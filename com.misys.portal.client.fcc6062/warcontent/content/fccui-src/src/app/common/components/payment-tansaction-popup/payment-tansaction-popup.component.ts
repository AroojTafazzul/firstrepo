import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { DynamicDialogConfig, DynamicDialogRef, MessageService } from 'primeng';
import { FCCBase } from '../../../base/model/fcc-base';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { CommonService } from '../../services/common.service';

@Component({
  selector: 'app-payment-tansaction-popup',
  templateUrl: './payment-tansaction-popup.component.html',
  styleUrls: ['./payment-tansaction-popup.component.scss']
})
export class PaymentTansactionPopupComponent extends FCCBase implements OnInit {

  textAreaValue = ""
  maxChars = "255"
  rows = 0;
  cols = 0;
  public dialogData: any;
  langDir: string = localStorage.getItem('langDir');
  autoResize = false;
  discardForm: FormGroup;
  paymentDashboardWidget: boolean;
  beneApproveRejectWidget: boolean;
  isConfirmClicked= false;
  constructor(protected fb: FormBuilder, protected injector: Injector, protected commonService: CommonService,
    public translate: TranslateService, public dialogRef: DynamicDialogRef,
    protected dynamicDialogConfig: DynamicDialogConfig, public messageService: MessageService) {
      super();
   }

  ngOnInit(): void {

    this.discardForm = this.fb.group({
      remarks: ['', Validators.required]
  });
  if (this.commonService.paymentWidget) {
    this.paymentDashboardWidget = true;
  }
  this.commonService.paymentWidget = false;

  if(this.commonService.beneApproveRejectWidget) {
    this.beneApproveRejectWidget = true;
    this.commonService.beneApproveRejectWidget = false;
  } else {
    this.beneApproveRejectWidget = false;
  }

  }

  onClickConfirm() {
    this.isConfirmClicked= true;
    if(this.dynamicDialogConfig.data.isBatchPayment.toLowerCase() == 'true'){
    if(this.textAreaValue.length > 0)
    {
     this.commonService.scrapbatchPaymentAction(this.dynamicDialogConfig.data.paymentReferenceNumber,
      FccGlobalConstant.ACTION_DISCARD, this.textAreaValue).subscribe(() => {
     const tosterObj = {
       life : 5000,
       key: 'tc',
       severity: 'success',
       detail: `${this.translate.instant('BatchscrapToasterMEssage', { refNo: this.dynamicDialogConfig.data.paymentReferenceNumber })}`
     };
     this.messageService.add(tosterObj);
     this.commonService.refreshPaymentList.next(true);
     this.dialogRef.close();
   }, () => {
     const tosterObj = {
       life : 5000,
       key: 'tc',
       severity: 'error',
       summary: `${this.translate.instant('error')}`,
       detail: `${this.translate.instant('failedApiErrorMsg')}`
     };
     this.messageService.add(tosterObj);
     this.dialogRef.close();
   });}
    }else {
      if(this.textAreaValue.length > 0)
    {
    this.commonService.performPaymentsApproveRejectFCM(this.dynamicDialogConfig.data.paymentReferenceNumber,
       FccGlobalConstant.ACTION_DISCARD, this.textAreaValue).subscribe(() => {
      const tosterObj = {
        life : 5000,
        key: 'tc',
        severity: 'success',
        detail: `${this.translate.instant('scrapToasterMEssage', { refNo: this.dynamicDialogConfig.data.paymentReferenceNumber })}`
      };
      this.messageService.add(tosterObj);
      this.commonService.refreshPaymentList.next(true);
      this.dialogRef.close();
    }, () => {
      const tosterObj = {
        life : 5000,
        key: 'tc',
        severity: 'error',
        detail: `${this.translate.instant('failedApiErrorMsg')}`
      };
      this.messageService.add(tosterObj);
      this.dialogRef.close();
    });
  }}
  }


  onClickConfirmPaymentsWidget() {
    const data = this.dynamicDialogConfig.data;
    let paymentReferenceList = data.rowData.paymentReferenceList.split(',');
      paymentReferenceList = paymentReferenceList.filter(item => item !==null && item !== '');
      const clientCode = data.rowData.clientCode?data.rowData.clientCode:null;
      const packageName = data.rowData.packageName?data.rowData.packageName:null;
      let action='';
      if(data.action === 'SCRAP'){
        action = 'DISCARD';
      }else{
        action = data.action;
      }
      const request = {
        event: action,
        checkerRemarks:this.textAreaValue?this.textAreaValue:null,
        paymentReferenceNumber: paymentReferenceList
      };
    this.commonService.paymentDashboardAction(request,packageName,clientCode).subscribe(
      () => {
        let successMsg='';
        if('SCRAP' === data.action){
          successMsg = `${this.translate.instant('scrappedToasterMEssage',
        { name: packageName?packageName: clientCode })}`;
        }else{
          successMsg = `${this.translate.instant('rejectToasterMEssage',
        { name: packageName?packageName: clientCode })}`;
        }
        const tosterObj = {
          life : 5000,
          key: 'tc',
          severity: 'success',
          detail: successMsg
        };
        this.messageService.add(tosterObj);
        this.commonService.refreshPaymentWidgetList.next({
          inputParam: data.inputParam,
          selectedRowsData: data.rowData
        });
        this.dialogRef.close();
      }, () => {
        const tosterObj = {
          life : 5000,
          key: 'tc',
          severity: 'error',
          detail: `${this.translate.instant('failedApiErrorMsg')}`
        };
        this.messageService.add(tosterObj);
        this.dialogRef.close();
      });
  }

  onClickCancel() {
    this.dialogRef.close();
  }

  onClickConfirmBeneRejectWidget() {
    this.commonService.beneApproveRejectWidget = true;
    this.commonService.beneApproveRejectWidgetRejectReason = this.textAreaValue;
    this.dialogRef.close();
  }

}
