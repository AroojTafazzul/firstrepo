<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils">
	
<!--
##########################################################
Templates for

 Save Matrix

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      30/12/2010
author:    Saïd SAI
##########################################################
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="entity">
		<result>
			<com.misys.portal.entity.common.EntityTnx>
				<xsl:if test="entity_id">
			   		<entity_id>
			    	  <xsl:value-of select="entity_id"/>
			  	   </entity_id>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="company_abbv_name">
					<company_abbv_name>
						<xsl:value-of select="company_abbv_name"/>
					</company_abbv_name>
				</xsl:if>
				<xsl:if test="abbv_name">
					<abbv_name>
						<xsl:value-of select="abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="name">
					<name>
						<xsl:value-of select="name"/>
					</name>
				</xsl:if>
				<xsl:if test="address_line_1">
					<address_line_1>
						<xsl:value-of select="address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="address_line_2">
					<address_line_2>
						<xsl:value-of select="address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="address_line_3">
					<address_line_3>
						<xsl:value-of select="address_line_3"/>
					</address_line_3>
				</xsl:if>
				<xsl:if test="address_line_4">
					<address_line_4>
						<xsl:value-of select="address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="dom">
					<dom>
						<xsl:value-of select="dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="subscription_code">
					<package_id>
						<xsl:value-of select="subscription_code"/>
					</package_id>
				</xsl:if>
				<xsl:if test="customise_package">
					<customise_package>
						<xsl:value-of select="customise_package"/>
					</customise_package>
				</xsl:if>
				<xsl:if test="country">
					<country>
						<xsl:value-of select="country"/>
					</country>
				</xsl:if>
				<xsl:if test="bei">
					<bei>
						<xsl:value-of select="bei"/>
					</bei>
				</xsl:if>
				<xsl:if test="street_name">
					<street_name>
						<xsl:value-of select="street_name"/>
					</street_name>
				</xsl:if>
				<xsl:if test="post_code">
					<post_code>
						<xsl:value-of select="post_code"/>
					</post_code>
				</xsl:if>
				<xsl:if test="town_name">
					<town_name>
						<xsl:value-of select="town_name"/>
					</town_name>
				</xsl:if>
				<xsl:if test="country_sub_div">
					<country_sub_div>
						<xsl:value-of select="country_sub_div"/>
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
				<xsl:if test="contact_person">
					<contact_person>
						<xsl:value-of select="contact_person"/>
					</contact_person>
				</xsl:if>
				<xsl:if test="subscription_package">
				     <package_id>
				        <xsl:value-of select="subscription_package"/>
				     </package_id>
				</xsl:if>
				<xsl:if test="charging_account">
				<additional_field name="charging_account" type="string" scope="master">
						<xsl:value-of select="charging_account"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="return_comments">
					<return_comments>
						<xsl:value-of select="return_comments"/>
					</return_comments>
				</xsl:if>
				<xsl:if test="personal">
				<additional_field name="personal" type="string" scope="master">
						<xsl:value-of select="personal"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="legal_id_type">
				<additional_field name="legal_id_type" type="string" scope="master">
						<xsl:value-of select="legal_id_type"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="country_legalid">
				<additional_field name="country_legalid" type="string" scope="master">
						<xsl:value-of select="country_legalid"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="legal_id_no">
				<additional_field name="legal_id_no" type="string" scope="master">
						<xsl:value-of select="legal_id_no"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="legal_id">
				<additional_field name="legal_id" type="string" scope="master">
						<xsl:value-of select="legal_id"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="second_entity_name">
				<additional_field name="second_entity_name" type="string" scope="master">
						<xsl:value-of select="second_entity_name"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="authorize_own_transaction">
				<additional_field name="authorize_own_transaction" type="string" scope="master">
						<xsl:value-of select="authorize_own_transaction"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="auto_fwd_date">
				<additional_field name="auto_fwd_date" type="string" scope="master">
						<xsl:value-of select="auto_fwd_date"/>
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
				<xsl:if test="alternative_address_line_1">
				<additional_field name="alternative_address_line_1" type="string" scope="master">
						<xsl:value-of select="alternative_address_line_1"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="alternative_address_line_2">
				<additional_field name="alternative_address_line_2" type="string" scope="master">
						<xsl:value-of select="alternative_address_line_2"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="alternative_address_line_3">
				<additional_field name="alternative_address_line_3" type="string" scope="master">
						<xsl:value-of select="alternative_address_line_3"/>
				</additional_field>
				</xsl:if>
				<xsl:if test="alternative_address_line_4">
				<additional_field name="alternative_address_line_4" type="string" scope="master">
						<xsl:value-of select="alternative_address_line_4"/>
				</additional_field>
				</xsl:if>
                <xsl:if test="special_charge_cur_code">
                 <additional_field name="special_charge_cur_code" type="string" scope="master">
						<xsl:value-of select="special_charge_cur_code"/>
				</additional_field>
                </xsl:if>
                <xsl:if test="special_charge_amt">
                 <additional_field name="special_charge_amt" type="string" scope="master">
                        <xsl:value-of select="special_charge_amt"/>
				</additional_field>
                </xsl:if>
                <xsl:if test="stnd_charge_cur_code">
                 <additional_field name="stnd_charge_cur_code" type="string" scope="master">
						<xsl:value-of select="stnd_charge_cur_code"/>
				</additional_field>
                </xsl:if>
                 <xsl:if test="stnd_charge_amt">
                 <additional_field name="stnd_charge_amt" type="string" scope="master">
                        <xsl:value-of select="stnd_charge_amt"/>
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
                <xsl:if test="remark">
                 <additional_field name="remark" type="string" scope="master">
						<xsl:value-of select="remark"/>
				</additional_field>
			   </xsl:if>
			   <xsl:for-each select="//*[starts-with(name(), 'select_service_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">select_service_<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))]='Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		
			   		</xsl:if>
			 </xsl:for-each>
			  <xsl:for-each select="//*[starts-with(name(), 'sevice_name_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">sevice_name_<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			  <xsl:for-each select="//*[starts-with(name(), 'service_stnd_charge_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_stnd_charge_<xsl:value-of select="position()"/>_cur_code</xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			 <xsl:for-each select="//*[starts-with(name(), 'service_stnd_amt_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_stnd_amt_<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			 <xsl:for-each select="//*[starts-with(name(), 'service_special_chge_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_special_chge_<xsl:value-of select="position()"/>_cur_code</xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			  <xsl:for-each select="//*[starts-with(name(), 'service_special_amt_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_special_amt_<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			  <xsl:for-each select="//*[starts-with(name(), 'service_special_charge_expiry_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_special_charge_expiry_<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			  <xsl:for-each select="//*[starts-with(name(), 'service_subscription_waive_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_subscription_waive_<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			 <xsl:for-each select="//*[starts-with(name(), 'service_waive_expiry_date')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_waive_expiry_date<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			  <xsl:for-each select="//*[starts-with(name(), 'service_local_tax_')]">
			   		<xsl:variable name="prefix"><xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:variable name="fieldName">service_local_tax_<xsl:value-of select="position()"/></xsl:variable>
			   		<xsl:if test="//*[starts-with(name(), concat('select_service_', $prefix))] = 'Y'">
			   		<additional_field type="string" scope="master" >
			   				<xsl:attribute name="name"><xsl:value-of select="$fieldName"/></xsl:attribute>
			   				<xsl:value-of select="."/>
			   		</additional_field>
			   		</xsl:if>
			 </xsl:for-each>
			  <xsl:if test="bulk_authorize_limit">
			     <additional_field name="bulk_authorize_limit" type="string" scope="master">
						<xsl:value-of select="bulk_authorize_limit"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="check_file_hash_value">
			     <additional_field name="check_file_hash_value" type="string" scope="master">
						<xsl:value-of select="check_file_hash_value"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="check_duplicate_file">
			     <additional_field name="check_duplicate_file" type="string" scope="master">
						<xsl:value-of select="check_duplicate_file"/>
				</additional_field>
			   </xsl:if>
			    <xsl:if test="check_duplicate_cust_ref">
			     <additional_field name="check_duplicate_cust_ref" type="string" scope="master">
						<xsl:value-of select="check_duplicate_cust_ref"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="reject_file_on_error">
			     <additional_field name="reject_file_on_error" type="string" scope="master">
						<xsl:value-of select="reject_file_on_error"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="process_successful_tnx">
			     <additional_field name="process_successful_tnx" type="string" scope="master">
						<xsl:value-of select="process_successful_tnx"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="bulk_draft_on_error">
			     <additional_field name="bulk_draft_on_error" type="string" scope="master">
						<xsl:value-of select="bulk_draft_on_error"/>
				</additional_field>
			   </xsl:if>
			    <xsl:if test="bulk_tnx_sucess_error_separately">
			     <additional_field name="bulk_tnx_sucess_error_separately" type="string" scope="master">
						<xsl:value-of select="bulk_tnx_sucess_error_separately"/>
				</additional_field>
			   </xsl:if>
			   <xsl:if test="merge_demerge_allowed">
			     <additional_field name="merge_demerge_allowed" type="string" scope="master">
						<xsl:value-of select="merge_demerge_allowed"/>
				</additional_field>
			   </xsl:if>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.entity.common.EntityTnx>
			
			
			<xsl:for-each select="//*[starts-with(name(), 'references')]">
			<com.misys.portal.product.util.EntityReferenceTnx>
			    <bank_id>
			    	<xsl:value-of select="bankid"></xsl:value-of>
			    </bank_id>
			    <bank_abbv_name>
			    	<xsl:value-of select="bankabbvname"></xsl:value-of>
			    </bank_abbv_name>
			    <reference>
			       <xsl:value-of select="reference"></xsl:value-of>
			    </reference>
			    <description>
			       <xsl:value-of select="description"></xsl:value-of>
			    </description>
			</com.misys.portal.product.util.EntityReferenceTnx>    
			</xsl:for-each>
			
			
			<xsl:for-each select="//*[starts-with(name(), 'accounts')]">
			  <xsl:call-template name="account"></xsl:call-template>
			</xsl:for-each>
			<xsl:for-each select="//*[starts-with(name(), 'existing_roles')]">
			  <xsl:call-template name="entity-roles"></xsl:call-template>
			</xsl:for-each>
			 
			
		</result>
	</xsl:template>
	<xsl:template name="account">
		<xsl:for-each select="account">
		<com.misys.portal.cash.product.ab.common.AccountTnx>
		<xsl:variable name="curCode" ><xsl:value-of select="ccy"/></xsl:variable>
		<xsl:variable name="acctNo" ><xsl:value-of select="account_number"/></xsl:variable>
		<xsl:variable name="acctDescription" ><xsl:value-of select="description"/></xsl:variable>
		<xsl:variable name="accountName"><xsl:value-of select="concat($curCode,' ',$acctNo,' ',$acctDescription)"/></xsl:variable>
			    <cur_code>
			       <xsl:value-of select="ccy"></xsl:value-of>
			    </cur_code>
			    <account_no>
			    	<xsl:value-of select="account_number"></xsl:value-of>
			    </account_no>
			     <description>
			    	<xsl:value-of select="description"></xsl:value-of>
			    </description>
			    <bank_id>
			    	<xsl:value-of select="bank_id"></xsl:value-of>
			    </bank_id>
			     <branch_no>
			    	<xsl:value-of select="branch_code"></xsl:value-of>
			    </branch_no>
			    <acct_name>
			       <xsl:value-of select="$accountName"></xsl:value-of>
			    </acct_name>
			    <account_type>
			    	<xsl:value-of select="account_type"></xsl:value-of>
			    </account_type>
			    <additional_field name="nra" type="string" scope="master">
						<xsl:value-of select="NRA"/>
				</additional_field>
				<additional_field name="bank_account_type" type="string" scope="master">
					<xsl:value-of select="type"/>
				</additional_field>
				<additional_field name="customer_account_type" type="string" scope="master">
					<xsl:value-of select="cust_account_type"/>
				</additional_field>
				<additional_field name="bank_account_product_type" type="string" scope="master">
					<xsl:value-of select="account_product_type"/>
				</additional_field>
				<xsl:if test="settlement_means">
					<additional_field name="settlement_means" type="string" scope="master">
							<xsl:value-of select="settlement_means"/>
					</additional_field>
				</xsl:if>
		</com.misys.portal.cash.product.ab.common.AccountTnx>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="entity-roles">
	  <xsl:for-each select="roles_desc_record">
	     <com.misys.portal.product.util.EntityRoleTnx>
	     <xsl:if test="role">
	     <xsl:variable name="role_desc"><xsl:value-of select="role"></xsl:value-of></xsl:variable>
	      	<role_id><xsl:value-of select="utils:getRoleId($role_desc)"/></role_id>
	      </xsl:if>
	     </com.misys.portal.product.util.EntityRoleTnx>
	  </xsl:for-each>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
