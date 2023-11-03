<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for Update DDA

 Fund Transfer (FT) Form, Bank Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      13/10/11
author:    Lithwin
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
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        exclude-result-prefixes="xmlRender localization ftProcessing">
       
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

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" /> 
  <xsl:include href="./common/ft_common.xsl" />
  <xsl:include href="./common/bp_dda_common.xsl" />
  <xsl:include href="../../cash/xsl/common/remittance_common.xsl" />
  
  
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
     <xsl:when test="tnx_type_code[.='15']">
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
   
		      		<!--
  	 					General Details Fieldset. 
   					-->
			      	<xsl:call-template name="fieldset-wrapper">   		
			    		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			    		<xsl:with-param name="content">
							    <xsl:call-template name="column-container">
							 	<xsl:with-param name="content">
							 	<!-- column 1 -->		 
							 	<xsl:call-template name="column-wrapper">
							   	<xsl:with-param name="content"> 
						   		 
						   		 <div>
			    			<!-- Display Entity -->
							<xsl:call-template name="input-field">
						     	<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
						     	<xsl:with-param name="id">entity_view</xsl:with-param>
						     	<xsl:with-param name="value" select="entity" />
				    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<!-- Display Debit Account -->
							<xsl:call-template name="input-field">
						     	<xsl:with-param name="label">XSL_DEBIT_ACCOUNT</xsl:with-param>
						     	<xsl:with-param name="id">transfer_from_view</xsl:with-param>
						     	<xsl:with-param name="value" select="transfer_from" />
				    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<!-- Display Customer reference -->
							<xsl:call-template name="input-field">
					  			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>			
					  			<xsl:with-param name="id">customer_reference_view</xsl:with-param>
					  			<xsl:with-param name="value" select="customer_reference" />
				    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					 		</xsl:call-template>
					 		<!-- Action -->
					 		<xsl:call-template name="select-field">
						      	<xsl:with-param name="label">ACTION_USER_LABEL</xsl:with-param>
						      	<xsl:with-param name="name">action</xsl:with-param>
						      	<xsl:with-param name="required">Y</xsl:with-param>
        						<xsl:with-param name="fieldsize">small</xsl:with-param>
						      	<xsl:with-param name="options">			       		
									<xsl:choose>
										<xsl:when test="$displaymode='edit'">
										    <option value="MODIFY">
										   		<xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATE_MODIFY')"/>
     										</option>
										    <option value="CANCEL">
										   		<xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATE_CANCEL')"/>
     										</option>
									   </xsl:when>
									   <xsl:otherwise>
									    	<xsl:choose>
									     		 <xsl:when test="action[. = 'MODIFY']">
									     		 	<xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATE_MODIFY')"/>
									     		 </xsl:when>
											     <xsl:when test="action[. = 'CANCEL']">
									     		 	<xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATE_CANCEL')"/>
									     		 </xsl:when>							     
											</xsl:choose>
									   </xsl:otherwise>
									</xsl:choose>
						     	</xsl:with-param>
						   	</xsl:call-template>
						   	
						   		</div>
						   		</xsl:with-param>
						   		</xsl:call-template>
						   		<!-- column 2 -->		 
						  		<xsl:call-template name="column-wrapper">
						   		<xsl:with-param name="content">
						   		
						   		<div>
							<!-- Display Bank -->
																   
						    <!-- Display System ID. -->
						     <xsl:call-template name="input-field">
						      	<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
						     	<xsl:with-param name="id">ref_id_view</xsl:with-param>
						     	<xsl:with-param name="value" select="ref_id" />
						     	 <xsl:with-param name="override-displaymode">view</xsl:with-param>
						     </xsl:call-template>
						    <!-- Display Issue Date -->
						     <xsl:call-template name="input-field">
						      	<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
						     	<xsl:with-param name="id">appl_date_view</xsl:with-param>
						     	<xsl:with-param name="value" select="appl_date" />
						     	 <xsl:with-param name="override-displaymode">view</xsl:with-param>
						     </xsl:call-template>
						    <!-- Display Bank Reference -->
						     <xsl:if test="bo_ref_id[.!='']">
							     <xsl:call-template name="input-field">
							      	<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
							     	<xsl:with-param name="id">bo_ref_id_view</xsl:with-param>
							     	<xsl:with-param name="value" select="bo_ref_id" />
							     	 <xsl:with-param name="override-displaymode">view</xsl:with-param>
							     </xsl:call-template>
						     </xsl:if>
							     </div>
							     </xsl:with-param>
							     </xsl:call-template>
							     </xsl:with-param>
							     </xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					
			      	<!-- transaction details -->
			      	
		      		 <xsl:call-template name="tnx-update-details"/>
		      		 <!--
  					 Transaction Remarks Details Fieldset. 
   					-->		      		
			      	<!--<xsl:call-template name="transaction-remarks-details" />
	     		
	  --></xsl:with-param>
	 </xsl:call-template>
  </div>
     
<!-- Display common menu, this time outside the form -->
<xsl:call-template name="menu">
		<xsl:with-param name="show-template">N</xsl:with-param>
		<xsl:with-param name="second-menu">Y</xsl:with-param>
</xsl:call-template>
</div>
  <!-- Table of Contents -->
  <xsl:call-template name="toc"/>
  
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/> 
 </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
	
	<xsl:template name="tnx-update-details">
		<xsl:param name="tnx-record" select="org_previous_file/ft_tnx_record"/>
		<div id="dda-update-amount" class="widgetContainer">
				   		<xsl:call-template name="fieldset-wrapper">
					     	<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>	
					     	<xsl:with-param name="content">					     		
							     <xsl:variable name="org-amt-name">org_ft_amt</xsl:variable>
							     <xsl:variable name="product-amt-name">ft_amt</xsl:variable>
							     <xsl:variable name="org-amt-val" select="$tnx-record//*[name()=$product-amt-name]"/>
				    			 <xsl:variable name="cur-code-name">ft_cur_code</xsl:variable>
				 				
				 				<xsl:call-template name="column-container">
							 	<xsl:with-param name="content">
							 	<!-- column 1 -->		 
							 	<xsl:call-template name="column-wrapper">
							   	<xsl:with-param name="content"> 
							   	
					 				<!-- display Original Limit Amount -->
					 				
					 				 <xsl:call-template name="currency-field">
									      <xsl:with-param name="label">XSL_ORIGINAL_LIMIT_AMOUNT</xsl:with-param>
									      <xsl:with-param name="product-code">ft</xsl:with-param>
									      <xsl:with-param name="override-amt-name"><xsl:value-of select="$org-amt-name"/></xsl:with-param>
									      <xsl:with-param name="override-amt-value"><xsl:value-of select="$org-amt-val"/></xsl:with-param>
									      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
									      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
								     </xsl:call-template>
					 				
					 				 <xsl:if test="$displaymode='edit'">
									      <xsl:call-template name="hidden-field"> 
									       		<xsl:with-param name="name"><xsl:value-of select="$cur-code-name"/></xsl:with-param>
									      </xsl:call-template>
								     </xsl:if>
								     
					 				</xsl:with-param>
					 				</xsl:call-template>
					 				<!-- column 2 -->		 
								 	<xsl:call-template name="column-wrapper">
								   	<xsl:with-param name="content"> 
								   	
					 				<!-- New Limit Amount -->			 				
					 				
								     <xsl:call-template name="currency-field">
									      <xsl:with-param name="label">XSL_NEW_LIMIT_AMOUNT</xsl:with-param>
									      <xsl:with-param name="product-code">ft</xsl:with-param>
									      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
									      <xsl:with-param name="required">Y</xsl:with-param>
								     </xsl:call-template>
								     
							    </xsl:with-param>
				 				</xsl:call-template>
				 				</xsl:with-param>
				 				</xsl:call-template>
			      			</xsl:with-param>
			      		</xsl:call-template>
			      	</div>
	</xsl:template>
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.cash.create_bp_dda</xsl:with-param>
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
	   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. --><!--
  <xsl:template name="hidden-fields">
	<xsl:call-template name="common-hidden-fields">
		<xsl:with-param name="additional-fields">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiaryName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicant_reference</xsl:with-param>
				<xsl:with-param name="id">applicant_reference_hidden</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">deal_type</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_tnx_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">request_number</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_ref_id</xsl:with-param>
			</xsl:call-template>
			 Begin to delete ? 
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicantName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">debitAccountNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">debitAccountName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">creditAccountNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">creditAccountName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">executionDate</xsl:with-param>
			</xsl:call-template>
			 End to delete ? 
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">transactionNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">rate</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeAccount</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeAmt</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeCurCode</xsl:with-param>
			</xsl:call-template>	
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_cur_code</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_amt</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>-->

	
 <!--
   Real form for Remittance
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
<!--    <xsl:with-param name="method">POST</xsl:with-param>-->
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
      </xsl:call-template> <xsl:call-template name="hidden-field">
<!--       <xsl:with-param name="name">option</xsl:with-param>-->
<!--       <xsl:with-param name="value"/>-->
      </xsl:call-template>      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">03</xsl:with-param>
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
</xsl:stylesheet>