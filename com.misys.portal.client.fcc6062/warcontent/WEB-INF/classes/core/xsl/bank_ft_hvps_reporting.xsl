<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
CNAPS Domestic Fund Transfer (FT-HVPS) Form.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All  Rights Reserved. 

version:   1.0
date:      08/01/2013
author:    Achyut Behera
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security defaultresource">

	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="product-code">FT</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>

	  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" /> 
  <xsl:include href="../../cash/xsl/common/ft_common.xsl" />
  <xsl:include href="../../core/xsl/common/beneficiary_advices_common.xsl" />
  <xsl:include href="../../core/xsl/common/bank_fx_common.xsl" />
  <xsl:include href="../../collaboration/xsl/collaboration.xsl" />
  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="ft_tnx_record"/>
	</xsl:template>
	
	<xsl:template match="ft_tnx_record">
		<xsl:call-template name="loading-message"/>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			
			<!-- Display common reporting area -->
    		<xsl:call-template name="bank-reporting-area"/>
    		
    		<!-- Attachments -->
		    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
		    	 <xsl:call-template name="attachments-file-dojo">
			       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
			       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
		      	</xsl:call-template> 
			</xsl:if>
			
			 <!-- Link to display transaction contents -->
      		<xsl:call-template name="transaction-details-link"/>
      		
            <div id="transactionDetails">
      		 <xsl:call-template name="form-wrapper">
		        <xsl:with-param name="name" select="$main-form-name"/>
		        <xsl:with-param name="validating">Y</xsl:with-param>
		        <xsl:with-param name="content">
         		<h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         
		         <!-- Disclaimer Notice -->
		         <xsl:call-template name="disclaimer"/>
		         
		         <xsl:call-template name="hidden-fields"/>
			<!--
		 	 General Details Fieldset. 
		  	-->
		  		<xsl:call-template name="fieldset-wrapper">   		
			   		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			   		<xsl:with-param name="content">
			   		<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
				     	<xsl:with-param name="id">entity_view</xsl:with-param>
				     	<xsl:with-param name="disabled">Y</xsl:with-param>	
						<xsl:with-param name="fieldsize">small</xsl:with-param>
			   			<xsl:with-param name="value" select="entity" />
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
						
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>	
				     	<xsl:with-param name="id">transfer_from_view</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
		    			<xsl:with-param name="value" select="applicant_act_name" />
		    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
				     	<xsl:with-param name="name">issuing_bank_name</xsl:with-param>	
						<xsl:with-param name="fieldsize">small</xsl:with-param>
			   			<xsl:with-param name="value" select="issuing_bank/name" />
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>	
					
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">XSL_PRODUCT_TYPE</xsl:with-param>			
					    <xsl:with-param name="name">product_type</xsl:with-param>
			   			<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code[.])"/></xsl:with-param>
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				  	<xsl:call-template name="common-general-details">
				  		<xsl:with-param name="show-template-id">N</xsl:with-param>
			     		<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>			     		
			  		</xsl:call-template>
					</xsl:with-param>
		  		</xsl:call-template>	
		  			<xsl:call-template name="recurring_content">
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="isBankReporting">Y</xsl:with-param>
					</xsl:call-template>	  		
			      	<xsl:call-template name="hvps-transfer-to-details" />
					<xsl:call-template name="hvps-transaction-details" />   				
		      		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
        				<xsl:call-template name="bank-fx-template">
        					<xsl:with-param name="override-displaymode">view</xsl:with-param>
        				</xsl:call-template>
        			</xsl:if>    
			      	<xsl:call-template name="beneficiary-advice-details" /> 
			      	<xsl:call-template name="transaction-remarks-details" >
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
       			 </xsl:with-param>
      		 </xsl:call-template>
     	  </div>
       	  <xsl:call-template name="menu">
	     	  <xsl:with-param name="show-template">N</xsl:with-param>
	      	  <xsl:with-param name="second-menu">Y</xsl:with-param>
   		  </xsl:call-template>
  		</div>
		
		<!--  Collaboration Window -->   
	   <xsl:if test="$collaborationmode != 'none'">
	   	<xsl:call-template name="collaboration">
		    <xsl:with-param name="editable">true</xsl:with-param>
		    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
		    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
		    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>
	   </xsl:if>	
		
	  <!-- Javascript imports  -->
	  <xsl:call-template name="js-imports"/>
  
	  <!-- Bene Advice Dialog and GridMultipleItem Template Node -->
	  <xsl:call-template name="bene-advices-dialog-template"/>
 </xsl:template>
 
  <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->

<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.client.binding.bank.cash.report_ft_hvps</xsl:with-param>
			<xsl:with-param name="override-help-access-key">
			   <xsl:choose>
			   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
			   	<xsl:otherwise>PR_01</xsl:otherwise>
			   </xsl:choose>
	  		</xsl:with-param>
		</xsl:call-template>
		<script>
			dojo.ready(function(){
				misys._config = (misys._config) || {};
				misys._config.offset = misys._config.offset ||
				[{
					<xsl:for-each select="start_dt_offset/offset">
						'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>	
				}];
			misys._config.recurring_product = misys._config.recurring_product || 
			{
			<xsl:for-each select="recurring_payment/recurring_product">
					'<xsl:value-of select="sub_prod_type" />':'<xsl:value-of select="flag" />'
					<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>	
			};
			misys._config.frequency_mode = misys._config.frequency_mode || 
			[
			{
			<xsl:for-each select="frequency/frequency_mode">
				'<xsl:value-of select="frequency_type"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
            	<xsl:if test="position()!=last()">,</xsl:if>
            </xsl:for-each>
            }
            ];				
		});
		</script>
 	</xsl:template>

	<xsl:template name="hvps-transfer-to-details">
		<xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata)))"/>

	   	<!-- Transfer to options for HVPS transfer -->
		<xsl:call-template name="fieldset-wrapper">
		  <xsl:with-param name="legend">XSL_HEADER_TRANSFER_TO_DETAILS</xsl:with-param>
			 <xsl:with-param name="content">
			 <xsl:call-template name="column-container">
					<xsl:with-param name="content">
				   <xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_NAME</xsl:with-param>
							<xsl:with-param name="name">beneficiary_name</xsl:with-param>		
							<xsl:with-param name="swift-validate">Y</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>	
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<!-- <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param> -->
							<xsl:with-param name="override-displaymode"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">view</xsl:if></xsl:with-param>	
						</xsl:call-template>
						
						<!-- <xsl:if test="$displaymode='edit'">
							<xsl:call-template name="button-wrapper">
								<xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
								<xsl:with-param name="show-image">Y</xsl:with-param>
								<xsl:with-param name="show-border">N</xsl:with-param>
								<xsl:with-param name="id">beneficiary_img</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="not($pre-approved_beneficiary_only)">
								<xsl:call-template name="button-wrapper">
									<xsl:with-param name="id">clear_img</xsl:with-param>
									<xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
									<xsl:with-param name="show-image">Y</xsl:with-param>
									<xsl:with-param name="show-border">N</xsl:with-param>
									<xsl:with-param name="img-src"><xsl:value-of select="$contextPath"/>/content/images/pic_clear.gif</xsl:with-param>
								</xsl:call-template>					   
							</xsl:if>
						</xsl:if> -->
						<div class="field">

		    				<xsl:if test="$displaymode = 'edit' or ($displaymode ='view' and counterparties/counterparty/counterparty_act_no[.!=''])">
		    					<span class="label"> 
		    					<!-- <span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span> -->
		    						<xsl:value-of select="localization:getGTPString($language,'XSL_BENEFICIARY_ACCOUNT')"/>
		    					</span>
		    				</xsl:if>
		    	
		    				<xsl:if test="$displaymode = 'edit' or ($displaymode ='view' and sub_product_code[.='HVPS'])">
		    					<div>
		    						<xsl:attribute name="class">CUR <xsl:if test="$displaymode !='edit'"> inlineBlock</xsl:if></xsl:attribute>
		    						<xsl:choose>
		    							<xsl:when test="$displaymode = 'edit'">
		    								<div style="display:none;">
			    								<div name="beneficiary_act_cur_code" id="beneficiary_act_cur_code" trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" regExp="^[a-zA-Z]*$" class="xx-small inlineBlock inlineBlockNoLabel" maxLength="3">										
			    									<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
			    									<xsl:attribute name="displayedValue"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
			    									<!-- <xsl:attribute name="readOnly">Y</xsl:attribute> -->
			    									<xsl:attribute name="override-displaymode">view</xsl:attribute>
			    								</div>
		    								</div>
		    							</xsl:when>
		    							<xsl:otherwise>
		    								<div style="display:none;">
		    									<div name="beneficiary_act_cur_code" id="beneficiary_act_cur_code" trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" regExp="^[a-zA-Z]*$" class="xx-small inlineBlock inlineBlockNoLabel" maxLength="3">										
		    										<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
		    										<xsl:attribute name="displayedValue"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
		    										<!-- <xsl:attribute name="readOnly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:attribute> -->
		    											 <xsl:attribute name="override-displaymode"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">view</xsl:if></xsl:attribute>
		    									</div>
		    								</div>
		    								<span class="content" style="padding-right: 0.5em;"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></span>
		    							</xsl:otherwise>
		    						</xsl:choose>
		    				
		    						<!-- Hidden fields to store information related to Beneficary Account Validation when product type is HVPS -->
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
		    							<xsl:with-param name="name">bene_email_1</xsl:with-param>
		    							<xsl:with-param name="value">
		    								<xsl:if test="notify_beneficiary[.='Y'] and notify_beneficiary_choice[.='default_email']">
		    									<xsl:value-of select="notify_beneficiary_email"/>
		    								</xsl:if>
		    							</xsl:with-param>
		    						</xsl:call-template>
		    						<xsl:call-template name="hidden-field">
		    							<xsl:with-param name="name">bene_email_2</xsl:with-param>
		    						</xsl:call-template>
		    					</div>	
		    				</xsl:if>	
		    				<xsl:call-template name="input-field">
		    				    <xsl:with-param name="type">account</xsl:with-param>
		    				    <xsl:with-param name="name">beneficiary_account</xsl:with-param>	
		    				    <xsl:with-param name="maxsize">11</xsl:with-param>	
		    				    <xsl:with-param name="required">N</xsl:with-param>	
		    				    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
		    				    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
		    				   <!--  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param> -->
		    				    <xsl:with-param name="override-displaymode"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">view</xsl:if></xsl:with-param>
		    				</xsl:call-template>
		    				<xsl:call-template name="hidden-field">
		    							<xsl:with-param name="name">beneficiary_account</xsl:with-param>
		    							<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
		    				</xsl:call-template>
					 	    <!-- </div> -->
							<!-- This Empty div is to show inline for HVPS product , used in JS -->				
							<div class="CUR"/>
							<div id="pre_approved_row" class="field">
								<span class="label"/>
								<div id="PAB" class="content">
									<xsl:attribute name="style">
										<xsl:choose>
											<xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
											<xsl:otherwise>display:none</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language,'XSL_TPT_PAB')"/>
								</div> 
							</div>
						</div>
						<xsl:if test="transfer_purpose[.!='']">
						<xsl:variable name="transfer_purpose_code"><xsl:value-of select="transfer_purpose"></xsl:value-of></xsl:variable>
							 <xsl:call-template name="input-field">
							 	<xsl:with-param name="label">XSL_TRANSFER_PURPOSE</xsl:with-param>
							 	<xsl:with-param name="name">transfer_purpose</xsl:with-param>
							 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
							 	<xsl:with-param name="value"><xsl:value-of select="utils:retrieveTransferPurposeDesc($rundata, $transfer_purpose_code)"/></xsl:with-param>	
							 </xsl:call-template>
							 </xsl:if>
						</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
					    	<xsl:call-template name="input-field">
						      	 <xsl:with-param name="label">XSL_BENEFICIARY_CNAPS_BANK_CODE</xsl:with-param>
							     <xsl:with-param name="name">cnaps_bank_code</xsl:with-param>
							     <xsl:with-param name="maxsize">14</xsl:with-param>	
							     <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			                     <xsl:with-param name="required">N</xsl:with-param>		
			                     <xsl:with-param name="value"><xsl:if test="sub_product_code = 'HVPS'"><xsl:value-of select="cnaps_bank_code"/></xsl:if></xsl:with-param>	
			                     <!-- <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>	 -->
			                     <xsl:with-param name="override-displaymode"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">view</xsl:if></xsl:with-param>     			  
							 </xsl:call-template>	
					         <xsl:choose>
			                 <xsl:when test="bulk_ref_id[.!='']">
							     <xsl:if test="not($pre-approved_beneficiary_only) and $displaymode='edit'">	
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="show-image">Y</xsl:with-param>
										<xsl:with-param name="show-border">N</xsl:with-param>
										<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cnaps_bank_code', 'cpty_branch_name','cpty_bank_name']", '', '', '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
										<xsl:with-param name="id">bank_img</xsl:with-param>
										<xsl:with-param name="non-dijit-button">N</xsl:with-param>
									</xsl:call-template>
				               	</xsl:if>	
				              </xsl:when> 
				              <xsl:otherwise>
				                 <xsl:if test="not($pre-approved_beneficiary_only) and $displaymode='edit'">	
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="show-image">Y</xsl:with-param>
										<xsl:with-param name="show-border">N</xsl:with-param>
										<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cnaps_bank_code', 'cpty_branch_name','cpty_bank_name']", '', '', 'N', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
										<xsl:with-param name="id">bank_img</xsl:with-param>
										<xsl:with-param name="non-dijit-button">N</xsl:with-param>
									</xsl:call-template>
				               	</xsl:if>	
				              </xsl:otherwise>
			               	</xsl:choose>	
						  <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_BENEFICIARY_CNAPS_BANK_NAME</xsl:with-param>
						    <xsl:with-param name="name">cnaps_bank_name</xsl:with-param>
						    <xsl:with-param name="fieldsize">medium</xsl:with-param>
						    <xsl:with-param name="required">N</xsl:with-param>	
						    <xsl:with-param name="value"><xsl:if test="sub_product_code = 'HVPS'"><xsl:value-of select="cnaps_bank_name"/></xsl:if></xsl:with-param>		
						    <!-- <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param> -->
						  	<!-- <xsl:with-param name="readonly">Y</xsl:with-param> -->
						  	<xsl:with-param name="override-displaymode">view</xsl:with-param>
						  	<xsl:with-param name="swift-validate">N</xsl:with-param>
						  </xsl:call-template>
						</xsl:with-param>
						</xsl:call-template>       				
					</xsl:with-param>
		 	        </xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bk_sub_product_code</xsl:with-param>
				    </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="hvps-transaction-details">	 	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">		
				<xsl:call-template name="column-container">
				<xsl:with-param name="content">
					<xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
							<xsl:with-param name="product-code">ft</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="currency-readonly">Y</xsl:with-param>		
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
							<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<div id="transfer_date_div">
									<xsl:call-template name="business-date-field">
										<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
										<xsl:with-param name="name">iss_date</xsl:with-param>
										<xsl:with-param name="size">10</xsl:with-param>
										<xsl:with-param name="maxsize">10</xsl:with-param>
										<xsl:with-param name="required">N</xsl:with-param>
										<xsl:with-param name="fieldsize">small</xsl:with-param>
										<xsl:with-param name="sub-product-code-widget-id">sub_product_code_custom</xsl:with-param>
										<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
										<xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">sub_product_code_custom</xsl:with-param>
						   			</xsl:call-template>
						   			<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">iss_date</xsl:with-param>
						   			</xsl:call-template>
						</div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_URGENT_TRANSFER_VIEW</xsl:with-param>
							<xsl:with-param name="name">urgent_transfer</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:if test="urgent_transfer[.='Y']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_URGENT_TRANSFER_YES')"/>
								</xsl:if>
								<xsl:if test="urgent_transfer[.='N']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_URGENT_TRANSFER_NO')"/>
								</xsl:if>
							</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
										
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
							<xsl:with-param name="name">cust_ref_id</xsl:with-param>
							<xsl:with-param name="size">16</xsl:with-param>
							<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
							<xsl:with-param name="regular-expression">
							<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
							</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
							<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
							<xsl:with-param name="size">19</xsl:with-param>
							<xsl:with-param name="maxsize">19</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>

						<xsl:variable name="businessTypeDescription">CNAPS_BUSINESS_TYPE_HVPS_<xsl:value-of select="business_type"/></xsl:variable>
						<xsl:variable name="businessDetailTypeDescription">CNAPS_BUSINESS_DETAIL_TYPE_HVPS_<xsl:value-of select="business_detail_type"/></xsl:variable>
						<xsl:call-template name="input-field">
							  <xsl:with-param name="label">XSL_GENERALDETAILS_BUSINESS_TYPE</xsl:with-param>
						      <xsl:with-param name="name">business_type</xsl:with-param>
						      <xsl:with-param name="value"><xsl:value-of select="business_type"/> - <xsl:value-of select="localization:getGTPString($language, $businessTypeDescription)"/></xsl:with-param>
						 	  <xsl:with-param name="override-displaymode">view</xsl:with-param>
						 </xsl:call-template>
						<xsl:call-template name="input-field">
						      <xsl:with-param name="label">XSL_GENERALDETAILS_BUSINESS_DETAIL_TYPE</xsl:with-param>
						      <xsl:with-param name="name">business_detail_type</xsl:with-param>
						      <xsl:with-param name="value"><xsl:value-of select="business_detail_type"/> - <xsl:value-of select="localization:getGTPString($language, $businessDetailTypeDescription)"/></xsl:with-param>
						 	  <xsl:with-param name="override-displaymode">view</xsl:with-param>
						 </xsl:call-template>	
								
						<!-- Verifying amount access from bulk -->
			   			<div>
							<xsl:if test="bulk_ref_id[.!='']">
								<xsl:variable name="transactionCodeRequired">
									<xsl:choose>
										<xsl:when test="sub_product_code[.='IBGEX'] or sub_product_code[.='IBG']">
											<xsl:value-of select="'Y'"></xsl:value-of>
										</xsl:when>
										<xsl:otherwise>	
											<xsl:value-of select="'N'"></xsl:value-of>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
						<xsl:if test="bulk_ref_id[.!=''] and transaction_code and transaction_code/transaction_codes[.!='']">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_BK_TRANSACTION_CODE</xsl:with-param>
									<xsl:with-param name="name">bk_transaction_code</xsl:with-param>
									<xsl:with-param name="fieldsize">medium</xsl:with-param>
									<xsl:with-param name="required"><xsl:value-of select="$transactionCodeRequired"/></xsl:with-param>
									<xsl:with-param name="options">			       		
										<xsl:choose>
											<xsl:when test="$displaymode='edit'">
												<xsl:for-each select="transaction_code/transaction_codes">
													<option value="{transaction_code_id}">
														<xsl:value-of select="tranaction_code_des"/>
													</option>
												</xsl:for-each>
											</xsl:when>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
					</xsl:if>
						</div>
						<!-- some hidden fields -->
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="entity"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">ft_cur_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="ft_cur_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">applicant_act_cur_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="applicant_act_cur_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">ft_amt_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="ft_amt"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">recurring_start_date_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="recurring_start_date"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">base_cur_code</xsl:with-param>
						    <xsl:with-param name="value" select="base_cur_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">ref_id</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
					</xsl:call-template>
			</xsl:with-param>
			</xsl:call-template>	
		</xsl:with-param>
		</xsl:call-template>			
	</xsl:template>
</xsl:stylesheet>
