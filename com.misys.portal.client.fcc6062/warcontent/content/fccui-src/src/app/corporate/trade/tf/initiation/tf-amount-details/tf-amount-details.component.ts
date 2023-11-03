import { Component, ElementRef, EventEmitter, OnInit, Output, AfterViewInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DynamicDialogRef } from 'primeng';
import { ConfirmationService, SelectItem } from 'primeng/api';

import { FCCFormGroup } from '../../../../../../app/base/model/fcc-control.model';
import { FccGlobalConstant } from '../../../../../../app/common/core/fcc-global-constants';
import { CurrencyRequest } from '../../../../../../app/common/model/currency-request';
import { ExchangeRateRequest } from '../../../../../../app/common/model/xch-rate-request';
import { CommonService } from '../../../../../../app/common/services/common.service';
import { EventEmitterService } from '../../../../../../app/common/services/event-emitter-service';
import { FormModelService } from '../../../../../../app/common/services/form-model.service';
import { LcTemplateService } from '../../../../../../app/common/services/lc-template.service';
import { SearchLayoutService } from '../../../../../../app/common/services/search-layout.service';
import { SessionValidateService } from '../../../../../../app/common/services/session-validate-service';
import { LeftSectionService } from '../../../../../../app/corporate/common/services/leftSection.service';
import { ResolverService } from '../../../../../common/services/resolver.service';
import { ProductStateService } from '../../../lc/common/services/product-state.service';
import { SaveDraftService } from '../../../lc/common/services/save-draft.service';
import { FilelistService } from '../../../lc/initiation/services/filelist.service';
import { FormControlService } from '../../../lc/initiation/services/form-control.service';
import { LcReturnService } from '../../../lc/initiation/services/lc-return.service';
import { PrevNextService } from '../../../lc/initiation/services/prev-next.service';
import { UtilityService } from '../../../lc/initiation/services/utility.service';
import {
  emptyCurrency,
} from '../../../lc/initiation/validator/ValidateAmt';
import { TfProductComponent } from '../tf-product/tf-product/tf-product.component';
import { FccGlobalConfiguration } from './../../../../../common/core/fcc-global-configuration';
import { FccGlobalConstantService } from './../../../../../common/core/fcc-global-constant.service';
import { CurrencyConversionRequest } from './../../../../../common/model/currency-conversion-request';
import { CurrencyConversionService } from './../../../../../common/services/currency-conversion.service';
import { PhrasesService } from './../../../../../common/services/phrases.service';
import { CurrencyConverterPipe } from '../../../lc/initiation/pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { TfProductService } from '../../services/tf-product.service';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-tf-amount-details',
  templateUrl: './tf-amount-details.component.html',
  styleUrls: ['./tf-amount-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: TfAmountDetailsComponent }]
})
export class TfAmountDetailsComponent extends TfProductComponent implements OnInit, AfterViewInit {
  @Output() messageToEmit = new EventEmitter<string>();

  form: FCCFormGroup;
  rendered: true;
  formSubmitted = false;
  module = `${this.translateService.instant('tfAmountDetails')}`;
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
  twoDecimal = 2;
  threeDecimal = 3;
  subheadTitle = 'subheader-title';
  length2 = FccGlobalConstant.LENGTH_2;
  length3 = FccGlobalConstant.LENGTH_3;
  length4 = FccGlobalConstant.LENGTH_4;
  val;
  radioButtonValue = localStorage.getItem('confInst');
  allLcRecords;
  mandatoryParams = ['currency', 'amount'];
  splitChargeEnabled: any;
  tnxTypeCode: any;
  validateAmt = false;
  validatorPattern = FccGlobalConstant.AMOUNT_VALIDATION;
  cal = '';
  mode: any;
  phrasesResponse: any;
  amountVal: any;
  ccRequest: CurrencyConversionRequest = new CurrencyConversionRequest();
  warning = 'warning';
  notionalAmount;
  language = localStorage.getItem('language');
  requestType: any;
  standalone = '03';

  constructor(protected commonService: CommonService, protected sessionValidation: SessionValidateService,
    protected translateService: TranslateService, protected router: Router,
    protected leftSectionService: LeftSectionService,
    protected lcReturnService: LcReturnService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
    protected currencyConverterPipe: CurrencyConverterPipe,
    protected utilityService: UtilityService, protected prevNextService: PrevNextService,
    protected saveDraftService: SaveDraftService, protected stateService: ProductStateService,
    protected elementRef: ElementRef, protected lcTemplateService: LcTemplateService,
    protected formModelService: FormModelService, protected formControlService: FormControlService,
    protected emitterService: EventEmitterService, protected searchLayoutService: SearchLayoutService,
    protected phrasesService: PhrasesService, protected currencyConversionService: CurrencyConversionService,
    protected fccGlobalConfiguration: FccGlobalConfiguration, protected fccGlobalConstantService: FccGlobalConstantService,
    protected confirmationService: ConfirmationService, protected resolverService: ResolverService,
    protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
    protected tfProductService: TfProductService) {
    super(emitterService, stateService, commonService, translateService, confirmationService,
      customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray,
      dialogRef, currencyConverterPipe, tfProductService);
  }

  getCurrencyDetail() {
    const requestVal = this.stateService.getSectionData('tfGeneralDetails').get('typeOfProduct').value;
      const requestValArray = [FccGlobalConstant.FROM_EXPORT_LC, FccGlobalConstant.FROM_IMPORT_COLLECTION,
        FccGlobalConstant.FROM_EXPORT_COLLECTION, FccGlobalConstant.FROM_IMPORT_LC, FccGlobalConstant.FROM_GENERAL_SCRATCH,
      'IMPORT_DRAFT','EXPORT_DRAFT'];
      if (requestVal && (requestValArray.includes(requestVal))) {
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
                this.updateCurrencyValue();
              }
            });
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
              this.commonService.TFRequestType.subscribe((res: any) => {
                if (res === 'standalone') {
                  return null;
                }
                else {
                  const bill: string = this.commonService.getTfBillAmount();
                  if (bill !== '' && bill !== null && bill !== undefined) {
                    const curr = bill.split(' ')[0];
                    const currency = this.currency.find(item => item.label === curr);
                    this.form.get('currency').setValue({
                      label: currency.value.label,
                      iso: currency.value.iso,
                      country: currency.value.country,
                      currencyCode: currency.value.label,
                      shortName: currency.value.label,
                      name: currency.value.name
                    });
                  }
                }
              });
              this.notionalAmount = 0;
              this.form.get('currency')[this.params][this.warning] = '';
              this.onBlurAmount();
            } else {
              this.updateCurrencyValue();
            }
          }
        }
      });
    }
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
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.initializeFormGroup();
    this.initiationofdata();
    const sectionName = 'tfGeneralDetails';
    this.requestType = this.stateService.getSectionData(sectionName);
    this.requestType = this.requestType.controls.requestOptionsTF.value;
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.addamtregex = response.swiftXCharacterSet;
        // this.form.addFCCValidators('addAmtTextArea', Validators.pattern(this.addamtregex), 0);
      }
    });
    this.getCurrencyDetail();
    if (this.mode != FccGlobalConstant.DRAFT_OPTION &&
      this.commonService.getTfBillAmount() !== null && this.commonService.getTfBillAmount() !== undefined) {
      this.patchFieldParameters(this.form.get('billAmountValue'), { label: this.commonService.getTfBillAmount() });
      this.form.get('billAmountValue').setValue(this.commonService.getTfBillAmount().toString());
      this.patchFieldValueAndParameters(this.form.get('billamt'), this.commonService.getTfFinAmount(), {});
      this.patchFieldValueAndParameters(this.form.get('billamtcurCode'), this.commonService.getTfFinCurrency(), {});
      this.form.get(FccGlobalConstant.TF_BILL_CURRENCY).setValue(this.commonService.getTfFinCurrency());
    }
    else if (this.mode === FccGlobalConstant.DRAFT_OPTION) {
      const billamountvalue = this.commonService.getTfFinCurrency() + ' ' + this.form.get('billamt').value;
      this.patchFieldParameters(this.form.get('billAmountValue'), { label: billamountvalue });
      this.form.get('billAmountValue').setValue(billamountvalue);
      this.patchFieldValueAndParameters(this.form.get('billamt'), this.form.get('billamt').value, {});
      this.patchFieldValueAndParameters(this.form.get('billamtcurCode'), this.commonService.getTfFinCurrency(), {});
      this.form.get(FccGlobalConstant.TF_BILL_CURRENCY).setValue(this.commonService.getTfFinCurrency());
    }
    if (this.form.get('amount').value !== undefined && this.form.get('amount').value !== null && this.form.get('amount').value !== '') {
      this.onBlurAmount();
    }
    this.form.addFCCValidators('requestedPercentValue', Validators.compose([Validators.pattern(FccGlobalConstant.percentagePattern)]), 0);
    this.form.updateValueAndValidity();
    this.checkAmount(FccGlobalConstant.LENGTH_1);
    this.form.get('amount').updateValueAndValidity();
    this.form.get(FccGlobalConstant.TF_BILL_CURRENCY)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    this.form.get(FccGlobalConstant.TF_BILL_AMOUNT)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;

    if (this.requestType === this.standalone) {
      this.form.get('billAmountLabel')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('billAmountValue')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    } else {
      this.form.get('billAmountLabel')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('billAmountValue')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    }

    if (this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.get('financingAmount')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    }

  }

  ngAfterViewInit() {
    const amountValue = this.form.get('amount').value;
    if (amountValue != undefined && amountValue != null && amountValue != '') {
      this.onBlurAmount();
    }
  }
  ngOnDestroy() {
    if (this.requestType !== this.standalone) {
      this.form.get(FccGlobalConstant.TF_BILL_CURRENCY)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get(FccGlobalConstant.TF_BILL_AMOUNT).setValue(this.form.get('billamt').value);
      this.form.get(FccGlobalConstant.TF_BILL_AMOUNT)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    }
    this.stateService.setStateSection('tfAmountDetails', this.form);
  }

  /*on click of previous button*/
  onClickPrevious() {
    this.saveFormObject();
    if (!CommonService.isTemplateCreation) {
      this.saveDraftService.changeSaveStatus('tfAmountDetails',
        this.stateService.getSectionData('tfAmountDetails'));
    }
  }
  /*on click of next button */
  onClickNext() {

    this.saveFormObject();
    if (!CommonService.isTemplateCreation) {
      this.saveDraftService.changeSaveStatus('tfAmountDetails',
        this.stateService.getSectionData('tfAmountDetails'));
    }
  }

  saveFormObject() {
    if (this.utilityService.getMasterValue('mode') === 'draft') {
      this.utilityService.putMasterdata('currency', this.form.get('currency').value.label);
    }
    this.stateService.setStateSection('tfAmountDetails', this.form);
  }

  removeMandatory(fields: any) {
    if (CommonService.isTemplateCreation) {
      this.setMandatoryFields(this.form, fields, false);
    }
  }

  /*validation on change of currency field*/
  onClickCurrency(event) {
    if (event.value !== undefined) {
      this.enteredCurMethod = true;
      this.iso = event.value.currencyCode;
      this.commonService.getamountConfiguration(this.iso);
      this.isoamt = this.iso;
      const amt = this.form.get('amount');
      this.val = amt.value;
      amt.setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
      this.setMandatoryField(this.form, 'amount', true);
      this.flagDecimalPlaces = 0;
      this.setNotionalAmount();
      if (this.commonService.isnonEMptyString(this.val)) {
        this.commonService.amountConfig.subscribe((res) => {
          if (res) {
            let valueupdated = this.commonService.replaceCurrency(this.val);
            valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), this.iso, res);
            amt.setValue(valueupdated);
            this.calculateAmount();
            this.patchFieldValueAndParameters(this.form.get('finAmount'), amt.value, {});
            this.patchFieldValueAndParameters(this.form.get('finCurCode'), this.form.get('currency').value.shortName, {});
            this.patchFieldValueAndParameters(this.form.get('tnxAmount'), amt.value, {});
            this.patchFieldValueAndParameters(this.form.get('tnxCurCode'), this.form.get('currency').value.shortName, {});
          }
        });
      } else {
        amt.setErrors({ required: true });
      }
      amt.updateValueAndValidity();
      this.removeMandatory(['amount']);
    }
  }

  initializeFormGroup() {
    const sectionName = 'tfAmountDetails';
    this.form = this.stateService.getSectionData(sectionName);
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
      this.patchFieldParameters(this.form.get('currency'), { options: this.currency });
    }
    if (this.mode === 'DRAFT') {
      this.patchFieldValueAndParameters(this.form.get('finAmount'), this.form.get('amount').value, {});
      this.patchFieldValueAndParameters(this.form.get('finCurCode'), this.form.get('currency').value.shortName, {});
      this.patchFieldValueAndParameters(this.form.get('tnxAmount'), this.form.get('amount').value, {});
      this.patchFieldValueAndParameters(this.form.get('tnxCurCode'), this.form.get('currency').value.shortName, {});
      this.form.updateValueAndValidity();
    }
    this.setAmountLengthValidator('amount');
  }

  updateCurrencyValue() {
    if (this.mode === 'DRAFT' && this.form.get('currency').value !== undefined
      && this.form.get('currency').value !== null && this.form.get('currency').value !== '' &&
      this.currency.length > 0) {
      const exists = this.currency.filter(
        task => task.label === this.form.get('currency').value.shortName);
      if (exists.length > 0) {
        const currency = this.currency.filter(
          task => task.label === this.form.get('currency').value.shortName)[0].value;
        if (currency !== undefined && currency !== null && currency !== '') {
          this.form.get('currency').setValue({
            label: currency.label,
            iso: currency.iso,
            country: currency.country,
            currencyCode: currency.label,
            shortName: currency.label,
            name: currency.name
          });
          this.commonService.getamountConfiguration(this.form.get('currency').value.currencyCode);
          this.setNotionalAmount();
        }
      }
      this.patchFieldParameters(this.form.get('currency'), { readonly: false });
    } else {
      this.patchFieldParameters(this.form.get('currency'), { options: this.currency });
      const amountDetails = this.stateService.getSectionData('tfAmountDetails', undefined, false);
      const currency = amountDetails.get('currency').value;
      if (currency !== undefined && currency !== null && currency !== '') {
        this.form.get('currency').setValue({
          label: currency.label,
          iso: currency.iso,
          country: currency.country,
          currencyCode: currency.label,
          shortName: currency.label,
          name: currency.name
        });
        this.commonService.getamountConfiguration(this.form.get('currency').value.currencyCode);
        this.setNotionalAmount();
      }
    }
  }

  onClickAmount() {
    this.OnClickAmountFieldHandler('amount');
  }

  /*validation on change of amount field*/
  onBlurAmount() {
    this.setAmountLengthValidator('amount');
    this.checkAmount(FccGlobalConstant.LENGTH_0);
    const flag = 0;
    if (this.form.get('amount').value && this.stateService.getSectionData('tfAmountDetails').get('tnx_amt')) {
      this.stateService.getSectionData('tfAmountDetails').get('tnx_amt').setValue(this.form.get('amount').value ?
        this.form.get('amount').value : '');
    }
    if(this.commonService.isnonEMptyString(this.stateService.getSectionData('tfAmountDetails')
    .get('billCurrency').value) && this.commonService.isnonEMptyString(this.stateService.getSectionData('tfAmountDetails')
    .get('billAmount').value)) {
      this.validateAmount(parseFloat(this.form.get('amount').value), this.stateService.getSectionData('tfAmountDetails')
      .get('billCurrency').value,this.stateService.getSectionData('tfAmountDetails').get('billAmount').
      value.split(',').join(''), flag);
      this.form.updateValueAndValidity();
    }
  }

  onChangeAmount() {
    this.setAmountLengthValidator('amount');
    this.checkAmount(FccGlobalConstant.LENGTH_0);
    const flag = 0;
    if (this.form.get('amount').value && this.stateService.getSectionData('tfAmountDetails').get('tnx_amt')) {
      this.stateService.getSectionData('tfAmountDetails').get('tnx_amt').setValue(this.form.get('amount').value ?
        this.form.get('amount').value : '');
    }
    this.validateAmount(parseFloat(this.form.get('amount').value), this.stateService.getSectionData('tfAmountDetails')
    .get('billCurrency').value,this.stateService.getSectionData('tfAmountDetails').get('billAmount').
    value.split(',').join(''), flag);
    this.form.updateValueAndValidity();
  }
  onKeyupAmount() {
    if (this.form.get('amount').value && this.stateService.getSectionData('tfAmountDetails').get('tnx_amt')) {
      this.stateService.getSectionData('tfAmountDetails').get('tnx_amt').setValue(this.form.get('amount').value ?
        this.form.get('amount').value : '');
    }
    this.form.updateValueAndValidity();
  }

  checkAmount(flag) {
    const amt = this.form.get('amount');
    const currcode = this.form.get('currency').value.currencyCode;
    const amtVal = amt.value;
    if (amtVal === null || amtVal === undefined || amtVal === '') {
      this.form.get('amount').setErrors({ amountNotNull: true });
      return;
    } else if (amtVal <= 0) {
      this.form.get('amount').setErrors({ amountCanNotBeZero: true });
      return;
    }
    if (amtVal !== '') {
      if (this.flagDecimalPlaces === -1 && this.enteredCurMethod) {
        this.form.get('amount').setValidators(emptyCurrency);
      }
      if (currcode !== '') {
        this.commonService.amountConfig.subscribe((res) => {
          if (res) {
            let valueupdated = this.commonService.replaceCurrency(amtVal);
            valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), currcode, res);
            let bill: string;
            if (this.commonService.getTfBillAmount()) {
              bill = this.commonService.getTfBillAmount().split(' ')[1];
            }
            this.form.get('amount').setValue(valueupdated);
            let billAmt = '';
            let amtValue = '';
            billAmt = this.commonService.replaceCurrency(bill);
            amtValue = this.commonService.replaceCurrency(valueupdated);
            if (this.notionalAmount === 0) {
              this.validateAmount(parseFloat(amtValue), currcode, billAmt, flag);
            } else {
              this.calculateAmount();
            }
            this.patchFieldValueAndParameters(this.form.get('finAmount'), this.form.get('amount').value, {});
            this.patchFieldValueAndParameters(this.form.get('finCurCode'), this.form.get('currency').value.shortName, {});
            this.patchFieldValueAndParameters(this.form.get('tnxAmount'), this.form.get('amount').value, {});
            this.patchFieldValueAndParameters(this.form.get('tnxCurCode'), this.form.get('currency').value.shortName, {});
          }
        });
      }
    }
  }

  validateAmount(newAmt, newAmtCurrency, oldAmt, flag) {
    if (parseFloat(newAmt) > parseFloat(oldAmt)) {
      if (this.requestType !== this.standalone) {
        this.form.get('amount').setErrors({ requestedAmtExceeded: true });
      }
      this.form.get('requestedPercentValue').setValue(null);
      if (flag === FccGlobalConstant.LENGTH_1) {
        this.form.get('amount').setValue(null);
        this.form.updateValueAndValidity();
      }
    }
  }

  onClickPhraseIcon(event: any, key: any) {
    this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_TF, key);
  }

  calculateAmount() {
    const amt: string = this.form.get('amount').value;
    const amount = this.commonService.replaceCurrency(amt);
    if (this.requestType !== this.standalone) {
      if (parseFloat(amount) > parseFloat(this.notionalAmount)) {
        this.form.get('amount').setErrors({ requestedAmtExceeded: true });
      }
    }
  }

  setNotionalAmount() {
    let exAmt: string;
    if (this.commonService.getTfBillAmount()) {
      exAmt = this.commonService.getTfBillAmount().split(' ')[1];
    }
    const exchangeAmt = this.commonService.replaceCurrency(exAmt);
    let exchangeCurrency;
    if (this.commonService.getTfBillAmount()) {
      exchangeCurrency = this.commonService.getTfBillAmount().split(' ')[0];
    }
    const toCurrency = this.form.get('currency').value.currencyCode;
    this.ccRequest.fromCurrency = exchangeCurrency;
    this.ccRequest.toCurrency = toCurrency;
    this.ccRequest.fromCurrencyAmount = exchangeAmt.toString();
    this.currencyConversionService.getConversion(this.fccGlobalConstantService.getCurrencyConverterUrl(), this.ccRequest).subscribe(
      response => {
        if (response.errorMessage && response.errorMessage === 'SESSION_INVALID') {
          this.sessionValidation.IsSessionValid();
        } else {
          if (this.requestType !== this.standalone) {
            this.commonService.amountConfig.subscribe((res) => {
              if (res) {
                this.notionalAmount = response.toCurrencyAmount != null ? response.toCurrencyAmount : 0;
                this.notionalAmount = this.commonService.replaceCurrency(exchangeAmt);
                const notionalAmountValue = this.currencyConverterPipe.transform(this.notionalAmount.toString(), toCurrency, res);
                this.form.get('currency')[this.params][this.warning] = `${this.translateService.instant('tfNotionalMessage')} ${toCurrency}
            ${this.translateService.instant('is')} ${notionalAmountValue}`;
                const amt: string = this.form.get('amount').value;
                if (amt !== undefined && amt !== '' && amt !== null) {
                  let amount = '';
                  amount = this.commonService.replaceCurrency(amt);
                  if (parseFloat(amount) > parseFloat(this.notionalAmount)) {
                    this.form.get('amount').setErrors({ requestedAmtExceeded: true });
                  }
                }
              }
            });
          } else {
            this.notionalAmount = 0;
          }
        }
      });
  }

}
