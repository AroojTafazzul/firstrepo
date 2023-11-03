import { DatePipe, getCurrencySymbol } from '@angular/common';
import { TransactionDetailService } from './../../services/transactionDetail.service';
import { ProductMappingService } from './../../services/productMapping.service';
import { ReviewScreenService } from './../../services/review-screen.service';
import { FccGlobalConstant } from './../../core/fcc-global-constants';
import { ActivatedRoute } from '@angular/router';
import { Component, OnInit, ElementRef, ViewChild, OnDestroy, HostListener } from '@angular/core';
import { LcConstant } from '../../../corporate/trade/lc/common/model/constant';
import { FccGlobalConstantService } from './../../core/fcc-global-constant.service';
import { CommonService } from '../../services/common.service';
import { TranslateService } from '@ngx-translate/core';
import { ReauthService } from '../../services/reauth.service';

@Component({
  selector: 'app-review-detail',
  templateUrl: './review-detail.component.html',
  styleUrls: ['./review-detail.component.scss']
})
export class ReviewDetailComponent implements OnInit, OnDestroy {
  @ViewChild('childaccessability') protected childaccessability: ElementRef;
  lcConstant = new LcConstant();
  transactionId;
  subProductCode;
  referenceId;
  productCode;
  reviewDetail = [];
  currency;
  widgetDetails: any;
  componentDetails: any;
  widgets;
  masterData;
  apiId;
  apiProductCode;
  coloumNo;
  lang;
  termCode;
  liabAmtDisplay;
  innerWidth = 0;
  constructor(protected activatedRoute: ActivatedRoute, protected fccGlobalConstant: FccGlobalConstant,
              protected reviewScreenService: ReviewScreenService, protected elementRef: ElementRef,
              protected globalConstantService: FccGlobalConstantService, protected commonService: CommonService,
              protected productMappingService: ProductMappingService,
              protected transactionDetailService: TransactionDetailService,
              public datepipe: DatePipe, protected translate: TranslateService,
              protected reauthService: ReauthService) { }

  ngOnInit() {
    const tnxid = 'tnxid';
    const referenceid = 'referenceid';
    const noOfColoums = 'noOfColoums';
    const subProductCode = 'subProductCode';

    this.lang = localStorage.getItem('language');
    this.widgets = this.widgetDetails ? JSON.parse(this.widgetDetails) : '';
    this.componentDetails = this.widgets.widgetData;
    this.activatedRoute.queryParams.subscribe(params => {
      this.transactionId = params[tnxid];
      this.referenceId = params[referenceid];
      this.productCode = this.referenceId.substring(FccGlobalConstant.LENGTH_0, FccGlobalConstant.LENGTH_2);
      if (params[subProductCode] !== undefined && params[subProductCode] !== null && params[subProductCode] !== '') {
        this.subProductCode = params[subProductCode];
      }
      if (this.transactionId !== undefined && this.transactionId !== null && this.transactionId !== '') {
        this.commonService.putQueryParameters(tnxid, params[tnxid]);
      }
    });
    this.coloumNo = this.componentDetails[noOfColoums];
    if (this.transactionId === '') {
      this.apiId = this.referenceId;
      this.apiProductCode = undefined;
    } else {
      this.apiProductCode = this.productCode;
      this.apiId = this.transactionId;
    }
    this.getReviewDataAll();
    this.innerWidth = window.innerWidth;
  }


  getReviewDataAll() {
    const values = [];
    const Displaykeys = 'Displaykeys';
    this.productMappingService.getApiModel(this.productCode, this.subProductCode).subscribe(apiMappingModel => {
    const displayKeys = this.componentDetails[Displaykeys];
    this.transactionDetailService.fetchTransactionDetails(this.apiId, this.apiProductCode).toPromise()
      .then(response => {
        for (const sectionData of displayKeys) {
          const feilds = Object.keys(sectionData);
          feilds.forEach((element) => {
            if (element === 'apiMapping') {
              const mappingFieldKey = apiMappingModel[sectionData[element]];
              if (mappingFieldKey !== null && mappingFieldKey !== undefined) {
                const fieldValue = this.productMappingService.
                 getFieldValueFromMappingObject(sectionData[element], response.body, mappingFieldKey);
                values.push(fieldValue);
              }
            }
          });
        }
        this.saveReviewDetails(displayKeys, values);
      });
});

  }


  saveReviewDetails(keys, values) {
    let reviewdata: { 'key': any, 'value': any, 'layoutClass': any, 'feildType': any };

    for (let i = 0; i < keys.length; i++) {
      if (values[i] !== undefined && values[i] !== null && values[i] !== '') {
        if (values[i] !== undefined && keys[i].feildType !== undefined && keys[i].feildType !== 'currency' &&
              keys[i].feildType !== 'currencyE' && keys[i].feildType !== FccGlobalConstant.TERM_CODE) {
          if (keys[i].feildType === 'translateCodeField' && !this.checkSwiftVersionFields(keys[i])) {
            const apiFieldMappingValue = keys[i].apiMapping;
            reviewdata = { key: keys[i].label, value: this.translate.instant(apiFieldMappingValue.concat('_').concat(values[i])),
              layoutClass: keys[i].layoutClass, feildType: keys[i].feildType };
            this.reviewDetail.push(reviewdata);
          } else if (keys[i].feildType === 'translateField') {
            reviewdata = { key: keys[i].label, value: this.translate.instant(values[i]),
              layoutClass: keys[i].layoutClass, feildType: keys[i].feildType };
            this.reviewDetail.push(reviewdata);
          } else if (keys[i].feildType === 'account') {
            reviewdata = { key: keys[i].label, value: values[i + 1].concat(FccGlobalConstant.BLANK_SPACE_STRING).concat(values[i]),
              layoutClass: keys[i].layoutClass, feildType: keys[i].feildType };
            this.reviewDetail.push(reviewdata);
          } else {
             reviewdata = { key: keys[i].label, value: this.commonService.decodeHtml(values[i]),
               layoutClass: keys[i].layoutClass, feildType: keys[i].feildType };
             if (values[i] === 'liabAmount') {
                this.reauthService.getConfigurationValue('DISPLAY_LIABILITY_AMOUNT').subscribe((val: any) => {
                  this.liabAmtDisplay = val;
                  if (this.liabAmtDisplay !== 'false' && this.liabAmtDisplay !== 'undefined' && this.liabAmtDisplay !== null) {
                    this.reviewDetail.push(reviewdata);
                  }
                });
              }
              else {
                this.reviewDetail.push(reviewdata);
               }

          }
        } else if (values[i] !== undefined && keys[i].feildType !== undefined && keys[i].feildType === 'currency') {
          this.currency = values[i];
        } else if (values[i] !== undefined && keys[i].feildType !== undefined && keys[i].feildType === FccGlobalConstant.TERM_CODE) {
          const termCodeValue = keys[i].translateValue;
          this.termCode = this.translate.instant(termCodeValue.concat(values[i]));
        }
      }
    }
  }



  classObject() {
    const value = this.coloumNo;
    const totalValue = 12;
    const columnValue = totalValue / value;
    return 'p-col-' + columnValue;
  }


  ngOnDestroy() {
    this.reviewDetail = null;
    this.currency = '';
    this.termCode = '';
  }

  getCurrencySymbol(curCode: string): string {
    return getCurrencySymbol(curCode, 'narrow');
  }

  checkSwiftVersionFields(key: any) {
    let isSwift2021 = false;
    if (key.swiftVersion !== undefined && key.swiftVersion !== null && key.swiftVersion !== '') {
      this.commonService.getSwiftVersionValue();
      if (this.commonService.swiftVersion !== key.swiftVersion) {
        isSwift2021 = true;
      }
    }
    return isSwift2021;
  }

  @HostListener('window:resize', [])
  handleScreenResize() {
    this.innerWidth = window.innerWidth;
  }


  borderClass(i: number): string {
    i = i + 1;

    // For items greater than 6;
    if (this.reviewDetail.length >= 6) {

      // For large screen
      if (this.innerWidth > 992) {
        if (i % 6 === 0) {
          return '';
        }
      }

      // For medium screen
      if (this.innerWidth < 992 && this.innerWidth >= 768) {
        if (i % 3 === 0) {
          return '';
        }
      }

      // For small screen
      if (this.innerWidth < 768) {
        if (i % 2 === 0) {
          return '';
        }
      }
    } else {
       // For large screen
       if (this.innerWidth > 992) {
        if (i % 4 === 0) {
          return '';
        }
      }

      // For medium screen
      if (this.innerWidth < 992 && this.innerWidth >= 768) {
        if (i % 3 === 0) {
          return '';
        }
      }

      // For small screen
      if (this.innerWidth < 768) {
        if (i % 2 === 0) {
          return '';
        }
      }
    }

    if ((this.reviewDetail.length > i) && this.lang !== 'ar') {
      return 'border-class';
    } else if ((this.reviewDetail.length > i) && this.lang === 'ar') {
      return 'border-class-left';
    } else {
      return '';
    }
  }

}

