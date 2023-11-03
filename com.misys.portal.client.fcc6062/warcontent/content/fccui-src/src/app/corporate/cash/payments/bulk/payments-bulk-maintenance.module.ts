import { FccLcModule } from './../../../trade/lc/fcc-lc.module';
import { FccLcRoutes } from './../../../trade/lc/fcc-lc.routes';
import { FormResolverModule } from './../../../../shared/FCCform/form/form-resolver/form-resolver.module';
import { CommonModule } from '@angular/common';
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatDialogModule } from '@angular/material/dialog';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatTabsModule } from '@angular/material/tabs';
import { MatTooltipModule } from '@angular/material/tooltip';
import { AngularEditorModule } from '@kolkov/angular-editor';
import { TranslateModule } from '@ngx-translate/core';
import { RecaptchaModule } from 'ng-recaptcha';
import { AccordionModule } from 'primeng/accordion';
import { ButtonModule } from 'primeng/button';
import { CalendarModule } from 'primeng/calendar';
import { CardModule } from 'primeng/card';
import { CheckboxModule } from 'primeng/checkbox';
import { DialogModule } from 'primeng/dialog';
import { DropdownModule } from 'primeng/dropdown';
import { FileUploadModule } from 'primeng/fileupload';
import { InputSwitchModule } from 'primeng/inputswitch';
import { InputTextModule } from 'primeng/inputtext';
import { InputTextareaModule } from 'primeng/inputtextarea';
import { KeyFilterModule } from 'primeng/keyfilter';
import { MessageModule } from 'primeng/message';
import { MessagesModule } from 'primeng/messages';
import { MultiSelectModule } from 'primeng/multiselect';
import { OrganizationChartModule } from 'primeng/organizationchart';
import { OverlayPanelModule } from 'primeng/overlaypanel';
import { ProgressBarModule } from 'primeng/progressbar';
import { ProgressSpinnerModule } from 'primeng/progressspinner';
import { RadioButtonModule } from 'primeng/radiobutton';
import { SelectButtonModule } from 'primeng/selectbutton';
import { StepsModule } from 'primeng/steps';
import { TableModule } from 'primeng/table';
import { TabViewModule } from 'primeng/tabview';
import { PaymentsBulkFileUploadGeneralComponent } from './payments-bulk-upload/payments-bulk-file-upload-general.component';
import { PaymentsBulkMaintenanceRoutes } from './payment-bulk-maintenance.routes';
import { PaymentsProductComponent } from './payments-product/payments-product.component';
import { PaymentsFileUploadDialogComponent } from './payments-file-upload-dialog/payments-file-upload-dialog.component';
import { PaymentsBulkFiletemplateDownloadComponent } from './payments-bulk-template-download/payments-bulk-filetemplate-download.component';

@NgModule({
  declarations: [
    PaymentsBulkFileUploadGeneralComponent,
    PaymentsBulkFiletemplateDownloadComponent,
    PaymentsFileUploadDialogComponent,
    PaymentsProductComponent
  ],
  imports: [
    CommonModule,
    PaymentsBulkMaintenanceRoutes,
    MatIconModule,
    MatInputModule,
    MatFormFieldModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatRadioModule,
    MatCheckboxModule,
    MatButtonToggleModule,
    MatSelectModule,
    MatSlideToggleModule,
    MatIconModule,
    MatInputModule,
    MatFormFieldModule,
    FccLcModule,
    FccLcRoutes,
    MatExpansionModule,
    MatTooltipModule,
    ReactiveFormsModule,
    FormsModule,
    MessagesModule,
    MessageModule,
    CalendarModule,
    RecaptchaModule,
    RadioButtonModule,
    ButtonModule,
    CheckboxModule,
    DropdownModule,
    MultiSelectModule,
    KeyFilterModule,
    InputTextModule,
    TabViewModule,
    InputTextareaModule,
    SelectButtonModule,
    ProgressBarModule,
    OrganizationChartModule,
    StepsModule,
    InputSwitchModule,
    CardModule,
    FileUploadModule,
    TableModule,
    OverlayPanelModule,
    MatCardModule,
    MatTabsModule,
    TranslateModule,
    DialogModule,
    ProgressSpinnerModule,
    MatDialogModule,
    MatAutocompleteModule,
    AccordionModule,
    FormResolverModule,
    AngularEditorModule
  ],
  providers: [],
  entryComponents: [
    PaymentsBulkFileUploadGeneralComponent
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class PaymentsBulkMaintenanceModule { }
