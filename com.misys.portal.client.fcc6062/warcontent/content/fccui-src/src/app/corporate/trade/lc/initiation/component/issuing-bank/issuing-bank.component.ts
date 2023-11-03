import { Component, Input, OnInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';

import { FCCFormGroup } from '../../../../../../base/model/fcc-control.model';
import { FccGlobalConstantService } from '../../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from '../../../../../../common/core/fcc-global-constants';
import { CommonService } from '../../../../../../common/services/common.service';
import { DropDownAPIService } from '../../../../../../common/services/dropdownAPI.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { MultiBankService } from '../../../../../../common/services/multi-bank.service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { LcConstant } from '../../../common/model/constant';
import { ProductStateService } from '../../../common/services/product-state.service';
import { CustomCommasInCurrenciesPipe } from '../../pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../services/filelist.service';
import { FormControlService } from '../../services/form-control.service';
import { UtilityService } from '../../services/utility.service';
import { LcProductComponent } from '../lc-product/lc-product.component';
import { BankDetails } from './../../../../../../common/model/bankDetails';
import { References } from './../../../../../../common/model/references';
import { CorporateCommonService } from './../../../../../../corporate/common/services/common.service';
import { ImportLetterOfCreditResponse } from './../../model/importLetterOfCreditResponse';
import { FccTaskService } from '../../../../../../common/services/fcc-task.service';
import { CurrencyConverterPipe } from '../../pipes/currency-converter.pipe';
import { LcProductService } from '../../../services/lc-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-issuing-bank',
  templateUrl: './issuing-bank.component.html',
  styleUrls: ['./issuing-bank.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: IssuingBankComponent }]
})
export class IssuingBankComponent extends LcProductComponent implements OnInit {

  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  form: FCCFormGroup;
  module = '';
  bankDetails: BankDetails;
  corporateBanks = [];
  corporateReferences = [];
  references: References;
  entityName: any;
  lcConstant = new LcConstant();
  params = this.lcConstant.params;
  entitiesList: any;
  readonly = this.lcConstant.readonly;
  disabled = this.lcConstant.disabled;
  lcResponseForm = new ImportLetterOfCreditResponse();
  option;
  tnxTypeCode: any;
  entities = [];
  nameOrAbbvName: any;
  constructor(protected stateService: ProductStateService, protected emitterService: EventEmitterService,
              protected formControlService: FormControlService, protected corporateCommonService: CorporateCommonService,
              protected fccGlobalConstantService: FccGlobalConstantService, protected utilityService: UtilityService,
              protected commonService: CommonService, protected multiBankService: MultiBankService,
              protected dropDownAPIservice: DropDownAPIService, protected confirmationService: ConfirmationService,
              protected translateService: TranslateService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected searchLayoutService: SearchLayoutService, protected resolverService: ResolverService,
              protected fileList: FilelistService, protected dialogRef: DynamicDialogRef, protected taskService: FccTaskService,
              protected currencyConverterPipe: CurrencyConverterPipe, protected lcProductService: LcProductService
  ) {
    super(emitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
          searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, lcProductService);
  }

  ngOnInit(): void {
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.nameOrAbbvName = response.TradeIssuingBankNameOrAbbvName;
      }
    });
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    const obj = this.parentForm.controls[this.controlName];
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    if (obj !== null) {
      this.form = obj as FCCFormGroup;
    }
    this.getCorporateBanks();
    this.getCorporateReferences();
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryField(this.form, 'bankNameList', false);
      this.setMandatoryField(this.form, 'issuerReferenceList', false);
      this.form.get('bankNameList').setErrors({ required: false });
      this.form.get('bankNameList').clearValidators();
      this.form.get('issuerReferenceList').setErrors({ required: false });
      this.form.get('issuerReferenceList').clearValidators();
    }
  }


  getCorporateBanks() {
    this.multiBankService.getEntityList().forEach(entity => {
      this.entities.push(entity);
    });
    const valobj = this.dropDownAPIservice.getDropDownFilterValueObj(this.entities, 'applicantEntity',
                  this.stateService.getSectionData(FccGlobalConstant.APPLICANT_BENEFICIARY));
    if (valobj && valobj[FccGlobalConstant.VALUE] && !this.taskService.getTaskEntity()) {
      this.multiBankService.setCurrentEntity(valobj[FccGlobalConstant.VALUE].name);
    }
    this.setBankNameList();
    const val = this.dropDownAPIservice.getInputDropdownValue(this.corporateBanks, 'bankNameList', this.form);
    this.patchFieldParameters(this.form.get('bankNameList'), { options: this.corporateBanks });
    this.form.get('bankNameList').setValue(val);
    if (this.corporateBanks.length === 1) {
      this.form.get(FccGlobalConstant.BANK_NAME_LIST)[FccGlobalConstant.PARAMS][this.disabled] = true;
    } else {
      this.form.get(FccGlobalConstant.BANK_NAME_LIST)[FccGlobalConstant.PARAMS][this.disabled] = false;
    }
    this.multiBankService.setCurrentBank(val);
    if (this.taskService.getTaskBank()){
    this.form.get('bankNameList').setValue(this.taskService.getTaskBank().value);
    this.multiBankService.setCurrentBank(this.taskService.getTaskBank().value);
    } else {
    this.taskService.setTaskBank(this.corporateBanks[0]);
    }
    if (this.tnxTypeCode && this.tnxTypeCode === FccGlobalConstant.N002_AMEND
      && this.form.get('bankNameList').value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get('bankNameList'), { amendPersistenceSave: true });
      const valObj = { label: String, value: String };
      const valueDisplayed = this.dropDownAPIservice.getDropDownFilterValueObj(this.corporateBanks, 'bankNameList', this.form);
      valObj.label = valueDisplayed[FccGlobalConstant.LABEL];
      if (valObj) {
        this.form.get('bankNameList').setValue(valObj.label);
      }
    }
  }

  setBankNameList() {
    if (this.nameOrAbbvName === 'abbv_name') {
      this.corporateBanks = [];
      this.multiBankService.getBankList().forEach(bank => {
        bank.label = bank.value;
        this.corporateBanks.push(bank);
      });
    } else {
      this.corporateBanks = [];
      this.multiBankService.getBankList().forEach(bank => {
        this.corporateBanks.push(bank);
      });
    }
  }

  onClickBankNameList(event) {
    if (event && event.value)
    {
      if (!this.form.get('bankNameList')[this.params][this.disabled]) {
        this.multiBankService.setCurrentBank(event.value);
        const taskBank = this.corporateBanks.filter((item) => item.value === event.value);
        this.taskService.setTaskBank(taskBank[0]);
        this.setIssuerReferenceList();
    }
  }
  }

  getCorporateReferences() {
    this.patchFieldParameters(this.form.get('issuerReferenceList'), { options: [] });
    this.entityName = this.stateService.getSectionData(FccGlobalConstant.APPLICANT_BENEFICIARY).get('applicantEntity').value.shortName;
    if (this.entityName === '') {
      this.form.get('issuerReferenceList')[this.params][this.disabled] = true;
    } else {
      this.form.get('issuerReferenceList')[this.params][this.disabled] = false;
    }
    this.setIssuerReferenceList();
  }

  setIssuerReferenceList() {
    this.corporateReferences = [];
    const referenceList = this.multiBankService.getReferenceList();
    referenceList.forEach(reference => {
      this.corporateReferences.push(reference);
    });
    const isDefaultFirst = this.corporateReferences.length === FccGlobalConstant.LENGTH_1;
    let val = this.dropDownAPIservice.getInputDropdownValue(this.corporateReferences, 'issuerReferenceList', this.form, isDefaultFirst);
    this.patchFieldParameters(this.form.get('issuerReferenceList'), { options: this.corporateReferences });
    val = this.multiBankService.updateRefonEntityChange && !isDefaultFirst && !val ? '' : val;
    this.form.get('issuerReferenceList').setValue(val);
    if (this.corporateReferences.length === 1) {
      this.form.get('issuerReferenceList')[this.params][this.disabled] = true;
    } else {
      this.form.get('issuerReferenceList')[this.params][this.disabled] = false;
    }
    if (this.tnxTypeCode && this.tnxTypeCode === FccGlobalConstant.N002_AMEND
      && this.form.get('issuerReferenceList').value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get('issuerReferenceList'), { amendPersistenceSave: true });
      const valObj = { label: String, value: String };
      const valueDisplayed = this.dropDownAPIservice.getDropDownFilterValueObj(this.corporateReferences, 'issuerReferenceList', this.form);
      valObj.label = valueDisplayed[FccGlobalConstant.LABEL];
      if (valObj) {
        this.form.get('issuerReferenceList').setValue(valObj.label);
      }
    }
  }

  ngOnDestroy() {
    this.parentForm.controls[this.controlName] = this.form;
  }
}
