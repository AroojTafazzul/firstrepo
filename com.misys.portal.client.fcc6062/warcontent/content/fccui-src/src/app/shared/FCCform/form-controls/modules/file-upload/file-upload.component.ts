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

@Component({
  selector: 'fcc-file-upload',
  templateUrl: './file-upload.component.html',
  styleUrls: ['./file-upload.component.scss'],
})
export class FileUploadComponent
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

  constructor() {
    super();
  }

  ngOnInit(): void {
    //eslint : no-empty-function
  }
  ngAfterViewInit(): void {
    this.controlDataEmitter.emit({
      control: this.control,
      data: this.compData,
    });
  }
}
