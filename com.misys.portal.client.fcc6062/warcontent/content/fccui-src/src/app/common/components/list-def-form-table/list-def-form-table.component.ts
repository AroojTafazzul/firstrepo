import { Component, Input, OnInit } from '@angular/core';
import { CommonService } from '../../services/common.service';
import { FccConstants } from '../../core/fcc-constants';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { TranslateService } from '@ngx-translate/core';

@Component({
  selector: 'form-listdef-table',
  templateUrl: './list-def-form-table.component.html',
  styleUrls: ['./list-def-form-table.component.scss']
})
export class ListDefFormTableComponent implements OnInit {

  @Input() inputParams?: any = [];
  tableName = '';
  contextPath : string;
  showTable = false;
  
  constructor(protected commonService : CommonService, protected translateService: TranslateService) { }

  ngOnInit(): void {
    this.prepareBatchDetailsInputParams();
  }

  private prepareBatchDetailsInputParams() {
    const listdefName = 'listdefName';
    const showFilterSection = 'showFilterSection';
    const paginator = 'paginator';
    const downloadIconEnabled = 'downloadIconEnabled';
    const colFilterIconEnabled = 'colFilterIconEnabled';
    const passBackEnabled = 'passBackEnabled';
    const columnSort = 'columnSort';
    this.contextPath = this.commonService.getContextPath();
    const productCode = 'productCode';
    const filterParam = 'filterParams';
    const filterParamsRequired = 'filterParamsRequired';
    const filterChipsRequired = 'filterChipsRequired';
    const widgetName = 'widgetName';
    this.inputParams[listdefName] = FccConstants.BATCH_DETAILS_LISTDEF;
    this.inputParams[showFilterSection] = false;
    this.inputParams[paginator] = false;
    this.inputParams[downloadIconEnabled] = false;
    this.inputParams[colFilterIconEnabled] = false;
    this.inputParams[passBackEnabled] = false;
    this.inputParams[columnSort] = true;
    this.inputParams[productCode] = FccGlobalConstant.PRODUCT_BT;
    this.inputParams[filterParamsRequired] = false;
    this.inputParams[filterParam] = { paymentReferenceNumber: this.commonService.getQueryParametersFromKey('paymentReferenceNumber') };
    this.inputParams[filterChipsRequired] = false;
    this.inputParams[FccGlobalConstant.ENABLE_LIST_DATA_DOWNLOAD] = false;
    this.inputParams[widgetName] = this.translateService.instant('batchDetails');
    this.inputParams[FccGlobalConstant.WILDSEARCH] = false;
    this.showTable = true;
  }

  refreshTableData(){
    this.showTable = false;
    setTimeout( ()=> {
      this.prepareBatchDetailsInputParams();
    });
  }
}
