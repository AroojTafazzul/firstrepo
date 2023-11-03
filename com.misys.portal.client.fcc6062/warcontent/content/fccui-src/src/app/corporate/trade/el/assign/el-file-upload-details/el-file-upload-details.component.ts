import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService } from 'primeng';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { FileUpload } from 'primeng/fileupload';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

import { FCCFormGroup } from '../../../../../../app/base/model/fcc-control.model';
import { DialogWindowControl } from '../../../../../../app/base/model/form-controls.model';
import { FccGlobalConstantService } from '../../../../../../app/common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../../app/common/core/fcc-global-constants';
import { CommonService } from '../../../../../../app/common/services/common.service';
import { EventEmitterService } from '../../../../../../app/common/services/event-emitter-service';
import { FileHandlingService } from '../../../../../../app/common/services/file-handling.service';
import { FormModelService } from '../../../../../../app/common/services/form-model.service';
import { HideShowDeleteWidgetsService } from '../../../../../../app/common/services/hide-show-delete-widgets.service';
import { LcTemplateService } from '../../../../../../app/common/services/lc-template.service';
import { SessionValidateService } from '../../../../../../app/common/services/session-validate-service';
import { LeftSectionService } from '../../../../../../app/corporate/common/services/leftSection.service';
import { ResolverService } from '../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../common/services/search-layout.service';
import { LcConstant } from '../../../lc/common/model/constant';
import { ProductStateService } from '../../../lc/common/services/product-state.service';
import { SaveDraftService } from '../../../lc/common/services/save-draft.service';
import {
  ConfirmationDialogComponent,
} from '../../../lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { CurrencyConverterPipe } from '../../../lc/initiation/pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../lc/initiation/services/filelist.service';
import { FormControlService } from '../../../lc/initiation/services/form-control.service';
import { FileMap } from '../../../lc/initiation/services/mfile';
import { PrevNextService } from '../../../lc/initiation/services/prev-next.service';
import { UtilityService } from '../../../lc/initiation/services/utility.service';
import { ElProductComponent } from '../../el-product/el-product.component';
import { ElProductService } from '../../services/el-product.service';
import { ElFileUploadDailogComponent } from '../el-file-upload-dailog/el-file-upload-dailog.component';

@Component({
  selector: 'app-el-file-upload-details',
  templateUrl: './el-file-upload-details.component.html',
  styleUrls: ['./el-file-upload-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: ElFileUploadDetailsComponent }]
})
export class ElFileUploadDetailsComponent extends ElProductComponent implements OnInit, OnDestroy {
  confirmMsg: string;
  resultOfConfirmation: string;
  maxNoOfFiles: number;
  maxSizeOfFile: number;
  imagePath: string;
  hideUploadButton: boolean;
  headerMessage: string;
  module: string;
  numberOfFilesRegex = 0;
  sizeOfFileRegex;
  isFileSizeValid = false;
  isFileExtValid = false;
  numberOfFile: any;
  form: FCCFormGroup;
  public data: FileMap[] = [];
  noOfFiles: number;
  blob: Blob;
  validFileExtensions: any = [];
  lcConstant = new LcConstant();
  totalSections = 11;
  headerEnableOrDisable: any;
  params = 'params';
  btndisable = 'btndisable';
  rendered = 'rendered';
  label = 'label';
  isValidFile = false;
  fileModel: FileMap;
  allFileExtensions: any;
  processingFiles: any = [];
  messageSet: Set<number> = new Set<number>();
  contextPath: any;
  modeValue: any;
  index: any;
  tnxTypeCode: any;
  docId: any;
  dataParam = 'data';
  attachmentId = 'attachmentId';
  isFileNameValid = false;

  constructor(protected commonService: CommonService, protected sessionValidation: SessionValidateService,
              protected translateService: TranslateService, protected router: Router, protected leftSectionService: LeftSectionService,
              public dialogService: DialogService, public uploadFile: FilelistService, public deleteFile: CommonService,
              public downloadFile: CommonService, protected prevNextService: PrevNextService, protected utilityService: UtilityService,
              protected saveDraftService: SaveDraftService, protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
              public autoUploadFile: CommonService, protected fileListSvc: FilelistService, public lcDetails: SaveDraftService,
              protected lcTemplateService: LcTemplateService, protected formModelService: FormModelService,
              protected formControlService: FormControlService, protected fccGlobalConstantService: FccGlobalConstantService,
              protected emitterService: EventEmitterService, protected stateService: ProductStateService,
              protected fileHandlingService: FileHandlingService, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected resolverService: ResolverService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected elProductService: ElProductService) {
    super(emitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
         searchLayoutService, utilityService, resolverService, fileListSvc, dialogRef, currencyConverterPipe, elProductService);
    this.module = this.translateService.instant('elFileUploadDetails');
  }

  @ViewChild(ElFileUploadDailogComponent) public fileDialogReference;

  ngOnInit() {
    super.ngOnInit();
    this.initializeFormGroup();
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.contextPath = this.fccGlobalConstantService.contextPath;
    // this.hideShowDeleteWidgetsService.customiseSubject.subscribe(data => {
    //   this.headerEnableOrDisable = data;
    // });
    window.scroll(0, 0);
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.numberOfFilesRegex = response.FileUploadMaxLimit;
        this.sizeOfFileRegex = response.FileUploadMaxSize;
        this.fileUploadMaxSize = response.FileUploadMaxSize;
        this.form.get('fileMaxLimits')[this.params][this.label] = `${this.translateService.instant('Maximum_')}` + this.numberOfFilesRegex
                                                          + `${this.translateService.instant('_files_and_')}` + this.sizeOfFileRegex
                                                          + `${this.translateService.instant('_MB_each')}`;
        this.allFileExtensions = response.validFileExtensions.split(',');
        this.validFileExtensions = [];
        this.allFileExtensions.forEach(element => {
          //eslint-disable-next-line no-useless-escape
          if (this.validFileExtensions.indexOf(element.replace(/[\[\]"]/g, '').toUpperCase()) === -1) {
            //eslint-disable-next-line no-useless-escape
            this.validFileExtensions.push(element.replace(/[\[\]"]/g, '').toUpperCase());
          }
        });
        this.patchFieldParameters(this.form.get('fileExtnText'), { label: `${this.translateService.instant('fileUploadExtn')}` +
          `${this.validFileExtensions}` + `.` });
        this.showUploadedFiles();
      }
    });
    const numberOfFiles = this.uploadFile.numberOfFiles;
    if (numberOfFiles <= this.numberOfFilesRegex ) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: '' });
      this.form.updateValueAndValidity();
    }
    this.addEventsForDragDropArea();
    }




    initializeFormGroup() {
      const sectionName = 'elFileUploadDetails';
      this.form = this.stateService.getSectionData(sectionName);
      const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
      if (mode === FccGlobalConstant.DRAFT_OPTION && this.getFileList() && this.getFileList().length > 0) {
        this.setAttachmentIds(this.getFileList(), this.form);
      }
      this.patchFieldParameters(this.form.get('fileUploadTable'), { columns: this.getColumns() });
      this.patchFieldParameters(this.form.get('fileUploadTable'), { data: this.getFileList() });
      // this.fileHandlingService.getFileAttachment(this.commonService.eventId, this.form);
      const operation = this.commonService.getQueryParametersFromKey('operation');
      const eventTab = this.commonService.getQueryParametersFromKey('eventTab');
      const transactionTab = this.commonService.getQueryParametersFromKey('transactionTab');
      const eventTnxId = this.commonService.getQueryParametersFromKey('eventTnxId');
      const reviewTnxId = this.commonService.getQueryParametersFromKey('reviewTnxId');
      const refID = this.commonService.getQueryParametersFromKey('referenceid');
      let tnxId;

      if (operation !== undefined && operation === 'LIST_INQUIRY') {

           if ( reviewTnxId && transactionTab ) {
            tnxId = reviewTnxId;
           } else if (eventTab && eventTnxId ) {
            tnxId = eventTnxId;
           }

           if (tnxId && tnxId !== '') {
          this.fileHandlingService.getFileAttachment(tnxId, this.form);
        } else {
          this.fileHandlingService.getFileAttachmentWithID(refID, this.form);
        }
      } else {
        const eventId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TRANSACTION_ID);
        const tnxid = this.commonService.eventId ? this.commonService.eventId :
          this.commonService.getQueryParametersFromKey(FccGlobalConstant.TRANSACTION_ID);
        const fileTnxId = ((this.commonService.isNonEmptyField(FccGlobalConstant.PARENT_TNX_ID, this.form) &&
        this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.PARENT_TNX_ID).value) &&
        this.form.get(FccGlobalConstant.PARENT_TNX_ID).value !== '') ? this.form.get(FccGlobalConstant.PARENT_TNX_ID).value : tnxid);
        this.fileHandlingService.getTnxFileDetails(fileTnxId ).subscribe(
          response1 => {
            if (response1 && response1.body && response1.body.items) {
              this.uploadFile.resetList();
              for (const values of response1.body.items) {
                if ( values.type === 'CUSTOMER' && this.tnxTypeCode === '13' && values.eventId !== eventId) {
                  this.docId = values.docId;
                  this.fileModel = new FileMap(null, values.fileName, values.title, values.type,
                    this.getFileExtPath(values.fileName), this.getFileSize(values.size), this.docId, null, null, null,
                    null, this.commonService.decodeHtml(values.mimeType));
                  this.uploadFile.pushFile(this.fileModel);
                  this.form.updateValueAndValidity();
                } else if (values.type === 'CUSTOMER' && this.tnxTypeCode === '13' && values.eventId === eventId
                ) {
                    this.docId = values.docId;
                    this.fileModel = new FileMap(null, values.fileName, values.title, values.type,
                      this.getFileExtPath(values.fileName), this.getFileSize(values.size), this.docId, null, null, null,
                       null, this.commonService.decodeHtml(values.mimeType));
                    this.uploadFile.pushFile(this.fileModel);
                    this.form.updateValueAndValidity();
                  
                } else if (values.type === 'CUSTOMER') {
                  this.docId = values.docId;
                  this.fileModel = new FileMap(null, values.fileName, values.title, values.type,
                    this.getFileExtPath(values.fileName), this.getFileSize(values.size), this.docId, null, null, null,
                     null, this.commonService.decodeHtml(values.mimeType));
                  this.uploadFile.pushFile(this.fileModel);
                  this.form.updateValueAndValidity();
                }
              }
            }
          }
        );
      }
  }

    getSpinnerStyle() {
      const langDir = localStorage.getItem('langDir');
      if (langDir === 'rtl') {
        return 'spinnerRightStyle';
      } else {
        return 'spinnerLeftStyle';
      }
    }

  addEventsForDragDropArea() {
    setTimeout(() => {
      const doc = document.getElementsByClassName('ui-fileupload-content')[0] as HTMLElement;
      const innerDoc = document.getElementsByClassName('dragDropInner')[0] as HTMLElement;
      if (doc === undefined || doc === null) {
        return;
      }
      doc.addEventListener('drop', () => {
        doc.style.borderColor = FccGlobalConstant.FILEUPLOAD_DEFAULT_COLOR;
        innerDoc.style.opacity = '1';
      });
      doc.addEventListener('dragover', () => {
        doc.style.borderColor = FccGlobalConstant.FILEUPLOAD_HIGHLIGTED_COLOR;
        innerDoc.style.opacity = FccGlobalConstant.FILEUPLOAD_STYLE_OPACITY;
      });
      doc.addEventListener('dragleave', () => {
        doc.style.borderColor = FccGlobalConstant.FILEUPLOAD_DEFAULT_COLOR;
        innerDoc.style.opacity = '1';
      });
      }, FccGlobalConstant.LENGTH_2000);
  }

  startProcessing() {
    this.form.addControl('dialogWindow',
      new DialogWindowControl('dialogWindow', '', this.translateService, {
        label: `${this.translateService.instant('uploading')}`,
        displayPosition: true,
        rendered: true,
        columns: [
          {
            field: 'fileName',
            header: 'FILE NAME'
          }],
        data: this.getProcessingFiles(),
        showSpinner: true,
        positionLeft: 0,
        positionTop: 0,
        styleClass: 'dialogStyle',
        SpinnerStyle: this.getSpinnerStyle(),
        dialogStyleClass: 'dialogStyleClass'
      }),
    );
    this.form.updateValueAndValidity();
  }
  endProcessing() {
    this.form.removeControl('dialogWindow');
    this.showUploadedFiles();
  }

  getProcessingFiles() {
    return this.processingFiles;
  }

  addFilesToDialog(filesArray) {
    this.processingFiles = [];
    filesArray.forEach(element => {
      const file = { fileName: element.name };
      this.processingFiles.push(file);
    });
  }

  async onAutoUploadHandler(event, uploader: FileUpload) {
    this.messageSet.clear();
    this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
    if (this.uploadFile.numberOfFiles >= this.numberOfFilesRegex) {
      uploader.clear();
      this.messageSet.add(0);
      this.showMessage();
      return;
    }
    const filesLength = event.files.length;
    const filesArray = event.files;
    this.addFilesToDialog(filesArray);
    uploader.clear();
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    let lcNumber = this.commonService.referenceId;
    let eventId = this.commonService.eventId;
    if (!(this.commonService.isNonEmptyValue(lcNumber) && lcNumber === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      lcNumber = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    }
    if (!(this.commonService.isNonEmptyValue(eventId) && eventId === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      eventId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_ID);
    }
    if (lcNumber === undefined || lcNumber === null || lcNumber === ''
        || eventId === undefined || eventId === null || eventId === '') {
          this.messageSet.add(FccGlobalConstant.LENGTH_3);
          this.showMessage();
          return;
    }
    for (let i = 0; i < filesLength; i++) {
      if (this.uploadFile.numberOfFiles < this.numberOfFilesRegex) {
        this.isFileSizeValid = this.checkValidFile(filesArray[i]);
        this.isFileExtValid = this.checkFileExt(filesArray[i]);
        this.isFileNameValid = this.checkValidFileName(filesArray[i]);
        this.fileModel = new FileMap(filesArray[i], filesArray[i].name, filesArray[i].name, this.getFileExt(filesArray[i].name),
                         this.getFileExtPath(filesArray[i].name), this.getFileSize(filesArray[i].size), null, null, null, null, null);
        if (this.isFileSizeValid && this.isFileExtValid) {
            if(!this.isFileNameValid && this.fileModel.title !== null && this.fileModel.title !== " " ) {
               this.fileModel.title = this.fileModel.title.substring(0,35);
                }
          this.fileModel.file = new File([this.fileModel.file], encodeURIComponent(this.fileModel.fileName),
          { type: this.fileModel.file.type, lastModified: this.fileModel.file.lastModified });
          await this.autoUploadFile.uploadAttachments(this.fileModel.file, this.fileModel.title, lcNumber, eventId).toPromise().then(
            response => {
              this.fileModel.attachmentId = response.docId;
              this.fileListSvc.pushFile(this.fileModel);
            });
          } else if (!this.isFileSizeValid) {
            this.messageSet.add(1);
        } else if (!this.isFileExtValid) {
          this.messageSet.add(FccGlobalConstant.LENGTH_2);
        } else if (!this.isFileNameValid) {
          this.messageSet.add(FccGlobalConstant.LENGTH_4);
        }
      } else {
        this.messageSet.add(0);
        break;
      }
    }
    this.endProcessing();
    this.showMessage();
  }

  getFileExt(fileName: string) {
    return fileName.split('.').pop();
  }

  checkValidFile(file) {
    const maxFileSize = FccGlobalConstant.FILEUPLOAD_MB_BYTE * this.sizeOfFileRegex;
    if (file.size === 0) {
        return false;
    } else if (file.size > maxFileSize) {
        return false;
    }
    return true;
  }

  checkFileExt(file: any) {
    return this.checkValidFileExtensionfn(this.getFileExt(file.name));
  }

  checkValidFileExtensionfn(fileExt): boolean {
    for (let i = 0; i < this.validFileExtensions.length; i++) {
      const ext: string = this.validFileExtensions[i].toLowerCase();
      if (ext.trim() === fileExt.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  checkValidFileName(file: any) {
    if (file.name.length > 35) {
      return false;
    }
    return true;
  }

    onClickBrowseButton() {
    this.messageSet.clear();
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    let lcNumber = this.commonService.referenceId;
    let eventId = this.commonService.eventId;
    if (!(this.commonService.isNonEmptyValue(lcNumber) && lcNumber === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      lcNumber = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    }
    if (!(this.commonService.isNonEmptyValue(eventId) && eventId === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      eventId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_ID);
    }
    if (lcNumber === undefined || lcNumber === null || lcNumber === ''
        || eventId === undefined || eventId === null || eventId === '') {
        this.messageSet.add(FccGlobalConstant.LENGTH_3);
        this.showMessage();
        return;
    }
    this.numberOfFile = this.uploadFile.numberOfFiles;
    if (this.numberOfFile >= this.numberOfFilesRegex) {
        this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: true });
        this.patchFieldParameters(this.form.get('fileUploadTable'), { message: `${this.translateService.instant('MaxFileReached')}` });
        this.form.updateValueAndValidity();
        return;
    } else {
    this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
    // this.hideShowDeleteWidgetsService.customiseSubject.next(true);
    const dir = localStorage.getItem('langDir');
    const dialogRef = this.dialogService.open(ElFileUploadDailogComponent, {
      header: `${this.translateService.instant('fileDetails')}`,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir }
    });
    dialogRef.onClose.subscribe(() => {
      this.hideShowDeleteWidgetsService.customiseSubject.next(false);
      this.showUploadedFiles();
    });
  }
}
  showUploadedFiles() {
      this.noOfFiles = this.uploadFile.numberOfFiles;
      this.renderBrowseButton(this.noOfFiles);
      if (this.noOfFiles !== 0) {
        this.patchFieldParameters(this.form.get('fileUploadTable'), { columns: this.getColumns() });
        this.patchFieldParameters(this.form.get('fileUploadTable'), { data: this.getFileList() });
        this.patchFieldParameters(this.form.get('fileUploadTable'), { hasData: true });
        this.form.updateValueAndValidity();
        this.form.get('fileUploadTable').updateValueAndValidity();
        this.setAttachmentIds(this.getFileList(), this.form);
      } else {
        this.patchFieldParameters(this.form.get('fileUploadTable'), { hasData: false });
      }
  }

  renderBrowseButton(numberOfFiles) {
    if (numberOfFiles >= this.numberOfFilesRegex) {
      this.form.get('browseButton')[this.params][this.btndisable] = true;
    } else {
      this.form.get('browseButton')[this.params][this.btndisable] = false;
    }
  }

  onClickDownloadIcon(event, key, index) {
    const id = this.getFileList()[index].attachmentId;
    const fileName = this.getFileList()[index].fileName;
    this.downloadFile.downloadAttachments(id).subscribe(
      response => {
        let fileType;
        if (response.type) {
          fileType = response.type;
        } else {
          fileType = 'application/octet-stream';
        }
        const newBlob = new Blob([response.body], { type: fileType });

        // IE doesn't allow using a blob object directly as link href
        // instead it is necessary to use msSaveOrOpenBlob
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveOrOpenBlob(newBlob, fileName);
            return;
        }

        const data = window.URL.createObjectURL(newBlob);
        const link = document.createElement('a');
        link.href = data;
        link.download = fileName;
        // this is necessary as link.click() does not work on the latest firefox
        link.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true, view: window }));

        window.URL.revokeObjectURL(data);
        link.remove();
    });
  }

  onClickTrashIcon(event, key, index) {
    const dir = localStorage.getItem('langDir');
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      header: `${this.translateService.instant('deleteFile')}`,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir },
      data: { locaKey: FccGlobalConstant.DELETE_ATTACHMENT_CONFIRMATION_MSG }
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === 'yes') {
        const a = this.getFileList()[index].attachmentId;
        this.deleteFile.deleteAttachments(a).subscribe();
        this.removeSelectedRow(a);
        const numberOfFiles = this.uploadFile.numberOfFiles;
        if (numberOfFiles < this.numberOfFilesRegex ) {
          this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
          this.patchFieldParameters(this.form.get('fileUploadTable'), { message: '' });
          this.form.updateValueAndValidity();
        }
      }
    });
  }

  removeSelectedRow(deleteID: string) {
    let attids = null;
    let removeIndex = null;
    for (let i = 0; i < this.uploadFile.fileMap.length; ++i) {
      if (this.uploadFile.fileMap[i].attachmentId !== deleteID) {
          if (attids === null) {
              attids = this.uploadFile.fileMap[i].attachmentId;
          } else {
            attids = `${attids} | ${this.uploadFile.fileMap[i].attachmentId}`;
          }
        } else {
          removeIndex = i;
        }
      }
    if (removeIndex !== null) {
      this.uploadFile.fileMap.splice(removeIndex, 1);
    }
    if (this.uploadFile.fileMap.length === 0) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasData: false });
    }
    this.renderBrowseButton(this.uploadFile.numberOfFiles);
    this.showUploadedFiles();
  }

  getFileExtPath(fileName: string) {
    return this.commonService.getFileExtPath(fileName);
  }

  showMessage() {
    if (this.messageSet.has(0)) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: `${this.translateService.instant('MaxFileReached')}` });
    } else if (this.messageSet.has(1)) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: `${this.translateService.instant('fileAttachmentFailed')}` +
          this.sizeOfFileRegex + ` MB.` });
    } else if (this.messageSet.has(FccGlobalConstant.LENGTH_2)) {
      const errorMsg = `${this.translateService.instant('fileValidExtnError')} `
                                                                + this.validFileExtensions + `${this.translateService.instant('.')}`;
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: errorMsg });
      this.form.updateValueAndValidity();
    } else if (this.messageSet.has(FccGlobalConstant.LENGTH_3)) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: `${this.translateService.instant('entityNotSelected')}` });
    } else if (this.messageSet.has(FccGlobalConstant.LENGTH_4)) {
      this.patchFieldParameters(this.form.get("fileUploadTable"), {
        message: `${this.translateService.instant("fileTitleLengthExceeded")}`,
      });
    }
    if (this.messageSet.size !== 0) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: true });
      setTimeout(() => {
        this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
        this.patchFieldParameters(this.form.get('fileUploadTable'), { message: '' });
     }, FccGlobalConstant.LENGTH_5000);
    }
  }

  saveFormObject() {
    this.stateService.setStateSection(
      FccGlobalConstant.FILE_UPLOAD,
      this.form
    );
  }

  ngOnDestroy() {
    // if (this.form.get('fileUploadTable') && this.form.get('attachments')) {
    // this.docId = [];
    // const files = this.form.get('fileUploadTable')[this.params][this.dataParam];
    // for (const index in files) {
    //   if (files[index]) {
    //     this.docId.push(files[index][this.attachmentId]);
    //   }
    // }
    // const attachments = { docId : this.docId};
    // this.form.get('attachments').setValue(attachments);
    // }
    this.stateService.setStateSection(FccGlobalConstant.FILE_UPLOAD, this.form);
  }

  onClickNext() {
    this.saveFormObject();
    this.saveDraftService.changeSaveStatus(FccGlobalConstant.FILE_UPLOAD,
    this.stateService.getSectionData(FccGlobalConstant.FILE_UPLOAD));
  }

  onClickPrevious() {
    this.saveFormObject();
    if (!CommonService.isTemplateCreation) {
    this.saveDraftService.changeSaveStatus(FccGlobalConstant.FILE_UPLOAD,
      this.stateService.getSectionData(FccGlobalConstant.FILE_UPLOAD));
    }
  }


  onClickCancel() {
  this.lcTemplateService.getConfirmaton();
  }

  // onClickSave(event) {
  //   this.saveDraftService.saveLCTemplate(FccGlobalConstant.GENERAL_DETAILS,
     //      this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS));
  // }

}
