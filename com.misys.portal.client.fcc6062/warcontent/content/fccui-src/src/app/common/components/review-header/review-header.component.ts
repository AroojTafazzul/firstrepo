import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DialogService } from 'primeng/dynamicdialog';
import { ProductStateService } from '../../../corporate/trade/lc/common/services/product-state.service';

import {
  ConfirmationDialogComponent,
} from '../../../../app/corporate/trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { CommonService } from '../../services/common.service';
import { EnquiryService } from './../../../corporate/trade/lc/initiation/services/enquiry.service';
import { UtilityService } from './../../../corporate/trade/lc/initiation/services/utility.service';
import { ListDefService } from './../../services/listdef.service';


@Component({
  selector: 'app-review-header',
  templateUrl: './review-header.component.html',
  styleUrls: ['./review-header.component.scss']
})
export class ReviewHeaderComponent implements OnInit {
  displayButtons = true;
  menuToggleFlag;
  widgetDetails: any;
  componentDetails: any;
  header: string;
  widgets;
  tnxID;
  tnxTypeCode;
  tnxStatCode;
  productCode;
  buttonItemList = [];
  threeDotsButton = false;
  formattedButtonName: string;
  tranasactionDetails;
  eventType: string;
  referenceNum: string;
  button;
  boRefId;
  event = `${this.translateService.instant('event')}`;
  dir: string = localStorage.getItem('langDir');
  repricingDate;
  prodStatCode;
  lnLiabAmt;
  underRepricing;
  subPoductCode;
  lnStatus;
  lnAccessType;
  TSCode;
  respond;
  fetchItems;
  repricingFrequency;
  displayEvent = true;
  constructor(
    protected commonService: CommonService,
    protected translateService: TranslateService,
    protected listService: ListDefService,
    protected location: Location,
    protected enquiryService: EnquiryService, protected router: Router,
    protected utilityService: UtilityService,
    protected dialogService: DialogService,
    protected stateService: ProductStateService
  

  ) { }

  ngOnInit() {
    this.displayButtons = true;
    this.displayEvent = true;
    this.widgets = this.widgetDetails ? JSON.parse(this.widgetDetails) : '';
    this.boRefId = this.widgets.transactionCode.body.bo_ref_id;
    this.referenceNum = this.widgets.recordDetails.referenceId;
    this.tnxID = this.widgets.recordDetails.transactionId;
    this.componentDetails = this.widgets.widgetData;
    this.prodStatCode = this.widgets.transactionCode.body.prod_stat_code;
    this.productCode = this.widgets.recordDetails.productCode;

    this.repricingDate = this.widgets.transactionCode.body.repricing_date;
    this.repricingFrequency = this.widgets.transactionCode.body.repricing_frequency;
    this.lnLiabAmt = this.widgets.transactionCode.body.ln_liab_amt;
    this.underRepricing = this.widgets.transactionCode.body.under_repricing;
    this.subPoductCode = this.widgets.transactionCode.body.sub_product_code;
    this.lnStatus = this.widgets.transactionCode.body.status;
    this.lnAccessType = this.widgets.transactionCode.body.ln_access_type;
    if (this.tnxID === '') {
      this.tnxTypeCode = 'MASTER';
      this.tnxStatCode = 'ACKNOWLEDGED';
      this.eventType = this.translateService.instant('N005_' + this.widgets.transactionCode.body.prod_stat_code);
      if (this.productCode && this.productCode === FccGlobalConstant.PRODUCT_LN) {
        this.displayEvent = false;
        this.displayButtons = true;
      }
    } else {
      this.tnxTypeCode = this.widgets.transactionCode.body.tnx_type_code;
      this.eventType = this.tnxTypeCodeAlias();
      const tnxStatRepl = this.widgets.transactionCode.body.tnx_stat_code;
      this.tnxStatCode = tnxStatRepl.replace(/-/g, '_');
      if (this.productCode && this.productCode === FccGlobalConstant.PRODUCT_LN) {
        this.displayEvent = true;
      }
      if (this.productCode && this.productCode === FccGlobalConstant.PRODUCT_SE &&
        this.subPoductCode === FccGlobalConstant.SUB_PRODUCT_LNCDS) {
        this.displayEvent = false;
        this.displayButtons = true;
      }
    }
    this.getxnStat(this.widgets.recordDetails.referenceId);
  }

  tnxTypeCodeAlias() {
    let eventTypeName: any;
    switch (this.productCode) {
      case FccGlobalConstant.PRODUCT_TD:
        eventTypeName = this.translateService.instant('N002_TD_' + this.widgets.transactionCode.body.tnx_type_code);
        break;
      case FccGlobalConstant.PRODUCT_LN:
        eventTypeName = this.translateService.instant('N002_LN_' + this.widgets.transactionCode.body.tnx_type_code);
        break;
      case FccGlobalConstant.PRODUCT_BK:
        eventTypeName = this.tnxTypeCodeAliasBK();
        break;
      default:
        if (this.commonService.isnonEMptyString(this.widgets.transactionCode.body.sub_tnx_type_code)) {
          eventTypeName = this.translateService.instant('N002_' + this.widgets.transactionCode.body.tnx_type_code) + ' ' +
          this.translateService.instant('LIST_N003_' + this.widgets.transactionCode.body.sub_tnx_type_code) ;
        } else {
          eventTypeName = this.translateService.instant('N002_' + this.widgets.transactionCode.body.tnx_type_code);
        }
    }
    return eventTypeName;
  }

  tnxTypeCodeAliasBK() {
    let eventTypeName: any;
    switch (this.subPoductCode) {
      case FccGlobalConstant.SUB_PRODUCT_BLFP:
        if (this.commonService.isnonEMptyString(this.widgets.transactionCode.body.sub_tnx_type_code)) {
          eventTypeName = this.translateService.instant('LIST_N003_' + this.widgets.transactionCode.body.sub_tnx_type_code);
        } else {
          eventTypeName = this.translateService.instant('N002_' + this.widgets.transactionCode.body.tnx_type_code);
        }
        break;
      default:
        if (this.commonService.isnonEMptyString(this.widgets.transactionCode.body.sub_tnx_type_code)) {
          eventTypeName = this.translateService.instant('N002_' + this.widgets.transactionCode.body.tnx_type_code) + ' ' +
          this.translateService.instant('LIST_N003_' + this.widgets.transactionCode.body.sub_tnx_type_code) ;
        } else {
          eventTypeName = this.translateService.instant('N002_' + this.widgets.transactionCode.body.tnx_type_code);
        }
    }
    return eventTypeName;
  }

  getxnStat = async (br) => {
    const paginatorParams = {};
    const filterValues = {};
    const refId = 'ref_id';
    filterValues[refId] = br;
    const filterParams = JSON.stringify(filterValues);
    let txnTypeCode = '';
    let txnStatCode = '';
    this.listService.getTableData('loan/listdef/customer/LN/lnTnxRecords', filterParams , JSON.stringify(paginatorParams))
    .subscribe(result => {
     const data = result.rowDetails.filter((e) => {
      const tmpData = e.index;
      tmpData.map((el) => {
        if (el.name === FccGlobalConstant.LNTnxTypeCode){ txnTypeCode = el.value; }
        if (el.name === FccGlobalConstant.LNTnxStatCode){ txnStatCode = el.value; }
      });
      if ((txnTypeCode === FccGlobalConstant.N002_INQUIRE || txnTypeCode === FccGlobalConstant.N002_AMEND)
          && txnStatCode !== FccGlobalConstant.N004_ACKNOWLEDGED){
           return e;
      }
     });
     this.TSCode = data.length > 0 ? false : true;
     this.renderButton();
    });
  }

  renderButton() {
    const selectedDate = 0;
    const buttons = 'buttons';
    const txnStatusButton = 'txnStatusButton';
    const buttonItemListTmp = this.enquiryService.getButtonPermission( this.tnxTypeCode, this.componentDetails[buttons],
    this.componentDetails[txnStatusButton], this.prodStatCode);
    this.buttonItemList = this.enquiryService.getButtonPermissionForLive(buttonItemListTmp,
    this.prodStatCode, this.repricingDate, this.lnLiabAmt, this.underRepricing,
    this.subPoductCode, this.lnStatus, this.lnAccessType, this.TSCode, selectedDate, this.repricingFrequency);
    this.buttonItemList.map(e => {
      if (e.render && e.buttonType === 'threeDots') {
      this.threeDotsButton = true;
      }
    });
  }





  navigateButtonUrl(url, buttontype, params: JSON) {
    if (buttontype === FccGlobalConstant.AMENDMENT) {
      const tnxType = FccGlobalConstant.N002_AMEND;
      const optionValue = FccGlobalConstant.EXISTING_OPTION;
      const subProdCode = (this.productCode === FccGlobalConstant.PRODUCT_BG) ? FccGlobalConstant.EMPTY_STRING : FccGlobalConstant.LCSTD;
      this.router.navigate(['productScreen'], {
        queryParams: {
          refId: this.widgets.recordDetails.referenceId,
          productCode: this.widgets.recordDetails.productCode, subProductCode: subProdCode,
          tnxTypeCode: tnxType, mode: optionValue
        }
      });
    }
    else if (buttontype === FccGlobalConstant.IMPORTLNLANDING) {
      this.stateService.clearState();
      this.router.navigate([url], {
        queryParams: { ...params,
          refId: this.widgets.recordDetails.referenceId,
          productCode: this.widgets.recordDetails.productCode
        }
      });
    } else if (buttontype === FccGlobalConstant.IMPORTLNRPNLANDING) {
      this.commonService.selectedRows = [];
      const rowData = this.widgets.transactionCode.body;
      rowData.cur_code = rowData.fac_cur_code;
      this.commonService.selectedRows.push(rowData);
      const currentDateToValidate = this.utilityService.transformDateFormat(
        new Date()
      );
      const dateRequestParams = this.commonService.requestToValidateDate(
        currentDateToValidate,
        rowData
      );
      this.commonService
        .getValidateBusinessDate(dateRequestParams)
        .subscribe((res) => {
          if (res) {
            if (res && res.adjustedLocalizedDate && rowData && rowData.repricing_date) {
              const adjustedDate = this.utilityService.transformddMMyyyytoDate(
                res.adjustedLocalizedDate
              );
              const selectedDate = this.utilityService.transformddMMyyyytoDate(
                rowData.repricing_date
              );
              if (
                !this.utilityService.compareDateFields(
                  adjustedDate,
                  selectedDate
                )
              ) {
               this.getConfigDataForRollover(rowData, params, url);
              } else {
                const dir = localStorage.getItem('langDir');
                const locaKeyValue =
                  `${this.translateService.instant(
                    'repriceDateLessThanSelectedDate'
                  )}` + res.adjustedLocalizedDate;
                this.dialogService.open(
                  ConfirmationDialogComponent,
                  {
                    header: `${this.translateService.instant('message')}`,
                    width: '35em',
                    styleClass: 'fileUploadClass',
                    style: { direction: dir },
                    data: {
                      locaKey: locaKeyValue,
                      showOkButton: true,
                      showNoButton: false,
                      showYesButton: false,
                    },
                    baseZIndex: 10010,
                    autoZIndex: true,
                  }
                );
              }
            }
          }
        });
    } else if (url !== '') {
      this.router.navigate([url], {
        queryParams: params,
      });
    } else {
      this.location.back();
    }
  }

  getConfigDataForRollover(rowData, params, url) {
    this.commonService
      .getConfiguredValues('CHECK_FACILITY_STATUS_ON_CLICK_ROLLOVER')
      .subscribe((resp) => {
        if (resp.response && resp.response === 'REST_API_SUCCESS') {
          if (resp.CHECK_FACILITY_STATUS_ON_CLICK_ROLLOVER === 'true') {
            this.listService
              .getFacilityDetail(
                '/loan/listdef/customer/LN/getFacilityDetail',
                rowData.borrower_reference,
                rowData.bo_deal_id
              )
              .subscribe((facResponse) => {
                facResponse.rowDetails.forEach((facility) => {
                  const filteredData = facility.index.filter(
                    (row) =>
                      row.name === 'id' && (this.commonService.decodeHtml(row.value) === rowData.bo_facility_id)
                  );
                  if (filteredData && filteredData.length > 0) {
                    const filteredStatusData = facility.index.filter(
                      (row) => row.name === 'status'
                    );
                    if (
                      filteredStatusData[0].value === FccGlobalConstant.expired
                    ) {
                      const dir = localStorage.getItem('langDir');
                      const locaKeyValue = this.translateService.instant(
                        'rolloverErrorOnExpiredFacility'
                      );
                      const expiredFacDialog = this.dialogService.open(
                        ConfirmationDialogComponent,
                        {
                          header: `${this.translateService.instant('message')}`,
                          width: '35em',
                          styleClass: 'fileUploadClass',
                          style: { direction: dir },
                          data: {
                            locaKey: locaKeyValue,
                            showOkButton: true,
                            showNoButton: false,
                            showYesButton: false,
                          },
                          baseZIndex: 10010,
                          autoZIndex: true,
                        }
                      );
                      expiredFacDialog.onClose.subscribe(() => {
                        //eslint : no-empty-function
                      });
                    } else {
                      this.router.navigate([url], {
                        queryParams: params,
                      });
                    }
                  }
                });
              });
          } else {
            this.router.navigate([url], {
              queryParams: params,
            });
          }
        }
      });
  }

  iportletter() {
    this.location.back();
  }

  journey() {
    this.commonService.isJourneyClicked('yes');
  }

  get isJourneyButtonRequired(): boolean {
    if (this.buttonItemList.length !== 0) {
      if (this.productCode === FccGlobalConstant.PRODUCT_SE && this.subPoductCode === FccGlobalConstant.SUB_PRODUCT_LNCDS) {
        return false;
      }
      return true;
    } else if ((this.buttonItemList.length === 0) &&
      (this.productCode === FccGlobalConstant.PRODUCT_LN || this.productCode === FccGlobalConstant.PRODUCT_BK)) {
      return true;
    }
    return false;
  }
}
