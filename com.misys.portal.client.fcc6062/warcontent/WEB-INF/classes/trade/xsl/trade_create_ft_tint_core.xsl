<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) Form, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
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
        xmlns:xmlCrossRef="xalan://com.misys.portal.product.util.CrossReferenceTool"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="xmlRender localization xmlCrossRef ftProcessing securityCheck defaultresource">
       
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeFundTransferScreen</xsl:param>
  <xsl:param name="orderingAccountReadOnly">N</xsl:param>
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../cash/xsl/cash_common.xsl" />
  <xsl:include href="../../cash/xsl/request_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ft_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">

   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>

	<!-- Form #0 : Main Form -->
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name" select="$main-form-name"/>
		<xsl:with-param name="validating">Y</xsl:with-param>
		<xsl:with-param name="content">
			<!--  Display common menu. -->
			<xsl:call-template name="menu">
			<xsl:with-param name="show-return">Y</xsl:with-param>
			</xsl:call-template>
			
			<!-- Disclaimer Notice -->
			<xsl:call-template name="disclaimer"/>
			
			<xsl:call-template name="hidden-fields"/>
			<xsl:apply-templates select="cross_references" mode="hidden_form"/>
			<xsl:call-template name="general-details" />
			 <!-- Reauthentication -->
		      		<xsl:call-template name="reauthentication"/>
			<!-- <xsl:choose>
				<xsl:when test="$displaymode='view'">
					<xsl:call-template name="review-fields"/>
				</xsl:when>
				<xsl:otherwise> -->
					<xsl:call-template name="ft-transfer-details"/>
					
					<xsl:call-template name="waiting-Dialog"/>
					<xsl:call-template name="loading-Dialog"/>
					<xsl:call-template name="account-popup">
						<xsl:with-param name="id">orderingAccount</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="(securityCheck:hasPermission($rundata,'ls_access') and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true')">
   	  <xsl:call-template name="linked-ls-declaration"/>
	  <xsl:call-template name="linked-licenses"/>
        </xsl:if>
					<!-- Bank details -->
					<xsl:call-template name="bank-details" />
					 
				  	<!-- Bank Instructions -->
				  	<xsl:call-template name="bank-instructions">
				  		<xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
				  		<xsl:with-param name="send-mode-displayed">N</xsl:with-param>
				  	</xsl:call-template> 
					 
					
				    <!-- comments for return -->
				    <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
     					<xsl:call-template name="comments-for-return">
	  						<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   						<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 					</xsl:call-template>
   	 					</xsl:if>
				<!--  </xsl:otherwise>
			 </xsl:choose> -->
		 </xsl:with-param>
	</xsl:call-template>
	<!-- File Upload --> 
					<xsl:call-template name="attachments-file-dojo">
				    	<xsl:with-param name="hidden">
				    		<xsl:choose>
				    			<xsl:when test="securityCheck:hasPermission($rundata, 'ft_file_upload')">N</xsl:when>
				    			<xsl:otherwise>Y</xsl:otherwise>
				    		</xsl:choose>
				    	</xsl:with-param>
				    </xsl:call-template>

   <xsl:call-template name="realform"/>
    
   <xsl:call-template name="menu">
    <xsl:with-param name="second-menu">Y</xsl:with-param>
    <xsl:with-param name="show-return">Y</xsl:with-param>
   </xsl:call-template>
  </div>
     
  <!-- Table of Contents -->
  <xsl:call-template name="toc"/>
  
  <!--  Collaboration Window -->     
        
  <xsl:call-template name="collaboration">
   <xsl:with-param name="editable">true</xsl:with-param>
   <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
   <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
   <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
   <xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
  </xsl:call-template>
 

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
   <xsl:with-param name="binding">misys.binding.trade.create_ft_tint</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
	<xsl:call-template name="common-hidden-fields">
		<xsl:with-param name="additional-fields">
		 
     <xsl:if test="$displaymode='view'">
      <!-- This field is sent in the unsigned view -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">iss_date</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="iss_date"/> </xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">ft_cur_code</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/> </xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">ft_amt</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="ft_amt"/> </xsl:with-param>
	  </xsl:call-template>
     </xsl:if>

			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiaryName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicant_reference_hidden</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">deal_type</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_reference_hidden</xsl:with-param>
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
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">transactionNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">rate</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeAccount</xsl:with-param>
			</xsl:call-template> 
			<!-- <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fee_act_no</xsl:with-param>
			</xsl:call-template> -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeAmt</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeCurCode</xsl:with-param>
			</xsl:call-template>
			
			
			<!--  <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_cur_code</xsl:with-param>
			</xsl:call-template>  -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_amt</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_country</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_email</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">vcom_type</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">vcom_reference</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">po_ref_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">invoice_date</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>

 <!--
   FT General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">
      <!-- Common general details. -->
      <xsl:call-template name="ft-general-details">
      	<xsl:with-param name="show-template-id">Y</xsl:with-param>
      	<xsl:with-param name="override-cutomer-reference-id">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
      </xsl:call-template>
      
      <!-- Initiation From -->
      <xsl:if test="cross_references/cross_reference/type_code[.='02']">
       <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
 	<!--20170728_01 starts added for BO ref in review pop. Syncing with PDF  -->
      <xsl:if test="sub_product_code[.!='TRTD'] and bo_ref_id[.!=''] and $displaymode='view' and (tnx_id)">
			 	<xsl:call-template name="row-wrapper">
				 	<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
		            <xsl:with-param name="content"><div class="content">		             
		     		      <xsl:value-of select="bo_ref_id"/>
		            </div></xsl:with-param>
     				 </xsl:call-template>
     </xsl:if>
    <!--20170728_01 ends  -->
      <!-- Applicant Details -->
      <div class="clear"></div>
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
       
        <xsl:call-template name="address">
         <xsl:with-param name="show-entity">Y</xsl:with-param>
         <xsl:with-param name="prefix">applicant</xsl:with-param>
        </xsl:call-template>
        
        <!--
         If we have to, we show the reference field for applicants. This is
         specific to this form.
         -->
        <!-- <xsl:if test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
        <xsl:variable name="ref"><xsl:value-of select="applicant_reference"/></xsl:variable>
         <xsl:call-template name="input-field">
          <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
          <xsl:with-param name="name">applicant_reference</xsl:with-param>
          <xsl:with-param name="value">
          		<xsl:value-of select="utils:decryptApplicantReference($ref)"/>
          </xsl:with-param>
          <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
         </xsl:call-template>
        </xsl:if> -->
        <xsl:choose>
	      	<xsl:when test="$displaymode = 'edit'">
				<xsl:call-template name="row-wrapper">
		           <xsl:with-param name="required">Y</xsl:with-param>
		           <xsl:with-param name="label">XSL_PARTIESDETAILS_ORDERING_ACT_NO</xsl:with-param>
		           <xsl:with-param name="content">
		                 <xsl:call-template name="input-field">
		                     <xsl:with-param name="name">applicant_act_cur_code</xsl:with-param>   
		                     <xsl:with-param name="maxsize">3</xsl:with-param>
		                     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
		                     <xsl:with-param name="required">Y</xsl:with-param>
		                     <xsl:with-param name="readonly"><xsl:if test="$orderingAccountReadOnly='true'">Y</xsl:if></xsl:with-param>
		                     <xsl:with-param name="uppercase">Y</xsl:with-param>
		                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
		                 </xsl:call-template>     
					     <xsl:call-template name="input-field">
						     <xsl:with-param name="name">applicant_act_no</xsl:with-param>
						     <xsl:with-param name="maxsize">34</xsl:with-param>
						     <xsl:with-param name="button-type">transfer-to-account</xsl:with-param>
		                     <xsl:with-param name="readonly"><xsl:if test="$orderingAccountReadOnly='true'">Y</xsl:if></xsl:with-param>					     
						     <xsl:with-param name="required">Y</xsl:with-param>
					         <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
						 </xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
		 	</xsl:when>
			<xsl:otherwise>
			<xsl:if test="applicant_act_cur_code[.!=''] or applicant_act_no[.!='']">
			 	<xsl:call-template name="input-field">
				 	<xsl:with-param name="label">XSL_PARTIESDETAILS_ORDERING_ACT_NO</xsl:with-param>
		            <xsl:with-param name="name">applicant_act_view</xsl:with-param>   
		            <xsl:with-param name="value"><xsl:value-of select="applicant_act_cur_code"/>&nbsp;<xsl:value-of select="applicant_act_no"/> </xsl:with-param>
	            </xsl:call-template>
	        </xsl:if>
	            <xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">applicant_act_cur_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">applicant_act_no</xsl:with-param>
				</xsl:call-template>
			 </xsl:otherwise>
	  	</xsl:choose>
      
      		<!-- <xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_PARTIESDETAILS_ACT_CUR_CODE</xsl:with-param>
				<xsl:with-param name="product-code">applicant_act</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
				<xsl:with-param name="show-button">Y</xsl:with-param>
				<xsl:with-param name="disabled">N</xsl:with-param>
			</xsl:call-template> -->
       
       <!-- <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="legend">XSL_FT_BENEFICIARY_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						        <xsl:call-template name="address">
						         <xsl:with-param name="show-entity">N</xsl:with-param>
						         <xsl:with-param name="prefix">counterparty</xsl:with-param>
						        </xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">REFERENCE_LABEL</xsl:with-param>
							<xsl:with-param name="name">counterparty_reference</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="fieldsize">medium</xsl:with-param>
						</xsl:call-template>
						
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_COUNTERPARTY_IBAN_BIC</xsl:with-param>
								<xsl:with-param name="name">counterparty_act_iso_code</xsl:with-param>
								<xsl:with-param name="size">11</xsl:with-param>
								<xsl:with-param name="maxsize">11</xsl:with-param>
								<xsl:with-param name="fieldsize">medium</xsl:with-param>
							</xsl:call-template>	
							
							<xsl:call-template name="input-field">
								<xsl:with-param name="label"></xsl:with-param>
								<xsl:with-param name="name">counterparty_act_no</xsl:with-param>
								<xsl:with-param name="size">35</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="fieldsize">medium</xsl:with-param>
							</xsl:call-template>			
							
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_PARTIESDETAILS_ACT_CUR_CODE</xsl:with-param>
							<xsl:with-param name="product-code">counterparty_act</xsl:with-param>
							<xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
							<xsl:with-param name="show-button">Y</xsl:with-param>
							<xsl:with-param name="disabled">N</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template> -->
				
       </xsl:with-param>
      </xsl:call-template>
      
      <!-- 
      		Beneficiary Details.
      		Replace older Beneficiary Details field
       -->
     
      
     </div>
    </xsl:with-param>
   </xsl:call-template>
   <!-- Beneficiary Details : Hiding this field for the moment -->
   <!-- Adding beneficiary account is made under Applicant details -->
<!--   <xsl:call-template name="attachments-counterparties"/>-->
  </xsl:template>
  
  
   <!--
   General Details fields, common to forms on the customer side.
   
   System ID, Template ID, Customer Reference, Application Date.
   -->
  <xsl:template name="ft-general-details">
   <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
   <xsl:param name="swift-validate">Y</xsl:param>
   
   <xsl:param name="override-cutomer-reference-id">XSL_GENERALDETAILS_CUST_REF_ID</xsl:param>
   
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">sub_product_code</xsl:with-param>
    <xsl:with-param name="value" select="sub_product_code"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">appl_date</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">product_code</xsl:with-param>
    <xsl:with-param name="value">FT</xsl:with-param>
   </xsl:call-template>

   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
    <xsl:with-param name="id">ref_id_view</xsl:with-param>
   </xsl:call-template>
   
  
   <!-- Bank Reference -->
   <!-- Shown in consolidated view -->
   <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id" />
     <xsl:with-param name="swift-validate" select="$swift-validate"/>
    </xsl:call-template>
   </xsl:if>
   
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="cross_references">
    <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
   </xsl:if>
    
   <!-- Template ID. -->
   <xsl:if test="$show-template-id='Y'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="name">template_id</xsl:with-param>
     <xsl:with-param name="size">15</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate" select="$swift-validate"/>
    </xsl:call-template>
   </xsl:if>
    
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label"><xsl:value-of select="$override-cutomer-reference-id"/></xsl:with-param>
	     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	     <xsl:with-param name="size">20</xsl:with-param>
	     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
	     <xsl:with-param name="swift-validate" select="$swift-validate"/>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
   
   <xsl:if test="po_cust_ref_id">
   	   <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_PO_ISSUER_REF_ID</xsl:with-param>
	     <xsl:with-param name="value" select="po_cust_ref_id" />
	     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     <xsl:with-param name="content-after" >
	     <xsl:choose>
	     	<xsl:when test="po_ref_id">
	      	<a name="anchor_view_full_details" href="javascript:void(0)">
				<xsl:attribute name="onclick">misys.popup.showReporting('DETAILS', 'PO', '<xsl:value-of select="po_ref_id"/>');return false;</xsl:attribute>
				<img border="0" src="/content/images/preview.png" name="img_view_full_details">
					<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_TRANSACTION_DETAILS')"/></xsl:attribute>
				</img>
			</a>
			</xsl:when>
		</xsl:choose>
	     </xsl:with-param> 
	    </xsl:call-template>

     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">po_cust_ref_id</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="po_cust_ref_id"/></xsl:with-param> 
     </xsl:call-template>	 
     
  </xsl:if>
  
  <xsl:if test="invoice_cust_ref_id">
     <xsl:call-template name="input-field">
     	<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_REF_ID</xsl:with-param>
     	<xsl:with-param name="value" select="invoice_cust_ref_id" />
     	<xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">invoice_cust_ref_id</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="invoice_cust_ref_id"/></xsl:with-param> 
     </xsl:call-template>
  </xsl:if>

    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
      <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
  	<!-- Execution Date. -->
  	<!-- removed the code for holiday cut off check (i.e. business-date-field) as it is not yet implemented for multi bank scenario -->
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:with-param>
		<xsl:with-param name="name">iss_date</xsl:with-param>
		<xsl:with-param name="size">10</xsl:with-param>
		<xsl:with-param name="maxsize">10</xsl:with-param>
		<xsl:with-param name="fieldsize">small</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>
		<xsl:with-param name="type">date</xsl:with-param>
	</xsl:call-template>

     <!-- <xsl:call-template name="input-field">
     	<xsl:with-param name="label">FT_TYPE</xsl:with-param>
     	<xsl:with-param name="value" select="localization:getDecode($language, 'N950', vcom_type)" />
     	<xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template> -->		
  </xsl:template>
  
  <!-- 
   FT Transfer Details
   -->
  <xsl:template name="ft-transfer-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		
			<!-- Ordering details -->
			<xsl:if test="$displaymode='edit'">
				<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.customerReferences = {};
						<xsl:apply-templates select="avail_main_banks/bank"	mode="customer_references" />
					});
				</script>
			</xsl:if>

			<br/>
		<!-- Beneficiary Details -->
			<!-- <xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TRANSFER_TO</xsl:with-param>
				<xsl:with-param name="name">beneficiary_account</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="button-type">account</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template> -->
			<xsl:call-template name="row-wrapper">
                           <xsl:with-param name="required"><xsl:if test="$displaymode = 'edit'">Y</xsl:if></xsl:with-param>
                           <xsl:with-param name="label">XSL_BENEFICIARY_NAME_DESCRIPTION</xsl:with-param>
                           <xsl:with-param name="content">
                           <xsl:if test="$displaymode = 'edit'">
                                 <xsl:call-template name="input-field">
                                     <xsl:with-param name="name">counterparty_cur_code</xsl:with-param>   
                                     <xsl:with-param name="maxsize">3</xsl:with-param>
                                     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
                                     <xsl:with-param name="readonly">Y</xsl:with-param> 
                                     <xsl:with-param name="required">Y</xsl:with-param> 
                                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
                                     <!-- <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:with-param> -->
                                 </xsl:call-template> 
                                 <xsl:call-template name="input-field">
                                     <xsl:with-param name="button-type">transfer-to-account</xsl:with-param>
                                     <xsl:with-param name="name">beneficiary_account</xsl:with-param>     
                                     <xsl:with-param name="readonly">Y</xsl:with-param> 
                                     <xsl:with-param name="required">Y</xsl:with-param> 
                                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
                                 </xsl:call-template> 
                                 </xsl:if>
                                 <xsl:if test="$displaymode = 'view' and counterparties/counterparty/counterparty_cur_code[.!=''] and counterparties/counterparty/counterparty_act_no[.!='']">
                                  <xsl:call-template name="input-field">
                                   <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
                                   <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>   
                                  </xsl:call-template>
                                 </xsl:if>                       
                           </xsl:with-param>
                    </xsl:call-template>
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_BENEFICIARY_DESCRIPTION</xsl:with-param>
				<xsl:with-param name="name">beneficiary_name</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and ft_amt[.!=''])">
			<xsl:call-template name="currency-field">
			     <xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
			     <xsl:with-param name="product-code">ft</xsl:with-param>
			     <xsl:with-param name="show-currency">Y</xsl:with-param>
			     <xsl:with-param name="show-button">N</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="ft_amt"/></xsl:with-param>
			     <xsl:with-param name="currency-readonly">Y</xsl:with-param>
			     <xsl:with-param name="override-amt-name">ft_amt</xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
	     	</xsl:call-template>
	     	</xsl:if>
		 <xsl:choose>
	     		<xsl:when test="$displaymode='edit'">
		     		 <xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_FT_COUNTERPARTY_REFERENCE</xsl:with-param>
						<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
						<xsl:with-param name="maxsize">64</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					 </xsl:call-template>
	     		</xsl:when>
	     		<xsl:otherwise>
		     		<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_FT_COUNTERPARTY_REFERENCE</xsl:with-param>
						<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/> </xsl:with-param>
			 		</xsl:call-template>
			 		<xsl:call-template name="hidden-field">
			 			<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/> </xsl:with-param>
			 		</xsl:call-template>
	     		</xsl:otherwise>
	     	</xsl:choose>
		 <xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
				<xsl:with-param name="name">fwd_contract_no</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
		 </xsl:call-template>
		 
		<xsl:if test="$displaymode = 'edit'">
	   		<xsl:call-template name="textarea-field">
	    		<xsl:with-param name="label">XSL_PAYMENTS_DETAILS_TO_BENEFICIARY</xsl:with-param>	
		        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
		        <xsl:with-param name="cols">35</xsl:with-param>
		        <xsl:with-param name="rows">4</xsl:with-param>
		        <xsl:with-param name="maxlines">4</xsl:with-param>
		       	<xsl:with-param name="swift-validate">Y</xsl:with-param>
		    </xsl:call-template>
	    </xsl:if>
	    	    <!--  amount in ft preview -->
	     <xsl:if test="$displaymode = 'view' and ft_amt[.!='']">
		    <xsl:call-template name="textarea-field">			     
			      <xsl:with-param name="label">XSL_PARTIESDETAILS_FT_AMT_LABEL</xsl:with-param>
			     <xsl:with-param name="value">
					<xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/>
				</xsl:with-param>		  
			</xsl:call-template>		    
    	</xsl:if>
    	<!--  amount in ft preview ends -->
	    
	    <xsl:if test="$displaymode = 'view' and narrative_additional_instructions[.!='']">
		    <xsl:call-template name="big-textarea-wrapper">			     
			      <xsl:with-param name="label">XSL_PAYMENTS_DETAILS_TO_BENEFICIARY</xsl:with-param>
			      <xsl:with-param name="content"><div class="content">
			        <xsl:value-of select="narrative_additional_instructions"/>
			      </div></xsl:with-param>				  
			</xsl:call-template>		    
    	</xsl:if>
    	
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="review-fields">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		<xsl:if test="counterparties/counterparty/counterparty_cur_code[.!='']">
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">review_debitAccountName</xsl:with-param>
				<xsl:with-param name="label">XSL_BENEFICIARY_NAME_DESCRIPTION</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
			</xsl:call-template> 
		</xsl:if>
		<xsl:if test="ft_amt[.!='']">
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">review_debitAmount</xsl:with-param>
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_reference[.!='']">
			<xsl:call-template name="input-field">
	    		<xsl:with-param name="label">XSL_SYSTEMFEATURES_FT_COUNTERPARTY_REFERENCE</xsl:with-param>	
		        <xsl:with-param name="name">beneficiary_reference</xsl:with-param>
		        <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"></xsl:value-of> </xsl:with-param>
	    	</xsl:call-template>
	    </xsl:if>
	    <xsl:if test="fwd_contract_no[.!='']">
	    	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
				<xsl:with-param name="name">fwd_contract_no</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="fwd_contract_no"/> </xsl:with-param>
		 	</xsl:call-template>
		 </xsl:if>
		 <xsl:if test="narrative_additional_instructions[.!='']">
			<xsl:call-template name="input-field">
	    		<xsl:with-param name="label">XSL_PAYMENTDETAILS_MESSAGE_LABEL</xsl:with-param>	
		        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
                <xsl:with-param name="value"><xsl:value-of select="narrative_additional_instructions"/> </xsl:with-param>
	    	</xsl:call-template>
	    </xsl:if>
			<xsl:call-template name="bank-details"></xsl:call-template>
				<xsl:call-template name="bank-instructions">
			</xsl:call-template> 
			<xsl:call-template name="attachments-file-dojo"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="bank-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="issuing-bank-tabcontent"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="localization-dialog"/>
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
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value"/>
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
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">appxid</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">selected_payment_cur_code</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">selected_beneficiary_name</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">selected_beneficiary_account_no</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">selected_beneficiary_reference</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">selected_fee_act_no</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">productcode</xsl:with-param>
	    <xsl:with-param name="value" select="$product-code"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">subproductcode</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
   	  </xsl:call-template>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>