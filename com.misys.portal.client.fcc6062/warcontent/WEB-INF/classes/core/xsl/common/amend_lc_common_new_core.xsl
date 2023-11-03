<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Common templates for LC Amendment SWIFT 2018 format to be placed here.
 
Copyright (c) 2017-2018  (http://www.finastra.com),
All Rights Reserved. 

version:   1.0
date:      09/12/2017
author:    Avilash Ghosh

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization utils defaultresource security">

  
  <!--
   General Details Fieldset. 
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="button-type">summary-details</xsl:with-param>
   	<xsl:with-param name="button-type">
   		<xsl:choose>
   			<xsl:when test="$swift2018Enabled and tnx_type_code[.='03'] and $mode='UNSIGNED'">amend-summary-details</xsl:when>
   			<xsl:otherwise>summary-details</xsl:otherwise>
   		</xsl:choose>
   	</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:if test="$displaymode='edit'">
    	<xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_alt_applicant_name</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/alt_applicant_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_alt_applicant_address_line_1</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/alt_applicant_address_line_1"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_alt_applicant_address_line_2</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/alt_applicant_address_line_2"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_alt_applicant_dom</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/alt_applicant_dom"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_alt_applicant_address_line_4</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/alt_applicant_address_line_4"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_alt_applicant_country</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/alt_applicant_country"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_name</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_address_line_1</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_address_line_1"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_address_line_2</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_address_line_2"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_dom</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_dom"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_address_line_4</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_address_line_4"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_country</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_country"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_reference</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/beneficiary_reference"/>
      </xsl:call-template>
    </xsl:if>
     <xsl:call-template name="amend-general-details">
      	<xsl:with-param name="show-template-id">N</xsl:with-param>
      </xsl:call-template>
     <xsl:call-template name="amd-general-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
    <!--
   General Details fields, common to forms on the customer side.   
   System ID, Template ID, Customer Reference, Application Date.
   -->
  <xsl:template name="amend-general-details">
   <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
   <xsl:param name="cross-ref-summary-option"></xsl:param>
   <xsl:param name="show-product-code">N</xsl:param>
   <xsl:param name="show-sub-product-code">N</xsl:param>
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="localization-dialog"/>
   <!-- Don't display this in unsigned mode. -->
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">appl_date</xsl:with-param>
    </xsl:call-template>
	<xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
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
     <xsl:if test="cust_ref_id[.!='']">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
		     <xsl:with-param name="id">cust_ref_id</xsl:with-param>
		     <xsl:with-param name="value" select="cust_ref_id" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
   
   <!-- Bank Reference -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="cross_references">
   	 <xsl:choose>
      <xsl:when test="product_code[.='LI' or .='SG' or .='TF' or .='SI' or .='LC']">
       <xsl:apply-templates select="cross_references" mode="display_table_master"/>
      </xsl:when>
      <xsl:otherwise>
     <xsl:apply-templates select="cross_references" mode="display_table_tnx">
     	<xsl:with-param name="cross-ref-summary-option"><xsl:value-of select="$cross-ref-summary-option"/></xsl:with-param>
    </xsl:apply-templates>
    </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
       
  </xsl:template>
  
  <!--amend-general-details end here -->
  
  <xsl:template name="amd-general-details">
   <xsl:if test="$displaymode='edit'">
    <div>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_iss_date</xsl:with-param>
     </xsl:call-template>
    </div>
   </xsl:if>

   <!-- Issue Date -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="id">iss_date</xsl:with-param>
     <xsl:with-param name="value" select="iss_date"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
   
   <!--  Expiry Date. --> 
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
    <xsl:with-param name="name">exp_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
      
   <!-- Expiry place. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_PLACE</xsl:with-param>
    <xsl:with-param name="name">expiry_place</xsl:with-param>
    <xsl:with-param name="maxsize">29</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   
  
   <!--  Amendment Date. --> 
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">
    <xsl:choose>
       	<xsl:when test="$swift2018Enabled">XSL_GENERALDETAILS_AMD_CAN_DATE</xsl:when>
       	<xsl:otherwise>XSL_GENERALDETAILS_AMD_DATE</xsl:otherwise>
    </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="name">amd_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
   </xsl:call-template>  
   
   <xsl:variable name="isMT798Enabled"><xsl:value-of select="is_MT798"/></xsl:variable>
   <xsl:if test="product_code[.='LC'] and $displaymode = 'edit' and $isMT798Enabled = 'Y'">
	   <xsl:call-template name="checkbox-field">
	   		<xsl:with-param name="label">XSL_AMEND_CANCELLATION_REQUEST</xsl:with-param>
	    	<xsl:with-param name="name">cancellation_req_flag</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   <xsl:call-template name="hidden-field">
   		<xsl:with-param name="name">amd_no</xsl:with-param>
      	<xsl:with-param name="value"><xsl:value-of select="amd_no"/></xsl:with-param>
   </xsl:call-template>
   
   <xsl:call-template name="hidden-field">
   		<xsl:with-param name="name">proactive_amd</xsl:with-param>
      	<xsl:with-param name="value"><xsl:value-of select="proactive_amd"/></xsl:with-param>
   </xsl:call-template>
   
   <!-- Changed Applicant Details Section-->
   
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
   		<xsl:call-template name="lc-changed-applicant-details" />
 
    </xsl:with-param>
   </xsl:call-template>
   
   
   <!-- Alternate Applicant Details Section-->
   
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_ALTERNATE_PARTY_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
   <xsl:if test="$displaymode = 'edit'">
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_FOR_THE_ACCOUNT_OF</xsl:with-param>
     <xsl:with-param name="name">for_account_flag</xsl:with-param>
    </xsl:call-template>
    </xsl:if>
    <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and for_account_flag = 'Y'">
	      	<xsl:call-template name="lc-alternative-applicant-details" />
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit'">
		      <div id="alternate-party-details" style="display:none;">
		      	<xsl:call-template name="lc-alternative-applicant-details" />
		      </div>
	      </xsl:when>
      </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
 
   <!-- Beneficiary Details -->
   <!-- Do not show benefciary details section if type of LC is Upload-->
   <xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>

     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
	   <xsl:with-param name="reg-exp"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_VALIDATION_REGEX')"/></xsl:with-param>       
       <xsl:with-param name="show-country">Y</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="button-content">
          <xsl:call-template name="get-button">
	        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
	        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
	        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
	      </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  
  <!--
   Amount and Confirmation Details section
   
   By default, it looks for the lc_tnx_record node, but a different node can
   be passed in.
   -->
  <xsl:template name="amend-amt-details">
   <xsl:param name="tnx-record" select="lc_tnx_record"/>
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="show-os-amt">N</xsl:param>
   <xsl:param name="show-release-flag">N</xsl:param>
   
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="show-form-lc">Y</xsl:param>
   <xsl:param name="show-variation-drawing">Y</xsl:param>
   <xsl:param name="show-bank-confirmation">N</xsl:param>
   <xsl:param name="show-outstanding-amt">N</xsl:param>
   <xsl:param name="show-standby">Y</xsl:param>
   <xsl:param name="show-revolving">N</xsl:param>
   <xsl:param name="show-amt">Y</xsl:param>
   <xsl:param name="show-form-lc-irv">N</xsl:param>
   <xsl:param name="transferable">N</xsl:param>
   
   
   <xsl:variable name="cur-code-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>

   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_CONFIRMATION_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
         <xsl:if test="$show-form-lc-irv='Y'">
         	<xsl:call-template name="multioption-group">
     			<xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
        		<xsl:with-param name="content"> 
          		<xsl:call-template name="checkbox-field">
          		 	<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_IRREVOCABLE</xsl:with-param>
           		 	<xsl:with-param name="name">irv_flag</xsl:with-param>
           			 <xsl:with-param name="readonly">Y</xsl:with-param>
            	</xsl:call-template>
		   		</xsl:with-param>
		   </xsl:call-template>
     	</xsl:if>
     <!-- Form of LC Checkboxes. -->
     <div id="lc-amt-details">

     <xsl:if test="$show-form-lc='Y'">
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:choose>
          	<xsl:when test="$displaymode='view'">
	          	<xsl:choose>
	          		<xsl:when test="irv_flag = 'N'">
	          			<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOCABLE')"></xsl:value-of>
	          			&nbsp;
	           		</xsl:when>
	           		<xsl:otherwise>
	           			<span id="irrevocable">
		           			<xsl:call-template name="checkbox-field">
		           				<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_IRREVOCABLE</xsl:with-param>
		           				<xsl:with-param name="name">irv_flag</xsl:with-param>
		           				<xsl:with-param name="checked">Y</xsl:with-param>
		          			</xsl:call-template>
	          			</span>
	           		</xsl:otherwise>
	         	</xsl:choose>
          	</xsl:when>
          	<xsl:otherwise>
          		<xsl:call-template name="checkbox-field">
		           <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_IRREVOCABLE</xsl:with-param>
		           <xsl:with-param name="name">irv_flag</xsl:with-param>
		           <xsl:with-param name="readonly">Y</xsl:with-param>
		           <xsl:with-param name="checked">Y</xsl:with-param>
          		</xsl:call-template>
          	</xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
           <xsl:when test="$transferable='Y'">
				<xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">ntrf_flag</xsl:with-param>  
    				<xsl:with-param name="value">
     					<xsl:choose>
      						<xsl:when test="ntrf_flag[.='']">Y</xsl:when>
      						<xsl:otherwise>
      							<xsl:value-of select="ntrf_flag"></xsl:value-of>
      						</xsl:otherwise>
     					</xsl:choose>
    				</xsl:with-param> 				
   		  		</xsl:call-template>
   		  		
           		<xsl:call-template name="checkbox-field">
            		<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_TRANSFERABLE</xsl:with-param>
            		<xsl:with-param name="name">trf_flag</xsl:with-param>
					<xsl:with-param name="value">
     					<xsl:choose>
      						<xsl:when test="ntrf_flag='N'">Y</xsl:when>
      						<xsl:otherwise>N</xsl:otherwise>
     					</xsl:choose>
    				</xsl:with-param>
           		</xsl:call-template>          		
           </xsl:when>
           <xsl:otherwise>
           	<xsl:choose>
           		<xsl:when test="$displaymode='view'">
					<xsl:choose>
           				<xsl:when test="ntrf_flag[. = 'N']">
           					<span id="transferable">
           					<xsl:call-template name="checkbox-field">
           						<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_TRANSFERABLE</xsl:with-param>
           						<xsl:with-param name="name">ntrf_flag</xsl:with-param>
           						<xsl:with-param name="checked">Y</xsl:with-param>
          					</xsl:call-template>
          					</span>
           				</xsl:when>
           				<xsl:otherwise>
           					<span id="nontransferable">
	           					<xsl:call-template name="checkbox-field">
	           						<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE</xsl:with-param>
	           						<xsl:with-param name="name">ntrf_flag</xsl:with-param>
	           						<xsl:with-param name="checked">Y</xsl:with-param>
	          					</xsl:call-template>
          					</span>
           				</xsl:otherwise>
           			</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="checkbox-field">
           				<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE</xsl:with-param>
           				<xsl:with-param name="name">ntrf_flag</xsl:with-param>
          			</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
          
      <xsl:if test="$swift2019Enabled and $product-code = 'SI' and $displaymode='edit'">        
	   <xsl:call-template name="row-wrapper">
			<xsl:with-param name="id">transfer_condition</xsl:with-param>
			<xsl:with-param name="label">TRANSFER_CONDITION</xsl:with-param>
			<xsl:with-param name="type">textarea</xsl:with-param>
			<xsl:with-param name="content">
			 <xsl:call-template name="textarea-field">
			  <xsl:with-param name="name">narrative_transfer_conditions</xsl:with-param>
			  <xsl:with-param name="messageValue"><xsl:value-of select="narrative_transfer_conditions/text"/></xsl:with-param>
			  <xsl:with-param name="phrase-params">{'category':'48'}</xsl:with-param>
			  <xsl:with-param name="rows">12</xsl:with-param>
			  <xsl:with-param name="cols">65</xsl:with-param>
			  <xsl:with-param name="maxlines">12</xsl:with-param>
			  <xsl:with-param name="swift-validate">Y</xsl:with-param>
			  	<xsl:with-param name="disabled">
					<xsl:choose>
						<xsl:when test="ntrf_flag[.='N'] or ntrf_flag[.='']">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	  </xsl:if>

          <!-- Display the standby checkbox if this is an LC -->
          <xsl:if test="$show-standby='Y' and $displaymode='view'">
          <span id="standby">
	           <xsl:call-template name="checkbox-field">
	            <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_STAND_BY</xsl:with-param>
	            <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
	           </xsl:call-template>
           </span>
          </xsl:if>
          <xsl:if test="$show-standby='Y' and $displaymode='edit'">
           <xsl:call-template name="checkbox-field">
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_STAND_BY</xsl:with-param>
            <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
           </xsl:call-template>
          </xsl:if>
          <xsl:if test="$show-revolving='Y' and $displaymode='view'">
           <span id="revolving">
	           <xsl:call-template name="checkbox-field">
	            <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_REVOLVING</xsl:with-param>
	            <xsl:with-param name="name">revolving_flag</xsl:with-param>
	           </xsl:call-template>
           </span>
          </xsl:if>
          <xsl:if test="$show-revolving='Y' and $displaymode='edit'">
           <xsl:call-template name="checkbox-field">
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_REVOLVING</xsl:with-param>
            <xsl:with-param name="name">revolving_flag</xsl:with-param>
           </xsl:call-template>
          </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
   
       <!-- Confirmation Instructions Radio Buttons -->
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_INST_LABEL</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:apply-templates select="cfm_inst_code"/>
        </xsl:with-param>
       </xsl:call-template>
    
      
      </xsl:if>
      
      <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="hidden-field"> 
       <xsl:with-param name="name">lc_cur_code</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="lc_cur_code"/></xsl:with-param>
      </xsl:call-template>
     </xsl:if>
      <!-- Original LC Amt is hidden in new LC screen -->
          
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="required">N</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_lc_amt</xsl:with-param>
	      <xsl:with-param name="override-amt-value">
	        <xsl:choose>
     		<xsl:when test="$product-code='SI'"><xsl:value-of select="org_previous_file/si_tnx_record/lc_amt"/> </xsl:when>
     		<xsl:when test="$product-code='LC'"><xsl:value-of select="org_previous_file/lc_tnx_record/lc_amt"/> </xsl:when>
     	 </xsl:choose>
	      </xsl:with-param>
	      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	      <xsl:with-param name="disabled">Y</xsl:with-param>
	     </xsl:call-template>
	    <xsl:if test="$displaymode='edit'">
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">inc_amt</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="amt-readonly">N</xsl:with-param>
	      <xsl:with-param name="override-amt-name">dec_amt</xsl:with-param>
	     </xsl:call-template>
	    </xsl:if>
	    <xsl:if test="$displaymode='view' and inc_amt[.!='']">
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">inc_amt</xsl:with-param>
	     </xsl:call-template>
	    </xsl:if>
	    <xsl:if test="$displaymode='view' and dec_amt[.!='']"> 
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="amt-readonly">N</xsl:with-param>
	      <xsl:with-param name="override-amt-name">dec_amt</xsl:with-param>
	     </xsl:call-template>
	    </xsl:if>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="amt-readonly">N</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
      
      <!-- Can show outstanding amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-outstanding-amt='Y' or $displaymode='view'">
      
      
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
       <xsl:variable name="field-cur-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
       

       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="type">amount</xsl:with-param>
        <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()=$field-cur-name]"/></xsl:with-param>
        <xsl:with-param name="name"><xsl:value-of select="$field-name"/></xsl:with-param>
        <xsl:with-param name="size">20</xsl:with-param>
        <xsl:with-param name="appendClass">outstanding</xsl:with-param>
        <xsl:with-param name="maxsize">15</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	      <xsl:if test="$field-value !=''">
	       <xsl:choose>
	        <xsl:when test="$displaymode='view'">
	         <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	        </xsl:when>
	        <xsl:otherwise><xsl:value-of select="$field-value"/></xsl:otherwise>
	       </xsl:choose>
	      </xsl:if>
	    </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <br/>
      <!-- Variation in drawing. -->
      <xsl:if test="$show-variation-drawing='Y' and (lc_type[.!='04'] or tnx_type_code[.!='01'])">
       <xsl:call-template name="label-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="content">
        <xsl:call-template name="hidden-field">
           	<xsl:with-param name="name">DrawingTolerence_spl</xsl:with-param>
           	<xsl:with-param name="value" select="defaultresource:getResource('TOLERANCE_WITH_NOTEXCEEDING')"/>
         </xsl:call-template>
         <!-- <div class="group-fields">  -->
         <xsl:if test="$displaymode='edit'">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_PSTV</xsl:with-param>
           <xsl:with-param name="name">pstv_tol_pct</xsl:with-param>
           <xsl:with-param name="type">integer</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>        
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_NEG</xsl:with-param>
           <xsl:with-param name="name">neg_tol_pct</xsl:with-param>
           <xsl:with-param name="type">integer</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
          </xsl:call-template>
           </xsl:if>
           
          <xsl:if test="$displaymode='view' and pstv_tol_pct[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_PSTV</xsl:with-param>
           <xsl:with-param name="name">pstv_tol_pct</xsl:with-param>
           <xsl:with-param name="type">number</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>        
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
          </xsl:call-template>
          </xsl:if>
          <xsl:if test="$displaymode='view' and neg_tol_pct[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_NEG</xsl:with-param>
           <xsl:with-param name="name">neg_tol_pct</xsl:with-param>
           <xsl:with-param name="type">number</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
          </xsl:call-template>
          </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
		<br/>            
		<xsl:variable name="isMT798Enabled"><xsl:value-of select="is_MT798"/></xsl:variable>
      <!-- Issuing bank charges  -->
		<xsl:choose>
			<xsl:when test="(open_chrg_brn_by_code !='' and $displaymode='view')">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_ISS_LABEL</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/open_chrg_brn_by_code='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/open_chrg_brn_by_code='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>
							<xsl:when test="$product-code='SI' and /si_tnx_record/open_chrg_brn_by_code='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='SI' and /si_tnx_record/open_chrg_brn_by_code='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>
						</xsl:choose>
						</xsl:with-param>
				</xsl:call-template>
			</xsl:when>	
			<xsl:when test="$displaymode='edit'">
				<xsl:apply-templates select="open_chrg_brn_by_code">
	        		<xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
	       			 <xsl:with-param name="label">XSL_CHRGDETAILS_ISS_LABEL</xsl:with-param>
	       			 <xsl:with-param name="show-option">
	       			 	<xsl:choose>
							<xsl:when test="$isMT798Enabled = 'Y'">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					 </xsl:with-param>
      	 		</xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
       <!-- Outside country charges  -->
		<xsl:choose>
			<xsl:when test="(corr_chrg_brn_by_code !='' and $displaymode='view')">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/corr_chrg_brn_by_code ='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/corr_chrg_brn_by_code ='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>
							<xsl:when test="$product-code='SI' and /si_tnx_record/corr_chrg_brn_by_code ='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='SI' and /si_tnx_record/corr_chrg_brn_by_code ='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>
						</xsl:choose>
						</xsl:with-param>
				</xsl:call-template>
			</xsl:when>	
			<xsl:when test="$displaymode='edit'">
				<xsl:apply-templates select="corr_chrg_brn_by_code">
	        		<xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
	       			 <xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
	       			 <xsl:with-param name="show-option">
	       			 	<xsl:choose>
							<xsl:when test="$isMT798Enabled = 'Y'">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					 </xsl:with-param>
      	 		</xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
      <!-- Confirmation charges  -->	 	
	 	<xsl:choose>
			<xsl:when test="(is_MT798[.='N'] and cfm_chrg_brn_by_code !='' and $displaymode='view' and $confirmationChargesEnabled)">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/cfm_chrg_brn_by_code ='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/cfm_chrg_brn_by_code ='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>
							<xsl:when test="$product-code='SI' and /si_tnx_record/cfm_chrg_brn_by_code ='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='SI' and /si_tnx_record/cfm_chrg_brn_by_code ='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>
						</xsl:choose>
						</xsl:with-param>
				</xsl:call-template>
			</xsl:when>	
			<xsl:when test="is_MT798[.='N'] and $displaymode='edit' and $confirmationChargesEnabled">
			   <xsl:apply-templates select="cfm_chrg_brn_by_code">
			        <xsl:with-param name="node-name">cfm_chrg_brn_by_code</xsl:with-param>
			        <xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
		       </xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
		
		   <!-- Confirmation charges  -->	 	
	 	<xsl:choose>
			<xsl:when test="(amd_chrg_brn_by_code !='' and $displaymode='view')">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_AMD_LABEL</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/amd_chrg_brn_by_code ='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/amd_chrg_brn_by_code ='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/amd_chrg_brn_by_code ='07' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_OTHER')"/></xsl:when>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/amd_chrg_brn_by_code ='05' and $swift2019Enabled"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_SHARED')"/></xsl:when>
							<xsl:when test="$product-code='LC' and /lc_tnx_record/amd_chrg_brn_by_code ='09' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_NONE')"/></xsl:when>	
							<xsl:when test="$product-code='SI' and /si_tnx_record/amd_chrg_brn_by_code ='01' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/></xsl:when>
							<xsl:when test="$product-code='SI' and /si_tnx_record/amd_chrg_brn_by_code ='02' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/></xsl:when>			
							<xsl:when test="$product-code='SI' and /si_tnx_record/amd_chrg_brn_by_code ='07' "><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_OTHER')"/></xsl:when>									
						</xsl:choose>
						</xsl:with-param>
				</xsl:call-template>
				<xsl:choose>
				<xsl:when test="$product-code='LC' and ((/lc_tnx_record/amd_chrg_brn_by_code ='05') or (/lc_tnx_record/amd_chrg_brn_by_code ='07'))">
					<xsl:call-template name="input-field">
					<xsl:with-param name="value"><xsl:value-of select="/lc_tnx_record/narrative_amend_charges_other"/></xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:when test="$product-code='SI' and /si_tnx_record/amd_chrg_brn_by_code ='07' ">
					<xsl:call-template name="input-field">
					<xsl:with-param name="value"><xsl:value-of select="/si_tnx_record/narrative_amend_charges_other"/></xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				</xsl:choose>			
			</xsl:when>	
			<xsl:when test="$displaymode='edit'">
				<xsl:apply-templates select="amd_chrg_brn_by_code">
	        	<xsl:with-param name="node-name">amd_chrg_brn_by_code</xsl:with-param>
	        	<xsl:with-param name="label">XSL_CHRGDETAILS_AMD_LABEL</xsl:with-param>
	        	<xsl:with-param name="show-option">Y</xsl:with-param>
	      	 </xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
		
		<xsl:if test = "$product-code='LC'">
		  	<xsl:call-template name = "applicable-rules"/>
		</xsl:if>	         
      </xsl:if>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- This template is used to build the lc revolving details on the UI -->
  <xd:doc>
	<xd:short>Letter of credit revolving details.</xd:short>
	<xd:detail>
		This tempalte will create revolving details section.
	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-revolving-details">
  	<xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_REVOLVING_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_REVOLVE_PERIOD</xsl:with-param>
	       <xsl:with-param name="name">revolve_period</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="revolve_period[.!='']"><xsl:value-of select="revolve_period"/></xsl:if></xsl:with-param>
	       <xsl:with-param name="size">5</xsl:with-param>
	       <xsl:with-param name="maxsize">5</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="override-constraints">{min:0,max:99999}</xsl:with-param>
	       <xsl:with-param name="type">integer</xsl:with-param>
	     </xsl:call-template>
	     <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="select-field">
			       <xsl:with-param name="label">XSL_REVOLVE_FREQUENCY</xsl:with-param>
			       <xsl:with-param name="name">revolve_frequency</xsl:with-param>
			       <xsl:with-param name="fieldsize">small</xsl:with-param>
			       <xsl:with-param name="options">
			       <xsl:call-template name="revolving-frequency-options"/>
			       </xsl:with-param>
	     	   </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="revolve_frequency[.!=''] and $displaymode='view'">
		     	 <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_REVOLVE_FREQUENCY</xsl:with-param>
				     <xsl:with-param name="name">revolve_frequency</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getDecode($language, 'C049', revolve_frequency)"/>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
     	 </xsl:choose>
     	 <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_REVOLVE_TIME_NUMBER</xsl:with-param>
	       <xsl:with-param name="name">revolve_time_no</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="revolve_time_no[.!='']"><xsl:value-of select="revolve_time_no"/></xsl:if></xsl:with-param>
	       <xsl:with-param name="size">9</xsl:with-param>
	       <xsl:with-param name="maxsize">9</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="override-constraints">{min:0,max:999999999}</xsl:with-param>
	       <xsl:with-param name="type">integer</xsl:with-param>
	     </xsl:call-template>
	     <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="checkbox-field">
		           <xsl:with-param name="label">XSL_CUMULATIVE</xsl:with-param>
		           <xsl:with-param name="name">cumulative_flag</xsl:with-param>
		       </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="cumulative_flag[.='Y'] and $displaymode='view'">
	     	 	  <xsl:call-template name="input-field">
				     <xsl:with-param name="name">cumulative_flag</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getGTPString($language, 'XSL_CUMULATIVE')"></xsl:value-of>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="cumulative_flag[.='N'] and $displaymode='view'">
	     	 	 <xsl:call-template name="input-field">
				     <xsl:with-param name="name">cumulative_flag</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getGTPString($language, 'XSL_NON_CUMULATIVE')"></xsl:value-of>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
     	 </xsl:choose>
     	 <xsl:if test="next_revolve_date[.!='']">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="name">next_revolve_date</xsl:with-param>
	       <xsl:with-param name="label">XSL_NEXT_REVOLVE_DATE</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="next_revolve_date"/></xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="size">10</xsl:with-param>
	       <xsl:with-param name="maxsize">10</xsl:with-param>
	       <xsl:with-param name="readonly">Y</xsl:with-param>
	       <xsl:with-param name="type">date</xsl:with-param>
	     </xsl:call-template>
	     </xsl:if>
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_NOTICE_DAYS</xsl:with-param>
	       <xsl:with-param name="name">notice_days</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="notice_days[.!='']"><xsl:value-of select="notice_days"/></xsl:if></xsl:with-param>
	       <xsl:with-param name="size">9</xsl:with-param>
	       <xsl:with-param name="maxsize">9</xsl:with-param>
	       <xsl:with-param name="override-constraints">{min:0,max:999999999}</xsl:with-param>
	       <xsl:with-param name="type">integer</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	     </xsl:call-template>
	    <xsl:if test="charge_upto[.!='']">
	     <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="select-field">
			       <xsl:with-param name="label">XSL_CHARGE_UPTO</xsl:with-param>
			       <xsl:with-param name="name">charge_upto</xsl:with-param>
			       <xsl:with-param name="fieldsize">small</xsl:with-param>
			        <xsl:with-param name="readonly">Y</xsl:with-param>
			       <xsl:with-param name="options">
			       	<xsl:call-template name="charge-upto-options"/>
			       </xsl:with-param>
		       </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="charge_upto[.!=''] and $displaymode='view'">
		     	 <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_CHARGE_UPTO</xsl:with-param>
				     <xsl:with-param name="name">charge_upto</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getDecode($language, 'C050', charge_upto)"/>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
     	 </xsl:choose>
     	 </xsl:if>
    </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
   <!--
   Payment Details Fieldset.
   
   Credit Available With Bank.
   -->
  <xsl:template name="lc-payment-details">
   <xsl:param name="required">Y</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Credit Available With -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:apply-templates select="credit_available_with_bank" mode="select">
       		<xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
       </xsl:apply-templates>
       <xsl:call-template name="credit-available-by"/>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
    <!--
  Credit Available With. (Select Mode)
  
  Credit Available Bank Type, Credit Available By, Payment/Draft At, Drawee Details.
  -->
  <xsl:template match="credit_available_with_bank" mode="select">
   <xsl:param name="required">Y</xsl:param>
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_TYPE</xsl:with-param>
    <xsl:with-param name="name">credit_available_with_bank_type</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
    <xsl:with-param name="options">
     <xsl:call-template name="bank-type-options"/>
    </xsl:with-param>
   </xsl:call-template>
   

   
   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
    <xsl:with-param name="name">credit_available_with_bank_name</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="name"/></xsl:with-param>
    <xsl:with-param name="button-type">credit_available_with_bank_other</xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
    <script>
		dojo.ready(function()
			{
				if(misys._config.swiftRelatedSection !== undefined)
				{
					misys._config.swiftRelatedSections.push('credit_available_with_bank');
				}
			});
   </script>
  
   <!-- Address Lines -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
    <xsl:with-param name="name">credit_available_with_bank_address_line_1</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_1"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name">credit_available_with_bank_address_line_2</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_2"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name">credit_available_with_bank_dom</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="dom"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    	<xsl:with-param name="name">credit_available_with_bank_address_line_4</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="address_line_4"/></xsl:with-param>
    	<xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   
   <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">credit_available_with_bank_role_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="role_code"/></xsl:with-param>
     </xsl:call-template>
  </xsl:template>
  
    <!--
   Shipment Details Fieldset.
   -->
  <xsl:template name="amend-shipment-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_FROM</xsl:with-param>
      <xsl:with-param name="name">ship_from</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING</xsl:with-param>
      <xsl:with-param name="name">ship_loading</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE</xsl:with-param>
      <xsl:with-param name="name">ship_discharge</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_TO</xsl:with-param>
      <xsl:with-param name="name">ship_to</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="id">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
      	<xsl:choose>
     		 <xsl:when test="part_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       		 <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        	 <xsl:when test="part_ship_detl[. = '' or . = 'NONE']"></xsl:when>
       		 <xsl:otherwise>CONDITIONAL</xsl:otherwise>
       	</xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
       	  <option/>
         <option value="ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
	     <option value="CONDITIONAL">
	       	 <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/>       	 	
	     </option>	   
        </xsl:when>
        <xsl:otherwise>
        <xsl:if test="part_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="part_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = '' or . = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/></xsl:when>
          <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">	       
     		 <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/>     
          </xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="infoMessagePartialShipment"></xsl:call-template>       
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL_LC</xsl:with-param>
      <xsl:with-param name="id">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
      <xsl:choose>
       		 <xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       		 <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        	 <xsl:when test="tran_ship_detl[. = '' or . = 'NONE']"></xsl:when>
       		 <xsl:otherwise>CONDITIONAL</xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
       	  <option/>       	  
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	      <option value="CONDITIONAL">
	       	 	<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/>       	 	
	      </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:if test="tran_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = '' or . = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/></xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
    <xsl:call-template name="infoMessageTranshipment"></xsl:call-template>  
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="swift-validate">N</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
   
     </xsl:call-template>
     <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
         <xsl:call-template name="select-field">
	 	<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
		<xsl:with-param name="name">inco_term_year</xsl:with-param>	 
		 <xsl:with-param name="fieldsize">small</xsl:with-param>
		  <xsl:with-param name="required">N</xsl:with-param>	 
	</xsl:call-template>
	   </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="inco_year"><xsl:value-of select="inco_term_year"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
					<xsl:with-param name="name">inco_term_year_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$inco_year"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
	  <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
       </xsl:when>
		<xsl:otherwise>
		<xsl:variable name="incoTerm"><xsl:value-of select="inco_term"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
					<xsl:with-param name="name">inco_term_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','N212',$incoTerm)"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
      <xsl:with-param name="name">inco_place</xsl:with-param>
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
      <xsl:with-param name="required">N</xsl:with-param>
     </xsl:call-template>
     

	<!-- Hidden fields required for Shipment details -->   
    </xsl:with-param>    
   </xsl:call-template>      
  </xsl:template>
  
   <xsl:template name="amend-issue-bank-details">
   <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS_LC</xsl:with-param>
    <xsl:with-param name="tabgroup-id">issue-bank-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">215px</xsl:with-param>
  <xsl:with-param name="toc-item">N</xsl:with-param>
    <!-- Tab 0_0 - Issuing Bank  -->
    <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
    <xsl:with-param name="tab0-content">

   <xsl:call-template name="main-bank-selectbox">
    <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
    <xsl:with-param name="sender-name">applicant</xsl:with-param>
    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
    <xsl:with-param name="required">N</xsl:with-param>
   </xsl:call-template>
     
    </xsl:with-param>

   </xsl:call-template>
   </xsl:template>
   
    <!--
   Bank Details Tabgroup.
   
   Tab0 - Issuing Bank
   Tab1 - Advising Bank
   Tab2 - Advise Thru Bank
   -->
  <xsl:template name="amend-lc-bank-details">
   <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS_LC</xsl:with-param>
    <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">215px</xsl:with-param>

    <!-- Tab 0_3 - Requested Confirmation Party ILC--> 
    <xsl:with-param name="tab3-label">XSL_BANKDETAILS_TAB_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>  
    <xsl:with-param name="tab3-content">
    	 <xsl:call-template name="requestedConfirmationPartyTabSection"></xsl:call-template>  
    </xsl:with-param>
   </xsl:call-template>
   
   <!-- Add the communication channel in the page (MT798 or standard)
   Fields are switched depending on it -->
   <xsl:if test="$displaymode='edit'">
    <script>
    	dojo.ready(function(){
    		misys._config = misys._config || {};
			misys._config.customerBanksMT798Channel = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_banks_communication_channel"/>
		});
	</script>
   </xsl:if>   
  </xsl:template>


  <!--
  Issuing Bank Tab Content. Common to LC forms, and FT.
  -->
  <xsl:template name="amend-issuing-bank-tabcontent">
   <xsl:param name="main-bank-name">issuing_bank</xsl:param>
   <xsl:param name="sender-name">applicant</xsl:param>
   <xsl:param name="sender-reference-name">applicant_reference</xsl:param>
   
   <xsl:if test="$displaymode='edit'">
    <script>
    	dojo.ready(function(){
    		misys._config = misys._config || {};
			misys._config.customerReferences = {};
			misys._config.isoCodes = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
	</script>
   </xsl:if>

  </xsl:template>



  <!-- 
   Amend Narrative.
   -->
  <xsl:template name="amend-common-narrative">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMENDMENT_NARRATIVE</xsl:with-param>
    <xsl:with-param name="content">
     <!-- This empty tag is needed for this to appear, I'm not sure why. -->
     <div style="display:none">&nbsp;</div>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">amd_details</xsl:with-param>
       <xsl:with-param name="type">textarea</xsl:with-param>
       <xsl:with-param name="content">
       <xsl:choose>
      	<xsl:when test="product_code[.='LC']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
          <!-- Increasing as per TI confirmation that filed can accormodate 15860 including CR  -->
         <xsl:with-param name="maxlines">305</xsl:with-param> 
        </xsl:call-template>
       </xsl:when>
      	<xsl:when test="product_code[.='SI']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="phrase-params">{'category':'13'}</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="maxlines">70</xsl:with-param> 
        </xsl:call-template>
       </xsl:when>
       <xsl:when test="product_code[.='LS']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="maxlines">128</xsl:with-param>
        </xsl:call-template>
       </xsl:when>
       <xsl:when test="product_code[.='EC']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">4</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="maxlines">4</xsl:with-param>
        </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
       	<xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
          <!-- Increasing as per TI confirmation that filed can accormodate 15860 including CR  -->
         <xsl:with-param name="maxlines">305</xsl:with-param> 
        </xsl:call-template>
       </xsl:otherwise>
       </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>


  <xsl:template name="amend-lc-additional-amount">
     <xsl:choose>
     	<xsl:when test="$displaymode='edit'">
	     <xsl:call-template name="row-wrapper">
	      <xsl:with-param name="id">narrative_additional_amount</xsl:with-param>
	      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	      	<xsl:choose>
	      	<xsl:when test="product_code[.='LC' or .='SI']"> 
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
		        <xsl:with-param name="phrase-params">{'category':'05'}</xsl:with-param>
		        <xsl:with-param name="rows">4</xsl:with-param>
		        <xsl:with-param name="cols">35</xsl:with-param>
		        <xsl:with-param name="maxlines">4</xsl:with-param>
		       </xsl:call-template>
		     </xsl:when>
		     <xsl:otherwise>
		     	<xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
		        <xsl:with-param name="rows">4</xsl:with-param>
		        <xsl:with-param name="cols">35</xsl:with-param>
		       </xsl:call-template>
		     </xsl:otherwise>
		     </xsl:choose>
	     </xsl:with-param>
	    </xsl:call-template>
     	</xsl:when>
     	<xsl:otherwise>
	     <xsl:if test="$displaymode='view' and narrative_additional_amount[.!='']">
	      <xsl:call-template name="big-textarea-wrapper">
	      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT</xsl:with-param>
	      <xsl:with-param name="content">
			<div class="content">
				<xsl:value-of select="narrative_additional_amount"/>
			</div>
	      </xsl:with-param>
	     </xsl:call-template>
	     </xsl:if>
     	</xsl:otherwise>
     </xsl:choose>  
       
  </xsl:template>
  
   <xsl:template name="lc-changed-applicant-details">
   <!-- Changed Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="prefix">applicant</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>      
       </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
   
   <!-- 
   	LC Alternative Applicant Details
   -->
	<xsl:template name="lc-alternative-applicant-details">
   <!-- Alternative Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="name-label">XSL_PARTIESDETAILS_ALT_APPLICANT_NAME</xsl:with-param>
        <xsl:with-param name="address-label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param>
        <xsl:with-param name="country-label">XSL_PARTIESDETAILS_ALT_APPLICANT_COUNTRY</xsl:with-param>
        <xsl:with-param name="show-country">Y</xsl:with-param>
        <xsl:with-param name="max-size">20</xsl:with-param>
        <xsl:with-param name="prefix">alt_applicant</xsl:with-param>    
        <xsl:with-param name="required">N</xsl:with-param>      
       </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!--
   Confirmation Code Radio Buttons.
  -->
  <xsl:template match="cfm_inst_code">
   <xsl:call-template name="radio-field">
    <xsl:with-param name="label">XSL_AMOUNTDETAILS_CFM_INST_CONFIRM</xsl:with-param>
    <xsl:with-param name="name">cfm_inst_code</xsl:with-param>
    <xsl:with-param name="id">cfm_inst_code_1</xsl:with-param>
    <xsl:with-param name="value">01</xsl:with-param>
    <xsl:with-param name="radio-value"><xsl:value-of select="."/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="radio-field">
    <xsl:with-param name="label">XSL_AMOUNTDETAILS_CFM_INST_MAY_ADD</xsl:with-param>
    <xsl:with-param name="name">cfm_inst_code</xsl:with-param>
    <xsl:with-param name="id">cfm_inst_code_2</xsl:with-param>
    <xsl:with-param name="value">02</xsl:with-param>
    <xsl:with-param name="radio-value"><xsl:value-of select="."/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="radio-field">
    <xsl:with-param name="label">XSL_AMOUNTDETAILS_CFM_INST_WITHOUT</xsl:with-param>
    <xsl:with-param name="name">cfm_inst_code</xsl:with-param>
    <xsl:with-param name="id">cfm_inst_code_3</xsl:with-param>
    <xsl:with-param name="value">03</xsl:with-param>
    <xsl:with-param name="radio-value"><xsl:value-of select="."/></xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>