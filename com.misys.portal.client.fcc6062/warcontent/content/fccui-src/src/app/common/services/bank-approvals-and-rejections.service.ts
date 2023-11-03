import { Injectable } from '@angular/core';
import { FccGlobalConfiguration } from '../core/fcc-global-configuration';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from './common.service';
import { FccGlobalConstant } from '../core/fcc-global-constants';
import { StaticTranslateLoader } from '../core/StaticTranslateLoader';
import { GraphColorService } from './graph-color.service';

@Injectable({
  providedIn: 'root'
})
export class BankApprovalsAndRejectionsService {
  constructor(protected translateService: TranslateService, protected commonService: CommonService,
              protected graphColorService: GraphColorService) { }

  public static dataAvailable = false;
  productsList: any;
  approvalsList: any[] = [];
  tnxCount = [];
  colors = [];
  legendsList: any[] = [];
  legends: any[] = [];
  totalCount = [];
  borderColors = [];
  polarArea = 'polarArea';
  rowCount = FccGlobalConfiguration.configurationValues.get('BANK_APPROVAL_AND_REJECTION_ROW_COUNT');
  colorsList: any[] = this.graphColorService.colorsList;
  borderColorsList: any[] = this.graphColorService.borderColorsList;


  polarAreaChartOptions: any = {
    tooltips: {
      bodyFontFamily: FccGlobalConstant.CHART_FONT_FAMILY,
      callbacks: {
        label(tooltipItem, data) {
          return `${StaticTranslateLoader.translation.instant('noOfTransactions')} ${data.labels[tooltipItem.index]}`;
        }
      }
    },
    legend: {
      display: true,
      position: 'bottom',
      align: 'start',
      onClick: e => e.stopPropagation(),
      labels: {
        boxWidth : 6,
        fontColor: 'black',
        fontFamily: FccGlobalConstant.CHART_FONT_FAMILY,
        usePointStyle: true
      }
    },
    layout: {
      padding: {
        top: 50,
        bottom: 50,
        right: 20
      }
    },
    labels: {
      position: '#777777'
    },
    scale: {
      display: false,
      ticks: {
        fontSize: 14,
        fontStyle: 'bold'

      },
      pointLabels: {
        display: false
     }
    },
    plugins: {
      limitCenterText: false,
      datalabels: {
        display: false,
        anchor: 'end',
        align: 'end',
        color: '#777777',
        formatter(value) {
          return parseInt(value, 10).toLocaleString();
        },
        font: {
          weight: 500,
          family: 'Roboto',
          size: 12
        }
      }
    },
    options: {
      events: ['click']
  }
  };


  getTransactionsList(product: string, response: any, isGlobalDashboard: boolean): any[] {
    this.approvalsList = [];
    if (response.approvedTransactionsCount[product] !== undefined ) {
    BankApprovalsAndRejectionsService.dataAvailable = true;
    this.productsList = response.approvedTransactionsCount[product].subProducts.split(',');
    let breakloop = false;
    for (let i = 0; i < this.productsList.length; i++) {
        const transactions = response.approvedTransactionsList[product][this.productsList[i]];
        for (let j = 0; j < transactions.length; j++) {
          if (this.approvalsList.length === +this.rowCount ) {
            breakloop = true;
            break;
          } else {
            this.approvalsList.push({
              referenceId: transactions[j].ref_id,
              subProductCode: transactions[j].sub_product_code_val,
              entity: this.commonService.decodeHtml(transactions[j].entity),
              counterparty: this.commonService.decodeHtml(transactions[j].counterparty_name),
              tnxId: transactions[j].tnx_id,
              facility: this.commonService.decodeHtml(transactions[j].bo_facility_name),
              boRefId: this.commonService.decodeHtml(transactions[j].bo_ref_id),
              curCode: transactions[j].cur_code,
              tnxAmt: transactions[j].tnx_amt,
              tnxTypeCode: transactions[j].tnx_type_code,
              tnxStatCode: transactions[j].tnx_stat_code_val,
              subTnxTypeCode: transactions[j].sub_tnx_type_code
            });
          }


        }
        if (breakloop || !isGlobalDashboard) {
          break;
        }
      }

    }
    return this.approvalsList;
    }

    getProductWiseTransactionsList(product: string, response: any, legendName: string, isGlobalDashboard: boolean): any[] {
      this.approvalsList = [];
      if (product === '') {
        this.approvalsList = this.getTransactionsList(legendName, response, isGlobalDashboard);
      } else {
        const transactions = response.approvedTransactionsList[product][legendName];
        for (let i = 0; i < transactions.length; i++) {
          if (this.approvalsList.length === +this.rowCount ) {
            break;
          } else {
            this.approvalsList.push({
              referenceId: transactions[i].ref_id,
              entity: this.commonService.decodeHtml(transactions[i].entity),
              counterparty: this.commonService.decodeHtml(transactions[i].counterparty_name),
              tnxId: transactions[i].tnx_id,
              subProductCode: transactions[i].sub_product_code_val,
              facility: this.commonService.decodeHtml(transactions[i].bo_facility_name),
              boRefId: this.commonService.decodeHtml(transactions[i].bo_ref_id),
              curCode: transactions[i].cur_code,
              tnxAmt: transactions[i].tnx_amt,
              tnxTypeCode: transactions[i].tnx_type_code,
              tnxStatCode: transactions[i].tnx_stat_code_val,
              subTnxTypeCode: transactions[i].sub_tnx_type_code
            });
          }

        }


      }
      return this.approvalsList;

    }
    getTransactionCount(isGlobalDashboard: boolean, product: string, response: any): Map<string, any[]> {
      const count = new Map<string, any[]>();
      let eachProductCount = 0;
      this.totalCount = [];
      if (BankApprovalsAndRejectionsService.dataAvailable && isGlobalDashboard) {
        this.tnxCount = [];
        this.legendsList = [];
        this.legends = [];
        this.colors = [];
        this.borderColors = [];
        this.legendsList = response.products.split(',');
        for (let i = 0; i < this.legendsList.length; i++) {
        this.legends.push(this.legendsList[i]);
        this.tnxCount.push( response.approvedTransactionsCount[this.legendsList[i]].totalCount);
        this.colors.push(this.colorsList[i]);
        this.borderColors.push(this.borderColorsList[i]);
        eachProductCount = eachProductCount + Number(response.approvedTransactionsCount[this.legendsList[i]].totalCount);
       }
      } else if (BankApprovalsAndRejectionsService.dataAvailable) {
        this.tnxCount = [];
        this.legendsList = [];
        this.legends = [];
        this.colors = [];
        this.borderColors = [];
        this.legendsList = response.approvedTransactionsCount[product].subProducts.split(',');
        for (let i = 0; i < this.legendsList.length; i++) {
       this.legends.push(this.translateService.instant(this.legendsList[i]));
       this.tnxCount.push( response.approvedTransactionsCount[product][this.legendsList[i]]);
       this.colors.push(this.colorsList[i]);
       this.borderColors.push(this.borderColorsList[i]);
       eachProductCount = eachProductCount + Number(response.approvedTransactionsCount[product][this.legendsList[i]]);
       }
      }
      this.totalCount.push(eachProductCount);
      count.set('tnxCount', this.tnxCount);
      count.set('legendsList', this.legends);
      count.set('colors', this.colors);
      count.set('totalCount', this.totalCount);
      count.set('borderColors', this.borderColors);
      count.set('productCodes', this.legendsList);
      return count;
    }

    getPolarAreaData(
      labels: string[],
      data: string[],
      legend: string,
      backgroundColorPolar: string[],
      borderColorPolar: string[]
          ) {
      const jsonString: string =
        '{' +
        '"labels": ' +
        JSON.stringify(labels) +
        ',' +
        '"datasets": [' +
        '{' +
        '"label": "' +
        legend +
        '",' +
        '"backgroundColor": ' +
        JSON.stringify(backgroundColorPolar) +
        ',' +
         '"borderColor": ' +
         JSON.stringify(borderColorPolar) +
         ',' +
        '"data": ' +
        JSON.stringify(data) +
        '}]}';
      const chartData = JSON.parse(jsonString);
      return chartData;
    }



}
