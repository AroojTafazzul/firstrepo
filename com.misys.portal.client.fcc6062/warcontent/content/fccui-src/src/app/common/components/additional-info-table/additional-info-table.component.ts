import { FileHandlingService } from './../../services/file-handling.service';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';

import { LcConstant } from './../../../corporate/trade/lc/common/model/constant';
import { FccGlobalConstantService } from './../../core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../core/fcc-global-constants';
import {
  attachmentCols,
  attachmentColsForSeLncds,
  bankAttachmentCols,
  ChargesDetailsRequest,
  documentsCols,
  documentsColsforELRL,
  documentsColsWithoutName,
  feeAndChargesCols,
} from './../../model/review.model';
import { CommonService } from './../../services/common.service';
import { ReviewScreenService } from './../../services/review-screen.service';

@Component({
  selector: 'app-additional-info-table',
  templateUrl: './additional-info-table.component.html',
  styleUrls: ['./additional-info-table.component.scss']
})
export class AdditionalInfoTableComponent implements OnInit {
  cols: any[];
  @Input()
  tableSectioData: any;
  tableSectionKey;
  coldata;
  transactionId;
  referenceId;
  productCode;
  action: number;
  attachemntArrObj = [];
  feeandchargesArrObj = [];
  attachmentColoums = [];
  dir: string = localStorage.getItem('langDir');
  lcConstant = new LcConstant();
  contextPath: any;
  chargeAttachmentsRequest: ChargesDetailsRequest;
  subTnxTypeCode = '';
  subProductCode = '';
  allowedDocViewerType: string[];

  constructor(protected reviewScreenService: ReviewScreenService,
              protected activatedRoute: ActivatedRoute,
              protected fccGlobalConstant: FccGlobalConstant,
              protected commonService: CommonService,
              protected fccGlobalConstantService: FccGlobalConstantService,
              protected translateService: TranslateService,
              protected fileHandlingService: FileHandlingService
              ) { }
  ngOnInit(): void {
    const tnxid = 'tnxid';
    const referenceid = 'referenceid';
    const subProductCode = 'subProductCode';
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.activatedRoute.queryParams.subscribe(params => {
      this.transactionId = params[tnxid];
      this.referenceId = params[referenceid];
      this.productCode = this.referenceId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2);
      this.subProductCode = params[subProductCode];
    });
    this.commonService.getAllowedDocViewerMimeTypes();
    this.allowedDocViewerType = this.commonService.allowedDocViewerMimeTypes;
    this.tableSectionKey = this.tableSectioData;
    if (this.tableSectionKey) {
      this.getDataOfTable(this.tableSectionKey);
    }
  }

  getDataOfTable(key) {
    this.productCode = this.referenceId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2);
    switch (key) {
      case FccGlobalConstant.BANK_ATTACHMENT:
      case FccGlobalConstant.ATTACHMENT:
        this.reviewScreenService.getFileAttachments(this.referenceId, this.productCode).subscribe( data => {
          const arrObj = data.fileAttachments;
          this.getFormatedData(arrObj, key);
        });
        break;
      case FccGlobalConstant.DOCUMENT_DETAILS:
          this.reviewScreenService.getDocumentDetails(this.referenceId, this.productCode).subscribe( data => {
            const arrObj = data;
            this.getDocumetsFormatedData(arrObj, key);
          });
          break;
      case FccGlobalConstant.FEES_AND_CHARGES:
        this.transformToChargeRequest(this.referenceId, this.productCode, 'Tnx');
        this.reviewScreenService.getFeeAndChargesData(this.chargeAttachmentsRequest).subscribe( data => {
          const arrObj = data.chargeAttachments;
          this.getChargeFormatedData(arrObj, key);
        });
        this.cols = feeAndChargesCols;
        break;
      case 'Miss':
        break;
    }
  }

  getAttachmentCols() {
    if (this.productCode === FccGlobalConstant.PRODUCT_SE && this.subProductCode === FccGlobalConstant.SUB_PRODUCT_LNCDS) {
      return attachmentColsForSeLncds;
    } else {
      return attachmentCols;
    }
  }

  transformToChargeRequest(referenceId, productCode, masterOrTnx) {
    this.chargeAttachmentsRequest = new ChargesDetailsRequest();
    this.chargeAttachmentsRequest.refId = referenceId;
    this.chargeAttachmentsRequest.tnxId = '';
    this.chargeAttachmentsRequest.productCode = productCode;
    this.chargeAttachmentsRequest.masterOrTnx = masterOrTnx;
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  showicon(event, i) {
    event.target.classList.add('iconvisible');
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  hideicon(event, i) {
    event.target.classList.remove('iconvisible');
  }

  getLengthOfAttachemntArrObj() {
    return this.attachemntArrObj.length.toString();
  }
  getFormatedData(arrObj, key) {
    if (key === FccGlobalConstant.ATTACHMENT && arrObj !== undefined) {
      this.cols = this.getAttachmentCols();
      for (const keyOF in arrObj) {
        if (Object.prototype.hasOwnProperty.call(arrObj,keyOF)) {
          const element = arrObj[keyOF];
          if (this.productCode === FccGlobalConstant.PRODUCT_SE && this.subProductCode === FccGlobalConstant.SUB_PRODUCT_LNCDS) {
            const attachmentResultObj: {
              'fileType': string, 'date': any, 'docName': string,
              'fileName': any
            } = {
              fileType: this.getFileExtPath(element.fileName), date: element.customerReleaseDttm,
              docName: element.title,
              fileName: element.fileName
            };
            this.attachemntArrObj.push(attachmentResultObj);
          } else if (element.type === FccGlobalConstant.CUSTOMER_ATTACHMENT_TYPE &&
            element.tnxStatCode === FccGlobalConstant.TNX_STAT_CODE_APPROVED) {
            const attachmentResultObj: {'fileType': string, 'boReleaseDttm': any, 'event': string, 'eventStatus': string, 'title': string,
             'fileName': any, 'attachmentStatus': any, docId: number, 'fileMimeType': string, 'type': string}
            = { fileType: this.getFileExtPath(element.fileName), boReleaseDttm: element.boReleaseDttm,
              event: this.getEvent(element.tnxTypeCode, element.subTnxTypeCode),
              eventStatus: this.translateService.instant('N005_' + element.prodStatCode),
              title: element.title, fileName: element.fileName,
               attachmentStatus: `${this.translateService.instant('N004_' + element.tnxStatCode)}`,
               docId: element.attId, fileMimeType: element.fileMimeType, type: element.type };
            this.attachemntArrObj.push(attachmentResultObj);
          }
        }
      }
    } else if (key === FccGlobalConstant.BANK_ATTACHMENT && arrObj !== undefined) {
      this.cols = bankAttachmentCols;
      for (const keyOF in arrObj) {
        if (Object.prototype.hasOwnProperty.call(arrObj,keyOF)) {
          const element = arrObj[keyOF];
          if (element.type === FccGlobalConstant.BANK_ATT_TYPE) {
            const attachmentResultObj: {'fileType': string, 'boReleaseDttm': any, 'event': string, 'eventStatus': string, 'title': string,
            'fileName': any, docId: number, 'fileMimeType': string, 'type': string}
            = { fileType: this.getFileExtPath(element.fileName), boReleaseDttm: element.boReleaseDttm,
              event: this.getEvent(element.tnxTypeCode, element.subTnxTypeCode),
              eventStatus: this.translateService.instant('N005_' + element.prodStatCode),
              title: element.title, fileName: element.fileName,
               docId: element.attId, fileMimeType: element.fileMimeType, type: element.type };
            this.attachemntArrObj.push(attachmentResultObj);
          }
        }
      }
    }
  }

  getDocumetsFormatedData(arrObj, key) {
    let nameColumn = false;
    this.subTnxTypeCode = '';
    if (key === FccGlobalConstant.DOCUMENT_DETAILS && arrObj !== undefined) {
      for (const keyOF in arrObj) {
        if (Object.prototype.hasOwnProperty.call(arrObj,keyOF)) {
          const element = arrObj[keyOF];
          if (element.tnxStatCode === FccGlobalConstant.TNX_STAT_CODE_APPROVED) {
          if (!nameColumn && element.name && element.name !== null && element.name !== '' ) {
          nameColumn = true;
          }
          const docType = this.translateService.instant('C064_' + element.code);
          const attachmentResultObj: { documentType: any, numOfOriginals: any,
            numOfPhotocopies: any, total: any, documentDate: any, documentName: any, documentNumber: any, linkTo: any , 'event': string,
                eventStatus: string} = {
              documentType: docType,
              event: this.getEvent(element.tnxTypeCode, element.subTnxTypeCode),
              eventStatus: this.translateService.instant('N005_' + element.prodStatCode),
              numOfOriginals: element.firstMail,
              numOfPhotocopies: element.secondMail,
              total: element.total,
              documentDate: element.docDate,
              documentName: element.name,
              documentNumber: element.docNo,
              linkTo: element.mappedAttachmentName
            };
          if (element.tnxTypeCode && element.tnxTypeCode !== FccGlobalConstant.N002_INQUIRE) {
            this.attachemntArrObj.push(attachmentResultObj);
          }
          if (element.tnxTypeCode && element.tnxTypeCode === FccGlobalConstant.N002_INQUIRE &&
            element.subTnxTypeCode && element.subTnxTypeCode === FccGlobalConstant.N003_REMITTANCE_LETTER_GENERATION) {
              this.subTnxTypeCode = FccGlobalConstant.N003_REMITTANCE_LETTER_GENERATION;
              const attachmentResultObjEL: { documentType: any, numOfOriginals: any,
                numOfPhotocopies: any, total: any, documentNumber: any, 'event': string} = {
                  documentType: docType,
                  event: this.getEvent(element.tnxTypeCode, element.subTnxTypeCode),
                  numOfOriginals: element.firstMail,
                  numOfPhotocopies: element.secondMail,
                  total: element.total,
                  documentNumber: element.docNo
                };
              this.attachemntArrObj.push(attachmentResultObjEL);
          }
         }
        }
      }
      this.cols = this.getDocumentCols(nameColumn);
    }
  }

  getChargeFormatedData(arrObj, key) {
  if (key === FccGlobalConstant.FEES_AND_CHARGES && arrObj !== undefined) {
    for (const keyOF in arrObj) {
      if (Object.prototype.hasOwnProperty.call(arrObj,keyOF)) {
        const element = arrObj[keyOF];
        if (Array.isArray(element)) {
          for (let index = 0; index < element.length; index++) {
            const arrElement = element[index];
            const attachmentResultObj: {'boReleaseDttm': any, 'event': string, 'eventStatus': string, 'ChargeType': string,
            'Description': any, 'tnx_cur_code': any, 'amount': any, 'chargeStatus': any, 'SettlementDate': any} = {
            boReleaseDttm: arrElement.boReleaseDttm,
            event: this.getEvent(arrElement.tnxTypeCode, arrElement.subTnxTypeCode),
            eventStatus: this.translateService.instant('N005_' + arrElement.prodStatCode),
            ChargeType: this.convertChargesToLocalize(arrElement.chargeType, 'ChargeType'), Description: arrElement.description,
            tnx_cur_code: arrElement.ccy, amount: arrElement.amount,
            chargeStatus: this.convertChargesToLocalize(arrElement.status, 'tnx_stat_code'),
            SettlementDate: arrElement.settlementDate };
            this.attachemntArrObj.push(attachmentResultObj);
          }
        } else {
          const attachmentResultObj: {'boReleaseDttm': any, 'event': string, 'eventStatus': string, 'ChargeType': string,
          'Description': any, 'tnx_cur_code': any, 'amount': any, 'chargeStatus': any, 'SettlementDate': any} = {
          boReleaseDttm: element.boReleaseDttm,
          event: this.getEvent(element.tnxTypeCode, element.subTnxTypeCode),
          eventStatus: this.translateService.instant('N005_' + element.prodStatCode),
          ChargeType: this.convertChargesToLocalize(element.chargeType, 'ChargeType'),
          Description: element.description, tnx_cur_code: element.ccy,
          amount: element.amount, chargeStatus: this.convertChargesToLocalize(element.status, 'tnx_stat_code'),
          SettlementDate: element.settlementDate };
          this.attachemntArrObj.push(attachmentResultObj);
        }
        }
      }
    }
  }

  convertChargesToLocalize(status, type) {
    let localizeValue = '';
    if (type === FccGlobalConstant.TNX_STAT_CODE) {
        localizeValue = FccGlobalConstant.ROLE_CODE;
    }
    if (type === FccGlobalConstant.CHARGE_TYPE) {
        localizeValue = FccGlobalConstant.CHARGE_TYPE_CODE;
    }
    const value = status;
    const conCatValue = localizeValue.concat('_', value);
    return this.translateService.instant(conCatValue);
  }

  keyPressDownload(e, docID, fileName) {
    const keycodeIs = e.which || e.keyCode;
    if (keycodeIs === this.lcConstant.thirteen) {
      this.getActionData(docID, fileName);
    }
  }

  getActionData(docID, fileName) {
    this.commonService.downloadAttachments(docID).subscribe(response => {
      let fileType;
      if (response.type) {
        fileType = response.type;
      } else {
        fileType = 'application/octet-stream';
      }
      const newBlob = new Blob([response.body], { type: fileType });
      if (window.navigator && window.navigator.msSaveOrOpenBlob) {
          window.navigator.msSaveOrOpenBlob(newBlob);
          return;
      }
      const data = window.URL.createObjectURL(newBlob);
      const link = document.createElement('a');
      link.href = data;
      link.download = fileName;
      link.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true, view: window }));
      window.URL.revokeObjectURL(data);
      link.remove();
    });
  }

  onClickViewFile(docId, fileName) {
    this.fileHandlingService.viewFile(docId, fileName);
  }



  getFileExtPath(fileName: string) {
    const fileExtn = fileName.split('.').pop().toLowerCase();
    const path = `${this.contextPath}`;
    const imgSrcStartTag = '<img src="';
    const endTag = '"/>';
    const pdfFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.PDF_IMG_PATH).concat(endTag);
    const docFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.DOC_IMG_PATH).concat(endTag);
    const xlsFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.XLS_IMG_PATH).concat(endTag);
    const xlsxFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.XLSX_IMG_PATH).concat(endTag);
    const pngFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.PNG_IMG_PATH).concat(endTag);
    const jpgFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.JPG_IMG_PATH).concat(endTag);
    const txtFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.TXT_IMG_PATH).concat(endTag);
    const zipFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.ZIP_IMG_PATH).concat(endTag);
    const rtgFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.RTF_IMG_PATH).concat(endTag);
    const csvFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.CSV_IMG_PATH).concat(endTag);
    switch (fileExtn) {
      case 'pdf':
        return pdfFilePath;
      case 'docx':
      case 'doc':
        return docFilePath;
      case 'xls':
        return xlsFilePath;
      case 'xlsx':
        return xlsxFilePath;
      case 'png':
        return pngFilePath;
      case 'jpg':
        return jpgFilePath;
      case 'jpeg':
        return jpgFilePath;
      case 'txt':
        return txtFilePath;
      case 'zip':
        return zipFilePath;
      case 'rtf':
        return rtgFilePath;
      case 'csv':
        return csvFilePath;
      default:
        return fileExtn;
    }
  }

  getEvent(tnxTypeCode: string, subTnxTypeCode: string) {
    let event = '';
    if (this.productCode === FccGlobalConstant.PRODUCT_LN) {
      if (tnxTypeCode !== null && tnxTypeCode !== '' && subTnxTypeCode !== null && subTnxTypeCode !== '') {
        event = `${this.translateService.instant(tnxTypeCode + ':' + subTnxTypeCode)}`;
      }
    } else if (this.subProductCode === FccGlobalConstant.SUB_PRODUCT_BLFP) {
      if (subTnxTypeCode !== null && subTnxTypeCode !== '') {
        event = `${this.translateService.instant('LIST_N003_' + subTnxTypeCode)}`;
      } else {
        event = `${this.translateService.instant('N002_' + tnxTypeCode)}`;
      }
    } else {
      event = `${this.translateService.instant('N002_' + tnxTypeCode)}`;
      if (tnxTypeCode !== FccGlobalConstant.N002_NEW && subTnxTypeCode !== null && subTnxTypeCode !== '') {
        event = event + ' ' + `${this.translateService.instant('LIST_N003_' + subTnxTypeCode)}`;
      }
    }
    return event;
  }

  getDocumentCols(nameField: boolean) {
    if (this.subTnxTypeCode === FccGlobalConstant.N003_REMITTANCE_LETTER_GENERATION) {
      return documentsColsforELRL;
      }
    else if (nameField) {
      return documentsCols;
    } else {
      return documentsColsWithoutName;
    }
  }

}

export interface Item {
      fileName: string;
      docId: string;
      title: string;
      id: string;
      eventId: string;
      type: string;
      size: number;
      uploadDate: string;
  }

export interface RootObject {
      items: Item[];
  }
export interface AttachemntData {
  title: string;
  fileName: any;
  status: string;
}


