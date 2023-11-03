import { AfterViewInit, Component, ElementRef, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService } from 'primeng/api';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { BehaviorSubject } from 'rxjs';
import { PhrasesService } from '../../../../../../common/services/phrases.service';
import { FccGlobalConstant } from '../../../../../../common/core/fcc-global-constants';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { AmendCommonService } from '../../../../../common/services/amend-common.service';
import { LeftSectionService } from '../../../../../common/services/leftSection.service';
import {
  ConfirmationDialogComponent
} from '../../../../lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { LcConstant } from '../../../common/model/constant';
import { ProductStateService } from '../../../common/services/product-state.service';
import { CustomCommasInCurrenciesPipe } from '../../pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../services/filelist.service';
import { LcReturnService } from '../../services/lc-return.service';
import { PrevNextService } from '../../services/prev-next.service';
import { UtilityService } from '../../services/utility.service';
import {
  emptyCurrency
} from '../../validator/ValidateAmt';
import { compareNewAmountToOld } from '../../validator/ValidateLastShipDate';
import { CurrencyRequest } from './../../../../../../../app/common/model/currency-request';
import { UserData } from './../../../../../../../app/common/model/user-data';
import { ExchangeRateRequest } from './../../../../../../../app/common/model/xch-rate-request';
import { CommonService } from './../../../../../../../app/common/services/common.service';
import { DropDownAPIService } from './../../../../../../../app/common/services/dropdownAPI.service';
import { SessionValidateService } from './../../../../../../../app/common/services/session-validate-service';
import { FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from './../../../../../../common/core/fcc-business-constants.service';
import { EventEmitterService } from './../../../../../../common/services/event-emitter-service';
import { FormModelService } from './../../../../../../common/services/form-model.service';
import { LcTemplateService } from './../../../../../../common/services/lc-template.service';
import { CurrencyConverterPipe } from './../../pipes/currency-converter.pipe';
import { FormControlService } from './../../services/form-control.service';
import { LcProductComponent } from './../lc-product/lc-product.component';
import { LcProductService } from '../../../services/lc-product.service';
import { FccTradeFieldConstants } from '../../../../common/fcc-trade-field-constants';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { SelectItem } from 'primeng/api/selectitem';

@Component({
  selector: 'fcc-amount-charge-details',
  templateUrl: './amount-charge-details.component.html',
  styleUrls: ['./amount-charge-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: AmountChargeDetailsComponent }]
})
export class AmountChargeDetailsComponent extends LcProductComponent implements OnInit, AfterViewInit, OnDestroy {
  form: FCCFormGroup;
  @ViewChild('fccCommonTextAreaId') public fccCommonTextAreaId: ElementRef;
  rendered: true;
  formSubmitted = false;
  module = `${this.translateService.instant('amountChargeDetails')}`;
  subheader = '';
  confirm = true;
  prev = 'prev';
  next = 'next';
  currencies = [];
  selectedValue = '';
  flagDecimalPlaces;
  currency: SelectItem[] = [];
  xchRequest: ExchangeRateRequest = new ExchangeRateRequest();
  curRequest: CurrencyRequest = new CurrencyRequest();
  OMR = 'OMR';
  BHD = 'BHD';
  TND = 'TND';
  JPY = 'JPY';
  isoamt = '';
  enteredCurMethod = false;
  iso;
  addamtregex;
  params = 'params';
  render = 'rendered';
  required = 'required';
  enteredCharCount = 'enteredCharCount';
  twoDecimal = 2;
  threeDecimal = 3;
  subheadTitle = 'subheader-title';
  revolvingValue: string[] = [];
  lcConstant = new LcConstant();
  revolveFrequencyOptions = [
    {
      label: `${this.translateService.instant('days')}`, value:
        { label: 'Days', shortName: `${this.translateService.instant('days')}` },
    },
    {
      label: `${this.translateService.instant('months')}`,
      value: { label: 'Months', shortName: `${this.translateService.instant('months')}` }
    }
  ];
  lcFeatureArray: string[] = [];
  revolvingFlag = FccBusinessConstantsService.NO;

  length2 = FccGlobalConstant.LENGTH_2;
  length3 = FccGlobalConstant.LENGTH_3;
  length4 = FccGlobalConstant.LENGTH_4;
  val;
  radioButtonValue;
  allLcRecords;
  splitChargeEnabled: any;
  tnxTypeCode: any;
  validateAmt = false;
  validatorPattern = FccGlobalConstant.AMOUNT_VALIDATION;
  option;
  licenseData: any = [];
  sessionCols: any = [];
  licenseValue: any = [];
  confChargesEnabled;
  isMasterRequired: any;
  mode: any;
  operation: any;
  modeParam: string;
  amendmentCharges = 'amendmentCharges';
  outStdCurrency = 'outStdCurrency';

  constructor(protected commonService: CommonService, protected sessionValidation: SessionValidateService,
    protected translateService: TranslateService, protected router: Router,
    protected leftSectionService: LeftSectionService, protected elementRef: ElementRef,
    protected lcReturnService: LcReturnService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
    protected currencyConverterPipe: CurrencyConverterPipe, protected phrasesService: PhrasesService,
    protected utilityService: UtilityService, protected prevNextService: PrevNextService,
    protected stateService: ProductStateService, protected lcTemplateService: LcTemplateService,
    protected formModelService: FormModelService, protected formControlService: FormControlService,
    protected emitterService: EventEmitterService, protected dropdownAPIService: DropDownAPIService,
    protected dialogService: DialogService, protected searchLayoutService: SearchLayoutService,
    protected amendCommonService: AmendCommonService, protected confirmationService: ConfirmationService,
    protected resolverService: ResolverService, protected fileList: FilelistService, protected dialogRef: DynamicDialogRef,
    protected lcProductService: LcProductService) {
    super(emitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
      searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, lcProductService);
  }

  getCurrencyDetail() {
    if (this.form.get('currency')[FccGlobalConstant.OPTIONS] && this.form.get('currency')[FccGlobalConstant.OPTIONS].length === 0) {
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
          }
          if (this.form.get('currency').value !== FccGlobalConstant.EMPTY_STRING) {
            const valObj = this.dropdownAPIService.getDropDownFilterValueObj(this.currency, 'currency', this.form);
            if (valObj) {
              this.form.get('currency').patchValue(valObj[`value`]);
            }
          }
        });
    }
  }


  handlecontrolComponentsData(controlData: any) {
    if (controlData.has('addAmtTextArea')) {
      const event = new KeyboardEvent('keyup');
      controlData.get('addAmtTextArea').get('fccCommonTextAreaId').nativeElement.dispatchEvent(event);
    }
  }

  toTitleCase(value) {
    return value.replace(
      /\w\S*/g,
      (txt) => txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    );
  }

  initiationofdata() {
    this.flagDecimalPlaces = -1;
    this.iso = '';
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.iso = this.commonService.masterDataMap.get('currency');
    }
  }

  ngOnInit() {
    super.ngOnInit();
    window.scroll(0, 0);
    this.isMasterRequired = this.isMasterRequired;
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.revolvingFlag = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('revolving_flag').value;
    this.radioButtonValue = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('confirmationOptions').value;
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.mode = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('transmissionMode').value;
    this.modeParam = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.operation = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION);
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.confChargesEnabled = response.confChargesEnabled;
      }
    });
    this.initializeFormGroup();
    this.beneficiaryLicense();
    this.initiationofdata();
    this.xchRequest.userData = new UserData();
    this.xchRequest.userData.userSelectedLanguage = 'en';
    this.curRequest.userData = this.xchRequest.userData;
    if (this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
      this.getCurrencyDetail();
    }
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.addamtregex = response.swiftXCharacterSet;
        this.splitChargeEnabled = response.isSplitChargeEnabled;
        this.form.get('addAmtTextArea').clearValidators();
        if (this.mode === FccBusinessConstantsService.SWIFT) {
          this.form.addFCCValidators('addAmtTextArea', Validators.pattern(this.addamtregex), 0);
        }
        this.form.addFCCValidators('percp', Validators.pattern(FccGlobalConstant.numberPattern), 0);
        this.form.addFCCValidators('percm', Validators.pattern(FccGlobalConstant.numberPattern), 0);
        this.form.addFCCValidators('revolvePeriod', Validators.pattern(FccGlobalConstant.numberPattern), 0);
        this.form.addFCCValidators('numberOfTimesToRevolve', Validators.pattern(FccGlobalConstant.numberPattern), 0);
        this.form.addFCCValidators('noticeDays', Validators.pattern(FccGlobalConstant.numberPattern), 0);
        if (this.splitChargeEnabled) {
          this.form.addFCCValidators('chargesToApplicant', Validators.pattern(FccGlobalConstant.percentagePattern), 0);
          this.form.addFCCValidators('chargesToBeneficiary', Validators.pattern(FccGlobalConstant.percentagePattern), 0);
          this.form.addFCCValidators('chargesToApplicantOutside', Validators.pattern(FccGlobalConstant.percentagePattern), 0);
          this.form.addFCCValidators('chargesToBeneficiaryOutside', Validators.pattern(FccGlobalConstant.percentagePattern), 0);
          this.form.updateValueAndValidity();
          this.setSharedInDropdown('issuingBankCharges');
          this.setSharedInDropdown(this.outStdCurrency);
          this.setSharedInDropdown('confCharges');
          // if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
          //   this.setSharedInDropdown('amendmentCharges');
          // } for amend the split charges are removed for the time being as there is not db field present for the mapping
          this.settingSharedInDropDown();
        }
      }
    });
    this.renderDependentFeilds();
    const dependentFields = ['revolvePeriod', 'revolveFrequency', 'numberOfTimesToRevolve', 'noticeDays'];
    if (this.revolvingFlag === FccBusinessConstantsService.NO) {
      this.setMandatoryFields(this.form, dependentFields, false);
      this.removeValidators(this.form, dependentFields);
      this.resetValues(this.form, dependentFields);
      this.form.updateValueAndValidity();
    } else if (this.revolvingFlag === FccBusinessConstantsService.YES) {
      this.setMandatoryFields(this.form, dependentFields, true);
      this.addRequiredValidator(this.form, dependentFields);
      this.form.addFCCValidators(FccGlobalConstant.REVOLVE_PERIOD, Validators.pattern(FccGlobalConstant.numberPattern), 0);
      this.form.addFCCValidators(FccGlobalConstant.NUMBER_OF_TIMES_REVOLVE, Validators.pattern(FccGlobalConstant.numberPattern), 0);
      this.form.addFCCValidators(FccGlobalConstant.NOTICE_DAYS, Validators.pattern(FccGlobalConstant.numberPattern), 0);
      this.form.updateValueAndValidity();
    }
    this.removeMandatory(dependentFields);

    if (this.context === 'readonly') {
      this.readOnlyMode();
    }
    this.patchLayoutForReadOnlyMode();
    this.onClickIssuingBankCharges();
    this.onClickOutStdCurrency();
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.onClickAmendmentCharges();
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.removeControl('lcAvailableAmt');
      this.form.removeControl('outstandingAmount');
    }



    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND && this.form.get('decreaseAmount').value !== null) {
      let orgAmt: number;
      if (this.modeParam === FccGlobalConstant.DRAFT_OPTION || this.modeParam === FccGlobalConstant.EXISTING &&
        this.commonService.checkPendingClientBankViewForAmendTnx()) {
        orgAmt = parseFloat(this.commonService.replaceCurrency(this.stateService.getValue('amountChargeDetails', 'amount', true)));
      } else {
        orgAmt = parseFloat(this.commonService.replaceCurrency(this.stateService.getValue('amountChargeDetails', 'amount', false)));
      }
      const changeAmt = parseFloat(this.commonService.replaceCurrency(this.form.get('decreaseAmount').value));
      if (!(orgAmt > changeAmt)) {
        this.form.get('decreaseAmount').setValue(null);
      }
    }
    if (this.commonService.getClearBackToBackLCfields() === 'yes') {
      const fields = ['currency', 'amount', 'percp', 'percm', 'addAmtTextArea'];
      fields.forEach(ele => {
        this.form.get(ele).setValue('');
        this.form.get(ele).updateValueAndValidity();
      });
    }
    this.removeMandatory(['currency', 'amount']);
    this.updateNarrativeCount();
  }

  updateNarrativeCount() {
    if (this.form.get('addAmtTextArea').value) {
      const count = this.commonService.counterOfPopulatedData(this.form.get('addAmtTextArea').value);
      this.form.get('addAmtTextArea')[this.params][this.enteredCharCount] = count;
    }
  }

  beneficiaryLicense() {
    if (this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].data !== null &&
      this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].data !== '' &&
      this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].data !== undefined) {
      this.licenseData = this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].data;
    }
    if (this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].sessionCols !== null &&
      this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].sessionCols !== '' &&
      this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].sessionCols !== undefined) {
      this.sessionCols = this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].sessionCols;
    }
    if (this.stateService.getSectionData('licenseDetails').get('linkedLicenses').value !== null &&
      this.stateService.getSectionData('licenseDetails').get('linkedLicenses').value !== '' &&
      this.stateService.getSectionData('licenseDetails').get('linkedLicenses').value !== undefined) {
      this.licenseValue = this.stateService.getSectionData('licenseDetails').get('linkedLicenses').value;
    }
  }

  settingSharedInDropDown() {
    this.setSharedInDropdown('issuingBankCharges');
    this.setSharedInDropdown(this.outStdCurrency);
    if (this.confChargesEnabled === true) {
      if (this.radioButtonValue === 'confirm' || this.radioButtonValue === 'mayAdd') {
        this.setSharedInDropdown('confCharges');
      }
    }
    // if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
    //   this.setSharedInDropdown('amendmentCharges');
    // } for amend the split charges are removed for the time being as there is not db field present for the mapping
  }

  setSharedInDropdown(formField) {
    let found = false;
    const arr = this.form.get(formField)[`options`];
    for (const ele in arr) {
      if (arr[ele].value === '08') {
        found = true;
        break;
      }
    }
    if (!found) {
      this.form.get(formField)[`options`].push({
        label: `${this.translateService.instant(`${formField}_08`)}`,
        value: '08', valueStyleClass: 'p-col-6 leftwrapper'
      });
    }
  }

  onClickIssuingBankCharges() {
    if (this.form.get('issuingBankCharges') && this.form.get('issuingBankCharges').value === '08') {
      this.form.get('issuingBankChargesSplitDetails')[this.params][this.render] = true;
      this.form.get('chargesToApplicant')[this.lcConstant.params][this.render] = true;
      this.form.get('chargesToBeneficiary')[this.lcConstant.params][this.render] = true;
    } else {
      if (this.form.get('issuingBankChargesSplitDetails')) {
        this.form.get('issuingBankChargesSplitDetails')[this.params][this.render] = false;
        this.form.get('chargesToApplicant')[this.lcConstant.params][this.render] = false;
        this.form.get('chargesToBeneficiary')[this.lcConstant.params][this.render] = false;
      }
    }
  }
  onClickOutStdCurrency() {
    if (this.form.get(this.outStdCurrency).value && this.form.get(this.outStdCurrency).value === '08') {
      this.form.get('outStationChargesSplitDetails')[this.params][this.render] = true;
      this.form.get('chargesToApplicantOutside')[this.lcConstant.params][this.render] = true;
      this.form.get('chargesToBeneficiaryOutside')[this.lcConstant.params][this.render] = true;
    } else {
      if (this.form.get('outStationChargesSplitDetails')) {
        this.form.get('outStationChargesSplitDetails')[this.params][this.render] = false;
        this.form.get('chargesToApplicantOutside')[this.lcConstant.params][this.render] = false;
        this.form.get('chargesToBeneficiaryOutside')[this.lcConstant.params][this.render] = false;
      }
    }
  }
  onClickConfCharges() {
    this.setValidationsForCharges('chargesToApplicantConf', 'confCharges');
    this.setValidationsForCharges('chargesToBeneficiaryConf', 'confCharges');
    if (this.form.get('confCharges') && this.form.get('confCharges').value === '08') {
      this.form.get('confirmChargesSplitDetails')[this.params][this.render] = true;
    } else {
      if (this.form.get('confirmChargesSplitDetails')) {
        this.form.get('confirmChargesSplitDetails')[this.params][this.render] = false;
      }
    }
  }
  onClickAmendmentCharges() {
    this.setValidationsForCharges('chargesToApplicantAmendment', this.amendmentCharges);
    this.setValidationsForCharges('chargesToBeneficiaryAmendment', this.amendmentCharges);
    // if (this.form.get('amendmentCharges') && this.form.get('amendmentCharges').value === '08') {
    //   this.form.get('amendChargesSplitDetails')[this.params][this.render] = true;
    // } else {
    //   if (this.form.get('amendChargesSplitDetails')) {
    //   this.form.get('amendChargesSplitDetails')[this.params][this.render] = false;
    //   }
    // }
  }

  setValidationsForCharges(formField, chargesType) {
    if (this.form.get(chargesType).value === '08') {
      this.form.get(`${formField}`)[this.lcConstant.params][this.render] = true;
      this.form.get(`${formField}`).setValidators([Validators.pattern(this.validatorPattern)]);
      this.form.get(`${formField}`).updateValueAndValidity();
    } else {
      if (this.form.get(`${formField}`)) {
        this.form.get(`${formField}`).clearValidators();
        this.form.get(`${formField}`).updateValueAndValidity();
        this.form.get(`${formField}`)[this.lcConstant.params][this.render] = false;
      }
    }
  }
  protected renderDependentFeilds() {
    this.radioButtonValue = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('confirmationOptions').value;
    this.toggleradioButtonValue();

    if (this.form.get('confChargeslabel') && this.form.get('confChargeslabel')[this.lcConstant.params][this.render] &&
      (this.radioButtonValue === FccBusinessConstantsService.WITHOUT_03)) {
      this.form.get('confCharges')[this.lcConstant.params][this.render] = false;
      this.form.get('confChargeslabel')[this.lcConstant.params][this.render] = false;
      this.form.get('chargesToApplicantConf')[this.lcConstant.params][this.render] = false;
      this.form.get('chargesToBeneficiaryConf')[this.lcConstant.params][this.render] = false;
    }
    if (this.confChargesEnabled === true) {
      if (!(this.form.get('confChargeslabel')[this.lcConstant.params][this.render]) &&
        (this.radioButtonValue === FccBusinessConstantsService.CONFIRM_01 ||
          this.radioButtonValue === FccBusinessConstantsService.MAYADD_02)) {
        this.form.get('confCharges')[this.lcConstant.params][this.render] = true;
        this.form.get('confChargeslabel')[this.lcConstant.params][this.render] = true;
        if (this.splitChargeEnabled) {
          this.setSharedInDropdown('confCharges');
        }
      }
    }

    this.revolvingValueIndexMinusOne();
    this.revolvingValueIndexGrtrMinusOne();
    if (this.revolvingFlag === FccBusinessConstantsService.NO) {
      this.resettingValidatorsInitialize();
      this.setMandatoryFields(this.form, ['revolvePeriod', 'revolveFrequency', 'numberOfTimesToRevolve'], false);
      this.form.get('revolvePeriod').clearValidators();
      this.form.get('revolveFrequency').clearValidators();
      this.form.get('numberOfTimesToRevolve').clearValidators();
    }
  }
  revolvingValueIndexMinusOne() {
    if (this.form.get('revolvingDetailsLabel')[this.lcConstant.params][this.render] &&
      (this.revolvingFlag === FccBusinessConstantsService.NO)) {
      this.toggleRevolvingField(false);
      this.resettingValidatorsInitialize();
    }
  }
  revolvingValueIndexGrtrMinusOne() {
    if (this.revolvingFlag === FccBusinessConstantsService.YES) {
      this.toggleRevolvingField(true);
      this.setMandatoryFields(this.form, ['revolvePeriod', 'revolveFrequency', 'numberOfTimesToRevolve'], true);
      this.form.get('revolvePeriod').setValidators([Validators.pattern('^[0-9]+$'),
      Validators.maxLength(this.length4),
      Validators.min(1)]);
      this.form.get('numberOfTimesToRevolve').setValidators([
        Validators.pattern('^[0-9]+$'),
        Validators.maxLength(this.length3),
        Validators.min(1)]);
      this.removeMandatory(['revolvePeriod', 'revolveFrequency', 'numberOfTimesToRevolve']);
    }
  }
  resettingValidatorsInitialize() {
    this.resettingValidators('revolvePeriod');
    this.resettingValidators('revolveFrequency');
    this.resettingValidators('numberOfTimesToRevolve');
    this.resettingValidators('noticeDays');
  }
  ngAfterViewInit() {
    const amountValue = this.form.get('amount').value;
    if (amountValue != undefined && amountValue != null && amountValue != '') {
      this.onBlurAmount();
    }
  }

  patchLayoutForReadOnlyMode() {
    if (this.form.getFormMode() === 'view') {

      const controls = Object.keys(this.form.controls);
      let index: any;
      for (index = 0; index < controls.length; index++) {
        this.viewModeChange(this.form, controls[index]);
      }
    }
  }

  readOnlyMode() {
    this.lcReturnService.allLcRecords.subscribe(res => {
      this.allLcRecords = res;

      this.form.get('currency').setValue(this.currency.filter(task => task.label === this.allLcRecords.amount.currency)[0].value);
      this.patchFieldParameters(this.form.get('currency'), { readonly: true });
      this.patchFieldValueAndParameters(this.form.get('amount'), this.allLcRecords.amount.amount,
        { readonly: true });
      this.patchFieldValueAndParameters(this.form.get('percp'), this.allLcRecords.amountTolerance.minPercentAmountTolerance,
        { readonly: true });
      this.patchFieldValueAndParameters(this.form.get('percm'), this.allLcRecords.amountTolerance.maxPercentAmountTolerance,
        { readonly: true });

      if (this.allLcRecords.chargeDetail.issuanceChargesPayableBy === 'APPLICANT') {
        this.patchFieldParameters(this.form.get('iss'), { readonly: true, value: 'IssA' });
      } else {
        this.patchFieldParameters(this.form.get('iss'), { readonly: true, value: 'issB' });
      }
      if (this.allLcRecords.chargeDetail.overseasChargesPayableBy === 'APPLICANT') {
        this.patchFieldParameters(this.form.get('corrc'), { readonly: true, value: 'CorrA' });
      } else {
        this.patchFieldParameters(this.form.get('corrc'), {
          readonly: true, value: 'CorrB'
        });
      }
      if (this.allLcRecords.chargeDetail.issuanceChargesPayableBy === 'APPLICANT') {
        this.patchFieldParameters(this.form.get('confCharges'), {
          readonly: true, value: 'confa'
        });
      } else {
        this.patchFieldParameters(this.form.get('confCharges'), {
          readonly: true, value: 'confb'
        });
      }
      this.patchFieldValueAndParameters(this.form.get('addamt'), this.allLcRecords.narrative.additionalAmount,
        { readonly: true });

      if (this.allLcRecords.revolving.frequency === 'Days') {
        this.form.get('revolveFrequency').setValue({ label: 'Days', shortName: `${this.translateService.instant('days')}` });
      } else {
        this.form.get('revolveFrequency').setValue({ label: 'Months', shortName: `${this.translateService.instant('months')}` });
      }
      this.patchFieldParameters(this.form.get('revolveFrequency'), { readonly: true });

      const cvalue = [];
      if (this.allLcRecords.revolving.cumulative === true) {
        cvalue.push('cumulative');
      }
      this.patchFieldValueAndParameters(this.form.get('cumulativeCheckbox'), cvalue, { readonly: true });

      this.patchFieldValueAndParameters(this.form.get('revolvePeriod'), this.allLcRecords.revolving.period,
        { readonly: true });
      this.patchFieldValueAndParameters(this.form.get('numberOfTimesToRevolve'), this.allLcRecords.revolving.revolutions,
        { readonly: true });
      this.patchFieldValueAndParameters(this.form.get('noticeDays'), this.allLcRecords.revolving.revolutions,
        { readonly: true });

    });

    this.patchFieldParameters(this.form.get('previous'), { rendered: false });
    this.patchFieldParameters(this.form.get('next'), { rendered: false });
    this.form.setFormMode('view');
  }


  initializeFormGroup() {
    const sectionName = 'amountChargeDetails';
    this.form = this.stateService.getSectionData(sectionName, undefined, this.isMasterRequired);
    if (this.modeParam === FccGlobalConstant.DRAFT_OPTION && this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      const fieldValue = this.commonService.handleComputedProductAmtFieldForAmendDraft(this.form, FccTradeFieldConstants.NEW_LC_AMT);
      if (fieldValue && fieldValue !== '') {
        this.patchFieldValueAndParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), fieldValue, {});
      }
    }
    if (this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
      this.patchFieldParameters(this.form.get('currency'), { options: this.currency });
    }
    this.renderDependentFeilds();
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
      this.checkTnxAmt();
      this.iso = this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.CURRENCY).value) ?
      this.form.get(FccGlobalConstant.CURRENCY).value : null;
      this.commonService.getamountConfiguration(this.iso);
    }
    this.commonService.formatForm(this.form);
    this.removeAmendFlagFromField();
    this.checAmountAgainstCurreny();
    this.addAmountLengthValidator();
  }

  addAmountLengthValidator() {
    const controlNames: string[] = ['amount', 'increaseAmount', 'decreaseAmount', 'newLCAmt'];
    this.setAmountLengthValidatorList(controlNames);
  }

  checAmountAgainstCurreny() {
    if (this.form.get('currency').value !== null && this.form.get('currency').value !== undefined
      && this.form.get('currency').value !== '') {
      if (this.form.get('amount').value <= 0) {
        this.form.get('amount').setValue('');
        return;
      }
    }
    if (this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).value) {
      if (this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).value <= 0) {
        this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue('');
        this.form.controls[FccTradeFieldConstants.DECREASE_AMOUNT].enable();
        return;
      }
    }
    if (this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).value) {
      if (this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).value <= 0) {
        this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValue('');
        this.form.controls[FccTradeFieldConstants.INCREASE_AMOUNT].enable();
        return;
      }
    }
    if (this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value) {
      if (this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value <= 0) {
        this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue('');
        return;
      }
    }
  }

  checkTnxAmt() {
    if (this.form.get('tnxAmt') && this.form.get(FccTradeFieldConstants.NEW_LC_AMT) && this.form.get('tnxAmt').value &&
      this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value) {
      const tnxAmtValue = this.form.get('tnxAmt').value;
      const amtVal = this.commonService.replaceCurrency(this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value);
      let orgAmt;
      let currencyValue;
      if (this.modeParam === FccGlobalConstant.DRAFT_OPTION || this.modeParam === FccGlobalConstant.EXISTING &&
        this.commonService.checkPendingClientBankViewForAmendTnx()) {
        orgAmt = this.commonService.replaceCurrency(this.stateService.getValue('amountChargeDetails', 'orgLCAmt', false));
        currencyValue = this.stateService.getValue('amountChargeDetails', 'currency', true);
      } else {
        orgAmt = this.commonService.replaceCurrency(this.stateService.getValue('amountChargeDetails', 'orgLCAmt', false));
        currencyValue = this.stateService.getValue('amountChargeDetails', 'currency', false);
      }

      const amtValue = parseFloat(amtVal);
      const orgFloatAmt = parseFloat(orgAmt);
      let decreaseDisplayAmt;
      let increaseDisplayAmt;
      if (orgFloatAmt > amtValue) {
        this.form.get(FccTradeFieldConstants.NEW_LC_AMT)[this.params][this.render] = true;
        this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue(this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value);
        this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT)[this.params][this.render] = true;
        this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValue(tnxAmtValue);
        this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue('');
        if (this.mode === 'view') {
          this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT)[this.params][this.render] = false;
        }
        decreaseDisplayAmt = currencyValue.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(tnxAmtValue);
        this.patchFieldParameters(this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT), { displayedValue: decreaseDisplayAmt });
        this.patchFieldParameters(this.form.get('amountChargeAmount'), { infoIcon: true, infolabel: FccGlobalConstant.AMENDED });
      } else if (orgFloatAmt < amtValue) {
        this.form.get(FccTradeFieldConstants.NEW_LC_AMT)[this.params][this.render] = true;
        this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue(this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value);
        this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT)[this.params][this.render] = true;
        this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue(tnxAmtValue);
        this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValue('');
        if (this.mode === 'view') {
          this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT)[this.params][this.render] = false;
        }
        increaseDisplayAmt = currencyValue.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(tnxAmtValue);
        this.patchFieldParameters(this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT), { displayedValue: increaseDisplayAmt });
        this.patchFieldParameters(this.form.get('amountChargeAmount'), { infoIcon: true, infolabel: FccGlobalConstant.AMENDED });
      }
    }
    this.form.updateValueAndValidity();
  }

  toggleradioButtonValue() {
    if (this.confChargesEnabled === true) {
      if (this.radioButtonValue === FccBusinessConstantsService.CONFIRM_01 ||
        this.radioButtonValue === FccBusinessConstantsService.MAYADD_02) {
        this.form.get('confCharges')[this.lcConstant.params][this.render] = true;
        this.form.get('confChargeslabel')[this.lcConstant.params][this.render] = true;
        if (this.splitChargeEnabled) {
          this.setSharedInDropdown('confCharges');
        }
      }
    }
  }

  toggleRevolvingField(value) {
    this.form.get('revolvingDetailsLabel')[this.lcConstant.params][this.render] = value;
    this.form.get('revolvePeriod')[this.lcConstant.params][this.render] = value;
    this.form.get('revolvePeriod')[this.lcConstant.params][FccGlobalConstant.REQUIRED] = value;
    this.form.get('revolveFrequency')[this.lcConstant.params][this.render] = value;
    this.form.get('revolveFrequency')[this.lcConstant.params][FccGlobalConstant.REQUIRED] = value;
    this.form.get('numberOfTimesToRevolve')[this.lcConstant.params][this.render] = value;
    this.form.get('numberOfTimesToRevolve')[this.lcConstant.params][FccGlobalConstant.REQUIRED] = value;
    this.form.get('cumulativeCheckbox')[this.lcConstant.params][this.render] = value;
    this.form.get('noticeDays')[this.lcConstant.params][this.render] = value;
    this.form.get('noticeDays')[this.lcConstant.params][FccGlobalConstant.REQUIRED] = value;
    this.removeMandatory(['revolvePeriod', 'revolveFrequency', 'numberOfTimesToRevolve', 'noticeDays']);
  }

  resettingValidators(fieldvalue) {
    this.form.get(fieldvalue).clearValidators();
    this.form.get(fieldvalue).updateValueAndValidity();
  }
  holdErrors() {
    const curr = this.form.get('currency') !== null ? this.form.get('currency').value : null;
    if (this.commonService.isNonEmptyValue(curr) && curr !== '' && curr !== ' ') {
      this.form.get('amount').setValidators([Validators.required]);
      this.form.get('amount').setErrors({ required: true });
      this.form.get('amount').markAsDirty();
      this.form.get('amount').markAsTouched();
      this.form.get('amount').updateValueAndValidity();
    }
    this.removeMandatory(['amount']);
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.form.get('currency').clearValidators();
      this.form.get('amount').clearValidators();
    }
    this.addAmountLengthValidator();
  }
  ngOnDestroy() {
    this.holdErrors();
    this.handleSubTnxTypecode(this.form, this.tnxTypeCode, FccGlobalConstant.GENERAL_DETAILS);
    this.stateService.setStateSection(FccGlobalConstant.AMOUNT_CHARGE_DETAILS, this.form, this.isMasterRequired);
    if ((this.modeParam === FccGlobalConstant.EXISTING || this.modeParam === FccGlobalConstant.DRAFT_OPTION) && this.tnxTypeCode === '03') {
      if (this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).value === null ||
        this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).value === '') {
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.DECREASE_AMOUNT], false);
      } else {
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.DECREASE_AMOUNT], true);
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.NEW_LC_AMT], true);
        this.patchFieldParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), { amendPersistenceSave: true });
      }
      if (this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).value === null ||
        this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).value === '') {
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.INCREASE_AMOUNT], false);
      } else {
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.INCREASE_AMOUNT], true);
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.NEW_LC_AMT], true);
        this.patchFieldParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), { amendPersistenceSave: true });
      }
    }
  }

  onFocusYesButton() {
    this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].data = null;
    this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS].sessionCols = null;
    this.stateService.getSectionData('licenseDetails').get('license')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    this.stateService.getSectionData('licenseDetails').get('linkedLicenses').setValue(null);
    this.searchLayoutService.searchLayoutDataSubject.unsubscribe();
    this.searchLayoutService.searchLayoutDataSubject = new BehaviorSubject(null);
  }

  handleLinkedLicense() {
    if (this.licenseData.length > 0 || this.sessionCols.length > 0 || this.licenseValue > 0) {
      const headerField = `${this.translateService.instant('deleteLinkedLicense')}`;
      const obj = {};
      const dir = localStorage.getItem('langDir');
      const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
        data: obj,
        header: headerField,
        width: '35em',
        styleClass: 'fileUploadClass',
        style: { direction: dir }
      });
      dialogRef.onClose.subscribe((result: any) => {
        if (result.toLowerCase() === 'yes') {
          this.onFocusYesButton();
        }
      });
    }
  }

  onKeyupCurrency(event) {
    const keycodeIs = event.which || event.keyCode;
    if (keycodeIs === this.lcConstant.thirtyEight || keycodeIs === this.lcConstant.forty || keycodeIs === this.lcConstant.thirteen) {
      this.onclickCurrencyAccessibility(this.form.get(FccGlobalConstant.CURRENCY).value);
    }
  }

  onclickCurrencyAccessibility(value) {
    if (value) {
      this.postClickRKeyUpOnCurrency(value);
    }
  }

  /*validation on change of currency field*/
  onClickCurrency(event) {
    if (event.value !== undefined) {
      this.postClickRKeyUpOnCurrency(event.value);
    }
  }

  postClickRKeyUpOnCurrency(value) {
    if (value) {
      this.handleLinkedLicense();
      this.enteredCurMethod = true;
      this.iso = value.currencyCode;
      this.commonService.getamountConfiguration(this.iso);
      this.isoamt = this.iso;
      const amt = this.form.get('amount');
      this.val = amt.value;
      amt.setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
      this.setMandatoryField(this.form, 'amount', true);
      this.flagDecimalPlaces = 0;
      if (this.val !== '' && this.val !== null) {
        if (this.val <= 0) {
          this.form.get('amount').setErrors({ amountCanNotBeZero: true });
          return;
        } else {
          this.commonService.amountConfig.subscribe((res) => {
            if (res) {
              let valueupdated = this.commonService.replaceCurrency(this.val);
              valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), this.iso, res);
              this.form.get('amount').setValue(valueupdated);
            }
          });
        }
      } else {
        this.form.get('amount').setErrors({ required: true });
      }
      this.setAmountLengthValidator('amount');
      this.form.get('amount').updateValueAndValidity();
      this.removeMandatory(['amount']);
    }
  }

  onClickAmount() {
    this.OnClickAmountFieldHandler('amount');
  }

  /*validation on change of amount field*/
  onBlurAmount() {
    this.removeValidators(this.form, [FccGlobalConstant.AMOUNT_FIELD]);
    this.setAmountLengthValidator('amount');
    const amt = this.form.get('amount');
    this.iso = this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.CURRENCY).value) &&
      this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.CURRENCY).value.currencyCode) ?
      this.form.get(FccGlobalConstant.CURRENCY).value.currencyCode : null;
    if (this.commonService.getAmountForBackToBack() && parseInt(this.commonService.replaceCurrency(amt.value), 10) >
      parseInt(this.commonService.replaceCurrency(this.commonService.getAmountForBackToBack()), 10)) {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD).setValidators([compareNewAmountToOld]);
      this.form.get(FccGlobalConstant.AMOUNT_FIELD).updateValueAndValidity();
    } else if (this.commonService.getAmountForBackToBack()) {
      this.form.get(FccGlobalConstant.AMOUNT_FIELD).clearValidators();
      this.form.get(FccGlobalConstant.AMOUNT_FIELD).updateValueAndValidity();
    }
    this.val = amt.value;
    if (this.val === null || this.val === undefined || this.val === '') {
      this.form.get('amount').setErrors({ amountNotNull: true });
      return;
    }
    if (this.val == 0) {
      this.form.get('amount').setErrors({ amountCanNotBeZero: true });
      return;
    }
    if (this.val !== '') {
      if (this.flagDecimalPlaces === -1 && this.enteredCurMethod) {
        this.form.get('amount').setValidators(emptyCurrency);
      }
      if (this.iso !== '' && this.commonService.isNonEmptyValue(this.iso)) {
        this.commonService.amountConfig.subscribe((res) => {
          if (res) {
            let valueupdated = this.commonService.replaceCurrency(this.val);
            valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), this.iso, res);
            this.form.get('amount').setValue(valueupdated);
          }
        });
      }
    }
    this.form.get('amount').updateValueAndValidity();
  }

  onClickNewLCAmt() {
    this.OnClickAmountFieldHandler('newLCAmt');
  }

  onBlurNewLCAmt() {
    this.setAmountLengthValidator('newLCAmt');
    this.patchFieldParameters(this.form.get('newLCAmt'), { infoIcon: false });
    if (!this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value) {
      this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setErrors({ required: true });
    }
    const amt = this.form.get(FccTradeFieldConstants.NEW_LC_AMT);
    this.val = amt.value;
    if (this.commonService.isnonEMptyString(this.val)) {
      if (this.flagDecimalPlaces === -1 && this.enteredCurMethod) {
        this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValidators(emptyCurrency);
      }
      if (this.val <= 0) {
        this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setErrors({ amountCanNotBeZero: true });
        return;
      }
      this.commonService.amountConfig.subscribe((res) => {
        if (res) {
          const valueupdated = this.currencyConverterPipe.transform(this.val.toString(), this.iso, res);
          this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue(valueupdated);
          const newLCDisplayAmt = this.iso.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(valueupdated);
          this.patchFieldParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), { displayedValue: newLCDisplayAmt });
          if (this.iso !== '') {
            amt.setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
            const amtValue = this.commonService.replaceCurrency(this.val);
            const orgAmt = this.commonService.replaceCurrency(this.stateService.getValue('amountChargeDetails', 'amount', true));
            if (amtValue !== '') {
              const changeAmt = parseFloat(amtValue);
              const orgFloatAmt = parseFloat(orgAmt);
              if (orgFloatAmt > changeAmt) {
                const decrAmt = orgFloatAmt - changeAmt;
                const updatedDecrAmt = this.currencyConverterPipe.transform(decrAmt.toString(), this.iso, res);
                this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValue(updatedDecrAmt);
                this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).updateValueAndValidity();
                this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue('');
                this.form.controls[FccTradeFieldConstants.INCREASE_AMOUNT].disable();
                this.form.controls[FccTradeFieldConstants.DECREASE_AMOUNT].enable();
                const decreaseDisplayAmt = this.iso.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(updatedDecrAmt);
                this.patchFieldParameters(this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT), { displayedValue: decreaseDisplayAmt });
                this.form.get('tnxAmt').setValue(updatedDecrAmt);
                this.form.get('tnxAmt').updateValueAndValidity();
                this.newLCAmValidation();
              } else if (orgFloatAmt < changeAmt) {
                const incrAmt = changeAmt - orgFloatAmt;
                const updatedIncrValue = this.currencyConverterPipe.transform(incrAmt.toString(), this.iso, res);
                this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue(updatedIncrValue);
                this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).updateValueAndValidity();
                this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValue('');
                this.form.controls[FccTradeFieldConstants.DECREASE_AMOUNT].disable();
                this.form.controls[FccTradeFieldConstants.INCREASE_AMOUNT].enable();
                const increaseDisplayAmt = this.iso.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(updatedIncrValue);
                this.patchFieldParameters(this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT), { displayedValue: increaseDisplayAmt });
                this.form.get('tnxAmt').setValue(updatedIncrValue);
                this.form.get('tnxAmt').updateValueAndValidity();
                this.newLCAmValidation();
              }
              else {
                this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue('');
                this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).updateValueAndValidity();
                this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValue('');
                this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).updateValueAndValidity();
                this.form.controls[FccTradeFieldConstants.DECREASE_AMOUNT].enable();
                this.form.controls[FccTradeFieldConstants.INCREASE_AMOUNT].enable();
                this.patchFieldParameters(this.form.get('amountChargeAmount'), { infoIcon: false });
                this.form.get('tnxAmt').setValue('');
                this.form.get('tnxAmt').updateValueAndValidity();
              }
            }
          }
        }
      });
    } else {
      this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValidators([Validators.required]);
    }
  }

  onClickIncreaseAmount() {
    this.OnClickAmountFieldHandler(FccTradeFieldConstants.INCREASE_AMOUNT);
  }

  /*validation on change of amount field*/
  onBlurIncreaseAmount() {
    this.setAmountLengthValidator(FccTradeFieldConstants.INCREASE_AMOUNT);
    this.patchFieldParameters(this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT), { infoIcon: false });
    const amt = this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT);
    this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValue('');
    this.form.controls[FccTradeFieldConstants.DECREASE_AMOUNT].disable();
    this.iso = this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.CURRENCY).value) ?
      this.form.get(FccGlobalConstant.CURRENCY).value : null;
    this.val = amt.value;
    if (this.commonService.isnonEMptyString(this.val)) {
      if (this.flagDecimalPlaces === -1 && this.enteredCurMethod) {
        this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValidators(emptyCurrency);
      }
      if (this.val <= 0) {
        this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setErrors({ amountCanNotBeZero: true });
        this.form.get('tnxAmt').setValue('');
        this.form.get('tnxAmt').updateValueAndValidity();
        this.resetNewLCAmount();
        this.form.updateValueAndValidity();
        return;
      }
      if (this.iso !== '' && this.commonService.isNonEmptyValue(this.iso)) {
        amt.setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
        const amtValue = this.commonService.replaceCurrency(this.val);
        const orgAmt = this.commonService.replaceCurrency(this.stateService.getValue('amountChargeDetails', 'amount', true));
        if (amtValue !== '') {
          this.commonService.amountConfig.subscribe((res) => {
            if (res) {
              const changeAmt = parseFloat(amtValue);
              const orgFloatAmt = parseFloat(orgAmt);
              const valueupdated = this.currencyConverterPipe.transform(amtValue.toString(), this.iso, res);
              this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue(valueupdated);
              this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).updateValueAndValidity();
              const increaseDisplayAmt = this.iso.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(valueupdated);
              this.patchFieldParameters(this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT), { displayedValue: increaseDisplayAmt });
              this.form.get('tnxAmt').setValue(valueupdated);
              this.form.get('tnxAmt').updateValueAndValidity();
              let totalNewLCAmt = orgFloatAmt + changeAmt;
              totalNewLCAmt = this.currencyConverterPipe.transform(totalNewLCAmt.toString(), this.iso, res);
              this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue(totalNewLCAmt);
              const newLCDisplayAmt = this.iso.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(totalNewLCAmt);
              this.patchFieldParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), { displayedValue: newLCDisplayAmt });
              this.newLCAmValidation();
              const generalDetailsForm: FCCFormGroup = this.productStateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS);
              if (this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).value &&
                this.form.get('tnxAmt') && (this.form.get('tnxAmt').value > 0)) {
                generalDetailsForm.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE).setValue(FccGlobalConstant.EC_AMEND_INC);
              }
            }
          });
        }
      }
    } else {
      this.form.controls[FccTradeFieldConstants.DECREASE_AMOUNT].enable();
      this.patchFieldParameters(this.form.get('amountChargeAmount'), { infoIcon: false });
      this.resetNewLCAmount();
    }
  }

  onClickDecreaseAmount() {
    this.OnClickAmountFieldHandler(FccTradeFieldConstants.DECREASE_AMOUNT);
  }

  /*validation on change of amount field*/
  onBlurDecreaseAmount() {
    this.setAmountLengthValidator(FccTradeFieldConstants.DECREASE_AMOUNT);
    this.patchFieldParameters(this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT), { infoIcon: false });
    const amt = this.form.get(FccGlobalConstant.DECREASE_AMT);
    this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValue('');
    this.form.controls[FccTradeFieldConstants.INCREASE_AMOUNT].disable();
    this.iso = this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.CURRENCY).value) ?
      this.form.get(FccGlobalConstant.CURRENCY).value : null;
    this.val = amt.value;
    const generalDetailsForm: FCCFormGroup = this.productStateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS);
    if (this.commonService.isnonEMptyString(this.val)) {
      if (this.flagDecimalPlaces === -1 && this.enteredCurMethod) {
        this.form.get(FccGlobalConstant.DECREASE_AMT).setValidators(emptyCurrency);
      }
      if (this.val <= 0) {
        this.form.get(FccGlobalConstant.DECREASE_AMT).setErrors({ amountCanNotBeZero: true });
        this.form.get('tnxAmt').setValue('');
        this.form.get('tnxAmt').updateValueAndValidity();
        this.resetNewLCAmount();
        this.form.updateValueAndValidity();
        return;
      }
      if (this.iso !== '' && this.commonService.isNonEmptyValue(this.iso)) {
        amt.setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
        const amtValue = this.commonService.replaceCurrency(this.val);
        const orgAmt = this.commonService.replaceCurrency(this.stateService.getValue('amountChargeDetails', 'amount', true));
        if (amtValue !== '') {
          const changeAmt = parseFloat(amtValue);
          const orgFloatAmt = parseFloat(orgAmt);
          if (orgFloatAmt > changeAmt) {
            this.commonService.amountConfig.subscribe((res) => {
              if (res) {
                const valueupdated = this.currencyConverterPipe.transform(amtValue.toString(), this.iso, res);
                this.form.get(FccGlobalConstant.DECREASE_AMT).setValue(valueupdated);
                this.form.get(FccGlobalConstant.DECREASE_AMT).updateValueAndValidity();
                const decreaseDisplayAmt = this.iso.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(valueupdated);
                this.patchFieldParameters(this.form.get(FccGlobalConstant.DECREASE_AMT), { displayedValue: decreaseDisplayAmt });
                this.form.get('tnxAmt').setValue(valueupdated);
                this.form.get('tnxAmt').updateValueAndValidity();
                let totalNewLCAmt = orgFloatAmt - changeAmt;
                totalNewLCAmt = this.currencyConverterPipe.transform(totalNewLCAmt.toString(), this.iso, res);
                this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue(totalNewLCAmt);
                const newLCDisplayAmt = this.iso.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(totalNewLCAmt);
                this.patchFieldParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), { displayedValue: newLCDisplayAmt });
                this.newLCAmValidation();
                if (this.form.get(FccGlobalConstant.DECREASE_AMT).value && this.form.get('tnxAmt') && (this.form.get('tnxAmt').value > 0)) {
                  generalDetailsForm.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE).setValue(FccGlobalConstant.EC_AMEND_DEC);
                }
              }
            });
          } else {
            this.form.get(FccGlobalConstant.DECREASE_AMT).setErrors({ orgLessThanChangeAmt: true });
          }
        }
      }
    } else {
      this.form.controls[FccTradeFieldConstants.INCREASE_AMOUNT].enable();
      this.resetNewLCAmount();
      this.patchFieldParameters(this.form.get('amountChargeAmount'), { infoIcon: false });
    }
  }

  resetNewLCAmount() {
    const amountValue = this.stateService.getValue('amountChargeDetails', 'amount', true);
    this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue(amountValue);
  }

  newLCAmValidation() {
    if (this.form.get('newLCAmt').value !== '' && this.form.get('newLCAmt').value !== null) {
      this.form.get('newLCAmt')[this.params][this.render] = true;
      this.patchFieldParameters(this.form.get('amountChargeAmount'), { infoIcon: true, infolabel: FccGlobalConstant.AMENDED });
      this.patchFieldParameters(this.form.get('decreaseAmount'), { infoIcon: false });
      this.patchFieldParameters(this.form.get('increaseAmount'), { infoIcon: false });
      this.form.get('amount').setValue(this.form.get('newLCAmt').value);
      this.form.get('amount').updateValueAndValidity();
    }
  }

  onBlurChargesToApplicant() {
    this.calculateIssuingAppliChargesAmt('chargesToApplicant');
  }
  onBlurChargesToBeneficiary() {
    this.calculateIssuingBeneChargesAmt('chargesToBeneficiary');
  }
  onBlurChargesToApplicantOutside() {
    this.calculateOutsideIssuingAppliChargesAmt('chargesToApplicantOutside');
  }
  onBlurChargesToBeneficiaryOutside() {
    this.calculateOutsideIssuingBeneChargesAmt('chargesToBeneficiaryOutside');
  }
  onBlurChargesToApplicantConf() {
    this.calculateChargesAmt('chargesToApplicantConf');
  }
  onBlurChargesToBeneficiaryConf() {
    this.calculateChargesAmt('chargesToBeneficiaryConf');
  }
  onBlurChargesToApplicantAmendment() {
    this.calculateChargesAmt('chargesToApplicantAmendment');
  }
  onBlurChargesToBeneficiaryAmendment() {
    this.calculateChargesAmt('chargesToBeneficiaryAmendment');
  }
  calculateChargesAmt(chargesField) {
    const amt = this.form.get(chargesField);
    if (amt.value !== '') {
      // Amend check is only temporary.
      // Will be updated when the charge split fields validation is changed to percentage
      const curcode = this.form.get('currency').value;
      if (curcode !== '' && this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
        this.commonService.amountConfig.subscribe((res) => {
          if (res) {
            let valueupdated = this.commonService.replaceCurrency(amt.value);
            valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), curcode, res);
            this.form.get(chargesField).setValue(valueupdated);
          }
        });
      }
    }
    this.form.get(chargesField).updateValueAndValidity();
  }
  calculateIssuingAppliChargesAmt(chargesField) {
    const amt = this.form.get(chargesField);
    const actualAmnt = Math.round(amt.value * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
    if (amt.value !== '' && actualAmnt > FccGlobalConstant.LENGTH_100) {
      this.form.get(chargesField).setErrors({ percentageExceeded: true });
      return;
    }
    if (amt.value !== '' && actualAmnt <= FccGlobalConstant.LENGTH_100 && actualAmnt >= FccGlobalConstant.LENGTH_0) {
      const diffPercentVal = FccGlobalConstant.LENGTH_100 - actualAmnt;
      const originalVal = Math.round(diffPercentVal * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
      this.form.get('chargesToApplicant').setValue(actualAmnt);
      this.form.get('chargesToBeneficiary').setValue(originalVal);
      this.form.get('chargesToApplicant').updateValueAndValidity();
      this.form.get('chargesToBeneficiary').updateValueAndValidity();
      return;
    }
  }

  calculateIssuingBeneChargesAmt(chargesField) {
    const amt = this.form.get(chargesField);
    const actualAmnt = Math.round(amt.value * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
    if (amt.value !== '' && actualAmnt > FccGlobalConstant.LENGTH_100) {
      this.form.get(chargesField).setErrors({ percentageExceeded: true });
      return;
    }
    if (amt.value !== '' && actualAmnt <= FccGlobalConstant.LENGTH_100 && actualAmnt >= FccGlobalConstant.LENGTH_0) {
      const diffPercentVal = FccGlobalConstant.LENGTH_100 - actualAmnt;
      const originalVal = Math.round(diffPercentVal * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
      this.form.get('chargesToBeneficiary').setValue(actualAmnt);
      this.form.get('chargesToApplicant').setValue(originalVal);
      this.form.get('chargesToBeneficiary').updateValueAndValidity();
      this.form.get('chargesToApplicant').updateValueAndValidity();
      return;
    }
  }
  calculateOutsideIssuingAppliChargesAmt(chargesField) {
    const amt = this.form.get(chargesField);
    const actualAmnt = Math.round(amt.value * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
    if (amt.value !== '' && actualAmnt > FccGlobalConstant.LENGTH_100) {
      this.form.get(chargesField).setErrors({ percentageExceeded: true });
      return;
    }
    if (amt.value !== '' && actualAmnt <= FccGlobalConstant.LENGTH_100 && actualAmnt >= FccGlobalConstant.LENGTH_0) {
      const diffPercentVal = FccGlobalConstant.LENGTH_100 - actualAmnt;
      const originalVal = Math.round(diffPercentVal * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
      this.form.get('chargesToApplicantOutside').setValue(actualAmnt);
      this.form.get('chargesToBeneficiaryOutside').setValue(originalVal);
      this.form.get('chargesToApplicantOutside').updateValueAndValidity();
      this.form.get('chargesToBeneficiaryOutside').updateValueAndValidity();
      return;
    }
  }

  calculateOutsideIssuingBeneChargesAmt(chargesField) {
    const amt = this.form.get(chargesField);
    const actualAmnt = Math.round(amt.value * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
    if (amt.value !== '' && actualAmnt > FccGlobalConstant.LENGTH_100) {
      this.form.get(chargesField).setErrors({ percentageExceeded: true });
      return;
    }
    if (amt.value !== '' && actualAmnt <= FccGlobalConstant.LENGTH_100 && actualAmnt >= FccGlobalConstant.LENGTH_0) {
      const diffPercentVal = FccGlobalConstant.LENGTH_100 - actualAmnt;
      const originalVal = Math.round(diffPercentVal * FccGlobalConstant.LENGTH_100) / FccGlobalConstant.LENGTH_100;
      this.form.get('chargesToBeneficiaryOutside').setValue(actualAmnt);
      this.form.get('chargesToApplicantOutside').setValue(originalVal);
      this.form.get('chargesToBeneficiaryOutside').updateValueAndValidity();
      this.form.get('chargesToApplicantOutside').updateValueAndValidity();
      return;
    }
  }

  removeMandatory(fields: any) {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryFields(this.form, fields, false);
    }
  }

  amendFormFields() {
    const generalDetailsForm: FCCFormGroup = this.productStateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS);
    if (generalDetailsForm.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE)) {
      generalDetailsForm.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE).setValue(FccGlobalConstant.EC_AMEND_TERMS);
    }
    this.form.get('amountChargeAmount')[this.params][this.render] = true;
    this.form.get('orgLCAmt')[this.params][this.render] = true;
    this.form.get('amount')[this.params][this.render] = false;
    this.form.get('lcAvailableAmt')[this.params][this.render] = false;
    this.form.get('outstandingAmount')[this.params][this.render] = false;
    this.form.get('amount').clearValidators();
    this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT)[this.params][this.render] = true;
    this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
    this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT)[this.params][this.render] = true;
    this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
    this.form.get(FccTradeFieldConstants.NEW_LC_AMT)[this.params][this.render] = true;
    this.form.get(FccTradeFieldConstants.NEW_LC_AMT)[this.params][this.required] = true;
    if (this.modeParam === FccGlobalConstant.DRAFT_OPTION) {
      this.patchFieldParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), { infoIcon: false });
    }
    this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
    this.form.get('decrAmountCurrency')[this.params][this.render] = true;
    this.form.get('newLCAmtCurrency')[this.params][this.render] = true;
    this.form.get('variationInDrawingText')[this.params][this.render] = true;
    this.form.get(FccGlobalConstant.OUTSTANDINGCURCHARGES)[this.params][this.render] = false;
    this.form.get(FccGlobalConstant.AMENDMENTCHARGESLABEL)[this.params][this.render] = false;
    this.form.get(this.amendmentCharges)[this.params][this.render] = true;
    let amountValue;
    let currencyValue;
    let orgLcAmt;
    if (this.modeParam === FccGlobalConstant.DRAFT_OPTION || this.modeParam === FccGlobalConstant.EXISTING &&
      this.commonService.checkPendingClientBankViewForAmendTnx()) {
      amountValue = this.stateService.getValue('amountChargeDetails', 'amount', true);
      currencyValue = this.stateService.getValue('amountChargeDetails', 'currency', true);
      orgLcAmt = this.stateService.getValue('amountChargeDetails', 'orgLCAmt', false);
    } else {
      amountValue = this.stateService.getValue('amountChargeDetails', 'amount', false);
      currencyValue = this.stateService.getValue('amountChargeDetails', 'currency', false);
      orgLcAmt = this.stateService.getValue('amountChargeDetails', 'orgLCAmt', false);
    }
    this.commonService.amountConfig.subscribe((res) => {
      if (res) {
        let orglcAmtValue = (this.commonService.isNonEmptyValue(orgLcAmt) &&
          orgLcAmt !== FccGlobalConstant.EMPTY_STRING) ? orgLcAmt : amountValue;
        if (orglcAmtValue.indexOf(FccGlobalConstant.BLANK_SPACE_STRING) === -1) {
          //orglcAmtValue = this.currencyConverterPipe.transform(orglcAmtValue.toString(), currencyValue, res);
          orglcAmtValue = currencyValue.concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(orglcAmtValue);
        }
        if (this.operation !== FccGlobalConstant.PREVIEW) {
          const orgAmt = this.stateService.getValue(FccGlobalConstant.AMOUNT_CHARGE_DETAILS, FccGlobalConstant.ORG_AMOUNT_FIELD, true);
          if (orgAmt === null || orgAmt === undefined || orgAmt === FccGlobalConstant.EMPTY_STRING) {
            this.stateService.setValue(FccGlobalConstant.AMOUNT_CHARGE_DETAILS, FccGlobalConstant.ORG_AMOUNT_FIELD,
              orglcAmtValue, true);
          }
        }
        this.patchFieldValueAndParameters(this.form.get('orgLCAmt'), orglcAmtValue, '');
        this.amendCommonService.setValueFromMasterToPrevious('amountChargeDetails');
        this.stateService.setValue('amountChargeDetails', 'decrAmountCurrency', currencyValue, false);
        this.stateService.setValue('amountChargeDetails', 'newLCAmtCurrency', currencyValue, false);
        if (this.form.get(FccTradeFieldConstants.NEW_LC_AMT) && this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value === null) {
          this.form.get(FccTradeFieldConstants.NEW_LC_AMT).setValue(amountValue);
        }
      }
    });
    if (this.form.get(this.amendmentCharges) && this.form.get(this.amendmentCharges)[this.params][FccGlobalConstant.PREVIOUSCOMPAREVALUE] &&
      this.form.get(this.amendmentCharges).value !==
      this.form.get(this.amendmentCharges)[this.params][FccGlobalConstant.PREVIOUSCOMPAREVALUE]) {
      this.patchFieldParameters(this.form.get(this.amendmentCharges), { infoIcon: true, infolabel: FccGlobalConstant.AMENDED });
    }
    if (this.form.get(this.outStdCurrency) && this.form.get(this.outStdCurrency)[this.params][FccGlobalConstant.PREVIOUSCOMPAREVALUE] &&
      this.form.get(this.outStdCurrency).value !==
      this.form.get(this.outStdCurrency)[this.params][FccGlobalConstant.PREVIOUSCOMPAREVALUE]) {
      this.patchFieldParameters(this.form.get(this.outStdCurrency), { infoIcon: true, infolabel: FccGlobalConstant.AMENDED });
    }
  }

  removeAmendFlagFromField() {
    if (this.form.get('orgLCAmt').value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get('orgLCAmt'), { amendPersistenceSave: true });
    }
    if (this.form.get(FccTradeFieldConstants.NEW_LC_AMT).value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get(FccTradeFieldConstants.NEW_LC_AMT), { amendPersistenceSave: true });
    }
    if (this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT).value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get(FccTradeFieldConstants.INCREASE_AMOUNT), { amendPersistenceSave: true });
    }
    if (this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT).value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get(FccTradeFieldConstants.DECREASE_AMOUNT), { amendPersistenceSave: true });
    }
  }

  onClickPhraseIcon(event: any, key: any) {
    const entityControl = this.stateService.getSectionData(FccGlobalConstant.APPLICANT_BENEFICIARY).get('applicantEntity');
    let entityName;
    if (entityControl && entityControl.value && entityControl.value.shortName) {
      entityName = entityControl.value.shortName;
    }
    if (this.commonService.isnonEMptyString(entityName)) {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '05', false, entityName);
    } else {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '05', false);
    }
  }
}
