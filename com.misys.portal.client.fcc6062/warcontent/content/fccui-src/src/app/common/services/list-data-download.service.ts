import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from './common.service';
import { PdfGeneratorService } from './pdf-generator.service';
import { FccGlobalConstant } from '../core/fcc-global-constants';
import { ListDefService } from './listdef.service';
import { Workbook } from 'exceljs';
import { saveAs } from 'file-saver';
import { DatePipe } from '@angular/common';
import { UtilityService } from '../../corporate/trade/lc/initiation/services/utility.service';

@Injectable({
    providedIn: 'root'
})

export class ListDataDownloadService {
    private language = this.translate.currentLang;
    private downloadOption: any;
    private pdfMode: any;
    private listDataDownloadLimit: any;
    private completeTableData;
    private tableName: any;
    private tableHeaders: any[] = [];
    private tableHeadersCSV: any[] = [];
    private tableData: any;
    private dateFormatForExcelDownload: any;
    private excludeColumns = [FccGlobalConstant.ACTION];
    private columnHeader: any;
    private columnData: any;
    private isGroupsDownload: boolean;
    private groupTableData: any;
    private groupDetails: any;
    private setPaymentsRemarks = false;
    private displayNote: any;
    private setPaymentsRepairRejectRemarksHeaders: any;
    private setPaymentsRepairRejectRemarksData: any;
    private bankDetails: string[] = [];
    private paymentsBulk = false;
    private selectedColHeader = [];
    currencySymbolDisplayEnabled = false;

    constructor(protected translate: TranslateService, protected commonService: CommonService,
                protected pdfGeneratorService: PdfGeneratorService, protected listService: ListDefService,
                public datePipe: DatePipe,
                protected utilityService: UtilityService) {
                  this.commonService.getBankDetails().subscribe(data => {
                    this.bankDetails = data as string[];
                  });
                  this.commonService.getBankContextParameterConfiguredValues(FccGlobalConstant.PARAMETER_P809).subscribe(
                    (response) => {
                      if (this.commonService.isNonEmptyValue(response) &&
                      this.commonService.isNonEmptyValue(response.paramDataList)) {
                        this.currencySymbolDisplayEnabled = response.paramDataList[0][FccGlobalConstant.DATA_1] === 'y';
                      }
                    }
                  );
                }

  checkListDataDownloadOption(downloadOption: any, colHeader: any, colData: any, widgetDetails: any,
                              maxColForPDFMode?: any, excelDateFormat?: any, maxDataDownload?: any) {

    if (widgetDetails && widgetDetails.dashboardType !== FccGlobalConstant.TREASURY && widgetDetails.option !== FccGlobalConstant.GENERAL &&
       this.commonService.isnonEMptyString(widgetDetails.exportFileName)) {
        this.tableName = widgetDetails.exportFileName;
    } else if(widgetDetails && widgetDetails.dashboardType === FccGlobalConstant.TREASURY &&
       widgetDetails.option !== FccGlobalConstant.GENERAL){
        this.tableName = `${widgetDetails.option}TreasuryList`;
    } else if(widgetDetails && widgetDetails.dashboardType && !this.commonService.isnonEMptyString(widgetDetails.exportFileName)
      && (widgetDetails.activeTab.index === '0' || widgetDetails.activeTab.localizationKey === this.translate.instant('all'))){
        this.tableName = `${widgetDetails.option}AllList`;
    } else {
      if (this.language === FccGlobalConstant.LANGUAGE_AR) {
        if (widgetDetails.option === 'BL') {
          this.tableName = (widgetDetails && widgetDetails.widgetName) ? widgetDetails.widgetName :
            widgetDetails.activeTab.localizationKey ? `${widgetDetails.activeTab.localizationKey}` + `${widgetDetails.option}List` +
              `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
              FccGlobalConstant.LIST_DATA_TITLE;
        }
        this.tableName = (widgetDetails && widgetDetails.widgetName) ? widgetDetails.widgetName :
          widgetDetails.activeTab.localizationKey ? `${widgetDetails.activeTab.localizationKey}` + `${widgetDetails.productCode}List` +
            `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
            FccGlobalConstant.LIST_DATA_TITLE;
      } else {
        if (widgetDetails.option === 'BL' ) {
          this.tableName = (widgetDetails && widgetDetails.widgetName && widgetDetails.widgetName !== FccGlobalConstant.CHEQUE_TITLE) ?
            widgetDetails.widgetName :
            (widgetDetails.activeTab && widgetDetails.activeTab.localizationKeyPdf) ?
              `${widgetDetails.activeTab.localizationKeyPdf}` + `${widgetDetails.option}List` +
              `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
              widgetDetails.activeTab.localizationKey ? `${widgetDetails.activeTab.localizationKey}` 
              + `${widgetDetails.productCode}List` +
                `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
                FccGlobalConstant.LIST_DATA_TITLE;
        } 
        else if (widgetDetails.subProductCode === 'LNFP' ) {
          this.tableName = (widgetDetails && widgetDetails.widgetName && widgetDetails.widgetName !== FccGlobalConstant.CHEQUE_TITLE) ?
            widgetDetails.widgetName :
            (widgetDetails.activeTab && widgetDetails.activeTab.localizationKeyPdf) ?
              `${widgetDetails.activeTab.localizationKeyPdf}` + `${widgetDetails.subProductCode}List` +
              `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
              widgetDetails.activeTab.localizationKey ? `${widgetDetails.activeTab.localizationKey}` 
              + `${widgetDetails.subProductCode}List` +
                `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
                FccGlobalConstant.LIST_DATA_TITLE;
        }
        else {
          this.tableName = (widgetDetails && widgetDetails.widgetName 
            && widgetDetails.widgetName !== FccGlobalConstant.CHEQUE_TITLE) ?
            widgetDetails.widgetName :
            (widgetDetails.activeTab && widgetDetails.activeTab.localizationKeyPdf) ?
              `${widgetDetails.activeTab.localizationKeyPdf}` + `${widgetDetails.productCode}List` +
              `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
              widgetDetails.activeTab.localizationKey ? `${widgetDetails.activeTab.localizationKey}` 
              + `${widgetDetails.productCode}List` +
                `${widgetDetails.activeTab.extraPdfTitle ? widgetDetails.activeTab.extraPdfTitle : ''}` :
                FccGlobalConstant.LIST_DATA_TITLE;
        }
      }
    }

    if (widgetDetails && widgetDetails.appendTabNameDownloadHeader)
    {
      this.tableName = this.tableName + '_' + widgetDetails.tabName;
    }

    this.downloadOption = downloadOption;
    this.dateFormatForExcelDownload = excelDateFormat;
    /* deep copy */
    this.columnHeader = JSON.parse(JSON.stringify(colHeader));
    this.columnData = JSON.parse(JSON.stringify(colData));
    this.listDataDownloadLimit = maxDataDownload;
    if (maxColForPDFMode && maxColForPDFMode < this.columnHeader.length) {
      this.pdfMode = FccGlobalConstant.PDF_MODE_LANDSCAPE;
    } else {
      this.pdfMode = FccGlobalConstant.PDF_MODE_PORTRAIT;
    }
    this.isGroupsDownload = false;
    switch (this.downloadOption) {
      case FccGlobalConstant.PDF_FULL_DOWNLOAD:
      case FccGlobalConstant.EXCEL_FULL_DOWNLOAD:
      case FccGlobalConstant.CSV_FULL_DOWNLOAD:
        this.fetchCompleteTableData(widgetDetails);
        break;
      case FccGlobalConstant.PDF_CURRENT_DOWNLOAD:
        this.formatListData(this.columnHeader, this.columnData);
        this.pdfGeneratorService.createListDataPDF(this.pdfMode, this.tableHeaders, this.tableData,
          this.selectedColHeader, this.columnData, this.tableName, null, null, widgetDetails.productCode);
        break;
      case FccGlobalConstant.EXCEL_CURRENT_DOWNLOAD:
        this.formatListData(this.columnHeader, this.columnData);
        this.createListDataExcel();
        break;
      case FccGlobalConstant.CSV_CURRENT_DOWNLOAD:
        this.formatListData(this.columnHeader, this.columnData);
        this.createListDataCSV();
        break;
    }
  }

  createDataForMergeFileds(header: any, data: any) {
   header.forEach(col => {
    if (this.commonService.isnonEMptyString(col.separator)) {
        data.forEach(ele => {
        const clubbedList = col.clubbedFieldsList.split(',');
          if (col.separator === FccGlobalConstant.CLUBBED_DATA) {
            col.separator = FccGlobalConstant.SEPARATOR_ENTER;
          }
          let separatorText = '';
          if (col.field === FccGlobalConstant.CONTORL_SUM) {
            separatorText = this.translate.instant('batchCount') + ': ';
          }
        const delimiter = col.separator === FccGlobalConstant.SEPARATOR_ENTER ?
        FccGlobalConstant.NEXT_LINE : col.separator;
        let clubbedString = '';
          let flag = false;
        if (delimiter === FccGlobalConstant.NEXT_LINE) {
        clubbedList.forEach((field, index) => {
           if (index < 1) {
            const str = ele[field];
            if (!str.includes(FccGlobalConstant.NEXT_LINE)) {
              clubbedString = ele[field] === '' ? FccGlobalConstant.SAMPLE_COMMENT : ele[col.field];
            } else {
              flag = true;
            }
           } else {
            if (!ele[field].includes(FccGlobalConstant.NEXT_LINE)) {
              const str = ele[field] === '' ? FccGlobalConstant.SAMPLE_COMMENT : ele[field];
               clubbedString = clubbedString +FccGlobalConstant.NEXT_LINE + separatorText +str;
               } else {
                 flag = true;
            }
           }
         });
         if (!flag) {
         ele[clubbedList[0]] = clubbedString;
         }
        } else {
          ele[col.field] = '';
          clubbedList.forEach((field, index) => {
           if (index < 1){
               ele[col.field] = ele[field];
             } else {
               ele[col.field] = (ele[col.field] === '' ? FccGlobalConstant.SAMPLE_COMMENT : ele[col.field])
               + delimiter +separatorText+ ele[field] ;
             }
           });
        }
       });

       col.separator = FccGlobalConstant.CLUBBED_DATA;
      }
    });
 }

  formatListData(colHeader, colData) {
    const downloadOption = this.downloadOption.toLowerCase();
    const sum = 'controlSum';
    const amt = ['amt', 'tnx_amt', sum, 'maturity_amount', 'principal_amount', 'RunningStatement@AvailableBalance@amt',
    'convertedPrincipal_amount', 'RunningStatement@AvailableBalance@convertedAmt', 'convertedMaturity_amount'];
    let value;
    if (this.tableName !== 'ALL_ACCOUNTS' && this.currencySymbolDisplayEnabled && downloadOption.indexOf('current') > -1 &&
    !(downloadOption.indexOf('pdf') > -1)) {
      colData.forEach(element => {
        value = element;
        Object.keys(element).forEach(ele => {
          if (amt.indexOf(ele) > -1) {
            const val = value[ele]?.split(' ');
            if (val.length > 1) {
              element[ele] = `${val[1]} ${val[0]}`;
            }
          }
        });
      });
    } else if (this.tableName !== 'ALL_ACCOUNTS' && this.currencySymbolDisplayEnabled &&
    downloadOption.indexOf('current') > -1 && downloadOption.indexOf('pdf') > -1) {
      const applicableAmtKeys = amt.splice(2);
      colData.forEach(element => {
        value = element;
        Object.keys(element).forEach(ele => {
          if (applicableAmtKeys.indexOf(ele) > -1) {
            const val = value[ele]?.split(' ');
            if (val.length > 1) {
              element[ele] = `${val[1]} ${val[0]}`;
            }
          }
        });
      });
    }
    if (this.commonService.isnonEMptyString(colHeader) && colHeader.length > FccGlobalConstant.ZERO) {
      this.createDataForMergeFileds(this.columnHeader?this.columnHeader:colHeader, this.columnData?this.columnData:colData);
      let tableHeaderList: any[] = [];
      this.tableHeaders = [];
      this.tableHeadersCSV = [];
      this.selectedColHeader = [];
      for (const columnName of colHeader) {
        if (this.excludeColumns.indexOf(columnName.field) === -1 && columnName.showAsDefault) {
          const col = {};
          tableHeaderList.push(columnName.field);
          const translatedValue = columnName.header;
          col[FccGlobalConstant.TABLE_HEADER] = columnName.header;
          this.tableHeadersCSV.push(col);
          this.tableHeaders.push(translatedValue);
          this.selectedColHeader.push(columnName);
        }
      }
      if (this.language === FccGlobalConstant.LANGUAGE_AR && !this.downloadOption.includes(FccGlobalConstant.EXCEL)) {
        this.tableHeaders = this.reverseTableContent(this.tableHeaders);
        tableHeaderList = this.reverseTableContent(tableHeaderList);
        this.tableHeadersCSV = this.reverseTableContent(this.tableHeadersCSV);
        this.columnHeader = this.reverseTableContent(this.columnHeader);
      }
      if (this.isGroupsDownload && colData.length > FccGlobalConstant.ZERO) {
        this.groupTableData = [];
        colData.forEach(group => {
          this.setListTableData(group, tableHeaderList);
          this.groupTableData.push(this.tableData);
        });
      } else {
        if(this.downloadOption !== FccGlobalConstant.PDF_CURRENT_DOWNLOAD) {
          this.setListTableData(colData, tableHeaderList);
        }
      }
    }
  }

  reverseTableContent(DataArray: string[]) {
    const DataArrayLength = DataArray.length;
    const DataArrayArabic: string[] = [];
    for (let i = 0; i < DataArrayLength; i++) {
      DataArrayArabic.push(DataArray.pop());
    }
    return DataArrayArabic;
  }

  fetchCompleteTableData(widgetDetails: any) {
    const dashboardType = {};
    const listDefName = widgetDetails ? widgetDetails.listdefName : FccGlobalConstant.EMPTY_STRING;
    if (this.commonService.isnonEMptyString(widgetDetails)) {
      if (this.commonService.isnonEMptyString(widgetDetails.dashboardType)) {
        dashboardType[FccGlobalConstant.DASHBOARD_TYPE] = widgetDetails.dashboardType;
      } else {
        dashboardType[FccGlobalConstant.DASHBOARD_TYPE] = widgetDetails.dashboardTypeValue;
      }
      if (this.commonService.isnonEMptyString(widgetDetails.accountType)) {
        dashboardType[FccGlobalConstant.ACCOUNT_TYPE] = widgetDetails.accountType;
      }
      if (this.commonService.isnonEMptyString(widgetDetails.baseCurrency)) {
        dashboardType[FccGlobalConstant.BASE_CURRENCY_APPLICABILITY] = widgetDetails.baseCurrency;
      }
    }
    const defaultFilterValues = JSON.stringify(dashboardType);
    const filterParams = this.commonService.isnonEMptyString(this.commonService.listDataFilterParams) ?
    this.commonService.listDataFilterParams : defaultFilterValues;
    const paginatorParams = { first: 0, rows: this.listDataDownloadLimit, sortOrder: undefined, filters: {}, globalFilter: null };
    this.listService.getTableData(listDefName, filterParams , JSON.stringify(paginatorParams))
      .subscribe(result => {
      this.setTableData(result);
    });
  }

  setTableData(tableresponse: any) {
    const tempTableData = tableresponse.rowDetails;
    if (tempTableData) {
      this.completeTableData = [];
      tempTableData.forEach(element => {
        const obj = {};
        const amt = 'amt';
        const curCode = 'cur_code';
        const tnxAmt = 'tnx_amt';
        const sum = 'controlSum';
        const ccy = 'debtorAccount@currency';
        const matAmount = 'maturity_amount';
        const prinAmount = 'principal_amount';
        const balAmt = 'RunningStatement@AvailableBalance@amt';
        const baseCurrency = this.commonService.getBaseCurrency();
        const convertedPrincipalAmount = 'convertedPrincipal_amount';
        const convertedAmount = 'RunningStatement@AvailableBalance@convertedAmt';
        const convertedMaturityAmount = 'convertedMaturity_amount';
        let amountField;
        let amount;
        let currencyCode;
        let valueToCheck;
        element.index.forEach(ele => {
          if (amt === ele.name || tnxAmt === ele.name || ele.name === 'ft_amt') {
            amountField = ele.name;
            amount = ele.value;
          }
          if (curCode === ele.name || ele.name === 'ft_cur_code') {
            currencyCode = ele.value;
          }
          valueToCheck = (this.commonService.isNonEmptyValue(ele.displayValue) &&
          this.commonService.isNonEmptyValue(ele.showdisplayValue)) ? ele.displayValue : ele.value;
          valueToCheck = (this.commonService.isNonEmptyValue(ele.groupedValues))
                          ? this.commonService.formatGroupedColumns(FccGlobalConstant.EXPORT_LIST, ele.groupedValues) :
                            valueToCheck;
          obj[ele.name] = valueToCheck ? this.commonService.decodeHtml(valueToCheck) : FccGlobalConstant.SAMPLE_COMMENT;
        });
        if (this.downloadOption.toLowerCase().indexOf('pdf') > -1) {
          obj[amountField] = this.commonService.getCurrencyFormatedAmountForListdef(
            currencyCode, amount, this.currencySymbolDisplayEnabled);
        } else {
          obj[amountField] = this.commonService.getCurrencyFormatedAmount(currencyCode, amount, this.currencySymbolDisplayEnabled);
        }
        obj[sum] = this.commonService.getCurrencyFormatedAmount(obj[ccy], obj[sum], this.currencySymbolDisplayEnabled);
        obj[prinAmount] = this.commonService.getCurrencyFormatedAmount(
          obj[curCode], obj[prinAmount], this.currencySymbolDisplayEnabled);
        obj[matAmount] = this.commonService.getCurrencyFormatedAmount(obj[curCode], obj[matAmount], this.currencySymbolDisplayEnabled);
        obj[balAmt] = this.commonService.getCurrencyFormatedAmount(obj[curCode], obj[balAmt], this.currencySymbolDisplayEnabled);
        obj[convertedPrincipalAmount] = this.commonService.getCurrencyFormatedAmount(
          baseCurrency, obj[convertedPrincipalAmount], this.currencySymbolDisplayEnabled);
        obj[convertedAmount] = this.commonService.getCurrencyFormatedAmount(
          baseCurrency, obj[convertedAmount], this.currencySymbolDisplayEnabled);
        obj[convertedMaturityAmount] = this.commonService.getCurrencyFormatedAmount(
          baseCurrency, obj[convertedMaturityAmount], this.currencySymbolDisplayEnabled);
        this.completeTableData.push(obj);
      });
    }
    if (this.completeTableData && this.completeTableData.length > FccGlobalConstant.ZERO) {
      this.columnData = this.completeTableData;
    }
    this.formatListData(this.columnHeader, this.columnData);
    this.checkFullDownloadExcelOrPDFOrCSV();
  }

  createBulkPaymentExcel(tableHeader, headers, data, remarksHeader, remarksData, setRemarks) {
    this.tableName = tableHeader;
    this.tableHeaders = headers;
    this.tableData = data;
    this.setPaymentsRemarks = setRemarks;
    this.setPaymentsRepairRejectRemarksHeaders = remarksHeader;
    this.setPaymentsRepairRejectRemarksData = remarksData;
    this.paymentsBulk = true;
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.dateFormatForExcelDownload = response.listDataExcelDateFormat;
     }
    });
    this.createListDataExcel();
  }

  createListDataExcel() {
    const workbook = new Workbook();
    const worksheet = workbook.addWorksheet(this.translate.instant(this.tableName));
    const titleRow = worksheet.addRow([this.translate.instant(this.tableName)]);
    worksheet.mergeCells('A1:R1');
    titleRow.font = {
      size: 16,
      bold: true
    };
    titleRow.alignment = {
      vertical: 'middle', horizontal: 'center'
    };
    worksheet.addRow([]);
    const imageBase64Logo = this.pdfGeneratorService.getHeaderLogoForExcel();
    const imageLogoId = workbook.addImage({
      base64: imageBase64Logo,
      extension: 'png',
    });
    worksheet.addImage(imageLogoId, 'A2:C6');
    worksheet.mergeCells('A2:C6');
    worksheet.addRow([]);
    const name = 'name';
    const swiftAddress = 'SWIFTAddress';
    const isoCode = 'isoCode';
    if (this.bankDetails[name] && this.bankDetails[name] !== '' && this.bankDetails[name] != null) {
      worksheet.addRow([this.bankDetails[name]]);
    }
    if (this.bankDetails[swiftAddress].line1 && this.bankDetails[swiftAddress].line1 !== ''
      && this.bankDetails[swiftAddress].line1 != null) {
      worksheet.addRow([this.bankDetails[swiftAddress].line1]);
      }
    if (this.bankDetails[swiftAddress].line2 && this.bankDetails[swiftAddress].line2 !== ''
      && this.bankDetails[swiftAddress].line2 != null) {
      worksheet.addRow([this.bankDetails[swiftAddress].line2]);
      }
    if (this.bankDetails[swiftAddress].line3 && this.bankDetails[swiftAddress].line3 !== ''
      && this.bankDetails[swiftAddress].line3 != null) {
      worksheet.addRow([this.bankDetails[swiftAddress].line3]);
      }
    if (this.bankDetails[isoCode] && this.bankDetails[isoCode] !== null) {
      const swiftBold = worksheet.addRow([this.translate.instant('SWIFT')]);
      swiftBold.font={
        bold:true
      };
      worksheet.addRow([this.bankDetails[isoCode]]);
    }
    const downloadDate = new Date();
    const dateValue = this.datePipe.transform(downloadDate, this.dateFormatForExcelDownload);
    const timeValue = this.datePipe.transform(downloadDate, 'mediumTime');
    const dateFormatMessage = this.translate.instant('dateFollows') + ' ' + this.utilityService.getDisplayDateFormat();
    const dateFormatMessageAr = this.utilityService.getDisplayDateFormat() + ' ' + this.translate.instant('dateFollows');
    if(this.language === FccGlobalConstant.LANGUAGE_AR){
      worksheet.addRow(['','','','','','','',dateValue + ' ' + this.translate.instant(FccGlobalConstant.DOWNLOAD_DATE)]);
      worksheet.addRow(['','','','','','','',timeValue + ' ' + this.translate.instant(FccGlobalConstant.DOWNLOAD_TIME)]);
      worksheet.addRow(['','','','','','','',dateFormatMessageAr]).font={
        italic : true
      };
    } else {
      worksheet.addRow(['','','','','','','',this.translate.instant(FccGlobalConstant.DOWNLOAD_DATE) + ' ' + dateValue]);
      worksheet.addRow(['','','','','','','',this.translate.instant(FccGlobalConstant.DOWNLOAD_TIME) + ' ' + timeValue]);
      worksheet.addRow(['','','','','','','',dateFormatMessage]).font={
        italic : true
      };
    }
    worksheet.addRow([]);
    worksheet.addRow(this.tableHeaders);
        if (!this.paymentsBulk) {
      const dataRows = worksheet.addRows(this.tableData);
      dataRows.forEach(function(dataRow) {
        dataRow.alignment = { vertical: 'middle', wrapText: true };
      });
    } else {
      worksheet.addRow(this.tableData);
      this.paymentsBulk = false;
    }

    if (this.setPaymentsRemarks) {
      worksheet.addRow([]);
      worksheet.addRow(this.setPaymentsRepairRejectRemarksHeaders);
      const dataRows = worksheet.addRows(this.setPaymentsRepairRejectRemarksData);
      dataRows.forEach(function(dataRow) {
        dataRow.alignment = { vertical: 'middle', wrapText: true };
      });
    }



    if (this.language === FccGlobalConstant.LANGUAGE_AR) {
      worksheet.views = [
        { rightToLeft: true }
      ];
    }
    workbook.xlsx.writeBuffer().then((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      saveAs(blob, `${this.translate.instant(this.tableName)}.xlsx`);
    });
  }

  createGroupListDataExcel() {
    const workbook = new Workbook();
    const worksheet = [];
    if (this.groupDetails.length === this.groupTableData.length) {
      for (let i = 0; i < this.groupDetails.length; i++) {
        worksheet[i] = workbook.addWorksheet(this.translate.instant(this.groupDetails[i].groupName));
        const titleRow = worksheet[i].addRow([this.translate.instant(this.groupDetails[FccGlobalConstant.GROUP_TITLE])]);
        worksheet[i].mergeCells('A1:R1');
        titleRow.font = {
          size: 16,
          bold: true
        };
        titleRow.alignment = {
          vertical: 'middle', horizontal: 'center'
        };
        worksheet[i].addRow([this.translate.instant('total'), `${this.translate.instant('numberOfAccounts',
        { noOfAccounts: this.groupDetails[i].groupAccountCount })}`]);
        worksheet[i].addRow([this.translate.instant(this.groupDetails[i].groupName), this.groupDetails[i].displayTotalAmtBalance]);
        worksheet[i].addRow([]);
        const downloadDate = new Date();
        const dateValue = this.datePipe.transform(downloadDate, this.dateFormatForExcelDownload);
        const timeValue = this.datePipe.transform(downloadDate, 'mediumTime');
        worksheet[i].addRow([this.translate.instant(FccGlobalConstant.DOWNLOAD_DATE), dateValue]);
        worksheet[i].addRow([this.translate.instant(FccGlobalConstant.DOWNLOAD_TIME), timeValue]);
        worksheet[i].addRow([]);
        worksheet[i].addRow(this.tableHeaders);
        worksheet[i].addRows(this.groupTableData[i]);
        if (this.language === FccGlobalConstant.LANGUAGE_AR) {
          worksheet[i].views = [
            { rightToLeft: true }
          ];
        }
      }
    }
    workbook.xlsx.writeBuffer().then((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      saveAs(blob, `${this.translate.instant(this.groupDetails[FccGlobalConstant.GROUP_TITLE])}.xlsx`);
    });
  }

  createListDataCSV() {
    const workbook = new Workbook();
    const worksheet = workbook.addWorksheet(this.translate.instant(this.tableName));
    worksheet.addRow([this.translate.instant(this.tableName)]);
    worksheet.columns = this.tableHeadersCSV;
    worksheet.addRows(this.tableData);
    workbook.csv.writeBuffer().then((data) => {
      const BOM = '\uFEFF';
      const blob = new Blob([BOM + data], { type: 'text/csv;charset=utf-8' });
      saveAs(blob, `${this.translate.instant(this.tableName)}.csv`);
    });
  }

  createGroupListDataCSV() {
    const workbook = new Workbook();
    const worksheet = workbook.addWorksheet(this.translate.instant(this.groupDetails[0].groupName));
    worksheet.columns = this.tableHeadersCSV;
    this.groupTableData.forEach(data => {
      worksheet.addRow([]);
      worksheet.addRows(data);
      worksheet.addRow([]);
    });
    workbook.csv.writeBuffer().then((data) => {
      const BOM = '\uFEFF';
      const blob = new Blob([BOM + data], { type: 'text/csv;charset=utf-8' });
      saveAs(blob, `${this.translate.instant(this.groupDetails[FccGlobalConstant.GROUP_TITLE])}.csv`);
    });
  }

  checkFullDownloadExcelOrPDFOrCSV() {
    if (this.downloadOption === FccGlobalConstant.PDF_FULL_DOWNLOAD) {
      this.pdfGeneratorService.createListDataPDF(this.pdfMode, this.tableHeaders, this.tableData, this.columnHeader,
        this.columnData, this.tableName);
    } else if (this.downloadOption === FccGlobalConstant.EXCEL_FULL_DOWNLOAD) {
      this.createListDataExcel();
    } else if (this.downloadOption === FccGlobalConstant.CSV_FULL_DOWNLOAD) {
      this.createListDataCSV();
    }
  }

  setListTableData(colData: any, tableHeaderList: any) {
    this.tableData = [];
    for (const listData of colData) {
      const row = [];
      let dataValue: any;
      tableHeaderList.forEach(header => {
        dataValue = this.getTableDataValue(header, listData);
        row.push(dataValue);
      });
      this.tableData.push(row);
    }
  }

  getTableDataValue(header, listData) {
    let dataValue: any;
    switch (header) {
      case FccGlobalConstant.ACCOUNT_TYPE:
      case FccGlobalConstant.ACCOUNTTYPECODE:
        dataValue = this.translate.instant('N068_' + listData[header]);
        break;
      case FccGlobalConstant.PRODUCTCODE:
        dataValue = this.translate.instant('N001_' + listData[header]);
        break;
      case FccGlobalConstant.TNXTYPECODE:
        dataValue = this.translate.instant('N003_' + listData[header]);
        break;
      case FccGlobalConstant.PROD_STAT_CODE:
        dataValue = this.translate.instant('N005_' + listData[header]);
        break;
      case FccGlobalConstant.TENOR_TYPE:
        dataValue = this.translate.instant('DraftAgainst_' + listData[header]);
        break;
      case FccGlobalConstant.ENTITY:
        if ((listData[header].includes('displayedFieldValue') || listData[header].includes('fieldValuePassbackParameters'))
          && ((listData[header] !== 'displayedFieldValue') || listData[header] !== 'fieldValuePassbackParameters')) {
          dataValue = listData[header].split("displayedFieldValue\":\"").pop().split("\"}")[0];
        } else {
          dataValue = listData[header];
        }
        break;
      case FccGlobalConstant.LC_EXP_DATE_TYPE_CODE:
        dataValue = this.translate.instant('expiryType_' + listData[header]);
        break;
      case FccGlobalConstant.FT_TYPE:
        dataValue = this.translate.instant('ftType_' + listData[header]);
        break;
      case FccGlobalConstant.SUB_TNX_STAT_CODE:
        if (listData[header] === '01'){
          dataValue = this.translate.instant('SECQBK_' + listData[header]);
        } else {
          dataValue = listData[header];
        }
        break;
      case FccGlobalConstant.subProductCode:
        if (listData[header] !== FccGlobalConstant.SAMPLE_COMMENT){
          dataValue = this.translate.instant('N047_' + listData[header]);
        } else {
          dataValue = listData[header];
        }
        break;
      case FccGlobalConstant.ACTION_REQ_CODE:
        dataValue = this.translate.instant('N042_' + listData[header]);
        break;
      case FccGlobalConstant.ENTITYCOL:
      case FccGlobalConstant.BENE_ACCOUNT_MASTER:
      case FccGlobalConstant.BENE_ACCOUNT_TNX:
        if (this.commonService.isnonEMptyString(listData[FccGlobalConstant.ORIG_GROUPED_VAL]))
        {
          dataValue = listData[FccGlobalConstant.ORIG_GROUPED_VAL];
        }else{
          dataValue = listData[header];
        }
        break;
      case FccGlobalConstant.BENE_DEFAULT_ACCOUNT:
        if( listData[header] === 'true'){
          dataValue = this.translate.instant('yes');
        } else{
          dataValue = this.translate.instant('no');
        }
        break;
      default:
        dataValue = listData[header];
    }
    return dataValue;
  }

  checkGroupsDownload(downloadOption: any, isGroupsDownloadEnabled: any, groupDetails: any, columnHeaders: any,
                      groupsColData: any, maxColForPDFMode?: any, excelDateFormat?: any) {
    this.downloadOption = downloadOption;
    this.isGroupsDownload = isGroupsDownloadEnabled;
    this.groupDetails = groupDetails;
    this.dateFormatForExcelDownload = excelDateFormat;
    if (maxColForPDFMode && maxColForPDFMode < columnHeaders.length) {
      this.pdfMode = FccGlobalConstant.PDF_MODE_LANDSCAPE;
    } else {
      this.pdfMode = FccGlobalConstant.PDF_MODE_PORTRAIT;
    }
    this.formatListData(columnHeaders, groupsColData);

    switch (this.downloadOption) {
      case FccGlobalConstant.PDF:
        this.pdfGeneratorService.createListDataPDF(this.pdfMode, this.tableHeaders, this.groupTableData, this.columnHeader, this.columnData,
          FccGlobalConstant.EMPTY_STRING, this.isGroupsDownload, this.groupDetails);
        break;
      case FccGlobalConstant.EXCEL:
        this.createGroupListDataExcel();
        break;
      case FccGlobalConstant.CSV:
        this.createGroupListDataCSV();
        break;
    }
  }

  checkPaymentSummaryDataDownloadOption(downloadOption: any, data: any,headers: any,subHeaders: any
    ,excelDateFormat?: any,duration?: any) {
      this.downloadOption = downloadOption;
      this.dateFormatForExcelDownload = excelDateFormat;
      switch (this.downloadOption) {
        case FccGlobalConstant.PDF:
          this.pdfGeneratorService.createPaymentSummaryPDF(FccGlobalConstant.PDF_MODE_PORTRAIT,FccGlobalConstant.PAYMENT_SUMMARY,data
            ,headers,subHeaders,duration);
          break;
        case FccGlobalConstant.EXCEL:
          this.createPaymentSummaryListDataExcel(data,duration,FccGlobalConstant.PAYMENT_SUMMARY,
            headers,subHeaders);
          break;
      }
  }

  createPaymentSummaryListDataExcel(data, duration, tableName, tableHeaders, subTableHeaders) {

    const workbook = new Workbook();
    const worksheet = workbook.addWorksheet(this.translate.instant(tableName));
    const titleRow = worksheet.addRow([this.translate.instant(tableName)]);
    worksheet.mergeCells('A1:I1');
    titleRow.font = {
      size: 16,
      bold: true
    };
    titleRow.alignment = {
      vertical: 'middle', horizontal: 'center'
    };
    worksheet.addRow([]);
    const imageBase64Logo = this.pdfGeneratorService.getHeaderLogoForExcel();
    const imageLogoId = workbook.addImage({
      base64: imageBase64Logo,
      extension: 'png',
    });
    worksheet.addImage(imageLogoId, 'A2:B6');
    worksheet.mergeCells('A2:B6');
    worksheet.addRow([]);

    const downloadDate = new Date();
    const dateValue = this.datePipe.transform(downloadDate, this.dateFormatForExcelDownload);
    const timeValue = this.datePipe.transform(downloadDate, 'mediumTime');
    const detailsRow1 = worksheet.addRow([]);
    detailsRow1.getCell(1).value = this.translate.instant(FccGlobalConstant.COMPANY_NAME);
    detailsRow1.getCell(2).value = data.companyName;
    detailsRow1.getCell(5).value = this.translate.instant(FccGlobalConstant.DOWNLOAD_DATE_PAYMENT);
    detailsRow1.getCell(6).value = dateValue;

    const detailsRow2 = worksheet.addRow([]);
    detailsRow2.getCell(1).value = this.translate.instant(FccGlobalConstant.TOTAL_PAYMENT);
    detailsRow2.getCell(2).value = this.commonService.getCurrencyFormatedAmount(
      'INR',
      data.totalConsolidatedPackageAmount,
      this.currencySymbolDisplayEnabled);
    detailsRow2.getCell(5).value = this.translate.instant(FccGlobalConstant.DOWNLOAD_TIME_PAYMENT);
    detailsRow2.getCell(6).value = timeValue;

    worksheet.addRow([]);
    worksheet.addRow([]);
    const durationRow = worksheet.addRow([]);
    duration = this.translate.instant(duration);
    durationRow.getCell(1).value = this.translate.instant('DURATION_OF_TRANSACTION', { duration });
    worksheet.mergeCells('A12:B12');
    worksheet.addRow([]);
    this.tableData = [];

    for (const listData of data.paymentsOverview) {
      const row = [];
      const subrows = [];
      let subrow;
      let dataValue: any;
      const headers = [];
      let subHeaders = [];
      tableHeaders.forEach(header => {
        if (header === FccGlobalConstant.CLIENT_DETAILS) {
          dataValue = listData[header];
          for (const subListData of dataValue) {
            subrow = [];
            let subDataValue: any;
            subHeaders = [];
            subTableHeaders.forEach(subHeader => {
              subHeaders.push(this.translate.instant(subHeader));
              subDataValue = subListData[subHeader];
              if (subHeader === FccGlobalConstant.CLIENT_AMT) {
                subDataValue = this.commonService.getCurrencyFormatedAmount(
                  'INR',
                  subDataValue,
                  this.currencySymbolDisplayEnabled);
              }
              subrow.push(subDataValue);
            });
            subrows.push(subrow);
          }

        } else {
          headers.push(this.translate.instant(header));
          dataValue = listData[header];
          if (header === FccGlobalConstant.PACKAGE_AMT) {
            dataValue = this.commonService.getCurrencyFormatedAmount(
              'INR',
              dataValue,
              this.currencySymbolDisplayEnabled);
          }
          row.push(dataValue);
        }
      });

      const headerRow = worksheet.addRow(headers);
      headerRow.font = {
        size: 11,
        bold: true
      };
      headerRow.alignment = {
        vertical: 'middle', horizontal: 'left'
      };
      // Cell Style : Fill and Border
      headerRow.eachCell((cell) => {
        cell.fill = {
          type: 'pattern',
          pattern: 'solid',
          fgColor: { argb: FccGlobalConstant.PAYMENT_SUMMARY_HEADER_COLOR },
          bgColor: { argb: FccGlobalConstant.PAYMENT_SUMMARY_HEADER_COLOR }
        };
      });
      worksheet.addRow(row);
      const subHeaderRow = worksheet.addRow(subHeaders);

      subHeaderRow.alignment = {
        vertical: 'middle', horizontal: 'center'
      };
      // Cell Style : Fill and Border
      subHeaderRow.eachCell((cell) => {
        cell.fill = {
          type: 'pattern',
          pattern: 'solid',
          fgColor: { argb: FccGlobalConstant.PAYMENT_SUMMARY_HEADER_COLOR },
          bgColor: { argb: FccGlobalConstant.PAYMENT_SUMMARY_HEADER_COLOR }
        };
      });
      worksheet.addRows(subrows);
      worksheet.addRow([]);
    }
    if (this.language === FccGlobalConstant.LANGUAGE_AR) {
      worksheet.views = [
        { rightToLeft: true }
      ];
    }
    workbook.xlsx.writeBuffer().then((data: any) => {
      const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
      saveAs(blob, `${this.translate.instant(tableName)}.xlsx`);
    });
  } 
}
