import { UiService } from './../../../common/services/ui-service';
import { Component, Input, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { DynamicDialogRef } from 'primeng';
import { ConfirmationService, SelectItem } from 'primeng/api';
import { FccGlobalConstantService } from '../../../../../../common/core/fcc-global-constant.service';
import { CommonService } from '../../../../../../common/services/common.service';
import { EventEmitterService } from '../../../../../../common/services/event-emitter-service';
import { ResolverService } from '../../../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../../../common/services/search-layout.service';
import { ProductStateService } from '../../../../../../corporate/trade/lc/common/services/product-state.service';
import { CustomCommasInCurrenciesPipe } from '../../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../../../lc/initiation/services/filelist.service';
import { UtilityService } from '../../../../lc/initiation/services/utility.service';
import { UiProductComponent } from '../ui-product/ui-product.component';
import { FCCFormGroup } from './../../../../../../base/model/fcc-control.model';
import { FccBusinessConstantsService } from './../../../../../../common/core/fcc-business-constants.service';
import { FccGlobalConstant } from './../../../../../../common/core/fcc-global-constants';
import { CorporateCommonService } from './../../../../../../corporate/common/services/common.service';
import { CurrencyConverterPipe } from './../../../../lc/initiation/pipes/currency-converter.pipe';
import { UiProductService } from '../../../services/ui-product.service';
import { HOST_COMPONENT } from './../../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
@Component({
  selector: 'app-ui-shipment-details',
  templateUrl: './ui-shipment-details.component.html',
  styleUrls: ['./ui-shipment-details.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: UiShipmentDetailsComponent }]
})
export class UiShipmentDetailsComponent extends UiProductComponent implements OnInit {

  module = ``;
  form: FCCFormGroup;
  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  swiftXChar: any;
  readonly = 'readonly';
  params = 'params';
  purchasetermsvalue: SelectItem[] = [];
  termValues = [];
  incoTermsRules = [];
  incotermsDetails: any;
  option;
  transmissionMode: any;
  constructor(protected translateService: TranslateService, protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService, protected commonService: CommonService,
              protected corporateCommonService: CorporateCommonService, protected fccGlobalConstantService: FccGlobalConstantService,
              protected confirmationService: ConfirmationService, protected uiService: UiService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected uiProductService: UiProductService) {
              super(eventEmitterService, productStateService, commonService, translateService, confirmationService,
                customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray,
                dialogRef, currencyConverterPipe, uiProductService);
}

  ngOnInit(): void {
    this.getIncotermsDetails();
    this.initializeFormGroup();
    this.transmissionMode =
    this.productStateService.getSectionData(FccGlobalConstant.UI_GENERAL_DETAIL, undefined, this.isMasterRequired).get('advSendMode').value;
    this.form.get('purchaseTermsValue')[this.params][this.readonly] = this.form.get('incoTermsRules').value ? false : true;
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      this.swiftXChar = response.swiftXCharacterSet;
      if (this.transmissionMode === FccBusinessConstantsService.SWIFT) {
        this.form.addFCCValidators('shipmentForm', Validators.pattern(this.swiftXChar), 0);
        this.form.addFCCValidators('shipmentTo', Validators.pattern(this.swiftXChar), 0);
        this.form.addFCCValidators('shipmentPlaceOfLoading', Validators.pattern(this.swiftXChar), 0);
        this.form.addFCCValidators('shipmentPlaceOfDischarge', Validators.pattern(this.swiftXChar), 0);
      }
    });
    if (this.form.get('incoTermsRules') && this.form.get('incoTermsRules').value && this.context !== 'view') {
      this.setPurchaseTermField();
   }

  }

  initializeFormGroup() {
    const form = this.parentForm.controls[this.controlName];
    if (form !== null) {
      this.form = form as FCCFormGroup;
    }
    this.patchFieldParameters(this.form.get('incoTermsRules'), { options: this.incoTermsRules });
    this.patchFieldParameters(this.form.get('purchaseTermsValue'), { amendinfo: true });
  }

  ngOnDestroy() {
    this.parentForm.controls[this.controlName] = this.form;
  }

  onClickShipmentLastDate() {
    const lastShipmentDate = this.form.get('shipmentLastDate').value;
    const expDate = this.uiService.getBgExpDate();
    this.uiService.calculateShipmentDate(lastShipmentDate, expDate, this.form.get('shipmentLastDate'));

  }
  getIncotermsDetails() {
    this.corporateCommonService.getValues(this.fccGlobalConstantService.incotermDetails).subscribe(
      response => {
        if (response.status === FccGlobalConstant.LENGTH_200) {
         // let sectionForm2: FCCFormGroup;
          const sectionForm: FCCFormGroup = this.productStateService.getSectionData(
            FccGlobalConstant.UI_BANK_DETAILS,
            undefined,
            this.isMasterRequired
          );
        //  sectionForm2 = sectionForm.get('uiIssuingBank') as FCCFormGroup;
          /* if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
            bankName = sectionForm.get('uiBankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS] ?
              sectionForm.get('uiBankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS][0].value :
              sectionForm.get('uiBankNameList').value;
          } else { */
         const bankName = sectionForm.get('uiBankNameList').value;
         // }
          if (bankName !== undefined || bankName !== '') {
            this.handleIncoTerms(response, bankName);
          }
        }
      });
  }

  protected handleIncoTerms(response: any, bankName: any) {
    this.incotermsDetails = response.body.incotermDetailsList;
    if (this.incotermsDetails !== undefined && this.incotermsDetails.length > 0) {
      for (const i of this.incotermsDetails) {
        const respBank = i.bankName;
        if (bankName === respBank) {
          const largeParamKeyListarr = i.largeParamKeyList;
          for (const j of largeParamKeyListarr) {
            const incoRules = j.incotermsRules;
            this.incoTermsRules.push({ label: incoRules, value: incoRules });
          }
        }
      }
    }
  }

  setPurchaseTermField() {
    if (this.form.get('incoTermsRules').value) {
      this.form.get('purchaseTermsValue')[this.params][this.readonly] = false;
      this.setMandatoryField(this.form, 'purchaseTermsValue', true);
      this.setPurchaseTerms();
    }
  }

  setPurchaseTerms() {
    const incotermValue = this.form.get('incoTermsRules').value;
  //  let sectionForm2: FCCFormGroup;
    const sectionForm = this.productStateService.getSectionData(FccGlobalConstant.UI_BANK_DETAILS, undefined, this.isMasterRequired);
   // sectionForm2 = sectionForm.get('uiIssuingBank') as FCCFormGroup;
    /* if (this.tnxTypeCode === FccGlobalConstant.N002_AMEND) {
      bankName = sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS] ?
                sectionForm2.get('bankNameList')[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS][0].value :
                sectionForm2.get('bankNameList').value;
    } else { */
    const bankName = sectionForm.get('uiBankNameList').value;
   // }
    if (bankName !== undefined || bankName !== '') {
      if (this.incotermsDetails !== undefined && this.incotermsDetails.length > 0) {
      for (let i = 0; i < this.incotermsDetails.length; i++) {
        const respBank = this.incotermsDetails[i].bankName;
        if (bankName === respBank) {
          const largeParamKeyListarr = this.incotermsDetails[i].largeParamKeyList;
          for (let j = 0; j < largeParamKeyListarr.length; j++) {
            const incoRules = largeParamKeyListarr[j].incotermsRules;
            if (incotermValue === incoRules) {
              this.termValues = [];
              const incoparams = largeParamKeyListarr[j].incotermValues;
              for (let k = 0; k < incoparams.length; k++) {
                this.termValues.push({ label: `${this.translateService.instant(incoparams[k])}`, value: incoparams[k] });
              }

            }
          }
        }

      }
    }
    }
    this.patchFieldParameters(this.form.get('purchaseTermsValue'), { options: this.termValues });
  }

  onClickIncoTermsRules() {
    if (this.form.get('incoTermsRules').value) {
      this.form.get('purchaseTermsValue')[this.params][this.readonly] = false;
      this.setMandatoryField(this.form, 'purchaseTermsValue', true);
      this.setPurchaseTerms();
    }
    this.removeMandatory(['purchaseTermsValue']);
  }

  removeMandatory(fields: any) {
    if (this.option === FccGlobalConstant.TEMPLATE) {
      this.setMandatoryFields(this.form, fields, false);
    }
  }

  onChangeincoTermsRules() {
    this.form.get('purchaseTermsValue').setValue('');
    this.form.get('namedPlace').setValue('');
    this.setMandatoryField(this.form, 'namedPlace', false);
    this.form.get('namedPlace').updateValueAndValidity();

  }

  onClickPurchaseTermsValue(event) {
    const termsValue = event.value;
    if (termsValue !== undefined) {
      if (termsValue !== '') {
        this.setMandatoryField(this.form, 'namedPlace', true);
      } else if (termsValue === '') {
        this.form.get('namedPlace').reset();
        this.setMandatoryField(this.form, 'namedPlace', false);
        if (this.transmissionMode === FccBusinessConstantsService.SWIFT) {
          this.form.get('namedPlace').setValidators([ Validators.pattern(this.fccGlobalConstantService.getSwiftRegexPattern())]);
        }
        this.form.get('namedPlace').setValidators([Validators.maxLength(FccGlobalConstant.LENGTH_60)]);
      }
      this.form.get('namedPlace').updateValueAndValidity();
    }
    this.removeMandatory(['namedPlace']);
  }

}
