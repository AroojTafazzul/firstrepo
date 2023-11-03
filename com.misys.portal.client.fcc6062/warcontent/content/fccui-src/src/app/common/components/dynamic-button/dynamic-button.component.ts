import { Component, Injectable, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';

import { FCCBase } from '../../../base/model/fcc-base';
import { CommonService } from '../../../common/services/common.service';
import { FccGlobalConstantService } from '../../core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { FormModelService } from '../../services/form-model.service';
import { ReviewScreenService } from '../../services/review-screen.service';
import { TransactionDetailService } from '../../services/transactionDetail.service';
import { FCCFormGroup } from './../../../base/model/fcc-control.model';
import { EnquiryService } from './../../../corporate/trade/lc/initiation/services/enquiry.service';
import { FormControlService } from './../../../corporate/trade/lc/initiation/services/form-control.service';
import { HOST_COMPONENT } from './../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FccConstants } from './../../core/fcc-constants';

@Component({
  selector: 'fcc-common-dynamic-button',
  templateUrl: './dynamic-button.component.html',
  styleUrls: ['./dynamic-button.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: DynamicButtonComponent }]
})

@Injectable({
  providedIn: 'root'
})


export class DynamicButtonComponent extends FCCBase implements OnInit {

  mode: any;
  user: any;
  status: any;
  items: any;
  widgets: any;
  productCode;
  subProductCode;
  tnxTypeCode;
  tnxStatCode;
  sectionName: any;
  buttons: any;
  header: any;
  componentDetails: any;
  form: FCCFormGroup;
  module = '';
  enquiryButton: any;
  @Input() inputParams: any = [];
  comment: any;
  returnComment: any;
  responseDetails: any;
  action: string;
  itemIdTnx: string;
  eTagVersion: string;

  constructor(protected commonService: CommonService,
              protected translateService: TranslateService,
              protected formModelService: FormModelService,
              protected formControlService: FormControlService,
              protected router: Router,
              public fccGlobalConstantService: FccGlobalConstantService,
              protected enquiryService: EnquiryService,
              protected reviewScreenService: ReviewScreenService,
              protected activatedRoute: ActivatedRoute,
              protected transactionDetailService: TransactionDetailService) {
                super();
              }

  // eslint-disable-next-line @angular-eslint/contextual-lifecycle
  ngOnInit() {
    this.activatedRoute.queryParams.subscribe(params => {
      this.action = params[FccGlobalConstant.ACTION];
      this.subProductCode = params[FccGlobalConstant.SUB_PRODUCT_CODE];
      this.getCommentSection(this.inputParams.fieldData, this.inputParams.pdtCode);
    });
  }

  getReturnComment() {
    if (this.inputParams.pdtCode && this.inputParams.pdtCode !== null && this.inputParams.pdtCode !== '') {
      this.transactionDetailService.fetchTransactionDetails(this.inputParams.tnxId, this.inputParams.pdtCode).subscribe(data => {
        this.handleReturnComments(data.body, this.inputParams.pdtCode);
      });
    }
  }

  protected handleReturnComments(data: any, productCodeValue: any) {
    if (data.return_comments && data.return_comments.text) {
      this.returnComment = data.return_comments.text;
      if (this.form.get(FccGlobalConstant.RETURN_COMMENTS)) {
        this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.RETURN_COMMENTS), this.returnComment,
          { readonly: false });
      }
    }
    this.populateResponseDetails(data, productCodeValue);
    this.eTagVersion = data.version;
  }

  getCommentSection(fields, productCode) {
    this.header = FccGlobalConstant.ENQUIRY_BUTTON_COMMENTS;
    this.buttons = FccGlobalConstant.COMMENT_BUTTONS;
    this.widgets = fields ? fields : '';
    this.productCode = productCode;
    for (const tnxDetails of this.widgets) {
      this.itemIdTnx = tnxDetails[FccGlobalConstant.TRANSACTION_DETAILS] !== undefined ?
                        FccGlobalConstant.TRANSACTION_DETAILS : FccGlobalConstant.DEPOSIT_DETAILS;
      if (tnxDetails[this.itemIdTnx] !== undefined) {
        this.enquiryButton = tnxDetails[this.itemIdTnx][this.header];
        for (const buttonDetails of this.enquiryButton) {
          if (buttonDetails[this.buttons] !== undefined) {
            this.sectionName = buttonDetails[this.buttons];
            break;
          }
        }
      }
    }
    let subProductCodeParam = this.subProductCode;
    if (this.subProductCode === FccConstants.SE_SUB_PRODUCT_CODE_COCQS) {
      subProductCodeParam = FccConstants.SE_SUB_PRODUCT_CODE_CQS;
    }
    const approverPermission = this.commonService.getPermissionName(this.productCode, 'approve', subProductCodeParam);
    this.commonService.getUserPermission(approverPermission).subscribe(result => {
      if (result) {
        this.user = FccGlobalConstant.APPROVER;
        this.initializeFormGroup();
      }
    });
  }

  initializeFormGroup() {
      this.form = this.formControlService.getFormControls(this.sectionName);
      if (this.user === FccGlobalConstant.APPROVER && ( this.action === FccGlobalConstant.APPROVE ||
        this.action === FccGlobalConstant.RETURN)) {
        this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
        this.form.get('return')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
        this.form.get('approve')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
        if (localStorage.getItem('langDir') === FccGlobalConstant.LANUGUAGE_DIR_ARABIC ) {
          const oldStyle = this.form.get('return')[FccGlobalConstant.PARAMS][FccGlobalConstant.STYLECLASS] ;
          this.form.get('return')[FccGlobalConstant.PARAMS][FccGlobalConstant.STYLECLASS] = oldStyle + ' rightDirectArabic';
        } else {
          const oldStyle = this.form.get('return')[FccGlobalConstant.PARAMS][FccGlobalConstant.STYLECLASS] ;
          this.form.get('return')[FccGlobalConstant.PARAMS][FccGlobalConstant.STYLECLASS] = oldStyle + ' floatRight';
        }
        this.getReturnComment();
      }
  }

  onClickReturn(e) {
    this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
    if (this.formValid()) {
      this.comment = this.form.get('comments').value;
      if (this.comment !== null && this.comment.length !== 0 && this.comment.trim().length !== 0) {
        this.enquiryService.returnForm(e, this.inputParams.tnxId, this.comment, this.responseDetails, this.eTagVersion);
        this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.HINT_TEXT_CONTROL] = false;
      } else {
        this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.HINT_TEXT_CONTROL] = true;
      }
    }
  }

  onChangeComments() {
    this.comment = this.form.get('comments').value;
    if (this.comment !== null && this.comment.length !== 0 && this.comment.trim().length !== 0) {
      this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.HINT_TEXT_CONTROL] = false;
    } else {
      this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.HINT_TEXT_CONTROL] = true;
    }
    this.form.updateValueAndValidity();
  }

  onClickApprove(e) {
    this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
    this.form.get('comments')[FccGlobalConstant.PARAMS][FccGlobalConstant.HINT_TEXT_CONTROL] = false;
    this.enquiryService.approveForm(e, this.inputParams.tnxId, this.responseDetails, this.eTagVersion);
  }

  formValid() {
    return this.form.valid;
  }


  populateResponseDetails(data: any, productCodeValue: any) {
    switch (productCodeValue) {
      case FccGlobalConstant.PRODUCT_LC:
      case FccGlobalConstant.PRODUCT_EL:
      case FccGlobalConstant.PRODUCT_SR:
      case FccGlobalConstant.PRODUCT_SI:
      case FccGlobalConstant.PRODUCT_BG:
      case FccGlobalConstant.PRODUCT_BR:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: data.entity,
          amount: data.lc_amt,
          currency: data.lc_cur_code,
          tnxMode: data.adv_send_mode,
          tnxModeText: data.adv_send_mode_text,
          beneName: data.beneficiary_name,
          expDate: data.exp_date,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          subProductCode: this.subProductCode,
          applicantName: data.applicant_name,
          issueDate: data.iss_date,
          bankReference: data.bo_ref_id,
          assigneeName: data.assignee_name,
          transactionAmount: data.tnx_amt,
          expiryType: data.lc_exp_date_type_code,
          secondBeneficiaryName: data.sec_beneficiary_name,
          subTnxTypeCode: data.sub_tnx_type_code,
          companyName: data.company_name
        };
        break;
      case FccGlobalConstant.PRODUCT_IC:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: (data.entity === undefined ) ? data.drawee_name : data.entity,
          amount: data.ic_amt,
          currency: data.ic_cur_code,
          beneName: data.drawer_name,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          subProductCode: this.subProductCode,
          subTnxTypeCode: data.sub_tnx_type_code
        };
        break;
      case FccGlobalConstant.PRODUCT_EC:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: (data.entity === undefined ) ? data.drawer_name : data.entity,
          amount: data.ec_amt,
          currency: data.ec_cur_code,
          beneName: data.drawee_name,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          bankReference: data.bo_ref_id,
          ecTermCode: data.term_code,
          ecTenorType: data.tenor_type,
          subProductCode: this.subProductCode
        };
        break;
      case FccGlobalConstant.PRODUCT_TF:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: (data.entity === undefined ) ? data.applicant_abbv_name : data.entity,
          amount: data.req_amt,
          currency: data.req_cur_code,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          subProductCode: this.subProductCode,
          bankReference: data.bo_ref_id
        };
        break;
      case FccGlobalConstant.PRODUCT_SG:
          this.responseDetails = {
            channelId: data.ref_id,
            entity: (data.entity === undefined ) ? data.applicant_name : data.entity,
            beneName: data.beneficiary_name,
            expDate: data.exp_date,
            tnxType: data.tnx_type_code,
            productCode: productCodeValue,
            amount: data.sg_amt,
            currency: data.sg_cur_code,
            subProductCode: this.subProductCode
          };
          break;
      case FccGlobalConstant.PRODUCT_IR:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: data.entity,
          bankReference : data.bo_ref_id,
          remitterName: data.remitter_name,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          remittanceType : data.ir_type_code,
          currency: data.ir_cur_code,
          remittanceAmount: data.ir_amt,
          subTnxTypeCode: data.sub_tnx_type_code,
          remittanceDate: data.remittance_date
        };
        break;
      case FccGlobalConstant.PRODUCT_FT:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: (data.entity === undefined ) ? data.applicant_abbv_name : data.entity,
          amount: data.ft_amt,
          currency: data.ft_cur_code,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          ftType: data.ft_type,
          orderingCurrency: data.applicant_act_cur_code,
          orderingAccount: data.applicant_act_no,
          transfereeAccount: data.counterparty_act_no,
          executionDate: data.iss_date
        };
        break;
      case FccGlobalConstant.PRODUCT_BG:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: (data.entity === undefined ) ? data.applicant_abbv_name : data.entity,
          amount: data.bg_amt,
          currency: data.bg_cur_code,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          subProductCode: this.subProductCode,
          bgType: data.bg_type,
          orderingCurrency: data.applicant_act_cur_code,
          orderingAccount: data.applicant_act_no,
          transfereeAccount: data.counterparty_act_no,
          executionDate: data.iss_date
        };
        break;
      case FccGlobalConstant.PRODUCT_LI:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: data.entity,
          amount: data.li_amt,
          currency: data.li_cur_code,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          subProductCode: this.subProductCode,
          beneName: data.beneficiary_name,
          applicantName: data.applicant_name,
          expDate: data.exp_date,
          executionDate: data.iss_date,
          subTnxTypeCode: data.sub_tnx_type_code,
          companyName: data.company_name
        };
        break;
      case FccGlobalConstant.PRODUCT_LN:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: data.entity,
          amount: data.ln_amt,
          currency: data.ln_cur_code,
          tnxMode: data.adv_send_mode,
          beneName: data.beneficiary_name,
          expDate: data.exp_date,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          subProductCode: this.subProductCode,
          applicantName: data.applicant_name,
          issueDate: data.iss_date,
          bankReference: data.bo_ref_id,
          assigneeName: data.assignee_name,
          transactionAmount: data.tnx_amt,
          expiryType: data.ln_exp_date_type_code,
          secondBeneficiaryName: data.sec_beneficiary_name,
          subTnxTypeCode: data.sub_tnx_type_code,
          companyName: data.company_name,
          facilityType: this.getFacilityForloan(data)
        };
        break;

      case FccGlobalConstant.PRODUCT_BK:
        switch (this.subProductCode) {
          case FccGlobalConstant.SUB_PRODUCT_LNRPN:
            this.responseDetails = {
              channelId: data.ref_id,
              entity: data.entity,
              amount: data.bk_total_amt,
              currency: data.bk_cur_code,
              tnxType: data.tnx_type_code,
              productCode: productCodeValue,
              subProductCode: this.subProductCode,
              bankReference: data.bo_ref_id,
              transactionAmount: data.tnx_amt,
              subTnxTypeCode: data.sub_tnx_type_code,
              companyName: data.company_name,
              facilityType: this.getFacilityForloan(data)
            };
            break;
          case FccGlobalConstant.SUB_PRODUCT_BLFP:
            this.responseDetails = {
              channelId: data.ref_id,
              entity: data.entity,
              amount: data.bk_total_amt,
              currency: data.bk_cur_code,
              tnxType: data.tnx_type_code,
              productCode: productCodeValue,
              subProductCode: this.subProductCode,
              bankReference: data.bo_ref_id,
              transactionAmount: data.tnx_amt,
              subTnxTypeCode: data.sub_tnx_type_code,
              companyName: data.company_name
            };
            break;
          default:
            break;
        }
        break;
      case FccGlobalConstant.PRODUCT_TD:
        this.responseDetails = {
          channelId: data.ref_id,
          entity: data.entity,
          tnxType: data.tnx_type_code,
          productCode: productCodeValue,
          subProductCode: this.subProductCode,
          bankReference: data.bo_ref_id,
          transactionAmount: data.td_amt,
          withdrawalAmount: data.tnx_amt,
          subTnxTypeCode: data.sub_tnx_type_code,
          companyName: data.company_name,
          orderingAccount: data.applicant_act_no,
          additionalFields: data.additionalFields,
          depositType: data.td_type,
          currency: data.td_cur_code,
          issuingBankName: data.issuing_bank.name,
          maturitydate: data.maturity_date
        };
        break;
      case FccGlobalConstant.PRODUCT_SE:
        this.responseDetails = {
            channelId: data.ref_id,
            entity: data.entity,
            tnxType: data.tnx_type_code,
            productCode: productCodeValue,
            subProductCode: this.subProductCode,
            bankReference: data.bo_ref_id,
            subTnxTypeCode: data.sub_tnx_type_code,
            companyName: data.company_name,
            orderingAccount: data.applicant_act_no,
            deliveryMode: this.deliveryMode(data),
            issuingBankName: data.issuing_bank.name,
            additionalFields: data.additionalFields
        };
        break;
      default:
        break;
    }
  }

  deliveryMode(data: any){
    let deliveryMode;
    if (data.additionalFields !== undefined){
      const additionalFields = data.additionalFields;
      additionalFields.forEach(element => {
        if (element.name === 'adv_send_mode'){
          deliveryMode = element.value;
        }
      });
    }

    return deliveryMode;
  }

getFacilityForloan(data: any){
  let facilityType;
  if (data.additionalFields !== undefined){
    const additionalFields = data.additionalFields;
    additionalFields.forEach(element => {
      if (element.name === 'facility_type'){
        facilityType = element.value;
      }
    });
  }

  return facilityType;
}


}
