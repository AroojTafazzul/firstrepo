import { Component, OnInit, HostListener } from '@angular/core';
import { DynamicDialogRef } from 'primeng/dynamicdialog';
import { Router } from '@angular/router';
@Component({
  selector: 'app-lc-template-confirmation',
  templateUrl: './lc-template-confirmation.component.html',
  styleUrls: ['./lc-template-confirmation.component.scss']
})
export class LcTemplateConfirmationComponent implements OnInit {

  constructor(protected dynamicDialogRef: DynamicDialogRef, protected router: Router) { }

  
  ngOnInit(): void {
    //eslint : no-empty-function
  }

  @HostListener('document:keydown.escape') onKeydownHandler() {
    this.onDialogClose();
  }

  onDialogClose() {
    this.dynamicDialogRef.close();
  }
  onDiscardChanges() {
    this.onDialogClose();
    this.router.navigate(['/dashboard/global']);
  }
}
