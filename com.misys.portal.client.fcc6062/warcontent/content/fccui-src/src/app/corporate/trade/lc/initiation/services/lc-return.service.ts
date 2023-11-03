import { FccGlobalConstantService } from './../../../../../common/core/fcc-global-constant.service';
import { TranslateService } from '@ngx-translate/core';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { FccGlobalConstant } from '../../../../../common/core/fcc-global-constants';
@Injectable({
  providedIn: 'root'
})

export class LcReturnService {
  allLcRecords;
  tnxLcRecords;
    constructor(protected translateService: TranslateService, protected http: HttpClient,
                protected fccGlobalConstantService: FccGlobalConstantService
      ) {
    }
    details = this.translateService.instant('Details');
    amendementDetails = this.translateService.instant('Amendement_details');
    messageToBank = this.translateService.instant('Message_to_bank');
    items = [
        { label: 'Details', id: 'Details' },
        { label: 'AmendementDetails', id: 'AmendementDetails' },
        { label: 'MessageToBank', id: 'MessageToBank' }
      ];
    getTanMenuList() {
        return this.items;
    }
    public getMasterTransaction(lcnumber): Observable<any> {
      const contentType = FccGlobalConstant.APP_JSON;
      const headers = new HttpHeaders({ 'Content-Type': contentType });
      const reqURl = `${this.fccGlobalConstantService.getMasterTransaction}/${lcnumber}`;
      this.allLcRecords = this.http.get<any>(reqURl, { headers });
      return this.allLcRecords;
    }

    public getLCTransactionData(lcnumber): Observable<any> {
      const contentType = FccGlobalConstant.APP_JSON;
      const headers = new HttpHeaders({ 'Content-Type': contentType });
      const reqURl = `${this.fccGlobalConstantService.getLCTransactionData}/${lcnumber}`;
      this.tnxLcRecords = this.http.get<any>(reqURl, { headers });
      return this.tnxLcRecords;
    }

}

