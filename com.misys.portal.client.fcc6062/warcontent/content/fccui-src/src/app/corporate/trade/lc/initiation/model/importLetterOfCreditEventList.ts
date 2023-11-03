/**
 * Import Letter of Credit
 * _Import Letter of Credit (ILC) is an undertaking to pay to a beneficiary (an exporter), issued by a bank on behalf of
 * its corporate customer (an importer; applicant) for procured goods or services. A payment is released to the exporter a
 * gainst a presentation of specified documentation and in accordance with the terms of the letter of credit._  _The ILC
 * reflects the transaction request from the perspective of an importer and the importer's bank, typically known as the i
 * ssuing bank._  _'Issuance request' is the initial event that creates the ILC transaction event. This event could only b
 * e created once per ILC. If changes to the basic details of the ILC are needed, an 'Amendment request' event could be cr
 * eated. Once the beneficiary submits their documents and claims the payment, a 'Claims Received' event is created. The '
 * Amend' and 'Claims Received' events can be created multiple times and at any point in the ILC lifecycle prior to its ex
 * piry._  _Issuance request can be for the final issuance of letter of credit by the issuing bank or if this request is
 *  marked as "Provisional", then it is for vetting the text of the letter of credit by the issuing bank. On finalisatio
 * n of the text between the corporate customer and the bank the actual letter of credit will be issued by the bank._  _T
 * here are two kinds of IDs in this API: id and eventId. The eventId is the identifier returned for events such as 'Issua
 * nce', 'Amendment' and 'Claims Received'. The id is the identifier returned for the ILC master and it is created together
 *  with the 'Issuance' event. A master ILC transaction can have one 'Issuance' event and multiple 'Amendment' and 'Claim
 * s Received' events._
 *
 * OpenAPI spec version: 1.1.0
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */
import { ImportLetterofCreditEventInquiry } from './importLetterofCreditEventInquiry';
import { LCMeta } from './meta';


/**
 * Import Letter of Credit Event List
 */
export class ImportLetterOfCreditEventList {
    /**
     * The list of events under an Import letter of credit
     */
    items?: Array<ImportLetterofCreditEventInquiry>;
    meta?: LCMeta;
}