<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    exclude-result-prefixes="localization xmlRender">

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
  <xsl:param name="newPaymentFromScratch">false</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" /> 
  <xsl:include href="./common/ft_common.xsl" />
  <xsl:include href="./common/bp_dda_common.xsl" />
 
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
	<script>
			dojo.ready(function(){		
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
			productCode: '<xsl:value-of select="$product-code"/>',
			mode: '<xsl:value-of select="$mode"/>',
			ft_type : '<xsl:value-of select="ft_type"/>',
			subProductCode : '<xsl:value-of select="sub_product_code"/>',
			newPaymentFromScratch : '<xsl:value-of select="$newPaymentFromScratch"/>'
			});
		//Call Template to initialize the recurring payment details related configuration
		<xsl:call-template name="recurring_payment_details_script" />
		});
	</script>

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
    
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- 
    <xsl:choose>
     
    -->
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
<!--         <xsl:call-template name="general-details"/>-->
			<!--
		 	 General Details Fieldset. 
		  	-->
<!--		 	<xsl:template name="general-details-bank">-->
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
				     	<xsl:with-param name="label">
				     		<xsl:choose>
								<xsl:when test="sub_product_code ='BILLP' or sub_product_code ='DDA' or sub_product_code ='BILLS'">XSL_DEBIT_ACCOUNT</xsl:when>
								<xsl:otherwise>XSL_TRANSFER_FROM</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>	
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
			     		<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>	
		      			<xsl:with-param name="show-template-id">N</xsl:with-param>		     		
			  		</xsl:call-template>
					</xsl:with-param>
		  		</xsl:call-template>
	     			     		
				<xsl:if test="sub_product_code[.='BILLP'] or sub_product_code[.='DDA'] or sub_product_code[.='BILLS']">
					<!-- Bill Payment specific -->
		      		<xsl:if test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS']">
			      		<xsl:call-template name="recurring_content" >
				      		<xsl:with-param name="override-displaymode">view</xsl:with-param>
				      		<xsl:with-param name="isBankReporting">Y</xsl:with-param>
			      		</xsl:call-template>			    		      	
			      	</xsl:if>			     
			      	
			      	<!-- transaction details -->
			      	<div class="widgetContainer">
				   		<xsl:call-template name="fieldset-wrapper">
					     	<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
					     	<xsl:with-param name="content">
					     	
						     	<xsl:call-template name="column-container">
								<xsl:with-param name="content">
								 <!-- column 1 -->		 
								<xsl:call-template name="column-wrapper">
								<xsl:with-param name="content">
				 						<xsl:call-template name="payee-details">
				 							<xsl:with-param name="isBankReporting">Y</xsl:with-param>
				 						</xsl:call-template>	
								</xsl:with-param>
								</xsl:call-template><!-- End of column1 -->
								<!-- Column 2 -->
								<xsl:call-template name="column-wrapper">
								<xsl:with-param name="content">
								
									<xsl:choose>
										<xsl:when test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS']">
				      						<xsl:call-template name="tnx-details-billPayment">
				      							<xsl:with-param name="isBankReporting">Y</xsl:with-param>
				      						</xsl:call-template>	
				      					</xsl:when>
				      					<xsl:otherwise>
				      						<xsl:call-template name="tnx-details-dda"/>	
				      					</xsl:otherwise>
				      			 	</xsl:choose>
				      			 	
			      			  	</xsl:with-param>
				   				</xsl:call-template><!-- End of column2 -->
				   				</xsl:with-param>
				   				</xsl:call-template>
			      		
			      			</xsl:with-param>
			      		</xsl:call-template>
			      	</div>	
		      		 
		      		<xsl:call-template name="transaction-remarks-details">
		      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		      		</xsl:call-template>
				</xsl:if>

        </xsl:with-param>
       </xsl:call-template>
      </div>
   
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
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
  <xsl:call-template name="common-js-imports">
<!--   <xsl:with-param name="binding">misys.binding.cash.BankReportingFtBinding</xsl:with-param>-->
<xsl:with-param name="binding">misys.binding.bank.report_bp_dda</xsl:with-param>
	<xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
	</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
</xsl:stylesheet>