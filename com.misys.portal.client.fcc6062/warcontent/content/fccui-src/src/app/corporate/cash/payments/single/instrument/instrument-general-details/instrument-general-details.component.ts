import { PaymentBatchService } from './../../../../../../common/services/payment.service';
import { InstrumentProductComponent } from './../instrument-product/instrument-product.component';
import { AfterViewInit, Component, EventEmitter, OnDestroy, OnInit, Output } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DialogService, DynamicDialogRef, ConfirmationService, SelectItem } from 'primeng';
import { Subscription } from 'rxjs';
import { CashCommonDataService } from '../../../../../../corporate/cash/services/cash-common-data.service';
import { FccConstants } from '../../../../../../common/core/fcc-constants';
import { PaymentInstrumentProductService } from '../../services/payment-instrument-product.service';
import { HOST_COMPONENT } from '../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FCCFormGroup } from '../../../../../../base/model/fcc-control.model';
import { CommonService } from '../../../../../../common/services/common.service';
import { LeftSectionService } from '../../../../../../corporate/common/services/leftSection.service';
import { PrevNextService } from '../../../../../../corporate/trade/lc/initiation/services/prev-next.service';
import { SaveDraftService } from '../../../../../../corporate/trade/lc/common/services/save-draft.service';
import { UtilityService } from '../../../../../../corporate/trade/lc/initiation/services/utility.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { FormModelService } from '../../../../../../common/services/form-model.service';
import { FormControlService } from '../../../../../../corporate/trade/lc/initiation/services/form-control.service';
import { ProductStateService } from '../../../../../../corporate/trade/lc/common/services/product-state.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { TransactionDetailService } from '../../../../../../common/services/transactionDetail.service';
import { FccGlobalConstantService } from '../../../../../../common/core/fcc-global-constant.service';
import { ProductMappingService } from '../../../../../../common/services/productMapping.service';
import { FilelistService } from '../../../../../../corporate/trade/lc/initiation/services/filelist.service';
import { CustomCommasInCurrenciesPipe } from '../../../../../../corporate/trade/lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { CurrencyConverterPipe } from '../../../../../../corporate/trade/lc/initiation/pipes/currency-converter.pipe';
import { MultiBankService } from '../../../../../../common/services/multi-bank.service';
import { DropDownAPIService } from '../../../../../../common/services/dropdownAPI.service';
import { FccTaskService } from '../../../../../../common/services/fcc-task.service';
import { DashboardService } from '../../../../../../common/services/dashboard.service';
import { CodeDataService } from '../../../../../../common/services/code-data.service';
import { FccGlobalConstant } from '../../../../../../common/core/fcc-global-constants';
import { FCMPaymentsConstants } from '../../model/fcm-payments-constant';
import { Validators } from '@angular/forms';
import { FccBusinessConstantsService } from '../../../../../../../app/common/core/fcc-business-constants.service';
import { CurrencyRequest } from '../../../../../../common/model/currency-request';
import { multipleEmailValidation } from '../../../../../common/validator/ValidationKeys';
import {
  ConfirmationDialogComponent
 } from '../../../../../../../app/corporate/trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { SessionValidateService } from '../../../../../../../app/common/services/session-validate-service';
import { DatePipe } from '@angular/common';
import { concatMap, debounceTime, filter } from 'rxjs/operators';
import { PreviewService } from '../../../../../../corporate/trade/lc/initiation/services/preview.service';

@Component({
  selector: 'app-instrument-general-details',
  templateUrl: './instrument-general-details.component.html',
  styleUrls: ['./instrument-general-details.component.scss'],
  providers: [
    { provide: HOST_COMPONENT, useExisting: InstrumentGeneralDetailsComponent }
  ]
})
export class InstrumentGeneralDetailsComponent extends InstrumentProductComponent implements OnInit, AfterViewInit, OnDestroy {
  @Output() messageToEmit = new EventEmitter<string>();
  form: FCCFormGroup;
  module = `${this.translateService.instant(FccConstants.INSTRUMENT_GENERAL_DETAILS)}`;
  mode;
  beneEditToggleVisible: boolean;
  subscriptions: Subscription[] = [];
  ifscResponse;
  iso;
  length2 = FccGlobalConstant.LENGTH_2;
  val;
  flagDecimalPlaces;
  allowedDecimals = -1;
  threeDecimal = 3;
  clientCodeAndName: any;
  finalArr = '';
  beneficiaryCustRefRegex: any;
  currency: SelectItem[] = [];
  curRequest: CurrencyRequest = new CurrencyRequest();
  eventValue = true;
  count =0;
  setPreviousvaluList: any;
  valMap = new Map();
  boolFieldclickVal = false;
  FieldValToOpenDialog: any;
  accountNumberRegex: any;
  maxDate: Date;
  holidayList: any[];
  beneficiaryCodeRegex: any;
  beneficiaryNameRegex: any;
  option;
  category;
  apiModel;
  mondayFlag: any;
  tuesdayFlag: any;
  wednesdayFlag: any;
  thrusdayFlag: any;
  fridayFlag: any;
  saturdayFlag: any;
  sundayFlag: any;
  maxDays: any;
  clientValMap = new Map();
  addNewMode = false;
  enrichmentFlags = FCMPaymentsConstants.enrichmentFlags;
  enrichmentConfig = FCMPaymentsConstants.enrichmentConfig
  enrichmentSubscriptions: Subscription[] = [];
  paymentRef = '';
  stopLoadingEnrichment = false;


  constructor(protected commonService: CommonService, protected leftSectionService: LeftSectionService,
              protected router: Router, protected translateService: TranslateService,
              protected prevNextService: PrevNextService,
              public datepipe: DatePipe,
              protected sessionValidation: SessionValidateService,
              protected utilityService: UtilityService, protected saveDraftService: SaveDraftService,
              protected searchLayoutService: SearchLayoutService,
              protected formModelService: FormModelService, protected formControlService: FormControlService,
              protected stateService: ProductStateService, protected route: ActivatedRoute,
              protected eventEmitterService: EventEmitterService, protected transactionDetailService: TransactionDetailService,
              protected dialogService: DialogService,
              public fccGlobalConstantService: FccGlobalConstantService, protected productMappingService: ProductMappingService,
              protected fileList: FilelistService, protected dialogRef: DynamicDialogRef,
              protected confirmationService: ConfirmationService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected resolverService: ResolverService,
              protected currencyConverterPipe: CurrencyConverterPipe,
              protected paymentInstrumentProductService: PaymentInstrumentProductService,
              protected multiBankService: MultiBankService,
              protected dropdownAPIService: DropDownAPIService,
              protected taskService: FccTaskService,
              protected dashboardService: DashboardService,
              protected previewService: PreviewService,
              protected paymentService: PaymentBatchService,
              protected translate: TranslateService,
              protected codeDataService: CodeDataService, protected cashCommonDataService: CashCommonDataService) {
      super(eventEmitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
        searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, paymentInstrumentProductService);

      }

  ngOnInit(): void {
    super.ngOnInit();
    this.resetEnrichConfigOnInit();
    this.mode = this.commonService.getQueryParametersFromKey(
      FccGlobalConstant.MODE
    );
    this.category = this.commonService.getQueryParametersFromKey(FccGlobalConstant.CATEGORY);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.operation = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION);
    this.stateService.autosaveProductCode = FccGlobalConstant.PRODUCT_IN;
    this.subscriptions.push(
      this.commonService.loadDefaultConfiguration().subscribe(response => {
        if (response && response.showStepper !== FccConstants.STRING_TRUE) {
          this.commonService.isStepperDisabled = true;
        }
      })
    );
    this.initializeFormGroup();
    this.initializeDropdownValues(FCMPaymentsConstants.FCM_FETCH_DATA_OPTIONS);
    this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.hasActions] = true;
    if (this.form.get(FCMPaymentsConstants.PAYMENT_REFERENCE).value) {
      this.paymentRef = this.form.get(FCMPaymentsConstants.PAYMENT_REFERENCE).value;
    }
    this.intializeEditForm();
    this.getApiModel();
    this.eventEmitterService.autoSaveForLater.subscribe(sectionName => {
      if(sectionName === FccConstants.INSTRUMENT_GENERAL_DETAILS) {
        this.commonService.autoSaveForm(
          this.productMappingService.buildFormDataJson(this.form, FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS)
          , this.stateService.getAutoSaveCreateFlagInState()
          , FccGlobalConstant.PRODUCT_IN
          , ''
          , this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION)
          ).subscribe(resp => {
            if (resp?.message) {
              this.stateService.setAutoSaveCreateFlagInState(false);
            }
          });
      }
    });

    this.eventEmitterService.renderSavedValues.subscribe(sectionName => {
      if(sectionName === FccConstants.INSTRUMENT_GENERAL_DETAILS) {
        this.onClickClientDetails();
        this.loadEnrichmentDataOnAutoSave();
      }
    });

    this.updateAdhocDetails();
    this.subscriptions.push(
    this.eventEmitterService.cancelTransaction.subscribe(sectionName => {
      if(sectionName === FccConstants.INSTRUMENT_GENERAL_DETAILS) {
        const paramKeys = {
          productCode : FccGlobalConstant.PRODUCT_IN,
          subProductCode : this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_PRODUCT_CODE),
          referenceId : this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID),
          option : this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION),
          tnxType : this.commonService.getQueryParametersFromKey(FccGlobalConstant.TRANSACTION_TYPE_CODE),
          subTnxtype : this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_TNX_TYPE)
         };
        this.commonService.deleteAutosave(
          paramKeys
          ).subscribe(resp=>{
            if (resp?.responseDetails?.message) {
              this.stateService.setAutoSaveCreateFlagInState(true);
            }
          });
      }
    })
    );
    this.commonService.batchRefId.next(null);
  }

  updateAdhocDetails() {
    if (this.form.get(FccConstants.BATCH_ADHOC_FLAG).value === FccConstants.BATCH_PAYMENT_ADHOC_FLOW) {
      FCMPaymentsConstants.FCM_BATCH_ADHOC_PAYMENT_FIELDS.forEach((field) => {
        this.form.get(field)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      });
      let filterParams: any = {};
      if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PRODUCT_ID).value)) {
        filterParams.paymenttype = this.form.get(FccConstants.FCM_PAYMENT_PRODUCT_ID).value;
        filterParams = JSON.stringify(filterParams);
        this.initializeDropdownValues(FCMPaymentsConstants.FCM_FETCH_ADHOC_BASED_OPTIONS, filterParams);
      }
      this.form.get('payTo')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.updateValueAndValidity();
    }
  }

  getApiModel() {
    this.productMappingService.getApiModel(undefined, undefined, undefined, undefined, undefined,
      FccGlobalConstant.BENEFICIARY_MASTER_MAINTENANCE_MC, this.category).subscribe(apiMappingModel => {
        this.apiModel = apiMappingModel;
      });
  }

  onClickBeneficiaryCode(event) {
    let beneficiaryObj;
    event.preventDefault();
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_BENEFICIARY_CODE).value) &&
    event?.currentTarget?.id !== FccConstants.FCM_BENEFICIARY_CODE ) {
      this.form.get(FCMPaymentsConstants.BENEFICIARY_NAME).setValue(this.form.get(FccConstants.FCM_BENEFICIARY_CODE).value);
      this.form.get(FCMPaymentsConstants.CREDITOR_CURRENCY).setValue(this.form.get(FccGlobalConstant.CURRENCY).value.label);
      if (this.apiModel) {
        beneficiaryObj = this.buildFCMBeneficiaryRequestObject(this.form,this.apiModel);
      }
      this.paymentService.fcmAdhocBeneficiaryCreation(beneficiaryObj).subscribe(response => {
        if(response && response.status === FccGlobalConstant.HTTP_RESPONSE_SUCCESS) {
          this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccConstants.FCM_SWITCH_HYPERLINK_AND_IMG] = true;
          this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccConstants.FCM_SWITCH_IMG_PATH] = true;
          this.form.updateValueAndValidity();
          beneficiaryObj = {};
        }
      },
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      error => {
        if(error?.error?.errors){
          const err = error?.error?.errors[0]?.code;
          const errMsg = this.translateService.instant(err);
          this.form.get(FccConstants.FCM_BENEFICIARY_CODE).setErrors({ savBeneMessage: errMsg });
        }
        this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccConstants.FCM_SWITCH_HYPERLINK_AND_IMG] = true;
        this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccConstants.FCM_SWITCH_IMG_PATH] = false;
        this.form.updateValueAndValidity();
      });
    }
  }


  onBlurBeneficiaryCode() {
    if (!this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_BENEFICIARY_CODE).value)) {
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccConstants.FCM_SWITCH_HYPERLINK_AND_IMG] = false;
      this.form.updateValueAndValidity();
    }
    let filterParams: any = {};
    filterParams.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
    filterParams.token = Math.floor(Math.random() * 1000);
    filterParams = JSON.stringify(filterParams);
    const beneCode = this.form.get(FccConstants.FCM_BENEFICIARY_CODE).value;
    this.subscriptions.push(
      this.commonService.getExternalStaticDataList(FccConstants.FCM_BENEFICIARY_CODE, filterParams).subscribe(response => {
        if(response) {
          response.forEach(val=>{
            if(beneCode === val?.receiver_code) {
              this.form.get(FccConstants.FCM_BENEFICIARY_CODE).setErrors({ beneficiaryCodeExist : true });
            }
          });
        }
      })
    );
  }

  onBlurEmailID(){
    this.updateEmailValidity();
  }

  buildFCMBeneficiaryRequestObject(form, mappingModel): any {
    const requestObject = {};
    const objModel = FCMPaymentsConstants.FCM_ADHOC_BENEFICIARY_FIELDS;
    const sectionFormValue = form;
    if (sectionFormValue.controls !== null && mappingModel !== null) {
      Object.keys(sectionFormValue.controls).forEach(key => {
        if (FCMPaymentsConstants.FCM_ADHOC_BENE_PAYMENT_FIELDS.includes(key)) {
          const control = sectionFormValue.controls[key];
          const mapping = objModel[key];
          let val = this.previewService.getPersistenceValue(control, false);
          if (key === FccConstants.FCM_PAYMENT_PAYMENT_TYPE) {
            val = val.replace(/\s/g,"").toUpperCase();
          }
          if(mapping != undefined && !this.commonService.isEmptyValue(val)) {
            this.createNested(mapping,requestObject, val);
          } else {
            const mappingKey = this.productMappingService.getRequestFieldNameFromMappingModel(key, mappingModel);
            if (control[FccGlobalConstant.PARAMS][FccConstants.MAP_BOOLEAN_VALUE]) {
              requestObject[mappingKey] = (val === FccGlobalConstant.CODE_Y) ? true : false;
            } else {
              requestObject[mappingKey] = val;
            }
          }
        }
      });
    }
    const data = [];
    data.push(requestObject['bankAccount']);
    requestObject['bankAccount'] = data;
    return requestObject;
  }

  createNested(mapping, requestObject, value){
    mapping = mapping.reverse();
    const lastIndex = mapping.length - 1;
    let child = {};
    let obj = {};
    mapping.forEach((element,index) => {
      if(index == 0){
        child[element] = value;
        obj = Object.assign({},child);
      } else if(index < mapping.length -2){
        obj = this.createChild(element,child);
        child = Object.assign({},obj);
      }
    });
    const val = mapping.length > 2 ? obj : value;
    if(requestObject[mapping[lastIndex]] !== undefined && requestObject[mapping[lastIndex]] !== null){
      const temp = Object.assign({},requestObject[mapping[lastIndex]][mapping[lastIndex-1]]);
      if(typeof val === 'string') {
        if (mapping[lastIndex-1] === 'isDefaultAccount') {
          requestObject[mapping[lastIndex]][mapping[lastIndex-1]] = (val === FccGlobalConstant.CODE_Y) ? true : false;
        } else {
          requestObject[mapping[lastIndex]][mapping[lastIndex-1]] = val;
        }
      } else {
        requestObject[mapping[lastIndex]][mapping[lastIndex-1]] = Object.assign(temp,val);
      }
    } else {
      requestObject[mapping[lastIndex]] = this.createChild([mapping[lastIndex-1]],val);
    }
    mapping.reverse();
  }

  createChild(key,obj){
    return { [key] : obj };
  }

  ngAfterViewInit(): void {
    this.getEnrichmentConfigFromService();
    if (this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION) === FccGlobalConstant.ADD_FEATURES) {
      this.callAutoSave();
      this.commonService.getProductCode.next(FccGlobalConstant.PRODUCT_IN);
      if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value)){
        this.enrichmentFlags.preloadData = true;
        this.paymentInstrumentProductService.isNextFlag = false;
      }
      this.stopLoadingEnrichment = false;
      this.onClickPaymentPackages();
      this.onClickAdditionalInformation();
    }
  }

  callAutoSave(){
    if (this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION) === FccGlobalConstant.ADD_FEATURES) {
      this.subscriptions.push(this.form.valueChanges
        .pipe(
              filter(() => this.form.dirty && this.stateService.getAutoSaveConfig()?.isAutoSaveEnabled),
              debounceTime(this.stateService.getAutoSaveConfig()?.autoSaveDelay),
              concatMap(() => this.commonService.autoSaveForm(
                  this.productMappingService.buildFormDataJson(this.form, FccConstants.INSTRUMENT_GENERAL_DETAILS)
                  , this.stateService.getAutoSaveCreateFlagInState()
                  , FccGlobalConstant.PRODUCT_IN
                  , null
                  , this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION)
                  )
                )
              )
        .subscribe(resp => {
          if (resp?.message) {
            this.stateService.setAutoSaveCreateFlagInState(false);
          }
          if(resp?.responseDetails) {
            this.stateService.setAutoSavedTime(resp?.responseDetails?.lastUpdatedDateTime);
          }
          this.stateService.setStateSection(FccConstants.INSTRUMENT_GENERAL_DETAILS, this.form);
        })
        );
    }
  }

 openDialogForClientCode(){
  const clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
  let preClientName = this.valMap.get(FccConstants.FCM_CLIENT_CODE_DETAILS);
  if(preClientName === undefined){
    preClientName = this.clientValMap.get(FccConstants.FCM_CLIENT_CODE_DETAILS);
  }
  if (this.commonService.isNonEmptyValue(preClientName) && preClientName.label !== clientCode ){
    if(this.count === 0){
    this.openDialog();
    }
  }
 }

 openDialogForPaymentPackage(){
  const paymentpackage = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value.label;
  const prePackage = this.valMap.get(FccConstants.FCM_PAYMENT_PACKAGES);
  if (this.commonService.isNonEmptyValue(prePackage) && prePackage.label !== paymentpackage){
    if(this.count === 0){
    this.openDialog();
    }
  } else if( this.FieldValToOpenDialog === 'paymentPackClick'){
    this.loadFieldBasedOnPackage();
  }
 }

 loadFieldBasedOnPackage(){
  let filterParams: any = {};
  filterParams.packageCode = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value?.productCode;
  filterParams = JSON.stringify(filterParams);
  this.initializeDropdownValues(FCMPaymentsConstants.FCM_FETCH_PACKAGE_BASED_OPTIONS, filterParams);
  this.initializeCheckboxVal(FCMPaymentsConstants.FCM_FETCH_CONFIDENTIALITY_CHECKBOX, filterParams);
  if(!this.enrichmentFlags.preloadData || this.commonService.isObjectEmpty(this.enrichmentConfig.enrichmentFields)){
    // this.updatePakageChangeFlag();
    if(!this.stopLoadingEnrichment){
      this.loadEnrichmentConfig();
    }
    this.stopLoadingEnrichment = false;
  }
 }

  onClickClientDetails() {
    let filterParams: any = {};
    const clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
    this.clientCodeAndName = clientCode;
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value)) {
    this.FieldValToOpenDialog = 'clientCodeClick';
    this.form.get('clientName')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    this.patchFieldValueAndParameters(this.form.get('clientName'),
            this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.name, {});
            this.openDialogForClientCode();
    }
      filterParams.clientCode = clientCode;
      filterParams = JSON.stringify(filterParams);
    this.initializeDropdownValues(FCMPaymentsConstants.FCM_FETCH_DATA_PAYMENT_PACKAGE, filterParams);
  }

  onKeyupClientDetails(event) {
    if (event.key === 'Enter') {
      this.onClickClientDetails();
    }
  }

  onKeyupPaymentPackages(event) {
    if (event.key === 'Enter') {
      this.stopLoadingEnrichment = false;
      this.onClickPaymentPackages();
    }
  }

  onKeyupBeneficiaryBankIfscCode(event) {
    const keycodeIs = event.which || event.keyCode;
    if (keycodeIs === FccGlobalConstant.LENGTH_13 || keycodeIs === FccGlobalConstant.LENGTH_38
      || keycodeIs === FccGlobalConstant.LENGTH_40) {
      this.onClickBeneficiaryBankIfscCode();
    }
  }

  onKeyupBeneficiaryBankIfscCodeIcons(event) {
    const keycodeIs = event.which || event.keyCode;
    if (keycodeIs === FccGlobalConstant.LENGTH_13) {
      this.onClickBeneficiaryBankIfscCodeIcons();
    }
  }

  getRegexValidation() {
    this.commonService.getConfiguredValues('PAYMENT_SINGLE_CUSTREFLIECODE_VALIDATION,BENEFICIARY_FORM_ACCOUNT_NUMBER_VALIDATION,'
    + 'BENEFICIARY_FORM_BENE_CODE_VALIDATION,BENEFICIARY_FORM_BENE_NAME_VALIDATION')
  .subscribe(resp => {
    if (resp.response && resp.response === 'REST_API_SUCCESS') {
      this.beneficiaryCustRefRegex = resp.PAYMENT_SINGLE_CUSTREFLIECODE_VALIDATION;
      this.accountNumberRegex = resp.BENEFICIARY_FORM_ACCOUNT_NUMBER_VALIDATION;
      this.beneficiaryCodeRegex = resp.BENEFICIARY_FORM_BENE_CODE_VALIDATION;
      this.beneficiaryNameRegex = resp.BENEFICIARY_FORM_BENE_NAME_VALIDATION;
      this.doBeneFormValidation();
    }});

  }

  doBeneFormValidation() {

    this.form.addFCCValidators(
      FccConstants.FCM_BENEFICIARY_CODE,
      Validators.pattern(this.beneficiaryCodeRegex),
      0
    );
      this.form.addFCCValidators(
        FccConstants.FCM_CUSTOMER_REF,
        Validators.pattern(this.beneficiaryCustRefRegex),
        0
      );

      this.form.addFCCValidators(
        FccConstants.FCM_LEI_CODE,
        Validators.compose([
          Validators.pattern(this.beneficiaryCustRefRegex),
        ]),
        0
      );

      if(typeof (this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).value) === 'string'){
        this.form.addFCCValidators(
          FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME,
          Validators.pattern(this.beneficiaryNameRegex),
          0
        );
      } else {
        this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).clearValidators();
        this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).setErrors(null);
        this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).setValidators([Validators.required]);
        this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).updateValueAndValidity();
      }

      this.form.addFCCValidators(
        FccConstants.FCM_ACCOUNT_NO,
        Validators.pattern(this.accountNumberRegex),
        0
      );

      this.form.addFCCValidators(
        FccConstants.FCM_CONFIRM_ACCONT_NO,
        Validators.pattern(this.accountNumberRegex),
        0
      );

  }
  addEnrichmentValidation(){
    this.enrichmentConfig.enrichmentFieldsName.forEach(element => {
      const field = this.form.get(element);
      if(!this.commonService.isEmptyValue(field)){
        if(this.enrichmentConfig.enrichmentFields[element].dataType == FccGlobalConstant.TYPE_NUMERIC){
          this.form.addFCCValidators(
            element,
            Validators.compose([
              Validators.pattern(FccGlobalConstant.NUMBER_REGEX),
            ]),
            0
          );
        } else if(this.enrichmentConfig.enrichmentFields[element].dataType == FccGlobalConstant.TYPE_AMOUNT){
          this.form.addFCCValidators(
            element,
            Validators.compose([
              Validators.pattern(FccGlobalConstant.AMOUNT_VALIDATION),
            ]),
            0
          );
        }
        this.setRequiredOnly(this.form, element, this.enrichmentConfig.enrichmentFields[element].required);
      }
    });
    this.form.updateValueAndValidity();
  }

  onClickPaymentPackages() {
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value)) {
      this.FieldValToOpenDialog = 'paymentPackClick';
      this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.patchFieldValueAndParameters(this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE),
            this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value.name, {});
      this.patchFieldValueAndParameters(this.form.get(FccConstants.FCM_PAYMENT_TYPE_ID),
            this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value.paymentType, {});
      this.setRenderOnlyFields(
        this.form,
        FCMPaymentsConstants.DISPLAY_PAYMENT_DETAILS_FIELDS,
        true
      );
      this.valMap.set(FccConstants.FCM_CLIENT_CODE_DETAILS,this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value);
      this.valMap.set(FccConstants.FCM_CLIENT_NAME,this.form.get(FccConstants.FCM_CLIENT_NAME).value);
      this.clientValMap.set(FccConstants.FCM_CLIENT_CODE_DETAILS,this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value);
      this.clientValMap.set(FccConstants.FCM_CLIENT_NAME,this.form.get(FccConstants.FCM_CLIENT_NAME).value);

      this.openDialogForPaymentPackage();
      let filterParams: any = {};
        if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_TYPE_ID).value)) {
          filterParams.paymentTypeId = this.form.get(FccConstants.FCM_PAYMENT_TYPE_ID).value;
          filterParams = JSON.stringify(filterParams);
          this.subscriptions.push(
            this.commonService.getExternalStaticDataList(FccConstants.FCM_PAYMENT_PRODUCT_ID, filterParams).subscribe(response => {
              if(response) {
                this.patchFieldValueAndParameters(this.form.get(FccConstants.FCM_PAYMENT_PRODUCT_ID),
                          response[0].product_id, {});
              }
            })
          );
        }
    }
    if (this.form.get(FccConstants.FCM_BENEFECIARY_NAME).value) {
      this.form.get(FccConstants.FCM_PAYMENT_PAY_TO)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.updateValueAndValidity();
    }

    let filterParamsTemp: any = {};
    if(this.operation === FccGlobalConstant.UPDATE_FEATURES 
        && this.commonService.isNonEmptyValue(this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value)){
      const packageOptions = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES)[FccConstants.PARAMS][FccConstants.OPTIONS];
      const form = this.form;
      const selectedPackage = packageOptions?.filter(ele => ele.value?.productCode === form.get(FccConstants.FCM_PAYMENT_PACKAGES).value);
      if(this.commonService.isNonEmptyValue(selectedPackage) && selectedPackage.length > 0){
        filterParamsTemp.packageCode = selectedPackage[0].value?.productCode;
      }
    } else {
      filterParamsTemp.packageCode = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value?.productCode;
    }
    filterParamsTemp.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
    filterParamsTemp = JSON.stringify(filterParamsTemp);
    this.initializeDropdownValues(FCMPaymentsConstants.FCM_PAY_FROM, filterParamsTemp);

  }
  onClickPaymentProductType() {
    let filterParams: any = {};
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PRODUCT_TYPE).value)) {
      this.valMap.set(FccConstants.FCM_PAYMENT_PACKAGES,this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value);
      this.valMap.set(FccConstants.FCM_PAYMENT_PAYMENT_TYPE,this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE).value);
      this.checkCutOffTimings();
      filterParams.packageCode = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value?.productCode;
      filterParams.productCode = this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.label;
      filterParams = JSON.stringify(filterParams);
      this.initializeDropdownValues(FCMPaymentsConstants.FCM_FETCH_PRODUCT_CODE_BASED_OPTIONS, filterParams);

      if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).value)) {
        this.onClickAmount();
        this.onBlurAmount();
      }
    }
  }

  onChangeCustomerReferenceNumber() {
    if(this.form.get(FCMPaymentsConstants.CUSTOMER_REFERENCE_NUMBER).value) {
      this.form.get(FCMPaymentsConstants.PAYMENT_REFERENCE).setValue(this.form.get(FCMPaymentsConstants.CUSTOMER_REFERENCE_NUMBER).value);
    } else {
      this.form.get(FCMPaymentsConstants.PAYMENT_REFERENCE).setValue(this.paymentRef);
    }
  }

  checkCutOffTimings() {
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PRODUCT_TYPE).value)) {
      const time = new Date();
      const getSystemHour = time.getHours();
      const getSystemMin = time.getMinutes();
      if(this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.time)){
        const productTime = this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.time;
        const spiltProductTime = productTime.split(':');
        const productTimeHour = parseInt(spiltProductTime[0]);
        const productTimeMin = parseInt(spiltProductTime[1]);
        if (getSystemHour >= productTimeHour && getSystemMin > productTimeMin){
          this.form.get(FccConstants.FCM_PRODUCT_TYPE)[FccGlobalConstant.PARAMS].warning = '';
          this.form.get(FccConstants.FCM_PRODUCT_TYPE).setErrors({ productCutOffTime: true });
        }
      }
    }
  }

  onClickEffectiveDate(){
      const currentDate = new Date();
      const date = currentDate.getDate();
      const val = this.form.get('effectiveDate').value;
      const maxdate = this.form.get(FccConstants.FCM_PAYMENT_EFFECTIVE_DATE)[FccGlobalConstant.PARAMS]['maxDate'];
      const date2 = val.getDate();
      if (date === date2) {
        if(this.form.get(FccConstants.FCM_PRODUCT_TYPE).getError !== null){
          const error = this.form.get(FccConstants.FCM_PRODUCT_TYPE).getError('productCutOffTime');
          if(error){
            this.form.get('effectiveDate')[FccGlobalConstant.PARAMS].warning = '';
            this.form.get('effectiveDate').setErrors({ effectiveDateSelection: true });
            this.form.updateValueAndValidity();
          }
     }
    }
    else if(currentDate.getTime() > val.getTime()){
      this.form.get('effectiveDate')[FccGlobalConstant.PARAMS].warning = '';
      this.form.get('effectiveDate').setErrors({ backDatederror: true });
      this.form.updateValueAndValidity();
    } else if(val?.getTime() > maxdate?.getTime()){
      this.form.get('effectiveDate')[FccGlobalConstant.PARAMS].warning = '';
      this.form.get('effectiveDate').setErrors({ futureDateerror: true });
      this.form.updateValueAndValidity();
    }
    else{
      this.form.get(FccConstants.FCM_PRODUCT_TYPE).setErrors(null);
      this.form.updateValueAndValidity();
    }

  }
  onClickPayFrom(){
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PAY_FROM).value)) {
    this.valMap.set(FccConstants.FCM_PAYMENT_PACKAGES,this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value);
    this.valMap.set(this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE),this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE).value);
    this.form.get(FCMPaymentsConstants.DEBTOR_CURRENCY).setValue(this.form.get(FCMPaymentsConstants.PAY_FROM).value.currency);
    this.form.get(FCMPaymentsConstants.DEBTOR_ACCOUNT_TYPE).setValue(this.form.get(FCMPaymentsConstants.PAY_FROM).value.accountType);
    this.form.get(FCMPaymentsConstants.DEBTOR_NAME).setValue(this.form.get(FCMPaymentsConstants.PAY_FROM).value.accountName);
    this.form.get(FCMPaymentsConstants.DEBTOR_ACCOUNT_ID).setValue(this.form.get(FCMPaymentsConstants.PAY_FROM).value.accountId);
    }
  }

  onClickPayTo(){
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).value)) {
      const data = {
        value : this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).value.accountType,
        shortName : this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).value.accountType,
        label : this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).value.accountType
      };
      this.form.get(FCMPaymentsConstants.ACCOUNT_TYPE).setValue(data);
      this.form.get(FCMPaymentsConstants.ACCOUNT_NUMBER).setValue(this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).value.label);
      this.form.get(FCMPaymentsConstants.CREDITOR_CURRENCY).setValue(this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).value.currency);
    }
  }

  onClickBeneficiaryNameCode() {
    let filterParams: any = {};
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).value)) {
     this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
     this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      filterParams.packageCode = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value?.productCode;
      filterParams.productCode = this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.label;
      filterParams.receiverCode = this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).value.label;
      filterParams = JSON.stringify(filterParams);
      this.initializeDropdownValues(FCMPaymentsConstants.FCM_FETCH_BENEFICIARY_CODE_BASED_OPTIONS, filterParams);
      this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.PARAMS]['shortDescription'] = "";
      this.form.get(FCMPaymentsConstants.BENEFICIARY_NAME).setValue(
        this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).value.label);
      this.onClickPayTo();
      this.getRegexValidation();
      if(this.form.get(FccConstants.BATCH_ADHOC_FLAG).value === FccConstants.BATCH_PAYMENT_NON_ADHOC_FLOW){
        this.form.get(FCMPaymentsConstants.BENEFICIARY_ADHOC_NAME).setValue(null);
      }
    } else {
      const checkboxVal = this.form.get(FccConstants.FCM_ADD_BENE_CHECKBOX).value;
      if (this.commonService.isnonEMptyString(this.form.get(FCMPaymentsConstants.BENEFICIARY_ADHOC_NAME).value)
      && this.form.get(FccConstants.BATCH_ADHOC_FLAG).value === FccConstants.BATCH_PAYMENT_ADHOC_FLOW)
      {
        this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).setValue(
          this.form.get(FCMPaymentsConstants.BENEFICIARY_ADHOC_NAME).value);
          if (checkboxVal === FccBusinessConstantsService.YES) {
            this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
            this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
          } else {
            this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
            this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
          }
      } else {
        this.form.get(FccConstants.FCM_ADD_BENE_CHECKBOX).setValue('N');
        this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).setValue('');
      }

    }
  }


   // method to check if adhoc beneficiary save can be performed
   checkBeneSaveAllowed(toggleValue){
    this.beneEditToggleVisible = toggleValue;
    if (this.beneEditToggleVisible){
      this.form.get(FccConstants.FCM_PAYMENT_PAY_TO)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).setValue('');
      this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).clearValidators();
      this.form.get(FccConstants.BATCH_ADHOC_FLAG).setValue(FccConstants.BATCH_PAYMENT_ADHOC_FLOW);
      this.form.get(FCMPaymentsConstants.BENEFICIARY_NAME).setValue('');
      this.form.get(FccConstants.FCM_ACCOUNT_NO).setValue('');
      this.form.get(FccConstants.FCM_ACCOUNT_NO).clearValidators();
      this.setRenderOnlyFields(
        this.form,
        FCMPaymentsConstants.DISPLAY_ADHOC_BENEFICIARY_FIELDS,
        true
      );
      this.form.get(FccConstants.FCM_ADD_BENE_CHECKBOX).setValue('N');
      this.setRequired(this.form,
        FCMPaymentsConstants.REQUIRED_ADHOC_BENEFICIARY_FIELDS,
        true);
      this.getRegexValidation();
      if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).value)) {
        this.form.get(FCMPaymentsConstants.BENEFICIARY_ADHOC_NAME).setValue(
          this.form.get(FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME).value);
        let filterParams: any = {};
        if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PRODUCT_ID).value)) {
          filterParams.paymenttype = this.form.get(FccConstants.FCM_PAYMENT_PRODUCT_ID).value;
          filterParams = JSON.stringify(filterParams);
          this.initializeDropdownValues(FCMPaymentsConstants.FCM_FETCH_ADHOC_BASED_OPTIONS, filterParams);
        }
      }
    }
  else{
    if (!this.beneEditToggleVisible){
      this.form.get(FccConstants.FCM_PAYMENT_PAY_TO)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get(FccConstants.BATCH_ADHOC_FLAG).setValue(FccConstants.BATCH_PAYMENT_NON_ADHOC_FLOW);
      this.setRenderOnlyFields(
        this.form,
        FCMPaymentsConstants.DISPLAY_ADHOC_BENEFICIARY_FIELDS,
        false
      );
      this.setRequired(this.form,
        FCMPaymentsConstants.REQUIRED_ADHOC_BENEFICIARY_FIELDS,
        false);
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE).setValue('');
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE).clearValidators();
      this.form.get(FccConstants.FCM_PAYMENT_ACCOUNT_TYPE).setValue('');
      this.form.get(FccConstants.FCM_ACCOUNT_NO).setValue('');
      this.form.get(FccConstants.FCM_CONFIRM_ACCONT_NO).setValue('');
      this.form.get(FccConstants.BENE_BANK_IFSC_CODE).setValue('');
      this.form.get(FccConstants.FCM_ACCOUNT_NO).clearValidators();
      this.form.get(FccConstants.FCM_CONFIRM_ACCONT_NO).clearValidators();
      this.form.get(FccConstants.BENE_BANK_IFSC_CODE).clearValidators();
      this.form.get(FccConstants.FCM_PAYMENT_ACCOUNT_TYPE).clearValidators();
     }
    }
  }

  onClickAddBeneficiaryCheckbox() {
    const checkboxVal = this.form.get(FccConstants.FCM_ADD_BENE_CHECKBOX).value;
    if (checkboxVal === FccBusinessConstantsService.YES) {
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      if(this.commonService.isEmptyValue(this.form.get(FccConstants.FCM_BENEFICIARY_CODE).value)) {
        this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[
          FccGlobalConstant.PARAMS
        ][FccConstants.FCM_SWITCH_HYPERLINK_AND_IMG] = false;
        this.form.get(FccConstants.FCM_BENEFICIARY_CODE).clearValidators();
      }
      this.getRegexValidation();
    } else {
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
    }
    this.form.updateValueAndValidity();
  }

  onBlurConfirmAccountNumber() {
    if(!this.checkAccountNumberMatch()) {
      this.form.get(FccConstants.FCM_CONFIRM_ACCONT_NO).setErrors({ accountNumberMismatch : true });
    }
  }

  checkAccountNumberMatch():boolean {
    const accountNo = this.form.get(FccConstants.FCM_ACCOUNT_NO);
    const confirmAccountNo = this.form.get(FccConstants.FCM_CONFIRM_ACCONT_NO);
    if (this.commonService.isNonEmptyValue(accountNo.value) &&
        this.commonService.isNonEmptyValue(confirmAccountNo.value)) {
      return(accountNo.value === confirmAccountNo.value);
    }
  }


  onClickBeneficiaryBankIfscCodeIcons() {
    const obj = {};
    this.preapreLookUpObjectData(obj);
    const header = `${this.translateService.instant('IFSC_Details')}`;
    this.resolverService.getSearchData(header, obj);
    this.ifscResponse = this.searchLayoutService.searchLayoutDataSubject.subscribe((response) => {
          if (response) {
            this.form.get(FccConstants.BENE_BANK_IFSC_CODE).setValue(response.responseData.IFSC);
            const options = this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.OPTIONS];
            const valObj = this.dropdownAPIService.getDropDownFilterValueObj(options, FccConstants.BENE_BANK_IFSC_CODE, this.form);
            if (valObj) {
              this.form.get(FccConstants.BENE_BANK_IFSC_CODE).setValue(valObj[`value`]);
            }
            this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.PARAMS]['shortDescription']
            = response.responseData.DRAWEE_BANK_DESCRIPTION+", "+response.responseData.DRAWEE_BRANCH_DESCRIPTION;
            this.form.get(FccConstants.BENEFICIARY_BANK_CODE).setValue(response.responseData.DRAWEE_BANK_CODE);
            this.form.get(FccConstants.BENEFICIARY_BRANCH_CODE).setValue(response.responseData.DRAWEE_BRANCH_CODE);
            this.form.get(FccConstants.BENEFICIARY_BANK_BRANCH).setValue(response.responseData.DRAWEE_BRANCH_DESCRIPTION);
            this.form.updateValueAndValidity();
          }
        }
      );
  }

  preapreLookUpObjectData(obj) {
    let filterParams: any = {};
    filterParams.paymentType = this.form.get(FccConstants.FCM_PAYMENT_PRODUCT_ID).value;
    filterParams = JSON.stringify(filterParams);
    obj[FccGlobalConstant.FILTER_PARAMS] = filterParams;
    obj[FccGlobalConstant.PRODUCT] = '';
    obj[FccGlobalConstant.DEFAULT_CRITERIA] = true;
    obj[FccConstants.BENE_BANK_CODE_OPTION] = FccConstants.BENE_BANK_IFSC_CODE;
    obj[FccGlobalConstant.SUB_PRODUCT_CODE] = '';
    obj[FccGlobalConstant.BUTTONS] = false;
    obj[FccGlobalConstant.SAVED_LIST] = false;
    obj[FccGlobalConstant.HEADER_DISPLAY] = false;
    obj[FccGlobalConstant.DOWNLOAD_ICON_ENABLED] = false;
    obj[FccGlobalConstant.CATEGORY] = FccConstants.FCM;
  }

  onClickBeneficiaryBankIfscCode() {
    if (this.form.get(FccConstants.BENE_BANK_IFSC_CODE).value) {
      const options = this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.OPTIONS];
      options.forEach(option => {
        if (option.value.label === this.form.get(FccConstants.BENE_BANK_IFSC_CODE).value?.label) {
          this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.PARAMS]['shortDescription']
          = option.value.drawee_bank_description+", "+option.value.drawee_branch_description;
          this.form.get(FccConstants.BENEFICIARY_BANK_CODE).setValue(option.value.drawee_bank_code);
          this.form.get(FccConstants.BENEFICIARY_BRANCH_CODE).setValue(option.value.drawee_branch_code);
          this.form.get(FccConstants.BENEFICIARY_BANK_BRANCH).setValue(option.value.drawee_branch_description);
        }
      });
    }
  }

  onClickAdditionalInformation() {
    if (this.form.get(FccConstants.ADDITIONAL_INFORMATION).value === FccGlobalConstant.CODE_Y) {
      this.setRenderOnlyFields(
        this.form,
        FCMPaymentsConstants.DISPLAY_ADDITIONAL_INFO_FIELDS,
        true
      );
    } else {
      this.setRenderOnlyFields(
        this.form,
        FCMPaymentsConstants.DISPLAY_ADDITIONAL_INFO_FIELDS,
        false
      );
    }
  }


  setRenderOnlyFields(form, ids: string[], flag) {
    ids.forEach((id) => this.setRenderOnly(form, id, flag));
  }

  setRenderOnly(form, id, flag) {
    this.patchFieldParameters(form.controls[id], { rendered: flag });
    if (!flag) {
      this.setRequiredOnly(form, id, false);
    }
  }

  setButtonDisable(form, id, flag) {
    this.patchFieldParameters(form.controls[id], { btndisable: flag });
  }

  setRequired(form, ids: string[], flag) {
    ids.forEach((id) => this.setRequiredOnly(form, id, flag));
  }

  setRequiredOnly(form, id, flag) {
    this.patchFieldParameters(form.controls[id], { required: flag });
  }

  initializeDropdownValues(dropdownFields?, filterParams?){
    dropdownFields.forEach((dropdownField) => {
      if (dropdownField === 'paymentPackages') {
        let filterParamsTemp: any = {};
        filterParamsTemp.paymentPackages = 'Q';
        filterParamsTemp.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
        filterParamsTemp = JSON.stringify(filterParamsTemp);
        this.subscriptions.push(this.commonService.getExternalStaticDataList(dropdownField, filterParamsTemp)
        .subscribe((response) => {
          if (response) {
              this.updateDropdown(dropdownField,response);
          }
        }));
      } else if (dropdownField === 'payFrom') {
        let filterParamsTemp: any = {};
        filterParamsTemp.packageCode = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value?.productCode;
        filterParamsTemp.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
        filterParamsTemp.payFromType = 'Q';
        filterParamsTemp = JSON.stringify(filterParamsTemp);
        if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label)
        && this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label)) {
        this.commonService.getExternalStaticDataList(dropdownField, filterParamsTemp)
        .subscribe((response) => {
          if (response) {
              this.updateDropdown(dropdownField,response);
          }
        });
      }
     } else {
      this.subscriptions.push(this.commonService.getExternalStaticDataList(dropdownField, filterParams)
        .subscribe((response) => {
          if (response) {
              this.updateDropdown(dropdownField,response);
          }
        }));
      }
    });
  }

  updateDropdown(key, dropdownList) {
    if (key === FccConstants.FCM_CLIENT_CODE_DETAILS) {
      this.commonService.setDefaultClient(dropdownList, this.form, key);
      if (this.form.controls[key].value) {
        this.onClickClientDetails();
        this.patchDropdownValue(key);
      }
    } else if (key === FccConstants.FCM_PAYMENT_PACKAGES) {
      const paymentPackages = [];
      dropdownList.forEach(element => {
        const paymentPackage: { label: string, value: any } = {
          label: element.package,
            value : {
              label: element.package,
              name: element.paymenttype,
              shortName: element.package,
              paymentType: element.payment_type,
              productCode: element.mypproduct
            }
        };
        paymentPackages.push(paymentPackage);
      });
      this.patchFieldParameters(this.form.get(key), { options: paymentPackages });
      this.patchDropdownValue(key);
      this.stopLoadingEnrichment = true;
      this.onClickPaymentPackages();
    } else if (key === FccConstants.FCM_PAYMENT_PAY_FROM){
      const payFromVal = [];
      dropdownList.forEach(element => {
        const payFrom: { label: string, value: any } = {
          label: element.code,
            value : {
              label: element.code,
              name: element.description,
              shortName: element.description,
              accountType : element.account_type,
              currency : element.currency,
              accountName : element.acct_name,
              accountId : element.code
          }
        };
        payFromVal.push(payFrom);
      });
      this.patchFieldParameters(this.form.get(key), { options: payFromVal });
      this.patchDropdownValue(key);
      this.onClickPayFrom();
    } else if (key === FccConstants.FCM_PRODUCT_TYPE){
      const productTypeVal = [];
      dropdownList.forEach(element => {
        const productType: { label: string, value: any } = {
          label: element.code,
          value : {
            label: element.code,
            name: `${this.translateService.instant(FccConstants.CUT_OFF_TIME)}`
             + this.commonService.convertNumberToTimePattern(element.cut_off_time),
            shortName: element.description,
            time: this.commonService.convertNumberToTime(element.cut_off_time),
            perProductMinLimit: element.per_txn_min_amnt,
            perProductMaxLimit: element.per_txn_max_amnt
          }
        };
        productTypeVal.push(productType);
      });
      this.patchDropdownValue(key);
      this.patchFieldParameters(this.form.get(key), { options: productTypeVal });
      this.onClickPaymentProductType();
    } else if (key === FccConstants.FCM_PAYMENT_BENEFICIARY_CODE_NAME){
      const benefeciaryNameCodeVal = [];
      dropdownList.forEach(element => {
        const benefeciaryNameCode: { label: string, value: any } = {
          label: element.receiver_code,
          value : {
            label: element.receiver_code,
            name: element.benedescription,
            shortName: element.benedescription
          }
        };
        benefeciaryNameCodeVal.push(benefeciaryNameCode);
      });
      this.patchFieldParameters(this.form.get(key), { options: benefeciaryNameCodeVal });
      this.patchDropdownValue(key);
      if(benefeciaryNameCodeVal.length > 0){
        this.onClickBeneficiaryNameCode();
        this.commonService.setInputAutoComp(true);
      }
    } else if (key === FccConstants.FCM_PAYMENT_PAY_TO){
      const payToVal = [];
      dropdownList.forEach(element => {
        const payTo: { label: string, value: any } = {
          label: element.accountno,
          value : {
            label: element.accountno,
            name: element.bene_account_type,
            shortName: element.accountno,
            defaultAcc: element.default_account,
            accountType : element.bene_account_type,
            currency : element.bene_account_ccy
          }
        };
        payToVal.push(payTo);

      });
        this.form.get(FccConstants.FCM_PAYMENT_PAY_TO).setValue( payToVal.filter(
          task => task.value.defaultAcc === FccGlobalConstant.CODE_Y)[0]?.value);

      this.patchFieldParameters(this.form.get(key), { options: payToVal });
      this.patchDropdownValue(key);
      this.onClickPayTo();
    } else if (key === FccConstants.BENE_BANK_IFSC_CODE){
      const ifscVal = [];
      dropdownList.forEach(element => {
        const ifsc: { label: string, value: any } = {
          label: element.ifsc,
          value : {
            label: element.ifsc,
            shortName: element.ifsc,
            drawee_bank_code: element.drawee_bank_code,
            drawee_bank_description: element.drawee_bank_description,
            drawee_branch_code: element.drawee_branch_code,
            drawee_branch_description: element.drawee_branch_description
          }
        };
        ifscVal.push(ifsc);
      });
      this.patchFieldParameters(this.form.get(key), { options: ifscVal });
    } else if (key === FccConstants.FCM_PAYMENT_ACCOUNT_TYPE) {
      const paymentAccountTypes = [];
      dropdownList.forEach(element => {
        const paymentAccountType: { label: string, value: any } = {
          label : element.preload_value,
          value : {
            label: element.preload_value,
            shortName: element.preload_value
          }
        };
        paymentAccountTypes.push(paymentAccountType);
      });
      this.patchFieldParameters(this.form.get(key), { options: paymentAccountTypes });
    } else if (key === FccConstants.FCM_PAYMENT_EFFECTIVE_DATE) {
      dropdownList.forEach(element => {
        this.form.get(FccConstants.FCM_PAYMENT_EFFECTIVE_DATE)[FccGlobalConstant.PARAMS]['maxDate'] =
        this.commonService.calculateMaxDate(element.allow_max_future_days);
        this.maxDays = element.allow_max_future_days;
      });
      this.setProfileHolidays();
      }
  }

  setProfileHolidays(){
    let filterParams: any = {};
    filterParams.productCode = this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.label;
    filterParams = JSON.stringify(filterParams);
    this.holidayList =[];
    this.subscriptions.push(this.commonService.getExternalStaticDataList(FCMPaymentsConstants.FCM_FETCH_HOLIDAY_LIST, filterParams)
    .subscribe((response) => {
      if (response) {
        this.mondayFlag = response[0].monday_flag;
        this.tuesdayFlag = response[0].tuesday_flag;
        this.wednesdayFlag = response[0].wednesday_flag;
        this.thrusdayFlag = response[0].thursday_flag;
        this.fridayFlag = response[0].friday_flag;
        this.saturdayFlag = response[0].saturday_flag;
        this.sundayFlag = response[0].sunday_flag;
        response.forEach(element => {
          const latestDate = this.datepipe.transform(element.holiday_date, 'yyyy-MM-dd');
          this.holidayList.push(latestDate);
        });
        this.calculateWeeklyDays();
      }
    }));
  }

  calculateWeeklyDays(){
    const currentDate = new Date();
    const week = Number(this.maxDays/7);
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();
    const date = currentDate.getDate();
    if(this.mondayFlag === 'Y'){
      const offset = 8 - currentDate.getDay(); // days till next Monday
      if(currentDate.getDay() === 1){
        this.holidayList.push( currentDate );
      }
      for(let i = 0 ; i < week ; i++) {
      this.holidayList.push( new Date(year, month, date + offset + 7 * i) );
      }
    }
    if(this.tuesdayFlag === 'Y'){
      const offset = 2 - currentDate.getDay(); // days till next Monday
      if(currentDate.getDay() === 1){
        this.holidayList.push( currentDate );
      }
      for(let i = 0 ; i < week ; i++) {
      this.holidayList.push( new Date(year, month, date + offset + 7 * i) );
      }
    }
    if(this.wednesdayFlag === 'Y'){
      const offset = 3 - currentDate.getDay(); // days till next Monday
      if(currentDate.getDay() === 1){
        this.holidayList.push( currentDate );
      }
      for(let i = 0 ; i < week ; i++) {
      this.holidayList.push( new Date(year, month, date + offset + 7 * i) );
      }
    }
    if(this.thrusdayFlag === 'Y'){
      const offset = 4 - currentDate.getDay(); // days till next Monday
      if(currentDate.getDay() === 1){
        this.holidayList.push( currentDate );
      }
      for(let i = 0 ; i < week ; i++) {
      this.holidayList.push( new Date(year, month, date + offset + 7 * i) );
      }
    }
    if(this.fridayFlag === 'Y'){
      const offset = 5 - currentDate.getDay(); // days till next Monday
      if(currentDate.getDay() === 1){
        this.holidayList.push( currentDate );
      }
      for(let i = 0 ; i < week ; i++) {
      this.holidayList.push( new Date(year, month, date + offset + 7 * i) );
      }
    }
    if(this.saturdayFlag === 'Y'){
      const offset = 6 - currentDate.getDay(); // days till next Monday
      if(currentDate.getDay() === 1){
        this.holidayList.push( currentDate );
      }
      for(let i = 0 ; i < week ; i++) {
      this.holidayList.push( new Date(year, month, date + offset + 7 * i) );
      }
    }
    if(this.sundayFlag === 'Y'){
      this.calculateAllSunday();
    }
    this.form.get(FccConstants.FCM_PAYMENT_EFFECTIVE_DATE)[FccGlobalConstant.PARAMS]['holidayList'] = this.holidayList;
  }

  calculateAllSunday() {
    const currentDate = new Date();
    const startDate = this.datepipe.transform(currentDate, 'yyyy-MM-dd');
    const maxDate = this.form.get(FccConstants.FCM_PAYMENT_EFFECTIVE_DATE)[FccGlobalConstant.PARAMS]['maxDate'];
    const endDate = this.datepipe.transform(maxDate, 'yyyy-MM-dd');
    const moment = require('moment');
    const start = moment(startDate);
    const end = moment(endDate);
    const day = 0;
    const current = start.clone();

    while (current.day(7 + day).isBefore(end)) {
      this.holidayList.push(current.clone());
    }
  }


  initializeCheckboxVal(checkboxField?, filterParams?) {
    this.subscriptions.push(this.commonService.getExternalStaticDataList(checkboxField, filterParams)
    .subscribe((response) => {
      if (response && (response.length > 0)) {
         if (response[0].allow_confidential_flag === FccGlobalConstant.CODE_Y &&
          response[0].confidential_mand_flag === FccGlobalConstant.CODE_N){
          this.form.get(FccConstants.FCM_PAYMENT_CONFIDENTIAL_CHECKBOX)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
         } else if(response[0].allow_confidential_flag === FccGlobalConstant.CODE_Y &&
          response[0].confidential_mand_flag === FccGlobalConstant.CODE_Y) {
          this.form.get(FccConstants.FCM_PAYMENT_CONFIDENTIAL_CHECKBOX).setValue(FccGlobalConstant.CODE_Y);
          this.form.get(FccConstants.FCM_PAYMENT_CONFIDENTIAL_CHECKBOX)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
          this.form.get(FccConstants.FCM_PAYMENT_CONFIDENTIAL_CHECKBOX)[FccGlobalConstant.PARAMS][FccGlobalConstant.DISABLED] = true;
          this.form.get(FccConstants.FCM_PAYMENT_CONFIDENTIAL_CHECKBOX)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;

         }
      }
    }));
  }

  onKeyupReceiverType(event) {
    const keycodeIs = event.which || event.keyCode;
    if (keycodeIs === FccGlobalConstant.LENGTH_13) {
      this.onClickReceiverType();
    }
  }

  onClickReceiverType() {
    if (this.form.get(FccConstants.FCM_RECEIVER_TYPE).value === FccConstants.RECEIVER_TYPE_CORPORATE) {
      this.form.get(FccConstants.FCM_LEI_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      this.form.get(FccConstants.FCM_LEI_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    } else {
      this.form.get(FccConstants.FCM_LEI_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      this.form.get(FccConstants.FCM_LEI_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get(FccConstants.FCM_LEI_CODE).setValue(null);
      this.form.updateValueAndValidity();
    }
  }

  openDialog(){
    const message = `${this.translateService.instant('paymentChange')}`;
    this.count = 1;
      this.dialogRef = this.dialogService.open(
        ConfirmationDialogComponent,
        {
          header: `${this.translateService.instant('confirmation')}`,
          width: '35em',
          baseZIndex: 10000,
          styleClass: 'fileUploadClass',
          data: { locaKey: message },
        }
      );
      this.dialogRef.onClose.subscribe(
        (result) => {
        if (result.toLowerCase() === 'yes') {
          this.resetFormfields();
        } else if(result.toLowerCase() === 'no'){
          this.resetFormToOriginal();
        }
      });

  }

  resetFormToOriginal(){
  this.count =0;
  this.getRegexValidation();
  if (this.FieldValToOpenDialog === 'clientCodeClick'){
    if(this.valMap.size === 0 || !this.valMap.has(FccConstants.FCM_CLIENT_CODE_DETAILS)){
      this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).setValue( this.clientValMap.get(FccConstants.FCM_CLIENT_CODE_DETAILS));
      this.form.get('clientName').setValue( this.clientValMap.get('clientName'));

    }else{
      this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).setValue( this.valMap.get(FccConstants.FCM_CLIENT_CODE_DETAILS));
      this.form.get('clientName').setValue( this.valMap.get('clientName'));
    }

  } else if (this.FieldValToOpenDialog === 'paymentPackClick'){
  this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).setValue( this.valMap.get(FccConstants.FCM_PAYMENT_PACKAGES));
  this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE).setValue( this.valMap.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE));
  }

  this.form.updateValueAndValidity();
  }

  resetFormfields(){
    this.count =0;
    this.getRegexValidation();
    this.resetAndHideEnrichmentFields();
    this.setRenderOnly(this.form, FCMPaymentsConstants.ADD_ENRICHMENT_FIELD,false);
    this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.PARAMS]['shortDescription'] = "";
    if (this.FieldValToOpenDialog === 'clientCodeClick'){
      this.form.get('paymentPackages').setValue(null);
      FCMPaymentsConstants.FCM_PAYMENT_SINGLE_CLIENT_FIELDS.map((value: string) => {
        this.form.get(value).setValue(null);
        this.form.get(value).markAsUntouched();
        this.form.get(value).markAsPristine();
        this.form.get(value).clearValidators();
      });
      this.clientValMap.clear();
      this.clientValMap.set(FccConstants.FCM_CLIENT_CODE_DETAILS,this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value);
      this.clientValMap.set(FccConstants.FCM_CLIENT_NAME,this.form.get(FccConstants.FCM_CLIENT_NAME).value);
      if (this.commonService.isNonEmptyValue(FCMPaymentsConstants.FCM_PAYMENT_SINGLE_CLIENT_FIELDS)) {
        this.setRenderOnlyFields(this.form, FCMPaymentsConstants.FCM_PAYMENT_SINGLE_CLIENT_FIELDS, false);
      }
      this.valMap.clear();

    } else if (this.FieldValToOpenDialog === 'paymentPackClick'){
      FCMPaymentsConstants.FCM_PAYMENT_SINGLE_PAYMENT_FIELDS.map((value: string) => {
        this.form.get(value).setValue(null);
        this.form.get(value).markAsUntouched();
        this.form.get(value).markAsPristine();
        this.form.get(value).clearValidators();
      });
      this.loadFieldBasedOnPackage();
      this.valMap.clear();
      this.valMap.set(FccConstants.FCM_PAYMENT_PACKAGES,this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value);
    }
  }


  onClickAmount() {
    this.OnClickAmountFieldHandler(FccConstants.FCM_PAYMENT_AMOUNT);
    this.form.addFCCValidators(
      'amount',
      Validators.pattern(FccGlobalConstant.AMOUNT_VALIDATION),
      0
    );
  }

  onBlurAmount() {
    // const amtVal = parseInt(this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).value);
    this.commonService.amountConfig.subscribe((res)=>{
      if(this.commonService.isnonEMptyString(res)){
        let validationError = null;
        const amtdecimalVal = this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).value;
        const productMinLimit = this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.perProductMinLimit;
        const currency = this.form.get(FccGlobalConstant.CURRENCY).value.label;
        const productMaxLimit = this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.perProductMaxLimit;
        const formatedMinLimit = this.commonService.isnonEMptyString(productMinLimit) ?
        this.currencyConverterPipe.transform(productMinLimit.toString(), currency, res) : '';
        const formatedMaxLimit = this.commonService.isnonEMptyString(productMaxLimit) ?
        this.currencyConverterPipe.transform(productMaxLimit.toString(), currency, res) : '';
        const productName = this.form.get(FccConstants.FCM_PRODUCT_TYPE).value.label;
        this.setAmountLengthValidator(FccConstants.FCM_PAYMENT_AMOUNT);
        if (this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).value &&
              (this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).value <= FccGlobalConstant.ZERO)) {
            this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).setErrors({ amountCanNotBeZero: true });
        }else if (amtdecimalVal < productMinLimit || amtdecimalVal > productMaxLimit){
          if(this.commonService.isnonEMptyString(currency)){
            this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).setErrors({ amountLimitPerProdType :
              { currency: currency, productMinLimit: formatedMinLimit, productMaxLimit: formatedMaxLimit
                , productName: productName } });
          } else{
            this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).setErrors({ selectCurrency: true });
          }

        }else if(!FccGlobalConstant.AMOUNT_LENGTH_11_VALIDATION.test(amtdecimalVal)){
          validationError = { amountMaxLength:
            { field : "Amount Of Transaction", maxLength : FccGlobalConstant.MAX_LENGTH_11 }
          };
          this.addFccValidation(validationError, FccConstants.FCM_PAYMENT_AMOUNT);
        }else {
            this.formatAmount(res);
        }
      }
    });
  }

  addFccValidation(validationError, validationField:string){
    if(this.commonService.isNonEmptyValue(validationError)){
      this.form.get(validationField).clearValidators();
      this.form.addFCCValidators(validationField, Validators.compose([() => validationError]), 0);
      this.form.get(validationField).updateValueAndValidity();
    }
  }
  onFocusAmount() {
    this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).clearValidators();
  }

  formatAmount(data) {
    const currency = this.form.get(FccGlobalConstant.CURRENCY).value.label;
    const val = this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).value;
    let valueupdated;
    if (val) {
      valueupdated = this.commonService.replaceCurrency(val);
      valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), currency, data);
      this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).setValue(valueupdated);
    }
  }

  getCurrencyDetail() {
    if (this.form.get(FccGlobalConstant.CURRENCY)[FccGlobalConstant.OPTIONS].length === 0) {
      this.subscriptions.push(this.commonService.userCurrencies(this.curRequest).subscribe(
        response => {
          if (response.errorMessage && response.errorMessage === 'SESSION_INVALID') {
            this.sessionValidation.IsSessionValid();
          } else {
            response.items.forEach(
              value => {
                const ccy: { label: string, value } = {
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
            this.patchFieldParameters(this.form.get(FccGlobalConstant.CURRENCY), { options: this.currency });
          }
          if (this.form.get(FccGlobalConstant.CURRENCY).value !== FccGlobalConstant.EMPTY_STRING) {
            const valObj = this.dropdownAPIService.getDropDownFilterValueObj(this.currency,
              FccGlobalConstant.CURRENCY, this.form);
            if (valObj) {
              this.form.get(FccGlobalConstant.CURRENCY).patchValue(valObj[`value`]);
            }
          }
        })
      );
    }
  }

  toTitleCase(value) {
    return value.replace(
      /\w\S*/g,
      (txt) => txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    );
  }

  onClickCurrency(event) {
    if (event.value && event.value.currencyCode) {
      this.iso = event.value.currencyCode;
      this.commonService.getamountConfiguration(this.iso);
      const amt = this.form.get(FccConstants.FCM_PAYMENT_AMOUNT);
      const val = amt.value;
      amt.setValidators([Validators.pattern(this.commonService.getRegexBasedOnlanguage())]);
      this.setMandatoryField(this.form, FccConstants.FCM_PAYMENT_AMOUNT, true);
      if (this.commonService.isnonEMptyString(val)) {
          if (val <= 0) {
            this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).setErrors({ amountCanNotBeZero: true });
            return;
          } else {
            this.commonService.amountConfig.subscribe((res)=>{
              if(this.commonService.isnonEMptyString(res)){
                this.formatAmount(res);
              }
            });
          }
        } else {
          this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).setErrors({ required: true });
        }
      // this.form.get(FccConstants.FCM_AMOUNT_LIMIT).updateValueAndValidity();
    } else if (this.commonService.isEmptyValue(this.form.get(FccGlobalConstant.CURRENCY).value)) {
      this.setMandatoryField(this.form, FccConstants.FCM_PAYMENT_AMOUNT, false);
      this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).updateValueAndValidity();
    }
    this.setAmountLengthValidator(FccConstants.FCM_PAYMENT_AMOUNT);
    this.form.get(FccConstants.FCM_PAYMENT_AMOUNT).updateValueAndValidity();
    this.form.get(FCMPaymentsConstants.CREDITOR_CURRENCY).setValue(this.form.get(FccGlobalConstant.CURRENCY).value.label);
  }
  initializeFormGroup() {
    const sectionName = FccConstants.INSTRUMENT_GENERAL_DETAILS;
    this.form = this.stateService.getSectionData(sectionName);
    this.getRegexValidation();
    this.form.updateValueAndValidity();
    this.getCurrencyDetail();
  }

  updateEnrichmentFieldName(){
    this.enrichmentConfig.enrichmentFieldsName = [];
    this.enrichmentConfig.enrichmentFieldsName = Object.keys(this.enrichmentConfig.enrichmentFields);
  }
  updateEnrichmentTypeFlag(){
    const flag = this.enrichmentConfig.enrichmentFields[this.enrichmentConfig.enrichmentFieldsName[0]].typeFlag;
    if(this.commonService.isnonEMptyString(flag)){
      this.enrichmentFlags.isEnrichTypeMultiple = flag === 'M';
    }
    // this.paymentInstrumentProductService.setPaymentMultiset(this.enrichmentFlags.isEnrichTypeMultiple);

  }
  addFieldsInEnrichmentGroup(){
    this.enrichmentConfig.enrichmentFieldsName.forEach(element => {
      this.enrichmentConfig.enrichmentFields[element].grouphead = FCMPaymentsConstants.ENRICHMENT_FIELD_HEADER;
    });
  }
  updateColumnOrder(){
    this.enrichmentConfig.columnOrder = [];
    let hasRequiredField = false;
    this.enrichmentConfig.enrichmentFieldsName.forEach(element => {
      this.enrichmentConfig.columnOrder.push({
        column : this.enrichmentConfig.enrichmentFields[element].name,
        order : this.enrichmentConfig.enrichmentFields[element].order,
        code : this.enrichmentConfig.enrichmentFields[element].code,
        format : this.enrichmentConfig.enrichmentFields[element].format,
        dataType : this.enrichmentConfig.enrichmentFields[element].dataType });
        if(this.enrichmentConfig.enrichmentFields[element].required){
          hasRequiredField = true;
        }
    });
    this.enrichmentFlags.hasRequiredField = hasRequiredField;
    this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS_ORDER
    ] = this.enrichmentConfig.columnOrder;
    this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS
    ] = this.enrichmentConfig.enrichmentFieldsName;
    this.updateDataAsPerColumn();
  }
  updateDataAsPerColumn(){
    const data = this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.DATA];
    const updatedData = [];
    if(this.isEditMode(data)){
      data.forEach(element => {
        const el = {};
        this.enrichmentConfig.columnOrder.forEach(element1 => {
          el[element1.column] = element[element1.code];
          if(element1.dataType === FccGlobalConstant.DATA_TYPE_DATE){
            el[element1.column + FCMPaymentsConstants.ORIGNAL] = this.utilityService.getDateFromAnyFormat(element[element1.code]);
          }
        });
        el[FccConstants.UPDATE_FLAG] = true;
        updatedData.push(el);
      });
      this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.DATA] = updatedData;
    }
  }
  isEditMode(data){
    let isEditMode = this.enrichmentFlags.isEditMode;
    if(isEditMode){
      return false;
    }
    if(data.length > 0){
      const array1 = Object.keys(data[0]);
      const array2 = [];
      this.enrichmentConfig.columnOrder.forEach(element1 => {
        array2.push(element1.code);
      });
      isEditMode = this.commonService.compareArray(array1,array2,true);
    }
    this.enrichmentFlags.isEditMode = isEditMode;
    return isEditMode;
  }

  resetAndHideEnrichmentFields(){
    this.removeEnrichmentFields();
    this.resetAndHideTable();
    this.removeAllEnrichmentBtns();
    this.resetEnrichmentConfig();
    this.enrichmentFlags.isPackageChanged = true;
    this.setEnrichmentConfigToService();
  }

  onClickAddEnrichmentField() {
    this.showAddEnrichmentBtn(false);
    this.resetAndHideTable();
    this.addEnrichmentFields();
    this.showSaveCancelBtn(true);
  }

  onClickSave(){
    if (this.checkEnrichmentValidations()) {
      return;
    }
    this.addNewMode = false;
    this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.LIST_DATA
    ] = true;
    this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS
    ] = this.enrichmentConfig.enrichmentFieldsName;
    this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS_ORDER
    ] = this.enrichmentConfig.columnOrder;
    const gridObj = {};
    for (const item in this.form.controls) {
      if (this.enrichmentConfig.enrichmentFieldsName.includes(item)) {
        if(this.form.controls[item][FccGlobalConstant.TYPE] === FccGlobalConstant.inputDate){
          gridObj[item] = this.getFormatedDate(item);
          gridObj[item + FCMPaymentsConstants.ORIGNAL] = this.form.controls[item].value;
        }else{
          gridObj[item] = this.form.controls[item].value;
        }
      }
    }
    this.addAdditionalAttributesInTableObject(gridObj);
      if(this.enrichmentFlags.isEnrichTypeMultiple){
        this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
          FccGlobalConstant.DATA].push(gridObj);
          this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA] = [...this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
              FccGlobalConstant.DATA]];
      }else{
        this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
          FccGlobalConstant.DATA] = [gridObj];
          this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA] = [...this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
              FccGlobalConstant.DATA]];
      }
        this.removeEnrichmentFields();
        this.showSaveCancelBtn(false);
        if(this.enrichmentFlags.isEnrichTypeMultiple){
          this.showAddNewBtn(true);
        }
    this.setRenderOnly(this.form,FccConstants.ENRICHMENT_LIST_TABLE,true);
    this.form.updateValueAndValidity();
  }


  onClickAddNew(){
    this.addNewMode = true;
    this.addEnrichmentFields();
    this.showSaveCancelBtn(true);
    this.showAddNewBtn(false);
  }

  onClickCancel() {
    this.removeEnrichmentFields();
    this.showUpdateCancelBtn(false);
    this.showSaveCancelBtn(false);
    this.disableTable(false);
    const length = this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.DATA]?.length;
    if(this.enrichmentFlags.isModeNew ){
      if(this.enrichmentFlags.isEnrichTypeMultiple && length > 0){
        this.showAddNewBtn(true);
      }else{
        this.showAddEnrichmentBtn(true);
      }
    } else {
      this.addEnrichmentFields();
      this.retainRenderedOnlyField(
        this.form,
        this.enrichmentConfig.enrichmentFieldsName,
        this.enrichmentConfig.tempRowData
      );
      this.onClickUpdate();
    }
    this.enrichmentFlags.isModeNew = true;
    this.enrichmentSubscriptions.forEach(subs => subs.unsubscribe());
  }
  cancelFields(){
    this.removeEnrichmentFields();
    this.showAddEnrichmentBtn(true);
    if(this.enrichmentFlags.isEnrichTypeMultiple){
      this.setRenderOnly(this.form,FCMPaymentsConstants.FCM_ENRICHMENT_SAVE_ADD_NEW,false);
      this.setRenderOnly(this.form,FCMPaymentsConstants.FCM_ENRICHMENT_ADD_NEW,true);
      this.setRenderOnly(this.form,FCMPaymentsConstants.FCM_ENRICHMENT_CANCEL,true);
    }
  }
  onClickEditEnrichment(event, key, index, rowData) {
    this.getEnrichmentConfigFromService();
    this.enrichmentFlags.isModeNew = false;
    this.enrichmentConfig.tempRowData = rowData;
    rowData.highlight = true;
    this.disableTable(true);
    if(!this.enrichmentFlags.isEnrichTypeMultiple){
      this.resetAndHideTable();
    }
    this.enrichmentConfig.editRecordIndex = index;
    this.paymentInstrumentProductService.enrichmentConfig = this.enrichmentConfig;
    this.addEnrichmentFields();
    this.retainRenderedOnlyField(
      this.form,
      this.enrichmentConfig.enrichmentFieldsName,
      rowData
    );
    this.showUpdateCancelBtn(true);
    this.disableUpdateButton(true);
    this.showAddNewBtn(false);
    this.detectValueChangeOnUpdate();
  }
  getEnrichmentConfigFromService(){
    this.enrichmentConfig = this.paymentInstrumentProductService.enrichmentConfig;
    this.enrichmentFlags = this.paymentInstrumentProductService.enrichmentFlags;
  }
  setEnrichmentConfigToService(){
    this.paymentInstrumentProductService.enrichmentConfig = this.enrichmentConfig ;
    this.paymentInstrumentProductService.enrichmentFlags = this.enrichmentFlags;
  }
  detectValueChangeOnUpdate(){
    this.enrichmentConfig.enrichmentFieldsName.forEach(field =>{
      this.enrichmentSubscriptions.push(
        this.form.get(field).valueChanges.subscribe(change => {
          if(this.enrichmentConfig.tempRowData["field"] != change){
            this.disableUpdateButton(false);
            }
          })
        );
      });
  }

  onClickUpdate(){
    this.enrichmentFlags.isModeNew = true;
    if(this.enrichmentFlags.isEnrichTypeMultiple){
      this.enrichmentConfig.editRecordIndex = this.paymentInstrumentProductService.enrichmentConfig.editRecordIndex;
      if (this.checkEnrichmentValidations()) {
        return;
      }
      this.disableTable(false);
      const retainedRecord = this.form
        .get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.DATA].filter(
          (item, i) => i !== this.enrichmentConfig.editRecordIndex
        );
      const gridObj = {};
      for (const item in this.form.controls) {
        if (this.enrichmentConfig.enrichmentFieldsName.includes(item)) {
          if(this.form.controls[item][FccGlobalConstant.TYPE] === FccGlobalConstant.inputDate){
            // gridObj[item] = this.form.controls[item].value.toDateString();
            gridObj[item] = this.getFormatedDate(item);
            gridObj[item + FCMPaymentsConstants.ORIGNAL] = this.form.controls[item].value;
          }else{
            gridObj[item] = this.form.controls[item].value;
          }
        }
      }
      this.addAdditionalAttributesInTableObject(gridObj);
      retainedRecord.splice(this.enrichmentConfig.editRecordIndex, 0, gridObj);
      this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.DATA
      ] = [...retainedRecord];
      this.removeEnrichmentFields();
      this.showAddNewBtn(true);
      this.showUpdateCancelBtn(false);
      
    }else{
      if (this.checkEnrichmentValidations()) {
        return;
      }
      this.showUpdateCancelBtn(false);
      this.onClickSave();
    }
    //this.enrichmentSubscriptions.forEach(subs => subs.unsubscribe());
  }
  getFormatedDate(item){
    const format = this.enrichmentConfig.columnOrder.find(e => {
      if(e.column === item){
        return e.format;
      }
    }).format.toUpperCase();
    return this.utilityService.transformDateToSpecificFormat(this.form.controls[item].value,
      format );
  }
  onClickDeleteEnrichment(event, rowData, index) {
    const headerField = `${this.translateService.instant(FCMPaymentsConstants.DELETE_ENRICHMENT)}`;
    const message = `${this.translateService.instant(
      FCMPaymentsConstants.DELETE_ENRICHMENT_CONFIRM
    )}`;
    const dir = localStorage.getItem('langDir');
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      header: headerField,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir },
      data: { locaKey: message },
      baseZIndex: 9999,
      autoZIndex: true
    });
    this.subscriptions.push(dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === FccGlobalConstant.CONFIRMATION_YES) {
        if (
          this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA
          ].length === 1
        ) {
          this.resetAndHideTable();
          this.removeEnrichmentFields();
          this.showAddEnrichmentBtn(true);
          this.showAddNewBtn(false);
        } else {
          const retainedItem = this.form
          .get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.DATA].filter(
            (item, i) => i !== index
          );
          this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA
          ] = [];
          this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA
          ] = [...retainedItem];
        }
        this.commonService.showToasterMessage({
          life : 5000,
          key: 'tc',
          severity: 'success',
          summary: 'Done',
          detail: this.translate.instant('deleteSuccessMessage')
        });
      }
    }));
  }

  checkEnrichmentValidations() {
    let invalidStatus = false;
    this.enrichmentConfig.enrichmentFieldsName.forEach(field =>{
      this.form.get(field).markAsTouched();
      if (this.form.get(field)[FccGlobalConstant.STATUS] === FccConstants.STATUS_INVALID) {
        invalidStatus = true;
      }
    });
    if (this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[
      FccGlobalConstant.STATUS] === FccConstants.STATUS_INVALID) {
        invalidStatus = true;
    }
    return invalidStatus;
  }

  resetAndHideTable(){
    this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA] = [];
      this.setRenderOnly(this.form, FccConstants.ENRICHMENT_LIST_TABLE,false);
  }
  retainRenderedOnlyField(form, ids: string[], rowdata) {
    for (const [key, value] of Object.entries(rowdata)) {
      const field = this.form.get(key);
      if(!this.commonService.isEmptyValue(field)){
        if(this.form.controls[key][FccGlobalConstant.TYPE] === FccGlobalConstant.inputDate){
          this.patchFieldValueAndParameters(form.controls[key], rowdata[key + FCMPaymentsConstants.ORIGNAL], {});
        }else{
          this.patchFieldValueAndParameters(form.controls[key], value, {});
        }
      }
    }
  }
  addAdditionalAttributesInTableObject(gridObj) {
    gridObj[FccConstants.UPDATE_FLAG] = true;
    if (this.operation === FccGlobalConstant.UPDATE_FEATURES) {
      gridObj[FccConstants.LEGAL_ENTITY] = 'IN';
      gridObj[FccConstants.FCM_CLIENT_CODE_DETAILS] = this.form.value[FccConstants.FCM_CLIENT_CODE_DETAILS];
      gridObj[FccConstants.FCM_BENEFICIARY_CODE] = this.form.value[FccConstants.FCM_BENEFICIARY_CODE];
    }
  }

  ngOnDestroy(): void {
    this.stateService.setStateSection(FccConstants.INSTRUMENT_GENERAL_DETAILS, this.form);
    this.subscriptions.forEach(subs => subs.unsubscribe());
    this.commonService.isStepperDisabled = true;
  }

  intializeEditForm(){
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value)){
      this.enrichmentFlags.preloadData = true;
    }
    this.onClickClientDetails();
    this.stopLoadingEnrichment = false;
    this.onClickPaymentPackages();
    this.onClickPayFrom();
    this.onClickPaymentProductType();
    this.onClickBeneficiaryNameCode();

    if(this.commonService.isnonEMptyString(this.form.get('effectiveDate').value)){
      this.form.get('effectiveDate').setValue(new Date(this.form.get('effectiveDate').value));
      this.onClickEffectiveDate();
    }
    this.patchDropdownValue(FccGlobalConstant.CURRENCY);
    this.displayPaymentReferenceNumber();
  }

  patchDropdownValue(key){
    if (this.form.get(key).value !== FccGlobalConstant.EMPTY_STRING) {
      const valObj = this.dropdownAPIService.getDropDownFilterValueObj(this.form.controls[key]['options'], key, this.form);
      if (valObj) {
        this.form.get(key).patchValue(valObj[`value`]);
      }
    }
  }

  updateEmailValidity(){
    if (this.form.get('emailID')[FccGlobalConstant.PARAMS][FccGlobalConstant.MULTI_VALUE_LIMIT]==0) {
      this.subscriptions.push(
        this.commonService.getConfiguredValues('BENEFICIARY_EMAIL_LIMIT')
          .subscribe(resp => {
            if(resp && resp?.BENEFICIARY_EMAIL_LIMIT) {
              this.form.get('emailID')[FccGlobalConstant.PARAMS][FccGlobalConstant.MULTI_VALUE_LIMIT]
              = parseInt(resp.BENEFICIARY_EMAIL_LIMIT, 10);
              this.form.get('emailID').clearValidators();
              this.form.addFCCValidators('emailID', Validators.compose([Validators.compose([multipleEmailValidation])]), 0);
              this.form.get('emailID').updateValueAndValidity();
            }
          }
        )
      );
    } else {
      this.form.get('emailID').clearValidators();
      this.form.addFCCValidators('emailID', Validators.compose([Validators.compose([multipleEmailValidation])]), 0);
      this.form.get('emailID').updateValueAndValidity();
    }
  }

  loadEnrichmentDataOnAutoSave(){
    if((!this.paymentInstrumentProductService.isNextFlag && !this.enrichmentFlags.isFieldLoadedOnScreen)
    || (this.paymentInstrumentProductService.isNextFlag && !this.enrichmentFlags.hasEnrichmentFields)){ 
      this.enrichmentFlags.loadEnrichDataAutoSaveFlag = true;
      this.loadEnrichmentConfig();
    }
  }

  loadEnrichmentFieldsOnAutoSave(){
    this.updateTableAndButtons();
    this.enrichmentFlags.loadEnrichDataAutoSaveFlag = false;
    this.paymentInstrumentProductService.autoSaveDataLoaded = true;
  }

  resetEnrichConfigOnInit(){
  if(!this.paymentInstrumentProductService.isNextFlag && this.paymentInstrumentProductService.loadCount == 0){
    this.resetEnrichmentConfig();
  }
  this.paymentInstrumentProductService.loadCount++;
  if(this.paymentInstrumentProductService.loadCount >= 2){
    this.paymentInstrumentProductService.loadCount = 0;
  }
 }

  preloadEnrichmentData(){
    this.showAddEnrichmentBtn(false);
    this.setRenderOnly(this.form,FccConstants.ENRICHMENT_LIST_TABLE,true);
    this.enrichmentFlags.preloadData = false;
  }

  preloadEnrichmentDataOnEdit(){
    this.updateTableAndButtons();
    this.enrichmentFlags.preloadData = false;
  }

  updateTableAndButtons(){
    const tableLen = this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA
    ]?.length;
    if(tableLen > 0){
      this.showAddEnrichmentBtn(false);
      this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.LIST_DATA
      ] = true;
      this.setRenderOnly(this.form,FccConstants.ENRICHMENT_LIST_TABLE,true);
      if(this.enrichmentFlags.isEnrichTypeMultiple){
        this.showAddNewBtn(true);
      }
    }else if( this.enrichmentFlags.isFieldLoadedOnScreen ){
      this.showAddEnrichmentBtn(false);
    }else{
      this.showAddEnrichmentBtn(true);
    }
    this.form.updateValueAndValidity();
  }

  isEnrichCall = false;
  loadEnrichmentConfig(){
    let filterParams: any = {};
    filterParams.packageCode = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value?.productCode;
    if(!filterParams.packageCode){
      filterParams.packageCode = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value?.value;
    }
    filterParams.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
    let hasParams = false;
    if(filterParams.packageCode && filterParams.clientCode){
      hasParams = true;
    }
    filterParams = JSON.stringify(filterParams);
    if (this.updatePakageChangeFlag() && this.commonService.isObjectEmpty(this.enrichmentConfig.enrichmentFields) 
    && !this.isEnrichCall && hasParams) {
    this.isEnrichCall = true;
    this.subscriptions.push(
      this.commonService.getExternalStaticDataList(FccConstants.FCM_ENRICHMENT_BY_PACKAGE, filterParams).subscribe(response => {
        if(response && !this.commonService.isObjectEmpty(response)) {
          this.enrichmentConfig.enrichmentFields = response;
          this.enrichmentFlags.hasEnrichmentFields = true;
          this.updateEnrichmentFieldName();
          this.updateEnrichmentTypeFlag();
          this.addFieldsInEnrichmentGroup();
          this.updateColumnOrder();
          // this.showAddEnrichmentBtn(true);
          this.setEnrichmentConfigToService();
          this.paymentInstrumentProductService.isNextFlag = false;
          if(this.enrichmentFlags.loadEnrichDataAutoSaveFlag){
            this.loadEnrichmentFieldsOnAutoSave();
          } else if(this.enrichmentFlags.isEditMode){
            this.preloadEnrichmentDataOnEdit();
          } else if(this.enrichmentFlags.preloadData){
            this.preloadEnrichmentData();
          } else {
            this.showAddEnrichmentBtn(true);
          }
        }else{
          this.setRenderOnly(this.form, FCMPaymentsConstants.ADD_ENRICHMENT_FIELD,false);
        }
        this.valMap.set(FccConstants.FCM_PAYMENT_PACKAGES,this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value);
        this.isEnrichCall = false;
      })
    );
    } else if(this.enrichmentFlags.loadEnrichDataAutoSaveFlag 
      && !this.commonService.isObjectEmpty(this.enrichmentConfig.enrichmentFields)){
        // this.showAddEnrichmentBtn(true);
        this.loadEnrichmentFieldsOnAutoSave();
    }
  }

  updatePakageChangeFlag(){
    const packageName = this.form.get(FccConstants.FCM_PAYMENT_PACKAGES).value.label;
    const prepackageName = this.valMap.get(FccConstants.FCM_PAYMENT_PACKAGES);
    if (this.commonService.isEmptyValue(prepackageName) || (prepackageName.label !== packageName) 
    || this.enrichmentFlags.preloadData || this.enrichmentFlags.loadEnrichDataAutoSaveFlag 
    || this.enrichmentFlags.isPackageChanged){
      this.enrichmentFlags.isPackageChanged = true;
    }
    return this.enrichmentFlags.isPackageChanged;
  }

  addEnrichmentFields(){
    this.formControlService.addNewFormControls(this.enrichmentConfig.enrichmentFields, 
    this.form, FCMPaymentsConstants.ENRICHMENT_FIELD_HEADER);
    this.addEnrichmentValidation();
    this.enrichmentFlags.isFieldLoadedOnScreen = true;
    this.form.updateValueAndValidity();
  }

  removeEnrichmentFields(){
    this.formControlService.removeFormControls(this.enrichmentConfig.enrichmentFields, this.form);
    this.enrichmentFlags.isFieldLoadedOnScreen = false;
    this.form.updateValueAndValidity();
  }
  
  showSaveCancelBtn(show){
    this.setRenderOnlyFields(
      this.form,
      [...FCMPaymentsConstants.ENRICHMENT_SAVE_CANCEL],
      show
    );
  }
  
  showUpdateCancelBtn(show){
    this.setRenderOnly(this.form, FCMPaymentsConstants.FCM_ENRICHMENT_UPDATE,show);
    this.setRenderOnly(this.form, FCMPaymentsConstants.FCM_ENRICHMENT_CANCEL,show);
  }

  showAddEnrichmentBtn(show){
    this.setRenderOnly(this.form, FCMPaymentsConstants.ADD_ENRICHMENT_FIELD,show);
    this.setRenderOnly(this.form, FCMPaymentsConstants.ENRICHMENT_FIELD_HEADER,!show);  
    if(show && this.enrichmentFlags.hasRequiredField){
      this.onClickAddEnrichmentField();
      this.setRenderOnly(this.form, FCMPaymentsConstants.FCM_ENRICHMENT_CANCEL,false);
    }  
  }
  
  disableUpdateButton(disable:boolean){
    this.setButtonDisable(this.form, FCMPaymentsConstants.FCM_ENRICHMENT_UPDATE,disable);
  }

  showAddNewBtn(show){
    this.setRenderOnly(this.form,FCMPaymentsConstants.FCM_ENRICHMENT_ADD_NEW,show);
  }
  removeAllEnrichmentBtns(){
    this.setRenderOnlyFields(
      this.form,
      [...FCMPaymentsConstants.ENRICHMENT_SAVE_CANCEL],
      false
    );
    this.setRenderOnly(this.form, FCMPaymentsConstants.FCM_ENRICHMENT_UPDATE,false);
    this.setRenderOnly(this.form, FCMPaymentsConstants.FCM_ENRICHMENT_CANCEL,false);
    this.setRenderOnly(this.form, FCMPaymentsConstants.ADD_ENRICHMENT_FIELD,false);
    this.setRenderOnly(this.form, FCMPaymentsConstants.ENRICHMENT_FIELD_HEADER,false);
    this.setRenderOnly(this.form,FCMPaymentsConstants.FCM_ENRICHMENT_ADD_NEW,false);
  }
  resetEnrichmentConfig(){
    this.enrichmentConfig = {
      enrichmentFields: {},
      enrichmentFieldsName : [],
      columnOrder : [],
      editRecordIndex : 0,
      tempRowData : {}
    };
    this.enrichmentFlags = {
      hasEnrichmentFields : false,
      isEnrichTypeMultiple : true,
      isEnrichmentBtnClicked : false,
      isFieldLoadedOnScreen : false,
      isModeNew: true,
      isPackageChanged: false,
      loadEnrichDataAutoSaveFlag : false,
      isSaveValid : false,
      preloadData : false,
      isEditMode : this.enrichmentFlags.isEditMode,
      hasRequiredField : false
    };
    this.setEnrichmentConfigToService();
  }
  
  disableTable(flag){
    const griddata =this.form.get(FccConstants.ENRICHMENT_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA];
      griddata.forEach(element => {
        element[FccConstants.UPDATE_FLAG] = !flag;
      });
  }

  displayPaymentReferenceNumber(){
    const paymentReferenceNumber = this.commonService.getQueryParametersFromKey(FCMPaymentsConstants.PAYMENT_REFERENCE_NUMBER_FIELD);
    const operation = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION);
    if (operation === FccGlobalConstant.UPDATE_FEATURES && this.commonService.isnonEMptyString(paymentReferenceNumber)) {
      this.setRenderOnly(this.form, FCMPaymentsConstants.PAYMENT_REF_NUMBER,true);
      this.form.get(FCMPaymentsConstants.PAYMENT_REF_NUMBER).setValue(paymentReferenceNumber);
    }
  }
}
