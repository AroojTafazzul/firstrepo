<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:accountUtils="xalan://com.misys.portal.common.tools.AccountUtils"
	xmlns:entityUtils="xalan://com.misys.portal.common.tools.EntityUtils"
	exclude-result-prefixes="utils">
	<xsl:template match="entity_details">
	<result>
 		<com.misys.portal.systemfeatures.entity.EntityFile>
 			<xsl:apply-templates select="entity">
 				<xsl:with-param name="operation_type"><xsl:value-of select="entity/operation_type"/></xsl:with-param>
 				<xsl:with-param name="company_name"><xsl:value-of select="entity/companyShortName"/></xsl:with-param>
 			</xsl:apply-templates>
		</com.misys.portal.systemfeatures.entity.EntityFile>
	</result>
	</xsl:template>
	<xsl:template match="entity">
		<xsl:param name="operation_type"/>
		<xsl:param name="company_name"/>
		
			<com.misys.portal.entity.common.Entity>
			<xsl:variable name="authoriseOwnTransaction" select="systemSettings/authoriseOwnTransaction"/>
			<xsl:variable name="autoForwardDate" select="systemSettings/autoForwardDate"/>
			<xsl:variable name="bulkAuthoriseLimitatPayment" select="systemSettings/bulkAuthoriseLimitatPayment"/>
			<xsl:variable name="checkHashValueinFiles" select="fileUploadSettings/checkHashValueinFiles"/>
			<xsl:variable name="checkFileDuplicates" select="fileUploadSettings/checkFileDuplicates"/>
			<xsl:variable name="checkDuplicateCustomerReference" select="fileUploadSettings/checkDuplicateCustomerReference"/>
			<xsl:variable name="mergeDemergeAllowed" select="fileUploadSettings/mergeDemergeAllowed"/>
			<xsl:variable name="rejectfileonerror" select="fileUploadSettings/rejectFileOnError"/>
			<xsl:variable name="draftfileonerror" select="fileUploadSettings/draftFileOnError"/>
			<xsl:variable name="personal" select="personal"/>
				<xsl:if test="entityId">
			   		<entity_id>
			    	  <xsl:value-of select="entityId"/>
			  	   </entity_id>
				</xsl:if>
				<xsl:if test="companyShortName">
					<company_id>
						<xsl:value-of select="entityUtils:getCompanyIdFromCompanyName($company_name)"/>
					</company_id>
				</xsl:if>
				<xsl:if test="companyShortName">
					<company_abbv_name>
						<xsl:value-of select="companyShortName"/>
					</company_abbv_name>
				</xsl:if>
				<xsl:if test="entityShortName">
					<abbv_name>
						<xsl:value-of select="entityShortName"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="entityName">
					<name>
						<xsl:value-of select="entityName"/>
					</name>
				</xsl:if>
				<xsl:if test="status">
					<status>
						<xsl:value-of select="status"/>
					</status>
				</xsl:if>
				<xsl:if test="version">
					<version>
						<xsl:value-of select="version"/>
					</version>
				</xsl:if>
				<xsl:if test="entityUtils:isChargingAccountEnabled()">
					<xsl:if test="chargeAccountAddress/line1">
						<address_line_1>
							<xsl:value-of select="chargeAccountAddress/line1"/>
						</address_line_1>
					</xsl:if>
					<xsl:if test="chargeAccountAddress/line2">
						<address_line_2>
							<xsl:value-of select="chargeAccountAddress/line2"/>
						</address_line_2>
					</xsl:if>
						<xsl:if test="chargeAccountAddress/line3">
						<address_line_3>
							<xsl:value-of select="chargeAccountAddress/line3"/>
						</address_line_3>
					</xsl:if>
					<xsl:if test="chargeAccountAddress/line4">
						<address_line_4>
							<xsl:value-of select="chargeAccountAddress/line4"/>
						</address_line_4>
					</xsl:if>
				</xsl:if>
				<xsl:if test="address_line_3">
					<dom>
						<xsl:value-of select="address_line_3"/>
					</dom>
				</xsl:if>
				<xsl:if test="subscription_code">
					<subscription_code>
						<xsl:value-of select="subscription_code"/>
					</subscription_code>
				</xsl:if>
				<xsl:if test="customise_package">
					<customise_package>
						<xsl:value-of select="customise_package"/>
					</customise_package>
				</xsl:if>
				<xsl:if test="countryCode">
					<country>
						<xsl:value-of select="countryCode"/>
					</country>
				</xsl:if>
				<xsl:if test="beiCode">
					<bei>
						<xsl:value-of select="beiCode"/>
					</bei>
				</xsl:if>
				<xsl:if test="postalAddress/streetName">
					<street_name>
						<xsl:value-of select="postalAddress/streetName"/>
					</street_name>
				</xsl:if>
				<xsl:if test="postalAddress/postCode">
					<post_code>
						<xsl:value-of select="postalAddress/postCode"/>
					</post_code>
				</xsl:if>
				<xsl:if test="postalAddress/town">
					<town_name>
						<xsl:value-of select="postalAddress/town"/>
					</town_name>
				</xsl:if>
				<xsl:if test="postalAddress/countrySubDivision">
					<country_sub_div>
						<xsl:value-of select="postalAddress/countrySubDivision"/>
					</country_sub_div>
				</xsl:if>
				<xsl:if test="crm_email">
					<crm_email>
						<xsl:value-of select="crm_email"/>
					</crm_email>
				</xsl:if>
				<xsl:if test="email">
					<contact_email>
						<xsl:value-of select="email"/>
					</contact_email>
				</xsl:if>
				<xsl:if test="contactPerson">
					<contact_person>
						<xsl:value-of select="contactPerson"/>
					</contact_person>
				</xsl:if>
				<xsl:if test="subscription_package">
				     <package_id>
				        <xsl:value-of select="subscription_package"/>
				     </package_id>
				</xsl:if>
				<xsl:if test="entityUtils:isChargingAccountEnabled()">
					<xsl:if test="chargingAccount">
					<additional_field name="charging_account" type="string" scope="master">
							<xsl:value-of select="chargingAccount"/>
					</additional_field>
					</xsl:if>
				</xsl:if>
				<xsl:if test="personal">
				<additional_field name="personal" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($personal)"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="country">
				<additional_field name="country_legalid" type="string" scope="master">
						<xsl:value-of select="country"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="legalIdType">
				<additional_field name="legal_id_type" type="string" scope="master">
						<xsl:value-of select="legalIdType"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="legalId">
				<additional_field name="legal_id_no" type="string" scope="master">
						<xsl:value-of select="legalId"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="entityNameLine2">
				<additional_field name="second_entity_name" type="string" scope="master">
						<xsl:value-of select="entityNameLine2"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="systemSettings/authoriseOwnTransaction">
				<additional_field name="authorize_own_transaction" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($authoriseOwnTransaction)"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="systemSettings/autoForwardDate">
				<additional_field name="auto_fwd_date" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($autoForwardDate)"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="systemSettings/bulkAuthoriseLimitatPayment">
			     <additional_field name="bulk_authorize_limit" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($bulkAuthoriseLimitatPayment)"/>
				</additional_field>
			   </xsl:if>
				<xsl:if test="file_encryption_method">
				<additional_field name="file_encryption_method" type="string" scope="master">
						<xsl:value-of select="file_encryption_method"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="ibft_bulk_cnaps_code">
				<additional_field name="ibft_bulk_cnaps_code" type="string" scope="master">
						<xsl:value-of select="ibft_bulk_cnaps_code"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="ibft_cnaps_code">
				<additional_field name="ibft_cnaps_code" type="string" scope="master">
						<xsl:value-of select="ibft_cnaps_code"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="alternativeAddress/line1">
				<additional_field name="alternative_address_line_1" type="string" scope="master">
						<xsl:value-of select="alternativeAddress/line1"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="alternativeAddress/line2">
				<additional_field name="alternative_address_line_2" type="string" scope="master">
						<xsl:value-of select="alternativeAddress/line2"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="alternativeAddress/line3">
				<additional_field name="alternative_address_line_3" type="string" scope="master">
						<xsl:value-of select="alternativeAddress/line3"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="alternativeAddress/line4">
				<additional_field name="alternative_address_line_4" type="string" scope="master">
						<xsl:value-of select="alternativeAddress/line4"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="stnd_charge_cur_code">
                 <additional_field name="stnd_charge_cur_code" type="string" scope="master">
						<xsl:value-of select="stnd_charge_cur_code"/>
				 </additional_field>
                </xsl:if>
                <xsl:if test="stnd_charge_amt">
                 <additional_field name="stnd_charge_amt" type="amount" scope="master">
                 		<xsl:attribute name="currency">stnd_charge_cur_code</xsl:attribute>
						<xsl:value-of select="stnd_charge_amt"/>
				 </additional_field>
                </xsl:if>
                <xsl:if test="special_charge_cur_code">
                 <additional_field name="special_charge_cur_code" type="string" scope="master">
						<xsl:value-of select="special_charge_cur_code"/>
				</additional_field>
                </xsl:if>
                <xsl:if test="special_charge_amt">
                 <additional_field name="special_charge_amt" type="amount" scope="master">
                 		<xsl:attribute name="currency">special_charge_cur_code</xsl:attribute>
						<xsl:value-of select="special_charge_amt"/>
				</additional_field>
                </xsl:if>
                 <xsl:if test="special_charge_expiry">
                 <additional_field name="special_charge_expiry" type="string" scope="master">
						<xsl:value-of select="special_charge_expiry"/>
				</additional_field>
                </xsl:if>
                <xsl:if test="subscription_waive">
                 <additional_field name="subscription_waive" type="string" scope="master">
						<xsl:value-of select="subscription_waive"/>
				</additional_field>
                </xsl:if>
                <xsl:if test="waive_expiry_date">
                 <additional_field name="waive_expiry_date" type="string" scope="master">
						<xsl:value-of select="waive_expiry_date"/>
				</additional_field>
                </xsl:if>
                <xsl:if test="local_tax">
                 <additional_field name="local_tax" type="string" scope="master">
						<xsl:value-of select="local_tax"/>
				</additional_field>
                </xsl:if>
                <xsl:if test="enable_additional_role">
                 <additional_field name="enable_additional_role" type="string" scope="master">
						<xsl:value-of select="enable_additional_role"/>
				</additional_field>
				</xsl:if>
                 <additional_field name="operation_type" type="string" scope="master">
						<xsl:value-of select="$operation_type"/>
				</additional_field>
                <xsl:if test="stnd_charge">
                 <additional_field name="stnd_charge" type="string" scope="master">
						<xsl:value-of select="stnd_charge"/>
				</additional_field>
                </xsl:if>
                 <xsl:if test="remarks">
                 <additional_field name="remark" type="string" scope="master">
						<xsl:value-of select="remarks"/>
				</additional_field>
			   </xsl:if>
			 
			   <xsl:if test="fileUploadSettings/checkHashValueinFiles">
			     <additional_field name="check_file_hash_value" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($checkHashValueinFiles)"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="fileUploadSettings/checkFileDuplicates">
			     <additional_field name="check_duplicate_file" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($checkFileDuplicates)"/>
				</additional_field>
			   </xsl:if>
			    <xsl:if test="fileUploadSettings/checkDuplicateCustomerReference">
			     <additional_field name="check_duplicate_cust_ref" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($checkDuplicateCustomerReference)"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="fileUploadSettings/rejectFileOnError">
			     <additional_field name="reject_file_on_error" type="string" scope="master">
						<xsl:value-of select="entityUtils:getCheckedValue($rejectfileonerror)"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="process_successful_tnx">
			     <additional_field name="process_successful_tnx" type="string" scope="master">
						<xsl:value-of select="process_successful_tnx"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="fileUploadSettings/draftFileOnError">
			     <additional_field name="bulk_draft_on_error" type="string" scope="master">
						<xsl:value-of select="entityUtils:getCheckedValue($draftfileonerror)"/>
				</additional_field>
			   </xsl:if>
			    <xsl:if test="bulk_tnx_sucess_error_separately">
			     <additional_field name="bulk_tnx_sucess_error_separately" type="string" scope="master">
						<xsl:value-of select="bulk_tnx_sucess_error_separately"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="fileUploadSettings/mergeDemergeAllowed">
			     <additional_field name="merge_demerge_allowed" type="string" scope="master">
						<xsl:value-of select="entityUtils:isValueEnable($mergeDemergeAllowed)"/>
				</additional_field>
			   </xsl:if>
	
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.entity.common.Entity>
			
			<xsl:for-each select="entityReferences">
			<xsl:variable name="bank_name" select="bankShortName"/>
				<xsl:for-each select="references">
				<com.misys.portal.product.util.EntityReference>
					<bank_id>
				    	<xsl:value-of select="entityUtils:getCompanyIdFromCompanyName($bank_name)"></xsl:value-of>
				    </bank_id>
				    <bank_abbv_name>
				    	<xsl:value-of select="$bank_name"></xsl:value-of>
				    </bank_abbv_name>
				    <customer_id>
				    	<xsl:value-of select="entityUtils:getCompanyIdFromCompanyName($company_name)"></xsl:value-of>
				    </customer_id>
				    <customer_abbv_name>
				    	<xsl:value-of select="$company_name"></xsl:value-of>
				    </customer_abbv_name>
				    <reference>
				       <xsl:value-of select="referenceKey"></xsl:value-of>
				    </reference>
				    <description>
				       <xsl:value-of select="referenceKey"></xsl:value-of>
				    </description>
			    </com.misys.portal.product.util.EntityReference>			
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="entityRoles/roles">
			     <com.misys.portal.product.util.EntityRole>
			     <xsl:variable name="roleName"><xsl:value-of select="roleId"/></xsl:variable>
			     <xsl:if test="roleId">
			     <role_id><xsl:value-of select="entityUtils:getRoleIdFromRoleName($roleName)"></xsl:value-of></role_id>
			      </xsl:if>
			      <additional_field name="role_name" type="string" scope="master">
						<xsl:value-of select="$roleName"/>
				</additional_field>
			     </com.misys.portal.product.util.EntityRole>
	  		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>