import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { LcProductService } from '../../../../services/lc-product.service';
import { PhrasesService } from '../../../../../../../common/services/phrases.service';
import { ResolverService } from '../../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../../common/services/search-layout.service';
import { LcConstant } from '../../../../common/model/constant';
import { CurrencyConverterPipe } from '../../../pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../../pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../services/filelist.service';
import { LcProductComponent } from '../../lc-product/lc-product.component';
import { FCCFormGroup } from './../../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from './../../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstantService } from './../../../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../../../../../../common/core/fcc-global-constants';
import { CommonService } from './../../../../../../../common/services/common.service';
import { EventEmitterService } from './../../../../../../../common/services/event-emitter-service';
import { ProductStateService } from './../../../../common/services/product-state.service';
import { FormControlService } from './../../../services/form-control.service';
import { NarrativeService } from './../../../services/narrative.service';
import { UtilityService } from './../../../services/utility.service';
import { HOST_COMPONENT } from './../../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-special-payment-for-beneficiary',
  templateUrl: './special-payment-for-beneficiary.component.html',
  styleUrls: ['./special-payment-for-beneficiary.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: SpecialPaymentForBeneficiaryComponent }]
})
export class SpecialPaymentForBeneficiaryComponent extends LcProductComponent implements OnInit, OnDestroy {

  form: FCCFormGroup;
  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  lcConstant = new LcConstant();
  module = '';
  element = 'splPaymentBeneText';
  swiftZCharRegex: string;
  swiftExtendedNarrativeEnable: boolean;
  mode: any;
  paramDataList: any[] = [];
  modeOfTransmission;
  splBeneRowCount: number;
  maxLength = this.lcConstant.maximumlength;
  maxRowCount = this.lcConstant.maxRowCount;
  enteredCharCount = this.lcConstant.enteredCharCounts;
  allowedCharCount = this.lcConstant.allowedCharCount;
  params = this.lcConstant.params;
  swift = 'swift';
  totalCharCount;
  totalNarrativeCount;
  goodAndDocsCount;
  splPaymentBenecounter = this.lcConstant.zero;
  openAllSvg = 'openAllSvg';
  closeAllSvg = 'closeAllSvg';
  openAllSvgPath: any;
  closeAllSvgPath: any;
  contextPath: any;
  tnxTypeCode: any;
  mandatoryFields: any[];
  readonly = this.lcConstant.readonly;
  phrasesResponseForSpclPaymnt: any;
  displayValue: string;
  finalTextValue = '';
  entityName: any;
  responseData: string;
  amendEditSection = 'otherDetails';
  amendEditsubSection = 'specialPaymentNarrativeBene';
  amendEditTextAreaKey = 'splPaymentBeneAmendEditTextArea';
  repAllTextAreaKey = 'splPaymentBeneAmendEditTextArea0';
  textAreaCount;
  textAreaCreated = false;
  splBeneLen;
  constructor(protected emitterService: EventEmitterService, protected stateService: ProductStateService,
              protected formControlService: FormControlService, protected commonService: CommonService,
              protected fccBusinessConstantsService: FccBusinessConstantsService,
              protected utilityService: UtilityService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected narrativeService: NarrativeService, protected resolverService: ResolverService,
              protected fccGlobalConstantService: FccGlobalConstantService, protected translateService: TranslateService,
              protected searchLayoutService: SearchLayoutService, protected phrasesService: PhrasesService,
              protected confirmationService: ConfirmationService, protected fileList: FilelistService,
              protected dialogRef: DynamicDialogRef, protected currencyConverterPipe: CurrencyConverterPipe,
              protected lcProductService: LcProductService
    ) {
    super(emitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
      searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, lcProductService);
   }

  ngOnInit(): void {
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.openAllSvgPath = this.contextPath + '/content/FCCUI/assets/icons/expandAll.svg';
    this.closeAllSvgPath = this.contextPath + '/content/FCCUI/assets/icons/collapseAll.svg';
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    const obj = this.parentForm.controls[this.controlName];
    if (obj !== null) {
        this.form = obj as FCCFormGroup;
    }
    this.modeOfTransmission = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('transmissionMode').value;
    this.configAndValidations();
    if (!this.swiftExtendedNarrativeEnable) {
      const currentCount = this.form.get(this.element)[this.params][this.enteredCharCount];
      this.narrativeService.specialBeneSubject.next(currentCount);
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.get(this.element)[this.params][FccGlobalConstant.PHRASE_ENABLED] = true;
    } else {
      this.form.get(this.element)[this.params][FccGlobalConstant.PHRASE_ENABLED] = false;
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.updateMasterData();
      this.amendFormFields();
      this.configAndValidationsAmend();
      if (!this.textAreaCreated){
        if (this.mode === FccGlobalConstant.DRAFT_OPTION)
        {
          this.textAreaCount = this.splPaymentBenecounter;
        }
        else {
          this.textAreaCount = 0;
        }
        this.textAreaCreated = true;
      }
    }
  }

updateMasterData() {
  this.narrativeService.updateMasterData(this.form, this.element, 'masterSplBene');

  }
  onKeyupSplPaymentBeneText() {
    const currentCount = this.form.get(this.element)[this.params][this.enteredCharCount];
    this.narrativeService.specialBeneSubject.next(currentCount);
    this.totalCountValidation();
  }

  onFocusSplPaymentBeneText() {
    this.totalCountValidation();
  }

  totalCountValidation() {
    const totalCount = (this.narrativeService.goodAndDocsCount === undefined ? 0 : this.narrativeService.goodAndDocsCount) +
                        (this.narrativeService.documentReqCount === undefined ? 0 : this.narrativeService.documentReqCount) +
                        (this.narrativeService.additionalInfoCount === undefined ? 0 : this.narrativeService.additionalInfoCount) +
                        (this.narrativeService.specialBeneCount === undefined ? 0 : this.narrativeService.specialBeneCount);
    if (totalCount > this.narrativeService.getNarrativeTotalSwiftCharLength()) {
      this.form.get(this.element).setErrors({ maxSizeExceeds: { maxSize: this.narrativeService.getNarrativeTotalSwiftCharLength() } });
    }
  }

  onKeyupSplPaymentBeneAmendEditTextArea(event, key) {
    const data = this.form.get(key).value;
    const checkForValue = this.commonService.isNonEmptyValue(data) ? data.replace( /[\r\n]+/gm, '' ) : '';
    if (checkForValue === '') {
      this.form.get(key).setValue(null);
      this.form.get(key).setErrors({ invalid: true });
      this.form.get(key).updateValueAndValidity();
    } else {
      this.form.get(key).setErrors({ invalid: false });
      this.form.get(key).updateValueAndValidity();
      this.narrativeService.limitCharacterCountPerLine(key, this.form);
    }

    this.totalNarrativeCount = this.narrativeService.getTotalAmendNarrativeCount(
      this.amendEditSection,
      this.amendEditsubSection,
      this.form,
      this.amendEditTextAreaKey,
      this.splPaymentBenecounter
    );

    this.narrativeService.specialBeneSubjectAmend.next(this.totalNarrativeCount);
    this.narrativeService.totalCountValidationAmend(key, this.form, this.totalNarrativeCount, this.stateService, this.splBeneLen);
  }

  onFocusSplPaymentBeneAmendEditTextArea(event, key) {
    this.narrativeService.totalCountValidationAmend(key, this.form, this.totalNarrativeCount, this.stateService, this.splBeneLen);
  }

  configAndValidations() {
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.swiftZCharRegex = response.swiftZChar;
        this.swiftExtendedNarrativeEnable = response.swiftExtendedNarrativeEnable;
        if (this.modeOfTransmission === FccBusinessConstantsService.SWIFT) {
          this.form.addFCCValidators(this.element, Validators.pattern(this.swiftZCharRegex), 0);
          this.swiftModeTransmission();
          this.form.get(this.element).updateValueAndValidity();
          if (!this.swiftExtendedNarrativeEnable && this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
            this.commonService.getParameterConfiguredValues(FccGlobalConstant.PRODUCT_LC,
              FccGlobalConstant.PARAMETER_P940).subscribe(responseData => {
                if (responseData) {
                  this.paramDataList = responseData.paramDataList;
                  this.parameterList();
                  this.splBeneLen = this.splBeneRowCount * FccGlobalConstant.LENGTH_65;
                  this.form.get(this.element)[this.params][this.maxLength] =
                  (this.splBeneLen + (this.splBeneRowCount - FccGlobalConstant.LENGTH_1));
                  this.form.get(this.element)[this.params][this.allowedCharCount] = this.splBeneLen;
                  this.form.get(this.element)[this.params][this.maxRowCount] = this.splBeneRowCount;
                }
              });
          }
        } else {
          this.texelCourierModeTransmission();
        }
      }
    });
  }

  configAndValidationsAmend() {
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.swiftZCharRegex = response.swiftZChar;
        this.swiftExtendedNarrativeEnable = response.swiftExtendedNarrativeEnable;
        if (this.modeOfTransmission[0] && this.modeOfTransmission[0].value === FccBusinessConstantsService.SWIFT) {
          this.totalNarrativeCount = this.narrativeService.getTotalAmendNarrativeCount(
            this.amendEditSection,
            this.amendEditsubSection,
            this.form,
            this.amendEditTextAreaKey,
            this.splPaymentBenecounter
          );

          this.narrativeService.specialBeneSubjectAmend.next(this.totalNarrativeCount);
          for ( let i = 0; i < this.totalNarrativeCount ; i++){
            const tempAmendEditTextArea = this.amendEditTextAreaKey.concat(i.toString());
            this.form.addFCCValidators( tempAmendEditTextArea, Validators.pattern(this.swiftZCharRegex), 0);
            this.form.get(tempAmendEditTextArea).updateValueAndValidity();
            this.form.get(tempAmendEditTextArea)[this.params][this.swift] = true;
            this.narrativeService.swiftModeTransmissionAmend(
              this.form,
              tempAmendEditTextArea,
              this.stateService,
              this.totalNarrativeCount,
              this.splBeneLen
            );

          }
          this.form.get(this.element).updateValueAndValidity();
          if (this.modeOfTransmission[0] && this.modeOfTransmission[0].value === FccBusinessConstantsService.SWIFT) {
          this.form.addFCCValidators(this.element, Validators.pattern(this.swiftZCharRegex), 0);
          }
          if (!this.swiftExtendedNarrativeEnable) {
            this.commonService.getParameterConfiguredValues(FccGlobalConstant.PRODUCT_LC,
              FccGlobalConstant.PARAMETER_P940).subscribe(responseData => {
                if (responseData) {
                  this.paramDataList = responseData.paramDataList;
                  this.parameterList();
                  this.splBeneLen = this.splBeneRowCount * FccGlobalConstant.LENGTH_65;
                //  this.narrativeService.validateMaxLengthAmend(maxLength, this.totalNarrativeCount, this.form, this.element);
                }
              });
          }
        } else {
          this.texelCourierModeTransmission();
        }
      }
    });
  }

  parameterList() {
    if (this.paramDataList !== null) {
      this.paramDataList.forEach(element => {
        if (element.data_2 === this.lcConstant.splPay) {
          this.splBeneRowCount = Number(element.data_1);
        }
      });
      if (this.splBeneRowCount === undefined || this.splBeneRowCount === null) {
        this.splBeneRowCount = FccGlobalConstant.LENGTH_100;
      }
    }
  }

  texelCourierModeTransmission() {
    this.form.get(this.element).setValidators([]);
    this.form.get(this.element).updateValueAndValidity();
    this.form.get(this.element)[this.params][this.swift] = true;
    this.form.get(this.element)[this.params][this.maxRowCount] = FccGlobalConstant.LENGTH_800;
    this.form.get(this.element)[this.params][this.allowedCharCount] = this.narrativeService.getNarrativeSwiftCharLength();
    this.form.get(this.element)[this.params][this.maxLength] =
    this.narrativeService.getNarrativeSwiftCharLength() + (FccGlobalConstant.LENGTH_800 - FccGlobalConstant.LENGTH_1);
  }

  swiftModeTransmission() {
    if (this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
    this.form.get(this.element).updateValueAndValidity();
    this.form.get(this.element)[this.params][this.swift] = true;
    this.form.get(this.element)[this.params][this.maxRowCount] = FccGlobalConstant.LENGTH_800;
    this.form.get(this.element)[this.params][this.allowedCharCount] = this.narrativeService.getNarrativeSwiftCharLength();
    this.form.get(this.element)[this.params][this.maxLength] =
    this.narrativeService.getNarrativeSwiftCharLength() + (FccGlobalConstant.LENGTH_800 - FccGlobalConstant.LENGTH_1);
    }
  }

  amendHistoryHeaderJsonObject(field): any {
    const obj = {};
    const nameStr = 'name';
    const typeStr = 'type';
    const renderedStr = 'rendered';
    const layoutClassStr = 'layoutClass';
    const styleClassStr = 'styleClass';
    const previewScreenStr = 'previewScreen';
    obj[nameStr] = field.key ;
    obj[typeStr] = field.type;
    obj[renderedStr] = field.params.rendered;
    obj[layoutClassStr] = field.params.layoutClass;
    obj[styleClassStr] = field.params.styleClass;
    obj[previewScreenStr] = field.params.previewScreen;
    return obj;
  }

  onClickSplPaymentBeneAmendOptions(obj: any) {
    if (this.mode === FccGlobalConstant.DRAFT_OPTION) {
      this.splPaymentBenecounter = this.commonService.amendDescofGooodsCounter;
      if (this.commonService.isNonEmptyValue(this.form.get(this.amendEditTextAreaKey).value) &&
        Array.isArray(this.form.get(this.amendEditTextAreaKey).value.items) &&
        (this.form.get(this.amendEditTextAreaKey).value.items.length > 0))
      {
         this.splPaymentBenecounter++;
      }
      else {
         this.splPaymentBenecounter = 0;
      }
      this.commonService.amendDescofGooodsCounter = this.splPaymentBenecounter;
    }
    const fieldObj1 = this.amendHistoryHeaderJsonObject(this.form.get('splPaymentBeneAmendHistoryHeader'));
    this.form.removeControl('splPaymentBeneAmendHistoryHeader');
    const fieldObj2 = this.narrativeService.narrativeExpansionPanelJsonObject(
      this.form.get('splPaymentBeneAmendmentPanel'));
    this.form.removeControl('splPaymentBeneAmendmentPanel');
    const fieldObj = this.narrativeService.amendNarrativeTextAreaJsonObject(
      this.form.get(this.amendEditTextAreaKey));
    let newKeyName = this.amendEditTextAreaKey + this.splPaymentBenecounter;
    this.form.addControl(newKeyName, this.formControlService.getControl(fieldObj));
    this.form.get(newKeyName)[FccGlobalConstant.KEY] = newKeyName;
    this.form.get(newKeyName)[this.params][FccGlobalConstant.RENDERED] = true;
    this.form.get(newKeyName)[this.params][FccGlobalConstant.PREVIEW_SCREEN] = false;
    this.splPaymentBenecounter++;
    const count = this.splPaymentBenecounter;
    let newCount;
    for (let i = this.splPaymentBenecounter - 1; i >= 0 ; i--) {
      let newName = this.amendEditTextAreaKey + i;
      if (i > 0) {
        const newKeyFinal = this.narrativeService.getFinalNewKeyName(this.form, this.amendEditTextAreaKey, i, fieldObj, newName);
        if (this.commonService.isNonEmptyValue(newKeyFinal)) {
          newName = newKeyFinal;
          this.splPaymentBenecounter--;
          newCount = this.splPaymentBenecounter;
        }
      }
      const narrativefieldObj = this.narrativeService.amendNarrativeTextAreaJsonObject(this.form.get(newName));
      const newControlVal = this.form.get(newName).value;
      this.form.removeControl(newName);
      this.form.addControl(newName, this.formControlService.getControl(narrativefieldObj));
      if (this.modeOfTransmission[0] && this.modeOfTransmission[0].value === FccBusinessConstantsService.SWIFT) {
        this.form.addFCCValidators(newName, Validators.pattern(this.swiftZCharRegex), 0);
      }
      this.form.get(newName)[FccGlobalConstant.KEY] = newName;
      this.form.get(newName)[FccGlobalConstant.VALUE] = newControlVal;
    }
    if (count !== this.splPaymentBenecounter) {
      newKeyName = this.amendEditTextAreaKey + (newCount - 1);
      this.form.addControl(newKeyName, this.formControlService.getControl(fieldObj));
      this.form.get(newKeyName)[FccGlobalConstant.KEY] = newKeyName;
      this.form.get(newKeyName)[this.params][FccGlobalConstant.RENDERED] = true;
      this.form.get(newKeyName)[this.params][FccGlobalConstant.PREVIEW_SCREEN] = false;
    }
    this.form.addControl('splPaymentBeneAmendHistoryHeader', this.formControlService.getControl(fieldObj1));
    this.form.addControl('splPaymentBeneAmendmentPanel', this.formControlService.getControl(fieldObj2));
    this.form.get('splPaymentBeneAmendmentPanel').patchValue(fieldObj2[FccGlobalConstant.VALUE]);

    if (obj.value === 'amendAdd') {
      this.form.get(newKeyName)[this.params][FccGlobalConstant.START] = 'Add';
    } else {
      this.form.get(newKeyName)[this.params][FccGlobalConstant.START] = 'Delete';
    }
    this.textAreaCount++;
    this.narrativeService.totalCountValidationAmend(newKeyName, this.form, this.totalNarrativeCount, this.stateService, this.splBeneLen);
  }

  onBlurSplPaymentBeneAmendEditTextArea(event, key) {
    const strResult = event.srcElement.value ? event.srcElement.value : event.srcElement.innerText;
    if ((this.form.get('splPaymentBeneRepAll').value === 'N') && (key !== null || key !== undefined)) {
      this.form.get(key).setValue(strResult);
    } else {
      this.form.get(this.repAllTextAreaKey).setValue(strResult);
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.patchFieldParameters(this.form.get(this.element), { isNarrativeAmended: false });
      for (let i = 0; i < this.splPaymentBenecounter; i++) {
        const narrativeTextValue = this.form.get('splPaymentBeneAmendEditTextArea' + i).value;
        if (narrativeTextValue !== '') {
          this.patchFieldParameters(this.form.get(this.element), { isNarrativeAmended: true });
          break;
        }
      }
    }
    this.narrativeService.totalCountValidationAmend(key, this.form, this.totalNarrativeCount, this.stateService,
      this.splBeneLen);
  }

  onClickSplPaymentBeneAmendEditTextArea(event, key) {
    this.patchFieldParameters(this.form.get(this.element), { isNarrativeAmended: false });
    this.form.removeControl(key);
    this.totalNarrativeCount = this.narrativeService.getTotalAmendNarrativeCount(
      this.amendEditSection,
      this.amendEditsubSection,
      this.form,
      this.amendEditTextAreaKey,
      this.splPaymentBenecounter
    );

    this.narrativeService.specialBeneSubjectAmend.next(this.totalNarrativeCount);
    this.splPaymentBenecounter--;
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      for (let i = 0; i < this.splPaymentBenecounter; i++) {
        if (this.form.get('splPaymentBeneAmendEditTextArea' + i) !== null &&
        this.form.get('splPaymentBeneAmendEditTextArea' + i) !== undefined) {
        const narrativeTextValue = this.form.get('splPaymentBeneAmendEditTextArea' + i).value;
        if (narrativeTextValue !== '') {
          this.patchFieldParameters(this.form.get(this.element), { isNarrativeAmended: true });
          break;
        }
      }
      }
    }
    this.form.get(FccGlobalConstant.NAR_TAB_CONTROL_SPL_PAY_BENE_AMD_OPT).setValue(null);
    this.narrativeService.totalCountValidationAmend(key, this.form, this.totalNarrativeCount, this.stateService, this.splBeneLen);
  }

  onClickSplPaymentBeneRepAll() {
    if (this.form.get('splPaymentBeneRepAll').value === 'Y') {
      for (let i = 0 ; i < this.textAreaCount ; i++) {
        if (this.form.get(this.amendEditTextAreaKey + i)) {
        this.onClickSplPaymentBeneAmendEditTextArea(null, this.amendEditTextAreaKey + i);
        }
        this.splPaymentBenecounter++;
      }
      this.textAreaCount = 0;
      this.splPaymentBenecounter = 0;
      const fieldObj1 = this.amendHistoryHeaderJsonObject(this.form.get('splPaymentBeneAmendHistoryHeader'));
      this.form.removeControl('splPaymentBeneAmendHistoryHeader');
      const fieldObj2 = this.narrativeService.narrativeExpansionPanelJsonObject(
        this.form.get('splPaymentBeneAmendmentPanel'));
      this.form.removeControl('splPaymentBeneAmendmentPanel');
      this.form.get('splPaymentBeneAmendOptions')[this.params][FccGlobalConstant.RENDERED] = false;
      this.form.get(this.amendEditTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = false;
      this.form.get(this.amendEditTextAreaKey).setValue(null);
      const fieldObj = this.narrativeService.amendNarrativeTextAreaJsonObject(
        this.form.get(this.amendEditTextAreaKey));
      this.form.addControl(this.repAllTextAreaKey, this.formControlService.getControl(fieldObj));
      this.form.get(this.repAllTextAreaKey)[FccGlobalConstant.KEY] = this.repAllTextAreaKey;
      this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = true;
      this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.PREVIEW_SCREEN] = false;
      this.form.addControl('splPaymentBeneAmendHistoryHeader', this.formControlService.getControl(fieldObj1));
      this.form.addControl('splPaymentBeneAmendmentPanel', this.formControlService.getControl(fieldObj2));
      this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.START] = 'Repall';
      if (this.modeOfTransmission[0] && this.modeOfTransmission[0].value === FccBusinessConstantsService.SWIFT) {
      this.form.addFCCValidators(this.repAllTextAreaKey, Validators.pattern(this.swiftZCharRegex), 0);
      }
      this.splPaymentBenecounter++;
    } else {
      this.setValuesForRepallNo();
    }
  }

  amendFormFields() {
    this.form.get(this.element)[this.params][this.swift] = true;
    this.form.get(this.element)[this.params][this.readonly] = true;
    this.form.get(this.element)[FccGlobalConstant.PARAMS][FccGlobalConstant.ROWS] = FccGlobalConstant.LENGTH_4;
    if (this.form.get('splPaymentBeneAmendmentPanel')[this.params]) {
      this.form.get('splPaymentBeneAmendmentPanel')[this.params][this.openAllSvg] = this.openAllSvgPath;
      this.form.get('splPaymentBeneAmendmentPanel')[this.params][this.closeAllSvg] = this.closeAllSvgPath;
    }
    this.mandatoryFields = [this.element];
    this.setMandatoryFields(this.form, this.mandatoryFields, false);
    this.form.get(this.element).updateValueAndValidity();
    if (this.form.get(this.amendEditTextAreaKey).value && this.form.get(this.amendEditTextAreaKey).value.items) {
      this.splPaymentBenecounter = this.form.get(this.amendEditTextAreaKey).value.items.length;
    }
    this.form.get('splPaymentBeneRepAll')[this.params][FccGlobalConstant.PREVIOUSCOMPAREVALUE] = undefined;
  }

  ngOnDestroy() {
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND && this.splPaymentBenecounter > this.lcConstant.zero) {
      const arraySet: {items: any} = {
        items: []
      };
      this.form.get(this.amendEditTextAreaKey).setValue(arraySet);
      let tempCounter = 0;
      for (let i = 0; i < this.splPaymentBenecounter; i++) {
        const narrativeTextValue = this.form.get(this.amendEditTextAreaKey + i).value;
        const verbCode = this.form.get(this.amendEditTextAreaKey + i)[this.params][FccGlobalConstant.START];
        if (narrativeTextValue === '') {
          if (verbCode === 'Repall') {
            this.form.get('splPaymentBeneRepAll').setValue('N');
            this.setValuesForRepallNo();
          } else {
            this.form.removeControl(this.amendEditTextAreaKey + i);
          }
        } else {
          const jsonVal = { verb: String, text: String };
          jsonVal.verb = verbCode.toLowerCase();
          jsonVal.text = narrativeTextValue;
          this.form.get(this.amendEditTextAreaKey).value[FccGlobalConstant.ITEMS].push(jsonVal);
          const tempController = this.form.get(this.amendEditTextAreaKey + i);
          this.form.removeControl(this.amendEditTextAreaKey + i);
          this.form.addControl(this.amendEditTextAreaKey + tempCounter, tempController);
          tempCounter++;
        }
      }
      this.splPaymentBenecounter = tempCounter;
    }
    this.parentForm.controls[this.controlName] = this.form;
    this.phrasesResponseForSpclPaymnt = null;
  }

  onClickPhraseIcon(event, key) {
    this.entityName = this.stateService.getSectionData(FccGlobalConstant.APPLICANT_BENEFICIARY).get('applicantEntity').value.shortName;
    if (this.entityName !== '' && this.entityName !== undefined) {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '14', false, this.entityName);
    } else {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '14', false);
    }
  }

  setValuesForRepallNo() {
    this.form.get('splPaymentBeneAmendOptions')[this.params][FccGlobalConstant.RENDERED] = true;
    this.form.get(this.amendEditTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = false;
    this.form.get(this.amendEditTextAreaKey).setValue(null);
    this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = false;
    this.form.get(this.repAllTextAreaKey).setValue(null);
    if (this.form.get(this.repAllTextAreaKey)) {
      this.onClickSplPaymentBeneAmendEditTextArea(null, this.repAllTextAreaKey);
    }
  }
}
