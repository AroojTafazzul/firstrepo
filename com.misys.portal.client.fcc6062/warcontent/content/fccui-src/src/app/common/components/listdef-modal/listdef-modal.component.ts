import { Component, ElementRef, Injector, ViewChild, EventEmitter, AfterViewInit, Output } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { FccGlobalConstantService } from '../../core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { Router } from '@angular/router';
import { CommonService } from '../../services/common.service';
import { ListDataDownloadService } from '../../services/list-data-download.service';
import {
  ConfirmationDialogComponent
} from '../../../../app/corporate/trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { DialogService } from 'primeng/dynamicdialog';
import { MessageService } from 'primeng';
import { FccConstants } from '../../core/fcc-constants';
import { ResolverService } from '../../services/resolver.service';

@Component({
  selector: 'app-listdef-modal',
  templateUrl: './listdef-modal.component.html',
  styleUrls: ['./listdef-modal.component.scss']
})

export class ListdefModalComponent implements AfterViewInit {

  public dialogData: any;
  public displayData: any;
  public rowConfig: any;
  public actionValue: any;
  public dir: string;
  public actions: any;
  public colorCode: any;
  public commentField: any = null;
  public displayKeys: any = [];
  public maxCommentLn: number;
  public comment: string;
  public dialogRef = null;
  public status = null;
  public fileName = null;
  repairRejectFooter = false;
  showRepairReject = false;
  uploadReferenceNumber = null;
  downloadReport = FccGlobalConstant.DONWLOAD_PAYMENT_EXCEL;
  repairReject = FccGlobalConstant.PAYMENT_REPAIR_REJECT;
  public routeOptions;
  public cols: any[];
  public colHeaders: any[];
  public colData : any[]
  public option;
  public category;
  rejectedCount: number;
  @ViewChild('input') public inputComment: ElementRef;
  public inputElement:ElementRef;
  isCommentInvalid=false;
  commentValue:string;
  beneUpload = false;
  failureCount: number;
  public refreshTableDataEvent:EventEmitter<any> = new EventEmitter<any>();
  currencySymbolDisplayEnabled = false;

  @Output()
  refreshList: EventEmitter<any> = new EventEmitter<any>();
  enrichTableDisplay = false;
  enrichColCode = false;
  enrchMap = {};
  enrichCols = [];
  enrichTableValues = [];
  accountCols = [];
  accountTableValues = [];
  accountTableDisplay = false;
  constructor(protected injector: Injector, public translate: TranslateService,
    protected fccGlobalConstantService:FccGlobalConstantService,
    protected dialogService: DialogService,
    protected messageService: MessageService,
    protected commonService:CommonService, protected router: Router,
    protected corporateCommonService: CommonService, protected listDataDownloadService: ListDataDownloadService,
    public activatedRoute: ActivatedRoute, protected resolverService: ResolverService) {
    this.maxCommentLn = 250;
    this.dialogRef = this.injector.get(MatDialogRef, null);
    this.dialogData = this.injector.get(MAT_DIALOG_DATA, null);
    this.dir = localStorage.getItem(FccGlobalConstant.LANG_DIR);
    this.currencySymbolDisplayEnabled = localStorage.getItem(FccGlobalConstant.CUR_SYMBOL_ENABLED) === 'y' ? true : false;
    if (this.dialogData) {
      Object.keys(this.dialogData.data).forEach(k => {
        if (k !== 'beneAccountCurrency' && !this.commonService.isEmptyValue(this.dialogData.data[k])){
          this.displayKeys.push(k);
        }
      });

      if (this.displayKeys.indexOf(FccGlobalConstant.BENE_ACCOUNT_DATA) > -1) {
        this.accountTableDisplay = true;
        this.dialogData[FccGlobalConstant.TABLE_DATA][FccGlobalConstant.BENE_ACCOUNT_DATA].forEach((ele,index) => { 
          const accountObj = {};
          ele.isDefaultAccount = ele.isDefaultAccount === true? FccGlobalConstant.YES: FccGlobalConstant.NO;
          accountObj[FccGlobalConstant.BENE_ACCOUNT_COLUMNS[0]] = index+1;
          accountObj[FccGlobalConstant.BENE_ACCOUNT_COLUMNS[1]] = ele.isDefaultAccount;
          accountObj[FccGlobalConstant.BENE_ACCOUNT_COLUMNS[2]] = ele.account.type;
          accountObj[FccGlobalConstant.BENE_ACCOUNT_COLUMNS[3]] = ele.account.id.other.id;
          accountObj[FccGlobalConstant.BENE_ACCOUNT_COLUMNS[4]] = FccGlobalConstant.PAYMENT_TYPE_MAPPING[ele.paymentType];
          accountObj[FccGlobalConstant.BENE_ACCOUNT_COLUMNS[5]] = ele.benificiaryBank.otherId;
          this.accountTableValues.push(accountObj);
        });
        this.accountCols = FccGlobalConstant.BENE_ACCOUNT_COLUMNS;
        delete this.displayKeys[this.displayKeys.indexOf(FccGlobalConstant.BENE_ACCOUNT_DATA)];
      }
      if (this.displayKeys.indexOf('enrichmentListTable') > -1 && this.dialogData["data"]["enrichmentListTable"].length) {
        this.enrichTableDisplay = true;
        this.enrichCols = this.commonService.getEnrichmentDetails(999);
        this.enrichCols?.forEach((col) => {
          delete this.displayKeys[this.displayKeys?.indexOf(col)];
        });
        this.dialogData["data"]["enrichmentListTable"].forEach((ele) => {
          this.enrichTableValues.push(ele);
        });
      }
      delete this.displayKeys[this.displayKeys.indexOf('enrichmentListTable')];
      if (this.displayKeys.indexOf(FccConstants.ENRICHMENT_LIST_DATA) > -1 &&
       this.dialogData.data.enrichmentListData) {
        this.enrichColCode = true;
        let filterParams: any = {};
        filterParams.packageCode = this.dialogData[FccConstants.DATA][FccConstants.FCM_PAYMENT_PACKAGES];
        filterParams.clientCode = this.dialogData[FccConstants.DATA][FccConstants.FCM_CLIENT_CODE_DETAILS];
        filterParams = JSON.stringify(filterParams);
        if (this.dialogData.data.enrichmentListData?.multiSet.length > 0) {
          this.enrichTableDisplay = true;
          this.commonService.getExternalStaticDataList(FccConstants.FCM_ENRICHMENT_BY_PACKAGE, filterParams).subscribe(response => {
            const enrichColumns = [];
            Object.keys(response).forEach((key) => {
              enrichColumns.push(response[key].code);
            });
            this.enrichTableValues = this.dialogData?.data?.enrichmentListData?.multiSet;
            Object.keys(response).forEach(key => {
              enrichColumns.forEach((ele) => {
                if (response[key].code === ele) {
                  this.enrichCols.push(key);
                  this.enrchMap[key] = response[key];
                }
              });
            });
          });
        } else if (this.dialogData.data.enrichmentListData?.singleSet) {
          this.enrichTableDisplay = true;
          this.commonService.getExternalStaticDataList(FccConstants.FCM_ENRICHMENT_BY_PACKAGE, filterParams).subscribe(response => {
            const enrichColumns = [];
            Object.keys(response).forEach((key) => {
              enrichColumns.push(response[key].code);
            });
            this.enrichTableValues.push(this.dialogData?.data?.enrichmentListData?.singleSet);
            Object.keys(response).forEach(key => {
              enrichColumns.forEach((ele) => {
                if (response[key].code === ele) {
                  this.enrichCols.push(key);
                  this.enrchMap[key] = response[key];
                }
              });
            });
          });
        }
        delete this.displayKeys[this.displayKeys.indexOf(FccConstants.ENRICHMENT_LIST_DATA)];
      }

      this.displayKeys.forEach((param: string, i: any) => {
        if (param === FccGlobalConstant.BENE_STATUS) {
          this.displayKeys.splice(i, 1);
        }
      });
      this.displayData = this.dialogData.data;
      const beneCurrency = this.displayData['beneAccountCurrency'];
      const beneAmtVal = this.displayData['limitOnAmount'];
      delete this.displayData.beneAccountCurrency;
      const amtVal = this.displayData[FccGlobalConstant.AMOUNT_FIELD];
      const curCode = this.displayData[FccGlobalConstant.CURRENCY];
      if (this.currencySymbolDisplayEnabled) {
        if (this.commonService.isNonEmptyValue(curCode) && this.commonService.isNonEmptyValue(amtVal)) {
          this.displayData[FccGlobalConstant.AMOUNT_FIELD] = this.commonService.getCurrencySymbol(curCode, amtVal);
        }
        if (this.commonService.isNonEmptyValue(beneCurrency) && this.commonService.isNonEmptyValue(beneAmtVal)) {
          this.displayData['limitOnAmount'] = this.commonService.getCurrencySymbol(beneCurrency, beneAmtVal);
        }
      }
      this.rowConfig = this.dialogData.rowData;
      this.activatedRoute.queryParams.subscribe((params) => {
        this.routeOptions = params && params.option ? params.option : '';
      });
      switch(this.routeOptions) {
        case FccGlobalConstant.BENEFICIARY_MASTER_MAINTENANCE_MC :
          this.status = this.rowConfig[ FccGlobalConstant.BANK_BENE_STATUS];
          break;
        case FccGlobalConstant.PAYMENTS :
          this.status = this.rowConfig[ FccGlobalConstant.PAYMENTS_STATUS];
          break;
      }
      if (this.dialogData && this.dialogData.actionResponse && this.dialogData.actionResponse.actionList) {
      this.actions = this.dialogData.actionResponse.actionList;
      }
      this.colorCode = this.rowConfig[FccGlobalConstant.BENE_STATUS_COLOR_CODE];
      if (this.dialogData.repairReject) {
        this.showRepairReject = this.dialogData.repairReject;
        }
      if (this.dialogData.beneUpload) {
        this.beneUpload = this.dialogData.beneUpload;
      }

      if(this.dialogData.failureCount) {
        this.failureCount = this.dialogData.failureCount;
      }
        // remove this when repair/reject impl is done
        this.showRepairReject = false;
        if (this.dialogData.repairRejectFooter) {
          this.fileName = this.rowConfig.fileName;
        this.repairRejectFooter = this.dialogData.repairRejectFooter;
        this.getPaymentBulkRepairRejectTableData();
        }
        if (this.dialogData.uploadReferenceNumber) {
        this. uploadReferenceNumber = this.dialogData.uploadReferenceNumber;
        }
        if (this.dialogData.actionResponse ) {
          this.repairRejectFooter = false;
      if(this.actions){
        this.actions.forEach((action: { actionType: string; }, index: any) => {
          if (action.actionType === FccGlobalConstant.INPUT_TYPE) {
            this.commentField = action;
            this.actions.splice(index, 1);
          }
        });
      }
    }
    }
    }
  ngAfterViewInit(): void {
    this.inputElement=this.inputComment;
  }

  checkAmtField(col){
    const langDir = localStorage.getItem('langDir');
    if (Object.keys(this.enrchMap)?.length > 0) {
      if(this.enrchMap[col]?.dataType === "A"){
        return langDir == 'ltr' ? true : false;
      }
    }
    return langDir == 'ltr' ? false : true;
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  close(event: KeyboardEvent): void {
    this.dialogRef.close(true);
  }

  onClickAction(action: any) {
    let successMsg: string, errMsg: string;

    this.actionValue = action;
    this.activatedRoute.queryParams.subscribe((params) => {
      this.option = params && params.option ? params.option : '';
      this.category = params && params.category ? params.category : '';
    });

    const comment: string = this.inputElement?.nativeElement.value;

    switch (action) {
      case 'CANCEL':
        this.dialogRef.close(true);
        break;
      case FccGlobalConstant.ACTION_APPROVE:
        successMsg = FccGlobalConstant.SINGLE_TXN_MESSAGES.APPROVE_SUCCESS;
        errMsg = FccGlobalConstant.SINGLE_TXN_MESSAGES.APPROVE_FAILED;
        this.approveRjectAction(action, comment, successMsg, errMsg);
        break;
      case FccGlobalConstant.ACTION_REJECT:
        successMsg = FccGlobalConstant.SINGLE_TXN_MESSAGES.REJECT_SUCCESS;
        errMsg = FccGlobalConstant.SINGLE_TXN_MESSAGES.REJECT_FAILED;
        this.approveRjectAction(action, comment, successMsg, errMsg);
        break;
      case FccGlobalConstant.ACTION_EDIT:
        this.dialogRef.close(true);
        this.editBene();
        break;
      case FccGlobalConstant.ACTION_MAKE_PAYMENT:
        this.router.navigateByUrl('/commonProductScreen?option=PAYMENTS&operation=ADD_FEATURES&category=FCM');
        this.dialogRef.close(true);
        break;
      case FccGlobalConstant.SUSPEND:
        this.dialogRef.close(true);
        this.beneficiaryStatus(this.rowConfig, FccGlobalConstant.SUSPEND,
          'fcmBeneSuspend', 'fcmBeneNotSuspend', 'fcmBeneSuspendConfirmation');
        break;
      case FccGlobalConstant.ENABLE:
        this.dialogRef.close(true);
        this.beneficiaryStatus(this.rowConfig, FccGlobalConstant.ENABLE,
          'fcmBeneActivate', 'fcmBeneNotActivate', 'fcmBeneActivateConfirmation');
        break;

    }
  }

  approveRjectAction(action: string, comment: any, successMsg: any, errMsg: any){
    // Approve/Reject on bene Listing screen
    if (this.option === FccGlobalConstant.BENEFICIARY_MASTER_MAINTENANCE_MC && this.category == FccGlobalConstant.FCM.toUpperCase()) {
      const beneficiaryName: string = this.dialogData?.rowData[FccGlobalConstant.BENEFICIARY_NAME];
      const beneficiaryId: string = this.dialogData?.rowData[FccGlobalConstant.BENEFICIARY_ID];
      const associationId: string = this.dialogData?.rowData[FccGlobalConstant.associationIdKey];
      if ((action == FccGlobalConstant.ACTION_APPROVE) || (action == FccGlobalConstant.ACTION_REJECT
        && this.isNonEmpty(this.commentValue))) {
        this.isCommentInvalid = false;
        this.doBeneficiarySingleApprRejectFCM(associationId, action, comment, beneficiaryName, successMsg, beneficiaryId);
      } else {
        this.isCommentInvalid = true;
      }
    } // Approve/Reject on Payment Listing screen
    else if (this.option === FccGlobalConstant.PAYMENTS && this.category == FccGlobalConstant.FCM.toUpperCase()) {
      if (action == FccGlobalConstant.ACTION_APPROVE) {
        successMsg = FccGlobalConstant.SINGLE_PAYMENT_TXN_MESSAGES.APPROVE_SUCCESS;
        errMsg = FccGlobalConstant.SINGLE_PAYMENT_TXN_MESSAGES.APPROVE_FAILED;
      } else if (action == FccGlobalConstant.ACTION_REJECT) {
        successMsg = FccGlobalConstant.SINGLE_PAYMENT_TXN_MESSAGES.REJECT_SUCCESS;
        errMsg = FccGlobalConstant.SINGLE_PAYMENT_TXN_MESSAGES.REJECT_FAILED;
      }
      const paymentReferenceNumber: string = this.dialogData?.rowData[FccGlobalConstant.PAYMENT_REFERENCE_NUMBER];
      if ((action == FccGlobalConstant.ACTION_APPROVE) || (action == FccGlobalConstant.ACTION_REJECT
        && this.isNonEmpty(this.commentValue))) {
        this.isCommentInvalid = false;
        this.doPaymentsSingleApproveRejectFCM(paymentReferenceNumber, action, comment, successMsg, errMsg);
      } else {
        this.isCommentInvalid = true;
      }
    }
    // Approve/Reject on Batch Details screen
    else if (this.dialogData?.heading === this.translate.instant('instrumentDetail')) {
      if (action == FccGlobalConstant.ACTION_APPROVE) {
        successMsg = 'PAYMENTS_MULTI_APPROVAL_SUCCESS_MSG';
        errMsg = 'PAYMENTS_MULTI_APPROVAL_FAILURE_MSG';
      } else if (action == FccGlobalConstant.ACTION_REJECT) {
        successMsg = 'PAYMENTS_MULTI_REJECT_SUCCESS_MSG';
        errMsg = 'PAYMENTS_MULTI_REJECT_FAILURE_MSG';
      }
      const paymentReferenceNumber: string = this.dialogData?.data[FccGlobalConstant.PAYMENT_REFERENCE_NUMBER];
      const istrumentReferenceNumber: string = this.dialogData?.rowData[FccGlobalConstant.INSTRUMENT_REFERENCE_NUMBER];
      if (action == FccGlobalConstant.ACTION_APPROVE) {
        this.doPaymentInstrumentApproveFCM(paymentReferenceNumber, istrumentReferenceNumber, action, successMsg, errMsg);
      } else if ((action == FccGlobalConstant.ACTION_REJECT && this.isNonEmpty(this.commentValue))){
        this.isCommentInvalid = false;
        this.doPaymentInstrumentRejectFCM(paymentReferenceNumber, istrumentReferenceNumber, action, comment, successMsg, errMsg);
        }else {
        this.isCommentInvalid = true;
      }
    }
  }
  doBeneficiarySingleApprRejectFCM(associationId, action, comment, beneficiaryNameVal, successMsg, beneficiaryId) {


    this.commonService.approveReject(associationId, action, comment, beneficiaryId)
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      .subscribe(_res => {
        this.refreshTableDataEvent.emit();
        this.commonService.showToasterMessage({
          life: 5000,
          key: 'tc',
          severity: 'success',
          summary: 'Done',
          detail: this.translate.instant(successMsg, { beneficiaryName: beneficiaryNameVal })
        });
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
      }, _err => {
        this.refreshTableDataEvent.emit();
        let errMsg = '';
        try {
          errMsg = this.dialogData?.rowData[FccGlobalConstant.associationIdKey] + ` ${this.translate.instant(_err.error.errors[0].code)}`;
        } catch (err) {
          errMsg = this.translate.instant('failedApiErrorMsg');
        }
        this.commonService.showToasterMessage({
          life: 5000,
          key: 'tc',
          severity: 'error',
          summary: 'Error',
          detail: errMsg
        });
      });
      this.dialogRef.close(true);
  }


  getButtonClass(buttonClass: any, index: any): any{
    if(FccGlobalConstant.PRIMARY_BUTTON_CLASS === buttonClass && index === (this.actions.length -1)){
      return FccGlobalConstant.PRIMARY_BUTTON_CLASS;
    }
    return FccGlobalConstant.TERTIARY_BUTTON_CLASS;
  }

  onClickRejectRepair() {
    this.commonService.setActiveTab = false;
    this.dialogRef.close(true);
    this.commonService.setActiveTab = true;
    this.commonService.setActiveTabIndex = 1;

    this.router.navigateByUrl('/productListing?option=PAYMENTS&category=FCM');
  }

  onClickDownloadBeneficiaryBulkUploadStatus() {
    let totalCount = 0;
    let rejected = 0;
    let success = 0;
    const headers = [];
    const data = [];
    let tableHeader = '';
    if (this.fileName) {
      tableHeader = this.translate.instant(FccGlobalConstant.PAYMENT_BACTH_FILR) + ' - ' + this.fileName;
    } else {
      tableHeader = this.translate.instant(FccGlobalConstant.PAYMENT_BACTH_FILR);
    }
    const remarksHeader = [];
    const remarksData = [];
    let setRemarks = false;
    this.corporateCommonService.getBeneBulkUploadDetailsOfRefNo(this.uploadReferenceNumber).subscribe(result => {
      if(result) {
        headers.push(this.translate.instant(FccGlobalConstant.PAYMENT_TOTAL_COUNT));
        headers.push(this.translate.instant(FccGlobalConstant.PAYMENT_SUCCESS_COUNT));
        headers.push(this.translate.instant(FccGlobalConstant.PAYMENT_FAILURE_COUNT));

        totalCount = result.data.files[0].totalCount;
        rejected = result.data.files[0].rejectedCount;
        success = totalCount - rejected;

        data.push(totalCount);
        data.push(success);
        data.push(rejected);


        if(result.data.files[0].remarks) {
          setRemarks = true;
          remarksHeader.push(this.translate.instant(FccGlobalConstant.PAYMENT_RECORD_COUNT));
          remarksHeader.push(this.translate.instant(FccGlobalConstant.PAYMENT_RECORD_REMARK));

          result.data.files[0].remarks.forEach(data => {
            const dataArr = [];
            dataArr.push(data.recordnumber);
            dataArr.push(data.rejectReason);
            remarksData.push(dataArr);
          });
        }

        this.listDataDownloadService.createBulkPaymentExcel(tableHeader, headers, data, remarksHeader, remarksData, setRemarks);
      }
    });
        this.dialogRef.close(true);
  }

  onClickDownloadBulkUploadStatus() {
    let totalCount = 0;
    let rejected = 0;
    let success = 0;
    const headers = [];
    const data = [];
    let tableHeader = '';
    if (this.fileName) {
      tableHeader = this.translate.instant(FccGlobalConstant.PAYMENT_BACTH_FILR) + ' - ' + this.fileName;
    } else {
      tableHeader = this.translate.instant(FccGlobalConstant.PAYMENT_BACTH_FILR);
    }
    const remarksHeader = [];
    const remarksData = [];
    let setRemarks = false;
    this.corporateCommonService.getPaymentBulkUploadDetailsOfRefNo(this.uploadReferenceNumber).subscribe(result => {
      if(result) {
        headers.push(this.translate.instant(FccGlobalConstant.PAYMENT_TOTAL_COUNT));
        headers.push(this.translate.instant(FccGlobalConstant.PAYMENT_SUCCESS_COUNT));
        headers.push(this.translate.instant(FccGlobalConstant.PAYMENT_FAILURE_COUNT));

        totalCount = result.data.files[0].totalCount;
        rejected = result.data.files[0].rejectedCount;
        success = totalCount - rejected;
        data.push(totalCount);
        data.push(success);
        data.push(rejected);

        if(result.data.files[0].remarks) {
          setRemarks = true;
          remarksHeader.push(this.translate.instant(FccGlobalConstant.PAYMENT_RECORD_COUNT));
          remarksHeader.push(this.translate.instant(FccGlobalConstant.PAYMENT_RECORD_REMARK));

          result.data.files[0].remarks.forEach(data => {
            const dataArr = [];
            dataArr.push(data.recordnumber);
            dataArr.push(data.rejectReason);
            remarksData.push(dataArr);
          });
        }

        this.listDataDownloadService.createBulkPaymentExcel(tableHeader, headers, data, remarksHeader, remarksData, setRemarks);
      }
    });
        this.dialogRef.close(true);

  }

  getPaymentBulkRepairRejectTableData() {
    this.cols = [];
    this.colData = [];

    for (const key of Object.keys(this.displayData))
    {
      const obj = { };
     obj['field'] = key;
     obj['header'] = key;
     this.cols.push( { ...obj } );
    }

    this.colData = [ { ...this.displayData } ];

  }

  doPaymentInstrumentApproveFCM(paymentReferenceNumber, instrumentPaymentReference, action, successMsg, errorMsg){
    this.commonService.paymentInstrumentApproveFCM(paymentReferenceNumber, action, 
      instrumentPaymentReference, '')
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      .subscribe(_res=>
      {
      this.commonService.showToasterMessage({
        life : 5000,
        key: 'tc',
        severity: 'success',
        summary: this.translate.instant('done'),
        detail: this.translate.instant(successMsg)
      });
      this.commonService.refreshTable.next(true);
      this.resolverService.updateBatchStatus(paymentReferenceNumber);
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
    }, _err => {
      let errorMessage = '';
        if (_err.status !== FccGlobalConstant.HTTP_RESPONSE_BAD_REQUEST){
          errorMessage = 'failedApiErrorMsg';
        } else {
          errorMessage = errorMsg;
        }
        this.commonService.showToasterMessage({
          life : 5000,
          key: 'tc',
          severity: 'error',
          summary:this.translate.instant('error'),
          detail:this.translate.instant(errorMessage)
        });
      });   
    this.dialogRef.close(true);
  }
  

  doPaymentInstrumentRejectFCM(paymentReferenceNumber, instrumentPaymentReference, action, comment, successMsg, errorMsg){
    this.commonService.paymentInstrumentRejectFCM(paymentReferenceNumber, action, 
      instrumentPaymentReference,comment)
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      .subscribe(_res=>
      {
      this.commonService.showToasterMessage({
        life : 5000,
        key: 'tc',
        severity: 'success',
        summary: this.translate.instant('done'),
        detail: this.translate.instant(successMsg)
      });
      this.commonService.refreshTable.next(true);
      this.resolverService.updateBatchStatus(paymentReferenceNumber);
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
    }, _err => {
      let errorMessage = '';
        if (_err.status !== FccGlobalConstant.HTTP_RESPONSE_BAD_REQUEST){
          errorMessage = 'failedApiErrorMsg';
        } else {
          errorMessage = errorMsg;
        }
        this.commonService.showToasterMessage({
          life : 5000,
          key: 'tc',
          severity: 'error',
          summary:this.translate.instant('error'),
          detail:this.translate.instant(errorMessage)
        });
      });   
    this.dialogRef.close(true);

  }
  
  doPaymentsSingleApproveRejectFCM(paymentReferenceNumber, action, comment, successMsg, errorMsg) {
      this.commonService.paymentsApproveReject(paymentReferenceNumber, action, comment)
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      .subscribe(_res => {
        this.commonService.showToasterMessage({
          life: 5000,
          key: 'tc',
          severity: 'success',
          summary: 'Done',
          detail: this.translate.instant(successMsg, { paymentReferenceNumber: paymentReferenceNumber })
        });
        this.commonService.refreshPaymentList.next(true);
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
      }, _err => {
        let errMsg = '';
        try {
          errMsg = _err.error.errors[0].description;
        } catch (err) {
          errMsg = errorMsg;
        }
        this.commonService.showToasterMessage({
          life: 5000,
          key: 'tc',
          severity: 'error',
          summary: 'Error',
          detail: this.translate.instant(errMsg, { paymentReferenceNumber: paymentReferenceNumber })
        });
      });
      this.dialogRef.close(true);
  }

  isNonEmpty(text:string){
    return (null!=text&&undefined!=text&&text!=='');
  }

  beneficiaryStatus(rowdata, status, successToasterMsg, errorToasterMsg, popUpMessage){
    const headerField = `${this.translate.instant('confirmation')}`;
    const message = `${this.translate.instant(popUpMessage)}`;
    let associationId = '';
    if (rowdata[FccGlobalConstant.ASSOCIATION_ID])
    {
      associationId = rowdata[FccGlobalConstant.ASSOCIATION_ID];
    }
    else{
      associationId = rowdata[FccGlobalConstant.STATIC_ASSOCIATION_ID];
    }
    let beneficiaryId = '';
    if (rowdata[FccGlobalConstant.BENEFICIARY_ID])
    {
      beneficiaryId = rowdata[FccGlobalConstant.BENEFICIARY_ID];
    }

    if (status === FccGlobalConstant.SUSPEND) {
    this.commonService.setActiveTab = true;
    this.commonService.setActiveTabIndex = 1;
    }
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const direction = 'direction';
    const dir = localStorage.getItem('langDir');
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      header: headerField,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir },
      data: { locaKey: message }
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === 'yes') {
        let beneName = null;
           if(rowdata[FccGlobalConstant.BENEFICIARY_NAME]){
            beneName = rowdata[FccGlobalConstant.BENEFICIARY_NAME];
           }else{
             beneName = rowdata[FccGlobalConstant.BENEFICIARIES_NAME];
           }
        this.commonService.beneficiaryStatus(associationId, status,beneficiaryId).subscribe(response => {
         if (response.status == 200) {

            const tosterObj = {
              life : 5000,
              key: 'tc',
              severity: 'success',
              detail: beneName + ` ${this.translate.instant(successToasterMsg)}`
            };
            this.messageService.add(tosterObj);
            setTimeout(() => {
              //eslint : no-empty-function
            }, FccGlobalConstant.LENGTH_2000);
            this.refreshList.emit();
         }
        },(response) =>{
          const tosterObj = {
            life : 5000,
            key: 'tc',
            severity: 'error',
            detail: this.translate.instant(response.error.errors[0].code)
          };
          this.messageService.add(tosterObj);
          setTimeout(() => {
            //eslint : no-empty-function
          }, FccGlobalConstant.LENGTH_2000);
        });
      }
    });
  }

  formatAmount(amount){
    return this.commonService.getCurrencyFormatedAmountForPreview(FccConstants.FCM_ISO_CODE, amount);
  }
  editBene(){
    const actionJson = JSON.parse(this.rowConfig.action.match(/\[(.*?)\]/)[0]);

    if (actionJson.length > 0) {
      actionJson.forEach(element => {
        if (element.actionName === FccGlobalConstant.ACTION_EDIT_BENEFICIARY) {
          const url = element.urlLink;
          const urlType = element.urlType ? element.urlType : '';
          const urlScreenType = element.urlScreenType ? element.urlScreenType : '';


        if (urlType === FccGlobalConstant.INTERNAL && this.commonService.isNonEmptyValue(urlScreenType)
            && urlScreenType !== '') {
              const urlScreenTypeString = urlScreenType as string;
              if (urlScreenTypeString.toUpperCase() === FccGlobalConstant.ANGULAR_UPPER_CASE) {
                this.commonService.setSummaryDetails(this.rowConfig);
                // eslint-disable-next-line @typescript-eslint/no-unused-vars
                this.router.navigate([]).then(result => {
                  window.open(url, FccGlobalConstant.SELF);
                });
              } else {
                const urlContext = this.commonService.getContextPath();
                const dojoUrl = urlContext + this.fccGlobalConstantService.servletName + url;
                window.open(dojoUrl, FccGlobalConstant.SELF);
              }
            }
        }
        });
    }
  }
}
