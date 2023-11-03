import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';

import { ResolverService } from '../../../../../../common/services/resolver.service';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { CommonService } from './../../../../../../../app/common/services/common.service';
import { EventEmitterService } from './../../../../../../../app/common/services/event-emitter-service';
import { PhrasesService } from './../../../../../../../app/common/services/phrases.service';
import { FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FccGlobalConstantService } from './../../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../../../../../common/core/fcc-global-constants';
import { FormModelService } from './../../../../../../common/services/form-model.service';
import { SearchLayoutService } from './../../../../../../common/services/search-layout.service';
import { LeftSectionService } from './../../../../../../corporate/common/services/leftSection.service';
import { ProductStateService } from './../../../../../../corporate/trade/lc/common/services/product-state.service';
import { SaveDraftService } from './../../../../../../corporate/trade/lc/common/services/save-draft.service';
import { BankFileMap } from './../../../../../../corporate/trade/lc/initiation/services/bankmfile';
import { FilelistService } from './../../../../../../corporate/trade/lc/initiation/services/filelist.service';
import { FormControlService } from './../../../../../../corporate/trade/lc/initiation/services/form-control.service';
import { PrevNextService } from './../../../../../../corporate/trade/lc/initiation/services/prev-next.service';
import { UtilityService } from './../../../../../../corporate/trade/lc/initiation/services/utility.service';
import { EcProductComponent } from './../../../initiation/ec-product/ec-product.component';
import { CurrencyConverterPipe } from '../../../../lc/initiation/pipes/currency-converter.pipe';
import { EcProductService } from '../../../services/ec-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FileHandlingService } from './../../../../../../common/services/file-handling.service';

@Component({
  selector: 'app-ec-message-to-bank-general-details',
  templateUrl: './ec-message-to-bank-general-details.component.html',
  styleUrls: ['./ec-message-to-bank-general-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: EcMessageToBankGeneralDetailsComponent }]
})
export class EcMessageToBankGeneralDetailsComponent extends EcProductComponent implements OnInit {
  @Output() messageToEmit = new EventEmitter<string>();

  form: FCCFormGroup;
  module = `${this.translateService.instant('ecMessageToBankGeneralDetails')}`;
  option: any;
  tableColumns = [];
  refId: any;
  tnxId: any;
  docId: any;
  data: any;
  bankFileModel: BankFileMap;
  contextPath: any;
  fileName: any;
  params = FccGlobalConstant.PARAMS;
  enteredCharCount = 'enteredCharCount';
  rendered = FccGlobalConstant.RENDERED;
  mode: any;
  subTnxTypeCode: any;
  actionReqCode: any;
  customerInstructionText = 'customerInstructionText';

  constructor(protected commonService: CommonService, protected leftSectionService: LeftSectionService,
              protected router: Router, protected translateService: TranslateService,
              protected prevNextService: PrevNextService, protected utilityService: UtilityService,
              protected saveDraftService: SaveDraftService, protected searchLayoutService: SearchLayoutService,
              protected formModelService: FormModelService, protected formControlService: FormControlService,
              protected stateService: ProductStateService, protected route: ActivatedRoute,
              protected eventEmitterService: EventEmitterService, public fccGlobalConstantService: FccGlobalConstantService,
              protected uploadFile: FilelistService, public phrasesService: PhrasesService, protected resolverService: ResolverService,
              protected dialogRef: DynamicDialogRef, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected currencyConverterPipe: CurrencyConverterPipe, protected ecProductService: EcProductService,
              protected fileHandlingService: FileHandlingService) {
              super(eventEmitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
                searchLayoutService, utilityService, resolverService, uploadFile, dialogRef, currencyConverterPipe, ecProductService);
}

  ngOnInit(): void {
    super.ngOnInit();
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.refId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    this.tnxId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.tnxId);
    this.option = this.commonService.getQueryParametersFromKey('option');
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.subTnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE);
    if (this.mode === 'DRAFT') {
      this.actionReqCode = this.commonService.getQueryParametersFromKey('actionReqCode');
    }
    if (this.commonService.referenceId === undefined) {
      sessionStorage.removeItem(FccGlobalConstant.idempotencyKey);
    }
    this.initializeFormGroup();
    this.updateNarrativeCount();
  }

  updateNarrativeCount() {
    if (this.form.get(this.customerInstructionText) && this.form.get(this.customerInstructionText).value) {
      const count = this.commonService.counterOfPopulatedData(this.form.get(this.customerInstructionText).value);
      this.form.get(this.customerInstructionText)[this.params][this.enteredCharCount] = count;
    }
  }

    initializeFormGroup() {
      const sectionName = 'ecMessageToBankGeneralDetails';
      this.form = this.stateService.getSectionData(sectionName);
      this.commonService.formatForm(this.form);
      this.form.get('consentResponse')[this.params][this.rendered] = false;
      this.form.get('consentResponsevalue')[this.params][this.rendered] = false;
      if (this.tnxTypeCode === FccGlobalConstant.N002_INQUIRE) {
        this.form.get(this.customerInstructionText)[this.params][FccGlobalConstant.PHRASE_ENABLED] = true;
      } else {
        this.form.get(this.customerInstructionText)[this.params][FccGlobalConstant.PHRASE_ENABLED] = false;
      }
      if ((this.subTnxTypeCode !== null && this.subTnxTypeCode !== '' && this.subTnxTypeCode !== FccGlobalConstant.N003_SETTLEMENT_REQUEST)
      || this.option === FccGlobalConstant.ACTION_REQUIRED || this.actionReqCode) {
        this.form.get('settlementAmount')[this.params][this.rendered] = false;
        this.form.get('currency')[this.params][this.rendered] = false;
        this.form.get('amount')[this.params][this.rendered] = false;
        this.form.get('forwardContract')[this.params][this.rendered] = false;
        this.form.get('principalAct')[this.params][this.rendered] = false;
        this.form.get('feeAct')[this.params][this.rendered] = false;
        this.form.updateValueAndValidity();
        this.form.get('amount').clearValidators();
        this.setMandatoryField(this.form, 'amount', false);
      }
      if (this.option !== FccGlobalConstant.ACTION_REQUIRED || !this.actionReqCode) {
      if (this.subTnxTypeCode === undefined || this.subTnxTypeCode === null || this.subTnxTypeCode === '') {
        this.subTnxTypeCode = FccGlobalConstant.N003_CORRESPONDENCE;
      }
      this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE), this.subTnxTypeCode, {});
      }
      this.form.get(FccGlobalConstant.BANK_ATTACHMENT)[this.params][this.rendered] = false;
      this.form.get('bankComments')[this.params][this.rendered] = false;
      this.mode = this.commonService.getQueryParametersFromKey('mode');
      if (this.option === FccGlobalConstant.ACTION_REQUIRED || this.actionReqCode) {
        const fileTnxId = ((this.commonService.isNonEmptyField(FccGlobalConstant.PARENT_TNX_ID, this.form) &&
        this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.PARENT_TNX_ID).value) &&
        this.form.get(FccGlobalConstant.PARENT_TNX_ID).value !== '') ? this.form.get(FccGlobalConstant.PARENT_TNX_ID).value : this.tnxId);
        this.fileHandlingService.getTnxFileDetails(fileTnxId ).subscribe(
        response1 => {
          if (response1) {
            this.uploadFile.resetBankList();
            for (const values of response1.body.items) {
          if ( values.type === 'BANK') {
            this.form.get(FccGlobalConstant.BANK_ATTACHMENT)[this.params][this.rendered] = true;
            this.docId = values.docId;
            this.bankFileModel = new BankFileMap(null, values.fileName, values.title, values.type,
              this.getFileExtPath(values.fileName), null, this.docId, null, null, null, null, 
              this.commonService.decodeHtml(values.mimeType));
            this.uploadFile.pushBankFile(this.bankFileModel);
            this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE), { columns: this.getColumns() });
            this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE), { data: this.fileList() });
            this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE), { hasData: true });
            this.form.get('bankAttachmentType').setValue(values.type);
            this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE).updateValueAndValidity();
            this.form.updateValueAndValidity();
          }
        }
      }
    }
    );
        if (this.form.get('bankComments').value && this.form.get('bankComments').value !== ' ') {
          this.form.get('bankComments')[this.params][this.rendered] = true;
        }
        this.renderedDraftFields();
  }
      this.commonService.checkSettlementCurAndBaseCur(this.form);
 }

  renderedDraftFields() {
    if (this.mode === 'DRAFT') {
      this.form.get('consentResponse')[this.params][this.rendered] = false;
      this.form.get('consentResponsevalue')[this.params][this.rendered] = false;
      this.form.updateValueAndValidity();
    }
  }

  onClickDownloadIcon(event, key, index) {
    const id = this.fileList()[index].attachmentId;
    const fileName = this.fileList()[index].fileName;
    this.commonService.downloadAttachments(id).subscribe(
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
  onFocusConsentResponsevalue_46() {
    this.patchFieldValueAndParameters(this.form.get('consentResponsevalue'), FccGlobalConstant.N003_AMENDMENT_ADVICE_ACK, {});
    this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
    FccGlobalConstant.N003_AMENDMENT_ADVICE_ACK, {});
  }

  onFocusConsentResponsevalue_47() {
    this.patchFieldValueAndParameters(this.form.get('consentResponsevalue'), FccGlobalConstant.N003_AMENDMENT_ADVICE_NACK, {});
    this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
    FccGlobalConstant.N003_AMENDMENT_ADVICE_NACK, {});
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

  saveFormOject() {
    this.stateService.setStateSection('ecMessageToBankGeneralDetails', this.form);
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
                width: '40%'
              },
              {
                field: 'fileName',
                header: `${this.translateService.instant('fileName')}`,
                width: '40%'
              }];
    return this.tableColumns;
  }


  fileList() {
    return this.uploadFile.getBankList();
  }

  onBlurAmount() {
    if (this.form.get('amount').value && this.form.get('collectionAmount').value) {
      const settlementamt = parseFloat(this.commonService.replaceCurrency(this.form.get('amount').value));
      const tnxAmt = parseFloat(this.commonService.replaceCurrency(this.form.get('collectionAmount').value));
      if ((settlementamt && tnxAmt) && (settlementamt > tnxAmt) ) {
      this.form.get('amount').setErrors({ settlementAmtLessThanLCAmt: true });
      }
    }
  }

  onClickNext() {
    this.saveFormOject();
    if (!CommonService.isTemplateCreation) {
      this.leftSectionService.addSummarySection();
      this.saveDraftService.changeSaveStatus('ecMessageToBankGeneralDetails',
        this.stateService.getSectionData('ecMessageToBankGeneralDetails'));
    }
    if (this.form.valid && !CommonService.isTemplateCreation) {
      this.leftSectionService.addSummarySection();
    }
    if (this.form.invalid) {
      this.leftSectionService.removeSummarySection();
    }
}

  onClickPhraseIcon(event: any, key: any) {
    this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_EC, key);
  }

}
