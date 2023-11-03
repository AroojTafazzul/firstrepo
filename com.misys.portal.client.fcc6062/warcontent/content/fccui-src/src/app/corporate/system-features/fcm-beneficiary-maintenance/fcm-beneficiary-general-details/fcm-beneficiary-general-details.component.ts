import { AfterViewInit, Component, EventEmitter, OnDestroy, OnInit, Output } from '@angular/core';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { HOST_COMPONENT } from './../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FCMBeneficiaryProductComponent } from './../fcm-beneficiary-product/fcm-beneficiary-product.component';
import { FCMBeneficiaryProductService } from '../services/fcm-beneficiary-product.service';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, SelectItem } from 'primeng';
import { FCCFormGroup } from './../../../../../app/base/model/fcc-control.model';
import { FccGlobalConstantService } from './../../../../../app/common/core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../../../../app/common/core/fcc-global-constants';
import { FccConstants } from './../../../../../app/common/core/fcc-constants';
import { CommonService } from './../../../../../app/common/services/common.service';
import { FileHandlingService } from './../../../../../app/common/services/file-handling.service';
import { HideShowDeleteWidgetsService } from './../../../../../app/common/services/hide-show-delete-widgets.service';
import { SessionValidateService } from './../../../../../app/common/services/session-validate-service';
import { EventEmitterService } from './../../../../common/services/event-emitter-service';
import { FormModelService } from './../../../../common/services/form-model.service';
import { ResolverService } from './../../../../common/services/resolver.service';
import { SearchLayoutService } from './../../../../common/services/search-layout.service';
import { LeftSectionService } from './../../../common/services/leftSection.service';
import { ProductStateService } from './../../../trade/lc/common/services/product-state.service';
import { CurrencyConverterPipe } from './../../../trade/lc/initiation/pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from './../../../trade/lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from './../../../trade/lc/initiation/services/filelist.service';
import { FormControlService } from './../../../trade/lc/initiation/services/form-control.service';
import { UtilityService } from './../../../trade/lc/initiation/services/utility.service';
import { CodeDataService } from '../../../../common/services/code-data.service';
import { MultiBankService } from '../../../../common/services/multi-bank.service';
import { DropDownAPIService } from '../../../../common/services/dropdownAPI.service';
import { FccTaskService } from '../../../../common/services/fcc-task.service';
import { MatDialog } from '@angular/material/dialog';
import { DashboardService } from '../../../../common/services/dashboard.service';
import { Subscription } from 'rxjs';
import { Validators } from '@angular/forms';
import { ConfirmationDialogComponent } from '../../../../../app/corporate/trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { FCMBeneConstants } from './fcm-beneficiary-general-details.constants';
import { CurrencyRequest } from '../../../../common/model/currency-request';
import { concatMap, debounceTime, filter } from 'rxjs/operators';
import { ProductMappingService } from '../../../../common/services/productMapping.service';
import { multipleEmailValidation } from '../../../common/validator/ValidationKeys';
@Component({
  selector: 'app-fcm-beneficiary-general-details',
  templateUrl: './fcm-beneficiary-general-details.component.html',
  styleUrls: ['./fcm-beneficiary-general-details.component.scss'],
  providers: [
    DialogService,
    { provide: HOST_COMPONENT, useExisting: FCMBeneficiaryGeneralDetailsComponent },
  ]
})
export class FCMBeneficiaryGeneralDetailsComponent extends FCMBeneficiaryProductComponent implements OnInit, OnDestroy, AfterViewInit {

  module = `${this.translateService.instant('fcmBeneficiaryGeneralDetails')}`;
  mode;
  form: FCCFormGroup;
  subscriptions: Subscription[] = [];
  additionalFormFields: any;
  accountNumberInvalid: string;
  beneficiaryCodeRegex: string;
  beneficiaryNameRegex: string;
  accountNumberRegex: string;
  mobileNumberRegex: string;
  addrLine1Regex: string;
  addrLine2Regex: string;
  noOfTxnRegex: string;
  leiCodeRegex: string;
  accountFieldsList = [];
  accountColumnList = [];
  defaultAccountFlag: SelectItem[] = [];
  editRecordIndex;
  ifscResponse;
  beneficiaryFCMCode: any;
  currency: SelectItem[] = [];
  curRequest: CurrencyRequest = new CurrencyRequest();
  opts: any;
  valMap = new Map();
  count = 0;
  isDialogCloseResp = false;
  accountLimit = 0;
  accountNumberIfscCodePairRes: any;
  isExistingAccountDefault = false;
  packageOnEditFlag = false;

  formChangeFlag = false;
  @Output() checkSubmitStatus: EventEmitter<any> = new EventEmitter();



  constructor(
    protected commonService: CommonService,
    protected sessionValidation: SessionValidateService,
    protected translateService: TranslateService,
    protected router: Router,
    protected leftSectionService: LeftSectionService,
    public dialogService: DialogService,
    public uploadFile: FilelistService,
    public deleteFile: CommonService,
    public downloadFile: CommonService,
    protected dialog: MatDialog,
    protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
    public autoUploadFile: CommonService,
    protected fileListSvc: FilelistService,
    protected formModelService: FormModelService,
    protected multiBankService: MultiBankService,
    protected formControlService: FormControlService,
    protected fccGlobalConstantService: FccGlobalConstantService,
    protected eventEmitterService: EventEmitterService,
    protected stateService: ProductStateService,
    protected fileHandlingService: FileHandlingService,
    protected confirmationService: ConfirmationService,
    protected dropdownAPIService: DropDownAPIService,
    protected taskService: FccTaskService,
    protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
    protected searchLayoutService: SearchLayoutService,
    protected utilityService: UtilityService,
    protected resolverService: ResolverService,
    protected dashboardService: DashboardService,
    protected dialogRef: DynamicDialogRef,
    protected currencyConverterPipe: CurrencyConverterPipe,
    protected codeDataService: CodeDataService,
    protected fcmBeneficiaryProductService: FCMBeneficiaryProductService,
    protected productMappingService: ProductMappingService
  ) {
    super(
      eventEmitterService,
      stateService,
      commonService,
      translateService,
      confirmationService,
      customCommasInCurrenciesPipe,
      searchLayoutService,
      utilityService,
      resolverService,
      fileListSvc,
      dialogRef,
      currencyConverterPipe,
      fcmBeneficiaryProductService
  ); }



  ngOnInit(): void {
    super.ngOnInit();
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.opts = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.stateService.autosaveProductCode = FccGlobalConstant.PRODUCT_BENE;

    this.subscriptions.push(
      this.commonService.loadDefaultConfiguration().subscribe(response => {
        if (response && response.showStepper !== FccConstants.STRING_TRUE) {
          this.commonService.isStepperDisabled = true;
        }
      })
    );
    this.subscriptions.push(
    this.commonService.getConfiguredValues('BENEFICIARY_CREATION_ACCOUNT_LIMIT')
      .subscribe(resp => {
        if(resp && resp?.BENEFICIARY_CREATION_ACCOUNT_LIMIT) {
          this.accountLimit = parseInt(resp.BENEFICIARY_CREATION_ACCOUNT_LIMIT, 10);
        }
      })
    );
    this.operation = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION);
    this.initializeFormGroup();
    this.initializeDropdownValues(FCMBeneConstants.FCM_FETCH_DATA_OPTIONS);
    this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.hasActions] = true;
    this.checkAccountTableListExists();


    if (this.operation === FccGlobalConstant.ADD_FEATURES
      && this.commonService.isNonEmptyValue(this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS))
      && this.form.get(FccConstants.BENEFICIARY_RADIO).value === FccConstants.BENE_TYPE_NEW) {
      this.setRenderOnlyFields(this.form, FccConstants.FCM_NEW_BENE_FIELDS, true);
      this.setRenderOnly(this.form, FccConstants.EXISTING_BENE_CODE, false);
      this.setRenderOnly(this.form, FccConstants.ADD_TABLE_BUTTON, false);
      this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      if (this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.DATA].length > 0) {
        this.setRenderOnlyFields(this.form, this.accountFieldsList,false);
        this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
        this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
        this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
        this.clearValidationRenderFields(this.form,this.accountFieldsList);
      }
      this.form.get(FccConstants.EXISTING_BENE_NAME)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    } else if (this.operation === FccGlobalConstant.UPDATE_FEATURES) {
      this.form.get(FccConstants.FCM_EMAIL_ID)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    }


    this.eventEmitterService.autoSaveForLater.subscribe(sectionName => {
      if(sectionName === FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS) {
        this.commonService.autoSaveForm(
          this.productMappingService.buildFormDataJson(this.form, FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS)
          , this.stateService.getAutoSaveCreateFlagInState()
          , FccGlobalConstant.PRODUCT_BENE
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
      if(sectionName === FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS) {
              this.onClickClientDetails();
              this.onClickPaymentType();
              const tableLen = this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
                FccGlobalConstant.DATA
              ]?.length;
              if(tableLen > 0) {
                this.setRenderOnlyFields(
                  this.form,
                  FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS,
                  false
                );
                this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                  FccGlobalConstant.RENDERED
                ] = false;
                this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                  FccGlobalConstant.RENDERED
                ] = true;
                this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                  FccGlobalConstant.RENDERED
                ] = false;

              } else {
                this.setRenderOnlyFields(
                  this.form,
                  FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS,
                  true
                );
                this.getRegexValidation();
                this.clearValidationRenderFields(
                  this.form,
                  FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS
                );
                this.getRegexValidation();
                this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                  FccGlobalConstant.RENDERED
                ] = true;
                this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                  FccGlobalConstant.RENDERED
                ] = false;
                this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                  FccGlobalConstant.RENDERED
                ] = false;

              }
              this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG)[FccGlobalConstant.PARAMS][
                FccGlobalConstant.RENDERED
              ] = false;
              this.checkForAddlimit();
      }
    });

    this.subscriptions.push(
    this.eventEmitterService.cancelTransaction.subscribe(sectionName => {
      if(sectionName === FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS) {
        const paramKeys = {
          productCode : FccGlobalConstant.PRODUCT_BENE,
          subProductCode : this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_PRODUCT_CODE),
          referenceId : this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID),
          option : this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION) ?
          this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION) : this.opts,
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
  }

  ngAfterViewInit(): void {

    if (this.operation === FccGlobalConstant.UPDATE_FEATURES) {
      const initialFormValue = this.stateService.getSectionData(FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS, null, false).getRawValue();
      const packageValue = this.stateService.getValueObject('fcmBeneficiaryGeneralDetails', 'newPackage', false);
      if (packageValue?.shortName) {
        this.form.get('newPackage').setValue({ label: packageValue.shortName, shortName: packageValue.shortName });
      }
      this.form.valueChanges.subscribe(change => {
        if (initialFormValue && initialFormValue.clientDetails && change) {
          let changeCount = 0;
          Object.keys(initialFormValue).forEach(control => {
            if ((!initialFormValue[control] || typeof initialFormValue[control] === FccGlobalConstant.STRING)
            && (initialFormValue[control] !== change[control] && (this.commonService.isnonEMptyString(initialFormValue[control])
            || this.commonService.isnonEMptyString(change[control])))) {
              changeCount++;
            } else if (initialFormValue[control] && change[control] && typeof initialFormValue[control] === FccGlobalConstant.OBJECT) {
              Object.keys(change[control]).forEach(key => {
                if (change[control][key] !== initialFormValue[control][key]) {
                  changeCount++;
                }
              });
            }
          });
          if (changeCount) {
            this.formChangeFlag = true;
          } else {
            this.formChangeFlag = false;
          }
          this.checkSubmitStatus.emit(this.formChangeFlag);
        }
      });
      this.loadPackageOnEdit();
    } else if (this.operation === FccGlobalConstant.ADD_FEATURES) {
      this.subscriptions.push(
      this.form.valueChanges
        .pipe(
              filter(() => this.form.dirty && this.stateService.getAutoSaveConfig()?.isAutoSaveEnabled),
              debounceTime(this.stateService.getAutoSaveConfig()?.autoSaveDelay),
              concatMap(() => this.commonService.autoSaveForm(
                  this.productMappingService.buildFormDataJson(this.form, FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS)
                  , this.stateService.getAutoSaveCreateFlagInState()
                  , FccGlobalConstant.PRODUCT_BENE
                  , ''
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
        })
      );
        this.commonService.getProductCode.next(FccGlobalConstant.PRODUCT_BENE);
        this.stateService.setStateSection(FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS, this.form);
        this.patchDropdownValue(FccConstants.FCM_CLIENT_CODE_DETAILS);
        this.onClickAdditionalInformation();
        this.onClickRemarks();
    }
  }
  loadPackageOnEdit(){
    let filterParams: any = {};
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE).value) &&
    this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value) {
      const paymentType = FccGlobalConstant.PAYMENT_TYPE_MAPPING[this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE).value.value];
      this.fcmBeneficiaryProductService.paymentTypeList.forEach(element => {
        if(element.product_category_desc === paymentType){
          filterParams.paymenttype = element.product_id;
        }
      });
      filterParams.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value;
      filterParams = JSON.stringify(filterParams);
      this.packageOnEditFlag = true;
      this.initializeDropdownValues(FCMBeneConstants.FCM_BENEFICIARY_PACKAGE_DATA_OPTIONS, filterParams);
    }

  }
  getRegexValidation() {
    this.subscriptions.push(
      this.commonService.getConfiguredValues('BENEFICIARY_FORM_BENE_CODE_VALIDATION,BENEFICIARY_FORM_BENE_NAME_VALIDATION,'
        + 'BENEFICIARY_FORM_ACCOUNT_NUMBER_VALIDATION,BENEFICIARY_FORM_MOBILE_NUMBER_VALIDATION,BENEFICIARY_FORM_ADDRESS_LINE1_VALIDATION,'
        + 'BENEFICIARY_FORM_ADDRESS_LINE2_VALIDATION,BENEFICIARY_FORM_N_TXN_VALIDATION,BENEFICIARY_FORM_LEICODE_VALIDATION')
      .subscribe(resp => {
        if (resp.response && resp.response === 'REST_API_SUCCESS') {
          this.beneficiaryCodeRegex = resp.BENEFICIARY_FORM_BENE_CODE_VALIDATION;
          this.beneficiaryNameRegex = resp.BENEFICIARY_FORM_BENE_NAME_VALIDATION;
          this.accountNumberRegex = resp.BENEFICIARY_FORM_ACCOUNT_NUMBER_VALIDATION;
          this.mobileNumberRegex = resp.BENEFICIARY_FORM_MOBILE_NUMBER_VALIDATION;
          this.addrLine1Regex = resp.BENEFICIARY_FORM_ADDRESS_LINE1_VALIDATION;
          this.addrLine2Regex = resp.BENEFICIARY_FORM_ADDRESS_LINE2_VALIDATION;
          this.noOfTxnRegex = resp.BENEFICIARY_FORM_N_TXN_VALIDATION;
          this.leiCodeRegex = resp.BENEFICIARY_FORM_LEICODE_VALIDATION;
          this.doBeneFormValidation();
        }}));
  }

  initializeFormGroup() {
    const sectionName = FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS;
    this.form = this.stateService.getSectionData(sectionName);
    this.getRegexValidation();
    this.getCurrencyDetail();
    this.form.get(FccConstants.ADDITIONAL_INFORMATION_HEADER)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED] = false;
    this.form.get(FccConstants.REMARKS_HEADER)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED] = false;
    this.accountFieldsList = FCMBeneConstants.ACCOUNTS_TABLE_FIELDS;
    this.accountColumnList = FCMBeneConstants.ACCOUNTS_TABLE_COLUMNS;
    this.form.updateValueAndValidity();
    this.fetchAccountIFSCpairDetails();
  }

  onClickAdditionalInformation() {
    if (this.form.get(FccConstants.ADDITIONAL_INFORMATION).value === FccGlobalConstant.CODE_Y) {
      this.form.get('packages')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('mobileNo')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('addressLine1')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('addressLine2')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('pincode')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('numberOfTransaction')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get(FccConstants.FCM_AMOUNT_LIMIT)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('receiverType')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get('leiCode')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    } else {
      this.form.get('packages')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('mobileNo')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('addressLine1')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('addressLine2')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('pincode')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('numberOfTransaction')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get(FccConstants.FCM_AMOUNT_LIMIT)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('receiverType')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get('leiCode')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    }
  }

  setPackageType() {
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PACKAGE).value)) {
      this.form.get(FccConstants.FCM_PACKAGE_TYPE).setValue(FccConstants.FCM_PACKAGE_TYPE_FIXED);
    }
  }

  setcompleteAddress() {
    const completeAddress = [];
    const address1 = this.form.get(FccConstants.FCM_ADDRESS_LINE_1).value ? this.form.get(FccConstants.FCM_ADDRESS_LINE_1).value
    : this.form.get(FccConstants.NEW_FCM_ADDRESS_LINE_1).value;
    const address2 = this.form.get(FccConstants.FCM_ADDRESS_LINE_2).value ? this.form.get(FccConstants.FCM_ADDRESS_LINE_2).value
    : this.form.get(FccConstants.NEW_FCM_ADDRESS_LINE_2).value;
    if (this.commonService.isnonEMptyString(address1) ||
    this.commonService.isnonEMptyString(address2)) {
      completeAddress.push(address1);
      completeAddress.push(address2);
      this.form.get(FccConstants.FCM_ADDRESS_LINES).setValue(completeAddress);
    }
  }

  onClickRemarks() {
    this.form.get('enterComments')[FccGlobalConstant.PARAMS][FccGlobalConstant.PREVIEW_SCREEN] = false;
    if (this.form.get(FccConstants.REMARKS).value === FccGlobalConstant.CODE_Y) {
      this.form.get('enterComments')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
    } else {
      this.form.get('enterComments')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    }
  }

  initializeDropdownValues(dropdownFields?, filterParams?) {
    dropdownFields.forEach((dropdownField) => {
      this.subscriptions.push(this.commonService.getExternalStaticDataList(dropdownField, filterParams)
        .subscribe((response) => {
          if (response) {
            if ((this.form.get(dropdownField)[FccGlobalConstant.OPTIONS] &&
            this.form.get(dropdownField)[FccGlobalConstant.OPTIONS].length <= FccGlobalConstant.LENGTH_0) ||
            (this.commonService.isEmptyValue(this.form.get(dropdownField)[FccGlobalConstant.OPTIONS]))) {
              this.updateDropdown(dropdownField,response);
            } else if (dropdownField === FccConstants.BENE_BANK_IFSC_CODE) {
              this.updateDropdown(dropdownField,response);
            } else if (dropdownField === FccConstants.FCM_PACKAGE) {
              this.updatePaymentDropdown(dropdownField,response);
            }
          }
        }));
    });
  }

  updatePaymentDropdown(key, dropdownList) {
    if (key === 'packages'){
      const packageTemp = [];
      const newPackageTemp = [];

      dropdownList.forEach(element => {
        const data: { label: string, value: any } = {
          label: element.package_name,
            value : {
              label: element.package_name,
              shortName: element.package_name
            }
        };
        packageTemp.push(data);
      });

      dropdownList.forEach(element => {
        const data: { label: string, value: any } = {
          label: element.mypdescription,
              value : {
                label: element.mypdescription,
                shortName: element.mypdescription
              }
        };
        newPackageTemp.push(data);
      });

      this.patchFieldParameters(this.form.get(key), { options: packageTemp });
      this.patchFieldParameters(this.form.get('newPackage'), { options: newPackageTemp });
      if(this.packageOnEditFlag){
        this.patchFieldParameters(this.form.get('newPackage'), { options: packageTemp });
        this.packageOnEditFlag = false;
      }

    }
  }

  updateDropdown(key, dropdownList) {
    if (!this.form.controls[key]['options']?.length) {
    if (key === 'accountType') {
      dropdownList.forEach(element => {
        this.form.controls[key]['options'].push(
          {
            label : element.preload_value,
            value : {
              label: element.preload_value,
              shortName: element.preload_value
            }
          }
        );
      });
    } else if (key === 'packages'){
      dropdownList.forEach(element => {
        this.form.controls[key]['options'].push(
          {
            label: element.package_name,
            value : {
              label: element.package_name,
              shortName: element.package_name
            }
          }
        );
        if (this.form.controls?.newPackage) {
          this.form.controls['newPackage']['options'].push(
            {
              label: element.mypdescription,
              value : {
                label: element.mypdescription,
                shortName: element.mypdescription
              }
            }
          );
        }
      });
    } else if (key === 'paymentType'){
      dropdownList.forEach(element => {
        this.form.controls[key]['options'].push(
          {
            label: element.product_category_desc,
            value : {
              label: element.product_category_desc,
              shortName: element.product_category_desc,
              codeValue: element.product_id
            }
          }
        );
      });
      this.fcmBeneficiaryProductService.paymentTypeList = dropdownList;
    } else if (key === 'clientDetails'){
      this.commonService.setDefaultClient(dropdownList, this.form, key);
      if (this.form.controls[key].value) {
        this.onClickClientDetails();
      }
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
    }
  }
  }

  getCurrencyDetail() {
    if (this.form.get(FccConstants.FCM_ACCOUNT_CURRENCY)[FccGlobalConstant.OPTIONS]?.length === 0) {
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
            this.patchFieldParameters(this.form.get(FccConstants.FCM_ACCOUNT_CURRENCY), { options: this.currency });
          }
          if (this.form.get(FccConstants.FCM_ACCOUNT_CURRENCY).value !== FccGlobalConstant.EMPTY_STRING) {
            const valObj = this.dropdownAPIService.getDropDownFilterValueObj(this.currency,
              FccConstants.FCM_ACCOUNT_CURRENCY, this.form);
            if (valObj) {
              this.form.get(FccConstants.FCM_ACCOUNT_CURRENCY).patchValue(valObj[`value`]);
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

  onKeyupBeneficiaryBankIfscCodeIcons(event) {
    const keycodeIs = event.which || event.keyCode;
    if (keycodeIs === FccGlobalConstant.LENGTH_13) {
      this.onClickBeneficiaryBankIfscCodeIcons();
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
            this.form.get(FccConstants.BENEFICIARY_BANK_NAME).setValue(response.responseData.DRAWEE_BANK_DESCRIPTION);
            this.form.get(FccConstants.BENEFICIARY_BRANCH_CODE).setValue(response.responseData.DRAWEE_BRANCH_CODE);
            this.form.get(FccConstants.BENEFICIARY_BANK_BRANCH).setValue(response.responseData.DRAWEE_BRANCH_DESCRIPTION);
            this.form.updateValueAndValidity();
          }
        }
      );
  }

  preapreLookUpObjectData(obj) {
    let filterParams: any = {};
    filterParams.paymentType = this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE)?.value?.codeValue;
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

  onKeyupBeneficiaryBankIfscCode(event) {
    const keycodeIs = event.which || event.keyCode;
    if (keycodeIs === FccGlobalConstant.LENGTH_13 || keycodeIs === FccGlobalConstant.LENGTH_38
      || keycodeIs === FccGlobalConstant.LENGTH_40) {
      this.onClickBeneficiaryBankIfscCode();
    }
  }

  onClickBeneficiaryBankIfscCode() {
    if (this.form.get(FccConstants.BENE_BANK_IFSC_CODE).value) {
      const options = this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.OPTIONS];
      options.forEach(option => {
        if (option.value.label === this.form.get(FccConstants.BENE_BANK_IFSC_CODE).value?.label) {
          this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.PARAMS]['shortDescription']
          = option.value.drawee_bank_description+", "+option.value.drawee_branch_description;
          this.form.get(FccConstants.BENEFICIARY_BANK_CODE).setValue(option.value.drawee_bank_code);
          this.form.get(FccConstants.BENEFICIARY_BANK_NAME).setValue(option.value.drawee_bank_description);
          this.form.get(FccConstants.BENEFICIARY_BRANCH_CODE).setValue(option.value.drawee_branch_code);
          this.form.get(FccConstants.BENEFICIARY_BANK_BRANCH).setValue(option.value.drawee_branch_description);
        }
      });
      this.validateAccountNumber();
    }
  }

  onClickPaymentType() {
    let filterParams: any = {};
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE).value)) {
      filterParams.paymenttype = this.form.get(FccConstants.FCM_PAYMENT_PAYMENT_TYPE).value.codeValue;
      filterParams.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.shortName;
      filterParams = JSON.stringify(filterParams);
      this.initializeDropdownValues(FCMBeneConstants.FCM_BENEFICIARY_IFSC_DATA_OPTIONS, filterParams);
      this.initializeDropdownValues(FCMBeneConstants.FCM_BENEFICIARY_PACKAGE_DATA_OPTIONS, filterParams);

    }
  }

  onKeyupPaymentType(event) {
    const keycodeIs = event.which || event.keyCode;
    if (keycodeIs === FccGlobalConstant.LENGTH_13 || keycodeIs === FccGlobalConstant.LENGTH_38
      || keycodeIs === FccGlobalConstant.LENGTH_40) {
      this.onClickPaymentType();
    }
  }

  onClickTrashIcon(event, rowData, index) {
    const headerField = `${this.translateService.instant('deleteAccount')}`;
    const message = `${this.translateService.instant(
      'deleteAccountConfirmationMsg'
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
          this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA
          ].length === 1
        ) {
            this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA
          ] = [];
          this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.RENDERED
          ] = false;
          this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.RENDERED
          ] = false;
          this.form.get(FccConstants.UPDATE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.RENDERED
          ] = false;
          this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.RENDERED
          ] = true;
          this.resetRenderOnlyFields(this.form, this.accountFieldsList);
          this.setRenderOnlyFields(
            this.form,
            FCMBeneConstants.DISPLAY_ACCOUNTS_FIELDS,
            true
          );
          this.setRequired(this.form, FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS, true);
        } else {
          const retainedItem = this.form
          .get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.DATA].filter(
            (item, i) => i !== index
          );
          this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA
          ] = [];
          this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA
          ] = [...retainedItem];
          this.setDefaultAccountOnDelete(rowData);
        }
        this.checkForAddlimit();
      }
    }));
  }

  onClickPencilIcon(event, key, index, rowData) {
    this.editRecordIndex = index;
    if (
      this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.RENDERED]) {
      this.setRenderOnlyFields(
        this.form,
        this.accountFieldsList,
        false
      );
      this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.RENDERED] = false;
    }
    this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED] = false;
    this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED] = true;
    this.form.get(FccConstants.UPDATE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED] = true;
    this.setRenderOnlyFields(
      this.form,
      FCMBeneConstants.DISPLAY_ACCOUNTS_FIELDS,
      true
    );
    this.setRequired(this.form, FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS, true);
    this.getRegexValidation();
    this.retainRenderedOnlyField(
      this.form,
      this.accountFieldsList,
      rowData
    );
  }

  onSetDefaultAccount(event, index) {
    const control: any = this.form.get('accountListTable');
    control.params.data[index].defaultAccountFlag = event.checked ? FccGlobalConstant.CODE_Y : FccGlobalConstant.CODE_N;
    this.form.get('accountListTable').setValue(control);
  }

  checkForRequiredFields() {
    let invalidStatus = false;
    const requiredFieldsList = FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS;
    requiredFieldsList.forEach(field =>{
      if (this.form.get(field)[FccGlobalConstant.STATUS] === FccConstants.STATUS_INVALID) {
        invalidStatus = true;
        return;
      }
    });
    if (this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[
      FccGlobalConstant.STATUS] === FccConstants.STATUS_INVALID) {
        invalidStatus = true;
    }
    return invalidStatus;
  }

  addAdditionalAttributesInTableObject(gridObj) {
    gridObj[FccConstants.UPDATE_FLAG] = true;
    if (this.operation === FccGlobalConstant.UPDATE_FEATURES) {
      gridObj[FccConstants.LEGAL_ENTITY] = 'IN';
      gridObj[FccConstants.FCM_CLIENT_CODE_DETAILS] = this.form.value[FccConstants.FCM_CLIENT_CODE_DETAILS];
      gridObj[FccConstants.FCM_BENEFICIARY_CODE] = this.form.value[FccConstants.FCM_BENEFICIARY_CODE];
    }
  }

  onClickSaveAccountButton() {
    if (this.checkForRequiredFields()) {
      return;
    }

    if (this.isExistingAccountDefault) {
      this.setDefaultAccountFlagInExisting();
    } else {
      this.setDefaultAccountFlag();
      this.updateGrid();
    }
  }

  setDefaultAccountFlagInExisting() {
    const tableData = this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA];
    const field = this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG);
    if (field && field.value === FccGlobalConstant.CODE_Y &&
       (this.commonService.isEmptyValue(tableData) || tableData.length === FccGlobalConstant.LENGTH_0)) {
      this.openDefaultAccountDialog();
    } else if (field && field.value === FccGlobalConstant.CODE_Y && tableData.length >= 1 && this.noDefaultAccountPresent(tableData)) {
      this.openDefaultAccountDialog();
    } else if (field && field.value === FccGlobalConstant.CODE_Y && tableData.length >= 1 && !this.noDefaultAccountPresent(tableData)) {
      tableData.forEach(data => {
        data[FccConstants.DEFAULT_ACCOUNT_FLAG] = FccGlobalConstant.CODE_N;
      });
      this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG).setValue(FccGlobalConstant.CODE_Y);
      this.updateGrid();
    } else {
      this.updateGrid();
    }
  }
  updateGrid() {
    this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.LIST_DATA
    ] = true;
    this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS
    ] = this.accountColumnList;
    const gridObj = {};
    for (const item in this.form.value) {
      if (this.accountFieldsList.includes(item)) {
        gridObj[item] = this.form.value[item];
      }
    }
    this.addAdditionalAttributesInTableObject(gridObj);
    this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA].push(gridObj);
      this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.DATA] = [...this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
          FccGlobalConstant.DATA]];
      this.checkForAddlimit();
    this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = true;
    this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.setRenderOnlyFields(
      this.form,
      this.accountFieldsList,
      false
    );
    this.clearValidationRenderFields(
      this.form,
      this.accountFieldsList
    );
  }

  onClickAddAccountButton() {
    if (
      this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[
        FccGlobalConstant.STATUS] === FccConstants.STATUS_INVALID) {
      return;
    }
    this.setRenderOnlyFields(
      this.form,
      FCMBeneConstants.DISPLAY_ACCOUNTS_FIELDS,
      true
    );
    this.resetRenderOnlyFields(this.form, this.accountFieldsList);
    this.setRequired(this.form, FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS, true);
    this.getRegexValidation();
    this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = true;
    this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = true;
    this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.PARAMS]['shortDescription'] = "";
  }

checkForAddlimit() {
  const tableLength = this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
    FccGlobalConstant.DATA];
    if(this.operation === FccGlobalConstant.ADD_FEATURES && (tableLength?.length > this.accountLimit ||
      tableLength?.length === this.accountLimit) && this.form.get(FccConstants.BENEFICIARY_RADIO).value === FccConstants.BENE_TYPE_NEW) {
      this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS]["btndisable"] = true;
      this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.READONLY] = true;
      const errMsg = this.translateService.instant('maxAcclimit');
      this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS].warning = errMsg;
      this.form.get(FccConstants.ACCOUNTS_LIST_TABLE).setErrors({ err: true });
    } else {
      this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.READONLY] = false;
      this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS]["btndisable"] = false;
      this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.READONLY] = false;
      this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS]["btndisable"] = false;
      this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS].warning = '';
    }
}


  onClickUpdateAccountButton() {
    if (this.checkForRequiredFields()) {
      return;
    }
    this.setDefaultAccountFlag();
    const retainedRecord = this.form
      .get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.DATA].filter(
        (item, i) => i !== this.editRecordIndex
      );
    const gridObj = {};
    for (const item in this.form.value) {
      if (this.accountFieldsList.includes(item)) {
        gridObj[item] = this.form.value[item];
      }
    }
    this.addAdditionalAttributesInTableObject(gridObj);
    retainedRecord.splice(this.editRecordIndex, 0, gridObj);
    this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA
    ] = [...retainedRecord];
    this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.UPDATE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = true;
    this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.setRenderOnlyFields(
      this.form,
      this.accountFieldsList,
      false
    );
  }

  onClickCancelAccountButton() {
    this.setRenderOnlyFields(
      this.form,
      this.accountFieldsList,
      false
    );
    this.setRenderOnly(this.form,'beneficiaryAccountDetailsText',false);
    this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = true;
    this.form.get(FccConstants.UPDATE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
  }

  setDefaultAccountFlag() {
    const tableData = this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA];
    const field = this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG);
    if (this.commonService.isEmptyValue(tableData) || tableData.length === FccGlobalConstant.LENGTH_0) {
      this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG).setValue(FccGlobalConstant.CODE_Y);
    } else if (tableData.length === FccGlobalConstant.LENGTH_1 &&
      tableData[FccGlobalConstant.LENGTH_0][FccConstants.ACCOUNT_NUMBER] === this.form.get(
        FccConstants.ACCOUNT_NUMBER).value) {
          this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG).setValue(FccGlobalConstant.CODE_Y);
          this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.DATA][FccGlobalConstant.LENGTH_0][
              FccConstants.DEFAULT_ACCOUNT_FLAG] = FccGlobalConstant.CODE_Y;
    } else if (field && field.value === FccGlobalConstant.CODE_Y) {
      tableData.forEach(data => {
        data[FccConstants.DEFAULT_ACCOUNT_FLAG] = FccGlobalConstant.CODE_N;
      });
    } else if (tableData.length > 1 && this.noDefaultAccountPresent(tableData)) {
        this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
          FccGlobalConstant.DATA][FccGlobalConstant.LENGTH_0][
            FccConstants.DEFAULT_ACCOUNT_FLAG] = FccGlobalConstant.CODE_Y;
    }
  }

  setDefaultAccountOnDelete(rowData) {
    const tableData = this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA];
    if (tableData.length === FccGlobalConstant.LENGTH_1 || rowData.defaultAccountFlag === FccGlobalConstant.CODE_Y) {
      this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.DATA][FccGlobalConstant.LENGTH_0][
          FccConstants.DEFAULT_ACCOUNT_FLAG] = FccGlobalConstant.CODE_Y;
    }
  }

  noDefaultAccountPresent(tableData) {
    let flag = true;
    tableData.forEach(data =>{
      if (data[FccConstants.DEFAULT_ACCOUNT_FLAG] === FccGlobalConstant.CODE_Y) {
        flag = false;
      }
    });
    return flag;
  }

  checkAccountTableListExists() {
    if (this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS] && this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS].length > FccGlobalConstant.LENGTH_0 && this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[
        FccGlobalConstant.PARAMS][FccGlobalConstant.TABLE_DATA] && this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[
          FccGlobalConstant.PARAMS][FccGlobalConstant.TABLE_DATA].length > FccGlobalConstant.LENGTH_0) {
          this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
            FccGlobalConstant.LIST_DATA
          ] = true;
          let isDirty = false;
          this.accountFieldsList.forEach(field => {
            const control: any = this.form.get(field);
            if (control?.params?.rendered && control?.value) {
              isDirty = true;
            }
          });
          if (!isDirty) {
            this.setRenderOnlyFields(
              this.form,
              this.accountFieldsList,
              false
            );
            this.clearValidationRenderFields(
              this.form,
              this.accountFieldsList
            );
            this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
              FccGlobalConstant.RENDERED
            ] = false;
            this.setAddTableButtonForModifyBene(true);
          } else {
            if (this.form.get(FccConstants.UPDATE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED]) {
              this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                FccGlobalConstant.RENDERED
              ] = false;
            } else {
              this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
                FccGlobalConstant.RENDERED
              ] = true;
            }
            this.setAddTableButtonForModifyBene(false);
          }
    } else if (this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.COLUMNS] && this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.COLUMNS].length == FccGlobalConstant.LENGTH_0 && this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[
        FccGlobalConstant.PARAMS][FccGlobalConstant.TABLE_DATA] && this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[
          FccGlobalConstant.PARAMS][FccGlobalConstant.TABLE_DATA].length > FccGlobalConstant.LENGTH_0) {
      this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][FccGlobalConstant.TABLE_DATA] = [];
    }

  }

  setAddTableButtonForModifyBene(value) {
    if (this.operation === FccGlobalConstant.UPDATE_FEATURES) {
      this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.RENDERED
      ] = false;
      this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.RENDERED
      ] = false;
    } else {
      this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.RENDERED
      ] = value;
    }

  }

  resetRenderOnly(form, id) {
    this.resetValue(form, id, null);
    form.get(id).markAsUntouched();
    form.get(id).markAsPristine();
  }

  resetValidation(form, id) {
    form.get(id).setErrors(null);
    form.get(id).markAsUntouched();
    form.get(id).markAsPristine();
    form.get(id).clearValidators();
  }

  resetRenderOnlyFields(form, ids: string[]) {
    ids.forEach((id) => this.resetRenderOnly(form, id));
  }

  clearValidationRenderFields(form, ids: string[]) {
    ids.forEach((id) => this.resetValidation(form, id));
    this.form.updateValueAndValidity();
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

  setRequired(form, ids: string[], flag) {
    ids.forEach((id) => this.setRequiredOnly(form, id, flag));
  }

  setRequiredOnly(form, id, flag) {
    this.patchFieldParameters(form.controls[id], { required: flag });
  }

  retainRenderedOnlyField(form, ids: string[], rowdata) {
    for (const [key, value] of Object.entries(rowdata)) {
      this.patchFieldValueAndParameters(form.controls[key], value, {});
    }
  }
  onClickAccountCurrency() {
    this.commonService.amountConfig.subscribe((res)=>{
      if(res){
      this.formatAmountLimit(res);
      }
    });
    this.commonService.getamountConfiguration(FccConstants.FCM_ISO_CODE);
  }
  onClickClientDetails() {
    let filterParams: any = {};
    if (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value)) {
      this.form.get(FccConstants.FCM_CLIENT_NAME)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      if (!this.form.get(FccConstants.FCM_CLIENT_NAME).value ||
      (this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value && this.operation === FccGlobalConstant.ADD_FEATURES)) {
        this.patchFieldValueAndParameters(this.form.get(FccConstants.FCM_CLIENT_NAME),
        this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.name, {});
      }
      if(this.operation === FccGlobalConstant.ADD_FEATURES){
        this.getExistingBeneficiaryData();
      }
      this.openDialogForClientCode();
      filterParams.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
      filterParams = JSON.stringify(filterParams);
      this.subscriptions.push(
        this.commonService.getExternalStaticDataList(FccConstants.FCM_BENEFICIARY_CODE, filterParams).subscribe(response => {
          if(response) {
            this.beneficiaryFCMCode = response;
          }
        })
      );
      this.valMap.set(FccConstants.FCM_CLIENT_CODE_DETAILS,this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value);
    }
  }

  onKeyupClientDetails(event) {
   if(event.key === 'Enter') {
    this.onClickClientDetails();
   }
  }

  onBlurBeneficiaryCode() {
    let filterParams: any = {};
    filterParams.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
    filterParams.token = Math.floor(Math.random() * 1000);
    filterParams = JSON.stringify(filterParams);
    const beneCode = this.form.get(FccConstants.FCM_BENEFICIARY_CODE).value;
    this.subscriptions.push(
      this.commonService.getExternalStaticDataList(FccConstants.FCM_BENEFICIARY_CODE, filterParams).subscribe(response => {
        if(response) {
          this.beneficiaryFCMCode = response;
          for (const value of response) {
            if (beneCode === value.receiver_code) {
              this.form.get(FccConstants.FCM_BENEFICIARY_CODE).setErrors({ beneficiaryCodeExist : true });
            }
          }
        }
      })
    );
  }

  onBlurAccountNumber() {
    if(!this.checkAccountNumberMatch()) {
      this.form.get(FccConstants.FCM_CONFIRM_ACCONT_NO).setErrors({ accountNumberMismatch : true });
    } else {
      this.form.get(FccConstants.FCM_CONFIRM_ACCONT_NO).setErrors(null);
    }
    this.validateAccountNumber();
  }

  onBlurConfirmAccountNumber() {
    if(!this.checkAccountNumberMatch()) {
      this.form.get(FccConstants.FCM_CONFIRM_ACCONT_NO).setErrors({ accountNumberMismatch : true });
    }
  }

  onBlurNumberOfTransaction() {
    if (this.form.get(FccConstants.FCM_NO_OF_TRANSACTION).valid) {
      if (this.form.get(FccConstants.FCM_NO_OF_TRANSACTION).value &&
      (this.form.get(FccConstants.FCM_NO_OF_TRANSACTION).value <= FccGlobalConstant.ZERO)) {
        this.form.get(FccConstants.FCM_NO_OF_TRANSACTION).setErrors({ nonZeroFieldValue: true });
      } else {
        this.form.get(FccConstants.FCM_NO_OF_TRANSACTION).setErrors(null);
      }
    }
  }

  onClickAmountLimit(){
    this.OnClickAmountFieldHandler(FccConstants.FCM_AMOUNT_LIMIT);
  }

  onBlurAmountLimit() {
    this.setAmountLengthValidator(FccConstants.FCM_AMOUNT_LIMIT);
    if (this.form.get(FccConstants.FCM_AMOUNT_LIMIT).value &&
          (this.form.get(FccConstants.FCM_AMOUNT_LIMIT).value <= FccGlobalConstant.ZERO)) {
        this.form.get(FccConstants.FCM_AMOUNT_LIMIT).setErrors({ amountCanNotBeZero: true });
    } else {
      this.commonService.amountConfig.subscribe((res)=>{
        if(res){
        this.formatAmountLimit(res);
        }
      });
    }

  }

  onBlurNewAmountLimit(){
    this.setAmountLengthValidator(FccConstants.NEW_FCM_AMOUNT_LIMIT);
    if (this.form.get(FccConstants.NEW_FCM_AMOUNT_LIMIT).value &&
          (this.form.get(FccConstants.NEW_FCM_AMOUNT_LIMIT).value <= FccGlobalConstant.ZERO)) {
        this.form.get(FccConstants.NEW_FCM_AMOUNT_LIMIT).setErrors({ amountCanNotBeZero: true });
    } else {
      this.formatNewAmountLimit();
    }
  }

  onClickNewAmountLimit(){
    this.OnClickAmountFieldHandler(FccConstants.NEW_FCM_AMOUNT_LIMIT);
  }

  onFocusNewAmountLimit() {
    this.form.get(FccConstants.NEW_FCM_AMOUNT_LIMIT).clearValidators();
  }

  onFocusAmountLimit() {
    this.form.get(FccConstants.FCM_AMOUNT_LIMIT).clearValidators();
  }

  formatNewAmountLimit() {
    const val = this.form.get(FccConstants.NEW_FCM_AMOUNT_LIMIT).value;
    let valueupdated;
    if (val) {
      valueupdated = this.commonService.replaceCurrency(val);
      valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), FccConstants.FCM_ISO_CODE);
      this.form.get(FccConstants.NEW_FCM_AMOUNT_LIMIT).setValue(valueupdated);
    }
  }

  formatAmountLimit(data) {
    const val = this.form.get(FccConstants.FCM_AMOUNT_LIMIT).value;
    let valueupdated;
    if (val) {
      valueupdated = this.commonService.replaceCurrency(val);
      valueupdated = this.currencyConverterPipe.transform(valueupdated.toString(), FccConstants.FCM_ISO_CODE, data);
      this.form.get(FccConstants.FCM_AMOUNT_LIMIT).setValue(valueupdated);
    }
  }

  onClickReceiverType() {
    if (this.form.get(FccConstants.FCM_RECEIVER_TYPE).value === FccConstants.RECEIVER_TYPE_CORPORATE) {
      this.form.get(FccConstants.FCM_LEI_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
    } else {
      this.form.get(FccConstants.FCM_LEI_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
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

  onBlurEmailID(){
    this.updateEmailValidity();
  }

   doBeneFormValidation() {

      this.form.addFCCValidators(
        FccConstants.FCM_BENEFECIARY_NAME,
        Validators.pattern(this.beneficiaryNameRegex),
        0
      );

      this.form.addFCCValidators(
        FccConstants.FCM_BENEFICIARY_CODE,
        Validators.pattern(this.beneficiaryCodeRegex),
        0
      );

      this.updateEmailValidity();

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

      this.form.addFCCValidators(
        FccConstants.FCM_MOBILE_NO,
        Validators.pattern(this.mobileNumberRegex),
        0
      );

      this.form.addFCCValidators(
        FccConstants.FCM_ADDRESS_LINE_1,
        Validators.pattern(this.addrLine1Regex),
        0
      );

      this.form.addFCCValidators(
        FccConstants.FCM_ADDRESS_LINE_2,
        Validators.pattern(this.addrLine2Regex),
        0
      );

      this.form.addFCCValidators(
        FccConstants.FCM_NO_OF_TRANSACTION,
        Validators.pattern(this.noOfTxnRegex),
        0
      );

      this.form.addFCCValidators(
        FccConstants.FCM_LEI_CODE,
        Validators.pattern(this.leiCodeRegex),
        0
      );

      if (this.operation === FccGlobalConstant.UPDATE_FEATURES) {


        this.form.addFCCValidators(
          FccConstants.NEW_FCM_MOBILE_NO,
          Validators.pattern(this.mobileNumberRegex),
          0
        );

        this.form.addFCCValidators(
          FccConstants.NEW_FCM_ADDRESS_LINE_1,
          Validators.pattern(this.addrLine1Regex),
          0
        );

        this.form.addFCCValidators(
          FccConstants.NEW_FCM_ADDRESS_LINE_2,
          Validators.pattern(this.addrLine2Regex),
          0
        );
      }
    }

  ngOnDestroy(): void {
  //  this.openDailog();
    if (this.form && this.commonService.isNonEmptyField(FccConstants.ADDITIONAL_INFORMATION, this.form) &&
    this.form.get(FccConstants.ADDITIONAL_INFORMATION).value === FccGlobalConstant.CODE_Y) {
      this.form.get(FccConstants.ADDITIONAL_INFORMATION_HEADER)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.RENDERED] = true;
        this.setPackageType();
        this.setcompleteAddress();
    }
    if (this.operation === FccGlobalConstant.UPDATE_FEATURES) {
      this.setcompleteAddress();
    }
    if (this.form && this.commonService.isNonEmptyField(FccConstants.REMARKS, this.form) &&
    this.form.get(FccConstants.REMARKS).value === FccGlobalConstant.CODE_Y) {
      this.form.get(FccConstants.REMARKS_HEADER)[FccGlobalConstant.PARAMS][
        FccGlobalConstant.RENDERED] = true;
    }
    this.subscriptions.forEach(subs => subs.unsubscribe());
    this.commonService.isStepperDisabled = true;
  }

  /**
   * opens confirmation dialog on Client code filed change
   */
  openDialogForClientCode() {
    const clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
    const preClientName = this.valMap.get(FccConstants.FCM_CLIENT_CODE_DETAILS);
    if (this.commonService.isNonEmptyValue(preClientName) && preClientName.label !== clientCode) {
      if (this.count === 0 && this.checkForNonEmptyField(this.form)) {
        this.openDialog(FccConstants.FCM_CLIENT_CODE_DETAILS, preClientName);
      }
    }
  }

  openDialog(controlName: any, oldFiledValue: any) {
    const message = `${this.translateService.instant('filedChangeMsg')}`;
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
    this.dialogRef.onClose.subscribe((result) => {
      if (result.toLowerCase() === 'yes') {
        this.isDialogCloseResp = true;
        this.count = 0;
        this.resetFormFieldValues(this.form);
        this.form.get(FccConstants.BENE_BANK_IFSC_CODE)[FccGlobalConstant.PARAMS]['shortDescription'] = "";
        this.resetAccountTableGrid();
        if (this.form.get(FccConstants.BENEFICIARY_RADIO).value === FccConstants.BENE_TYPE_EXISTING) {
          this.setRenderOnlyFields(
            this.form,
            FccConstants.FCM_NEW_BENE_FIELDS,
            false
          );
          this.setRenderOnly(this.form,FccConstants.EXISTING_BENE_NAME,false);
          this.setRenderOnly(this.form,FccConstants.BENE_HEADER,true);
        }
        this.form.get(FccConstants.ADDITIONAL_INFORMATION).setValue(FccGlobalConstant.CODE_N);
        this.form.get(FccConstants.REMARKS).setValue(FccGlobalConstant.CODE_N);
        this.onClickAdditionalInformation();
        this.onClickRemarks();
      } else {
        this.isDialogCloseResp = false;
        this.count = 0;
        this.form.controls[controlName].setValue(oldFiledValue);
        this.valMap.set(FccConstants.FCM_CLIENT_CODE_DETAILS, this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value);
        this.patchFieldValueAndParameters(this.form.get(FccConstants.FCM_CLIENT_NAME),
          this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.name, {});

      }
    });
    this.dialogRef.onDestroy.subscribe(() => {
      if (!this.isDialogCloseResp) {
        this.count = 0;
        this.form.controls[controlName].setValue(oldFiledValue);
        this.valMap.set(FccConstants.FCM_CLIENT_CODE_DETAILS, this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value);
        this.patchFieldValueAndParameters(this.form.get(FccConstants.FCM_CLIENT_NAME),
          this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.name, {});
      }
      this.isDialogCloseResp = false;
    }
    );

  }

  /**
   * this fucntion checks if there is any value inside form field
   * @param formGroup
   * @returns
   */
  checkForNonEmptyField(formGroup: FCCFormGroup): boolean {
    let result = false;
    Object.keys(formGroup.controls).forEach((field: any) => {
      const fieldDtls: any = formGroup.controls[field];
      if (field != FccConstants.FCM_CLIENT_CODE_DETAILS && field != FccConstants.FCM_CLIENT_NAME
        && fieldDtls.touched && field != FccConstants.BENEFICIARY_RADIO) {
        const controlVal = formGroup.get(field).value;
        if (controlVal) {
          result = true;
        }
      }
    });
    return result;
  }

  /**
   * Function to reset form field values apart
   * from client code and name
   * @param formGroup
   */
  resetFormFieldValues(formGroup: FCCFormGroup) {
    Object.keys(formGroup.controls).forEach((field: any) => {
      const fieldDtls: any = formGroup.controls[field];
      if (field != FccConstants.FCM_CLIENT_CODE_DETAILS && field != FccConstants.FCM_CLIENT_NAME
        && (fieldDtls.type === 'input-text' || fieldDtls.type === 'input-dropdown-filter' || fieldDtls.type === 'view-mode')) {
        this.resetValue(formGroup, field, null);
      }
    });
  }

  resetAccountTableGrid() {
    this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA
    ] = [];
    this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.UPDATE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = false;
    this.form.get(FccConstants.SAVE_TABLE_BUTTON)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.RENDERED
    ] = true;
    this.resetRenderOnlyFields(this.form, this.accountFieldsList);
    this.setRenderOnlyFields(
      this.form,
      FCMBeneConstants.DISPLAY_ACCOUNTS_FIELDS,
      true
    );
    this.setRequired(this.form, FCMBeneConstants.ACCOUNTS_TABLE_REQUIRED_FIELDS, true);
    this.getRegexValidation();
  }

  /**
   * function to validate existing account number and
   * IFSC code pair
   */
   validateAccountNumber() {
    const accListTable = (this.form.get(FccConstants.ACCOUNTS_LIST_TABLE) as any).params.data;
    if (accListTable) {
      for (const val of accListTable) {
        if (val[FccConstants.ACCOUNT_NUMBER] === this.form.get(FccConstants.ACCOUNT_NUMBER).value
          && val[FccConstants.BENE_BANK_IFSC_CODE].label === this.form.get(FccConstants.BENE_BANK_IFSC_CODE).value.label) {
          this.form.get(FccConstants.ACCOUNT_NUMBER).setErrors({ accountNumberExist: true });
          this.form.get(FccConstants.BENE_BANK_IFSC_CODE).setErrors({ accountNumberExist: true });
          return;
        }else{
          this.form.get(FccConstants.ACCOUNT_NUMBER).enable();
          this.form.get(FccConstants.BENE_BANK_IFSC_CODE).enable();
        }
      }
    }
    if (this.commonService.isNonEmptyValue(this.accountNumberIfscCodePairRes)) {
      const accountNumber = this.form.get(FccConstants.ACCOUNT_NUMBER).value;
      const ifscCode = this.form.get(FccConstants.BENE_BANK_IFSC_CODE).value.label;
      for (const value of this.accountNumberIfscCodePairRes) {
        if (accountNumber === value.accountnumber && ifscCode === value.beneficiarybankifsccode) {
          this.form.get(FccConstants.ACCOUNT_NUMBER).setErrors({ accountNumberExist: true });
          this.form.get(FccConstants.BENE_BANK_IFSC_CODE).setErrors({ accountNumberExist: true });
          return;

        }else{
          this.form.get(FccConstants.ACCOUNT_NUMBER).enable();
          this.form.get(FccConstants.BENE_BANK_IFSC_CODE).enable();
        }
      }
    }
  }

  fetchAccountIFSCpairDetails(){
    this.subscriptions.push(
      this.commonService.getExternalStaticDataList(FccConstants.ACCOUNT_NUMBER_IFSC_CODE_PAIR).subscribe(response => {
        if(response) {
          this.accountNumberIfscCodePairRes = response;
        }
      })
    );
  }

  getExistingBeneficiaryData() {
    let filterParams: any = {};
    filterParams.clientCode = this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label;
    filterParams = JSON.stringify(filterParams);

    this.subscriptions.push(
      this.commonService.getExternalStaticDataList(FccConstants.EXISTING_APPROVED_BENE_BY_CLIENT_CODE, filterParams).subscribe(response => {
        if(response) {
            response.forEach(element => {
              this.form.controls[FccConstants.EXISTING_BENE_CODE][FccConstants.FCM_OPTIONS].push(
                {
                  label : element.receiver_code,
                  value : {
                    label: element.receiver_code,
                    name: element.drawer_description,
                    shortName: element.receiver_code,
                  }
                }
              );
            });

          if(!this.commonService.isEmptyValue(response) && response.length > 0){
            this.setRenderOnly(this.form,FccConstants.BENEFICIARY_RADIO,true);
          } else {
            this.setRenderOnly(this.form,FccConstants.BENEFICIARY_RADIO,false);
            this.setRenderOnlyFields(this.form,FccConstants.FCM_NEW_BENE_FIELDS,true);
          }
        }
      })
    );
  }

  onClickBeneficiaryRadio(event){
    this.form.get(FccConstants.ACCOUNTS_LIST_TABLE)[FccGlobalConstant.PARAMS][
      FccGlobalConstant.DATA] = [];
    this.form.get(FccConstants.ADDITIONAL_INFORMATION).setValue(FccGlobalConstant.CODE_N);
    this.form.get(FccConstants.REMARKS).setValue(FccGlobalConstant.CODE_N);
    this.onClickAdditionalInformation();
    this.onClickRemarks();
    if(event.value === FccConstants.BENE_TYPE_NEW){
      this.setRenderOnlyFields(this.form,FccConstants.FCM_NEW_BENE_FIELDS,true);
      this.setRenderOnly(this.form,FccConstants.EXISTING_BENE_CODE,false);
      this.setRenderOnly(this.form, FccConstants.ADD_TABLE_BUTTON, false);
      this.form.get(FccConstants.EXISTING_BENE_NAME)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.resetRenderOnlyFields(this.form,FccConstants.FCM_NEW_BENE_FIELDS);
      this.resetRenderOnlyFields(this.form, FCMBeneConstants.FCM_BENEFICIARY_ADDITIONAL_INFO_FIELDS);
      this.resetRenderOnly(this.form, FCMBeneConstants.FCM_MAKER_REMARKS);
      this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.form.get(FccConstants.EXISTING_BENE_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      this.form.get(FccConstants.EXISTING_BENE_CODE).updateValueAndValidity();
    } else if (event.value === FccConstants.BENE_TYPE_EXISTING){
      this.setRenderOnlyFields(this.form,FccConstants.FCM_NEW_BENE_FIELDS,false);
      this.setRenderOnly(this.form,FccConstants.EXISTING_BENE_CODE,true);
      this.resetRenderOnly(this.form,FccConstants.EXISTING_BENE_CODE);
      this.setRenderOnly(this.form,FccConstants.BENE_HEADER,true);
      this.form.get(FccConstants.CANCEL_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get(FccConstants.ADD_TABLE_BUTTON)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      this.form.get(FccConstants.EXISTING_BENE_CODE)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      this.form.get(FccConstants.EXISTING_BENE_CODE).updateValueAndValidity();
    }
  }

  onClickExistingBeneficiaryCode(){
    if (this.form.get(FccConstants.EXISTING_BENE_CODE).value) {
      this.form.get(FccConstants.EXISTING_BENE_NAME)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      this.patchFieldValueAndParameters(this.form.get(FccConstants.EXISTING_BENE_NAME),
      this.form.get(FccConstants.EXISTING_BENE_CODE).value.name, {});
      this.form.get(FccConstants.FCM_BENEFICIARY_CODE).setValue(this.form.get(FccConstants.EXISTING_BENE_CODE).value);
      this.form.get(FccConstants.FCM_BENEFECIARY_NAME).setValue(this.form.get(FccConstants.EXISTING_BENE_NAME).value);
      this.getBeneficiaryDetails();
    }
  }

  getBeneficiaryDetails() {
    this.stateService.populateAllEmptySectionsInState();
    this.productMappingService.getApiModel(undefined, undefined, undefined, undefined, undefined,
      'BENEFICIARY_MASTER_MAINTENANCE_MC',
      'FCM').subscribe(apiMappingModel => {
        this.commonService.getBeneficiaryDetails(this.form.get(FccConstants.EXISTING_BENE_CODE).value.label).subscribe(response => {
          if (response?.body.data) {
            this.isExistingAccountDefault = true;
            this.setRenderOnlyFields(this.form, FccConstants.FCM_EXISTING_BENE_FIELDS, true);
            this.setRenderOnlyFields(this.form, FCMBeneConstants.DISPLAY_ACCOUNTS_FIELDS, false);
            this.setRenderOnly(this.form, FccConstants.SAVE_TABLE_BUTTON, false);
            this.setRenderOnly(this.form, FccConstants.CANCEL_TABLE_BUTTON, false);
            this.setRenderOnly(this.form, FccConstants.ADD_TABLE_BUTTON, true);
            this.setRenderOnly(this.form, FccConstants.ACCOUNT_HEADER, true);
            this.productMappingService.setStateFromMapModel(apiMappingModel, FccConstants.FCM_BENEFICIARY_GENERAL_DETAILS,
              this.form, response.body.data,
              "BENE", null, false);
            this.patchInputFields(response?.body.data);
            this.form.updateValueAndValidity();
            this.patchDropdownValue(FccConstants.FCM_PACKAGE);
            this.patchDropdownValue(FccConstants.FCM_RECEIVER_TYPE);
            this.checkIfAdditionalInfoExist();
            this.checkIfRemarksExist();
          }
        });
      });
  }

  patchInputFields(jsnObj) {
    this.form.get(FccConstants.FCM_EMAIL_ID).setValue(jsnObj.email);
    this.form.get(FccConstants.FCM_MOBILE_NO).setValue(jsnObj.mobile);
    this.form.get(FccConstants.FCM_ADDRESS_LINE_1).setValue(jsnObj.addressLine1);
    this.form.get(FccConstants.FCM_ADDRESS_LINE_2).setValue(jsnObj.addressLine2);
    this.form.get(FccConstants.FCM_PIN_CODE).setValue(jsnObj.postalCode);
    this.form.get(FccConstants.FCM_NO_OF_TRANSACTION).setValue(jsnObj.limitOnTransactions);
    this.form.get(FccConstants.FCM_AMOUNT_LIMIT).setValue(jsnObj.limitOnAmount);
    this.form.get(FccConstants.FCM_LEI_CODE).setValue(jsnObj.leiCode);
    this.form.get(FCMBeneConstants.FCM_MAKER_REMARKS).setValue(jsnObj.makerRemarks);
  }

  patchDropdownValue(key) {
    if (this.form.get(key).value !== FccGlobalConstant.EMPTY_STRING) {
      const valObj = this.dropdownAPIService.getDropDownFilterValueObj(this.form.controls[key]['options'], key, this.form);
      if (valObj) {
        this.form.get(key).patchValue(valObj[`value`]);
      }
    }
  }

  checkIfAdditionalInfoExist() {
    FCMBeneConstants.FCM_BENEFICIARY_ADDITIONAL_INFO_FIELDS.forEach((field) => {
      if (this.form.controls[field].value !== null && this.commonService.isnonEMptyString(this.form.controls[field].value)) {
        this.form.get(FccConstants.ADDITIONAL_INFORMATION).setValue(FccGlobalConstant.CODE_Y);
        this.onClickAdditionalInformation();
        return;
      }
    });
  }

  checkIfRemarksExist() {
    if (this.form.controls[FCMBeneConstants.FCM_MAKER_REMARKS].value !== null
      && this.commonService.isnonEMptyString(this.form.controls[FCMBeneConstants.FCM_MAKER_REMARKS].value)) {
      this.form.get(FCMBeneConstants.FCM_REMARKS).setValue(FccGlobalConstant.CODE_Y);
      this.form.get(FCMBeneConstants.FCM_MAKER_REMARKS)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
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

  openDefaultAccountDialog() {
    const message = `${this.translateService.instant('defaultAccountChangeMsg')}`;
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
    this.dialogRef.onClose.subscribe((result) => {
      if (result.toLowerCase() === 'yes') {
        this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG).setValue(FccGlobalConstant.CODE_Y);
      } else {
        this.form.get(FccConstants.DEFAULT_ACCOUNT_FLAG).setValue(FccGlobalConstant.CODE_N);
      }
      this.updateGrid();
    });
  }
}
