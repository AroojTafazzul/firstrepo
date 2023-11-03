import { Component, ElementRef, HostListener, Inject, Input, OnInit, QueryList, ViewChild, ViewChildren } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { MessageService } from 'primeng';
import { BehaviorSubject, Observable, Subject, Subscription } from 'rxjs';
import { DynamicContentComponent } from '../base/components/dynamic-content.component';
import { FCCFormGroup } from '../base/model/fcc-control.model';
import { ProductComponent } from '../common/components/product-component/product.component';
import { FccStepperComponent } from '../common/components/stepper/fcc-stepper/fcc-stepper.component';
import { FccGlobalConstant } from '../common/core/fcc-global-constants';
import { StepperParams } from '../common/model/stepper-model';
import { CommonService } from '../common/services/common.service';
import { EventEmitterService } from '../common/services/event-emitter-service';
import { FormControlService } from '../corporate/trade/lc/initiation/services/form-control.service';
@Component({
  selector: 'confirmation-guard-dialog',
  templateUrl: 'confirmation-guard-dialog.component.html',
  styleUrls: ['./confirmation-guard-dialog.component.scss'],
  providers: [ProductComponent]
})

export class ConfirmationGuardDialogComponent implements OnInit {
  public destroyed = new Subject<any>();
  title: string = this.translateService.instant('confirmation');
  message: string = this.translateService.instant('confirmationDialogMessage');
  saveButtonText = this.translateService.instant('save');
  discardButtonText = this.translateService.instant('discard');
  stayButtonText = this.translateService.instant('stayHere');
  menuToggleFlag: string;
  storeIndexValue = 0;
  productCode: string;
  save = this.translateService.instant('save');
  previous = this.translateService.instant('previous');
  next = this.translateService.instant('next');
  Submit = this.translateService.instant('submit');
  showProgresssSpinner: boolean;
  showSavedTimeText: boolean;
  savedTime = '';
  lcHeaderKey: string;
  productFormKey: string;
  sections = false;
  selectedType: string;
  tasks = false;
  value = 0;
  items: any[] = [];
  componentType: string;
  eventRequired: boolean;
  @ViewChild('container') public container: DynamicContentComponent;
  @ViewChildren('hiddenContainer') public hiddenContainer: QueryList<DynamicContentComponent>;
  @ViewChild('stepper') public stepper: FccStepperComponent;
  @ViewChild(ProductComponent) public productComponent: ProductComponent;
  isParentFormValid: boolean;
  buttonDetails: any[] = [];
  intervalId1;
  intervalId2;
  count = 1;
  savedTimeTextShowvalue = false;
  public spinnerShow = new BehaviorSubject(false);
  public saveUrlStatus = new BehaviorSubject(this.save);
  public savedTimeTextShow = new BehaviorSubject(false);
  public savedTimeText = new BehaviorSubject(this.savedTime);
  timerCode = 60000;
  minutesago = `${this.translateService.instant('minutesAgo')}`;
  savedJustNow = `${this.translateService.instant('savedJustNow')}`;
  leftSectionEnabled;
  referenceId: string;
  eventId: string;
  @Input() inputParams;
  mode: any;
  tnxType: any;
  refId: any;
  tnxId: any;
  eventTypeCode: any;
  option: any;
  subTnxType: any;
  subTnxTypeCode: any;
  templateId: any;
  operation: any;
  prodStatus: any;
  tnxStatus: any;
  subProductCode: any;
  actionReqCode: any;
  stepperParams: StepperParams;
  review = false;
  isMaster: boolean;
  accordionViewRequired = false;
  reviewComments: any;
  tnxStatCode: any;
  subTnxStatCode: any;
  reInit: boolean;
  reviewCommentsHeader: any;
  subscription: Subscription;
  disabled = 'disabled';
  view = this.translateService.instant('view');
  formName: string;
  modeTnxType = 'mode';
  moduleName: string;
  IEview = navigator.userAgent.indexOf('Trident') !== -1;
  channelRefID: any;
  setSystemID = false;
  channelReference: any;
  parentTnxId: any;
  stepperReEval = false;
  stateType = '';
  stateId: string;

  // review Screen from tranasction tab
  reviewTnxTypeCode: any;
  reviewSubTnxType: any;
  // review Screen from event tab
  eventTnxTypeCode: any;
  eventSubTnxType: any;
  parent = false;
  viewMaster = false;
  titleKey: any;

  form: FCCFormGroup;
  params = FccGlobalConstant.PARAMS;
  readonly = FccGlobalConstant.READONLY;
  sectionName: any;
  dir: string = localStorage.getItem('langDir');
  autoSavemessage: string = this.translateService.instant('autoSaveConfirmationDialogMessage');
  saveForLaterButtonText = this.translateService.instant('saveForLater');
  noCancelButtonText = this.translateService.instant('noCancel');
  yesCancelButtonText = this.translateService.instant('yesCancel');
  isAutoSaveEnabled = false;
  daysConfigured: any;
  autoSaveInfo: any ='';

  constructor(
    @Inject(MAT_DIALOG_DATA) protected data: any,
    protected dialogRef: MatDialogRef<ConfirmationGuardDialogComponent>,
    protected translateService: TranslateService,
    protected activatedRoute: ActivatedRoute,
    protected router: Router, protected commonService: CommonService,
    protected messageService: MessageService, protected formControlService: FormControlService,
    protected eventEmitterService: EventEmitterService, protected eRef: ElementRef) { }
  public subject: Subject<boolean>;
  @HostListener('document:keydown.escape') onKeydownHandler() {
      this.onDialogClose();
  }


  ngOnInit(): void {
    const subProductCode = FccGlobalConstant.SUB_PRODUCT_CODE;
    const tnxTypeCode = FccGlobalConstant.TNX_TYPE_CODE;
    const option = FccGlobalConstant.OPTION;
    const templateId = FccGlobalConstant.TEMPLATE_ID;
    const mode = FccGlobalConstant.MODE;
    const refId = FccGlobalConstant.REF_ID;
    const tnxId = FccGlobalConstant.TNX_ID;
    const subTnxTypeCode = FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE;
    const operation = FccGlobalConstant.OPERATION;
    const actionReqCode = FccGlobalConstant.ACTION_REQUIRED_CODE;
    this.eventEmitterService.autoSaveDetails.subscribe(val=>{
      this.daysConfigured = val?.data_3;
    });
    this.commonService.getMenuValue().subscribe((value) => {
      this.menuToggleFlag = value;
    });
    this.activatedRoute.queryParams.subscribe(params => {
      this.commonService.clearQueryParameters();
      Object.keys(params).forEach(element => {
        if (this.isParamValid(params[element])) {
          if (element === 'productCode') {
            this.productCode = params[element];
            this.subProductCode = params[subProductCode];
            this.tnxType = params[tnxTypeCode];
            this.option = params[option];
            this.templateId = params[templateId];
            this.mode = params[mode];
            this.refId = params[refId];
            this.tnxId = params[tnxId];
            this.subTnxType = params[subTnxTypeCode];
            this.operation = params[operation];
            this.actionReqCode = params[actionReqCode];
          }
          this.commonService.putQueryParameters(element, params[element]);
        }
      });
    });
    this.isAutoSaveEnabled = this.data?.isBene;
    if(this.isAutoSaveEnabled === true){
      this.title = this.translateService.instant('confirmationmsg');
      this.message = this.autoSavemessage;
      this.autoSaveInfo = this.translateService.instant('autoSavedaysConfigMsg')+
      this.daysConfigured +this.translateService.instant('days');
      this.autoSaveInfo = this.autoSaveInfo ? this.autoSaveInfo : '';
    }

  }

  onSaveForLater() {
    this.dialogRef.close('saveForLater');
  }

  onDontCancel() {
    this.dialogRef.close('dontCancel');
  }

  onYesCancel() {
    this.dialogRef.close('cancel');
  }


  isParamValid(param: any) {
    let isParamValid = false;
    if (param !== undefined && param !== null && param !== '') {
      isParamValid = true;
    }
    return isParamValid;
  }
  onNoClick(): void {
    this.dialogRef.close();
  }
  onConfirmClick(): void {
    this.dialogRef.close(true);
  }
  onConfirmationSave() {
    this.eventEmitterService.onConfirmationSave();
    this.dialogRef.close(true);
    const ref = this.refId ? this.refId : this.commonService.referenceId;
    const tosterObj = {
        maxOpened: 1,
        autoDismiss: true,
        life: 2000,
        key: 'tc',
        severity: 'success',
        summary: `${ref}`,
        detail: this.translateService.instant('singleSaveToasterMessage')
      };
    this.messageService.add(tosterObj);
  }
  onDiscard() {
    let result: Observable<any>;
    const eventId = this.tnxId ? this.tnxId : this.commonService.eventId;
    const ref = this.refId ? this.refId : this.commonService.referenceId;
    if (this.productCode === FccGlobalConstant.PRODUCT_LC) {
      result = this.commonService.deleteLC(eventId);
    } else if (this.productCode === FccGlobalConstant.PRODUCT_EL) {
      result = this.commonService.deleteEL(eventId);
    } else if (this.productCode !== '') {
      result = this.commonService.genericDelete(this.productCode , ref , eventId, this.subProductCode);
    }

    result.subscribe(data => {
      if (data.status === FccGlobalConstant.LENGTH_200) {
        setTimeout(() => {
          //eslint : no-empty-function
      }, FccGlobalConstant.LENGTH_2000);
      }
    });
    setTimeout(() => {
      this.dialogRef.close(true);
      const tosterObj = {
        maxOpened: 1,
        autoDismiss: true,
        life: 2000,
        key: 'tc',
        severity: 'success',
        summary: `${ref}`,
        detail: this.translateService.instant('singleDiscardToasterMessage')
      };
      this.messageService.add(tosterObj);
    }, FccGlobalConstant.LENGTH_2000);
  }
  onDialogClose() {
    this.dialogRef.close();
  }
  setDirection() {
    if (this.dir === 'rtl') {
    return 'right';
    } else {
    return 'left';
    }
  }
  setDirectionButton() {
    if (this.dir === 'rtl') {
    return 'left';
    } else {
    return 'right';
    }
  }
}
