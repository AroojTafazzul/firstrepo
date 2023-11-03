import { Component, ElementRef, Input, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { LcProductService } from '../../../../services/lc-product.service';
import { PhrasesService } from '../../../../../../../common/services/phrases.service';
import { ResolverService } from '../../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../../common/services/search-layout.service';
import { LcConstant } from '../../../../common/model/constant';
import { CurrencyConverterPipe } from '../../../pipes/currency-converter.pipe';
import { CustomCommasInCurrenciesPipe } from '../../../pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../services/filelist.service';
import { UtilityService } from '../../../services/utility.service';
import { LcProductComponent } from '../../lc-product/lc-product.component';
import { FCCFormGroup } from './../../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from './../../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstant } from './../../../../../../../common/core/fcc-global-constants';
import { CommonService } from './../../../../../../../common/services/common.service';
import { EventEmitterService } from './../../../../../../../common/services/event-emitter-service';
import { ProductStateService } from './../../../../common/services/product-state.service';
import { FormControlService } from './../../../services/form-control.service';
import { NarrativeService } from './../../../services/narrative.service';
import { HOST_COMPONENT } from './../../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-period-for-presentation',
  templateUrl: './period-for-presentation.component.html',
  styleUrls: ['./period-for-presentation.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: PeriodForPresentationComponent }]
})
export class PeriodForPresentationComponent extends LcProductComponent implements OnInit {

  form: FCCFormGroup;
  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  lcConstant = new LcConstant();
  module = '';
  element = 'periodOfPresentationText';
  swiftZCharRegex: string;
  swiftXCharRegex: string;
  swiftExtendedNarrativeEnable: boolean;
  paramDataList: any[] = [];
  modeOfTransmission;
  descOfGoodsRowCount: number;
  maxLength = this.lcConstant.maxlength;
  maxRowCount = this.lcConstant.maxRowCount;
  enteredCharCounts = this.lcConstant.enteredCharCounts;
  allowedCharCount = this.lcConstant.allowedCharCount;
  params = this.lcConstant.params;
  swift = 'swift';
  rendered = this.lcConstant.rendered;
  tnxTypeCode: any;
  phrasesResponseForPeriodOfPresent: any;
  displayValue: string;
  finalTextValue = '';
  entityName: any;
  responseData: string;

  constructor(protected emitterService: EventEmitterService, protected stateService: ProductStateService,
              protected formControlService: FormControlService, protected narrativeService: NarrativeService,
              protected fccBusinessConstantsService: FccBusinessConstantsService, protected commonService: CommonService,
              protected elementRef: ElementRef, protected translateService: TranslateService,
              protected searchLayoutService: SearchLayoutService, protected phrasesService: PhrasesService,
              protected confirmationService: ConfirmationService, protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected fileList: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected lcProductService: LcProductService
    ) {
    super(emitterService, stateService, commonService, translateService, confirmationService, customCommasInCurrenciesPipe,
          searchLayoutService, utilityService, resolverService, fileList, dialogRef, currencyConverterPipe, lcProductService);
   }

  ngOnInit(): void {
    const obj = this.parentForm.controls[this.controlName];
    if (obj !== null) {
        this.form = obj as FCCFormGroup;
    }
    this.modeOfTransmission = this.stateService.getSectionData(FccGlobalConstant.GENERAL_DETAILS).get('transmissionMode').value;
    this.configAndValidations();
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    if (this.tnxTypeCode === FccGlobalConstant.N002_NEW) {
      this.form.get(this.element)[this.params][FccGlobalConstant.PHRASE_ENABLED] = true;
    } else {
      this.form.get(this.element)[this.params][FccGlobalConstant.PHRASE_ENABLED] = false;
    }
    this.form.addFCCValidators('nbdays', Validators.pattern(FccGlobalConstant.numberPattern), 0);
    this.updateNarrativeCount();
  }

  updateNarrativeCount() {
    if (this.form.get('periodOfPresentationText').value) {
      const count = this.commonService.counterOfPopulatedData(this.form.get('periodOfPresentationText').value);
      this.form.get('periodOfPresentationText')[this.params][this.enteredCharCounts] = count;
    }
  }

  configAndValidations() {
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.swiftZCharRegex = response.swiftZChar;
        this.swiftXCharRegex = response.swiftXCharacterSet;
        if ((this.modeOfTransmission === FccBusinessConstantsService.SWIFT)
        || (this.modeOfTransmission[0] && this.modeOfTransmission[0].value === FccBusinessConstantsService.SWIFT)) {
          this.form.addFCCValidators(this.element, Validators.pattern(this.swiftXCharRegex), 0);
          this.form.get(this.element).updateValueAndValidity();
        } else {
          this.form.get(this.element).setValidators([]);
          this.form.get(this.element).updateValueAndValidity();
        }
      }
    });
  }

  onClickPhraseIcon(event, key) {
    this.entityName = this.stateService.getSectionData(FccGlobalConstant.APPLICANT_BENEFICIARY).get('applicantEntity').value.shortName;
    if (this.entityName !== '' && this.entityName !== undefined) {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '07', true, this.entityName);
    } else {
      this.phrasesService.getPhrasesDetails(this.form, FccGlobalConstant.PRODUCT_LC, key, '07', true);
    }
  }

  ngOnDestroy() {
    this.phrasesResponseForPeriodOfPresent = null;
  }
}
