import { Component, OnDestroy, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef, SelectItem } from 'primeng';
import { FCCFormGroup } from '../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from '../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstantService } from '../../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../../common/core/fcc-global-constants';
import { CommonService } from '../../../../../../common/services/common.service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { AmendCommonService } from '../../../../../common/services/amend-common.service';
import { LeftSectionService } from '../../../../../common/services/leftSection.service';
import { LcConstant } from '../../../common/model/constant';
import { ProductStateService } from '../../../common/services/product-state.service';
import { CurrencyConverterPipe } from '../../pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../services/filelist.service';
import { FormControlService } from '../../services/form-control.service';
import { LcReturnService } from '../../services/lc-return.service';
import { PrevNextService } from '../../services/prev-next.service';
import { UtilityService } from '../../services/utility.service';
import { compareLastShipmentDate, compareNewExpiryDateToOld } from '../../validator/ValidateLastShipDate';
import { EventEmitterService } from './../../../../../../common/services/event-emitter-service';
import { FormModelService } from './../../../../../../common/services/form-model.service';
import { LcTemplateService } from './../../../../../../common/services/lc-template.service';
import { CorporateCommonService } from './../../../../../../corporate/common/services/common.service';
import { ImportLetterOfCreditResponse } from './../../model/importLetterOfCreditResponse';
import { LcProductComponent } from './../lc-product/lc-product.component';
import { LcProductService } from '../../../services/lc-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
@Component({
  selector: 'fcc-trade-app-shipmentdetails',
  templateUrl: './shipmentdetails.component.html',
  styleUrls: ['./shipmentdetails.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: ShipmentdetailsComponent }]
})
export class ShipmentdetailsComponent extends LcProductComponent implements OnInit, OnDestroy {
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
  mutualExclusiveMessage = 'mutualExclusiveMessage';
  label = 'label';
  readonly = 'readonly';
  previewScreen = 'previewScreen';
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
  option;
  incotermsDetails: any;
  sectionName = 'shipmentDetails';
  shipmentNamedPlaceLength;
  shipmentDate = 'shipmentLastDate';
  shipmentPeriodTxt = 'shipmentPeriodText';
  isMasterRequired: any;
  enquiryRegex;
  mode: any;
  fieldNames = [];
  regexType: string;
  swiftZchar;
  productCode: any;
  constructor(protected router: Router, protected translationService: TranslateService, protected lcReturnService: LcReturnService,
              protected leftSectionService: LeftSectionService, protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService, protected prevNextService: PrevNextService,
              protected lcTemplateService: LcTemplateService, protected resolverService: ResolverService,
              protected formModelService: FormModelService, protected formControlService: FormControlService,
              protected commonService: CommonService, protected stateService: ProductStateService,
              protected emitterService: EventEmitterService, protected corporateCommonService: CorporateCommonService,
              protected fccGlobalConstantService: FccGlobalConstantService, protected amendCommonService: AmendCommonService,
              protected confirmationService: ConfirmationService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected fileList: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected lcProductService: LcProductService
  ) {
    super(emitterService, stateService, commonService, translationService, confirmationService, customCommasInCurrenciesPipe,
          searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, lcProductService);
    this.module = `${this.translationService.instant('shipmentDetails')}`;
  }

  ngOnInit() {
    this.isMasterRequired = this.isMasterRequired;
    this.mode = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('transmissionMode').value;
    this.productCode = this.commonService.getQueryParametersFromKey (FccGlobalConstant.PRODUCT);
    this.getIncotermsDetails();
    super.ngOnInit();
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    window.scroll(0, 0);
    this.initializeFormGroup();
    this.expiryDate = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('expiryDate').value;
    this.form.get('purchaseTermsValue')[this.params][this.readonly] = this.form.get('incoTermsRules').value ? false : true;
    this.patchLayoutForReadOnlyMode();
    this.fieldNames = ['shipmentForm', 'shipmentTo',
    'shipmentPlaceOfLoading', 'shipmentPlaceOfDischarge', 'shipmentPeriodText'];
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.shipmentNamedPlaceLength = response.shipmentNamedPlaceLength;
        this.enquiryRegex = response.swiftXCharacterSet;
        this.swiftZchar = response.swiftZChar;
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
    if (this.mode === FccBusinessConstantsService.SWIFT){
      this.form.addFCCValidators('namedPlace', Validators.pattern(this.fccGlobalConstantService.getSwiftRegexPattern()), 0);
    }
    this.commonService.checkForBankName(this.stateService, this.form, FccGlobalConstant.BANK_DETAILS,
      FccGlobalConstant.LC_ISSUING_BANK, FccGlobalConstant.INCO_TERMS_RULES, FccGlobalConstant.INCO_TERM_RULES_MESSAGE);
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

  ngOnDestroy() {
    this.setNamedPlaceField();
    this.stateService.setStateSection(FccGlobalConstant.SHIPMENT_DETAILS, this.form, this.isMasterRequired);
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
    if (this.form.get('purchaseTermsValue').value) {
      this.setNamedPlaceField();
    }
    if (this.form.get('purchaseTermsValue').value === '') {
      this.form.get('namedPlace').reset();
      this.form.get('namedPlace').clearValidators();
      this.form.get('namedPlace').setErrors({ required: false });
      this.form.get('namedPlace')[this.params][FccGlobalConstant.REQUIRED] = false;
      this.form.get('namedPlace').updateValueAndValidity();
    }
  }

  setNamedPlaceField() {
    if (this.form.get('purchaseTermsValue').value !== undefined && this.form.get('purchaseTermsValue').value !== '') {
      if ((this.form.get('namedPlace').value === '' || this.form.get('namedPlace').value === null)
      && this.form.get('namedPlace').value !== undefined) {
        if (this.option !== FccGlobalConstant.TEMPLATE) {
          this.form.get('namedPlace')[this.params][FccGlobalConstant.REQUIRED] = true;
          this.form.get('namedPlace').setValidators([Validators.required]);
          this.form.get('namedPlace').setErrors({ required: true });
        }
        this.form.get('namedPlace').markAsDirty();
        this.form.get('namedPlace').markAsTouched();
        this.form.get('namedPlace').updateValueAndValidity();
        if (this.mode === FccBusinessConstantsService.SWIFT){
          this.form.get('namedPlace').setValidators([Validators.pattern(this.fccGlobalConstantService.getSwiftRegexPattern())]);
        }
      }

    }
  }


  onClickPurchaseTermsValue(event) {
    const termsValue = event.value;
    if (termsValue !== undefined) {
      if (termsValue !== '') {
        if (this.option !== FccGlobalConstant.TEMPLATE) {
          this.form.get('namedPlace')[this.params][FccGlobalConstant.REQUIRED] = true;
          this.form.get('namedPlace').setValidators([Validators.required]);
          this.form.get('namedPlace').setErrors({ required: true });
        }
        this.form.get('namedPlace').markAsDirty();
        this.form.get('namedPlace').markAsTouched();
        this.form.get('namedPlace').updateValueAndValidity();
        if (this.mode === FccBusinessConstantsService.SWIFT){
          this.form.get('namedPlace').setValidators([Validators.pattern(this.fccGlobalConstantService.getSwiftRegexPattern())]);
        }
      } else if (termsValue === '') {
        this.form.get('namedPlace').reset();
        this.form.get('namedPlace').clearValidators();
        this.form.get('namedPlace').setErrors({ required: false });
        this.form.get('namedPlace')[this.params][FccGlobalConstant.REQUIRED] = false;
      }
      this.form.get('namedPlace').updateValueAndValidity();
    } else {
      this.form.get('namedPlace').clearValidators();
      this.form.get('namedPlace').setErrors({ required: false });
      this.form.get('namedPlace')[this.params][FccGlobalConstant.REQUIRED] = false;
      this.form.get('namedPlace').updateValueAndValidity();
    }
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
    const lastshipmentdate = this.form.get('shipmentLastDate').value;
    const previewScreenToggleControls = ['shipmentPeriodText'];
    if (lastshipmentdate !== null && lastshipmentdate !== '') {
      this.form.get('shipmentPeriodText')[this.params][this.readonly] = true;
      this.form.controls[this.shipmentPeriodTxt].disable();
      this.form.get('shipmentLastDate')[this.params][this.warning] = `${this.translationService.instant(this.mutualExclusiveMessage)}`;
      this.togglePreviewScreen(this.form, previewScreenToggleControls, false);
    } else if (lastshipmentdate === null || lastshipmentdate === '') {
      this.patchFieldParameters(this.form.get('shipmentPeriodText'), { readonly: false });
      this.form.controls[this.shipmentPeriodTxt].enable();
      this.form.get('shipmentPeriodText')[this.params][this.rendered] = true;
      this.form.get('shipmentLastDate')[this.params][this.warning] = FccGlobalConstant.EMPTY_STRING;
      this.togglePreviewScreen(this.form, previewScreenToggleControls, true);
    }
    if (lastshipmentdate !== null && lastshipmentdate !== '' && this.expiryDate !== '' && lastshipmentdate > this.expiryDate) {
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
    const previewScreenToggleControls = ['shipmentPeriodText'];
    if (lastshipmentdate !== null && lastshipmentdate !== '') {
      this.form.get('shipmentPeriodText')[this.params][this.readonly] = true;
      this.form.controls[this.shipmentPeriodTxt].disable();
      this.form.get('shipmentLastDate')[this.params][this.warning] = `${this.translationService.instant(this.mutualExclusiveMessage)}`;
      this.togglePreviewScreen(this.form, previewScreenToggleControls, false);
    } else if (lastshipmentdate === null || lastshipmentdate === '') {
      this.patchFieldParameters(this.form.get('shipmentPeriodText'), { readonly: false });
      this.form.controls[this.shipmentPeriodTxt].enable();
      this.form.get('shipmentPeriodText')[this.params][this.rendered] = true;
      this.togglePreviewScreen(this.form, previewScreenToggleControls, true);
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
    this.form.updateValueAndValidity();
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
    this.form = this.stateService.getSectionData(this.sectionName, FccGlobalConstant.PRODUCT_LC, this.isMasterRequired);
    this.patchFieldParameters(this.form.get('incoTermsRules'), { options: this.incoTermsRules });
    this.patchFieldParameters(this.form.get('purchaseTermsValue'), { amendinfo: true });
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
    }
  }

  amendFormFields() {
    const purchaseTermsValue = this.stateService.getValue('shipmentDetails', 'purchaseTermsValue', false);
    const incoTermsRules = this.stateService.getValue('shipmentDetails', 'incoTermsRules', false);
    if (purchaseTermsValue !== undefined && purchaseTermsValue !== '') {
      this.setPurchaseTerms();
      const exist = this.termValues.filter(task => task.label === purchaseTermsValue);
      if (exist.length > 0) {
        this.form.get('purchaseTermsValue').setValue(this.termValues.filter(
          task => task.label === purchaseTermsValue)[0].value);
      }
    }
    if ((incoTermsRules !== undefined && incoTermsRules !== '')) {
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
          const sectionForm : FCCFormGroup= this.stateService.getSectionData(FccGlobalConstant.BANK_DETAILS);
          const sectionForm2 : FCCFormGroup = sectionForm.get('issuingBank') as FCCFormGroup;
          let bankName;
          if (this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE) === FccGlobalConstant.N002_AMEND) {
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
    const sectionForm : FCCFormGroup = this.stateService.getSectionData(FccGlobalConstant.BANK_DETAILS);
    const sectionForm2 : FCCFormGroup = sectionForm.get('issuingBank') as FCCFormGroup;
    let bankName;
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      bankName = sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS] ?
                sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS][0].value :
                sectionForm2.get('bankNameList').value;
    } else {
      bankName = sectionForm2.get('bankNameList').value;
    }
    if (bankName !== undefined || bankName !== '') {
      if (this.incotermsDetails !== undefined && this.incotermsDetails.length > 0) {
      for (let i = 0; i < this.incotermsDetails.length; i++) {
        const respBank = this.incotermsDetails[i].bankName;
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
    }
    this.patchFieldParameters(this.form.get('purchaseTermsValue'), { options: this.termValues });
  }
  clearingFormValidators(fields: any){
    for (let i = 0; i < fields.length; i++) {
      this.form.get(fields[i]).clearValidators();
    }
  }

}
