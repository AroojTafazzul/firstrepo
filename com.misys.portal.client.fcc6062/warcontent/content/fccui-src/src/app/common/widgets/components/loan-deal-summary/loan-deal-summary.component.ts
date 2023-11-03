import { HttpClient } from '@angular/common/http';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';

import { LendingCommonDataService } from '../../../../corporate/lending/common/service/lending-common-data-service';
import { CarouselCardParams, CarouselParams } from '../../../model/carousel-model';
import { GlobalDashboardComponent } from './../../../components/global-dashboard/global-dashboard.component';
import { FccGlobalConstantService } from './../../../core/fcc-global-constant.service';
import { FccGlobalConstant } from './../../../core/fcc-global-constants';
import { OPEN_CLOSE_ANIMATION } from './../../../model/animation';
import { CommonService } from './../../../services/common.service';
import { DashboardService } from './../../../services/dashboard.service';
import { HideShowDeleteWidgetsService } from './../../../services/hide-show-delete-widgets.service';

@Component({
  selector: 'app-loan-deal-summary',
  templateUrl: './loan-deal-summary.component.html',
  styleUrls: ['./loan-deal-summary.component.scss'],
  animations: [OPEN_CLOSE_ANIMATION]
})
export class LoanDealSummaryComponent implements OnInit {
  @Input()
  widgetDetails: any;
  nudges: any;
  @Input() inputParams: any = [];
  widgetCode: any = '';
  widgets;
  widgetConfig;
  hideShowCard;
  carouselCardParams: CarouselCardParams[] = [];
  carouselParams: CarouselParams;
  userFirstName = '';
  checkCustomise: any;
  classCheck: any;
  contextPath: any;
  currentPathLoanDeals: any;
  selectedDealId: string;
  innerWidth;

  constructor(protected hideShowDeleteWidgetsService: HideShowDeleteWidgetsService,
              protected globalDashboardComponent: GlobalDashboardComponent,
              protected commonService: CommonService,
              protected dashboardService: DashboardService,
              protected fccGlobalConstantService: FccGlobalConstantService,
              protected http: HttpClient,
              protected translate: TranslateService,
              protected lendingService: LendingCommonDataService,
    protected router: Router, protected activatedRoute: ActivatedRoute) {
      this.activatedRoute.queryParams.subscribe(queryParams => {
        this.widgetCode = queryParams[`widgetCode`] || '';
      });
              }

  ngOnInit(): void {
    this.commonService.getNudges(this.widgetDetails).then(data => {
      this.nudges = data;
    });
    this.widgets = this.widgetDetails ? JSON.parse(this.widgetDetails) : '';
    this.currentPathLoanDeals = (this.activatedRoute.url[FccGlobalConstant.VALUE][1].path === FccGlobalConstant.LOANDEALS) ? true : false;
    this.currentPathLoanDeals && this.auditCall();
    if (this.widgets !== '' && this.widgets.widgetConfig) {
      this.widgetConfig = JSON.parse(this.widgets.widgetConfig);
     }
    this.dashboardService.getUserDetails().subscribe(
      userDetails => {
        this.userFirstName = userDetails.firstName;
      }
    );

    this.lendingService.getBorrowerDeals().toPromise().then(res => {
      if (res && res.dealList.length > 0) {
        res.dealList.forEach(deal => {
          deal[`unformatSantionLimit`] = deal.totalLimit.replace(/,/g, '');
        });
        this.prepareForCarousel(res.dealList.sort((a, b) => b.unformatSantionLimit - a.unformatSantionLimit));
        this.enableDefaultCardSelection();
      }
    });

    this.commonService.dashboardOptionsSubject.subscribe(check => {
      this.classCheck = check;
    });

    this.hideShowDeleteWidgetsService.customiseSubject.subscribe(customiseCheck => {
      this.checkCustomise = customiseCheck;
    });

    this.activatedRoute.queryParams.subscribe(params =>
      this.selectedDealId = params[`id`]
    );
    this.innerWidth = window.innerWidth;
  }

  auditCall() {
    const requestPayload = {
      productCode: 'DEALDASHBOARD',
      subProductCode: this.activatedRoute.snapshot.queryParams[FccGlobalConstant.SUB_PRODUCT_CODE],
      operation: this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPERATION),
      option: this.commonService.getQueryParametersFromKey(FccGlobalConstant.OPTION),
      action: this.commonService.getQueryParametersFromKey(FccGlobalConstant.ACTION),
      tnxtype: this.commonService.getQueryParametersFromKey(FccGlobalConstant.TNX_TYPE_CODE),
      mode: this.commonService.getQueryParametersFromKey(FccGlobalConstant.MODE),
      subTnxType: this.commonService.getQueryParametersFromKey(FccGlobalConstant.SUB_TRANSACTION_TYPE_CODE),
      listDefName: this.inputParams && this.inputParams.listdefName ? this.inputParams.listdefName : ''
    };
    this.commonService.audit(requestPayload).subscribe(() => {
      //eslint : no-empty-function
    });
  }

  private enableDefaultCardSelection() {
    const reqUrl = '/dashboard/loanDeals';
    if (this.activatedRoute.url[FccGlobalConstant.VALUE][1].path === FccGlobalConstant.LOANDEALS) {
      this.activatedRoute.queryParams.subscribe(params => {
        if (!params.id) {
          this.carouselCardParams[0].selected = true;
          this.commonService.dealDetailsDashboardLoad(this.carouselCardParams[0]);
          this.router.navigate([reqUrl], { queryParams: { id: this.carouselCardParams[0].reference } });
        } else {
          this.carouselCardParams.forEach(card => {
            if (card.reference === params.id) {
              card.selected = true;
              this.commonService.dealDetailsDashboardLoad(card);
              this.router.navigate([reqUrl], { queryParams: { id: card.reference } });
            } else {
              card.selected = false;
            }
          });
        }
      });
    }
  }

  protected prepareForCarousel(items: any) {
    items.forEach(item => {
      const cardParams = { description: '' };
      cardParams[FccGlobalConstant.NAME] = item.dealName;
      cardParams[FccGlobalConstant.REFERENCE] = item.dealId;
      this.setEntityOrBorrowerDetails(item, cardParams);
      cardParams[FccGlobalConstant.TEXT1] = this.translate.instant('sanctionLimit');
      cardParams[FccGlobalConstant.TEXT2] = item.currency.concat(' ').concat(item.totalLimit);
      cardParams[FccGlobalConstant.SELECTED] = false;
      this.carouselCardParams.push(cardParams);
    });
    this.carouselParams = {
      cardParams: this.carouselCardParams,
      numVisible: 3,
      numScroll: 2
    };
  }

  get selectedPage(): number {
    if (this.commonService.isNonEmptyValue(this.selectedDealId)) {
      const selectedIndex = this.carouselCardParams
        .findIndex((carouselCard) => carouselCard[FccGlobalConstant.REFERENCE] === this.selectedDealId);
     return selectedIndex;
    } else {
      return 0;
    }
  }

  protected setEntityOrBorrowerDetails(item: any, cardParams: { description: string; }) {
    let numOfborrowers = item.borrowers.length;
    const entities = this.extractEntitiesFromBorrowers(item.borrowers);
    let numOfEntiies = entities ? entities.length : 0;
    if (numOfborrowers === FccGlobalConstant.LENGTH_1) {
      if (numOfEntiies === FccGlobalConstant.LENGTH_1) {
        cardParams[FccGlobalConstant.DESCRIPTION] += entities[numOfEntiies - FccGlobalConstant.LENGTH_1].entityAbbvName;
      } else if (numOfEntiies > FccGlobalConstant.LENGTH_0) {
        while (numOfEntiies--) {
          const entity = entities[numOfEntiies];
          if (numOfEntiies === FccGlobalConstant.LENGTH_0) {
            cardParams[FccGlobalConstant.DESCRIPTION] = `${cardParams[FccGlobalConstant.DESCRIPTION].toString()
              .substring(0, cardParams[FccGlobalConstant.DESCRIPTION]
                .toString().length - FccGlobalConstant.LENGTH_2)} and ${entity.entityAbbvName}`;
          } else {
            cardParams[FccGlobalConstant.DESCRIPTION] += `${entity.entityAbbvName}, `;
          }
        }
      } else {
        cardParams[FccGlobalConstant.DESCRIPTION] += item.borrowers[numOfborrowers - FccGlobalConstant.LENGTH_1].customerName;
      }
    } else if (entities !== null && (entities.length > FccGlobalConstant.LENGTH_0)){
      if (entities.length === FccGlobalConstant.LENGTH_1) {
        cardParams[FccGlobalConstant.DESCRIPTION] += entities[numOfEntiies - FccGlobalConstant.LENGTH_1].entityAbbvName;
      } else {
        while (numOfEntiies--) {
          const entity = entities[numOfEntiies];
          if (numOfEntiies === 0) {
            cardParams[FccGlobalConstant.DESCRIPTION] = `${cardParams[FccGlobalConstant.DESCRIPTION].toString()
              .substring(0, cardParams[FccGlobalConstant.DESCRIPTION]
                .toString().length - FccGlobalConstant.LENGTH_2)} and ${entity.entityAbbvName}`;
          } else {
            cardParams[FccGlobalConstant.DESCRIPTION] += `${entity.entityAbbvName}, `;
          }
        }
      }
    } else {
      while (numOfborrowers--) {
        const borrower = item.borrowers[numOfborrowers];
        if (numOfborrowers === 0) {
          cardParams[FccGlobalConstant.DESCRIPTION] = `${cardParams[FccGlobalConstant.DESCRIPTION].toString()
            .substring(0, cardParams[FccGlobalConstant.DESCRIPTION]
              .toString().length - FccGlobalConstant.LENGTH_2)} and ${borrower.customerName}`;
        } else {
          cardParams[FccGlobalConstant.DESCRIPTION] += `${borrower.customerName}, `;
        }
      }
    }
  }

  extractEntitiesFromBorrowers(borrowers) {
    const entityArray = [];
    borrowers.forEach(borrower => {
      if (this.commonService.isNonEmptyValue(borrower.entities) && borrower.entities !== '') {
        borrower.entities.forEach(entity => {
          const checkRoleExistence = roleParam => entityArray.some( ({ entityAbbvName }) => entityAbbvName === roleParam);
          if (!checkRoleExistence(entity.entityAbbvName)) {
            entityArray.push(entity);
          }
        });
      }
    });
    return entityArray;
  }

  deleteCards() {
    this.hideShowDeleteWidgetsService.loanDealSummary.next(true);
    this.hideShowDeleteWidgetsService.loanDealSummary.subscribe(res => {
      this.hideShowCard = res;
    });
    setTimeout(() => {
      this.hideShowDeleteWidgetsService.getSmallWidgetActions(this.widgets.widgetName, this.widgets.widgetPosition);
      this.globalDashboardComponent.deleteCardLayout(this.widgets.widgetName);
    }, FccGlobalConstant.DELETE_TIMER_INTERVAL);
  }

  captureSelectedCardDetails(event) {
    this.commonService.dealDetailsDashboardLoad(event);
    this.activatedRoute.params.subscribe(
      params => {
        this.hideShowDeleteWidgetsService.flagForDropDown = false;
        if (params.name === FccGlobalConstant.LOANDEALS) {
          this.router.navigate([], { queryParams: { id: event.reference } });
        } else {
          this.router.navigate(['/dashboard/loanDeals'], { queryParams: { id: event.reference } });
        }
      }
    );
  }
}
