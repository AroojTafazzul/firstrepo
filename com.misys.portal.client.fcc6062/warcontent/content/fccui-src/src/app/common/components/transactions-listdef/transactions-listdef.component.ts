import {
  ChangeDetectorRef,
  Component,
  EventEmitter,
  HostListener,
  Injectable,
  Input,
  OnChanges,
  OnInit,
  Output,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { MessageService, SelectItem } from 'primeng/api';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { Table } from 'primeng/table';

import { ComponentService } from '../../../base/services/component.service';
import { UtilityService } from '../../../corporate/trade/lc/initiation/services/utility.service';
import { FccConstants } from '../../core/fcc-constants';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { AccountsSummaryService } from '../../services/accounts-summary.service';
import { CommonService } from '../../services/common.service';
import { FormModelService } from '../../services/form-model.service';
import { FormService } from '../../services/listdef-form-service';
import { ListDefService } from '../../services/listdef.service';
import { ResolverService } from '../../services/resolver.service';
import { FiltersectionComponent } from '../filtersection/filtersection.component';
import { PreferenceConfirmationComponent } from '../preference-confirmation/preference-confirmation.component';
import { TableComponent } from './../../../base/components/table/table.component';
import { InputDateControl, MultiSelectFormControl } from './../../../base/model/form-controls.model';
import { CurrencyConverterPipe } from './../../../corporate/trade/lc/initiation/pipes/currency-converter.pipe';
import { FccGlobalParameterFactoryService } from './../../core/fcc-global-parameter-factory-service';
import { HideShowDeleteWidgetsService } from './../../services/hide-show-delete-widgets.service';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { MatFiltersectionComponent } from '../filtersection/matfiltersection.component';
import { FCCFormGroup } from '../../../base/model/fcc-control.model';

@Component({
  selector: 'fcc-common-transactions-listdef',
  templateUrl: './transactions-listdef.component.html',
  styleUrls: ['./transactions-listdef.component.scss'],
  providers: []
})

@Injectable({
  providedIn: 'root'
})
export class TransactionsListdefComponent implements OnChanges, OnInit {

  @Output()
  submitEvent: EventEmitter<any> = new EventEmitter<any>();
  @Output()
  refreshList: EventEmitter<any> = new EventEmitter<any>();
  @Input() inputParams: any = [];
  @Input() equivalentCurrency = '';
  @Input() enableMasking = false;
  @Input() inputParamsList: any = [];
  @Input() tabsConfig: any = [];
  @Input() tabsInfo: any = [];
  @Output() rowSelectEventListdef: EventEmitter<any> = new EventEmitter<any>();
  @Output() rowUnSelectEventListdef: EventEmitter<any> = new EventEmitter<any>();
  @Output() retrieveFilterParams: EventEmitter<any> = new EventEmitter<any>();
  @Output() filterValues: EventEmitter<any> = new EventEmitter<any>();
  isFiltersClicked = false;
  displayableJson: any[] = [];
  filterPreferenceData: any;
  columnPreferenceData: any;
  indexAcc: number = null;
  showFilterValues: boolean;
  obj = {};
  search: any;
  column: any;
  timeFrame: SelectItem[] = [];
  cols: any[] = [];
  expandRowCols: any[] = [];
  tabledata: any[] = [];
  tempTableData: any;
  numRows: number;
  showWidgetFilter: boolean;
  savePreference: boolean;
  modifySavedPreference: boolean;
  widgetFilterData: FCCFormGroup;
  formValues: any[] = [];
  loading: boolean;
  totalRecords: number;
  finalData: any[] = [];
  defaultRow: number;
  first: number;
  sortOrder: number;
  rppOptions = [FccGlobalConstant.NUMBER_TEN, FccGlobalConstant.NUMBER_TWENTY, FccGlobalConstant.NUMBER_FIFTY,
    FccGlobalConstant.NUMBER_HUNDRED];
  loadingMessage = 'loading';
  paramsArray: any[] = [];
  filterParameters: string;
  defaultSortOrder: number;
  defaultSortField: string;
  datakey: string;
  checkBoxPermission: boolean;
  displayInputSwitch: any;
  buttons: any[] = [];
  isFilterValuesRequired: boolean;
  passbackField: any;
  selectMode: string;
  changed: boolean;
  showFilterSection: boolean;
  @ViewChild(Table) public tt: Table;
  checkCustomise;
  dir: string = localStorage.getItem('langDir');
  dirChevronStyle;
  filterParamsRequired = false;
  filterParams: any;
  widgetFilter: boolean;
  dialogRef: MatDialogRef<MatFiltersectionComponent>;
  filterDialogRef: DynamicDialogRef;
  dialogmodel: any;
  event: any;
  customFilter = false;
  showColumnsWithCurrency = ['EQUIVALENT_OPENING_BALANCE', 'EQUIVALENT_PRINCIPAL_AMOUNT', 'EQUIVALENT_AVAILABLE_BALANCE',
  'EQUIVALENT_AMOUNT', 'EQUIVALENT_MATURITY_AMOUNT'];
  firstRowSelected: any[] = [];
  defaultFilter: string;
  isRecordsFetched = false;
  preferenceArray: any[] = [];
  isActive = true;
  className: string;
  preferenceName: string;
  selectedPreference: any;
  addPhraseButtonEnable: boolean;
  addBankButtonEnable: boolean;
  createPhraseEnable: boolean;
  createBankEnable: boolean;
  filterPreferenceValues: any;
  filterDataArray: any;
  eyeEnable: boolean;
  widgetCode: any = '';
  displayTotalAmtBal: any;
  viewInCurrency: any;
  filterChipsRequired: boolean;

  numberOfDisplayableParams: any = 0;
  enableFilterPopup = false;
  defaultDaysCount = null;
  drilldownEnabled: string;
  childListdef: string;
  isParentList = true;
  parentWidgetConfig : any = {};
  filterDataParam : any;

  @Output() refreshProductList: EventEmitter<any> = new EventEmitter<any>();
  @Output() refreshTableDataList:EventEmitter<any> = new EventEmitter<any>();
  @Output() headerCheckboxToggle: EventEmitter<any> = new EventEmitter<any>();
  @Output() filterAppliedEvent: EventEmitter<any> = new EventEmitter<any>();
  @Output() resetTableFilterOnSwitch: EventEmitter<any> = new EventEmitter<any>();
  @Output() showViewAllListingPage: EventEmitter<any> = new EventEmitter<any>();
  @Output() selectedAccounts: EventEmitter<any> = new EventEmitter<any>();
  @Output() tabCountCheck: EventEmitter<any> = new EventEmitter<any>();
  @Output()
  filterChipResetEvent: EventEmitter<any> = new EventEmitter<any>();
  filterCriteriaOnCheckBox: any;
  rowCheckBoxEvent: any;
  showFilterText = false;
  showFilterIcon = true;
  multipleTabEnable = false;
  tabName: string;
  allowPreferenceSave = true;
  showSpinner: boolean;
  updateListdefData = true;
  retainFilterValues: any;
  dashboardTypes = FccGlobalConstant.dashboardTypes;
  activeState = false;
  isaccordionOpen = false;
  checkItemNottoBeTranslated = false;
  isTabsEnabled = false;
  API_ERROR_CODES = ['401', '403', '404', '408', '500','503'];
  currencySymbolDisplayEnabled = false;
  constructor( protected listService: ListDefService,
               protected router: Router,
               protected translateService: TranslateService,
               protected parameterType: FccGlobalParameterFactoryService,
               protected formService: FormService,
               public componentService: ComponentService,
               protected utilityService: UtilityService,
               protected translate: TranslateService,
               protected changedetector: ChangeDetectorRef,
               protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
               protected commonService: CommonService, protected formModelService: FormModelService,
               protected resolverService: ResolverService, public dialogService: DialogService,
               protected activatedRoute: ActivatedRoute, protected accountsSummaryService: AccountsSummaryService,
               public currencyConverterPipe: CurrencyConverterPipe, protected messageService: MessageService,
               protected matDialog: MatDialog) {
                this.showFilterValues = true;
                this.changed = true;
                this.activatedRoute.queryParams.subscribe(queryParams => {
                  this.widgetCode = queryParams[`widgetCode`] || '';
                });
               }

 @ViewChild(FiltersectionComponent) public formValuesBinding: FiltersectionComponent;
 @ViewChild(TableComponent) public table: TableComponent;

  // eslint-disable-next-line @angular-eslint/contextual-lifecycle
    ngOnInit() {
      this.commonService.setFooterSticky(true);
        this.commonService.getBankContextParameterConfiguredValues(FccGlobalConstant.PARAMETER_P809).subscribe(
          (response) => {
          if (this.commonService.isNonEmptyValue(response) &&
          this.commonService.isNonEmptyValue(response.paramDataList) && response.paramDataList[0] &&
          response.paramDataList[0][FccGlobalConstant.DATA_1]) {
            this.currencySymbolDisplayEnabled = response.paramDataList[0][FccGlobalConstant.DATA_1] === 'y';
          }
        });
      this.showSpinner = (this.inputParams.loaderEnabled !== undefined &&
        this.inputParams.loaderEnabled !== '') ?
        (this.inputParams.loaderEnabled === true ? true : false) : false;
      this.eyeEnable = this.enableMasking;

      if(this.tabsConfig.length === 0 && this.tabsInfo.length === 0){
        this.isTabsEnabled = false;
      } else {
        if(this.commonService.isNonEmptyValue(this.tabsConfig) &&
        this.commonService.isNonEmptyValue(this.tabsInfo)){
        this.isTabsEnabled = true;
        }
      }
      if(this.isTabsEnabled) {
        this.setTabConfig(this.tabsInfo,this.tabsConfig);
      }
      this.commonService.inputParamList = this.inputParamsList;
      this.showFilterSection = (this.inputParams.showFilterSection !== undefined &&
        this.inputParams.showFilterSection !== '') ?
      (this.inputParams.showFilterSection === true ? true : false) : true;
      this.setShowFilterSection();
      /** If metadata is defined and has search parameters only then the filter section should be dispalyed. */
      this.widgetFilter = (this.inputParams.widgetFilter !== undefined &&
        this.inputParams.widgetFilter !== '') ?
      (this.inputParams.widgetFilter) : false;
      this.customFilter = (this.inputParams.customFilter !== undefined &&
        this.inputParams.customFilter !== '') ?
      (this.inputParams.customFilter) : false;
      this.allowPreferenceSave = this.commonService.isnonEMptyString(this.inputParams.allowPreferenceSave) ?
        this.inputParams.allowPreferenceSave : true;
      this.multipleTabEnable = this.commonService.isnonEMptyString(this.inputParams.multipleTabEnable) ?
        (this.inputParams.multipleTabEnable) : false;
      this.tabName = this.commonService.isnonEMptyString(this.inputParams.tabName) ?
        (this.inputParams.tabName) : false;
      if (this.inputParams.filterText !== undefined && this.inputParams.filterText !== '') {
        if (this.inputParams.filterText === true) {
          this.showFilterText = true;
          this.showFilterIcon = false;
        }
      }
      this.widgetFilterData = this.inputParams.filterFormDataObj ? this.inputParams.filterFormDataObj : this.widgetFilterData;
      this.inputParams.skipRequest = this.inputParams.skipRequest ?? false;
      if (this.inputParams && this.inputParams.listdefName && !this.inputParams.skipRequest) {
        this.getMetadata(this.inputParams.listdefName, this.inputParams.productCode);
      }
      this.createPhraseEnable = false;
      this.createBankEnable = false;
      this.addPhraseButtonEnable = (this.commonService.getUserPermissionFlag(FccGlobalConstant.ADD_PHRASE_PERMISSION) &&
                    this.inputParams.listdefName === FccGlobalConstant.PHRASE_LISTDEF);
      this.addBankButtonEnable = (this.inputParams.listdefName === FccGlobalConstant.BANK_LISTDEF);
      this.preferenceName = this.preferenceArray.length > 0 ? this.preferenceArray[0].value : '';

      this.buttons = [
                      {
                        localizationkey: this.translateService.instant('saveAsNewBtn'),
                        name: 'saveAsNewBtn',
                        type: 'submit',
                        isActive : false,
                        hidden: !this.allowPreferenceSave
                      },
                      {
                        localizationkey: this.translateService.instant('saveBtn'),
                        name: 'saveBtn',
                        type: 'submit',
                        isActive : false,
                        hidden: !this.allowPreferenceSave
                      },
                      {
                        localizationkey: this.translateService.instant('apply'),
                        name: 'applyBtn',
                        type: 'submit',
                        isActive : true,
                        hidden: false
                      }
                     ];
      this.hideShowDeleteWidgetsService.customiseSubject.subscribe(data => {
        this.checkCustomise = data;
      });

      if (this.dir === 'rtl') {
        this.dirChevronStyle = 'chevronRtlStyle';
      } else {
        this.dirChevronStyle = 'chevronLtrStyle';
      }

      if (this.widgetFilterData?.value) {
        this.getFormValue(null, true);
      }
      this.commonService.refreshPaymentList.subscribe((val) => {
        if (val) {
          this.refreshDataTableList();
          this.commonService.refreshPaymentList.next(false);
        }
      });

      this.commonService.refreshPaymentWidgetList.subscribe((val) =>{
        if(val){
          this.refreshWidgetList(val);
          this.commonService.refreshPaymentWidgetList.next(null);
        }
      });

      this.commonService.refreshTable.subscribe((value) => {
        if (value) {
          this.fetchRecords(FccGlobalConstant.FCM_PAYMENT_DETAILS_LISTDEF, '', '', false, this.inputParams.filterParams);
          this.changed = true;
          this.changedetector.detectChanges();
          this.commonService.refreshTable.next(false);
          this.refreshTableDataList.emit();
        }
      });
    }

    @HostListener('window:keyup', ['$event'])
    tabEvent(event: KeyboardEvent) {
      const FILTER_SECTION_DIV_ID = 'filterSectionDivison';
      const KEYBOARD_TAB_KEY = 'Tab';
      const DOWNLOAD_BUTTON = 'tableDownload';

      const filterSectionDiv = document.getElementById(FILTER_SECTION_DIV_ID);
      const isFocused = (document.activeElement === filterSectionDiv);

      const isTabSkipRequired = (event.key === KEYBOARD_TAB_KEY
                                && isFocused
                                && !this.isFiltersClicked);
      if (isTabSkipRequired) {
        const tableDownload = document.getElementById(DOWNLOAD_BUTTON);
        tableDownload.setAttribute('tabindex', '-1');
        tableDownload.focus();
        tableDownload.setAttribute('tabindex', '0');
      }
    }

    setTabConfig(tabValue, config) {
      config.listdefName = tabValue?.listdefName;
      config.showFilterSection = config?.showFilterSection ? config.showFilterSection : false;
      config.widgetFilter = config?.widgetFilter ? config.widgetFilter : false;
      config.allowColumnCustomization = config?.allowColumnCustomization ?
      config.allowColumnCustomization : false;
      config.showButton = true;
      config.colFilterIconEnabled = false;
      config.passBackEnabled = true;
      this.inputParams = config;
    }

    toggleAdvancedFilter() {
      this.isFiltersClicked = !this.isFiltersClicked;
    }

    auditCall() {
      const requestPayload = {
        productCode: this.inputParams.productCode === undefined ? this.widgetCode : this.inputParams.productCode,
        subProductCode: this.activatedRoute.snapshot.queryParams[FccGlobalConstant.SUB_PRODUCT_CODE],
        operation: this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION),
        option: this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION),
        action: this.commonService.getQueryParametersFromKey(FccGlobalConstant.ACTION),
        tnxtype: this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE),
        mode: this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE),
        subTnxType: this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
        listDefName: this.inputParams && this.inputParams.listdefName ? this.inputParams.listdefName : '',
        actionCode: this.inputParams && this.inputParams.activeTab 
        && this.inputParams.activeTab.actionCode ? this.inputParams.activeTab.actionCode : ""
      };
      this.commonService.audit(requestPayload).subscribe(() => {
        //eslint : no-empty-function
      });
    }
    // eslint-disable-next-line @angular-eslint/contextual-lifecycle
    ngOnChanges() {
      this.showSpinner = (this.inputParams.loaderEnabled !== undefined &&
        this.inputParams.loaderEnabled !== '') ?
        (this.inputParams.loaderEnabled === true ? true : false) : false;
      if ((this.commonService.getAngularProducts().indexOf(this.inputParams.productCode) > -1
        || (this.commonService.isnonEMptyString(this.inputParams.dashboardType)) 
        || (this.inputParams.activeTab && this.commonService.isnonEMptyString(this.inputParams.activeTab.actionCode)))
        && this.inputParams.listdefName !== '/trade/listdef/customer/LS/customerLicense'
        && this.inputParams.listdefName !== 'core/listdef/systemfeatures/undertakingTemplateList' ||
        this.inputParams.listdefName === 'core/listdef/customer/MC/groupAccountsList') {
        this.auditCall();
      }
      this.commonService.filterDataAvailable = false;
      this.displayableJson = null;
      if (this.inputParams && this.inputParams.metadata) {
        this.displayableJson = this.formService.getFields(this.inputParams.metadata, this.inputParams.productCode);
        // this.commonService.filterInputVal = this.displayableJson;
        if (this.inputParams.showFilter) {
          this.commonService.filterInputVal = this.displayableJson;
          }
        this.setShowFilterSection();
        this.setDefaultProperties(this.inputParams.metadata);
        this.inputParams.listdefName = this.inputParams && this.inputParams.listdefName ? this.inputParams.listdefName : '';
        if (this.inputParams && this.inputParams.listdefName) {
          this.getColumns(this.inputParams.metadata, this.inputParams.listdefName);
        }
        this.getcheckboxPermission(this.inputParams.metadata);
      } else {
        const filterValues = {};
        if (this.inputParams && this.inputParams.baseCurrency) {
          filterValues[FccGlobalConstant.BASE_CURRENCY_APPLICABILITY] = this.inputParams.baseCurrency;
        }
        if (this.inputParams && this.commonService.isNonEmptyValue(this.inputParams.accountType) &&
          this.inputParams.accountType !== FccGlobalConstant.EMPTY_STRING && this.inputParams.accountType instanceof Array) {
          let stringValue = '';
          this.inputParams.accountType.forEach(element => {
            const trimmedValue: string = element;
            stringValue = stringValue + trimmedValue.trim() + '|';
          });
          stringValue = stringValue.substring(0, stringValue.length - 1);
          filterValues[FccGlobalConstant.ACCOUNT_TYPE] = stringValue;
        } else {
          if (this.inputParams && this.commonService.isNonEmptyValue(this.inputParams.accountType) &&
            this.inputParams.accountType !== FccGlobalConstant.EMPTY_STRING) {
            filterValues[FccGlobalConstant.ACCOUNT_TYPE] = this.inputParams.accountType;
          }
        }
        if (this.inputParams && this.commonService.isNonEmptyValue(this.inputParams.periodConfig) &&
          this.inputParams.periodConfig !== FccGlobalConstant.EMPTY_STRING) {
          filterValues[FccGlobalConstant.TIMEFRAME] = this.inputParams.periodConfig;
        }
        if (this.inputParams) {
          if (this.commonService.isnonEMptyString(this.inputParams.groupId)) {
            filterValues[FccGlobalConstant.GROUP_ID] = this.inputParams.groupId;
          }
          if (this.commonService.isnonEMptyString(this.inputParams.amountColumnValue)) {
            filterValues[FccGlobalConstant.AMOUNT_COLUMN_VALUE] = this.inputParams.amountColumnValue;
          }
          if (this.commonService.isnonEMptyString(this.inputParams.postDate)) {
            filterValues[FccGlobalConstant.POST_DATE] = this.inputParams.postDate;
          }
        }
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const filterParams = JSON.stringify(filterValues);
        this.inputParams.skipRequest = this.inputParams.skipRequest ?? false;
        if (this.inputParams && this.inputParams.listdefName && !this.inputParams.skipRequest &&
             (!this.inputParams.dashboardType || (
          this.inputParams.dashboardType && !this.dashboardTypes.includes(this.inputParams.dashboardType.toUpperCase())))) {
          this.getMetadata(this.inputParams.listdefName, this.inputParams.productCode, filterParams);
        }
      }
    }
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  getChildDeleteAllEvent(event: Event) {
    let keyList = Object.keys(this.inputParams.filterParams);
    if(this.inputParams.listdefName === FccGlobalConstant.FCM_PAYMENT_DETAILS_LISTDEF){
      keyList = Object.keys(this.inputParams.retainFilterValues);
    }
    if (keyList.length) {
      keyList.forEach(key => {
          this.deleteFilterByControl(key);
      });
      this.filterChipResetEvent.emit(event);
      this.fetchRecords(this.inputParams.listdefName, '', '', this.enableMasking, this.inputParams.filterParams);
    }
  }

  getChildDeleteEvent(event) {
    const control = event?.controlName;
    if (control) {
      this.filterChipResetEvent.emit(event);
      this.deleteFilterByControl(control);
      if(this.inputParams.listdefName === FccGlobalConstant.FCM_PAYMENT_DETAILS_LISTDEF){
        this.fetchRecords(this.inputParams.listdefName, '', '', this.enableMasking, this.inputParams.retainFilterValues);
      } else {
        this.fetchRecords(this.inputParams.listdefName, '', '', this.enableMasking, this.inputParams.filterParams);
      }
    }
  }

  deleteFilterByControl(key) {
    const controlName = this.underscoreToCamelcase(key);
    if(this.inputParams.listdefName === FccGlobalConstant.FCM_PAYMENT_DETAILS_LISTDEF){
      if (this.inputParams.retainFilterValues && this.inputParams.retainFilterValues[key]) {
        delete this.inputParams.retainFilterValues[key];
      }
    } else {
      if (this.inputParams.filterParams && this.inputParams.filterParams[key]) {
        delete this.inputParams.filterParams[key];
      }
    }
    if (this.formValues?.length) {
      const values = this.formValues;
      values.forEach((value, index) => {
        if (value.controlName === key) {
          this.formValues.splice(index, 1);
        }
      });
    }
    if (this.widgetFilterData) {
      this.widgetFilterData.get(controlName)?.reset();
    }
  }

  underscoreToCamelcase(name: string) {
    return name.toLowerCase().replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
  }

    resetTableFiltersOnSwtich(event) {
      if (!event.checked) {
        this.firstRowSelected = [];
        this.filterCriteriaOnCheckBox = {};
        const listdefName = event.type === FccGlobalConstant.checkBox ?
            this.inputParams.activeTab?.displayInputSwitch?.listdefName : this.inputParams.listdefName;
        if (this.rowCheckBoxEvent) {
          this.rowCheckBoxEvent.selected = false;
        }
        this.getMetadata(listdefName, this.inputParams.productCode, JSON.stringify({}));
        this.resetTableFilterOnSwitch.emit(event);
      }
    }

    checkClass(item){
      this.buttons.forEach(val => {
        if (val.name === item.name) {
          val.isActive = true;
        }else{
          val.isActive = false;
        }
      });
    }

    handleClick(item: any, event: Event) {
      this.updateListdefData = true;
      this.checkClass(item);
      switch (item.name) {
        case 'saveAsNewBtn':
        this.saveAsNew(event);
        break;
        case 'saveBtn':
        this.handleSave(event);
        break;
        case 'applyBtn':
        this.handleApply(event);
        break;
     default:
       break;
    }
    this.activeState = false;
    this.getFormValue(event,true);
  }

  onMatSelectEventRaised(event: any) {
    this.inputParams.preferenceName = event.value;
    if (this.inputParams && this.inputParams.listdefName) {
      this.getMetadata(this.inputParams.listdefName, this.inputParams.productCode);
    }
  }

  handleSave(event?: Event){
    if (this.commonService.isnonEMptyString(this.selectedPreference)) {
      this.inputParams.preferenceName = this.selectedPreference;
      this.customFilter = false;
      this.modifySavedPreference = true;
      this.commonService.filterDataAvailable = false;
      this.handleApply(event);
    } else {
      const tosterObj = {
        life : 5000,
        key: 'tc',
        severity: 'success',
        detail: `${this.translate.instant('preferenceNameRequired')}`
      };
      this.messageService.add(tosterObj);
      this.refreshList.emit();
      setTimeout(() => {
        //eslint : no-empty-function
      }, FccGlobalConstant.LENGTH_2000);
    }
  }

// eslint-disable-next-line @typescript-eslint/no-unused-vars
  saveAsNew(event?: Event, filterDataParam?: any) {
    const displayJSON = 'displayJSON';
    const buttonJSON = 'buttonJSON';
    this.obj = {};
    this.obj[displayJSON] = this.displayableJson;
    this.obj[buttonJSON] = this.dialogmodel;
    const dialogRef = this.dialogService.open(PreferenceConfirmationComponent, {
      header: `${this.translateService.instant('preferenceTitle')}`,
      width: '25em',
      contentStyle: {
        height: 'auto',
        overflow: 'auto'
      },
      styleClass: 'filterButton',
      data: this.obj,
      baseZIndex: 9999,
      autoZIndex: true,
      dismissableMask: false,
      closeOnEscape: true
    });
    dialogRef.onClose.subscribe((result: any) => {
     this.inputParams.companyId = '';
     this.inputParams.userId = '';
     this.inputParams.preferenceName = result.savedName === null ? '' : result.savedName;
     this.inputParams.defaultPreference = result.defaultPreferenceValue;
     this.inputParams.filterValues = {};
     this.inputParams.filterValues = {};
     this.customFilter = false;
     if (this.commonService.isNonEmptyValue(result)) {
      this.savePreference = true;
      this.commonService.filterDataAvailable = false;
      this.handleApply(event);
     }
  });
  }


    switchListDef(event) {
      if (event.checked) {
        this.getMetadata(this.inputParams.activeTab.displayInputSwitch.listdefName, this.inputParams.productCode, JSON.stringify({}));
      } else if (this.inputParams?.isDashboardWidget && (this.drilldownEnabled === 'true' || this.inputParams?.drillDownEnabled)) {
        if (this.commonService.isNonEmptyValue(this.childListdef)){
          this.getMetadata(this.childListdef, this.inputParams.productCode, JSON.stringify({}));
        } else {
          this.getMetadata(this.inputParams.drillDownTableConfig.listdefName, this.inputParams.productCode, JSON.stringify({}));
        }
        this.isParentList = false;
      } else if (this.inputParams?.isDashboardWidget && this.drilldownEnabled === 'false') {
        return;
      } else {
        this.getMetadata(this.inputParams.listdefName, this.inputParams.productCode, JSON.stringify({}));
      }
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    onClickResetbtn(event) {
      this.dialogService.dialogComponentRef.instance.componentRef.instance.form.value = {};
      this.inputParams.filterFormDataObj.controls.entity.value = [];
      this.dialogService.dialogComponentRef.instance.componentRef.instance.form.value.curCode = [];
      this.inputParams.filterFormDataObj.controls.curCode.value = [];
      this.retrieveFilterParams.emit(this.dialogService.dialogComponentRef.instance.componentRef.instance.form);
    }

    handleApply(event?: Event, filterDataParam?: any) {
      if (!this.customFilter) {
        this.changed = false;
        this.changedetector.detectChanges();
        this.isFilterValuesRequired = true;
        if (event) {
          event.preventDefault();
        }
        this.tabledata = [];
        const paginatorParams = '';
        this.inputParams.filterParamsRequired = false;
        if (this.inputParams && this.inputParams.listdefName) {
          this.updateListdefData = true;
          if (this.commonService.isNonEmptyValue(filterDataParam)){
            this.retainFilterValForViewMore(filterDataParam.value, filterDataParam);
          } else {
            this.inputParams.retainFilterValues = undefined;
          }
          this.fetchRecords(this.inputParams.listdefName, paginatorParams, '', this.enableMasking, filterDataParam);
        }
        this.changed = true;
        this.filterAppliedEvent.emit(this.widgetFilterData);
      } else {
        this.retrieveFilterParams.emit(this.widgetFilterData);
      }
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    onClickCreateNewPhrase(event: Event){
      this.createPhraseEnable = true;
      this.addPhraseButtonEnable = false;
    }
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    onClickCreateNewBank(event: Event){
      this.createBankEnable = true;
      this.addBankButtonEnable = false;
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    onClickCancelNewPhrase(event: Event){
      this.createPhraseEnable = false;
      this.addPhraseButtonEnable = true;
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    onClickSaveNewPhrase(event: Event){
      this.createPhraseEnable = false;
      this.addPhraseButtonEnable = true;
      this.refreshTransactionList();
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    onClickCancelNewBank(event: Event){
      this.createBankEnable = false;
      this.addBankButtonEnable = true;
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    onClickSaveNewBank(event: Event){
      this.createBankEnable = false;
      this.addBankButtonEnable = true;
      this.refreshTransactionList();
    }

    filterData(event: Event) {
      let dialogueStatus;
      this.commonService.filterDialogueStatus.subscribe((res: any) => {
        dialogueStatus = res;
      });
      const displayJSON = 'displayJSON';
      const buttonJSON = 'buttonJSON';
      const widgetFilterJSON = 'widgetFilterJSON';
      const formData = 'formData';
      this.obj = {};
      this.obj[displayJSON] = this.displayableJson;
      this.obj[buttonJSON] = this.dialogmodel;
      this.obj[widgetFilterJSON] = 'true';
      this.obj['tableData'] = this.tabledata;
      if (this.widgetFilterData) {
        this.obj[formData] = this.widgetFilterData;
      } else if (this.customFilter && this.inputParams.filterFormDataObj && Object.keys(this.inputParams.filterFormDataObj).length > 0) {
        this.obj[formData] = this.inputParams.filterFormDataObj;
      }
        this.filterDialogRef = this.dialogService.open(FiltersectionComponent, {
          header: `${this.translateService.instant('applyFilter')}`,
          width: '65em',
          contentStyle: {
            'min-height': '12em',
            overflow: 'inherit'
          },
          styleClass: 'filterButton',
          style: { direction: this.dir },
          data: this.obj,
          showHeader: true,
          baseZIndex: 9999,
          autoZIndex: true,
          dismissableMask: false,
          closeOnEscape: true
        });
        this.filterDialogRef.onClose.subscribe((result: any) => {
          const cancel = 'cancel';
          if (dialogueStatus === cancel) {
          this.widgetFilterData = result;
          this.obj[formData] = undefined;
          this.showWidgetFilter = true;
          } else {
            this.widgetFilterData = result;
            this.obj[formData] = undefined;
            this.showWidgetFilter = true;
            this.componentService.lazy = undefined;
            this.handleApply(event, result);
          }
          this.getFormValue(null, true);
      });
  }

  clearFilterData(event: Event) {
    const formData = 'formData';
    this.formValuesBinding = null;
    this.showWidgetFilter = false;
    this.widgetFilterData = undefined;
    this.obj[formData] = undefined;
    this.formValues = [];
    this.handleApply(event);
  }

    doNothing(event: Event) {
      event.preventDefault();
      event.stopPropagation();
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    public getMetadata(xmlName: string, productCode: string, filterParams?: string) {
      this.resetFields();
      this.listService.getSavedFilterPreference(xmlName, productCode, this.inputParams.preferenceName)
      .subscribe(data => {
        if (data) {
          if (this.inputParams.activeTab) {
            this.displayInputSwitch = this.inputParams.activeTab.displayInputSwitch !== null ?
                                      this.inputParams.activeTab.displayInputSwitch : {};
              if(this.displayInputSwitch?.display){
              this.commonService.setFooterSticky(false);
            }
          }
          const filterPreference = this.commonService.getFilterPreference();
          if (this.commonService.isNonEmptyValue(data.body.preferenceValues)) {
            this.filterPreferenceData = JSON.parse(data.body.preferenceValues).preferenceData.filtervalues;
            this.columnPreferenceData = JSON.parse(data.body.preferenceValues).preferenceData.columns;
            this.inputParams.preferenceData = JSON.parse(data.body.preferenceValues).preferenceData;
            this.filterDataArray = Object.entries(this.filterPreferenceData);
            this.commonService.filterDataAvailable = true;
            this.commonService.filterPreferenceData = this.filterPreferenceData;
          } else if (this.commonService.isnonEMptyString(filterPreference)) {
            this.filterPreferenceData = filterPreference;
            this.commonService.filterDataAvailable = true;
            this.commonService.filterPreferenceData = this.filterPreferenceData;
          } else {
            this.inputParams.preferenceData = undefined;
          }
          this.displayableJson = this.formService.getFields(data.body.MetaDataResponse, productCode);
          // this.commonService.filterInputVal = this.displayableJson;
          if (this.commonService.isNonEmptyValue(data.body.preferenceName)) {
            this.selectedPreference = data.body.preferenceName;
          }
          this.inputParams.preferenceName = this.selectedPreference;
          if (this.commonService.isNonEmptyValue(data.body.preferenceList)) {
            this.preferenceArray = data.body.preferenceList;
          }
          this.setShowFilterSection();
          if (this.commonService.isNonEmptyValue(data.body.MetaDataResponse)) {
            this.setDefaultProperties(data.body.MetaDataResponse);
            this.getColumns(data.body.MetaDataResponse, xmlName);
            this.getcheckboxPermission(data.body.MetaDataResponse);
          }
          return data;
        }
      });
    }

    setDefaultProperties(metadata: any) {
      if (metadata.ListDefDefaultProperties.length) {
        this.defaultSortOrder = metadata.ListDefDefaultProperties[0].default_order_type === 'd' ? -1 : 1;
        this.defaultSortField = metadata.ListDefDefaultProperties[0].default_order;
        this.datakey = metadata.ListDefDefaultProperties[0].dataKey;
        this.defaultRow = metadata.ListDefDefaultProperties[0].page;
        this.defaultFilter = metadata.ListDefDefaultProperties[0].defaultFilter;
        this.drilldownEnabled = metadata.ListDefDefaultProperties[0].drilldownEnabled;
        this.childListdef = metadata.ListDefDefaultProperties[0].childListdef;
        this.componentService.frozenColMaxLimit = metadata.ListDefDefaultProperties[0].freezeColMaxLimit;
        this.enableFilterPopup = metadata.ListDefDefaultProperties[0].enableFilterPopup;
        if (this.widgetFilter || this.customFilter || this.enableFilterPopup) {
          this.formModelService.getSubSectionModelAPI().subscribe(model => {
             this.dialogmodel = model[FccGlobalConstant.FILTER_DIALOG_MODEL];
            });
        }
      }
    }

    getColumns(data: any, xmlName: string) {
      this.defaultRow = this.defaultRow || FccGlobalConstant.LENGTH_10;
      if (data.Column) {
        const tempCols = [];
        const expandTempCols = [];
        data.Column.forEach(element => {
          if (!element.hidden) {
            tempCols.push({
            field: element.name,
            index: element.index,
            header: this.getHeader(element),
            align: element.align,
            hidden: element.hidden,
            width: element.width,
            columnFilterType: element.columnFilterType,
            isColumnSortDisabled: element.isColumnSortDisabled ? element.isColumnSortDisabled : false,
            showInThreeDotsOnly: element.showInThreeDotsOnly ? element.showInThreeDotsOnly : false,
            showAbbvAmt: element.showAbbvAmt,
            showAsDefault: element.showAsDefault,
            frozen: element.frozen,
            maskable: element.maskable,
            localizationkey: element.localizationkey,
            isCodeField: element.isCodeField,
            codeId: element.codeId,
            isClubbed: element.isClubbed,
            showDisplayValue: element.showDisplayValue,
            groupedValues: element.groupedValues,
            isClubbedField : element.isClubbedField,
            clubbedFieldsList : element.clubbedFieldsList,
            separator : element.separator,
            groupBy: element.groupBy,
            sortBy: element.sortBy,
            colorCode: element.colorCode,
            remarkApplicabilityList: element.remarkApplicabilityList,
            remarkValueColumn: element.remarkValueColumn,
            showFavIcon: element.showFavIcon,
            orderType : this.getSortingOrder(element.orderType)
          });
        } else {
          expandTempCols.push({
          field: element.name,
          index: element.index,
          header: this.translateService.instant(element.name).toUpperCase(),
          align: element.align
          });
        }
          if (element.passBack) {
          this.passbackField = element.name;
          }
      });
        this.loading = true;
        this.cols = tempCols;
        this.expandRowCols = expandTempCols;
        if (tempCols && !this.isRecordsFetched) {
          this.updateListdefData = true;
          if(this.inputParams.paginatorParams &&
            this.commonService.isNonEmptyValue(this.inputParams.paginatorParams)){
            const params = this.inputParams.paginatorParams;
            this.fetchRecords(xmlName, params, '', this.enableMasking);
          }else {
            this.fetchRecords(xmlName, '', '', this.enableMasking);
          }
        }
      }
    }
    getSortingOrder(orderType){
      return orderType ? (orderType === 'a' ? 'asc' : 'desc') : '';
    }
    getHeader(element) {
      const baseCurrency = this.equivalentCurrency ? this.equivalentCurrency : this.commonService.getBaseCurrency();
      if (element.localizationkey) {
        if ((this.showColumnsWithCurrency.indexOf(element.localizationkey) > -1) && baseCurrency) {
          return this.translateService.instant(element.localizationkey) + ' (' + baseCurrency + ')';
        } else {
          return this.translateService.instant(element.localizationkey);
        }
      } else {
          return '';
      }
    }

    retainFilterValForViewMore(eventFilterValue: any, filterDataParam?: any){
      if (eventFilterValue) {
        const filterParams = eventFilterValue;
        if (filterParams.favourite === 'all') {
          filterParams.favourite = '';
        }
        const transformedParameters = {};
        Object.keys(filterParams).forEach(element => {
          if (filterParams[element] instanceof Array) {
            const pipedValue = filterParams[element].toString().replaceAll(',', '|');
            transformedParameters[filterDataParam.controls[element][FccGlobalConstant.PARAMS].srcElementId] = pipedValue;
          } else {
            transformedParameters[filterDataParam.controls[element][FccGlobalConstant.PARAMS].srcElementId] = filterParams[element];
          }
        });
        this.inputParams.retainFilterValues = transformedParameters;
      }
    }

    fetchRecords(xmlName, paginatorParams, exportType, enableMasking: boolean, filterDataParam?: any) {
      if (!enableMasking || enableMasking === null || enableMasking === undefined) {
        enableMasking = false;
      }
      if (this.commonService.isNonEmptyValue(this.formValuesBinding)
        && this.commonService.isnonEMptyString(this.formValuesBinding.exportFileName)) {
        this.componentService.fileName = this.formValuesBinding.exportFileName;
      } else if (this.commonService.isNonEmptyValue(this.inputParams.exportFileName)) {
        this.componentService.fileName = this.inputParams.exportFileName;
      }
      if (paginatorParams === '') {
        paginatorParams = { first: 0, rows: this.defaultRow, sortOrder: this.sortOrder, filters: {}, globalFilter: null };
      }
      if (this.commonService.defaultLicenseFilter || this.commonService.backTobackExpDateFilter ||
        (this.inputParams && (this.inputParams.defaultFilterCriteria || this.inputParams.defaultLicenseFilter))) {
          this.isFilterValuesRequired = true;
      }
      this.filterParams = undefined;
      if (this.commonService.isNonEmptyValue(this.filterPreferenceData) && this.commonService.filterDataAvailable 
      && Object.keys(this.filterPreferenceData).length !== FccGlobalConstant.LENGTH_0) {
        this.filterParams = JSON.stringify(this.filterPreferenceData);
      } else {
        this.filterParams = this.isFilterValuesRequired ? this.transformFilterParams(filterDataParam) : '';
      }
      if (this.savePreference) {
        this.saveFilterPreferenceData(xmlName, this.filterParams);
      } else if (this.modifySavedPreference) {
        this.modifyFilterPreferenceData(xmlName, this.filterParams);
      } else {
        const dashboardTypekey = 'dashboardType';
        const enableListDataDownloadKey = 'enableListDataDownload';
        const sortOrder = 'sortorder';
        const sortField = 'sortfield';
        const sortValue = 'sortValue';
        const sortColumn = 'sortColumn';
        if (this.inputParams && (this.filterParams === FccGlobalConstant.EMPTY_STRING ||
          this.filterParams === undefined || this.filterParams === null)) {
            const dashboardType = {};
            if (this.commonService.isnonEMptyString(this.inputParams.dashboardTypeValue)) {
              dashboardType[dashboardTypekey] = this.inputParams.dashboardTypeValue;
            } else if (this.commonService.isnonEMptyString(this.inputParams.dashboardType)) {
              dashboardType[dashboardTypekey] = this.inputParams.dashboardType;
            }
            if (this.inputParams && this.commonService.isNonEmptyValue(this.inputParams.accountType) &&
              this.inputParams.accountType !== FccGlobalConstant.EMPTY_STRING && this.inputParams.accountType instanceof Array) {
              let stringValue = '';
              this.inputParams.accountType.forEach(element => {
                const trimmedValue: string = element;
                stringValue = stringValue + trimmedValue.trim() + '|';
              });
              stringValue = stringValue.substring(0, stringValue.length - 1);
              dashboardType[FccGlobalConstant.ACCOUNT_TYPE] = stringValue;
            } else {
              if (this.commonService.isNonEmptyValue(this.inputParams.accountType) &&
                this.inputParams.accountType !== FccGlobalConstant.EMPTY_STRING) {
                dashboardType[FccGlobalConstant.ACCOUNT_TYPE] = this.inputParams.accountType;
              }
            }
            if (this.inputParams && this.commonService.isNonEmptyValue(this.inputParams.periodConfig) &&
              this.inputParams.periodConfig !== FccGlobalConstant.EMPTY_STRING) {
              dashboardType[FccGlobalConstant.TIMEFRAME] = this.inputParams.periodConfig;
            }
            if (this.inputParams.baseCurrency) {
              dashboardType[FccGlobalConstant.BASE_CURRENCY_APPLICABILITY] = this.inputParams.baseCurrency;
            }
            if (this.inputParams.accountCcy) {
              dashboardType[FccGlobalConstant.ACCOUNT_CURRENCY] = this.inputParams.accountCcy;
            }
            this.setOtherDashboardTypes(dashboardType);
            if (this.inputParams) {
              if (this.commonService.isnonEMptyString(this.inputParams.groupId)) {
                dashboardType[FccGlobalConstant.GROUP_ID] = this.inputParams.groupId;
              }
              if (this.commonService.isnonEMptyString(this.inputParams.amountColumnValue)) {
                dashboardType[FccGlobalConstant.AMOUNT_COLUMN_VALUE] = this.inputParams.amountColumnValue;
              }
              if (this.commonService.isnonEMptyString(this.inputParams.postDate)) {
                dashboardType[FccGlobalConstant.POST_DATE] = this.inputParams.postDate;
              }
              if (this.commonService.isnonEMptyString(this.inputParams.activeFlag)) {
                dashboardType[FccGlobalConstant.ACTIVE_FLAG] = this.inputParams.activeFlag;
              }
              if (this.commonService.isnonEMptyString(this.inputParams.enableListDataDownload)
                && this.inputParams.enableListDataDownload) {
                dashboardType[enableListDataDownloadKey] = this.inputParams.enableListDataDownload;
              }
              if (this.inputParams?.isDashboardWidget 
                && FccConstants.VIEW_INFO_POPUP_PAYMENT_WIDGET_LIST.indexOf(this.inputParams?.listdefName) > -1) {
                dashboardType[sortOrder] = '2';
                dashboardType[sortField] = 'initiationDate';
              }
            }
            if (this.inputParams.tabName === 'TOP_BENEFICIARIES' || this.inputParams.tabName === 'FAVORITE_BENEFICIARIES'){
              dashboardType[sortColumn]='topFetch';
              dashboardType[sortValue]='count';
            }
            this.filterParams = JSON.stringify(dashboardType);
        } else {
          const filterparamarray = JSON.parse(this.filterParams);
          if (this.commonService.isnonEMptyString(this.inputParams.dashboardTypeValue)) {
            filterparamarray[dashboardTypekey] = this.inputParams.dashboardTypeValue;
          } else if (this.commonService.isnonEMptyString(this.inputParams.dashboardType)) {
            filterparamarray[dashboardTypekey] = this.inputParams.dashboardType;
          }
          if (this.commonService.isnonEMptyString(this.inputParams.enableListDataDownload)
            && this.inputParams.enableListDataDownload) {
              filterparamarray[enableListDataDownloadKey] = this.inputParams.enableListDataDownload;
          }
          if (this.inputParams?.isDashboardWidget 
            && FccConstants.VIEW_INFO_POPUP_PAYMENT_WIDGET_LIST.indexOf(this.inputParams?.listdefName) > -1) {
            filterparamarray[sortOrder] = '2';
            filterparamarray[sortField] = 'initiationDate';
          }
          if (this.commonService.isnonEMptyString(this.inputParams.beneBankCodeOption)) {
            filterparamarray[FccGlobalConstant.OPTION] = this.inputParams.beneBankCodeOption;
          }
          if (this.inputParams && this.commonService.isNonEmptyValue(this.inputParams.filterParams)) {
            
            const filterParamsValue = typeof this.inputParams.filterParams !== 'object' ? JSON.parse(this.inputParams.filterParams) : '';
            if (this.commonService.isnonEMptyString(this.inputParams.filterParams.paymentReferenceNumber)){
              filterparamarray[FccGlobalConstant.PAYMENT_REFERENCE_NUMBER] = this.inputParams.filterParams.paymentReferenceNumber;
            }
            Object.keys(filterParamsValue).forEach(filter => {
              if (filter === FccConstants.FCM_PAYMENT_PAYMENT_TYPE) {
                filterparamarray[FccConstants.FCM_PAYMENT_PAYMENT_TYPE] = filterParamsValue[filter];
            }
            });
          }
          this.filterParams = JSON.stringify(filterparamarray);
        }
        if (this.inputParams.filterParamsRequired && this.inputParams.filterParams !== '' &&
          this.inputParams.filterParams !== undefined) {
            const getCircularReplacer = () => {
              const seen = new WeakSet();
              return (key, value) => {
                if (typeof value === 'object' && value !== null) {
                  if (seen.has(value)) {
                    return;
                  }
                  seen.add(value);
                }
                return value;
              };
            };
            JSON.stringify(this.inputParams.filterParams, getCircularReplacer());
          //  filterParams = JSON.stringify(this.inputParams.filterParams);
        }
        if (this.commonService.isnonEMptyString(this.isFilterValuesRequired) && this.isFilterValuesRequired === true &&
        this.commonService.isnonEMptyString(this.filterParams)) {
          this.commonService.listDataFilterParams = this.filterParams;
        }

        if (this.inputParams.filterNoEntity !== undefined &&
          this.inputParams.filterNoEntity !== '' &&
          this.inputParams.filterNoEntity !== null &&
          this.inputParams.filterNoEntity === 'true') {
            const filterNoEntity = 'filterNoEntity';
            const filterParamsObj = JSON.parse(this.filterParams);
            filterParamsObj[filterNoEntity] = this.inputParams.filterNoEntity;
            this.filterParams = JSON.stringify(filterParamsObj);
        }

        this.filterParameters = JSON.parse(this.filterParams);
        this.listService.getTableData(xmlName, this.filterParams , JSON.stringify(paginatorParams), enableMasking)
          .subscribe(result => {
            this.showSpinner = false;
            if (this.updateListdefData) {
              this.selectedAccounts.emit(result);
              this.setTableData(result, exportType);
            } else {
              this.inputParams = JSON.parse(JSON.stringify(this.inputParams));
            }
            this.tabCountCheck.emit(result);
        });
        if (this.inputParams && this.inputParams.displayTotalBalance === true) {
          this.accountsSummaryService.getAccountDetailsSummary(xmlName, FccGlobalConstant.EMPTY_STRING,
            this.filterParams).then(response => {
              if (response && response.accountTypeList) {
                const accountSummary = response.accountTypeList;
                accountSummary.forEach((data: any) => {
                data.accountType.forEach((accountType: any) => {
                  this.setTotalAmtBalance(accountType.totalAccountTypeBalance);
                });
              });
            }
          });
        }
      }
  }

  setTotalAmtBalance(totalBal: any) {
    this.viewInCurrency = this.filterParameters && this.filterParameters[FccGlobalConstant.ACCOUNT_CURRENCY] ?
    this.filterParameters[FccGlobalConstant.ACCOUNT_CURRENCY] : this.commonService.getBaseCurrency();
    this.displayTotalAmtBal = totalBal;
  }

  setOtherDashboardTypes(dashboardType: any) {
    let filterParamDetails;
    if (this.commonService.isNonEmptyValue(this.inputParams.filterParams)){
       filterParamDetails = this.inputParams.filterParams;
    }else if (this.commonService.isNonEmptyValue(this.inputParams.retainFilterValues)){
       filterParamDetails = this.inputParams.retainFilterValues;
    }
    if (filterParamDetails && ((Object.keys(filterParamDetails).length) > 0)) {
      for (const [key, value] of Object.entries(filterParamDetails)) {
        dashboardType[key] = value;
      }
    }
  }

  saveFilterPreferenceData(xmlName: any, filterParams: any) {
    let columns = [];
    if (this.columnPreferenceData !== undefined && this.columnPreferenceData.length > 0){
      columns = this.columnPreferenceData;
    } else {
      columns = this.listService.preferenceData?.columns !== undefined ?
        JSON.parse(JSON.stringify(this.listService.preferenceData?.columns)) : [];
    }
    if (columns && columns.length) {
      columns.forEach(pref => {
        pref.header = encodeURIComponent(pref.header);
      });
    }
    const filterValue = filterParams ? JSON.parse(filterParams) : '';
    this.filterPreferenceValues = { filtervalues: filterValue, columns };
    this.inputParams.productCode = this.commonService.isnonEMptyString(this.inputParams.productCode) ? this.inputParams.productCode : '';
    this.listService.saveFilterDataPreference(xmlName, this.inputParams.preferenceName, this.filterPreferenceValues,
      this.inputParams.productCode, this.inputParams.subProductCode, this.inputParams.defaultPreference).subscribe(result => {
        if (result) {
          let message;
          if (this.commonService.isnonEMptyString(result.body.errorMessage)) {
            message = result.body.errorMessage;
            this.updateListdefData = false;
          } else if (this.commonService.isnonEMptyString(result.body.successMessage)) {
            message = result.body.successMessage;
            this.updateListdefData = true;
          }
          if (this.updateListdefData)
          {this.preferenceArray.push(result.body.preferenceName);
           this.selectedPreference = result.body.preferenceName; }
          const tosterObj = {
            life : 5000,
            key: 'tc',
            severity: 'success',
            detail: `${this.translate.instant(message)}`
          };
          this.messageService.add(tosterObj);
          this.refreshList.emit();
          setTimeout(() => {
            //eslint : no-empty-function
          }, FccGlobalConstant.LENGTH_2000);
        }
      }, error => {
          const tosterObj = {
            life : 5000,
            key: 'tc',
            severity: 'error',
            detail: `${this.translate.instant(error.error.causes[0].title)}`
          };
          this.messageService.add(tosterObj);
          this.refreshList.emit();
          setTimeout(() => {
            //eslint : no-empty-function
          }, FccGlobalConstant.LENGTH_2000);
      });
    this.savePreference = false;
  }

  modifyFilterPreferenceData(xmlName: any, filterParams: any) {
    const preferenceData = JSON.parse(filterParams);
    this.filterPreferenceValues = { filtervalues: preferenceData, columns: this.columnPreferenceData };
    this.listService.modifyFilterDataPreference(xmlName, this.inputParams.productCode, this.inputParams.preferenceName,
      this.filterPreferenceValues, this.inputParams.subProductCode).subscribe(result => {
        if (result) {
          const tosterObj = {
            life : 5000,
            key: 'tc',
            severity: 'success',
            detail: `${this.translate.instant(result.body.successMessage)}`
          };
          this.messageService.add(tosterObj);
          this.refreshList.emit();
          setTimeout(() => {
            //eslint : no-empty-function
          }, FccGlobalConstant.LENGTH_2000);
        }
      });
    this.modifySavedPreference = false;
  }

  convertAmountByPipeOrCustom(amount, currencyCode) {
    let convertedAmount;
    if (amount && currencyCode) {
      convertedAmount = this.convertAmountByPipe(amount, currencyCode);
    } else if (amount) {
      convertedAmount = this.convertAmountByCustom(amount);
    }
    return convertedAmount;
  }

  convertAmountByPipe(amount, currencyCode) {
    const convertedAmountByPipe = this.currencyConverterPipe.transform(amount, currencyCode);
    return convertedAmountByPipe;
  }

  convertAmountByCustom(amount) {
    const amountSplits = amount.split('.');
    let realPart = amount;
    let decimalPart = '00';
    let convertedAmountByCustom = realPart;
    if (amountSplits.length === 2) {
      realPart = amountSplits[0];
      decimalPart = amountSplits[1].substr(0, 2);
      convertedAmountByCustom = realPart + '.' + decimalPart;
    }
    return convertedAmountByCustom;
  }

  setTableData(tableresponse, exportType) {
    const presentColums = [];
    for (const i of this.cols) {
      presentColums.push(i.field);
    }
    const passbackParameters = 'passbackParameters';
    const tnxCcy = this.inputParams[FccGlobalConstant.CURRENCY];
    const amt = 'amt';
    const curCode = 'cur_code';
    const tnxAmt = 'tnx_amt';
    const liabAmt = 'liab_amt';
    const lnAmt = 'ln_amt';
    const colorCode = 'colorCode_';
    const sum = 'controlSum';
    const ccy = 'debtorAccount@currency';
    const matAmount = 'maturity_amount';
    const prinAmount = 'principal_amount';
    const instructedAmt = 'instructedAmountCurrencyOfTransfer2@amount';
    const instructedAmtCurr = 'creditorDetails@account@currency';
    const balAmt = 'RunningStatement@AvailableBalance@amt';
    const baseCurrency = this.equivalentCurrency ? this.equivalentCurrency : this.commonService.getBaseCurrency();
    const convertedPrincipalAmount = 'convertedPrincipal_amount';
    const reqAmt = 'req_amt';
    const reqCurCode = 'req_cur_code';
    const convertedAmount = 'RunningStatement@AvailableBalance@convertedAmt';
    const convertedMaturityAmount= 'convertedMaturity_amount';

    localStorage.setItem(FccGlobalConstant.CUR_SYMBOL_ENABLED, this.currencySymbolDisplayEnabled ? 'y' : 'n');
    if (tableresponse.defaultDaysCount) {
    this.defaultDaysCount = tableresponse.defaultDaysCount;
    }
    this.tempTableData = tableresponse.rowDetails;
    if (this.tempTableData) {
      this.tabledata = [];
      this.numRows = tableresponse.count;

      this.tempTableData.forEach(element => {
        const obj = {};
        let amount;
        let currencyCode;
        let amountField;
        let originalGroupedVal = '';
        const originalGroupValMap = new Map();
        element.index.forEach(ele => {
          if (ele.colorCode) {
            obj[colorCode + ele.name] = ele.colorCode;
          }
          if (amt === ele.name || tnxAmt === ele.name || ele.name === 'ft_amt' || ele.name === 'totalAmount') {
            amountField = ele.name;
            amount = ele.value;
          }
          if (curCode === ele.name || ele.name === 'ft_cur_code' || ele.name === 'ccy') {
            currencyCode = ele.value;
          }
          if (this.passbackField === ele.name) {
            const fieldValue = JSON.parse(ele.value);
            if (!this.commonService.defaultLicenseFilter && this.inputParams && !this.inputParams.defaultLicenseFilter) {
              this.selectMode = 'single';
            }
            obj[ele.name] = fieldValue.displayedFieldValue;
            obj[passbackParameters] = fieldValue.fieldValuePassbackParameters;
          } else if (ele.name === 'action') {
            const actionArray = ele.value.split(',');
            const actionsList = [];
            for (let i = 0 ; i < actionArray.length; i++) {
              if (actionArray[i] !== 'Action') {
                actionsList.push(actionArray[i]);
              }
            }
            obj[ele.name] = actionsList.toString();
          }else {
            // const valueMap = { value: this.commonService.decodeHtml(ele.value),
            //   displayValue : this.commonService.decodeHtml(ele.displayValue) };

            if (this.cols.length && presentColums.indexOf(ele.name) > -1) {
              const isGroupedVal = this.commonService.isNonEmptyValue(ele.groupedValues) ? true : false;
              let valueToCheck = (this.commonService.isNonEmptyValue(ele.displayValue) &&
              this.commonService.isNonEmptyValue(ele.showdisplayValue)) ? ele.displayValue : ele.value;
              valueToCheck = isGroupedVal ?
                            this.commonService.formatGroupedColumns(FccGlobalConstant.EMPTY_STRING, ele.groupedValues) :
                            valueToCheck;
              if (ele.name === FccGlobalConstant.subProductCode ) {
                obj[ele.name] = this.commonService.decodeHtml(valueToCheck);
              } else if (obj[ele.name] === FccGlobalConstant.subProductCode ) {
                obj[ele.name] = this.commonService.decodeHtml(valueToCheck);
              } else {
                obj[ele.name] = this.commonService.isEmptyValue(valueToCheck) ?
                `${this.translate.instant(FccGlobalConstant.SAMPLE_COMMENT)}` :
                this.commonService.decodeHtml(valueToCheck);
              }


              // Store the original grouped values in separate object key for use in
              if (isGroupedVal){
                originalGroupedVal += ele.groupedValues;
                originalGroupValMap.set(obj[ele.name], ele.groupedValues);
              }
            } else {
              obj[ele.name] = this.commonService.decodeHtml(ele.value);
            }
          }
        });
        if (originalGroupedVal.length > 0){
          obj[FccGlobalConstant.ORIG_GROUPED_VAL] = originalGroupedVal;
        }
        if (originalGroupValMap.size > 0){
          obj[FccGlobalConstant.ORIG_GROUPED_VAL_MAP] = originalGroupValMap;
        }

        if (this.commonService.isNonEmptyValue(currencyCode) && this.commonService.isNonEmptyValue(amount)) {
          obj[amountField] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
            currencyCode, amount, localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[amountField];
          obj[amountField === amt ? tnxAmt : amt] = obj[amountField];
          obj[amountField === 'ft_amt' ? tnxAmt : 'ft_amt'] = obj[amountField];
        }
        // This statement is to make auto select first radio button in table based on conditions
        if (this.inputParams && this.inputParams.selectedRow && tableresponse.count > 0 &&
          (this.firstRowSelected.length > 0) ) {
          this.firstRowSelected.push(obj);
          const eventObj = { data: {} };
          eventObj.data = obj;
          this.rowSelectEventListdef.emit(eventObj); // Emitting the object with data
        }

        if (this.isParamValid(tnxCcy) && this.isParamValid(obj[FccGlobalConstant.ALLOW_MULTI_CUR]) &&
              this.isParamValid(obj[FccGlobalConstant.LICENSE_PRODUCT_CODE])) {
          this.checkLicenseDetails(this.tabledata, obj, tnxCcy);
        } else {
          if (this.commonService.isNonEmptyValue(obj[sum]) && this.commonService.isNonEmptyValue(obj[ccy])) {
            obj[sum] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[ccy] !== '' ? obj[ccy] : 'INR', obj[sum], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[sum];
          }
          if (this.commonService.isNonEmptyValue(obj[reqAmt]) && this.commonService.isNonEmptyValue(obj[reqCurCode])) {
            obj[reqAmt] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[reqCurCode] !== '' ? obj[reqCurCode] : 'INR',
              obj[reqAmt], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[reqAmt];
          }
          if (this.commonService.isNonEmptyValue(obj[tnxAmt]) && this.commonService.isNonEmptyValue(obj[reqCurCode])) {
            obj[tnxAmt] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[reqCurCode] !== '' ? obj[reqCurCode] : 'INR',
              obj[tnxAmt], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[tnxAmt];
          }
          if (this.commonService.isNonEmptyValue(obj[curCode]) && this.commonService.isNonEmptyValue(obj[prinAmount]) &&
          obj[prinAmount] !== '-') {
            obj[prinAmount] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[curCode], obj[prinAmount], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[prinAmount];
          }
          if (this.commonService.isNonEmptyValue(obj[instructedAmtCurr]) && this.commonService.isNonEmptyValue(obj[instructedAmt]) &&
          obj[instructedAmt] !== '-') {
            obj[instructedAmt] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[instructedAmtCurr], obj[instructedAmt], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[instructedAmt];
          }
          if (this.commonService.isNonEmptyValue(obj[curCode]) && this.commonService.isNonEmptyValue(obj[matAmount]) &&
          obj[matAmount] !== '-') {
            obj[matAmount] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[curCode], obj[matAmount], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[matAmount];
          }
          if (this.commonService.isNonEmptyValue(obj[curCode]) && this.commonService.isNonEmptyValue(obj[liabAmt]) &&
          obj[liabAmt] !== '-') {
            obj[liabAmt] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[curCode], obj[liabAmt], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[liabAmt];
          }
          if (this.commonService.isNonEmptyValue(obj[curCode]) && this.commonService.isNonEmptyValue(obj[lnAmt]) &&
          obj[lnAmt] !== '-') {
            obj[lnAmt] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[curCode], obj[lnAmt], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[lnAmt];
          }
          if (this.commonService.isNonEmptyValue(obj[curCode]) && this.commonService.isNonEmptyValue(obj[balAmt]) &&
          obj[balAmt] !== '-') {
            obj[balAmt] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              obj[curCode], obj[balAmt], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[balAmt];
          }
          if (this.commonService.isNonEmptyValue(baseCurrency) && this.commonService.isNonEmptyValue(obj[convertedPrincipalAmount]) &&
          obj[convertedPrincipalAmount] !== '-') {
            obj[convertedPrincipalAmount] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              baseCurrency, obj[convertedPrincipalAmount], localStorage.getItem(FccGlobalConstant.LANGUAGE)) :
              obj[convertedPrincipalAmount];
          }
          if (this.commonService.isNonEmptyValue(baseCurrency) && this.commonService.isNonEmptyValue(obj[convertedAmount]) &&
          obj[convertedAmount] !== '-') {
            obj[convertedAmount] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              baseCurrency, obj[convertedAmount], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[convertedAmount];
          }
          if (this.commonService.isNonEmptyValue(baseCurrency) && this.commonService.isNonEmptyValue(obj[convertedMaturityAmount]) &&
          obj[convertedMaturityAmount] !== '-') {
            obj[convertedMaturityAmount] = this.currencySymbolDisplayEnabled ? this.commonService.getCurrencySymbolForListdef(
              baseCurrency, obj[convertedMaturityAmount], localStorage.getItem(FccGlobalConstant.LANGUAGE)) : obj[convertedMaturityAmount];
          }
          this.tabledata.push(obj);
        }
      });
      this.finalData = this.tabledata;
      this.setColumnHeaders();
      this.exportValues(exportType);
}
  }


  setColumnHeaders() {
    if (this.cols && this.commonService.isnonEMptyString(this.inputParams) &&
    this.commonService.isnonEMptyString(this.inputParams.displayTotalBalance) &&
    this.inputParams.displayTotalBalance === true) {
      this.cols.forEach(column => {
        column.header = this.getHeader(column);
      });
    }
  }
  updateColumns(event){
    this.cols = event;
  }
  exportValues(exportType) {
    if (exportType !== '') {
      this.addExportValuesToTableComponent(this.finalData, this.cols, exportType);
      this.table.exportDataBasedOnType(exportType);
    } else {
      if (this.rowCheckBoxEvent && this.rowCheckBoxEvent.selected) {
        this.firstRowSelected.push(this.rowCheckBoxEvent.data);
      }
      this.addValuesToTableComponent();
    }
  }
    resetFields() {
      this.inputParams.metadata = undefined;
      this.displayableJson = undefined;
    }

    getFormValue($event: Event, showContent: boolean, filterDataParam?: any) {
      this.isaccordionOpen = !showContent;
      this.toggleAdvancedFilter();
      this.formValues = [];
      let bindingValues;
      let resultArray;
      if (filterDataParam || this.widgetFilterData) {
        bindingValues = this.commonService.isNonEmptyValue(filterDataParam) ? filterDataParam : this.widgetFilterData;
        if (this.commonService.isNonEmptyValue(filterDataParam) && this.commonService.isNonEmptyValue(filterDataParam.value)) {
          resultArray = Object.keys(filterDataParam.value);
        } else {
          resultArray = Object.keys(this.widgetFilterData.value);
        }
      } else {
        bindingValues = this.commonService.isNonEmptyValue(this.formValuesBinding) ? this.formValuesBinding.form : undefined;
        if (this.commonService.isNonEmptyValue(bindingValues)) {
          resultArray = Object.keys(this.formValuesBinding.form.value);
        }
      }
      if (showContent && resultArray) {
        resultArray.forEach(subele => {
          const element = bindingValues.controls[subele];
          if (element instanceof MultiSelectFormControl && element.value instanceof Array && element.value.length > 0) {
            this.getMultiSelectFormControlFormValues(element, subele, bindingValues);
          } else if (element instanceof InputDateControl && element.value instanceof Array && element.value.length > 0) {
            this.getInputDateControlFormValues(element, subele, bindingValues);
          } else if ((element.value !== '' && element.value !== null) && element.value.length > 0) {
            this.getDefaultFormValues(element, subele, bindingValues);
          }
        });
      }
      return this.formValues;
    }

  checkItemtoBeTranslated(value: any){
    if (this.API_ERROR_CODES.includes(value)){
      this.checkItemNottoBeTranslated = true;
      return false;
    } else {
      this.checkItemNottoBeTranslated = false;
      return true;
    }
  }

  getActualValue(element, codeId?: any) {
    codeId = codeId ? codeId + '_' : codeId;
    let actualValue = '';
    element.value.forEach(element => {
      actualValue = actualValue ? actualValue + ', ' + this.translateService.instant(codeId + element.trim())
      : this.translateService.instant(codeId + element.trim());
    });
    return actualValue;
  }

  getMultiSelectFormControlFormValues(element: any, subele: any, bindingValues?: any) {
    let elementValues = '';
    let actualValue = '';
    if (element.value.length > FccGlobalConstant.LENGTH_2) {
    if (subele === FccGlobalConstant.TNX_TYPE_CODE) {
      elementValues = this.translateService.instant('N002_' + element.value[0]) + ' , ' +
      this.translateService.instant('N002_' + element.value[1]) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
      + this.translateService.instant('more');
      actualValue = this.getActualValue(element, 'N002');
      } else if (subele === FccGlobalConstant.PROD_STATUS) {
        elementValues = this.translateService.instant('N005_' + element.value[0]) + ' , ' +
        this.translateService.instant('N005_' + element.value[1]) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        actualValue = this.getActualValue(element, 'N005');
      } else if (subele === FccGlobalConstant.TNX_TYPE_CODE_DROPDOWN) {
        elementValues = this.translateService.instant(element.value[0].trim()) + ' , ' +
        this.translateService.instant(element.value[1].trim()) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        actualValue = this.getActualValue(element);
      } else if (subele === FccGlobalConstant.PARAMETER1) {
        const element0 = element.value[0].trim().substring(0, 2);
        const element1 = element.value[1].trim().substring(0, 2);
        const value0 = this.translateService.instant(element0.trim());
        const value1 = this.translateService.instant(element1.trim());
        elementValues = value0 + ' , ' + value1
        + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant(FccGlobalConstant.MORE);
        actualValue = this.getActualValue(element);
      } else if (subele === FccGlobalConstant.SUB_PRODUCT_CODE) {
        elementValues = this.translateService.instant('N047_' + element.value[0].trim()) + ' , ' +
        this.translateService.instant('N047_' + element.value[1].trim()) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        actualValue = this.getActualValue(element, 'N047');
      } else if (subele === FccGlobalConstant.EVENT) {
        elementValues = this.translateService.instant('EVENT_' + element.value[0].trim()) + ' , ' +
        this.translateService.instant("EVENT_" + element.value[1].trim()) +
        " & " +
        (element.value.length - FccGlobalConstant.LENGTH_2) +
        " " +
        this.translateService.instant("more");
        actualValue = this.getActualValue(element, 'EVENT');
      } else if (subele === FccGlobalConstant.TRANSACTION_STAT_CODE) {
        elementValues = this.translateService.instant('N004_' + element.value[0].trim()) + ' , ' +
        this.translateService.instant('N004_' + element.value[1].trim()) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        actualValue = this.getActualValue(element, 'N004');
      } else if (subele === FccGlobalConstant.SUB_TRANSACTION_STAT_CODE) {
        elementValues = this.translateService.instant('N015_' + element.value[0].trim()) + ' , ' +
        this.translateService.instant('N015_' + element.value[1].trim()) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        actualValue = this.getActualValue(element, 'N015');
      } else if (subele === FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE) {
        elementValues = this.translateService.instant('N003_' + element.value[0].trim()) + ' , ' +
        this.translateService.instant('N003_' + element.value[1].trim()) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        actualValue = this.getActualValue(element, 'N003');
      } else if (subele === 'instrumentstatus') {
        elementValues = this.translateService.instant(element.value[0].trim()) + ' , ' +
        this.translateService.instant(element.value[1].trim()) + ' & ' + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        element.value.forEach(element => {
          actualValue = actualValue ? actualValue + ', ' + this.translateService.instant(element) : this.translateService.instant(element);
        });
      } else if (subele === FccGlobalConstant.PAYMENTSTATUS) {
        for (let i = 0; i < FccGlobalConstant.LENGTH_2; i++) {
          elementValues = elementValues + this.translateService.instant(element.value[i]) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3) + ' & '
        + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
        + this.translateService.instant('more');
        element.value.forEach(element => {
          actualValue = actualValue ? actualValue + ', ' + this.translateService.instant(element) : this.translateService.instant(element);
        });
      } else {
      for (let i = 0; i < FccGlobalConstant.LENGTH_2; i++) {
        elementValues = elementValues + element.value[i] + ' , ';
      }
      elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3) + ' & '
      + (element.value.length - FccGlobalConstant.LENGTH_2) + ' '
      + this.translateService.instant('more');
      element.value.forEach(element => {
        actualValue = actualValue ? actualValue + ', ' + element : element;
      });
      }
    } else {
      if (subele === FccGlobalConstant.TNX_TYPE_CODE) {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('N002_' + element.value[i]) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === FccGlobalConstant.PROD_STATUS) {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('N005_' + element.value[i]) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === 'ftType') {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('N029_' + element.value[i]) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === 'lcExpDateTypeCode') {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('C085_' + element.value[i]) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === 'productTypeCode') {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('C010_' + element.value[i]) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === 'tnxTypeCodeDropdown') {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant(element.value[i].trim()) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === FccGlobalConstant.PARAMETER1) {
        for (let i = 0; i < element.value.length; i++) {
            const eleValue = element.value[i].trim().substring(0, 2);
            elementValues = elementValues + this.translateService.instant(eleValue) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === FccGlobalConstant.SUB_PRODUCT_CODE) {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('N047_' + element.value[i].trim()) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === FccGlobalConstant.TRANSACTION_STAT_CODE) {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('N004_' + element.value[i].trim()) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === FccGlobalConstant.SUB_TRANSACTION_STAT_CODE) {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('N015_' + element.value[i].trim()) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE) {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('N003_' + element.value[i].trim()) + ' , ';
        }
        elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
      } else if (subele === FccGlobalConstant.EVENT) {
        for (let i = 0; i < element.value.length; i++) {
          elementValues = elementValues + this.translateService.instant('EVENT_' + element.value[i].trim()) + ' , ';
        }
      } else if (subele === 'instrumentstatus') {
        for (let i = 0; i < element.value.length; i++) {
          if (i < element.value.length -1){
            elementValues = elementValues + this.translateService.instant(element.value[i].trim()) + ' , ';
          } else {
            elementValues = elementValues + this.translateService.instant(element.value[i].trim());
          }
        }
      } else if (subele === FccGlobalConstant.PAYMENTSTATUS) {
        element.value.forEach(value => {
          elementValues = elementValues ? elementValues + ', ' + this.translateService.instant(value) : 
          this.translateService.instant(value);
        });
      } else {
        element.value.forEach(value => {
          elementValues = elementValues ? elementValues + ', ' + value : value;
        });
      }
      actualValue = elementValues;
    }
    this.formValues.push({
      name: this.translateService.instant(
        (bindingValues.controls[subele][FccGlobalConstant.PARAMS].srcElementId).toUpperCase()),
      value: elementValues,
      actualValue: actualValue,
      controlName: bindingValues.controls[subele][FccGlobalConstant.PARAMS].srcElementId
    });
  }

  getInputDateControlFormValues(element: any, subele: any, bindingValues?: any) {
    let elementValues = '';
    for (let i = 1; i <= element.value.length; i++) {
        if (element.value[i - 1] !== null) {
          elementValues = elementValues + this.utilityService.transformDateFormat(element.value[i - 1]) + ' - ';
        }
      }
    elementValues = elementValues.substring(0, elementValues.length - FccGlobalConstant.LENGTH_3);
    this.formValues.push({
        name: this.translateService.instant(
          (bindingValues.controls[subele][FccGlobalConstant.PARAMS].srcElementId).toUpperCase()),
        value: elementValues,
        controlName: bindingValues.controls[subele][FccGlobalConstant.PARAMS].srcElementId
      });
  }

  getDefaultFormValues(element: any, subele: any, bindingValues?: any) {
    let timeframeValue;
    if (element.key === FccGlobalConstant.TIMEFRAME) {
      for (const optionValue of element.options) {
        if (element.value === optionValue.value) {
          timeframeValue = optionValue.displayedValue;
        }
      }
    }
    this.formValues.push({
      name: this.translateService.instant(
        (bindingValues.controls[subele][FccGlobalConstant.PARAMS].srcElementId).toUpperCase()),
      value: timeframeValue ? timeframeValue : element.value,
      controlName: bindingValues.controls[subele][FccGlobalConstant.PARAMS].srcElementId
    });
  }

  getLazyEvent(event: Event) {
    this.updateListdefData = true;
    if (this.displayInputSwitch && this.displayInputSwitch.listdefName && this.displayInputSwitch.listdefName !== ''
            && this.displayInputSwitch.listdefName !== null && this.table.hideActionsShowCheckBox) {
        this.fetchRecords(this.displayInputSwitch.listdefName, event, '', this.enableMasking);
      } else {
        this.fetchRecords(this.inputParams.listdefName, event, '', this.enableMasking);
      }
  }

  getRowSelectEvent(event) {
    const filterParams = 'filterParams';
    if (this.displayInputSwitch && this.displayInputSwitch.display && event.fetchRecords) {
      this.rowCheckBoxEvent = event;
      this.filterCriteriaOnCheckBox = event[filterParams];
      this.isFilterValuesRequired = true;
      this.updateListdefData = true;
      if (this.displayInputSwitch.listdefName && this.displayInputSwitch.listdefName !== ''
            && this.displayInputSwitch.listdefName !== null) {
        this.fetchRecords(this.displayInputSwitch.listdefName, '', '', this.enableMasking);
      } else {
        this.fetchRecords(this.inputParams.listdefName, '', '', this.enableMasking);
      }
    }
    if (this.inputParams?.isDashboardWidget && (this.drilldownEnabled === 'true' || this.inputParams?.drillDownEnabled)) {
      this.isRecordsFetched = true;
      this.isFilterValuesRequired = true;
      const filterDataParam = {};
      filterDataParam[this.defaultFilter] = event.selectedRowsData[this.defaultFilter];
      this.commonService.paymentWidgetListdefFilter = event.selectedRowsData[this.defaultFilter];
      this.drilldownEnabled = 'false';
      if(this.inputParams.childTableConfig){
        if(this.inputParams.childTableConfig.isViewMore){
          this.parentWidgetConfig.isViewMore = this.inputParams.isViewMore;
          this.parentWidgetConfig.listdefName = this.inputParams.listdefName;
          this.inputParams.isViewMore = this.inputParams.childTableConfig.isViewMore;
          this.inputParams.listdefName = this.childListdef;
          filterDataParam[FccConstants.IS_CHILDGRID_HAS_VIEWMORE] = true;
          filterDataParam[FccConstants.IS_VIEWMORE_CLICKED] = false;
        }
      }
      this.filterDataParam = filterDataParam; 
      this.commonService.setIsChildList(true);
      this.commonService.setIsViewMore(false);
      if (this.commonService.isNonEmptyValue(this.childListdef)){
        this.fetchRecords(this.childListdef, '', '', this.enableMasking,filterDataParam);
      } else {
        this.fetchRecords(this.inputParams.drillDownTableConfig.listdefName, '', '', this.enableMasking,filterDataParam);
      }
    }
    this.rowSelectEventListdef.emit(event);
  }

  switchToParentWidget(){
    this.isParentList = true;
    this.commonService.setIsChildList(false);
    this.commonService.setIsViewMore(false);
    this.filterDataParam = {};
    if(this.parentWidgetConfig){
      if(this.parentWidgetConfig.isViewMore){
        this.inputParams.isViewMore = this.parentWidgetConfig.isViewMore;
        this.inputParams.listdefName = this.parentWidgetConfig.listdefName;
      }
    }
    this.getMetadata(this.inputParams.listdefName, this.inputParams.productCode, JSON.stringify({}));
    this.fetchRecords(this.inputParams.listdefName, '', '', this.enableMasking);
  }

  getRowUnSelectEvent(event) {
    if (this.displayInputSwitch && this.displayInputSwitch.display) {
      this.rowCheckBoxEvent = event;
      this.firstRowSelected = this.firstRowSelected.filter(entry => entry.ref_id !== event.data.ref_id);
      this.filterCriteriaOnCheckBox = {};
      if (event.fetchRecords) {
        this.isFilterValuesRequired = false;
        this.updateListdefData = true;
        if (this.displayInputSwitch.listdefName && this.displayInputSwitch.listdefName !== ''
            && this.displayInputSwitch.listdefName !== null) {
          this.fetchRecords(this.displayInputSwitch.listdefName, '', '', this.enableMasking);
        } else {
          this.fetchRecords(this.inputParams.listdefName, '', '', this.enableMasking);
        }
      }
    }
    this.rowUnSelectEventListdef.emit(event);
  }

  transformFilterParams(filterDataParam?: any) {
    let bindingValues;
    if (filterDataParam) {
      bindingValues = filterDataParam;
    } else {
      if (this.inputParamsList && (this.inputParamsList.length > 1 || this.commonService.multipleablesInaPage)) {
        bindingValues = this.commonService.bindingValue;
      } else {
        bindingValues = this.formValuesBinding ? this.formValuesBinding.form : undefined;
      }
    }
    const bindingFormValues = {};
    const params = 'params';
    const tnxTypeCodeParam = 'tnx_type_code_parameter';
    const subTnxTypeCodeParam = 'sub_tnx_type_code_parameter';
    if (this.inputParams) {
      if (this.inputParams && this.commonService.isNonEmptyValue(this.inputParams.accountType) &&
        this.inputParams.accountType !== FccGlobalConstant.EMPTY_STRING && this.inputParams.accountType instanceof Array) {
        let stringValue = '';
        this.inputParams.accountType.forEach(element => {
          const trimmedValue: string = element;
          stringValue = stringValue + trimmedValue.trim() + '|';
        });
        stringValue = stringValue.substring(0, stringValue.length - 1);
        bindingFormValues[FccGlobalConstant.ACCOUNT_TYPE] = stringValue;
      } else if (this.commonService.isnonEMptyString(this.inputParams.accountType)) {
        bindingFormValues[FccGlobalConstant.ACCOUNT_TYPE] = this.inputParams.accountType;
      }
      if (this.commonService.isnonEMptyString(this.inputParams.baseCurrency)) {
        bindingFormValues[FccGlobalConstant.BASE_CURRENCY_APPLICABILITY] = this.inputParams.baseCurrency;
      }
      if (this.commonService.isnonEMptyString(this.inputParams.accountCcy)) {
        bindingFormValues[FccGlobalConstant.ACCOUNT_CURRENCY] = this.inputParams.accountCcy;
      }
      if (this.commonService.isnonEMptyString(this.inputParams.periodConfig)) {
          bindingFormValues[FccGlobalConstant.TIMEFRAME] = this.inputParams.periodConfig;
      }
      if (this.commonService.isnonEMptyString(this.inputParams.parmid)) {
        bindingFormValues[FccConstants.PARAM_ID] = this.inputParams.parmid;
      }
      if (this.commonService.isnonEMptyString(this.inputParams.intermediateBankFlag)) {
        bindingFormValues[FccConstants.DATA_8] = this.inputParams.intermediateBankFlag;
      }
    }

    if (bindingValues && bindingValues.value) {
      const fields = Object.keys(bindingValues.value);
      fields.forEach(element => {
        const controlElement = bindingValues.controls[element];
        let stringValue = '';
        let tnxTypeCode = '';
        let subTnxTypeCode = '';
        const keyName = bindingValues.controls[element][params].srcElementId;
        if (controlElement instanceof MultiSelectFormControl && controlElement.value instanceof Array) {
            controlElement.value .forEach(value => {
              const trimmedValue: string = value;
              stringValue = stringValue + trimmedValue.trim() + '|';

              if (keyName === 'tnx_type_code_dropdown') {
                const tnxTypeCodeArray = trimmedValue.split(':');
                tnxTypeCode = tnxTypeCode + tnxTypeCodeArray[0].trim() + '|';
                if (tnxTypeCodeArray.length === 2) {
                  subTnxTypeCode = subTnxTypeCode + tnxTypeCodeArray[1] + '|';
                }
              }
            });

            stringValue = stringValue.substring(0, stringValue.length - 1);
            bindingFormValues[keyName] = stringValue;
            if (keyName === 'tnx_type_code_dropdown') {
              tnxTypeCode = tnxTypeCode.substring(0, tnxTypeCode.length - 1);
              subTnxTypeCode = subTnxTypeCode.substring(0, subTnxTypeCode.length - 1);
              bindingFormValues[tnxTypeCodeParam] = tnxTypeCode;
              bindingFormValues[subTnxTypeCodeParam] = subTnxTypeCode;
            }

        } else if (controlElement instanceof InputDateControl && controlElement.value instanceof Array) {
            for (let i = 1; i <= controlElement.value.length; i++) {
              if (i === 1) {
                bindingFormValues[keyName] = this.utilityService.transformDateFormat(controlElement.value[i - 1]);
              } else if (controlElement.value[i - 1] !== null && controlElement.value[i - 1] !== '' &&
                 controlElement.value[i - 1] !== undefined) {
                  bindingFormValues[keyName + i] = this.utilityService.transformDateFormat(controlElement.value[i - 1]);
                 }
            }
        } else if (keyName === FccGlobalConstant.PARAMETER1 && controlElement.value === '') {
          bindingFormValues[keyName] = FccGlobalConstant.PRODUCT_DEFAULT;
        } else if (keyName === FccGlobalConstant.PRODUCTCODE
          && keyName.value === undefined) {
          bindingFormValues[keyName] = this.inputParams.filterParams[FccGlobalConstant.PRODUCTCODE];
        } else if (keyName === FccGlobalConstant.CATEGORY && keyName.value === undefined) {
            bindingFormValues[keyName] = this.inputParams.filterParams[FccGlobalConstant.CATEGORY];
        } else if ( keyName === FccGlobalConstant.ACCOUNTTYPE && controlElement.value === '' && !this.commonService.allAccountType){
          bindingFormValues[keyName] = this.inputParams.accountType;
        } else if ( keyName === FccGlobalConstant.ACCOUNTTYPE && this.commonService.allAccountType) {
          bindingFormValues[keyName] = this.inputParams.accountType;
        } else if (keyName === FccGlobalConstant.FAVOURITE && controlElement.value !== ''
                   && controlElement.value !== FccGlobalConstant.ALL) {
          bindingFormValues[keyName] = controlElement.value;
        }else if (keyName === FccGlobalConstant.FAVOURITE && controlElement.value !== ''
                  && controlElement.value === FccGlobalConstant.ALL) {
          bindingFormValues[keyName] = '';
        }
        else {
          bindingFormValues[keyName] = controlElement.value;
        }
      });
      if (bindingFormValues && bindingFormValues[FccGlobalConstant.ACCOUNT_CURRENCY]) {
        this.equivalentCurrency = bindingFormValues[FccGlobalConstant.ACCOUNT_CURRENCY];
      }
      this.setFilterCriteriaOnCheckbox(bindingFormValues);
      this.setDefaultFilterCriteria(bindingFormValues);
      this.defaultLicenseFilters(bindingFormValues);
      return JSON.stringify(bindingFormValues);
    } else if (this.inputParams.defaultFilterCriteria) {
      this.setDefaultFilterCriteria(bindingFormValues);
      return JSON.stringify(bindingFormValues);
    } else if (this.inputParams && this.inputParams.defaultLicenseFilter) {
      this.defaultLicenseFilters(bindingFormValues);
      return JSON.stringify(bindingFormValues);
    } else if (this.commonService.defaultLicenseFilter) {
      this.checkProductAndSubProductCode(bindingFormValues);
      bindingFormValues[FccGlobalConstant.COUNTERPARTY_ABBV_NAME] = this.inputParams[FccGlobalConstant.CPTY_NAME];
      bindingFormValues[FccGlobalConstant.VALID_TO_DATE] = this.inputParams[FccGlobalConstant.EXPIRY_DATE_FIELD];
      bindingFormValues[FccGlobalConstant.ACCOUNT_CURRENCY] = this.inputParams[FccGlobalConstant.CURRENCY];
      bindingFormValues[FccGlobalConstant.BENE_NAME] = this.inputParams[FccGlobalConstant.BENEFICIARY_NAME];
      bindingFormValues[FccGlobalConstant.FIN_TYPE] = this.inputParams[FccGlobalConstant.FIN_TYPE];
      if ( this.inputParams[FccGlobalConstant.ENABLE_RADIO_BUTTON]) {
        bindingFormValues[FccGlobalConstant.ALLOW_MULTIPLE_LS] = 'Y';
        } else {
        bindingFormValues[FccGlobalConstant.ALLOW_MULTIPLE_LS] = 'N';
        this.commonService.licenseCheckBoxRequired = 'N';
      }
      return JSON.stringify(bindingFormValues);
    } else if (this.commonService.backTobackExpDateFilter) {
      bindingFormValues[FccGlobalConstant.CURRENT_DATE_VALUE] = this.inputParams[FccGlobalConstant.CURRENT_DATE];
      return JSON.stringify(bindingFormValues);
    } else if (bindingValues) {
      return JSON.stringify(bindingValues);
    } else {
      return '';
    }
  }
  setFilterCriteriaOnCheckbox(bindingFormValues: any) {
    if (this.filterCriteriaOnCheckBox) {
      Object.keys(this.filterCriteriaOnCheckBox).forEach(filter => {
        if (filter === FccGlobalConstant.REPRICING_DATE) {
          bindingFormValues[filter] = this.filterCriteriaOnCheckBox[filter];
          bindingFormValues[filter + '2'] = this.filterCriteriaOnCheckBox[filter];
        } else{
          bindingFormValues[filter] = this.filterCriteriaOnCheckBox[filter];
        }
      });
    }
  }

  protected checkProductAndSubProductCode(bindingFormValues: any) {
    if (this.inputParams[FccGlobalConstant.PRODUCT] !== '' &&
      this.commonService.isNonEmptyValue(this.inputParams[FccGlobalConstant.PRODUCT])) {
      bindingFormValues[FccGlobalConstant.PRODUCTCODE] = this.inputParams[FccGlobalConstant.PRODUCT];
    } else {
      const productCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.PRODUCT);
      bindingFormValues[FccGlobalConstant.PRODUCTCODE] = productCode;
    }
    if (this.inputParams[FccGlobalConstant.SUB_PRODUCT_CODE] !== '' &&
      this.commonService.isNonEmptyValue(this.inputParams[FccGlobalConstant.SUB_PRODUCT_CODE])) {
      bindingFormValues[FccGlobalConstant.subProductCode] = this.inputParams[FccGlobalConstant.SUB_PRODUCT_CODE];
    } else {
      const subProduct = this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_PRODUCT_CODE);
      const subProductCode = (subProduct !== undefined && subProduct !== null) ? subProduct : '';
      bindingFormValues[FccGlobalConstant.subProductCode] = subProductCode;
    }
  }

  private handleMultipleLicenseFilter(bindingFormValues: any) {
    if (this.inputParams[FccGlobalConstant.MULTIPLE_LICENSE] === 'Y') {
      bindingFormValues[FccGlobalConstant.ALLOW_MULTIPLE_LS] = this.inputParams[FccGlobalConstant.MULTIPLE_LICENSE];
    }
  }
  private setDefaultFilterCriteria(bindingFormValues) {
    if (this.inputParams.defaultFilterCriteria) {
      Object.keys(this.inputParams.defaultFilterCriteria).forEach(filter => {
        bindingFormValues[filter] = this.inputParams.defaultFilterCriteria[filter];
      });
    }
  }

  private defaultLicenseFilters(bindingFormValues: any) {
    if (this.commonService.defaultLicenseFilter || (this.inputParams && this.inputParams.defaultLicenseFilter)) {
      this.checkProductAndSubProductCode(bindingFormValues);
      bindingFormValues[FccGlobalConstant.COUNTERPARTY_ABBV_NAME] = this.inputParams[FccGlobalConstant.CPTY_NAME];
      bindingFormValues[FccGlobalConstant.VALID_TO_DATE] = this.inputParams[FccGlobalConstant.EXPIRY_DATE_FIELD];
      bindingFormValues[FccGlobalConstant.ACCOUNT_CURRENCY] = this.inputParams[FccGlobalConstant.CURRENCY];
      bindingFormValues[FccGlobalConstant.CUR_CODE] = this.inputParams[FccGlobalConstant.CURRENCY];
      bindingFormValues[FccGlobalConstant.BENE_NAME] = this.inputParams[FccGlobalConstant.BENEFICIARY_NAME];
      bindingFormValues[FccGlobalConstant.ALLOW_MULTIPLE_LS] = this.inputParams[FccGlobalConstant.MULTIPLE_LICENSE];
      bindingFormValues[FccGlobalConstant.FIN_TYPE] = this.inputParams[FccGlobalConstant.FIN_TYPE];
    }
  }

  addValuesToTableComponent() {
    this.componentService = new ComponentService();
    this.componentService.enableFilterPopup = this.enableFilterPopup;
    this.addColumnDetails();
    this.addPaginatorDetails();
    this.addSortingDetails();
    this.addOtherTableDetails();
    this.addWildSearchDetailsToTableComponent();
    this.addActionConfigDetailsToTableComponent();
    this.addPaginatorDetailsTOTableComponent();
    this.addColumnCustomizationAttributes();
    this.componentService.displayDashboard = (this.inputParams.displayDashboard !== undefined &&
      this.inputParams.displayDashboard !== '') ?
    (this.inputParams.displayDashboard === true ? true : false) : false;
    this.addIsActionIconsRequired();
    this.addIsButtonRequired();
  }

  addIsActionIconsRequired() {
    this.componentService.isActionIconsRequired = (this.inputParams.isActionIconsRequired !== undefined &&
      this.inputParams.isActionIconsRequired !== '') ?
    (this.inputParams.isActionIconsRequired === true ? true : false) : false;
  }

  addIsButtonRequired() {
    this.componentService.showButton = (this.inputParams.showButton !== undefined &&
      this.inputParams.showButton !== '') ?
    (this.inputParams.showButton === true ? true : false) : false;
  }
  addColumnDetails() {
    this.componentService.columns = this.cols;
    this.componentService.expandRowCols = this.expandRowCols;
    this.componentService.values = this.finalData;
  }

  addPaginatorDetails() {
    this.componentService.paginator = (this.inputParams.paginator !== undefined &&
      this.inputParams.paginator !== '') ?
    (this.inputParams.paginator === true ? true : false) : true;
    this.componentService.rows = this.defaultRow;
    this.componentService.responsive = true;
    this.componentService.lazy = true;
    this.componentService.totalRecords = this.numRows > 0 ? this.numRows : 0;
    this.componentService.rppOptions = this.rppOptions;
  }

  addSortingDetails() {
    this.componentService.columnSort = (this.inputParams.columnSort !== undefined &&
      this.inputParams.columnSort !== '') ?
    (this.inputParams.columnSort === true ? true : false) : true;
    if (this.widgetFilter || this.customFilter) {
      this.componentService.columnSort = false;
    }
    this.componentService.sortfield = this.defaultSortField;
    this.componentService.sortOrder = this.defaultSortOrder;
    this.componentService.datakey = this.datakey;
    // this.componentService.rowexpansion = (this.datakey && this.datakey !== '') ? true : false;
    this.componentService.rowexpansion = false;
    this.componentService.selectMode = this.selectMode;
    this.componentService.selectedRow = this.firstRowSelected;
  }

  addOtherTableDetails() {
    this.componentService.columnActions = (this.inputParams.columnActions !== undefined &&
      this.inputParams.columnActions !== '') ?
    (this.inputParams.columnActions === true ? true : false) : true;
    this.componentService.passBackEnabled = (this.inputParams.passBackEnabled !== undefined &&
      this.inputParams.passBackEnabled !== '') ?
    (this.inputParams.passBackEnabled === true ? true : false) : true;
    this.componentService.showButton = (this.inputParams.showButton !== undefined &&
      this.inputParams.showButton !== '') ?
    (this.inputParams.showButton === true ? true : false) : true;
    this.componentService.selectionEnabled = (this.inputParams.passBackEnabled === true || (this.passbackField !== undefined &&
        this.passbackField !== '')) ? true : false;
    this.componentService.downloadIconEnabled = (this.inputParams.downloadIconEnabled !== undefined &&
      this.inputParams.downloadIconEnabled !== '') ?
    (this.inputParams.downloadIconEnabled === true ? true : false) : true;
    this.componentService.colFilterIconEnabled = (this.inputParams.colFilterIconEnabled !== undefined &&
      this.inputParams.colFilterIconEnabled !== '') ?
    (this.inputParams.colFilterIconEnabled === true ? true : false) : true;
    this.componentService.enhancedUXTable = (this.inputParams.enhancedUXTable === undefined ||
      this.inputParams.enhancedUXTable === '' || this.inputParams.enhancedUXTable === null) ?
      false : this.inputParams.enhancedUXTable;
    this.componentService.checkBoxPermission = (this.inputParams.checkBoxPermission !== undefined &&
      this.inputParams.checkBoxPermission !== '') ?
      (this.inputParams.checkBoxPermission === true ? true : false) : this.checkBoxPermission;
    if (this.enableFilterPopup || this.inputParams.filterChipsRequired) {
      this.componentService.filterChipsRequired = true;
    } else {
      this.componentService.filterChipsRequired = false;
    }
    if (this.inputParams) {
      this.componentService.listDataDownloadWidgetDetails = this.inputParams;
    }
    if (this.commonService.isEmptyValue(this.componentService.fileName)) {
      if (this.commonService.isNonEmptyValue(this.formValuesBinding)
        && this.commonService.isnonEMptyString(this.formValuesBinding.exportFileName)) {
        this.componentService.fileName = this.formValuesBinding.exportFileName;
      } else if (this.commonService.isNonEmptyValue(this.inputParams.exportFileName)) {
        this.componentService.fileName = this.inputParams.exportFileName;
      }
    }
    this.componentService.displayInputSwitch = this.displayInputSwitch;
  }

  addWildSearchDetailsToTableComponent() {
    this.componentService.wildsearch = (this.inputParams.wildsearch !== undefined &&
      this.inputParams.wildsearch !== '') ?
      (this.inputParams.wildsearch === true ? true : false) : false;
  }

  addActionConfigDetailsToTableComponent() {
    this.componentService.actionconfig = (this.commonService.isnonEMptyString(this.inputParams.actionconfig)) ?
      (this.inputParams.actionconfig === true ? true : false) : false;
  }

  addPaginatorDetailsTOTableComponent() {
   this.componentService.alignPagination = this.inputParams.alignPagination;
  }

  addColumnCustomizationAttributes() {
    this.componentService.allowColumnCustomization = this.inputParams.allowColumnCustomization ?
    this.inputParams.allowColumnCustomization : false;
    if (this.inputParams?.isDashboardWidget) {
      this.componentService.frozenColMaxLimit = this.inputParams.frozenColMaxLimit ?
      this.inputParams.frozenColMaxLimit : this.componentService.frozenColMaxLimit;
    }
  }

  addExportValuesToTableComponent(tableData: any, columns: any, exportType: string) {
    this.componentService.exportData = tableData;
    this.componentService.exportCols = columns;
    this.componentService.exportType = exportType;
    this.componentService.fileName = this.formValuesBinding === undefined
       ? this.inputParams.exportFileName
       : this.formValuesBinding.exportFileName;
    }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  exportCSV(table: any) {
    const paginatorParams = { first: this.first, rows: this.numRows, sortOrder: this.sortOrder, filters: {}, globalFilter: null };
    if ( this.formValuesBinding !== undefined ) {
      this.filterParameters = JSON.stringify(this.formValuesBinding.form.value);
    }
    if (this.inputParams && this.inputParams.listdefName) {
      this.updateListdefData = true;
      this.fetchRecords(this.inputParams.listdefName, paginatorParams, 'csv', this.enableMasking);
    }
  }

  refreshTransactionList() {
    this.refreshProductList.emit({
      filterCriteria : this.inputParams.filterParams
    });
  }

  refreshDataTableList() {
    this.refreshTableDataList.emit();
  }

  onHeaderCheckboxEvent(event) {
    event[`type`] = FccGlobalConstant.checkBox;
    this.resetTableFiltersOnSwtich(event);
    this.headerCheckboxToggle.emit(event);
  }
  // user to have both batch permission and approve permission for checkbox (MPS-63647)
  getcheckboxPermission(metadata: any) {
    if (metadata.BatchProperties && this.inputParams) {
      this.checkBoxPermission = metadata.BatchProperties.permission && this.inputParams.hasSubmissionAccess;
    }
  }
  isParamValid(param: any) {
    let isParamValid = false;
    if (param !== undefined && param !== null && param !== '') {
     isParamValid = true;
    }
    return isParamValid;
  }

  checkLicenseDetails(tabledata: any, obj: any, tnxCcy: any) {
    if (localStorage.getItem(FccGlobalConstant.LANGUAGE) === FccGlobalConstant.LANGUAGE_AR) {
        if ((this.commonService.decodeHtml(obj[FccGlobalConstant.ALLOW_MULTI_CUR]) ===
          this.translateService.instant(FccGlobalConstant.ALLOW_MULTI_CUR_NO) &&
          tnxCcy === obj[FccGlobalConstant.CUR_CODE]) ||
          (this.commonService.decodeHtml(obj[FccGlobalConstant.ALLOW_MULTI_CUR]) ===
          this.translateService.instant(FccGlobalConstant.ALLOW_MULTI_CUR_YES))) {
            this.tabledata.push(obj);
      }
    } else if ((obj[FccGlobalConstant.ALLOW_MULTI_CUR] === this.translateService.instant(FccGlobalConstant.ALLOW_MULTI_CUR_NO) &&
      tnxCcy === obj[FccGlobalConstant.CUR_CODE]) ||
        (obj[FccGlobalConstant.ALLOW_MULTI_CUR] === this.translateService.instant(FccGlobalConstant.ALLOW_MULTI_CUR_YES))) {
          this.tabledata.push(obj);
    }
  }

  setShowFilterSection() {
    this.numberOfDisplayableParams = this.formService.getNoOfDisplayableParams();
    if (this.numberOfDisplayableParams === 0) {
      this.showFilterSection = false;
    } else if (this.numberOfDisplayableParams !== 0 && this.inputParams.productCode === '*') {
      this.showFilterSection = true;
    }
  }

  ngOnDestroy() {
    this.commonService.setFooterSticky(false);
    this.showWidgetFilter = false;
    this.commonService.filterDataAvailable = false;
    this.inputParams.retainFilterValues = undefined;
    this.inputParams.filterParams = undefined;
  }

  viewMoreClicked(event: boolean){
    if (event){
      this.defaultRow = 10;
      const paginatorParams = { first: 0, rows: this.defaultRow, sortOrder: this.sortOrder, filters: {}, globalFilter: null };
      this.inputParams.paginatorParams = paginatorParams;
      this.updateListdefData = true;
      this.fetchRecords(this.inputParams.listdefName, paginatorParams, '', this.enableMasking);
      if(this.filterDataParam && !this.commonService.isObjectEmpty(this.filterDataParam)){
        this.filterDataParam[FccConstants.IS_VIEWMORE_CLICKED] = true;
      }
      this.commonService.setIsViewMore(true);
      this.fetchRecords(this.inputParams.listdefName, paginatorParams, '', this.enableMasking, this.filterDataParam);
      }
  }
  viewListingPage(event){
    this.showViewAllListingPage.emit(event);
  }
  @HostListener('document:keydown.escape', ['$event']) onKeydownHandler(event) {
      if (event && this.filterDialogRef && event.target.localName === 'body'){
          this.filterDialogRef.destroy();
      }
    }

  refreshWidgetList(event) {
    if (this.isParentList) {
      this.updateListdefData = true;
      this.fetchRecords(event.inputParam.listdefName, '', '', this.enableMasking);
    } else {
      const filterDataParam = {};
      filterDataParam[this.defaultFilter] = this.commonService.paymentWidgetListdefFilter;
      this.updateListdefData = true;
      this.fetchRecords(this.childListdef, '', '', this.enableMasking, filterDataParam);
    }
  }

  widgetRefreshList(event) {
    this.fetchRecords(event, '', '', this.enableMasking);

  }

}


