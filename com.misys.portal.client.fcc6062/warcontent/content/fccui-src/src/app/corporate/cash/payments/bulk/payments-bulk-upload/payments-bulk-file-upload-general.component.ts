import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FileMap } from './../../../../trade/lc/initiation/services/mfile';
import { DialogWindowControl } from './../../../../../base/model/form-controls.model';
import { ConfirmationDialogComponent } from './../../../../trade/lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { FccGlobalConstant } from './../../../../../common/core/fcc-global-constants';
import { EventEmitterService } from './../../../../../common/services/event-emitter-service';
import { ResolverService } from './../../../../../common/services/resolver.service';
import { CurrencyConverterPipe } from './../../../../trade/lc/initiation/pipes/currency-converter.pipe';
import { SearchLayoutService } from './../../../../../common/services/search-layout.service';
import { UtilityService } from './../../../../trade/lc/initiation/services/utility.service';
import { CustomCommasInCurrenciesPipe } from './../../../../trade/lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from './../../../../trade/lc/initiation/services/filelist.service';
import { HideShowDeleteWidgetsService } from './../../../../../common/services/hide-show-delete-widgets.service';
import { CommonService } from './../../../../../common/services/common.service';
import { FccGlobalConstantService } from './../../../../../common/core/fcc-global-constant.service';
import { ProductStateService } from './../../../../trade/lc/common/services/product-state.service';
import { FormControlService } from './../../../../trade/lc/initiation/services/form-control.service';
import { FormModelService } from './../../../../../common/services/form-model.service';
import { FCCFormGroup } from './../../../../../base/model/fcc-control.model';
import { Component, OnDestroy, OnInit, ViewChild, HostListener, Output, EventEmitter } from '@angular/core';
import { FormControl } from '@angular/forms';
import { MatAccordion } from '@angular/material/expansion';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, FileUpload } from 'primeng';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { Subscription } from 'rxjs';
import { FccConstants } from '../../../../../../app/common/core/fcc-constants';
import { PaymentsBulkFiletemplateDownloadComponent } from '../payments-bulk-template-download/payments-bulk-filetemplate-download.component';
import { PaymentsFileUploadDialogComponent } from '../payments-file-upload-dialog/payments-file-upload-dialog.component';
import { PaymentsProductComponent } from '../payments-product/payments-product.component';
import { PaymentInstrumentProductService } from '../../single/services/payment-instrument-product.service';
import { TableColumn } from '../model/table-column';
import { FileName } from '../model/template-data';
import { FCMBeneConstants } from '../../../../system-features/fcm-beneficiary-maintenance/fcm-beneficiary-general-details/fcm-beneficiary-general-details.constants';

@Component({
  selector: 'app-payments-bulk-file-upload-general',
  templateUrl: './payments-bulk-file-upload-general.component.html',
  styleUrls: ['./payments-bulk-file-upload-general.component.scss'],
  providers: [
    { provide: HOST_COMPONENT, useExisting: PaymentsBulkFileUploadGeneralComponent },
  ],
})
export class PaymentsBulkFileUploadGeneralComponent extends PaymentsProductComponent implements OnInit, OnDestroy {

  form: FCCFormGroup;
  module = `${this.translateService.instant('paymentsBulkFileUploadGeneralDetail')}`;
  @ViewChild(MatAccordion) public accordion: MatAccordion;
  @ViewChild(PaymentsBulkFiletemplateDownloadComponent,
    { read: PaymentsBulkFiletemplateDownloadComponent }) public paymentsBulkFileTemplateDownload:
    PaymentsBulkFiletemplateDownloadComponent;

  mode: string;
  subscriptions: Subscription[] = [];
  showSpinner: boolean;
  contextPath: string;
  isValidSize = false;
  tnxTypeCode: string;
  option: string;
  params = 'params';
  btndisable = 'btndisable';
  flag: boolean;
  @ViewChild(PaymentsFileUploadDialogComponent) public fileDialogReference;
  tableColumns: TableColumn[];
  noOfFiles: number;
  numberOfFilesRegex = 0;
  numberOfFile: number;
  sizeOfFileRegex: number;
  fileUploadMaxSize: number;
  fileNameMaxLength: any;
  label: string;
  allFileExtensions: string[];
  processingFiles: FileName[] = [];
  messageSet: Set<number> = new Set<number>();
  isFileSizeValid: boolean;
  isFileExtValid: boolean;
  isFileNameValid: boolean;
  noOfAttachments: number;
  fileUploadFlag = false;
  @Output() checkSubmitStatus: EventEmitter<any> = new EventEmitter();

  constructor(
    protected formModelService: FormModelService,
    protected formControlService: FormControlService,
    protected stateService: ProductStateService,
    protected translateService: TranslateService,
    protected fccGlobalConstantService: FccGlobalConstantService,
    protected commonService: CommonService,
    protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
    public dialogService: DialogService, protected fileListSvc: FilelistService,
    public uploadFile: FilelistService,
    protected confirmationService: ConfirmationService,
    protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
    protected searchLayoutService: SearchLayoutService, protected utilityService: UtilityService,
    protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
    protected currencyConverterPipe: CurrencyConverterPipe, protected paymentsProductService: PaymentInstrumentProductService,
    protected resolverService: ResolverService, public downloadFile: CommonService,
    protected eventEmitterService: EventEmitterService, public deleteFile: CommonService) {
    super(eventEmitterService, stateService, commonService, translateService,
      confirmationService, customCommasInCurrenciesPipe, searchLayoutService, utilityService,
      resolverService, fileArray, dialogRef, currencyConverterPipe, paymentsProductService,
    );
  }
  ngOnDestroy(): void {
    this.subscriptions.forEach(subs => subs.unsubscribe());
    this.commonService.isStepperDisabled = false;
  }

  ngOnInit(): void {
    this.showSpinner = true;
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(
      FccGlobalConstant.TNX_TYPE_CODE
    );
    this.option = this.commonService.getQueryParametersFromKey(
      FccGlobalConstant.OPTION
    );
    this.mode = this.commonService.getQueryParametersFromKey(
      FccGlobalConstant.MODE
    );
    this.subscriptions.push(
      this.commonService.loadDefaultConfiguration().subscribe(response => {
        if (response && response.showStepper !== FccConstants.STRING_TRUE) {
          this.commonService.isStepperDisabled = true;
        }
      })
    );
    this.checkSubmitStatus.emit(false);
        this.beforeSubmitValidation();
    this.initializeFormGroup();
    this.stateService.setAutoSaveConfig(false);
  }

  initializeFormGroup(): void {
    const sectionName = FccGlobalConstant.PAYMENTS_BULK_FILEUPLOAD_GENERAL_DETAILS;
    this.form = this.stateService.getSectionData(sectionName);
    this.initializeFormForFileUpload();
  }

  initializeFormForFileUpload(): void {
    this.subscriptions.push(
      this.commonService.getConfiguredValues('PAYMENTSBULK_UPLOAD_EXTENSIONS,PAYMENTSBULK_FILE_UPLOAD_LIMIT,'
      +'PAYMENTSBULK_FILE_UPLOAD_SIZE,PAYMENTBULK_UPLOAD_FILENAME_LENGTH')
        .subscribe(resp => {
          if (resp.response && resp.response === 'REST_API_SUCCESS') {
            this.numberOfFilesRegex = Number(resp.PAYMENTSBULK_FILE_UPLOAD_LIMIT);
            this.sizeOfFileRegex = resp.PAYMENTSBULK_FILE_UPLOAD_SIZE;
            this.fileUploadMaxSize = resp.PAYMENTSBULK_FILE_UPLOAD_SIZE;
            this.fileNameMaxLength = resp.PAYMENTBULK_UPLOAD_FILENAME_LENGTH;
            this.form.get('fileMaxLimits')[this.params][this.label] = `${this.translateService.instant('Message')}`
              + this.sizeOfFileRegex + FccGlobalConstant.BLANK_SPACE_STRING
              + `${this.translateService.instant('MB')}`;
            this.allFileExtensions = resp.PAYMENTSBULK_UPLOAD_EXTENSIONS?.split(',');
            this.validFileExtensions = [];
            this.allFileExtensions?.forEach(element => {
              if (this.validFileExtensions.indexOf(element.replace(/\s|\[|\]/g, '').toUpperCase()) === -1) {
                this.validFileExtensions.push(element.replace(/\s|\[|\]/g, ' ').toUpperCase());
              }
            });
            this.patchFieldParameters(this.form.get('fileExtnText'), {
              label: `${this.translateService.instant('fileUploadExtn')}${this.validFileExtensions}.`
            });
            this.showUploadedFiles();

          }
        }));

        this.getDropDownFiledData();
  }

  onClickTrashIcon(event: Event, key: string, index: number): void {
    const dir = localStorage.getItem('langDir');
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      header: `${this.translateService.instant('deleteFile')}`,
      width: '35em',
      baseZIndex: 10000,
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
          this.form.addControl('noOfAttachments', new FormControl(this.fileListSvc.fileMap.length));
        }
        this.noOfAttachments = this.form.get('noOfAttachments').value;
        this.form.get('noOfAttachments').setValue(--this.noOfAttachments);
        this.form.get('noOfAttachments').updateValueAndValidity();
        const numberOfFiles = this.uploadFile.numberOfFiles;
        if (numberOfFiles < this.numberOfFilesRegex) {
          this.fileUploadFlag = false;
          this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
          this.patchFieldParameters(this.form.get('fileUploadTable'), { message: '' });
          this.form.updateValueAndValidity();
        }
      }
    });
  }

  removeSelectedRow(deleteID: string): void {
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

  renderBrowseButton(numberOfFiles: number): void {
    if (numberOfFiles < this.numberOfFilesRegex) {
      this.form.get('browseButton')[this.params][this.btndisable] = false;
    }

  }

  onClickBrowseButton(): void {
    this.flag = true;
    this.numberOfFile = this.uploadFile.numberOfFiles;
    if (this.numberOfFile === this.numberOfFilesRegex) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: true });
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: `${this.translateService.instant('MaxFileReached')}` });
      this.form.updateValueAndValidity();
      return;
    } else {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { hasError: false });
      const dir = localStorage.getItem('langDir');
      const dialogRef = this.dialogService.open(PaymentsFileUploadDialogComponent, {
        header: `${this.translateService.instant('fileDetails')}`,
        width: '35em',
        baseZIndex: 10000,
        styleClass: 'fileUploadClass',
        style: { direction: dir }
      });
      this.subscriptions.push(
        dialogRef.onClose.subscribe(() => {
          this.hideShowDeleteWidgetsService.customiseSubject.next(false);
          this.showUploadedFiles();
        }));
    }
  }

  fileList(): FileMap[] {
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

  getColumns(): TableColumn[] {
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

  addEventsForDragDropArea(): void {
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

  startProcessing(): void {
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
  endProcessing(): void {
    this.form.removeControl('dialogWindow');
    this.showUploadedFiles();
  }

  getProcessingFiles(): FileName[] {
    return this.processingFiles;
  }

  addFilesToDialog(filesArray): void {
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
    for (let i = 0; i < filesLength; i++) {
      if (this.uploadFile.numberOfFiles < this.numberOfFilesRegex) {
        this.isFileSizeValid = this.checkValidFile(filesArray[i]);
        this.isFileExtValid = this.checkFileExt(filesArray[i]);
        this.isFileNameValid = this.checkValidFileName(filesArray[i], this.fileNameMaxLength);
        this.fileModel = new FileMap(filesArray[i], filesArray[i].name, filesArray[i].name, this.getFileExt(filesArray[i].name),
          this.getFileExtPath(filesArray[i].name), this.getFileSize(filesArray[i].size), null, null, null, null, null);
        if (this.isFileSizeValid && this.isFileExtValid) {
          if(!this.isFileNameValid && this.fileModel.title !== null && this.fileModel.title !== " " ) {
            this.fileModel.title = this.fileModel.title.substring(0,35);
          }
          await this.commonService.uploadAttachmentsForBeneAndPayments(this.fileModel.file, this.fileModel.title,
            '', FccGlobalConstant.PAYMENTS_BULK_FCM_ATTACHMENT).toPromise().then(
            response => {
              this.fileModel.attachmentId = response.docId;
              this.fileListSvc.pushFile(this.fileModel);
              this.noOfAttachments = this.form.get('noOfAttachments').value;
              if (this.noOfAttachments === null || isNaN(this.noOfAttachments)) {
                this.noOfAttachments = 0;
              }
              this.form.get('noOfAttachments').setValue(++this.noOfAttachments);
              this.form.get('noOfAttachments').updateValueAndValidity();
            });
        } else if(!this.isFileSizeValid && event.files[i].size === 0){
          this.messageSet.add(FccGlobalConstant.LENGTH_5);
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
  getFileExt(fileName: string): string {
    return fileName.split('.').pop();
  }

  checkValidFile(file): boolean {
    const maxFileSize = FccGlobalConstant.FILEUPLOAD_MB_BYTE * this.sizeOfFileRegex;
    if (file.size === 0) {
      return false;
    } else if (file.size > maxFileSize) {
      return false;
    }
    return true;
  }

  checkFileExt(file: any): boolean {
    return this.checkValidFileExtensionfn(this.getFileExt(file.name));
  }

  checkValidFileName(file: any, length: any): boolean {
    const fileTitle = file.name.slice(0,file.name.lastIndexOf('.'));
    if (fileTitle.length > length) {
      return false;
    }
    return true;
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


  showMessage(): void {
    if (this.messageSet.has(0)) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), { message: `${this.translateService.instant('MaxFileReached')}` });
    } else if (this.messageSet.has(1)) {
      this.patchFieldParameters(this.form.get('fileUploadTable'), {
        message: `${this.translateService.instant('fileAttachmentFailed')} ${this.sizeOfFileRegex} MB.`
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
        message: `${this.translateService.instant('fileTitleLengthError', { maxLen: this.fileNameMaxLength })}`,
      });
    } else if(this.messageSet.has(FccGlobalConstant.LENGTH_5)){
      this.patchFieldParameters(this.form.get("fileUploadTable"), {
        message: `${this.translateService.instant('fileEmptyError')}`,
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

  getSpinnerStyle(): string {
    const langDir = localStorage.getItem('langDir');
    if (langDir === 'rtl') {
      return 'spinnerRightStyle';
    } else {
      return 'spinnerLeftStyle';
    }
  }
  onClickDownloadIcon(event, key, index): void {
    const id = this.fileList()[index].attachmentId;
    const fileName = this.fileList()[index].fileName;
    this.subscriptions.push(
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
          if (window.navigator && (window.navigator as any).msSaveOrOpenBlob) {
            (window.navigator as any).msSaveOrOpenBlob(newBlob, fileName);
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
          const anchorElement = document.querySelector('.mat-tooltip-trigger.ng-star-inserted');
          (anchorElement as HTMLElement).blur();
        }));
  }

  /**
   * validates form on form value change to enable and disable submit button
   */
  ngAfterViewChecked(): void {
    this.manageBtnFocus();
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    this.form.valueChanges.subscribe(change => {
      Object.keys(this.form.controls).forEach(key => {
        const control: any = this.form.controls[key];
          if(control.type === FccConstants.INPUT_TABLE_CONTROL_TYPE && control.params.data.length){
            this.fileUploadFlag = true;
          }
    });
    if(this.fileUploadFlag && this.stateService.validateStateFields()){
      this.checkSubmitStatus.emit(true);
    }else{
      this.fileUploadFlag = false;
      this.checkSubmitStatus.emit(false);
    }
    });
  }
  /**
   * Assigning default focus from close ison to primary button(No button)
   * on delete file confirmation popup
   */
  manageBtnFocus(): void {
    const anchorElement = document.querySelector('.ui-dialog-titlebar-icon.ui-dialog-titlebar-close.ui-corner-all');
    const noBtnElement = document.querySelector('.ConfirmButton');
     if (noBtnElement && !noBtnElement.getAttribute('tabIndex') && anchorElement.getAttribute('tabIndex') === '0'
     && anchorElement && anchorElement.getAttribute('tabIndex')) {
      (anchorElement as HTMLElement).blur();
      (noBtnElement as HTMLElement).focus();
      noBtnElement.setAttribute('tabIndex', '1');
      anchorElement.removeAttribute('tabIndex');
      anchorElement.addEventListener("focus", () => {
        anchorElement.setAttribute('style','outline: 0 none !important;outline-offset: 0;box-shadow: 0 0 0 0.125em black !important');
      });
      anchorElement.addEventListener("focusout", () => {
        anchorElement.setAttribute('style','box-shadow: 0 0 0 0.2em none');
      });
    }
  }
  /**
   * Assigning tabindex to close icon on pressing Tab button
   * for accessibility, on delete file confirmation popup
   */
  @HostListener('document:keyup', ['$event'])
  keyEvent(event: KeyboardEvent): void {
    if (event.key == 'Tab'){
      const anchorElement = document.querySelector('.ui-dialog-titlebar-icon.ui-dialog-titlebar-close.ui-corner-all');
      if(anchorElement){
        anchorElement.setAttribute('tabIndex', '2');
      }
    }
  }

  /**
   * calls API to fetch dropdown data from FCM and
   * patches value with respective fields
   * @param key
   * @param dropdownList
   */
  updateDropdown(key, dropdownList) {
    if (key === FccConstants.FCM_CLIENT_CODE_DETAILS){
      this.commonService.setDefaultClient(dropdownList, this.form, key);
      if (this.form.controls[key].value) {
        this.onClickClientDetails();
      }
    }
    else if (key === FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE && dropdownList.length){
      dropdownList.forEach(element => {
        this.form.controls[key][FccConstants.FCM_OPTIONS].push(
          {
            label: element.interfacecode,
            value : {
              label: element.interfacecode,
              name: element.mapdescription,
              shortName: element.interfacecode
            }
          }
        );
      });
      if (dropdownList.length === 1) {
        this.form.get(key).setValue({ label: dropdownList[0].interfacecode, name: dropdownList[0].mapdescription,
        shortName: dropdownList[0].interfacecode });
      }
    }
  }

  oldClientDetails: string;
  oldFileFormatCode: string;
  counter = 0;
  fieldVal:any;
  filedValMap = new Map();
  headerField = `${this.translateService.instant('confirmation')}`;
  message = `${this.translateService.instant('filedChangeMsg')}`;
  dir = localStorage.getItem('langDir');

  /**
   * calls confirmation pop-up on client code dropdown filed click
   * @param event
   */
  onClickClientDetails(event?) {
    this.openConfirmationPopup(event, FccConstants.FCM_CLIENT_CODE_DETAILS, this.oldClientDetails);
    this.updateFileFormatCodeFieldOption();
    this.getFileFormatDropdown();
  }

  /**
   * function to open confirmation pop-up on changing
   * form field value
   * @param event
   * @param controlName
   * @param oldFiledDtls
   */
  openConfirmationPopup(event, controlName, oldFiledDtls) {
    const fileTab = (this.form.get(FccConstants.FCM_FILE_UPLOAD_TABLE) as any).params.data;
    this.filedValMap.set(controlName, this.form.get(controlName).value);
    if (this.filedValMap.has(controlName) && this.fieldVal != this.filedValMap.get(controlName)) {
      this.fieldVal = this.filedValMap.get(controlName);
      this.counter = 1;
    }
    if (this.commonService.isnonEMptyString(oldFiledDtls) &&
      oldFiledDtls != this.fieldVal && 1 === this.counter &&
      (this.commonService.isnonEMptyString(this.form.get(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE).value)
      || fileTab.length)) {
      this.counter = 0;
      const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
        header: this.headerField,
        width: '35em',
        baseZIndex: 10000,
        styleClass: 'fileUploadClass',
        style: { direction: this.dir },
        data: { locaKey: this.message }
      });
      dialogRef.onClose.subscribe(
        (result: any) => {
        if (result.toLowerCase() === 'yes') {
          this.uploadFile.resetList();
          const resetFields = [FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE];
          this.resetValues(this.form, resetFields);
          this.patchFieldParameters(this.form.get(FccConstants.FCM_FILE_UPLOAD_TABLE), { hasData: false });
          this.oldClientDetails = null;
          this.oldFileFormatCode = null;
          this.fieldVal = null;
          this.filedValMap = new Map();
          this.updateFileFormatCodeFieldOption();
        } else if(result.toLowerCase() === 'no') {
          // assign same values
          this.form.controls[controlName].setValue(oldFiledDtls);
          this.filedValMap.set(controlName, this.form.get(controlName).value);
          this.fieldVal = this.form.get(controlName).value;
          this.persistOldFieldVal();
          return;
        }
        
      });
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      dialogRef.onDestroy.subscribe((result: any) => {
        // assign same values
        this.form.controls[controlName].setValue(oldFiledDtls);
        this.filedValMap.set(controlName, this.form.get(controlName).value);
        this.fieldVal = this.form.get(controlName).value;
        this.persistOldFieldVal();
      });
      
    } else {
      this.persistOldFieldVal();

    }
    
  }
  persistOldFieldVal(){
    const dropdownFields = FCMBeneConstants.FCM_FETCH_BULK_FILE_DATA_OPTIONS;
    dropdownFields.forEach((dropdownField) => {
      switch(dropdownField){
        case FccConstants.FCM_CLIENT_CODE_DETAILS:
          this.oldClientDetails = this.form.get(dropdownField).value;
          break;
        case FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE:
          this.oldFileFormatCode = this.form.get(dropdownField).value;
          break;
      }
    });

  }

  getDropDownFiledData(){
    const dropdownFields = FCMBeneConstants.FCM_FETCH_BULK_FILE_DATA_OPTIONS;
    const filterParam = '{"clientCode":'+this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label+
    ',"interfaceCodeModel":"CU_PAYMENTS"}';
    dropdownFields.forEach((dropdownField) => {
      switch (dropdownField) {
        case FccConstants.FCM_CLIENT_CODE_DETAILS:
          this.subscriptions.push(this.commonService.getExternalStaticDataList(dropdownField)
            .subscribe((response) => {
              if (response) {
                this.updateDropdown(dropdownField, response);
              }
            }));
          break;
        case FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE:
          this.subscriptions.push(this.commonService.getExternalStaticDataList(dropdownField, filterParam)
            .subscribe((response) => {
              if(response.length == 0){
                this.patchFieldParameters(this.form.get(dropdownField), { options: [] });
              }
              else if (response) {
                this.updateDropdown(dropdownField, response);
              }
            }));
          break;
      }

    });
  }

  onKeyupClientDetails(event) {
    if (event.key === 'Enter' || event.keyCode === 40 || event.keyCode === 38
    || event.keyCode === 32) {
      this.onClickClientDetails(event);
    }
  }
  updateFileFormatCodeFieldOption() {
    const filterParam = '{"clientCode":' + this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label + 
    ',"interfaceCodeModel":"CU_PAYMENTS"}';
    this.subscriptions.push(this.commonService.getExternalStaticDataList(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE, filterParam)
      .subscribe((response) => {
        if (!this.commonService.isnonEMptyString(this.oldFileFormatCode) && response.length == 0) {
          this.patchFieldParameters(this.form.get(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE), { options: [] });
        }
        else if (response && !this.commonService.isnonEMptyString(this.oldFileFormatCode)) {
          this.patchFieldParameters(this.form.get(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE), { options: [] });
          response.forEach(element => {
            this.form.controls[FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE][FccConstants.FCM_OPTIONS].push(
              {
                label: element.interfacecode,
                value: {
                  label: element.interfacecode,
                  name: element.mapdescription,
                  shortName: element.interfacecode
                }
              }
            );
          });
        }
        if (response.length === 1) {
          this.form.get(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE).setValue({ label: response[0].interfacecode, 
          name: response[0].mapdescription,
          shortName: response[0].interfacecode });
        }
      }));
      
  }

  getFileFormatDropdown() {
    const filterParam = '{"clientCode":' + this.form.get(FccConstants.FCM_CLIENT_CODE_DETAILS).value.label + 
    ',"interfaceCodeModel":"CU_PAYMENTS"}';
    this.commonService.getExternalStaticDataList(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE, filterParam)
      .subscribe((response) => {
        if (!this.commonService.isnonEMptyString(this.oldFileFormatCode) && response.length == 0) {
          this.patchFieldParameters(this.form.get(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE), { options: [] });
        }
        else if (response && !this.commonService.isnonEMptyString(this.oldFileFormatCode)) {
          this.patchFieldParameters(this.form.get(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE), { options: [] });
          response.forEach(element => {
            this.form.controls[FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE][FccConstants.FCM_OPTIONS].push(
              {
                label: element.interfacecode,
                value: {
                  label: element.interfacecode,
                  name: element.mapdescription,
                  shortName: element.interfacecode
                }
              }
            );
          });
        }
        if (response.length === 1) {
          this.form.get(FccConstants.FCM_PAYMENT_FILE_FORMAT_CODE).setValue({ label: response[0].interfacecode, 
          name: response[0].mapdescription,
          shortName: response[0].interfacecode });
        }
      });
  }
}
