import {
  Component,
  OnInit,
  Output,
  EventEmitter,
  Input,
  ViewChild,
  OnChanges,
  AfterViewChecked
} from '@angular/core';
import { LeftSectionService } from '../../../../corporate/common/services/leftSection.service';
import { CommonService } from '../../../services/common.service';
import { MatStepper } from '@angular/material/stepper';
import { StepperParams } from '../../../model/stepper-model';
import { STEPPER_GLOBAL_OPTIONS, StepperSelectionEvent } from '@angular/cdk/stepper';
import { TranslateService } from '@ngx-translate/core';
import { FccGlobalConstant } from '../../../core/fcc-global-constants';
import { ProductStateService } from '../../../../corporate/trade/lc/common/services/product-state.service';
import { MatDialog } from '@angular/material/dialog';
import { Subscription } from 'rxjs';

@Component({
  selector: 'mat-fcc-stepper',
  templateUrl: './fcc-stepper.component.html',
  styleUrls: ['./fcc-stepper.component.scss'],
  providers: [
    {
      provide: STEPPER_GLOBAL_OPTIONS,
      useValue: { displayDefaultIndicatorType: false, showError: true }
    }
  ]
})
export class FccStepperComponent implements OnInit, OnChanges, AfterViewChecked {
  @ViewChild('stepper', { static: false }) stepper: MatStepper;
  // @ViewChild('stepRef') stepRef: MatStep;
  @Input() inputParams: StepperParams;
  @Output() indexChangeEvent: EventEmitter<any> = new EventEmitter<any>();
  enableStepper: boolean;
  currentComponent;
  data: any = {};
  activeIndex = 0;
  isLinear: boolean;
  isEditable: boolean;
  barLength;
  barValue: number;
  stepChangeEvent: StepperSelectionEvent;
  isButtonAction;
  idx;
  enableLicenseSection: boolean;

  public steps: any[] = [];
  subscription: Subscription;

  ngOnDestroy(): void {
    this.reset();
    this.subscription.unsubscribe();
  }

  constructor(
    protected leftSectionService: LeftSectionService,
    protected commonService: CommonService,
    protected translateService: TranslateService,
    protected productStateService: ProductStateService,
    protected dialog: MatDialog
  ) {
    this.subscription = commonService.missionAnnounced$.subscribe(
      mission => {
        this.updateStepper(mission);
    });
  }

  updateStepper(mission) {
    if (mission === 'yes') {
      this.stepper.linear = true;
      this.stepper.selected.completed = false;
    } else {
      this.stepper.linear = false;
      this.stepper.selected.completed = true;
    }
  }
  ngOnInit() {
    //eslint : no-empty-function
  }

  ngOnChanges() {
    // A check whether to render the Stepper Component on basis of the personalization
    this.steps = this.inputParams.items;
    this.commonService.loadDefaultConfiguration().subscribe(response => {
      if (response) {
        this.leftSectionService.handleLicenseSection(this.steps);
      }
    });
    this.isEditable = this.inputParams.isEditable;
    this.isLinear = this.inputParams.isLinear;

    this.leftSectionService.progressBarData.subscribe(
      data => {
        this.barValue = data;
      }
    );
    this.leftSectionService.highlightMenuSection.subscribe(
      data => {
        this.activeIndex = data;
      });
    this.leftSectionService.isButtonAction.subscribe(
        action => {
          this.isButtonAction = action;
      });
    this.leftSectionService.addSummarySection();
  }

  ngAfterViewChecked(): void {
    if (this.inputParams.reEvaluate) {
      this.reEvaluateProgress();
    }

   // hack to get autogenerated idx value, required for automation team.
    this.idx = this.stepper._getStepLabelId(0).split('-', FccGlobalConstant.LENGTH_5)[FccGlobalConstant.LENGTH_3];
    this.leftSectionService.reEvaluateProgressBar.subscribe(value => {
      if (value) {
        this.reEvaluateProgress();
      }}
    );
  }

  // After transitioning,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  stepChanged(event) {
    this.leftSectionService.isButtonAction.next(false);
  }


  // run before transitioning,
  // events order is important for proper save and highlighting.
  selectionChange(event: StepperSelectionEvent) {
    this.activeIndex = event.selectedIndex;
    if (!this.isButtonAction) {
      this.indexChangeEvent.emit(event);
    }
    this.reEvaluateProgress();
  }

  /**
   * get formstate from state service for each section.
   * for summary section, check parent form state.
   */
  isFormValid(index: number): boolean {
      return this.steps[index] === 'summaryDetails' ? this.isParentFormValid()
      : this.productStateService.isSectionFormValid(this.steps[index]);
  }

  updateProgressBar(formValid: boolean, index: number) {
    if (this.steps[index] !== 'summaryDetails') {
    this.barLength = this.leftSectionService.progressBarPerIncrease(this.steps[index]);
    if (formValid) {
      if (this.barValue >= 0 && this.barValue < FccGlobalConstant.LENGTH_100 &&
        this.leftSectionService.getSectionProgressBarData(this.steps[index]) !== true) {
        this.leftSectionService.progressBarData.next(this.barValue + this.barLength);
        this.leftSectionService.putProgressBardata(this.steps[index], true);
      }
    } else {
      if (this.barValue > 0 && this.barValue <= FccGlobalConstant.LENGTH_100 &&
        this.leftSectionService.getSectionProgressBarData(this.steps[index]) === true) {
          this.leftSectionService.progressBarData.next(this.barValue - this.barLength);
          this.leftSectionService.putProgressBardata(this.steps[index], false);
      } else {
        if (this.barValue >= 0 && this.barValue <= FccGlobalConstant.LENGTH_100 && this.steps.length < 3) {
          this.leftSectionService.progressBarData.next(0);
        }
      }
    }
  }
  }

  /**
   * reset stepper and progressbar
   */
  reset() {
    this.leftSectionService.resetProgressBarMap();
    this.stepper.reset();
    this.leftSectionService.progressBarData.next(0);
    this.leftSectionService.highlightMenuSection.next(0);
    this.leftSectionService.reEvaluateProgressBar.next(false);
  }


  reEvaluateProgress() {
    this.barValue = 0;
    this.stepper.steps.forEach((step, index) => {
      if (this.steps[index] !== 'summaryDetails') {
        this.leftSectionService.putProgressBardata(this.steps[index], false);
      }
      // edit mode scenario, update dependent sections progress dynamically
      if (this.inputParams.reEvaluate || (!this.inputParams.reEvaluate && step.interacted)) {
        const valid = this.isFormValid(index);
        this.updateProgressBar(valid, index);
        step.completed = valid;
        step.hasError = !valid;
      }
    });
  }


  /**
   * prior to parent form validity, checks if all sections are set in parent form
   */
  isParentFormValid(): boolean {
    let isSectionSet = true;
    this.steps.forEach((step) => {
      if (step !== 'summaryDetails' && !this.productStateService.isStateSectionSet(step)) {
        isSectionSet = false;
      }
    });
    return isSectionSet ? this.productStateService.isParentStateValid() : false;
  }

}

