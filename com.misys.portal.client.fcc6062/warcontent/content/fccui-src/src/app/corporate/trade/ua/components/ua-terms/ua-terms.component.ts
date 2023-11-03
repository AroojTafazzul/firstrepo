import { Component, Input, OnInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { FCCFormGroup } from './../../../../../base/model/fcc-control.model';
import { FccGlobalConstantService } from './../../../../../common/core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../../../../common/core/fcc-global-constants';
import { CommonService } from './../../../../../common/services/common.service';
import { EventEmitterService } from './../../../../../common/services/event-emitter-service';
import { CorporateCommonService } from './../../../../../corporate/common/services/common.service';
import { ProductStateService } from '../../../lc/common/services/product-state.service';
import { UaProductComponent } from '../ua-product/ua-product.component';
import { ConfirmationService, DynamicDialogRef } from 'primeng';
import { CustomCommasInCurrenciesPipe } from '../../../lc/initiation/pipes/custom-commas-in-currencies.pipe';
import { SearchLayoutService } from '../../../../../common/services/search-layout.service';
import { ResolverService } from '../../../../../common/services/resolver.service';
import { UtilityService } from '../../../lc/initiation/services/utility.service';
import { FilelistService } from '../../../lc/initiation/services/filelist.service';
import { CurrencyConverterPipe } from '../../../lc/initiation/pipes/currency-converter.pipe';
import { UaProductService } from '../../services/ua-product.service';
import { HOST_COMPONENT } from './../../../../../shared/FCCform/form/form-resolver/form-resolver.directive';

@Component({
  selector: 'app-ua-terms',
  templateUrl: './ua-terms.component.html',
  providers: [{ provide: HOST_COMPONENT, useExisting: UaTermsComponent }]
})
export class UaTermsComponent extends UaProductComponent implements OnInit {
  module = '';
  form: FCCFormGroup;
  @Input() parentForm: FCCFormGroup;
  @Input() data;
  @Input() controlName;
  constructor(protected translateService: TranslateService, protected eventEmitterService: EventEmitterService,
              protected productStateService: ProductStateService, protected commonService: CommonService,
              protected corporateCommonService: CorporateCommonService, protected fccGlobalConstantService: FccGlobalConstantService,
              protected confirmationService: ConfirmationService,
              protected customCommasInCurrenciesPipe: CustomCommasInCurrenciesPipe, protected searchLayoutService: SearchLayoutService,
              protected utilityService: UtilityService, protected resolverService: ResolverService,
              protected fileArray: FilelistService, protected dialogRef: DynamicDialogRef,
              protected currencyConverterPipe: CurrencyConverterPipe, protected uaProductService: UaProductService) {
              super(eventEmitterService, productStateService, commonService, translateService, confirmationService,
                customCommasInCurrenciesPipe, searchLayoutService, utilityService, resolverService, fileArray,
                dialogRef, currencyConverterPipe, uaProductService);
}

ngOnInit(): void {
  this.initializeFormGroup();
  this.tnxTypeCode = this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE);

}

initializeFormGroup() {
  const form = this.parentForm.controls[this.controlName];
  if (form !== null) {
    this.form = form as FCCFormGroup;
  }
}

ngOnDestroy() {
this.parentForm.controls[this.controlName] = this.form;
}

}
