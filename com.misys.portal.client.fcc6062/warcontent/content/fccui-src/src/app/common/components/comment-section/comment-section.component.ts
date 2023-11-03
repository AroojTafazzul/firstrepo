import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from '../../services/common.service';


@Component({
  selector: 'fcc-comment-section',
  templateUrl: './comment-section.component.html',
  styleUrls: ['./comment-section.component.scss']
})
export class CommentSectionComponent implements OnInit {

  constructor(protected translateService: TranslateService,
    public CommonService: CommonService) { }

  @Input() visible: any;
  @Input() position: any;
  @Input() disableReturn;
  @Input() selectedRowsData: any;
  @Input() commentsRequired: any;
  @Input() commentsMandatory: any;
  @Input() remarkRequired:any;
  @Input() buttonList: any;
  @Input() bottomButtonList: any;
  @Output() handleAction: EventEmitter<any> = new EventEmitter<any>();
  charactersEnteredValue: any;
  comments: any;
  maxCommentLn=250;

  dir: string = localStorage.getItem('langDir');

  ngOnInit() {
    if (this.buttonList?.length) {
      this.buttonList.forEach(button => {
        button.label = this.translateService.instant(button.localizationKey);
      });
    }
  }

  get charactersEntered() {
    if (this.comments) {
    this.charactersEnteredValue = this.comments.length;
    return this.charactersEnteredValue;
    } else {
      return 0;
    }
  }

  onClick(clickEvent, button, comments) {
    this.handleAction.emit({
      event: clickEvent,
      comment: comments,
      action: button.name ? button.name : button.localizationKey,
      routerLink: button.routerLink
    });
  }
  ngAfterViewChecked(): void {
  if(this.charactersEntered!== 0)
  {
  this.CommonService.scrapCommentRequired= false;
  }
  }
}
