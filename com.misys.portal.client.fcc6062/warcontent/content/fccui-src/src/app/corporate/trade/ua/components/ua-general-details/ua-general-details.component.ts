import { Component, OnInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { FCCFormGroup } from '../../../../../base/model/fcc-control.model';
import { FccGlobalConstantService } from '../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../common/core/fcc-global-constants';
import { CommonService } from '../../../../../common/services/common.service';
import { EventEmitterService } from '../../../../../common/services/event-emitter-service';
import { PhrasesService } from '../../../../../common/services/phrases.service';
import { ResolverService } from '../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../common/services/search-layout.service';
import { SaveDraftService } from '../../../../../corporate/trade/lc/common/services/save-draft.service';
import { FilelistService } from '../../../../../corporate/trade/lc/initiation/services/filelist.service';
import { LeftSectionService } from '../../../../common/services/leftSection.service';
import { LcConstant } from '../../../lc/common/model/constant';
import { ProductStateService } from '../../../lc/common/services/product-state.service';
import { CustomCommasInCurrenciesPipe } from '../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { UtilityService } from '../../../lc/initiation/services/utility.service';
import { UaProductComponent } from '../ua-product/ua-product.component';
import { CurrencyConverterPipe } from '../../../lc/initiation/pipes/currency-converter.pipe';
import { UaProductService } from '../../services/ua-product.service';
import { BankFileMap } from '../../../lc/initiation/services/bankmfile';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { FileHandlingService } from '../../../../../common/services/file-handling.service';
@Component({
  selector: 'app-ua-general-details',
  templateUrl: './ua-general-details.component.html',
  styleUrls: ['./ua-general-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: UaGeneralDetailsComponent }]
})
export class UaGeneralDetailsComponent extends UaProductComponent implements OnInit {

  form: FCCFormGroup;
  module = `${this.translateService.instant(FccGlobalConstant.UA_GENERAL_DETAIL)}`;
  contextPath: any;
  mode: any;
  tnxId: any;
  productCode: any;
  subTnxTypeCode: any;
  option: any;
  refId: any;
  docId: any;
  fileName: any;
  tableColumns = [];
  params = FccGlobalConstant.PARAMS;
  rendered = FccGlobalConstant.RENDERED;
  enteredCharCount = 'enteredCharCount';
  customerInstructionText = 'customerInstructionText';
  actionReqCode: any;
  swiftXChar: any;
  Constant = new LcConstant();
  allowedCharCount = this.Constant.allowedCharCount;
  maxlength = this.Constant.maximumlength;
  maxRowCount = this.Constant.maxRowCount;
  cols = this.Constant.cols;
  isMasterRequired: any;
  bankFileModel: BankFileMap;
  referenceId: any;

  constructor(protected translateService: TranslateService, protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService, protected commonService: CommonService,
              protected fccGlobalConstantService: FccGlobalConstantService, protected leftSectionService: LeftSectionService,
              protected phrasesService: PhrasesService, protected saveDraftService: SaveDraftService,
              protected uploadFile: FilelistService, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected dialogRef: DynamicDialogRef, protected currencyConverterPipe: CurrencyConverterPipe,
              protected uaProductService: UaProductService, protected fileHandlingService: FileHandlingService) {
              super(eventEmitterService, productStateService, commonService, translateService, confirmationService,
                customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, uploadFile,
                dialogRef, currencyConverterPipe, uaProductService);
  }
  ngOnInit(): void {
    super.ngOnInit();
    this.isMasterRequired = this.isMasterRequired;
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.refId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REFERENCE_ID);
    this.referenceId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    this.option = this.commonService.getQueryParametersFromKey('option');
    this.tnxId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_ID);
    this.productCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.PRODUCT);
    this.subTnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE);
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (this.mode === FccGlobalConstant.DRAFT_OPTION) {
      this.actionReqCode = this.commonService.getQueryParametersFromKey('actionReqCode');
    }
    if (this.commonService.referenceId === undefined) {
      sessionStorage.removeItem(FccGlobalConstant.idempotencyKey);
    }
    this.initializeFormGroup();
    // Consent Response Values are applicable for Pending actions events.
    // Not applicable for Message to bank(24) & Request for settlement(25)
    if (((this.commonService.isNonEmptyValue(this.subTnxTypeCode)) && (this.commonService.isNonEmptyValue(this.mode)) &&
          (this.mode === FccGlobalConstant.DRAFT_OPTION && this.subTnxTypeCode !== FccGlobalConstant.N003_CORRESPONDENCE &&
            this.subTnxTypeCode !== FccGlobalConstant.N003_SETTLEMENT_REQUEST))
           || this.option === FccGlobalConstant.ACTION_REQUIRED) {
      this.actionReqCode = this.commonService.getQueryParametersFromKey('actionReqCode');
      this.enableConsentResponse();
    } else {
      if ((this.commonService.isNonEmptyValue(this.subTnxTypeCode))
      && this.commonService.isNonEmptyField('consentResponseValue' , this.form)) {
        this.form.get('consentResponseValue').setValue(this.subTnxTypeCode);
      }

    }

    if (this.commonService.currentStateTnxResponse.prod_stat_code && this.commonService.currentStateTnxResponse.prod_stat_code !== ''
    && this.commonService.currentStateTnxResponse.prod_stat_code !== undefined && this.form.get('prodStatCode')) {
    this.form.get('prodStatCode').setValue(this.commonService.currentStateTnxResponse.prod_stat_code);
    }
    if (this.form.get('parentTnxId')) {
    this.form.get('parentTnxId').setValue(this.tnxId);
    }
    this.updateNarrativeCount();
    this.setNarrativeLength();
  }

  updateNarrativeCount() {
    if (this.form.get(this.customerInstructionText) && this.form.get(this.customerInstructionText).value) {
      const count = this.commonService.counterOfPopulatedData(this.form.get(this.customerInstructionText).value);
      this.form.get(this.customerInstructionText)[this.params][this.enteredCharCount] = count;
    }
  }

  enableConsentResponse() {
    this.form.get('consentResponse')[this.params][this.rendered] = true;
    this.form.get('consentResponseValue')[this.params][this.rendered] = true;
    if (this.productStateService.getSectionData('uaGeneralDetails').get('consentResponseValue').value) {
      this.form.get('consentResponseValue').setValue(this.productStateService.
        getSectionData('uaGeneralDetails').get('consentResponseValue').value);
    } else {
      this.form.get('consentResponseValue').setValue('66');
    }
    this.handleConsentResponseValue();
  }

  initializeFormGroup() {
    const sectionName = FccGlobalConstant.UA_GENERAL_DETAIL;
    this.form = this.productStateService.getSectionData(sectionName, FccGlobalConstant.PRODUCT_BR, this.isMasterRequired);
    if (this.form.get(FccGlobalConstant.BANK_ATTACHMENT)) {
      this.form.get(FccGlobalConstant.BANK_ATTACHMENT)[this.params][this.rendered] = false;
    }
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      this.swiftXChar = response.swiftXCharacterSet;
    });
    if (this.option === FccGlobalConstant.ACTION_REQUIRED || (this.mode === FccGlobalConstant.DISCREPANT &&
      this.option === FccGlobalConstant.EXISTING_OPTION) || this.actionReqCode || this.isDiscrepantDraft()) {
        const fileTnxId = ((this.commonService.isNonEmptyField(FccGlobalConstant.PARENT_TNX_ID, this.form) &&
        this.commonService.isNonEmptyValue(this.form.get(FccGlobalConstant.PARENT_TNX_ID).value) &&
        this.form.get(FccGlobalConstant.PARENT_TNX_ID).value !== '') ? this.form.get(FccGlobalConstant.PARENT_TNX_ID).value : this.tnxId);
        this.fileHandlingService.getTnxFileDetails(fileTnxId ).subscribe(
        response1 => {
          if (response1) {
            this.uploadFile.resetBankList();
            for (const values of response1.body.items) {
          if ( values.type === 'BANK') {
            this.docId = values.docId;
            this.bankFileModel = new BankFileMap(null, values.fileName, values.title, values.type,
              this.getFileExtPath(values.fileName), null, this.docId, null, null, null, null, 
              this.commonService.decodeHtml(values.mimeType));
            this.uploadFile.pushBankFile(this.bankFileModel);
            this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE), { columns: this.getColumns() });
            this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE), { data: this.fileList() });
            this.patchFieldParameters(this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE), { hasData: true });
            this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE)[this.params][this.rendered] = true;
            this.form.get('bankAttachmentType').setValue(values.type);
            this.form.get(FccGlobalConstant.FILE_ATTACHMENT_TABLE).updateValueAndValidity();
            this.form.updateValueAndValidity();
        }
        }
      }
    }
    );
  }
  }

  isDiscrepantDraft(): boolean {
    return (this.mode === FccGlobalConstant.DRAFT_OPTION && (this.subTnxTypeCode === FccGlobalConstant.SUB_TNX_TYPE_AMD_BENE_ACCEPT));
  }

  renderedDraftFields() {
    if (this.mode === 'DRAFT') {
    this.patchFieldValueAndParameters(this.form.get('consentResponseValue'), this.subTnxTypeCode, {});
    this.form.updateValueAndValidity();
  }
  }

  onClickConsentResponseValue() {
    if (this.option === FccGlobalConstant.ACTION_REQUIRED || this.actionReqCode) {
      const constentResponseValue = this.form.get('consentResponseValue').value;
      if (this.commonService.currentStateTnxResponse.prod_stat_code === FccGlobalConstant.N005_WORDING_UNDER_REVIEW ||
        this.commonService.currentStateTnxResponse.prod_stat_code === FccGlobalConstant.N005_FINAL_WORDING) {
          if (constentResponseValue && constentResponseValue === FccGlobalConstant.N003_ACK) {
            this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
               FccGlobalConstant.N003_WORDING_ACK, {});
          } else {
            this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
               FccGlobalConstant.N003_WORDING_NACK, {});
          }
      } else if (constentResponseValue && constentResponseValue === FccGlobalConstant.N003_ACK) {
        this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE), FccGlobalConstant.N003_ACK, {});
      } else {
        this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE), FccGlobalConstant.N003_NACK, {});
      }
    }
  }

  handleConsentResponseValue()
{
  if (this.option === FccGlobalConstant.ACTION_REQUIRED || this.actionReqCode) {
    const constentResponseValue = this.form.get('consentResponseValue').value;
    if (constentResponseValue && constentResponseValue === FccGlobalConstant.N003_ACK
        && this.form.get('consentResponseValue')[this.params][this.rendered] === true) {
      this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
      FccGlobalConstant.N003_ACK, {});
    } else if (constentResponseValue && constentResponseValue === FccGlobalConstant.N003_NACK &&
      this.form.get('consentResponseValue')[this.params][this.rendered] === true) {
      this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
      FccGlobalConstant.N003_NACK, {});
  }
}
}

  saveFormOject() {
    this.productStateService.setStateSection('uaGeneralDetails', this.form);
  }

  onClickNext() {
    this.saveFormOject();
    if (!CommonService.isTemplateCreation) {
      this.leftSectionService.addSummarySection();
      this.saveDraftService.changeSaveStatus('uaGeneralDetails',
        this.productStateService.getSectionData('uaGeneralDetails'));
    }
    if (this.form.valid && !CommonService.isTemplateCreation) {
      this.leftSectionService.addSummarySection();
    }
    if (this.form.invalid) {
      this.leftSectionService.removeSummarySection();
    }
}

setNarrativeLength() {
  if (this.option === FccGlobalConstant.ACTION_REQUIRED || this.actionReqCode) {
    this.form.get('customerInstructionText').clearValidators();
    this.form.get('customerInstructionText')[this.params][this.allowedCharCount] = '210';
    this.form.get('customerInstructionText')[this.params][this.maxlength] = '210';
    this.form.get('customerInstructionText')[this.params][this.maxRowCount] = '6';
    this.form.get('customerInstructionText')[this.params][this.cols] = '35';
  } else {
    this.form.get('customerInstructionText')[this.params][this.allowedCharCount] = '1750';
    this.form.get('customerInstructionText')[this.params][this.maxlength] = '1750';
    this.form.get('customerInstructionText')[this.params][this.cols] = '50';
    this.form.get('customerInstructionText')[this.params][this.maxRowCount] = '35';
  }
  // this.form.addFCCValidators('customerInstructionText', Validators.pattern(this.swiftXChar), 0);
}


onClickPhraseIcon(event, key) {
  this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_BR, key, '', true);
}
  ngOnDestroy() {
    this.productStateService.setStateSection(FccGlobalConstant.UA_GENERAL_DETAIL, this.form, this.isMasterRequired);
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

}

