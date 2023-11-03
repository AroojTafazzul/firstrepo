import { LocationStrategy, getCurrencySymbol } from '@angular/common';
import { HttpClient, HttpHeaders, HttpParams, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AbstractControl, Validators } from '@angular/forms';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer, Title } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DialogService } from 'primeng';
import { MenuItem, Message } from 'primeng/api';
import { BehaviorSubject, Observable, Subject } from 'rxjs';
import { shareReplay } from 'rxjs/operators';

import { invalidAmount } from '../../corporate/trade/lc/initiation/validator/ValidateAmt';
import { FccConstants } from '../core/fcc-constants';
import { FccGlobalConstant } from '../core/fcc-global-constants';
import { CorporateDetails } from '../model/corporateDetails';
import { CounterpartyRequest } from '../model/counterpartyRequest';
import { ProductParams } from '../model/params-model';
import { ResetPasswordRequestData } from '../retrievecredential/model/retrieveCredentialsReqData';
import { FCCFormGroup } from './../../base/model/fcc-control.model';
import { ListDefService } from './../../common/services/listdef.service';
import { FccGlobalConstantService } from './../core/fcc-global-constant.service';
import { CodeData } from './../model/codeData';
import { DeepLinkingService } from './deep-linking.service';
import { FileUploadHandlerService } from './file-upload-handler.service';
import { LicenseDetailsHandlerService } from './license-details-handler.service';
import { FormService } from './listdef-form-service';
import { NudgesService } from './nudges.service';
import { MessageService } from 'primeng';
import { FCCBase } from '../../base/model/fcc-base';

@Injectable({ providedIn: 'root' })
export class CommonService extends FCCBase {
  public static isTemplateCreation = false;
  public queryParameters = new Map([]);
  authenticated: any;
  referenceId;
  beneGroupId;
  eventId;
  isnewEventSaved = false;
  applDate;
  masterAllAccountlistingArray: any;
  public isSubmitAllowed = new BehaviorSubject(false);
  public parentFormValidCheck = new BehaviorSubject(false);
  public sectionItemList = new BehaviorSubject([]);
  isSaveAllowed = true;
  angularProducts: string[];
  viewAllScreens: string[];
  public getProductCode = new BehaviorSubject<any>(null);
  public displayFacilityFeeCycle = new BehaviorSubject<boolean>(false);
  public facilityFeeCycleFilterCriteria = new BehaviorSubject<any>(null);
  public chequeViewDetails = new BehaviorSubject(null);
  public batchRefId = new BehaviorSubject(null);
  allAccountType = false;
  multipleablesInaPage = false;
  public isSpacerRequired = false;
  public applDateService = new BehaviorSubject<any>(null);
  public inputParamList: any;
  public bindingValue: any;
  public filterDataAvailable = false;
  public filterPreferenceData: any;
  public licenseCheckBoxRequired = 'Y';
  public swiftVersion;
  public formLicenseGrid = false;
  public amendDescofGooodsHandle = false;
  public narrativeDetailsHandle = false;
  public amendDescofGooodsCounter = 0;
  public narrativeDraft = false;
  public formDocumentGrid = false;
  public freeFormatOptionSelected = false;
  public autoSavedTime = new BehaviorSubject<any>(null);
  angularSubProducts: string[];
  private sessionIdleTimeout: number;
  public dashboardWidget = false;
  private useMidRate: boolean;
  private starRatingSize;
  private feedbackCharLength;
  private homeUrl;
  private onDemandTimedLogout;
  filterParams;
  allGroupAccountsData: any[] = [];
  contentType = 'Content-Type';
  public LayoutSetting: any = 'layout1';
  private maxUploadSize;
  public dashboardOptionsSubject = new BehaviorSubject<any>(null);
  public landingiconHide = new BehaviorSubject<any>(true);
  public footerStatus = new BehaviorSubject<any>(false);
  public TFRequestType = new BehaviorSubject<any>(null);
  public channelRefNo = new BehaviorSubject<any>(null);
  public warningCancelResponse = new BehaviorSubject(null);
  public FTRequestType = new BehaviorSubject<any>(1);
  public defaultLicenseFilter = false;
  public iframeURL: any;
  public deepLinkingQueryParameter: any;
  public toggleLicenseFilter = false;
  public radioButtonHeaderRequired = false;
  public backTobackExpDateFilter = false;
  public actionsDisable = false;
  public buttonsDisable = false;
  private menuObject: MenuItem[] = [];
  public dir: string;
  public languageOf: string;
  public igroupName: any;
  public loginDataMap = new Map([]);
  public termsAndConditionData = new Map([]);
  public loginModeMap = new Map([]);
  public dojoIdentifiermap = new Map([]);
  public sessionFlagmap = new Map([]);
  private landingPage;
  public dashboardType = 'globalDashboard';
  public landingPageLinksMap = new Map([]);
  public productNameRoute = '';
  public dashboardProductPath = '';
  public topMenuToggle: BehaviorSubject<string>;
  public showCustomHeader = false;
  public buttonItemsMap = new Map([]);
  public masterDataMap = new Map([]);
  public pdfDecodeValue = false;
  public modePdf = false;
  public decodeNarrative = true;
  public formLoadDraft = true;
  private shipmentExpiryDateForBackToBack: any;
  private amountForBackToBack: any;
  private clearBackToBackLCfields: any;
  public listDataFilterParams: any;
  public selectedRows = [];
  public summaryDetails = {};
  public tableColumnHeaders: any;
  private totalBeneFavCount: number;
  openReauthDialog$ = new BehaviorSubject(null);
  openSessionWarningDialog$ = new BehaviorSubject(null);
  openChipConfirmationDialog$ = new BehaviorSubject(null);
  responseChipConfirmationDialog$ = new BehaviorSubject(null);
  public globalBankDate$ = new BehaviorSubject<any>({});
  initiateProdComp$ = new BehaviorSubject(null);
  filterDialogueStatus = new BehaviorSubject(null);
  noReloadListDef = false;
  filterInputVal: any;
  // Observable string sources
  private listenEditClick = new Subject<string>();
  savedResponse = new Subject<any>();
  errorResponse = new Subject<any>();
  // Observable string streams
  editClicked$ = this.listenEditClick.asObservable();
  savedResponse$ = this.savedResponse.asObservable();
  errorResponse$ = this.errorResponse.asObservable();
  openLegelTextDialog$ = new BehaviorSubject(null);
  // Observable string sources
  private missionAnnouncedSource = new Subject<string>();
  // Observable string streams
  missionAnnounced$ = this.missionAnnouncedSource.asObservable();

  // Observable string sources
  private listenInstInquiryClicked = new Subject<string>();

  // Observable string streams
  listenInstInquiryClicked$ = this.listenInstInquiryClicked.asObservable();

  // Observable string sources
  private listenJourneyClick = new Subject<string>();
  // Observable string streams
  journeyClicked$ = this.listenJourneyClick.asObservable();

  // Observable string sources
  private listenSetEntityClicked = new Subject<string>();
  // Observable string streams
  listenSetEntityClicked$ = this.listenSetEntityClicked.asObservable();

  private listenSetEntitySuccess = new Subject<string>();
  // Observable string streams
  listenSetEntitySuccess$ = this.listenSetEntitySuccess.asObservable();

  // Observable string sources
  private listenSetReferenceClicked = new Subject<string>();
  // Observable string streams
  listenSetReferenceClicked$ = this.listenSetReferenceClicked.asObservable();

  // Observable string sources
  private eyeIconClicked = new Subject<string>();
  // Observable string streams
  eyeIconClicked$ = this.eyeIconClicked.asObservable();

  private listenSetReferenceSuccess = new Subject<string>();
  // Observable string streams
  listenSetReferenceSuccess$ = this.listenSetReferenceSuccess.asObservable();

    // bene Save Toggle
    toggleVisibilityChange = new Subject<boolean>();
    istoggleVisible = true;
  // Cache Map to store the repeated get request responses
  private cachedResponses = new Map<string, any>();

  // etag version change
  etagVersionChange = new Subject<any>();

  eTagVersion: string;

  // user permissions map
  private userPermissions = new Map([]);

  // user permmission map grouped by entity
  private userPermissionsByEntityMap = new Map<string, Map<string, boolean>>();

  private loginImageFilePath = '';

  public isTranslationServiceInitialized = new BehaviorSubject(false);

  // Observable string sources
  public listenTransmissionMode = new Subject<string>();
  // Observable string streams
  tranmissionModeChanged$ = this.listenTransmissionMode.asObservable();

  private enrichmentTableMap = new Map<number, any>();

  public paymentBatchBalanceValidation = new BehaviorSubject(false);


  errorStatus: any;
  commonErrPage: any;
  errorList: string[] = [];
  interceptorRetry: any = 0;
  responseStatusCode = 200;
  otpAuthScreenSource = '';
  isViewPopup = false;
  parent = false;
  displayableJsonValue: any;
  metadata: any;
  inputParams: any = {};
  requestForm = 'REQUEST-FROM';
  cacheRequest = 'cache-request';
  counterpartyRequest: CounterpartyRequest;
  corporateDetails: CorporateDetails;
  companyBaseCurrency: any;
  isEnableUxAddOn: boolean;
  settlementCurCode: any;
  amountFormatAbbvNameList: any;

  private resetPasswordData: ResetPasswordRequestData;

  private tfBillAmount: any;
  enteredCharCountBtBTemp;
  currentStateRefId: string;
  currentStateApiModel: any;
  currentStateTnxResponse: any;
  tnxResponse: any;
  private lcResponse: string;
  private tfFinAmount: any;
  private tfFinCurrency: any;
  enableLicenseSection: boolean;
  private componentRowData: any;
  viewPopupFlag = false;
  comparisonPopup = false;
  public isMasterRequired = false;
  liMode: any;
  liCopyFrom: any;
  addressType: any;
  public rowSellistdefName: string;
  responseMap: Map<any, any> = new Map();
  public isResponse = new BehaviorSubject(false);
  currentUserMail: any;
  loginUserId: any;
  public siBankDetailResponseObj;
  public siViewSpecimenDownloadParams;
  public uiBankDetailResponseObj;
  public uiViewSpecimenDownloadParams;
  public productState = new BehaviorSubject<any>({});
  public loadForEventValues = new BehaviorSubject<any>({});
  mode: string;
  currentRouteTitle = new BehaviorSubject<string>('');
  titleKey: any;
  mainTitleKey: any;
  option: string;
  public parentReference = new BehaviorSubject<string>('');
  public parentTnxObj = new BehaviorSubject<string>('');
  isCompanyCaseSensitiveSearchEnabled: boolean;
  isUserCaseSensitiveSearchEnabled: boolean;
  widgetClicked = '';
  isStaticAccountEnabled: boolean;
  public dealDetailsBehaviourSubject = new BehaviorSubject(null);
  nudges: any;
  isMT700Upload: any;
  public externalUrlLink: any;
  public displayDialog = false;
  filterPreference: any = {};
  isStepperDisabled: boolean;
  private showPopup: boolean;
  private actionPopup: boolean;
  isFooterSticky = new BehaviorSubject(false);
  setActiveTab = false;
  setActiveTabIndex = 0;
  inputAutoComp = new BehaviorSubject(false);
  refreshPaymentList = new BehaviorSubject(false);
  refreshPaymentWidgetList = new BehaviorSubject(null);
  refreshBeneApprovalWidgetList = new BehaviorSubject(null);
  amountConfig = new BehaviorSubject("");
  getType: string;
  paymentWidget = false;
  beneApproveRejectWidget = false;
  beneApproveRejectWidgetRejectReason = '';
  beneApproveRejectWidgetclose = false;
  paymentWidgetListdefFilter: string;
  isChildList = new BehaviorSubject(false);
  batchAmtTransactionSubject$ = new BehaviorSubject(new Map());
  isViewMore = new BehaviorSubject(false);
  private batchFormData : any[] = [];
  allowedDocViewerMimeTypes: string[] = [];
  beneficiaryEmailLimit:number;
  batchEditInstrument = new BehaviorSubject(null);
  onBatchTxnUpdateClick = new BehaviorSubject(null);
  batchData = new BehaviorSubject(null);
  batchDiscardInstrument = new BehaviorSubject(-1);
  batchEditSubmitFlag = new BehaviorSubject(null);
  batchInstrumntCancelFlag = new BehaviorSubject(false);
  batchTransactionBalance = new BehaviorSubject(null);
  buttonList: any[] = [];
  refreshTable = new BehaviorSubject(false);
  scrapCommentRequired=false;
  displayRemarks = new BehaviorSubject(null);
  public isssoENabled = new BehaviorSubject(false);
  refreshBatchDetails = new BehaviorSubject(false);

  compName: any;
  constructor(
    protected http: HttpClient, public fccGlobalConstantService: FccGlobalConstantService,
    public translate: TranslateService, public locationStrategy: LocationStrategy,
    protected router: Router, protected matIconRegistry: MatIconRegistry, protected domSanitizer: DomSanitizer,
    public fileUploadHandlerService: FileUploadHandlerService, public licenseDetailsHandlerService: LicenseDetailsHandlerService,
    protected route: ActivatedRoute, protected titleService: Title,
    protected listDefService: ListDefService, protected dialogService: DialogService,
    protected formService: FormService, protected nudgesService: NudgesService,
    protected deepLinkingSerice: DeepLinkingService,
    protected messageService:MessageService
  ) {
    super();
    this.topMenuToggle = new BehaviorSubject<string>(null);
    this.etagVersionChange.subscribe(etag => {this.eTagVersion = etag;});
  }
  setAngularProducts(angularProducts: string[]) {
    this.angularProducts = angularProducts;
  }

  setAngularSubProducts(angularSubProducts: string[]) {
    this.angularSubProducts = angularSubProducts;
  }

  getAngularProducts(): string[] {
    return this.angularProducts;
  }

  getAngularSubProducts(): string[] {
    return this.angularSubProducts;
  }

  setViewAllScreens(viewAllScreens: string[]) {
    this.viewAllScreens = viewAllScreens;
  }

  getViewAllScreens(): string[] {
    return this.viewAllScreens;
  }

  isAngularProductUrl(productCode, subProductCode): boolean {
    if (!subProductCode || subProductCode === null || subProductCode === 'null' || subProductCode === '') {
      return this.angularProducts.indexOf(productCode) > -1;
    } else {
      return this.angularProducts.indexOf(productCode) > -1 && this.angularSubProducts.indexOf(subProductCode) > -1;
    }
  }

  setEnableUxAddOn(value: boolean) {
    this.isEnableUxAddOn = value;
  }

  getEnableUxAddOn() {
    return this.isEnableUxAddOn;
  }

  setSummaryDetails(data) {
    this.summaryDetails = data;
  }

  getSummaryDetails() {
    return this.summaryDetails;
  }

  setWidgetClicked(data) {
    this.widgetClicked = data;
  }

  getWidgetClicked() {
    return this.widgetClicked;
  }

  setFilterPreference(filterPreference) {
    this.filterPreference = filterPreference;
  }

  getFilterPreference() {
    return this.filterPreference;
  }

  setBaseCurrency(value: string) {
    sessionStorage.setItem('baseCurrency' , value);
  }

  getBaseCurrency() {
    return sessionStorage.getItem('baseCurrency');
  }

  // this function removes single error from the error list of control
  removeError(control: AbstractControl, error: string) {
    const err = control.errors;
    if (err) {
      // delete the particular error sent in param
      delete err[error];
      if (!Object.keys(err).length) {
        // if no errors left set control errors to null making it VALID
        control.setErrors(null);
      } else {
        // controls got other errors so set them back
        control.setErrors(err);
      }
    }
  }

  //  escape special characters from json string (to be used before JSON.parse)
  escapeSplCharactersBeforeParse(inputStr: string): string {
    return inputStr.replace(/\n/g, '\\n')
            .replace(/\r/g , '\\r')
            .replace(/\t/g , '\\t')
            .replace(/'/g , '\'')
            .replace(/"/g , '\\\"'); //eslint-disable-line no-useless-escape
  }

  // Service message commands
  announceMission(mission: string) {
    this.missionAnnouncedSource.next(mission);
  }

  isEditClicked(edit: string) {
    this.listenEditClick.next(edit);
  }

  addedResponse(res: any) {
    this.savedResponse.next(res);
  }

  showError(res: any) {
    this.errorResponse.next(res);
  }

  isInstInquiryClicked(rowData) {
    this.listenInstInquiryClicked.next(rowData);
  }

  isJourneyClicked(journey: string) {
    this.listenJourneyClick.next(journey);
  }

  isTransmissionModeChanged(data: string) {
    this.listenTransmissionMode.next(data);
  }

  isSetEntityClicked(rowData) {
    this.listenSetEntityClicked.next(rowData);
  }
  setEntitySuccedded() {
    this.listenSetEntitySuccess.next('yes');
  }
  isSetReferenceClicked(rowData) {
    this.listenSetReferenceClicked.next(rowData);
  }
  setReferenceSuccedded() {
    this.listenSetReferenceSuccess.next('yes');
  }
  isEyeIconClicked(value){
    if (value){
    this.eyeIconClicked.next('yes');
    } else {
      this.eyeIconClicked.next('no');
    }
  }

  putGlobalBankDate(value) {
    this.globalBankDate$ = value;
  }

  getGlobalBankDate() {
    return this.globalBankDate$;
  }

  public getShipmentExpiryDateForBackToBack(): any {
    return this.shipmentExpiryDateForBackToBack;
  }
  public setShipmentExpiryDateForBackToBack(value: any) {
    this.shipmentExpiryDateForBackToBack = value;
  }
  public getAmountForBackToBack(): any {
    return this.amountForBackToBack;
  }
  public setAmountForBackToBack(value: any) {
    this.amountForBackToBack = value;
  }
  public getClearBackToBackLCfields(): any {
    return this.clearBackToBackLCfields;
  }
  public setClearBackToBackLCfields(value: any) {
    this.clearBackToBackLCfields = value;
  }

  public getResetPasswordData(): ResetPasswordRequestData {
    return this.resetPasswordData;
  }
  public setResetPasswordData(value: ResetPasswordRequestData) {
    this.resetPasswordData = value;
  }

  putSessionFlag(key, value) {
    this.sessionFlagmap.set(key, value);
  }

  getSessionFlag(key) {
    return this.sessionFlagmap.get(key);
  }

  putEnrichmentDetails(value: any, key: number) {
    this.enrichmentTableMap.set(key, value);
  }

  getEnrichmentDetails(key: number) {
    return this.enrichmentTableMap.get(key);
  }

  setComponentRowData(data) {
    this.componentRowData = data;
  }

  getComponentRowData() {
    return this.componentRowData;
  }

  setShowPopup(val) {
    this.showPopup = val;
  }

  getShowPopup() {
    return this.showPopup;
  }

  setActionPopup(val) {
    this.actionPopup = val;
  }

  getActionPopup() {
    return this.actionPopup;
  }

  putLandingPageLinks(key, data) {
    this.landingPageLinksMap.set(key, data);
  }

  getLandingPageLinks(key) {
    return this.landingPageLinksMap.get(key);
  }

  putButtonItems(key, data) {
    this.buttonItemsMap.set(key, data);
  }

  getButtonItems(key) {
    return this.buttonItemsMap.get(key);
  }

  putMasterData(key, data) {
    this.masterDataMap.set(key, data);
  }

  getMasterData(key) {
    return this.masterDataMap.get(key);
  }

  clearMasterData() {
    this.masterDataMap.clear();
  }

  putLoginMode(key, data) {
    this.loginModeMap.set(key, data);
  }

  getLoginMode() {
    return this.loginModeMap;
  }

  clearLoginModeMap() {
    this.loginModeMap.clear();
  }

  putLoginData(key, data) {
    this.loginDataMap.set(key, data);
  }

  getLogindata() {
    return this.loginDataMap;
  }

  clearLoginDataMap() {
    this.loginDataMap.clear();
  }

  putTermsAndConditionData(key, data) {
    this.termsAndConditionData.set(key, data);
  }

  getTermsAndConditionData() {
    return this.termsAndConditionData;
  }

  putQueryParameters(key: any, data: any) {
    this.queryParameters.set(key, data);
  }

  getQueryParameters() {
    return this.queryParameters;
  }

  getQueryParametersFromKey(key: any): any {
    return this.queryParameters.get(key);
  }

  clearQueryParameters() {
    this.queryParameters.clear();
  }

  getCachedResponses() {
    return this.cachedResponses;
  }

  clearCachedResponses() {
    this.cachedResponses.clear();
    // eslint-disable-next-line no-console
    console.log('clearing the cached responses: ' + this.cachedResponses.size);
  }

  getLiMode() {
    return this.liMode;
  }

  setLiMode(liMode) {
    this.liMode = liMode;
  }


  getLiCopyFrom() {
    return this.liCopyFrom;
  }

  setLiCopyFrom(liCopyFrom) {
    this.liCopyFrom = liCopyFrom;
  }

  clearCachedData() {
    this.cachedResponses.clear();
    try {
      this.userPermissions.clear();
      this.userPermissionsByEntityMap.clear();
    } catch (error) {
      this.userPermissions = new Map([]);
      this.userPermissionsByEntityMap = new Map<string, Map<string, boolean>>();
    }
  }

  login(data, lang: string, preferredMode?: any): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    data.mode = data.mode ? data.mode : '';
    data.tandcflag = data.tandcflag ? data.tandcflag : '';
    data.newUserName = data.newUserName ? data.newUserName : '';
    data.newPasswordValue = data.newPasswordValue ? data.newPasswordValue : '';
    data.newPasswordConfirm = data.newPasswordConfirm ? data.newPasswordConfirm : '';
    data.phone = data.phone ? data.phone : '';
    data.email = data.email ? data.email : '';
    data.nextScreen = data.nextScreen ? data.nextScreen : '';
    preferredMode = preferredMode ? preferredMode : '';
    const requestPayload = {
      userData: {
        username: data.username,
        company: data.corporateid,
        userSelectedLanguage: lang
      },
      requestData: { password: data.password,
                     mode: data.mode,
                     tandcflag: data.tandcflag,
                     newUserName: data.newUserName,
                     newPasswordValue: data.newPasswordValue,
                     newPasswordConfirm: data.newPasswordConfirm,
                     phone: data.phone,
                     email: data.email,
                     nextScreen: data.nextScreen,
                     captcha: data.recaptcha,
                     preferredMode }
    };
    return this.http.post<any>(
      this.fccGlobalConstantService.fccLogin,
      requestPayload,
      { headers, withCredentials: true }
    );
  }

  public checkUniqueEmail(loginData, lang: string): Observable<any> {
    const requestPayload = {
       userId: loginData.username,
       corporateId: loginData.corporateid,
       email: loginData.email,
       language: lang
  };
    // API CALL to check unique emailID
    return this.http.post<any>(this.fccGlobalConstantService.uniqueEmailIdUrl, requestPayload);
  }

  public retrieveUserId(request): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const completePath = this.fccGlobalConstantService.getRetrieveUserId();
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload, { headers });
  }
  public retrievePassword(request): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const completePath = this.fccGlobalConstantService.getRetrievePassword();
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload, { headers });
  }
  async checkLoggedIn(): Promise<boolean> {
    await this.getUserDetailsAPI().toPromise().then(
      (res) => {
        if (res.status === FccGlobalConstant.LENGTH_200) {
          this.authenticated = true;
          this.loginUserId = res.body.userId;
          this.currentUserMail = this.decodeHtml(res.body.contactInformation.email);
        } else {
          this.authenticated = false;
        }
      },
      () => {
        this.authenticated = false;
      }
    );
    return this.authenticated;
  }

  public getProductList(): Observable<any> {
    const headers = this.getCacheEnabledHeaders();
    return this.http.get<any>(
      this.fccGlobalConstantService.getPRoductList,
      { headers }
    );
  }
requestToValidateDate(dateForValidate, rowData): any{
  const dateRequestParams: any = {};
  dateRequestParams.dateToValidate = dateForValidate;
  dateRequestParams.isRepricingDate = 'N';
  dateRequestParams.boFacilityId = rowData.bo_facility_id;
  dateRequestParams.currency = rowData.cur_code;
  dateRequestParams.pricingOptionName = rowData.pricing_option;
  dateRequestParams.dealId = rowData.bo_deal_id;
  dateRequestParams.operation = '';
  dateRequestParams.borrowerId = rowData.borrower_reference;
  return dateRequestParams;
}

  /**
   * @param prododctCode Product code.
   * @param parmId ParmId as PARM_ID of GTP_LARGE_PARAM_KEY.
   * Add the parmId in portal.properties for key large.param.parmid.whitelist
   */

public getParamData(prododctCode , parmId) {
  const headers = this.getCacheEnabledHeaders();
  const reqURl =
  `${this.fccGlobalConstantService.getParamDetails}?parmId=${parmId}&key_2=${prododctCode}`;
  return this.http.get<any>(reqURl, { headers } );

}

public getParamDataBasedOnLanguage(parmId: any) {
  const language = localStorage.getItem(FccGlobalConstant.LANGUAGE);
  const headers = this.getCacheEnabledHeaders();
  const reqURl = `${this.fccGlobalConstantService.getParamDetails}?parmId=${parmId}&key_4=${language}`;
  return this.http.get<any>(reqURl, { headers } );
}

public downloadTemplate(templateId: string): Observable<HttpResponse<Blob>> {
  const completePath = this.fccGlobalConstantService.getTemplateDownloadUrl(templateId) + '/content';
  return this.http.get(completePath, { responseType: 'blob', observe: 'response' });
}

public getAmountFormatAbbreviationList() {
  this.getParamDataBasedOnLanguage(FccConstants.PARAMETER_P702).subscribe(response => {
    if (response && response.largeParamDetails && response.largeParamDetails.length > 0) {
      let paramDataList: any;
      response.largeParamDetails.forEach(element => {
        paramDataList = element.largeParamDataList;
      });
      this.setAmountFormatAbbvNameList(paramDataList);
    }
  });
}

getShowCustomHeaderValue() {
  this.loadDefaultConfiguration().subscribe(response => {
    if (response) {
      this.showCustomHeader = response.showCustomHeader;
    }
  });
}

  counterOfPopulatedData(strResult) {
    this.enteredCharCountBtBTemp = 0;
    if (strResult && (strResult.indexOf('\n') > -1 || strResult.indexOf('\r') > -1)) {
      const strInputArray = strResult.split('\n');
      let k = 0;
      for (let i = 0; i < strInputArray.length - 1; i++) {
          const strInputText = strInputArray[i];
          let num = 0;
          if (!( strInputText.length % 65 === 0) || strInputText.length === 0){
            num = 1;
          }
          this.enteredCharCountBtBTemp +=
          ((Math.trunc(strInputText.length / FccGlobalConstant.LENGTH_65)) + (num)) * FccGlobalConstant.LENGTH_65;
          k++;
      }
      if (k === strInputArray.length - 1) {
        this.enteredCharCountBtBTemp += strInputArray[k].length;
      }
      return this.enteredCharCountBtBTemp;
    } else {
        this.enteredCharCountBtBTemp = strResult ? strResult.length : 0;
        return this.enteredCharCountBtBTemp;
    }
}

limitCharacterCountPerLine(key, form, length?) {
  const initialValue = form.get(key).value;
  let charLimit;
  let DATA_LENGTH = FccGlobalConstant.LENGTH_35;
  if (this.isnonEMptyString(length)){
    DATA_LENGTH = length;
  }
  const lineArray = initialValue.split('\n');
  for (let i = 0; i < lineArray.length; i++) {
    charLimit = DATA_LENGTH;

    if (lineArray[i].length <= charLimit) {
      continue;
    }
    const tempKey = lineArray[i].substr(charLimit, lineArray[i].length - charLimit);
    lineArray[i] = lineArray[i].substr(0, charLimit);
    if (this.isNonEmptyValue(lineArray[i + 1])) {
      lineArray[i + 1] = tempKey.concat(lineArray[i + 1]);
    }
    else {
      lineArray.length++;
      lineArray[i + 1] = tempKey;
    }
  }
  const keyValue = lineArray.join('\n');
  form.get(key).setValue(keyValue);
}
  /**
   *  Method to fetch Embed token from Server side
   */
  public getEmbedToken(productKey: string): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const requestPayload = { productKey };
    return this.http.post<any>(
      this.fccGlobalConstantService.getEmbedToken,
      requestPayload,
      { headers }
    );
  }

  getContextPath() {
    return window[FccGlobalConstant.CONTEXT_PATH];
  }
  public getloginImageFilePath() {
    return this.loginImageFilePath;
  }
  public setloginImageFilePath(value) {
    this.loginImageFilePath = value;
  }
  getImagePath() {
    return this.getContextPath() + '/content/FCCUI/assets/images/';
  }

  public getSessionIdleTimeout() {
    return this.sessionIdleTimeout;
  }

  public setSessionIdleTimeout(sessionIdleTimeout) {
    this.sessionIdleTimeout = sessionIdleTimeout;
  }

  public getUseMidRate() {
    return this.useMidRate;
  }

  public setUseMidRate(useMidRate) {
    this.useMidRate = useMidRate;
  }

  public getStarRatingSize() {
    return this.starRatingSize;
  }
  public setStarRatingSize(starRatingSize) {
    this.starRatingSize = starRatingSize;
  }

  public getfeedbackCharLength() {
    return this.feedbackCharLength;
  }
  public setfeedbackCharLength(feedbackCharLength) {
    this.feedbackCharLength = feedbackCharLength;
  }

  public getHomeUrl() {
    return this.homeUrl;
  }
  public setHomeUrl(homeUrl) {
    this.homeUrl = homeUrl;
  }

  public getOnDemandTimedLogout() {
    return this.onDemandTimedLogout;
  }
  public setOnDemandTimedLogout(onDemandTimedLogout) {
    this.onDemandTimedLogout = onDemandTimedLogout;
  }

  public setMenuObject(menuObject) {
    this.menuObject = menuObject;
  }
  public getMenuObject() {
    return this.menuObject;
  }
  public setMaxUploadSize(maxUploadSize) {
    return this.maxUploadSize = maxUploadSize;
  }
  public getMaxUploadSize() {
    return this.maxUploadSize;
  }
  public setTotalBeneFavCount(totalBeneFavCount: number) {
    return this.totalBeneFavCount = totalBeneFavCount;
  }
  public getTotalBeneFavCount() {
    return this.totalBeneFavCount;
  }
  public getTfBillAmount(): any {
    return this.tfBillAmount;
  }
  public setTfBillAmount(value: any) {
    this.tfBillAmount = value;
  }

  public getTfFinAmount(): any {
    return this.tfFinAmount;
  }
  public setTfFinAmount(value: any) {
    this.tfFinAmount = value;
  }

  public getTfFinCurrency(): any {
    return this.tfFinCurrency;
  }
  public setTfFinCurrency(value: any) {
    this.tfFinCurrency = value;
  }

  public getLcResponse(): any {
    return this.lcResponse;
  }
  public setLcResponse(value: any) {
    this.lcResponse = value;
  }

  getUserContextEnabledHeaders = () => new HttpHeaders({ 'user-context':  'true', 'Content-Type': 'application/json' })

  getBankContextEnabledHeaders = () => new HttpHeaders({ 'bank-context':  'true', 'Content-Type': 'application/json' })

  getCacheEnabledHeaders() {
    return new HttpHeaders({ 'cache-request':  'true', 'Content-Type': 'application/json' });
  }

  public loadDefaultConfiguration(): Observable<any> {
    const headers = this.getCacheEnabledHeaders();
    const completePath = this.fccGlobalConstantService.getConfgurations();
    return this.http.get<any>(completePath, { headers }).pipe(
      shareReplay()
    );
  }


  public userCurrencies(request) {
    const headers = this.getCacheEnabledHeaders();
    const completePath = this.fccGlobalConstantService.getCurrencies();
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload, { headers });
  }


public getExternalStaticDataList(filter, filterParams?: string) {
  if (this.isEmptyValue(filterParams)) {
    filterParams = FccGlobalConstant.EMPTY_STRING;
  }
  const headers = this.getCacheEnabledHeaders();
  const reqURl = `${this.fccGlobalConstantService.getExternalStaticDataUrl()}?option=${filter}&FilterValues=${filterParams}`;
  return this.http.get<any>(reqURl, { headers } );
}

public getPaymentBulkUploadDetailsOfRefNo(refNo) {
  const headers = this.getCacheEnabledHeaders();
  const reqURl = `${this.fccGlobalConstantService.getPaymentBulkUploadDetails()}?refNo=${refNo}`;
  return this.http.get<any>(reqURl, { headers } );
}

public getBeneBulkUploadDetailsOfRefNo(refNo) {
  const headers = this.getCacheEnabledHeaders();
  const reqURl = `${this.fccGlobalConstantService.getBeneBulkUploadDetails()}?refNo=${refNo}`;
  return this.http.get<any>(reqURl, { headers } );
}

  checkLandingPage(): Observable<any> {
    const headers = this.getCacheEnabledHeaders();
    const reqURl = `${this.fccGlobalConstantService.getLandingPage}?&userPreference=showlandingpage`;
    return this.http.get<any>(reqURl, { headers } );
  }

  public saveLandingpagepreference(
    showlandingpage: string
  ): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const requestPayload = {
      userPreference: 'showlandingpage',
      userPreferenceValue: showlandingpage
    };
    this.clearCachedResponses();
    return this.http.post<any>(
      this.fccGlobalConstantService.saveLandingpreference,
      requestPayload,
      { headers }
    );
  }
  checkHorizontalMenuPage(): Observable<any> {
    const headers = this.getCacheEnabledHeaders();
    const reqURl = `${this.fccGlobalConstantService.getLandingPage}`;
    return this.http.get<any>(reqURl, { headers } );
  }

  public saveHorizontalMenupreference(
    menuPrefernce: string
  ): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const requestPayload = {
      userPreference: 'showhorizontalmenu',
      userPreferenceValue: menuPrefernce
    };
    return this.http.post<any>(
      this.fccGlobalConstantService.saveLandingpreference,
      requestPayload,
      { headers }
    );
  }
  public getComponents() {
    return this.http.get<any>(
      this.fccGlobalConstantService.contextPath + '/../../assets/showcase/data/layout.json'
      );
  }

  getConfiguredValues(configuredKeys: string): Observable<any> {
    const headers = this.getCacheEnabledHeaders();
    const reqURl =
    `${this.fccGlobalConstantService.getConfigurationDetails}?configuredKey=${configuredKeys}`;
    return this.http.get<any>(reqURl, { headers } );
  }

  getAutosaveParameterConfiguredValues(paramKeys: any = {}): Observable<any> {
    let params = '';
    const keys = Object.keys(paramKeys);
    for (let index = 0; index < keys.length; index++) {
      if (paramKeys[keys[index]]) {
        params = `${params}&${keys[index]}=${paramKeys[keys[index]]}`;
      }
    }
    return this.http.get<any>(`${this.fccGlobalConstantService.getParamConfig}?${params.substring(1, params.length)}`,
      { headers : this.getUserContextEnabledHeaders() } );
  }

  isOnlyAutosaveEnabled = (data): boolean => data === FccGlobalConstant.AUTOSAVE_ALONE;

  getParameterConfiguredValues(configuredKeys: string, paramId: string, key2?: string, key3?: string): Observable<any> {
    const headers = this.getCacheEnabledHeaders();
    let baseUrl = `${this.fccGlobalConstantService.getParamConfig}?paramId=${paramId}`;
    if (configuredKeys !== null && configuredKeys !== undefined && configuredKeys !== '') {
      baseUrl = baseUrl + `&KEY_1=${configuredKeys}`;
    }
    if (key2 !== null && key2 !== undefined && key2 !== '') {
      baseUrl = baseUrl + `&KEY_2=${key2}`;
    }
    if (key3 !== null && key3 !== undefined && key3 !== '') {
      baseUrl = baseUrl + `&KEY_3=${key3}`;
    }
    const reqURL = baseUrl;
    return this.http.get<any>(reqURL, { headers } );
  }

  getBankContextParameterConfiguredValues(paramId: string): Observable<any> {
    const headers = this.getBankContextEnabledHeaders();
    const baseUrl = `${this.fccGlobalConstantService.getParamConfig}?paramId=${paramId}`;
    return this.http.get<any>(baseUrl, { headers } );
  }

  getCodeKey(codeId: any, type: any, prodCode: any, subProductCode: any){

    let key = null ;
    key = codeId + '_' + type + '_' + prodCode + '_' + subProductCode;
    return key;
  }

  getFormValues(limit: number, url: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[FccGlobalConstant.REQUEST_FORM] = FccGlobalConstant.REQUEST_INTERNAL;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = `${url}?limit=${limit}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }
  async getFormValuesWithOffset(offset, limit, url) {
    const headers = this.getCacheEnabledHeaders();
    const reqURl = `${url}?limit=${limit}&offset=${offset}`;
    return await this.http.get<any>(reqURl, { headers, observe: 'response' }).toPromise().then(res => res.body)
    .catch(res => res)
    .then(data => data);
  }

  public uploadAttachmentsForBeneAndPayments(file: File, title: string, uploadType?: any, attachmentGroup?: string): Observable<any> {
    const formData: FormData = new FormData();
    formData.append('file', file);
    formData.append('title', encodeURIComponent(title));
    formData.append('fileName', encodeURIComponent(file.name));
    formData.append('requestType', FccGlobalConstant.REQUEST_INTERNAL);
    if (this.isnonEMptyString(uploadType)) {
      formData.append('type', FccGlobalConstant.SWIFT);
      formData.append('attachmentGroup', FccGlobalConstant.OTHER);
    } else {
      formData.append('type', FccGlobalConstant.CUSTOMER);
      formData.append('attachmentGroup', attachmentGroup);
    }

    return this.http.post<any>(this.fccGlobalConstantService.getFileUploadUrl(), formData);
  }


  public saveFormData(request) {
    const iKey = this.fccGlobalConstantService.generateUIUD();
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[FccGlobalConstant.idempotencyKey] = iKey;
    const headers = new HttpHeaders(obj);
    const completePath = this.fccGlobalConstantService.saveLCAsDraft;
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload, { headers , observe: 'response' });
  }

  public saveLCTemplateData(request): Observable<any> {
    const iKey = this.fccGlobalConstantService.generateUIUD();
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[FccGlobalConstant.idempotencyKey] = iKey;
    const headers = new HttpHeaders(obj);
    const completePath = this.fccGlobalConstantService.saveLCTemplate;
    return this.http.post<any>(completePath, request, { headers , observe: 'response' });
  }

  public deleteLCTemplate(templateName: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    return this.http.delete<any>(this.fccGlobalConstantService.deleteLCTemplate + templateName, { headers , observe: 'response' });
  }

  public deleteTemplate(templateName: any, productCode: any, subProductCode?: any): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    let reqUrl: any;
    const url = `${this.fccGlobalConstantService.deleteTemplate + templateName}?productCode=${productCode}`;
    if (subProductCode) {
      reqUrl = `${url}&subProductCode=${subProductCode}`;
    } else {
      reqUrl = `${url}`;
    }
    return this.http.delete<any>(reqUrl, { headers , observe: 'response' });
  }

  public deleteLC(lcNumber: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    return this.http.delete<any>(this.fccGlobalConstantService.deleteLC + lcNumber, { headers , observe: 'response' });
  }

  public deleteTD(refId: any, tnxId: any): Observable<any> {
    const tempRefId = refId;
    const tempTnxId = tnxId;
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = `${this.fccGlobalConstantService.deleteTD}?refId=${tempRefId}&tnxId=${tempTnxId}`;
    return this.http.put<any>(reqURl, { headers , observe: 'response' });
  }

  public delete(groupId: any): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    return this.http.delete<any>(this.fccGlobalConstantService.delete + groupId, { headers , observe: 'response' });
  }

  public deleteAutosave(paramKeys: any = {}): Observable<any> {
    const reqURl = this.fccGlobalConstantService.getAutoSaveUrl();
    let params = '';
    const keys = Object.keys(paramKeys);
    for (let index = 0; index < keys.length; index++) {
      if (paramKeys[keys[index]]) {
        params = `${params}&${keys[index]}=${paramKeys[keys[index]]}`;
      }
    }
    return this.http.delete<any>(`${reqURl}?${params.substring(1, params.length)}`,
      { headers : this.getUserContextEnabledHeaders() } );
  }

  public genericDelete(prodCode: any, refId: any, tnxId: any, subProdCode: any): Observable<any> {
  const uri = this.fccGlobalConstantService.genericDelete;
  const tnxDetails = [{
    eventId: tnxId,
    productCode: prodCode,
    id: refId,
    subProductCode: subProdCode
}];
  const options = {
    headers: new HttpHeaders({
      'Content-Type': FccGlobalConstant.APP_JSON
    }),
    body: {
      transactions: tnxDetails
    },
  };
  return this.http.request<string>(FccGlobalConstant.HTTP_DELETE, uri, options);
    }
    getCodeDataDetails(codeData: CodeData): Observable<any> {
    const codeId = codeData.codeId;
    const productCode = codeData.productCode;
    const subProductCode = codeData.subProductCode;
    const language = codeData.language;
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    // junk character is appened in URL
    // eslint-disable-next-line max-len
    const reqURl = `${this.fccGlobalConstantService.getCodeData}?CodeId=${codeId}&ProductCode=${productCode}&SubProductCode=${subProductCode}&Language=${language}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  getPackagesValues(isPackageRequired: boolean): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = `${this.fccGlobalConstantService.packages}?isPackageRequired=${isPackageRequired}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  public getPhraseProductDetails(): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = this.fccGlobalConstantService.getProductsForPhrases();
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  public getDynamicPhraseAddFieldData(productCode: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = `${this.fccGlobalConstantService.addFieldsForDynamicPhrases}?productCode=${productCode}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  public savePhrases(data: any): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const body = {
      entityShortName: data.get('entityShortName'),
      name: data.get('name'),
      type: data.get('type'),
      product: data.get('product'),
      category: data.get('category'),
      description: data.get('description'),
      content: data.get('content')
    };
    return this.http.post<any>(this.fccGlobalConstantService.getPhraseSaveUrl(), body, { headers, observe: 'response' });
  }

  public checkPhraseAbbvName(abbvName: string): Observable<any>{
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const reqURl = `${this.fccGlobalConstantService.validatePhraseAbbvName}?abbvName=${abbvName}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  public saveOrSubmitBank(request: any): Observable<any> {
    const requestPayload = request;
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const completePath = this.fccGlobalConstantService.getBankSaveUrl();
    return this.http.post<any>(completePath, requestPayload, { headers, observe: 'response' });
  }

   public updateSavedFormData(transactionID: string, etag, request): Observable<any> {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        obj[FccGlobalConstant.ifMatch] = etag;
        const headers = new HttpHeaders(obj);
        const completePath = this.fccGlobalConstantService.putSavedLCUrl(transactionID);
        const requestPayload = request;
        return this.http.put<any>(completePath, requestPayload, { headers , observe: 'response' });
    }

  public uploadAttachments(file: File, title: string, lcNumber: any, eventId: any, uploadType?: any): Observable<any> {
    const formData: FormData = new FormData();
    formData.append('file', file);
    formData.append('title', encodeURIComponent(title));
    // encoding has been removed as the name in the "file" object is being encoded
    formData.append('fileName', file.name);
    formData.append('id', lcNumber);
    formData.append('eventId', eventId);
    if (this.isnonEMptyString(uploadType)) {
      formData.append('type', FccGlobalConstant.SWIFT);
      formData.append('attachmentGroup', FccGlobalConstant.OTHER);
    } else {
      formData.append('type', FccGlobalConstant.CUSTOMER);
    }

    return this.http.post<any>(this.fccGlobalConstantService.getFileUploadUrl(), formData);
  }

  public deleteAttachments(attachmentId: string): Observable<any> {
    return this.http.delete<any>(this.fccGlobalConstantService.getFileDeleteUrl(attachmentId));
  }

  public downloadAttachments(attachmentId: string): Observable<HttpResponse<Blob>> {
    const completePath = this.fccGlobalConstantService.getFileDownloadUrl(attachmentId) + '/content';
    return this.http.get(completePath, { responseType: 'blob', observe: 'response' });
  }

  public downloadNewsAttachments(attachmentId: string, attachmentType: string): Observable<HttpResponse<Blob>> {
    const completePath = this.fccGlobalConstantService.getNewsAttachmentDownloadUrl(attachmentId, attachmentType);
    return this.http.get(completePath, { responseType: 'blob', observe: 'response' });
  }

  setCurrentRouteTitle(title: any) {
    if (title) {
      this.currentRouteTitle.next(title);
    }
  }

  getCurrentRouteTitle() {
    this.currentRouteTitle.subscribe(
      (currentValue: any) => {
        this.titleKey = currentValue;
      }
    );
  }

  setSwitchOnLanguage(lang) {
    this.languageOf = lang.code;
    this.translate.use(lang.code);
    localStorage.setItem('language' , this.languageOf);
    if (this.languageOf === 'ar') {
    this.dir = 'rtl';
    } else {
    this.dir = 'ltr';
    }
    localStorage.setItem('langDir' , this.dir);
    this.getTranslatedMainTitle();
    if (this.titleKey) {
    this.getCurrentRouteTitle();
    this.setTranslatedTitle();
    }
  }

  getTranslatedMainTitle() {
    const mainTitleKey = 'MAIN_TITLE';
    this.translate.get(mainTitleKey).subscribe((translated: string) => {
      this.mainTitleKey = translated;
    });
  }

  setTranslatedTitle() {
    const dontShowRouter = 'dontShowRouter';
    if (!(window[dontShowRouter] && window[dontShowRouter] === true )) {
      this.translate.get(this.titleKey).subscribe((translated: string) => {
        const translatedTitleKey = translated;
        const completeTitle = this.mainTitleKey + '-' + translatedTitleKey;
        this.titleService.setTitle(completeTitle);
      });
    }
  }

  setSwitchOnLanguageForHeader(lang) {
    this.languageOf = lang.code;
    this.translate.use(lang.code);
    localStorage.setItem('language' , this.languageOf);
  }

  getLocale(lang) {
    if (lang && lang !== null) {
      if (`en` === lang) {
        return 'en-gb';
      } else if ('us' === lang) {
        return 'en-us';
      } else if ('zh' === lang) {
        return 'zh-cn';
      } else {
        return lang.concat('-').concat(lang);
      }
    } else {
      return 'en-gb';
    }
  }
  getSwitchOnLAnguage() {
    const a = localStorage.getItem('language');
    this.translate.use(a);
  }
  checKlanguage(lang: string) {
    let language = '';
    if (lang === 'en') {
      language = FccGlobalConstant.N061_EN;
    } else if (lang === 'fr') {
      language = FccGlobalConstant.N061_FR;
    } else if (lang === 'us') {
      language = FccGlobalConstant.N061_US;
    } else if (lang === 'ar') {
      language = FccGlobalConstant.N061_AR;
    } else if (lang === 'de') {
      language = FccGlobalConstant.N061_DE;
    } else if (lang === 'es') {
      language = FccGlobalConstant.N061_ES;
    } else if (lang === 'th') {
      language = FccGlobalConstant.N061_TH;
    } else if (lang === 'zh') {
      language = FccGlobalConstant.N061_ZH;
    } else if (lang === 'br') {
      language = FccGlobalConstant.N061_BR;
    } else {
      language = FccGlobalConstant.N061_EN;
    }
    return language;
  }

  public checkUniqueUserID(userID: string): Observable<any> {
    // API CALL to check unique userID
    return this.http.get<any>(this.fccGlobalConstantService.getUniqueUserIdUrl(userID));
  }
  putDojoAngularSwitch(key, value) {
    this.dojoIdentifiermap.set(key, value);
  }
  getDojoAngularSwitch(key) {
    return this.dojoIdentifiermap.get(key);
  }

  public getDuplicateBeneDetails(beneName?: string, beneAccNo?: string): Observable<any> {
    const url = this.fccGlobalConstantService.getDuplicateBeneDetails;
    const headers = this.getCacheEnabledHeaders();
    const reqURl = `${url}?beneName=${beneName}&beneAccountNumber=${beneAccNo}`;
    return this.http.get<any>( reqURl, { headers } );
  }

  public getUserDetailsAPI(): Observable<any> {
    // API CALL to get the userdetails
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[this.requestForm] = FccGlobalConstant.REQUEST_INTERNAL;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    return this.http.get<any>(this.fccGlobalConstantService.getUserDetails, { headers, observe: 'response' });
  }

  /**
   * Checks if the user has chatbot permission
   */
  public hasChatBotAccess() {
    const headers = this.getCacheEnabledHeaders();
    return this.http
      .get<any>(
        this.fccGlobalConstantService.hasChatbotAccess, { headers })
      .toPromise()
      .then(res => res.chatBotSessionDetailsList as any[])
      .catch(res => res)
      .then(data => data);
  }

  public getCorporateDetailsAPI(additionalheader: any): Observable<any> {
    // API CALL to get the Corporate Details
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[this.cacheRequest] = 'true';
    if (additionalheader) {
    obj[this.requestForm] = additionalheader;
    }
    const headers = new HttpHeaders(obj);
    return this.http.get<any>(this.fccGlobalConstantService.corporateDetails, { headers, observe: 'response' });
  }

  // Below method is used to decode HTML entities
  decodeHtml(input) {
    const contentType = 'text/html';
    const doc = new DOMParser().parseFromString(input, contentType);
    return (doc && doc.documentElement) ? doc.documentElement.innerText : '';
  }

  userAuthorizationDetails(): Observable<any> {
    const headers = new HttpHeaders({ ContentType: FccGlobalConstant.APP_JSON });
    return this.http.get<any>(this.fccGlobalConstantService.userAuthorizationDetails, { headers });
  }

  public getLandingPage() {
    return this.landingPage;
  }
  public setLandingPage(landingPage) {
    this.landingPage = landingPage;
  }

  getCustomContent(reqURl: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const completeUrl = `${this.fccGlobalConstantService.baseUrl + reqURl}`;
    return this.http.get<any>(completeUrl, { headers , observe: 'response' });
  }

  getWidgetContent(widgetName: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[this.cacheRequest] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = `${this.fccGlobalConstantService.getWidgetContent}?widgetName=${widgetName}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }
  public getLandingPageDataAPI(): Observable<any> {
    // API CALL to get the landing pageparameter data
    const headers = this.getCacheEnabledHeaders();
    return this.http.get<any>(this.fccGlobalConstantService.getLandingPageData, { headers, observe: 'response' });
  }

  // fetch model from api
  public getProductModel(params: ProductParams): Observable<any> {
    // commenting out this as a temporary fix, this api call has to be refactored
    const headers = this.getCacheEnabledHeaders();
    const opts = this.buildQueryParams(params);
    return this.http.get<any>(this.fccGlobalConstantService.getProductModelURL(params.type),
    { headers, params: opts, observe: 'body' });
  }

  buildQueryParams(productParams: ProductParams): HttpParams {
    const params = new HttpParams({
      fromObject: {
        productCode: productParams.productCode,
        subProductCode: productParams.subProductCode,
        tnxTypeCode: productParams.tnxTypeCode,
        subTnxTypeCode: productParams.subTnxTypeCode,
        option: productParams.option,
        operation: productParams.operation,
        mode: productParams.mode,
        category: productParams.category
      }
    });
    return params;
  }

  getListOFDashboard(productType) {
    const headers = this.getCacheEnabledHeaders();
    const completePath = `${this.fccGlobalConstantService.getDashboardList}?dashboardCategory=${productType}`;
    return this.http.get<any>(completePath, { headers });
  }

  saveDashboardPreference(data): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const body = {
      dashboardCategory: data.dashboardCategory,
      dashboardName: data.dashboardName,
      userDashboardId: data.userDashboardId,
      dashboardId: data.dashboardId
    };
    this.clearCachedData();
    return this.http.post<any>(this.fccGlobalConstantService.saveDashboardPreferences, body, { headers, observe: 'response' });
  }

  async createPersonalizedDashboad(body) {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    this.clearCachedData();
    return await this.http.post<any>(this.fccGlobalConstantService.createUserDashboard, body, { headers, observe: 'response' })
    .toPromise()
      .then(res => res.body as any[])
      .catch(res => res)
      .then(data => data);
  }

  async updatePersonalizedDashboad(body) {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    this.clearCachedData();
    return await this.http.put<any>(this.fccGlobalConstantService.updateUserDashboard, body, { headers, observe: 'response' })
    .toPromise()
      .then(res => res.body as any[])
      .catch(res => res)
      .then(data => data);
  }

  preventBackButton() {
    history.pushState(null, null, location.href);
    this.locationStrategy.onPopState(() => {
    history.pushState(null, null, location.href);
    });
  }
  getMenuValue(): Observable<string> {
    return this.topMenuToggle.asObservable();
  }
    setMenuValue(newValue): void {
    this.topMenuToggle.next(newValue);
  }

  getOtpAuthScreenSource() {
    return this.otpAuthScreenSource;
  }

  /**
   * API call to get the journey details
   */
  public getJourneyDetails(refId: string, eventId: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
  //  return this.http.get<any>(this.fccGlobalConstantService.getJourneyDetails(refId), { headers, observe: 'response' });

    let reqUrl: string;
    const url = this.fccGlobalConstantService.detailJourney;
    if (this.isnonEMptyString(eventId)) {
      reqUrl = `${url}?refId=${refId}&eventId=${eventId}`;
    } else {
      reqUrl = `${url}?refId=${refId}`;
    }
    return this.http.get<any>(reqUrl, { headers, observe: 'response' });
  }

  fetchEtagVersion(transactionID: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const reqURl = this.fccGlobalConstantService.getLCTransactionDataDetailsUrl(transactionID);
    return this.http.get<any>(reqURl, { headers, observe: 'response' });
}

      getTransactionDetails(reqURl) {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        return this.http.get<any>(reqURl, { headers, observe: 'response' });
      }

      getFileDetails(refId: string) {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        const reqUrl = `${this.fccGlobalConstantService.getFileDetails}?id=${refId}`;
        return this.http.get<any>(reqUrl, { headers, observe: 'response' });
      }

      async getCoverBillDetails(refId: string, tnxId: string) {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        obj[FccGlobalConstant.REQUEST_FORM] = FccGlobalConstant.REQUEST_INTERNAL;
        const headers = new HttpHeaders(obj);
        const reqUrl = `${this.fccGlobalConstantService.getFileDetails}?id=${refId}&eventId=${tnxId}`;
        return await this.http.get<any>(reqUrl, { headers, observe: 'response' }).toPromise().then(res => res.body)
        .catch(res => res)
        .then(data => data);
      }

      getMasterDetails(reqURl) {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        return this.http.get<any>(reqURl, { headers, observe: 'response' });
      }

      generateTemplateName(productCode): Observable<any> {
        const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
        const body = {
          productCode
        };
        return this.http.post<any>(this.fccGlobalConstantService.generateTemplateName, body, { headers, observe: 'response' });
      }

      // API CALL to load countires
      loadCountries(): Observable<any> {
        const headers = this.getCacheEnabledHeaders();
        const baseUrl = this.fccGlobalConstantService.countries;
        const offset = FccGlobalConstant.LENGTH_0;
        const limit = this.fccGlobalConstantService.getStaticDataLimit();
        return this.http.get<any>(baseUrl + `?limit=${limit}&offset=${offset}`, { headers, observe: 'response' });
      }

      public getCountries() {
        return new Observable(subscriber => {
          this.loadCountries().subscribe(data => {
            subscriber.next(data.body);
          });
        });
      }
      // API CALL to load the user permissions
      loadUserPermissions(): Observable<any> {
        const headers = this.getCacheEnabledHeaders().set('REQUEST-FROM', 'INTERNAL');
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const baseUrl = this.fccGlobalConstantService.contextPath + this.fccGlobalConstantService.restServletName;
        const offset = FccGlobalConstant.LENGTH_0;
        const limit = this.fccGlobalConstantService.getStaticDataLimit();
        const completePath = baseUrl + `/access-permissions?limit=${limit}&offset=${offset}`;
        return this.http.get<any>(completePath, { headers, observe: 'response' });
      }

      // Checks if the permission is there or not in the user permissions list
      public getUserPermissionFlag(key: string) {
        for (const element in this.userPermissions) {
          if (this.userPermissions[element].actionAllowed === key) {
            return true;
          }
        }
        return false;
      }

      // Loads the user permissions if not available and returns the input permission availability
      public getUserPermission(key: string) {
        return new Observable(subscriber => {
          if (Object.keys(this.userPermissions).length > 0) {
            subscriber.next(this.getUserPermissionFlag(key));
          } else {
            this.loadUserPermissions().subscribe(data => {
              this.userPermissions = data.body.items;
              this.setPermissionAsEntityMap(data.body.items);
              subscriber.next(this.getUserPermissionFlag(key));
            });
          }
        });
      }

      // loads the user permissions if not available and updates input the permission map with user permissions
      getButtonPermission(buttonPermission): Observable<any> {
        return new Observable(subscriber => {
          if (Object.keys(this.userPermissions).length > 0) {
            subscriber.next(this.getButtonPermissionFlag(buttonPermission));
          } else {
            this.loadUserPermissions().subscribe(data => {
              this.userPermissions = data.body.items;
              this.setPermissionAsEntityMap(data.body.items);
              subscriber.next(this.getButtonPermissionFlag(buttonPermission));
            });
          }
        });
      }

      setPermissionAsEntityMap(permissionObject: any) {
        for (const permissionObj of permissionObject) {
          if (this.userPermissionsByEntityMap.has(permissionObj[`${FccGlobalConstant.SHORT_NAME}`])){
            const map = this.userPermissionsByEntityMap.get(permissionObj[`${FccGlobalConstant.SHORT_NAME}`]);
            map.set(permissionObj[`${FccGlobalConstant.ACTION_ALLOWED}`], true);
            this.userPermissionsByEntityMap.set(permissionObj[`${FccGlobalConstant.SHORT_NAME}`], map);
          } else{
            const map = new Map<string, boolean>();
            map.set(permissionObj[`${FccGlobalConstant.ACTION_ALLOWED}`], true);
            this.userPermissionsByEntityMap.set(permissionObj[`${FccGlobalConstant.SHORT_NAME}`], map);
          }
        }
      }

      checkUserPermissionByEntity(entity: string, permission: string): boolean {
        if (this.userPermissionsByEntityMap.has(entity)) {
          const valueMap = this.userPermissionsByEntityMap.get(entity);
          if (valueMap.has(permission)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }

      // updates input the permission map with user permissions
      getButtonPermissionFlag(buttonPermission): any {
        for (const [key] of buttonPermission) {
          if ( this.getUserPermissionFlag(key)) {
            buttonPermission.set(key, true);
          }
        }
        return buttonPermission;
      }

      savePaymentBeneficiaryDetails(requestPayload: any) {
        const obj = {};
        let iKey = sessionStorage.getItem(FccGlobalConstant.idempotencyKey);
        if (this.isEmptyValue(iKey)) {
          iKey = this.fccGlobalConstantService.generateUIUD();
          sessionStorage.setItem(FccGlobalConstant.idempotencyKey, iKey);
        }
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        obj[FccGlobalConstant.idempotencyKey] = iKey;
        const headers = new HttpHeaders(obj);
        const completePath = this.fccGlobalConstantService.paymentBeneficiaryDetails;
        return this.http.post<any>(completePath, requestPayload, { headers, observe: 'response' });
      }

      updatePaymentBeneficiaryDetails(requestPayload: any, groupId?: any) {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        const completePath = this.fccGlobalConstantService.updatePaymentBeneficiaryDetails + groupId;
        return this.http.put<any>(completePath, requestPayload, { headers });
      }

      public getPaymentBeneficiaryDetails(beneGroupId: string, event: string): Observable<any> {
        const url = this.fccGlobalConstantService.paymentBeneficiaryDetails;
        const headers = this.getCacheEnabledHeaders();
        const reqURl = `${url}/${beneGroupId}?event=${event}`;
        return this.http.get<any>( reqURl, { headers } );
      }

      fcmBeneficiaryCreation(requestPayload: any) {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        obj['X-Request-ID'] = this.fccGlobalConstantService.generateUIUD();
        const headers = new HttpHeaders(obj);
        if (requestPayload.requestType === FccGlobalConstant.ADD_FEATURES) {
          const completePath = this.fccGlobalConstantService.fcmBeneficiaryCreation;
          return this.http.post<any>(completePath, requestPayload.request, { headers, observe: 'response' });
        } else if (requestPayload.requestType === FccGlobalConstant.UPDATE_FEATURES) {
          const completePath = this.fccGlobalConstantService.fcmBeneficiaryUpdation;
          return this.http.put<any>(completePath, requestPayload.request, { headers, observe: 'response' });
        }
      }

      persistFormDetails(request: any) {
        let iKey = sessionStorage.getItem(FccGlobalConstant.idempotencyKey);
        this.mode = this.getQueryParametersFromKey(FccGlobalConstant.MODE);
        const tnxid = request.common ? request.common.tnxid : '';
        if (!this.isnonEMptyString(tnxid)) {
          if (iKey === null) {
            iKey = this.fccGlobalConstantService.generateUIUD();
            sessionStorage.setItem(FccGlobalConstant.idempotencyKey, iKey);
          }
        } else {
            iKey = null;
        }
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        if (!this.isnonEMptyString(tnxid)) {
          obj[FccGlobalConstant.idempotencyKey] = iKey;
        }
        if (this.eTagVersion) {
          obj['If-Match'] = this.eTagVersion;
        }
        const headers = new HttpHeaders(obj);
        const completePath = this.fccGlobalConstantService.baseUrl + 'genericsave';
        return this .http.post<any>(completePath, request, { headers, observe: 'response' });
      }

      public loadPdfConfiguration(): Observable<any> {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        obj[this.cacheRequest] = 'true';
        const headers = new HttpHeaders(obj);
        const completePath = this.fccGlobalConstantService.getPdfConfigurations;
        return this.http.get<any>(completePath, { headers });
      }

      public getAmendmentNo(requestPayload: any): Observable<any> {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        const completePath = this.fccGlobalConstantService.getAmendmentNo;
        return this.http.post<any>(completePath, requestPayload, { headers });
      }

      public getBankDetails(): Observable<any> {
        const completePath = this.fccGlobalConstantService.bankDetailsForPdf;
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        obj[FccGlobalConstant.REQUEST_FORM] = FccGlobalConstant.REQUEST_INTERNAL;
        obj[this.cacheRequest] = 'true';
        const headers = new HttpHeaders(obj);
        return this.http.get<any>(completePath, { headers });
      }

      public getBankDateAndTime(): Observable<any> {
        const completePath = this.fccGlobalConstantService.bankDateAndTime;
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        obj[FccGlobalConstant.REQUEST_FORM] = FccGlobalConstant.REQUEST_INTERNAL;
        obj[this.cacheRequest] = 'true';
        const headers = new HttpHeaders(obj);
        return this.http.get<any>(completePath, { headers });
      }

      getPermissionName(productCode: string, suffix: string, subProductCode?: string): string {
        let permission;
        if (subProductCode && subProductCode !== '' && subProductCode !== null && subProductCode !== 'undefined') {
          permission = productCode.toLowerCase().concat('_').concat(subProductCode).toLowerCase().concat('_').concat(suffix);
        } else {
          permission = productCode.toLowerCase().concat('_').concat(suffix);
        }
        return permission;
      }

      formatForm(form: FCCFormGroup) {
        Object.keys(form.controls).forEach(fieldName => {
          const fieldControl = form.get(fieldName);
          if ((fieldControl.value !== undefined && fieldControl.value === FccGlobalConstant.BLANK_SPACE_STRING) ||
              (fieldControl[FccGlobalConstant.TYPE] === FccGlobalConstant.VIEW_MODE_TYPE && fieldControl.value === null)) {
            fieldControl[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
            form.get(fieldName).updateValueAndValidity();
          } else if (fieldControl[FccGlobalConstant.TYPE] === FccGlobalConstant.VIEW_MODE_TYPE && fieldControl.value !== undefined &&
            fieldControl.value !== FccGlobalConstant.BLANK_SPACE_STRING && fieldControl.value !== null &&
            fieldControl[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] !== false
            ){
            fieldControl[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
            form.get(fieldName).updateValueAndValidity();
          }
        });
      }

      /**
       *  @param fieldname of the form
       */
      isNonEmptyField(fieldName: any, form: FCCFormGroup) {
        return (form.get(fieldName) !== undefined && form.get(fieldName) !== null);
      }

       /**
        * @param fieldname of the form
        */
      isNonEmptyValue(fieldValue: any) {
        return (fieldValue !== undefined && fieldValue !== null);
      }

      isEmptyValue(fieldValue: any) {
        return (fieldValue === undefined || fieldValue === null || fieldValue === FccGlobalConstant.EMPTY_STRING);
      }

      isnonEMptyString(fieldValue: any) {
      return (fieldValue !== undefined && fieldValue !== null && fieldValue !== '' );
      }

      isnonBlankString(fieldValue: any) {
        return (fieldValue !== undefined && fieldValue !== null && fieldValue.trim() !== '' );
      }

      /**
       *  Formats grouped values in listgin screen rows based on if type is export or otherwise
       *  Example 3 entites linked to an account can be formatted as entityABC(+2)
       */
      formatGroupedColumns(type: string, groupedValues: string): string {
        let formattedColumnVal = FccGlobalConstant.EMPTY_STRING;
        if (type !== 'export') {
          if (groupedValues.indexOf(',') > 0) {
            const splittedArray = groupedValues.split(',');
            formattedColumnVal += formattedColumnVal + splittedArray[0] + '(+' + (splittedArray.length - 1) +
            ')';
          }
          else {
            formattedColumnVal = groupedValues;
          }
        } else {
          formattedColumnVal = groupedValues;
        }
        return formattedColumnVal;
      }

      public isIBANValid(country?: string, currency?: string, accountNo?: string): Observable<any> {
        const url = this.fccGlobalConstantService.isIBANValid;
        const headers = this.getCacheEnabledHeaders();
        const reqURl = `${url}?country=${country}&currency=${currency}&accountNo=${accountNo}`;
        return this.http.get<any>( reqURl, { headers } );
        }

      /**
       *  @param fieldname of the form
       */
      clearValidatorsAndUpdateValidity(fieldName: any, form: FCCFormGroup) {
        form.get(fieldName).clearValidators();
        form.get(fieldName).updateValueAndValidity();

      }

      // Pass the fields name as parameter. This method sets the fields value to null
      setFieldValuesToNull(fieldName: any[], form: FCCFormGroup) {
        let index: any;
        for (index = 0; index < fieldName.length; index++) {
          form.controls[fieldName[index]].setValue('');
        }
      }

      checkSettlementCurAndBaseCur( form: any) {
        this.getCorporateDetailsAPI(FccGlobalConstant.REQUEST_INTERNAL).subscribe(response => {
          if (response.status === FccGlobalConstant.HTTP_RESPONSE_SUCCESS) {
            this.corporateDetails = response.body;
            this.companyBaseCurrency = this.corporateDetails.baseCurrency;
            this.settlementCurCode = form.get('currency').value;
            if (form.get('forwardContract') && (this.settlementCurCode === this.companyBaseCurrency)) {
              form.get('forwardContract')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
              form.updateValueAndValidity();
            }
          }
        });
      }

      convertToDateFormat(dateEntered: string): Date {
        let dateObject = new Date();
        if (dateEntered !== '' && dateEntered != null) {
          const dateParts = dateEntered.split('/');
          const userLanguage = window[FccGlobalConstant.USER_LANGUAGE];
          if (userLanguage === FccGlobalConstant.LANGUAGE_US) {
            dateObject = new Date(+dateParts[FccGlobalConstant.NUMERIC_TWO], +dateParts[0] - 1, +dateParts[1]);
          } else {
            dateObject = new Date(+dateParts[FccGlobalConstant.NUMERIC_TWO], +dateParts[1] - 1, +dateParts[0]);
          }
        }
        return dateObject;
      }

      public deleteEL(elTnxId: string): Observable<any> {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        return this.http.delete<any>(this.fccGlobalConstantService.deleteEL + elTnxId, { headers , observe: 'response' });
      }

      markAccountAsFav(accountId: string): Observable<any> {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        return this.http.post<any>(this.fccGlobalConstantService.addFavAccount + accountId, { headers , observe: 'response' });
      }

      markAccountAsUnFav(accountId: string): Observable<any> {
        const obj = {};
        obj[this.contentType] = FccGlobalConstant.APP_JSON;
        const headers = new HttpHeaders(obj);
        return this.http.delete<any>(this.fccGlobalConstantService.delFavAccount + accountId, { headers , observe: 'response' });
      }


      public audit(request): Observable<any> {
        const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
        const completePath = this.fccGlobalConstantService.getAudit();
        const requestPayload = request;
        return this.http.post<any>(completePath, requestPayload, { headers });
      }

      replacePhraseText(text: string) {
        const tempArray = text.split('');
        for (let i = 0; i < tempArray.length; i++) {
          if (tempArray[i] === 'n' && tempArray[i - 1] === '\\') {
            tempArray[i] = '&#13;';
            tempArray[i - 1] = '';
          } else if (tempArray[i] === '\\' && tempArray[i - 1] === '\\') {
            tempArray[i] = '\\';
            tempArray[i - 1] = '';
          } else if (tempArray[i] === '\'' && tempArray[i - 1] === '\\') {
            tempArray[i] = '\'';
            tempArray[i - 1] = '';
        }
      }
        const temp = tempArray.join('').toString();
        return temp;
    }

      getUnifiedWidget() {
        const headers = this.getCacheEnabledHeaders();
        const reqPath = this.fccGlobalConstantService.getUnifiedWidget;
        return this.http.get<any>(reqPath, { headers });
     }

    convertNumberToTimePattern(time :any) {
      const mystring = time.replace(/(..?)/g, '$1:').slice(0,-1);
      let hour = (mystring.split(':'))[0];
      let min = (mystring.split(':'))[1];
      const part = hour >= 12 ? 'PM' : 'AM';
      if (parseInt(hour) == 0){
      hour = 12;
      }
      min = (min+'').length == 1 ? `0${min}` : min;
      hour = hour > 12 ? hour - 12 : hour;
      hour = (hour+'').length == 1 ? `0${hour}` : hour;
      return hour + '.' + min + part;
    }

    convertNumberToTime(time: any){
      const mystring = time.replace(/(..?)/g, '$1:').slice(0,-1);
      const hour = (mystring.split(':'))[0];
      const min = (mystring.split(':'))[1];
      return hour + ':' + min;
    }

    calculateMaxDate(days: any){
      const currentTimeAsMs = Date.now();
      const adjustedTimeAsMs = currentTimeAsMs + (1000 * 60 * 60 * 24 * days);
      const adjustedDateObj = new Date(adjustedTimeAsMs);
      const year = adjustedDateObj.getFullYear();
      const month = adjustedDateObj.getMonth();
      const date = adjustedDateObj.getDate();
      return new Date(year , month, date);
    }

    fetchDynamicPhrases(request: any) {
      const obj = {};
      obj[this.contentType] = FccGlobalConstant.APP_JSON;
      const headers = new HttpHeaders(obj);
      const completePath = this.fccGlobalConstantService.dynamicPhrases;
      return this .http.post<any>(completePath, request, { headers, observe: 'response' });
    }

    replaceCurrency(amount: any) {
      const lang = localStorage.getItem('language');
      if (amount !== null && amount !== undefined && lang === 'fr') {
            let updateAmount = amount.replace(/,/g, '.');
            updateAmount = updateAmount.replace(/ /g, '');
            if ((updateAmount.match(/[^a-zA-Z0-9. ]/g)) !== null) {
              updateAmount = updateAmount.replace(/[^a-zA-Z0-9. ]/g, '');
            }
            return updateAmount;
      } else if (amount !== null && amount !== undefined && lang === FccGlobalConstant.LANGUAGE_AR) {
          const updateAmount = amount.replace(/٫/g, '.');
          amount = updateAmount.replace(/٬/g, ',');
          return amount.replace(/,/g, '');
      } else if (amount !== null && amount !== undefined) {
          return amount.replace(/[^0-9.]/g, '');
      }
      return '';
    }

    getChatConfigurationDetails() {
      const headers = this.getCacheEnabledHeaders();
      const reqPath = this.fccGlobalConstantService.chatConfigUrl;
      return this.http.get<any>(reqPath, { headers });
    }

    getSpeechText(base64: any): Observable<any> {
      const reqURl = this.fccGlobalConstantService.speechtoTextUrl;
      return this.http.post<any>(reqURl, base64);
    }

    countInputChars(strResult, length?) {
      this.enteredCharCountBtBTemp = 0;
      let DATA_LENGTH = FccGlobalConstant.LENGTH_35;
      if (this.isnonEMptyString(length)){
        DATA_LENGTH = length;
      }
      if (strResult && (strResult.indexOf('\n') > -1 || strResult.indexOf('\r') > -1)) {
        const strInputArray = strResult.split('\n');
        let k = 0;
        for (let i = 0; i < strInputArray.length - 1; i++) {
            const strInputText = strInputArray[i];
            this.enteredCharCountBtBTemp +=
            ((Math.trunc(strInputText.length / (DATA_LENGTH + 1))) + FccGlobalConstant.LENGTH_1) * DATA_LENGTH;
            k++;
        }
        if (k === strInputArray.length - 1) {
          this.enteredCharCountBtBTemp += strInputArray[k].length;
        }
        return this.enteredCharCountBtBTemp;
      } else {
          this.enteredCharCountBtBTemp = strResult ? strResult.length : 0;
          return this.enteredCharCountBtBTemp;
      }
  }

  checkPendingClientBankViewForAmendTnx(): boolean {
    const tnxTypeCode = this.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    const mode = this.getQueryParametersFromKey(FccGlobalConstant.MODE);
    const operation = this.getQueryParametersFromKey(FccGlobalConstant.OPERATION);
    const tnxId = this.getQueryParametersFromKey(FccGlobalConstant.TNXID);
    const eventTnxStatCode = this.getQueryParametersFromKey(FccGlobalConstant.eventTnxStatCode);
    let returnValue = true;
    if (tnxTypeCode === FccGlobalConstant.N002_AMEND && mode === FccGlobalConstant.VIEW_SCREEN &&
      operation === FccGlobalConstant.PREVIEW && tnxId !== '' &&
      (eventTnxStatCode === FccGlobalConstant.N002_NEW || eventTnxStatCode === FccGlobalConstant.N002_UPDATE ||
        eventTnxStatCode === FccGlobalConstant.N002_AMEND || eventTnxStatCode === FccGlobalConstant.N002_EXTEND)) {
        returnValue = false;
    }
    return returnValue;
  }

  checkValidFileExtension(fileExt, validFileExtensions): boolean {
    for (let i = 0; i < validFileExtensions.length; i++) {
      const ext: string = validFileExtensions[i].toLowerCase();
      if (ext.trim() === fileExt.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  getFileExtPath(fileName: string) {
    const fileExtn = fileName.split('.').pop().toLowerCase();
    const path = `${this.getContextPath()}`;
    const alt = `" alt = "`;
    const imgSrcStartTag = '<img src="';
    const endTag = '"/>';
    const pdfFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.PDF_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.PDF_ALT)}`).concat(endTag);
    const docFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.DOC_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.DOC_ALT)}`).concat(endTag);
    const xlsFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.XLS_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.XSL_ALT)}`).concat(endTag);
    const xlsxFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.XLSX_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.XSLS_ALT)}`).concat(endTag);
    const pngFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.PNG_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.PNG_ALT)}`).concat(endTag);
    const jpgFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.JPG_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.JPG_ALT)}`).concat(endTag);
    const txtFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.TXT_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.TXT_ALT)}`).concat(endTag);
    const zipFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.ZIP_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.ZIP_ALT)}`).concat(endTag);
    const rtgFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.RTF_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.RTF_ALT)}`).concat(endTag);
    const csvFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.CSV_IMG_PATH).concat(alt)
    .concat(`${this.translate.instant(FccGlobalConstant.CSV_ALT)}`).concat(endTag);
    switch (fileExtn) {
      case 'pdf':
        return pdfFilePath;
      case 'docx':
      case 'doc':
        return docFilePath;
      case 'xls':
        return xlsFilePath;
      case 'xlsx':
        return xlsxFilePath;
      case 'png':
        return pngFilePath;
      case 'jpg':
        return jpgFilePath;
      case 'jpeg':
        return jpgFilePath;
      case 'txt':
        return txtFilePath;
      case 'zip':
        return zipFilePath;
      case 'rtf':
        return rtgFilePath;
      case 'csv':
        return csvFilePath;
      default:
        return fileExtn;
    }
  }

  getSwiftVersionValue() {
    this.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        if ( response.swiftVersion ) {
          this.swiftVersion = response.swiftVersion;
        }
      }
    });
  }

  validateProductCodeWithRefId(productCode: any, refId: any) {
    if (refId !== undefined && refId !== null && refId !== '') {
      const prodCodeFromRefId = refId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2);
      if (productCode && prodCodeFromRefId !== productCode) {
        this.router.navigateByUrl('/dummy', { skipLocationChange: true }).then(() => {
          this.router.navigate([FccGlobalConstant.GLOBAL_DASHBOARD]);
      });
      }
    }
  }
  /**
   * Set Entity Submit API
   */
  public setEntity(request): Observable<any> {
    const completePath = this.fccGlobalConstantService.setEntityURL;
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload, { headers , observe: 'response' });
  }

  getNumberWithoutLanguageFormatting(amt: any) {
      amt = amt.split(FccGlobalConstant.COMMA).join('');
      return amt;
  }

  async getBase64FDataFromFile(filePath) {
    const res = await fetch(filePath);
    const blob = await res.blob();

    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.addEventListener('load', () => {
        resolve(reader.result);
      }, false);

      reader.onerror = () => reject(this);
      reader.readAsDataURL(blob);
    });
  }
  /**
   * Set Reference Submit API
   */
  public setReference(request, id): Observable<any> {
    const completePath = this.fccGlobalConstantService.setReferenceURL + id;
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload, { headers , observe: 'response' });
  }

  public registerCustomMatIcons() {
    this.registerCustomMatIcon('accordion_expand_all', 'accordion_expand_all.svg');
    this.registerCustomMatIcon('accordion_collapse_all', 'accordion_collapse_all.svg');
  }

  protected registerCustomMatIcon(iconName: string, iconFileName: string) {
     const iconsPath = this.getContextPath() + '/content/FCCUI/assets/icons/';
     this.matIconRegistry.addSvgIcon(
     iconName,
     this.domSanitizer.bypassSecurityTrustResourceUrl(`${iconsPath}${iconFileName}`)
   );
  }

  getRegexBasedOnlanguage() {
    const regexAmount = `${this.translate.instant('amountregex')}`;
    return regexAmount;
  }

  checkNegativeAmount(form: any, amtValue: any, amountField: any) {
    if (parseFloat(amtValue) < 0) {
      form.addFCCValidators(amountField,
        Validators.compose([Validators.required, invalidAmount]), 0);
      form.get(amountField).clearValidators();
      form.get(amountField).setErrors({ invalidAmt: true });
      form.get(amountField).markAsDirty();
      form.get(amountField).markAsTouched();
      return false;
    }
    return true;
  }

  checkRegexAmount(form: any, amtValue: any, amountField: any) {
    form.addFCCValidators(amountField,
      Validators.compose([Validators.pattern(this.getRegexBasedOnlanguage())]), 0);
    form.get(amountField).updateValueAndValidity();
    if (form.get(amountField).hasError('pattern')) {
      form.get(amountField).setErrors({ pattern : true });
      form.get(amountField).markAsDirty();
      form.get(amountField).markAsTouched();
      return false;
    }
    return true;
  }

  public changeUserLanguage(languageCode) {
    const headers = this.getCacheEnabledHeaders();
    const completePath = this.fccGlobalConstantService.getUserLanguageUrl();
    const requestPayload = {
      requestData: { language: languageCode.code }
    };
    return this.http.post<any>(completePath, requestPayload, { headers });
  }

  checkForBankName(stateService: any, form: any, bankDetails: any, issuingBank: any, incoTermRules: any, incoTermRulesMessage: any) {
    const bankNameValue = (stateService && stateService.getSectionData(bankDetails) &&
    stateService.getSectionData(bankDetails).get(issuingBank)) ?
    stateService.getSectionData(bankDetails).get(issuingBank).value :
    FccGlobalConstant.EMPTY_STRING;
    if (bankNameValue === FccGlobalConstant.EMPTY_STRING || (bankNameValue && (bankNameValue.bankNameList === undefined ||
      bankNameValue.bankNameList === null || bankNameValue.bankNameList === FccGlobalConstant.EMPTY_STRING))) {
        form.get(incoTermRules)[FccGlobalConstant.PARAMS][FccGlobalConstant.WARNING]
       = `${this.translate.instant(incoTermRulesMessage)}`;
    } else {
      form.get(incoTermRules)[FccGlobalConstant.PARAMS][FccGlobalConstant.WARNING]
      = FccGlobalConstant.EMPTY_STRING;
    }
  }

  getAllDeals(custReferences) {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const params = new HttpParams({
          fromObject: {
            custReferences
          } });
    return this.http.get<any>(this.fccGlobalConstantService.getAllDeals, { headers , params, observe: 'response' });
  }

  getAllFacilities(dealIds, custReferences) {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const params = new HttpParams({
          fromObject: {
            dealIds,
            custReferences
          } });
    return this.http.get<any>(this.fccGlobalConstantService.getAllFacilities, { headers , params, observe: 'response' });
  }

  getFacilityDetails(facilityId, custReferences) {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const params = new HttpParams({
      fromObject: {
        custReferences
      } });
    return this.http.get<any>(this.fccGlobalConstantService.getFacilityDetails(facilityId), { headers , params, observe: 'response' });
  }

  getValidateBusinessDate(requestPayload) {
    return this.http.post<any>(this.fccGlobalConstantService.getValidateBusinessDate, requestPayload);
  }

  /**
   *  Save adhoc beneficiary
   */
  saveBeneficiary(counterpartyRequest: CounterpartyRequest) {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[FccGlobalConstant.REQUEST_FORM] = FccGlobalConstant.REQUEST_INTERNAL;
    const headers = new HttpHeaders(obj);
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    return this.http.post<any>(this.fccGlobalConstantService.adhocCounterparties, counterpartyRequest, {
      headers
    });
  }

  validateValue(param: any) {
    let validValue = FccGlobalConstant.EMPTY_STRING;
    if (param !== undefined && param !== null) {
      validValue = param;
    }
    return validValue;
  }
  getAddressBasedOnParamData(parameterId: any, productCode: any, subProductCode?: any) {
    this.addressType = null;
    this.getParameterConfiguredValues(productCode, parameterId, subProductCode).subscribe(responseData => {
      if (responseData && responseData.paramDataList && responseData.paramDataList.length > FccGlobalConstant.LENGTH_0) {
         responseData.paramDataList.forEach(element => {
          if (element[FccGlobalConstant.KEY_1] && element[FccGlobalConstant.KEY_1] === productCode) {
            if (subProductCode && element[FccGlobalConstant.KEY_2] === subProductCode) {
              this.addressType = element[FccGlobalConstant.DATA_1];
            }
            this.addressType = this.addressType ? this.addressType : element[FccGlobalConstant.DATA_1];
          }
         });
         this.addressType = this.addressType ? this.addressType :
         responseData.paramDataList[FccGlobalConstant.LENGTH_0][FccGlobalConstant.DATA_1];
      }
    });
  }

  public redirectPage() {
    const dontShowRouter = 'dontShowRouter';
    let homeDojoUrl = '';
    homeDojoUrl = this.fccGlobalConstantService.contextPath;
    homeDojoUrl = homeDojoUrl + this.fccGlobalConstantService.servletName + '#/dashboard/global';
    this.router.navigate([]).then(() => {
      window[dontShowRouter] = false;
      const dojoContentElement = document.querySelector('.colmask');
      if (dojoContentElement && dojoContentElement !== undefined) {
        (dojoContentElement as HTMLElement).style.display = 'none';
      }
      const footerComponentID = 'footerHtml';
      const dojoFooterElement = document.getElementById(footerComponentID);
      if (dojoFooterElement && dojoFooterElement !== undefined) {
        (dojoFooterElement as HTMLElement).style.display = 'none !important;';
      }
      window.open(homeDojoUrl, '_self');
    });
  }

  handleComputedProductAmtFieldForAmendDraft(form: any, amtField: any) {
    let computedAmtValue = '';
    if (form.get(amtField) && form.get(amtField).value && (form.get(amtField).value).indexOf(FccGlobalConstant.BLANK_SPACE_STRING) > -1) {
      computedAmtValue = this.replaceCurrency(form.get(amtField).value).toString();
    }
    return computedAmtValue;
  }
  checkForSwiftEnabledProduct(productCode) {
    if (productCode === FccGlobalConstant.PRODUCT_BG) {
      return true;
    } else {
      return false;
    }
  }

  getCommitmentScheduledValues(reqParam: any): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const params = new HttpParams({
      fromObject: {
        facilityId: reqParam.facilityId,
        rolloverDate: reqParam.rolloverDate,
        facilityCurrency: reqParam.facilityCurrency,
        loanCurrency: reqParam.loanCurrency,
        loanAmount: reqParam.loanAmount
      }
    });
    return this.http.get<any>(this.fccGlobalConstantService.getCommitmentScheduledValue, {
      headers, params, observe: 'response'
    });
  }

  isLoanBulk(productCode, subProdCode) {
    if (productCode === FccGlobalConstant.PRODUCT_BK
      && (subProdCode === FccGlobalConstant.SUB_PRODUCT_LNRPN || subProdCode === FccGlobalConstant.SUB_PRODUCT_BLFP )) {
      return true;
    }
    return false;
  }

  isExistingLoan(productCode: string, subTnxType: string, mode: string) {
    if ((mode === FccGlobalConstant.EXISTING || mode === FccGlobalConstant.PAYMENT)
      && productCode === FccGlobalConstant.PRODUCT_LN
      && (subTnxType === FccGlobalConstant.N003_INCREASE
      || subTnxType === FccGlobalConstant.N003_DRAWDOWN || subTnxType === FccGlobalConstant.N003_PAYMENT)
      ) {
      return true;
    }
    return false;
  }

  setParentTnxInformation(parentTnxObj: any) {
    if (parentTnxObj) {
      this.parentTnxObj.next(parentTnxObj);
    }
  }

  getParentTnxInformation() {
    return this.parentTnxObj;
  }

  setParentReference(parentReference: any) {
    if (parentReference) {
      this.parentReference.next(parentReference);
    }
  }

  getParentReference() {
    this.parentReference.subscribe(
      (currentValue: any) => currentValue
    );
  }

  getParentReferenceAsObservable() {
    return this.parentReference;
  }

  openParentTransactionPopUp(
    parentProductCode: string, parentRefId: string, subProdCode?: string, tnxId?: string,
    tnxTypeCode?: string, eventTnxStatCode?: string, subTnxTypeCode?: string) {
    const url = this.router.serializeUrl(
      this.router.createUrlTree(['view'], { queryParams: { tnxid: tnxId, referenceid: parentRefId,
        productCode: parentProductCode, subProductCode: subProdCode, tnxTypeCode,
        eventTnxStatCode, mode: FccGlobalConstant.VIEW_MODE,
        subTnxTypeCode,
        operation: FccGlobalConstant.PREVIEW } })
    );
    const popup = window.open('#' + url, '_blank');
    const productId = `${this.translate.instant(parentProductCode)}`;
    const mainTitle = `${this.translate.instant('MAIN_TITLE')}`;
    popup.onload = function() {
      popup.document.title = mainTitle + ' - ' + productId;
    };
  }

  getUserAuditByTnx(tnxId): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    return this.http.get<any>(this.fccGlobalConstantService.getUserAuditByTnx(tnxId), { headers , observe: 'response' });
  }
  getUserAccountType(url: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[FccGlobalConstant.REQUEST_FORM] = FccGlobalConstant.REQUEST_INTERNAL;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = `${url}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  getUserAccountIds(url: string): Observable<any> {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj[FccGlobalConstant.REQUEST_FORM] = FccGlobalConstant.REQUEST_INTERNAL;
    obj['cache-request'] = 'true';
    const headers = new HttpHeaders(obj);
    const reqURl = `${url}`;
    const offset = FccGlobalConstant.LENGTH_0;
    const limit = this.fccGlobalConstantService.getStaticDataLimit();
    return this.http.get<any>(reqURl + `?limit=${limit}&offset=${offset}`, { headers , observe: 'response' });
  }

  public generateToken(request?: any) {
    const headers = this.getCacheEnabledHeaders();
    const completePath = this.fccGlobalConstantService.generateTokenUrl;
    return this.http.post<any>(completePath, request, { headers });
  }

  public callDeepLinkURL(deepLinkURLType: any, token ?: any, url ?: any, payLoad ?: any): Observable<any> {
    let headers;
    let body;
    if (deepLinkURLType) {
      headers = { contentType: FccGlobalConstant.APP_JSON, SEC_TKN: token, Accept: 'text/html', Authorization: token };
      body = payLoad ;
      return this.http.request('POST', url, { body, headers , observe: 'response' , responseType: 'text' });
    } else {
      headers = { contentType: FccGlobalConstant.APP_JSON, Accept: 'text/html' };
      body = payLoad ;
      const reqURL = `${url}?SEC_TKN=${token}`;
      return this.http.request('POST', reqURL, { body, headers , observe: 'response' , responseType: 'text' });
    }
  }

  getAllAccountsMappedToGroup(filterValues: any) {
    this.filterParams = filterValues;
    return this.listDefService.getTableData(FccConstants.ACCOUNTS_MAPPED_TO_GROUP, JSON.stringify(this.filterParams), '');
  }
  setCompanyCaseSensitiveSearchEnabled(value: boolean) {
    this.isCompanyCaseSensitiveSearchEnabled = value;
  }

  getCompanyCaseSensitiveSearchEnabled() {
    return this.isCompanyCaseSensitiveSearchEnabled;
  }

  setUserCaseSensitiveSearchEnabled(value: boolean) {
    this.isUserCaseSensitiveSearchEnabled = value;
  }

  getUserCaseSensitiveSearchEnabled() {
    return this.isUserCaseSensitiveSearchEnabled;
  }

  setIsStaticAccountEnabled(isStaticAccountEnabled: boolean) {
    this.isStaticAccountEnabled = isStaticAccountEnabled;
  }
  getIsStaticAccountEnabled(): boolean {
    return this.isStaticAccountEnabled;
  }

  dealDetailsDashboardLoad(parameter: any) {
    this.dealDetailsBehaviourSubject.next(parameter);
  }

  setAmountFormatAbbvNameList(amountFormatAbbvNameList) {
    this.amountFormatAbbvNameList = amountFormatAbbvNameList;
  }

  getAmountFormatAbbvNameList() {
    return this.amountFormatAbbvNameList;
  }

  chequeViewDetailsLoad(parameter: any) {
    this.chequeViewDetails.next(parameter);
  }

  setIsMT700Upload(isMT700Upload: any) {
    this.isMT700Upload = isMT700Upload;
  }

  getIsMT700Upload(): any {
    return this.isMT700Upload;
  }

  public getNudges(widgetDetail, productCode?, subProductCode?): Promise<any>{
    return new Promise(async (resolver) => { // eslint-disable-line no-async-promise-executor
     const widgetDetails = this.isNonEmptyValue(widgetDetail) ? JSON.parse(widgetDetail) : {};
     if (this.isnonEMptyString(widgetDetails)) {
        await this.nudgesService.getNudges(widgetDetails.widgetName, productCode, subProductCode).then(data => {
       this.nudges = data.nudgetList ? data.nudgetList : [];
       for (let i = 0; i < this.nudges.length; i++) {
        this.getDeepLinkingData(this.nudges, i).then(response => {
          this.nudges = response;
          resolver(this.nudges);
        });
       }
     });
   }
   });
 }

 public getHyperLinks(widgetName): Promise<any>{
  return new Promise(async (resolver) => { // eslint-disable-line no-async-promise-executor
   if (this.isnonEMptyString(widgetName)) {
      await this.nudgesService.getNudges(widgetName).then(data => {
     this.nudges = data.nudgetList ? data.nudgetList : [];
     for (let i = 0; i < this.nudges.length; i++) {
      this.getDeepLinkingData(this.nudges, i).then(response => {
        this.nudges = response;
        resolver(this.nudges);
      });
     }
   });
 }
 });
}

  getDeepLinkingData(nudges, index): Promise<any>{
    return new Promise(async (resolver) => { // eslint-disable-line no-async-promise-executor
      this.deepLinkingSerice.getDeepLinking(nudges[index].productProcessor, nudges[index].urlKey).then(data => {
        if (data.deepLinkingDetails && data.deepLinkingDetails[0]
            && data.deepLinkingDetails[0].deepLinkingDataList.length > 0 && nudges.length > 0) {
          nudges[index].urlType = data.deepLinkingDetails[0].deepLinkingDataList[0].urlType;
          nudges[index].url = data.deepLinkingDetails[0].deepLinkingDataList[0].url;
          nudges[index].securityType = data.deepLinkingDetails[0].deepLinkingDataList[0].securityType;
          nudges[index].httpMethod = data.deepLinkingDetails[0].deepLinkingDataList[0].httpMethod;
          nudges[index].headerParameters = data.deepLinkingDetails[0].deepLinkingDataList[0].headerParameters;
          nudges[index].bodyParameters = data.deepLinkingDetails[0].deepLinkingDataList[0].bodyParameters;
          nudges[index].target = data.deepLinkingDetails[0].deepLinkingDataList[0].target;
          nudges[index].permission = data.deepLinkingDetails[0].deepLinkingDataList[0].permission;
          nudges[index].urlScreenType = data.deepLinkingDetails[0].deepLinkingDataList[0].urlScreenType;
          nudges[index].queryParameter = data.deepLinkingDetails[0].deepLinkingDataList[0].queryParameter;
          resolver(nudges);
        }
      });
    });
 }

navigateToLink(item) {
  // To be used for Post requests SSO (Ex: Download statement)
  if (item.httpMethod.toUpperCase() === FccConstants.POST){
    this.generateToken().subscribe(response => {
      if (response) {
        const ssoToken = response.SSOTOKEN;
        const queryParameter = item.queryParameter;
        const headerType = item.headerParameters as string;
        if (headerType.toUpperCase() === FccConstants.HEADER && queryParameter){
          const headerObject = {
            [queryParameter] : ssoToken
          };
          const headers = new HttpHeaders(headerObject);
          return this.http.post<any>(item.url, item.bodyParameters, { headers });
        } else if (item.headerParameters === 'url' && queryParameter){
          const url = item.url + '?' + queryParameter + '=' + ssoToken;
          return this.http.post<any>(url, item.bodyParameters);
        }
      }
  });
  } else if (item.urlType === FccGlobalConstant.INTERNAL && this.isNonEmptyValue(item.urlScreenType)
  && item.urlScreenType !== '') {
    this.displayDialog = false;
    const urlScreenType = item.urlScreenType as string;
    if (urlScreenType.toUpperCase() === FccGlobalConstant.ANGULAR_UPPER_CASE) {
      window.scrollTo(0, 0);
      this.router.navigate([]).then(() => {
        window.open(item.url, FccGlobalConstant.SELF);
      });
    } else {
      const urlContext = this.getContextPath();
      const dojoUrl = urlContext + this.fccGlobalConstantService.servletName + item.url;
      this.router.navigate([]).then(() => {
        window.open(dojoUrl, FccGlobalConstant.SELF);
      });
    }
  } else if (item.urlType === FccGlobalConstant.EXTERNAL) {
    if (item.securityType === FccGlobalConstant.SSO) {
      this.generateToken().subscribe(response => {
        if (response) {
          const ssoToken = response.SSOTOKEN;
          const queryParameter = item.queryParameter;
          const headerObject = {
            [queryParameter] : ssoToken
          };
          const headers = new HttpHeaders(headerObject);
          this.http.get<any>(item.url, { headers }).subscribe( () => {
            window.open(item.url, FccGlobalConstant.BLANK);
          },
          // eslint-disable-next-line @typescript-eslint/no-unused-vars
          (error) => {
            window.open(item.url, FccGlobalConstant.BLANK);
          }
          );
        }
      });
    }else {
      window.open(item.url, FccGlobalConstant.BLANK);
    }
  } else if (item.urlType === FccGlobalConstant.IFRAME) {
    this.displayDialog = false;
    if (item.securityType === FccGlobalConstant.SSO) {
      this.iframeURL = item.url;
      this.deepLinkingQueryParameter = item.queryParameter;
      this.router.navigate(['/sso-deeplink-url']);
    } else{
      this.iframeURL = item.url;
      this.router.navigate(['/iframe']);
    }
  }
}


  public getUserProfileAccount(productCode, entity): Observable<any> {
    const headers = new HttpHeaders({ 'cache-request': 'true', 'Content-Type': FccGlobalConstant.APP_JSON });
    const reqUrl = `${this.fccGlobalConstantService.userProfileAccounts}`;
    const reqPayload = {
      requestData: { productCode, option: FccGlobalConstant.USER_ACCOUNT, entity },
    };
    return this.http.post<any>(reqUrl, reqPayload, { headers });
  }

  // Display label based on product code and sub product code
  public displayLabelByCode(productCode, subProductCode) {
    switch (subProductCode) {
      case FccGlobalConstant.SUB_PRODUCT_LNCDS:
      case FccGlobalConstant.SUB_PRODUCT_BLFP:
      case FccGlobalConstant.SUB_PRODUCT_LNRPN:
        return this.translate.instant('N047_' + subProductCode);
      default:
        return `${this.translate.instant(productCode)}`;
    }
  }

  autoSaveForm(requestObj, createFlag: boolean, productCode?: string, subProductCode?: string, option?: string
    , referenceId?: string, tnxTypeCode?: string, version?: string) {
    const headers = new HttpHeaders({ 'cache-request': 'true', 'Content-Type': FccGlobalConstant.APP_JSON
    , 'Idempotency-Key': this.fccGlobalConstantService.generateUIUD() });
    const reqUrl = this.fccGlobalConstantService.getAutoSaveUrl();
    const requestPayload = {
      productCode: this.getValue(productCode),
      subProductCode: this.getValue(subProductCode),
      option: this.getValue(option),
      referenceId: this.getValue(referenceId),
      tnxTypeCode: this.getValue(tnxTypeCode),
      version: this.getValue(version),
      formData: JSON.stringify(requestObj)
    };
    if (createFlag) {
      return this.http.post<any>(reqUrl , requestPayload , { headers });
    }
    else {
      return this.http.put<any>(reqUrl , requestPayload , { headers });
    }
  }

  getValue(value) {
    return value ? value : FccGlobalConstant.EMPTY_STRING;
  }

  getAutoSavedForm(productCode?: string, subProductCode?: string, referenceId?: string, tnxTypeCode?: string, option?: string){
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    const reqURl = this.fccGlobalConstantService.getAutoSaveUrl();
    const params = `?productCode=${this.getValue(productCode)}&subProductCode=${this.getValue(subProductCode)}&referenceId=${this
      .getValue(referenceId)}&tnxTypeCode=${this.getValue(tnxTypeCode)}&option=${this.getValue(option)}`;
    return this.http.get<any>(reqURl.concat(params), { headers });
  }

  getBeneficiaryAccounts(associationId, fetchAccountsList?) {
    const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
    const reqURl =
     `${this.fccGlobalConstantService.beneficiaryAccounts}/${associationId}`;
    const params = new HttpParams({
      fromObject: {
        fetchAccountsList
      }
    });
    return this.http.get<any>(
      reqURl,
      { headers, params }
    );
  }

  markBeneAccountPairAsFavUnFav(associationId: string, favStatus): Observable<any> {
    const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
    const reqURl =
    `${this.fccGlobalConstantService.favPaymentBeneficiaryDetails}/${associationId}`+'/favourite';
    const requestPayload = {
      isFavourite: favStatus,
    };
    return this.http.put<any>(reqURl,requestPayload, { headers , observe: 'response' });
  }

  getFavBeneCount(): Observable<any> {
    const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
    const reqURl = `${this.fccGlobalConstantService.favBeneficiaryCount}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  beneficiaryStatus(associationId: string, status: string, beneficiaryId: string): Observable<any> {
    const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
    const reqURl = `${this.fccGlobalConstantService.beneficiaryStatus}/${associationId}`+'/status?beneficiaryId='+beneficiaryId;
    const requestPayload = {
      event: status,
      makerRemarks: "",
      checkerRemarks: ""
    };
    return this.http.put<any>(reqURl,requestPayload, { headers , observe: 'response' });
  }

  addIdToPmenuDropdown() {
    const allMenues: any = Array.from(document.getElementsByTagName('p-menubar'));
    allMenues.forEach((menu) => {
      const list: any = menu.getElementsByTagName('ul')[0];
      const allLinks: any = Array.from(list.getElementsByTagName('a'));
      allLinks.forEach((link) => {
        const spanValue = link.getElementsByClassName('ui-menuitem-text')[0];
        const idValue = spanValue.textContent.replace(/\s+/g, '_').trim();
        link.setAttribute("id", idValue + '_link');
        spanValue.setAttribute("id", idValue);
      });
    });
  }

  addIdToMatTabLabel(){
    const allMenues: any = Array.from(document.getElementsByTagName('mat-tab-header'));
    allMenues.forEach((menu) => {
        const matTabLabel: any = Array.from(menu.getElementsByClassName('mat-tab-label'));
        matTabLabel.forEach((label) => {
        const matTabLabelContent = label.getElementsByClassName('mat-tab-label-content')[0];
        const value = matTabLabelContent.textContent.trim().replace(/\s+/g, '_');
        matTabLabelContent.setAttribute("id", value + "_Content");
        label.setAttribute("id", value);
        });
    });
  }

  validateProduct(form: FCCFormGroup, fieldName: string, productCode: string): boolean {
    const checkApplicableProducts = form.get(fieldName)[FccGlobalConstant.PARAMS]['applicableValidation'][0]['applicableProducts'];
    if (checkApplicableProducts !== undefined) {
    return checkApplicableProducts.indexOf(productCode) > -1;
    } else {
      return true;
    }
  }

  public submitSinglePayment(request) {
    const iKey = this.fccGlobalConstantService.generateUIUD();
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    obj['xRequestID'] = iKey;
    const headers = new HttpHeaders(obj);
    const completePath = this.fccGlobalConstantService.singlePaymentURL;
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload, { headers , observe: 'response' });
  }

  public submitBulkPayment(request) {
    const completePath = this.fccGlobalConstantService.bulkPaymentURL;
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload);
  }

  public submitBulkBene(request) {
    const completePath = this.fccGlobalConstantService.bulkBeneURL;
    const requestPayload = request;
    return this.http.post<any>(completePath, requestPayload);
  }

  public getPaymentDetails(request){
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const reqURl = this.fccGlobalConstantService.paymentDetailsurl + request.paymentReferenceNumber + '/payments-detail';
    return this.http.get<any>(reqURl, { headers });
  }

  public getInstrumentDetails(request, instumentRefNum){
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const reqURl = this.fccGlobalConstantService.paymentDetailsurl + request.paymentReferenceNumber + 
    '/payments-detail?instrumentPaymentReference='+ instumentRefNum;
    return this.http.get<any>(reqURl, { headers });
  }

  public getPaymentOverviewDetails(liquidationDateDuration): Observable<any> {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const reqURl = this.fccGlobalConstantService.paymentOverviewDetailsURL+ '?liquidationDateDuration='+liquidationDateDuration;
    return this.http.get<any>(reqURl, { headers });
  }

  getListPopupActions(listdefName?: string, status?: string, option?: string, category?: string) {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const reqURl = this.fccGlobalConstantService.getPopupActionsUrl();
    const params = `?listdefName=${this.getValue(listdefName)}&status=${this.getValue(status)}
    &Option=${this.getValue(option)}&category=${this.getValue(category)}`;
    return this.http.get<any>(reqURl.concat(params), { headers });
  }

  viewDetailsPopup(associationId: string): Promise<any> {
    return new Promise<any>((res) => {
      let accountResponse: any;

        if (this.isnonEMptyString(associationId)) {
           this.getBeneficiaryAccounts(associationId).subscribe(response => {
            if (response.data && response.data.bankAccountBeneStatus) {
              accountResponse = response.data;
              res(accountResponse);
            }
          });
        }

    });
  }

  public isListdefActionColumn(column: string): boolean {
    return column === FccGlobalConstant.ACTION? true: false;
  }

  setFooterSticky(footerFlag: boolean){
    this.isFooterSticky.next(footerFlag);
  }
  getFooterStickyFlag(){
    return this.isFooterSticky;

  }

  showToasterMessage(message:Message){
    this.messageService.add(message);
  }


  performBeneficiaryMultiApproveRejectFCM(associationIdsArr:string[],eventType:string,
    comment:string, associationId?:string, beneficiaryId?:string){
    if(associationId==undefined||associationId==null){
      associationId=associationIdsArr[0];
    }
   return this.http.put(this.fccGlobalConstantService.baseUrl +
    `beneficiary-accounts/${associationId}/status?associationIds=`+associationIdsArr+`&beneficiaryId=`+beneficiaryId, {
      makerRemarks: "",
      checkerRemarks: comment,
      event: eventType
    });
  }


  performBeneficiaryApproveRejectFCM(associationId:string,eventType:string,comment,beneficiaryId?: string){
    return this.http.put(this.fccGlobalConstantService.baseUrl +
      `beneficiary-accounts/${associationId}/status?beneficiaryId=`+beneficiaryId, {
      makerRemarks: "",
      checkerRemarks: comment,
      event: eventType
    });
  }

  /**
  *
  * @param associationId
  * @param eventType
  * @param comment
  */
  approveReject(associationId?:string,eventType?:string,comment?:string,beneficiaryId?: string){
    if(this.isnonEMptyString(associationId)&&this.isnonEMptyString(eventType)){
      if(eventType==FccGlobalConstant.ACTION_APPROVE || eventType==FccGlobalConstant.ACTION_REJECT){
        return this.performBeneficiaryApproveRejectFCM(associationId,eventType,comment,beneficiaryId);
      }

    }

}

paymentsApproveReject(paymentReferenceNumber?:string,eventType?:string,comment?:string){
  if(this.isnonEMptyString(paymentReferenceNumber)&&this.isnonEMptyString(eventType)){
    if(eventType==FccGlobalConstant.ACTION_APPROVE || eventType==FccGlobalConstant.ACTION_REJECT){
      return this.performPaymentsApproveRejectFCM(paymentReferenceNumber,eventType,comment);
    }

  }

}

paymentDiscard(paymentReferenceNumber: any, action: any, comment: any) {
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/paymentstatus`, {
    checkerRemarks: comment,
    event: action
  });
}

paymentInstrumentDiscard(paymentReferenceNumber: any, action: any, instrumentRefNumber: any, comment)
{
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}`+
    `/batchpaymentdeleteinstrument?instrumentPaymentReference=${instrumentRefNumber}`,{
      event: action, 
      checkerRemarks: comment
    
    });
}

paymentInstrumentApproveFCM(paymentReferenceNumber: any, action: any, instrumentRefNumber: any, comment)
{
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}`+
    `/batchpaymentapproveinstrument?instrumentPaymentReference=${instrumentRefNumber}`,{
      event: action, 
      checkerRemarks: ''
    
    });
}


paymentInstrumentRejectFCM(paymentReferenceNumber: any, action: any, instrumentRefNumber: any, comment)
{
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}`+
    `/batchpaymentrejectinstrument?instrumentPaymentReference=${instrumentRefNumber}`,{
      event: action, 
      checkerRemarks: comment
    
    });
}

paymentInstrumentVerifyFCM(paymentReferenceNumber: any, action: any, instrumentRefNumber: any, comment)
{
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}`+
    `/batchpaymentverifyinstrument?instrumentPaymentReference=${instrumentRefNumber}`,{
      event: action, 
      checkerRemarks: ''
    
    });
}

batchPaymentAction(paymentReferenceNumber: any, action: any, comment: any) {
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/batchpaymentstatus`, {
    checkerRemarks: comment,
    event: action
  });
}

sendbatchPaymentAction(paymentReferenceNumber: any, action: any, comment: any) {
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/sendbatchpayment`, {
    checkerRemarks: comment,
    event: action
  });
}

scrapbatchPaymentAction(paymentReferenceNumber: any, action: any, comment: any) {
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/scrapbatchpayment`, {
    checkerRemarks: comment,
    event: action
  });
}

batchPaymentActionApprove(paymentReferenceNumber: any, action: any, comment: any) {
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/batchpaymentstatusApprove`, {
    checkerRemarks: comment,
    event: action
  });
}

batchPaymentActionReject(paymentReferenceNumber: any, action: any, comment: any) {
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/batchpaymentstatusReject`, {
    checkerRemarks: comment,
    event: action
  });
}

beneDiscard(associationId) {
  const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
  return this.http.delete(this.fccGlobalConstantService.fcmBeneficiaryCreation+`/${associationId}`, { headers });
}

performPaymentsApproveRejectFCM(paymentReferenceNumber:string,eventType:string,comment){
  return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/paymentstatus`, {
    checkerRemarks: comment,
    event: eventType
  });
}

  performTransactionPaymentsApproveRejectFCM(paymentReferenceNumbers: any, eventType: string,
    comment: string, paymentReferenceNumber?: string) {
    if (paymentReferenceNumber == undefined || paymentReferenceNumber == null) {
      paymentReferenceNumber = paymentReferenceNumbers[0];
    }
   return this.http.put(
    this.fccGlobalConstantService.paymentDetailsurl+`${paymentReferenceNumber}/paymentstatus?paymentReferenceNumbers=`
    +paymentReferenceNumbers, {
      checkerRemarks: comment,
      event: eventType
    });
  }

  viewAdditionalInfoPopup(paymentReferenceNumber: string): Promise<any> {
    return new Promise<any>((res) => {
      let accountResponse: any;
        if (this.isnonEMptyString(paymentReferenceNumber)) {
          const req = {
            paymentReferenceNumber : paymentReferenceNumber
          };
          this.getPaymentDetails(req).subscribe(response => {
            if (response.data) {
              const flatMap = {};
              const paymentDetail = response.data;
              this.convertResponse(paymentDetail,FccGlobalConstant.PAYMENT_DETAILS_MAPPING,flatMap);
              accountResponse = flatMap;
              res(accountResponse);
            }
          });
        }

    });
  }

  viewAdditionalInfoInstrumentPopup(paymentReferenceNumber: string, instrumentRefNum: string): Promise<any> {
    return new Promise<any>((res) => {
      let accountResponse: any;
        if (this.isnonEMptyString(paymentReferenceNumber)) {
          const req = {
            paymentReferenceNumber : paymentReferenceNumber
          };
          this.getInstrumentDetails(req, instrumentRefNum).subscribe(response => {
            if (response.data) {
              const flatMap = {};
              const paymentDetail = response.data;
              this.convertResponse(paymentDetail,FccGlobalConstant.INSTRUMENT_PAYMENT_DETAILS_MAPPING,flatMap);
              accountResponse = flatMap;
              res(accountResponse);
            }
          });
        }

    });
  }

  convertResponse(response,map ,flatMap){
    const paramId = FccGlobalConstant.CONFIDENTIAL_PARAMETER;
    let confidentialString = FccGlobalConstant.EMPTY_STRING;
    this.getParameterConfiguredValues(null, paramId).subscribe(resp => {
      if (resp && resp.paramDataList) {
        resp.paramDataList.forEach(element => {
           confidentialString = element.data_1;
        });
      }
    });
    Object.keys(map).forEach(key => {
      const fields = map[key];
      let value = Object.assign({},response);
      fields.forEach(field => {
        if(Array.isArray(value[field])) {
          value = value[field][0];
        } else if(typeof value[field] === 'object'){
          value = value[field];
        } else if(typeof value[field] !== 'object'){
          value = value[field];
        }
      });
      if(this.isnonEMptyString(confidentialString) && this.isnonEMptyString(value) &&
        typeof value === 'string' && value.indexOf(FccGlobalConstant.CONFIDENTIAL_STRING) !==-1 ){
        value = confidentialString;
      }
      flatMap[key] = value;
    });
  }

    isObjectEmpty(object){
      return Object.keys(object).length === 0 ;
    }
  public updateSinglePayment(requestObj) {
    const obj = {};
    obj[this.contentType] = FccGlobalConstant.APP_JSON;
    const headers = new HttpHeaders(obj);
    const completePath = this.fccGlobalConstantService.singlePaymentURL + `/${requestObj.paymentReferenceNumber}`;
    const requestPayload = requestObj.request;
    return this.http.put<any>(completePath, requestPayload, { headers , observe: 'response' });
  }

  setInputAutoComp(flag: boolean){
    this.inputAutoComp.next(flag);
  }

  addTitleBarCloseButtonAccessibilityControl(): void {
    const closeButton = Array.from(document.getElementsByClassName('ui-dialog-titlebar-close'));
    closeButton.forEach(element => {
      element[FccGlobalConstant.ARIA_LABEL] = this.translate.instant("close");
      element[FccGlobalConstant.TITLE] = this.translate.instant("close");
    });
  }

  getCurrencySymbolForPDF(curCode: string, amt: any): string {
    return `${curCode} ${getCurrencySymbol(curCode, "narrow")} ${amt}`;
  }

  getCurrencyFormatedAmount(curCode: string, amt: any, currencySymbolDisplayEnabled: boolean): string {
    if (this.isnonEMptyString(curCode) && this.isnonEMptyString(amt) && amt !== '-') {
      return currencySymbolDisplayEnabled ? this.getCurrencySymbolForDownloads(curCode, amt) : amt;
    }
    return amt;
  }

  getCurrencyFormatedAmountForPreview(curCode: string, amt: any): string {
    const currencyAmount = this.getCurrencySymbol(curCode, amt);
    const isArabic = localStorage.getItem(FccGlobalConstant.LANGUAGE) === FccGlobalConstant.LANGUAGE_AR;
    if (this.isnonEMptyString(curCode) && this.isnonEMptyString(amt) && amt !== '-' && !isArabic) {
      return currencyAmount;
    } else if (isArabic) {
      return currencyAmount.split(' ').reverse().join(' ');
    }
    return amt;
  }

  getCurrencyFormatedAmountForListdef(curCode: string, amt: string, currencySymbolDisplayEnabled: boolean): string {
    if (this.isnonEMptyString(curCode) && this.isnonEMptyString(amt) && amt !== '-') {
      return currencySymbolDisplayEnabled ? this.getCurrencySymbolForListdef(
        curCode, amt, localStorage.getItem(FccGlobalConstant.LANGUAGE)) : amt;
    }
    return amt;
  }

  getCurrencySymbolForDownloads(curCode: string, amt: string): string {
    const currSymbol = getCurrencySymbol(curCode, "narrow");
    return curCode !== currSymbol ? `${currSymbol} ${amt}` : `${amt}`;
  }

  getCurrencySymbol(curCode: string, amt: string): string {
    const currSymbol = getCurrencySymbol(curCode, "narrow");
    return `${currSymbol} ${amt}`;
  }

  getCurrSymbol(curCode: string) {
    return getCurrencySymbol(curCode, "narrow");
  }

  removeAmountFormatting(value: any) {
    const language = localStorage.getItem('language');
    let amt: any;
    if (language === 'fr') {
      amt = value.replace(/\s/g, '').replace(',', '.');
      return amt;
    } else if (language === 'ar') {
      amt = value.replace(/,/g, '').replace('٫', '.');
      return amt;
    } else {
      amt = value.replace(/,/g, '');
      return amt;
    }
  }

  getCurrencySymbolForListdef(curCode: string, amt: any, language: string): string {
    const currSymbol = getCurrencySymbol(curCode, "narrow");
    let newAmt;
    if (!isNaN(amt.split(',').join(''))) {
      if (language !== 'ar') {
        newAmt = curCode !== currSymbol ? `${currSymbol} ${amt}` : `${amt}`;
      } else {
        newAmt = curCode !== currSymbol ? `${amt} ${currSymbol}` : `${amt}`;
      }
    } else {
      newAmt = amt;
    }
    return newAmt;
  }

  isPositiveNumber(number):boolean{
    let flag = false;
    if(!isNaN(number)){
      if(+number >= 0){
        flag = true;
      }
    }
    return flag;
  }

  redirectToLink(link, filterObj?) {
    if (link) {
      const isAngularUrl = link && link.indexOf('#') > -1;
      if (isAngularUrl) {
        const url = link.split('#')[1];
        window.scroll(0, 0);
        if (filterObj) {
          this.router.navigateByUrl(url, { state: { filterdata: filterObj } });
        } else {
          this.router.navigateByUrl(url);
        }
      } else {
        const contextPath = this.getContextPath();
        const dojoPath = `${this.fccGlobalConstantService.servletName}/screen/`;
        let url = '';
        if (contextPath !== null && contextPath !== '') {
          url = contextPath;
        }
        url = `${url}${dojoPath}${link}`;
        this.router.navigate([]).then(() => {
          window.open(url, '_self');
        });
      }
    }
  }
  public getamountConfiguration(currency: any) {
    let isAmountConfigured = "";
    let bankName = "";
    this.getBankDetails().subscribe((bankRes) => {
      bankName = bankRes.shortName;
      this.getParameterConfiguredValues(bankName, FccGlobalConstant.PARAMETER_P808, currency).subscribe((response) => {
        if (this.isNonEmptyValue(response) && this.isNonEmptyValue(response.paramDataList)) {
          const paramData = response.paramDataList;
          isAmountConfigured = paramData[0].data_1;
          this.amountConfig.next(isAmountConfigured);
          }
      });
    });
    return isAmountConfigured === "2" ? true : false;
  }

  realAmount(currencySymbolDisplayEnabled: any, totalAmtInFormat: any,
    baseCurrencyUserLimitCurrency: any) {
    const language = localStorage.getItem('language');
    let totalAmtNumber: any;
    if (language === 'fr') {
      if (currencySymbolDisplayEnabled) {
        totalAmtNumber = this.getCurrencySymbol(baseCurrencyUserLimitCurrency,
          totalAmtInFormat.split(',')[0]) + ',';
      } else {
        totalAmtNumber = totalAmtInFormat.split(',')[0] + ',';
      }
    } else if (language === 'ar') {
      if (currencySymbolDisplayEnabled) {
        totalAmtNumber = this.getCurrencySymbol(baseCurrencyUserLimitCurrency,
          totalAmtInFormat.split('٫')[0]) + '٫';
      } else {
        totalAmtNumber = totalAmtInFormat.split('٫')[0] + '٫';
      }
    } else {
      if (currencySymbolDisplayEnabled) {
        totalAmtNumber = this.getCurrencySymbol(baseCurrencyUserLimitCurrency,
          totalAmtInFormat.split('.')[0]) + '.';
      } else {
        totalAmtNumber = totalAmtInFormat.split('.')[0] + '.';
      }
    }
    return totalAmtNumber;
  }

  paymentDashboardAction( request: any, packageName?: string, debtorIdentification?: string) {
    const headers = new HttpHeaders({ contentType: FccGlobalConstant.APP_JSON });
    const reqURl = this.fccGlobalConstantService.paymentDetailsurl + 'paymentactionrequest';
    const params = `?packageName=${this.getValue(packageName)}
    &debtorIdentification=${this.getValue(debtorIdentification)}`;
    return this.http.put<any>(reqURl.concat(params), request, { headers });
  }
  setIsChildList(flag: boolean){
    this.isChildList.next(flag);
  }
  getIsChildList(){
    return this.isChildList;
  }
  setIsViewMore(flag: boolean){
    this.isViewMore.next(flag);
  }
  getIsViewMore(){
    return this.isViewMore;
  }

  setDefaultClient(dropdownList, form, controlName) {
    const defaultClient = dropdownList.length ? dropdownList[0].defaultclient : null;
    const obj = [];
    let objValue;
    let currValue;
    dropdownList.forEach(element => {
    objValue = {
      label: element.clientid,
      value : {
        label: element.clientid,
        name: element.clientdesc,
        shortName: element.clientid
      }
    };
    obj.push(objValue);
    if (defaultClient && element.clientid === defaultClient) {
      currValue = objValue.value;
    }
    });
    if (dropdownList.length === 1 && !form.controls[controlName].value) {
      this.patchFieldValueAndParameters(form.controls[controlName], obj[0].value, { options: obj });
    } else if (currValue && !form.controls[controlName].value) {
      this.patchFieldValueAndParameters(form.controls[controlName], currValue, { options: obj });
    } else {
      this.patchFieldParameters(form.controls[controlName], { options: obj });
    }
  }

  setDefaultPayTO(dropdownList, form, controlName) {
    let objValue;
    const obj = [];
    let currValue;

    dropdownList.forEach(element => {
      objValue = {
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
      obj.push(objValue);
      if (element.default_account === 'Y') {
        currValue = objValue.value;
      }
      });
    this.patchFieldValueAndParameters(form.controls[controlName], currValue, { options: obj });


  }


  setBatchFormData(formData){
    this.batchFormData = formData;
  }

  getBatchFormData(){
    return this.batchFormData;
  }

  getUpcomingTransactionDetailsNew(fromDate, toDate) {
    const headers = this.getCacheEnabledHeaders();
    const reqURl = `${this.fccGlobalConstantService.getUpcomingPaymentSummaryUrl()}?fromDate=${fromDate}&toDate=${toDate}`;
    return this.http.get<any>(reqURl, { headers } );
  }

  getAllowedDocViewerMimeTypes() {
    this.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        if ( response.docViewerMimeType ) {
          this.allowedDocViewerMimeTypes = response.docViewerMimeType;
        }
      }
    });
  }

  getBeneficiaryDetails(beneficiaryId): Observable<any> {
    const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
    const reqURl = `${this.fccGlobalConstantService.getBeneficiaryDetails}?beneficiaryId=${beneficiaryId}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  getBeneficiaryAccountDetails(beneficiaryId): Observable<any> {
    const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
    const reqURl = `${this.fccGlobalConstantService.getBeneficiaryAccountDetails}?beneficiaryId=${beneficiaryId}`;
    return this.http.get<any>(reqURl, { headers , observe: 'response' });
  }

  convertCurrencyFormatStrToFloat(numStr:any):number{
    let floatValue = 0;
    if(this.isnonEMptyString(numStr)){
      floatValue = parseFloat(numStr.toString().replace(",", "")) || 0;
    }
    return floatValue;
  }

  replaceStringToNumberFormat(numStr:any):number{
    let numValue = 0;

    if(this.isnonEMptyString(numStr)){
      numStr = numStr.replace(new RegExp(FccGlobalConstant.NUMBER_REPLACE_CHARS, "g"), "");
      numValue = parseInt(numStr) || 0;
    }

    return numValue;
  }

  replaceNumberToFloatStringPerLang(numValue){
    let numStr = numValue.toString();
    const language = localStorage.getItem('language');
    if(this.isnonEMptyString(numValue)){
      if (language === 'fr') {
        numStr = numStr.replace(".", ",");
      }else if(language === 'ar'){
        numStr = numStr.replace(".", "٫");
      }
    }
    return numStr;
  }

  compareArray(array1 , array2, sortAndCompare = false){
    if(sortAndCompare){
      array1 = array1.slice().sort();
      array2 = array2.slice().sort();
      return this.isEqual(array1,array2);
    }else{
      return this.isEqual(array1,array2);
    }
  }
  isEqual(a, b)
  {
    return a.join() == b.join();
  }
  getButtonList() {
    const approveBatchPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_APPROVE_BATCH_PAYMENTS_PERMISSION);
    const rejectBatchPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_REJECT_BATCH_PAYMENTS_PERMISSION);
    const sendBatchPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_SEND_BATCH_PAYMENTS_PERMISSION);
    const scrapBatchPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_SCRAP_BATCH_PAYMENTS_PERMISSION);
    const verifyBatchPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_VERIFY_BATCH_PAYMENTS_PERMISSION);

    const approveInstrumentPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_APPROVE_INSTRUMENT_PAYMENTS_PERMISSION);
    const rejectInstrumentPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_REJECT_INSTRUMENT_PAYMENTS_PERMISSION);
    const sendInstrumentPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_SEND_INSTRUMENT_PAYMENTS_PERMISSION);
    const scrapInstrumentPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_SCRAP_INSTRUMENT_PAYMENTS_PERMISSION);
    const verifyInstrumentPermission = this.getUserPermissionFlag(FccGlobalConstant.FCM_VERIFY_INSTRUMENT_PAYMENTS_PERMISSION);
    let batchStatus;
    const generalDetails = JSON.parse(localStorage.batchDetailsData).viewDetails;
    generalDetails.forEach((item) => {
      if (item.key === "batchStatus") {
        batchStatus = item.value;
      }
    });
    const list = [];
    if ((rejectBatchPermission || rejectInstrumentPermission) &&
      (batchStatus === FccGlobalConstant.PENDINGMYAPPROVAL || batchStatus === FccGlobalConstant.PENDINGMYVERIFICATION)) {
      list.push({
        label: "Reject",
        localizationKey: "Reject",
        name: "reject",
        styleClass: "secondaryButton rejectButton",
        type: "submit",
      });
    }
    if ((approveBatchPermission || approveInstrumentPermission) && batchStatus === FccGlobalConstant.PENDINGMYAPPROVAL) {
      list.push({
        label: "Approve",
        localizationKey: "Approve",
        name: "approve",
        styleClass: "primaryButton approveButton",
        type: "submit",
      });
    }
    if ((scrapBatchPermission || scrapInstrumentPermission) && batchStatus === FccGlobalConstant.PENDINGSEND) {
      list.push({
        label: "Scrap",
        localizationKey: "SCRAP",
        name: "scrap",
        styleClass: "secondaryButton rejectButton",
        type: "submit",
      });
    }
    if ((sendBatchPermission || sendInstrumentPermission) && batchStatus === FccGlobalConstant.PENDINGSEND) {
      list.push({
        label: "Send",
        localizationKey: "SEND",
        name: "send",
        styleClass: "primaryButton approveButton",
        type: "submit",
      });
    }
    if ((verifyBatchPermission || verifyInstrumentPermission) && batchStatus === FccGlobalConstant.PENDINGMYVERIFICATION) {
      list.push({
        label: "Verify",
        localizationKey: "verify",
        name: "verify",
        styleClass: "primaryButton approveButton",
        type: "submit",
      });
    }
    this.buttonList = list;
    return list;
  }
}

export interface FcmBeneficiaryStatusRequest{
  event:string,
  makerRemarks:string,
  checkerRemarks:string
}
