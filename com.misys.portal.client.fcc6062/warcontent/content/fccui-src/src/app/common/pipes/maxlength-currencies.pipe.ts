import { FccGlobalConstant } from './../../common/core/fcc-global-constants';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'maxlengthCurrencies'
})
export class MaxlengthCurrenciesPipe implements PipeTransform {
  OMR = 'OMR';
  BHD = 'BHD';
  TND = 'TND';
  JPY = 'JPY';
  fromAmtSize: number;
  length11 = FccGlobalConstant.LENGTH_11;
  length12 = FccGlobalConstant.LENGTH_12;
  length14 = FccGlobalConstant.LENGTH_14;
  length15 = FccGlobalConstant.LENGTH_15;
  //eslint-disable-next-line no-useless-escape
  ZeroDecimalAmtRegex = '/^\d{0,2}(,{0,1}\d{0,3})(,{0,1}\d{0,3})(,{0,1}\d{0,3})(,{0,1}\d{0,3})?$/';
  //eslint-disable-next-line no-useless-escape
  TwoDecimalAmtRegex = '/^\d{0,3}(,{0,1}\d{0,3})(,{0,1}\d{0,3})(,{0,1}\d{0,3})\.?\d{0,2}$/g';
  //eslint-disable-next-line no-useless-escape
  ThreeDecimalAmtRegex = '/^\d{0,2}(,{0,1}\d{0,3})(,{0,1}\d{0,3})(,{0,1}\d{0,3})\.?\d{0,3}$/g';

  transform(fromCurrency: any, fromAmount: any): any {
    if (
      (fromCurrency === this.OMR ||
        fromCurrency === this.BHD ||
        fromCurrency === this.TND)
        && fromAmount.match(this.ThreeDecimalAmtRegex)
      ) {
      if (fromAmount.indexOf('.') > -1) {
        this.fromAmtSize = this.length15;
      } else {
        this.fromAmtSize = this.length11;
      }
    } else if (fromCurrency === this.JPY && fromAmount.match(this.ZeroDecimalAmtRegex)) {
      this.fromAmtSize = this.length14;
    } else if (fromAmount.match(this.TwoDecimalAmtRegex)) {
      if (fromAmount.indexOf('.') > -1) {
        this.fromAmtSize = this.length15;
      } else {
        this.fromAmtSize = this.length12;
      }
    } else {
      this.fromAmtSize = this.length15;
    }
    return this.fromAmtSize;
  }

}
