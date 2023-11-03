import { Component, Input, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { CurrencyConverterPipe } from './../../../../lc/initiation/pipes/currency-converter.pipe';

import { CommonService } from '../../../../../../common/services/common.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { PhrasesService } from '../../../../../../common/services/phrases.service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { LcConstant } from '../../../../../../corporate/trade/lc/common/model/constant';
import { ProductStateService } from '../../../../../../corporate/trade/lc/common/services/product-state.service';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { UtilityService } from '../../../../lc/initiation/services/utility.service';
import { UiProductComponent } from '../ui-product/ui-product.component';
import { FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from './../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstant } from './../../../../../../common/core/fcc-global-constants';
import { UiProductService } from '../../../services/ui-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-ui-narrative',
  templateUrl: './ui-narrative.component.html',
  styleUrls: ['./ui-narrative.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: UiNarrativeComponent }]
})
export class UiNarrativeComponent extends UiProductComponent implements OnInit {

  module = ``;
  form: FCCFormGroup;
  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  constant = new LcConstant();
  params = this.constant.params;
  allowedCharCount = this.constant.allowedCharCount;
  maxlength = this.constant.maximumlength;
  enteredCharCount = 'enteredCharCount';
  modeOfTransmission;
  swiftZChar;
  charCount;
  option: any;
  constructor(protected translateService: TranslateService, protected eventEmitterService: EventEmitterService,
              protected stateService: ProductStateService, protected commonService: CommonService,
              protected phrasesService: PhrasesService, protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected uiProductService: UiProductService) {
              super(eventEmitterService, stateService, commonService, translateService, confirmationService,
                customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray,
                dialogRef, currencyConverterPipe, uiProductService);
}

  ngOnInit(): void {
    this.initializeFormGroup();
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    this.option = this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION);
    if (this.modeOfTransmission === FccBusinessConstantsService.SWIFT) {
      this.charCount = this.form.get('bgNarrativeTextUndertaking')[this.params][this.maxlength];
      this.form.addFCCValidators('bgNarrativeTextUndertaking',
      Validators.compose([Validators.maxLength(this.charCount), Validators.pattern(this.swiftZChar)]), 0);
    }
    if (this.option === FccGlobalConstant.TEMPLATE || this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.setMandatoryFields(this.form, ['bgNarrativeTextUndertaking', 'bgNarrativeUnderlyingTransactionDetails'], false);
      this.form.get('bgNarrativeTextUndertaking').clearValidators();
      this.form.get('bgNarrativeUnderlyingTransactionDetails').clearValidators();
      this.form.updateValueAndValidity();
    }
  }

  initializeFormGroup() {
    const form = this.parentForm.controls[this.controlName];
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.swiftZChar = response.swiftZChar;
      }
    });
    if (form !== null) {
      this.form = form as FCCFormGroup;
    }
    this.modeOfTransmission = this.stateService.getSectionData(FccGlobalConstant.UI_GENERAL_DETAIL, undefined,
      this.isMasterRequired).get('advSendMode').value;
    if (this.modeOfTransmission !== FccBusinessConstantsService.SWIFT) {
      this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.allowedCharCount] = '';
      this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.maxlength] = '';
      this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.enteredCharCount] = '';
      this.form.get('bgNarrativeTextUndertaking')[this.params][this.allowedCharCount] = '';
      this.form.get('bgNarrativeTextUndertaking')[this.params][this.maxlength] = '';
      this.form.get('bgNarrativeTextUndertaking')[this.params][this.enteredCharCount] = '';
      this.form.get('bgNarrativePresentationInstructions')[this.params][this.allowedCharCount] = '';
      this.form.get('bgNarrativePresentationInstructions')[this.params][this.maxlength] = '';
      this.form.get('bgNarrativePresentationInstructions')[this.params][this.enteredCharCount] = '';
      this.form.get('bgNarrativeUnderlyingTransactionDetails').clearValidators();
      this.form.get('bgNarrativeTextUndertaking').clearValidators();
      this.form.get('bgNarrativePresentationInstructions').clearValidators();
    } else {
      this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.allowedCharCount] = '3250';
      this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.maxlength] = '3250';
      this.form.get('bgNarrativeTextUndertaking')[this.params][this.allowedCharCount] = '9750';
      this.form.get('bgNarrativeTextUndertaking')[this.params][this.maxlength] = '9750';
      this.form.get('bgNarrativePresentationInstructions')[this.params][this.allowedCharCount] = '6500';
      this.form.get('bgNarrativePresentationInstructions')[this.params][this.maxlength] = '6500';
      this.form.addFCCValidators('bgNarrativeTextUndertaking', Validators.pattern(this.swiftZChar), 0);
      this.form.addFCCValidators('bgNarrativeUnderlyingTransactionDetails', Validators.pattern(this.swiftZChar), 0);
      this.form.addFCCValidators('bgNarrativePresentationInstructions', Validators.pattern(this.swiftZChar), 0);
    }

    if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      this.amendFormFields();
    }
    this.resetValidationForTextUndertaking();
  }

  amendFormFields() {

    this.toggleControls(this.form, ['bgNarrativeUnderlyingTransactionDetails'], false);
    this.toggleControls(this.form, ['bgNarrativePresentationInstructions'], false);
    this.toggleControls(this.form, ['bgNarrativeTextUndertaking'], false);

}
  onClickPhraseIcon(event, key) {
    this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_BG, key, '', true);
  }

  onBlurBgNarrativeTextUndertaking() {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryField(this.form, 'bgNarrativeTextUndertaking', false);
      this.form.get('bgNarrativeTextUndertaking').clearValidators();
      if (this.modeOfTransmission !== FccBusinessConstantsService.SWIFT) {
        this.form.get('bgNarrativeTextUndertaking')[this.params][this.allowedCharCount] = '';
        this.form.get('bgNarrativeTextUndertaking')[this.params][this.maxlength] = '';
        this.form.get('bgNarrativeTextUndertaking')[this.params][this.enteredCharCount] = '';
      }
      else {
        this.form.get('bgNarrativeTextUndertaking')[this.params][this.allowedCharCount] = '9750';
        this.form.get('bgNarrativeTextUndertaking')[this.params][this.maxlength] = '9750';
        this.form.addFCCValidators('bgNarrativeTextUndertaking', Validators.pattern(this.swiftZChar), 0);
      }
      this.form.get('bgNarrativeTextUndertaking').updateValueAndValidity();
    }
    this.resetValidationForTextUndertaking();

  }
  // The below changes are done "Text Standard" is selected as "bank standard" then
  // "text of undertaking" need to be set as non-mandatory
  resetValidationForTextUndertaking() {
    const textStandard = this.stateService.getSectionData(FccGlobalConstant.UI_UNDERTAKING_DETAILS,
      undefined, this.isMasterRequired).get('uiTerms').get('bgTextTypeCode').value;
    if (textStandard && textStandard === FccGlobalConstant.BANK_STANDARD) {
      this.setMandatoryField(this.form, 'bgNarrativeTextUndertaking', false);
      this.form.get('bgNarrativeTextUndertaking').clearValidators();
      if (this.modeOfTransmission === FccBusinessConstantsService.SWIFT) {
        this.form.addFCCValidators('bgNarrativeTextUndertaking',
        Validators.compose([Validators.maxLength(this.charCount), Validators.pattern(this.swiftZChar)]), 0);
      }
      this.form.updateValueAndValidity();
    }
  }

  onBlurBgNarrativeUnderlyingTransactionDetails() {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryField(this.form, 'bgNarrativeUnderlyingTransactionDetails', false);
      this.form.get('bgNarrativeUnderlyingTransactionDetails').clearValidators();
      if (this.modeOfTransmission !== FccBusinessConstantsService.SWIFT) {
        this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.allowedCharCount] = '';
        this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.maxlength] = '';
        this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.enteredCharCount] = '';
      }
      else {
        this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.allowedCharCount] = '3250';
        this.form.get('bgNarrativeUnderlyingTransactionDetails')[this.params][this.maxlength] = '3250';
        this.form.addFCCValidators('bgNarrativeUnderlyingTransactionDetails', Validators.pattern(this.swiftZChar), 0);
      }
      this.form.get('bgNarrativeUnderlyingTransactionDetails').updateValueAndValidity();
    }
  }

  ngOnDestroy() {
    this.parentForm.controls[this.controlName] = this.form;
  }

}
