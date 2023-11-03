<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Internal Trade Fund Transfer (FT-TINT) Form.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

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
 	<xsl:include href="../../core/xsl/common/ls_common.xsl" />
  
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
					<xsl:choose>
						<xsl:when test ="sub_tnx_stat_code[.='17']">
							     <xsl:call-template name="attachments-file-dojo">
							       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
							       <xsl:with-param name="title-size">35</xsl:with-param>
							      </xsl:call-template> 
						</xsl:when>
						<xsl:otherwise>
							     <xsl:call-template name="attachments-file-dojo">
							       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
							       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02' or type = '01']"/>
							       <xsl:with-param name="title-size">35</xsl:with-param>
							      </xsl:call-template> 
						</xsl:otherwise>
					</xsl:choose>
> 
				</xsl:if>
				
				 <!-- Link to display transaction contents -->
				<xsl:call-template name="transaction-details-link">
					<xsl:with-param name="show-transaction">
						<xsl:choose>
							<xsl:when test="tnx_type_code[.!='01'] and $displaymode='edit' or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="show-hyperlink">
						<xsl:choose>
							<xsl:when test="tnx_type_code[.='01'] and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
							<xsl:when test="tnx_type_code[.='13'] and defaultresource:getResource('ENABLE_EDITING_MSG_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
							<xsl:when test="tnx_type_code[.='15']">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
	      		
		            <div id="transactionDetails">
		      			<xsl:call-template name="form-wrapper">
			       			<xsl:with-param name="name" select="$main-form-name"/>
					        <xsl:with-param name="validating">Y</xsl:with-param>
					        <xsl:with-param name="content">
						        <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
						         
						        <!-- Disclaimer Notice -->
						        <xsl:call-template name="disclaimer"/>
				         
						        <xsl:call-template name="hidden-fields"/>
						        
						        <xsl:if test="securitycheck:hasPermission($rundata,'tradeadmin_ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	   </xsl:if>
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
							  		<xsl:call-template name="fieldset-wrapper">
								       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
								       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
								       <xsl:with-param name="content">
									        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
									         <xsl:with-param name="id">applicant_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">view</xsl:with-param>
									         <xsl:with-param name="value"><xsl:value-of select="applicant_name"/></xsl:with-param>
							       			</xsl:call-template>
							       			<xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
									         <xsl:with-param name="id">applicant_address_line_1</xsl:with-param>
									         <xsl:with-param name="override-displaymode">view</xsl:with-param>
									         <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
							       			</xsl:call-template>
							       			<xsl:call-template name="input-field">
									         <xsl:with-param name="id">applicant_address_line_2</xsl:with-param>
									         <xsl:with-param name="override-displaymode">view</xsl:with-param>
									         <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
							       			</xsl:call-template>
							       			<xsl:call-template name="input-field">
									         <xsl:with-param name="id">applicant_dom</xsl:with-param>
									         <xsl:with-param name="override-displaymode">view</xsl:with-param>
									         <xsl:with-param name="value"><xsl:value-of select="applicant_dom"/></xsl:with-param>
							       			</xsl:call-template>
							       	   </xsl:with-param>
							       	</xsl:call-template>
							  		<!-- Applicant Details -->
									<xsl:call-template name="row-wrapper">
							           <xsl:with-param name="label">XSL_PARTIESDETAILS_ORDERING_ACT_NO</xsl:with-param>
							           <xsl:with-param name="content">
							                 <xsl:call-template name="input-field">
							                     <xsl:with-param name="name">applicant_act_cur_code</xsl:with-param>   
							                     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
							                     <xsl:with-param name="value" select="applicant_act_cur_code" />
							                     <xsl:with-param name="override-displaymode">view</xsl:with-param>
							                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
							                 </xsl:call-template>     
							                 &nbsp;    
										     <xsl:call-template name="input-field">
											     <xsl:with-param name="name">applicant_act_no</xsl:with-param>
											     <xsl:with-param name="maxsize">34</xsl:with-param>
											     <xsl:with-param name="value" select="applicant_act_no" />
											     <xsl:with-param name="override-displaymode">view</xsl:with-param>
										         <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
											 </xsl:call-template>
										</xsl:with-param>
									</xsl:call-template>
									</xsl:with-param>
						  		</xsl:call-template>
						  		<xsl:call-template name="recurring_content">
						  			<xsl:with-param name="override-displaymode">view</xsl:with-param>
						  		</xsl:call-template>
						      	<xsl:call-template name="tint-transfer-to-details" />
								<xsl:call-template name="tint-transaction-details" />  				
					      		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
				       				<xsl:call-template name="bank-fx-template">
				       					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				       				</xsl:call-template>
				       			</xsl:if>    
				       			<!-- Bank details -->
						        <xsl:call-template name="fieldset-wrapper">
								     <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
								     <xsl:with-param name="content">
								     	<xsl:call-template name="bank_details">
								          <xsl:with-param name="prefix" select="'issuing_bank'"/>
								        </xsl:call-template>
								        </xsl:with-param>
							     </xsl:call-template>
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
  
  <xsl:template name="bank_details">
		<xsl:param name="prefix"/>
		<xsl:variable name="bank-name-value">
			<xsl:value-of select="//*[name()=$prefix]/name"/>
		</xsl:variable>
		<xsl:variable name="appl_ref">
		  <xsl:value-of select="applicant_reference"/>
	    </xsl:variable>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
			<xsl:with-param name="value" select="$bank-name-value"/>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="fieldsize">small</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
	  	   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
	  	   <xsl:with-param name="value">
	  	   	<xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
	  	   </xsl:with-param>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>
   
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.bank.report_ft_tint</xsl:with-param>
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

	<xsl:template name="tint-transfer-to-details">
		<xsl:call-template name="fieldset-wrapper">
			  <xsl:with-param name="legend">XSL_HEADER_TRANSFER_TO_DETAILS</xsl:with-param>
			   <xsl:with-param name="content">
				  <xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_BENEFICIARY_ACCOUNT</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
						    <xsl:with-param name="name">counterparty_cur_code</xsl:with-param>	
						    <xsl:with-param name="override-displaymode">view</xsl:with-param>
						    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:with-param>
						</xsl:call-template> 
						&nbsp;
						<xsl:call-template name="input-field">
						    <xsl:with-param name="type">account</xsl:with-param>
						    <xsl:with-param name="name">counterparty_act_no</xsl:with-param>	
						    <xsl:with-param name="override-displaymode">view</xsl:with-param>
						    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
						</xsl:call-template>    				
					</xsl:with-param>
				</xsl:call-template>
				</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
    
	<xsl:template name="tint-transaction-details">	 	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
			             <xsl:with-param name="content">
			         <xsl:call-template name="transaction-amt-details">
				       <xsl:with-param name="override-product-code">ft</xsl:with-param>
				     </xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
					<xsl:with-param name="name">cust_ref_id</xsl:with-param>
					<xsl:with-param name="size">16</xsl:with-param>
					<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
					<xsl:with-param name="regular-expression">
							<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_VALIDATION_REGEX')"/>
					</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>

				<div id="transfer_date_div">
					<xsl:call-template name="business-date-field">
								<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
								<xsl:with-param name="name">iss_date</xsl:with-param>
								<xsl:with-param name="size">10</xsl:with-param>
								<xsl:with-param name="maxsize">10</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="sub-product-code-widget-id">sub_product_code_custom</xsl:with-param>
								<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
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
					<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
					<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
					<xsl:with-param name="size">19</xsl:with-param>
					<xsl:with-param name="maxsize">19</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
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
				</xsl:with-param>
	    	</xsl:call-template>
	</xsl:template>

	<xsl:template name="transaction-amt-details">
	  <xsl:param name="override-product-code" select="$lowercase-product-code"/>
	  <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
	       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_amt</xsl:with-param>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       <xsl:with-param name="value">
	         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
	         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
	         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
		     <xsl:if test="$field-value !=''">
		      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
		     </xsl:if>
		   </xsl:with-param>
	      </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">ft_amt</xsl:with-param>
		      <xsl:with-param name="value" select="ft_amt"/>
		  </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">ft_cur_code</xsl:with-param>
		      <xsl:with-param name="value" select="ft_cur_code"/>
	  </xsl:call-template>
	  </xsl:template>							   	

</xsl:stylesheet>
