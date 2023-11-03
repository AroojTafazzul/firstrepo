import {
  AfterViewInit,
  Component,
  EventEmitter,
  Output,
  Input,
  OnInit,
} from '@angular/core';
import { FCCBase } from './../../../../../base/model/fcc-base';
import {
  FCCMVFormControl,
  FCCFormGroup,
} from './../../../../../base/model/fcc-control.model';

import {
  IDataEmittterModel,
  IUpdateFccBase,
} from '../../form-control-resolver/form-control-resolver.model';
import { FccGlobalConstant } from '../../../../../common/core/fcc-global-constants';
import { CommonService } from '../../../../../common/services/common.service';
import { FccConstants } from '../../../../../../app/common/core/fcc-constants';

@Component({
  selector: 'fcc-input-auto-comp',
  templateUrl: './input-auto-comp.component.html',
  styleUrls: ['./input-auto-comp.component.scss'],
})
export class InputAutoCompComponent
  extends FCCBase
  implements OnInit, AfterViewInit, IUpdateFccBase
{
  @Input() control!: FCCMVFormControl;
  @Input() form!: FCCFormGroup;
  @Input() mode!: string;
  @Input() hostComponentData!: any | null;
  @Output() controlDataEmitter: EventEmitter<IDataEmittterModel> =
    new EventEmitter<IDataEmittterModel>();
  compData = new Map<string, any>();

  constructor(protected commonService : CommonService) {
    super();
  }

  ngOnInit(): void {
    //eslint : no-empty-function
    this.commonService.inputAutoComp.subscribe(() => {
      this.updateValue();
    });
  }
  ngAfterViewInit(): void {
    this.updateValue();
  }

  updateValue(){
    if (this.form && this.form.value) {
      if (this.form.value.beneficiaryName) {
        this.control.options.forEach((item) => {
          if(item.label === this.form.value.beneficiaryName || 
            item.value[FccGlobalConstant.SHORT_NAME] === this.form.value.beneficiaryName) {
            this.inputValue = item.value[FccGlobalConstant.SHORT_NAME];
          }
        });
      }
      if(this.form.value.adhocFlag === FccConstants.BATCH_PAYMENT_ADHOC_FLOW){
        if (this.form.value.BeneficiaryName) {
          this.inputValue = this.form.value.BeneficiaryName;
        }
      }
      
    }

    this.controlDataEmitter.emit({
      control: this.control,
      data: this.compData,
    });
  }

}

