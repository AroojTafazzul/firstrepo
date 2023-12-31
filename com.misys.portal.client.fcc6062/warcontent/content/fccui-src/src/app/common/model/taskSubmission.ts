/**
 * Tasks Management
 * Create a task for the corporate or bank user
 *
 * OpenAPI spec version: 1.0.0
 *
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */
import { BankUserDetails } from './bankUserDetails';
import { CounterpartyUserDetails } from './counterpartyUserDetails';
import { IssuerDetails } from './issuerDetails';
import { ReceiverDetails } from './receiverDetails';
import { TaskDetails } from './taskDetails';


/**
 * Task submission by the corporate user
 */
export interface TaskSubmission {
    task?: TaskDetails;
    issuer?: IssuerDetails;
    counterpartyUser?: CounterpartyUserDetails;
    bankUser?: BankUserDetails;
    companyUser?: ReceiverDetails;
}
