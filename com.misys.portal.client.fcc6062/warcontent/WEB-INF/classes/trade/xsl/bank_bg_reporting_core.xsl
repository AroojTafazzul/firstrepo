<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Bankers Guarantee (BG) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
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
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization security securitycheck defaultresource">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">BG</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <!-- <xsl:include href="../../xsl/report/report.xsl"/>  -->
   <xsl:include href="./common/bg_common.xsl" />
   <xsl:include href="../../core/xsl/common/ls_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="bg_tnx_record"/>
  </xsl:template>
 
 <!-- 
   BG TNX FORM TEMPLATE.
  -->
  <xsl:template match="bg_tnx_record">
   <!-- Preloader  -->
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
		</xsl:if>
   
   <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
   <!-- <xsl:choose>
     <xsl:when test="tnx_type_code[.='15' or .='13']"> -->
     
      <!-- Link to display transaction contents (transaction hidden by default) -->
		<xsl:call-template name="transaction-details-link">
			<xsl:with-param name="show-transaction">
				<xsl:choose>
					<xsl:when test="tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and $displaymode = 'edit' or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="show-hyperlink">
				<xsl:choose>
					<xsl:when test="(tnx_type_code[.='01'] or tnx_type_code[.='03']) and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
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
         <!-- Disclaimer Notice -->
         <xsl:call-template name="disclaimer"/>
        
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         <xsl:call-template name="hidden-fields"/>
         <xsl:call-template name="general-details"/>
         <xsl:call-template name="amt-details"/>
         <!-- Renewal details -->
         <xsl:call-template name="bg-renewal-details"/> 
   
         <!-- Bank Details -->
         <xsl:call-template name="bank-details"/>
         <xsl:call-template name="bg-guarantee-details">
         	<xsl:with-param name="isBankReporting">Y</xsl:with-param>
         	<xsl:with-param name="pdfOption">
	          <xsl:choose>
			   <xsl:when test="security:isBank($rundata)">PDF_BG_DOCUMENT_DETAILS_BANK</xsl:when>
			   <xsl:otherwise>PDF_BG_DOCUMENT_DETAILS</xsl:otherwise>
			  </xsl:choose>
	         </xsl:with-param>
         </xsl:call-template>
         
         <xsl:call-template name="bg-contract-details">
      </xsl:call-template>
        <xsl:choose>
	      <xsl:when test="$displaymode = 'view'">
	      	<xsl:choose>
	      	<xsl:when test="$mode = 'UNSIGNED' and //limit_details/limit_reference[.!=''] ">
			   	  	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	</xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 	<xsl:if test="//limit_details/limit_reference[.!='']">
		  	 	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	<xsl:with-param name="displayAmount">N</xsl:with-param>
			   	  	</xsl:call-template>
			   	 </xsl:if>
		  	 </xsl:otherwise>
		  	 </xsl:choose>
	      </xsl:when>
	      <xsl:otherwise>
		      <xsl:if test="//limit_details/limit_reference[.!='']">
		       <xsl:call-template name="build-facility-data"/> 
			   	  	<xsl:call-template name="facility-limit-section">
				  	  	<xsl:with-param name="isBank">Y</xsl:with-param>
				  	</xsl:call-template>
		  	 </xsl:if>
	   	 </xsl:otherwise>
   	 </xsl:choose>
         
     <xsl:if test="securitycheck:hasPermission($rundata,'tradeadmin_ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
		<xsl:call-template name="linked-ls-declaration"/>
 		<xsl:call-template name="linked-licenses"/>
 	 </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
      </div>
    <!-- </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="common-hidden-fields">
         <xsl:with-param name="show-type">N</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>  --> 
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
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.bank.report_bg</xsl:with-param>
      <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
  <script type="text/javascript">
		dojo.ready(function(){
			misys._config.isBank = <xsl:value-of select="security:isBank($rundata)"/>
		});
	</script>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="override-product-code">bg</xsl:with-param>
   <xsl:with-param name="additional-fields">
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_bg_liab_amt</xsl:with-param>
   </xsl:call-template>
    <!--  <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_bg_amt</xsl:with-param>
     <xsl:with-param name="value" select="org_bg_amt"/>
   	</xsl:call-template> -->
   <xsl:if test="lead_bank_flag[.='Y']">
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">lead_bank_flag</xsl:with-param>
	    <xsl:with-param name="value" select="lead_bank_flag"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">processing_bank_iso_code</xsl:with-param>
	    <xsl:with-param name="value" select="processing_bank/iso_code"/>
	   </xsl:call-template>
   </xsl:if>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">prv_pod_stat_code</xsl:with-param>
   </xsl:call-template>
 	<xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">inc_amt</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="inc_amt"/></xsl:with-param>
	 </xsl:call-template>
	<xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">dec_amt</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="dec_amt"/></xsl:with-param>
	</xsl:call-template>
	 <!--	<xsl:if test="product_code[.='BG'] and tnx_type_code[.='03']">
   <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">tnx_amt</xsl:with-param>
   	</xsl:call-template>
   	</xsl:if> -->
	<!-- Domestic Guarantee value -->
	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">form_mask</xsl:with-param>
	</xsl:call-template>
	 <xsl:if test="$displaymode='edit' and release_dttm[.!='']">
	   <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
	   </xsl:call-template>
    </xsl:if>
   </xsl:with-param>
  </xsl:call-template>
  
  <!--Empty the principal and fee accounts-->
  <div>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">principal_act_no</xsl:with-param>
    <xsl:with-param name="value"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">fee_act_no</xsl:with-param>
    <xsl:with-param name="value"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">loading_bg_text_type_code</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="bg_text_type_code"/></xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- 
  BG General Details
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_EFFECTIVE_DATE_TYPE</xsl:with-param>
     <xsl:with-param name="name">iss_date_type_code</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
		  <option value="01">
		   <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/>
		  </option>
		  <option value="02">
		   <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/>
		  </option>
		  <option value="03">
		   <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/>
		  </option>
		  <option value="99">
		   <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_OTHER')"/>
		  </option>
       </xsl:when>
       <xsl:otherwise>
         <xsl:choose>
	      <xsl:when test="iss_date_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/></xsl:when>
	      <xsl:when test="iss_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/></xsl:when>
	      <xsl:when test="iss_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/></xsl:when>
	      <xsl:when test="iss_date_type_code[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_OTHER')"/></xsl:when>
	     </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    
    <xsl:if test="template_id[.!=''] and security:isBank($rundata) and $displaymode='view'">
      <xsl:call-template name="row-wrapper">
      <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
      <xsl:with-param name="content"><div class="content">
      <xsl:value-of select="template_id"/>
      </div></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:call-template name="input-field">
     <xsl:with-param name="name">iss_date_type_details</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
     <xsl:with-param name="name">exp_date_type_code</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:call-template name="bg-exp-dates"/>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="name">exp_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">exp_event</xsl:with-param>
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">exp_event</xsl:with-param>
        <xsl:with-param name="button-type"></xsl:with-param>
        <xsl:with-param name="rows">4</xsl:with-param>
        <xsl:with-param name="cols">35</xsl:with-param>
        <xsl:with-param name="maxlines">4</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
   </xsl:call-template>
    <!-- <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
     <xsl:with-param name="name">amd_no</xsl:with-param>
     <xsl:with-param name="size">2</xsl:with-param>
     <xsl:with-param name="maxsize">3</xsl:with-param>
     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
     <xsl:with-param name="name">amd_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>-->
    <div id="chkBoxAlignPopup">
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_REDUCTION_AUTHORISED</xsl:with-param>
     <xsl:with-param name="name">reduction_authorised</xsl:with-param>
    </xsl:call-template>
    </div>
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_REDUCTION_CLAUSE</xsl:with-param>
     <xsl:with-param name="name">reduction_clause</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:call-template name="bg-reduction-clause"/>
    </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">reduction_clause_other</xsl:with-param>
      <xsl:with-param name="maxsize">35</xsl:with-param>
      <!-- <xsl:with-param name="readonly">Y</xsl:with-param> -->
     </xsl:call-template>
    </xsl:if>
   
    <!-- Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-entity">
        <xsl:choose>
         <xsl:when test="entity[.='']">N</xsl:when>
         <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="show-country">Y</xsl:with-param>
       <xsl:with-param name="show-entity-button">N</xsl:with-param>
       <xsl:with-param name="entity-required">N</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="prefix">applicant</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="bg-alternative-applicant-details" />

    <!-- Beneficiary Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type">beneficiary</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
       <xsl:with-param name="show-country">Y</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Contact Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_CONTACT_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="button-type">contact</xsl:with-param>
      <xsl:with-param name="content">
      <xsl:if test="$displaymode='edit' or ($displaymode='view' and  
      (contact_name[.!=''] or contact_country[.!=''] or contact_address_line_1[.!=''] or 
      contact_address_line_2[.!=''] or contact_dom[.!=''] or contact_address_line_4[.!='']))">
       <xsl:call-template name="address">
        <xsl:with-param name="show-country">Y</xsl:with-param>
        <xsl:with-param name="prefix">contact</xsl:with-param>
        <xsl:with-param name="required">N</xsl:with-param>
       </xsl:call-template>
       </xsl:if>
      </xsl:with-param>
     </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  BG Amount Details
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="product-code">bg</xsl:with-param>
    </xsl:call-template> 
    <!-- MPS-41651 - Start -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()='bg_cur_code']"/></xsl:with-param>
     <xsl:with-param name="name">bg_available_amt</xsl:with-param>
     <xsl:with-param name="appendClass">outstanding</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="bg_available_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="bg_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="bg_available_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="bg_available_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    <!-- MPS-41651 - End -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()='bg_cur_code']"/></xsl:with-param>
     <xsl:with-param name="name">bg_liab_amt</xsl:with-param>
     <xsl:with-param name="appendClass">outstanding</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="bg_liab_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="bg_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="bg_liab_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="bg_liab_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Consortium Details -->
	<xsl:choose>
     <xsl:when test="$displaymode='edit'">
	      <xsl:call-template name="checkbox-field">
		      <xsl:with-param name="label">XSL_AMOUNTDETAILS_CONSORTIUM</xsl:with-param>
		      <xsl:with-param name="name">consortium</xsl:with-param>
		  </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
	     <xsl:if test="consortium[. = 'Y'] and $displaymode='view'">
	     <xsl:call-template name="row-wrapper">
			<xsl:with-param name="override-label">&nbsp;</xsl:with-param>
			<xsl:with-param name="content">
				<div class="content">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CONSORTIUM')"/>
			    </div>
			</xsl:with-param>
	     </xsl:call-template>
	     </xsl:if>
     </xsl:otherwise>
	</xsl:choose>
    <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">consortium_details</xsl:with-param>
      <xsl:with-param name="label">XSL_CONSORTIUM_DETAILS_LABEL</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">consortium_details</xsl:with-param>
        <xsl:with-param name="button-type"></xsl:with-param>
        <xsl:with-param name="rows">6</xsl:with-param>
        <xsl:with-param name="cols">35</xsl:with-param>
        <xsl:with-param name="maxlines">4</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
     <xsl:if test="$displaymode='edit' or ($displaymode='view' and net_exposure_amt != '')">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NET_EXPOSUER_LABEL</xsl:with-param>
      <xsl:with-param name="override-currency-name">net_exposure_cur_code</xsl:with-param>
      <xsl:with-param name="override-amt-name">net_exposure_amt</xsl:with-param>
      <xsl:with-param name="override-product-code">net_exposure</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     
		<!-- Charges -->
		<xsl:if test="$displaymode='edit' or ($displaymode='view' and open_chrg_brn_by_code != '')">
		<xsl:apply-templates select="open_chrg_brn_by_code">
			<xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
			<xsl:with-param name="label">XSL_CHRGDETAILS_BG_ISS_LABEL</xsl:with-param>
		</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$displaymode='edit' or ($displaymode='view' and corr_chrg_brn_by_code != '')">
		<xsl:apply-templates select="corr_chrg_brn_by_code">
			<xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
			<xsl:with-param name="label">XSL_CHRGDETAILS_BG_CORR_LABEL</xsl:with-param>
		</xsl:apply-templates>
		</xsl:if>

    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="name">bg_release_flag</xsl:with-param>
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_RELEASE</xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  BG Bank Details
  -->
 <xsl:template name="bank-details">
 
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
  
   <xsl:call-template name="recipient_bank">
     <xsl:with-param name="prefix" select="'recipient_bank'"/> 
   </xsl:call-template>
   
  <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    
   <!-- Tab 1_0 - Issuing Bank  -->
   <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_LOCAL_GUARANTOR</xsl:with-param>
   <xsl:with-param name="tab0-content"> 
   
   <xsl:if test="$displaymode='view'">
     <xsl:call-template name="select-field">
   		<xsl:with-param name="label">XSL_ISSUING_INSTRUCTIONS_LABEL</xsl:with-param>
  	    <xsl:with-param name="name">issuing_bank_type_code</xsl:with-param>
    	<xsl:with-param name="options">
    		<xsl:call-template name="bg-bankdetails-types"/>
   	   </xsl:with-param> 
    </xsl:call-template> 
  </xsl:if>
   
    <xsl:apply-templates select="issuing_bank">
     <xsl:with-param name="prefix" select="'issuing_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
   
   <!-- Tab 1_1 - Advising Bank  -->
   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
   <xsl:with-param name="tab1-content">
    <!-- Form #5 : Documents Required Details -->
    <xsl:apply-templates select="advising_bank">
     <xsl:with-param name="prefix" select="'advising_bank'"/>
    </xsl:apply-templates>
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_ADVISING_BANK_CONFIRMATION_REQUIRED</xsl:with-param>
     <xsl:with-param name="name">adv_bank_conf_req</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
   
   <!-- Tab 1_2 - Confirming Bank  -->
   <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_CONFIRMING_BANK</xsl:with-param>
   <xsl:with-param name="tab2-content">
    <!-- Form #5 : Documents Required Details -->
    <xsl:apply-templates select="confirming_bank">
     <xsl:with-param name="prefix" select="'confirming_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
   
   <!-- Tab 1_3 - Processing Bank  -->
   <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_PROCESSING_BANK</xsl:with-param>
   <xsl:with-param name="tab2-content">
    <xsl:apply-templates select="processing_bank">
     <xsl:with-param name="prefix" select="'processing_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
  </xsl:call-template> 
  </xsl:with-param>
  </xsl:call-template>
  
 </xsl:template>
 
 <xsl:template name="recipient_bank">
   <xsl:param name="prefix"/>
   <xsl:variable name="recipient-bank-name-value">
     <xsl:value-of select="//*[name()=$prefix]/name"/>
   </xsl:variable>
   
   <xsl:variable name="appl_ref">
	  <xsl:value-of select="applicant_reference"/>
   </xsl:variable>
   
		 <xsl:call-template name="input-field">
			<xsl:with-param name="label">
	          <xsl:choose>
	           <xsl:when test="lead_bank_flag[.='Y']">XSL_LEAD_BANK_NAME</xsl:when>
			   <xsl:when test="issuing_bank_type_code[.='02'] or (not(security:isBank($rundata)))">XSL_TRANSACTIONDETAILS_RECIPIENT_BANK</xsl:when>
			   <xsl:otherwise>XSL_BANKDETAILS_TAB_RECIPIENT_ISSUING_BANK</xsl:otherwise>
			  </xsl:choose>
           </xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
			<xsl:with-param name="value" select="$recipient-bank-name-value"/>
			<xsl:with-param name="readonly">Y</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
	  	   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
	  	   <xsl:with-param name="value">
	 	   	<xsl:choose>
           <xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
           <xsl:value-of select="utils:decryptApplicantReference(//*/customer_references/customer_reference[reference=$appl_ref]/reference)"/>
	  	   </xsl:when>
	  	    <xsl:otherwise>
            <xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
	  	   </xsl:otherwise></xsl:choose>
	  	 	   </xsl:with-param>
	  	   <xsl:with-param name="readonly">Y</xsl:with-param>
	  	   <xsl:with-param name="swift-validate">N</xsl:with-param>
	  	   <xsl:with-param name="id">recipient_bank_customer_reference </xsl:with-param>
  		</xsl:call-template>
			  
</xsl:template>
 
 <!--
  Remitting or collecting bank  
 -->
 <xsl:template match="advising_bank | confirming_bank | processing_bank | recipient_bank">
  <xsl:param name="prefix"/>

   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="value" select="name"/>
    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="override-product-code"><xsl:value-of select="product-code"/></xsl:with-param>
    <xsl:with-param name="override-form-name">form_<xsl:value-of select="$prefix"/></xsl:with-param>
   </xsl:call-template>
   
   <!-- Address Lines -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
    <xsl:with-param name="value" select="address_line_1"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
    <xsl:with-param name="value" select="address_line_2"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
    <xsl:with-param name="value" select="dom"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
    <xsl:with-param name="value" select="address_line_4"/>
   </xsl:call-template>
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
     <xsl:with-param name="value" select="reference"></xsl:with-param>
    </xsl:call-template>
   </div>
 </xsl:template>
 
 <!-- 
  -->
 <xsl:template match="issuing_bank">
  <xsl:param name="prefix"/>

  <xsl:call-template name="select-field">
   <xsl:with-param name="label">XSL_ISSUING_INSTRUCTIONS_LABEL</xsl:with-param>
   <xsl:with-param name="name">issuing_bank_type_code</xsl:with-param>
   <xsl:with-param name="options">
    <xsl:call-template name="bg-bankdetails-types"/>
   </xsl:with-param>
  </xsl:call-template> 

   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="value" select="name"/>
    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="override-product-code"><xsl:value-of select="product-code"/></xsl:with-param>
    <xsl:with-param name="override-form-name">form_<xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   
   <!-- Address Lines -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
    <xsl:with-param name="value" select="address_line_1"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
    <xsl:with-param name="value" select="address_line_2"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
    <xsl:with-param name="value" select="dom"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
    <xsl:with-param name="value" select="address_line_4"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">issuing_bank_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"/>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="name">issuing_bank_reference</xsl:with-param>
     <xsl:with-param name="value" select="reference"/>
     <xsl:with-param name="readonly">Y</xsl:with-param>
    </xsl:call-template>
   </div>
 </xsl:template>

</xsl:stylesheet>
