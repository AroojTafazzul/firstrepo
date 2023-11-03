import { FCCBase } from './../../../../base/model/fcc-base';
import { TextControl, ImgControl } from './../../../../base/model/form-controls.model';
import { FCCFormGroup } from './../../../../base/model/fcc-control.model';
import { OPEN_CLOSE_ANIMATION } from '../../../model/animation';
import { Component, OnInit, Input, OnChanges, AfterViewInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { HOST_COMPONENT } from './../../../../shared/FCCform/form/form-resolver/form-resolver.directive';
import { CommonService } from './../../../../../app/common/services/common.service';


@Component({
  selector: 'fcc-news-left',
  templateUrl: './fcc-news-left.component.html',
  styleUrls: ['./fcc-news-left.component.scss'],
  providers: [{ provide: HOST_COMPONENT, useExisting: FccNewsLeftComponent }],
  animations: [OPEN_CLOSE_ANIMATION]
})
export class FccNewsLeftComponent extends FCCBase implements OnChanges, OnInit, AfterViewInit {

  @Input() newsObject;
  form: FCCFormGroup;
  module = '';

  constructor(protected translateService: TranslateService, public downloadFile: CommonService) {
    super();
  }

  ngOnInit() {

    this.initializeGroup();
    if (this.newsObject.titleLink) {
      this.patchFieldParameters(this.form.get('download'), { rendered: false });
      this.patchFieldParameters(this.form.get('link'), { rendered: true });
    } else {
      this.patchFieldParameters(this.form.get('download'), { rendered: true });
      this.patchFieldParameters(this.form.get('link'), { rendered: false });
    }
    (this.newsObject.attachment[0].attachmentId && this.newsObject.attachment[0].attachmentId !== null
      && this.newsObject.attachment[0].attachmentId !== '') ? this.patchFieldParameters(this.form.get('download'), { rendered: true })
    : this.patchFieldParameters(this.form.get('download'), { rendered: false });
    this.form.updateValueAndValidity();
  }

  ngAfterViewInit() {
    //eslint : no-empty-function
  }

  ngOnChanges() {
    this.initializeGroup();
    if (this.newsObject.titleLink) {
      this.patchFieldParameters(this.form.get('download'), { rendered: false });
      this.patchFieldParameters(this.form.get('link'), { rendered: true });
    } else {
      this.patchFieldParameters(this.form.get('download'), { rendered: true });
      this.patchFieldParameters(this.form.get('link'), { rendered: false });
    }
  }


  initializeGroup() {
    this.form = new FCCFormGroup({
      title: new TextControl('lcheader', this.translateService, {
        label: this.newsObject.title,
        key: 'lcheader',
        rendered: true,
        layoutClass: 'p-col-10',
        styleClass: ['title lefttitle']
      }),
      download: new ImgControl('download', this.translateService, {
        label: 'Download',
        rendered: true,
        fontawesome: 'fa-download',
        styleClass: ['p-col-6 '],
        key: 'itemId',
        itemId: 'download',
        title: 'Download',
        layoutClass: 'p-col-2 download'
      }),
      link: new ImgControl('link', this.translateService, {
        label: '',
        rendered: true,
        title: 'External link',
        pimengicon: 'pi-external-link',
        layoutClass: 'p-col-2 externallink',
        styleClass: ['p-col-2'],
        key: 'itemId',
        itemId: 'link',
      }),
      image: new ImgControl('lcheader', this.translateService, {
        label: this.newsObject.image,
        key: 'lcheader',
        rendered: true,
        layoutClass: 'p-col-12 newsbannerimage',
        styleClass: ['image']
      }),
      desc: new TextControl('lcheader', this.translateService, {
        label: this.newsObject.completeDesc,
        key: 'lcheader',
        rendered: true,
        layoutClass: '',
        styleClass: ['completeDesc']
      })

    });
    this.form.setFormMode('edit');
  }
// eslint-disable-next-line @typescript-eslint/no-unused-vars
  onClickDownload(event, key, index) {
    const id = this.newsObject.attachment[0].attachmentId;
    const fileName = this.newsObject.attachment[0].fileName;
    this.downloadFile.downloadNewsAttachments(id, 'news').subscribe(
      response => {
        let fileType;
        if (response.type) {
          fileType = response.type;
        } else {
          fileType = 'application/octet-stream';
        }
        const newBlob = new Blob([response.body], { type: fileType });
        // IE doesn't allow using a blob object directly as link href
        // instead it is necessary to use msSaveOrOpenBlob
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveOrOpenBlob(newBlob, fileName);
            return;
        }
        const data = window.URL.createObjectURL(newBlob);
        const link = document.createElement('a');
        link.href = data;
        link.download = fileName;
        // this is necessary as link.click() does not work on the latest firefox
        link.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true, view: window }));
        window.URL.revokeObjectURL(data);
        link.remove();
    });
  }

  onClickLink() {
    window.open(this.newsObject.titleLink, '_blank');
  }



}
