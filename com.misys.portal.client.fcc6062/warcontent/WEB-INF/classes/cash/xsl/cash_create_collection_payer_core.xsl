<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Bulk Collection Payer Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      27/12/11
author:    Ramesh M
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
       exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils">
       
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen</xsl:param>
  <xsl:param name="isMultiBank">N</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/beneficiary_advices_common.xsl" />
  <xsl:include href="./common/ft_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ft_tnx_record"/>
  </xsl:template>
  
  <!-- 
   FT TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
     
   <div>
   	<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     	<xsl:with-param name="content">
      		<!-- Disclaimer Notice -->
	      		<xsl:call-template name="disclaimer"/> 
	      		    
		      	<xsl:call-template name="hidden-fields"/>
		      	<div class="widgetContainer"> 
		      		<xsl:call-template name="hidden-fields-bulk"/>
		      	</div>
	      			<!--  Display common menu. -->
					<xsl:call-template name="menu" >
						<xsl:with-param name="show-reject">Y</xsl:with-param>
			 		</xsl:call-template>
				 	<xsl:call-template name="server-message">
				 		<xsl:with-param name="name">server_message</xsl:with-param>
				 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
				 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
	      		   	<xsl:call-template name="general-details">
	      		   		<xsl:with-param name="transfer-from-label">XSL_TRANSFER_TO</xsl:with-param>
	      		   	</xsl:call-template>
	      		   	<xsl:call-template name="payer-details" />
	     </xsl:with-param>
	 </xsl:call-template>	 	 
    <xsl:call-template name="realform"/>
   </div>
  
  	<!--
  	 General Details Fieldset. 
   	-->
    
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
   <xsl:with-param name="binding">misys.binding.cash.create_collection</xsl:with-param>
  </xsl:call-template>
  <script>
		dojo.ready(function(){
			misys._config = (misys._config) || {};
			misys._config.recurring_product = misys._config.recurring_product || 
			{
			<xsl:for-each select="recurring_payment/recurring_product">
					'<xsl:value-of select="sub_prod_type" />':'<xsl:value-of select="flag" />'
					<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>	
			};
			misys._config.offset = misys._config.offset ||
			[ 
			{
			<xsl:for-each select="start_dt_offset/offset">
					'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
					<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>	
			}
			];			
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

 <!--
   Real form for Collection Payer 
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
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
       <xsl:with-param name="value" select="$mode"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
     
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  	<!--
  	 Collection Payer Fieldset. 
   	-->
   	<xsl:template name="payer-details">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_PAYER_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="column-container">
				<xsl:with-param name="content">			 
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
						 	<xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_ACCOUNT_NUMBER</xsl:with-param>
							    <xsl:with-param name="name">counterparty_act_no</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>	
							    <xsl:with-param name="fieldsize">small</xsl:with-param>
							    <xsl:with-param name="size">11</xsl:with-param>
				   				<xsl:with-param name="maxsize">11</xsl:with-param>
							</xsl:call-template>  
							<xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_APPLICANT_ACCOUNT_NAME</xsl:with-param>
							    <xsl:with-param name="name">counterparty_name</xsl:with-param>
							    <xsl:with-param name="fieldsize">medium</xsl:with-param>	
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="size">20</xsl:with-param>
							    <xsl:with-param name="maxsize">20</xsl:with-param>	
							</xsl:call-template>  
							<xsl:if test="bulk_ref_id[.!=''] and transaction_code and transaction_code/transaction_codes[.!='']">
									<xsl:call-template name="select-field">
										<xsl:with-param name="label">XSL_BK_TRANSACTION_CODE</xsl:with-param>
										<xsl:with-param name="name">bk_transaction_code</xsl:with-param>
										<xsl:with-param name="fieldsize">medium</xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
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
						    <xsl:call-template name="currency-field">
						      	<xsl:with-param name="label">XSL_DEBIT_AMOUNT</xsl:with-param>
							   	<xsl:with-param name="product-code">ft</xsl:with-param>
							   	<xsl:with-param name="required">Y</xsl:with-param>
							   	<xsl:with-param name="currency-readonly">
							   	<xsl:choose>
							   		<xsl:when test="bulk_ref_id[.!='']">Y</xsl:when>
							   		<xsl:otherwise>N</xsl:otherwise>
							   	</xsl:choose>				   		
							   	</xsl:with-param>
							   	<xsl:with-param name="show-button">
							   	<xsl:choose>
							   		<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
							   		<xsl:otherwise>Y</xsl:otherwise>
							   	</xsl:choose>
							   	</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
				     			<xsl:with-param name="label">REFERENCE_LABEL</xsl:with-param>	
					    		<xsl:with-param name="name">bk_reference</xsl:with-param>
				   				<xsl:with-param name="size">12</xsl:with-param>
				   				<xsl:with-param name="maxsize">12</xsl:with-param>
				   				<xsl:with-param name="fieldsize">small</xsl:with-param>
				   				<xsl:with-param name="required">N</xsl:with-param>
				   			</xsl:call-template>	
							<xsl:call-template name="input-field">
			     			  <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
				    		  <xsl:with-param name="name">cust_ref_id</xsl:with-param>
			   				  <xsl:with-param name="size">16</xsl:with-param>
			   				  <xsl:with-param name="maxsize">64</xsl:with-param>
			   				  <xsl:with-param name="fieldsize">small</xsl:with-param>
	   						</xsl:call-template>
					       <xsl:call-template name="input-field">
			    			<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
			    			<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
			  				<xsl:with-param name="size">19</xsl:with-param>
			  				<xsl:with-param name="maxsize">19</xsl:with-param>
			  				<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
			  				<xsl:with-param name="fieldsize">small</xsl:with-param>
				  		   </xsl:call-template>
					</xsl:with-param>
				   </xsl:call-template>
				   <xsl:call-template name="column-wrapper">
						  <xsl:with-param name="content">
					    	<xsl:call-template name="input-field">
						      	 <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_BRANCH_CODE</xsl:with-param>
							     <xsl:with-param name="name">cpty_bank_code</xsl:with-param>
							     <xsl:with-param name="maxsize">4</xsl:with-param>	
							     <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			                     <xsl:with-param name="required">Y</xsl:with-param>		
			                     <xsl:with-param name="value"><xsl:if test="sub_product_code = 'DOM'"><xsl:value-of select="counterparties/counterparty/cpty_bank_code"/></xsl:if></xsl:with-param>	
			                     <xsl:with-param name="readonly">Y</xsl:with-param>	     			  
							 </xsl:call-template>	
							 <xsl:call-template name="input-field">
							     <xsl:with-param name="name">cpty_branch_code</xsl:with-param>	
						   		 <xsl:with-param name="maxsize">3</xsl:with-param>	
						   		 <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
			                     <xsl:with-param name="required">Y</xsl:with-param>	
			                     <xsl:with-param name="value"><xsl:if test="sub_product_code = 'DOM'"><xsl:value-of select="counterparties/counterparty/cpty_branch_code"/></xsl:if></xsl:with-param>
			                     <xsl:with-param name="readonly">Y</xsl:with-param>	
			                 </xsl:call-template>	
			                 <xsl:choose>
			                 <xsl:when test="bulk_ref_id[.!='']">
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="show-image">Y</xsl:with-param>
										<xsl:with-param name="show-border">N</xsl:with-param>
										<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cpty_branch_code', 'cpty_branch_name','cpty_bank_name']", '', '', '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
										<xsl:with-param name="id">bank_img</xsl:with-param>
										<xsl:with-param name="non-dijit-button">N</xsl:with-param>
									</xsl:call-template>
				              </xsl:when> 
				              <xsl:otherwise>
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="show-image">Y</xsl:with-param>
										<xsl:with-param name="show-border">N</xsl:with-param>
										<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cpty_branch_code', 'cpty_branch_name','cpty_bank_name']", '', '', 'N', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
										<xsl:with-param name="id">bank_img</xsl:with-param>
										<xsl:with-param name="non-dijit-button">N</xsl:with-param>
									</xsl:call-template>
				              </xsl:otherwise>
			               	</xsl:choose>	
						  <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS</xsl:with-param>
						    <xsl:with-param name="name">cpty_bank_name</xsl:with-param>
						    <xsl:with-param name="fieldsize">medium</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>			
						  	<xsl:with-param name="readonly">Y</xsl:with-param>
						  	<xsl:with-param name="swift-validate">N</xsl:with-param>
						  </xsl:call-template>
				      	  <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_PARTIESDETAILS_BRANCH_NAME</xsl:with-param>
						    <xsl:with-param name="name">cpty_branch_name</xsl:with-param>	
						    <xsl:with-param name="fieldsize">medium</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>			
						  	<xsl:with-param name="readonly">Y</xsl:with-param>
						  	<xsl:with-param name="swift-validate">N</xsl:with-param>
						  </xsl:call-template>
						</xsl:with-param>
					  </xsl:call-template>
				  </xsl:with-param>
			  </xsl:call-template>
		  </xsl:with-param>
	  </xsl:call-template>
   </xsl:template>
   
   <xsl:template name="hidden-fields-bulk">
   	  <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">applicant_act_no</xsl:with-param>
       	<xsl:with-param name="value" select="applicant_act_no"/>
      </xsl:call-template>  
      <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">applicant_act_name</xsl:with-param>
        <xsl:with-param name="value" select="applicant_act_name"/>
   	  </xsl:call-template>
  		<xsl:call-template name="hidden-field">
		  <xsl:with-param name="name">entity</xsl:with-param>
		  <xsl:with-param name="value" select="entity"/>
		</xsl:call-template>
   </xsl:template>
  
</xsl:stylesheet>