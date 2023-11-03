import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { MessageService } from 'primeng';
import { DialogService } from 'primeng/dynamicdialog';
import { Observable } from 'rxjs';

import {
  ConfirmationDialogComponent,
} from '../../../app/corporate/trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { ScreenMapping } from '../model/screen-mapping';
import { FccGlobalConstantService } from './../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../common/core/fcc-global-constants';
import { CommonService } from './../../common/services/common.service';
import { ReauthService } from './../../common/services/reauth.service';
import { TransactionDetailService } from './../../common/services/transactionDetail.service';

@Injectable({
  providedIn: 'root'
})
export class TableService {

  constructor(protected router: Router, protected translate: TranslateService,
              protected dialogService: DialogService , protected commonService: CommonService,
              protected messageService: MessageService, protected fccGlobalConstantService: FccGlobalConstantService,
              protected reauthService: ReauthService, protected transactionDetailService: TransactionDetailService) {
  }
  deleterowstatus =  false;
  contextPath: any;

  onClickCorrespondence(event, rowData) {
    const tnxType = FccGlobalConstant.N002_INQUIRE;
    const optionValue = FccGlobalConstant.EXISTING_OPTION;
    const subTnxTypeCodeValue = FccGlobalConstant.N003_CORRESPONDENCE;
    this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
    productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
    tnxTypeCode: tnxType, option: optionValue, subTnxTypeCode: subTnxTypeCodeValue} });
  }

  onClickAssignment(event, rowData, option) {
    if (option === FccGlobalConstant.GENERAL) {
      this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
        productCode: rowData.product_code,
        tnxTypeCode: FccGlobalConstant.N002_INQUIRE, option: FccGlobalConstant.OPTION_ASSIGNEE } });
    }
  }

  onClickTDUpdate(event, rowData, option) {
    this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: {
      productCode: FccGlobalConstant.PRODUCT_TD, subProductCode: FccGlobalConstant.SUB_PRODUCT_CODE_CSTD,
      tnxTypeCode: FccGlobalConstant.EC_AMEND_TERMS, accountId: rowData.account_id,
      entity_abbv_name: rowData[FccGlobalConstant.ACCOUNT_ENTITY], option: FccGlobalConstant.EXISTING } });
  }

  onClickTDWithDraw(event, rowData, option) {
    this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: {
      productCode: FccGlobalConstant.PRODUCT_TD, subProductCode: FccGlobalConstant.SUB_PRODUCT_CODE_CSTD,
      tnxTypeCode: FccGlobalConstant.N002_INQUIRE, accountId: rowData.account_id,
      entity_abbv_name: rowData[FccGlobalConstant.ACCOUNT_ENTITY], option: FccGlobalConstant.EXISTING } });
  }

  onClickRemittanceLetter(event, rowData, option) {
    if (option === FccGlobalConstant.GENERAL) {
      const subTnxTypeCodeValue = FccGlobalConstant.N003_REMITTANCE_LETTER_GENERATION;
      this.router.navigate(['productScreen'], { queryParams: { refId: rowData.ref_id,
        productCode: rowData.product_code,
        tnxTypeCode: FccGlobalConstant.N002_INQUIRE, subTnxTypeCode: subTnxTypeCodeValue } });
    }
  }

  onClickTransfer(event, rowData, option) {
    if (option === FccGlobalConstant.GENERAL) {
      this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
        productCode: rowData.product_code,
        tnxTypeCode: FccGlobalConstant.N002_INQUIRE, option: FccGlobalConstant.OPTION_TRANSFER } });
    }
  }

  onClickRequestSettlement(event, rowData) {
    const tnxType = FccGlobalConstant.N002_INQUIRE;
    const optionValue = FccGlobalConstant.EXISTING_OPTION;
    const subTnxTypeCodeValue = FccGlobalConstant.N003_SETTLEMENT_REQUEST;
    if ((rowData.product_code === FccGlobalConstant.PRODUCT_BG || rowData.product_code === FccGlobalConstant.PRODUCT_BR )
      && rowData.action_req_code && rowData.action_req_code === FccGlobalConstant.N042_CLEAN_RESPONSE) {
        this.onClickRespond(event, rowData);
    } else {
      this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
      productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
      tnxTypeCode: tnxType, option: optionValue, subTnxTypeCode: subTnxTypeCodeValue}});
    }
  }

  onClickRespond($event, rowData) {
    const tnxType = FccGlobalConstant.N002_INQUIRE;
    const optionValue = FccGlobalConstant.ACTION_REQUIRED;
    this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
    productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
    tnxTypeCode: tnxType, option: optionValue, tnxId: rowData.tnx_id} });
  }

  onClickDiscrepant($event, rowData) {
    if (rowData.product_code === FccGlobalConstant.PRODUCT_LC || rowData.product_code === FccGlobalConstant.PRODUCT_SI) {
    const tnxType = FccGlobalConstant.N002_INQUIRE;
    const optionValue = FccGlobalConstant.EXISTING_OPTION;
    const modeValue = FccGlobalConstant.DISCREPANT;
    this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
    productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
    tnxTypeCode: tnxType, option: optionValue, tnxId: rowData.tnx_id, mode: modeValue} });
    } else {
      const tnxType = FccGlobalConstant.N002_INQUIRE;
      const optionValue = FccGlobalConstant.ACTION_REQUIRED;
      this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
      productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
      tnxTypeCode: tnxType, option: optionValue, tnxId: rowData.tnx_id} });
    }
  }

  onClickCancel(event, rowData) {
    const tnxType = FccGlobalConstant.N002_INQUIRE;
    const optionValue = FccGlobalConstant.CANCEL_OPTION;
    const subTnxTypeCodeValue = FccGlobalConstant.N003_CANCELLATION_REQUEST;
    this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], { queryParams: { refId: rowData.ref_id,
    productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
    tnxTypeCode: tnxType, option: optionValue, subTnxTypeCode: subTnxTypeCodeValue} });
  }

  onClickDelete(event, rowData) {
    const beneGroupId = rowData[FccGlobalConstant.BENEFICIARY_GRP_ID];
    let headerField;
    let message;
    headerField = `${this.translate.instant('deleteBeneficiary')}`;
    message = `${this.translate.instant('delteConfirmationMsgForBeneficiary')}`;
    const direction = 'direction';
    const dir = localStorage.getItem('langDir');
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      header: headerField,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: {direction: dir},
      data: {locaKey: message}
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === 'yes') {
        this.continueDelete(beneGroupId);
      }
    });
  }

  onClickUpdate(event, rowData) {
  const option = FccGlobalConstant.BENEFICIARY_MASTER_MAINTENANCE_MC;
  const operation = FccGlobalConstant.ADD_FEATURES;
  this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
    queryParams: {
      option: option, operation: operation, action: FccGlobalConstant.UPDATE,
      beneGroupId: rowData[FccGlobalConstant.BENEFICIARY_GRP_ID]
    }
  });
  }

  continueDelete(beneGroupId){
    let result: Observable<any>;
    result = this.commonService.delete(beneGroupId);
    result.subscribe(data => {
      if (data.status === FccGlobalConstant.HTTP_RESPONSE_SUCCESS) {
        const tosterObj = {
          life : 5000,
          key: 'tc',
          severity: 'success',
          detail: `${this.translate.instant('singleBeneDeleteToasterMessage')}`
        };
        this.messageService.add(tosterObj);
        this.commonService.isResponse.next(true);
        setTimeout(() => {
        }, FccGlobalConstant.LENGTH_2000);
      }
    });
  }

  onClickAmend(event, rowData, option) {
    const tnxType = FccGlobalConstant.N002_AMEND;
    const optionValue = FccGlobalConstant.EXISTING_OPTION;
    if (option === FccGlobalConstant.GENERAL) {
      this.router.navigate(['productScreen'], { queryParams: { refId: rowData.ref_id,
        productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
        tnxTypeCode: tnxType, mode: optionValue} });
    }
  }

  onClickAmendRelease(event, rowData, option) {
    const tnxType = FccGlobalConstant.N002_AMEND;
    const subTnxType = FccGlobalConstant.N003_AMEND_RELEASE;
    const optionValue = FccGlobalConstant.EXISTING_OPTION;
    if (option === FccGlobalConstant.GENERAL) {
      this.router.navigate(['productScreen'], { queryParams: { refId: rowData.ref_id,
        productCode: rowData.product_code, subProductCode: rowData.sub_product_code,
        tnxTypeCode: tnxType, subTnxTypeCode: subTnxType, mode: optionValue} });
    }
  }

  onClickView(event, rowData) {
    const productCodeValue = rowData.product_code;
    const subProductCodeValue = rowData.sub_product_code;
    const referenceId = rowData.ref_id;
    const transactionId = rowData.tnx_id;
    const tnxTypeCodeValue = rowData.tnx_type_code;
    const tnxStatCode = rowData.tnx_stat_code;
    const subTnxTypeCodeValue = rowData.sub_tnx_type_code;
    this.commonService.getSwiftVersionValue();
    if (this.commonService.isAngularProductUrl(productCodeValue, subProductCodeValue) &&
    (!(this.commonService.swiftVersion < FccGlobalConstant.SWIFT_2021 &&
      (productCodeValue === FccGlobalConstant.PRODUCT_BG || productCodeValue === FccGlobalConstant.PRODUCT_BR)))) {
      const url = this.router.serializeUrl(
        this.router.createUrlTree(['view'], { queryParams: { tnxid: transactionId,  referenceid: referenceId,
          productCode: productCodeValue, subProductCode: subProductCodeValue, tnxTypeCode: tnxTypeCodeValue,
          eventTnxStatCode: tnxStatCode, mode: FccGlobalConstant.VIEW_MODE,
          subTnxTypeCode: subTnxTypeCodeValue, operation: FccGlobalConstant.PREVIEW} })
      );
      const popup = window.open('#' + url, '_blank', 'top=100,left=200,height=400,width=900,toolbar=no,resizable=no');
      const productId = this.commonService.displayLabelByCode(rowData.product_code, rowData.sub_product_code);
      const mainTitle = `${this.translate.instant('MAIN_TITLE')}`;
      popup.onload = () => {
        popup.document.title = mainTitle + ' - ' + productId;
      };
    } else {
      const prodCodeParam = [];
      const refIdParam = [];
      const tnxIdParam = [];
      const screenParam = 'ReportingPopup';
      const viewUrl = [];
      const tnxTypeCodeParam = [];
      const subTnxTypeCodeParam = [];
      const tnxStatusParam = [];
      if (this.commonService.isnonEMptyString(productCodeValue)) {
        prodCodeParam.push('&productcode=', productCodeValue);
      }
      if (this.commonService.isnonEMptyString(referenceId)) {
        refIdParam.push('&referenceid=', referenceId);
      }

      if (this.commonService.isnonEMptyString(transactionId)) {
        tnxIdParam.push('&tnxid=', transactionId);
      }

      if (this.commonService.isnonEMptyString(tnxTypeCodeValue)) {
        tnxTypeCodeParam.push('&tnxtype=', tnxTypeCodeValue);
      }

      if (this.commonService.isnonEMptyString(subTnxTypeCodeValue)) {
        subTnxTypeCodeParam.push('&subtnxtype=', subTnxTypeCodeValue);
      }
      if (this.commonService.isnonEMptyString(tnxStatCode)) {
        tnxStatusParam.push('&tnxstatus=', tnxStatCode);
      }
      viewUrl.push('/screen/', screenParam);
      viewUrl.push('?option=', 'FULL');
      viewUrl.push(refIdParam.join(''), tnxIdParam.join(''), prodCodeParam.join(''),
        tnxTypeCodeParam.join(''), subTnxTypeCodeParam.join(''), tnxStatusParam.join(''));
      let viewDetailsUrl = '';
      if (this.commonService.isnonEMptyString(this.commonService.getContextPath())) {
          viewDetailsUrl = this.commonService.getContextPath();
      }
      viewDetailsUrl += this.fccGlobalConstantService.servletName + viewUrl.join('');
      this.router.navigate([]).then(result => {
        window.open
        (viewDetailsUrl, '', 'width=800,height=600,resizable=yes,scrollbars=yes');
      });
    }
  }

  onClickEdit(event, rowData) {
    const productCode = rowData.product_code;
    const subProductCode = rowData.sub_product_code;
    const referenceId = rowData.ref_id;
    const transactionId = rowData.tnx_id;
    const tnxTypeCode = rowData.tnx_type_code;
    // const tnxStatCode = rowData.tnx_stat_code;
    const subTnxTypeCode = rowData.sub_tnx_type_code;
    const mode = 'DRAFT';
    this.commonService.getSwiftVersionValue();
    if (this.commonService.isAngularProductUrl(productCode, subProductCode) &&
      (!(this.commonService.swiftVersion < FccGlobalConstant.SWIFT_2021 &&
        (productCode === FccGlobalConstant.PRODUCT_BG || productCode === FccGlobalConstant.PRODUCT_BR)))) {
      if (rowData.action_req_code) {
        this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
          queryParams: {
            productCode: productCode,
            subProductCode: subProductCode,
            tnxTypeCode: tnxTypeCode,
            refId: referenceId,
            tnxId: transactionId,
            mode: mode,
            subTnxTypeCode: subTnxTypeCode,
            actionReqCode: rowData.action_req_code
          },
        });
      } else {
        this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
          queryParams: {
            productCode: productCode,
            subProductCode: subProductCode,
            tnxTypeCode: (rowData.template_id) ? FccGlobalConstant.N002_NEW : tnxTypeCode,
            refId: referenceId,
            tnxId: transactionId,
            mode: mode,
            subTnxTypeCode: subTnxTypeCode,
            templateId: rowData.template_id,
            option: (rowData.template_id) ? FccGlobalConstant.TEMPLATE : undefined
          },
        });
      }
    } else {
      const screenName = ScreenMapping.screenmappings[productCode];
      const tnxTypeCode = rowData.tnx_type_code;
      const subTnxTypeCode = rowData.sub_tnx_type_code === undefined || rowData.sub_tnx_type_code === ''
          ? 'null' : rowData.sub_tnx_type_code;
      const referenceId = rowData.ref_id;
      const tnxId = rowData.tnx_id;
      let url = '';
      this.contextPath = this.commonService.getContextPath();
      if (this.commonService.isnonEMptyString(this.contextPath)) {
        url = this.contextPath;
      }
      url = `${url}${this.fccGlobalConstantService.servletName}`;
      url = `${url}/screen/${screenName}?mode=${mode}&tnxtype=${tnxTypeCode}&subtnxtype=${subTnxTypeCode}`;

      if (productCode === FccGlobalConstant.PRODUCT_FT && (subProductCode === FccGlobalConstant.SUB_PRODUCT_CODE_BILLP
        || subProductCode === FccGlobalConstant.SUB_PRODUCT_CODE_BILLS)) {
        url = `${url}&referenceid=${referenceId}&tnxid=${tnxId}&option=${subProductCode}`;
      } else {
        url = `${url}&referenceid=${referenceId}&tnxid=${tnxId}&option=null`;
      }
      this.router.navigate([]).then(result => {
        window.open(url, '_self');
      });
    }
  }

  onClickLendingEdit(event, rowData) {
    if (rowData.product_code === FccGlobalConstant.PRODUCT_BK) {
      let optionValue;
      switch (rowData.sub_product_code) {
        case FccGlobalConstant.SUB_PRODUCT_LNRPN:
          optionValue = FccGlobalConstant.BK_LOAN_REPRICING;
          break;
        case FccGlobalConstant.SUB_PRODUCT_BLFP:
          optionValue = FccGlobalConstant.BK_LOAN_FEE_PAYMENT;
          break;
        default:
          optionValue = '';
      }
      this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
        queryParams: {
          productCode: rowData.product_code,
          subProductCode: rowData.sub_product_code,
          refId: rowData.ref_id,
          tnxId: rowData.tnx_id,
          mode: 'DRAFT',
          option: optionValue,
          tnxTypeCode: rowData.tnx_type_code
        },
      });
    } else if (rowData.transaction_type === 'Increase') {
      this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
        queryParams: {
          productCode: rowData.product_code,
          subProductCode: rowData.sub_product_code,
          tnxTypeCode: rowData.tnx_type_code,
          refId: rowData.ref_id,
          tnxId: rowData.tnx_id,
          mode: 'DRAFT',
          subTnxTypeCode: FccGlobalConstant.N003_INCREASE,
          facilityid: rowData.bo_facility_id,
          borrowerIds: rowData.borrower_reference
        },
      });
    } else {
      this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
        queryParams: {
          productCode: rowData.product_code,
          subProductCode: rowData.sub_product_code,
          tnxTypeCode: rowData.tnx_type_code,
          refId: rowData.ref_id,
          tnxId: rowData.tnx_id,
          mode: 'DRAFT',
          subTnxTypeCode: rowData.sub_tnx_type_code,
          facilityid: rowData.bo_facility_id,
          borrowerIds: rowData.borrower_reference
        },
      });
    }
  }

  onClickApprove(event: any, rowData: any, option: any, widgetCode?: any) {
    if (option === FccGlobalConstant.GENERAL || this.commonService.isnonEMptyString(widgetCode) ||
    option === FccGlobalConstant.PENDING_APPROVAL || option === FccGlobalConstant.TRANSACTION_IN_PROGRESS ||
    option === FccGlobalConstant.TRANSACTION_SEARCH || option === FccGlobalConstant.TRANSACTION_NOTIFICATION) {
      this.router.navigate(['reviewScreen'], { queryParams: { tnxid: rowData.tnx_id,  referenceid: rowData.ref_id,
      action: FccGlobalConstant.APPROVE, mode: FccGlobalConstant.VIEW_MODE, tnxTypeCode: rowData.tnx_type_code,
      productCode: rowData.ref_id.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2),
      subProductCode: rowData.sub_product_code, operation: FccGlobalConstant.LIST_INQUIRY} });
    }
  }

  onClickReturn(event, rowData) {
    this.router.navigate(['reviewScreen'], { queryParams: { tnxid: rowData.tnx_id,  referenceid: rowData.ref_id,
      action: FccGlobalConstant.RETURN, mode: FccGlobalConstant.VIEW_MODE, tnxTypeCode: rowData.tnx_type_code,
      productCode: rowData.ref_id.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2),
      subProductCode: rowData.sub_product_code, operation: FccGlobalConstant.LIST_INQUIRY} });
  }

  onClickDetail(event, rowData) {
    const productCode = rowData.product_code;
    const subProductCode = rowData.sub_product_code;
    const referenceId = rowData.ref_id;
    const transactionId = rowData.tnx_id;
    const subTnxTypeCodeValue = rowData.sub_tnx_type_code;
    this.commonService.getSwiftVersionValue();
    if (this.commonService.isAngularProductUrl(productCode, subProductCode) &&
      (!(this.commonService.swiftVersion < FccGlobalConstant.SWIFT_2021 &&
        (productCode === FccGlobalConstant.PRODUCT_BG || productCode === FccGlobalConstant.PRODUCT_BR)))) {
      this.router.navigate(['reviewScreen'], { queryParams: { tnxid: transactionId,  referenceid: referenceId,
        productCode: referenceId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2),
        subProductCode: rowData.sub_product_code, mode: FccGlobalConstant.VIEW_MODE, operation: 'LIST_INQUIRY',
        subTnxTypeCode: subTnxTypeCodeValue, tnxTypeCode: rowData.tnx_type_code} });
    } else {
      const consolidateViewUrlInitial = 'screen/!?productcode=';
      const consolidateViewUrlMiddle = '&operation=LIST_INQUIRY&referenceid=';
      const consolidateViewUrlEnd = '&option=HISTORY';
      const screenName = ScreenMapping.screenmappings[productCode];
      let consolidateViewUrl = '';
      this.contextPath = this.commonService.getContextPath();
      if (this.commonService.isnonEMptyString(this.contextPath)) {
          consolidateViewUrl = this.contextPath;
      }
      consolidateViewUrl += this.fccGlobalConstantService.servletName + '/'
      .concat(consolidateViewUrlInitial.replace('!', screenName))
      .concat(productCode).concat(consolidateViewUrlMiddle).concat(referenceId).concat(consolidateViewUrlEnd);
      this.router.navigate([]).then(result => { window.open(consolidateViewUrl, '_self'); });
    }
  }

  onClickMessage(event, rowData, option) {
    if (option === FccGlobalConstant.GENERAL) {
      this.router.navigate(['importLetterOfCredit'], { queryParams: { refId: rowData.ref_id,
        productCode: rowData.productCode, subProductCode: rowData.subProductCode,
        tnxTypeCode: rowData.tnxTypeCode, option: 'MESSAGE' } });
    }
  }

  checkIsRequestSettlementAllowed(rowData): boolean {
    return true;
  }
  
  onClickAcceptCN(event, rowData) {
    const productCode = rowData.product_code;
    const referenceId = rowData.ref_id;
    const tnxTypeCode = FccGlobalConstant.N002_ACCEPT;
    const option = FccGlobalConstant.OPTION_ACCEPT;
    const mode = FccGlobalConstant.MODE_ACCEPT;
    const screenName = ScreenMapping.screenmappings[productCode];
    const tnxId = rowData.tnx_id;
    let url = '';
    this.contextPath = this.commonService.getContextPath();
    if (this.commonService.isnonEMptyString(this.contextPath)) {
      url = this.contextPath;
    }
    url = `${url}${this.fccGlobalConstantService.servletName}`;
    url = `${url}/screen/${screenName}?mode=${mode}&tnxtype=${tnxTypeCode}&productcode=${productCode}`;
    url = `${url}&referenceid=${referenceId}&tnxid=${tnxId}&option=${option}`;
    this.router.navigate([]).then(result => {
      window.open(url, '_self');
    });

  }

  onClickAcceptPOA(event, rowData) {
    const productCode = rowData.product_code;
    const option = FccGlobalConstant.OPTION_PENDING;
    const referenceId = rowData.ref_id;
    const tnxTypeCode = FccGlobalConstant.N002_RESUBMIT;
    const screenName = ScreenMapping.screenmappings[productCode];
    const tnxId = rowData.tnx_id;
    let url = '';
    this.contextPath = this.commonService.getContextPath();
    if (this.commonService.isnonEMptyString(this.contextPath)) {
      url = this.contextPath;
    }
    url = `${url}${this.fccGlobalConstantService.servletName}`;
    url = `${url}/screen/${screenName}?tnxtype=${tnxTypeCode}`;
    url = `${url}&referenceid=${referenceId}&tnxid=${tnxId}&option=${option}`;

    this.router.navigate([]).then(result => {
      window.open(url, '_self');
    });

  }

  onClickAcceptIP(event, rowData) {
    const option = FccGlobalConstant.EXISTING_OPTION;
    const referenceId = rowData.ref_id;
    const productCode = rowData.product_code;
    const tnxTypeCode = FccGlobalConstant.N002_INQUIRE;
    const mode = FccGlobalConstant.MODE_ACCEPT;
    const screenName = ScreenMapping.screenmappings[productCode];
    const tnxId = rowData.tnx_id;
    let url = '';
    this.contextPath = this.commonService.getContextPath();
    if (this.commonService.isnonEMptyString(this.contextPath)) {
      url = this.contextPath;
    }
    url = `${url}${this.fccGlobalConstantService.servletName}`;
    url = `${url}/screen/${screenName}?mode=${mode}&tnxtype=${tnxTypeCode}`;
    url = `${url}&referenceid=${referenceId}&tnxid=${tnxId}&option=${option}`;
    this.router.navigate([]).then(result => {
      window.open(url, '_self');
    });
  }

  onClickViewMultiSubmit(event, valObj) {
    const result = this.reauthService.multiSubmitRequestPayload.multiTransactionSubmissionPayload
    .filter(payloadObj => (payloadObj.id === valObj.refId && payloadObj.eventId === valObj.eventId));
    if (this.commonService.isNonEmptyValue(result) && result.length > 0) {
    this.transactionDetailService.fetchTransactionDetails(result[0].eventId, result[0].productCode, false,
      result[0].subProductCode).subscribe(response => {
        if (this.commonService.isNonEmptyValue(response) && this.commonService.isNonEmptyValue(response.body)) {
          this.onClickView(event, response.body);
        }
      });
    }
  }

}
