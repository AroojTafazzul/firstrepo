<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Secure Email (SE) Form, Bank Side.

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
  <xsl:param name="product-code">SE</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="newPaymentFromScratch">false</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" /> 

 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="se_tnx_record"/>
  </xsl:template>
 
 <!-- 
   FT TNX FORM TEMPLATE.
  -->
  <xsl:template match="se_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
	<script>
			dojo.ready(function(){		
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
			productCode: '<xsl:value-of select="$product-code"/>',
			mode: '<xsl:value-of select="$mode"/>',			
			subProductCode : '<xsl:value-of select="sub_product_code"/>',
			newPaymentFromScratch : '<xsl:value-of select="$newPaymentFromScratch"/>'
			});
			
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
     </div>
     <xsl:call-template name="js-imports"/>    
    
     
     <xsl:call-template name="transaction-details-link"/>
     
     <div id="transactionDetails">
     <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         
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
		    			<xsl:with-param name="value" select="transfer_from" />
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
                	<xsl:call-template name="cheque-details-bank" /> 
                	 <xsl:call-template name="common-hidden-fields"/>
       </xsl:with-param>
       </xsl:call-template>
       
</div>
         
         <!-- Disclaimer Notice -->
         <xsl:call-template name="disclaimer"/>
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- 
    <xsl:choose>
     
    -->
      <!-- Link to display transaction contents -->
      </xsl:template>
      
    <xsl:template name="cheque-details-bank">
  		<xsl:call-template name="fieldset-wrapper">
    		<xsl:with-param name="legend">XSL_HEADER_CHEQUE_DETAILS</xsl:with-param>
    		<xsl:with-param name="content">
    			<div>    			
				  	<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
				     	<xsl:with-param name="id">cheque_entity_view</xsl:with-param>	
				     	<xsl:with-param name="disabled">Y</xsl:with-param>	
						<xsl:with-param name="fieldsize">small</xsl:with-param>
			   			<xsl:with-param name="value" select="entity" />
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>	
				    			   
			    	<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">XSL_SE_ACT_NO_LABEL</xsl:with-param>			
					    <xsl:with-param name="name">applicant</xsl:with-param>
					    <xsl:with-param name="entity-field">entity</xsl:with-param>
					    <xsl:with-param name="dr-cr">debit</xsl:with-param>
					    <xsl:with-param name="show-product-types">N</xsl:with-param>
					   <xsl:with-param name="product_types">SE:<xsl:value-of select="sub_product_code"/></xsl:with-param> 
					   <xsl:with-param name="required">Y</xsl:with-param>				
					   <xsl:with-param name="value"><xsl:value-of select="applicant_act_name"/></xsl:with-param>
					   <xsl:with-param name="override-displaymode">view</xsl:with-param>	   
			    	</xsl:call-template>	
			    	<xsl:choose>
			    	<xsl:when test="sub_product_code[.='COCQS']">
				    	<xsl:call-template name="input-field">
					      	<xsl:with-param name="label">XSL_CHEQUEDETAILS_CHEQUE_TYPE</xsl:with-param>
					      	<xsl:with-param name="name">cheque_type</xsl:with-param>
					      	<xsl:with-param name="required">Y</xsl:with-param>
					      	<xsl:with-param name="fieldsize">x-medium</xsl:with-param>
					      	<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N115', cheque_type)"/></xsl:with-param>
					      <!-- 	<xsl:with-param name="options"><xsl:call-template name="cheque_type_options"/></xsl:with-param> -->
					      	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
						</xsl:call-template>
						<div class="field">
							<label><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CHEQUE_NUMBER')"/></label>
							<div class="inlineBlock chequeServicesChequeNumber">
								<xsl:call-template name="input-field">
						      		<xsl:with-param name="label">XSL_GENERALDETAILS_CHEQUE_NUMBER_FROM</xsl:with-param>
						      		<xsl:with-param name="name">cheque_number_from</xsl:with-param>
						      		<xsl:with-param name="size">6</xsl:with-param>
						      		<xsl:with-param name="maxsize">6</xsl:with-param>
						      		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						      		<xsl:with-param name="type">number</xsl:with-param>
						      		<xsl:with-param name="required">Y</xsl:with-param>
						      		<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
									<xsl:with-param name="override-constraints">{min:0,pattern: '##'}</xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>	
								</xsl:call-template>
								<xsl:call-template name="input-field">
						      		<xsl:with-param name="label">XSL_GENERALDETAILS_CHEQUE_NUMBER_TO</xsl:with-param>
						      		<xsl:with-param name="name">cheque_number_to</xsl:with-param>
						      		<xsl:with-param name="size">6</xsl:with-param>
						      		<xsl:with-param name="maxsize">6</xsl:with-param>
						      		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						      		<xsl:with-param name="type">number</xsl:with-param>
						      		<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
						      		<xsl:with-param name="override-constraints">{min:0,pattern: '##'}</xsl:with-param>
						      		<xsl:with-param name="override-displaymode">view</xsl:with-param>	
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
							     	<xsl:with-param name="name">cheque_number_range</xsl:with-param>
							    </xsl:call-template>
							</div>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
			      		<xsl:with-param name="label">XSL_GENERALDETAILS_NUMBER_OF_CHEQUE_BOOKS</xsl:with-param>
			      		<xsl:with-param name="name">no_of_cheque_books</xsl:with-param>
			      		<xsl:with-param name="size">2</xsl:with-param>
			      		<xsl:with-param name="maxsize">2</xsl:with-param>
			      		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
			      		<xsl:with-param name="type">number</xsl:with-param>
			      		<xsl:with-param name="required">Y</xsl:with-param>
			      		<xsl:with-param name="override-displaymode">view</xsl:with-param>	
						</xsl:call-template>
						<xsl:call-template name="input-field">
			      		<xsl:with-param name="label">XSL_GENERALDETAILS_DELIVERY_MODE</xsl:with-param>
			      		<xsl:with-param name="name">adv_send_mode</xsl:with-param>
			      		<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N018', adv_send_mode)"/> </xsl:with-param>
			      		<xsl:with-param name="override-displaymode">view</xsl:with-param>			      		
			      		</xsl:call-template>
			      		<div id="delivery_mode_08_div">
							<xsl:call-template name="input-field">
						      	 <xsl:with-param name="label">XSL_BRANCH_CODE</xsl:with-param>
							     <xsl:with-param name="name">collecting_bank_code</xsl:with-param>
							     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>	                     	
			                     <xsl:with-param name="override-displaymode">view</xsl:with-param>	     			  
							 </xsl:call-template>	
							 <xsl:call-template name="input-field">
							     <xsl:with-param name="name">collecting_branch_code</xsl:with-param>
							     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
			                     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			                 </xsl:call-template>	   				    		
							<xsl:call-template name="input-field">
				 				 <xsl:with-param name="label">XSL_GENERALDETAILS_COLLECTORS_NAME</xsl:with-param>
							     <xsl:with-param name="name">collectors_name</xsl:with-param>
							     <xsl:with-param name="override-displaymode">view</xsl:with-param>							     		    
						    </xsl:call-template> 
						    <xsl:call-template name="input-field">
				 				 <xsl:with-param name="label">XSL_GENERALDETAILS_COLLECTORS_ID</xsl:with-param>
							     <xsl:with-param name="name">collectors_id</xsl:with-param>	
							     <xsl:with-param name="override-displaymode">view</xsl:with-param>				     					     
						    </xsl:call-template>
						</div>
					</xsl:otherwise>
					</xsl:choose>	   
			   </div>
			   
   		<xsl:call-template name="menu">
			     <xsl:with-param name="show-template">N</xsl:with-param>
			     <xsl:with-param name="second-menu">Y</xsl:with-param>
        </xsl:call-template>
			   </xsl:with-param>
   		</xsl:call-template>
   		
   		
   		</xsl:template>   		 

   		  <xsl:template name="cheque_type_options">
	  	<xsl:for-each select="cheque_types/cheque_type">
	     	<xsl:variable name="cheque_type_value"><xsl:value-of select="."/></xsl:variable>
	     	<option>
	     		<xsl:attribute name="value"><xsl:value-of select="$cheque_type_value"/></xsl:attribute>     		
	     	    <xsl:value-of select="localization:getDecode($language, 'N115', $cheque_type_value)"/> 
	     	</option>
	    </xsl:for-each>
  </xsl:template>  
  
  <xsl:template name="delivery_mode_options">
	  	<xsl:for-each select="delivery_mode_options/delivery_mode_option">
	     	<xsl:variable name="delivery_mode_value"><xsl:value-of select="."/></xsl:variable>
	     	<option>
	     		<xsl:attribute name="value"><xsl:value-of select="$delivery_mode_value"/></xsl:attribute>     		
	     	    <xsl:value-of select="localization:getDecode($language, 'N018', $delivery_mode_value)"/> 
	     	</option>
	    </xsl:for-each>
  </xsl:template>
  
  
  <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
  
  <xsl:with-param name="binding">misys.binding.bank.report_cs</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>