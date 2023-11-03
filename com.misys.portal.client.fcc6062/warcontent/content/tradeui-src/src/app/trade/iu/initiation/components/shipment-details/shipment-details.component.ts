import { CommonDataService } from './../../../../../common/services/common-data.service';
import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { IUCommonDataService } from '../../../common/service/iuCommonData.service';
import { Constants } from '../../../../../common/constants';
import { validateSwiftCharSet, validateDates } from '../../../../../common/validators/common-validator';
import { StaticDataService } from '../../../../../common/services/staticData.service';
import { CommonService } from '../../../../../common/services/common.service';
import { DropdownOptions } from '../../../common/model/DropdownOptions.model';
import { TranslateService } from '@ngx-translate/core';
import { ValidationService } from '../../../../../common/validators/validation.service';

@Component({
  selector: 'fcc-iu-shipment-details',
  templateUrl: './shipment-details.component.html',
  styleUrls: ['./shipment-details.component.scss']
})
export class ShipmentDetailsComponent implements OnInit {

  @Input() public bgRecord;
  @Output() formReady = new EventEmitter<FormGroup>();
  shipmentDetailsSection: FormGroup;
  viewMode: boolean;
  originalShipmentObj: DropdownOptions[] = [];
  tempOriginalShipmentObj: DropdownOptions[] = [];
  incoTermValues: DropdownOptions[] = [];
  incoRulesDropDown: DropdownOptions[] = [];
  yearRange: string;
  partialShipConditional: boolean;
  transShipConditional: boolean;
  namedPlace: boolean;
  collapsible: boolean;
  displayIncoDetails = false;
  displayIncoTerms = false;
  dateFormat: string;
  isExistingDraftMenu: boolean;
  dataToBePersisted = false;
  bankIncoRulesMap = new Map();
  incoRuleTermsMap  = new Map();

  constructor(public fb: FormBuilder, public commonDataService: IUCommonDataService,
              protected staticDataService: StaticDataService, public commonService: CommonService,
              public translate: TranslateService, public readonly commonData: CommonDataService,
              public validationService: ValidationService) { }

  ngOnInit() {
    this.dateFormat = this.commonService.getDateFormat();
    if (this.checkForDataIfPresent() || (this.commonDataService.getDisplayMode() === 'view' && this.checkForDataIfPresent())) {
      this.collapsible = true;
    } else {
      this.collapsible = false;
    }
    this.isExistingDraftMenu = (this.bgRecord.tnxTypeCode === Constants.TYPE_REPORTING
      && this.commonData.getMode() === Constants.MODE_DRAFT);
    this.shipmentDetailsSection = this.fb.group({
      shipFrom: ['', [Validators.maxLength(Constants.LENGTH_65), validateSwiftCharSet(Constants.Z_CHAR)]],
      shipLoading: ['', [Validators.maxLength(Constants.LENGTH_65), validateSwiftCharSet(Constants.Z_CHAR)]],
      shipDischarge: ['', [Validators.maxLength(Constants.LENGTH_65), validateSwiftCharSet(Constants.Z_CHAR)]],
      shipTo: ['', [Validators.maxLength(Constants.LENGTH_65), validateSwiftCharSet(Constants.Z_CHAR)]],
      partShipDetl: [''],
      tranShipDetl: [''],
      lastShipDate: [''],
      incoTermYear: ['', [Validators.maxLength(Constants.LENGTH_10)]],
      incoTerm: [''],
      incoPlace: ['', [Validators.maxLength(Constants.LENGTH_60), validateSwiftCharSet(Constants.Z_CHAR)]],
    });

    this.fetchIncoDetails();

    this.yearRange = this.commonService.getYearRange();
    if (this.commonDataService.getDisplayMode() === 'view' ||
        this.commonDataService.getDisplayMode() === Constants.UNSIGNED_AMEND) {
      this.viewMode = true;
    } else {
      this.viewMode = false;
    }
    this.dataToBePersisted = (this.commonDataService.getOption() === Constants.OPTION_EXISTING ||
                              this.commonDataService.getOption() === Constants.OPTION_TEMPLATE ||
                              this.commonDataService.getMode() === Constants.MODE_DRAFT ||
                              this.commonDataService.getMode() === Constants.MODE_AMEND ||
                              this.commonDataService.getMode() === Constants.OPTION_REJECTED
                              || this.isExistingDraftMenu);

    if (this.dataToBePersisted) {
        this.initFieldValues();
    }

    this.staticDataService.fetchBusinessCodes(Constants.SHIPMENT_DETAILS).subscribe(data => {
      this.tempOriginalShipmentObj = data.dropdownOptions as DropdownOptions[];
      this.tempOriginalShipmentObj.forEach(element => {
        const tempele: any = {};
        this.translate.get(element.label).subscribe((value: string) => {
          tempele.label =  value;
         });
        tempele.value = element.value;
        this.originalShipmentObj.push(tempele);
        if (element.value === this.bgRecord.partShipDetl) {
          this.shipmentDetailsSection.get('partShipDetl').setValue(element.value);
        }
        if (element.value === this.bgRecord.tranShipDetl) {
          this.shipmentDetailsSection.get('tranShipDetl').setValue(element.value);
        }
      });
    });

    if (this.bgRecord[`partShipDetl`] !== 'CONDITIONAL') {
      this.partialShipConditional = false;
    } else {
      this.partialShipConditional = true;
    }
    if (this.bgRecord[`tranShipDetl`] !== 'CONDITIONAL') {
      this.transShipConditional = false;
    } else {
      this.transShipConditional = true;
    }
    this.setSectionValue();
    this.formReady.emit(this.shipmentDetailsSection);
  }

  setSectionValue() {
    if (!(this.bgRecord[`partShipDetl`] && this.bgRecord[`partShipDetl`] !== null
       && this.bgRecord[`partShipDetl`] !== '')) {
       this.shipmentDetailsSection.get(`partShipDetl`).setValue(null);
    }
    if (!(this.bgRecord[`tranShipDetl`] && this.bgRecord[`tranShipDetl`] !== null
       && this.bgRecord[`tranShipDetl`] !== '')) {
       this.shipmentDetailsSection.get(`tranShipDetl`).setValue(null);
    }
  }

  checkForDataIfPresent() {
    const arr = [this.bgRecord.shipFrom, this.bgRecord.shipLoading, this.bgRecord.shipDischarge,
      this.bgRecord.shipTo, this.bgRecord.partShipDetl, this.bgRecord.tranShipDetl,
      this.bgRecord.incoPlace, this.bgRecord.incoTerm, this.bgRecord.lastShipDate];

    return this.commonService.isFieldsValuesExists(arr);
  }

  initFieldValues() {
    this.shipmentDetailsSection.patchValue({
            shipFrom: this.bgRecord.shipFrom,
            shipLoading: this.bgRecord.shipLoading,
            shipDischarge: this.bgRecord.shipDischarge,
            shipTo:  this.bgRecord.shipTo,
            partShipDetl: this.bgRecord.partShipDetl,
            tranShipDetl: this.bgRecord.tranShipDetl,
            incoPlace: this.bgRecord.incoPlace
          });
    if (this.commonDataService.getMode() === Constants.MODE_AMEND || this.commonDataService.getMode() === Constants.MODE_DRAFT ||
       (this.commonDataService.getMode() === Constants.MODE_DRAFT && this.commonDataService.getTnxType() === Constants.TYPE_AMEND
       || this.isExistingDraftMenu || this.commonDataService.getOption() === Constants.OPTION_EXISTING)) {
        this.shipmentDetailsSection.patchValue({
          lastShipDate: this.bgRecord.lastShipDate
        });
      }
  }

  validateLastShipDate() {
    if (this.commonDataService.getMode() === Constants.MODE_AMEND ||
    (this.commonDataService.getMode() === Constants.MODE_DRAFT && this.commonDataService.getTnxType() === Constants.TYPE_AMEND)) {
      this.shipmentDetailsSection.get('lastShipDate').setValidators(validateDates(this.shipmentDetailsSection.get('lastShipDate'),
      this.shipmentDetailsSection.parent.get('amendGeneraldetailsSection').get('bgExpDate'),
      Constants.LAST_SHIP_DATE , Constants.EXPIRY_DATE , Constants.GREATER_THAN));
      this.shipmentDetailsSection.parent.get('amendGeneraldetailsSection').get('bgExpDate').clearValidators();
      this.shipmentDetailsSection.parent.get('amendGeneraldetailsSection').get('bgExpDate').updateValueAndValidity();
    } else if (this.commonDataService.getOption() === Constants.OPTION_SCRATCH_GUARANTEE ||
     this.commonData.getOption() === Constants.SCRATCH || this.commonDataService.getMode() === Constants.MODE_DRAFT) {
       if (this.commonData.getProductCode() === Constants.PRODUCT_CODE_RU) {
        this.shipmentDetailsSection.get('lastShipDate').setValidators(validateDates(this.shipmentDetailsSection.get('lastShipDate'),
        this.shipmentDetailsSection.parent.get('ruGeneraldetailsSection').get('expDate'),
        Constants.LAST_SHIP_DATE , Constants.EXPIRY_DATE , Constants.GREATER_THAN));
        this.shipmentDetailsSection.parent.get('ruGeneraldetailsSection').get('expDate').clearValidators();
        this.shipmentDetailsSection.parent.get('ruGeneraldetailsSection').get('expDate').updateValueAndValidity();
        } else {
          if (this.commonDataService.getExpDateType() === '02') {
            this.shipmentDetailsSection.get('lastShipDate').setValidators(validateDates(this.shipmentDetailsSection.get('lastShipDate'),
            this.shipmentDetailsSection.parent.get('undertakingGeneralDetailsSection').get('bgExpDate'),
            Constants.LAST_SHIP_DATE , Constants.EXPIRY_DATE , Constants.GREATER_THAN));
            this.shipmentDetailsSection.parent.get('undertakingGeneralDetailsSection').get('bgExpDate').clearValidators();
            this.shipmentDetailsSection.parent.get('undertakingGeneralDetailsSection').get('bgExpDate').updateValueAndValidity();
          } else if (this.commonDataService.getExpDateType() !== '02') {
            this.shipmentDetailsSection.get('lastShipDate').setValidators(validateDates(this.shipmentDetailsSection.get('lastShipDate'),
            this.shipmentDetailsSection.parent.get('undertakingGeneralDetailsSection').get('bgApproxExpiryDate'),
            Constants.LAST_SHIP_DATE , Constants.EXPIRY_DATE , Constants.GREATER_THAN));
            this.shipmentDetailsSection.parent.get('undertakingGeneralDetailsSection').get('bgApproxExpiryDate').clearValidators();
            this.shipmentDetailsSection.parent.get('undertakingGeneralDetailsSection').get('bgApproxExpiryDate').updateValueAndValidity();
          }
        }
       this.shipmentDetailsSection.get('lastShipDate').updateValueAndValidity();
    }
  }
  diaplayMessage(event, field) {
    if (event === 'CONDITIONAL' && field === 'partShipDetl') {
      this.partialShipConditional = true;
    } else if (event !== 'CONDITIONAL' && field === 'partShipDetl') {
      this.partialShipConditional = false;
    } else if (event === 'CONDITIONAL' && field === 'tranShipDetl') {
      this.transShipConditional = true;
    } else if (event !== 'CONDITIONAL' && field === 'tranShipDetl') {
      this.transShipConditional = false;
    }
  }
  generatePdf(generatePdfService) {
    if (this.commonDataService.getPreviewOption() !== 'SUMMARY') {
      generatePdfService.setSectionDetails('HEADER_SHIPMENT_DETAILS', true, false, 'shipmentDetailsSection');
    }
  }

  purchaseTermsSelected(event) {
    if (event != null && event !== '') {
      this.namedPlace = true;
      this.shipmentDetailsSection.get('incoPlace').setValidators(
        [Validators.required, Validators.maxLength(Constants.LENGTH_60), validateSwiftCharSet(Constants.Z_CHAR)]);
    } else if (!this.displayIncoTerms || event == null || event === '') {
      if (this.shipmentDetailsSection.get('incoTerm').value !== null && this.shipmentDetailsSection.get('incoTerm').value !== '') {
        this.namedPlace = true;
        this.shipmentDetailsSection.get('incoPlace').setValidators(
          [Validators.required, Validators.maxLength(Constants.LENGTH_60), validateSwiftCharSet(Constants.Z_CHAR)]);
        this.shipmentDetailsSection.get('incoPlace').updateValueAndValidity();
      } else {
      this.namedPlace = false;
      this.shipmentDetailsSection.get('incoPlace').clearValidators();
      this.shipmentDetailsSection.get('incoPlace').setValue('');
      this.shipmentDetailsSection.get('incoPlace').setErrors(null);
      this.shipmentDetailsSection.get('incoPlace').setValidators(
        [Validators.maxLength(Constants.LENGTH_60), validateSwiftCharSet(Constants.Z_CHAR)]);
      }
    }
  }

  clearShipmentDate(event) {
    this.shipmentDetailsSection.get('lastShipDate').setValue('');
  }

  hasShipmentDateValue(): boolean {
    if (this.shipmentDetailsSection.get(`lastShipDate`) &&
        this.shipmentDetailsSection.get(`lastShipDate`).value !== null &&
        this.shipmentDetailsSection.get(`lastShipDate`).value !== '') {
      return true;
    } else {
      return false;
    }
  }

  fetchIncoDetails() {
    this.staticDataService.fetchIncoTermDetails().subscribe(data => {
      if (data && data != null && data.incoTermDetails && data.incoTermDetails.incoTermBanks &&
        data.incoTermDetails.incoTermBanks.length !== 0) {
        const incoTermBanks = data.incoTermDetails.incoTermBanks;
        incoTermBanks.forEach(element => {
          this.bankIncoRulesMap.set(element.bank, element.incoTermValues);
        });
        const bankSection = this.shipmentDetailsSection.parent.get(`bankDetailsSection`);

        const recepientBank = (bankSection && bankSection.get(`recipientBankAbbvName`) &&
                              bankSection.get(`recipientBankAbbvName`).value != null &&
                              bankSection.get(`recipientBankAbbvName`).value !== '') ?
                              this.commonDataService.getBankDetails(bankSection.get(`recipientBankAbbvName`).value) : '';

        let bankName = this.commonData.getIsBankUser() ? this.commonService.getCompanyName() : recepientBank;

        if (bankName !== '' || (this.dataToBePersisted &&
            this.commonService.isFieldsValuesExists([this.bgRecord[`recipientBank`][`abbvName`]]))) {
          if (bankName === '') {
            bankName = this.bgRecord[`recipientBank`][`abbvName`];
          }
          this.getIncoTermDetailsOptions(bankName, true);
        }
      } else {
        this.displayIncoDetails = false;
      }
    });
  }

  getIncoTermDetailsOptions(bankName, persistFieldValue: boolean) {
    if (bankName != null && bankName !== '' && this.bankIncoRulesMap.size > 0 && this.bankIncoRulesMap.get(bankName) != null) {
      this.shipmentDetailsSection.get(`incoTermYear`).reset();
      this.shipmentDetailsSection.get(`incoTerm`).reset();
      this.shipmentDetailsSection.get(`incoPlace`).reset();
      this.incoRulesDropDown.length = 0;
      this.displayIncoDetails = true;
      const applicableRules = this.bankIncoRulesMap.get(bankName);
      applicableRules.forEach(element => {
        const incoRuleEle: any = {};
        incoRuleEle.label = element.year;
        incoRuleEle.value = element.year;
        this.incoRulesDropDown.push(incoRuleEle);
        this.incoRuleTermsMap.set(element.year, element.values);

        if (this.bgRecord[`incoTermYear`] === element.year && persistFieldValue) {
          this.shipmentDetailsSection.get(`incoTermYear`).setValue(element.year);
          this.updateIncoTermList(this.bgRecord[`incoTermYear`], persistFieldValue);
        }
      });
    } else {
      this.displayIncoDetails = false;
    }
  }

  updateIncoTermList(incoRule, persistFieldValue: boolean) {
    this.incoTermValues.length = 0;
    this.shipmentDetailsSection.get(`incoTerm`).reset();
    if (!(incoRule == null || incoRule === '')) {
      this.shipmentDetailsSection.get('incoPlace').setValue('');
      if (this.commonService.isFieldsValuesExists([this.bgRecord[`incoPlace`]]) && persistFieldValue) {
        this.namedPlace = true;
        this.shipmentDetailsSection.get('incoPlace').setValidators(
          [Validators.required, Validators.maxLength(Constants.LENGTH_60), validateSwiftCharSet(Constants.Z_CHAR)]);
        this.shipmentDetailsSection.get(`incoPlace`).setValue(this.bgRecord[`incoPlace`]);
      }
      this.shipmentDetailsSection.get('incoPlace').setErrors(null);
      this.shipmentDetailsSection.get(`incoTerm`).setValidators(Validators.required);
      this.displayIncoTerms = true;
      const termsArr = this.incoRuleTermsMap.get(incoRule);
      termsArr.forEach(element => {
        const incoTermEle: any = {};
        incoTermEle.label = `${this.translate.instant(this.commonDataService.getIncoTermDetails(element))}`;
        incoTermEle.value = element;
        this.incoTermValues.push(incoTermEle);
        this.incoTermValues.sort((obj1, obj2) =>
          obj1.value.localeCompare(obj2.value));
        if (this.bgRecord[`incoTerm`] === element && persistFieldValue) {
          this.shipmentDetailsSection.get(`incoTerm`).setValue( element);
        }
      });
    } else {
      this.shipmentDetailsSection.get(`incoTerm`).reset();
      this.shipmentDetailsSection.get(`incoTermYear`).setValue('');
      this.shipmentDetailsSection.get(`incoTerm`).setValue('');
      this.shipmentDetailsSection.get(`incoTerm`).clearValidators();
      this.shipmentDetailsSection.get(`incoTerm`).setErrors(null);
      this.displayIncoTerms = false;
      this.purchaseTermsSelected('');
    }
  }
}
