/**
 * Beneficiary Maintenance
 * Finastra's Beneficiary Maintenance API creates a request to save a beneficiary for funds transfer. It also allows to make changes to the existing beneficiary or delete the beneficiary itself. 
 *
 * OpenAPI spec version: 1.0.1
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */
import { FTBeneficiary } from './beneficiary';
import { Meta } from './meta';


/**
 * List of Beneficiaries
 */
export interface Beneficiaries { 
    /**
     * List of Beneficiaries
     */
    items?: Array<FTBeneficiary>;
    meta?: Meta;
}
