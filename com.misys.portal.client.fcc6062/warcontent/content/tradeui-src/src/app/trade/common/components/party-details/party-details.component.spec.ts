import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PartyDetailsComponent } from './party-details.component';

describe('GenericBankDetailsComponent', () => {
  let component: PartyDetailsComponent;
  let fixture: ComponentFixture<PartyDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PartyDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PartyDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
