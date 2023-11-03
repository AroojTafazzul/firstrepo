import { CommonReductionIncreaseComponent } from './../../../iu/initiation/components/common-reduction-increase/common-reduction-increase.component';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Component, OnInit, Input, ViewChild } from '@angular/core';
import { CommonService } from '../../../../common/services/common.service';

@Component({
  selector: 'fcc-ru-reduction-increase',
  templateUrl: './ru-reduction-increase.component.html',
  styleUrls: ['./ru-reduction-increase.component.css']
})
export class RuReductionIncreaseComponent implements OnInit {
  @Input() public brRecord;
  redIncForm: FormGroup;
  collapsible = true;
  @ViewChild(CommonReductionIncreaseComponent)commonReductionIncreaseChildComponent: CommonReductionIncreaseComponent;

  constructor(public fb: FormBuilder, public commonService: CommonService) { }

  ngOnInit() {
    if (this.checkForDataIfPresent()) {
      this.collapsible = false;
    }
    this.redIncForm = this.fb.group({
      brVariationType: [''],
      brAdviseEventFlag: [''],
      brAdviseDaysPriorNb: [{value: '', disabled: true}],
      brMaximumNbVariation: [''],
      brVariationFrequency: [''],
      brVariationPeriod: [''],
      brVariationDayInMonth: [''],
      brVariationsLists: ['']
    });
  }

  checkForDataIfPresent() {
    const arr = [this.brRecord.bgVariation, this.brRecord.bgVariationType, this.brRecord.bgAdviseEventFlag,
      this.brRecord.bgAdviseDaysPriorNb, this.brRecord.bgMaximumNbVariation, this.brRecord.bgVariationFrequency,
      this.brRecord.bgVariationPeriod, this.brRecord.bgVariationDayInMonth, this.brRecord.bgVariationsLists];

    return this.commonService.isFieldsValuesExists(arr);
  }

  generatePdf(generatePdfService) {
    if (this.commonReductionIncreaseChildComponent) {
      this.commonReductionIncreaseChildComponent.generatePdf(generatePdfService);
    }
  }
}
