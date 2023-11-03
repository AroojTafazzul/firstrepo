import { Transaction } from '../../../../common/model/transaction.model';
import { Bank } from '../../../../model/bank.model';
import { Narrative } from '../../../../common/model/narrative.model';



export class ReceivedUndertaking extends Transaction {

  template_id: string;
  issDateTypeCode: string;
  issDateTypeDetails: string;
  issDate: string;
  expDateTypeCode: string;
  expDate: string;
  expEvent: string;
  amdNo: string;
  bgAmdDate: string;
  bgCurCode: string;
  bgAmt: string;
  bg_liab_amt: string;
  release_amt: string;
  bg_outstanding_amt: string;
  bg_type_code: string;
  bg_type_details: string;
  bgRule: string;
  bg_rule_other: string;
  bgTextTypeCode: string;
  bgTextTypeDetails: string;
  bgReleaseFlag: string;
  applicantAbbvName: string;
  applicantName: string;
  applicantAddressLine1: string;
  applicantAddressLine2: string;
  applicantDom: string;
  applicantAddressLine4: string;
  applicantCountry: string;
  applicantReference: string;
  open_chrg_brn_by_code: string;
  corr_chrg_brn_by_code: string;
  beneficiaryAbbvName: string;
  beneficiaryName: string;
  beneficiaryAddressLine1: string;
  beneficiaryAddressLine2: string;
  beneficiaryDom: string;
  beneficiaryAddressLine4: string;
  beneficiaryCountry: string;
  beneficiaryReference: string;
  contactName: string;
  contactAddressLine1: string;
  contactAddressLine2: string;
  contactAddressLine4: string;
  contactDom: string;
  contactCountry: string;
  issuingBankTypeCode: string;
  advSendMode: string;
  contractReference: string;
  contract_date: string;
  contract_amt: string;
  contract_cur_code: string;
  contract_pct: string;
  bgPrincipalActNo: string;
  bgFeeActNo: string;
  bgTextLanguage: string;
  bgTextLanguageOther: string;
  bg_text_details_code: string;
  bg_code: string;
  forAccount: string;
  advBankConfReq: string;
  reductionAuthorised: string;
  reductionClause: string;
  reductionClauseOther: string;
  character_commitment: string;
  delivery_to: string;
  delivery_to_other: string;
  altApplicantName: string;
  altApplicantAddressLine1: string;
  altApplicantAddressLine2: string;
  altApplicantAddressLine4: string;
  altApplicantDom: string;
  altApplicantCountry: string;
  consortium: string;
  consortium_details: string;
  guarantee_type_company_id: string;
  guarantee_type_name: string;
  deliveryChannel: string;
  provisional_status: string;
  leadBankFlag: string;
  bgRenewFlag: string;
  bgRenewOnCode: string;
  bgRenewalCalendarDate: string;
  bgRenewForNb: string;
  bgRenewForPeriod: string;
  bgAdviseRenewalFlag: string;
  bgAdviseRenewalDaysNb: string;
  bgRollingRenewalFlag: string;
  bgRollingRenewalNb: string;
  bgRollingCancellationDays: string;
  bgRenewAmtCode: string;
  bgFinalExpiryDate: string;
  original_xml: string;
  claim_cur_code: string;
  claim_amt: string;
  claim_reference: string;
  claim_present_date: string;
  docRefNo: string;
  rollingDayInMonth: string;
  bgRollingRenewOnCode: string;
  bgRollingRenewForNb: string;
  bgRollingRenewForPeriod: string;
  projectedExpiryDate: string;
  contract_narrative: string;
  tender_expiry_date: string;
  bg_available_amt: string;
  refId: string;
  recipientBank: Bank;
  issuingBank: Bank;
 confirmingBank: Bank;
  advisingBank: Bank;
  processingBank: Bank;
  narrativeAdditionalInstructions: Narrative;
  bo_comment: Narrative;
  free_format_text: Narrative;
  bgAmdDetails: Narrative;
  bgDocument: Narrative;
  xslFo: Narrative;
  returnComments: Narrative;
  cuAmt: string;
  cuCurCode: string;
 }
