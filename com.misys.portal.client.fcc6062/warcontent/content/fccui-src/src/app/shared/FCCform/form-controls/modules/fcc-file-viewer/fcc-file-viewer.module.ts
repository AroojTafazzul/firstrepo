import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { NgxExtendedPdfViewerModule } from 'ngx-extended-pdf-viewer';
import { FccFileViewerComponent } from './fcc-file-viewer.component';



@NgModule({
  declarations: [FccFileViewerModule.rootComponent],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    NgxExtendedPdfViewerModule
  ],
  entryComponents: [FccFileViewerModule.rootComponent],
  exports: [FccFileViewerModule.rootComponent],
})
export class FccFileViewerModule {
  static rootComponent = FccFileViewerComponent;
}
