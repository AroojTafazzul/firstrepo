<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Export Letter of Credit (EL) Form, Bank Side
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    exclude-result-prefixes="localization securitycheck security">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">EL</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="el_tnx_record"/>
  </xsl:template>
 
 <!-- 
   EL TNX FORM TEMPLATE.
  -->
  <xsl:template match="el_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area, realform and top menu-->
    <xsl:call-template name="bank-reporting-area"/>
       <xsl:call-template name="build-inco-terms-data"/>
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
	

    
    <!-- Transaction details link and control -->
    <xsl:call-template name="transaction-details-link">
     <xsl:with-param name="show-transaction">
      <xsl:choose>
       <xsl:when test="tnx_type_code[.!='01'] and $displaymode='edit'">N</xsl:when>
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
     <xsl:if test="tnx_type_code[.='01']">
      <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
     </xsl:if>
     <!-- Form #0 : Main Form -->
     <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:if test="tnx_type_code[.!='01']">
        <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
       </xsl:if>
       
       <!-- Disclaimer Notice -->
       <xsl:call-template name="disclaimer"/>
       
       <xsl:call-template name="hidden-fields"/>
       <xsl:call-template name="lc-bank-general-details">
        <xsl:with-param name="additional-content">
         <xsl:if test="sub_tnx_type_code[.='12' or .='19'] or (tnx_type_code[.='01'] and tnx_stat_code[.='04'] and prod_stat_code[.='03'])">
          <xsl:call-template name="transfer-details"/>
         </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
       <xsl:choose>
        	<xsl:when test="$swift2018Enabled">
        		<xsl:call-template name="lc-amt-details-swift2018">
        		<xsl:with-param name="override-product-code">lc</xsl:with-param>
		        <xsl:with-param name="show-bank-confirmation">Y</xsl:with-param>
		        <xsl:with-param name="show-available-amt">Y</xsl:with-param>
		        <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		        <xsl:with-param name="show-standby">N</xsl:with-param>
		        <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.='01'] or lc_type[.='']">Y</xsl:if></xsl:with-param>
		        <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.='01'] or lc_type[.='02'] or lc_type[.='']">Y</xsl:if></xsl:with-param>
		       </xsl:call-template>
      		</xsl:when>
        	<xsl:otherwise>
        		<xsl:call-template name="lc-amt-details">
        		<xsl:with-param name="override-product-code">lc</xsl:with-param>
		        <xsl:with-param name="show-bank-confirmation">Y</xsl:with-param>
		        <xsl:with-param name="show-available-amt">Y</xsl:with-param>
		        <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		        <xsl:with-param name="show-standby">N</xsl:with-param>
		        <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.='01'] or lc_type[.='']">Y</xsl:if></xsl:with-param>
		        <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.='01'] or lc_type[.='']">Y</xsl:if></xsl:with-param>
		       </xsl:call-template>
        	</xsl:otherwise>
        </xsl:choose>
       
       <xsl:if test="lc_type[.='01'] or lc_type[.='']">
        <xsl:call-template name="lc-bank-payment-details"/>
        <xsl:choose>
        	<xsl:when test="$swift2018Enabled"><xsl:call-template name="lc-bank-shipment-details-swift2018"/></xsl:when>
        	<xsl:otherwise><xsl:call-template name="lc-bank-shipment-details"/></xsl:otherwise>
        </xsl:choose>
        <xsl:if test="securitycheck:hasPermission($rundata,'tradeadmin_ls_access') = 'true' or
       				securitycheck:hasPermission($rundata,'ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	 	 </xsl:if>
       </xsl:if>
       
       <xsl:if test="lc_type[.='02']">
        <xsl:call-template name="lc-narrative-full"/>
       </xsl:if>
        <xsl:call-template name="amendedNarrativesStore"/>
       <!-- Narrative Details -->
       <xsl:if test="lc_type[.='01'] or lc_type[.='']">
        <xsl:choose>
		<xsl:when test="($displaymode = 'view' and (($swift2018Enabled and tnx_type_code[.='09' or .='19'])or (tnx_type_code[.='13'] and sub_tnx_type_code[.='12' or .='19']) or ($swift2018Enabled and (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) or (not($swift2018Enabled)))) or ($displaymode = 'edit' and (not($swift2018Enabled)) or ($displaymode = 'edit' and $swift2018Enabled and (tnx_type_code[.='01'] or (tnx_type_code[.='13'] and sub_tnx_type_code[.='12' or .='19']))))">		        
		 	 <xsl:call-template name="lc-narrative-details">
					<xsl:with-param name="documents-required-required">
						<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'true'">
							<xsl:value-of select="'Y'"/>
						</xsl:if>
						<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'false'">
							<xsl:value-of select="'N'"/>
						</xsl:if>	
					</xsl:with-param>
					<xsl:with-param name="description-goods-required">
						<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'true'">
							<xsl:value-of select="'Y'"/>
						</xsl:if>
						<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'false'">
							<xsl:value-of select="'N'"/>
						</xsl:if>	
					</xsl:with-param>
				</xsl:call-template>
		          <xsl:choose>
			      	<xsl:when test = "$swift2018Enabled" >
			      		<xsl:if test = "$displaymode = 'edit'">
			      		<xsl:call-template name="lc-narrative-special-payments"/>
			      		</xsl:if>
			      		<xsl:if test = "$displaymode = 'view'">
			      		<xsl:call-template name="lc-narrative-special-payments-view"/>
			      		</xsl:if>
			      	</xsl:when>
			      	<xsl:otherwise>
			      	</xsl:otherwise>
			      </xsl:choose>
	      </xsl:when>
	      <xsl:otherwise>
	      	<div id="view-narrative-swift">
	      	<xsl:if test="$displaymode = 'edit' and $swift2018Enabled">
	      		<xsl:call-template name="view-narrative-swift-details"/>
	      		<xsl:call-template name="view-narrative-swift-special-payments"/>
	      	</xsl:if>	
	      	</div>
	      	<div id="amend_narratives_display">
		        <xsl:if test="$displaymode = 'edit' and $swift2018Enabled ">
		      	  <xsl:call-template name="lc-narrative-swift-details">
					<xsl:with-param name="documents-required-required">
						<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'true'">
							<xsl:value-of select="'Y'"/>
						</xsl:if>
						<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'false'">
							<xsl:value-of select="'N'"/>
						</xsl:if>	
					</xsl:with-param>
					<xsl:with-param name="description-goods-required">
						<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'true'">
							<xsl:value-of select="'Y'"/>
						</xsl:if>
						<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'false'">
							<xsl:value-of select="'N'"/>
						</xsl:if>	
					</xsl:with-param>
				   </xsl:call-template>
		         <xsl:call-template name="lc-narrative-swift-special-payments"/>
		        </xsl:if>
		        </div>
		        <xsl:if test="(not($swift2018Enabled)) or ($displaymode = 'view' and $swift2018Enabled) ">
			     <xsl:call-template name="fieldset-wrapper">
				    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
				    <xsl:with-param name="in-fieldset">Y</xsl:with-param>
				    <xsl:with-param name="content">
					<xsl:call-template name="previewModeExtendedNarrative"/>
					</xsl:with-param>
				</xsl:call-template> 
				</xsl:if>
		      </xsl:otherwise>
	      </xsl:choose>
        <xsl:choose>
        	<xsl:when test="$swift2018Enabled">
	        	 <!-- SWIFT 2018 :2 new Narratives for bank ELC -->
        		<xsl:call-template name="lc-narrative-charges-swift2018"/>
        		<xsl:call-template name="lc-bank-narrative-other-swift2018"/>
        		<xsl:call-template name="fieldset-wrapper">
				      <xsl:with-param name="legend">XSL_LEGACY_DETAILS_LABEL</xsl:with-param>
				      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
				      <xsl:with-param name="content">
				       <!-- <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE'] or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> -->
				       		<xsl:call-template name="legacy-template"/>
				       <!-- </xsl:if> -->
				      </xsl:with-param>
	     		</xsl:call-template>
        	</xsl:when>
        	<xsl:otherwise>
        		<xsl:call-template name="lc-narrative-charges"/>
        		<xsl:call-template name="lc-bank-narrative-other"/>
        	</xsl:otherwise>
        </xsl:choose>
       </xsl:if>
      </xsl:with-param>
     </xsl:call-template>
    </div>
    
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
   <xsl:with-param name="binding">misys.binding.bank.report_el</xsl:with-param>
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	    <xsl:when test="(tnx_type_code[.='01'])">EL_01</xsl:when>	
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
    <script type="text/javascript">
		dojo.ready(function(){
			misys._config.swiftExtendedNarrativeEnabled = <xsl:value-of select="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE')" />
			misys._config.isBank = <xsl:value-of select="security:isBank($rundata)"/>
		});
	</script>
 </xsl:template>
 
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="override-product-code">lc</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
   </xsl:call-template>
   <!-- Hard coded for time being, later send mode should be added -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">adv_send_mode</xsl:with-param>
    <xsl:with-param name="value">01</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">narrative_period_presentation_nosend</xsl:with-param>
	     <xsl:with-param name="value" select="narrative_period_presentation"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">companyNameRegexValue</xsl:with-param>
		 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('COMPANYNAME_VALIDATION_REGEX')"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">org_narrative_description_goods</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/el_tnx_record/narrative_description_goods"/>
	</xsl:call-template> 
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">org_narrative_documents_required</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/el_tnx_record/narrative_documents_required"/>
	</xsl:call-template> 
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">org_narrative_additional_instructions</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/el_tnx_record/narrative_additional_instructions"/>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">org_narrative_special_beneficiary</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/el_tnx_record/narrative_special_beneficiary"/>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">org_narrative_special_recvbank</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/el_tnx_record/narrative_special_recvbank"/>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_description_goods</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_description_goods"/>
	</xsl:call-template> 
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_documents_required</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_documents_required"/>
	</xsl:call-template> 
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_additional_instructions</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_additional_instructions"/>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_special_beneficiary</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_special_beneficiary"/>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_special_recvbank</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_special_recvbank"/>
	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">is798</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="is_MT798"/></xsl:with-param>
 	</xsl:call-template> 
  </div>
 </xsl:template>
 <!-- 
   Narrative details.
   
   Tab0 - Special payment conditions for Beneficiary
  		  For front office view only the 'Special payment conditions for beneficiary must be visible' 
  -->
  <xsl:template name="lc-narrative-special-payments-view">
  <xsl:param name="in-fieldset">Y</xsl:param>
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
    <!-- Tab 0 - Special payment conditions for Beneficiary -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
      <xsl:with-param name="maxlines">100</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'40'}</xsl:with-param>
       <xsl:with-param name="messageValue">
        <xsl:choose>
        	<xsl:when test="$swift2018Enabled and product_code = 'EL' and (((tnx_type_code = '13' and sub_tnx_type_code[.='12' or .='19']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)) or ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2']))"><xsl:value-of select="narrative_special_beneficiary"/></xsl:when>
        	<xsl:when test="$swift2018Enabled">
	   				<xsl:variable name="desc"><xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/></xsl:variable>
	   				<xsl:choose>
 		 					<xsl:when test="$desc != ''">
 		 						<xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/>
 		 					</xsl:when>
 		 					<xsl:otherwise><xsl:value-of select="//narrative_special_beneficiary/text"/></xsl:otherwise>
	   		 		</xsl:choose>
	   		</xsl:when>
		   	<xsl:otherwise><xsl:value-of select="narrative_special_beneficiary"/></xsl:otherwise>
		</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV</xsl:with-param>
      <xsl:with-param name="tab1-content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">narrative_special_recvbank</xsl:with-param>
        <xsl:with-param name="maxlines">100</xsl:with-param>
        <xsl:with-param name="phrase-params">{'category':'40'}</xsl:with-param>
         <xsl:with-param name="messageValue">
          <xsl:choose>
          	<xsl:when test="$swift2018Enabled and product_code = 'EL' and (((tnx_type_code = '13' and sub_tnx_type_code[.='12' or .='19']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)) or ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2']))"><xsl:value-of select="narrative_special_recvbank"/></xsl:when>	
  			<xsl:when test="$swift2018Enabled">
	   				<xsl:variable name="desc"><xsl:value-of select="//narrative_special_recvbank/issuance/data/datum/text"/></xsl:variable>
	   				<xsl:choose>
 		 					<xsl:when test="$desc != ''">
 		 						<xsl:value-of select="//narrative_special_recvbank/issuance/data/datum/text"/>
 		 					</xsl:when>
 		 					<xsl:otherwise><xsl:value-of select="//narrative_special_recvbank/text"/></xsl:otherwise>
	   		 		</xsl:choose>
	   		</xsl:when>
  		   	<xsl:otherwise><xsl:value-of select="narrative_special_recvbank"/></xsl:otherwise>
  		</xsl:choose>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>

    </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>