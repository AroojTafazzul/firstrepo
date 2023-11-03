import { Component, OnInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmationService, DynamicDialogRef } from 'primeng';

import { FccGlobalConstant } from '../../../../../app/common/core/fcc-global-constants';
import { EventEmitterService } from '../../../../../app/common/services/event-emitter-service';
import { CommonService } from '../../../../common/services/common.service';
import { ResolverService } from '../../../../common/services/resolver.service';
import { SearchLayoutService } from '../../../../common/services/search-layout.service';
import { TransactionComponent } from '../../common/component/transaction/transaction.component';
import { ProductStateService } from '../../lc/common/services/product-state.service';
import { CustomCommasInCurrenciesPipe } from '../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { FilelistService } from '../../lc/initiation/services/filelist.service';
import { UtilityService } from '../../lc/initiation/services/utility.service';
import { CurrencyConverterPipe } from '../../lc/initiation/pipes/currency-converter.pipe';
import { IcProductService } from '../services/ic-product.service';

@Component({
  selector: 'app-ic-product',
  templateUrl: './ic-product.component.html',
  styleUrls: ['./ic-product.component.scss']
})
export class IcProductComponent extends TransactionComponent implements OnInit {
  form = this[FccGlobalConstant.FORM];
  constructor(protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService,
              protected commonService: CommonService,
              protected translateService: TranslateService,
              protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe,
              protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService,
              protected resolverService: ResolverService,
              protected fileArray: FilelistService,
              protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe,
              protected icProductService: IcProductService) {
    super(translateService, confirmationService, customCommasInCurrenciesPipe, searchLayoutService,
      commonService, utilityService, resolverService, productStateService, fileArray, dialogRef, currencyConverterPipe);
}

ngOnInit(): void {
  if (this.eventEmitterService.subsVar === undefined) {
    this.eventEmitterService.subsVar = this.eventEmitterService.
    getSubmitEvent().subscribe(() => {
      this.beforeSubmitValidation();
    });
  }
}

beforeSaveValidation(): boolean {
  return this.icProductService.beforeSaveValidation(this.form);

}

beforeSubmitValidation(): boolean {
  return this.icProductService.beforeSubmitValidation();

}

}
