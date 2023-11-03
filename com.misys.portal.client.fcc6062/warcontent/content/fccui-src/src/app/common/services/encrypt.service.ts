import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { FccGlobalConstant } from '../core/fcc-global-constants';
import { FccGlobalConstantService } from '../core/fcc-global-constant.service';
import { Observable } from 'rxjs';

declare let RSAKey: any;

@Injectable({ providedIn: 'root' })
export class EncryptionService {

  constructor(protected http: HttpClient, public fccGlobalConstantService: FccGlobalConstantService) {}

  encryptText(passPhrase: any, htmlUsedModulus: any, crSeq: any) {
      const jsencrypt = new RSAKey();
      jsencrypt.setPublic(htmlUsedModulus, '10001');
      return jsencrypt.encrypt(passPhrase) + crSeq;
  }

  public generateKeys(): Observable<any> {
  const headers = new HttpHeaders({ 'Content-Type': FccGlobalConstant.APP_JSON });
  const reqUrl = `${this.fccGlobalConstantService.getGenerateKeysUrl()}`;
  const requestPayload = {};
  return this.http.post<any>(reqUrl, requestPayload, { headers });
  }

}
