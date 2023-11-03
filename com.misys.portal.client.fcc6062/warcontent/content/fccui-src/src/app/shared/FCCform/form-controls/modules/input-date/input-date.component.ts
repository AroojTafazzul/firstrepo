import {
  AfterViewInit,
  Component,
  EventEmitter,
  Output,
  Input,
  OnInit,
  ViewChild,
  HostListener,
} from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
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

@Component({
  selector: 'fcc-input-date',
  templateUrl: './input-date.component.html',
  styleUrls: ['./input-date.component.scss'],
})
export class InputDateComponent
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

  @ViewChild('calendar') calendar: any;

  constructor(
    protected commonService: CommonService,
    protected translateService: TranslateService
  ) {
    super();
  }

  ngOnInit(): void {
    //eslint : no-empty-function
  }

  holidayDateFilter = (d :Date): boolean => {
    const moment = require('moment');
    const date = moment(d);
    const holidayList = this.control.params.holidayList;
    if (holidayList) {
      return !holidayList.find(x => moment(x).isSame(date, 'day'));
    } else{
      return date;
    }
  };


  ngAfterViewInit() {
    if (this.commonService.isNonEmptyValue(this.calendar)) {
      this.calendar.el.nativeElement
        .getElementsByClassName(FccGlobalConstant.UI_CALENDAR_BUTTON)[0]
        .setAttribute(
          'title',
          this.translateService.instant(FccGlobalConstant.CALENDAR)
        );
      this.compData.set('calendar', this.calendar);
    }
    this.controlDataEmitter.emit({
      control: this.control,
      data: this.compData,
    });
  }

  @HostListener('document:keydown.escape', ['$event']) onKeydownHandler(event) {
    if (event && ( event.target.localName === 'select' || event.target.localName === 'body')){
        this.calendar.hideOverlay();
    }
  }

  onClose() {
    this.calendar.el.nativeElement.getElementsByClassName(FccGlobalConstant.UI_CALENDAR_BUTTON)[0].focus();
  }
}
