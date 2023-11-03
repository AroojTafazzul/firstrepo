import { DatePipe } from '@angular/common';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DialogService, DynamicDialogRef } from 'primeng';

import { FCCFormControl, FCCFormGroup } from '../../../../../../app/base/model/fcc-control.model';
import { FccGlobalConstantService } from '../../../../../../app/common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../../app/common/core/fcc-global-constants';
import { CommonService } from '../../../../../../app/common/services/common.service';
import { EventEmitterService } from '../../../../../../app/common/services/event-emitter-service';
import { FormModelService } from '../../../../../../app/common/services/form-model.service';
import { SearchLayoutService } from '../../../../../../app/common/services/search-layout.service';
import { TransactionDetailService } from '../../../../../../app/common/services/transactionDetail.service';
import { LeftSectionService } from '../../../../../../app/corporate/common/services/leftSection.service';
import { ResolverService } from '../../../../../common/services/resolver.service';
import { LcConstant } from '../../../lc/common/model/constant';
import { ProductStateService } from '../../../lc/common/services/product-state.service';
import { SaveDraftService } from '../../../lc/common/services/save-draft.service';
import { ConfirmationDialogComponent } from '../../../lc/initiation/component/confirmation-dialog/confirmation-dialog.component';
import { CurrencyConverterPipe } from '../../../lc/initiation/pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../lc/initiation/services/filelist.service';
import { FormControlService } from '../../../lc/initiation/services/form-control.service';
import { FileMap } from '../../../lc/initiation/services/mfile';
import { PrevNextService } from '../../../lc/initiation/services/prev-next.service';
import { UtilityService } from '../../../lc/initiation/services/utility.service';
import { TfProductService } from '../../services/tf-product.service';
import { TfProductComponent } from '../tf-product/tf-product/tf-product.component';
import { PhrasesService } from './../../../../../common/services/phrases.service';
import { TfWarningComponent } from '../tf-warning/tf-warning.component';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

import { compareRequestDateToCurrentDate } from '../../../lc/initiation/validator/ValidateDates';
import { FccTradeFieldConstants } from '../../../common/fcc-trade-field-constants';
import { ProductMappingService } from './../../../../../common/services/productMapping.service';

@Component({
  selector: 'app-tf-general-details',
  templateUrl: './tf-general-details.component.html',
  styleUrls: ['./tf-general-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: TfGeneralDetailsComponent }]
})
export class TfGeneralDetailsComponent extends TfProductComponent implements OnInit {

  @Output() messageToEmit = new EventEmitter<string>();
  taskDialog: DynamicDialogRef;
  referenceId;
  channelRefStatus;
  TFRequestTypeStatus;
  standaloneDataChecked = false;
  form: FCCFormGroup;
  module = `${this.translateService.instant('tfGeneralDetails')}`;
  option: any;
  tableColumns = [];
  refId: any;
  docId: any;
  data: any;
  fileModel: FileMap;
  contextPath: any;
  fileName: any;
  params = FccGlobalConstant.PARAMS;
  rendered = FccGlobalConstant.RENDERED;
  layoutClass = FccGlobalConstant.layoutClass;
  mode: any;
  lcResponse: any;
  backToBackResponse: any;
  templateResponse: any;
  styleClass: any;
  selectedRequestType: any;
  lcConstant = new LcConstant();
  options = this.lcConstant.options;
  selectedRefId: string;
  importFinancingList = [];
  exportFinancingList = [];
  requestOptionsTFList = [];
  otherFinancingList = [];
  disabled = this.lcConstant.disabled;
  phrasesResponse: any;
  addCommentPermission = false;
  warningConfirm = null;
  currentDate = new Date();
  custRefLength;

  constructor(
    protected commonService: CommonService,
    protected leftSectionService: LeftSectionService,
    protected router: Router, protected translateService: TranslateService,
    protected prevNextService: PrevNextService, protected utilityService: UtilityService,
    protected saveDraftService: SaveDraftService, protected searchLayoutService: SearchLayoutService,
    protected formModelService: FormModelService, protected formControlService: FormControlService,
    protected stateService: ProductStateService, protected route: ActivatedRoute,
    protected transactionDetailService: TransactionDetailService, protected eventEmitterService: EventEmitterService,
    public fccGlobalConstantService: FccGlobalConstantService, public datePipe: DatePipe,
    public uploadFile: FilelistService, protected phrasesService: PhrasesService, protected resolverService: ResolverService,
    protected confirmationService: ConfirmationService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
    protected dialogRef: DynamicDialogRef, protected currencyConverterPipe: CurrencyConverterPipe,
    protected dialogService: DialogService, protected tfProductService: TfProductService,
    protected productMappingService: ProductMappingService) {
    super(eventEmitterService, stateService, commonService, translateService, confirmationService,
      customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, uploadFile,
      dialogRef, currencyConverterPipe, tfProductService);
  }

  ngOnInit(): void {
    super.ngOnInit();
    this.referenceId = this.commonService.referenceId;
    this.contextPath = this.fccGlobalConstantService.contextPath;
    this.refId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    this.option = this.commonService.getQueryParametersFromKey('option');
    if (this.commonService.referenceId === undefined) {
      sessionStorage.removeItem(FccGlobalConstant.idempotencyKey);
    }
    this.initializeFinancingList();
    this.initializeFormGroup();
    this.commonService.getUserPermission(FccGlobalConstant.TF_GENERAL_FROM_SCRATCH).subscribe(res => {
      if (res) {
        this.addCommentPermission = true;
      }
    });

    if (this.addCommentPermission) {
      this.patchFieldParameters(this.form.get('requestOptionsTF'), { options: this.requestwithstandalone() });
    } else {
      this.patchFieldParameters(this.form.get('requestOptionsTF'), { options: this.requestwithoutstandalone() });
    }
    this.setStandaloneList();
    this.commonService.FTRequestType.next('01');
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.custRefLength = response.customerReferenceTradeLength;
        this.form.addFCCValidators('customerReference', Validators.maxLength(this.custRefLength), 0);
      }
    });
  }

  setStandaloneList() {
    this.otherFinancingList = [{
      label: `${this.translateService.instant('typeOfFinancingList_08')}`,
      code: 'OTHER',
      value: {
        smallName: 'OTHER',
        label: 'OTHER',
        shortName: `${this.translateService.instant('typeOfFinancingList_08')}`
      }
    }];

  }

  requestwithoutstandalone() {
    return this.requestOptionsTFList = [
      { label: `${this.translateService.instant('requestOptionsTF_01')}`, value: '01', icon: 'fa fa-check-circle fa-2x', disabled: false },
      { label: `${this.translateService.instant('requestOptionsTF_02')}`, value: '02', icon: 'fa fa-check-circle fa-2x', disabled: false }
    ];
  }

  requestwithstandalone() {
    return this.requestOptionsTFList = [
      { label: `${this.translateService.instant('requestOptionsTF_01')}`, value: '01', icon: 'fa fa-check-circle fa-2x', disabled: false },
      { label: `${this.translateService.instant('requestOptionsTF_02')}`, value: '02', icon: 'fa fa-check-circle fa-2x', disabled: false },
      { label: `${this.translateService.instant('requestOptionsTF_03')}`, value: '03', icon: 'fa fa-check-circle fa-2x', disabled: false }
    ];
  }

  ngOnDestroy() {
    this.lcResponse = null;
    if (this.form) {
      this.tfProductService.toggleCreateFormButtons(this.form.get('requestOptionsTF')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS],
      this.form.get('requestOptionsTF').value);
      if (this.form.get('otherSubProductText')[this.params][this.rendered] === true) {
        this.togglePreviewScreen(this.form, ['otherSubProductText', 'typeOfFinancingList'], false);
        this.form.get('financingSubproductType').setValue(this.form.get('otherSubProductText').value);
        this.form.get('financingSubproductType')[this.params][this.rendered] = true;
        this.form.get('financingSubproductType').updateValueAndValidity();
    } else {
      this.togglePreviewScreen(this.form, ['typeOfFinancingList'], true);
      this.form.get('otherSubProductText').reset();
      this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      this.form.get('otherSubProductText').clearValidators();
      this.form.get('otherSubProductText').updateValueAndValidity();
      this.form.get('financingSubproductType')[this.params][this.rendered] = false;
      this.form.updateValueAndValidity();
    }
  }
  }

  initializeFinancingList() {
    this.importFinancingList = [
      {
        label: `${this.translateService.instant('typeOfFinancingList_01')}`,
        code: 'ITRPT',
        value: {
          smallName: 'ITRPT',
          label: 'ITRPT',
          shortName: `${this.translateService.instant('typeOfFinancingList_01')}`
        }
      },
      {
        label: `${this.translateService.instant('typeOfFinancingList_02')}`,
        code: 'ILNIC',
        value: {
          smallName: 'ILNIC',
          label: 'ILNIC',
          shortName: `${this.translateService.instant('typeOfFinancingList_02')}`
        }
      },
      {
        label: `${this.translateService.instant('typeOfFinancingList_03')}`,
        code: 'IBCLC',
        value: {
          smallName: 'IBCLC',
          label: 'IBCLC',
          shortName: `${this.translateService.instant('typeOfFinancingList_03')}`
        }
      },
      {
        label: `${this.translateService.instant('typeOfFinancingList_04')}`,
        code: 'IOTHF',
        value: {
          smallName: 'IOTHF',
          label: 'IOTHF',
          shortName: `${this.translateService.instant('typeOfFinancingList_04')}`
        }
      }
    ];
    this.exportFinancingList = [
      {
        label: `${this.translateService.instant('typeOfFinancingList_05')}`,
        code: 'EBEXP',
        value: {
          smallName: 'EBEXP',
          label: 'EBEXP',
          shortName: `${this.translateService.instant('typeOfFinancingList_05')}`
        }
      },
      {
        label: `${this.translateService.instant('typeOfFinancingList_06')}`,
        code: 'EDIEC',
        value: {
          smallName: 'EDIEC',
          label: 'EDIEC',
          shortName: `${this.translateService.instant('typeOfFinancingList_06')}`
        }
      },
      {
        label: `${this.translateService.instant('typeOfFinancingList_07')}`,
        code: 'EOTHF',
        value: {
          smallName: 'EOTHF',
          label: 'EOTHF',
          shortName: `${this.translateService.instant('typeOfFinancingList_07')}`
        }
      }
    ];
    this.otherFinancingList = [{
      label: `${this.translateService.instant('typeOfFinancingList_08')}`,
      code: 'OTHER',
      value: {
        smallName: 'OTHER',
        label: 'OTHER',
        shortName: `${this.translateService.instant('typeOfFinancingList_08')}`
      }
    }];
  }

  initializeFormGroup() {
    const sectionName = 'tfGeneralDetails';
    this.form = this.stateService.getSectionData(sectionName);
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    this.refId = this.commonService.getQueryParametersFromKey(FccGlobalConstant.REF_ID);
    this.form.get('fourSpace01')[this.params][this.rendered] = true;
    if (this.form.get('requestOptionsTF').value === '01') {
      this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.importFinancingList, disabled: false });
    }
    if (this.form.get('requestOptionsTF').value === '02') {
      this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.exportFinancingList, disabled: false });
    }
    if (!this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] && this.mode !== 'DRAFT' &&
    this.form.get('requestOptionsTF').value !== '03') {
      this.hideNavigation();
      this.toggleHiddenFields(false);
    }
    if (this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS) &&
    this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered]) {
      this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params]['showRemoveLink'] = false;
    }
    this.patchFieldParameters(this.form.get('parentReference'), { rendered: false });
    if (this.mode === 'DRAFT') {
      this.fetchedValuesOnEdit();
      this.manageRequestedIssueDate();
    }
    this.form.get('otherSubProductText')[this.params][this.rendered] = false;
    this.form.get('financingSubproductType')[this.params][this.rendered] = false;
    this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
    this.setFinancingType();
    this.setStandaloneList();
    if (this.form.get('requestOptionsTF').value === '03') {
      this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.otherFinancingList });
      this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), FccGlobalConstant.FROM_GENERAL_SCRATCH, {});
      // this.patchFieldValueAndParameters(this.form.get('mode'), 'DRAFT', {});
      this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.otherFinancingList });
      this.patchFieldValueAndParameters(this.form.get('typeOfFinancingList'), this.otherFinancingList[0].value, { disabled: true });
      this.form.updateValueAndValidity();
    }
    this.displayWarning();
    const parentRefID = this.form.get(FccGlobalConstant.PARENT_REF).value || this.form.get('parentTnxId').value;
    if (this.mode === FccGlobalConstant.DRAFT_OPTION && this.commonService.isNonEmptyValue(parentRefID) &&
        this.commonService.isNonEmptyField(FccGlobalConstant.TF_REQUEST_OPTIONS, this.form)) {
      this.initializeFormToLCDetailsResponse(parentRefID);
    }
  }

  displayWarning() {
    this.commonService.channelRefNo.subscribe((data) => {
      if (data) {
        this.channelRefStatus = data;
        if (this.channelRefStatus) {
          this.form.get('requestOptionsTF')[this.params][this.layoutClass] = 'p-grid p-col-12 disableOptions';
        }
      }
    });
    if (this.channelRefStatus === 'undefined') {
      this.form.get('requestOptionsTF')[this.params][this.layoutClass] = 'p-grid p-col-12';
    }
    this.form.updateValueAndValidity();
  }

  fetchedValuesOnEdit() {
    this.form.get('browseButton')[this.params][this.rendered] = false;
    this.form.get('selectLCMessage')[this.params][this.rendered] = false;
    this.toggleHiddenFields(true);
    this.form.get('transactionDetails')[this.params][this.rendered] = false;
    this.form.get('infoIcons')[this.params][this.rendered] = false;
    this.setBillAmt(this.form.get('parentReference').value);
    this.commonService.announceMission('no');
    const finTypeVal = this.form.get('finType').value;
    this.patchFieldParameters(this.form.get('typeOfFinancingList'), { readonly: true });
    if (finTypeVal === '01') {
      this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), 'IMPORT_DRAFT', {});
      this.patchFieldValueAndParameters(this.form.get('requestOptionsTF'), '01', {});
      this.tfProductService.toggleCreateFormButtons(
        this.form.get("requestOptionsTF")[FccGlobalConstant.PARAMS][
          FccGlobalConstant.OPTIONS
        ],
        this.form.get("requestOptionsTF").value
      );
    } else if (finTypeVal === '02') {
      this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), 'EXPORT_DRAFT', {});
      this.patchFieldValueAndParameters(this.form.get('requestOptionsTF'), '02', {});
      this.tfProductService.toggleCreateFormButtons(this.form.get('requestOptionsTF')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS],
        this.form.get('requestOptionsTF').value);
    } else if (finTypeVal === '03') {
      this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), FccGlobalConstant.FROM_GENERAL_SCRATCH, {});
    } else if (finTypeVal === '99') {
      this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), FccGlobalConstant.FROM_GENERAL_SCRATCH, {});
      this.form.get('relatedReferenceView')[this.params][this.rendered] = true;
      this.form.get('relatedReference')[this.params][this.rendered] = true;
      this.patchFieldValueAndParameters(this.form.get('requestOptionsTF'), '03', {});
      this.tfProductService.toggleCreateFormButtons(
        this.form.get("requestOptionsTF")[FccGlobalConstant.PARAMS][
          FccGlobalConstant.OPTIONS
        ],
        this.form.get("requestOptionsTF").value
      );
    } else {
      this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), 'GENERAL_DRAFT', { disabled: true });
    }
  }

  manageRequestedIssueDate() {
    const currentDate = new Date();
    const reqDateVal = this.form.get('requestedIssueDateSelect').value;
    const dateDiff = this.dateDifference(currentDate, reqDateVal);
    if (dateDiff < 0) {
      this.form.get('requestedIssueDateSelect').setValue(null);
      this.form.get('maturityDateSelect').setValue(null);
      this.form.get('inputDays_D').setValue(null);
    }
  }

  setBillAmt(parentRef: any) {
    if (parentRef && parentRef !== null) {
    this.transactionDetailService.fetchTransactionDetails(parentRef).subscribe(responseData => {
      const responseObj = responseData.body;
      let benificiary;
      let amount;
      let currency;
      let dateHeader;
      let date;
      if (responseObj.product_code === FccGlobalConstant.PRODUCT_LC || responseObj.product_code === FccGlobalConstant.PRODUCT_EL) {
        benificiary = responseObj.beneficiary_name;
        if (responseObj.product_code === FccGlobalConstant.PRODUCT_LC) {
          if (this.commonService.isNonEmptyValue(responseObj.lc_amt) && this.commonService.isNonEmptyValue(responseObj.lc_liab_amt)) {
            const lcAmt = parseFloat(this.commonService.replaceCurrency(responseObj.lc_amt));
            const lcLiabAmt = parseFloat(this.commonService.replaceCurrency(responseObj.lc_liab_amt));
            if (lcAmt !== lcLiabAmt) {
              amount = lcAmt - lcLiabAmt;
              amount = this.currencyConverterPipe.transform(amount.toString(), responseObj.lc_cur_code);
            } else {
              amount = responseObj.lc_amt;
            }
          }
          currency = responseObj.lc_cur_code;
          date = responseObj.exp_date;
          dateHeader = 'expiryDate';
        } else {
          amount = responseObj.lc_amt;
          currency = responseObj.lc_cur_code;
          date = responseObj.iss_date;
          dateHeader = 'TFIssueDate';
        }
      } else {
        benificiary = responseObj.drawer_name;
        date = responseObj.appl_date;
        dateHeader = 'applicableDate';
        if (responseObj.product_code === FccGlobalConstant.PRODUCT_IC) {
          amount = responseObj.ic_amt;
          currency = responseObj.ic_cur_code;
        } else {
          amount = responseObj.ec_amt;
          currency = responseObj.ec_cur_code;
        }
      }
      const cardData = [
        {
          header: this.translateService.instant('channelsId'),
          value: responseObj.ref_id
        },
        {
          header: this.translateService.instant('beneficiaryHeader'),
          value: benificiary
        },
        {
          header: this.translateService.instant(FccGlobalConstant.AMOUNT_FIELD),
          value: `${currency} ${amount}`
        },
        {
          header: this.translateService.instant(dateHeader),
          value: date
        },
        {
          header: this.translateService.instant('boRefId'),
          value: responseObj.bo_ref_id
        }
      ];
      this.commonService.setLcResponse(responseObj);
      this.commonService.setTfBillAmount(`${currency} ${amount}`);
      this.commonService.setTfFinAmount(`${amount}`);
      this.commonService.setTfFinCurrency(`${currency}`);
      this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.options] = cardData;
      this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] = true;
    });
    }
  }

  setFinancingType() {
    if (this.form.get('typeOfFinancingList').value) {
      const typeOfFinancingList = this.stateService.getValue('tfGeneralDetails', 'typeOfFinancingList', false);
      if (typeOfFinancingList !== undefined && typeOfFinancingList !== '') {
        if (this.form.get('requestOptionsTF').value === '01') {
          this.form.get('typeOfFinancingList').setValue(this.importFinancingList.filter(
            task => task.label === typeOfFinancingList)[0].value);
          if (this.importFinancingList[3].code === this.form.get('typeOfFinancingList').value.label) {
            this.form.get('otherSubProductText')[this.params][this.rendered] = true;
            this.form.get('fourSpace01')[this.params][this.rendered] = false;
            this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
          }
        } else if (this.form.get('requestOptionsTF').value === '02') {
          this.form.get('typeOfFinancingList').setValue(this.exportFinancingList.filter(
            task => task.label === typeOfFinancingList)[0].value);
          if (this.exportFinancingList[2] &&
            this.exportFinancingList[2].code === this.form.get('typeOfFinancingList').value.label) {
            this.form.get('otherSubProductText')[this.params][this.rendered] = true;
            this.form.get('fourSpace01')[this.params][this.rendered] = false;
            this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
          }
        }
        else {
          //    this.form.get('typeOfFinancingList').setValue(this.exportFinancingList.filter(
          //     task => task.label === typeOfFinancingList)[0].value);
          if (this.exportFinancingList[2].code === this.form.get('typeOfFinancingList').value.label) {
            this.form.get('otherSubProductText')[this.params][this.rendered] = true;
            this.form.get('fourSpace01')[this.params][this.rendered] = false;
            this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
          }
        }
      }
      this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT).updateValueAndValidity();
    }
  }

  hideNavigation() {
    setTimeout(() => {
      const ele = document.getElementById('next');
      if (ele) {
        this.commonService.announceMission('yes');
      } else {
        this.hideNavigation();
      }
    }, FccGlobalConstant.LENGTH_500);
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
    this.stateService.setStateSection('tfGeneralDetails', this.form);
    // this.fileModel = new FileMap(null, null, null, null, null, null, null, null, null, null, null);
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
    return this.uploadFile.getList();
  }

  onBlurAmount() {
    const settlementamt = parseFloat(this.form.get('amount').value);
    const tnxAmt = parseFloat(this.form.get('collectionAmount').value);
    if ((settlementamt && tnxAmt) && (settlementamt > tnxAmt)) {
      this.form.get('amount').setErrors({ settlementAmtLessThanLCAmt: true });
    }
  }

  onClickNext() {
    this.saveFormOject();
    if (!CommonService.isTemplateCreation) {
      this.leftSectionService.addSummarySection();
      this.saveDraftService.changeSaveStatus('tfGeneralDetails',
        this.stateService.getSectionData('tfGeneralDetails'));
    }
    if (this.form.valid && !CommonService.isTemplateCreation) {
      this.leftSectionService.addSummarySection();
    }
    if (this.form.invalid) {
      this.leftSectionService.removeSummarySection();
    }
  }

  onClickBrowseButton() {
    const header = `${this.translateService.instant('existingTnxList')}`;
    const productCode = 'productCode';
    const subProductCode = 'subProductCode';
    const headerDisplay = 'headerDisplay';
    const buttons = 'buttons';
    const savedList = 'savedList';
    const option = 'option';
    const downloadIconEnabled = 'downloadIconEnabled';
    const obj = {};
    obj[productCode] = FccGlobalConstant.PRODUCT_TF;
    obj[FccGlobalConstant.CURRENT_DATE] = this.currentDate;
    if (this.selectedRequestType === '02') {
      obj[option] = 'ExportGeneral';
    } else {
      obj[option] = 'ImportGeneral';
    }
    obj[subProductCode] = '';
    obj[buttons] = false;
    obj[savedList] = false;
    obj[headerDisplay] = false;
    obj[downloadIconEnabled] = false;

    this.resolverService.getSearchData(header, obj);
    this.lcResponse = this.searchLayoutService.searchLayoutDataSubject.subscribe((response) => {
      if (response !== null) {
        this.searchLayoutService.searchLayoutDataSubject.next(null);
        this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] = true;
        this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params]['showRemoveLink'] = true;
        this.commonService.announceMission('no');
        this.initializeFormToLCDetailsResponse(response);
        this.commonService.warningCancelResponse.next(response);

        //  if (this.form.get('typeOfProduct').value ==='FROM_IMPORT_LC' ){
        // this.toggleCreateFormButtons(
        //   this.form.get(FccGlobalConstant.REQUEST_OPTIONS_TF)[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS],
        //   this.form.get(FccGlobalConstant.REQUEST_OPTIONS_TF).value);
      }
    });

  }

  setFTRequestType(type) {
    this.commonService.FTRequestType.next(type);
  }

  initializeFormToLCDetailsResponse(response: any) {
    const data = response;
    this.setFTRequestType(this.form.get('requestOptionsTF').value);
    this.transactionDetailService.fetchTransactionDetails(response.responseData.REF_ID).subscribe(responseData => {
      const responseObj = responseData.body;
      this.commonService.setParentTnxInformation(responseObj);
      let amount;
      let currency;
      if (responseObj.product_code === FccGlobalConstant.PRODUCT_LC || responseObj.product_code === FccGlobalConstant.PRODUCT_EL) {
        if (responseObj.product_code === FccGlobalConstant.PRODUCT_LC) {
          amount = data.responseData.TNX_AMT;
          currency = data.responseData.CUR_CODE;
        } else {
          amount = data.responseData.TNX_AMT;
          currency = data.responseData.CUR_CODE;
        }
      } else {
        if (responseObj.product_code === FccGlobalConstant.PRODUCT_IC) {
          amount = responseObj.ic_amt;
          currency = responseObj.ic_cur_code;
        } else {
          amount = responseObj.ec_amt;
          currency = responseObj.ec_cur_code;
        }
      }

      this.commonService.setLcResponse(responseObj);
      let billAmt = '';
      if (localStorage.getItem('language') !== 'ar') {
        billAmt = this.commonService.replaceCurrency(amount);
        billAmt = this.currencyConverterPipe.transform(billAmt.toString(), currency);
      } else {
        billAmt = amount;
      }
      this.commonService.setTfBillAmount(`${currency} ${billAmt}`);
      this.commonService.setTfFinAmount(`${billAmt}`);
      this.commonService.setTfFinCurrency(`${currency}`);
      this.form.get('browseButton')[this.params][this.rendered] = false;
      this.form.get('infoIcons')[this.params][this.rendered] = false;
      this.form.get('selectLCMessage')[this.params][this.rendered] = false;
      this.form.get('parentReference').patchValue(responseObj.ref_id);
      this.form.get('relatedReference')[this.params][this.rendered] = false;
      this.toggleHiddenFields(true);
      this.form.addFCCValidators('inputDays_D', Validators.compose([Validators.pattern(FccGlobalConstant.numberPattern)]), 0);
      this.form.get('inputDays_D').updateValueAndValidity();
      this.selectedRefId = responseObj.ref_id;
      if (this.selectedRefId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2) === FccGlobalConstant.PRODUCT_LC) {
        this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), 'FROM_IMPORT_LC', {});
        this.patchFieldValueAndParameters(this.form.get('finType'), '01', {});
        this.patchFieldValueAndParameters(this.form.get('parentTnxId'), data.responseData.TNX_ID, {});
      } else if (this.selectedRefId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2) === FccGlobalConstant.PRODUCT_IC) {
        this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), 'FROM_IMPORT_COLLECTION', {});
        this.patchFieldValueAndParameters(this.form.get('finType'), '01', {});
      } else if (this.selectedRefId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2) === FccGlobalConstant.PRODUCT_EL) {
        this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), 'FROM_EXPORT_LC', {});
        this.patchFieldValueAndParameters(this.form.get('finType'), '02', {});
        this.patchFieldValueAndParameters(this.form.get('parentTnxId'), data.responseData.TNX_ID, {});
      } else if (this.selectedRefId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2) === FccGlobalConstant.PRODUCT_EC) {
        this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), 'FROM_EXPORT_COLLECTION', {});
        this.patchFieldValueAndParameters(this.form.get('finType'), '02', {});
      }
      if (this.form.get('requestOptionsTF').value === '01') {
        this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.importFinancingList, disabled: false });
      }
      if (this.form.get('requestOptionsTF').value === '02') {
        this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.exportFinancingList, disabled: false });
      }
      const liCardControl = this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS) as FCCFormControl;
      let cardData= null;
      let cardDataVal = null;
      cardData = this.productMappingService.getDetailsOfCardData(responseObj, liCardControl);
      cardDataVal = cardData.concat([{ header: this.translateService.instant('EVENT_REF'), value: data.responseData.BO_TNX_ID },
      { header: this.translateService.instant('billAmountLabel'), value: `${currency} ${billAmt}` }]);
      this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.options] = cardDataVal;
      this.form.updateValueAndValidity();
    });
  }

  toggleHiddenFields(flag: boolean) {
    this.form.get('financingInstructions')[this.params][this.rendered] = flag;
    this.form.get('customerReferenceView')[this.params][this.rendered] = flag;
    this.form.get('typeOfFinancing')[this.params][this.rendered] = flag;
    this.form.get('requestedIssueDate')[this.params][this.rendered] = flag;
    this.form.get('tenor')[this.params][this.rendered] = flag;
    this.form.get('maturityDate')[this.params][this.rendered] = flag;
    this.form.get('descOfGoodsText')[this.params][this.rendered] = flag;
    this.form.get('fourSpace01')[this.params][this.rendered] = flag;
    const dependentFields = [FccGlobalConstant.CUSTOMER_REF, FccGlobalConstant.TYPE_OF_FINANCING_LIST,
    FccGlobalConstant.REQUESTED_ISSUED_DATE_SELECT, FccGlobalConstant.INPUT_DAYS_D, FccGlobalConstant.MATURITY_DATE_SELECT,
    FccGlobalConstant.DESC_GOODS_HEADER];
    this.handleDependentFields(flag, dependentFields);
    this.handleOtherTextArea();

    if (this.lcResponse !== undefined) {
      this.lcResponse.unsubscribe();
    }
  }

  protected handleDependentFields(flag: boolean, dependentFields: any) {
    dependentFields.forEach(id => this.setRenderOnly(id, flag));
  }

  setRenderOnly(id: any, flag: any) {
    if (this.form.get(id)) {
      this.patchFieldParameters(this.form.controls[id], { rendered: flag });
      if (this.mode !== FccGlobalConstant.DRAFT_OPTION) {
        this.patchFieldValueAndParameters(this.form.get(id), '', {});
      }
    }
  }

  protected handleOtherTextArea() {
    if (this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)) {
      this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[this.params][this.rendered] = false;
      this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      if (this.mode !== FccGlobalConstant.DRAFT_OPTION) {
        this.patchFieldValueAndParameters(this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT), '', {});
      }
    }
  }

  displayPopUp(requestOptionsTF) {

    const dir = localStorage.getItem('langDir');
    const headerField = `${this.translateService.instant(FccGlobalConstant.WARNINGTEXT)}`;
    const obj = {};
    const locaKey = FccGlobalConstant.LOCA_KEY;
    obj[locaKey] = FccGlobalConstant.WARNING_TF_KEY;
    const dialogRef = this.dialogService.open(TfWarningComponent, {
      data: obj,
      header: headerField,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir }
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === FccGlobalConstant.CONFIRMATION_YES) {
        this.patchFieldValueAndParameters(this.form.get('requestOptionsTF'), this.form.get('requestOptionsTF').value, {});
        if (this.form.get('requestOptionsTF').value === '01' || this.form.get('requestOptionsTF').value === '02') {
          this.standaloneDataChecked = false;
          this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] = false;
          this.form.get('browseButton')[this.params][this.rendered] = true;
          this.form.get('selectLCMessage')[this.params][this.rendered] = true;
          this.form.get('transactionDetails')[this.params][this.rendered] = true;
          this.form.get('infoIcons')[this.params][this.rendered] = true;
          this.toggleControls(false);
          this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] = false;
          this.form.get('relatedReferenceView')[this.params][this.rendered] = false;
          this.form.get('relatedReference')[this.params][this.rendered] = false;
          this.patchFieldValueAndParameters(this.form.get('relatedReference'), '', {});
          this.form.updateValueAndValidity();
        }
        if (this.form.get('requestOptionsTF').value === '03') {
          this.standaloneDataChecked = false;
          this.form.get('browseButton')[this.params][this.rendered] = false;
          this.form.get('selectLCMessage')[this.params][this.rendered] = false;
          this.form.get('transactionDetails')[this.params][this.rendered] = false;
          this.form.get('infoIcons')[this.params][this.rendered] = false;
          this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] = false;
          this.toggleControls(true);
          this.form.get('relatedReferenceView')[this.params][this.rendered] = true;
          this.form.get('relatedReference')[this.params][this.rendered] = true;
          this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.otherFinancingList });
          this.patchFieldValueAndParameters(this.form.get('typeOfFinancingList'), this.otherFinancingList[0].value, { disabled: true });
          this.form.updateValueAndValidity();
        }

      } else {
        if (this.standaloneDataChecked) {
          this.patchFieldValueAndParameters(this.form.get('requestOptionsTF'), '03', {});
        } else {
          this.patchFieldValueAndParameters(this.form.get('requestOptionsTF'), requestOptionsTF, {});
          this.form.get('browseButton')[this.params][this.rendered] = false;
          this.form.get('selectLCMessage')[this.params][this.rendered] = false;
          this.form.get('transactionDetails')[this.params][this.rendered] = false;
          this.form.get('infoIcons')[this.params][this.rendered] = false;
          this.toggleControls(true);

        }




      }
    });

  }


  toggleControls(flag) {
    this.form.get('financingInstructions')[this.params][this.rendered] = flag;
    this.form.get('customerReference')[this.params][this.rendered] = flag;
    this.form.get('customerReferenceView')[this.params][this.rendered] = flag;
    this.form.get('typeOfFinancing')[this.params][this.rendered] = flag;
    this.form.get('typeOfFinancingList')[this.params][this.rendered] = flag;
    this.form.get('requestedIssueDate')[this.params][this.rendered] = flag;
    this.form.get('requestedIssueDateSelect')[this.params][this.rendered] = flag;
    this.form.get('tenor')[this.params][this.rendered] = flag;
    this.form.get('inputDays_D')[this.params][this.rendered] = flag;
    this.form.get('maturityDate')[this.params][this.rendered] = flag;
    this.form.get('maturityDateSelect')[this.params][this.rendered] = flag;
    this.form.get('descOfGoodsText')[this.params][this.rendered] = flag;
    this.form.get('descOfGoodsHeader')[this.params][this.rendered] = flag;
    this.form.get('fourSpace01')[this.params][this.rendered] = flag;
  }
  onClickRequestOptionsTF(event) {

    let type = '';
    this.commonService.FTRequestType.subscribe((data) => {
      if (data) {
        type = data;
      }
    });

    if (this.form.get('requestOptionsTF').value === '01') {
      this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.importFinancingList });
    }
    if (this.form.get('requestOptionsTF').value === '02') {
      this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.exportFinancingList });
    }

    const status = this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered];
    this.selectedRequestType = event.value;
    if (this.standaloneDataChecked) {
      if (this.form.get('requestOptionsTF').value === '01' || this.form.get('requestOptionsTF').value === '02') {
        this.form.get('relatedReferenceView')[this.params][this.rendered] = true;
        this.form.get('relatedReference')[this.params][this.rendered] = true;
        this.displayPopUp('02');

      }

      if (this.form.get('requestOptionsTF').value === '03') {
        this.toggleControls(true);
        this.form.get('relatedReferenceView')[this.params][this.rendered] = true;
        this.form.get('relatedReference')[this.params][this.rendered] = true;
        this.patchFieldValueAndParameters(this.form.get('finType'), '99', {});
        this.commonService.setLcResponse(null);
        this.commonService.setTfBillAmount(null);
        this.commonService.setTfFinAmount(null);
        this.commonService.setTfFinCurrency(null);
      }


    } else {
      if (status === false && (this.form.get('requestOptionsTF').value === '01' || this.form.get('requestOptionsTF').value === '02')) {
        this.toggleHiddenFields(false);
        this.form.get('relatedReferenceView')[this.params][this.rendered] = true;
        this.form.get('relatedReference')[this.params][this.rendered] = true;
        this.form.get('browseButton')[this.params][this.rendered] = true;
        this.form.get('selectLCMessage')[this.params][this.rendered] = true;
        this.form.get('transactionDetails')[this.params][this.rendered] = true;
        this.form.get('infoIcons')[this.params][this.rendered] = true;


      }
      if (status === false && this.form.get('requestOptionsTF').value === '03') {
        this.form.get('browseButton')[this.params][this.rendered] = false;
        this.form.get('selectLCMessage')[this.params][this.rendered] = false;
        this.form.get('transactionDetails')[this.params][this.rendered] = false;
        this.form.get('infoIcons')[this.params][this.rendered] = false;
        this.toggleHiddenFields(true);
        this.form.get('relatedReferenceView')[this.params][this.rendered] = true;
        this.form.get('relatedReference')[this.params][this.rendered] = true;
        this.patchFieldValueAndParameters(this.form.get('finType'), '99', {});
        this.commonService.setLcResponse(null);
        this.commonService.setTfBillAmount(null);
        this.commonService.setTfFinAmount(null);
        this.commonService.setTfFinCurrency(null);
      }
    }


    if (status) {
      if (type === '01') {
        this.displayPopUp('01');
      }
      if (type === '02') {
        this.displayPopUp('02');
      }

    } else {
      if (this.form.get('requestOptionsTF').value === '01') {
        }
      if (this.form.get('requestOptionsTF').value === '02') {
      }
      if (this.form.get('requestOptionsTF').value === '03') {
        this.form.get('relatedReferenceView')[this.params][this.rendered] = true;
        this.form.get('relatedReference')[this.params][this.rendered] = true;
        this.patchFieldValueAndParameters(this.form.get('finType'), '99', {});
        //   const typeOfFinancingList = this.stateService.getValue('tfGeneralDetails', 'typeOfFinancingList', false);
        this.patchFieldParameters(this.form.get('typeOfFinancingList'), { options: this.otherFinancingList });
        this.patchFieldValueAndParameters(this.form.get('typeOfFinancingList'), this.otherFinancingList[0].value, { disabled: true });

        this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), FccGlobalConstant.FROM_GENERAL_SCRATCH, {});
        this.commonService.announceMission('no');
        this.form.get('browseButton')[this.params][this.rendered] = false;
        this.form.get('selectLCMessage')[this.params][this.rendered] = false;
        this.form.get('transactionDetails')[this.params][this.rendered] = false;
        this.form.get('infoIcons')[this.params][this.rendered] = false;
        this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] = false;
      }
    }

    if (status === false && this.standaloneDataChecked === false) {
      if (this.form.get('requestOptionsTF').value === '01' || this.form.get('requestOptionsTF').value === '02') {
        this.patchFieldValueAndParameters(this.form.get('relatedReference'), '', {});
        this.form.get('relatedReferenceView')[this.params][this.rendered] = false;
        this.form.get('relatedReference')[this.params][this.rendered] = false;
      }
    }

    this.commonService.channelRefNo.subscribe((data) => {
      if (data) {
        this.channelRefStatus = data;
      }
    });


  }







  onKeyupCustomerReference() {

    if (this.form.get('customerReference').value && this.form.get('requestOptionsTF').value === '03') {
      this.standaloneDataChecked = true;
    } else {
      this.standaloneDataChecked = false;
    }


  }

  onClickRemoveTfCardDetails() {
    this.commonService.setParentReference(null);
    const dir = localStorage.getItem('langDir');
    const headerField = `${this.translateService.instant(FccGlobalConstant.REMOVE_SELECTED_TRANSACION)}`;
    const obj = {};
    const locaKey = FccGlobalConstant.LOCA_KEY;
    obj[locaKey] = FccGlobalConstant.REMOVE_TF_KEY;
    const dialogRef = this.dialogService.open(ConfirmationDialogComponent, {
      data: obj,
      header: headerField,
      width: '35em',
      styleClass: 'fileUploadClass',
      style: { direction: dir }
    });
    dialogRef.onClose.subscribe((result: any) => {
      if (result.toLowerCase() === FccGlobalConstant.CONFIRMATION_YES) {
        this.resetRemoveLabelSR();
      }
    });
  }

  resetRemoveLabelSR() {
    this.toggleHiddenFields(false);
    this.commonService.setTfBillAmount(null);
    this.commonService.setLcResponse(null);
    this.form.get(FccTradeFieldConstants.TF_CARD_DETAILS)[this.params][this.rendered] = false;
    this.form.get('browseButton')[this.params][this.rendered] = true;
    this.form.get('infoIcons')[this.params][this.rendered] = true;
    this.form.get('selectLCMessage')[this.params][this.rendered] = true;
    this.patchFieldValueAndParameters(this.form.get('typeOfProduct'), null, {});
    this.form.get('parentReference').setValue('');
    this.commonService.announceMission('yes');
    this.form.updateValueAndValidity();
    this.tfProductService.enableCreateFormButtons(
      this.form.get(FccGlobalConstant.REQUEST_OPTIONS_TF)[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS]);
  }

  onBlurInputDays_D() {
    const requestedIssueDateValue = this.form.get('requestedIssueDateSelect').value;
    const tenorValue = this.form.get('inputDays_D').value;
    let newMaturityDate: any;
    if (requestedIssueDateValue !== null && tenorValue !== null && requestedIssueDateValue !== '' && tenorValue !== '') {
      newMaturityDate = this.dateChange(requestedIssueDateValue, tenorValue);
      this.patchFieldValueAndParameters(this.form.get('maturityDateSelect'), this.commonService.convertToDateFormat(newMaturityDate), {});
    }
    this.form.addFCCValidators('inputDays_D', Validators.compose([Validators.pattern(FccGlobalConstant.numberPattern)]), 0);
    this.form.get('inputDays_D').updateValueAndValidity();
  }

  onClickMaturityDateSelect() {
    const requestedIssueDateValue = this.form.get('requestedIssueDateSelect').value;
    const maturityDateValue = this.form.get('maturityDateSelect').value;
    let tenor: any;
    if (requestedIssueDateValue !== null && maturityDateValue !== null && requestedIssueDateValue !== '' && maturityDateValue !== '') {
      tenor = this.dateDifference(requestedIssueDateValue, maturityDateValue);
      if (tenor > 0) {
        this.patchFieldValueAndParameters(this.form.get('inputDays_D'), tenor, {});
      } else {
        this.patchFieldValueAndParameters(this.form.get('inputDays_D'), null, {});
        this.patchFieldValueAndParameters(this.form.get('maturityDateSelect'), null, {});
        this.form.get('maturityDateSelect').setErrors({});
      }
    }
  }

  onClickRequestedIssueDateSelect() {
    let requestedIssueDateValue = this.form.get(FccGlobalConstant.REQUESTED_ISSUED_DATE_SELECT).value;
    const currentDate = new Date();
    const maturityDateValue = this.form.get('maturityDateSelect').value;
    const tenorValue = this.form.get('inputDays_D').value;
    if ((requestedIssueDateValue)) {
      requestedIssueDateValue = `${requestedIssueDateValue.getDate()}/${
        requestedIssueDateValue.getMonth() + 1
      }/${requestedIssueDateValue.getFullYear()}`;
      requestedIssueDateValue = (requestedIssueDateValue !== '' && requestedIssueDateValue !== null) ?
                                  this.commonService.convertToDateFormat(requestedIssueDateValue) : '';
      if (requestedIssueDateValue && (requestedIssueDateValue.setHours(0, 0, 0, 0) < currentDate.setHours(0, 0, 0, 0)) ) {
        this.form.get(FccGlobalConstant.REQUESTED_ISSUED_DATE_SELECT).clearValidators();
        this.form.get(FccGlobalConstant.REQUESTED_ISSUED_DATE_SELECT).setValidators([compareRequestDateToCurrentDate]);
        this.form.get(FccGlobalConstant.REQUESTED_ISSUED_DATE_SELECT).updateValueAndValidity();
      }
       else {
        this.form.get(FccGlobalConstant.REQUESTED_ISSUED_DATE_SELECT).clearValidators();
        this.form.get(FccGlobalConstant.REQUESTED_ISSUED_DATE_SELECT).updateValueAndValidity();
      }
      }
    let newMaturityDate: any;
    let flag = true;
    if (tenorValue !== null && tenorValue !== '') {
      newMaturityDate = this.dateChange(requestedIssueDateValue, tenorValue);
      this.patchFieldValueAndParameters(this.form.get('maturityDateSelect'), this.commonService.convertToDateFormat(newMaturityDate), {});
      flag = false;
    }
    if (maturityDateValue !== null && maturityDateValue !== '' && flag) {
      this.patchFieldValueAndParameters(this.form.get('maturityDateSelect'), null, {});
    }
  }

  dateDifference(requestedIssueDateValue: any, maturityDateValue: any) {
    const requestedIssueDateVal = new Date(requestedIssueDateValue);
    const maturityDateVal = new Date(maturityDateValue);
    const date1 = Date.UTC(requestedIssueDateVal.getFullYear(), requestedIssueDateVal.getMonth(), requestedIssueDateVal.getDate());
    const date2 = Date.UTC(maturityDateVal.getFullYear(), maturityDateVal.getMonth(), maturityDateVal.getDate());
    return Math.floor((date2 - date1) / FccGlobalConstant.ONE_DAY_TOTAL_TIME);
  }

  dateChange(requestedIssueDateValue: any, tenorValue: any) {
    const date = new Date(requestedIssueDateValue);
    const newDate = new Date(+ date + tenorValue * FccGlobalConstant.ONE_DAY_TOTAL_TIME);
    return newDate.getDate() + '/' + (newDate.getMonth() + 1) + '/' + newDate.getFullYear();
  }
  onClickPhraseIcon(event: any, key: any) {
    this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_TF, key);
  }

  onClickTypeOfFinancingList() {
    if (this.form.get('typeOfFinancingList').value !== undefined && this.form.get('typeOfFinancingList').value !== null
      && this.form.get('typeOfFinancingList').value !== '') {
      const typeOfFinancingList = this.form.get('typeOfFinancingList').value;
      if (this.form.get('requestOptionsTF').value === '01' && typeOfFinancingList.label === this.importFinancingList[3].code) {
        this.form.get('otherSubProductText')[this.params][this.rendered] = true;
        this.form.get('fourSpace01')[this.params][this.rendered] = false;
        this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      } else if (this.form.get('requestOptionsTF').value === '02' && typeOfFinancingList.label === this.exportFinancingList[2].code) {
        this.form.get('otherSubProductText')[this.params][this.rendered] = true;
        this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
        this.form.get('fourSpace01')[this.params][this.rendered] = false;
      } else {
        this.form.get('otherSubProductText')[this.params][this.rendered] = false;
        this.form.get('fourSpace01')[this.params][this.rendered] = true;
        this.form.get('otherSubProductText').reset();
        this.form.get(FccGlobalConstant.OTHER_SUB_PRODUCT_TEXT)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
        this.form.get('otherSubProductText').updateValueAndValidity();
        this.form.updateValueAndValidity();
      }
    }
  }

}
