
import { FccGlobalConstant } from './../../../../../common/core/fcc-global-constants';
import { Pipe, PipeTransform } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
@Pipe({
  name: 'currencyConverter'
})
export class CurrencyConverterPipe implements PipeTransform {
  formattedValue: any;

  constructor(protected currencyPipe: CurrencyPipe) {}

  transform(value: any, iso: any, amountConfiguration?: string) {
    const isAmountConfigured = amountConfiguration === '2' ? true : false;
    let decimalFraction;
    if (iso === FccGlobalConstant.OMR || iso === FccGlobalConstant.BHD || iso === FccGlobalConstant.TND) {
      decimalFraction = FccGlobalConstant.LENGTH_3;
    } else if (iso === FccGlobalConstant.JPY || iso === FccGlobalConstant.ADP) {
      decimalFraction = FccGlobalConstant.LENGTH_0;
    } else {
      decimalFraction = FccGlobalConstant.LENGTH_2;
    }
    let language = localStorage.getItem('language');
    if (language === 'ar') {
      if (isAmountConfigured) {
        this.formattedValue = Intl.NumberFormat(FccGlobalConstant.INDIAN_LOCALE, {
          minimumFractionDigits: decimalFraction,
          maximumFractionDigits: decimalFraction,
        }).format((value.replace('٫', '.').replace(/,/g, '')));
        return this.formattedValue.replace('.', '٫');
      } else {
        this.formattedValue = Intl.NumberFormat(FccGlobalConstant.DEFAULT_LOCALE, {
          minimumFractionDigits: decimalFraction,
          maximumFractionDigits: decimalFraction,
        }).format((value.replace('٫', '.').replace(/,/g, '')));
        return this.formattedValue.replace('.', '٫');
      }
    } else if (language === 'fr') {
      if (isAmountConfigured) {
        this.formattedValue = Intl.NumberFormat(FccGlobalConstant.INDIAN_LOCALE, {
          minimumFractionDigits: decimalFraction,
          maximumFractionDigits: decimalFraction,
        }).format((value.replace(/\s/g, '').replace('٬', '.')));
        return this.formattedValue.replace(/,/g, ' ').replace('.', ',');
      } else {
        this.formattedValue = Intl.NumberFormat(FccGlobalConstant.DEFAULT_LOCALE, {
          minimumFractionDigits: decimalFraction,
          maximumFractionDigits: decimalFraction,
        }).format((value.replace(/\s/g, '').replace('٬', '.')));
        return this.formattedValue.replace(/,/g, ' ').replace('.', ',');
      }
    } else {
      if (language === 'us') {
        language = 'en';
      }
      if (isAmountConfigured) {
        this.formattedValue = Intl.NumberFormat(FccGlobalConstant.INDIAN_LOCALE, {
          minimumFractionDigits: decimalFraction,
          maximumFractionDigits: decimalFraction,
        }).format((value.replace(',', '')));
        return this.formattedValue;
      } else {
        this.formattedValue = Intl.NumberFormat(FccGlobalConstant.DEFAULT_LOCALE, {
          minimumFractionDigits: decimalFraction,
          maximumFractionDigits: decimalFraction,
        }).format((value.replace(',', '')));
        return this.formattedValue;
      }
    }
  }
}

