import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ViewModeSelectComponent } from './view-mode-select.component';
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [ViewModeSelectModule.rootComponent],
  imports: [CommonModule, ReactiveFormsModule],
  entryComponents: [ViewModeSelectModule.rootComponent],
  exports: [ViewModeSelectModule.rootComponent],
})
export class ViewModeSelectModule {
  static rootComponent = ViewModeSelectComponent;
}
