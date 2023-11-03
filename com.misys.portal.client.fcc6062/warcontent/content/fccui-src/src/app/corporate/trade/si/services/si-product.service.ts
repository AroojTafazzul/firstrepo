import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from '../../../../common/services/common.service';
import { FccGlobalConstant } from '../../../../common/core/fcc-global-constants';
import { EventEmitterService } from '../../../../common/services/event-emitter-service';
import { ProductStateService } from '../../lc/common/services/product-state.service';
import { ProductValidator } from '../../../common/validator/productValidator';

@Injectable({
  providedIn: 'root'
})
export class SiProductService implements ProductValidator {

  constructor(protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService,
              protected commonService: CommonService,
              protected translateService: TranslateService) { }

  disableRequestOptionsOnSave(form) {
    if (form !== undefined && form.get(FccGlobalConstant.REQUEST_OPTION_LC) !== undefined &&
        form.get(FccGlobalConstant.REQUEST_OPTION_LC) !== null) {
      const requestOptions = form.get(FccGlobalConstant.REQUEST_OPTION_LC)[FccGlobalConstant.PARAMS][FccGlobalConstant.OPTIONS];
      requestOptions.forEach( (element) => {
        element[FccGlobalConstant.DISABLED] = true;
      });
      form.get(FccGlobalConstant.REQUEST_OPTION_LC)[FccGlobalConstant.PARAMS][FccGlobalConstant.DISABLED] = true;
      form.get(FccGlobalConstant.REQUEST_OPTION_LC).updateValueAndValidity();
    }
  }

  beforeSaveValidation(form?): boolean {
    this.disableRequestOptionsOnSave(form);
    // eslint-disable-next-line no-console
    console.log('beforeSaveValidation invoked');
    return true;
  }

  beforeSubmitValidation(): boolean {
    const isValid = this.validate();
    this.eventEmitterService.subFlag.next(isValid);
    // eslint-disable-next-line no-console
    console.log('beforeSubmitValidation invoked');
    return true;
  }

  validate() {
    return true;
  }
}
