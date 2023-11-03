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
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { SiProductComponent } from '../si-product/si-product.component';
import { BankDetails } from './../../../../../../common/model/bankDetails';
import { References } from './../../../../../../common/model/references';
import { CorporateCommonService } from './../../../../../../corporate/common/services/common.service';
import { LcConstant } from './../../../../../../corporate/trade/lc/common/model/constant';
import { ProductStateService } from './../../../../../../corporate/trade/lc/common/services/product-state.service';
import { FormControlService } from './../../../../../../corporate/trade/lc/initiation/services/form-control.service';
import { UtilityService } from './../../../../../../corporate/trade/lc/initiation/services/utility.service';
import { FccTaskService } from '../../../../../../common/services/fcc-task.service';
import { CurrencyConverterPipe } from './../../../../lc/initiation/pipes/currency-converter.pipe';
import { SiProductService } from '../../../services/si-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-si-issuing-bank',
  templateUrl: './si-issuing-bank.component.html',
  styleUrls: ['./si-issuing-bank.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: SiIssuingBankComponent }]
})
export class SiIssuingBankComponent extends SiProductComponent implements OnInit {

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
  option;
  tnxTypeCode: any;
  provisionalTagValue: any;
  selectedEntity;
  provisionalBankList: Set<string> = new Set<string>();
  provisionalBankMap: Map<string, any> = new Map();
  selectEntityBank: Set<any> = new Set<any>();
  finalSetofBank = [];
  readonly value = 'value';
  entities = [];
  mode: any;
  nameOrAbbvName: any;
  private entityBankMap: Map<string, IssuingDropdown[]> = new Map();
  constructor(protected stateService: ProductStateService, protected emitterService: EventEmitterService,
              protected formControlService: FormControlService, protected corporateCommonService: CorporateCommonService,
              protected fccGlobalConstantService: FccGlobalConstantService, protected utilityService: UtilityService,
              protected commonService: CommonService, protected multiBankService: MultiBankService,
              protected dropDownAPIservice: DropDownAPIService, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected resolverService: ResolverService, protected translateService: TranslateService,
              protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef, protected taskService: FccTaskService,
              protected currencyConverterPipe: CurrencyConverterPipe, protected siProductService: SiProductService
  ) {
    super(emitterService, stateService, commonService, translateService, confirmationService,
      customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray,
      dialogRef, currencyConverterPipe, siProductService);
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
    this.mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (obj !== null) {
      this.form = obj as FCCFormGroup;
    }
    this.provisionalTagValue = this.stateService.getSectionData(FccGlobalConstant.SI_GENERAL_DETAILS).get('provisionalLCToggle').value;
    this.provisionalBankList = this.commonService.getQueryParametersFromKey('provisionalBankList');
    this.provisionalBankMap = this.commonService.getQueryParametersFromKey('provisionalBankMap');
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND &&
      this.stateService.getSectionData('siApplicantBeneficiaryDetails').get('applicantEntity') &&
      this.stateService.getSectionData('siApplicantBeneficiaryDetails').get('applicantEntity').value &&
      this.stateService.getSectionData('siApplicantBeneficiaryDetails').get('applicantEntity').value !==
      FccGlobalConstant.BLANK_SPACE_STRING ) {
        this.selectedEntity = this.stateService.getSectionData('siApplicantBeneficiaryDetails').get('applicantEntity').value;
    } else {
      if (this.stateService.getSectionData('siApplicantBeneficiaryDetails').get('applicantEntity').value.name !== undefined){
        this.selectedEntity = this.stateService.getSectionData('siApplicantBeneficiaryDetails').get('applicantEntity').value.name;
      }else{
        this.selectedEntity = this.stateService.getSectionData('siApplicantBeneficiaryDetails').get('applicantEntity').value;
      }
     }
    this.provisionalCheck();
    this.getCorporateBanks();
    this.getCorporateReferences();
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryField(this.form, FccGlobalConstant.BANK_NAME_LIST, false);
      this.setMandatoryField(this.form, FccGlobalConstant.ISSUER_REFERENCE_LIST, false);
      this.form.get(FccGlobalConstant.BANK_NAME_LIST).setErrors({ required: false });
      this.form.get(FccGlobalConstant.BANK_NAME_LIST).clearValidators();
      this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST).setErrors({ required: false });
      this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST).clearValidators();
    }
  }
  provisionalCheck() {

    if (this.provisionalTagValue === 'Y' && !this.provisionalBankMap.has('*') && this.selectedEntity !== undefined)
 {

 this.entityBankMap = this.multiBankService.getEntityBankMap();
 const value = this.entityBankMap.get( this.selectedEntity);

 value.forEach(element => {
       this.selectEntityBank.add(element);
     });

 this.selectEntityBank.forEach(element => {
     if (this.provisionalBankMap.has(element[this.value])) {
     this.finalSetofBank.push(element);
     }
     });

//  this.corporateBanks.forEach(element => {
//       if (this.provisionalBankList.has(element.value) ) {
//         this.finalSetofBank.push(element);
//       }

//      });
//  this.corporateBanks = [];
 this.corporateBanks = this.finalSetofBank;

 } else if (this.provisionalTagValue === 'Y' && !this.provisionalBankMap.has('*') && this.selectedEntity === undefined) {

   this.corporateBanks.forEach(element => {
      if (this.provisionalBankMap.has(element.value) ) {
        this.finalSetofBank.push(element);
      }

     });
   this.corporateBanks = [];
   this.corporateBanks = this.finalSetofBank;

 }

  }

  getCorporateBanks() {
    if (this.mode === FccGlobalConstant.VIEW_MODE && this.tnxTypeCode !== FccGlobalConstant.N002_AMEND) {
      this.multiBankService.getEntityList().forEach(entity => {
        this.entities.push(entity);
      });
      const valobj = this.dropDownAPIservice.getDropDownFilterValueObj(this.entities, 'applicantEntity',
                  this.stateService.getSectionData(FccGlobalConstant.SI_APPLICANT_BENEFICIARY));
      if (valobj && valobj[FccGlobalConstant.VALUE] && !this.taskService.getTaskEntity()) {
        this.multiBankService.setCurrentEntity(valobj[FccGlobalConstant.VALUE].name);
      }
    } else {
      this.multiBankService.setCurrentEntity(this.selectedEntity);
    }
    this.setBankNameList();
    const val = this.dropDownAPIservice.getInputDropdownValue(this.corporateBanks, FccGlobalConstant.BANK_NAME_LIST, this.form);
    this.patchFieldParameters(this.form.get(FccGlobalConstant.BANK_NAME_LIST), { options: this.corporateBanks });
    this.form.get(FccGlobalConstant.BANK_NAME_LIST).setValue(val);
    if (this.corporateBanks.length === 1) {
      this.form.get(FccGlobalConstant.BANK_NAME_LIST)[FccGlobalConstant.PARAMS][this.disabled] = true;
    } else {
      this.form.get(FccGlobalConstant.BANK_NAME_LIST)[FccGlobalConstant.PARAMS][this.disabled] = false;
    }
    this.multiBankService.setCurrentBank(val, this.selectedEntity);
    if (this.taskService.getTaskBank()){
      this.form.get('bankNameList').setValue(this.taskService.getTaskBank().value);
      this.multiBankService.setCurrentBank(this.taskService.getTaskBank().value, this.selectedEntity);
      } else {
      this.taskService.setTaskBank(this.corporateBanks[0]);
      }
    if (this.tnxTypeCode && this.tnxTypeCode === FccGlobalConstant.N002_AMEND
      && this.form.get(FccGlobalConstant.BANK_NAME_LIST).value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get(FccGlobalConstant.BANK_NAME_LIST), { amendPersistenceSave: true });
      const valObj = { label: String, value: String };
      const valueDisplayed = this.dropDownAPIservice.getDropDownFilterValueObj(this.corporateBanks,
        FccGlobalConstant.BANK_NAME_LIST, this.form);
      valObj.label = valueDisplayed[FccGlobalConstant.LABEL];
      if (valObj) {
        this.form.get(FccGlobalConstant.BANK_NAME_LIST).setValue(valObj.label);
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
      this.multiBankService.setCurrentBank(event.value , this.selectedEntity);
      const taskBank = this.corporateBanks.filter((item) => item.value === event.value);
      this.taskService.setTaskBank(taskBank[0]);
      this.setIssuerReferenceList();
    }
  }

  getCorporateReferences() {
    this.patchFieldParameters(this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST), { options: [] });
    this.entityName = this.stateService.getSectionData(FccGlobalConstant.SI_APPLICANT_BENEFICIARY).get('applicantEntity').value.shortName;
    if (this.entityName === '') {
      this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST)[this.params][this.disabled] = true;
    } else {
      this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST)[this.params][this.disabled] = false;
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
    let val = this.dropDownAPIservice.getInputDropdownValue(this.corporateReferences, FccGlobalConstant.ISSUER_REFERENCE_LIST, this.form,
      isDefaultFirst);
    this.patchFieldParameters(this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST), { options: this.corporateReferences });
    val = this.multiBankService.updateRefonEntityChange && !isDefaultFirst && !val ? '' : val;
    this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST).setValue(val);
    if (this.corporateReferences.length === 1) {
      this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST)[this.params][this.disabled] = true;
    } else {
      this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST)[this.params][this.disabled] = false;
    }
    if (this.tnxTypeCode && this.tnxTypeCode === FccGlobalConstant.N002_AMEND
      && this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST).value !== FccGlobalConstant.EMPTY_STRING) {
      this.patchFieldParameters(this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST), { amendPersistenceSave: true });
      const valObj = { label: String, value: String };
      const valueDisplayed = this.dropDownAPIservice.getDropDownFilterValueObj(this.corporateReferences,
        FccGlobalConstant.ISSUER_REFERENCE_LIST, this.form);
      valObj.label = valueDisplayed[FccGlobalConstant.LABEL];
      if (valObj) {
        this.form.get(FccGlobalConstant.ISSUER_REFERENCE_LIST).setValue(valObj.label);
      }
    }
  }

  ngOnDestroy() {
    this.parentForm.controls[this.controlName] = this.form;
  }
}

export interface IssuingDropdown {
  label: string;
  value: string;
}
