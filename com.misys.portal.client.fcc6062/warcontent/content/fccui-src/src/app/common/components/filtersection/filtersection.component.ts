import {
  AfterViewInit,
  Component,
  EventEmitter,
  Input,
  OnChanges,
  OnInit,
  Output,
  ViewChild,
} from '@angular/core';
import { AbstractControl } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';

import { LocaleService } from '../../../base/services/locale.service';
import { UtilityService } from '../../../corporate/trade/lc/initiation/services/utility.service';
import { FccConstants } from '../../core/fcc-constants';
import { FccGlobalConstantService } from '../../core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../core/fcc-global-constants';
import { CommonService } from '../../services/common.service';
import { FCCBase } from './../../../base/model/fcc-base';
import { FCCFormGroup } from './../../../base/model/fcc-control.model';
import {
  ButtonControl,
  DivControl,
  DropdownFormControl,
  InputDateControl,
  InputTextControl,
  MultiSelectFormControl,
  SelectButtonControl,
  SpacerControl,
} from './../../../base/model/form-controls.model';
import { LendingCommonDataService } from './../../../corporate/lending/common/service/lending-common-data-service';
import { FormControlService } from './../../../corporate/trade/lc/initiation/services/form-control.service';
import { HOST_COMPONENT } from './../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { CodeData } from './../../model/codeData';
import { CurrencyRequest } from './../../model/currency-request';
import { FccTradeFieldConstants } from '../../../corporate/trade/common/fcc-trade-field-constants';

@Component({
  selector: 'fcc-common-filtersection',
  templateUrl: './filtersection.component.html',
  styleUrls: ['./filtersection.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: FiltersectionComponent }]
})
export class FiltersectionComponent extends FCCBase implements OnChanges, OnInit, AfterViewInit {
  form: FCCFormGroup;
  @Input()
  inputJson: any[] = [];
  @Input()
  filterParam: any[] = [];
  @Input()
  filterParams: any;
  @Output()
  filterApplied: EventEmitter<any> = new EventEmitter<any>();
  @Output()
  submitform: EventEmitter<any> = new EventEmitter<any>();
  element: any;
  options = 'options';
  module: any;
  phraseTypes: any;
  codeData = new CodeData();
  exportFileName: string;
  productCode: string;
  params = 'params';
  pdtCode = 'productCode';
  curRequest: CurrencyRequest = new CurrencyRequest();
  beneficiaries = [];
  language = localStorage.getItem('language');
  widgetData: any;
  widgetFilterRequired: any;
  buttonJSONValue: any;
  buttonName: any;
  formDataValue: any;
  @ViewChild('calendar') public calendar: any;
  dir: string = localStorage.getItem('langDir');
  backUpForm = new FCCFormGroup({});
  backupValue: any;
  viewInCurrency: any;
  pCol3 = 'p-col-3 p-lg-3 p-md-6 p-sm-12 inputStyle';
  isCurrencyDataLoaded = false;
  isEntityDataLoaded = false;
  isCodeDataLoaded = false;
  isUserAccountsIdsLoaded = false;
  tableData: any;

  constructor(protected translateService: TranslateService,
              protected commonService: CommonService,
              protected corporateCommonService: CommonService,
              protected fccGlobalConstantService: FccGlobalConstantService,
              protected activatedRoute: ActivatedRoute,
              protected lendingService: LendingCommonDataService,
              protected dynamicDialogConfig: DynamicDialogConfig,
              protected formControlService: FormControlService,
              protected dynamicDialogRef: DynamicDialogRef,
              protected utilityService: UtilityService,
              protected localeService: LocaleService) {
    super();
  }
  ngOnInit() {
    this.initializeFormGroup();
    this.commonService.filterDialogueStatus.next(null);
    this.activatedRoute.queryParams.subscribe(params => {
      Object.keys(params).forEach(element => {
        if (this.isParamValid(params[element]) && element === 'productCode') {
          this.productCode = params[element];
        }
      });
    });
    this.getBeneficiaryList(this.productCode);
    this.addAccessibilityControl();
  }

  ngOnChanges() {
    if (this.filterParam && this.filterParam[FccGlobalConstant.DISPLAY_ADV_FILTER]) {
      this.inputJson = this.commonService.filterInputVal;
      this.initializeFormGroup();
    } else {
      this.initializeFormGroup();
    }

  }

  addAccessibilityControl(): void {
    const titleBarCloseList = Array.from(document.getElementsByClassName('ui-dialog-titlebar-close'));
    titleBarCloseList.forEach(element => {
      element[FccGlobalConstant.ARIA_LABEL] = this.translateService.instant('close');
      element[FccGlobalConstant.TITLE] = this.translateService.instant('close');
    });    
  }

  isParamValid(param: any) {
    let isParamValid = false;
    if (param !== undefined && param !== null && param !== '') {
     isParamValid = true;
    }
    return isParamValid;
  }

  initializeFormGroup() {
    this.form = new FCCFormGroup({});
    let obj1 = {};
    if (this.dynamicDialogConfig && this.dynamicDialogConfig.data) {
      const displayJSON = 'displayJSON';
      const buttonJSON = 'buttonJSON';
      const widgetFilterJSON = 'widgetFilterJSON';
      const formData = 'formData';
      obj1 = this.dynamicDialogConfig.data;
      this.widgetData = obj1[displayJSON];
      this.buttonJSONValue = obj1[buttonJSON];
      this.widgetFilterRequired = obj1[widgetFilterJSON];
      this.formDataValue = obj1[formData];
      this.tableData = obj1['tableData'];
    }
    if (this.widgetFilterRequired) {
      this.inputJson = this.widgetData;
    }
    if (this.commonService.filterDataAvailable) {
      this.inputJson = this.filterPreferenceDataBinding(this.inputJson, this.commonService.filterPreferenceData);
    }
    if (this.filterParams) {
      this.inputJson = this.filterPreferenceDataBinding(this.inputJson, this.filterParams);
    }
    this.handleFormDatavalue();
    if (this.widgetFilterRequired && this.buttonJSONValue) {
      this.handleFilterButtons();
    }
    this.backupValue = this.form.getRawValue();
    this.viewInCurrency = this.commonService.getBaseCurrency();
    if (this.commonService.isNonEmptyField(FccConstants.ACCOUNTCCY, this.form) &&
    this.commonService.isEmptyValue(this.form.get(FccConstants.ACCOUNTCCY).value)) {
      this.onClickAccountCcy();
      this.form.get(FccConstants.ACCOUNTCCY).setValue(this.viewInCurrency);
    }
    this.productCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.PRODUCT);
    if (this.productCode === FccGlobalConstant.PRODUCT_LC || this.productCode === FccGlobalConstant.PRODUCT_SI) {
      this.patchFieldParameters(this.form.get(FccTradeFieldConstants.PHRASE_TYPE), { rendered: true, required: true });
    }
    else{
      this.patchFieldParameters(this.form.get(FccTradeFieldConstants.PHRASE_TYPE), { rendered: false, required: false });
    }
  }

  protected handleFormDatavalue() {
    if (this.formDataValue) {
      this.form = this.formDataValue;
    } else {
      if (this.inputJson) {
        this.inputJson.forEach(element => {
          if (element.name === 'revolving_flag' || element.name === 'ntrf_flag' || element.name === 'renew_flag'
          || element.name === 'rolling_renewal_flag') {
            element.type = 'input-multiselect';
            element.options[0].label = `${this.translateService.instant('Y')}`;
            element.options[0].value = 'Y';
            element.options[1].label = `${this.translateService.instant('N')}`;
            element.options[1].value = 'N';
          }
          if (element.name !== 'export_list') {
            this.form.addControl(this.underscoreToCamelcase(element.name), this.getControl(element));
            this.populateMultiSelectOPtions(element.name);
          } else {
            this.exportFileName = element.fileName;
          }
        });
        if (this.filterParams) {
          this.filterApplied.emit();
        }
      }
    }
  }

  protected handleFilterButtons() {
    if (this.buttonJSONValue.space1) {
      this.form.addControl(this.buttonJSONValue.space1.name, this.getControl(this.buttonJSONValue.space1));
    }
    if (this.dir === 'ltr') {
      if (this.buttonJSONValue.cancelBtn) {
        this.form.addControl(this.buttonJSONValue.cancelBtn.name, this.getControl(this.buttonJSONValue.cancelBtn));
      }
      if (this.buttonJSONValue.resetBtn) {
        this.form.addControl(this.buttonJSONValue.resetBtn.name, this.getControl(this.buttonJSONValue.resetBtn));
      }
      if (this.buttonJSONValue.applyBtn) {
        this.form.addControl(this.buttonJSONValue.applyBtn.name, this.getControl(this.buttonJSONValue.applyBtn));
      }
    }
    if (this.dir === 'rtl') {
      if (this.buttonJSONValue.applyBtn) {
        this.form.addControl(this.buttonJSONValue.applyBtn.name, this.getControl(this.buttonJSONValue.applyBtn));
        this.form.get(this.buttonJSONValue.applyBtn.name)[FccGlobalConstant.PARAMS].layoutClass =
        'button-filter-width-11';
      }
      if (this.buttonJSONValue.resetBtn) {
        this.form.addControl(this.buttonJSONValue.resetBtn.name, this.getControl(this.buttonJSONValue.resetBtn));
        this.form.get(this.buttonJSONValue.resetBtn.name)[FccGlobalConstant.PARAMS].layoutClass = 'button-filter-width-14';
      }
      if (this.buttonJSONValue.cancelBtn) {
        this.form.addControl(this.buttonJSONValue.cancelBtn.name, this.getControl(this.buttonJSONValue.cancelBtn));
        this.form.get(this.buttonJSONValue.cancelBtn.name)[FccGlobalConstant.PARAMS].layoutClass = 'button-filter-width-14';
      }
    }
  }

  filterPreferenceDataBinding(inputJson: any[], filterPreferenceData: any) {
    const filterDataArray = Object.entries(filterPreferenceData);
    filterDataArray.forEach(element1 => {
      inputJson.forEach(element2 => {
        if (element2.name === element1[0] && (element2.type === FccGlobalConstant.inputText ||
          element2.type === FccGlobalConstant.inputDate )) {
          element2.value = element1[1];
        } else if (element2.name === element1[0] && element2.type === FccGlobalConstant.inputMultiSelect &&
          this.commonService.isnonEMptyString(element1[1])) {
          element2.value = (element1[1] as string).split('|');
        } else if (element2.name === element1[0] && element2.type === FccGlobalConstant.inputMultiSelect &&
          this.commonService.isEmptyValue(element1[1])) {
          element2.value = FccGlobalConstant.EMPTY_STRING;
        } else if (element2.name === element1[0] && element2.type === FccGlobalConstant.selectButton) {
          element2.selected = element1[1];
        }
      });
    });
    return inputJson;
  }

  populateMultiSelectOPtions(key: string) {
    if (key.indexOf('_') > -1) {
      key = this.underscoreToCamelcase(key);
    }
    const functionSuffixName = `${key.substr(0, 1).toUpperCase()}${key.substr(1)}`;
    const fnName = `onClick${functionSuffixName}`;
    if (this[fnName] && (typeof this[fnName] === 'function')) {
      this[fnName]();
    }
  }

  underscoreToCamelcase(name: string) {
    return name.toLowerCase().replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
  }

  async getBeneficiaryList(productCode: any) {
    const offset = FccGlobalConstant.LENGTH_0;
    await this.corporateCommonService.getFormValuesWithOffset(offset, this.fccGlobalConstantService.getStaticDataLimit(),
         this.fccGlobalConstantService.counterparties).then(data => {
        this.updateBeneFicaryList(data, productCode);
    });
  }
// eslint-disable-next-line @typescript-eslint/no-unused-vars
  onClickEntity(event: any) {
    const elementId = 'entity';
    this.isEntityDataLoaded = false;
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
          const entityDataArray = [];
          if (this.form.get(elementId)[this.options].length === 0) {
          this.corporateCommonService.getFormValues(
            this.fccGlobalConstantService.getStaticDataLimit(), this.fccGlobalConstantService.userEntities)
            .subscribe(result => {
              result.body.items.forEach(value => {
                const entity: { label: string; value: any } = {
                  label: value.shortName,
                  value: value.shortName
                };
                entityDataArray.push(entity);
              });
              entityDataArray.sort((a, b) => {
                const x = a.label.toLowerCase();
                const y = b.label.toLowerCase();
                if (x < y) {
                  return -1;
                }
                if (x > y) {
                  return 1;
                }
                return 0;
              });
              this.patchFieldParameters(this.form.get(elementId), { options: entityDataArray });
            },
            () => {
              this.isEntityDataLoaded = false;
            });
          this.isEntityDataLoaded = true;
          }
        }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickApplicantActNo() {
    this.onClickAccountNo(FccGlobalConstant.APPLICANT_ACCOUNT_NUMBER);
  }

  onClickAccountNo(id = '') {
    this.isUserAccountsIdsLoaded = false;
    const elementId = id ? id : FccGlobalConstant.ACCOUNT_NO;
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
          const accountDataArray = [];
          if (this.commonService.isNonEmptyValue(this.form.get(elementId)[this.options])){
            if (this.form.get(elementId)[this.options].length === 0) {
            this.corporateCommonService.getUserAccountIds(this.fccGlobalConstantService.userAccountsIds)
              .subscribe(result => {
                result.body.items.forEach(value => {
                  const accountDetails: { label: string; value: any } = {
                    label: value.number,
                    value: value.number
                  };
                  accountDataArray.push(accountDetails);
                });
                this.sortListByLabel(accountDataArray);
                this.patchFieldParameters(this.form.get(elementId), { options: accountDataArray });
              },
              error => {
                if(error){
                  this.isUserAccountsIdsLoaded = false;
                }
                
              });
              this.sortListByLabel(accountDataArray);
              this.patchFieldParameters(this.form.get(elementId), { options: accountDataArray });
            }
          this.isUserAccountsIdsLoaded = true;
          }
        }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickDepositAccount() {
    this.onClickAccount(FccConstants.DEPOSIT_ACCOUNT, FccConstants.ACCOUNT_TYPE_05);
  }

  onClickLoanAccount() {
    this.onClickAccount(FccConstants.LOAN_ACCOUNT, FccConstants.ACCOUNT_TYPE_04);
  }

  onClickAccount(id, filterValue) {
    const elementId = id ? id : FccGlobalConstant.ACCOUNT_NO;
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
          const accountDataArray = [];
          if (this.form.get(elementId)[this.options].length === 0 ) {
          this.corporateCommonService.getUserAccountIds(this.fccGlobalConstantService.userAccountsIds)
            .subscribe(result => {
              result.body.items
              .filter(value => value.type === filterValue)
              .forEach(value => {
                const accountDetails: { label: string; value: any } = {
                  label: value.number,
                  value: value.number
                };
                accountDataArray.push(accountDetails);
              });
              this.sortListByLabel(accountDataArray);
              this.patchFieldParameters(this.form.get(elementId), { options: accountDataArray });
            });
          }
        }
    this.form.get(elementId).updateValueAndValidity();
  }

  sortListByLabel(list) {
    list.sort((a, b) => {
      const x = a.label.toLowerCase();
      const y = b.label.toLowerCase();
      if (x < y) {
        return -1;
      }
      if (x > y) {
        return 1;
      }
      return 0;
    });
  }

  onClickAccountType() {
    const elementId = FccGlobalConstant.ACCOUN_TYPE;
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
          const accountTypeDataArray = [];
          if (this.form.get(elementId)[this.options].length === 0 ) {
          this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
          this.corporateCommonService.getUserAccountType( this.fccGlobalConstantService.userAccountsType + '/' + this.codeData.language)
            .subscribe(result => {
              result.body.items.forEach(value => {
                const accountType: { label: string; value: any } = {
                  label: value.description,
                  value: value.type
                };
                accountTypeDataArray.push(accountType);
              });
              const accountType1: { label: string; value: any } = {
                label: `${this.translateService.instant('all')}`,
                value: 'all'
              };
              accountTypeDataArray.push(accountType1);
              accountTypeDataArray.sort((a, b) => {
                const x = a.label.toLowerCase();
                const y = b.label.toLowerCase();
                if (x < y) {
                  return -1;
                }
                if (x > y) {
                  return 1;
                }
                return 0;
              });
              this.patchFieldParameters(this.form.get(elementId), { options: accountTypeDataArray });
            });
          }
        }
    this.form.get(elementId).updateValueAndValidity();
  }
  onClickTnxTypeCode() {
    const elementId = 'tnxTypeCode';
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    const productCodeValue = this.form.get(elementId)[this.params][this.pdtCode];
    this.productCode = this.commonService.isNonEmptyValue(productCodeValue) ? productCodeValue : '*';
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_EVENT_TYPE_C090;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }
 onClickSubTnxStatCode() {
    const elementId = 'subTnxStatCode';
    let elementValue = this.form.get(elementId).value;
    const productCodeValue = this.form.get(elementId)[this.params][this.pdtCode];
    this.productCode = this.commonService.isNonEmptyValue(productCodeValue) ? productCodeValue : '*';
    if (elementValue === null || elementValue === undefined) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length === 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_SUB_TNX_STAT_CODE_N015;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
          if (this.exportFileName.toLowerCase().indexOf('draft') > -1 &&
          (responseValue.value === '01' || responseValue.value === '18')) {
              const eventData: { label: string; value: any } = {
                label: responseValue.longDesc,
                value: responseValue.value
              };
              eventDataArray.push(eventData);
            }
        });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
      });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }


  onClickAccountCcy() {
    const elementId = FccConstants.ACCOUNTCCY;
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null || elementValue === undefined) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      const accountCcyDataArray = [];
      let accountCurrencyList;
      if (this.form.get(elementId)[this.options].length === 0 ) {
        this.commonService.loadDefaultConfiguration().subscribe(response => {
          if (response) {
            accountCurrencyList = response.equivalentCurrencyList;
            accountCurrencyList.forEach (element => {
              const accountCcy: { label: string; value: any } = {
                label: element,
                value: element
              };
              accountCcyDataArray.push(accountCcy);
            });
            accountCcyDataArray.sort((a, b) => {
              const x = a.label.toLowerCase();
              const y = b.label.toLowerCase();
              if (x < y) {
                return -1;
              }
              if (x > y) {
                return 1;
              }
              return 0;
            });
            this.patchFieldParameters(this.form.get(elementId), { options: accountCcyDataArray });
          }
        });
      }
    }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickResetBtn() {
    this.dynamicDialogConfig.data = undefined;
    this.formDataValue = undefined;
    this.ngOnInit();
  }

  onClickCancelBtn() {
    const cancel = 'cancel';
    this.commonService.filterDialogueStatus.next(cancel);
    this.form.setValue(this.backupValue);
    this.form.updateValueAndValidity();
    this.dynamicDialogRef.close(this.form);
  }

  onClickApplyBtn() {
    this.onFocusApplyBtn();
  }

  onClickFavourite() {
    const elementId = FccGlobalConstant.FAVOURITE;
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_FAVOURITE_C065;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const favDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const favData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            favDataArray.push(favData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: favDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickActionReqCode() {
    const elementId = 'actionReqCode';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_ACTION_REQUIRED_TYPE_C094;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickProductTypeCode() {
    const elementId = 'productTypeCode';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_PRODUCT_TYPE_C010;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const ProdDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const prodData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            ProdDataArray.push(prodData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: ProdDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickTenorType() {
    const elementId = 'tenorType';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_TENOR_TYPE_C095;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickTermCode() {
    const elementId = 'termCode';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_TERM_CODE_C097;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  onKeydownProdStatCode() {
    this.onClickProdStatCode();
  }

  onClickProdStatCode() {
    const elementId = 'prodStatCode';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_EVENT_TYPE_C093;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

onClickCurCode() {
    const elementId = 'curCode';
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if (elementValue !== null) {
      const currencyDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 && !this.isCurrencyDataLoaded) {
        this.corporateCommonService.userCurrencies(this.curRequest).subscribe(result => {
          result.items.forEach(value => {
            const curency: { label: string; value: any } = {
              label: value.isoCode,
              value: value.isoCode
            };
            currencyDataArray.push(curency);
          });
          this.patchFieldParameters(this.form.get(elementId), { options: currencyDataArray });
        },
        () => {
          this.isCurrencyDataLoaded = false;
        });
        this.isCurrencyDataLoaded = true;
      }
    }
    this.form.get(elementId).updateValueAndValidity();
  }

onClickSubProductCode() {
    const elementId = 'subProductCode';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_FINANCING_TYPE_C096;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0) {
        this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
          response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
          this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  getControl(element: any) {
    let control: AbstractControl;
    switch (element.type) {
      case 'input-multiselect':
      control = new MultiSelectFormControl(this.underscoreToCamelcase(element.name), element.value, this.translateService, {
        placeholder: `${this.translateService.instant(element.localizationkey)}`,
        options: element.options,
        layoutClass: this.pCol3,
        styleClass: 'triggerIcon',
        rendered: true,
        maxSelectLabels: 1,
        srcElementId: element.name,
        productCode: element.productCode
      });
      break;
      case 'select-button':
      control = new SelectButtonControl(this.underscoreToCamelcase(element.name), element.selected, this.translateService, {
          label: `${this.translateService.instant(element.name)}`,
          options: element.options,
          styleClass: 'bank-select time-frame',
          layoutClass: 'p-col-12',
          rendered: true,
          srcElementId: element.name,
          showHorizontal: true
        });
      break;
      case 'button':
      control = new ButtonControl(this.underscoreToCamelcase(element.name), this.translateService, {
          label: `${this.translateService.instant(element.name)}`,
          options: element.options,
          styleClass: element.styleClass,
          layoutClass: element.layoutClass,
          rendered: true,
          srcElementId: element.name,
          showHorizontal: true
        });
      break;
      case 'button-div':
      control = this.getDivControl(element);
      break;
      case 'spacer':
        control = new SpacerControl(this.translateService, {
          layoutClass: element.layoutClass,
          rendered: element.rendered !== undefined ? element.rendered : true
        });
        break;
      case 'input-date':
      control = new InputDateControl(this.underscoreToCamelcase(element.name), element.value, this.translateService, {
        label: `${this.translateService.instant(element.localizationkey)}`,
        layoutClass: 'p-col-3 p-lg-3 p-md-6 p-sm-12 calendarStyle', styleClass: ['dateStyle'],
        srcElementId: element.name,
        selectionMode: 'range',
        rendered: true,
        langLocale: this.localeService.getCalendarLocaleJson(this.language),
        dateFormat: this.utilityService.getDateFormatForRangeSelectionCalendar()
      });
      break;
      case 'input-dropdown':
      control = new DropdownFormControl(this.underscoreToCamelcase(element.name), '', this.translateService, {
        label: `${this.translateService.instant(element.localizationkey)}`,
        options: element.options,
        layoutClass: this.pCol3,
        styleClass: 'triggerIcon',
        rendered: true,
        maxSelectLabels: 1,
        srcElementId: element.name,
        productCode: element.productCode
      });
      break;
      default:
        control = new InputTextControl(this.underscoreToCamelcase(element.name), element.value, this.translateService, {
          label: `${this.translateService.instant(element.localizationkey)}`,
          styleClass: ['textFieldStyle'],
          layoutClass: this.pCol3,
          rendered: true,
          srcElementId: element.name
        });
    }

    return control;
  }

  protected getDivControl(field: any) {
    const control : AbstractControl = new DivControl(field.name, this.translateService, {
      label: `${this.translateService.instant(field.name)}`,
      rendered: field.rendered !== undefined ? field.rendered : true,
      [field.displayKey]: field.displayValue,
      layoutClass: field.layoutClass,
      styleClass : field.styleClass,
      parentStyleClass: field.parentStyleClass,
      key: field.name,
      previewScreen: field.previewScreen === false ? false : true,
      groupChildren: field.groupChildren,
      grouphead: field.grouphead,
      btndisable: field.btndisable
    });
    return control;
  }

  uniqueBeneficaryList(beneficiaryDataArray) {
    return beneficiaryDataArray.reduce((unique, o) => {
      if (!unique.some(obj => obj.label === o.label)) {
        unique.push(o);
      }
      return unique;
    }, []);
  }
  updateBeneFicaryList(body: any, productode: any) {
    let elementId = 'beneficiaryName';
    if (productode === FccGlobalConstant.PRODUCT_EC) {
      elementId = 'draweeName';
    }
    let upadatedBeneficaryList = [];

    body.items.forEach((responseValue: { name: any; shortName: any; }) => {
      const beneficiary: { label: string; value: any } = {
        label: responseValue.name,
        value: responseValue.name
      };
      this.beneficiaries.push(beneficiary);
    });

    this.beneficiaries.sort((a, b) => {
      const x = a.label.toLowerCase();
      const y = b.label.toLowerCase();
      if (x < y) {
        return -1;
      }
      if (x > y) {
        return 1;
      }
      return 0;
   });
    upadatedBeneficaryList = this.uniqueBeneficaryList(this.beneficiaries);
    this.patchFieldParameters(this.form.get(elementId), { options: upadatedBeneficaryList });
  }

  onFocusApplyBtn(){
    this.form.removeControl('applyBtn');
    if (this.commonService.isNonEmptyField('space1', this.form)) {
      this.form.removeControl('space1');
    }
    if (this.commonService.isNonEmptyField('cancelBtn', this.form)) {
      this.form.removeControl('cancelBtn');
    }
    if (this.commonService.isNonEmptyField('resetBtn', this.form)) {
      this.form.removeControl('resetBtn');
    }
    this.dynamicDialogRef.close(this.form);
  }

  onClickEcTypeCode() {
    const elementId = 'ecTypeCode';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_EC_TYPE_CODE_N021;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }


  onClickFtCurCode() {
    const elementId = 'ftCurCode';
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if (elementValue !== null && elementValue.length >= 0) {
      const ftCurrencyDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
        this.corporateCommonService.userCurrencies(this.curRequest).subscribe(result => {
          result.items.forEach(value => {
            const curency: { label: string; value: any } = {
              label: value.isoCode,
              value: value.isoCode
            };
            ftCurrencyDataArray.push(curency);
          });
          this.patchFieldParameters(this.form.get(elementId), { options: ftCurrencyDataArray });
        });
      }
    }
  }

  onClickLcExpDateTypeCode() {
    const elementId = 'lcExpDateTypeCode';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_EXPIRY_TYPE_C085;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  // Added Event for Enter Key
  onKeydownTnxTypeCode() {
    this.onClickTnxTypeCode();
  }

  onKeydownEntity(event: any) {
    if (!this.isEntityDataLoaded) {
      this.onClickEntity(event);
    }
  }
  onKeydownAccountType() {
    this.onClickAccountType();
  }

  onKeydownAccountNo(event: any) {
    if (!this.isUserAccountsIdsLoaded) {
      this.onClickAccountNo(event);
    }
  }

  onKeydownCurCode() {
    this.onClickCurCode();
  }

  onKeydownLcExpDateTypeCode() {
    this.onClickLcExpDateTypeCode();
  }

  onClickBoDealName(event: any) {
    if (event) {
      const elementId = 'boDealName';
      const facilityElementId = 'boFacilityName';
      const eventDataArray = [];
      let elementValue = this.form.get(elementId).value;
      if (elementValue === null) {
        elementValue = FccGlobalConstant.EMPTY_STRING;
      }
      if ( elementValue.length >= 0) {
        this.lendingService.getAllDeals('').subscribe(response => {
          response.body.dealList.forEach(responseValue => {
              const eventData: { label: string; value: string; dealId: string} = {
                label: responseValue.dealName,
                value: responseValue.dealName,
                dealId: responseValue.dealId
              };
              eventDataArray.push(eventData);
            });

          eventDataArray.sort((a, b) => {
            const x = a.label.toLowerCase();
            const y = b.label.toLowerCase();
            if (x < y) {
              return -1;
            }
            if (x > y) {
              return 1;
            }
            return 0;
            });

          for (let i = 0; i < eventDataArray.length - 1; i++) {
            if (eventDataArray[i + 1].value === eventDataArray[i].value) {
              eventDataArray.splice(i + 1, 1);
            }
          }
          this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
          });
      }
      if (this.form.get(facilityElementId)) {
        this.patchFieldParameters(this.form.get(facilityElementId), { options: [] });
        this.form.get(facilityElementId).setValue([]);
      }
      this.form.get(elementId).updateValueAndValidity();
    }
  }

  onClickBoFacilityName(event: any) {
    if (event) {
      const elementId = 'boFacilityName';
      const allDeals = this.form.get('boDealName')[this.options];
      const dealNames = this.form.get('boDealName').value;
      const selectedDealIds = [];
      for (let i = 0; i < allDeals.length; i++){
        if (allDeals && dealNames && dealNames.indexOf(allDeals[i].value) > -1){
          selectedDealIds.push(allDeals[i].dealId);
        }
      }
      const eventDataArray = [];
      this.lendingService.getAllFacilities(selectedDealIds, '').subscribe(response => {
        response.body.facilityList.forEach(responseValue => {
          responseValue.facilities.forEach(facilities => {
            const eventData: { label: string; value: any } = {
              label: facilities.name,
              value: facilities.name
            };
            eventDataArray.push(eventData);
          });
          });
        eventDataArray.sort((a, b) => {
          const x = a.label.toLowerCase();
          const y = b.label.toLowerCase();
          if (x < y) {
            return -1;
          }
          if (x > y) {
            return 1;
          }
          return 0;
        });
        for (let i = 0; i < eventDataArray.length - 1; i++) {
          if (eventDataArray[i + 1].value === eventDataArray[i].value) {
            eventDataArray.splice(i + 1, 1);
          }
        }
        this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        });
      this.form.get(elementId).updateValueAndValidity();
    }
  }

  onClickProductType() {
    const elementId = 'productType';
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if (elementValue.length >= 0) {
      if (this.commonService.isnonEMptyString(this.productCode) && this.productCode === FccGlobalConstant.PRODUCT_BENE){
        this.codeData.codeId = FccGlobalConstant.CODE_DATA_BENE_PRODUCT_TYPE_C016;
        this.codeData.productCode = FccGlobalConstant.PRODUCT_DEFAULT;
      } else {
        this.codeData.codeId = FccGlobalConstant.CODE_DATA_PRODUCT_TYPE_N117;
        this.codeData.productCode = this.productCode;
      }
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const eventDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 && !this.isCodeDataLoaded) {
        this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
          response.body.items.forEach(responseValue => {
            const eventData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            eventDataArray.push(eventData);
          });
          this.patchFieldParameters(this.form.get(elementId), { options: eventDataArray });
        },
        () => {
          this.isCodeDataLoaded = false;
        });
        this.isCodeDataLoaded = true;
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickPreApproved() {
    const elementId = FccGlobalConstant.PRE_APPROVED;
    this.productCode = this.form.get(elementId)[this.params][this.pdtCode];
    let elementValue = this.form.get(elementId).value;
    if (elementValue === null) {
      elementValue = FccGlobalConstant.EMPTY_STRING;
    }
    if ( elementValue.length >= 0) {
      this.codeData.codeId = FccGlobalConstant.CODEDATA_PREAPPROVED_C066;
      this.codeData.productCode = this.productCode;
      this.codeData.subProductCode = FccGlobalConstant.SUBPRODUCT_DEFAULT;
      this.codeData.language = localStorage.getItem('language') !== null ? localStorage.getItem('language') : '';
      const favDataArray = [];
      if (this.form.get(elementId)[this.options].length === 0 ) {
      this.corporateCommonService.getCodeDataDetails(this.codeData).subscribe(response => {
        response.body.items.forEach(responseValue => {
            const favData: { label: string; value: any } = {
              label: responseValue.longDesc,
              value: responseValue.value
            };
            favDataArray.push(favData);
          });
        this.patchFieldParameters(this.form.get(elementId), { options: favDataArray });
        });
      }
      }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickClientClientid() {
    const elementId = FccGlobalConstant.BENE_CLIENT_ID;
    const beneClientList = [];
    if (this.form.get(elementId)[this.options].length === 0 ) {
    this.corporateCommonService.getExternalStaticDataList("clientDetails").subscribe(result => {
      if(result) {
        result.forEach(value => {
          const list: { label: string; value: any } = {
            label: value.clientdesc,
            value: value.clientid
          };
          beneClientList.push(list);
        });
        this.patchFieldParameters(this.form.get(elementId), { options: beneClientList });
      }
    });
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  onClickDebtorDebtoridentification() {
    const elementId = FccGlobalConstant.PAYMENT_BULK_CLIENT_ID;
    const beneClientList = [];
    this.corporateCommonService.getExternalStaticDataList("clientDetails").subscribe(result => {
      if(result) {
        result.forEach(value => {
          const list: { label: string; value: any } = {
            label: value.clientdesc,
            value: value.clientid
          };
          beneClientList.push(list);
        });
        this.patchFieldParameters(this.form.get(elementId), { options: beneClientList });
      }
    });
  }

  onClickDebtoridentification() {
    const elementId = FccGlobalConstant.DEBTOR_ID;
    const paymentsClientList = [];
    this.corporateCommonService.getExternalStaticDataList("clientDetails").subscribe(result => {
      if(result) {
        result.forEach(value => {
          const list: { label: string; value: any } = {
            label: value.clientdesc,
            value: value.clientid
          };
          paymentsClientList.push(list);
        });
        this.patchFieldParameters(this.form.get(elementId), { options: paymentsClientList });
      }
    });
  }

  onClickBatchstatus() {
    const elementId = FccGlobalConstant.PAYMENTSTATUS;
    const paymentsStatusList = [];

    if (this.form.get(elementId)[this.options].length === 0 ) {
    FccGlobalConstant.PAYMENT_STATUS_CODES.forEach(val => {
      const list: { label: string; value: any } = {
        label: val.value,
        value: val.key
      };
     paymentsStatusList.push(list);
    });
      this.patchFieldParameters(this.form.get(elementId), { options: paymentsStatusList });
    }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickStatus() {
    const elementId = FccGlobalConstant.STATUS;
    const statusList = [];

    const status = FccGlobalConstant.PAYMENT_BULK_STATUS;
    if (this.form.get(elementId)[this.options].length === 0 ) {
    status.forEach(val => {
      const list: { label: string; value: any } = {
        label: val,
        value: val.toUpperCase()
      };
      statusList.push(list);
    });
    this.patchFieldParameters(this.form.get(elementId), { options: statusList });
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  onKeyupCreditordetailsCreditorname() {
    const elementId = 'creditordetailsCreditorname';
    const beneIdList = [];
    if (this.form.get(elementId)[this.options].length === 0 ) {
      const result = this.tableData;
      let flag = true;
      if(result) {
        result.forEach(element => {
          flag = true;
          beneIdList.forEach(bene => {
            if(bene.label === element['creditorDetails@creditorName'])
            {
                flag = false;
            }
          });
          if(flag){
            const benefeciaryNameCode: { label: string, value: any } = {
              label: element['creditorDetails@creditorName'],
              value : element['creditorDetails@creditorName']
            };
            beneIdList.push(benefeciaryNameCode);
          }
        });
        this.patchFieldParameters(this.form.get(elementId), { options: beneIdList });
      }
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  onClickDebtoraccountIdOtherId() {
    const elementId = 'debtoraccountIdOtherId';
    let filterParamsTemp: any = {};
    filterParamsTemp.packageCode = this.tableData[0].methodOfPayment;
    filterParamsTemp.payFromType = 'B';
    filterParamsTemp = JSON.stringify(filterParamsTemp);
    const payFromList = [];
    if (this.form.get(elementId)[this.options].length === 0 ) {
    this.corporateCommonService.getExternalStaticDataList("payFrom", filterParamsTemp).subscribe(result => {
      if(result) {
        result.forEach(element => {
          const payFrom: { label: string, value: any } = {
            label: element.code,
            value : element.code
          };
          payFromList.push(payFrom);
        });
        this.patchFieldParameters(this.form.get(elementId), { options: payFromList });
      }
    });
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  onClickInstrumentstatus() {
    const elementId = 'instrumentstatus';
    const paymentsStatusList = [];

    if (this.form.get(elementId)[this.options].length === 0 ) {
    FccGlobalConstant.PAYMENT_STATUS_CODES.forEach(val => {
      const list: { label: string; value: any } = {
        label: val.value,
        value: val.key
      };
     paymentsStatusList.push(list);
    });
      this.patchFieldParameters(this.form.get(elementId), { options: paymentsStatusList });
    }
    this.form.get(elementId).updateValueAndValidity();
  }

  onClickCreditordetailsCreditorname() {
    const elementId = 'creditordetailsCreditorname';
    const beneIdList = [];
    if (this.form.get(elementId)[this.options].length === 0 ) {
      const result = this.tableData;
      let flag = true;
      if(result) {
        result.forEach(element => {
          flag = true;
          beneIdList.forEach(bene => {
            if(bene.label === element['creditorDetails@creditorName'])
            {
                flag = false;
            }
          });
          if(flag){
            const benefeciaryNameCode: { label: string, value: any } = {
              label: element['creditorDetails@creditorName'],
              value : element['creditorDetails@creditorName']
            };
            beneIdList.push(benefeciaryNameCode);
          }
        });
        this.patchFieldParameters(this.form.get(elementId), { options: beneIdList });
      }
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  onClickBankaccountAccountIdOtherId() {
    const elementId = FccGlobalConstant.BENE_ACCOUNT_ID;
    const bankAccountIdList = [];
    if (this.form.get(elementId)[this.options].length === 0 ) {
    this.corporateCommonService.getExternalStaticDataList("accountNo").subscribe(result => {
      if(result) {
        result.forEach(value => {
          const list: { label: string; value: any } = {
            label: value.bene_acct_nmbr,
            value: value.bene_acct_nmbr
          };
          bankAccountIdList.push(list);
        });
        this.patchFieldParameters(this.form.get(elementId), { options: bankAccountIdList });
      }
    });
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  onClickBeneficiaryid() {
    const elementId = FccGlobalConstant.BENE_ID;
    const beneIdList = [];
    if (this.form.get(elementId)[this.options].length === 0 ) {
    this.corporateCommonService.getExternalStaticDataList("beneficiaryId").subscribe(result => {
      if(result) {
        result.forEach(value => {
          const list: { label: string; value: any } = {
            label: value.receiver_code,
            value: value.receiver_code
          };
          beneIdList.push(list);
        });
        this.patchFieldParameters(this.form.get(elementId), { options: beneIdList });
      }
    });
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  onClickMethodofpayment() {
    let filterParamsTemp: any = {};
    filterParamsTemp.paymentPackages = 'M';
    filterParamsTemp = JSON.stringify(filterParamsTemp);
    const elementId = FccGlobalConstant.METHOD_OF_PAYMENT;
    const packageList = [];
    if (this.form.get(elementId)[this.options].length === 0 ) {
    this.corporateCommonService.getExternalStaticDataList("paymentPackages",filterParamsTemp).subscribe(result => {
      if(result) {
        result.forEach(value => {
          const list: { label: string; value: any } = {
            label: value.mypproduct,
            value: value.mypproduct
          };
          packageList.push(list);
        });
        this.patchFieldParameters(this.form.get(elementId), { options: packageList });
      }
    });
   }
   this.form.get(elementId).updateValueAndValidity();
  }

  getPhraseTypes() {
    this.phraseTypes = [];
    let flag = true;
    this.codeData.codeId = FccGlobalConstant.CODEDATA_EVENT_TYPE_C047;
    this.codeData.productCode = this.productCode;
    this.codeData.subProductCode = '';
    this.codeData.language = localStorage.getItem(FccGlobalConstant.LANGUAGE) !== null ?
    localStorage.getItem(FccGlobalConstant.LANGUAGE) : '';
    this.commonService.getCodeDataDetails(this.codeData).subscribe(response => {
      response.body.items.forEach(responseValue => {
              if (responseValue.value === FccGlobalConstant.CODE_DYNAMIC_PHRASE &&
                !this.commonService.getUserPermissionFlag(FccGlobalConstant.DYNAMIC_PHRASE_PERMISSION)) {
                flag = false;
              } else {
                flag = true;
              }
              if (flag) {
                this.phraseTypes.push(
                  {
                    label: this.commonService.decodeHtml(responseValue.longDesc),
                      value: responseValue.value
                  }
                );
              }
            });
        });
    this.patchFieldParameters(this.form.get(FccTradeFieldConstants.PHRASE_TYPE), { options: this.phraseTypes });
    if (this.phraseTypes.length === 1) {
      this.form.get(FccTradeFieldConstants.PHRASE_TYPE).setValue(this.phraseTypes[0].value);
      this.onClickPhraseType();
      this.form.get(FccTradeFieldConstants.PHRASE_TYPE).updateValueAndValidity();
    } else {
      this.form.get(FccTradeFieldConstants.PHRASE_TYPE).updateValueAndValidity();
    }
    this.form.updateValueAndValidity();
  }

  onClickPhraseType()
  {
    this.getPhraseTypes();
  }

  ngAfterViewInit() {
    if (this.commonService.isNonEmptyValue(this.calendar)) {
      this.calendar.el.nativeElement.getElementsByClassName(FccGlobalConstant.UI_CALENDAR_BUTTON)[0]
      .setAttribute('title', this.translateService.instant(FccGlobalConstant.CALENDAR));
    }
  }

  ngOnDestroy() {
    this.commonService.filterDataAvailable = false;
    this.commonService.setFilterPreference({});
  }
}
