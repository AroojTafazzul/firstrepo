import { Injectable } from '@angular/core';
import { EventEmitterService } from '../../../../../common/services/event-emitter-service';
import { ProductValidator } from '../../../../common/validator/productValidator';

@Injectable({
  providedIn: 'root',
})
export class FtCashProductService implements ProductValidator {

  constructor(protected eventEmitterService: EventEmitterService) {}
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  beforeSaveValidation(form?: any): boolean {
    return true;
  }

  /**
   * Invoked before submit
   */
  beforeSubmitValidation(): boolean {
    const isValid = this.validate();
    this.eventEmitterService.subFlag.next(isValid);
    return true;
  }

  validate() {
    const isValid = true;
    return isValid;
  }
}
