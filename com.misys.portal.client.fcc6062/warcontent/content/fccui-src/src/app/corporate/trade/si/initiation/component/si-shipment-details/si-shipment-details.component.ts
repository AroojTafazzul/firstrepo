import { Component, OnDestroy, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DynamicDialogRef } from 'primeng';
import { ConfirmationService, SelectItem } from 'primeng/api';
import { CurrencyConverterPipe } from './../../../../lc/initiation/pipes/currency-converter.pipe';
import { FccBusinessConstantsService } from '../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstantService } from '../../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../../common/core/fcc-global-constants';
import { CommonService } from '../../../../../../common/services/common.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { AmendCommonService } from '../../../../../common/services/amend-common.service';
import { LeftSectionService } from '../../../../../common/services/leftSection.service';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { SiProductComponent } from '../si-product/si-product.component';
import { FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FormModelService } from './../../../../../../common/services/form-model.service';
import { LcTemplateService } from './../../../../../../common/services/lc-template.service';
import { CorporateCommonService } from './../../../../../../corporate/common/services/common.service';
import { LcConstant } from './../../../../../../corporate/trade/lc/common/model/constant';
import { ProductStateService } from './../../../../../../corporate/trade/lc/common/services/product-state.service';
import { ImportLetterOfCreditResponse } from './../../../../../../corporate/trade/lc/initiation/model/models';
import { FormControlService } from './../../../../../../corporate/trade/lc/initiation/services/form-control.service';
import { LcReturnService } from './../../../../../../corporate/trade/lc/initiation/services/lc-return.service';
import { PrevNextService } from './../../../../../../corporate/trade/lc/initiation/services/prev-next.service';
import { UtilityService } from './../../../../../../corporate/trade/lc/initiation/services/utility.service';
import {
  compareLastShipmentDate,
  compareNewExpiryDateToOld
} from './../../../../../../corporate/trade/lc/initiation/validator/ValidateLastShipDate';
import { SiProductService } from '../../../services/si-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-si-shipment-details',
  templateUrl: './si-shipment-details.component.html',
  styleUrls: ['./si-shipment-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: SiShipmentDetailsComponent }]
})
export class SiShipmentDetailsComponent extends SiProductComponent implements OnInit, OnDestroy {
  form: FCCFormGroup;
  shipmentFormLength;
  module: string;
  subheader = '';
  shipmentForm = 'shipmentForm';
  shipmentTo = 'shipmentTo';
  placeOfLoading = 'shipmentPlaceOfLoading';
  placeOfDischarge = 'shipmentPlaceOfDischarge';
  lastShipmentDate = 'shipmentLastDate';
  shipmentPeriod = 'shipmentPeriod';
  partialshipment = 'partialshipment';
  transhipment = 'transhipment';
  purchaseTerms = 'purchaseTerms';
  namedPlace = 'namedPlace';
  exwork = 'exwork';
  freecarrier = 'freecarrier';
  freealong = 'freealong';
  freeboard = 'freeboard';
  costandfreight = 'costandfreight';
  costinfreight = 'costinfreight';
  deleverdterminal = 'deleverdterminal';
  deleverdplace = 'deleverdplace';
  carriagepaid = 'carriagepaid';
  carriageinsurance = 'carriageinsurance';
  deleverdpaid = 'deleverdpaid';
  allowed = 'allowed';
  conditional = 'conditional';
  notallowed = 'notallowed';
  params = 'params';
  enteredCharCount = 'enteredCharCount';
  warning = 'warning';
  warningmessage = 'warningmessage';
  label = 'label';
  readonly = 'readonly';
  year2020 = '2020';
  year2010 = '2010';
  yearOther = 'OTHER';
  summaryDetails: any;
  expiryDate: any;
  lcResponseForm = new ImportLetterOfCreditResponse();
  lcConstant = new LcConstant();
  rendered = this.lcConstant.rendered;
  tnxTypeCode: any;
  purchasetermsvalue: SelectItem[] = [];
  termValues = [];
  incoTermsRules = [];
  expiryDateBackToBack: any;
  shipmentNamedPlaceLength;
  option;
  incotermsDetails: any;
  sectionName = FccGlobalConstant.SI_SHIPMENT_DETAILS;
  mutualExclusiveMessage = 'mutualExclusiveMessage';
  shipmentDate = 'shipmentLastDate';
  shipmentPeriodTxt = 'shipmentPeriodText';
  mode: any;
  expiryType: any;
  isMasterRequired: any;
  enquiryRegex;
  fieldNames = [];
  regexType: string;
  swiftZchar;
  productCode: any;
  constructor(protected router: Router, protected translationService: TranslateService, protected lcReturnService: LcReturnService,
              protected leftSectionService: LeftSectionService,
              protected utilityService: UtilityService, protected prevNextService: PrevNextService,
              protected lcTemplateService: LcTemplateService,
              protected formModelService: FormModelService, protected formControlService: FormControlService,
              protected commonService: CommonService, protected stateService: ProductStateService,
              protected emitterService: EventEmitterService, protected corporateCommonService: CorporateCommonService,
              protected fccGlobalConstantService: FccGlobalConstantService, protected amendCommonService: AmendCommonService,
              protected confirmationService: ConfirmationService, protected resolverService: ResolverService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected siProductService: SiProductService
  ) {
    super(emitterService, stateService, commonService, translationService, confirmationService,
      customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray,
      dialogRef, currencyConverterPipe, siProductService);
    this.module = `${this.translationService.instant(FccGlobalConstant.SI_SHIPMENT_DETAILS)}`;
  }

  ngOnInit() {
    this.getIncotermsDetails();
    super.ngOnInit();
    this.isMasterRequired = this.isMasterRequired;
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.productCode = this.commonService.getQueryParametersFromKey (FccGlobalConstant.PRODUCT);
    this.mode = this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get('transmissionMode').value;
    window.scroll(0, 0);
    this.initializeFormGroup();
    this.expiryDate = this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get('expiryDate').value;
    this.form.get('purchaseTermsValue')[this.params][this.readonly] = this.form.get('incoTermsRules').value ? false : true;
    this.patchLayoutForReadOnlyMode();


    this.fieldNames = ['shipmentForm', 'shipmentTo',
    'shipmentPlaceOfLoading', 'shipmentPlaceOfDischarge', 'shipmentPeriodText'];
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.enquiryRegex = response.swiftXCharacterSet;
        this.swiftZchar = response.swiftZChar;
        this.shipmentNamedPlaceLength = response.shipmentNamedPlaceLength;
        this.clearingFormValidators(['shipmentForm', 'shipmentTo',
        'shipmentPlaceOfLoading', 'shipmentPlaceOfDischarge', 'shipmentPeriodText']);
        if ((this.mode === FccBusinessConstantsService.SWIFT) ||
        (this.mode[0] && this.mode[0].value === FccBusinessConstantsService.SWIFT)) {
          this.fieldNames.forEach(ele => {
            this.form.get(ele).clearValidators();
             this.regexType = this.form.get(ele)[FccGlobalConstant.PARAMS]['applicableValidation'][0]['characterValidation'];
            if (this.regexType === FccGlobalConstant.SWIFT_X) {
              this.regexType = this.enquiryRegex;
            } else if (this.regexType === FccGlobalConstant.SWIFT_Z) {
              this.regexType = this.swiftZchar;
            }
            if (this.commonService.validateProduct(this.form, ele, this.productCode)) {
              this.form.addFCCValidators(ele, Validators.pattern(this.regexType), 0);
              }
          });
          this.form.updateValueAndValidity();
        }
      }
    });


    if (this.commonService.getShipmentExpiryDateForBackToBack()) {
      const dateParts = this.commonService.getShipmentExpiryDateForBackToBack().toString().split('/');
      this.expiryDateBackToBack = new Date(dateParts[FccGlobalConstant.LENGTH_2],
        dateParts[FccGlobalConstant.LENGTH_1] - FccGlobalConstant.LENGTH_1, dateParts[FccGlobalConstant.LENGTH_0]);
      this.form.get(FccGlobalConstant.SHIPMENT_DATE_FIELD).patchValue(this.expiryDateBackToBack);
    }
    if (this.commonService.getClearBackToBackLCfields() === 'yes') {
      const fields = ['shipmentForm', 'shipmentTo', 'shipmentPlaceOfLoading', 'shipmentPlaceOfDischarge', 'shipmentPeriodText',
        'incoTermsRules', 'purchaseTermsValue', 'namedPlace'];
      fields.forEach(ele => {
        this.form.get(ele).setValue('');
        this.form.get(ele).updateValueAndValidity();
      });
    }
    if (this.form.get('incoTermsRules') && this.form.get('incoTermsRules').value && this.context !== 'view') {
       this.setPurchaseTermField();
    }
    this.form.get('namedPlace')[this.params][FccGlobalConstant.MAXLENGTH] = this.shipmentNamedPlaceLength;
    this.commonService.checkForBankName(this.stateService, this.form, FccGlobalConstant.SI_BANK_DETAILS,
      FccGlobalConstant.SI_ISSUING_BANK, FccGlobalConstant.INCO_TERMS_RULES, FccGlobalConstant.INCO_TERM_RULES_MESSAGE);
    this.updateValues();
    this.updateNarrativeCount();
  }

  updateNarrativeCount() {
    if (this.form.get('shipmentPeriodText').value) {
      const count = this.commonService.counterOfPopulatedData(this.form.get('shipmentPeriodText').value);
      this.form.get('shipmentPeriodText')[this.params][this.enteredCharCount] = count;
    }
  }

  updateValues() {
    this.onClickPartialshipmentvalue();
    this.onClickTranshipmentvalue();
    this.onClickShipmentLastDate();
    this.onBlurShipmentPeriodText();
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

  clearingFormValidators(fields: any){
    for (let i = 0; i < fields.length; i++) {
      this.form.get(fields[i]).clearValidators();
    }
  }

  ngOnDestroy() {
    this.stateService.setStateSection(FccGlobalConstant.SI_SHIPMENT_DETAILS, this.form, this.isMasterRequired);
  }

  onClickPartialshipmentvalue() {
    this.toggleValue(this.form.get('partialshipmentvalue').value, 'partialshipmentvalue');
  }

  onClickTranshipmentvalue() {
    this.toggleValue(this.form.get('transhipmentvalue').value, 'transhipmentvalue');
  }
  onClickIncoTermsRules() {
    if (this.form.get('incoTermsRules').value) {
      this.form.get('purchaseTermsValue')[this.params][this.readonly] = false;
      this.setMandatoryField(this.form, 'purchaseTermsValue', true);
      this.setPurchaseTerms();
    }
    this.removeMandatory(['purchaseTermsValue']);
  }

  setPurchaseTermField() {
    if (this.form.get('incoTermsRules').value) {
      this.form.get('purchaseTermsValue')[this.params][this.readonly] = false;
      this.setMandatoryField(this.form, 'purchaseTermsValue', true);
      this.setPurchaseTerms();
    }
  }


  onClickPurchaseTermsValue(event) {
    this.mode = this.mode = this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get('transmissionMode').value;
    const termsValue = event.value;
    if (termsValue !== undefined) {
      if (termsValue !== '') {
        this.setMandatoryField(this.form, 'namedPlace', true);
      } else if (termsValue === '') {
        this.form.get('namedPlace').reset();
        this.setMandatoryField(this.form, 'namedPlace', false);
        this.form.get('namedPlace').clearValidators();
        if (this.mode === FccBusinessConstantsService.SWIFT) {
          this.form.get('namedPlace').setValidators(Validators.pattern(this.fccGlobalConstantService.getSwiftRegexPattern()));
        }
      }
      this.form.get('namedPlace').updateValueAndValidity();
    }
    this.removeMandatory(['namedPlace']);
  }

  toggleValue(value, feildValue) {
    if (value === 'CONDITIONAL') {
      this.form.get(feildValue)[this.params][this.warning] = `${this.translationService.instant(this.warningmessage)}`;
    } else {
      this.form.get(feildValue)[this.params][this.warning] = '';
    }
  }

  onClickShipmentLastDate() {
    if (this.form.get(FccGlobalConstant.SHIPMENT_DATE_FIELD).value && this.expiryDateBackToBack &&
      this.form.get(FccGlobalConstant.SHIPMENT_DATE_FIELD).value > this.expiryDateBackToBack) {
      this.form.get(FccGlobalConstant.SHIPMENT_DATE_FIELD).setValidators([compareNewExpiryDateToOld]);
      this.form.get(FccGlobalConstant.SHIPMENT_DATE_FIELD).updateValueAndValidity();
    } else {
      this.form.get(FccGlobalConstant.SHIPMENT_DATE_FIELD).clearValidators();
      this.form.get(FccGlobalConstant.SHIPMENT_DATE_FIELD).updateValueAndValidity();
    }
    let flag = false;
    if (this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get(FccGlobalConstant.EXPIRY_TYPE_SI) &&
        this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get(FccGlobalConstant.EXPIRY_TYPE_SI).value !== '' &&
        this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get(FccGlobalConstant.EXPIRY_TYPE_SI).value !== null &&
        this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get(FccGlobalConstant.EXPIRY_TYPE_SI).value !== undefined) {
        this.expiryType = this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get('expiryType').value;
        if (this.expiryType === FccGlobalConstant.EXP_TYPE_VALUE_SPECIFIC) {
          // eslint-disable-next-line @typescript-eslint/no-unused-vars
          flag = true;
      }
    }
    const lastshipmentdate = this.form.get('shipmentLastDate').value;
    const previewScreenToggleControls = ['shipmentPeriodText'];
    if (lastshipmentdate !== null && lastshipmentdate !== '') {
      this.form.get('shipmentPeriodText')[this.params][this.readonly] = true;
      this.form.controls[this.shipmentPeriodTxt].disable();
      this.togglePreviewScreen(this.form, previewScreenToggleControls, false);
      this.form.get('shipmentLastDate')[this.params][this.warning] = `${this.translationService.instant(this.mutualExclusiveMessage)}`;
    } else if (lastshipmentdate === null || lastshipmentdate === '') {
      this.patchFieldParameters(this.form.get('shipmentPeriodText'), { readonly: false });
      this.form.controls[this.shipmentPeriodTxt].enable();
      this.form.get('shipmentPeriodText')[this.params][this.rendered] = true;
      this.form.get('shipmentLastDate')[this.params][this.warning] = FccGlobalConstant.EMPTY_STRING;
      this.togglePreviewScreen(this.form, previewScreenToggleControls, true);
    }
    if (lastshipmentdate !== null && lastshipmentdate !== '' && this.expiryDate && lastshipmentdate > this.expiryDate) {
      this.form.get('shipmentLastDate').setValidators([compareLastShipmentDate]);
      this.form.get('shipmentLastDate').updateValueAndValidity();
    } else {
      this.form.get('shipmentLastDate').clearValidators();
      this.form.get('shipmentLastDate').updateValueAndValidity();
    }
    this.form.get('shipmentPeriodText').updateValueAndValidity();
    this.form.updateValueAndValidity();
  }
  onBlurLastShipmentDate() {
    const lastshipmentdate = this.form.get('shipmentLastDate').value;
    if (lastshipmentdate !== null && lastshipmentdate !== '') {
      this.form.get('shipmentPeriodText')[this.params][this.readonly] = true;
      this.form.controls[this.shipmentPeriodTxt].disable();
      this.form.get('shipmentLastDate')[this.params][this.warning] = `${this.translationService.instant(this.mutualExclusiveMessage)}`;
    } else if (lastshipmentdate === null || lastshipmentdate === '') {
      this.patchFieldParameters(this.form.get('shipmentPeriodText'), { readonly: false });
      this.form.controls[this.shipmentPeriodTxt].enable();
      this.form.get('shipmentPeriodText')[this.params][this.rendered] = true;
      this.form.get('shipmentLastDate')[this.params][this.warning] = FccGlobalConstant.EMPTY_STRING;
    }
    if (lastshipmentdate !== null && lastshipmentdate !== '' && lastshipmentdate > this.expiryDate && this.expiryDate !== '') {
      this.form.get('shipmentLastDate').setValidators([compareLastShipmentDate]);
      this.form.get('shipmentLastDate').updateValueAndValidity();
    } else {
      this.form.get('shipmentLastDate').clearValidators();
      this.form.get('shipmentLastDate').updateValueAndValidity();
    }
    this.form.get('shipmentPeriodText').updateValueAndValidity();
  }
  onBlurShipmentPeriodText() {
    const previewScreenToggleControls = ['shipmentLastDate'];
    if (this.form.get('shipmentPeriodText')['type'] === 'highlight-texteditor' &&
    this.form.get('shipmentPeriodText').value === '\n') {
      this.form.get('shipmentPeriodText').setValue('');
      this.form.get('shipmentPeriodText').updateValueAndValidity();
    }
    const shipmentPeriod = this.form.get('shipmentPeriodText').value;
    if (shipmentPeriod !== null && shipmentPeriod !== '') {
      this.form.get('shipmentLastDate').setValue('');
      this.patchFieldParameters(this.form.get('shipmentLastDate'), { readonly: true });
      this.form.controls[this.shipmentDate].disable();
      this.togglePreviewScreen(this.form, previewScreenToggleControls, false);
      this.form.get('shipmentLastDate')[this.params][this.warning] = `${this.translationService.instant(this.mutualExclusiveMessage)}`;
    } else if (shipmentPeriod === '') {
      this.patchFieldParameters(this.form.get('shipmentLastDate'), { readonly: false });
      this.form.controls[this.shipmentDate].enable();
      this.togglePreviewScreen(this.form, previewScreenToggleControls, true);
      this.form.get('shipmentLastDate')[this.params][this.warning] = FccGlobalConstant.EMPTY_STRING;
    }
    this.form.get('shipmentLastDate').updateValueAndValidity();
    this.form.updateValueAndValidity();
  }

  initializeFormGroup() {
    this.form = this.stateService.getSectionData(this.sectionName, FccGlobalConstant.PRODUCT_SI, this.isMasterRequired);
    this.patchFieldParameters(this.form.get('incoTermsRules'), { options: this.incoTermsRules });
    this.patchFieldParameters(this.form.get('purchaseTermsValue'), { amendinfo: true });
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
    }
  }

  amendFormFields() {
    const purchaseTermsValue = this.stateService.getValue(FccGlobalConstant.SI_SHIPMENT_DETAILS, 'purchaseTermsValue', false);
    const incoTermsRules = this.stateService.getValue(FccGlobalConstant.SI_SHIPMENT_DETAILS, 'incoTermsRules', false);
    if (purchaseTermsValue !== undefined && purchaseTermsValue !== '') {
      this.setPurchaseTerms();
      const exist = this.termValues.filter(task => task.label === purchaseTermsValue);
      if (exist.length > 0) {
        this.form.get('purchaseTermsValue').setValue(this.termValues.filter(
          task => task.label === purchaseTermsValue)[0].value);
      }
    }
    if ((incoTermsRules !== undefined && incoTermsRules !== '')) {
      this.getIncotermsDetails();
      const exist = this.incoTermsRules.filter(task => task.label === incoTermsRules);
      if (exist.length > 0) {
      this.form.get('incoTermsRules').setValue(this.incoTermsRules.filter(
        task => task.label === incoTermsRules)[0].value);
      }
    }
    this.amendCommonService.setValueFromMasterToPrevious(this.sectionName);
  }

  onChangeincoTermsRules() {
    this.form.get('purchaseTermsValue').setValue('');
    this.form.get('namedPlace').setValue('');
    this.setMandatoryField(this.form, 'namedPlace', false);
    this.form.get('namedPlace').updateValueAndValidity();

  }

  removeMandatory(fields: any) {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryFields(this.form, fields, false);
    }
  }

  getIncotermsDetails() {
    this.corporateCommonService.getValues(this.fccGlobalConstantService.incotermDetails).subscribe(
      response => {
        if (response.status === FccGlobalConstant.LENGTH_200) {
          const sectionForm : FCCFormGroup = this.stateService.getSectionData(FccGlobalConstant.SI_BANK_DETAILS);
          const sectionForm2 : FCCFormGroup = sectionForm.get(FccGlobalConstant.SI_ISSUING_BANK) as FCCFormGroup;
          let bankName;
          if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
            bankName = sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS] ?
                sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS][0].value :
                sectionForm2.get('bankNameList').value;
          } else {
            bankName = sectionForm2.get('bankNameList').value;
          }
          if (bankName !== undefined || bankName !== '') {
            this.handleIncoTerms(response, bankName);
          }
        }
      });
  }

  protected handleIncoTerms(response: any, bankName: any) {
    this.incotermsDetails = response.body.incotermDetailsList;
    if (this.incotermsDetails !== undefined && this.incotermsDetails.length > 0) {
      for (const i of this.incotermsDetails) {
        const respBank = i.bankName;
        if (bankName === respBank) {
          const largeParamKeyListarr = i.largeParamKeyList;
          for (const j of largeParamKeyListarr) {
            const incoRules = j.incotermsRules;
            this.incoTermsRules.push({ label: incoRules, value: incoRules });
          }
        }
      }
    }
  }

  setPurchaseTerms() {
    const incotermValue = this.form.get('incoTermsRules').value;
    const sectionForm : FCCFormGroup = this.stateService.getSectionData(FccGlobalConstant.SI_BANK_DETAILS);
    const sectionForm2: FCCFormGroup = sectionForm.get(FccGlobalConstant.SI_ISSUING_BANK) as FCCFormGroup;
    let bankName;
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      bankName = sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS] ?
                sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS][0].value :
                sectionForm2.get('bankNameList').value;
    } else {
      bankName = sectionForm2.get('bankNameList').value;
    }
    if (bankName !== undefined && bankName !== '' && this.incotermsDetails !== undefined && this.incotermsDetails.length > 0) {
      for (let i = 0; i < this.incotermsDetails.length; i++) {
        const respBank = this.incotermsDetails[i].bankName;
        this.checkBankName(bankName, respBank, i, incotermValue);
      }
    }
    this.patchFieldParameters(this.form.get('purchaseTermsValue'), { options: this.termValues });
  }


  protected checkBankName(bankName: any, respBank: any, i: number, incotermValue: any) {
    if (bankName === respBank) {
      const largeParamKeyListarr = this.incotermsDetails[i].largeParamKeyList;
      for (let j = 0; j < largeParamKeyListarr.length; j++) {
        const incoRules = largeParamKeyListarr[j].incotermsRules;
        if (incotermValue === incoRules) {
          this.termValues = [];
          const incoparams = largeParamKeyListarr[j].incotermValues;
          for (let k = 0; k < incoparams.length; k++) {
            this.termValues.push({ label: `${this.translationService.instant(incoparams[k])}`, value: incoparams[k] });
          }

        }
      }
    }
  }
}
