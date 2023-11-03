import { Component, Input, OnInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { FccTradeFieldConstants } from './../../../../common/fcc-trade-field-constants';
import { CurrencyConverterPipe } from './../../../../lc/initiation/pipes/currency-converter.pipe';
import { expiryDateGreaterThanContractDate } from '../../../../../trade/lc/initiation/validator/ValidateDates';
import { FCCFormGroup } from '../../../../../../base/model/fcc-control.model';
import { CodeData } from '../../../../../../common/model/codeData';
import { CommonService } from '../../../../../../common/services/common.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { ProductStateService } from '../../../../lc/common/services/product-state.service';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { UtilityService } from '../../../../lc/initiation/services/utility.service';
import { UiService } from '../../../common/services/ui-service';
import { UiProductComponent } from '../ui-product/ui-product.component';
import { FccGlobalConstant } from './../../../../../../common/core/fcc-global-constants';
import { LeftSectionService } from './../../../../../common/services/leftSection.service';
import { UiProductService } from '../../../services/ui-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { Validators } from '@angular/forms';
import { FccBusinessConstantsService } from './../../../../../../common/core/fcc-business-constants.service';

@Component({
  selector: 'app-ui-type-expiry-details',
  templateUrl: './ui-type-expiry-details.component.html',
  styleUrls: ['./ui-type-expiry-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: UiTypeExpiryDetailsComponent }]
})
export class UiTypeExpiryDetailsComponent extends UiProductComponent implements OnInit {

  module = ``;
  form: FCCFormGroup;
  codeDataRequest = new CodeData();
  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  option: any;
  enquiryRegex = '';
  transmissionMode: any;
  productCode;
  fieldNames = [];
  regexType: string;
  swiftZchar;
  swiftXChar;

  constructor(protected translateService: TranslateService, protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService, protected commonService: CommonService,
              protected leftSectionService: LeftSectionService, protected uiService: UiService,
              protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected uiProductService: UiProductService
              ) {
              super(eventEmitterService, productStateService, commonService, translateService, confirmationService,
                customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray, dialogRef,
                currencyConverterPipe, uiProductService);
}

  ngOnInit(): void {
    this.initializeFormGroup();
    this.initializeFormValues();
    this.transmissionMode = this.productStateService.getSectionData(FccGlobalConstant.UI_GENERAL_DETAIL, undefined, this.isMasterRequired)
    .get('advSendMode').value;
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.enquiryRegex = response.swiftZChar;
        this.swiftXChar = response.swiftXCharacterSet;
      }
    });
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    this.productCode = this.commonService.getQueryParametersFromKey (FccGlobalConstant.PRODUCT);
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryFields(this.form, ['bgTypeCode', 'bgExpDate'], false);
      this.form.get('bgTypeCode').clearValidators();
      this.form.updateValueAndValidity();
    }
    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND){
      this.setMandatoryFields(this.form, ['bgTypeCode'], false);
      this.form.get('bgTypeCode').clearValidators();
      this.form.updateValueAndValidity();
      if (mode === FccGlobalConstant.DRAFT_OPTION || mode === FccGlobalConstant.EXISTING) {
        this.onClickBgIssDateTypeCode();
      }
    }
    this.fieldNames = ['bgExpEvent'];
  }

  initializeFormGroup() {
    const form = this.parentForm.controls[this.controlName];
    if (form !== null) {
      this.form = form as FCCFormGroup;
    }

    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
    }

  }

  amendFormFields() {
    this.form.get('bgTypeCode')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    this.form.get('bgTypeDetails')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    this.form.get('bgIssDateTypeCodeLabel')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    this.form.get('bgIssDateTypeCode')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    this.form.get('bgIssDateTypeDetails')[FccGlobalConstant.PARAMS][FccGlobalConstant.RENDERED] = false;
    this.form.get(FccGlobalConstant.EXPDATETYPECODELABEL)[this.params][FccGlobalConstant.RENDERED] = false;
}

  onClickBgTypeCode() {
    // show byTypedetails field , when other is selected.
    if (this.form.get('bgTypeCode').value === '99') {
      this.toggleControls(this.form, ['bgTypeDetails'], true);
      this.form.get('bgTypeDetails')[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = true;
      if (this.option === FccGlobalConstant.TEMPLATE) {
        this.setMandatoryField(this.form, 'bgTypeDetails', false);
      }
    } else {
      this.toggleControls(this.form, ['bgTypeDetails'], false);
      this.form.get('bgTypeDetails')[FccGlobalConstant.PARAMS][FccGlobalConstant.REQUIRED] = false;
      this.form.get('bgTypeDetails').clearValidators();
    }
  }

  onClickBgIssDateTypeCode() {
    // show bgIssDateTypeDetails field , when 04 is selected.
    if (this.form.get('bgIssDateTypeCode') && this.form.get('bgIssDateTypeCode').value === '99') {
      this.toggleControls(this.form, ['bgIssDateTypeDetails'], true);
      this.setMandatoryField(this.form, 'bgIssDateTypeDetails', true);
      if (this.option === FccGlobalConstant.TEMPLATE) {
        this.setMandatoryField(this.form, 'bgIssDateTypeDetails', false);
      }
      this.togglePreviewScreen(this.form, [FccTradeFieldConstants.ISSUE_DATETYPE_DETAILS], false);

      this.form.get('bgIssDateTypeDetails').updateValueAndValidity();
    } else {
      this.toggleControls(this.form, ['bgIssDateTypeDetails'], false);
      this.setMandatoryField(this.form, 'bgIssDateTypeDetails', false);
      this.form.get('bgIssDateTypeDetails').updateValueAndValidity();
    }
    this.onClickBgIssDateTypeDetails();
  }

  onClickBgIssDateTypeDetails() {
    const expDate = this.form.get('bgExpDate').value;
    const effectiveDate = this.form.get('bgIssDateTypeDetails').value;
    if (this.form.get('bgIssDateTypeCode') && this.form.get('bgIssDateTypeCode').value === '99') {
    this.uiService.calculateExpiryDate(effectiveDate, expDate, this.form.get('bgExpDate'));
    } else {
      this.uiService.calculateExpiryDate('', expDate, this.form.get('bgExpDate'));
    }
  }

  onClickBgExpDateTypeCode() {
    const formAccordionPanels = this.parentForm.get(FccGlobalConstant.UI_UNDERTAKING_DETAILS)[
      FccGlobalConstant.PARAMS
    ][`formAccordionPanels`];
    this.form.get('bgExpDate').clearValidators();
    this.form.get('bgExpDate').updateValueAndValidity();
    if (this.form.get('bgExpDateTypeCode') && this.form.get('bgExpDateTypeCode').value === '01') {
      // this.toggleFormFields(true, this.form, ['bgApproxExpiryDate', 'bgExpEvent']);
      this.toggleControls(this.form, ['bgApproxExpiryDate', 'bgExpEvent'], true);
      this.toggleControls(this.form, ['bgExpDate'], false);
      this.toggleRequired(false, this.form, ['bgExpDate', 'bgExpEvent']);
      this.form.get(FccGlobalConstant.BG_EXPIRY_EVENT).clearValidators();
      this.form.get(FccGlobalConstant.BG_EXPIRY_EVENT).updateValueAndValidity();
      if (this.option === FccGlobalConstant.TEMPLATE) {
        this.setMandatoryFields(this.form, ['bgExpEvent'], false);
      }
      if (this.transmissionMode === FccBusinessConstantsService.SWIFT) {
        this.fieldNames.forEach(ele => {
          this.form.get(ele).clearValidators();
           this.regexType = this.form.get(ele)[FccGlobalConstant.PARAMS]['applicableValidation'][0]['characterValidation'];
          if (this.regexType === FccGlobalConstant.SWIFT_X) {
            this.regexType = this.swiftXChar;
          } else if (this.regexType === FccGlobalConstant.SWIFT_Z) {
            this.regexType = this.enquiryRegex;
          }
          if (this.commonService.validateProduct(this.form, ele, this.productCode)) {
            this.form.addFCCValidators(ele, Validators.pattern(this.regexType), 0);
            }
        });
      }
      this.toggleControls(this.form, ['bgProjectedExpiryDate'], false);
      this.form.get('bgApproxExpiryDate')[FccGlobalConstant.PARAMS][FccGlobalConstant.LABEL] =
      `${this.translateService.instant('bgApproxExpiryDate')}`;
      this.form.get('bgProjectedExpiryDate').reset();
      this.form.get('bgExpDate').reset();
      // Hide Extension Details Section.
      this.toggelFormAccordionPanel(this.parentForm, formAccordionPanels, [FccGlobalConstant.UI_EXTENSION_DETAILS], false);
    } else if (this.form.get('bgExpDateTypeCode') && this.form.get('bgExpDateTypeCode').value === '03') {
      this.toggleControls(this.form, ['bgProjectedExpiryDate', 'bgExpEvent'], true);
      this.form.get('bgProjectedExpiryDate')[FccGlobalConstant.PARAMS][FccGlobalConstant.LABEL] =
      `${this.translateService.instant('bgProjectedExpiryDate')}`;
      if (this.transmissionMode === FccBusinessConstantsService.SWIFT) {
        this.fieldNames.forEach(ele => {
          this.form.get(ele).clearValidators();
           this.regexType = this.form.get(ele)[FccGlobalConstant.PARAMS]['applicableValidation'][0]['characterValidation'];
          if (this.regexType === FccGlobalConstant.SWIFT_X) {
            this.regexType = this.swiftXChar;
          } else if (this.regexType === FccGlobalConstant.SWIFT_Z) {
            this.regexType = this.enquiryRegex;
          }
          if (this.commonService.validateProduct(this.form, ele, this.productCode)) {
            this.form.addFCCValidators(ele, Validators.pattern(this.regexType), 0);
            }
        });
      }
      this.toggleRequired(true, this.form, ['bgExpEvent']);
      this.toggleControls(this.form, ['bgExpDate'], false);
      this.toggleRequired(false, this.form, ['bgExpDate']);
      this.toggleControls(this.form, ['bgApproxExpiryDate'], false);
      this.form.get('bgApproxExpiryDate').reset();
      this.form.get('bgExpDate').reset();
      if (this.option === FccGlobalConstant.TEMPLATE) {
        this.setMandatoryFields(this.form, ['bgExpEvent'], false);
      }
      // Hide Extension Details Section.
      this.toggelFormAccordionPanel(this.parentForm, formAccordionPanels, [FccGlobalConstant.UI_EXTENSION_DETAILS], false);
    } else {
      this.toggleControls(this.form, ['bgExpDate'], true);
      this.toggleRequired(true, this.form, ['bgExpDate']);
      this.toggleControls(this.form, ['bgApproxExpiryDate', 'bgProjectedExpiryDate', 'bgExpEvent'], false);
      this.toggleRequired(false, this.form, ['bgExpEvent']);
      this.form.get(FccGlobalConstant.BG_EXPIRY_EVENT).clearValidators();
      this.form.get(FccGlobalConstant.BG_EXPIRY_EVENT).updateValueAndValidity();
      if (this.option === FccGlobalConstant.TEMPLATE) {
        this.setMandatoryFields(this.form, ['bgExpDate'], false);
      }
      this.form.get('bgApproxExpiryDate').reset();
      this.form.get('bgProjectedExpiryDate').reset();
      // Show Extension Details Section
      this.toggelFormAccordionPanel(this.parentForm, formAccordionPanels, [FccGlobalConstant.UI_EXTENSION_DETAILS], true);
    }
    this.form.updateValueAndValidity();
  }

  onClickBgExpDate() {
    this.uiService.calculateFinalExpiryDate();
    // this.onClickBgIssDateTypeDetails();
    const bgExpDate = this.form.get('bgExpDate').value;
    const contractDate = this.stateService.getSectionData(FccGlobalConstant.UI_UNDERTAKING_DETAILS)
      .get(FccGlobalConstant.UI_CONTRACT_DETAILS).get('contractDate').value;
    const effectiveDate = this.form.get('bgIssDateTypeDetails').value;
    const bgIssDateTypeCode = this.form.get('bgIssDateTypeCode');
    if (bgExpDate !== null && bgExpDate !== '') {
      if (contractDate && contractDate !== '' ) {
        this.checkContractDate();
      }
      if (bgIssDateTypeCode && bgIssDateTypeCode.value === '99' && effectiveDate && effectiveDate !== '') {
        this.uiService.calculateExpiryDate(effectiveDate, bgExpDate, this.form.get('bgExpDate'));
      }
    } else {
      this.form.get('bgExpDate').clearValidators();
    }
  }

  checkContractDate() {
    const contractDate = this.stateService.getSectionData(FccGlobalConstant.UI_UNDERTAKING_DETAILS)
      .get(FccGlobalConstant.UI_CONTRACT_DETAILS).get('contractDate').value;
    const expiryDate = this.stateService.getSectionData(FccGlobalConstant.UI_UNDERTAKING_DETAILS)
      .get('uiTypeAndExpiry').get('bgExpDate').value;
    if (contractDate && contractDate !== '' && expiryDate !== '' && (contractDate > expiryDate)) {
      this.form.get('bgExpDate').setValidators([expiryDateGreaterThanContractDate]);
    } else {
      this.stateService.getSectionData(FccGlobalConstant.UI_UNDERTAKING_DETAILS)
      .get(FccGlobalConstant.UI_CONTRACT_DETAILS).get('contractDate').clearValidators();
    }
    this.form.get('bgExpDate').updateValueAndValidity();
    this.stateService.getSectionData(FccGlobalConstant.UI_UNDERTAKING_DETAILS)
      .get(FccGlobalConstant.UI_CONTRACT_DETAILS).get('contractDate').updateValueAndValidity();
  }

  initializeFormValues() {
    this.codeDataRequest.codeId = FccGlobalConstant.CODEDATA_UI_UNDERTAKING_TYPE_CODES_C082;
    this.codeDataRequest.productCode = FccGlobalConstant.PRODUCT_BG;
    this.codeDataRequest.subProductCode = this.productStateService
    .getSectionData(FccGlobalConstant.UI_GENERAL_DETAIL)
    .get("bgSubProductCode").value;
    this.codeDataRequest.language = localStorage.getItem(FccGlobalConstant.LANGUAGE) !== null ?
    localStorage.getItem(FccGlobalConstant.LANGUAGE) : '';
    const typeOfUndertakingArray = [];
    this.commonService.getCodeDataDetails(this.codeDataRequest).subscribe(response => {
      response.body.items.forEach(responseValue => {
          const typeOfUndertaking: { label: string; value: any } = {
            label: responseValue.longDesc,
            value: responseValue.value
          };
          if (responseValue.value !== '*') {
          typeOfUndertakingArray.push(typeOfUndertaking);
          }
        });
      this.form.get('bgTypeCode')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS] = typeOfUndertakingArray;
    });
    // Set required fields value on form load.
    this.onClickBgExpDateTypeCode();
    this.onClickBgExpDate();
    const tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    const option = this.uiService.getOption();
    const mode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE);
    if (tnxTypeCode === FccGlobalConstant.N002_NEW &&
      (option === FccGlobalConstant.EXISTING_OPTION || option === FccGlobalConstant.TEMPLATE
        || mode === FccGlobalConstant.DRAFT_OPTION)) {
      this.onClickBgTypeCode();
      this.onClickBgIssDateTypeCode();
    }
  }

  ngOnDestroy() {
    this.parentForm.controls[this.controlName] = this.form;
  }

}
