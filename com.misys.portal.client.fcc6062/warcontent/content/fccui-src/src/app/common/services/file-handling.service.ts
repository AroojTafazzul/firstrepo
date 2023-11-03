import { BankFileMap } from './../../corporate/trade/lc/initiation/services/bankmfile';
import { FccGlobalConstantService } from './../core/fcc-global-constant.service';
import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { FccGlobalConstant } from '../core/fcc-global-constants';
import { FileMap } from '../../../app/corporate/trade/lc/initiation/services/mfile';
import { FilelistService } from '../../../app/corporate/trade/lc/initiation/services/filelist.service';
import { FCCMVFormControl } from '../../../app/base/model/fcc-control.model';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from './common.service';
import { FileUploadHandlerService } from '../../../app/common/services/file-upload-handler.service';
import { ELMT700FileMap } from '../../../app/corporate/trade/lc/initiation/services/elMT700mfile';
import { FccOverlayService } from '../../..//app/base/services/fcc-overlay.service';


@Injectable({
  providedIn: 'root'
})

export class FileHandlingService {
  contentType = 'Content-Type';
  tableColumns = [];
  contextPath: any;
  dir: string = localStorage.getItem('langDir');

  constructor(public uploadFile: FilelistService, protected fileListSvc: FilelistService,
              protected fccGlobalConstantService: FccGlobalConstantService, protected http: HttpClient,
              protected translateService: TranslateService, protected commonService: CommonService,
              protected fileUploadHandlerService: FileUploadHandlerService, protected fccOverlayService: FccOverlayService) {
}

  getFileAttachment(eventId: any, form: any) {
    this.uploadFile.resetList();
    if (eventId) {
      this.getTnxFileDetails(eventId).subscribe(
        response => {
          if (response && response.body && response.body.items) {
            const docIds = [];
          for (const values of response.body.items) {
            if ( values.type !== 'BANK' && values.type !== FccGlobalConstant.SWIFT) {
            form.get('fileUploadTable')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
            const fileModel = new FileMap(null, this.commonService.decodeHtml(values.fileName),
            this.commonService.decodeHtml(values.title), values.type,
            this.getFileExtPath(values.fileName),
            this.fileUploadHandlerService.getFileSize(values.size), values.docId, null, null, null, null,
            this.commonService.decodeHtml(values.mimeType));
            this.uploadFile.addFileIdToMap(fileModel);
            this.uploadFile.pushFile(fileModel);
            this.patchFieldParameters(form.get('fileUploadTable'), { columns: this.getColumnsForEditMode() });
            this.patchFieldParameters(form.get('fileUploadTable'), { data: this.uploadFile.getFileList() });
            this.patchFieldParameters(form.get('fileUploadTable'), { hasData: true });
            form.get('fileUploadTable').updateValueAndValidity();
            form.updateValueAndValidity();
            docIds.push(values.docId);
            }    
          } 
        /* docId is not getting set to the form from setAttachmentIds() method.
         therefore on save of the transaction the the status of the attachment is getting set to '02' instead of 'null'
         which in turn is not displaying the attachment in the view popup and other screens.
         Hence the docId has been added here to the form */
        const attachments = { docId: docIds };
        form.get(FccGlobalConstant.ATTACHMENTS).setValue(attachments);
        form.get(FccGlobalConstant.ATTACHMENTS).updateValueAndValidity();
        form.updateValueAndValidity();
        }
        }
        );
      }
    }

    getFileData(fieldValue: any): any {
      let customerAttachments;
      this.uploadFile.resetList();
      if (fieldValue.attachment !== undefined && fieldValue.attachment.length > 1) {
          for (const values of fieldValue.attachment) {
            if (values.type === FccGlobalConstant.CUSTOMER_ATTACHMENT_TYPE){
              const fileModel = new FileMap(null, values.file_name, values.title, values.type,
              this.getFileExtPath(values.file_name),
              null, values.attachment_id, null, null, null, null, this.commonService.decodeHtml(values.mime_type));
              this.uploadFile.addFileIdToMap(fileModel);
              this.uploadFile.pushFile(fileModel);
              customerAttachments = this.uploadFile.getFileList();
            }
          }
        } else if (fieldValue.attachment !== undefined && fieldValue.attachment.type === FccGlobalConstant.CUSTOMER_ATTACHMENT_TYPE) {
            const fileModel = new FileMap(null, fieldValue.attachment.file_name, fieldValue.attachment.title, fieldValue.attachment.type,
            this.getFileExtPath(fieldValue.attachment.file_name),
            null, fieldValue.attachment.attachment_id, null, null, null, null,
            this.commonService.decodeHtml(fieldValue.attachment.mime_type));
            this.uploadFile.addFileIdToMap(fileModel);
            this.uploadFile.pushFile(fileModel);
            customerAttachments = this.uploadFile.getFileList();
        }
      return customerAttachments;
    }

    getBankFileData(fieldValue: any): any {
      let bankAttachments;
      this.uploadFile.resetBankList();
      if (fieldValue.attachment !== undefined && fieldValue.attachment.length > 1) {
          for (const values of fieldValue.attachment) {
            if ( values.type === FccGlobalConstant.BANK_ATT_TYPE) {
              const bankFileModel = new BankFileMap(null, values.file_name, values.title, values.type,
                this.getFileExtPath(values.file_name), null, values.attachment_id, null, null, null, null,
                this.commonService.decodeHtml(values.mime_type));
              this.uploadFile.addBankFileIdToMap(bankFileModel);
              this.uploadFile.pushBankFile(bankFileModel);
              bankAttachments = this.uploadFile.getBankFileList();
            }
          }
        } else if (fieldValue.attachment !== undefined && fieldValue.attachment.type === FccGlobalConstant.BANK_ATT_TYPE) {
            const bankFileModel = new BankFileMap(null, fieldValue.attachment.file_name, fieldValue.attachment.title,
              fieldValue.attachment.type, this.getFileExtPath(fieldValue.attachment.file_name),
              null, fieldValue.attachment.attachment_id, null, null, null, null, fieldValue.attachment.mime_type);
            this.uploadFile.addBankFileIdToMap(bankFileModel);
            this.uploadFile.pushBankFile(bankFileModel);
            bankAttachments = this.uploadFile.getBankFileList();
        }
      return bankAttachments;
    }


    getELMT700FileData(fieldValue: any): any {
      let elMT700Attachments;
      this.uploadFile.resetELMT700List();
      if (fieldValue.attachment !== undefined && fieldValue.attachment.length > 1) {
          for (const values of fieldValue.attachment) {
            if ( values.type === FccGlobalConstant.CODE_08) {
              const elMT700FileModel = new ELMT700FileMap(null, values.file_name, values.title, values.type,
                this.getFileExtPath(values.file_name), null, values.attachment_id, null, null, null, null);
              this.uploadFile.addELMT700FileIdToMap(elMT700FileModel);
              this.uploadFile.pushELMT700File(elMT700FileModel);
              elMT700Attachments = this.uploadFile.getELMT700FileList();
            }
          }
        } else if (fieldValue.attachment !== undefined && fieldValue.attachment.type === FccGlobalConstant.CODE_08) {
            const elMT700FileModel = new ELMT700FileMap(null, fieldValue.attachment.file_name, fieldValue.attachment.title,
              fieldValue.attachment.type, this.getFileExtPath(fieldValue.attachment.file_name),
              null, fieldValue.attachment.attachment_id, null, null, null, null);
            this.uploadFile.addELMT700FileIdToMap(elMT700FileModel);
            this.uploadFile.pushELMT700File(elMT700FileModel);
            elMT700Attachments = this.uploadFile.getELMT700FileList();
        }
      return elMT700Attachments;
    }

    getFileAttachmentWithID(eventId: any, form: any) {
      if (eventId) {
        this.getFileDetails(eventId).subscribe(
          response => {
            this.uploadFile.resetList();
            if (response && response.body && response.body.items) {
            for (const values of response.body.items) {
              if ( values.type !== 'BANK' || values.type !== FccGlobalConstant.SWIFT) {
              form.get('fileUploadTable')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
              const fileModel = new FileMap(null, values.fileName, values.title, values.type,
              this.getFileExtPath(values.fileName),
              this.fileUploadHandlerService.getFileSize(values.size), values.docId, null, null, null, null);
              this.uploadFile.addFileIdToMap(fileModel);
              this.uploadFile.pushFile(fileModel);
              this.patchFieldParameters(form.get('fileUploadTable'), { columns: this.getColumns() });
              this.patchFieldParameters(form.get('fileUploadTable'), { data: this.uploadFile.getFileList() });
              this.patchFieldParameters(form.get('fileUploadTable'), { hasData: true });
              form.get('fileUploadTable').updateValueAndValidity();
              form.updateValueAndValidity();
              }
            }
          }
          }
          );
        }
      }

    patchFieldParameters(control: any, params: any) {
      control.params = Object.assign(control.params, params);
      Object.keys(params).forEach(element => {
      if (control instanceof FCCMVFormControl && element === 'options') {
        (control as FCCMVFormControl).updateOptions();
      }
    });
    }

    getColumns() {
      this.tableColumns = [
                {
                  field: 'typePath',
                  header: `${this.translateService.instant('fileType')}`,
                  width: '10%'
                },
                {
                  field: 'title',
                  header: `${this.translateService.instant('title')}`,
                  width: '30%'
                },
                {
                  field: 'fileName',
                  header: `${this.translateService.instant('fileName')}`,
                  width: '30%'
                }];
      return this.tableColumns;
    }

    getColumnsForEditMode() {
      this.tableColumns = [
        {
          field: 'typePath',
          header: `${this.translateService.instant('fileType')}`,
          width: '10%'
        },
        {
          field: 'title',
          header: `${this.translateService.instant('title')}`,
          width: '30%'
        },
        {
          field: 'fileName',
          header: `${this.translateService.instant('fileName')}`,
          width: '30%'
        },
        {
          field: 'fileSize',
          header: `${this.translateService.instant('fileSize')}`,
          width: '10%'
        }];
      return this.tableColumns;
    }

    getFileDetails(refId: string) {
      const obj = {};
      obj[this.contentType] = FccGlobalConstant.APP_JSON;
      const headers = new HttpHeaders(obj);
      const reqUrl = `${this.fccGlobalConstantService.getFileDetails}?id=${refId}`;
      return this.http.get<any>(reqUrl, { headers, observe: 'response' });
    }

    getTnxFileDetails(eventId: string) {
      const obj = {};
      obj[this.contentType] = FccGlobalConstant.APP_JSON;
      const headers = new HttpHeaders(obj);
      const reqUrl = `${this.fccGlobalConstantService.getFileDetails}?eventId=${eventId}`;
      return this.http.get<any>(reqUrl, { headers, observe: 'response' });
    }

    getFileExtPath(fileName: string) {
      this.contextPath = this.contextPath = this.fccGlobalConstantService.contextPath;
      const fileExtn = fileName.split('.').pop().toLowerCase();
      const path = `${this.contextPath}`;
      const alt = `" alt = "`;
      const imgSrcStartTag = '<img src="';
      const endTag = '"/>';
      const pdfFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.PDF_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.PDF_ALT)}`).concat(endTag);
      const docFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.DOC_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.DOC_ALT)}`).concat(endTag);
      const xlsFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.XLS_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.XSL_ALT)}`).concat(endTag);
      const xlsxFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.XLSX_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.XSLS_ALT)}`).concat(endTag);
      const pngFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.PNG_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.PNG_ALT)}`).concat(endTag);
      const jpgFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.JPG_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.JPG_ALT)}`).concat(endTag);
      const txtFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.TXT_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.TXT_ALT)}`).concat(endTag);
      const zipFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.ZIP_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.ZIP_ALT)}`).concat(endTag);
      const rtgFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.RTF_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.RTF_ALT)}`).concat(endTag);
      const csvFilePath = imgSrcStartTag.concat(path).concat(FccGlobalConstant.CSV_IMG_PATH).concat(alt)
      .concat(`${this.translateService.instant(FccGlobalConstant.CSV_ALT)}`).concat(endTag);
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

    viewFile(docId, fileName){
      let docUrl = this.fccGlobalConstantService.getFileDownloadUrl(docId);
      docUrl = `${docUrl}/content`;
      let title = this.translateService.instant('viewAttachment');
      title = `${title} | ${fileName}`;
      const overlayConfig = {
        styleClass: 'fileViewLayoutClass',
        showHeader: true,
        header: title,
        dir: this.dir,
        data: {
          docUrl: docUrl,
          componentName: this.fccGlobalConstantService.getFileViewerComponent()
        },
      };
      this.fccOverlayService.open(overlayConfig);
    }

}
