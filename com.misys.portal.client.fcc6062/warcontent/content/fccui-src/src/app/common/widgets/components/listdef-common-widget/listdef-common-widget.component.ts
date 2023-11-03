import { ChangeDetectorRef, Component, Input, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { Subscription } from 'rxjs';
import { ScreenMapping } from '../../../../base/model/screen-mapping';
import { ProductService } from '../../../../base/services/product.service';
import { GlobalDashboardComponent } from '../../../../common/components/global-dashboard/global-dashboard.component';
import { FccGlobalConstant } from '../../../../common/core/fcc-global-constants';
import { CommonService } from '../../../../common/services/common.service';
import { HideShowDeleteWidgetsService } from '../../../../common/services/hide-show-delete-widgets.service';
import { ListDataDownloadService } from '../../../../common/services/list-data-download.service';
import { NudgesService } from '../../../../common/services/nudges.service';
import { ListDefService } from '../../../services/listdef.service';
import { FccGlobalConstantService } from './../../../core/fcc-global-constant.service';
import { OPEN_CLOSE_ANIMATION } from './../../../model/animation';


@Component({
  selector: 'fcc-listdef-common-widget',
  templateUrl: './listdef-common-widget.component.html',
  styleUrls: ['./listdef-common-widget.component.scss'],
  animations: [OPEN_CLOSE_ANIMATION]
})
export class ListdefCommonWidgetComponent implements OnInit, OnDestroy {
  constructor(protected globalDashboardComponent: GlobalDashboardComponent,
              protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
              protected nudgesService: NudgesService,
              protected commonService: CommonService, protected router: Router,
              protected fccGlobalConstantService: FccGlobalConstantService,
              protected listDataDownloadService: ListDataDownloadService,
              protected translateService: TranslateService,
              protected changedetector: ChangeDetectorRef,
              protected productService: ProductService,
              protected listService: ListDefService
  ) { }
  static urlKeyMapping = {
    REF_ID: 'referenceid',
    TNX_ID: 'tnxId',
    TNX_TYPE_CODE: 'tnxtype',
    OPTION: 'option',
    OPERATION: 'operation',
    SUB_TNX_TYPE_CODE: 'subtnxtype',
    MODE: 'mode'
  };
  inputParams: any = {};
  checkCustomise: any;
  hideShowCard: any;
  classCheck: any;
  contextPath: any;
  url = '';
  @Input()
  widgetDetails: any;
  dojoPath = `${this.fccGlobalConstantService.servletName}/screen/`;
  header: string;
  widgetConfig;
  widgets;
  @Input() dashboardName;
  displayDashboardValue = false;
  eventData;
  nudges: any[] = [];
  nudgesRequired: any;
  widgetConfigData: any;
  viewAllurl: string;
  viewAllTnxPermission = false;
  defaultFilterCriteria: any = {};
  defaultFilterCriteriaSubscription: Subscription;
  displayTabs = false;
  tabsList: any;
  widgetCode: any;

  ngOnInit() {
    const dashboardTypeValue = 'dashboardTypeValue';
    const displayDashboard = 'displayDashboard';
    this.contextPath = this.commonService.getContextPath();
    this.widgets = this.widgetDetails ? JSON.parse(this.widgetDetails) : '';
    if (this.commonService.isNonEmptyValue(this.widgets.widgetConfig)) {
      this.widgetConfigData = JSON.parse(this.widgets.widgetConfig);
      if (this.widgetConfigData.drillDownEnabled) {
        this.inputParams[FccGlobalConstant.DRILL_DOWN_ENABLED] = this.widgetConfigData.drillDownEnabled;
        this.inputParams[FccGlobalConstant.DRILL_DOWN_TABLE_CONFIG] = this.widgetConfigData.drillDownTableConfig;
        this.inputParams[FccGlobalConstant.IS_PARENT_LIST] = true;
      }
    }

    if (this.commonService.isNonEmptyValue(this.widgetConfigData.tabs) &&
    this.widgetConfigData.tabs.length > 0 ) {
      this.displayTabs = true;
      this.widgetCode = FccGlobalConstant.PAYMENTAPPROVALWIDGET;
       // eslint-disable-next-line @typescript-eslint/no-unused-vars
      this.listService.getSectionTabDetails("", this.widgetCode).subscribe((resp) => {
        //eslint : no-empty-function
      });
       this.tabsList = this.widgetConfigData;
    } else {
      this.displayTabs = false;
    }

    this.nudgesRequired = this.commonService.isNonEmptyValue(this.widgetConfigData.enableNudges) ?
      this.widgetConfigData.enableNudges : false;
    if (this.nudgesRequired && this.commonService.isNonEmptyValue(this.widgets.widgetConfig)) {
      this.commonService.getNudges(this.widgetDetails).then(data => {
        this.nudges = data;
      });
    }
    this.header = this.widgets.widgetName;
    if (this.commonService.isnonEMptyString(this.widgetConfigData)
        && this.commonService.isnonEMptyString(this.widgetConfigData.viewAllPermission)){
      this.commonService.getUserPermission(this.widgetConfigData.viewAllPermission).subscribe(permission => {
        if (permission) {
          this.viewAllTnxPermission = true;
        }
      });
    }
    this.inputParams[FccGlobalConstant.IS_DASHBOARD_WIDGET] = true;
    this.inputParams[FccGlobalConstant.WIDGET_NAME] = this.commonService.isnonEMptyString(this.widgets) ?
      this.widgets.widgetName : FccGlobalConstant.LIST_DATA_TITLE;
    if (this.widgets !== '' && this.widgets.widgetConfig) {
      this.widgetConfig = JSON.parse(this.widgets.widgetConfig);
      const dashBoardURI = this.dashboardName.split('/');
      const dashboardType = dashBoardURI[dashBoardURI.length - 1].toUpperCase();
      this.inputParams[dashboardTypeValue] = dashboardType;
      this.displayDashboardValue = this.widgetConfig.tableConfig[displayDashboard];
      this.inputParams[FccGlobalConstant.ENABLE_LIST_DATA_DOWNLOAD] =
        this.commonService.isnonEMptyString(this.widgetConfig.tableConfig) ?
          this.widgetConfig.tableConfig[FccGlobalConstant.DOWNLOAD_ICON_ENABLED] : false;
      Object.keys(this.widgetConfig.tableConfig).forEach(element => {
        this.inputParams[element] = this.checkForBooleanValue(this.widgetConfig.tableConfig[element]);
        this.inputParams.isViewMore = this.widgetConfigData.tableConfig.isViewMore;
      });
    }
    this.commonService.dashboardOptionsSubject.subscribe(data => {
      this.classCheck = data;
    });

    this.hideShowDeleteWidgetsService.customiseSubject.subscribe(data => {
      this.checkCustomise = data;
    });
    this.commonService.dashboardWidget = true;
    this.setDefaultFilterCriteria();
  }



  setDefaultFilterCriteria() {
    this.defaultFilterCriteriaSubscription = this.commonService.dealDetailsBehaviourSubject.subscribe(filterValues => {
      if (filterValues !== null) {
        this.inputParams.skipRequest = false;
        this.defaultFilterCriteria[FccGlobalConstant.BO_DEAL_NAME] = filterValues.name;
        this.inputParams = { ...this.inputParams };
        this.inputParams[FccGlobalConstant.DEFAULT_CRITERIA] = this.defaultFilterCriteria;
      }
    });
  }

  deleteCards() {
    this.hideShowDeleteWidgetsService.listdefCommonComp.next(true);
    this.hideShowDeleteWidgetsService.listdefCommonComp.subscribe(
      res => {
        this.hideShowCard = res;
      }
    );
    setTimeout(() => {
      this.hideShowDeleteWidgetsService.getSmallWidgetActions(this.widgets.widgetName, this.widgets.widgetPosition);
      this.globalDashboardComponent.deleteCardLayout(this.widgets.widgetName);
    }, FccGlobalConstant.DELETE_TIMER_INTERVAL);
  }

  onClickViewAllTransactions() {
    const dashBoardURI = this.dashboardName.split('/');
    const dashboardNameVal = dashBoardURI[dashBoardURI.length - 1].toUpperCase();
    this.commonService.setWidgetClicked(dashboardNameVal);
    this.router.navigate(['productListing'], { queryParams: { dashboardType: dashboardNameVal, option: this.header } });
  }

  onRowSelect(event) {
    if (!this.displayDashboardValue) {
      let passback ;
      if (event.data) {
        passback = event.data.passbackParameters;
        this.eventData = event.data;
      } else {
        passback = event.selectedRowsData.passbackParameters;
        this.eventData = event.selectedRowsData;
      }
      const screenName = ScreenMapping.screenmappings[this.eventData.product_code];
      let urlParams = '?';
      let url = '';
      Object.keys(passback).forEach(element => {
        urlParams = `${urlParams}${ListdefCommonWidgetComponent.urlKeyMapping[element]}=${passback[element]}&`;
      });
      urlParams = urlParams.substring(0, urlParams.length - 1);
      if (this.eventData.product_code === FccGlobalConstant.PRODUCT_FT &&
        (this.eventData.sub_product_code_val === FccGlobalConstant.SUB_PRODUCT_CODE_BILLP
          || this.eventData.sub_product_code_val === FccGlobalConstant.SUB_PRODUCT_CODE_BILLS)) {
        urlParams = `${urlParams}&option=${this.eventData.sub_product_code_val}`;
      }
      if (this.contextPath !== undefined && this.contextPath !== null && this.contextPath !== '') {
        url = this.contextPath;
      }
      url = `${url}${this.dojoPath}${screenName}${urlParams}`;
      this.commonService.getSwiftVersionValue();
      if (this.commonService.isAngularProductUrl(this.eventData.product_code, this.eventData.sub_product_code_val)
        && (!(this.commonService.swiftVersion < FccGlobalConstant.SWIFT_2021 &&
          (this.eventData.product_code === FccGlobalConstant.PRODUCT_BG ||
            this.eventData.product_code === FccGlobalConstant.PRODUCT_BR)))) {
        if (passback.TNX_TYPE_CODE === FccGlobalConstant.N002_INQUIRE && passback.MODE !== FccGlobalConstant.UNSIGNED) {
          this.router.navigate([FccGlobalConstant.PRODUCT_SCREEN], {
            queryParams: {
              refId: this.eventData.ref_id,
              tnxId: this.eventData.tnx_id, productCode: this.eventData.product_code, subProductCode: this.eventData.sub_product_code_val,
              tnxTypeCode: passback.TNX_TYPE_CODE,
              option: FccGlobalConstant.ACTION_REQUIRED
            }
          });
        } else if (passback.MODE === FccGlobalConstant.UNSIGNED && this.eventData.product_code === FccGlobalConstant.PRODUCT_TD) {
          this.router.navigate([FccGlobalConstant.REVIEW_SCREEN], {
            queryParams: {
              referenceid: this.eventData.ref_id,
              tnxid: this.eventData.tnx_id, productCode: this.eventData.product_code, subProductCode: this.eventData.sub_product_code_val,
              tnxTypeCode: passback.TNX_TYPE_CODE,
              mode: FccGlobalConstant.VIEW_MODE, operation: FccGlobalConstant.LIST_INQUIRY, action: FccGlobalConstant.APPROVE
            }
          });
        } else if (passback.MODE === FccGlobalConstant.UNSIGNED) {
          this.router.navigate([FccGlobalConstant.REVIEW_SCREEN], {
            queryParams: {
              referenceid: this.eventData.ref_id,
              tnxid: this.eventData.tnx_id, productCode: this.eventData.product_code, subProductCode: this.eventData.sub_product_code_val,
              mode: FccGlobalConstant.VIEW_MODE, operation: FccGlobalConstant.LIST_INQUIRY, action: FccGlobalConstant.APPROVE,
              tnxTypeCode: passback.TNX_TYPE_CODE
            }
          });
        }
      } else {
        this.router.navigate([]).then(() => {
          window.open(url, '_self');
        });
      }
    }
  }

  onClickViewAll() {
    if (this.widgetConfigData.tableConfig && this.widgetConfigData.tableConfig.viewAll) {
      this.commonService.redirectToLink(this.widgetConfigData.tableConfig.viewAll);
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
  ngOnDestroy(){
    if(this.defaultFilterCriteriaSubscription) {
      this.defaultFilterCriteriaSubscription.unsubscribe();
    }
    this.commonService.dashboardWidget = false;
  }
}
