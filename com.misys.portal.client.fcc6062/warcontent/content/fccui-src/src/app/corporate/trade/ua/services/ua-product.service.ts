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
export class UaProductService implements ProductValidator{
  tnxTypeCode: any;

  constructor(protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService,
              protected commonService: CommonService,
              protected translateService: TranslateService) { }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  beforeSaveValidation(form?: any): boolean {
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    return true;
  }
  beforeSubmitValidation(): boolean {
    this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);
    const isValid = this.validate();
    this.eventEmitterService.subFlag.next(isValid);
    return true;
  }

  validate() {
    let isValid = false;
    let sectionForm: FCCFormGroup;
    if (this.tnxTypeCode !== FccGlobalConstant.N002_INQUIRE) {
      sectionForm = this.productStateService.getSectionData('uaGeneralDetails', FccGlobalConstant.PRODUCT_BR);
      // Do Business Validation
      if (sectionForm) {
        isValid = true;
      }
    } else {
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
}
