<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      27/05/12
author:    Raja Rao
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils">
         
  <!-- 
   FT TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>    
  
  <div>
   	<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

	<!-- Reauthentication -->
    <xsl:call-template name="reauthentication" />
	 
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
           
      		<!-- Disclaimer Notice -->
      		<xsl:call-template name="disclaimer"/>
      
	      	<xsl:call-template name="hidden-fields"/>	      	
	      	<xsl:call-template name="hidden-fields-bpdda"/>	   
     			
				
	      	<xsl:apply-templates select="cross_references" mode="hidden_form"/>
	      	
	      	<div id="content1">	      
			 <xsl:if test="$displaymode='edit'">
			 	
			 	<xsl:choose>
	      		  	<xsl:when test="securitycheck:hasPermission(utils:getUserACL($rundata),'ft_recurringpayment_access',utils:getUserEntities($rundata))">	      				   			      				      		
		      			<xsl:call-template name="intermediary-section"> 	      		      				
	     					<xsl:with-param name="transfer-from-label">XSL_DEBIT_ACCOUNT</xsl:with-param> 				
		 					<xsl:with-param name="show-product-types">N</xsl:with-param>
		   					<xsl:with-param name="product_types">FT:<xsl:value-of select="sub_product_code"/></xsl:with-param>
		   					<xsl:with-param name="recurring-displaymode">
		   						<xsl:choose>
							      	<xsl:when test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS']">edit</xsl:when>
							      	<xsl:otherwise>none</xsl:otherwise>
							     </xsl:choose>
		   					</xsl:with-param>
		   					<xsl:with-param name="recurring-disabled">
							     <xsl:choose>
							      	<xsl:when test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS'] ">N</xsl:when>
							      	<xsl:otherwise>Y</xsl:otherwise>
							     </xsl:choose>
			    			 </xsl:with-param> 	
     						</xsl:call-template>
	      			</xsl:when>
	      			<xsl:otherwise>
		      			<xsl:call-template name="intermediary-section"> 	      		      				
	     					<xsl:with-param name="transfer-from-label">XSL_DEBIT_ACCOUNT</xsl:with-param>     					
		 					<xsl:with-param name="show-product-types">N</xsl:with-param>
		   					<xsl:with-param name="product_types">FT:<xsl:value-of select="sub_product_code"/></xsl:with-param> 	
		   					<xsl:with-param name="recurring-disabled">
							     <xsl:choose>
							      	<xsl:when test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS']">N</xsl:when>
							      	<xsl:otherwise>Y</xsl:otherwise>
							     </xsl:choose>
						     </xsl:with-param>
     					<xsl:with-param name="bank-abbv-name"><xsl:value-of select="customer_payee/customer_payee_record/bank_abbv_name"/></xsl:with-param>
     					</xsl:call-template>
	      			</xsl:otherwise>
		      	</xsl:choose>
		      	 <xsl:if test="$displaymode='edit'">
		      	  <div id="BILLP_DISCLAIMER" class="bpddaDisclaimer" style="display:none;">
      			   <xsl:call-template name="simple-disclaimer">
      				<xsl:with-param name="label">XSL_<xsl:value-of select="sub_product_code"/>_DISCLAIMER</xsl:with-param>
     			   </xsl:call-template>	      				
		      	  </div>
		      	  <div id="DDA_DISCLAIMER" class="bpddaDisclaimer" style="display:none;">
      			   <xsl:call-template name="simple-disclaimer">
      				<xsl:with-param name="label">XSL_<xsl:value-of select="sub_product_code"/>_DISCLAIMER</xsl:with-param>
     			   </xsl:call-template>	      				
		      	  </div>
	      		</xsl:if>
	      	</xsl:if>	
	      	
      		</div>
	      	<div id="content2">
      			<!--  Display common menu. -->
      			<xsl:call-template name="menu">
      				<xsl:with-param name="show-template">N</xsl:with-param>
      			    <xsl:with-param name="show-return">Y</xsl:with-param>   	     	
      			</xsl:call-template>
      				<xsl:call-template name="server-message">
				 		<xsl:with-param name="name">server_message</xsl:with-param>
				 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
				 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
		      		<xsl:call-template name="general-details" >
		      			<xsl:with-param name="transfer-from-label">XSL_DEBIT_ACCOUNT</xsl:with-param>
		      			<xsl:with-param name="show-template-id">N</xsl:with-param>
		      		</xsl:call-template>		      		
		      		<xsl:call-template name="recurring_content">
		      			<xsl:with-param name="override-displaymode"><xsl:value-of select="$displaymode"/></xsl:with-param>
		      		</xsl:call-template>	
		      		
		      		<!-- Bill Payment specific -->
		      		<xsl:if test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS']">
			      		<div id="recurringContent">
<!--				      		<xsl:call-template name="recurring-details" />-->
				      	</div>				    		      	
			      	</xsl:if>
			      	
			      	<!-- transaction details -->
				   		<xsl:call-template name="fieldset-wrapper">
					     	<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
					     	<xsl:with-param name="content">
					     	
					     		<xsl:call-template name="payee-details"/>
						     	<xsl:choose>
									<xsl:when test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS']">
			      						<xsl:call-template name="tnx-details-billPayment">
			      							<xsl:with-param name="isBankReporting">N</xsl:with-param>
			      						</xsl:call-template>	
			      					</xsl:when>
			      					<xsl:otherwise>
			      						<xsl:call-template name="tnx-details-dda"/>	
			      					</xsl:otherwise>
			      			 	</xsl:choose>
							</xsl:with-param>
			      		</xsl:call-template>
		      		 
		      		<xsl:call-template name="transaction-remarks-details" />
		      		<!-- comments for return -->
     				<xsl:call-template name="comments-for-return">
	  					<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   					<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 				</xsl:call-template>
	     		
	     		<!-- Display common menu, this time outside the form -->
	    		<xsl:call-template name="menu">
	    			<xsl:with-param name="show-template">N</xsl:with-param>
	     			<xsl:with-param name="second-menu">Y</xsl:with-param>
	     		   <xsl:with-param name="show-return">Y</xsl:with-param>     
	    		</xsl:call-template>
	    	</div>
 
	  </xsl:with-param>
	 </xsl:call-template>	 
	 
<!--	 <xsl:call-template name="attachments-file-dojo"/>-->

   <xsl:call-template name="realform"/>
    
<!--   <xsl:call-template name="menu">-->
<!--    <xsl:with-param name="second-menu">Y</xsl:with-param>-->
<!--   </xsl:call-template>-->
  </div>
     
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/> 
 </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 <xsl:template name="hidden-fields-bpdda">
 <!-- Hidden Fields: BP and DDA specific start-->
      <div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">customer_payee_id</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/customer_payee_id"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank</xsl:with-param>
       			<xsl:with-param name="value" select="/ft_tnx_record/customer_payee/customer_payee_record/bank_abbv_name"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/bank_abbv_name"/>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bank_abbv_name</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/bank_abbv_name"/>
			</xsl:call-template>			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">master_payee_id</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/master_payee_id"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">customer_bank</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/bank_abbv_name"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">payee_type</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/payee_type"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">payee_code</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/payee_code"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">payee_name</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/payee_name"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">service_name</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/service_name"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">service_code</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/service_code"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">description</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/description"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">registered_end_date</xsl:with-param>
       			<xsl:with-param name="value" select="customer_payee/customer_payee_record/end_date"/>
			</xsl:call-template>
				<!-- BP and DDA specific end-->
		</div>	
 
 </xsl:template>	  	
	 
	
 <!--
   Real form for Remittance
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
       <xsl:with-param name="name">option</xsl:with-param>       
       <xsl:with-param name="value" select="sub_product_code"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">productcode</xsl:with-param>
	    <xsl:with-param name="value" select="$product-code"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">subproductcode</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
   	  </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
      <xsl:if test="$displaymode='view'">
		  <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">applicant_act_no</xsl:with-param>
	    	<xsl:with-param name="value"><xsl:value-of select="applicant_act_no"/></xsl:with-param>
		  </xsl:call-template>
	  </xsl:if>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>