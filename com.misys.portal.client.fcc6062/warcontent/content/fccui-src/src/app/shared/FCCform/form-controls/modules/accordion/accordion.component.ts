import { FileHandlingService } from './../../../../../common/services/file-handling.service';
import {
  AfterViewInit,
  Component,
  EventEmitter,
  Output,
  Input,
  OnInit,
  ViewChild
} from '@angular/core';
import { FCCBase } from './../../../../../base/model/fcc-base';
import {
  FCCMVFormControl,
  FCCFormGroup,
} from './../../../../../base/model/fcc-control.model';
import { TableService } from './../../../../../base/services/table.service';
import {
  IDataEmittterModel,
  IUpdateFccBase,
} from '../../form-control-resolver/form-control-resolver.model';
import { CommonService } from '../../../../../common/services/common.service';
import { TranslateService } from '@ngx-translate/core';
import { FccGlobalConstant } from './../../../../../common/core/fcc-global-constants';
import { PaginatorParams } from './../../../../../base/model/paginator-params';
import { Table } from 'primeng';

@Component({
  selector: 'fcc-accordion.w-full',
  templateUrl: './accordion.component.html',
  styleUrls: ['./accordion.component.scss'],
})
export class AccordionComponent
  extends FCCBase
  implements OnInit, AfterViewInit, IUpdateFccBase
{
  @Input() control!: FCCMVFormControl;
  @Input() form!: FCCFormGroup;
  @Input() mode!: string;
  @Input() hostComponentData!: any | null;
  @ViewChild('tt') public ptable: Table;
  @ViewChild('et') public enrichTable: Table;
  @Output() controlDataEmitter: EventEmitter<IDataEmittterModel> =
    new EventEmitter<IDataEmittterModel>();
  compData = new Map<string, any>();
  actionList: any[] = [];
  allowedDocViewerType: string[];
  paginatorParams = PaginatorParams.paginatorParams;

  constructor(protected tableService: TableService,
    protected commonService: CommonService,
    protected translate: TranslateService,
    protected fileHandlingService: FileHandlingService) {
    super();
  }
  contextPath: string;
  rows = 10;

  ngOnInit(): void {
    this.commonService.loadDefaultConfiguration().subscribe(
      (response) => {
        if (response) {
          this.rows = response.rowDisplayLimit ? response.rowDisplayLimit : 10;
          this.allowedDocViewerType = response.docViewerMimeType;
        }
      }
    );
    this.contextPath = this.commonService.getContextPath();
    this.paginatorParams.defaultRows = this.rows <= 10 ? 10 : (this.rows <= 20 ? 20 : (this.rows <= 50 ? 50 : 100));
    this.paginatorParams.rppOptions = [10, 20, 50, 100];
  }

  ngAfterViewInit(): void {
    this.controlDataEmitter.emit({
      control: this.control,
      data: this.compData,
    });
  }

  onClickView(){
    this.tableService.onClickView(null, this.hostComponentData.taskService.getTnxResponseObj());
  }

  isTypeObject(colData) {
    if(colData && typeof colData === 'object') {
      return true;
    } else {
      return false;
    }
  }

  getMenus(event, key, index, rowData) {
    Array.from(document.getElementsByClassName('ellipisis')).forEach((element, arrayIndex)=>{
      if (index=== arrayIndex){
        document.getElementsByClassName('ellipisis')[index].classList.add('overdraw');
      } else if (document.getElementsByClassName('ellipisis')[arrayIndex].classList.contains('overdraw')) {
        document.getElementsByClassName('ellipisis')[arrayIndex].classList.remove('overdraw');
      }
    });
    this.actionList = [];
    this.actionList.push({
      label: this.translate.instant(FccGlobalConstant.VIEW_ADDITIONAL_INFO),
      command: () => this.onClickEye(event, key, index, rowData)
    });
  }

  keyPressRouteDots(event) {
    this.actionList.forEach(element => {
      if (element.label === event.target.innerText) {
        element.command();
      }
    });
  }

  setDirections(value: string) {
    return this.dir === 'rtl' ? (value === 'left' ? 'paginatorright' : 'paginatorleft') :
    (value === 'left' ? 'paginatorleft' : 'paginatorright');
  }

  setCurrentPage(event: { target: { value: number; }; }) {
    this.ptable.first = ((event.target.value -1) * this.ptable.rows);
    this.ptable.firstChange.emit(this.ptable.first);
    this.ptable.onLazyLoad.emit(this.ptable.createLazyLoadMetadata());
  }

  setPageSize(data: { pageSize: number; }){
    this.ptable._rows = data.pageSize;
    this.ptable.onLazyLoad.emit(this.ptable.createLazyLoadMetadata());
  }

  setCurrentPageForEnrichTable(event: { target: { value: number; }; }) {
    this.enrichTable.first = ((event.target.value -1) * this.enrichTable.rows);
    this.enrichTable.firstChange.emit(this.enrichTable.first);
    this.enrichTable.onLazyLoad.emit(this.enrichTable.createLazyLoadMetadata());
  }

  setPageSizeForEnrichTable(data: { pageSize: number; }){
    this.enrichTable._rows = data.pageSize;
    this.enrichTable.onLazyLoad.emit(this.enrichTable.createLazyLoadMetadata());
  }

  onClickViewFile(docId, fileName) {
    this.fileHandlingService.viewFile(docId, fileName);
  }
}
