import { AfterViewInit, Component, EventEmitter, OnDestroy, OnInit, Output } from '@angular/core';
import { Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { DynamicDialogRef } from 'primeng';
import { ConfirmationService, SelectItem } from 'primeng/api';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FCCFormGroup } from '../../../../../base/model/fcc-control.model';
import { FccGlobalConstantService } from '../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../common/core/fcc-global-constants';
import { BankDetails } from '../../../../../common/model/bankDetails';
import { CurrencyRequest } from '../../../../../common/model/currency-request';
import { References } from '../../../../../common/model/references';
import { CommonService } from '../../../../../common/services/common.service';
import { DropDownAPIService } from '../../../../../common/services/dropdownAPI.service';
import { EventEmitterService } from '../../../../../common/services/event-emitter-service';
import { FccTaskService } from '../../../../../common/services/fcc-task.service';
import { MultiBankService } from '../../../../../common/services/multi-bank.service';
import { ResolverService } from '../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../common/services/search-layout.service';
import { SessionValidateService } from '../../../../../common/services/session-validate-service';
import { LcConstant } from '../../../lc/common/model/constant';
import { ProductStateService } from '../../../lc/common/services/product-state.service';
import { CurrencyConverterPipe } from '../../../lc/initiation/pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../lc/initiation/services/filelist.service';
import { UtilityService } from '../../../lc/initiation/services/utility.service';
import {
  guaranteeAmtGreaterThanLCAmt,
  zeroAmount
} from '../../../lc/initiation/validator/ValidateAmt';
import { SgProductService } from '../../services/sg-product.service';
import { SgProductComponent } from '../../sg-product/sg-product.component';
import { CorporateCommonService } from './../../../../../corporate/common/services/common.service';


@Component({
  selector: 'app-sg-issuing-bank-and-amount',
  templateUrl: './sg-issuing-bank-and-amount.component.html',
  styleUrls: ['./sg-issuing-bank-and-amount.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: SgIssuingBankAndAmountComponent }]
})
export class SgIssuingBankAndAmountComponent extends SgProductComponent implements OnInit, AfterViewInit, OnDestroy {

  OMR = 'OMR';
  BHD = 'BHD';
  TND = 'TND';
  JPY = 'JPY';
  isoamt = '';
  enteredCurMethod = false;
  iso;
  threeDecimal = 3;
  length2 = FccGlobalConstant.LENGTH_2;
  val;
  validatorPattern = FccGlobalConstant.AMOUNT_VALIDATION;
  curRequest: CurrencyRequest = new CurrencyRequest();
  currency: SelectItem[] = [];
  bankDetails: BankDetails;
  corporateBanks = [];
  corporateReferences = [];
  references: References;
  entityName: any;
  lcConstant = new LcConstant();
  params = this.lcConstant.params;
  readonly = this.lcConstant.readonly;
  @Output() messageToEmit = new EventEmitter<string>();
  form: FCCFormGroup;
  module = `${this.translateService.instant(FccGlobalConstant.SG_ISSUING_BANK_AMOUNT)}`;
  allowedDecimals = -1;
  disabled = this.lcConstant.disabled;
  option;
  tnxTypeCode;
  mode: any;
  entities = [];
  selectedEntity;
  nameOrAbbvName: any;
  constructor(protected commonService: CommonService, protected stateService: ProductStateService,
    protected eventEmitterService: EventEmitterService, protected translateService: TranslateService,
    protected corporateCommonService: CorporateCommonService, protected fccGlobalConstantService: FccGlobalConstantService,
    protected sessionValidation: SessionValidateService, protected dialogRef: DynamicDialogRef,
    protected multiBankService: MultiBankService, protected dropDownAPIservice: DropDownAPIService,
    protected confirmationService: ConfirmationService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
    protected searchLayoutService: SearchLayoutService, protected utilityService: UtilityService,
    protected resolverService: ResolverService, protected fileList: FilelistService,
    protected taskService: FccTaskService, protected currencyConverterPipe: CurrencyConverterPipe,
    protected sgProductService: SgProductService) {
    super(eventEmitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
      searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, sgProductService);
  }

  ngOnInit(): void {
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.nameOrAbbvName = response.TradeIssuingBankNameOrAbbvName;
      }
    });
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.initializeFormGroup();
    this.getCorporateBanks();
    this.getCorporateReferences();
    this.getCurrencyDetail();
    if (this.tnxTypeCode === FccGlobalConstant.N002_NEW){
      this.form.removeControl('liabAmount');
    }
  }

  ngOnDestroy() {
    this.holdErrors();
    this.stateService.setStateSection(FccGlobalConstant.SG_ISSUING_BANK_AMOUNT, this.form);
  }

  ngAfterViewInit() {
    const guaranteeAmtVal = this.form.get('guaranteeAmt').value;
    if (guaranteeAmtVal != undefined && guaranteeAmtVal != null && guaranteeAmtVal != '') {
      this.onBlurGuaranteeAmt();
    }
  }

  initializeFormGroup() {
    const sectionName = FccGlobalConstant.SG_ISSUING_BANK_AMOUNT;
    this.form = this.stateService.getSectionData(sectionName);
    this.checAmountAgainstCurreny();
    this.setAmountLengthValidator(FccGlobalConstant.AMOUNT_FIELD_SG);
  }

  checAmountAgainstCurreny() {
    if (this.form.get('currency').value !== null && this.form.get('currency').value !== undefined
      && this.form.get('currency').value !== '') {
      if (this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).value <= 0) {
        this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setValue('');
        return;
      }
    }
  }

  getCorporateBanks() {
    let entityName;
    this.multiBankService.getEntityList().forEach(entity => {
      this.entities.push(entity);
    });
    if (this.stateService.getSectionData(FccGlobalConstant.SG_APPLICANT_BENEFICIARY)
      .get('applicantEntity') && this.mode !== FccGlobalConstant.VIEW_MODE) {
      this.selectedEntity = this.stateService.getSectionData(FccGlobalConstant.SG_APPLICANT_BENEFICIARY)
        .get('applicantEntity').value;
      if (typeof this.selectedEntity === 'object') {
        if (this.selectedEntity.name !== this.selectedEntity.shortName) {
          entityName = this.selectedEntity.name;
        }
        this.selectedEntity = this.selectedEntity.name;
      }

      /**
       * Adding this code because the entity Name is used in this.multiBankService.setCurrentEntity,
       * to fetch bankList from this.entityBankMap.
       * this.entityBankMap has key as Name rather than the abbv_name/shortName.
       * Ideally this needs to be corrected in the map to use abbv_name as key.
       *
       */
      if (entityName === undefined) {
        this.entities.forEach(entity => {
          if(entity.value.shortName === this.selectedEntity) {
            entityName = entity.value.name;
          }
        });
      }

      if (this.mode === FccGlobalConstant.DRAFT_OPTION && this.tnxTypeCode === '01') {
        this.multiBankService.setCurrentEntity(entityName);
      } else {
        this.multiBankService.setCurrentEntity(this.selectedEntity);
      }
    } else {
      const valobj = this.dropDownAPIservice.getDropDownFilterValueObj(this.entities, 'applicantEntity',
        this.stateService.getSectionData(FccGlobalConstant.SG_APPLICANT_BENEFICIARY));
      if (valobj && valobj[FccGlobalConstant.VALUE] && !this.taskService.getTaskEntity()) {
        this.multiBankService.setCurrentEntity(valobj[FccGlobalConstant.VALUE].name);
      }
    }
    this.setBankNameList();
    const val = this.dropDownAPIservice.getInputDropdownValue(this.corporateBanks, FccGlobalConstant.BANK_NAME_LIST, this.form);
    this.patchFieldParameters(this.form.get(FccGlobalConstant.BANK_NAME_LIST), { options: this.corporateBanks });
    this.form.get(FccGlobalConstant.BANK_NAME_LIST).setValue(val);
    if (this.corporateBanks.length === 1) {
      this.form.get(FccGlobalConstant.BANK_NAME_LIST)[FccGlobalConstant.PARAMS][this.disabled] = true;
    } else {
      this.form.get(FccGlobalConstant.BANK_NAME_LIST)[FccGlobalConstant.PARAMS][this.disabled] = false;
    }
    if (this.mode === FccGlobalConstant.DRAFT_OPTION && this.tnxTypeCode === '01') {
      this.multiBankService.setCurrentBank(val, entityName);
    } else {
      this.multiBankService.setCurrentBank(val);
    }
    if (this.taskService.getTaskBank()) {
      this.form.get('bankNameList').setValue(this.taskService.getTaskBank().value);
      this.multiBankService.setCurrentBank(this.taskService.getTaskBank().value);
    } else {
      this.taskService.setTaskBank(this.corporateBanks[0]);
    }
  }

  setBankNameList() {
    if (this.nameOrAbbvName === 'abbv_name') {
      this.corporateBanks = [];
      this.multiBankService.getBankList().forEach(bank => {
        bank.label = bank.value;
        this.corporateBanks.push(bank);
      });
    } else {
      this.corporateBanks = [];
      this.multiBankService.getBankList().forEach(bank => {
        this.corporateBanks.push(bank);
      });
    }
  }

  onClickBankNameList(event) {
    if (event && event.value && this.form.get('bankNameList') && !this.form.get('bankNameList')[this.params][this.disabled]) {
      this.multiBankService.setCurrentBank(event.value);
      const taskBank = this.corporateBanks.filter((item) => item.value === event.value);
      this.taskService.setTaskBank(taskBank[0]);
      this.setIssuerReferenceList();
    }
  }

  getCorporateReferences() {
    this.patchFieldParameters(this.form.get(FccGlobalConstant.ISSUER_REF_LIST), { options: [] });
    this.entityName =
      this.stateService.getSectionData(FccGlobalConstant.SG_APPLICANT_BENEFICIARY).get(FccGlobalConstant.APPLICANT_ENTITY).value.shortName;
    if (this.entityName === '') {
      this.form.get(FccGlobalConstant.ISSUER_REF_LIST)[this.params][this.readonly] = true;
    } else {
      this.form.get(FccGlobalConstant.ISSUER_REF_LIST)[this.params][this.readonly] = false;
    }
    this.setIssuerReferenceList();
  }

  setIssuerReferenceList() {
    this.corporateReferences = [];
    const referenceList = this.multiBankService.getReferenceList();
    referenceList.forEach(reference => {
      this.corporateReferences.push(reference);
    });
      const isDefaultFirst = this.corporateReferences.length === FccGlobalConstant.LENGTH_1;
      let val = this.dropDownAPIservice.getInputDropdownValue(this.corporateReferences, FccGlobalConstant.ISSUER_REF_LIST, this.form,
        isDefaultFirst);
      this.patchFieldParameters(this.form.get(FccGlobalConstant.ISSUER_REF_LIST), { options: this.corporateReferences });
      val = this.multiBankService.updateRefonEntityChange && !isDefaultFirst && !val ? '' : val;
      this.form.get(FccGlobalConstant.ISSUER_REF_LIST).setValue(val);
      if (this.corporateReferences.length === 1) {
        this.form.get(FccGlobalConstant.ISSUER_REF_LIST)[this.params][this.disabled] = true;
      } else {
        this.form.get(FccGlobalConstant.ISSUER_REF_LIST)[this.params][this.disabled] = false;
      }

  }


  getCurrencyDetail() {
    if (this.stateService.getValue(FccGlobalConstant.SG_GENERAL_DETAILS, FccGlobalConstant.CREATE_FROM_OPERATIONS, false)
      !== FccGlobalConstant.SGCOPY_FROM_LC) {
      if (this.form.get('currency')[FccGlobalConstant.OPTIONS].length === 0) {
        this.commonService.userCurrencies(this.curRequest).subscribe(
          response => {
            if (response.errorMessage && response.errorMessage === 'SESSION_INVALID') {
              this.sessionValidation.IsSessionValid();
            } else {
              response.items.forEach(
                value => {
                  const ccy: { label: string, value: any } = {
                    label: value.isoCode,
                    value: {
                      label: value.isoCode,
                      iso: `${value.isoCode} - ${this.toTitleCase(value.name)}`,
                      country: value.principalCountryCode,
                      currencyCode: value.isoCode,
                      shortName: value.isoCode,
                      name: value.name
                    }
                  };
                  this.currency.push(ccy);
                });
              this.patchFieldParameters(this.form.get('currency'), { options: this.currency });
              this.updateCurrncyValue();
            }
          });
      }
    } else {
      this.commonService.userCurrencies(this.curRequest).subscribe(
        response => {
          if (response.errorMessage && response.errorMessage === 'SESSION_INVALID') {
            this.sessionValidation.IsSessionValid();
          } else {
            response.items.forEach(
              value => {
                const ccy: { label: string, value: any } = {
                  label: value.isoCode,
                  value: {
                    label: value.isoCode,
                    iso: `${value.isoCode} - ${this.toTitleCase(value.name)}`,
                    country: value.principalCountryCode,
                    currencyCode: value.isoCode,
                    shortName: value.isoCode,
                    name: value.name
                  }
                };
                this.currency.push(ccy);
              });
            if (this.commonService.getLcResponse !== null && this.currency.length !== 0) {
              const checkCurr = this.form.get('currency').value;
              if (checkCurr === undefined || checkCurr === null || checkCurr === '') {
                const amt: string = this.commonService.getLcResponse().lc_cur_code;
                const curr = amt.split(' ')[0];
                const currency = this.currency.find(item => item.label === curr);
                this.form.get('currency').setValue({
                  label: currency.value.label,
                  iso: currency.value.iso,
                  country: currency.value.country,
                  currencyCode: currency.value.label,
                  shortName: currency.value.label,
                  name: currency.value.name
                });
                this.onBlurGuaranteeAmt();
              } else {
                this.patchFieldParameters(this.form.get('currency'), { options: this.currency });
                this.updateCurrncyValue();
              }
            }
          }
        });
    }
  }

  toTitleCase(value) {
    return value.replace(
      /\w\S*/g,
      (txt) => txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    );
  }

  onClickCurrency(event) {
    if (event.value) {
      let guaranteeAmt = this.commonService.replaceCurrency(this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).value);
      const currency = this.form.get('currency').value.currencyCode;
      this.commonService.getamountConfiguration(currency);
      this.commonService.amountConfig.subscribe((res) => {
        if (res) {
          if (currency && guaranteeAmt) {
            guaranteeAmt = this.currencyConverterPipe.transform(guaranteeAmt.toString(), currency, res);
          }
          if (guaranteeAmt) {
            this.updateAmountFieldValidation(currency, guaranteeAmt);
          }
          this.setAmountLengthValidator(FccGlobalConstant.AMOUNT_FIELD_SG);
        }
      });
    }
  }

  onClickGuaranteeAmt() {
    this.OnClickAmountFieldHandler(FccGlobalConstant.AMOUNT_FIELD_SG);
  }

  /*validation on change of amount field*/
  onBlurGuaranteeAmt() {
    this.setAmountLengthValidator(FccGlobalConstant.AMOUNT_FIELD_SG);
    let guaranteeAmt = this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).value;
    if (!guaranteeAmt) {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsDirty();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ required: true });
      return;
    }
    if (guaranteeAmt && guaranteeAmt <= FccGlobalConstant.ZERO) {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsDirty();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ amountCanNotBeZero: true });
      return;
    }
    const guaranteeAmtValue = this.commonService.replaceCurrency(guaranteeAmt);
    if ((guaranteeAmtValue && guaranteeAmtValue < 0) || !guaranteeAmtValue) {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ invalidAmt: true });
      return;
    }
    this.commonService.amountConfig.subscribe((res) => {
      if (res) {
        const currency = this.form.get('currency').value.currencyCode;
        if (currency && guaranteeAmt) {
          guaranteeAmt = this.commonService.replaceCurrency(guaranteeAmt);
          guaranteeAmt = this.currencyConverterPipe.transform(guaranteeAmt.toString(), currency, res);
        }
        if (guaranteeAmt) {
          this.updateAmountFieldValidation(currency, guaranteeAmt);
        } else {
          this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsDirty();
          this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ required: true });
        }
      }
    });
  }
  onFocusGuaranteeAmt() {
    this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).clearValidators();
  }
  updateAmountFieldValidation(currency, guaranteeAmt) {
    if(this.commonService.isnonEMptyString(this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).value)){
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setValue(guaranteeAmt);
    }
    const amt = this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG);
    amt.setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
    this.setMandatoryField(this.form, FccGlobalConstant.AMOUNT_FIELD_SG, true);
    this.allowedDecimals = 0;
    this.guaranteeAmountValidation(guaranteeAmt);
  }

  holdErrors() {
    const curr = this.form.get('currency') !== null ? this.form.get('currency').value : null;
    if (this.commonService.isNonEmptyValue(curr) && curr !== '') {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setValidators([Validators.required]);
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ required: true });
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsDirty();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsTouched();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).updateValueAndValidity();
    }
    this.removeMandatory([FccGlobalConstant.AMOUNT_FIELD_SG]);
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.form.get('currency').clearValidators();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).clearValidators();
    }
    this.setAmountValidator(FccGlobalConstant.AMOUNT_FIELD_SG);
  }

  removeMandatory(fields: any) {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryFields(this.form, fields, false);
    }
  }

  guaranteeAmountValidation(guaranteeAmt) {
    const lCAmt = this.commonService.replaceCurrency(
      this.stateService.getValue(
        FccGlobalConstant.SG_ISSUING_BANK_AMOUNT,
        "lcAmount",
        false
      )
    );

    const availableLCAmt = lCAmt ? parseFloat(lCAmt.toString()) : null;
    const guaranteeAmtFloatValue = this.commonService.replaceCurrency(guaranteeAmt);
    if (guaranteeAmtFloatValue === 0) {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).clearValidators();
      this.form.addFCCValidators(FccGlobalConstant.AMOUNT_FIELD_SG,
        Validators.compose([Validators.required, zeroAmount]), 0);
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ zeroAmount: true });
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsDirty();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsTouched();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).updateValueAndValidity();
    } else if (availableLCAmt && guaranteeAmtFloatValue > availableLCAmt) {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).clearValidators();
      this.form.addFCCValidators(FccGlobalConstant.AMOUNT_FIELD_SG,
        Validators.compose([Validators.required, guaranteeAmtGreaterThanLCAmt]), 0);
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ guaranteeAmtGreaterThanLCAmt: true });
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsDirty();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).markAsTouched();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).updateValueAndValidity();
    } else if (guaranteeAmtFloatValue > 0) {
      if (this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).hasError('invalidAmt')) {
        this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).setErrors({ invalidAmt: true });
      } else {
        this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).clearValidators();
        this.form.get(FccGlobalConstant.AMOUNT_FIELD_SG).updateValueAndValidity();
      }
    }
  }

  updateCurrncyValue() {
    if (this.form.get('currency').value) {
      const currency = this.stateService.getValue(FccGlobalConstant.SG_ISSUING_BANK_AMOUNT, 'currency', false);
      if (currency) {
        const currencyValue = this.currency.filter(task => task.value.label === currency)[0].value;
        if (currencyValue) {
          this.form.get('currency').setValue(currencyValue);
        } else {
          this.form.get('currency').setValue('');
        }
      }
    }
  }
}

