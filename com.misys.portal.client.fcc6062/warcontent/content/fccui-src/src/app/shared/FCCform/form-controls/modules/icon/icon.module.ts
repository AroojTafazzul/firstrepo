import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IconComponent } from './icon.component';
import { TranslateModule } from '@ngx-translate/core';
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [IconModule.rootComponent],
  imports: [CommonModule, TranslateModule, ReactiveFormsModule],
  entryComponents: [IconModule.rootComponent],
  exports: [IconModule.rootComponent],
})
export class IconModule {
  static rootComponent = IconComponent;
}
