import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';

import { FCCFormControl, FCCFormGroup } from '../../../base/model/fcc-control.model';
import { ProductStateService } from '../../../corporate/trade/lc/common/services/product-state.service';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { CommonService } from '../../services/common.service';
import { FormAccordionPanelService } from '../../services/form-accordion-panel.service';
import { PdfGeneratorService } from '../../services/pdf-generator.service';
import { TabPanelService } from '../../services/tab-panel.service';
import { TransactionDetailService } from './../../services/transactionDetail.service';

@Component({
  selector: 'app-view',
  templateUrl: './view.component.html',
  styleUrls: ['./view.component.scss']
})
export class ViewComponent implements OnInit, OnDestroy {
  eventTnxStatCode: any;
  showSpinner = true;

  constructor(protected activatedRoute: ActivatedRoute, protected stateService: ProductStateService,
              protected pdfGeneratorService: PdfGeneratorService, protected tabPanelService: TabPanelService,
              public translate: TranslateService, protected commonService: CommonService,
              protected transactionDetailService: TransactionDetailService,
              protected formAccordionPanelService: FormAccordionPanelService) { }
  transactionId;
  referenceId;
  tnxTypeCode;
  operation;
  mode;
  productCode;
  subProductCode;
  eventRequiredForEnquiry: any;
  eventTypeCode = 'eventTypeCode';
  params: any = {};
  pdfData: Map<string, FCCFormGroup>;
  sectionNames: string[];
  tabSectionControlMap: Map<string, Map<string, FCCFormControl>>;
  readonly param = 'params';
  readonly grouphead = 'grouphead';
  readonly previewScreen = 'previewScreen';
  translateLabel = 'translate';
  translateValue = 'translateValue';
  dir: string = localStorage.getItem('langDir');
  modelJson: any;
  accordionSectionsList: string[] = [];
  eventSubTnxTypeCode: any;
  displayCode: any;

  ngOnInit() {
    const tnxid = 'tnxid';
    const referenceid = 'referenceid';
    const modeValue = 'mode';
    const prodCode = 'productCode';
    const componentType = 'componentType';
    const accordionViewRequired = 'accordionViewRequired';
    const tnxTypeCode = 'tnxTypeCode';
    const operation = 'operation';
    const eventTnxStatCode = 'eventTnxStatCode';
    const eventSubTnxTypeCode = 'subTnxTypeCode';
    const subProductCode = 'subProductCode';
    this.activatedRoute.queryParams.subscribe(params => {
      this.transactionId = params[tnxid];
      this.referenceId = params[referenceid];
      this.productCode = this.referenceId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2);
      this.tnxTypeCode = params[tnxTypeCode];
      this.operation = params[operation];
      this.eventTnxStatCode = params[eventTnxStatCode];
      this.eventSubTnxTypeCode = params[eventSubTnxTypeCode];
      this.subProductCode = params[subProductCode];
      this.commonService.putQueryParameters('tnxid', this.transactionId);
    });
    this.mode = 'view';
    this.params[prodCode] = this.productCode;
    this.params[modeValue] = this.mode;
    this.params[FccGlobalConstant.refId] = this.referenceId;
    this.params[FccGlobalConstant.tnxId] = this.transactionId;
    this.params[componentType] = 'summaryDetails';
    this.params[accordionViewRequired] = true;
    this.params[tnxTypeCode] = this.tnxTypeCode;
    this.params[operation] = this.operation;
    this.params[eventTnxStatCode] = this.eventTnxStatCode;
    this.params[FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE] = this.eventSubTnxTypeCode;
    this.params[FccGlobalConstant.eventTab] = true;
    this.params[FccGlobalConstant.transactionTab] = true;
    this.displayCode = this.commonService.displayLabelByCode(this.productCode, this.subProductCode);
    if (this.transactionId) {
      this.fetchDetails(this.transactionId, this.productCode);
    } else if (this.referenceId) {
      this.fetchDetails(this.referenceId);
    }
  }

  private fetchDetails(id: any, productCode?: undefined) {
    this.transactionDetailService.fetchTransactionDetails(id, productCode).toPromise()
      .then(response => {
      const responseObj = response.body;
      if (responseObj) {
        if (responseObj.prod_stat_code) {
          this.params[FccGlobalConstant.eventprodStatCode] = responseObj.prod_stat_code;
        }
        if (responseObj.tnx_stat_code) {
          this.params[FccGlobalConstant.eventTnxStatCode] = responseObj.tnx_stat_code;
        }
        if (responseObj.sub_tnx_type_code) {
          this.params[FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE] = responseObj.sub_tnx_type_code;
          this.showSpinner = false;
        }
        this.showSpinner = false;
      }
    });
  }

  ngAfterViewInit() {
    this.translate.get('corporatechannels').subscribe(() => {
      const loadForEventParams = {
        referenceId: this.referenceId,
        transactionId: this.transactionId,
        eventTnxTypeCode: this.tnxTypeCode,
        param: this.params,
        stateTypeNotReq: true
      };
      this.commonService.loadForEventValues.next(loadForEventParams);
    });
  }
  ngOnDestroy() {
    this.transactionId = null;
    this.referenceId = null;
    this.productCode = null;
    this.tnxTypeCode = null;
    this.mode = null;
    this.operation = null;
    this.eventTnxStatCode = null;
    this.commonService.pdfDecodeValue = false;
  }

  OnEnterKey(event) {
    if (event.code === 'Enter') {
      this.downloadPDF();
    }
  }

  downloadPDF() {
    this.modelJson = this.stateService.getProductModel();
    this.populatePDFData();
    const language = localStorage.getItem('language');
    this.translate.use(language ? language : 'en' );
    this.translate.get('corporatechannels').subscribe(() => {
    // eslint-disable-next-line no-console
    console.log('to ensure that the translations are loaded via making this sequential call');
    this.pdfGeneratorService.createPDF(
      this.pdfData,
      this.modelJson,
      this.referenceId,
      this.productCode,
      FccGlobalConstant.VIEW_SCREEN,
      this.transactionId,
      this.subProductCode,
      this.operation,
      this.tnxTypeCode,
      this.eventTnxStatCode
    );
    });
  }

  populatePDFData() {
    this.pdfData = new Map();
    this.sectionNames = this.stateService.getSectionNames();
    this.sectionNames.forEach(sectionName => {
      if (this.modelJson[sectionName] !== undefined && this.tabPanelService.isTabPanel(this.modelJson[sectionName])) {
        this.tabPanelService.initializeMaps(sectionName, this.stateService.getSectionData(sectionName, this.productCode));
        this.tabSectionControlMap = this.tabPanelService.getTabSectionControlMap();
        if (this.tabSectionControlMap.has(sectionName)) {
          const tabForm = new FCCFormGroup({});
          for (const [fieldName, control] of this.tabSectionControlMap.get(sectionName)) {
            let previewScreen = control[this.param][this.previewScreen];
            previewScreen = previewScreen === false ? false : true;
            if (fieldName && previewScreen) {
              tabForm.addControl(fieldName, control);
            }
          }
          this.pdfData.set(sectionName, tabForm);
        }
      } else if (this.modelJson[sectionName] !== undefined &&
        this.formAccordionPanelService.isFormAccordionPanel(this.modelJson[sectionName], undefined, undefined)) {
        this.formAccordionPanelService.initializeFormAccordionMap(sectionName,
          this.stateService.getSectionData(sectionName, this.productCode));
        const accordionPanelForm = new FCCFormGroup({});
        const accordionSubSectionAndControlsListMap = this.formAccordionPanelService.getAccordionSubSectionAndControlsListMap();
        const subSectionControlsMap = accordionSubSectionAndControlsListMap.get(sectionName);
        subSectionControlsMap.forEach((subSectionControlsList: FCCFormControl[], subSectionName: string) => {
          const accordionPanelSubSectionForm = new FCCFormGroup({});
          subSectionControlsList.forEach((subSectionControl) => {
            let previewScreen = subSectionControl[this.param][this.previewScreen];
            previewScreen = previewScreen === false ? false : true;
            if (previewScreen) {
            accordionPanelSubSectionForm.addControl(subSectionControl.key, subSectionControl);
            }
          });
          accordionPanelForm.addControl(subSectionName, accordionPanelSubSectionForm);
        });
        this.accordionSectionsList.push(sectionName);
        this.pdfData.set(sectionName, accordionPanelForm);
      } else {
        const value: FCCFormGroup = this.stateService.getSectionData(sectionName, this.productCode);
        this.pdfData.set(sectionName, value);
      }
    });
    if (this.accordionSectionsList.length > 0) {
      this.pdfGeneratorService.setAccordionList(this.accordionSectionsList);
    }
  }
}

