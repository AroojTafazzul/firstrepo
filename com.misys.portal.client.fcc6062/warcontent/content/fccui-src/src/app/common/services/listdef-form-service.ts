import { FccGlobalParameterFactoryService } from '../core/fcc-global-parameter-factory-service';
import { Injectable } from '@angular/core';
import { Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { FccGlobalConstant } from '../core/fcc-global-constants';

@Injectable({
  providedIn: 'root'
})
export class FormService {

  config: any[] = [];
  numberOfDisplayableParameters: any = 0;

  constructor(protected paramService: FccGlobalParameterFactoryService,
              protected translate: TranslateService) {}

  getFields(inputJson: any, productCode: string) {
    this.config = [];
    if (inputJson) {
    this.prepareFormJson(inputJson, productCode);
    }
    return this.config;
  }

  getNoOfDisplayableParams() {
    return this.numberOfDisplayableParameters;
  }
  getOptions(options: any) {
    options = options.substring(1, options.length - 1);
    const arrayOfKeyValues = options.split(',');
    const obj = [];
    for (let i = 0; i < arrayOfKeyValues.length; i++) {
        const arrayValues = arrayOfKeyValues[i].split(':');
        if (arrayValues[FccGlobalConstant.LENGTH_1] === FccGlobalConstant.DEFAULT_TIMEFRAME) {
          obj.push({
            label : (arrayValues[FccGlobalConstant.LENGTH_2]),
            value : (arrayValues[FccGlobalConstant.LENGTH_1]),
            displayedValue: (arrayValues[FccGlobalConstant.LENGTH_2])
          });
        } else {
        obj.push({
          label : (arrayValues[FccGlobalConstant.LENGTH_0]) + ' ' + (arrayValues[FccGlobalConstant.LENGTH_2]),
          value : (arrayValues[FccGlobalConstant.LENGTH_0]) + (arrayValues[FccGlobalConstant.LENGTH_1]),
          displayedValue: (arrayValues[FccGlobalConstant.LENGTH_0]) + ' ' + (arrayValues[FccGlobalConstant.LENGTH_2])
        });
      }
    }
    return obj;
  }

  prepareFormJson(inputJson: any, pdtCode: string) {
    if ( null !== inputJson && inputJson !== undefined ) {
      inputJson.Search.forEach(element => {
        if (!element.hidden) {
          if (element.type === '' && !element.isCodeField) {
            this.config.push({
              name : element.name,
              type: this.paramService.getParameterType(element.type),
              localizationkey: (element.localizationkey !== null) ? this.translate.instant(element.localizationkey) : '',
              readonly: element.readonly,
              value: element.value,
              validation: [Validators.maxLength(element.maxLength)],
            });
            this.numberOfDisplayableParameters++;
          } else if (element.type === 'export') {
            this.config.push({
              name : element.name,
              type: element.type,
              fileName: element.fileName
            });
          } else if (element.type === 'AvailableTimeFrames') {
            const optionValues = this.getOptions(element.allowedDependentValuesString);
            this.config.push({
              name : 'timeframe',
              type : FccGlobalConstant.selectButton,
              options : optionValues,
              selected : optionValues[0].value,
            });
          } else {
            this.config.push({
              name : element.name,
              type: this.paramService.getParameterType(element.type, element.isCodeField),
              localizationkey: this.translate.instant(element.localizationkey),
              readonly: element.readonly,
              options: this.prepareDropDownValues(element),
              layoutClass : element.layoutClass,
              styleClass: element.styleClass,
              rendered: element.rendered,
              defautValue: element.defaultRadioValue,
              key: element.name,
              productCode: pdtCode
            });
            this.numberOfDisplayableParameters++;
          }
      }
    });
  }
}

  prepareDropDownValues(element) {
    const dropdownValues: any[] = [];
    if (element.allowedValuesString) {
        const values = element.allowedValuesString.substring(1, element.allowedValuesString.length - 1).split(',');
        let labelValue = values;
        if (element.allowedValuesLabelsString) {
        labelValue = element.allowedValuesLabelsString.substring(1, element.allowedValuesLabelsString.length - 1).split(',');
        }
        let i = 0;
        for (const itemValue of values) {
          dropdownValues.push({
            label: labelValue[i].trim(),
            value: itemValue.trim()
          });
          i++;
        }
      }
    return dropdownValues;
  }
}
