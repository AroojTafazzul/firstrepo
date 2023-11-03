import { LnrpnFileUploadDialogComponent } from './../lnrpn-file-upload-dialog/lnrpn-file-upload-dialog.component';
import { DialogWindowControl } from './../../../../../base/model/form-controls.model';
import { LcConstant } from './../../../../trade/lc/common/model/constant';
import { FileMap } from './../../../../trade/lc/initiation/services/mfile';
import { Component, OnInit, ViewChild, AfterViewChecked, OnDestroy } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, FileUpload } from 'primeng';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { LnrpnProductComponent } from '../lnrpn-product/lnrpn-product.component';
import { FCCFormGroup } from './../../../../../../app/base/model/fcc-control.model';
import { FccGlobalConstantService } from './../../../../../../app/common/core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../../../../../app/common/core/fcc-global-constants';
import { CommonService } from './../../../../../../app/common/services/common.service';
import { FileHandlingService } from './../../../../../../app/common/services/file-handling.service';
import { HideShowDeleteWidgetsService } from './../../../../../../app/common/services/hide-show-delete-widgets.service';
import { SessionValidateService } from './../../../../../../app/common/services/session-validate-service';
import { EventEmitterService } from './../../../../../common/services/event-emitter-service';
import { FormModelService } from './../../../../../common/services/form-model.service';
import { ResolverService } from './../../../../../common/services/resolver.service';
import { SearchLayoutService } from './../../../../../common/services/search-layout.service';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { LeftSectionService } from './../../../../common/services/leftSection.service';
import { ProductStateService } from './../../../../trade/lc/common/services/product-state.service';
import { CurrencyConverterPipe } from './../../../../trade/lc/initiation/pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from './../../../../trade/lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from './../../../../trade/lc/initiation/services/filelist.service';
import { FormControlService } from './../../../../trade/lc/initiation/services/form-control.service';
import { UtilityService } from './../../../../trade/lc/initiation/services/utility.service';
import { ConfirmationDialogComponent } from './../../../../trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { FormControl, Validators } from '@angular/forms';

@Component({
  selector: 'fcc-lnrpn-file-upload-details',
  templateUrl: './lnrpn-file-upload-details.component.html',
  styleUrls: ['./lnrpn-file-upload-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: LnrpnFileUploadDetailsComponent }]
})
export class LnrpnFileUploadDetailsComponent extends LnrpnProductComponent implements OnInit, AfterViewChecked, OnDestroy {
  confirmMsg: string;
  resultOfConfirmation: string;
  maxNoOfFiles: number;
  maxSizeOfFile: number;
  imagePath: string;
  hideUploadButton: boolean;
  headerMessage: string;
  module = `${this.translateService.instant('fileUploadDetails')}`;
  numberOfFilesRegex = 0;
  sizeOfFileRegex;
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
  isFileSizeValid = false;
  isFileExtValid = false;
  isFileNameValid = false;
  fileModel: FileMap;
  allFileExtensions: any;
  processingFiles: any = [];
  messageSet: Set<number> = new Set<number>();
  contextPath: any;
  modeValue: any;
  productCodeValue = FccGlobalConstant.PRODUCT_BK;
  index: any;
  tableColumns = [];
  tnxTypeCode: any;
  numberOfFile: any;
  docId = [];
  dataParam = 'data';
  requestType: any;
  attachmentId = 'attachmentId';
  attachmentList: any;
  noOfAttachments: any;

  constructor(protected commonService: CommonService, protected sessionValidation: SessionValidateService,
              protected translateService: TranslateService, protected router: Router, protected leftSectionService: LeftSectionService,
              public dialogService: DialogService, public uploadFile: FilelistService, public deleteFile: CommonService,
              public downloadFile: CommonService, protected activatedRoute: ActivatedRoute,
              protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
              public autoUploadFile: CommonService, protected fileListSvc: FilelistService,
              protected formModelService: FormModelService,
              protected formControlService: FormControlService, protected fccGlobalConstantService: FccGlobalConstantService,
              protected eventEmitterService: EventEmitterService, protected stateService: ProductStateService,
              protected fileHandlingService: FileHandlingService, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected dialogRef: DynamicDialogRef, protected currencyConverterPipe: CurrencyConverterPipe) {
    super(eventEmitterService, stateService, commonService, translateService, confirmationService,
      customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileListSvc, dialogRef,
      currencyConverterPipe);
  }
  @ViewChild(LnrpnFileUploadDialogComponent) fileDialogReference;

  ngOnInit() {
    super.ngOnInit();
    this.initializeFormGroup();
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.contextPath = this.fccGlobalConstantService.contextPath;
    if (this.commonService.isnonEMptyString(this.stateService.isStateSectionSet(FccGlobalConstant.GENERAL_DETAILS, false))) {
      this.requestType = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get(FccGlobalConstant.REQUEST_OPTION_LC).value;
      if (this.commonService.isnonEMptyString(this.requestType)) {
        if (this.tnxTypeCode === FccGlobalConstant.N002_NEW && this.requestType === '02') {
          this.form.get('attachmentsMessage')[FccGlobalConstant.PARAMS][this.rendered] = true;
        } else {
          this.form.get('attachmentsMessage')[FccGlobalConstant.PARAMS][this.rendered] = false;
        }
      }
    }
    this.checkAttachments();
    window.scroll(0, 0);
    if (this.operation !== FccGlobalConstant.PREVIEW && this.operation !== FccGlobalConstant.LIST_INQUIRY){
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
  }
    this.addEventsForDragDropArea();
  }
  ngAfterViewChecked() {
    setTimeout(() => {
      const anchorElement = document.querySelector('.ui-dialog-titlebar-icon.ui-dialog-titlebar-close.ui-corner-all');
      const dialogTitleElement = document.querySelector('.ui-dialog-title');
      if (anchorElement && anchorElement.getAttribute('tabIndex') && anchorElement.getAttribute('tabIndex') === '0') {
        if (dialogTitleElement) {
          (dialogTitleElement as HTMLElement).focus();
          dialogTitleElement.setAttribute('tabIndex', '1');
        }
        anchorElement.setAttribute('tabIndex', '2');
        (anchorElement as HTMLElement).blur();
      }
    }, FccGlobalConstant.LENGTH_200);
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
              },
              {
                field: 'fileSize',
                header: `${this.translateService.instant('fileSize')}`,
                width: '10%'
              }];
    return this.tableColumns;
  }

  initializeFormGroup() {
    const sectionName = FccGlobalConstant.LNRPN_FILE_UPLOAD_DETAIL;
    this.form = this.stateService.getSectionData(sectionName);
    if (this.form.get('attachmentsList') && this.form.get('attachmentsList').value !== undefined) {
      this.attachmentList = this.form.get('attachmentsList').value;
      if (this.attachmentList && this.form.get('noOfAttachments') && this.form.get('noOfAttachments').value === null) {
        const att = JSON.parse(this.attachmentList);
        if (att.attachment.length > 1) {
          this.form.get('noOfAttachments').setValue(att.attachment.length);
        } else if (att.attachment) {
          this.form.get('noOfAttachments').setValue(1);
        }
      }
    }
    this.operation = this.commonService.getQueryParametersFromKey('operation');
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (mode === FccGlobalConstant.DRAFT_OPTION && this.fileList() && this.fileList().length > 0) {
      this.setAttachmentIds(this.fileList(), this.form);
    }
    if (this.operation !== FccGlobalConstant.LIST_INQUIRY && this.operation !== FccGlobalConstant.PREVIEW) {
      this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_UPLOAD_TABLE), { columns: this.getColumns() });
      this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_UPLOAD_TABLE), { data: this.fileList() });
    }
    if (this.operation !== FccGlobalConstant.PREVIEW && this.operation !== FccGlobalConstant.LIST_INQUIRY){
      let tnxid = this.commonService.eventId ? this.commonService.eventId : this.commonService.getQueryParametersFromKey('tnxid');
      tnxid = this.commonService.isNonEmptyValue(tnxid) ? tnxid :
      this.commonService.getQueryParametersFromKey(FccGlobalConstant.TRANSACTION_ID);
      this.fileHandlingService.getFileAttachment(tnxid, this.form);
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

  fileList() {
    return this.uploadFile.getList();
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
    let bkNumber = this.commonService.referenceId;
    let eventId = this.commonService.eventId;
    if (!(this.commonService.isNonEmptyValue(bkNumber) && bkNumber === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      bkNumber = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    }
    if (!(this.commonService.isNonEmptyValue(eventId) && eventId === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      eventId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_ID);
    }
    if (bkNumber === undefined || bkNumber === null || bkNumber === ''
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
              this.commonService.getFileExtPath(filesArray[i].name), this.getFileSize(filesArray[i].size), null, null, null, null, null);
        if (this.isFileSizeValid && this.isFileExtValid) {
          if(!this.isFileNameValid && this.fileModel.title !== null && this.fileModel.title !== " " ) {
            this.fileModel.title = this.fileModel.title.substring(0,35);
          }
          this.fileModel.file = new File([this.fileModel.file], encodeURIComponent(this.fileModel.fileName),
          { type: this.fileModel.file.type, lastModified: this.fileModel.file.lastModified });
          await this.autoUploadFile.uploadAttachments(this.fileModel.file, this.fileModel.title, bkNumber, eventId).toPromise().then(
            response => {
            this.fileModel.attachmentId = response.docId;
            this.fileListSvc.pushFile(this.fileModel);
            this.noOfAttachments = this.form.get('noOfAttachments').value;
            if (this.noOfAttachments === null || this.noOfAttachments === '') {
                 this.noOfAttachments = 0;
               }
            this.form.get('noOfAttachments').setValue(++this.noOfAttachments);
            this.form.get('noOfAttachments').updateValueAndValidity();
          });
        } else if (!this.isFileSizeValid) {
          this.messageSet.add(1);
        } else if (!this.isFileExtValid) {
          this.messageSet.add(FccGlobalConstant.LENGTH_2);
        }
        else if (!this.isFileNameValid) {
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
    if (file.size === 0 || (file.size > maxFileSize)) {
      return false;
    }
    return true;
  }

  checkValidFileName(file: any) {
    if (file.name.length > 35) {
      return false;
    }
    return true;
  }


  checkFileExt(file: any) {
    return this.commonService.checkValidFileExtension(this.getFileExt(file.name), this.validFileExtensions);
  }

 onClickBrowseButton() {
    this.messageSet.clear();
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    let bkNumber = this.commonService.referenceId;
    let eventId = this.commonService.eventId;
    if (!(this.commonService.isNonEmptyValue(bkNumber) && bkNumber === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      bkNumber = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    }
    if (!(this.commonService.isNonEmptyValue(eventId) && eventId === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      eventId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_ID);
    }
    if (bkNumber === undefined || bkNumber === null || bkNumber === ''
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
      const dir = localStorage.getItem('langDir');
      const dialogRef = this.dialogService.open(LnrpnFileUploadDialogComponent, {
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
      this.patchFieldParameters(this.form.get('fileUploadTable'), { data: this.fileList() });
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasData: true });
      this.form.updateValueAndValidity();
      this.form.get('fileUploadTable').updateValueAndValidity();
      this.setAttachmentIds(this.fileList(), this.form);
    } else {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasData: false });
    }
  }

  renderBrowseButton(numberOfFiles) {
    if (numberOfFiles < this.numberOfFilesRegex) {
      this.form.get('browseButton')[this.params][this.btndisable] = false;
    }
  }

  onClickDownloadIcon(event, key, index) {
    const id = this.fileList()[index].attachmentId;
    const fileName = this.fileList()[index].fileName;
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
        const a = this.fileList()[index].attachmentId;
        this.deleteFile.deleteAttachments(a).subscribe();
        this.removeSelectedRow(a);
        if (this.form.get('noOfAttachments') === null || this.form.get('noOfAttachments') === undefined) {
          this.form.addControl('noOfAttachments', new FormControl (this.fileListSvc.fileMap.length));
        }
        this.noOfAttachments = this.form.get('noOfAttachments').value;
        this.form.get('noOfAttachments').setValue(--this.noOfAttachments);
        this.form.get('noOfAttachments').updateValueAndValidity();
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


  getFileSize(fileSize: any) {
    const a = fileSize / FccGlobalConstant.LENGTH_1000;
    return a + 'KB';
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
    }
    else if (this.messageSet.has(FccGlobalConstant.LENGTH_4)) {
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
      FccGlobalConstant.LNRPN_FILE_UPLOAD_DETAIL,
      this.form
    );
  }

  ngOnDestroy() {
    this.checkAttachments();
    this.stateService.setStateSection(FccGlobalConstant.LNRPN_FILE_UPLOAD_DETAIL, this.form);
  }

  checkAttachments() {
    if (this.commonService.isnonEMptyString(this.requestType)) {
      if (this.tnxTypeCode === FccGlobalConstant.N002_NEW && this.requestType === '02'
      && (this.form.get('noOfAttachments').value === FccGlobalConstant.ZERO || this.form.get('noOfAttachments').value === null)) {
        this.form.get(FccGlobalConstant.ATTACHMENTS)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
        this.form.get(FccGlobalConstant.ATTACHMENTS).setValidators([Validators.required]);
        this.form.get(FccGlobalConstant.ATTACHMENTS).setErrors( { invalid: true } );
        this.form.setErrors({ invalid: true });
        this.form.updateValueAndValidity();
    } else {
        this.form.get(FccGlobalConstant.ATTACHMENTS)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
        this.form.get(FccGlobalConstant.ATTACHMENTS).setErrors(null);
        this.form.get(FccGlobalConstant.ATTACHMENTS).clearValidators();
        this.form.get(FccGlobalConstant.ATTACHMENTS).updateValueAndValidity();
        this.form.updateValueAndValidity();
  }
  }
  }

}

