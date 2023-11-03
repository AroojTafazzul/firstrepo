import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { TradeCommonDataService } from './../../../services/trade-common-data.service';
import { CommonService } from '../../../../../common/services/common.service';

@Component({
  selector: 'fcc-trade-general-details',
  templateUrl: './general-details.component.html',
  styleUrls: ['./general-details.component.scss']
})
export class GeneralDetailsComponent implements OnInit {

  @Input() public bgRecord;
  @Output() formReady = new EventEmitter<FormGroup>();
  generalDetailsForm: FormGroup;

  constructor(protected fb: FormBuilder, public tradeCommonDataService: TradeCommonDataService,
              public commonService: CommonService) {}

  ngOnInit() {
    this.generalDetailsForm = this.fb.group({
      refId: [''],
      bo_refId: [''],
      prodStatCode: ['']
    });
    this.getFieldValues();

    // Emit the form group to the parent
    this.formReady.emit(this.generalDetailsForm);
  }

  getFieldValues() {
     this.generalDetailsForm.patchValue({
      refId: this.bgRecord.refId,
      bo_refId: this.bgRecord.boRefId,
      prodStatCode: this.bgRecord.prodStatCode
     });
   }
}
