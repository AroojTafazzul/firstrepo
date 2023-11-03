import { FccGlobalConstant } from '../../../common/core/fcc-global-constants';
import { Injectable } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from '../../../common/services/common.service';


@Injectable({
  providedIn: 'root'
})
export class CashCommonDataService {
  emptyString = 'KEY_EMPTYSTRING';
  constructor(protected translateService: TranslateService, protected commonService: CommonService) { }

  public getStopChequeReasonParamData(response: any, bankName: string, language: string, elementId: any, product: string) {
    let stopChequeReasonList = [];
    const paramDetails = response.largeParamDetails;
    for (let i = 0; i < paramDetails.length; i++) {
      const keyDetails = paramDetails[i].largeParamKeyDetails;
      if (keyDetails.key_1 !== null) {
        if (keyDetails.key_1 !== '*' && keyDetails.key_2 === product && keyDetails.key_1 === bankName &&
          keyDetails.key_4 === language) {
          for (let j = 0; j < paramDetails[i].largeParamDataList.length; j++) {
            if (paramDetails[i].largeParamDataList[j].data_2 === FccGlobalConstant.CODE_Y) {
              if (stopChequeReasonList.length === FccGlobalConstant.ZERO) {
                stopChequeReasonList = [{ label: paramDetails[i].largeParamDataList[j].data_1,
                value: paramDetails[i].largeParamDataList[j].data_1 }];
              } else if (stopChequeReasonList.length > 0 && stopChequeReasonList[0].value !== '' ||
                          stopChequeReasonList[0].value !== null) {
                stopChequeReasonList.push({ label: paramDetails[i].largeParamDataList[j].data_1,
                value: paramDetails[i].largeParamDataList[j].data_1,
                id: elementId.concat('_').concat(paramDetails[i].largeParamDataList[j].data_1) });
              }
            }

          }
        } else if (keyDetails.key_1 === '*' && keyDetails.key_2 === product && keyDetails.key_4 === language) {
            for (let j = 0; j < paramDetails[i].largeParamDataList.length; j++) {
                if (stopChequeReasonList.length === FccGlobalConstant.ZERO) {
                  stopChequeReasonList = [{ label: paramDetails[i].largeParamDataList[j].data_1,
                  value: paramDetails[i].largeParamDataList[j].data_1 }];
                } else if (stopChequeReasonList.length > 0 && stopChequeReasonList[0].value !== '' ||
                            stopChequeReasonList[0].value !== null) {
                  stopChequeReasonList.push({ label: paramDetails[i].largeParamDataList[j].data_1,
                  value: paramDetails[i].largeParamDataList[j].data_1,
                  id: elementId.concat('_').concat(paramDetails[i].largeParamDataList[j].data_1) });
                }
            }
          }
      }
    }
    return stopChequeReasonList;
  }

  getDepositTypeList(paramDataList: any): any {
    return [...new Set(paramDataList.map(x => x.data_1))];
  }

  getTenorPeriodList(paramDataList: any, eventValue: any): any {
    const list = paramDataList.filter(value => (value.data_1 === eventValue)).map(a => a.data_4.concat(a.data_5));
    return [...new Set(list)];
  }

  getCurrencyList(paramDataList: any, eventValue: any, selectedDT: any): any {
    const tpNum = eventValue.substr(0, eventValue.length - 1);
    const tpCode = eventValue.substr(eventValue.length - 1);
    const curList = paramDataList.filter(value => value.data_1 === selectedDT && value.data_4 === tpNum && value.data_5 === tpCode)
    .map(a => a.data_6);
    return [...new Set(curList)];
  }

  getMaturityInstList(paramDataList: any, selectedDT: any): any {
    const tds = 'TDS';
    let miList;
    if (this.commonService.isNonEmptyValue(selectedDT)) {
      miList = paramDataList.filter(value => value.data_1 === selectedDT && value.data_2 === tds).map(a => a.data_3);
    }
    else {
      miList = paramDataList.filter(value => value.data_2 === tds).map(a => a.data_3);
    }
    return [...new Set(miList)];
  }

  getMaturityCreditEnable(paramDataList: any, selectedDT: any, maturityInst: any): any {
    const tds = 'TDS';
    let maturityCreditEnable;
    if (this.commonService.isNonEmptyValue(selectedDT)) {
      maturityCreditEnable = paramDataList.filter(
          value => value.data_1 === selectedDT && value.data_2 === tds && value.data_3 === maturityInst).map(a => a.data_5);
    }
    return maturityCreditEnable;
  }
}
