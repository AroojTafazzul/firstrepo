import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { FccGlobalConstantService } from '../core/fcc-global-constant.service';
import { FccGlobalConstant } from '../core/fcc-global-constants';

@Injectable({
    providedIn: 'root'
})
export class TransactionDetailService {

  constructor(protected http: HttpClient, public fccGlobalConstantService: FccGlobalConstantService) {}

    public fetchTransactionDetails(id: string, productCode?: string, isTemplate = false, subProductCode?: string): Observable<any> {
      const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
      let reqUrl: string;
      const url = this.fccGlobalConstantService.getTransactionDetails;
      const typeOfId = isTemplate ? 'templateId' : 'eventId';
      if (isTemplate) {
        id = btoa(id);
      }
      if (productCode && subProductCode) {
        reqUrl = `${url}?${typeOfId}=${id}&productCode=${productCode}&subProductCode=${subProductCode}`;
      } else if (productCode) {
        reqUrl = `${url}?${typeOfId}=${id}&productCode=${productCode}`; }
         else if (id === null){
          return;
      } else {
        reqUrl = `${url}?refId=${id}`;
      }
      return this.http.get<any>(reqUrl, { headers, observe: 'response' });
      }

    public getExcludedFieldsNdSections(productCode?: string, subProductCode?: string) {
      const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON, 'cache-request': 'true' });
      let reqUrl: string;
      const url = this.fccGlobalConstantService.getExcludedFieldsNdSections;
      if (productCode && subProductCode) {
        reqUrl = `${url}?productCode=${productCode}&SubProductCode=${subProductCode}`;
      } else if (productCode) {
        reqUrl = `${url}?productCode=${productCode}`;
      }
      return this.http.get<any>(reqUrl, { headers, observe: 'response' });
    }

    public fetchBankTemplateDetails(productCode: string, requestParams: any) {
      const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
      const reqUrl = `${this.fccGlobalConstantService.getBankTemplateDetails}?productCode=${productCode}`+
                      `&featureid=${requestParams.FEATUREID}&companyid=${requestParams.COMPANYID}`;
      return this.http.get<any>(reqUrl, { headers, observe: 'response' });
    }
    public downloadEditor(params) {
      const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
      return this.http.post(this.fccGlobalConstantService.downloadSpecimenEditor, params, {
        headers,
        responseType: "blob",
        observe: "response",
      });
    }
    public downloadUndertakingSpecimenEditor(params): Observable<any> {
      const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON, 'Access-Control-Allow-Origin': '*' });
      return this.http.post(this.fccGlobalConstantService.downloadUndertakingSpecimenEditor, params,
        { headers, responseType: 'blob', observe: 'response' });
    }
}
