import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { FccOverlayComponent } from './../components/fcc-overlay/fcc-overlay.component';



interface DialogConfig {
  styleClass?: string;
  showHeader?: boolean;
  header?: string;
  dir?: string;
  data?: any;
}

@Injectable({
  providedIn: 'root'
})
export class FccOverlayService {

  constructor(protected translateService: TranslateService,
              protected dialogReference: DynamicDialogRef,
              protected dialogService: DialogService) { }

  open(config: DialogConfig) {
    this.translateService.get('corporatechannels').subscribe(() => {
      this.dialogReference = this.dialogService.open(FccOverlayComponent, {
        data: {
          docUrl: config.data.docUrl,
          componentName: config.data.componentName
        },
        header: config.header,
        contentStyle: {
          overflow: 'auto',
          direction: config.dir
        },
        styleClass: config.styleClass,
        showHeader: config.showHeader,
        baseZIndex: 9999,
        autoZIndex: true,
        dismissableMask: true,
        closeOnEscape: true,
      });

      this.dialogReference.onClose.subscribe();
    });
  }
}
