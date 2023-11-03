/**
 * Import Letter of Credit
 * Import Letter of Credit (ILC) is an undertaking to pay to a beneficiary (an exporter), issued
 *  by a bank on behalf of its corporate customer (an importer; applicant) for procured goods or se
 * rvices. A payment is released to the exporter against a presentation of specified documentation
 * and in accordance with the terms of the letter of credit.  The ILC reflects the transaction requ
 * est from the perspective of an importer and the importer's bank, typically known as the issuing b
 * ank.  'Issuance request' is the initial event that creates the ILC transaction event. This event
 * could only be created once per ILC. If changes to the basic details of the ILC are needed, an 'Am
 * endment request' event could be created. Once the beneficiary submits their documents and claims
 * the payment, a 'Claims Received' event is created. The 'Amend' and 'Claims Received' events can b
 * e created multiple times and at any point in the ILC lifecycle prior to its expiry.  Issuance requ
 * est can be for the final issuance of letter of credit by the issuing bank or if this request is ma
 * rked as \"Provisional\", then it is for vetting the text of the letter of credit by the issuing ban
 * k. On finalisation of the text between the corporate customer and the bank, the actual letter of cr
 * edit will be issued by the bank.  There are two kinds of IDs in this API: id and eventId. The eventI
 * d is the identifier returned for events such as 'Issuance', 'Amendment' and 'Claims Received'. The
 * id is the identifier returned for the ILC master and it is created together with the 'Issuance' eve
 * nt. A master ILC transaction can have one 'Issuance' event and multiple 'Amendment' and 'Claims Received' events.
 *
 * OpenAPI spec version: 1.1.0
 *
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */

import { ImportLetterOfCreditAmendment } from './importLetterOfCreditAmendment';
import { MessageResponse } from './messageResponse';


/**
 * Response object for successful letter of credit amendment request
 */
export interface ImportLetterOfCreditAmendmentResponse extends ImportLetterOfCreditAmendment {
    /**
     * System Generated reference id for the letter of credit transaction
     */
    id?: string;
    /**
     * Unique identifier of the event transaction
     */
    eventId?: string;
    messageResponse?: MessageResponse;
}