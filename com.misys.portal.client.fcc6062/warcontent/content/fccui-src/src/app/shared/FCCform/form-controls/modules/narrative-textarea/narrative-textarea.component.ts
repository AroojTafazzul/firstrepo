import {
  AfterViewInit,
  Component,
  EventEmitter,
  Output,
  Input,
  OnInit,
  ElementRef,
  ViewChild,
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

@Component({
  selector: 'fcc-narrative-textarea',
  templateUrl: './narrative-textarea.component.html',
  styleUrls: ['./narrative-textarea.component.scss'],
})
export class NarrativeTextareaComponent
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
  @ViewChild('fccCommonTextAreaId') fccCommonTextAreaId: ElementRef;

  constructor() {
    super();
  }

  ngOnInit(): void {
    //eslint : no-empty-function
  }
  ngAfterViewInit(): void {
    this.compData.set('fccCommonTextAreaId', this.fccCommonTextAreaId);
    this.controlDataEmitter.emit({
      control: this.control,
      data: this.compData,
    });
  }
}
