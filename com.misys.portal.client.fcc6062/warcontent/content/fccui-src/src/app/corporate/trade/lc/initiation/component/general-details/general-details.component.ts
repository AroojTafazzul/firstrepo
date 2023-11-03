import { DatePipe } from '@angular/common';
import { AfterViewChecked, Component, EventEmitter, OnDestroy, OnInit, Output } from '@angular/core';
import { Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService } from 'primeng';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { BehaviorSubject, Subscription } from 'rxjs';
import { FccGlobalConstant } from '../../../../../../../app/common/core/fcc-global-constants';
import {
  ConfirmationDialogComponent
} from '../../../../../../../app/corporate/trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { CodeData } from '../../../../../../common/model/codeData';
import { CodeDataService } from '../../../../../../common/services/code-data.service';
import { FormModelService } from '../../../../../../common/services/form-model.service';
import { ProductMappingService } from '../../../../../../common/services/productMapping.service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { TabPanelService } from '../../../../../../common/services/tab-panel.service';
import { TransactionDetailService } from '../../../../../../common/services/transactionDetail.service';
import { AmendCommonService } from '../../../../../common/services/amend-common.service';
import { LeftSectionService } from '../../../../../common/services/leftSection.service';
import { ProductStateService } from '../../../common/services/product-state.service';
import { LcProductService } from '../../../services/lc-product.service';
import { CurrencyConverterPipe } from '../../pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../services/filelist.service';
import { LcReturnService } from '../../services/lc-return.service';
import { UtilityService } from '../../services/utility.service';
import { compareExpiryDateToCurrentDate, expiryDateLessThanCurrentDate, invalidDate } from '../../validator/ValidateDates';
import {
  compareExpDateWithLastShipmentDate, compareNewExpiryDateToOld
} from '../../validator/ValidateLastShipDate';
import { PhrasesService } from './../../../../../../../app/common/services/phrases.service';
import { FCCFormControl, FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from './../../../../../../common/core/fcc-business-constants.service';
import { CommonService } from './../../../../../../common/services/common.service';
import { EventEmitterService } from './../../../../../../common/services/event-emitter-service';
import { LcTemplateService } from './../../../../../../common/services/lc-template.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FccTradeFieldConstants } from './../../../../common/fcc-trade-field-constants';
import { LcConstant } from './../../../common/model/constant';
import { ImportLetterOfCreditResponse } from './../../model/importLetterOfCreditResponse';
import { NarrativeService } from './../../services/narrative.service';
import { PrevNextService } from './../../services/prev-next.service';
import { LcProductComponent } from './../lc-product/lc-product.component';
@Component({
  selector: 'app-general-details',
  templateUrl: './general-details.component.html',
  styleUrls: ['./general-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: GeneralDetailsComponent }]
})
export class GeneralDetailsComponent extends LcProductComponent implements OnInit, AfterViewChecked, OnDestroy {
  @Output() messageToEmit = new EventEmitter<string>();

  lcConstant = new LcConstant();
  form: FCCFormGroup;
  form1: FCCFormGroup;
  module = `${this.translateService.instant('generalDetails')}`;
  contextPath: any;
  checked = true;
  progressivebar: number;
  btndisable;
  lcResponse;
  templateResponse;
  backToBackResponse;
  params = this.lcConstant.params;
  options = this.lcConstant.options;
  disabled = this.lcConstant.disabled;
  styleClass = this.lcConstant.styleClass;
  parentStyleClass = this.lcConstant.parentStyleClass;
  defaultValue = this.lcConstant.defaultValue;
  readonly = this.lcConstant.readonly;
  tnxTypeCode: any;
  checker = true;
  checkIcons = this.lcConstant.tickIcon;
  // getLcmode;
  blankCheckIcons = this.lcConstant.blankCheckIcons;
  rendered = this.lcConstant.rendered;
  custRefRegex;
  custRefLength;
  length16 = FccGlobalConstant.LENGTH_16;
  length35 = FccGlobalConstant.LENGTH_35;
  MARGIN_STYLE = 'margin-side';
  allLcRecords = new ImportLetterOfCreditResponse();
  formMode;
  applicableRules = [];
  enquiryRegex;
  optionChecked = 'checked';
  expiryDateBackToBack: any;
  option;
  sectionName = 'generalDetails';
  previewScreen = 'previewScreen';
  mode;
  templteId;
  refId;
  language = localStorage.getItem('language');
  transmissionMode: any;
  isMasterRequired: any;
  expiryDateField = 'expiryDate';
  warning = 'warning';
  confirmationPartymessage = 'confirmationPartymessage';
  templateKey: string;
  backtobackKey: string;
  currentDate = new Date();
  isPreview: boolean;
  productCode: any;
  subProductCode: any;
  codeData = new CodeData();
  eventDataArray: any;
  codeID: any;
  parentRefId: string;
  prevCreateFrom;
  lcFreeFormatUploadFlag;
  currentCreateForm;
  chipResponse: Subscription;
  purchaseOrderEnable: any;

  excludedFieldsNdSections: any;
  copyFromProductCode = '';
  excludingJsonFileKey = '';
  fieldsArray = [];
  sectionsArray = [];
  fieldNames = [];

  constructor(protected commonService: CommonService, protected leftSectionService: LeftSectionService,
              protected router: Router, protected translateService: TranslateService,
              protected lcReturnService: LcReturnService, protected prevNextService: PrevNextService,
              protected utilityService: UtilityService, protected searchLayoutService: SearchLayoutService,
              protected lcTemplateService: LcTemplateService, protected formModelService: FormModelService,
              protected stateService: ProductStateService, protected route: ActivatedRoute,
              protected eventEmitterService: EventEmitterService, protected transactionDetailService: TransactionDetailService,
              protected tabservice: TabPanelService,
              protected datePipe: DatePipe, protected dialogService: DialogService,
              protected phrasesService: PhrasesService,
              protected narrativeService: NarrativeService, protected productMappingService: ProductMappingService,
              protected amendCommonService: AmendCommonService, protected resolverService: ResolverService,
              protected confirmationService: ConfirmationService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected fileList: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe,
              protected codeDataService: CodeDataService, protected lcProductService: LcProductService
              ) {
    super(eventEmitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
          searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, lcProductService);
  }
  ngOnInit() {
    super.ngOnInit();
    window.scroll(0, 0);
    this.isMasterRequired = this.isMasterRequired;
    // this.intializeRules();
    // place holder to pass amendment design. This has to remove once integrated
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.templteId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TEMPLATE_ID);
    this.refId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    this.operation = this.commonService.getQueryParametersFromKey (FccGlobalConstant.OPERATION);
    this.productCode = this.commonService.getQueryParametersFromKey (FccGlobalConstant.PRODUCT);
    if (this.commonService.referenceId === undefined) {
      sessionStorage.removeItem(FccGlobalConstant.idempotencyKey);
    }
    this.initializeFormGroup();
    if ((this.mode === FccGlobalConstant.DRAFT_OPTION || this.mode === FccGlobalConstant.INITIATE)
     && this.tnxTypeCode === FccGlobalConstant.N002_NEW
     && this.form.get('requestOptionsLC').value === FccGlobalConstant.CODE_02) {
        this.form.get('createFromOptions').setValue('upload');
        this.form.get('createFromOptions').updateValueAndValidity();
        this.prevCreateFrom = 'upload';
    }
    this.lcFreeFormatUploadFlag = this.commonService.getUserPermissionFlag(FccGlobalConstant.LC_FREE_FORMAT);
    if (this.commonService.isnonEMptyString(this.form.get('transmissionMode').value)){
      this.transmissionMode = this.form.get('transmissionMode').value;
    } else {
      this.form.get('transmissionMode').setValue(FccBusinessConstantsService.SWIFT);
      this.transmissionMode = FccBusinessConstantsService.SWIFT;
    }
    this.commonService.isTransmissionModeChanged(this.form.get('transmissionMode').value);
    this.isPreview = this.mode === FccGlobalConstant.INITIATE || this.mode === FccGlobalConstant.DRAFT_OPTION ||
    this.mode === FccGlobalConstant.EXISTING;
    this.commonService.loadDefaultConfiguration().subscribe(response => {

      if (response) {
        this.custRefRegex = response.customerReferenceTradeRegex;
        this.custRefLength = response.customerReferenceTradeLength;
        this.purchaseOrderEnable = response.purchaseOrderReference;
        this.enquiryRegex = response.swiftXCharacterSet;
        this.form.get('placeOfExpiry').clearValidators();
        this.form.get('otherApplicableRules').clearValidators();
        this.form.get('customerReference').clearValidators();
        this.form.get('beneficiaryReference').clearValidators();
        this.transmissionMode = this.form.get('transmissionMode').value;
        if (this.transmissionMode === FccBusinessConstantsService.SWIFT) {
          this.form.addFCCValidators('placeOfExpiry', Validators.pattern(this.enquiryRegex), 0);
          this.form.addFCCValidators('otherApplicableRules', Validators.pattern('^[A-Za-z][A-Za-z0-9 ]*$'), 0);
        }
        this.form.addFCCValidators('customerReference', Validators.maxLength(this.custRefLength), 0);
        this.form.addFCCValidators('beneficiaryReference', Validators.maxLength(this.custRefLength), 0);
        this.form.addFCCValidators('otherApplicableRules', Validators.maxLength(FccGlobalConstant.LENGTH_35), 0);
        this.purchaseOrderFieldRender();
      }
    });
    if (!this.lcFreeFormatUploadFlag) {
      const requestList = this.form.get('createFromOptions')[this.params][this.options];
      requestList.splice(2, requestList.length);
    }
    this.patchLayoutForReadOnlyMode();
    this.templateChanges();
    this.onClickApplicableRulesOptions();
    this.editModeDataPopulate();
    this.updateValues();
    if (this.operation !== FccGlobalConstant.LIST_INQUIRY && this.operation !== FccGlobalConstant.PREVIEW){
    this.onClickExpiryDate();
    }
    this.onClickProvisionalLCToggle();
    if (this.mode === FccGlobalConstant.DRAFT_OPTION && this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      const productCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.PRODUCT);
      this.amendCommonService.compareTransactionAndMasterForAmend(productCode);
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      if (this.transmissionMode && this.transmissionMode[0] && this.transmissionMode[0].value === FccBusinessConstantsService.OTHER_99) {
      this.togglePreviewScreen(this.form, [FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT], true);
      this.togglePreviewScreen(this.form, [FccGlobalConstant.TRANS_MODE], false);
      }
    }

    const perms = [FccGlobalConstant.LC_LCSTD_BACKTOBACK_PERMISSION];
    perms.forEach(perKey => {
      const flag = this.commonService.getUserPermissionFlag(perKey);
      if (!flag) {
        this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.rendered] = false;
      }
    });

    if (this.mode === FccGlobalConstant.DRAFT_OPTION && this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      if (this.transmissionMode && this.transmissionMode === FccBusinessConstantsService.OTHER_99) {
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[this.params][this.rendered] = true;
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.TRANS_MODE], false);
      } else {
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[this.params][this.rendered] = false;
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.TRANS_MODE], true);
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT).setValue('');
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT).clearValidators();
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT).updateValueAndValidity();
      }
    }
    this.subscribeChipResponse();
    this.getExcludedFieldsNdSections();
  }

  getExcludedFieldsNdSections() {
    const productCode = FccGlobalConstant.PRODUCT_LC;
    const subProductCode = FccGlobalConstant.LCSTD;
    this.transactionDetailService.getExcludedFieldsNdSections(productCode, subProductCode).subscribe(
      (response) => {
          this.excludedFieldsNdSections = response.body;
        }, (error) => {
          // eslint-disable-next-line no-console
          console.log(error);
        }
      );
    }

  handleResponse(data) {
    if (data.action === 'cancelled') {
      this.form.get(data.controlName).setValue(data.previousValue);
      this.form.get(data.controlName).updateValueAndValidity();
    } else if (data.action === 'deselect') {
      this.unSelectButton(true, 'createFromOptions', data.presentValue, this.prevCreateFrom);
    }
    this.updateRequestLCType();
    this.prevCreateFrom = this.form.get(data.controlName).value;
  }
  updateValues() {
    this.onClickConfirmationOptions();
  }

  onClickConfirmationOptions() {
    this.toggleValue(this.form.get('confirmationOptions').value, 'confirmationOptions');
  }

  toggleValue(value, feildValue) {
    if (value === FccGlobalConstant.CONFIRMATION_OPTION_CONFIRM || value === FccGlobalConstant.CONFIRMATION_OPTION_MAY_ADD) {
      this.form.get(feildValue)[this.params][this.warning] = `${this.translateService.instant(this.confirmationPartymessage)}`;
    } else {
      this.form.get(feildValue)[this.params][this.warning] = FccGlobalConstant.EMPTY_STRING;
    }
  }

  editModeDataPopulate() {
    const parentRefID = this.form.get(FccTradeFieldConstants.PARENT_REFERENCE).value;
    const subTnxTypeCode = this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE).value;
    if (this.mode === 'DRAFT' && parentRefID !== undefined) {
      if (subTnxTypeCode === '06') {
      const mode = 'EDIT';
      this.initializeFormToLCDetailsResponse(parentRefID, mode);
    }
     else if (subTnxTypeCode !== '06' && this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.get('createFromOptions')[this.params][this.rendered] = false;
      this.form.get('referenceSelected')[this.params][this.rendered] = true;
      this.form.get('fetchedRefValue')[this.params][this.rendered] = true;
      this.form.get('removeLabel')[this.params][this.rendered] = false;
      this.form.get('fetchedRefValue').patchValue(parentRefID);
      this.form.get(FccTradeFieldConstants.PARENT_REFERENCE).patchValue(parentRefID);
      this.patchFieldParameters(this.form.get('fetchedRefValue'), { readonly: true });
      this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.disabled] = true;
      this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.previewScreen] = false;
      this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.rendered] = false;
      this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.previewScreen] = false;
    }
  }
}
  ngAfterViewChecked() {
    this.resetCreatForm();
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.refreshFormElements();
    }
  }

  templateChanges() {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.form.get('templateName')[this.params][this.rendered] = true;
      this.form.get('templateName')[this.params][FccGlobalConstant.REQUIRED] = true;
      this.form.get('provisionalLCToggle')[this.params][this.rendered] = false;
      this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.rendered] = false;
      this.form.get('templateDescription')[this.params][this.rendered] = true;
      this.form.get('requestTypeLC')[this.params][this.rendered] = false;
      this.form.get('requestOptionsLC')[this.params][this.rendered] = false;
      this.form.get('createFrom')[this.params][this.rendered] = false;
      this.form.get('createFromOptions')[this.params][this.rendered] = false;
      this.patchFieldParameters(this.form.get('applicableRulesOptions'), { autoDisplayFirst : false });
      if (this.mode !== FccGlobalConstant.DRAFT_OPTION && !this.form.get('templateName').value) {
        this.commonService.generateTemplateName(FccGlobalConstant.PRODUCT_LC).subscribe( res => {
          const jsonContent = res.body as string[];
          const templateName = jsonContent[`templateName`];
          this.form.get('templateName').setValue(templateName);
          this.commonService.putQueryParameters('templateName', this.form.get('templateName').value);
        });
      }
      this.commonService.putQueryParameters('templateName', this.form.get('templateName').value);
      this.setMandatoryField(this.form, 'applicableRulesOptions', false);
      this.setMandatoryField(this.form, 'placeOfExpiry', false);
      if ( this.templteId !== undefined && this.templteId !== null && this.mode === FccGlobalConstant.DRAFT_OPTION) {
          this.form.get('templateName')[this.params][this.readonly] = true;
      }
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

  ngOnDestroy() {
    if (this.form !== undefined) {
    this.form.get('removeLabelSR')[this.params][this.rendered] = false;
    this.form.get(FccGlobalConstant.REMOVE_LABEL)[this.params][this.rendered] = false;
    this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.disabled] = true;
    this.form.get('removeLabelTemplate')[this.params][this.rendered] = false;
  }
    this.stateService.setStateSection(FccGlobalConstant.GENERAL_DETAILS, this.form, this.isMasterRequired);
    this.stateService.setStateSection(FccGlobalConstant.NARRATIVE_DETAILS, this.form1);
    if (this.backToBackResponse !== undefined) {
      this.searchLayoutService.searchLayoutDataSubject.unsubscribe();
      this.backToBackResponse = null;
      this.searchLayoutService.searchLayoutDataSubject = new BehaviorSubject(null);
    }
    if (this.lcResponse !== undefined) {
      this.searchLayoutService.searchLayoutDataSubject.unsubscribe();
      this.lcResponse = null;
      this.searchLayoutService.searchLayoutDataSubject = new BehaviorSubject(null);
    }
    if (this.templateResponse !== undefined) {
      this.searchLayoutService.searchLayoutDataSubject.unsubscribe();
      this.templateResponse = null;
      this.searchLayoutService.searchLayoutDataSubject = new BehaviorSubject(null);
    }
    if (this.chipResponse !== undefined && this.chipResponse !== null) {
      this.chipResponse.unsubscribe();
      this.chipResponse = null;
    }
    this.commonService.actionsDisable = false;
    this.commonService.buttonsDisable = false;
    this.commonService.backTobackExpDateFilter = false;
  }

  confirmChange()
  {
    const dir = localStorage.getItem('langDir');
    const headerField = `${this.translateService.instant('confirmation')}`;
    const obj = {};
    const locaKey = 'locaKey';
    obj[locaKey] = FccGlobalConstant.CHANGE_UPLOAD;
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      data: obj,
      header: headerField,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir }
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === 'yes') {
        this.prevCreateFrom = this.currentCreateForm;
        this.onFocusYesButton(this.currentCreateForm);
        this.form.get(FccTradeFieldConstants.CREATE_FROM_OPTIONS).setValue(this.currentCreateForm);
      }
      if (result.toLowerCase() === 'no') {
        this.onFocusNoButton();
      }
      this.updateRequestLCType();
    });
    dialogRef.onDestroy.subscribe((result: any) => {
      if (!result) {
        this.onFocusNoButton();
        this.updateRequestLCType();
      }
    });

  }

  onClickCreateFromOptions(data: any) {
    this.subscribeChipResponse();
    if (data.value === 'existinglc') {
      if (this.prevCreateFrom === 'upload') {
        this.currentCreateForm = data.value;
        this.confirmChange();
      } else {
        this.onClickExistingLc();
      }
    } else if (data.value === 'template') {
      if (this.prevCreateFrom === 'upload') {
        this.currentCreateForm = data.value;
        this.confirmChange();
      } else {
        this.onClickExistingTemplate();
      }
    } else if (data.value === 'backtoback') {
      this.onClickBackToBackLC();
    } else if (data.value === 'upload') {
      if (this.prevCreateFrom === 'upload') {
        this.chipSelection(data, FccGlobalConstant.DESELECT_UPLOAD);
      }
      this.updateRequestLCType();
      this.leftSectionService.reEvaluateProgressBar.next(true);
    }
  }

  updateRequestLCType() {
    const sectionForm : FCCFormGroup = this.stateService.getSectionData(FccGlobalConstant.PAYMENT_DETAILS);
    const sectionForm2 : FCCFormGroup = this.stateService.getSectionData(FccGlobalConstant.FILE_UPLOAD);
    if (this.form.get('createFromOptions') && this.form.get('createFromOptions').value === 'upload') {
      this.form.get('requestOptionsLC').setValue(FccGlobalConstant.CODE_02);
      this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[this.params][FccGlobalConstant.REQUIRED] = false;
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).clearValidators();
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).markAsTouched();
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).updateValueAndValidity();
      sectionForm2.get(FccGlobalConstant.ATTACHMENTS)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      this.form.get('requestOptionsLC').updateValueAndValidity();
      this.prevCreateFrom = 'upload';
    } else {
      // give error msg popup
      this.form.get('requestOptionsLC').setValue(FccGlobalConstant.CODE_01);
      this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[this.params][FccGlobalConstant.REQUIRED] = true;
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).setValidators([Validators.required]);
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).setErrors({ required: true });
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).markAsDirty();
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).markAsTouched();
      sectionForm.get(FccGlobalConstant.PAYMENT_BANK_DETAILS_ENTITY).updateValueAndValidity();
      sectionForm2.get(FccGlobalConstant.ATTACHMENTS)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
    }
  }

  onFocusYesButton(createFrom) {
    setTimeout(() => {
      if (createFrom === 'existinglc') {
        this.onClickExistingLc();
      } else if (createFrom === 'template') {
        this.onClickExistingTemplate();
      }
    }, 400);
  }

  onFocusNoButton() {
    setTimeout(() => {
      this.form.get('createFromOptions').setValue(this.prevCreateFrom);
    }, 400);
  }

  chipSelection(data , message) {
    const presentValue = data[FccGlobalConstant.SOURCE][FccGlobalConstant.VALUE];
    const data1 = {
        controlName: 'createFromOptions',
        previousValue: this.prevCreateFrom,
        presentValue,
        event: true,
        locaKey: message
      };
    if (this.isChipEvent(data, this.prevCreateFrom)) {
      this.commonService.openChipConfirmationDialog$.next(data1);
    } else {
      this.prevCreateFrom = this.form.get('createFromOptions').value;
    }
  }

  onChangeTemplateName() {
    this.commonService.putQueryParameters('templateName', this.form.get('templateName').value);
    if (this.form.get('templateName').value.length === 0) {
      this.form.get('next')[this.params][this.rendered] = false;
    } else {
      this.form.get('next')[this.params][this.rendered] = true;
    }
  }

 onClickApplicableRulesOptions() {
    if (this.option !== FccGlobalConstant.TEMPLATE) {
    if (this.commonService.isnonEMptyString(this.form.get('requestOptionsLC').value) &&
      this.form.get('requestOptionsLC').value === FccGlobalConstant.CODE_02 && this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[this.params][FccGlobalConstant.REQUIRED] = false;
    } else if (this.commonService.isnonEMptyString(this.form.get('requestOptionsLC').value) &&
      this.form.get('requestOptionsLC').value === FccGlobalConstant.CODE_01 && this.tnxTypeCode === FccGlobalConstant.N002_NEW){
      this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[this.params][FccGlobalConstant.REQUIRED] = true;
    }
    }
    this.handleLCApplicableRulesOptions();
    const applicableRule = this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS).value;
    if (applicableRule && applicableRule.toString() === FccBusinessConstantsService.OTHER_99) {
      this.form.get(FccTradeFieldConstants.OTHER_APPLICABLE_RULES)[this.params][this.rendered] = true;
      if (this.isPreview) {
        this.togglePreviewScreen(this.form, [FccTradeFieldConstants.APPLICABLE_RULES_OPTIONS], false);
      }
      if (this.mode === FccBusinessConstantsService.SWIFT) {
        this.form.addFCCValidators(FccTradeFieldConstants.OTHER_APPLICABLE_RULES,
          Validators.compose([Validators.pattern('^[A-Za-z][A-Za-z0-9 ]*$')]), 1);
      }
      this.form.addFCCValidators(FccTradeFieldConstants.OTHER_APPLICABLE_RULES,
        Validators.compose([Validators.maxLength(FccGlobalConstant.LENGTH_35)]), 1);
      this.setMandatoryField(this.form, FccTradeFieldConstants.OTHER_APPLICABLE_RULES, true);
    } else {
      this.form.get(FccTradeFieldConstants.OTHER_APPLICABLE_RULES)[this.params][this.rendered] = false;
      this.setMandatoryField(this.form, FccTradeFieldConstants.OTHER_APPLICABLE_RULES, false);
      this.togglePreviewScreen(this.form, [FccTradeFieldConstants.APPLICABLE_RULES_OPTIONS], true);
    }
  }
  handleLCApplicableRulesOptions() {
    const elementId = FccGlobalConstant.APPLICABLE_RULES_OPTIONS;
    this.productCode = FccGlobalConstant.PRODUCT_DEFAULT;
    this.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
    const elementValue = this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS];
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[FccGlobalConstant.PARAMS][FccGlobalConstant.CODE_ID] !== null &&
        this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[FccGlobalConstant.PARAMS][FccGlobalConstant.CODE_ID] !== '' &&
        this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[FccGlobalConstant.PARAMS][FccGlobalConstant.CODE_ID] !== undefined) {
      this.codeID = this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[FccGlobalConstant.PARAMS][FccGlobalConstant.CODE_ID];
    }
    if (elementValue !== undefined && elementValue.length === 0) {
      this.eventDataArray = this.codeDataService.getCodeData(this.codeID, this.productCode, this.subProductCode, this.form, elementId);
      this.patchFieldParameters(this.form.get(elementId), { options: this.eventDataArray });
    }
    if (elementValue !== undefined && elementValue.length !== 0) {
      elementValue.forEach((value, index) => {
        if (value.value === '*') {
          elementValue.splice(index, 1);
        }
      });
      this.patchFieldParameters(this.form.get(elementId), { options: elementValue });
      this.form.updateValueAndValidity();
    }
  }

  setFieldsArrayNdSectionsData(isTemplate: boolean, productCode: string) {
    this.revertCopyFromDetails();
    // excludingJsonFileKey is used to fetch key from the JSON file from backend
    if (isTemplate) {
      this.excludingJsonFileKey = FccGlobalConstant.TEMPLATE.toLowerCase();
    } else {
      this.excludingJsonFileKey = productCode + FccGlobalConstant.TRANSACTION;
    }
    if (this.excludedFieldsNdSections) {
      this.fieldsArray = this.excludedFieldsNdSections[this.excludingJsonFileKey].fields;
      this.sectionsArray = this.excludedFieldsNdSections[this.excludingJsonFileKey].sections;
    }
  }

  revertCopyFromDetails() {
    this.copyFromProductCode = '';
    this.excludingJsonFileKey = '';
    this.fieldsArray = [];
    this.sectionsArray = [];
  }

  onClickRemoveLabel() {
    this.revertCopyFromDetails();
    this.commonService.setParentReference(null);
    const dir = localStorage.getItem('langDir');
    const headerField = `${this.translateService.instant('removeSelectedTransaction')}`;
    const obj = {};
    const locaKey = 'locaKey';
    if (this.templateKey) {
      obj[locaKey] = this.templateKey;
    } else if (this.backtobackKey) {
      obj[locaKey] = this.backtobackKey ;
    } else {
      obj[locaKey] = FccGlobalConstant.COPYFROM_KEY;
    }
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      data: obj,
      header: headerField,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir }
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === 'yes') {
        if (this.templateKey) {
          this.resetRemoveLabelTemplate();
        } else if (this.backtobackKey) {
          this.resetRemoveLabelSR();
        } else {
          this.resetFieldsForCopyFromTemplate();
        }
      }
      this.templateKey = null;
      this.backtobackKey = null;
    });
  }

  /**
   *  Reset fields for Copy From on click on confirmation from dialog box
   */
  resetFieldsForCopyFromTemplate(): void {
    this.lcResponse.unsubscribe();
    this.productStateService.clearState();
    this.formModelService.getFormModel(FccGlobalConstant.PRODUCT_LC).subscribe(modelJson => {
      this.productStateService.initializeProductModel(modelJson);
      this.productStateService.initializeState(FccGlobalConstant.PRODUCT_LC);
      this.productStateService.populateAllEmptySectionsInState();
      this.form = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS);
      this.form.get('createFromOptions')[this.params][this.rendered] = true;
      this.form.get('referenceSelected')[this.params][this.rendered] = false;
      this.form.get('fetchedRefValue')[this.params][this.rendered] = false;
      this.form.get('removeLabel')[this.params][this.rendered] = false;
      this.form.get('fetchedRefValue').setValue('');
      this.form.get('customerReference').setValue('');
      const val = this.form.get('createFromOptions')[this.params][this.options];
      const val1 = this.form.get('requestOptionsLC')[this.params][this.options];
      this.toggleCreateFormButtons(val, val1, false);
      this.form.get('createFromOptions').setValue('');
      this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.disabled] = false;
      this.onClickApplicableRulesOptions();
    });
  }
  onClickRemoveLabelTemplate() {
    this.templateKey = FccGlobalConstant.TEMPLATEFROM_KEY;
    this.onClickRemoveLabel();
  }
  resetRemoveLabelTemplate() {
    this.form.get('createFromOptions')[this.params][this.rendered] = true;
    this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.disabled] = false;
    this.form.get('templateSelection')[this.params][this.rendered] = false;
    this.form.get('fetchedTemplate')[this.params][this.rendered] = false;
    this.form.get('removeLabelTemplate')[this.params][this.rendered] = false;
    this.form.get('fetchedTemplate').setValue('');
    const val = this.form.get('createFromOptions')[this.params][this.options];
    const val1 = this.form.get('requestOptionsLC')[this.params][this.options];
    this.toggleCreateFormButtons(val, val1, false);
    this.form.get('createFromOptions').setValue('');
    this.templateResponse.unsubscribe();
    this.productStateService.clearState();
    this.formModelService.getFormModel(FccGlobalConstant.PRODUCT_LC).subscribe(modelJson => {
      this.productStateService.initializeProductModel(modelJson);
      this.productStateService.initializeState(FccGlobalConstant.PRODUCT_LC);
      this.productStateService.populateAllEmptySectionsInState();
    });
    this.initializeFormGroup();
  }
  onClickRemoveLabelSR() {
    this.backtobackKey = FccGlobalConstant.BACK_TO_BACK_LC;
    this.onClickRemoveLabel();
  }
  resetRemoveLabelSR() {
    this.renderFormFieldsOnToggle(false);
    this.commonService.announceMission('yes');
    this.form.get('selectLCMessage')[this.params][this.rendered] = true;
    this.form.get('infoIcons')[this.params][this.rendered] = true;
    this.form.get('backToBackLC')[this.params][this.rendered] = true;
    this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.rendered] = false;
    this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.options] = [];
    this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.previewScreen] = false;
    this.form.get('removeLabelSR')[this.params][this.rendered] = false;
    this.form.get('tipAfterBackToBackSelect')[this.params][this.rendered] = false;
    // this.form.get(FccTradeFieldConstants.IS_BACK_TO_BACK_LC)[this.params][this.previewScreen] = false;
    this.removeFormValues();
    this.form.get('requestOptionsLC').setValue('01');
    const val = this.form.get('requestOptionsLC')[this.params][this.options];
    const val1 = this.form.get('createFromOptions')[this.params][this.options];
    this.toggleRequestButtons(val, val1, false);
    this.backToBackResponse.unsubscribe();
  }

  resetCreatForm() {
    if (this.form.get('fetchedTemplate') && this.form.get('fetchedTemplate').value) {
      this.form.get('createFromOptions').setValue('template');
    }
    if (this.form.get('fetchedRefValue') && this.form.get('fetchedRefValue').value) {
      this.form.get('createFromOptions').setValue('existinglc');
    }
    if ( (!(this.form.get('fetchedTemplate') && this.form.get('fetchedTemplate').value)) &&
     (!(this.form.get('fetchedRefValue') && this.form.get('fetchedRefValue').value))
     && this.form.get('requestOptionsLC').value !== '02') {
      this.form.get('createFromOptions').setValue('');
    }
    if ( (!(this.form.get('fetchedTemplate') && this.form.get('fetchedTemplate').value)) &&
     (!(this.form.get('fetchedRefValue') && this.form.get('fetchedRefValue').value))
     && this.form.get('requestOptionsLC').value === '02') {
      this.form.get('createFromOptions').setValue('upload');
    }
    // this.refreshFormElements();
  }

  /**
   *
   * @param Refresh form elements
   * Update/refresh form controls if page is rendered but transaction state has been updated due to late observable
   * response
   */
   refreshFormElements(): void {
    Object.keys(this.form.controls).forEach(control => {
      if (this.commonService.isNonEmptyValue(this.form.get(control)) && this.commonService.isNonEmptyValue(this.form.get(control).value)){
        this.form.get(control).setValue(this.form.get(control).value);
        this.form.get(control).updateValueAndValidity();
      }
    });
   }

  onClickTransmissionMode(data: any) {
    if (data.value === FccBusinessConstantsService.OTHER_99) {
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT_OTHER)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      this.togglePreviewScreen(this.form, [FccGlobalConstant.TRANS_MODE], false);
    } else {
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT_OTHER)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      this.togglePreviewScreen(this.form, [FccGlobalConstant.TRANS_MODE], true);
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT).setValue('');
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT).clearValidators();
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT).updateValueAndValidity();
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    }
    if (data.value !== FccBusinessConstantsService.SWIFT) {
      this.form.get('placeOfExpiry').setValue(`${this.translateService.instant('defaultExpiryPlace')}`);
      this.form.get('placeOfExpiry').setValidators([]);
      this.form.get('customerReference').setValidators([]);
      this.form.get('beneficiaryReference').setValidators([]);
      this.form.get('otherApplicableRules').setValidators([]);
      this.form.get('placeOfExpiry').updateValueAndValidity();
      this.form.addFCCValidators('customerReference', Validators.maxLength(this.custRefLength), 0);
      this.form.addFCCValidators('beneficiaryReference', Validators.maxLength(this.custRefLength), 0);
      this.form.addFCCValidators('otherApplicableRules', Validators.maxLength(FccGlobalConstant.LENGTH_35), 0);
    } else {
      this.form.get('placeOfExpiry').setValue(`${this.translateService.instant('defaultExpiryPlace')}`);
      this.form.addFCCValidators('placeOfExpiry', Validators.pattern(this.enquiryRegex), 0);
      this.form.addFCCValidators('otherApplicableRules', Validators.pattern('^[A-Za-z][A-Za-z0-9 ]*$'), 0);
      this.form.get('placeOfExpiry').updateValueAndValidity();
      this.form.get('otherApplicableRules').updateValueAndValidity();
      this.form.get('customerReference').updateValueAndValidity();
      this.form.get('beneficiaryReference').updateValueAndValidity();
    }
    this.commonService.isTransmissionModeChanged(this.form.get('transmissionMode').value);
  }

  onClickExistingLc() {
    this.setFieldsArrayNdSectionsData(false, FccGlobalConstant.PRODUCT_LC);
    const header = `${this.translateService.instant('existingLcList')}`;
    const productCode = 'productCode';
    const subProductCode = 'subProductCode';
    const headerDisplay = 'headerDisplay';
    const buttons = 'buttons';
    const savedList = 'savedList';
    const option = 'option';
    const downloadIconEnabled = 'downloadIconEnabled';
    const obj = {};
    obj[productCode] = FccGlobalConstant.PRODUCT_LC;
    obj[option] = 'Existing';
    obj[subProductCode] = FccGlobalConstant.LCSTD;
    obj[buttons] = false;
    obj[savedList] = false;
    obj[headerDisplay] = false;
    obj[downloadIconEnabled] = false;
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const fieldsArray = ['expiryDate', 'customerReference', 'amount', 'lcAvailableAmt', 'issueDateView'];
    this.resolverService.getSearchData(header, obj);
    this.lcResponse = this.searchLayoutService.searchLayoutDataSubject.subscribe((response) => {
      if (this.backToBackResponse !== undefined) {
        this.backToBackResponse.unsubscribe();
      }
      if (this.templateResponse !== undefined) {
        this.templateResponse.unsubscribe();
      }
      if (response !== null) {
        const provisionalTogglevalue = this.form.get(FccGlobalConstant.PROVISIONAL_TOGGLE).value;
        this.searchLayoutService.searchLayoutDataSubject.next(null);
        const prodCode = (response.responseData.TNX_ID !== undefined && response.responseData.TNX_ID !== null
          && response.responseData.TNX_ID !== FccGlobalConstant.EMPTY_STRING ) ?
          FccGlobalConstant.PRODUCT_LC : undefined;
        const eventIdToPass = (response.responseData.TNX_ID !== undefined && response.responseData.TNX_ID !== null
          && response.responseData.TNX_ID !== FccGlobalConstant.EMPTY_STRING ) ?
          response.responseData.TNX_ID : response.responseData.REF_ID;
        this.stateService.populateAllEmptySectionsInState(FccGlobalConstant.PRODUCT_LC);
        this.productMappingService.getApiModel(FccGlobalConstant.PRODUCT_LC).subscribe(apiMappingModel => {
        this.transactionDetailService.fetchTransactionDetails(eventIdToPass, prodCode, false).subscribe(responseData => {
        const responseObj = responseData.body;
        const setStateForProduct = {
          responseObject: responseObj,
          apiModel: apiMappingModel,
          isMaster: false,
          fieldsList: this.fieldsArray,
          sectionsList: this.sectionsArray
        };
        this.commonService.productState.next(setStateForProduct);
        this.form = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS);
        this.form.get('createFromOptions')[this.params][this.rendered] = false;
        this.form.get('referenceSelected')[this.params][this.rendered] = true;
        this.form.get('fetchedRefValue')[this.params][this.rendered] = true;
        this.form.get('removeLabel')[this.params][this.rendered] = true;
        this.form.get('fetchedRefValue').patchValue(response.responseData.REF_ID);
        this.form.get(FccTradeFieldConstants.PARENT_REFERENCE).patchValue(response.responseData.REF_ID);
        if ( !this.fieldsArray || this.fieldsArray.length === 0) {
          this.form.get(FccGlobalConstant.CUSTOMER_REF).setValue(FccGlobalConstant.EMPTY_STRING);
          this.form.get(FccGlobalConstant.BENEFICIARY_REFERNCE).setValue(FccGlobalConstant.EMPTY_STRING);
          if (this.purchaseOrderEnable && this.commonService.getUserPermissionFlag(FccGlobalConstant.LC_DISPLAY_PO_REF)) {
            this.form.get(FccGlobalConstant.PO_REF)[this.params][this.rendered] = true;
            this.form.get(FccGlobalConstant.PO_REF).setValue(FccGlobalConstant.EMPTY_STRING);
          }
          this.form.get(FccTradeFieldConstants.BANK_REFERENCE_VIEW).setValue(FccGlobalConstant.EMPTY_STRING);
          this.stateService.getSectionData(FccGlobalConstant.BANK_DETAILS).get('issuingBank').get('issuerReferenceList').
          setValue(FccGlobalConstant.EMPTY_STRING);
        }
        this.updateProvisionalLCToggle(provisionalTogglevalue);
        this.onClickProvisionalLCToggle();
        this.patchFieldParameters(this.form.get('fetchedRefValue'), { readonly: true });
        this.form.get('customerReference').setValue(FccGlobalConstant.EMPTY_STRING);
        if (this.form.get('issueDateView')) {
          this.form.get('issueDateView').setValue(FccGlobalConstant.EMPTY_STRING);
        }
        this.form.get(FccTradeFieldConstants.BANK_REFERENCE_VIEW).setValue(FccGlobalConstant.EMPTY_STRING);
        this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.disabled] = true;
        this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.previewScreen] = false;
        this.form.get('backToBackLCToggle').setValue(FccGlobalConstant.EMPTY_STRING);
        this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.rendered] = false;
        this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.previewScreen] = false;
        const val = this.form.get('createFromOptions')[this.params][this.options];
        const val1 = this.form.get('requestOptionsLC')[this.params][this.options];
        this.toggleCreateFormButtons(val, val1, true);
        this.onClickApplicableRulesOptions();
        this.removeUnwantedFieldsForExistingLC();
        this.leftSectionService.reEvaluateProgressBar.next(true);
      });
    });
      }
    });
  }

  removeUnwantedFieldsForExistingLC(){
    if (this.stateService.getSectionData(FccGlobalConstant.AMOUNT_CHARGE_DETAILS)
      && this.stateService.getSectionData(FccGlobalConstant.AMOUNT_CHARGE_DETAILS).get(FccGlobalConstant.AMOUNT_FIELD)){
        this.stateService.getSectionData(FccGlobalConstant.AMOUNT_CHARGE_DETAILS).get(FccGlobalConstant.AMOUNT_FIELD)
          .setValue(FccGlobalConstant.EMPTY_STRING);
        this.stateService.getSectionData(FccGlobalConstant.AMOUNT_CHARGE_DETAILS).get(FccGlobalConstant.CURRENCY)
          .setValue(FccGlobalConstant.EMPTY_STRING);
    }
    if (this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD)) {
      this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).patchValue(FccGlobalConstant.EMPTY_STRING);
    }
    if (this.stateService.getSectionData(FccGlobalConstant.SHIPMENT_DETAILS)
      && this.stateService.getSectionData(FccGlobalConstant.SHIPMENT_DETAILS).get(FccGlobalConstant.SHIPMENT_DATE_FIELD)){
      this.stateService.getSectionData(FccGlobalConstant.SHIPMENT_DETAILS).get(FccGlobalConstant.SHIPMENT_DATE_FIELD).setValue(null);
    }
    if (this.stateService.getSectionData(FccGlobalConstant.PAYMENT_DETAILS)
      && this.stateService.getSectionData(FccGlobalConstant.PAYMENT_DETAILS).get(FccGlobalConstant.FIXED_MATURITY_PAYMENT_DATE)) {
        this.stateService.getSectionData(FccGlobalConstant.PAYMENT_DETAILS).get(FccGlobalConstant.FIXED_MATURITY_PAYMENT_DATE)
          .setValue(FccGlobalConstant.EMPTY_STRING);
    }
  }

  toggleCreateFormButtons(val, val1, enable) {
    val.forEach( (element) => {
      element[this.disabled] = enable;
    });
  }

  toggleRequestButtons(val, val1, enable) {
    val.forEach( (element) => {
      element[this.disabled] = enable;
    });
    val1.forEach( (element) => {
      element[this.disabled] = enable;
    });
  }

  onClickExistingTemplate() {
    this.setFieldsArrayNdSectionsData(true, '');
    const header = `${this.translateService.instant('templateListing')}`;
    const productCode = 'productCode';
    const subProductCode = 'subProductCode';
    const headerDisplay = 'headerDisplay';
    const buttons = 'buttons';
    const savedList = 'savedList';
    const option = 'option';
    const downloadIconEnabled = 'downloadIconEnabled';
    const obj = {};
    obj[productCode] = FccGlobalConstant.PRODUCT_LC;
    obj[option] = FccGlobalConstant.CREATE_FROM_TEMPLATE;
    obj[subProductCode] = FccGlobalConstant.LCSTD;
    obj[buttons] = false;
    obj[savedList] = false;
    obj[headerDisplay] = false;
    obj[downloadIconEnabled] = false;
    this.resolverService.getSearchData(header, obj);
    this.commonService.actionsDisable = true;
    this.commonService.buttonsDisable = true;
    this.templateResponse = this.searchLayoutService.searchLayoutDataSubject.subscribe((response) => {
      if (this.backToBackResponse !== undefined) {
        this.backToBackResponse.unsubscribe();
      }
      if (this.lcResponse !== undefined) {
        this.lcResponse.unsubscribe();
      }
      if (response !== null) {
        this.searchLayoutService.searchLayoutDataSubject.next(null);
        this.getTemplateById(response.responseData.TEMPLATE_ID);
      }
      if (this.commonService.isnonEMptyString(this.form.get('requestOptionsLC').value) &&
      this.form.get('requestOptionsLC').value === FccGlobalConstant.CODE_02 && this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[this.params][FccGlobalConstant.REQUIRED] = false;
      } else if (this.commonService.isnonEMptyString(this.form.get('requestOptionsLC').value) &&
        this.form.get('requestOptionsLC').value === FccGlobalConstant.CODE_01 && this.tnxTypeCode === FccGlobalConstant.N002_NEW){
        this.form.get(FccGlobalConstant.APPLICABLE_RULES_OPTIONS)[this.params][FccGlobalConstant.REQUIRED] = true;
      }
    });

  }

  removeUnwantedFieldsForTemplate() {
    if (!this.excludedFieldsNdSections || this.excludedFieldsNdSections.length === 0) {
      this.form.get('customerReference').setValue('');
      this.form.get('expiryDate').setValue('');
    }
    this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.disabled] = true;
    this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE)[this.params][this.previewScreen] = false;
    this.form.get('createFromOptions')[this.params][this.rendered] = false;
  }

  getTemplateById(templateID) {
    const provisionalTogglevalue = this.form.get(FccGlobalConstant.PROVISIONAL_TOGGLE).value;
    this.stateService.populateAllEmptySectionsInState(FccGlobalConstant.PRODUCT_LC);
    this.productMappingService.getApiModel(FccGlobalConstant.PRODUCT_LC).subscribe(apiMappingModel => {
    this.transactionDetailService.fetchTransactionDetails(templateID, FccGlobalConstant.PRODUCT_LC, true).subscribe(responseData => {
      const responseObj = responseData.body;
      const setStateForProduct = {
        responseObject: responseObj,
        apiModel: apiMappingModel,
        isMaster: false,
        fieldsList: this.fieldsArray,
        sectionsList: this.sectionsArray
      };
      this.commonService.productState.next(setStateForProduct);
      this.form = this.stateService.getSectionData(this.sectionName);
      this.form.get('requestOptionsLC')[this.params][this.rendered] = false;
      this.form.get('templateSelection')[this.params][this.rendered] = true;
      this.form.get('fetchedTemplate')[this.params][this.rendered] = true;
      this.form.get('removeLabelTemplate')[this.params][this.rendered] = true;
      const element = document.createElement('div');
      element.innerHTML = templateID;
      templateID = element.textContent;
      this.form.get('fetchedTemplate').patchValue(templateID);
      this.updateProvisionalLCToggle(provisionalTogglevalue);
      this.onClickProvisionalLCToggle();
      this.patchFieldParameters(this.form.get('fetchedTemplate'), { readonly: true });
      const val = this.form.get('createFromOptions')[this.params][this.options];
      const val1 = this.form.get('requestOptionsLC')[this.params][this.options];
      this.toggleCreateFormButtons(val, val1, true);
      this.removeUnwantedFieldsForTemplate();
    });
  });
  }

  updateProvisionalLCToggle(val){
    this.form.get(FccGlobalConstant.PROVISIONAL_TOGGLE).setValue(val);
    this.form.get(FccGlobalConstant.PROVISIONAL_TOGGLE).updateValueAndValidity();
    this.form.updateValueAndValidity();
  }

  onClickBackToBackLC() {
    this.setFieldsArrayNdSectionsData(false, FccTradeFieldConstants.BACK_TO_BACK_LC_OPTION);
    const header = `${this.translateService.instant('existingLetterOfCredits')}`;
    const productCode = 'productCode';
    const subProductCode = 'subProductCode';
    const headerDisplay = 'headerDisplay';
    const buttons = 'buttons';
    const savedList = 'savedList';
    const option = 'option';
    const downloadIconEnabled = 'downloadIconEnabled';
    const obj = {};
    this.commonService.backTobackExpDateFilter = true;
    obj[productCode] = FccGlobalConstant.PRODUCT_LC;
    obj[option] = 'BackToBack';
    obj[subProductCode] = FccGlobalConstant.LCSTD;
    obj[buttons] = false;
    obj[savedList] = false;
    obj[headerDisplay] = false;
    obj[downloadIconEnabled] = false;
    obj[FccGlobalConstant.CURRENT_DATE] = this.currentDate;

    this.resolverService.getSearchData(header, obj);
    this.backToBackResponse = this.searchLayoutService.searchLayoutDataSubject.subscribe((response) => {
      if (this.templateResponse !== undefined) {
        this.templateResponse.unsubscribe();
      }
      if (this.lcResponse !== undefined) {
        this.lcResponse.unsubscribe();
      }
      if (response !== null) {
        this.form.get('selectLCMessage')[this.params][this.rendered] = false;
        this.form.get('infoIcons')[this.params][this.rendered] = false;
        this.form.get('backToBackLC')[this.params][this.rendered] = false;
        this.renderFormFieldsOnToggle(true);
        this.onClickApplicableRulesOptions();
        this.searchLayoutService.searchLayoutDataSubject.next(null);
        this.commonService.announceMission('no');
        this.commonService.setClearBackToBackLCfields('no');
        const val = this.form.get('requestOptionsLC')[this.params][this.options];
        const val1 = this.form.get('createFromOptions')[this.params][this.options];
        this.toggleRequestButtons(val, val1, true);
        this.stateService.populateAllEmptySectionsInState(FccGlobalConstant.PRODUCT_LC);
        const mode = 'INIT';
        this.initializeFormToLCDetailsResponse(response.responseData.REF_ID, mode);
      }
    });
  }

  initializeFormToLCDetailsResponse(response: any, mode?: any) {
    this.transactionDetailService.fetchTransactionDetails(response).subscribe(responseData => {
      const responseObj = responseData.body;
      this.commonService.setParentTnxInformation(responseObj);
      this.parentRefId = responseObj.ref_id;
      this.commonService.setShipmentExpiryDateForBackToBack(responseObj.last_ship_date);
      this.commonService.setAmountForBackToBack(responseObj.lc_amt);
      let dateParts;
      this.productMappingService.getApiModel(FccGlobalConstant.PRODUCT_LC, undefined, undefined, undefined,
                                              FccGlobalConstant.LC_BACK_TO_BACK).subscribe(apiMappingModel => {
      const setStateForProduct = {
        responseObject: responseObj,
        apiModel: apiMappingModel,
        isMaster: false,
        subTnxType: FccGlobalConstant.LC_BACK_TO_BACK,
        fieldsList: this.fieldsArray,
        sectionsList: this.sectionsArray,
        templateBacktoBack: true
      };
      if (mode !== 'EDIT') {
        this.commonService.productState.next(setStateForProduct);
      }
      this.form = this.stateService.getSectionData(this.sectionName);
      if (responseObj.exp_date) {
        dateParts = responseObj.exp_date.toString().split('/');
        this.expiryDateBackToBack = new Date(dateParts[FccGlobalConstant.LENGTH_2],
          dateParts[FccGlobalConstant.LENGTH_1] - FccGlobalConstant.LENGTH_1, dateParts[FccGlobalConstant.LENGTH_0]);
        if (mode !== 'EDIT'){
          this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).patchValue(this.expiryDateBackToBack);
            }
      }
      if (localStorage.getItem('langDir') === FccGlobalConstant.LANUGUAGE_DIR_ARABIC) {
        this.form.get('removeLabelSR')[this.params][this.styleClass] = 'removeLabelSRStyle arabicRemoveLabelSR';
      }
      this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE).setValue(FccBusinessConstantsService.YES);
      this.form.get('tipAfterBackToBackSelect')[this.params][this.rendered] = true;
      this.onClickProvisionalLCToggle();
      this.form.get('removeLabelSR')[this.params][this.rendered] = true;
      if (mode === 'EDIT') {
        this.form.get('removeLabelSR')[this.params][this.rendered] = false;
      } else {
        this.form.get('removeLabelSR')[this.params][this.rendered] = true;
      }
      this.form.get(FccTradeFieldConstants.PARENT_REFERENCE).patchValue(response);
      this.form.get(FccTradeFieldConstants.PARENT_REFERENCE)[this.params][this.previewScreen] = false;
      // this.form.get(FccTradeFieldConstants.IS_BACK_TO_BACK_LC)[this.params][this.previewScreen] = true;
      // this.form.get(FccTradeFieldConstants.IS_BACK_TO_BACK_LC)[this.params][this.rendered] = true;
      if (responseObj.bo_ref_id && (responseObj.bo_ref_id !== '' || responseObj.bo_ref_id !== null)) {
        this.form.get('parentBoRefId').setValue(responseObj.bo_ref_id);
      }
      const lcCardControl = this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS) as FCCFormControl;
      const cardData = this.productMappingService.getDetailsOfCardData(responseObj, lcCardControl);
      this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.options] = cardData;
      this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.rendered] = true;
      this.form.get('requestOptionsLC')[this.params][this.rendered] = false;
      this.form.get('createFrom')[this.params][this.rendered] = false;
      this.form.get('createFromOptions')[this.params][this.rendered] = false;
      this.form.get('parentReference')[this.params][this.rendered] = false;
      this.form.get('removeLabel')[this.params][this.rendered] = false;
      this.form.get('subTnxTypeCode').patchValue(FccGlobalConstant.LC_BACK_TO_BACK);
      this.onClickApplicableRulesOptions();
      this.leftSectionService.reEvaluateProgressBar.next(true);
    });
  });
  }
  onBlurExpiryDate() {
    this.validateExpiryDate();
  }

  onClickExpiryDate() {
    let expiryDate = this.form.get(this.expiryDateField).value;
    const currentDate = new Date();
    this.form.addFCCValidators(this.expiryDateField, Validators.pattern(FccGlobalConstant.datePattern), 0);
    if ((expiryDate !== null && expiryDate !== '')) {
    expiryDate = `${expiryDate.getDate()}/${(expiryDate.getMonth() + 1)}/${expiryDate.getFullYear()}`;
    expiryDate = (expiryDate !== '' && expiryDate !== null) ?
                                this.commonService.convertToDateFormat(expiryDate) : '';
    this.form.get(this.expiryDateField).clearValidators();
    if (expiryDate !== '' && (expiryDate.setHours(0, 0, 0, 0) < currentDate.setHours(0, 0, 0, 0)) ) {
      if (this.mode === FccGlobalConstant.EXISTING && this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
        this.form.get(this.expiryDateField).markAsTouched();
        this.form.get(this.expiryDateField).setValidators([expiryDateLessThanCurrentDate]);
      }
      if (this.mode === FccGlobalConstant.DRAFT_OPTION && this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
        this.form.get(this.expiryDateField).markAsTouched();
        this.form.get(this.expiryDateField).setValidators([Validators.required]);
      }
    } else {
      this.form.get(this.expiryDateField).clearValidators();
    }
    } else {
      this.form.get(this.expiryDateField).clearValidators();
      if (this.option !== FccGlobalConstant.TEMPLATE) {
        this.form.get(this.expiryDateField).setValidators([invalidDate]);
      }
    }
    this.validateExpiryDate();
    this.form.get(this.expiryDateField).updateValueAndValidity();
  }

  /**
   * Validate expiry Date
   */
  validateExpiryDate(): void {
    const expDate = this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).value;
    if (expDate !== '' && this.commonService.isNonEmptyValue(expDate)) {
      const lastShipmentDate =
      this.stateService.getSectionData(FccGlobalConstant.SHIPMENT_DETAILS).get(FccGlobalConstant.SHIPMENT_DATE_FIELD).value;
      if (lastShipmentDate && expDate && (expDate < lastShipmentDate)) {
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).clearValidators();
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).setValidators([compareExpDateWithLastShipmentDate]);
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).updateValueAndValidity();
      } else if (this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).value && this.expiryDateBackToBack &&
      this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).value > this.expiryDateBackToBack) {
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).setValidators([compareNewExpiryDateToOld]);
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).updateValueAndValidity();
      } else if (this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).value) {
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).clearValidators();
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).setValidators([compareExpiryDateToCurrentDate]);
        this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).updateValueAndValidity();
      } else {
        this.commonService.clearValidatorsAndUpdateValidity(FccGlobalConstant.EXPIRY_DATE_FIELD, this.form);
      }
    }
  }

  onClickBackToBackLCToggle() {
    const togglevalue = this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE).value;
    const previewScreenToggleControls = [FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE];
    if (togglevalue === FccBusinessConstantsService.NO) {
      this.renderFormFieldsOnToggle(true);
      this.onClickApplicableRulesOptions();
      this.commonService.announceMission('no');
      this.form.get('tipAfterBackToBackSelect')[this.params][this.rendered] = false;
      this.form.get('selectLCMessage')[this.params][this.rendered] = false;
      this.form.get('infoIcons')[this.params][this.rendered] = false;
      this.form.get('backToBackLC')[this.params][this.rendered] = false;
      this.form.get('removeLabelSR')[this.params][this.rendered] = false;
      this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.rendered] = false;
      this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.options] = [];
      this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.previewScreen] = false;
      this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).clearValidators();
      this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).updateValueAndValidity();
      this.removeFormValues();
     // this.form.get('requestOptionsLC')[this.params][this.rendered] = true;
      this.form.get('createFrom')[this.params][this.rendered] = true;
      this.form.get('createFromOptions')[this.params][this.rendered] = true;
      if (this.form.get(FccTradeFieldConstants.TRANS_MODE).value === '99') {
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT_OTHER)[this.params][this.rendered] = true;
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[this.params][this.rendered] = true;
        this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      }
      this.togglePreviewScreen(this.form, previewScreenToggleControls, false);
    } else {
      this.renderFormFieldsOnToggle(false);
      this.commonService.announceMission('yes');
      this.form.get('selectLCMessage')[this.params][this.rendered] = true;
      this.form.get('infoIcons')[this.params][this.rendered] = true;
      this.form.get('backToBackLC')[this.params][this.rendered] = true;
      this.form.get('requestOptionsLC')[this.params][this.rendered] = false;
      this.form.get('createFrom')[this.params][this.rendered] = false;
      this.form.get('createFromOptions')[this.params][this.rendered] = false;
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT_OTHER)[this.params][this.rendered] = false;
      this.form.get(FccTradeFieldConstants.ADVISE_SEND_MODE_TEXT)[this.params][this.rendered] = false;
      this.togglePreviewScreen(this.form, previewScreenToggleControls, true);
    }
    this.form.get(FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE).updateValueAndValidity();
    this.form.updateValueAndValidity();
  }
  renderFormFieldsOnToggle(val) {
    const fields = ['modeofTransmission', 'transmissionMode', 'expiryDate', 'placeOfExpiry', 'featureofLC', 'irv_flag', 'ntrf_flag',
    'revolving_flag', 'ApplicableRules', 'applicableRulesOptions', 'confirmationInstruction', 'confirmationOptions', 'references',
    'customerReference', 'beneficiaryReference', 'otherApplicableRules'];
    if (val) {
      fields.forEach(ele => {
        this.form.get(ele)[this.params][this.rendered] = true;
      });
    } else {
      fields.forEach(ele => {
        this.form.get(ele)[this.params][this.rendered] = false;
      });
    }
  }

  removeFormValues() {
    this.form.get(FccTradeFieldConstants.PARENT_REFERENCE).setValue('');
    this.form.get(FccTradeFieldConstants.PARENT_REFERENCE).updateValueAndValidity();
    this.form.get('subTnxTypeCode').setValue('');
    this.form.get('subTnxTypeCode').updateValueAndValidity();
    this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).setValue('');
    this.form.get(FccGlobalConstant.EXPIRY_DATE_FIELD).updateValueAndValidity();
    this.commonService.setAmountForBackToBack('');
    this.commonService.setShipmentExpiryDateForBackToBack('');
    this.commonService.setClearBackToBackLCfields('yes');
    const fields = ['applicantName', 'applicantFirstAddress', 'applicantSecondAddress',
    'applicantThirdAddress', 'applicantFullAddress', 'altApplicantName', 'altApplicantFirstAddress', 'altApplicantSecondAddress',
    'altApplicantThirdAddress', 'altApplicantFullAddress', 'beneficiaryFirstAddress', 'beneficiarySecondAddress',
    'beneficiaryThirdAddress', 'beneficiaryFullAddress', 'beneAbbvName'];

    fields.forEach(ele => {
      this.stateService.getSectionData(FccGlobalConstant.APPLICANT_BENEFICIARY).get(ele).setValue('');
      this.stateService.getSectionData(FccGlobalConstant.APPLICANT_BENEFICIARY).get(ele).updateValueAndValidity();
    });

    this.stateService.getSectionData(FccGlobalConstant.BANK_DETAILS).reset();
    this.stateService.getSectionData(FccGlobalConstant.AMOUNT_CHARGE_DETAILS).reset();
    this.stateService.getSectionData(FccGlobalConstant.PAYMENT_DETAILS).reset();
    this.stateService.getSectionData(FccGlobalConstant.SHIPMENT_DETAILS).reset();
    this.stateService.getSectionData(FccGlobalConstant.NARRATIVE_DETAILS).reset();
  }

  amendFormFields() {
    this.form.get('requestTypeLC')[this.params][this.rendered] = false;
    this.form.get('modeofTransmission')[this.params][this.rendered] = false;
    this.form.get('amendNarrativeText')[this.params][this.rendered] = true;
    this.form.get('amendmentNarrative')[this.params][this.rendered] = true;
    this.form.get('createFrom')[this.params][this.rendered] = false;
    this.form.get('createFromOptions')[this.params][this.rendered] = false;
    this.form.get('provisionalLCToggle')[this.params][this.rendered] = false;
    this.form.get('otherApplicableRules')[this.params][this.parentStyleClass] = 'otherApplicableRulesStyle';
    this.form.get('references')[this.params][this.styleClass] = 'viewModeSubHeader';
    this.amendCommonService.setValueFromMasterToPrevious(this.sectionName);
    this.form1 = this.stateService.getSectionData(FccGlobalConstant.NARRATIVE_DETAILS);
    this.expansionPanelSplitValue();
  }

  initializeFormGroup() {
    this.form = this.stateService.getSectionData(this.sectionName, undefined, this.isMasterRequired);
    this.form.get('provisionalLCToggle')[this.params][this.rendered] = true;
    this.form.get('provisionalLCToggle').updateValueAndValidity();
    this.form.get('requestOptionsLC')[this.params][this.rendered] = false;
    this.form.get('requestOptionsLC').updateValueAndValidity();
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
      if (this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS) &&
       this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.options] !== undefined)
      {
        this.form.get(FccTradeFieldConstants.LC_CARD_DETAILS)[this.params][this.rendered] = true;
      }
    }
    this.commonService.formatForm(this.form);
    this.form.updateValueAndValidity();
    if (this.form.get('placeOfExpiry').value === null) {
      this.form.get('placeOfExpiry').setValue(`${this.translateService.instant('defaultExpiryPlace')}`);
    }
  }

  expansionPanelSplitValue() {
    const goodsandDoc = 'goodsandDoc';
    const descOfGoods = 'descOfGoods';
    const docRequired = 'docRequired';
    const additionallnstruction = 'additionallnstruction';
    const otherDetails = 'otherDetails';
    const specialPaymentNarrativeBene = 'specialPaymentNarrativeBene';
    this.narrativeService.descOfGoodsLoad(this.form1, goodsandDoc, descOfGoods);
    this.narrativeService.docRequiredLoad(this.form1, goodsandDoc, docRequired);
    this.narrativeService.additionallnstructionLoad(this.form1, goodsandDoc, additionallnstruction);
    this.narrativeService.specialPaymentNarrativeBeneLoad(this.form1, otherDetails, specialPaymentNarrativeBene);
  }

  onBlurTemplateName() {
    if (!this.form.get('templateName')[this.params][this.readonly]) {
      const templateName = this.form.get('templateName').value;
      this.lcTemplateService.isTemplateNameExists(templateName, FccGlobalConstant.PRODUCT_LC).subscribe( res => {
        const jsonContent = res.body as string[];
        const isTemplateIdExists = jsonContent[`isTemplateIdExists`];
        if (isTemplateIdExists) {
          this.form.get('templateName').setErrors({ duplicateTemplateName: { templateName } });
        } else {
          this.form.get('templateName').setErrors(null);
        }
      });
    }
  }

  onClickPhraseIcon(event: any, key: any) {
    if (key === FccGlobalConstant.AMENDMENT_NARRATIVE) {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '13');
    } else {
    this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '10');
    }
  }


  onClickProvisionalLCToggle() {
    const provisionalTogglevalue = this.form.get(FccGlobalConstant.PROVISIONAL_TOGGLE).value;
    const provisionalControl = [FccGlobalConstant.PROVISIONAL_TOGGLE];
    if (provisionalTogglevalue === FccBusinessConstantsService.YES) {
      this.togglePreviewScreen(this.form, provisionalControl, true);
      this.form.get(FccGlobalConstant.REQUEST_OPTION_LC)[this.params][this.rendered] = false;
      this.togglePreviewScreen(this.form, [FccGlobalConstant.REQUEST_OPTION_LC], false);
    } else {
      this.togglePreviewScreen(this.form, provisionalControl, false);
      this.togglePreviewScreen(this.form, [FccGlobalConstant.REQUEST_OPTION_LC], true);
    }
    this.togglePreviewScreen(this.form, [FccGlobalConstant.BACK_TO_BACK_LC_TOGGLE], false);
    this.form.get(FccGlobalConstant.REQUEST_OPTION_LC).updateValueAndValidity();
    this.form.get(FccGlobalConstant.PROVISIONAL_TOGGLE).updateValueAndValidity();
    this.form.updateValueAndValidity();
  }

  subscribeChipResponse() {
    if (this.chipResponse === undefined || this.chipResponse === null) {
      this.chipResponse = this.commonService.responseChipConfirmationDialog$.subscribe(data => {
        if (data && data.action && data.controlName === 'createFromOptions') {
          this.handleResponse(data);
          this.commonService.responseChipConfirmationDialog$.next(null);
        }
      });
    }
  }
  purchaseOrderFieldRender(){
    if (this.purchaseOrderEnable && this.commonService.getUserPermissionFlag('lc_display_po_reference')) {
      this.form.get('purchaseOrderReference')[this.params][this.rendered] = true;
    }
  }
}
