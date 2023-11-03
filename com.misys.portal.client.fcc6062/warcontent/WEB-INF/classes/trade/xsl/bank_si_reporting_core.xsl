<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for
 
Issued Standby LC (SI) Form, Bank Side.
 
Some templates beginning with lc- can be found in lc-common.xsl
 
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
   xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
   xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
   xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
   xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
   exclude-result-prefixes="localization utils security securitycheck defaultresource">
 
 <!--
  Global Parameters.
  These are used in the imported XSL, and to set global params in the JS
 -->
 <xsl:param name="rundata"/>
 <xsl:param name="language">en</xsl:param>
 <xsl:param name="mode">DRAFT</xsl:param>
 <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
 <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
 <xsl:param name="product-code">SI</xsl:param>
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
 
 <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 <xsl:template match="/">
   <xsl:apply-templates select="si_tnx_record"/>
 </xsl:template>
 
<!--
  SI TNX FORM TEMPLATE.
 -->
 <xsl:template match="si_tnx_record">
  <!-- Preloader  -->
  <xsl:call-template name="loading-message"/>
 
  <div>
   <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
 
   <!-- Display common reporting area -->
   <xsl:call-template name="bank-reporting-area"/>
    <xsl:call-template name="build-inco-terms-data"/>
	<xsl:call-template name="build-delivery-to-data"/>    
   
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
   
    <!-- Link to display transaction contents -->
	<xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and $displaymode='edit' or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
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
	
	 <xsl:call-template name="amendedNarrativesStore"/>
    
    <div id="transactionDetails">
     <xsl:if test="$displaymode='view'">
      <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
     </xsl:if>
     <!-- Form #0 : Main Form -->
     <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:if test="tnx_type_code[.!='01'] and tnx_type_code[.!='03']">
        <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
       </xsl:if>
       <!-- Disclaimer Notice -->
       <xsl:call-template name="disclaimer"/>
       <xsl:call-template name="hidden-fields"/>
       <xsl:call-template name="general-details"/>
 
      	<xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      		<xsl:call-template name="lc-amt-details-swift2018">
		         <xsl:with-param name="override-product-code">lc</xsl:with-param>
		         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
		         <xsl:with-param name="show-available-amt">Y</xsl:with-param>
        		 <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		         <xsl:with-param name="show-form-lc">Y</xsl:with-param>
		         <xsl:with-param name="show-variation-drawing">Y</xsl:with-param>
		         <xsl:with-param name="disable-standby-flag">Y</xsl:with-param>	
		        </xsl:call-template>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:call-template name="lc-amt-details">
		         <xsl:with-param name="override-product-code">lc</xsl:with-param>
		         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
		         <xsl:with-param name="show-available-amt">Y</xsl:with-param>
        		 <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		         <xsl:with-param name="show-form-lc">Y</xsl:with-param>
		         <xsl:with-param name="show-variation-drawing">Y</xsl:with-param>
		         <xsl:with-param name="disable-standby-flag">Y</xsl:with-param>		         
		        </xsl:call-template>
	      	</xsl:otherwise>
	     </xsl:choose>
 
       <xsl:call-template name="standby-lc-details">
       	<xsl:with-param name="isBank">Y</xsl:with-param>
       	<xsl:with-param name="isStructuredFormat">
       	<xsl:choose>
       		<xsl:when test="security:isBank($rundata) = 'true' and lc_type = '02' and securitycheck:hasPermission($rundata,'si_create_structured_format') = 'true'">Y</xsl:when>
       		<xsl:otherwise>N</xsl:otherwise>
       	</xsl:choose>
       	</xsl:with-param>
       </xsl:call-template>
       
        <xsl:call-template name="lc-renewal-details"/>
        <xsl:call-template name="payment-details"/>
        <xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      		<xsl:call-template name="lc-bank-shipment-details-swift2018"/>
	      		<xsl:call-template name="bank-details-swift2018"/>
 	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:call-template name="lc-bank-shipment-details"/>
	      		<xsl:call-template name="bank-details"/>
	      	</xsl:otherwise>
	     </xsl:choose>
       
 	<xsl:choose>
        <xsl:when test="($displaymode = 'view' and (not($swift2018Enabled))) or ($displaymode = 'edit' and (not($swift2018Enabled)) or ($displaymode = 'edit' and tnx_type_code[.='01'] and $swift2018Enabled) )">
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
	      		<xsl:call-template name="lc-narrative-special-payments"/>
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
				    <xsl:with-param name="content">
					<xsl:call-template name="previewModeExtendedNarrative"/>
					</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
	      </xsl:otherwise>
	      </xsl:choose>
        
          <xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
       			 <xsl:call-template name="lc-narrative-charges-swift2018"/>
       			  <xsl:call-template name="lc-bank-narrative-other-swift2018"/>
        	</xsl:when>
        	<xsl:otherwise>
	      		<xsl:call-template name="lc-narrative-charges"/>
	      		 <xsl:call-template name="lc-bank-narrative-other"/>
	      	</xsl:otherwise>
        </xsl:choose>
        
        <xsl:choose>
          <xsl:when test="$displaymode='edit' and (lc_type ='02' or (tnx_stat_code = '06' and narrative_full_details != ''))">
        	<xsl:call-template name="lc-narrative-full">
        		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
        		<xsl:with-param name="readonly">Y</xsl:with-param>
        		<xsl:with-param name="button-required">N</xsl:with-param>
            </xsl:call-template>  
          </xsl:when>
          <xsl:when test="$displaymode='view' and (narrative_full_details != '')">
          	<xsl:call-template name="lc-narrative-full">
          		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
          	</xsl:call-template>
          </xsl:when>
          </xsl:choose>
          
          <xsl:call-template name="fieldset-wrapper">
	      <xsl:with-param name="legend">XSL_LEGACY_DETAILS_LABEL</xsl:with-param>
	      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	      <xsl:with-param name="content">
	       <!-- <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE'] or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> -->
	       		<xsl:call-template name="legacy-template"/>
	       <!-- </xsl:if> -->
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:choose>
	      	<xsl:when test="$swift2019Enabled">
       			 <xsl:call-template name="si-bank-instructions"/>
       	   	</xsl:when>
        	<xsl:otherwise>
	      	</xsl:otherwise>
        </xsl:choose>
	     
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

<xsl:template name="payment-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">credit_available_with_bank</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="id">credit_available_with_bank</xsl:with-param>
     <xsl:with-param name="content">
     <xsl:call-template name="select-field">
    			 <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_TYPE</xsl:with-param>
    			 <xsl:with-param name="name">credit_available_with_bank_type</xsl:with-param>
    			 <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
    		     <xsl:with-param name="required">N</xsl:with-param>
    			 <xsl:with-param name="value">
    			  <xsl:choose>
    			  <xsl:when test="credit_available_with_bank_type[.!='']">
    					 		<xsl:value-of select="credit_available_with_bank_type"/>
    					 </xsl:when>
    					 <xsl:when test="credit_available_with_bank/name[.!='']">
    					 		<xsl:value-of select="credit_available_with_bank/name"/>
    					 </xsl:when>
    					<xsl:otherwise>
    							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
    					</xsl:otherwise>
    				</xsl:choose>	
    			   </xsl:with-param>
    			   <xsl:with-param name="options">
     			   <xsl:call-template name="bank-type-options"/>
    		</xsl:with-param>
   	  </xsl:call-template>
   	  <xsl:call-template name="lc-reporting-credit-available-with-bank">
       <xsl:with-param name="theNodeName">credit_available_with_bank</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="credit-available-by">
       <xsl:with-param name="show-drawee">N</xsl:with-param>
      </xsl:call-template>
      
      
    </xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
     	<xsl:choose>
	     <xsl:when test="$displaymode='view'">
	     <xsl:apply-templates select="drawee_details_bank">
	      <xsl:with-param name="theNodeName">drawee_details_bank/name</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="show-button">N</xsl:with-param>
	     </xsl:apply-templates>
	     </xsl:when>
	     <xsl:otherwise>
      <xsl:apply-templates select="drawee_details_bank">
       <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>
      </xsl:apply-templates>
      </xsl:otherwise>
	 </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
<!--                                     -->  
<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
<!--                                     -->
 
<!-- Additional JS imports for this form are -->
<!-- added here. -->
<xsl:template name="js-imports">
 <xsl:call-template name="common-js-imports">
  <xsl:with-param name="binding">misys.binding.bank.report_si</xsl:with-param>
  <xsl:with-param name="show-period-js">Y</xsl:with-param>   
  <xsl:with-param name="override-help-access-key">
           <xsl:choose>
                <xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
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
 
<!-- Additional hidden fields for this form are -->
<!-- added here. -->
<xsl:template name="hidden-fields">
 <xsl:call-template name="common-hidden-fields">
  <xsl:with-param name="show-type">Y</xsl:with-param>
  <xsl:with-param name="override-product-code">lc</xsl:with-param>
 </xsl:call-template>
 <div class="widgetContainer">
  <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">principal_act_no</xsl:with-param>
   <xsl:with-param name="value"><xsl:value-of select="principal_act_no"/></xsl:with-param>
  </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">adv_send_mode</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">narrative_period_presentation_nosend</xsl:with-param>
       <xsl:with-param name="value" select="narrative_period_presentation"/>
     </xsl:call-template>
  <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">fee_act_no</xsl:with-param>
   <xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">prv_pod_stat_code</xsl:with-param>
  </xsl:call-template>
   	<xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">org_lc_amt</xsl:with-param>
    	<xsl:with-param name="value" select="org_previous_file/si_tnx_record/lc_amt"/>
   	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
   		<xsl:with-param name="name">inc_amt</xsl:with-param>
   	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">dec_amt</xsl:with-param>
   	</xsl:call-template>
 <xsl:call-template name="hidden-field">
    		<xsl:with-param name="name">org_narrative_description_goods</xsl:with-param>
    		<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_description_goods"/>
 	</xsl:call-template> 
 	<xsl:call-template name="hidden-field">
    		<xsl:with-param name="name">org_narrative_documents_required</xsl:with-param>
    		<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_documents_required"/>
 	</xsl:call-template> 
 	<xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">org_narrative_additional_instructions</xsl:with-param>
    	<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_additional_instructions"/>
 	</xsl:call-template>
 	<xsl:call-template name="hidden-field">
    		<xsl:with-param name="name">org_narrative_special_beneficiary</xsl:with-param>
    		<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_special_beneficiary"/>
 	</xsl:call-template>
 	<xsl:call-template name="hidden-field">
    		<xsl:with-param name="name">org_narrative_special_recvbank</xsl:with-param>
    		<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_special_recvbank"/>
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
 SI General Details
 -->
<xsl:template name="general-details">
<xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
  <xsl:with-param name="content">
  <!-- The Issue Date needs to be shown only for a reporting,
          it is in the reporting section for the New Upload -->
    <xsl:if test="tnx_type_code[.='15' or .='13'] and $displaymode = 'edit'">
          <!-- Issue Date -->
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
           <xsl:with-param name="name">iss_date</xsl:with-param>
           <xsl:with-param name="size">10</xsl:with-param>
           <xsl:with-param name="maxsize">10</xsl:with-param>
           <xsl:with-param name="type">date</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
          </xsl:call-template>
   </xsl:if>
   
 <xsl:if test="$displaymode = 'view'">
 <xsl:if test="ref_id[.!='']">
   <xsl:call-template name="row-wrapper">
   <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
   <xsl:with-param name="content"><div class="content">
   <xsl:value-of select="ref_id"/></div>
   </xsl:with-param>
   </xsl:call-template>
 </xsl:if>
  <xsl:if test="appl_date[.!='']">
   <xsl:call-template name="row-wrapper">
   <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
   <xsl:with-param name="content"><div class="content">
   <xsl:value-of select="appl_date"/></div>
   </xsl:with-param>
   </xsl:call-template>
 </xsl:if>
  <xsl:if test="template_id[.!='']">
   <xsl:call-template name="row-wrapper">
   <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
   <xsl:with-param name="content"><div class="content">
   <xsl:value-of select="template_id"/></div>
   </xsl:with-param>
   </xsl:call-template>
 </xsl:if>
  <xsl:if test="cust_ref_id[.!='']">
   <xsl:call-template name="row-wrapper">
   <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
   <xsl:with-param name="content"><div class="content">
   <xsl:value-of select="cust_ref_id"/></div>
   </xsl:with-param>
   </xsl:call-template>
 </xsl:if>
 
 <!-- Bank Reference -->
   <!-- Shown in consolidated view -->
   <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id" />
    </xsl:call-template>
   </xsl:if>
 </xsl:if>
 <!-- Expiry Type -->
 <xsl:if test="$swift2019Enabled and $displaymode = 'edit'"> 
	<xsl:call-template name="select-field">
		<xsl:with-param name="label">
			<xsl:choose>
	     		<xsl:when test="$swift2019Enabled and tnx_type_code[.='03']">GENERALDETAILS_NEW_EXPIRY_TYPE</xsl:when>
	     		<xsl:otherwise>GENERALDETAILS_EXPIRY_TYPE</xsl:otherwise>
      		</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>
		<xsl:with-param name="fieldsize">small</xsl:with-param>
		<xsl:with-param name="options">
			<xsl:call-template name="exp-date-type-code-options"/>
	    </xsl:with-param>
    </xsl:call-template>
 </xsl:if>  
<xsl:if test="$swift2019Enabled and $displaymode = 'view'">
	<xsl:if test="lc_exp_date_type_code[.!='']">
		<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
		<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
		<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
		<xsl:variable name="parameterId">C085</xsl:variable>
		<xsl:call-template name="input-field">
		 	<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
		 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
		 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
		 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
		 </xsl:call-template>
	</xsl:if>
</xsl:if>
 <!-- Expiry Date -->
 <xsl:call-template name="input-field">
   <xsl:with-param name="label">
  	 <xsl:if test="$displaymode = 'view' and exp_date !=''"> 
  	    <xsl:choose>
     		<xsl:when test="$swift2018Enabled and tnx_type_code[.='03']">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:when>
     		<xsl:otherwise>XSL_GENERALDETAILS_EXPIRY_DATE</xsl:otherwise>
      	</xsl:choose>
      </xsl:if>
     <xsl:if test="$displaymode = 'edit'"> 
  	   	<xsl:choose>
     		<xsl:when test="$swift2018Enabled and tnx_type_code[.='03']">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:when>
     		<xsl:otherwise>XSL_GENERALDETAILS_EXPIRY_DATE</xsl:otherwise>
      	</xsl:choose>
     </xsl:if>
    </xsl:with-param>
  <xsl:with-param name="name">exp_date</xsl:with-param>
  <xsl:with-param name="size">10</xsl:with-param>
  <xsl:with-param name="maxsize">10</xsl:with-param>
  <xsl:with-param name="type">date</xsl:with-param>
  <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="required">
     <xsl:choose>
      <xsl:when test="$swift2019Enabled and lc_exp_date_type_code='01'">Y</xsl:when>
      <xsl:when test="$swift2019Enabled and (lc_exp_date_type_code='02' or lc_exp_date_type_code='03')">N</xsl:when>
      <xsl:otherwise>Y</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="disabled">
     <xsl:choose>
      <xsl:when test="$swift2019Enabled and lc_exp_date_type_code='03'">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
 </xsl:call-template>
 <xsl:if test="$swift2019Enabled and product_code[.='SI'] and security:isBank($rundata)">
	<xsl:if test="$displaymode = 'edit'">
 	 <div id="exp-event" style="display:none;">
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
	       <xsl:with-param name="messageValue"><xsl:value-of select="exp_event"/></xsl:with-param>
	      </xsl:call-template>
	     </xsl:with-param>
		</xsl:call-template>
	 </div>
	</xsl:if>
	<xsl:if test="$displaymode = 'view'">
		<xsl:if test="exp_event[.!='']">
	        <xsl:call-template name="big-textarea-wrapper">
			  <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
			  <xsl:with-param name="content">
			  	<div class="content">
			    	<xsl:value-of select="exp_event"/>
				</div>
			  </xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>
</xsl:if>
 <!-- Expiry Place -->
 <xsl:call-template name="input-field">
  <xsl:with-param name="label">
      <xsl:choose>
     		<xsl:when test="$swift2018Enabled and tnx_type_code[.='03']">XSL_GENERALDETAILS_NEW_EXPIRY_PLACE</xsl:when>
     		<xsl:otherwise>XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:otherwise>
      	</xsl:choose>
      </xsl:with-param>
  <xsl:with-param name="name">expiry_place</xsl:with-param>
  <xsl:with-param name="maxsize">29</xsl:with-param>
 </xsl:call-template>
 
  <xsl:if test="product_code[.='SI'] and purchase_order[.!=''] and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_PUO_REF_ID</xsl:with-param>
    <xsl:with-param name="name">purchase_order</xsl:with-param>
   <xsl:with-param name="readonly">Y</xsl:with-param>
   
   </xsl:call-template>
   </xsl:if>
   
 <xsl:if test="$displaymode = 'view'">
 	<xsl:if test="amd_no[.!='']">
	 	<xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
	      <xsl:with-param name="name">amd_no</xsl:with-param>
	      <xsl:with-param name="type">number</xsl:with-param>
	      <xsl:with-param name="size">2</xsl:with-param>
	      <xsl:with-param name="maxsize">3</xsl:with-param>
	     </xsl:call-template>
    </xsl:if>
      <xsl:if test="amd_date[.!='']">
	    <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
	      <xsl:with-param name="name">amd_date</xsl:with-param>
	      <xsl:with-param name="size">10</xsl:with-param>
	      <xsl:with-param name="fieldsize">small</xsl:with-param>
	      <xsl:with-param name="type">date</xsl:with-param>
	    </xsl:call-template>
	</xsl:if>
  <xsl:if test="iss_date[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'])">
          <!-- Issue Date -->
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
           <xsl:with-param name="name">iss_date</xsl:with-param>
           <xsl:with-param name="size">10</xsl:with-param>
           <xsl:with-param name="maxsize">10</xsl:with-param>
           <xsl:with-param name="type">date</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
          </xsl:call-template>
   </xsl:if>
</xsl:if>   
<!-- Place of Jurisdiction and Governing Law -->
   		<xsl:if test="$swift2019Enabled">
   		<xsl:if test="$displaymode='edit'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_LC_PLACE_OF_JURISDICTION</xsl:with-param>
				<xsl:with-param name="name">lc_govern_country</xsl:with-param>
				<xsl:with-param name="prefix">lc_govern</xsl:with-param>
				<xsl:with-param name="button-type">codevalue</xsl:with-param>
				<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				<xsl:with-param name="uppercase">Y</xsl:with-param>
				<xsl:with-param name="size">2</xsl:with-param>
				<xsl:with-param name="maxsize">2</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">  
				<xsl:with-param name="label">GOVERNING_LABEL</xsl:with-param>
				<xsl:with-param name="name">lc_govern_text</xsl:with-param>
				<xsl:with-param name="maxsize">65</xsl:with-param>
				<xsl:with-param name="swift-validate">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_DEMAND_INDICATOR</xsl:with-param>
			      <xsl:with-param name="name">demand_indicator</xsl:with-param>
			      <xsl:with-param name="required">N</xsl:with-param>
			      <xsl:with-param name="fieldsize">large</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:call-template name="demand-indicator"/>
			      </xsl:with-param>
			</xsl:call-template>
		</xsl:if>
			<xsl:if test="$displaymode='view'">
					<xsl:if test="lc_govern_country[.!='']">
					<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">XSL_LC_PLACE_OF_JURISDICTION</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="lc_govern_country"/>
	             </div></xsl:with-param>
	            </xsl:call-template>
	            </xsl:if>
	            <xsl:if test="lc_govern_text[.!='']">
				<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">GOVERNING_LABEL</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="lc_govern_text"/>
	             </div></xsl:with-param>
	            </xsl:call-template>
	            </xsl:if>
				<xsl:if test="demand_indicator[.!='']">
					<xsl:variable name="demand_indicator_code"><xsl:value-of select="demand_indicator"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C089</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_DEMAND_INDICATOR</xsl:with-param>
					 	<xsl:with-param name="name">demand_indicator</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $demand_indicator_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="ntrf_flag[.!=''] and ntrf_flag[.='N'] and narrative_transfer_conditions/text[.!='']">
					<xsl:call-template name="big-textarea-wrapper">
						<xsl:with-param name="label">TRANSFER_CONDITION</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="big-textarea-wrapper">
					  <xsl:with-param name="content">
					  	<div class="content">
					    	<xsl:value-of select="narrative_transfer_conditions/text"/>
						</div>
					  </xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>		
		</xsl:if>   
 <!-- Applicant Details. -->
 	<xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="button-type"><xsl:if test="tnx_type_code ='01' and release_dttm =''">bank-applicant</xsl:if></xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
        <xsl:with-param name="show-reference"><xsl:if test="$displaymode='view'">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="show-entity">
          <xsl:choose>
           <xsl:when test="entity =''">N</xsl:when>
           <xsl:otherwise>Y</xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
         <xsl:with-param name="show-entity-button"><xsl:if test="tnx_type_code ='01' and lc_type = '02'">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="entity-type">bank-entity</xsl:with-param>
         <xsl:with-param name="show-abbv"><xsl:if test="tnx_type_code ='01' and release_dttm =''">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="readonly"><xsl:if test="tnx_type_code ='01' and release_dttm =''">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="prefix">applicant</xsl:with-param>
        </xsl:call-template>
        
        <!-- Case of LC initiations on bank side : applicant must be selected and not keyed --> 
        <xsl:choose>
         <xsl:when test="tnx_type_code ='01' and release_dttm ='' and customer_references/customer_reference">
          <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
           <xsl:with-param name="name">applicant_reference</xsl:with-param>
           <xsl:with-param name="type">reference</xsl:with-param>
           <xsl:with-param name="options"><xsl:apply-templates select="customer_references/customer_reference"/></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
	       <xsl:with-param name="name">applicant_reference</xsl:with-param>
	       <xsl:with-param name="maxsize">34</xsl:with-param>
	       <xsl:with-param name="type">reference</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/></xsl:with-param>
	       <xsl:with-param name="swift-validate">N</xsl:with-param>
	      </xsl:call-template>
	     </xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
  
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
     <xsl:with-param name="prefix">beneficiary</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
</xsl:template>

 
<!--
 SI Bank Details
 -->
<xsl:template name="bank-details">
 <xsl:call-template name="tabgroup-wrapper">
  <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
 <!-- Tab 1_0 Issuing bank -->
   <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
   <xsl:with-param name="tab0-content">
     <xsl:call-template name="issuing_bank">
       <xsl:with-param name="prefix" select="'issuing_bank'"/>
     </xsl:call-template>
   </xsl:with-param>
 
  <!-- Tab 1_0 - Advising Bank  -->
  <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
  
  <xsl:with-param name="tab1-content">
   <!-- Documents Required Details -->
   
   <xsl:apply-templates select="advising_bank">          
    <xsl:with-param name="prefix">advising_bank</xsl:with-param>
        
   </xsl:apply-templates>
  </xsl:with-param>
  
  <!-- Tab 1_2 - Advise Thru Bank  -->
  <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
  
  <xsl:with-param name="tab2-content">
   <!-- Documents Required Details -->
   
  <xsl:apply-templates select="advise_thru_bank">
  
   <xsl:with-param name="prefix">advise_thru_bank</xsl:with-param>
   
        
   </xsl:apply-templates>
  </xsl:with-param>
 </xsl:call-template>
</xsl:template>

 <!-- Issuing bank -->
 <xsl:template name="issuing_bank">
   <xsl:param name="prefix"/>
   
   <xsl:variable name="issuing-bank-name-value">
     <xsl:value-of select="//*[name()=$prefix]/name"/>
   </xsl:variable>
   
   <xsl:variable name="appl_ref">
	  <xsl:value-of select="applicant_reference"/>
   </xsl:variable>
   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
	   <xsl:with-param name="value" select="$issuing-bank-name-value"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template> 
   
    <xsl:call-template name="input-field">
  	   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
  	   <xsl:with-param name="value">
  	   	<xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
  	   </xsl:with-param>
  	   <xsl:with-param name="readonly">Y</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 
<!--
 Advising / Advise Thru Bank
-->
 
<xsl:template match="advising_bank | advise_thru_bank">
 <xsl:param name="prefix"/>
 <xsl:param name="disabled">N</xsl:param>
 
 
   
 <!-- Name. -->
 <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
  <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>   
  <xsl:with-param name="value" select="name"/>
  <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
  <xsl:with-param name="type"><xsl:value-of select="$prefix"/></xsl:with-param>
  <xsl:with-param name="override-product-code"><xsl:value-of select="product-code"/></xsl:with-param>
  <xsl:with-param name="disabled" select="$disabled"/>   
 </xsl:call-template>
  
 <!-- Address Lines -->
 <xsl:call-template name="input-field">
  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
   
  <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
  <xsl:with-param name="value" select="address_line_1"/>
  <xsl:with-param name="disabled" select="$disabled"/>
 </xsl:call-template>
 <xsl:call-template name="input-field">
  <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
  <xsl:with-param name="value" select="address_line_2"/>
  <xsl:with-param name="disabled" select="$disabled"/> 
 </xsl:call-template>
 <xsl:call-template name="input-field">
  <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
  <xsl:with-param name="value" select="dom"/>
  <xsl:with-param name="disabled" select="$disabled"/>  
 </xsl:call-template>
 
   <xsl:call-template name="input-field">
  <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
  <xsl:with-param name="value" select="address_line_4"/>
   
 </xsl:call-template>
 
  <xsl:call-template name="input-field">
    <xsl:with-param name="label">
    	<xsl:choose>
     		<xsl:when test="$swift2018Enabled">XSL_PARTIESDETAILS_SWIFT_CODE</xsl:when>
     		<xsl:otherwise>XSL_JURISDICTION_BIC_CODE</xsl:otherwise>
      	</xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
    <xsl:with-param name="value" select="iso_code"/>
    <xsl:with-param name="size">11</xsl:with-param>
    <xsl:with-param name="maxsize">11</xsl:with-param>
    <xsl:with-param name="disabled" select="$disabled"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
    <xsl:with-param name="value" select="reference"/>
    <xsl:with-param name="size">16</xsl:with-param>
    <xsl:with-param name="maxsize">16</xsl:with-param>
    <xsl:with-param name="disabled" select="$disabled"/>
   </xsl:call-template>
</xsl:template>
<xsl:template name="si-bank-instructions">
<xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="content">
   <xsl:if test="$swift2019Enabled and product_code[.='SI'] and tnx_type_code[.!='13'] ">
	     	<xsl:if test="$displaymode = 'edit'"> 
				<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
			      <xsl:with-param name="name">delv_org</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:call-template name="delivery-mode-options"/>
			      </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="input-field">
			       <xsl:with-param name="name">delv_org_text</xsl:with-param>
			       <xsl:with-param name="size">35</xsl:with-param>
			       <xsl:with-param name="maxsize">35</xsl:with-param>
			       	<xsl:with-param name="disabled">
				       <xsl:choose>
			     		<xsl:when test="delv_org[.='99']">N</xsl:when>
			     		<xsl:otherwise>Y</xsl:otherwise>
			   		   </xsl:choose>
			   		</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
			      <xsl:with-param name="name">delivery_to</xsl:with-param>
			      <xsl:with-param name="fieldsize">small</xsl:with-param>
			      <xsl:with-param name="options"></xsl:with-param>
			     </xsl:call-template>
					<xsl:call-template name="row-wrapper">
					    <xsl:with-param name="id">narrative_delivery_to</xsl:with-param>
					    <xsl:with-param name="label">N002_BLANK</xsl:with-param>
					    <xsl:with-param name="type">textarea</xsl:with-param>
					    <xsl:with-param name="content">
					     <xsl:call-template name="textarea-field">
					      	<xsl:with-param name="name">narrative_delivery_to</xsl:with-param>
					      	<xsl:with-param name="messageValue"><xsl:value-of select="narrative_delivery_to/text"/></xsl:with-param>
      						<xsl:with-param name="phrase-params">{'category':'62'}</xsl:with-param>
				      		<xsl:with-param name="cols">35</xsl:with-param>
      						<xsl:with-param name="rows">6</xsl:with-param>
			  				<xsl:with-param name="maxlines">6</xsl:with-param>
					       <xsl:with-param name="swift-validate">Y</xsl:with-param>
					     </xsl:call-template>
					    </xsl:with-param>
					</xsl:call-template>	
			</xsl:if>
			<xsl:if test="$displaymode = 'view'">
				<xsl:if test="delv_org[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
					 	<xsl:with-param name="name">delv_org</xsl:with-param>
					 	<xsl:with-param name="value">
					 	<xsl:choose>
										<xsl:when test="delv_org[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COLLECTION')"/></xsl:when>
										<xsl:when test="delv_org[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COURIER')"/></xsl:when>
										<xsl:when test="delv_org[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MAIL')"/></xsl:when>
										<xsl:when test="delv_org[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MESSENGER')"/></xsl:when>
										<xsl:when test="delv_org[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_REGISTERED_MAIL')"/></xsl:when>
										<xsl:when test="delv_org[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_OTHER')"/></xsl:when>
						</xsl:choose>
						</xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delv_org_text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">delv_org_text</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="delv_org_text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delivery_to[.!=''] or narrative_delivery_to/text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
					 	<xsl:with-param name="name">delv_to</xsl:with-param>
					 	<xsl:with-param name="value">
									<xsl:variable name="delv_to_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>								
									<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
						</xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="narrative_delivery_to/text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">narrative_delivery_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="narrative_delivery_to/text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
   		</xsl:if>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>