import { Injectable } from '@angular/core';
import { HttpRequest, HttpResponse, HttpHandler, HttpInterceptor, HttpErrorResponse, HttpEvent } from '@angular/common/http';
import { throwError, Observable, of } from 'rxjs';
import { catchError, retry, tap } from 'rxjs/operators';
import { Router } from '@angular/router';
import { CommonService } from './common/services/common.service';
import { FccGlobalConstant } from './common/core/fcc-global-constants';
import { FccGlobalConfiguration } from './common/core/fcc-global-configuration';
import { FccGlobalConstantService } from './common/core/fcc-global-constant.service';


@Injectable()
export class Interceptor implements HttpInterceptor {

   constructor(protected router: Router, protected commonService: CommonService,
               protected fccGlobalConfiguration: FccGlobalConfiguration, protected fccGlobalConstantService: FccGlobalConstantService) {
   }
   intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
      if (req && req.body && Object.prototype.hasOwnProperty.call(req.body, 'captcha')) {
      this.commonService.interceptorRetry = 0;
      }
      let encodedUrl = req.url;
      // The URL Parameters are in general encoded by angular.
      //  However in some cases the same is byepassed as the entire URL including request parameters
      //   are handled as a single URL. Here such URLs will be catched and the request parameters are encoded
      if (encodedUrl.indexOf('?') > -1) {
            encodedUrl = req.url.substr(0, req.url.indexOf('?') + 1) +
               req.url.substr(req.url.indexOf('?') + 1).split('&').map(s => encodeURI(s)).join('&');
      }

      let cachedRequest = false;

      // Hard coded URL for model as there are other places which are failing.
      if (encodedUrl.indexOf(this.fccGlobalConstantService.productModelUrl) > -1) {
         encodedUrl = req.urlWithParams;
      }

      // To return the cached response if any for the get requests
      //  which are marked for caching by the header cache-request as true
      if (req.method === 'GET' && req.headers.get('cache-request') === 'true') {
         // console.log('this is a cached request' + encodedUrl);
         cachedRequest = true;
      }
      if (cachedRequest) {
         const lastResponse = this.commonService.getCachedResponses().get(encodedUrl);
         if (lastResponse !== undefined && lastResponse !== null) {
            // console.log('returning the cached response for encodedUrl:' + encodedUrl  + ' and response is: ' + lastResponse);
            return of(lastResponse);
         }
      }

      let authReq = null;
      // This is to handle the request with httpparams. Currently only model is having the httpparams and hence hard coded.
      if (encodedUrl.indexOf(this.fccGlobalConstantService.productModelUrl) > -1) {
         authReq = req.clone({
            setHeaders: {
               'Cache-Control': 'no-cache',
               Pragma: 'no-cache'
            }
         });
      } else {
         authReq = req.clone({
            setHeaders: {
               'Cache-Control': 'no-cache',
               Pragma: 'no-cache'
            },
            url: encodedUrl
         });
      }

      if (req.method === 'POST' || req.method === 'PUT') {
         return next.handle(authReq)
         .pipe(tap(),
            catchError((error: HttpErrorResponse) => this.handleError(error))
         );
      } else {
         return next.handle(authReq)
         .pipe(tap(event => {
            if (cachedRequest) {
               if (event instanceof HttpResponse) {
                  this.commonService.getCachedResponses().set(encodedUrl, event.clone());
                  // console.log('adding the entry: ' + encodedUrl + ',  at length' + this.commonService.getCachedResponses().size);
               }
            }
         }),
            retry(this.commonService.interceptorRetry),
            catchError((error: HttpErrorResponse) => this.handleError(error))
         );
      }
   }

   private handleError(error: HttpErrorResponse): Observable<never> | undefined {
      if ((error.status === FccGlobalConstant.LENGTH_0 || error.status === FccGlobalConstant.STATUS_404)
         && !(error.url.indexOf(FccGlobalConstant.NULL_JSON) > -1)) {
            if (this.commonService.commonErrPage === 'true') {
               this.commonService.errorStatus = error.status;
               const dontShowRouter = 'dontShowRouter';
               const servletName = window[FccGlobalConstant.SERVLET_NAME];
               const contextPath = this.commonService.getContextPath();
               const isUrlAcceptable = servletName && window.location.pathname + '#' === (contextPath + servletName) + '#';
               if (window[dontShowRouter] && window[dontShowRouter] === true && !isUrlAcceptable) {
                    const replaceurl = window.location.pathname;
                    window.open(replaceurl, '_self');
               } else {
                  this.router.navigate(['/error']);
               }
            } else {
                // For localization file urls error removing the error page re-direct
               if (error.url.indexOf('/assets/i18n') > -1 ) {
                  return throwError(error);
               }
               this.router.navigate(['/error']);
            }
            return throwError(error);
      } else if (this.commonService.commonErrPage === 'true') {
         if (error.error instanceof ErrorEvent) {
            // A client-side or network error occurred. Handle it accordingly.
            // eslint-disable-next-line no-console
            console.exception('An error occurred:', error.error.message);
         } else {
            // The backend returned an unsuccessful response code.
            this.commonService.errorStatus = error.status;
            if (this.commonService.errorList.indexOf(error.status.toFixed()) > -1 &&
              !(this.router.url === '/login' && error.status === FccGlobalConstant.STATUS_401)) {
                  // 401: Unauthorized Access
                this.router.navigate(['/error']);
            }
            // return an observable with a user-facing error message
            return throwError(error);
         }
      } else {
         return throwError(error);
      }
   }
}
