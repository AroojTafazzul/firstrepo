<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 User Screen, System Form.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      29/04/08
author:    Laure Blin
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization securitycheck utils defaultresource">
	
	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="languages"/>
	<xsl:param name="nextscreen"/>
	<xsl:param name="option"/>
	<xsl:param name="action"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="operation">SAVE_FEATURES</xsl:param>
	<xsl:param name="isMakerCheckerMode"/>
	<xsl:param name="makerCheckerState"/>
	<xsl:param name="token"/>
	<xsl:param name="processdttm"/>
	<xsl:param name="canCheckerReturnComments"/>
	<xsl:param name="checkerReturnCommentsMode"/>
	<xsl:param name="allowReturnAction">false</xsl:param>
	<xsl:param name="company"/>
    <xsl:param name="modifyMode">N</xsl:param>
    <xsl:param name="isMultiBank">N</xsl:param>
    <xsl:param name="return_comments"/>
    <xsl:param name="beneficiaryNicknameEnabled"/>
    	
	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl" />
	<xsl:include href="../common/maker_checker_common.xsl" />
	<xsl:include href="../../../cash/xsl/common/remittance_common.xsl" />
	<xsl:include href="sy_jurisdiction.xsl" />
	<xsl:include href="sy_customer_beneficiary_common.xsl" />
	<xsl:include href="sy_reauthenticationdialog.xsl" />
	<xsl:include href="../common/e2ee_common.xsl" />

	<xsl:variable name="beneLevelInterBankDetailsFlag"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_LEVEL_ENABLE_INTERMEDIARY_BANK_DETAILS')"/></xsl:variable>

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="static_account"/>
	</xsl:template>
  
	<xsl:template match="static_account">
		<!-- Loading message  -->
		<xsl:call-template name="loading-message"/>
		<script>
		dojo.ready(function(){
		misys._config = misys._config || {};
		misys._config.callCountForTheProductType = 0;
		dojo.mixin(misys._config, {
		productCode: '<xsl:value-of select="$product-code"/>',
		<xsl:if test="$isMultiBank='Y'">
			entityBanksCollection : {
	   			<xsl:if test="count(/static_account/entities_bank_datas/avail_entity_banks/entity_banks/mb_entity) > 0" >
	        		<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/entity_banks/mb_entity" >
	        			<xsl:variable name="mb_entity" select="self::node()/text()" />
	  						'<xsl:value-of select="."/>': [
	   						<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/entity_banks[mb_entity=$mb_entity]/banks/linked_bank" >
	   							{ value:"<xsl:value-of select="."/>",
			         				name:"<xsl:value-of select="."/>"},
	   						</xsl:for-each>
	   						{value:"*",name:"*"}]<xsl:if test="not(position()=last())">,</xsl:if>
	         		</xsl:for-each>
	       		</xsl:if>
			},
			<!-- Banks for without entity customers. i.e, when entity defaults to '*'  -->
			wildcardLinkedBanksCollection : {
	   			<xsl:if test="count(/static_account/entities_bank_datas/avail_entity_banks/wildcard_banks/linked_bank) > 0" >
	  						"*": [
		        		<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/wildcard_banks/linked_bank" >
	   							{ value:"<xsl:value-of select="."/>",
			         				name:"<xsl:value-of select="."/>"},
		         		</xsl:for-each>
	   						{value:"*",name:"*"}]<xsl:if test="not(position()=last())">,</xsl:if>
	       		</xsl:if>
			},
			<!-- Product types for without entity customers. i.e, when entity defaults to '*'  -->
			wildcardForEntitiesAndBankProdTypesCollection : {
        		<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/wildcard_banks/linked_bank" >
        			<xsl:variable name="linkedBank" select="self::node()/text()" />
  						'*_<xsl:value-of select="."/>': [
   						<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/wildcard_banks/bank_prodtypes[wildcard_bank=concat('*_',$linkedBank)]/sub_products/sub_product" >
   							{ value:"<xsl:value-of select="value"/>",
		         				name:"<xsl:value-of select="name"/>"},
   						</xsl:for-each>
  							]<xsl:if test="not(position()=last())">,</xsl:if>
         		</xsl:for-each>
			},
			<!-- Below array object could be used for getting Product types below combination:
				1. For specific entity and any linked banks
				2. For any entity and any linked banks. i.e, any linked bank refers to '*'  -->
			entityAndWildcardForBanksProdTypesCollection : {
        		<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/entities_wildcard/entity_banks/mb_entity" >
        			<xsl:variable name="anEntity" select="self::node()/text()" />
  						'<xsl:value-of select="."/>_*': [
   						<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/entities_wildcard/entity_banks/entity_wildcard_prodtypes[wildcard_bank=concat($anEntity,'_*')]/sub_products/sub_product" >
   							{ value:"<xsl:value-of select="value"/>",
		         				name:"<xsl:value-of select="name"/>"},
   						</xsl:for-each>
  							]<xsl:if test="not(position()=last())">,</xsl:if>
         		</xsl:for-each>
			},
			<!-- Product types for possible combination of entity and the bank. -->
			entityBankProdTypesCollection : {
        		<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/entity_banks/entity_bank_prodtypes/entity_bank" >
        			<xsl:variable name="entityBank" select="self::node()/text()" />
  						'<xsl:value-of select="."/>': [
   						<xsl:for-each select="/static_account/entities_bank_datas/avail_entity_banks/entity_banks/entity_bank_prodtypes[entity_bank=$entityBank]/sub_products/sub_product" >
   							{ value:"<xsl:value-of select="value"/>",
		         				name:"<xsl:value-of select="name"/>"},
   						</xsl:for-each>
  							]<xsl:if test="not(position()=last())">,</xsl:if>
         		</xsl:for-each>
			},
		</xsl:if>
		ibanMandatory : new Array()
		 });
		 <xsl:for-each select="iban_codes/iban_set">
		 misys._config.ibanMandatory["<xsl:value-of select="code"/>"] = "<xsl:value-of select="mandatoryIndicator"/>";
		 </xsl:for-each>
		 });
		 </script>
		 <xsl:call-template name="clearing-code-loader" />
		<div>
    		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

			<!-- Reauthentication -->
			<xsl:call-template name="server-message">
				<xsl:with-param name="name">server_message</xsl:with-param>
				<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
				<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="reauthentication" />
					
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="hidden-fields"/>
					<xsl:call-template name="beneficiary-general-details"/>
					<div id="beneficiary-details-div">
						<xsl:call-template name="beneficiary-details"/>
						<xsl:if test="$beneLevelInterBankDetailsFlag = 'true' and ($displaymode='edit' or ($displaymode='view' and intermediary_bank_swift_bic_code[.!=''] and product_type and product_type[.!='MEPS'] and product_type and product_type[.!='RTGS'])) ">
							<div id="intermediary-bank-details-div">
								<xsl:call-template name="intermediary-bank-details"/>
							</div>
						</xsl:if>
						<xsl:if test="$beneLevelInterBankDetailsFlag = 'true' and ($displaymode='edit' or ($displaymode='view' and intermediary_bank_swift_bic_code[.!=''] and product_type and product_type[.='MEPS'])) ">
							<div id="intermediary-bank-details-meps-div">
								<xsl:call-template name="intermediary-bank-meps-details"/>
							</div>
						</xsl:if>
						<xsl:if test="$beneLevelInterBankDetailsFlag = 'true' and ($displaymode='edit' or ($displaymode='view' and intermediary_bank_swift_bic_code[.!=''] and product_type and product_type[.='RTGS'])) ">
							<div id="intermediary-bank-details-rtgs-div">
								<xsl:call-template name="intermediary-bank-rtgs-details"/>
							</div>
						</xsl:if>						
						<div id="delivery-mode-div">
						<xsl:call-template name="delivery-mode-details"/> 
						</div>
					</div>
						<xsl:call-template name="additional-instructions"/>
						<xsl:call-template name="payment-details"/>
					<xsl:if test="$canCheckerReturnComments = 'true'">
						<xsl:call-template name="comments-for-return-mc">
							<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
						<!--  Display common menu. -->
					<xsl:call-template name="maker-checker-menu"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="realform"/>
		</div>

		<!-- Javascript imports  -->
		<xsl:call-template name="js-imports"/>
		
	</xsl:template>
  
	<!--                                     -->  
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->
 
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
	<xsl:variable name="help_access_key">
  <xsl:choose>
 		<xsl:when test="security:isBank($rundata)"><xsl:value-of select="'BMF_01'"></xsl:value-of></xsl:when>
 		<xsl:otherwise><xsl:value-of select="'DATAM_BENM'"></xsl:value-of></xsl:otherwise>
 	</xsl:choose>
 	</xsl:variable>
		<xsl:call-template name="system-common-js-imports">
			<xsl:with-param name="xml-tag-name">static_account</xsl:with-param>
			<xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/><xsl:if test="$company!=''">&amp;company=<xsl:value-of select="$company"/></xsl:if>'</xsl:with-param>
			<xsl:with-param name="override-help-access-key">BMF_01</xsl:with-param>
			<xsl:with-param name="binding">misys.binding.system.beneficiary_master_mc</xsl:with-param>
			<xsl:with-param name="override-help-access-key"><xsl:value-of select="$help_access_key"/></xsl:with-param>
		</xsl:call-template>
		<script>
			dojo.ready(function(){
				misys._config = (misys._config) || {};
				misys._config.postal_codes = misys._config.postal_codes || 
				{
		 			<xsl:for-each select="postal_codes/postal_code">
						<xsl:value-of select="code"/>:'<xsl:value-of select="length" />'
						<xsl:if test="position()!=last()">,</xsl:if>
		  			</xsl:for-each>
		 		}
		 		<xsl:variable name="nonPabAllowed"><xsl:value-of select="defaultresource:getResource('NON_PAB_ALLOWED')"/></xsl:variable>
		 		misys._config.non_pab_allowed = misys._config.non_pab_allowed || <xsl:value-of select="$nonPabAllowed"/>;
		 		misys._config.isMultiBank =<xsl:choose>
									 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 			<xsl:otherwise>false</xsl:otherwise>
									 		</xsl:choose>;
			});
		</script>
	</xsl:template>
 
	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<div class="widgetContainer">
			<xsl:call-template name="localization-dialog"/>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">user_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">company_abbv_name</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_name_label</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_NAME_WITH_ADDRESS')"/></xsl:with-param>
			</xsl:call-template>
			 <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_name_label_with_out_address</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_NAME')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_instituion_label</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_NAME_WITH_ADDRESS')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bank_name_label_with_out_address</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_BANK_NAME')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bank_name_label</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bank_instituion_label</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_BANK_ADDRESS_NAME')"/></xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">includedIBANProducts</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_IBAN_VALIDATION_INCLUDED_PRODUCTS')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">regexValue</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param>
			</xsl:call-template>	
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">reauth_popup_non_pab_flag</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('REAUTH_POPUP_NONPAB_FLAG')"/></xsl:with-param>
			</xsl:call-template>	
			<xsl:call-template name="hidden-field">
				 <xsl:with-param name="name">regexAddressValue</xsl:with-param>
				 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">allowedProducts</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_EXCLUDED_PRODUCTS')"/></xsl:with-param>
			</xsl:call-template>		
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_account_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_account_type</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_account_currency</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_branch_code</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_product_type</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">entity_size</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">swiftregexValue</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
				
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">account_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">DUPLICATE_BENEFICIARY_NAME_VALIDATION_FLAG</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('DUPLICATE_BENEFICIARY_NAME_VALIDATION_FLAG')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">DUPLICATE_BENEFICIARY_ACCOUNT_VALIDATION_FLAG</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('DUPLICATE_BENEFICIARY_ACCOUNT_VALIDATION_FLAG')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">return_comment_hidden</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$return_comments"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">intermediary_flag</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="intermediary_flag"/></xsl:with-param>
			</xsl:call-template>			
			<xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">swiftBicCodeRegexValue</xsl:with-param>
			 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BIC_CHARSET')"/></xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>     
      
	<!--
	Main Details of the Company 
	-->
	<xsl:template name="beneficiary-general-details">
		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   			<xsl:with-param name="button-type">
   				<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   			</xsl:with-param>
   			<xsl:with-param name="override-displaymode">edit</xsl:with-param>
   			<xsl:with-param name="content">
			   	<!-- Company -->
			    <xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
				    <xsl:with-param name="name">company_abbv_name</xsl:with-param>
				    <xsl:with-param name="readonly">Y</xsl:with-param>
				    <!-- To modify the mode from "Edit" to "View" -->
				    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    <!-- Entity -->
			    <xsl:choose>
			    	<xsl:when test="entity_size[number(.) &lt;= 0]">
			    		<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">entity</xsl:with-param>
							<xsl:with-param name="value">*</xsl:with-param>
				   		</xsl:call-template>
			    	</xsl:when>
			    	<xsl:when test="entity_size[number(.) = 1]">
			    		<xsl:call-template name="hidden-field">
					    	<xsl:with-param name="name">entity</xsl:with-param>
				   		</xsl:call-template>
				   		<xsl:call-template name="input-field">
					   		<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
				   			<xsl:with-param name="id">beneficiary_entity_view</xsl:with-param>
				   			<xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
				   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				   		</xsl:call-template>
			    	</xsl:when>
			    	<xsl:otherwise>
			    		<xsl:choose>
		    				<xsl:when test="$modifyMode = 'Y'">
		    					<xsl:call-template name="hidden-field">
			    				<xsl:with-param name="name">entity</xsl:with-param>
		   					</xsl:call-template>
			    				<xsl:if test="entity_size[number(.) &gt; 0]">
				    				<xsl:call-template name="input-field">
							   			<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
							   			<xsl:with-param name="id">beneficiary_entity_view</xsl:with-param>
							   			<xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
							   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				   					</xsl:call-template>
			   					</xsl:if>
		    				</xsl:when>
		    				<xsl:otherwise>
			    				<xsl:call-template name="entity-field">
					  			<xsl:with-param name="button-type">
							      	<xsl:choose>
							    		 <xsl:when test="security:isBank($rundata)">system-entity</xsl:when>
							    		 <xsl:otherwise>entity-basic-company</xsl:otherwise>
							    	</xsl:choose>
						 	   </xsl:with-param>
					  			<xsl:with-param name="entity-label">XSL_JURISDICTION_ENTITY</xsl:with-param>
					  			<xsl:with-param name="override_company_abbv_name" select="$company"/>
					     		<xsl:with-param name="required">Y</xsl:with-param>
					     		<xsl:with-param name="keep-entity-product-button">*</xsl:with-param>
					     		</xsl:call-template>
					    	 </xsl:otherwise>
					    </xsl:choose>
			    	</xsl:otherwise>
			    </xsl:choose>
				<!-- Bank to which beneficiary needs to be linked to. -->
				<xsl:if test="$isMultiBank='Y'">
					<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
								<xsl:with-param name="name">customer_bank</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							 <xsl:call-template name="input-field">
								<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
								<xsl:with-param name="name">customer_bank</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="disabled">Y</xsl:with-param>
				   			</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- Product Type /  Beneficiary Category -->
				<xsl:choose>
					<xsl:when test="$isMultiBank='Y'">
						<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
							<xsl:call-template name="select-field">
						     	<xsl:with-param name="label">PRODUCT_TYPE_OR_BENEFICIARY_CATEGORY_LABEL</xsl:with-param>
						     	<xsl:with-param name="name">product_type</xsl:with-param>
						     	<xsl:with-param name="required">Y</xsl:with-param>
						     	<xsl:with-param name="value"><xsl:value-of select="product_type"/></xsl:with-param>
							</xsl:call-template>
							<!-- Message Div: No Customer Bank available. Try with different Entity or Bank! whichever applicable. -->
					 		<div id="no-customer-bank-message-div">
								<xsl:call-template name="server-message">
									<xsl:with-param name="name">no_customer_bank_message</xsl:with-param>
									<xsl:with-param name="show-close">N</xsl:with-param>
									<xsl:with-param name="content">
										<xsl:value-of select="localization:getGTPString($language, 'MSG_NO_CUSTOMER_BANK_AVAILABLE')"/>
									</xsl:with-param>
									<!-- This is not a server message we are just using the serverMessage CSS style. -->
									<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
								</xsl:call-template>
					    	</div>	
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">PRODUCT_TYPE_OR_BENEFICIARY_CATEGORY_LABEL</xsl:with-param>
								<xsl:with-param name="name">product_type</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N117', product_type)"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">product_type</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="product_type"/></xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">product_type_hidden</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="product_type"/></xsl:with-param>
						</xsl:call-template>
				    </xsl:when>
					<xsl:when test= "$isMultiBank='N' and $displaymode = 'edit'">
						<xsl:call-template name="select-field">
					     	<xsl:with-param name="label">PRODUCT_TYPE_OR_BENEFICIARY_CATEGORY_LABEL</xsl:with-param>
					     	<xsl:with-param name="name">product_type</xsl:with-param>
					     	<xsl:with-param name="required">Y</xsl:with-param>
					     	<xsl:with-param name="value"><xsl:value-of select="product_type"/></xsl:with-param>
					     	<xsl:with-param name="options">
					     		<xsl:call-template name="avail_sub_products"/>
					    	</xsl:with-param>
						</xsl:call-template>
				    </xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">PRODUCT_TYPE_OR_BENEFICIARY_CATEGORY_LABEL</xsl:with-param>
							<xsl:with-param name="name">product_type</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N117', product_type)"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">product_type</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="product_type"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>		
		 		</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="intermediary-bank-details">
	   		<xsl:call-template name="fieldset-wrapper">
		     	<xsl:with-param name="legend">XSL_HEADER_INTERMEDIARY_BANK_DETAILS</xsl:with-param>
		     	<xsl:with-param name="button-type"></xsl:with-param>
		     	<xsl:with-param name="content">
		     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">intermediary_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	                  <xsl:with-param name="content-after">
		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['intermediary_bank_name', 'intermediary_bank_address_line_1', 'intermediary_bank_address_line_2', 'intermediary_bank_dom', 'intermediary_bank_swift_bic_code', 'intermediary_bank_contact_name', 'intermediary_bank_phone','intermediary_bank_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_SWIFT_BANKS')"/>');return false;</xsl:with-param>
		                      <xsl:with-param name="id">intermediary_bank_iso_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
                    	</xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
			   		
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">intermediary_bank</xsl:with-param>	
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label">XSL_PARTIESDETAILS_BANK_NAME_AND</xsl:with-param> 
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	       		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>			       		
			       		<xsl:with-param name="required">N</xsl:with-param>
			      	</xsl:call-template>
			      	</xsl:with-param>
			      	</xsl:call-template>
			      	
			       <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
			      	<xsl:call-template name="clearing-code-desc-field">
			   			<xsl:with-param name="prefix">intermediary_bank</xsl:with-param>	
			   		</xsl:call-template>
   				</xsl:with-param>
				</xsl:call-template>
			  </xsl:with-param>
			  </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
   	</xsl:template>
 
  	<xsl:template name="intermediary-bank-meps-details">
	   		<xsl:call-template name="fieldset-wrapper">
		     	<xsl:with-param name="legend">XSL_HEADER_INTERMEDIARY_BANK_DETAILS</xsl:with-param>
		     	<xsl:with-param name="button-type"></xsl:with-param>
		     	<xsl:with-param name="content">
		     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">intermediary_bank_meps_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="value">
	                  	<xsl:if test="product_type and product_type[.='MEPS']">
	                  		<xsl:value-of select="./intermediary_bank_swift_bic_code"/>
	                  	</xsl:if>
	                  </xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	                  <xsl:with-param name="content-after">
		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showIntermediaryBicCodesforMeps();return false;</xsl:with-param>
		                      <xsl:with-param name="id">intermediary_bank_meps_iso_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
                    	</xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
			   		
			    	   <xsl:call-template name="input-field">
			      			<xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS</xsl:with-param>
			      			<xsl:with-param name="name">intermediary_bank_meps_name</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='MEPS']">
			      					<xsl:value-of select="./intermediary_bank_name"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="input-field">
			    			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
			      			<xsl:with-param name="name">intermediary_bank_meps_address_line_1</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='MEPS']">
			      					<xsl:value-of select="./intermediary_bank_address_line_1"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="input-field">
			      			<xsl:with-param name="name">intermediary_bank_meps_address_line_2</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='MEPS']">
			      					<xsl:value-of select="./intermediary_bank_address_line_2"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="input-field">
			      			<xsl:with-param name="name">intermediary_bank_meps_dom</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='MEPS']">
			      					<xsl:value-of select="./intermediary_bank_dom"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="country-field">
			    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
			      			<xsl:with-param name="name">intermediary_bank_meps_country</xsl:with-param>
			      			<xsl:with-param name="prefix">intermediary_bank_meps</xsl:with-param>
			      			<xsl:with-param name="disabled">Y</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='MEPS']">
			      					<xsl:value-of select="./intermediary_bank_country"/>
			      				</xsl:if>
			      			</xsl:with-param>
			    		</xsl:call-template>
			      	</xsl:with-param>
			      	</xsl:call-template>
			  </xsl:with-param>
			  </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
   	</xsl:template>
   	
  	<xsl:template name="intermediary-bank-rtgs-details">
	   		<xsl:call-template name="fieldset-wrapper">
		     	<xsl:with-param name="legend">XSL_HEADER_INTERMEDIARY_BANK_DETAILS</xsl:with-param>
		     	<xsl:with-param name="button-type"></xsl:with-param>
		     	<xsl:with-param name="content">
		     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">intermediary_bank_rtgs_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="value">
	                  	<xsl:if test="product_type and product_type[.='RTGS']">
	                  		<xsl:value-of select="./intermediary_bank_swift_bic_code"/>
	                  	</xsl:if>
	                  </xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	                  <xsl:with-param name="content-after">
		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showIntermediaryBicCodesforRTGS();return false;</xsl:with-param>
		                      <xsl:with-param name="id">intermediary_bank_rtgs_bic_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
                    	</xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
			   		
			      	    <xsl:call-template name="input-field">
			      			<xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS</xsl:with-param>
			      			<xsl:with-param name="name">intermediary_bank_rtgs_name</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='RTGS']">
			      					<xsl:value-of select="./intermediary_bank_name"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="input-field">
			    			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
			      			<xsl:with-param name="name">intermediary_bank_rtgs_address_line_1</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='RTGS']">
			      					<xsl:value-of select="./intermediary_bank_address_line_1"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="input-field">
			      			<xsl:with-param name="name">intermediary_bank_rtgs_address_line_2</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='RTGS']">
			      					<xsl:value-of select="./intermediary_bank_address_line_2"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="input-field">
			      			<xsl:with-param name="name">intermediary_bank_rtgs_dom</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='RTGS']">
			      					<xsl:value-of select="./intermediary_bank_dom"/>
			      				</xsl:if>
			      			</xsl:with-param>
			      			<xsl:with-param name="size">35</xsl:with-param>
			       			<xsl:with-param name="maxsize">35</xsl:with-param>
			       			<xsl:with-param name="swift-validate">N</xsl:with-param>
			       			<xsl:with-param name="disabled">Y</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="country-field">
			    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
			      			<xsl:with-param name="name">intermediary_bank_rtgs_country</xsl:with-param>
			      			<xsl:with-param name="prefix">intermediary_bank_rtgs</xsl:with-param>
			      			<xsl:with-param name="disabled">Y</xsl:with-param>
			      			<xsl:with-param name="value">
			      				<xsl:if test="product_type and product_type[.='RTGS']">
			      					<xsl:value-of select="./intermediary_bank_country"/>
			      				</xsl:if>
			      			</xsl:with-param>
			    		</xsl:call-template> 
			      	</xsl:with-param>
			      	</xsl:call-template>
			  </xsl:with-param>
			  </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
   	</xsl:template>
   	   	
	<xsl:template name="delivery-mode-details">
	  	<xsl:call-template name="fieldset-wrapper">    
	   		<xsl:with-param name="legend">XSL_HEADER_DELIVERY_MODE</xsl:with-param>
	   		<xsl:with-param name="content">
	    		<!-- Two Column -->
	    		<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">beneficiary-details-column-wrapper</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Left Secion -->
								<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.!='']))">
								<div id="additional-advice-div">
									<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENEFICIARY_ID</xsl:with-param>
						      			<xsl:with-param name="name">beneficiary_id</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./beneficiary_id"/></xsl:with-param>
						      			<xsl:with-param name="size">20</xsl:with-param>
						       			<xsl:with-param name="maxsize">20</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENEFICIARY_PAYEE_REFERENCE</xsl:with-param>
						      			<xsl:with-param name="name">payee_ref</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./payee_ref"/></xsl:with-param>
						      			<xsl:with-param name="size">20</xsl:with-param>
						       			<xsl:with-param name="maxsize">20</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENEFICIARY_CUSTOMER_REFERENCE</xsl:with-param>
						      			<xsl:with-param name="name">cust_ref</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./cust_ref"/></xsl:with-param>
						      			<xsl:with-param name="size">20</xsl:with-param>
						       			<xsl:with-param name="maxsize">20</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		</div>
						   			<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_JURISDICTION_EMAIL_1</xsl:with-param>
						      			<xsl:with-param name="name">email_1</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./email_1"/></xsl:with-param>
						      			<xsl:with-param name="size">500</xsl:with-param>
						       			<xsl:with-param name="maxsize">500</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		<div id="email2_div">
						    		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_JURISDICTION_EMAIL_2</xsl:with-param>
						      			<xsl:with-param name="name">email_2</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./email_2"/></xsl:with-param>
						      			<xsl:with-param name="size">255</xsl:with-param>
						       			<xsl:with-param name="maxsize">255</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENE_ADVICE_FAX</xsl:with-param>
						      			<xsl:with-param name="name">fax</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./fax"/></xsl:with-param>
						      			<xsl:with-param name="size">30</xsl:with-param>
						       			<xsl:with-param name="maxsize">30</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		</div>
						    		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENE_ADVICE_PHONE</xsl:with-param>
						      			<xsl:with-param name="name">phone</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./phone"/></xsl:with-param>
						      			<xsl:with-param name="size">30</xsl:with-param>
						       			<xsl:with-param name="maxsize">30</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
					    		</xsl:if>
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.='DOM' or .='TPT' or .='MUPS' or .='RTGS' or .='MEPS' or .='DD'or .='HVPS' or .='HVXB']))">

						    		<div id="mailing_name_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_MAILING_NAME</xsl:with-param>
							      			<xsl:with-param name="name">mailing_name</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./mailing_name"/></xsl:with-param>
							      			<xsl:with-param name="size">20</xsl:with-param>
							       			<xsl:with-param name="maxsize">40</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		</xsl:if>
						    		<div id="description_div">
						    		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENEFICIARY_DESCRIPTION</xsl:with-param>
						      			<xsl:with-param name="name">description</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./description"/></xsl:with-param>
						      			<xsl:with-param name="size">30</xsl:with-param>
						       			<xsl:with-param name="maxsize">30</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		</div>
						    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.!='']))">
						    		
						    		<div id="mailing_address_div" class="field">
					    			<xsl:if test="$displaymode = 'edit'">									    		
								    		<xsl:call-template name="textarea-field">
								      			<xsl:with-param name="label">XSL_BENEFICIARY_ADDRESS</xsl:with-param>
								      			<xsl:with-param name="name">mailing_address</xsl:with-param>
								      			<xsl:with-param name="messageValue"><xsl:value-of select="./mailing_address"/></xsl:with-param>
												<xsl:with-param name="rows">2</xsl:with-param>
												<xsl:with-param name="cols">35</xsl:with-param>
												<xsl:with-param name="maxlines">2</xsl:with-param>
												<xsl:with-param name="maxlength">70</xsl:with-param>
												<xsl:with-param name="swift-validate">N</xsl:with-param>
												<xsl:with-param name="button-type"></xsl:with-param>
								    		</xsl:call-template>
							    		
							    	</xsl:if>
							     <xsl:if test="$displaymode = 'view' and mailing_address[.!=''] and product_type[.='HVPS' or .='HVXB' or .='MUPS']">
									<table cellspacing="0" cellpadding="0" border="0">
										<tr>
											<td class="label" style="text-align:right;"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ADDRESS')"/></td>
											<td class="content" style="float:right;clear:right;min-width:100px;max-width:500px;word-wrap: break-word"><xsl:value-of select="./mailing_address"/></td>
										</tr>
									</table>
				  					 </xsl:if>
								   </div>
								   
							    	
					    			<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='DOM' or .='TPT' or .='DD'])">						    	
						    		<div id="mailing_address_line_1_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_MAILING_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="name">mailing_address_line_1</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./mailing_address_line_1"/></xsl:with-param>
							      			<xsl:with-param name="size">40</xsl:with-param>
							       			<xsl:with-param name="maxsize">40</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="mailing_address_line_2_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">mailing_address_line_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./mailing_address_line_2"/></xsl:with-param>
							      			<xsl:with-param name="size">40</xsl:with-param>
							       			<xsl:with-param name="maxsize">40</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="mailing_address_line_3_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">mailing_address_line_3</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./mailing_address_line_3"/></xsl:with-param>
							      			<xsl:with-param name="size">40</xsl:with-param>
							       			<xsl:with-param name="maxsize">40</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="mailing_address_line_4_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">mailing_address_line_4</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./mailing_address_line_4"/></xsl:with-param>
							      			<xsl:with-param name="size">40</xsl:with-param>
							       			<xsl:with-param name="maxsize">40</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="mailing_address_line_5_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">mailing_address_line_5</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./mailing_address_line_5"/></xsl:with-param>
							      			<xsl:with-param name="size">40</xsl:with-param>
							       			<xsl:with-param name="maxsize">40</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		</xsl:if>
						    		<div id="beneficiary_country_div">
						    			<xsl:call-template name="country-field">
							    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
							      			<xsl:with-param name="name">beneficiary_country</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./beneficiary_country"/></xsl:with-param>
							      			<xsl:with-param name="prefix">beneficiary</xsl:with-param>
							      			<xsl:with-param name="appendClass">inlineBlock beneAdvCountry</xsl:with-param>
							    		</xsl:call-template>
							    	</div>
							    	<div id="postal_code_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_POSTAL_CODE</xsl:with-param>
							      			<xsl:with-param name="name">postal_code</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./postal_code"/></xsl:with-param>
							      			<xsl:with-param name="size">15</xsl:with-param>
							       			<xsl:with-param name="maxsize">15</xsl:with-param>
							       			<xsl:with-param name="fieldsize">small</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
						    			</xsl:call-template>
						    		</div>
					    		</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<!-- 
	Realform
	-->
	<xsl:template name="realform">
		<!-- Do not display this section when the counterparty mode is 'counterparty' -->
		<xsl:if test="$collaborationmode != 'counterparty'">
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">realform</xsl:with-param>
				<xsl:with-param name="method">POST</xsl:with-param>
				<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
				<xsl:with-param name="content">
					<div class="widgetContainer">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">operation</xsl:with-param>
							<xsl:with-param name="id">realform_operation</xsl:with-param>
							<xsl:with-param name="value" select="$operation"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$option != ''"><xsl:value-of select="$option"/></xsl:when>
									<xsl:otherwise>CUSTOMER_BENEFICIARY_MASTER_MAINTENANCE_MC</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="./account_id[.!='']">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">featureid</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="./account_id"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="./tnx_id[.!='']">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">tnxid</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="./tnx_id"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Company is only passed for customer user maintenance on bank side -->
						<xsl:if test="$option='CUSTOMER_BENEFICIARY_MASTER_MAINTENANCE_MC'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">company</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="./company_id"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">token</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">processdttm</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">mode</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="reauth_params"/>
						<xsl:call-template name="e2ee_transaction"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--
	Status type options.
	-->
	<xsl:template name="actv_flag-options">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<option value="A"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_YES')"/></option>
				<option value="I"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_NO')"/></option>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="actv_flag[. = 'A']"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_YES')"/></xsl:if>
				<xsl:if test="actv_flag[. = 'I']"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_NO')"/></xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	
	<xsl:template match="data_1">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
			<xsl:value-of select="localization:getDecode($language, 'N090', .)"/>
		</option>
	</xsl:template>
 
	<!--  Business Area options -->
	<xsl:template name="avail_sub_products">
	<xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>
		<!-- NEW PORTAL V5 TYPES -->
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_tpt_access')">
				<option value="TPT"><xsl:value-of select="localization:getDecode($language, 'N117', 'TPT')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_mups_access')">
				<option value="MUPS"><xsl:value-of select="localization:getDecode($language, 'N117', 'MUPS')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_dom_access')">
				<option value="DOM"><xsl:value-of select="localization:getDecode($language, 'N117', 'DOM')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_mt101_access')">
				<option value="MT101"><xsl:value-of select="localization:getDecode($language, 'N117', 'MT101')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_mt103_access')">
				<option value="MT103"><xsl:value-of select="localization:getDecode($language, 'N117', 'MT103')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_fi103_access')">
				<option value="FI103"><xsl:value-of select="localization:getDecode($language, 'N117', 'FI103')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_fi202_access')">
				<option value="FI202"><xsl:value-of select="localization:getDecode($language, 'N117', 'FI202')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_pico_access') or securitycheck:hasCompanyPermission($rundata,'ft_pidd_access')">
				<option value="DD"><xsl:value-of select="localization:getDecode($language, 'N117', 'DD')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_ttpt_access')">
				<option value="TTPT"><xsl:value-of select="localization:getDecode($language, 'N117', 'TTPT')"/></option>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="$swift_flag='true'">
					<xsl:if test="securitycheck:hasCompanyPermission($rundata,'treasury_td_access')">
						<option value="TRSRY"><xsl:value-of select="localization:getDecode($language, 'N117', 'TRSRY')"/></option>
					</xsl:if>
					<xsl:if test="(securitycheck:hasCompanyPermission($rundata,'fx_access') or securitycheck:hasCompanyPermission($rundata,'treasury_ft_access'))">
						<option value="TRSRYFXFT"><xsl:value-of select="localization:getDecode($language, 'N117', 'TRSRYFXFT')"/></option>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="securitycheck:hasCompanyPermission($rundata,'fx_access')">
						<option value="TRSRY"><xsl:value-of select="localization:getDecode($language, 'N117', 'TRSRY')"/></option>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_hvps_access')">
				<option value="HVPS"><xsl:value-of select="localization:getDecode($language, 'N117', 'HVPS')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_hvxb_access')">
				<option value="HVXB"><xsl:value-of select="localization:getDecode($language, 'N117', 'HVXB')"/></option>
			</xsl:if>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_meps_access')">
				<option value="MEPS"><xsl:value-of select="localization:getDecode($language, 'N117', 'MEPS')"/></option>
			</xsl:if>			
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'ft_rtgs_access')">
				<option value="RTGS"><xsl:value-of select="localization:getDecode($language, 'N117', 'RTGS')"/></option>
			</xsl:if>
	</xsl:template>
	  
</xsl:stylesheet>