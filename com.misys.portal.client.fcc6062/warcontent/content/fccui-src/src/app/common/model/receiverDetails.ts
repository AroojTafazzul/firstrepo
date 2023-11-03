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


/**
 * Receiver definition
 */
export interface ReceiverDetails {
    /**
     * The email id of the user in the company to whom the notification is to be sent
     */
    email?: string;
    /**
     * Select whether to send notification on any event occuring on this item for the counterparty
     */
    emailNotificationRequired?: string;
    /**
     * The login id of the user to whom the task is to be assigned
     */
    loginId?: string;
    /**
     * The user id of the user for whom the task is to be assigned
     */
    userId?: string;
}