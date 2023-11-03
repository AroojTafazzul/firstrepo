/**
 * Import Letter of Credit
 * Import Letter of Credit (ILC) is an undertaking to pay to a beneficiary (an exporter), issued by a bank on
 * behalf of its corporate customer (an importer; applicant) for procured goods or services. A payment is released
 * to the exporter against a presentation of specified documentation and in accordance with the terms of the letter
 * of credit.  The ILC reflects the transaction request from the perspective of an importer and the importer's bank,
 *  typically known as the issuing bank.  'Issuance request' is the initial event that creates the ILC transaction
 *  event. This event could only be created once per ILC. If changes to the basic details of the ILC are needed,
 * an 'Amendment request' event could be created. Once the beneficiary submits their documents and claims the
 * payment, a 'Claims Received' event is created. The 'Amend' and 'Claims Received' events can be created multiple
 * times and at any point in the ILC lifecycle prior to its expiry.  Issuance request can be for the final
 * issuance of letter of credit by the issuing bank or if this request is marked as \"Provisional\", then it
 * is for vetting the text of the letter of credit by the issuing bank. On finalisation of the text between the
 * corporate customer and the bank, the actual letter of credit will be issued by the bank.  There are two kinds
 * of IDs in this API: id and eventId. The eventId is the identifier returned for events such as 'Issuance',
 * 'Amendment' and 'Claims Received'. The id is the identifier returned for the ILC master and it is created
 * together with the 'Issuance' event. A master ILC transaction can have one 'Issuance' event and multiple
 * 'Amendment' and 'Claims Received' events.
 *
 * OpenAPI spec version: 1.1.0
 *
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */


/**
 * The last processed step for the letter of credit transaction. Possible transaction status code values:
 * * N004_01 = Incomplete * N004_02 = Uncontrolled * N004_03 = Submitted * N004_04 = Acknowledged
 * * N004_05 = Incomplete * N004_06 = Uncontrolled * N004_07 = Error * N004_08 = Transaction Incomplete in Session
 * * N004_09 = Cancelled * N004_11 = Revise * N004_12 = Failed * N004_51 = Business Ack.
 * * N004_52 = Business Reject * N004_53 = Financial Reject * N004_07 = Error * N004_09 = Cancelled
 * * N004_54 = Checker Returned * N004_55 = Checker Return Acknowledged * N004_56 = Maker Draft Acknowledged
 */
export type TransactionStatus = string;