import { TranslateLoader } from '@ngx-translate/core';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, forkJoin } from 'rxjs';
import { map } from 'rxjs/operators';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { FccGlobalConstant } from '../common/core/fcc-global-constants';

const contextPath = window[FccGlobalConstant.CONTEXT_PATH];
const restServletName = window[FccGlobalConstant.RESTSERVLET_NAME];
@Injectable({ providedIn: 'root' })
export class FccTranslationService implements TranslateLoader {

    baseUrl = `${contextPath}${restServletName}/`;
    constructor(protected http: HttpClient) { }

    getTranslation(lang: string): Observable<any> {

         return forkJoin([
            this.http.get(`${this.baseUrl}getlocalizationdetails?language=${lang}`).pipe(),
            this.http.get(`${contextPath}/content/FCCUI/assets/i18n/${lang}.json`).pipe()
         ]).pipe(map(([res1, res2]) => Object.assign(res2, res1)));
    }
 }
