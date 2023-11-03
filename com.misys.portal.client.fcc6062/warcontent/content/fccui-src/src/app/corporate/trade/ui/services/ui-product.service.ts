import { FccBusinessConstantsService } from './../../../../common/core/fcc-business-constants.service';
import { AmendCommonService } from './../../../common/services/amend-common.service';
import { Injectable } from '@angular/core';
import { ProductValidator } from '../../../common/validator/productValidator';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from '../../../../common/services/common.service';
import { FCCFormGroup } from '../../../../base/model/fcc-control.model';
import { FccGlobalConstant } from '../../../../common/core/fcc-global-constants';
import { EventEmitterService } from '../../../../common/services/event-emitter-service';
import { ProductStateService } from '../../lc/common/services/product-state.service';

@Injectable({
  providedIn: 'root'
})
export class UiProductService implements ProductValidator{
  tnxTypeCode: any;
  isMasterRequired: boolean;

  constructor(protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService,
              protected commonService: CommonService,
              protected translateService: TranslateService,
              protected amendCommonService: AmendCommonService) { }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  beforeSaveValidation(form?: any): boolean {
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    return true;
  }
  beforeSubmitValidation(): boolean {
    this.isMasterRequired = this.commonService.isMasterRequired;
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    const isValid = this.validate();
    this.eventEmitterService.subFlag.next(isValid);
    return true;
  }

  validate() {
    let isValid = false;
    let sectionForm: FCCFormGroup;
    if (this.tnxTypeCode == null) {
      this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    }
    if (this.tnxTypeCode !== FccGlobalConstant.N002_INQUIRE) {
      sectionForm = this.productStateService.getSectionData('uiGeneralDetails', FccGlobalConstant.PRODUCT_BG, this.isMasterRequired);
      // Do Business Validation
    } else {
      sectionForm = this.productStateService.getSectionData('uiTransactionBrief', FccGlobalConstant.PRODUCT_BG, this.isMasterRequired);
    }
    if (sectionForm) {
      isValid = true;
    }
    return isValid;
  }

  toggleFormFields(showField, form, fieldsToToggle) {
    if (showField) {
      fieldsToToggle.forEach(ele => {
        form.get(ele)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = true;
      });
    } else {
      fieldsToToggle.forEach(ele => {
        form.get(ele)[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
      });
    }
  }

  toggleRequired(setRequired, form, fieldsToToggle) {
    if (setRequired) {
      fieldsToToggle.forEach(ele => {
        form.get(ele)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      });
    } else {
      fieldsToToggle.forEach(ele => {
        form.get(ele)[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      });
    }
  }

  uiUndertakingDetailsAfterViewInit(form: FCCFormGroup) {
    const tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    const formAccordionPanels = form.get('uiUndertakingDetails')[FccGlobalConstant.PARAMS][`formAccordionPanels`];
    // Show shipment and payment details sections, only for STBY.
    if (tnxTypeCode === FccGlobalConstant.N002_NEW || tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      const generalDetailsForm: FCCFormGroup =
      this.productStateService.getSectionData(FccGlobalConstant.UI_GENERAL_DETAIL, undefined, this.isMasterRequired);
      const toggleSections = [FccGlobalConstant.UI_SHIPMENT_DETAILS, FccGlobalConstant.UI_PAYMENT_DETAILS];

      if (generalDetailsForm.get('bgSubProductCode') &&
      (generalDetailsForm.get('bgSubProductCode').value === FccGlobalConstant.STBY
      || generalDetailsForm.get('bgSubProductCode').value[0].value === FccGlobalConstant.STBY)) {
        this.toggelFormAccordionPanel(form, formAccordionPanels, toggleSections, true);
      } else {
        this.toggelFormAccordionPanel(form, formAccordionPanels, toggleSections, false);
      }
    }
    // Hide Terms Panel for Amend
    if (tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.toggelFormAccordionPanel(form, formAccordionPanels, [FccGlobalConstant.UI_TERMS], false);
    }

    // Show extension section only in case of Fixed Expiry type(02).
    const typeExpiryForm = form.get('uiTypeAndExpiry');
    if (typeExpiryForm.get('bgExpDateTypeCode') && (typeExpiryForm.get('bgExpDateTypeCode').value === '01'
    || typeExpiryForm.get('bgExpDateTypeCode').value === '03')) {
      this.toggelFormAccordionPanel(form, formAccordionPanels, [FccGlobalConstant.UI_EXTENSION_DETAILS], false);
    } else {
      this.toggelFormAccordionPanel(form, formAccordionPanels, [FccGlobalConstant.UI_EXTENSION_DETAILS], true);
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.undertakingAmendFormFields();
    }
  }

  undertakingAmendFormFields() {
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    const operation = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION);
    if (mode !== FccGlobalConstant.VIEW_MODE && operation !== FccGlobalConstant.PREVIEW) {
    this.amendCommonService.setValueFromMasterToPrevious(FccGlobalConstant.UI_UNDERTAKING_DETAILS);
    }
   }

   toggelFormAccordionPanel(form: FCCFormGroup, formAccordionPanels: any[], controls: string[], rendered: boolean) {
    for (let i = 0; i < formAccordionPanels.length ; i++) {
      const accordion = formAccordionPanels[i];
      const controlName = accordion.controlName;
      if (controls.indexOf(controlName) > -1) {
        accordion.rendered = rendered;
        const subsectionForm = form.controls[controlName] as FCCFormGroup;
        subsectionForm[FccGlobalConstant.RENDERED] = rendered;
        form.controls[controlName] = subsectionForm;
        form.updateValueAndValidity();
      }
    }
  }


  uiBankDetailsAfterViewInit(subProductValue: string, confirmationPartyValue: string, form: FCCFormGroup, event: any) {
    const confirmingBankFields = ['confirmingBankIcons', 'confirmingSwiftCode', 'confirmingBankName',
  'confirmingBankFirstAddress', 'confirmingBankSecondAddress', 'confirmingBankThirdAddress'];
    if (subProductValue === FccGlobalConstant.STBY && confirmationPartyValue !== FccBusinessConstantsService.WITHOUT_03) {
      if (form.get('uiConfirmingBank')) {
        confirmingBankFields.forEach(id => this.toggleControl(form.get('uiConfirmingBank'), id, true));
        form.get('uiConfirmingBank')[FccGlobalConstant.RENDERED] = true;
      }
    } else {
      // elementRef.nativeElement.querySelectorAll('.mat-tab-label.mat-focus-indicator.mat-ripple')
      event.get("bankDetailsTab").get("querySelectorAllValue")[
        FccGlobalConstant.LENGTH_3
      ].style.display = "none";

      if (form.get('uiConfirmingBank')) {
      form.get('uiConfirmingBank').reset();
      confirmingBankFields.forEach(id => this.toggleControl(form.get('uiConfirmingBank'), id, false));
      form.get('uiConfirmingBank')[FccGlobalConstant.RENDERED] = false;
      }
    }
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendCommonService.setValueFromMasterToPrevious(FccGlobalConstant.UI_BANK_DETAILS);
    }
  }

  toggleControl(form, id, flag) {
    form.controls[id].params.rendered = flag;
  }

}
