import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService } from 'primeng';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { AmendCommonService } from './../../../../common/services/amend-common.service';
import { FccGlobalConstantService } from '../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../common/core/fcc-global-constants';
import { FormModelService } from '../../../../../common/services/form-model.service';
import { ProductMappingService } from '../../../../../common/services/productMapping.service';
import { ResolverService } from '../../../../../common/services/resolver.service';
import { LcTemplateService } from '../../../../../common/services/lc-template.service';
import { SearchLayoutService } from '../../../../../common/services/search-layout.service';
import { TransactionDetailService } from '../../../../../common/services/transactionDetail.service';
import { FormControlService } from '../../../../../corporate/trade/lc/initiation/services/form-control.service';
import { LcConstant } from '../../../lc/common/model/constant';
import { ProductStateService } from '../../../lc/common/services/product-state.service';
import { SaveDraftService } from '../../../lc/common/services/save-draft.service';
import { CurrencyConverterPipe } from '../../../lc/initiation/pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../lc/initiation/services/filelist.service';
import { PrevNextService } from '../../../lc/initiation/services/prev-next.service';
import { UtilityService } from '../../../lc/initiation/services/utility.service';
import { FCCFormGroup } from './../../../../../base/model/fcc-control.model';
import { CommonService } from './../../../../../common/services/common.service';
import { EventEmitterService } from './../../../../../common/services/event-emitter-service';
import { LeftSectionService } from './../../../../common/services/leftSection.service';
import {
  ConfirmationDialogComponent,
} from './../../../lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { EcProductComponent } from './../ec-product/ec-product.component';
import { PhrasesService } from './../../../../../common/services/phrases.service';
import { EcProductService } from '../../services/ec-product.service';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FccTradeFieldConstants } from '../../../common/fcc-trade-field-constants';
import { Validators } from '@angular/forms';

@Component({
  selector: 'app-ec-general-details',
  templateUrl: './ec-general-details.component.html',
  styleUrls: ['./ec-general-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: EcGeneralDetailsComponent }]
})
export class EcGeneralDetailsComponent extends EcProductComponent implements OnInit {

  @Output() messageToEmit = new EventEmitter<string>();
  lcConstant = new LcConstant();
  form: FCCFormGroup;
  module = `${this.translateService.instant('generalDetails')}`;
  contextPath: any;
  progressivebar: number;
  tnxTypeCode: any;
  barLength: any;
  params = this.lcConstant.params;
  rendered = this.lcConstant.rendered;
  templateResponse;
  copyFromResponse;
  styleClass = this.lcConstant.styleClass;
  disabled = this.lcConstant.disabled;
  options = this.lcConstant.options;
  readonly = this.lcConstant.readonly;
  option: any;
  custRefLength;
  mode: any;
  templateKey: string;
  refId: any;

  excludedFieldsNdSections: any;
  copyFromProductCode = '';
  excludingJsonFileKey = '';
  fieldsArray = [];
  sectionsArray = [];

  constructor(protected commonService: CommonService, protected leftSectionService: LeftSectionService,
              protected router: Router, protected translateService: TranslateService,
              protected prevNextService: PrevNextService,
              protected utilityService: UtilityService, protected saveDraftService: SaveDraftService,
              protected searchLayoutService: SearchLayoutService,
              protected lcTemplateService: LcTemplateService,
              protected formModelService: FormModelService, protected formControlService: FormControlService,
              protected stateService: ProductStateService, protected route: ActivatedRoute,
              protected eventEmitterService: EventEmitterService, protected transactionDetailService: TransactionDetailService,
              protected dialogService: DialogService,
              public fccGlobalConstantService: FccGlobalConstantService, protected productMappingService: ProductMappingService,
              protected fileList: FilelistService, protected dialogRef: DynamicDialogRef,
              protected confirmationService: ConfirmationService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected resolverService: ResolverService, protected amendCommonService: AmendCommonService,
              public phrasesService: PhrasesService, protected fileListSvc: FilelistService,
              protected currencyConverterPipe: CurrencyConverterPipe, protected ecProductService: EcProductService) {
      super(eventEmitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
        searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, ecProductService);
    }

  ngOnInit(): void {
    super.ngOnInit();
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.refId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.initializeFormGroup();
    this.barLength = this.leftSectionService.progressBarPerIncrease(FccGlobalConstant.EC_GENERAL_DETAILS);
    this.leftSectionService.progressBarData.subscribe(
      data => {
        this.progressivebar = data;
      }
    );
    this.templateChanges();
    if (this.mode === FccGlobalConstant.DRAFT_OPTION && this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      const productCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.PRODUCT);
      this.amendCommonService.compareTransactionAndMasterForAmend(productCode);
    }
    if (this.commonService.referenceId === undefined) {
      sessionStorage.removeItem(FccGlobalConstant.idempotencyKey);
    }
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.custRefLength = response.customerReferenceTradeLength;
        this.form.addFCCValidators('ecDraweeReference', Validators.maxLength(this.custRefLength), 0);
        this.form.addFCCValidators('ecCustomerReference', Validators.maxLength(this.custRefLength), 0);
      }
    });
    this.getExcludedFieldsNdSections();
  }

  getExcludedFieldsNdSections() {
    const productCode = FccGlobalConstant.PRODUCT_EC;
    const subProductCode = '';
    this.transactionDetailService.getExcludedFieldsNdSections(productCode, subProductCode).subscribe(
      (response) => {
        this.excludedFieldsNdSections = response.body;
      }, (error) => {
        // eslint-disable-next-line no-console
        console.log(error);
      }
    );
  }

  /**
   * Initialise the form from state servic
   */
  initializeFormGroup() {
    const sectionName = 'ecGeneralDetails';
    this.form = this.stateService.getSectionData(sectionName);
    const tnxId = this.form.get('tnxId').value;
    if (this.mode === FccGlobalConstant.INITIATE || this.mode === FccGlobalConstant.DRAFT_OPTION) {
      const collectionType = this.stateService.getSectionData('ecGeneralDetails').get('collectionTypeOptions');
      const collectionTypeOptions = collectionType[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS];
      const hasRegularPermission = this.commonService.getUserPermissionFlag('ec_regular');
      const hasDirectPermission = this.commonService.getUserPermissionFlag('ec_direct');
      const hasDirectAltPermission = this.commonService.getUserPermissionFlag('ec_direct_alt');
      if (collectionTypeOptions) {
          if (!hasRegularPermission) {
            this.removeOptionFromCollectionType(collectionTypeOptions, '01');
          }
          if (!hasDirectPermission) {
            this.removeOptionFromCollectionType(collectionTypeOptions, '02');
          }
          if (!hasDirectAltPermission) {
            this.removeOptionFromCollectionType(collectionTypeOptions, '03');
          }
          this.patchFieldParameters(this.form.get(FccGlobalConstant.COLECTION_TYPE_OPTIONS), { options: collectionTypeOptions });
        }
      }
    if ((this.tnxTypeCode === FccGlobalConstant.N002_AMEND) && (tnxId === null || tnxId === undefined || tnxId === '')) {
      this.fileListSvc.resetList();
      this.fileListSvc.resetDocumentList();
      const docSectionName = 'ecDocumentDetails';
      const form : FCCFormGroup = this.stateService.getSectionData(docSectionName);
      form.get('attachments').setValue(null);
      form.get(FccGlobalConstant.DOCUMENTS).setValue(null);
      this.stateService.setStateSection(docSectionName, form);
    }
    if (this.mode !== FccGlobalConstant.INITIATE && this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
      const collectionType = this.stateService.getSectionData('ecGeneralDetails').get('collectionTypeOptions');
      if (collectionType) {
        const colTypeVal = collectionType.value;
        const collectionTypeOptions = collectionType[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS];
        this.ecProductService.toggleCreateFormButtons(collectionTypeOptions, colTypeVal);
        this.onClickCollectionTypeOptions(collectionType);
      }
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
    }
    const createFromOptions = this.stateService.getSectionData('ecGeneralDetails').get(FccGlobalConstant.CREATE_FROM_OPERATIONS);
    if (createFromOptions && createFromOptions.value) {
      const collectionTypeOptions = createFromOptions[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS];
      this.disableCreateFormButtons(collectionTypeOptions, true);
    }
    this.commonService.formatForm(this.form);
    this.form.updateValueAndValidity();
  }

  amendFormFields() {
    if (this.form.get('docsSendMode').value !== null){
      const val = this.form.get('docsSendMode').value;
      if (val === '') {
        this.form.get('docsSendMode')[this.params][this.rendered] = false;
      }
    }
    this.form.get('amendNarrativeText')[this.params][this.rendered] = true;
    this.form.get('amendmentNarrative')[this.params][this.rendered] = true;
    this.amendCommonService.setValueFromMasterToPrevious('ecGeneralDetails');
  }

  saveFormOject() {
    this.stateService.setStateSection(FccGlobalConstant.EC_GENERAL_DETAILS, this.form);
  }

  onClickCollectionTypeOptions(event) {
    if (event.value === '02' || event.value === '03') {
      if (this.form.get('modeofTransmission')) {
        this.form.get('modeofTransmission')[this.params][this.rendered] = false;
      }
      if (this.form.get('docsSendMode')) {
        this.form.get('docsSendMode')[this.params][this.rendered] = false;
        this.form.get('docsSendMode').setValue('');
      }
    } else {
      if (this.form.get('modeofTransmission')) {
        this.form.get('modeofTransmission')[this.params][this.rendered] = true;
      }
      if (this.form.get('docsSendMode')) {
        this.form.get('docsSendMode')[this.params][this.rendered] = true;
      }
    }
  }

  onClickCreateFromOptions(data: any) {
    if (data.value === FccGlobalConstant.TEMPLATE_VALUE) {
      this.onClickExistingTemplate();
    } else if (data.value === FccGlobalConstant.COPY_FROM) {
      this.onClickCopyFrom();
    }
  }

  onBlurTemplateName() {
    if (this.commonService.isNonEmptyField(FccGlobalConstant.TEMPLATE_NAME, this.form)
    && (!this.form.get(FccGlobalConstant.TEMPLATE_NAME)[this.params][this.readonly])) {
      const templateName = this.form.get(FccGlobalConstant.TEMPLATE_NAME).value;
      this.lcTemplateService.isTemplateNameExists(templateName, FccGlobalConstant.PRODUCT_EC).subscribe( res => {
        const jsonContent = res.body as string[];
        const isTemplateIdExists = jsonContent[`isTemplateIdExists`];
        if (isTemplateIdExists) {
          this.form.get(FccGlobalConstant.TEMPLATE_NAME).setErrors({ duplicateTemplateName: { templateName } });
        } else {
          this.form.get(FccGlobalConstant.TEMPLATE_NAME).setErrors(null);
        }
      });
    }
  }

  onClickExistingTemplate() {
    this.setFieldsArrayNdSectionsData(true, '');

    const header = `${this.translateService.instant('ecTemplateListing')}`;
    const productCode = FccGlobalConstant.PRODUCT;
    const subProductCode = FccGlobalConstant.SUB_PRODUCT_CODE;
    const headerDisplay = FccGlobalConstant.HEADER_DISPLAY;
    const buttons = FccGlobalConstant.BUTTONS;
    const savedList = FccGlobalConstant.SAVED_LIST;
    const option = FccGlobalConstant.OPTION;
    const downloadIconEnabled = FccGlobalConstant.DOWNLOAD_ICON_ENABLED;
    const obj = {};
    obj[productCode] = FccGlobalConstant.PRODUCT_EC;
    obj[option] = FccGlobalConstant.CREATE_FROM_TEMPLATE;
    obj[subProductCode] = '';
    obj[buttons] = false;
    obj[savedList] = false;
    obj[headerDisplay] = false;
    obj[downloadIconEnabled] = false;
    this.commonService.actionsDisable = true;
    this.commonService.buttonsDisable = true;

    this.resolverService.getSearchData(header, obj);
    this.templateResponse = this.searchLayoutService.searchLayoutDataSubject.subscribe((response) => {
      if (response !== null) {
        this.searchLayoutService.searchLayoutDataSubject.next(null);
        this.getTemplateById(response.responseData.TEMPLATE_ID, response.responseData.EC_TYPE_CODE);
      }
    });

  }

  onClickCopyFrom() {
    this.setFieldsArrayNdSectionsData(false, FccGlobalConstant.PRODUCT_EC);

    const header = `${this.translateService.instant('copyFromEC')}`;
    const productCode = FccGlobalConstant.PRODUCT;
    const subProductCode = FccGlobalConstant.SUB_PRODUCT_CODE;
    const headerDisplay = FccGlobalConstant.HEADER_DISPLAY;
    const buttons = FccGlobalConstant.BUTTONS;
    const savedList = FccGlobalConstant.SAVED_LIST;
    const option = FccGlobalConstant.OPTION;
    const downloadIconEnabled = FccGlobalConstant.DOWNLOAD_ICON_ENABLED;
    const obj = {};
    obj[productCode] = FccGlobalConstant.PRODUCT_EC;
    obj[option] = 'Existing';
    obj[subProductCode] = '';
    obj[buttons] = false;
    obj[savedList] = false;
    obj[headerDisplay] = false;
    obj[downloadIconEnabled] = false;

    this.resolverService.getSearchData(header, obj);
    this.copyFromResponse = this.searchLayoutService.searchLayoutDataSubject.subscribe((response) => {
      if (response !== null) {
        this.searchLayoutService.searchLayoutDataSubject.next(null);
        this.copyFromRef(response.responseData.TNX_ID, response.responseData.REF_ID, response.responseData.EC_TYPE_CODE);
      }
    });

  }

  copyFromRef(tnxId: any, refId: any, ecTypeCode: any) {
    this.stateService.populateAllEmptySectionsInState(FccGlobalConstant.PRODUCT_EC);
    const prodCode = (tnxId !== undefined && tnxId !== null
      && tnxId !== FccGlobalConstant.EMPTY_STRING ) ?
      FccGlobalConstant.PRODUCT_EC : undefined;
    const eventIdToPass = (tnxId !== undefined && tnxId !== null
      && tnxId !== FccGlobalConstant.EMPTY_STRING ) ?
      tnxId : refId;
    this.productMappingService.getApiModel(FccGlobalConstant.PRODUCT_EC).subscribe(apiMappingModel => {
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
      const sectionName = FccGlobalConstant.EC_GENERAL_DETAILS;
      this.form = this.stateService.getSectionData(sectionName);
      this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS)[this.params][this.rendered] = false;
      this.form.get('referenceSelected')[this.params][this.rendered] = true;
      this.form.get('fetchedRefValue')[this.params][this.rendered] = true;
      this.form.get('removeLabel')[this.params][this.rendered] = true;
      this.form.get('fetchedRefValue').patchValue(refId);
      this.form.get('parentReference').patchValue(refId);
      this.patchFieldParameters(this.form.get('fetchedRefValue'), { readonly: true });
      this.form.get('ecCustomerReference').setValue(FccGlobalConstant.EMPTY_STRING);
      if (!this.fieldsArray || this.fieldsArray.length === 0) {
        this.form.get(FccTradeFieldConstants.BANK_REFERENCE).setValue(FccGlobalConstant.EMPTY_STRING);
      }
      this.patchFieldParameters(this.form.get('ecCustomerReference'), { readonly: false });
      this.patchFieldParameters(this.form.get(FccGlobalConstant.FETCHED_TEMPLATE), { readonly: true });
      this.form.get(FccGlobalConstant.COLECTION_TYPE_OPTIONS).setValue(ecTypeCode);
      this.stateService.getSectionData(FccGlobalConstant.DRAWER_DRAWEE).get('drawerEntity').setValue(responseObj.drawer_name);
      const collectionType = this.stateService.getSectionData(sectionName).get(FccGlobalConstant.COLECTION_TYPE_OPTIONS);
      this.onClickCollectionTypeOptions(collectionType);
    });
  });
  }

  setFieldsArrayNdSectionsData(isTemplate: boolean, productCode: string) {
    this.revertCopyFromDetails();
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
    const headerField = `${this.translateService.instant('removeSelectedTransaction')}`;
    const obj = {};
    const locaKey = 'locaKey';
    obj[locaKey] = this.templateKey ? this.templateKey : FccGlobalConstant.COPYFROM_EC_KEY;
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
        if (this.templateKey) {
          this.resetRemoveLabelTemplate();
        } else {
          this.resetFieldsForCopyFromTemplate();
        }
      }
      this.templateKey = null;
    });
  }

  toggleCreateFormButton(val, enable) {
    val.forEach( (element) => {
      element[this.disabled] = enable;
    });
  }

  removeUnwantedFieldsForTemplate() {
    if (!this.fieldsArray || this.fieldsArray.length === 0) {
      this.stateService.getSectionData(FccGlobalConstant.EC_BANK_DETAILS).get(FccGlobalConstant.REMITTING_BANK)
      .get(FccGlobalConstant.ISSUER_REFERENCE_LIST).setValue(FccGlobalConstant.EMPTY_STRING);
    }
  }
  getTemplateById(templateID, ecTypeCode) {
    this.stateService.populateAllEmptySectionsInState(FccGlobalConstant.PRODUCT_EC);
    this.transactionDetailService.fetchTransactionDetails(templateID, FccGlobalConstant.PRODUCT_EC, true).subscribe(responseData => {
      const responseObj = responseData.body;
      this.productMappingService.getApiModel(FccGlobalConstant.PRODUCT_EC).subscribe(apiMappingModel => {
      const setStateForProduct = {
        responseObject: responseObj,
        apiModel: apiMappingModel,
        isMaster: false,
        fieldsList: this.fieldsArray,
        sectionsList: this.sectionsArray
      };
      this.commonService.productState.next(setStateForProduct);
      const sectionName = FccGlobalConstant.EC_GENERAL_DETAILS;
      this.form = this.stateService.getSectionData(sectionName);
      this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS)[this.params][this.rendered] = false;
      this.form.get(FccGlobalConstant.TEMPLATE_SELECTION)[this.params][this.rendered] = true;
      this.form.get(FccGlobalConstant.FETCHED_TEMPLATE)[this.params][this.rendered] = true;
      this.form.get(FccGlobalConstant.REMOVE_LABEL_TEMPLATE)[this.params][this.rendered] = true;
      const element = document.createElement('div');
      element.innerHTML = templateID;
      templateID = element.textContent;
      this.form.get(FccGlobalConstant.FETCHED_TEMPLATE).patchValue(templateID);
      this.patchFieldParameters(this.form.get(FccGlobalConstant.FETCHED_TEMPLATE), { readonly: true });
      this.form.get(FccGlobalConstant.COLECTION_TYPE_OPTIONS).setValue(ecTypeCode);
      const collectionType = this.stateService.getSectionData(sectionName).get(FccGlobalConstant.COLECTION_TYPE_OPTIONS);
      this.onClickCollectionTypeOptions(collectionType);
      this.removeUnwantedFieldsForTemplate();
    });
  });
  }

  /**
   *  Reset fields for Copy From on click on confirmation from dialog box
   */
  resetFieldsForCopyFromTemplate() {
    this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS)[this.params][this.rendered] = true;
    this.form.get('referenceSelected')[this.params][this.rendered] = false;
    this.form.get('fetchedRefValue')[this.params][this.rendered] = false;
    this.form.get('removeLabel')[this.params][this.rendered] = false;
    this.form.get('fetchedRefValue').setValue('');
    const val = this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS)[this.params][this.options];
    const val1 = this.form.get(FccGlobalConstant.COLECTION_TYPE_OPTIONS)[this.params][this.options];
    this.toggleTemplateCreateFormButtons(val, val1, false);
    this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS).setValue('');
    this.copyFromResponse.unsubscribe();
    this.productStateService.clearState();
    this.formModelService.getFormAndSubSectionModel(FccGlobalConstant.PRODUCT_EC).subscribe(modelJson => {
      if (modelJson) {
        this.formModelService.subSectionJson = modelJson[1];
        this.productStateService.initializeState(FccGlobalConstant.PRODUCT_EC);
        this.productStateService.populateAllEmptySectionsInState();
        this.form.get('ecCustomerReference').setValue('');
      }
    });
  }

  onClickRemoveLabelTemplate() {
    this.templateKey = FccGlobalConstant.TEMPLATEFROM_KEY;
    this.onClickRemoveLabel();
  }

  resetRemoveLabelTemplate() {
    this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS)[this.params][this.rendered] = true;
    this.form.get(FccGlobalConstant.TEMPLATE_SELECTION)[this.params][this.rendered] = false;
    this.form.get(FccGlobalConstant.FETCHED_TEMPLATE)[this.params][this.rendered] = false;
    this.form.get(FccGlobalConstant.REMOVE_LABEL_TEMPLATE)[this.params][this.rendered] = false;
    this.form.get(FccGlobalConstant.FETCHED_TEMPLATE).setValue('');
    const val = this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS)[this.params][this.options];
    const val1 = this.form.get(FccGlobalConstant.COLECTION_TYPE_OPTIONS)[this.params][this.options];
    this.toggleTemplateCreateFormButtons(val, val1, false);
    this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS).setValue('');
    this.templateResponse.unsubscribe();
    this.productStateService.clearState();
    this.formModelService.getFormAndSubSectionModel(FccGlobalConstant.PRODUCT_EC).subscribe(modelJson => {
      if (modelJson) {
        this.formModelService.subSectionJson = modelJson[1];
        // this.productStateService.initializeProductModel(modelJson[0]); // probably not required again to initialize
        this.productStateService.initializeState(FccGlobalConstant.PRODUCT_EC);
        this.productStateService.populateAllEmptySectionsInState();
      }
    });
    this.initializeFormGroup();
  }

  toggleTemplateCreateFormButtons(val, val1, enable) {
    val.forEach( (element) => {
      element[this.disabled] = enable;
    });
  }

  disableCreateFormButtons(val, enable) {
    val.forEach( (element) => {
      element[this.disabled] = enable;
    });
  }

  ngAfterViewChecked() {
    if (this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
      this.resetCreatForm();
    }
  }

  resetCreatForm() {
    if ( this.form.get(FccGlobalConstant.FETCHED_TEMPLATE).value ) {
      this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS).setValue(FccGlobalConstant.TEMPLATE_VALUE);
    }
    if ( this.form.get(FccGlobalConstant.FETCH_REF_VALUE).value ) {
      this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS).setValue(FccGlobalConstant.COPY_FROM);
    }
    if ( (!this.form.get(FccGlobalConstant.FETCHED_TEMPLATE).value) && (!this.form.get(FccGlobalConstant.FETCH_REF_VALUE).value)) {
      this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS).setValue(FccGlobalConstant.EMPTY_STRING);
    }
  }

  templateChanges() {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.form.get(FccGlobalConstant.TEMPLATE_NAME)[this.params][this.rendered] = true;
      this.form.get(FccGlobalConstant.TEMPLATE_NAME)[this.params][FccGlobalConstant.REQUIRED] = true;
      this.form.get(FccGlobalConstant.TEMPLATE_DESC)[this.params][this.rendered] = true;
      this.form.get(FccGlobalConstant.CREATE_FROM)[this.params][this.rendered] = false;
      this.form.get(FccGlobalConstant.CREATE_FROM_OPERATIONS)[this.params][this.rendered] = false;
      this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_PRODUCT_CODE), FccGlobalConstant.SUBPRODUCT_DEFAULT, {});
      if (this.mode !== FccGlobalConstant.DRAFT_OPTION && !this.form.get(FccGlobalConstant.TEMPLATE_NAME).value) {
        this.commonService.generateTemplateName(FccGlobalConstant.PRODUCT_EC).subscribe( res => {
          const jsonContent = res.body as string[];
          const templateName = jsonContent[`templateName`];
          this.form.get(FccGlobalConstant.TEMPLATE_NAME).setValue(templateName);
        });
      }
    }
  }

  ngOnDestroy() {
    this.stateService.setStateSection(FccGlobalConstant.EC_GENERAL_DETAILS, this.form);
    this.templateResponse = null;
    if (this.form && this.commonService.isNonEmptyField(FccGlobalConstant.REMOVE_LABEL_TEMPLATE, this.form)) {
      this.form.get(FccGlobalConstant.REMOVE_LABEL_TEMPLATE)[this.params][this.rendered] = false;
    }
    this.copyFromResponse = null;
    if (this.form && this.commonService.isNonEmptyField('removeLabel', this.form)) {
      this.form.get('removeLabel')[this.params][this.rendered] = false;
    }
    this.commonService.actionsDisable = false;
    this.commonService.buttonsDisable = false;
  }

  onClickPhraseIcon(event: any, key: any) {
    this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_EC, key);
  }

  removeOptionFromCollectionType(collectionTypeOptions, codeValue) {
    for (let i = 0; i < collectionTypeOptions.length; i++) {
      const value = collectionTypeOptions[i].value;
      if (value === codeValue) {
        collectionTypeOptions.splice(i, 1);
        break;
      }
    }
  }

}
