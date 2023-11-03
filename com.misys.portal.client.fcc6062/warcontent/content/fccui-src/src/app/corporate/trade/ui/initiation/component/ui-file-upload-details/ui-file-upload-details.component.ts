import { Component, OnInit, ViewChild, OnDestroy } from '@angular/core';
import { ActivatedRoute, Params, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService } from 'primeng/api';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { FileUpload } from 'primeng/fileupload';
import { CurrencyConverterPipe } from './../../../../lc/initiation/pipes/currency-converter.pipe';

import { DialogWindowControl } from '../../../../../../../app/base/model/form-controls.model';
import { FccGlobalConstantService } from '../../../../../../../app/common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../../../app/common/core/fcc-global-constants';
import { CommonService } from '../../../../../../../app/common/services/common.service';
import { HideShowDeleteWidgetsService } from '../../../../../../../app/common/services/hide-show-delete-widgets.service';
import { LcTemplateService } from '../../../../../../../app/common/services/lc-template.service';
import { SessionValidateService } from '../../../../../../../app/common/services/session-validate-service';
import { LcConstant } from '../../../../../../../app/corporate/trade/lc/common/model/constant';
import { FCCFormGroup } from '../../../../../../base/model/fcc-control.model';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { FileHandlingService } from '../../../../../../common/services/file-handling.service';
import { FormModelService } from '../../../../../../common/services/form-model.service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { LeftSectionService } from '../../../../../common/services/leftSection.service';
import { ProductStateService } from '../../../../lc/common/services/product-state.service';
import { SaveDraftService } from '../../../../lc/common/services/save-draft.service';
import {
  ConfirmationDialogComponent,
} from '../../../../lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import {
  FileUploadDialogComponent,
} from '../../../../lc/initiation/component/file-upload-dialog/file-upload-dialog.component';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { FormControlService } from '../../../../lc/initiation/services/form-control.service';
import { FileMap } from '../../../../lc/initiation/services/mfile';
import { PrevNextService } from '../../../../lc/initiation/services/prev-next.service';
import { UtilityService } from '../../../../lc/initiation/services/utility.service';
import { UiProductComponent } from '../ui-product/ui-product.component';
import { UiProductService } from '../../../services/ui-product.service';
import { HOST_COMPONENT } from '../../../../../../../../src/app/shared/FCCform/form/form-resolver/form-resolver.directive';
@Component({
  selector: 'app-ui-file-upload-details',
  templateUrl: './ui-file-upload-details.component.html',
  styleUrls: ['./ui-file-upload-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: UiFileUploadDetailsComponent }]
})
export class UiFileUploadDetailsComponent extends UiProductComponent implements OnInit, OnDestroy {

  @ViewChild(FileUploadDialogComponent) public fileDialogReference;

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
  form: FCCFormGroup;
  public data: FileMap[] = [];
  noOfFiles: number;
  blob: Blob;
  validFileExtensions: any = [];
  lcConstant = new LcConstant();
  totalSections = 11;
  headerEnableOrDisable: any;
  btndisable = 'btndisable';
  params = FccGlobalConstant.PARAMS;
  rendered = FccGlobalConstant.RENDERED;
  label = FccGlobalConstant.LABEL;
  isValidFile = false;
  fileModel: FileMap;
  allFileExtensions: any;
  processingFiles: any = [];
  messageSet: Set<number> = new Set<number>();
  contextPath: any;
  modeValue: any;
  index: any;
  tableColumns = [];
  docId = [];
  dataParam = FccGlobalConstant.DATA;
  attachmentId = FccGlobalConstant.ATTACHMENT_ID;
  isFileSizeValid = false;
  isFileExtValid = false;
  numberOfFile: any;
  tnxTypeCode: any;
  operation: string;
  option: string;
  isFileNameValid = false;


  constructor(protected commonService: CommonService, protected sessionValidation: SessionValidateService,
              protected translateService: TranslateService, protected router: Router, protected leftSectionService: LeftSectionService,
              public dialogService: DialogService, public uploadFile: FilelistService, public deleteFile: CommonService,
              public downloadFile: CommonService, protected prevNextService: PrevNextService, protected utilityService: UtilityService,
              protected saveDraftService: SaveDraftService, protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
              public autoUploadFile: CommonService, protected fileListSvc: FilelistService, public lcDetails: SaveDraftService,
              protected lcTemplateService: LcTemplateService, protected formModelService: FormModelService,
              protected formControlService: FormControlService, protected fccGlobalConstantService: FccGlobalConstantService,
              protected eventEmitterService: EventEmitterService, protected productStateService: ProductStateService,
              protected fileHandlingService: FileHandlingService, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected resolverService: ResolverService, protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected uiProductService: UiProductService,
              protected route: ActivatedRoute) {
              super(eventEmitterService, productStateService, commonService, translateService, confirmationService,
                customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray, dialogRef,
                currencyConverterPipe, uiProductService);
              this.module = `${this.translateService.instant(FccGlobalConstant.UI_FILE_UPLOAD_DETAIL)}`;
  }

  ngOnInit(): void {
    super.ngOnInit();
    this.initializeFormGroup();
    // this.hideShowDeleteWidgetsService.customiseSubject.subscribe(data => {
    //   this.headerEnableOrDisable = data;
    // });
    this.route.queryParamMap.subscribe((params: Params) => {
      this.option = params.get(`${FccGlobalConstant.OPTION}`);
    });
    window.scroll(0, 0);
    if (this.operation !== FccGlobalConstant.LIST_INQUIRY && this.operation !== FccGlobalConstant.PREVIEW ) {
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
          this.validFileExtensions.push(element.replace(/[\[\]"]/g, '').toUpperCase());
        });
        this.patchFieldParameters(this.form.get('fileExtnText'), {
          label: `${this.translateService.instant('fileUploadExtn')}` +
            `${this.validFileExtensions}` + `.`
        });
        this.showUploadedFiles();
      }
    });
  }
    const numberOfFiles = this.uploadFile.numberOfFiles;
    if (this.stateService.getSectionData('uiFileUploadDetails').get('attachments').value[FccGlobalConstant.DOC_ID]) {
      this.renderBrowseButton(this.stateService.getSectionData('uiFileUploadDetails')
      .get('attachments').value[FccGlobalConstant.DOC_ID].length);
    }
    if (numberOfFiles <= this.numberOfFilesRegex ) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: '' });
      this.form.updateValueAndValidity();
    }
    this.addEventsForDragDropArea();
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
    const sectionName = FccGlobalConstant.UI_FILE_UPLOAD_DETAIL;
    this.form = this.productStateService.getSectionData(sectionName);
    this.operation = this.commonService.getQueryParametersFromKey('operation');
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (mode === FccGlobalConstant.DRAFT_OPTION && this.fileList() && this.fileList().length > 0) {
      this.setAttachmentIds(this.fileList(), this.form);
    }
    if (this.operation !== FccGlobalConstant.LIST_INQUIRY && this.operation !== FccGlobalConstant.PREVIEW ) {
      let tnxid = this.commonService.eventId ? this.commonService.eventId : this.commonService.getQueryParametersFromKey('tnxid');
      tnxid = this.commonService.isNonEmptyValue(tnxid) ? tnxid :
      this.commonService.getQueryParametersFromKey(FccGlobalConstant.TRANSACTION_ID);
      this.fileHandlingService.getFileAttachment(tnxid, this.form);
      this.patchFieldParameters(this.form.get('fileUploadTable'), { columns: this.getColumns() });
      this.patchFieldParameters(this.form.get('fileUploadTable'), { data: this.fileList() });
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
    if (numberOfFiles >= this.numberOfFilesRegex) {
      this.form.get('browseButton')[this.params][this.btndisable] = true;
    } else {
      this.form.get('browseButton')[this.params][this.btndisable] = false;
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
    let uiRefId = this.commonService.referenceId;
    let eventId = this.commonService.eventId;
    if (!(this.commonService.isNonEmptyValue(uiRefId) && uiRefId === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      uiRefId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    }
    if (!(this.commonService.isNonEmptyValue(eventId) && eventId === '')
    && mode === FccGlobalConstant.DRAFT_OPTION) {
      eventId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_ID);
    }
    if (uiRefId === undefined || uiRefId === null || uiRefId === ''
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
          await this.autoUploadFile.uploadAttachments(this.fileModel.file, this.fileModel.title, uiRefId, eventId).toPromise().then(
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
    return this.checkValidFileExt(this.getFileExt(file.name));
  }

  checkValidFileExt(fileExt): boolean {
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
    let uiRefId = this.commonService.referenceId;
    let eventId = this.commonService.eventId;
    let entityDetails;
    if (this.commonService.isnonEMptyString(this.stateService.isStateSectionSet('uiApplicantBeneficiaryDetails', false))) {
    entityDetails = this.stateService.getControl('uiApplicantBeneficiaryDetails', 'applicantEntity');
    // checking if option === 'TEMPLATE' && entity has been selected
    if (!(entityDetails && Object.values(entityDetails).length && this.option === FccGlobalConstant.TEMPLATE))
    {
      if (!(this.commonService.isNonEmptyValue(uiRefId) && uiRefId === '')
      && mode === FccGlobalConstant.DRAFT_OPTION) {
        uiRefId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
      }
      if (!(this.commonService.isNonEmptyValue(eventId) && eventId === '')
      && mode === FccGlobalConstant.DRAFT_OPTION) {
        eventId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_ID);
      }
      if (uiRefId === undefined || uiRefId === null || uiRefId === ''
        || eventId === undefined || eventId === null || eventId === '') {
        this.messageSet.add(FccGlobalConstant.LENGTH_3);
        this.showMessage();
        return;
      }
    }
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
      const dialogRef = this.dialogService.open(FileUploadDialogComponent, {
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
      style: { direction: dir }
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === 'yes') {
        const a = this.fileList()[index].attachmentId;
        this.deleteFile.deleteAttachments(a).subscribe();
        this.removeSelectedRow(a);
        const numberOfFiles = this.uploadFile.numberOfFiles;
        if (numberOfFiles < this.numberOfFilesRegex) {
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
      this.patchFieldParameters(this.form.get('fileUploadTable'), {
        message: `${this.translateService.instant('fileAttachmentFailed')}` +
          this.sizeOfFileRegex + ` MB.`
      });
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
    this.productStateService.setStateSection(
      FccGlobalConstant.FILE_UPLOAD,
      this.form
    );
  }

  ngOnDestroy() {
    // if (this.form.get('fileUploadTable') && this.form.get('attachments')) {
    //   const docIds = [];
    //   const files = this.form.get('fileUploadTable')[this.params][this.dataParam];
    //   for (const index in files) {
    //     if (files[index]) {
    //       docIds.push(files[index][this.attachmentId]);
    //     }
    //   }
    //   const attachments = { docId: docIds };
    //   this.form.get('attachments').setValue(attachments);
    //   this.form.get('attachments').updateValueAndValidity();
    //   this.form.updateValueAndValidity();
    // }
    this.productStateService.setStateSection(FccGlobalConstant.FILE_UPLOAD, this.form);
  }

  onClickNext() {
    this.saveFormObject();
    this.saveDraftService.changeSaveStatus(FccGlobalConstant.FILE_UPLOAD,
      this.productStateService.getSectionData(FccGlobalConstant.FILE_UPLOAD));
  }

  onClickPrevious() {
    this.saveFormObject();
    if (!CommonService.isTemplateCreation) {
      this.saveDraftService.changeSaveStatus(FccGlobalConstant.FILE_UPLOAD,
        this.productStateService.getSectionData(FccGlobalConstant.FILE_UPLOAD));
    }
  }


  onClickCancel() {
    this.lcTemplateService.getConfirmaton();
  }
}
