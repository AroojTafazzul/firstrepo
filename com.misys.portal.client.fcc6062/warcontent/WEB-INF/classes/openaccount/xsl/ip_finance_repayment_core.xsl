<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!--
##########################################################
Templates for

Open Account - Finance Invoice Payable Repayment (IP) Form, Customer Side.
 
Copyright (c) 2000-2017 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      25/01/17
author:    Jayron Lester Sanchez
email:     JayronLester.Sanchez@misys.com
##########################################################
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:fscmUtils="xalan://com.misys.portal.openaccount.util.FSCMUtils"
	exclude-result-prefixes="localization securityCheck security defaultresource fscmUtils">
		
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">IP</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="nextscreen" />
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/InvoicePayableScreen</xsl:param>
	<xsl:param name="hasEntity">N</xsl:param>

	
	<!-- All marks used to shown/hidden form's sections-->
	
	<xsl:param name="show-template">N</xsl:param>
	<xsl:param name="product-currency-label">XSL_INVOICE_PAYABLE_CURRENCY_CODE</xsl:param>
	<xsl:param name="show_buyer_button">Y</xsl:param>
	
	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../core/xsl/common/fx_common.xsl"/>
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 
	<xsl:template match="/">
		<xsl:apply-templates select="ip_tnx_record"/>
	</xsl:template>

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_ip_repayment</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="override-lowercase-product-code">ip</xsl:with-param>
			<xsl:with-param name="override-help-access-key">IN_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="ip_tnx_record">
	<!-- Preloader  -->
	<xsl:call-template name="loading-message" />

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

	<!-- Form #0 : Main Form -->
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name" select="$main-form-name" />
		<xsl:with-param name="validating">Y</xsl:with-param>
		<xsl:with-param name="content">
			<!--  Display common menu.  -->
			<xsl:call-template name="menu">
				<xsl:with-param name="show-template" select="$show-template"/>	
				<xsl:with-param name="show-return">Y</xsl:with-param>
			</xsl:call-template>

			<!-- Disclaimer Notice -->
			<xsl:call-template name="disclaimer" />
			
			<!-- Reauthentication -->	
		 	<xsl:call-template name="server-message">
		 		<xsl:with-param name="name">server_message</xsl:with-param>
		 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
		 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="reauthentication" />

			<xsl:apply-templates select="cross_references" mode="hidden_form" />
			<xsl:call-template name="hidden-fields" />
			<!-- FSCM General Details -->
			<xsl:call-template name="fscm-general-detailsB" />
			<!-- Goods details -->
			<xsl:call-template name="finance-repayment-details" />			
			<xsl:call-template name="exchange-rate-details" />		
			
			<xsl:call-template name="instructions-for-bank" />
			<xsl:call-template name="instructions-from-bank" />
			
		
			<!-- Form #1 : Attach Files -->
			<xsl:choose>
				<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
					<xsl:call-template name="attachments-file-dojo">
						<xsl:with-param name="attachment-group">invoice</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="$option ='DETAILS'">
					<xsl:call-template name="attachments-file-dojo">
			          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
			          	<xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
			          	<xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
		          	</xsl:call-template>
		          	<xsl:call-template name="attachments-file-dojo">
			          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
			          	<xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
			          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
		          	</xsl:call-template>
		          	</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- comments for return -->
			<xsl:call-template name="comments-for-return">
				<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
				<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</div>

	<!-- Table of Contents -->
	<xsl:call-template name="toc" />

	<!--  Collaboration Window  -->
	<xsl:call-template name="collaboration">
		<xsl:with-param name="editable">true</xsl:with-param>
		<xsl:with-param name="productCode">
			<xsl:value-of select="$product-code" />
		</xsl:with-param>
		<xsl:with-param name="contextPath">
			<xsl:value-of select="$contextPath" />
		</xsl:with-param>
		<xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
		<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
	</xsl:call-template>

	<!-- Display common menu, this time outside the form -->
	<xsl:call-template name="menu">
		<xsl:with-param name="second-menu">Y</xsl:with-param>
		<xsl:with-param name="show-template" select="$show-template"/>
		<xsl:with-param name="show-return">Y</xsl:with-param>					
	</xsl:call-template>
	
	<!-- The form that's submitted -->
	<xsl:call-template name="realform" />
	
	<!-- Javascript and Dojo imports  -->
	<xsl:call-template name="js-imports" />
</xsl:template>

	<!--                                     -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="issuing_bank/abbv_name" />
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="issuing_bank/name" />
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">product_code</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">sub_product_code</xsl:with-param>	
					<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>			
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:with-param>			
			</xsl:call-template>			
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">program_id</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="security:isCounterparty($rundata)">
		 	  	<xsl:call-template name="hidden-field">
		     		<xsl:with-param name="name">company_type</xsl:with-param>
		     	 	<xsl:with-param name="value"><xsl:value-of select="company_type"/></xsl:with-param>
		   		</xsl:call-template>
		   	</xsl:if>
		   	<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			   	<xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fx_master_currency</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="counterparty_abbv_name"><xsl:value-of select="seller_abbv_name" /></xsl:variable>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bene_access_opened</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fscmUtils:getBeneficiaryCollaborationDetails($rundata,$counterparty_abbv_name,'IN','access')"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bene_email</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fscmUtils:getBeneficiaryCollaborationDetails($rundata,$counterparty_abbv_name,'IN','email')"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">abbvName</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fscmUtils:getBeneficiaryCollaborationDetails($rundata,$counterparty_abbv_name,'IN','beneCompAbbvName')"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>

	<!-- General Details fields, common to FSCM forms on the customer side.System ID, Customer Reference, Invoice Reference, Application Date, Invoice Date and Due Date -->
	<xsl:template name="fscm-general-detailsB">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:variable name="show-cust-ref-id">Y</xsl:variable>
			 	<xsl:variable name="show-bo-ref-id">Y</xsl:variable>
			 	<xsl:variable name="show-fin-bo-ref-id">Y</xsl:variable>
			   	<!-- Hidden fields. -->
			 	<xsl:variable name="override-cust-ref-id-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:variable>
			    <xsl:call-template name="hidden-field">
			   		 <xsl:with-param name="name">ref_id</xsl:with-param>
			   		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
				<!-- Don't display this in unsigned mode. -->
				<xsl:if test="$displaymode='edit'">
				   <xsl:call-template name="hidden-field">
					    <xsl:with-param name="name">appl_date</xsl:with-param>
					    <xsl:with-param name="override-displaymode">view</xsl:with-param>
				   </xsl:call-template>
				</xsl:if>
				<!--  System ID. -->
			   	<xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
				    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
				    <xsl:with-param name="value" select="ref_id" />
				    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    <!-- Customer reference -->
			    <xsl:if test="$show-cust-ref-id='Y'">
				    <xsl:call-template name="input-field">
					     <xsl:with-param name="label"><xsl:value-of select="$override-cust-ref-id-label"/></xsl:with-param>
					     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
					     <xsl:with-param name="size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_LENGTH')"/></xsl:with-param>
					     <xsl:with-param name="maxsize">64</xsl:with-param>
					     <xsl:with-param name="regular-expression">
					     	<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_FSCM_VALIDATION_REGEX')"/>
					     </xsl:with-param>
					     <xsl:with-param name="required">Y</xsl:with-param>
					     <xsl:with-param name="fieldsize">small</xsl:with-param>
					     <xsl:with-param name="override-displaymode">view</xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
			    <!-- Bank Reference -->
		  		<!-- Shown in consolidated view -->
			    <xsl:if test="$show-bo-ref-id='Y' and (not(tnx_id) or tnx_type_code[.!='01'])">
				    <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
				     <xsl:with-param name="value" select="bo_ref_id" />
				     <xsl:with-param name="override-displaymode">view</xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
			    <xsl:if test="$show-fin-bo-ref-id='Y' and (not(tnx_id) or tnx_type_code[.!='01'])">
			    	<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_FIN_BO_REF_ID</xsl:with-param>
				     <xsl:with-param name="value" select="fin_bo_ref_id" />
				     <xsl:with-param name="override-displaymode">view</xsl:with-param>
				    </xsl:call-template>
				 </xsl:if>
				<!-- Invoice reference -->
				<xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_REFERENCE</xsl:with-param>
				    <xsl:with-param name="name">issuer_ref_id</xsl:with-param>
				    <xsl:with-param name="value" select="issuer_ref_id" />
				    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    <!-- Bulk reference -->
				<xsl:if test="$displaymode!='edit'">
					<xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>
					     <xsl:with-param name="name">bulk_ref_id</xsl:with-param>
					     <xsl:with-param name="size">35</xsl:with-param>
					     <xsl:with-param name="maxsize">35</xsl:with-param>
					     <xsl:with-param name="required">Y</xsl:with-param>
					     <xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			    <!--  Application date. -->
			    <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
				     <xsl:with-param name="id">appl_date_view</xsl:with-param>
				     <xsl:with-param name="value" select="appl_date" />
				     <xsl:with-param name="type">date</xsl:with-param>
				     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    <!--  Finance Issue date. -->
			    <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_FINANCE_ISSUE_DATE</xsl:with-param>
				     <xsl:with-param name="id">fin_date_view</xsl:with-param>
				     <xsl:with-param name="value" select="fin_date" />
				     <xsl:with-param name="type">date</xsl:with-param>
				     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
				<!-- Due Date -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_FINANCE_DUE_DATE</xsl:with-param>
					<xsl:with-param name="name">fin_due_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Finance Amount -->
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_AMOUNT</xsl:with-param>
					<xsl:with-param name="product-code">finance</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="seller-programme-buyer-details2"/>
			</xsl:with-param>
	 	</xsl:call-template>	
	</xsl:template>

 
<!-- seller-programme-buyer Details --> 
<xsl:template name="seller-programme-buyer-details2">
	<!-- Buyer Details -->	
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="party-details">
				<xsl:with-param name="show-entity"><xsl:value-of select="$hasEntity"/></xsl:with-param>
				<xsl:with-param name="show-entity-button">N</xsl:with-param>
				<xsl:with-param name="show-BEI">Y</xsl:with-param>
				<xsl:with-param name="prefix">buyer</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				<xsl:with-param name="show-country-icon">N</xsl:with-param>
			</xsl:call-template>			
		</xsl:with-param>
	</xsl:call-template>	
	<!-- Programme Details -->
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_PROGRAMME_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
				<xsl:with-param name="name">fscm_programme_code</xsl:with-param>				
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="button-type">fscm_programme</xsl:with-param>
				<xsl:with-param name="prefix">fscm_programme</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	<!-- Seller Details -->	
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="party-details">				
				<xsl:with-param name="show-BEI">Y</xsl:with-param>
				<xsl:with-param name="prefix">seller</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				<xsl:with-param name="show-country-icon">N</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

	<!-- Repayment Details -->
	<xsl:template name="finance-repayment-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_FINANCE_REPAYMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:if test="$displaymode='edit'">
		    	<xsl:call-template name="select-field">
		      		<xsl:with-param name="label">XSL_FINANCE_REPAYMENT_ACTION</xsl:with-param>
		      		<xsl:with-param name="name">finance_repayment_action</xsl:with-param>
		      		<xsl:with-param name="required">Y</xsl:with-param>	
		      		<xsl:with-param name="options">
		       		<xsl:call-template name="finance_repayment_options"/>
		      		</xsl:with-param>
		     	</xsl:call-template>
		 	</xsl:if>
	  		<xsl:if test="$displaymode='view'">
	    		<xsl:variable name="finance_repayment_action_code"><xsl:value-of select="finance_repayment_action"></xsl:value-of></xsl:variable>
				<xsl:variable name="parameterId">C078</xsl:variable>
				<xsl:call-template name="input-field">
		 			<xsl:with-param name="label">XSL_FINANCE_REPAYMENT_ACTION</xsl:with-param>
		 			<xsl:with-param name="name">finance_repayment_action</xsl:with-param>
		 			<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*',$parameterId, $finance_repayment_action_code)"/></xsl:with-param>
		 			<xsl:with-param name="override-displaymode">view</xsl:with-param>	
				</xsl:call-template>
     		</xsl:if>
			
				<div>
	  				<xsl:call-template name="checkbox-field">
				    	 <xsl:with-param name="label">XSL_INTEREST_FLAG</xsl:with-param>
				     	 <xsl:with-param name="name">interest_flag</xsl:with-param>
				 	</xsl:call-template>			 	
			 	</div>
				<div>
	  				<xsl:call-template name="checkbox-field">
				    	 <xsl:with-param name="label">XSL_CHARGE_FLAG</xsl:with-param>
				     	 <xsl:with-param name="name">charge_flag</xsl:with-param>
				 	</xsl:call-template>			 	
			 	</div>
				<xsl:if test="outstanding_repayment_amt[.!='']">				
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_OUTSTANDING_REPAYMENT</xsl:with-param>
					 	<xsl:with-param name="product-code">outstanding_repayment</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
					</xsl:call-template>
				</xsl:if>		
				<xsl:choose>
					<xsl:when test="$option = 'FULL' or $option = 'DETAILS'">					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="finance_repayment_cur_code"/>&nbsp;<xsl:value-of select="finance_repayment_amt"/></xsl:with-param>
							<xsl:with-param name="name">finance_repayment_amt_input_field</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
					<xsl:if test="$displaymode = 'edit'">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="product-code">finance_repayment</xsl:with-param>
							<xsl:with-param name="currency-readonly">N</xsl:with-param>
							<xsl:with-param name="amt-readonly">N</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>	
							<xsl:with-param name="required">Y</xsl:with-param>						
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="$displaymode = 'view'">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
						 	<xsl:with-param name="product-code">finance_repayment</xsl:with-param>
							<xsl:with-param name="currency-readonly">Y</xsl:with-param>
							<xsl:with-param name="amt-readonly">Y</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>		
				<xsl:if test="interest_repayment_amt[.!=''] and tnx_stat_code[.='04']">				
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_INTEREST_REPAYMENT</xsl:with-param>
					 	<xsl:with-param name="product-code">interest_repayment</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
						<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
						<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="charges_repayment_amt[.!=''] and tnx_stat_code[.='04']">			
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_CHARGES_REPAYMENT</xsl:with-param>
					 	<xsl:with-param name="product-code">charges_repayment</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
						<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
						<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="total_repaid_amt[.!=''] and tnx_stat_code[.='04']">			
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_TOTAL_REPAID_AMT</xsl:with-param>
					 	<xsl:with-param name="product-code">total_repaid</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
						<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
						<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>											
					</xsl:call-template>
				</xsl:if>
				<div>
			     	  <xsl:call-template name="input-field">
				          <xsl:with-param name="label">XSL_REPAYMENT_PERCENTAGE</xsl:with-param>
				          <xsl:with-param name="name">finance_repayment_percentage</xsl:with-param>
				          <xsl:with-param name="type">integer</xsl:with-param>
				          <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				          <xsl:with-param name="swift-validate">N</xsl:with-param>
				          <xsl:with-param name="override-constraints">{places:'0,2', min:1, max:100}</xsl:with-param>        
				          <xsl:with-param name="size">5</xsl:with-param>
				          <xsl:with-param name="maxsize">5</xsl:with-param>
				          <xsl:with-param name="content-after">%</xsl:with-param>
				          <xsl:with-param name="appendClass">block</xsl:with-param>
			         </xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="finance_repayment_options">
		<xsl:for-each select="finance_repay/finance_repayment_details">
	    	<option>
	        	<xsl:attribute name="value">
	        	<xsl:value-of select="finance_repayment_code"></xsl:value-of>
	        	</xsl:attribute>
	        	<xsl:value-of select="finance_repayment_description"/>
	       	</option>
      	</xsl:for-each>
	</xsl:template>
	
	<!-- FX Snippets Start -->
	<xsl:template name="exchange-rate-details">
		<xsl:if test="$displaymode='edit'and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
			<xsl:call-template name="fx-template"/>
		</xsl:if>
		<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
			<xsl:call-template name="fx-details-for-view" /> 
		</xsl:if>
	</xsl:template>
	<!-- FX Snippets End -->
	
	<xsl:template name="instructions-for-bank">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_INSTRUCTIONS_FOR_THE_BANK</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:choose>
				<xsl:when test="$displaymode='edit'">
				     <xsl:call-template name="row-wrapper">
				      	  <xsl:with-param name="id">instructions_for_the_bank</xsl:with-param>				         
					      <xsl:with-param name="required">N</xsl:with-param>
					      <xsl:with-param name="type">textarea</xsl:with-param>
					      <xsl:with-param name="content">
						       <xsl:call-template name="textarea-field">
						        <xsl:with-param name="name">free_format_text</xsl:with-param>
						        <xsl:with-param name="rows">5</xsl:with-param>
						        <xsl:with-param name="cols">35</xsl:with-param>
						        <xsl:with-param name="required">N</xsl:with-param>
						       </xsl:call-template>
				      	  </xsl:with-param>
				    </xsl:call-template>
				</xsl:when>
			    <xsl:when test="$displaymode='view' and free_format_text[.!='']">
			     	<xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="label">XSL_INSTRUCTIONS_FOR_THE_BANK</xsl:with-param>
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="free_format_text"/>
					      </div></xsl:with-param>
				     </xsl:call-template>
			    </xsl:when>
			    </xsl:choose>
		   </xsl:with-param>
	  </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="instructions-from-bank">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_INSTRUCTIONS_FROM_THE_BANK</xsl:with-param>
			<xsl:with-param name="content">				
			    <xsl:if test="$displaymode='view' and bo_comment[.!='']">
			     	<xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="label">XSL_INSTRUCTIONS_FROM_THE_BANK</xsl:with-param>
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="bo_comment"/>
					      </div></xsl:with-param>
				     </xsl:call-template>
			    </xsl:if>
		   </xsl:with-param>
	  </xsl:call-template>
	</xsl:template>
 	
	<!--
   PO Realform.
   -->
	<xsl:template name="realform">
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">realform</xsl:with-param>
				<xsl:with-param name="action" select="$realform-action" />
				<xsl:with-param name="content">
					<div class="widgetContainer">
						<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">referenceid</xsl:with-param>
					       <xsl:with-param name="value" select="ref_id"/>
					      </xsl:call-template>
					      <xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">tnxid</xsl:with-param>
					       <xsl:with-param name="value" select="tnx_id"/>
					      </xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">operation</xsl:with-param>
							<xsl:with-param name="id">realform_operation</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">mode</xsl:with-param>
							<xsl:with-param name="value" select="$mode" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">tnxtype</xsl:with-param>
							<xsl:with-param name="value">13</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">subtnxtype</xsl:with-param>
							<xsl:with-param name="value">A4</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:if test="tnx_type_code = '01' and $option = 'EXISTING'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">isCopyFrom</xsl:with-param>
								<xsl:with-param name="value">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="e2ee_transaction"/>
						<xsl:call-template name="reauth_params"/>						
					</div>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>
