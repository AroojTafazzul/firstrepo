import { Component, ElementRef, Input, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { CurrencyConverterPipe } from './../../../../lc/initiation/pipes/currency-converter.pipe';

import { FccGlobalConstant } from '../../../../../../common/core/fcc-global-constants';
import { CommonService } from '../../../../../../common/services/common.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { PhrasesService } from '../../../../../../common/services/phrases.service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { SiProductComponent } from '../si-product/si-product.component';
import { FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from './../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstantService } from './../../../../../../common/core/fcc-global-constant.service';
import { LcConstant } from './../../../../../../corporate/trade/lc/common/model/constant';
import { ProductStateService } from './../../../../../../corporate/trade/lc/common/services/product-state.service';
import { FormControlService } from './../../../../../../corporate/trade/lc/initiation/services/form-control.service';
import { NarrativeService } from './../../../../../../corporate/trade/lc/initiation/services/narrative.service';
import { UtilityService } from './../../../../../../corporate/trade/lc/initiation/services/utility.service';
import { SiProductService } from '../../../services/si-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-si-description-of-goods',
  templateUrl: './si-description-of-goods.component.html',
  styleUrls: ['./si-description-of-goods.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: SiDescriptionOfGoodsComponent }]
})
export class SiDescriptionOfGoodsComponent extends SiProductComponent implements OnInit, OnDestroy {
  form: FCCFormGroup;
  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  lcConstant = new LcConstant();
  module = '';
  element = FccGlobalConstant.NAR_TAB_NESTED_CONTROL_DESC_OF_GOODS_TEXT;
  swiftZCharRegex: string;
  swiftExtendedNarrativeEnable: boolean;
  paramDataList: any[] = [];
  modeOfTransmission;
  mode: any;
  descOfGoodsRowCount: number;
  totalNarrativeCount;
  maxLength = this.lcConstant.maximumlength;
  maxRowCount = this.lcConstant.maxRowCount;
  enteredCharCount = this.lcConstant.enteredCharCounts;
  allowedCharCount = this.lcConstant.allowedCharCount;
  params = this.lcConstant.params;
  swift = 'swift';
  descOfGoodsMandatory: boolean;
  descOfGoodscounter = this.lcConstant.zero;
  openAllSvg = 'openAllSvg';
  closeAllSvg = 'closeAllSvg';
  openAllSvgPath: any;
  closeAllSvgPath: any;
  contextPath: any;
  tnxTypeCode: any;
  mandatoryFields: any[];
  readonly = this.lcConstant.readonly;
  rows = this.lcConstant.rows;
  phrasesResponseForDescOfGoods: any;
  displayValue: string;
  finalTextValue = '';
  entityName: any;
  responseData: string;
  @ViewChild('fccCommonTextArea') public dirs;
  option;
  amendEditSection = 'siGoodsandDoc';
  amendEditsubSection = 'siDescOfGoods';
  amendEditTextAreaKey = 'descOfGoodsAmendEditTextArea';
  repAllTextAreaKey = 'descOfGoodsAmendEditTextArea0';
  textAreaCount;
  textAreaCreated = false;
  descOfGoodsLen;

  constructor(protected emitterService: EventEmitterService, protected stateService: ProductStateService,
              protected formControlService: FormControlService, protected commonService: CommonService,
              protected fccBusinessConstantsService: FccBusinessConstantsService,
              protected narrativeService: NarrativeService, protected translateService: TranslateService,
              protected fccGlobalConstantService: FccGlobalConstantService,
              protected elementRef: ElementRef, protected searchLayoutService: SearchLayoutService,
              protected phrasesService: PhrasesService, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected siProductService: SiProductService
    ) {
    super(emitterService, stateService, commonService, translateService, confirmationService,
      customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray,
      dialogRef, currencyConverterPipe, siProductService);
   }

  ngOnInit(): void {
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.openAllSvgPath = this.contextPath + '/content/FCCUI/assets/icons/expandAll.svg';
    this.closeAllSvgPath = this.contextPath + '/content/FCCUI/assets/icons/collapseAll.svg';
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    const obj = this.parentForm.controls[this.controlName];
    if (obj !== null) {
        this.form = obj as FCCFormGroup;
    }
    this.modeOfTransmission = this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get('transmissionMode').value;
    this.configAndValidations();
    if (this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.get(this.element)[this.params][FccGlobalConstant.PHRASE_ENABLED] = true;
    } else {
      this.form.get(this.element)[this.params][FccGlobalConstant.PHRASE_ENABLED] = false;
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
      this.configAndValidationsAmend();
      if (!this.textAreaCreated){
        if (this.mode === FccGlobalConstant.DRAFT_OPTION)
        {
          this.textAreaCount = this.descOfGoodscounter;
        }
        else {
          this.textAreaCount = 0;
        }
        this.textAreaCreated = true;
      }
    }
  }

  onKeyupDescOfGoodsText() {
    const data = this.form.get(this.element).value;
    const checkForValue = this.commonService.isNonEmptyValue(data) ? data.replace(/[\r\n]+/gm, '' ) : '';
    if (checkForValue === '') {
      this.form.get(this.element).setValue(null);
      this.form.get(this.element).setErrors({ invalid: true });
      this.form.get(this.element).updateValueAndValidity();
    } else {
      this.form.get(this.element).setErrors({ invalid: false });
      this.form.get(this.element).updateValueAndValidity();
    }
    const currentCount = this.form.get(this.element)[this.params][this.enteredCharCount];
    this.narrativeService.descriptionOfGoodsSubject.next(currentCount);
    this.totalCountValidation();
  }

  onKeyupDescOfGoodsAmendEditTextArea(event, key) {
    const data = this.form.get(key).value;
    const maxLength = this.form.get(key)[this.params][this.maxLength];
    const checkForValue = this.commonService.isNonEmptyValue(data) ? data.replace(/[\r\n]+/gm, '') : '' ;
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
      this.descOfGoodscounter
    );

    this.narrativeService.descriptionOfGoodsSubjectAmend.next(this.totalNarrativeCount);
    this.narrativeService.totalCountValidationAmendSI(key, this.form, this.totalNarrativeCount, this.stateService, this.descOfGoodsLen);
    if (data.length > maxLength) {
      this.form.get(key).setErrors( { maxSizeExceedsIndividual: { maxSize: maxLength } } );
    }    
  }

  onFocusDescOfGoodsText() {
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

  onFocusDescOfGoodsAmendEditTextArea(event, key) {
    this.narrativeService.totalCountValidationAmendSI(key, this.form, this.totalNarrativeCount, this.stateService, this.descOfGoodsLen);
  }

  configAndValidations() {
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.swiftZCharRegex = response.swiftZChar;
        this.swiftExtendedNarrativeEnable = response.swiftExtendedNarrativeEnable;
        this.descOfGoodsMandatory = response.descOfGoodsMandatory;
        this.descriptionGoodsMandatory();
        if (this.modeOfTransmission === FccBusinessConstantsService.SWIFT
          || (this.modeOfTransmission[0] && this.modeOfTransmission[0] === FccBusinessConstantsService.SWIFT)){
          this.form.addFCCValidators(this.element, Validators.pattern(this.swiftZCharRegex), 0);
          this.swiftModeTransmission();
          this.form.get(this.element).updateValueAndValidity();
          if (!this.swiftExtendedNarrativeEnable) {
            this.commonService.getParameterConfiguredValues(FccGlobalConstant.PRODUCT_SI,
              FccGlobalConstant.PARAMETER_P940).subscribe(responseData => {
                if (responseData) {
                  this.paramDataList = responseData.paramDataList;
                  this.parameterList();
                  this.descOfGoodsLen = this.descOfGoodsRowCount * FccGlobalConstant.LENGTH_65;
                  this.form.get(this.element)[this.params][this.maxLength] =
                  (this.descOfGoodsLen + (this.descOfGoodsRowCount - FccGlobalConstant.LENGTH_1));
                  this.form.get(this.element)[this.params][this.allowedCharCount] = this.descOfGoodsLen;
                  this.form.get(this.element)[this.params][this.maxRowCount] = this.descOfGoodsRowCount;
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
        this.descOfGoodsMandatory = response.descOfGoodsMandatory;
        this.descriptionGoodsMandatory();
        if (this.modeOfTransmission[0] && this.modeOfTransmission[0].value === FccBusinessConstantsService.SWIFT) {
          this.totalNarrativeCount = this.narrativeService.getTotalAmendNarrativeCount(
            this.amendEditSection,
            this.amendEditsubSection,
            this.form,
            this.amendEditTextAreaKey,
            this.descOfGoodscounter
          );

          this.narrativeService.descriptionOfGoodsSubjectAmend.next(this.totalNarrativeCount);
          for ( let i = 0; i < this.descOfGoodscounter ; i++ ){
            const tempAmendEditTextArea = this.amendEditTextAreaKey.concat(i.toString());
            this.form.addFCCValidators( tempAmendEditTextArea, Validators.pattern(this.swiftZCharRegex), 0);
            this.form.get(tempAmendEditTextArea).updateValueAndValidity();
            this.form.get(tempAmendEditTextArea)[this.params][this.swift] = true;
            this.form.get(tempAmendEditTextArea)[this.params][this.maxRowCount] = FccGlobalConstant.LENGTH_800;
            this.narrativeService.swiftModeTransmissionAmend(
              this.form,
              tempAmendEditTextArea,
              this.totalNarrativeCount,
              this.stateService,
              this.descOfGoodsLen
            );

          }
          if (!this.swiftExtendedNarrativeEnable) {
            this.commonService.getParameterConfiguredValues(FccGlobalConstant.PRODUCT_LC,
              FccGlobalConstant.PARAMETER_P940).subscribe(responseData => {
                if (responseData) {
                  this.paramDataList = responseData.paramDataList;
                  this.parameterList();
                  this.descOfGoodsLen = this.descOfGoodsRowCount * FccGlobalConstant.LENGTH_65;
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


  descriptionGoodsMandatory() {
    if (this.descOfGoodsMandatory && this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
      this.setMandatoryField(this.form, this.element, true);
      this.form.addFCCValidators(this.element, Validators.required, 1);
      this.form.get(this.element).updateValueAndValidity();
    }
    this.removeMandatory([this.element]);
  }

  parameterList() {
    if (this.paramDataList !== null) {
      this.paramDataList.forEach(element => {
        if (element.data_2 === this.lcConstant.descGoods) {
          this.descOfGoodsRowCount = Number(element.data_1);
        }
      });
      if (this.descOfGoodsRowCount === undefined || this.descOfGoodsRowCount === null) {
        this.descOfGoodsRowCount = FccGlobalConstant.LENGTH_100;
      }
    }
  }

  texelCourierModeTransmission() {
    if (!this.descOfGoodsMandatory) {
      this.form.get(this.element).setValidators([]);
      this.form.get(this.element).updateValueAndValidity();
    }
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

  onClickDescOfGoodsAmendOptions(obj: any) {
    if (this.mode === FccGlobalConstant.DRAFT_OPTION) {
      this.descOfGoodscounter = this.commonService.amendDescofGooodsCounter;
      if (this.commonService.isNonEmptyValue(this.form.get(this.amendEditTextAreaKey).value) &&
          Array.isArray(this.form.get(this.amendEditTextAreaKey).value.items) &&
          (this.form.get(this.amendEditTextAreaKey).value.items.length > 0))
      {
         this.descOfGoodscounter++;
      }
      else {
         this.descOfGoodscounter = 0;
      }
      this.commonService.amendDescofGooodsCounter = this.descOfGoodscounter;
    }
    const fieldObj1 = this.amendHistoryHeaderJsonObject(this.form.get('descOfGoodsAmendHistoryHeader'));
    this.form.removeControl('descOfGoodsAmendHistoryHeader');
    const fieldObj2 = this.narrativeService.narrativeExpansionPanelJsonObject(
      this.form.get('descOfGoodsAmendmentPanel'));
    this.form.removeControl('descOfGoodsAmendmentPanel');
    const fieldObj = this.narrativeService.amendNarrativeTextAreaJsonObject(
      this.form.get(this.amendEditTextAreaKey));
    let newKeyName = this.amendEditTextAreaKey + this.descOfGoodscounter;
    this.form.addControl(newKeyName, this.formControlService.getControl(fieldObj));
    this.form.get(newKeyName)[FccGlobalConstant.KEY] = newKeyName;
    this.form.get(newKeyName)[this.params][FccGlobalConstant.RENDERED] = true;
    this.form.get(newKeyName)[this.params][FccGlobalConstant.PREVIEW_SCREEN] = false;
    this.descOfGoodscounter++;
    const count = this.descOfGoodscounter;
    let newCount;
    for (let i = this.descOfGoodscounter - 1; i >= 0 ; i--) {
      let newName = this.amendEditTextAreaKey + i;
      if (i > 0) {
        const newKeyFinal = this.narrativeService.getFinalNewKeyName(this.form, this.amendEditTextAreaKey, i, fieldObj, newName);
        if (this.commonService.isNonEmptyValue(newKeyFinal)) {
          newName = newKeyFinal;
          this.descOfGoodscounter--;
          newCount = this.descOfGoodscounter;
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
    if (count !== this.descOfGoodscounter) {
      newKeyName = this.amendEditTextAreaKey + (newCount - 1);
      this.form.addControl(newKeyName, this.formControlService.getControl(fieldObj));
      this.form.get(newKeyName)[FccGlobalConstant.KEY] = newKeyName;
      this.form.get(newKeyName)[this.params][FccGlobalConstant.RENDERED] = true;
      this.form.get(newKeyName)[this.params][FccGlobalConstant.PREVIEW_SCREEN] = false;
    }
    this.form.addControl('descOfGoodsAmendHistoryHeader', this.formControlService.getControl(fieldObj1));
    this.form.addControl('descOfGoodsAmendmentPanel', this.formControlService.getControl(fieldObj2));
    this.form.get('descOfGoodsAmendmentPanel').patchValue(fieldObj2[FccGlobalConstant.VALUE]);

    if (obj.value === 'amendAdd') {
      this.form.get(newKeyName)[this.params][FccGlobalConstant.START] = 'Add';
    } else {
      this.form.get(newKeyName)[this.params][FccGlobalConstant.START] = 'Delete';
    }
    this.textAreaCount++;
    this.narrativeService.totalCountValidationAmendSI(newKeyName, this.form, this.totalNarrativeCount, this.stateService,
      this.descOfGoodsLen);
  }

  onBlurDescOfGoodsAmendEditTextArea(event, key) {
    const strResult = event.srcElement.value ? event.srcElement.value : event.srcElement.innerText;
    if ((this.form.get('descOfGoodsRepAll').value === 'N') && (key !== null || key !== undefined)) {
      this.form.get(key).setValue(strResult);
    } else {
      this.form.get(this.repAllTextAreaKey).setValue(strResult);
    }
    this.narrativeService.totalCountValidationAmendSI(key, this.form, this.totalNarrativeCount, this.stateService);
  }

  onClickDescOfGoodsAmendEditTextArea(event, key) {
    this.form.removeControl(key);
    this.totalNarrativeCount = this.narrativeService.getTotalAmendNarrativeCount(
      this.amendEditSection,
      this.amendEditsubSection,
      this.form,
      this.amendEditTextAreaKey,
      this.descOfGoodscounter
    );

    this.narrativeService.descriptionOfGoodsSubjectAmend.next(this.totalNarrativeCount);
    this.descOfGoodscounter--;
    this.form.get(FccGlobalConstant.NAR_TAB_CONTROL_DESC_OF_GOODS_AMD_OPT).setValue(null);
    this.narrativeService.totalCountValidationAmendSI(key, this.form, this.totalNarrativeCount, this.stateService, this.descOfGoodsLen);
  }

  onClickDescOfGoodsRepAll() {
    if (this.form.get('descOfGoodsRepAll').value === 'Y') {
     for (let i = 0 ; i < this.textAreaCount ; i++) {
          if (this.form.get(this.amendEditTextAreaKey + i)) {
        this.onClickDescOfGoodsAmendEditTextArea(null, this.amendEditTextAreaKey + i);
          }

          this.descOfGoodscounter++;
      }
     this.textAreaCount = 0;
     this.descOfGoodscounter = 0;
     const fieldObj1 = this.amendHistoryHeaderJsonObject(this.form.get('descOfGoodsAmendHistoryHeader'));
     this.form.removeControl('descOfGoodsAmendHistoryHeader');
     const fieldObj2 = this.narrativeService.narrativeExpansionPanelJsonObject(
        this.form.get('descOfGoodsAmendmentPanel'));
     this.form.removeControl('descOfGoodsAmendmentPanel');
     this.form.get('descOfGoodsAmendOptions')[this.params][FccGlobalConstant.RENDERED] = false;
     this.form.get(this.amendEditTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = false;
     this.form.get(this.amendEditTextAreaKey).setValue(null);
     const fieldObj = this.narrativeService.amendNarrativeTextAreaJsonObject(
        this.form.get(this.amendEditTextAreaKey));
     this.form.addControl(this.repAllTextAreaKey, this.formControlService.getControl(fieldObj));
     this.form.get(this.repAllTextAreaKey)[FccGlobalConstant.KEY] = this.repAllTextAreaKey;
     this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = true;
     this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.PREVIEW_SCREEN] = false;
     this.form.addControl('descOfGoodsAmendHistoryHeader', this.formControlService.getControl(fieldObj1));
     this.form.addControl('descOfGoodsAmendmentPanel', this.formControlService.getControl(fieldObj2));
     this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.START] = 'Repall';
     if (this.modeOfTransmission[0] && this.modeOfTransmission[0].value === FccBusinessConstantsService.SWIFT) {
      this.form.addFCCValidators(this.repAllTextAreaKey, Validators.pattern(this.swiftZCharRegex), 0);
      }
     this.descOfGoodscounter++;
    } else {
      this.form.get('descOfGoodsAmendOptions')[this.params][FccGlobalConstant.RENDERED] = true;
      this.form.get(this.amendEditTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = false;
      this.form.get(this.amendEditTextAreaKey).setValue(null);
      this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.RENDERED] = false;
      this.form.get(this.repAllTextAreaKey)[this.params][FccGlobalConstant.PREVIEW_SCREEN] = false;
      this.form.get(this.repAllTextAreaKey).setValue(null);
      if (this.form.get(this.repAllTextAreaKey)) {
        this.onClickDescOfGoodsAmendEditTextArea(null, this.repAllTextAreaKey);
      }
    }
  }

  amendFormFields() {
    this.updateMasterData();
    this.form.get(this.element)[this.params][this.swift] = true;
    this.form.get(this.element)[this.params][this.readonly] = true;
    this.form.get(this.element)[FccGlobalConstant.PARAMS][FccGlobalConstant.ROWS] = FccGlobalConstant.LENGTH_4;
    this.form.get('descOfGoodsAmendmentPanel')[this.params][this.openAllSvg] = this.openAllSvgPath;
    this.form.get('descOfGoodsAmendmentPanel')[this.params][this.closeAllSvg] = this.closeAllSvgPath;
    this.mandatoryFields = [this.element];
    this.setMandatoryFields(this.form, this.mandatoryFields, false);
    this.form.get(this.element).updateValueAndValidity();
    if (this.form.get(this.amendEditTextAreaKey).value && this.form.get(this.amendEditTextAreaKey).value.items) {
      this.descOfGoodscounter = this.form.get(this.amendEditTextAreaKey).value.items.length;
    }
  }
  updateMasterData() {
    this.narrativeService.updateMasterData(this.form, this.element, 'masterDescOfGoods');
   }
  ngOnDestroy() {
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND && this.descOfGoodscounter > this.lcConstant.zero) {
      const arraySet: {items: any} = {
        items: []
      };
      this.form.get(this.amendEditTextAreaKey).setValue(arraySet);
      for (let i = 0; i < this.descOfGoodscounter; i++) {
        const jsonVal = { verb: String, text: String };
        const verbCode = this.form.get(this.amendEditTextAreaKey + i)[this.params][FccGlobalConstant.START];
        jsonVal.verb = verbCode.toLowerCase();
        jsonVal.text = this.form.get(this.amendEditTextAreaKey + i).value;
        this.form.get(this.amendEditTextAreaKey).value[FccGlobalConstant.ITEMS].push(jsonVal);
      }
    }
    this.parentForm.controls[this.controlName] = this.form;
  }

  onClickPhraseIcon(event, key) {
    this.entityName = this.stateService.getSectionData(FccGlobalConstant.SI_APPLICANT_BENEFICIARY).get('applicantEntity').value.shortName;
    if (this.entityName !== '' && this.entityName !== undefined) {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_SI, key, '01', false, this.entityName);
    } else {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_SI, key, '01', false);
    }
  }

  removeMandatory(fields: any) {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryFields(this.form, fields, false);
      this.form.get(fields[0]).clearValidators();
    }
  }
}

