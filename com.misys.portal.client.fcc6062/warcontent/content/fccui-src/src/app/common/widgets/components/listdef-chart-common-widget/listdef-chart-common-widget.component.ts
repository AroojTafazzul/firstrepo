import { DatePipe } from '@angular/common';
import { AfterViewInit, Component, Input, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DialogService } from 'primeng/dynamicdialog';
import { forkJoin, of } from 'rxjs';

import { GlobalDashboardComponent } from '../../../../common/components/global-dashboard/global-dashboard.component';
import { FccGlobalConfiguration } from '../../../../common/core/fcc-global-configuration';
import { CommonService } from '../../../../common/services/common.service';
import { HideShowDeleteWidgetsService } from '../../../../common/services/hide-show-delete-widgets.service';
import { LocaleService } from './../../../../base/services/locale.service';
import { CorporateCommonService } from './../../../../corporate/common/services/common.service';
import {
  ConfirmationDialogComponent
} from './../../../../corporate/trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { UtilityService } from './../../../../corporate/trade/lc/initiation/services/utility.service';
import { TransactionsListdefComponent } from './../../../components/transactions-listdef/transactions-listdef.component';
import { FccGlobalConstantService } from './../../../core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../../core/fcc-global-constants';
import { OPEN_CLOSE_ANIMATION } from './../../../model/animation';
import { BankApprovalsAndRejectionsService } from './../../../services/bank-approvals-and-rejections.service';
import { ListDefService } from './../../../services/listdef.service';

@Component({
  selector: 'app-listdef-chart-common-widget',
  templateUrl: './listdef-chart-common-widget.component.html',
  styleUrls: ['./listdef-chart-common-widget.component.scss'],
  animations: [OPEN_CLOSE_ANIMATION]
})
export class ListdefChartCommonWidgetComponent implements OnInit, AfterViewInit {

  constructor(protected globalDashboardComponent: GlobalDashboardComponent,
              protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
              protected commonService: CommonService, protected router: Router,
              protected fccGlobalConstantService: FccGlobalConstantService,
              protected listService: ListDefService,
              protected translateService: TranslateService,
              protected bankApprovalsAndRejectionsService: BankApprovalsAndRejectionsService,
              protected corporateCommonService: CorporateCommonService,
              protected datePipe: DatePipe,
              protected localeService: LocaleService,
              protected utilityService: UtilityService,
              protected dialogService: DialogService) { }

@Input()
widgetDetails: any;
nudges: any;
widgets;
contextPath: any;
header: any;
widgetConfig: any;
@Input () dashboardName;
inputParams: any = {};
transListdef: any;
@ViewChild('listdef') public listdef: TransactionsListdefComponent;
finalData: any[] = [];
isUiloaded: boolean;
dashboardType: any;
defaultRow: any;
defaultSortOrder: any;
listdefName: any;
retultdataArray: any;
metadata;
groupNames: any [] = [];
goupNamesDataMap: any;
checkCustomise;
classCheck;
hideShowCard;
approvedTransactionsTitle = this.translateService.instant('pendingApproval');
chartData: any;
chartdataoptions = this.bankApprovalsAndRejectionsService.polarAreaChartOptions;
transactionCountMap = new Map();
resulDataArrayMap = new Map<string, any[]>();
cols = [];
dataAvailable: boolean;
approvalDays: any;
day = this.translateService.instant('day');
star = this.translateService.instant('star');
of = this.translateService.instant('of');
days;
rowCount;
daterange;
defaultSelection;
dojoPath = `${this.fccGlobalConstantService.servletName}/screen/`;
two = 2;
three = 3;
currentDate = this.datePipe.transform(new Date(), 'dd/MM/yyyy').split('/');
dateRangeDays: any;
scrollable: boolean;
cssChart: any;
cssTable: any;
cssTextAlingnRight = 'right';
cssTextAlingnLeft = 'left';
dir: any;
selectedLegend = '';
date: Date;
recordsDisplayed: string;
showMessage = this.translateService.instant('showMessage');
totalCount = 0;
viewAllTnxPermission = false;

ngOnInit(): void {
    this.commonService.getNudges(this.widgetDetails).then(data => {
      this.nudges = data;
    });
    const dashboardTypeValue = 'dashboardTypeValue';
    const listDefName = 'listdefName';
    this.dataAvailable = true;
    this.translateService.get('corporatechannels').subscribe(() => {
      this.recordsDisplayed = this.translateService.instant('recordsDisplayed');
    });
    this.contextPath = this.commonService.getContextPath();
    this.widgets = this.widgetDetails ? JSON.parse(this.widgetDetails) : '';
    this.header = this.widgets.widgetName;
    if (this.widgets !== '' && this.widgets.widgetConfig) {
      this.widgetConfig = JSON.parse(this.widgets.widgetConfig);
      const dashBoardURI = this.dashboardName.split('/');
      this.dashboardType = dashBoardURI[dashBoardURI.length - 1].toUpperCase() ;
      this.inputParams[dashboardTypeValue] = this.dashboardType;
      this.listdefName = this.widgetConfig.tableConfig[listDefName];
      this.defaultSelection = this.widgetConfig.defalugroup;
      if (this.widgetConfig.daterange){
        this.daterange = this.widgetConfig.daterange;
      }
    }

    if (this.commonService.isnonEMptyString(this.widgetConfig)
          && this.commonService.isnonEMptyString(this.widgetConfig.viewAllPermission)){
      this.commonService.getUserPermission(this.widgetConfig.viewAllPermission).subscribe(permission => {
        if (permission) {
          this.viewAllTnxPermission = true;
        }
      });
    }

    this.selectedLegend = this.translateService.instant(this.defaultSelection);
    this.approvedTransactionsTitle = this.translateService.instant(this.widgets.widgetName);

    this.scrollable = false;
    this.cssChart = 'p-col-3';
    this.cssTable = 'p-col-9';

    if (this.widgets.widgetName === 'pendingApproval'){
      this.approvalDays = this.translateService.instant('nopendingapprovals');
    }else if (this.widgets.widgetName === 'upcomingEventsLoan'){
      this.date = new Date(new Date());
      const dateRangeDays = this.datePipe.transform(this.date.setDate(this.date.getDate() + parseInt(this.daterange, 0)),
      this.localeService.getDateLocaleJson(localStorage.getItem('language')).dateFormat);
      this.approvalDays = this.translateService.instant('noupcomingevents') + ' ' + dateRangeDays;
    }

    this.dir = localStorage.getItem('langDir');

    if (localStorage.getItem('language') === 'ar'){
      this.cssTextAlingnRight = 'left';
      this.cssTextAlingnLeft = 'right';
    }

    this.updateValues();
    this.updateGroupNames();
    this.updateColumsData(this.defaultSelection);
    this.getMetaData();

    this.commonService.dashboardOptionsSubject.subscribe(data => {
      this.classCheck = data;
    });

    this.hideShowDeleteWidgetsService.customiseSubject.subscribe(data => {
      this.checkCustomise = data;
    });

  }

  updateValues() {
    this.days = FccGlobalConfiguration.configurationValues.get('BANK_APPROVAL_AND_REJECTION_DAYS');
    this.rowCount = FccGlobalConfiguration.configurationValues.get('BANK_APPROVAL_AND_REJECTION_ROW_COUNT');
  }


  updateGroupNames() {
    this.goupNamesDataMap = this.widgetConfig.columngrouping;
    Object.keys(this.goupNamesDataMap).forEach(key => {
      this.groupNames.push(key);
    });
  }

  updateColumsData(defaultSelection: any){
    const columnslist = this.goupNamesDataMap[defaultSelection];
    const field = 'field';
    const header = 'header';
    const width = 'width';

    this.cols = [];

    columnslist.forEach(ele => {
      const obj = {};
      obj[field] = ele.field;
      obj[header] = this.translateService.instant(ele.header);
      obj[width] = ele.width;
      this.cols.push(obj);
    });
  }

  getMetaData() {
    this.listService.getMetaData(this.listdefName.split(',')[0], FccGlobalConstant.EMPTY_STRING, FccGlobalConstant.EMPTY_STRING)
      .subscribe(response => {
        this.metadata = response;
        this.setDefaultProperties();
        this.getRecords();
      });
  }

  setDefaultProperties() {
    this.defaultSortOrder = this.metadata.ListDefDefaultProperties[0].default_order_type === 'd' ? -1 : 1;
    this.defaultRow = this.metadata.ListDefDefaultProperties[0].page;
  }

  toCamelCase(str: string) {
    return str.toLowerCase().replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
  }

  formatResult(result: any, response: any) {
        const tempTableData = result.rowDetails;
        const data = [];
        if (tempTableData) {
          tempTableData.forEach(element => {
            const obj = {};
            element.index.forEach(ele => {
              const formattedName = this.toCamelCase(ele.name);
              let value = ele.value;
              if (formattedName === 'entity' && (value === '' || value === null || value === undefined)){
                    value = response.body.shortName;
              }
              obj[formattedName] = value;
            });
            data.push(obj);
          });
       }
        return data;
  }

  getRecords() {
    let filterparams = {};
    if ( this.daterange !== undefined){
       filterparams = { dashboardType: this.dashboardType, daterange: this.daterange };
    }else{
      filterparams = { dashboardType: this.dashboardType };
    }
    const paginatorParams = { first: 0, rows: this.defaultRow, sortOrder: this.defaultSortOrder };
    this.getResponsesFromListDef(filterparams, paginatorParams).subscribe(result => {
         this.corporateCommonService.getValues(this.fccGlobalConstantService.corporateDetails).
         subscribe(response => {
          const response0 = this.formatResult(result[0], response);
          if ( result[1] !== undefined){
            const response1 = this.formatResult(result[1], response);
            this.retultdataArray = response0.concat(response1);
          }else{
            this.retultdataArray = response0;
          }
          if (this.retultdataArray.length === 0){
            this.dataAvailable = false;
          }
          const dataArray: string[] = [];
          const bgcolors: any[] = [];
          const labelArray: string[] = [];
          const bordercolors: any[] = [];
          this.prepareDataArray();
          this.retultdataArray = this.resulDataArrayMap.get(this.defaultSelection);

          if (this.retultdataArray === undefined && this.dataAvailable === true){
            for ( let i = 0 ; i < this.groupNames.length; i++){
              if (this.resulDataArrayMap.get(this.groupNames[i]) !== undefined) {
                this.retultdataArray = this.resulDataArrayMap.get(this.groupNames[i]);
                this.defaultSelection = this.groupNames[i];
                this.selectedLegend = this.translateService.instant(this.groupNames[i]);
                this.updateColumsData(this.groupNames[i]);
                break;
              }
            }
          }
          if (this.retultdataArray && this.retultdataArray.length > 10){
            this.retultdataArray = this.retultdataArray.slice(0, 10);
          }
          this.groupNames.forEach((element, index) => {
            bgcolors.push(this.bankApprovalsAndRejectionsService.colorsList[index]);
            bordercolors.push(this.bankApprovalsAndRejectionsService.borderColorsList[index]);
            if (this.transactionCountMap.has(element)){
              dataArray.push(this.transactionCountMap.get(element));
              labelArray.push(element);
            }

            if (!this.resulDataArrayMap.has(element)){
              this.resulDataArrayMap.set(element, []);
            }

          });

          this.groupNames = [];
          const labelsWithcount: string[] = [];

          labelArray.forEach((element, index) => {
            labelArray [index] = this.translateService.instant(element);
            this.groupNames.push(element);
            labelsWithcount.push(this.translateService.instant(labelArray[index]) + ':' + ' ' +
             '(' + dataArray[index] + ')');
          });

          const legendNamePie =
                `${this.translateService.instant(this.approvedTransactionsTitle)}`;

          this.chartData = this.bankApprovalsAndRejectionsService.getPolarAreaData(labelsWithcount, dataArray,
            legendNamePie, bgcolors, bordercolors);

        });

      });


  }

  prepareDataArray(){
    this.retultdataArray.forEach(element => {
      this.totalCount++;
      const transactionType = (element.transactionType).toLowerCase().replace(/\s/g, '');
      if ((this.transactionCountMap.get(transactionType)) === undefined){
        this.transactionCountMap.set(transactionType, 1);
        const tmpdataArray = [];
        tmpdataArray.push(element);
        this.resulDataArrayMap.set(transactionType, tmpdataArray);
      }else{
        this.transactionCountMap.set(transactionType,
                        this.transactionCountMap.get(transactionType) + 1);
        const tmpdataArray = this.resulDataArrayMap.get(transactionType);
        tmpdataArray.push(element);
        this.resulDataArrayMap.set(transactionType, tmpdataArray);
      }
    });
  }

  ngAfterViewInit(): void {
    this.isUiloaded = true;
  }

  loadArray() {
    if (this.isUiloaded) {
      this.finalData = this.listdef.finalData;
      // eslint-disable-next-line no-console
      console.log(this.listdef.finalData);
      this.listdef.table.data = [];
      this.listdef.addColumnDetails();
    }
  }

  checkForBooleanValue(value: string) {
    switch (value) {
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return value;
    }
  }

  deleteCards() {
    this.hideShowDeleteWidgetsService.listdefChartComp.next(true);
    this.hideShowDeleteWidgetsService.listdefChartComp.subscribe(
      res => {
        this.hideShowCard = res;
      }
    );
    setTimeout(() => {
      this.hideShowDeleteWidgetsService.getSmallWidgetActions(this.widgets.widgetName, this.widgets.widgetPosition);
      this.globalDashboardComponent.deleteCardLayout(this.widgets.widgetName);
    }, FccGlobalConstant.DELETE_TIMER_INTERVAL);
  }

  selectData(e: any){

    this.updateColumsData(this.groupNames[e.element._index]);
    this.retultdataArray = this.resulDataArrayMap.get(this.groupNames[e.element._index]);
    if (this.retultdataArray.length > 10){
        this.retultdataArray = this.retultdataArray.slice(0, 10);
    }

    this.selectedLegend = this.translateService.instant(this.groupNames[e.element._index]);

  }

  getResponsesFromListDef(filterparams: any, paginatorParams: any) {
    const listdefarray = this.listdefName.split(',');
    if ( listdefarray[1] !== undefined){
     return forkJoin([this.listService.getTableData(listdefarray[0], JSON.stringify(filterparams) , JSON.stringify(paginatorParams)),
      this.listService.getTableData(listdefarray[1], JSON.stringify(filterparams) , JSON.stringify(paginatorParams))]);
    }else{
      return forkJoin([this.listService.getTableData(listdefarray[0], JSON.stringify(filterparams) , JSON.stringify(paginatorParams)),
      of(undefined)]);
    }

  }

  onClickViewAllTransactions() {
    const dashBoardURI = this.dashboardName.split('/');
    const dashboardNameVal = dashBoardURI[dashBoardURI.length - 1].toUpperCase();
    this.commonService.setWidgetClicked(dashboardNameVal);

    if(this.header === 'upcomingEventsLoan'){
      this.router.navigate(['productListing'], { queryParams: { productCode: 'LN', operation:'live',option: 'GENERAL' } });
    }else{
      this.router.navigate(['productListing'], { queryParams: { dashboardType: dashboardNameVal,
        subProductCode: null, option: this.header } });
    }
  }

  onClickLoanPayment($event, rowData) {
    const tnxType = FccGlobalConstant.N002_INQUIRE;
    const optionValue = FccGlobalConstant.EXISTING_OPTION;
    const subTnxTypeCode = FccGlobalConstant.N003_PAYMENT;
    this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
      queryParams: {
        productCode: rowData.productCode, refId: rowData.refId,
        tnxTypeCode: tnxType, option: optionValue, subTnxTypeCode
      }
    });
  }


  onClickRollover($event, rowData) {
    this.commonService.selectedRows = [];
    const formattedData = {
      ref_id: rowData.refId,
      pricing_option: rowData.pricingOption,
      borrower_reference: rowData.borrowerReference,
      bo_facility_id: rowData.boFacilityId,
      bo_deal_id: rowData.boDealId,
      cur_code: rowData.curCode,
      repricing_date: rowData.repricingDate
    };
    this.commonService.selectedRows.push(formattedData);
    const currentDateToValidate = this.utilityService.transformDateFormat(new Date());
    const dateRequestParams = this.commonService.requestToValidateDate(currentDateToValidate, formattedData);
    this.commonService.getValidateBusinessDate(dateRequestParams).subscribe((res) => {
      if (res) {
        if (res && res.adjustedLocalizedDate && formattedData && formattedData.repricing_date){
          const adjustedDate = this.utilityService.transformddMMyyyytoDate(res.adjustedLocalizedDate);
          const selectedDate = this.utilityService.transformddMMyyyytoDate(formattedData.repricing_date);
          if (!this.utilityService.compareDateFields(adjustedDate, selectedDate)) {
            this.getConfigDataForRollover(formattedData);
          } else {
            const dir = localStorage.getItem('langDir');
            const locaKeyValue = `${this.translateService.instant('repriceDateLessThanSelectedDate')}` + res.adjustedLocalizedDate;
            this.dialogService.open(ConfirmationDialogComponent, {
              header: `${this.translateService.instant('message')}`,
              width: '35em',
              styleClass: 'fileUploadClass',
              style: { direction: dir },
              data: { locaKey: locaKeyValue,
                showOkButton: true,
                showNoButton: false,
                showYesButton: false
              },
              baseZIndex: 10010,
              autoZIndex: true
            });
          }
        }
      }
    });
  }

  getConfigDataForRollover(rowData) {
    this.commonService.getConfiguredValues('CHECK_FACILITY_STATUS_ON_CLICK_ROLLOVER').subscribe(resp => {
      if (resp.response && resp.response === 'REST_API_SUCCESS') {
        if (resp.CHECK_FACILITY_STATUS_ON_CLICK_ROLLOVER === 'true'){
          this.listService
                .getFacilityDetail('/loan/listdef/customer/LN/getFacilityDetail',
                rowData.borrower_reference, rowData.bo_deal_id ).subscribe(facResponse => {
                  facResponse.rowDetails.forEach(facility => {
                    const filteredData = facility.index.filter(row => row.name === 'id'
                      && (this.commonService.decodeHtml(row.value) === rowData.bo_facility_id));
                    if (filteredData && filteredData.length > 0){
                      const filteredStatusData = facility.index.filter(row => row.name === 'status');
                      if (filteredStatusData[0].value === FccGlobalConstant.expired) {
                        const dir = localStorage.getItem('langDir');
                        const locaKeyValue = this.translateService.instant('rolloverErrorOnExpiredFacility');
                        const expiredFacDialog = this.dialogService.open(ConfirmationDialogComponent, {
                          header: `${this.translateService.instant('message')}`,
                          width: '35em',
                          styleClass: 'fileUploadClass',
                          style: { direction: dir },
                          data: { locaKey: locaKeyValue,
                            showOkButton: true,
                            showNoButton: false,
                            showYesButton: false
                          },
                          baseZIndex: 10010,
                          autoZIndex: true
                        });
                        expiredFacDialog.onClose.subscribe(() => {
                          //eslint : no-empty-function
                        });
                      } else {
                          this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
                            queryParams: {
                              productCode: FccGlobalConstant.PRODUCT_BK,
                              subProductCode: FccGlobalConstant.SUB_PRODUCT_LNRPN,
                              mode: FccGlobalConstant.INITIATE,
                              option: FccGlobalConstant.BK_LOAN_REPRICING,
                              tnxTypeCode: FccGlobalConstant.N002_NEW
                            },
                          });
                    }
                  }
                  });
                });
        } else {
            this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
              queryParams: {
                productCode: FccGlobalConstant.PRODUCT_BK,
                subProductCode: FccGlobalConstant.SUB_PRODUCT_LNRPN,
                mode: FccGlobalConstant.INITIATE,
                option: FccGlobalConstant.BK_LOAN_REPRICING,
                tnxTypeCode: FccGlobalConstant.N002_NEW
              },
            });
        }
      }
    });
  }

  onClickViews(event, rowData) {
    const url = this.router.serializeUrl(
      this.router.createUrlTree(['view'], { queryParams: { tnxid: rowData.tnxId, referenceid: rowData.refId,
        productCode: rowData.productCode, tnxTypeCode: rowData.tnxTypeCode,
        eventTnxStatCode: rowData.tnxStatCode, mode: FccGlobalConstant.VIEW_MODE,
        subTnxTypeCode: rowData.subTnxTypeCode,
        operation: FccGlobalConstant.PREVIEW } })
    );
    const popup = window.open('#' + url, '_blank', 'top=100,left=200,height=400,width=900,toolbar=no,resizable=no');
    const productId = `${this.translateService.instant(rowData.product_code)}`;
    const mainTitle = `${this.translateService.instant('MAIN_TITLE')}`;
    popup.onload = () => {
      popup.document.title = mainTitle + ' - ' + productId;
    };
}


  onClickView(event, rowData, actionvalue){
    // const url = 'reviewScreen?tnxid=21062600019247&referenceid=LN21060000014796&action=approve&mode=view&productCode=LN'
    // + '&subProductCode=LNDR';
    const url = this.router.serializeUrl(
      this.router.createUrlTree(['reviewScreen'], {
        queryParams: {
          tnxid: rowData.tnxId,
          referenceid: rowData.refId,
          mode: FccGlobalConstant.VIEW_MODE,
          productCode: rowData.productCodeVal,
          subProductCode: rowData.subProductCodeVal,
          operation: FccGlobalConstant.LIST_INQUIRY,
          hideTopMenu: FccGlobalConstant.HIDE_TOP_MENU
        }
      })
    );
    if (rowData && rowData.productCodeVal && (rowData.productCodeVal === FccGlobalConstant.PRODUCT_LN ||
      rowData.subProductCodeVal === FccGlobalConstant.SUB_PRODUCT_LNRPN
      || rowData.subProductCodeVal === FccGlobalConstant.SUB_PRODUCT_BLFP)) {
      this.router.navigate(['reviewScreen'], {
        queryParams: {
          tnxid: rowData.tnxId,
          referenceid: rowData.refId,
          action: actionvalue,
          mode: FccGlobalConstant.VIEW_MODE,
          productCode: rowData.productCodeVal,
          subProductCode: rowData.subProductCodeVal,
          operation: FccGlobalConstant.LIST_INQUIRY
        }
      });
    } else {
      window.open('#' + url, '_blank', 'top=100,left=200,height=800,width=900,toolbar=no,resizable=no');
    }
  }

  getColumnAction(action: any, acctionName: any){
    if (action.indexOf(acctionName) > -1){
      return true;
    }else{
      return false;
    }
  }

  checkLegend(legendName: string): boolean {
    const translatedLegendName = this.translateService.instant(legendName);
    return translatedLegendName === this.selectedLegend;
  }

  checkWidgetName(widgetName: string): boolean {
    return this.widgets.widgetName === widgetName;
  }

  setDirections(purpose: string, value: string): string {
    switch (purpose) {
      case 'className':
        return this.dir === 'rtl' ? 'ui-rtl' : 'none';
      case 'direction':
        return this.dir === 'rtl' ? 'left' : 'right';
      case 'paginatorDirection':
        return this.dir === 'rtl' ? (value === 'left' ? 'paginatorright' : 'paginatorleft') :
          (value === 'left' ? 'paginatorleft' : 'paginatorright');
      case 'colDirection':
        return this.dir === 'rtl' ? (value === 'left' ? 'right' : 'left') : value;
    }
  }
}
