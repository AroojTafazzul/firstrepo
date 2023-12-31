import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PhraseDialogComponent } from './phrase-dialog.component';

describe('PhraseDialogComponent', () => {
  let component: PhraseDialogComponent;
  let fixture: ComponentFixture<PhraseDialogComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PhraseDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PhraseDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
