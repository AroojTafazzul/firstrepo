import { PaymentInstrumentProductService } from './../../single/services/payment-instrument-product.service';
import { UtilityService } from './../../../../../../app/corporate/trade/lc/initiation/services/utility.service';
import { CommonService } from './../../../../../../app/common/services/common.service';
import { CurrencyConverterPipe } from './../../../../trade/lc/initiation/pipes/currency-converter.pipe';
import { SearchLayoutService } from './../../../../../common/services/search-layout.service';
import { FilelistService } from './../../../../trade/lc/initiation/services/filelist.service';
import { EventEmitterService } from './../../../../../common/services/event-emitter-service';
import { HideShowDeleteWidgetsService } from './../../../../../common/services/hide-show-delete-widgets.service';
import { FormControlService } from './../../../../trade/lc/initiation/services/form-control.service';
import { CustomCommasInCurrenciesPipe } from './../../../../trade/lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { ProductStateService } from './../../../../trade/lc/common/services/product-state.service';
import { FormModelService } from './../../../../../common/services/form-model.service';
import { FileMap } from './../../../../trade/lc/initiation/services/mfile';
import { FccGlobalConstant } from '../../../../../../app/common/core/fcc-global-constants';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { HttpErrorResponse } from '@angular/common/http';
import { Subscription } from 'rxjs';
import { PaymentsProductComponent } from '../payments-product/payments-product.component';
import { TranslateService } from '@ngx-translate/core';
import { Table, ConfirmationService } from 'primeng';
import { ResolverService } from './../../../../../../app/common/services/resolver.service';
import { FCCFormGroup } from '../../../../../../app/base/model/fcc-control.model';
import { FccGlobalConstantService } from '../../../../../../app/common/core/fcc-global-constant.service';

@Component({
  selector: 'app-payments-file-upload-dialog',
  templateUrl: './payments-file-upload-dialog.component.html',
  styleUrls: ['./payments-file-upload-dialog.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: PaymentsFileUploadDialogComponent }]
})
export class PaymentsFileUploadDialogComponent extends PaymentsProductComponent implements OnInit, OnDestroy {

  subscriptions: Subscription[] = [];
  form: FCCFormGroup;
  isValidSize = false;
  isValidFile = false;
  fileModel: FileMap;
  title: string;
  module: string;
  @Input() table: Table;
  @Input() newRow: number;
  mode: string;
  allFileExtensions: string[];
  errorMsgFileExtensions = [];
  sizeOfFileRegex: number;
  params = FccGlobalConstant.PARAMS;
  label = FccGlobalConstant.LABEL;
  contextPath: string;
  erroreMsgMaxFile: string;
  fileNameMaxLength: any;

  constructor(
    protected formModelService: FormModelService,
    protected formControlService: FormControlService,
    protected stateService: ProductStateService,
    protected translateService: TranslateService,
    protected fccGlobalConstantService: FccGlobalConstantService,
    protected commonService: CommonService,
    protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
    public dialogService: DialogService,
    protected eventEmitterService: EventEmitterService, protected productStateService: ProductStateService,
    protected confirmationService: ConfirmationService,
    protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
    protected searchLayoutService: SearchLayoutService, protected fileArray: FilelistService,
    protected dialogRef: DynamicDialogRef, protected utilityService: UtilityService,
    protected resolverService: ResolverService,
    protected currencyConverterPipe: CurrencyConverterPipe, protected paymentsProductService: PaymentInstrumentProductService) {
    super(eventEmitterService, stateService, commonService, translateService,
      confirmationService, customCommasInCurrenciesPipe, searchLayoutService, utilityService,
      resolverService, fileArray, dialogRef, currencyConverterPipe, paymentsProductService,
    );
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(subs => subs.unsubscribe());
  }

  ngOnInit(): void {
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    window.scroll(0, 0);
    this.subscriptions.push(
      this.commonService.loadDefaultConfiguration().subscribe(response => {
        if (response) {
          this.allFileExtensions = response.validFileExtensions.split(',');
          this.sizeOfFileRegex = response.FileUploadMaxSize;
          this.validFileExtensions = [];
          this.allFileExtensions.forEach(element => {
            this.validFileExtensions.push(element.replace(/[\]"]/g, '').replace(/ /g, ''));
            this.errorMsgFileExtensions.push(element.replace(/[\]"]/g, '').toUpperCase());
          });
        }
      }),
      this.commonService.getConfiguredValues('PAYMENTSBULK_UPLOAD_EXTENSIONS,PAYMENTSBULK_FILE_UPLOAD_LIMIT,'
      +'PAYMENTSBULK_FILE_UPLOAD_SIZE,PAYMENTBULK_UPLOAD_FILENAME_LENGTH')
      .subscribe(resp => {
        if (resp.response && resp.response === 'REST_API_SUCCESS') {
          this.fileUploadMaxSize = resp.PAYMENTSBULK_FILE_UPLOAD_SIZE;
          this.fileNameMaxLength = resp.PAYMENTBULK_UPLOAD_FILENAME_LENGTH;
          this.validFileExtensions = [];
          this.errorMsgFileExtensions = [];
          resp.PAYMENTSBULK_UPLOAD_EXTENSIONS?.split(',').forEach(element => {
            if (this.validFileExtensions.indexOf(element.replace(/\s|\[|\]/g, '')) === -1) {
              this.validFileExtensions.push(element.replace(/\s|\[|\]/g, ''));
              this.errorMsgFileExtensions.push(element.replace(/\s|\[|\]/g, ' ').toUpperCase());
            }
          });
        }
      })
      );
    this.initializeFormGroup();
  }

  initializeFormGroup(): void {
    const dialogmodel = JSON.parse(JSON.stringify(this.formModelService.getSubSectionModel()[FccGlobalConstant.FILE_DIALOG_MODEL]));
    this.form = this.formControlService.getFormControls(dialogmodel);
    let accept = '';
    this.validFileExtensions?.forEach(element => {
      accept = `${accept}.${element}${this.validFileExtensions?.indexOf(element) < this.validFileExtensions?.length - 1 ? ',' : ''}`;
    });
    this.form.get('filebrowseButton')[this.params].accept = accept;
  }

  onUploadHandler(event: any): void {
    this.checkValidFileName(event, this.fileNameMaxLength);
    this.checkFileSize(event, this.fileUploadMaxSize);
    if (this.isFileNameValid && this.isValidSize && this.checkTitle() && this.checkValidFileExtension(event)) {
      this.fileModel.title = this.form.get('fileUploadTitle').value;
      this.subscriptions.push(
        this.commonService.uploadAttachmentsForBeneAndPayments(this.fileModel.file, this.fileModel.title,
          '', FccGlobalConstant.PAYMENTS_BULK_FCM_ATTACHMENT).subscribe(
          response => {
            this.setDocId(response);
            this.process();
            let noOfAttachments: number;
            if (this.commonService.isnonEMptyString(this.stateService.isStateSectionSet('fileUploadDetails', false))) {
              noOfAttachments = Number(this.stateService.getValue('fileUploadDetails', 'noOfAttachments'));
              if (noOfAttachments === null || isNaN(noOfAttachments)) {
                noOfAttachments = 0;
              }
              this.stateService.setValue('fileUploadDetails', 'noOfAttachments', ++noOfAttachments);
            }
          },
          (error: HttpErrorResponse) => {
            if (error.status === FccGlobalConstant.HTTP_RESPONSE_BAD_REQUEST) {
              if (error.error && error.error.detail) {
                if (error.error.detail.indexOf(FccGlobalConstant.MALICIOUS) > -1) {
                  return this.commonService.fileUploadHandlerService.antiVirusCheck(true, this.form);
                } else {
                  const arr = error.error.detail.split(':');
                  let message = '';
                  if (arr.length > 1) {
                    message = arr[1].trim();
                  } else {
                    message = arr[0];
                  }
                  this.erroreMsgMaxFile = message;
                  this.form.get('fileUploadError')[this.params][this.label] = this.erroreMsgMaxFile;
                  this.form.get('fileUploadError')[this.params][FccGlobalConstant.RENDERED] = true;
                  this.form.updateValueAndValidity();
                }
              }
            }
          }, () => this.dialogRef.close(this.fileModel)));
    } else if (!this.isValidSize) {
      this.erroreMsgMaxFile =event.files[0].size === 0 ?
      `${this.translateService.instant('fileEmptyError')}`
      :`${this.translateService.instant('fileMaxLengthError')} ${this.fileUploadMaxSize} ${this.translateService.instant('MB')}`;
      this.form.get('fileUploadError')[this.params][this.label] = this.erroreMsgMaxFile;
      this.form.get('fileUploadError')[this.params][FccGlobalConstant.RENDERED] = true;
      this.form.updateValueAndValidity();
    } else if(!this.isFileNameValid){
      this.erroreMsgMaxFile =
        `${this.translateService.instant('fileTitleLengthError', { maxLen: this.fileNameMaxLength })}`;
      this.form.get('fileUploadError')[this.params][this.label] = this.erroreMsgMaxFile;
      this.form.get('fileUploadError')[this.params][FccGlobalConstant.RENDERED] = true;
    } else {
      this.form.get('fileUploadTitle').markAsTouched();
    }
  }
}
