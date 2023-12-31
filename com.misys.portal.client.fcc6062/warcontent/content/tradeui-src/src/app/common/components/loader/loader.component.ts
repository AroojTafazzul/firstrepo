import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { LoaderState } from './loader';
import { LoaderService } from '../../services/loader.service';

@Component({
  selector: 'fcc-common-loader',
  templateUrl: './loader.component.html',
  styleUrls: ['./loader.component.css']
})
export class LoaderComponent implements OnInit, OnDestroy {

  show = false;

  private subscription: Subscription;

  constructor(
    private readonly loaderService: LoaderService
) { }

ngOnInit() {
    this.subscription = this.loaderService.loaderState
        .subscribe((state: LoaderState) => {
            this.show = state.show;
        });
}

ngOnDestroy() {
    this.subscription.unsubscribe();
}

}
