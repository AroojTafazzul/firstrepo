import { AbstractControl } from '@angular/forms';

/* This method is to validate whether last shipment date is less than expiry date or not */

export function compareLastShipmentDate(control: AbstractControl) {
  return { comparelastshipmentdate: {
    parsedDomain: control.value
  }
};
}
export function compareLastShipmentDateWithApplicationDate(control: AbstractControl) {
  return { comparelastshipmentdatewithapplicationdate: {
    parsedDomain: control.value
  }
};
}
export function compareNewExpiryDateToOld(control: AbstractControl) {
  return { compareNewExpiryDateToOld: {
    parsedDomain: control.value
  }
};
}
export function compareNewAmountToOld(control: AbstractControl) {
  return { compareNewAmountToOld: {
    parsedDomain: control.value
  }
};
}
export function compareNewExpiryDateToIssueDate(control: AbstractControl) {
  return { compareNewExpiryDateToIssueDate: {
    parsedDomain: control.value
  }
};
}
export function compareExpDateWithLastShipmentDate(control: AbstractControl) {
  return { compareExpDateWithLastShipmentDate: {
    parsedDomain: control.value
  }
};
}
