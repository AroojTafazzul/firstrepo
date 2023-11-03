
import {
  ChangeDetectorRef,
  Component,
  ComponentFactoryResolver,
  ElementRef,
  EventEmitter,
  OnDestroy,
  OnInit,
  Output,
  ViewChild,
  ViewContainerRef,
} from '@angular/core';
import { MatTabGroup } from '@angular/material/tabs/tab-group';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { BehaviorSubject } from 'rxjs';

import { FccBusinessConstantsService } from '../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstantService } from '../../../../../../common/core/fcc-global-constant.service';
import { CommonService } from '../../../../../../common/services/common.service';
import { DropDownAPIService } from '../../../../../../common/services/dropdownAPI.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { FormModelService } from '../../../../../../common/services/form-model.service';
import { MultiBankService } from '../../../../../../common/services/multi-bank.service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { ProductStateService } from '../../../../../../corporate/trade/lc/common/services/product-state.service';
import { FormControlService } from '../../../../../../corporate/trade/lc/initiation/services/form-control.service';
import { LcReturnService } from '../../../../../../corporate/trade/lc/initiation/services/lc-return.service';
import { PrevNextService } from '../../../../../../corporate/trade/lc/initiation/services/prev-next.service';
import { UtilityService } from '../../../../../../corporate/trade/lc/initiation/services/utility.service';
import { AmendCommonService } from '../../../../../common/services/amend-common.service';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { UiAdviseThroughBankComponent } from '../ui-advise-through-bank/ui-advise-through-bank.component';
import { UiAdvisingBankComponent } from '../ui-advising-bank/ui-advising-bank.component';
import { UiConfirmingBankComponent } from '../ui-confirming-bank/ui-confirming-bank.component';
import { UiIssuingBankComponent } from '../ui-issuing-bank/ui-issuing-bank.component';
import { UiProductComponent } from '../ui-product/ui-product.component';
import { FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FccGlobalConstant } from './../../../../../../common/core/fcc-global-constants';
import { BankDetails } from './../../../../../../common/model/bankDetails';
import { References } from './../../../../../../common/model/references';
import { CorporateCommonService } from './../../../../../../corporate/common/services/common.service';
import { FccTaskService } from '../../../../../../common/services/fcc-task.service';
import { CurrencyConverterPipe } from '../../../../lc/initiation/pipes/currency-converter.pipe';
import { UiProductService } from '../../../services/ui-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-ui-bank-details',
  templateUrl: './ui-bank-details.component.html',
  styleUrls: ['./ui-bank-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: UiBankDetailsComponent }]
})
export class UiBankDetailsComponent extends UiProductComponent implements OnInit, OnDestroy {

  form: FCCFormGroup;
  @Output() notify = new EventEmitter<any>();
  @ViewChild('tabs') public tabs: MatTabGroup;
  @ViewChild(UiIssuingBankComponent, { read: UiIssuingBankComponent })
  public issuingBankComponent: UiIssuingBankComponent;
  @ViewChild(UiAdvisingBankComponent, { read: UiAdvisingBankComponent })
  public advisingBankComponent: UiAdvisingBankComponent;
  @ViewChild(UiAdviseThroughBankComponent, { read: UiAdviseThroughBankComponent })
  public adviseThroughBankComponent: UiAdviseThroughBankComponent;
  @ViewChild(UiConfirmingBankComponent, { read: UiConfirmingBankComponent })
  public confirmingBankComponent: UiConfirmingBankComponent;

  bankDetails: BankDetails;
  corporateBanks = [];
  corporateReferences = [];
  references: References;
  entityName: any;
  entitiesList: any;
  params = FccGlobalConstant.PARAMS;
  rendered = FccGlobalConstant.RENDERED;
  readOnly = FccGlobalConstant.READONLY;
  bankResponse;
  confirmationBehaviourSubject = new BehaviorSubject(null);
  mode;
  confirmationPartyValue;
  subProductValue;
  productCode: any;
  tnxTypeCode: any;
  option: any;
  isMasterRequired: any;
  module = `${this.translateService.instant(FccGlobalConstant.UI_BANK_DETAILS)}`;
  selectedEntity;
  nameOrAbbvName: any;
  constructor(protected translateService: TranslateService, protected eventEmitterService: EventEmitterService,
              protected stateService: ProductStateService,
              protected multiBankService: MultiBankService, protected dropDownAPIservice: DropDownAPIService ,
              protected searchLayoutService: SearchLayoutService,
              protected resolverService: ResolverService,
              protected corporateCommonService: CorporateCommonService,
              protected elementRef: ElementRef,
              protected commonService: CommonService,
              protected lcReturnService: LcReturnService, protected router: Router,
              protected utilityService: UtilityService,
              protected fccGlobalConstantService: FccGlobalConstantService,
              protected prevNextService: PrevNextService,
              protected formModelService: FormModelService,
              protected formControlService: FormControlService,
              protected emitterService: EventEmitterService,
              protected viewContainerRef: ViewContainerRef,
              protected cdRef: ChangeDetectorRef,
              protected resolver: ComponentFactoryResolver,
              protected amendCommonService: AmendCommonService,
              protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected fileArray: FilelistService,
              protected dialogRef: DynamicDialogRef,
              protected taskService: FccTaskService,
              protected currencyConverterPipe: CurrencyConverterPipe, protected uiProductService: UiProductService) {

              super(eventEmitterService, stateService, commonService, translateService, confirmationService,
                customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray, dialogRef,
                currencyConverterPipe, uiProductService);
}

ngOnInit(): void {
  this.commonService.loadDefaultConfiguration().subscribe(response => {
    if (response) {
      this.nameOrAbbvName = response.TradeIssuingBankNameOrAbbvName;
    }
  });
  this.isMasterRequired = this.isMasterRequired;
  this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
  this.productCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.PRODUCT);
  this.form = this.stateService.getSectionData(FccGlobalConstant.UI_BANK_DETAILS, undefined, this.isMasterRequired);
  this.mode =
  this.stateService.getSectionData(FccGlobalConstant.UI_GENERAL_DETAIL, undefined, this.isMasterRequired).get('advSendMode').value;
  this.confirmationPartyValue = this.stateService
  .getSectionData(
    FccGlobalConstant.UI_GENERAL_DETAIL,
    undefined,
    this.isMasterRequired
  )
  .get("bgConfInstructions").value;

  this.subProductValue = this.stateService
  .getSectionData(
    FccGlobalConstant.UI_GENERAL_DETAIL,
    undefined,
    this.isMasterRequired
  )
  .get("bgSubProductCode").value;

  this.option = this.commonService.getQueryParametersFromKey('option');
  this.getCorporateBanks();
  this.getCorporateReferences();
  this.removeMandatory();
  if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
    this.amendFormFields();
    this.commonService.formatForm(this.form);
  }
}


handleOnChange() {
  if (this.issuingBankComponent) {
    this.issuingBankComponent.ngOnDestroy();
  }
  if (this.adviseThroughBankComponent) {
    this.adviseThroughBankComponent.ngOnDestroy();
  }
  if (this.advisingBankComponent) {
    this.advisingBankComponent.ngOnDestroy();
  }
  if (this.confirmingBankComponent) {
    this.confirmingBankComponent.ngOnDestroy();
  }
}

removeMandatory() {
  if (this.option === FccGlobalConstant.TEMPLATE) {
    this.setMandatoryField(this.form, 'uiBankNameList', false);
    this.setMandatoryField(this.form, 'issuerReferenceList', false);
  }
}

ngAfterViewInit() {
 // this.uiProductService.uiBankDetailsAfterViewInit(this.subProductValue, this.confirmationPartyValue, this.form, this.elementRef);
  // TODO :: Retain the below commented code once the component extension works fine.
  // const confirmingBankFields = ['confirmingBankIcons', 'confirmingSwiftCode', 'confirmingBankName',
  // 'confirmingBankFirstAddress', 'confirmingBankSecondAddress', 'confirmingBankThirdAddress'];
  // if (this.subProductValue === FccGlobalConstant.STBY && this.confirmationPartyValue !== FccBusinessConstantsService.WITHOUT_03) {
  //    if (this.form.get('uiConfirmingBank')) {
  //     this.toggleControls(this.form.get('uiConfirmingBank'), confirmingBankFields, true);
  //     this.form.get('uiConfirmingBank')[this.rendered] = true;
  //  }
  //  } else {
  //   this.elementRef.nativeElement.querySelectorAll('.mat-tab-label.mat-focus-indicator.mat-ripple')
  //   [FccGlobalConstant.LENGTH_3].style.display = 'none';
  //   if (this.form.get('uiConfirmingBank')) {
  //   this.form.get('uiConfirmingBank').reset();
  //   this.toggleControls(this.form.get('uiConfirmingBank'), confirmingBankFields, false);
  //   this.form.get('uiConfirmingBank')[this.rendered] = false;
  //   }
  // }
  // this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
  // if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
  //   this.amendFormFields();
  // }
}

handleControlComponentsData(event: any) {
  // this.uiProductService.uiBankDetailsAfterViewInit(this.subProductValue, this.confirmationPartyValue, this.form, event);
  if (event.has('bankDetailsTab') && event.get('bankDetailsTab').has('querySelectorAllValue')) {
    this.uiProductService.uiBankDetailsAfterViewInit(this.subProductValue, this.confirmationPartyValue, this.form, event);
   // event.get("bankDetailsTab").get("querySelectorAllValue")[FccGlobalConstant.LENGTH_3].style.display = 'none';
  }
}


amendFormFields() {
  this.amendCommonService.setValueFromMasterToPrevious(FccGlobalConstant.UI_BANK_DETAILS);
}

private renderDependentFields(displayFields?: any,
                              hideFields?: any) {
if (displayFields) {
this.toggleControls(this.form, displayFields, true);

}
if (hideFields) {
this.toggleControls(this.form, hideFields, false);
this.setValueToNull(hideFields);
}

}
setValueToNull(fieldName: any[]) {
  let index: any;
  for (index = 0; index < fieldName.length; index++) {
    this.form.controls[fieldName[index]].setValue('');
  }
}

getCorporateBanks() {
  this.selectedEntity = this.stateService.getSectionData(FccGlobalConstant.UI_APPLICANT_BENEFICIARY_DETAILS).get('applicantEntity').value;
  if (typeof this.selectedEntity === 'object'){
    this.selectedEntity = this.selectedEntity.name;
  }
  this.multiBankService.setCurrentEntity(this.selectedEntity);
  this.setBankNameList();
  const val = this.dropDownAPIservice.getInputDropdownValue(this.corporateBanks, 'uiBankNameList', this.form);
  this.patchFieldParameters(this.form.get('uiBankNameList'), { options: this.corporateBanks });
  this.form.get('uiBankNameList').setValue(val);
  const valueDisplayed = this.dropDownAPIservice.getDropDownFilterValueObj(this.corporateBanks, 'uiBankNameList', this.form);
  if (valueDisplayed) {
  this.form.get('recipientBankName').setValue(valueDisplayed[FccGlobalConstant.VALUE]);
  }
  if (this.corporateBanks.length === FccGlobalConstant.LENGTH_1) {
    this.form.get('uiBankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.DISABLED] = true;
  }
  this.multiBankService.setCurrentBank(val);
  if (this.taskService.getTaskBank()){
    this.form.get('uiBankNameList').setValue(this.taskService.getTaskBank().value);
    this.multiBankService.setCurrentBank(this.taskService.getTaskBank().value);
    } else {
    this.taskService.setTaskBank(this.corporateBanks[0]);
    }
  if (this.tnxTypeCode && this.tnxTypeCode === FccGlobalConstant.N002_AMEND
      && this.form.get('recipientBankName').value !== FccGlobalConstant.EMPTY_STRING) {
    this.patchFieldParameters(this.form.get('recipientBankName'), { amendPersistenceSave: true });
    const valObj = { label: String, value: String };
    const valueDisplayedBank = this.dropDownAPIservice.getDropDownFilterValueObj(this.corporateBanks, 'recipientBankName', this.form);
    valObj.label = valueDisplayedBank[FccGlobalConstant.LABEL];
    if (valObj) {
      this.form.get('recipientBankName').setValue(valObj.label);
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

onClickUiBankNameList(event) {
  if (event.value) {
    this.multiBankService.setCurrentBank(event.value);
    const taskBank = this.corporateBanks.filter((item) => item.value === event.value);
    this.taskService.setTaskBank(taskBank[0]);
    this.setIssuerReferenceList();
    const reqURl = `${this.fccGlobalConstantService.corporateBanks}/${taskBank[0].value}`;
    this.corporateCommonService.getValues(reqURl).subscribe(response => {
    if (response.status === 200) {
      this.form.get('uiIssuingBank').get('issuingBankName').setValue(response.body.name);
          if (response.body.SWIFTAddress) {
            this.form.get('uiIssuingBank').get('issuingBankFirstAddress').setValue(response.body.SWIFTAddress.line1);
            this.form.get('uiIssuingBank').get('issuingBankSecondAddress').setValue(response.body.SWIFTAddress.line2);
            this.form.get('uiIssuingBank').get('issuingBankThirdAddress').setValue(response.body.SWIFTAddress.line3);           
          }
          if (response.body.isoCode) {
            this.form.get('uiIssuingBank').get('issuingBankswiftCode').setValue(response.body.isoCode);
          } else {
            this.form.get('uiIssuingBank').get('issuingBankswiftCode').setValue('');
          }
        }
      });
    }
  }

getCorporateReferences() {
  this.patchFieldParameters(this.form.get('issuerReferenceList'), { options: [] });
  this.entityName = this.stateService
  .getSectionData(
    "uiApplicantBeneficiaryDetails",
    undefined,
    this.isMasterRequired
  )
  .get("applicantEntity").value.shortName;

  if (this.entityName === '') {
    this.form.get('issuerReferenceList')[this.params][this.readOnly] = true;
  } else {
    this.form.get('issuerReferenceList')[this.params][this.readOnly] = false;
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
    this.form.get('issuerReferenceList')[this.params][this.readOnly] = true;
    this.form.get('issuerReferenceList')[FccGlobalConstant.PARAMS][FccGlobalConstant.DISABLED] = true;
  } else {
    this.form.get('issuerReferenceList')[this.params][this.readOnly] = false;
    this.form.get('issuerReferenceList')[FccGlobalConstant.PARAMS][FccGlobalConstant.DISABLED] = false;
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
  if (this.form.get('uiConfirmingBank')[this.rendered] === true ) {
    this.updateConfirmingBankDetails(this.form.get('uiConfirmingBank'));
  }
  this.stateService.setStateSection(FccGlobalConstant.UI_BANK_DETAILS, this.form, this.isMasterRequired);
}
updateConfirmingBankDetails(confirmBankForm){
  const advConf =
  this.stateService.getSectionData(FccGlobalConstant.UI_BANK_DETAILS, undefined, this.isMasterRequired).get('uiAdvisingBank').value;
  const advThruConf = this.stateService
  .getSectionData(
    FccGlobalConstant.UI_BANK_DETAILS,
    undefined,
    this.isMasterRequired
  )
  .get("uiAdviceThrough").value;

  if (advConf.advBankConfReq === 'Y' ) {
    confirmBankForm.get('confirmingSwiftCode').patchValue(advConf.advisingswiftCode);
    confirmBankForm.get('confirmingBankName').patchValue(advConf.advisingBankName);
    confirmBankForm.get('confirmingBankFirstAddress').patchValue(advConf.advisingBankFirstAddress);
    confirmBankForm.get('confirmingBankSecondAddress').patchValue(advConf.advisingBankSecondAddress);
    confirmBankForm.get('confirmingBankThirdAddress').patchValue(advConf.advisingBankThirdAddress);
    if (this.mode !== FccBusinessConstantsService.SWIFT) {
      confirmBankForm.get('confirmingBankFourthAddress').patchValue(advConf.advisingBankFourthdAddress);
    }
  } else if (advThruConf.adviseThruBankConfReq === 'Y') {

    confirmBankForm.get('confirmingSwiftCode').patchValue(advThruConf.advThroughswiftCode);
    confirmBankForm.get('confirmingBankName').patchValue(advThruConf.adviceThroughName);
    confirmBankForm.get('confirmingBankFirstAddress').patchValue(advThruConf.adviceThroughFirstAddress);
    confirmBankForm.get('confirmingBankSecondAddress').patchValue(advThruConf.adviceThroughSecondAddress);
    confirmBankForm.get('confirmingBankThirdAddress').patchValue(advThruConf.adviceThroughThirdAddress);
    if (this.mode !== FccBusinessConstantsService.SWIFT) {
      confirmBankForm.get('confirmingBankFourthAddress').patchValue(advThruConf.adviceThroughFourthdAddress);
    }
}
}

}
