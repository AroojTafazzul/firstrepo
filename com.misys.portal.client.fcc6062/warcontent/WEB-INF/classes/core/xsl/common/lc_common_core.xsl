<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all Letter of Credit forms (i.e. LC, SI, EL, SR).
This is divided into three sections; the first lists common templates
for the customer side, the second common templates for the bank side and the third
templates common to both.

Letter of Credit forms should import this template after importing
trade_common.xsl (on the customer side) or bank_common.xsl (on the bank
side).

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
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
  exclude-result-prefixes="localization utils security defaultresource securitycheck">
  
  <xsl:param name="trade_total_combined_sizeallowed"/>
  <!-- Common templates for swift 2018 changes are placed in lc_common_swift2018-->
   <xsl:include href="../swift/lc_common_swift.xsl" />
     <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
  <xsl:param name="section_line_item_po_reference"></xsl:param>
  <xsl:param name="section_line_item_total_net_amount_details"></xsl:param>
 <!--
  ########################################################################
  #1 - CUSTOMER SIDE TEMPLATES
 
  Below, all templates for LC-based forms on the customer side
  ########################################################################
  -->
 
  <!--
   General Details Fieldset.
    
   Expiry Date, Expiry Place, Eucp (optional), Applicant Details,
   Beneficiary Details.
   
   ** Notes **
   1. Unlike LC, in SI Expiry Date and Place are not required
   ***********
  -->
  
  <xsl:template name="lc-general-details">
   <xsl:if test="$displaymode='edit'">
    <div>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">iss_date</xsl:with-param>
      <xsl:with-param name="value">
      	<xsl:choose>
      		<xsl:when test="is_MT798[.='Y'] and product_code = 'LC' and $displaymode='edit' and tnx_type_code[.='01'] and security:isCustomer($rundata)">
      			<xsl:value-of select="convertTools:currentDateToDateString($language)"></xsl:value-of>
      		</xsl:when>
      		<xsl:otherwise></xsl:otherwise>
      	</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
    </div>
   </xsl:if>
   <!-- Issue Date -->
   <!-- Displayed in consolidated view -->
   <xsl:if test="$displaymode='view'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   
	<xsl:if test="$swift2019Enabled and product_code[.='SI'] and security:isCustomer($rundata)">
		<xsl:if test="$displaymode = 'edit'"> 
			<xsl:call-template name="select-field">
			<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
			<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			 <xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="options">
			<xsl:call-template name="exp-date-type-code-options"/>
		     </xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
	</xsl:if>
	
	<xsl:if test="$swift2019Enabled and product_code[.='SI'] and security:isCustomer($rundata)">
		<xsl:if test="$displaymode = 'view'">
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
	</xsl:if>
   
   <!--  Expiry Date. --> 
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
    <xsl:with-param name="name">exp_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="swift-validate">N</xsl:with-param>
    <xsl:with-param name="required">
     <xsl:choose>
      <xsl:when test="$product-code='LC' or $product-code='EL'">Y</xsl:when>
      <xsl:when test="$product-code='SI' and ($swift2019Enabled and lc_exp_date_type_code='01')">Y</xsl:when>
      <xsl:when test="$product-code='SI' and $swift2019Enabled and (lc_exp_date_type_code='02' or lc_exp_date_type_code='03')">N</xsl:when>
      <xsl:when test="$product-code='SI' and $swift2018Enabled">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="disabled">
    <xsl:choose>
      <xsl:when test="$product-code='SI' and $swift2019Enabled and lc_exp_date_type_code='03'">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
<xsl:if test="$swift2019Enabled and product_code[.='SI'] and security:isCustomer($rundata)">
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
	        <xsl:with-param name="required">Y</xsl:with-param>
	      </xsl:call-template>
	     </xsl:with-param>
		</xsl:call-template>
	 </div>
	</xsl:if>
	<xsl:if test="$displaymode = 'view'">
		<xsl:if test="exp_event[.!='']">
			<xsl:call-template name="big-textarea-wrapper-narrative">
				<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
					<xsl:with-param name="content">					
						<xsl:value-of select="exp_event" />
					</xsl:with-param>
			</xsl:call-template>										
		</xsl:if>
	</xsl:if>
</xsl:if>
 <xsl:if test="$displaymode = 'view' and amd_date[.!=''] and $product-code='SI'">

           <xsl:call-template name="row-wrapper">

           <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>

           <xsl:with-param name="content"><div class="content">

           <xsl:value-of select="amd_date"/></div>

           </xsl:with-param>

           </xsl:call-template>

   </xsl:if>
 <!-- Expiry place. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
    <xsl:with-param name="name">expiry_place</xsl:with-param>
    <xsl:with-param name="required">
     <xsl:choose>
      <xsl:when test="$product-code='LC'">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="maxsize">29</xsl:with-param>
   </xsl:call-template>
   
   <xsl:if test="$swift2019Enabled and product_code[.='SI'] and security:isCustomer($rundata)">
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
			<xsl:if test="$displaymode = 'view'">
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
					<xsl:call-template name="big-textarea-wrapper-narrative">
						<xsl:with-param name="label">TRANSFER_CONDITION</xsl:with-param>
						<xsl:with-param name="content">			
							<xsl:value-of select="narrative_transfer_conditions/text" />
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:if>
				<xsl:if test="delv_org[.!='']">
					<xsl:variable name="delv_org_code"><xsl:value-of select="delv_org"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C083</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
					 	<xsl:with-param name="name">delv_org</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
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
					<xsl:variable name="delv_org_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C084</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
					 	<xsl:with-param name="name">delv_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="narrative_delivery_to/text[.!='']">
				      <xsl:call-template name="big-textarea-wrapper">
					  <xsl:with-param name="content">
					  	<div class="content">
					    	<xsl:value-of select="narrative_delivery_to/text"/>
						</div>
					  </xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
	</xsl:if>
    <!-- PO Reference -->
 <xsl:if test="product_code[.='LC'] and securitycheck:hasPermission($rundata,'lc_display_po_reference') and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">  
 <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_PUO_REF_ID</xsl:with-param>
    <xsl:with-param name="name">purchase_order</xsl:with-param>
    <xsl:with-param name="maxsize">2000</xsl:with-param>
   </xsl:call-template>
   </xsl:if>
   
    <xsl:if test="product_code[.='SI'] and securitycheck:hasPermission($rundata,'si_display_po_reference') and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
  <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_PUO_REF_ID</xsl:with-param>
    <xsl:with-param name="name">purchase_order</xsl:with-param>
    <xsl:with-param name="maxsize">2000</xsl:with-param>
   </xsl:call-template>
   </xsl:if>
   
   <xsl:if test="amd_no[.!='']">
   		<xsl:call-template name="row-wrapper">
 	         <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
 	         <xsl:with-param name="content"><div class="content">
 	           <xsl:value-of select="utils:formatAmdNo(amd_no)"/>
 	 	     </div></xsl:with-param>
 	 	</xsl:call-template>
   </xsl:if>
   
   <xsl:if test="product_code = 'LC' and sub_tnx_type_code[.!='06'] and prod_stat_code[.!='03']">
   <div id="pro-check-box">
   	        	<xsl:choose>
		          	<xsl:when test="$displaymode='view'">
			         	 <xsl:choose>
			          		<xsl:when test="provisional_status = 'Y'">
			          			<xsl:call-template name="input-field">
			          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_PROVISIONAL')"/>
			          			</xsl:call-template>
			           		</xsl:when>
			         	</xsl:choose>
		          	</xsl:when>
		          	<xsl:otherwise>
					     <xsl:call-template name="checkbox-field">
						     <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
						     <xsl:with-param name="name">provisional_status</xsl:with-param>
						 </xsl:call-template>
		          	</xsl:otherwise>
          		</xsl:choose>
		 </div>
   </xsl:if> 
   <!-- 
    Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
    Pass in a show-presentation parameter set to Y to display the presentation fields.
    
    If set to N, the template will instead insert a hidden field with the value 1.0
   -->
   <xsl:call-template name="eucp-details">
    <xsl:with-param name="show-eucp" select="$show-eucp"/>
   </xsl:call-template>
   
   <!-- Applicant Details -->
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="address">
      <xsl:with-param name="show-entity">Y</xsl:with-param>
      <xsl:with-param name="prefix">applicant</xsl:with-param>
     </xsl:call-template>
     <!-- <xsl:if test="product_code[.='SI' or .='LC'] and applicant_reference[.!=''] and $displaymode='view'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
       <xsl:with-param name="name">applicant_reference</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="ref"><xsl:value-of select="applicant_reference"/></xsl:variable>
        	<xsl:choose>
					<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$ref]) &gt;= 1">
						<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$ref]/description"/>
					</xsl:when>
					<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$ref]) = 0">
						<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$ref]/description"/>
					</xsl:when>
			</xsl:choose>
         </xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
    </xsl:if> -->
     <!--
      If we have to, we show the reference field for applicants. This is
      specific to this form.
      -->
      <xsl:if test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
       <xsl:with-param name="name">applicant_reference</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="ref"><xsl:value-of select="applicant_reference"/></xsl:variable>
         <xsl:value-of select="utils:decryptApplicantReference($ref)"/>
         </xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
       <xsl:with-param name="swift-validate">N</xsl:with-param>
      </xsl:call-template>
     </xsl:if> 
    </xsl:with-param>
   </xsl:call-template>
   
   <xsl:if test="$product-code='LC' and (sub_tnx_type_code[.!='06'] or (normalize-space(sub_tnx_type_code)=''))">
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_ALTERNATE_PARTY_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:if test="$displaymode = 'edit'">
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_FOR_THE_ACCOUNT_OF</xsl:with-param>
     <xsl:with-param name="name">for_account_flag</xsl:with-param>
    </xsl:call-template>
     <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">alt_applicant_cust_ref</xsl:with-param>
		</xsl:call-template>
    </xsl:if>
    <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and for_account_flag = 'Y'">
      <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_NAME</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_name</xsl:with-param>
		   <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_name[.!='']"><xsl:value-of select="alt_applicant_name"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_address_line_1</xsl:with-param>
	       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS1_TRADE_LENGTH')"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_address_line_1[.!='']"><xsl:value-of select="alt_applicant_address_line_1"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="name">alt_applicant_address_line_2</xsl:with-param>
	       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS2_TRADE_LENGTH')"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_address_line_2[.!='']"><xsl:value-of select="alt_applicant_address_line_2"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="name">alt_applicant_dom</xsl:with-param>
	        <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('DOM_TRADE_LENGTH')"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_dom[.!='']"><xsl:value-of select="alt_applicant_dom"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_COUNTRY</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_country</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_country[.!='']"><xsl:value-of select="localization:getCodeData($language,'*','*','C006',alt_applicant_country)"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:if test="alt_applicant_cust_ref[.!='']">
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_ALTERNATE_APPLICANT_REF</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_cust_ref</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="alt_applicant_cust_ref"/></xsl:with-param>
	       </xsl:call-template>
	       </xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       </xsl:when>
      <xsl:when test="$displaymode = 'edit'">
	      <div id="alternate-party-details" style="display:none;">
	      	<xsl:call-template name="lc-alternative-applicant-details" />
	      </div>
      </xsl:when>
      </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  
   <!-- Beneficiary Details -->
   <!-- Hide it from LC Upload -->
   <xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type"></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
	   <xsl:with-param name="reg-exp"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_VALIDATION_REGEX')"/></xsl:with-param>       
       <xsl:with-param name="show-country">Y</xsl:with-param>
       <xsl:with-param name="required-country">Y</xsl:with-param>
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
   
   <!-- issuing bank -->
   <xsl:if test="$displaymode = 'view' and $product-code='LC'">
    <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="issuing_bank">
         <xsl:with-param name="theNodeName">issuing_bank</xsl:with-param>
         <xsl:with-param name="show-button">Y</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>
   </xsl:if>
  </xsl:template> 
  
  <!--
   Payment Details Fieldset.
   
   Credit Available With Bank.
   -->
  <xsl:template name="lc-payment-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Credit Available With -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:apply-templates select="credit_available_with_bank" mode="select"/>
       <xsl:call-template name="credit-available-by"/>
      </xsl:with-param>
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
        <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
        <xsl:with-param name="prefix">alt_applicant</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!--
  Credit Available With. (Select Mode)
  
  Credit Available Bank Type, Credit Available By, Payment/Draft At, Drawee Details.
  -->
  <xsl:template match="credit_available_with_bank" mode="select">
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_TYPE</xsl:with-param>
    <xsl:with-param name="name">credit_available_with_bank_type</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="options">
     <xsl:call-template name="bank-type-options"/>
    </xsl:with-param>
   </xsl:call-template>
   
   <!-- Hidden Fields. -->
   <xsl:if test="$displaymode='edit'">
    <div>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">credit_available_with_bank_iso_code</xsl:with-param>
      <xsl:with-param name="value" select="iso_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">credit_available_with_bank_reference</xsl:with-param>
      <xsl:with-param name="value" select="reference" />
     </xsl:call-template>
    </div>
   </xsl:if>
   
   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
    <xsl:with-param name="name">credit_available_with_bank_name</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value">
     <xsl:value-of select="localization:getCodeData($language,'*','*','C098', type)"/>
    </xsl:with-param>
    <xsl:with-param name="button-type">credit_available_with_bank_other</xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <script>
		dojo.ready(function()
			{
				if(misys._config.swiftRelatedSections !== undefined)
				{
					misys._config.swiftRelatedSections.push('credit_available_with_bank');
				}
			});
   </script>
   
  
   <!-- Address Lines -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
    <xsl:with-param name="name">credit_available_with_bank_address_line_1</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS1_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_1"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name">credit_available_with_bank_address_line_2</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS2_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_2"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name">credit_available_with_bank_dom</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('DOM_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="dom"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name">credit_available_with_bank_address_line_4</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS4_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_4"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
    
   </xsl:call-template>
   <script>
    dojo.ready(function(){ 
		dojo.mixin(misys._config, {
				trade_total_combined_sizeallowed :'<xsl:value-of select="defaultresource:getResource('TRADE_TOTAL_COMBINED_SIZEALLOWED')"/>',
				purchase_order_assistant:'<xsl:value-of select="defaultresource:getResource('PURCHASE_ORDER_ASSISTANT')"/>'
		});
	});   
	</script>
  </xsl:template>
  
  
  <!-- 
   Credit Available By. 
   
   ** Notes **
   1. Don't use address template, because of specific things for these fields.
   ***********
  -->
  <xsl:template name="credit-available-by">
   <xsl:param name="show-drawee">Y</xsl:param>
  
   <!-- Credit Available By radio buttons. -->
   <xsl:apply-templates select="cr_avl_by_code">
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL</xsl:with-param>
   </xsl:apply-templates>

  <!-- 
    Hidden by default in edit mode, or in view mode when
    cr_avl_by_code is not a mixed payment. 
  -->
  <div id="draft-term">
   <xsl:if test="$displaymode='edit' or ($displaymode='view' and cr_avl_by_code[.!='05'])">
    <xsl:attribute name="style">display:none</xsl:attribute>
   </xsl:if>
   <xsl:choose>

	  <xsl:otherwise>
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="id">draft_term</xsl:with-param>
	    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED_DETAILS</xsl:with-param>
	    <xsl:with-param name="type">textarea</xsl:with-param>
	    <xsl:with-param name="content">
	     <xsl:call-template name="textarea-field">
	      <xsl:with-param name="name">draft_term</xsl:with-param>
	      <xsl:with-param name="rows">4</xsl:with-param>
	      <xsl:with-param name="cols">35</xsl:with-param>
	      <xsl:with-param name="maxlines">4</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="view-style">
	      	<xsl:choose>
	  			<xsl:when test="$displaymode='view' and cr_avl_by_code[.='05']">display:inline-table</xsl:when>
	  			<xsl:otherwise></xsl:otherwise>
	  		</xsl:choose>
	  	 </xsl:with-param>
	     </xsl:call-template>
	    </xsl:with-param>
	   </xsl:call-template>
	  </xsl:otherwise>
   </xsl:choose>   
  </div>
     <!--
    Payment/Draft At fields.
    
    Hidden fields, that depend on the radio button selected in Credit Available By.
   -->
   <xsl:call-template name="lc-payment-draft-fields">
    <xsl:with-param name="show-drawee"><xsl:value-of select="$show-drawee"/></xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Shipment Details Fieldset.
   -->
  <xsl:template name="lc-shipment-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:with-param>
      <xsl:with-param name="name">ship_from</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_LOADING</xsl:with-param>
      <xsl:with-param name="name">ship_loading</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_DISCHARGE</xsl:with-param>
      <xsl:with-param name="name">ship_discharge</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_TO</xsl:with-param>
      <xsl:with-param name="name">ship_to</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="part_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:when test="part_ship_detl[. = 'NONE']">NONE</xsl:when>
        <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">OTHER</xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
         <option value="ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
         <option value="NONE">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/>
         </option>
         <option value="OTHER">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/>
         </option>
        </xsl:when>
        <xsl:otherwise>
        <xsl:if test="part_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="part_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/></xsl:when>
          <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">part_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="part_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:when test="tran_ship_detl[. = 'NONE']">NONE</xsl:when>
        <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">OTHER</xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	      <option value="NONE">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/>
	      </option>
	      <option value="OTHER">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/>
	      </option>
        </xsl:when>
        <xsl:otherwise>

         <xsl:if test="tran_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">tran_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="tran_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="swift-validate">N</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="purchase-terms-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
      <xsl:with-param name="name">inco_place</xsl:with-param>
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$product-code='LC' and ($displaymode='edit' or ($displaymode='view' and transport_mode[.!='']))">
    	 <xsl:call-template name="transport-mode-fields"/>
     </xsl:if>           
    </xsl:with-param>    
   </xsl:call-template>      
  </xsl:template>
 
  <!-- 
   Bank Details Tabgroup.
   
   Tab0 - Issuing Bank
   Tab1 - Advising Bank
   Tab2 - Advise Thru Bank
   -->
  <xsl:template name="lc-bank-details">
  <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">250px</xsl:with-param>

    <!-- Tab 0_0 - Issuing Bank  -->
    <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:call-template name="issuing-bank-tabcontent"/>
    </xsl:with-param>
     
    <!-- Tab 0_1 - Advising Bank -->
    <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
    <xsl:with-param name="tab1-content">
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and (advising_bank/name !=''  or advising_bank/iso_code !=''))">
       <xsl:apply-templates select="advising_bank">
        <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
       </xsl:apply-templates>
       </xsl:if>
    </xsl:with-param>
     
    <!-- Tab 0_2 - Advise Thru Bank -->
    <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_BENEFICIARY_BANK</xsl:with-param>
    <xsl:with-param name="tab2-content">
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and (advise_thru_bank/name !=''  or advise_thru_bank/iso_code !=''))">
       <xsl:apply-templates select="advise_thru_bank">
        <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
        <xsl:with-param name="swift-required">Y</xsl:with-param>
       </xsl:apply-templates>
       </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
    <script>
		dojo.ready(function()
		 {
		 	if(misys._config.swiftRelatedSections !== undefined) {
		  	misys._config.swiftRelatedSections.push('advise_thru_bank'); 
		  } 
		  });
	</script>
  
  
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
    Drawee Details Bank Options.
  -->
  <xsl:template name="drawee-details-banks">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="Issuing Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')"/>
     </option>
     <option value="Confirming Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')"/>
     </option>
     <option value="Advising Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')"/>
     </option>
     <option value="Negotiating Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')"/>
     </option>
     <option value="Reimbursing Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')"/>
     </option>
     <option value="Applicant">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')"/>
     </option>
     <option value="Other">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="drawee_details_bank/name[translate(.,$up,$lo)='issuing bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')"/></xsl:when>
      <xsl:when test="drawee_details_bank/name[translate(.,$up,$lo)='confirming bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')"/></xsl:when>
      <xsl:when test="drawee_details_bank/name[translate(.,$up,$lo)='advising bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')"/></xsl:when>
      <xsl:when test="drawee_details_bank/name[translate(.,$up,$lo)='negotiating bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')"/></xsl:when>
      <xsl:when test="drawee_details_bank/name[translate(.,$up,$lo)='reimbursing bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')"/></xsl:when>
      <xsl:when test="drawee_details_bank/name[translate(.,$up,$lo)='applicant']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_OTHER')"/></xsl:otherwise>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
 <!--
  ########################################################################
  #2 - BANK SIDE TEMPLATES
 
  Below, all templates for LC-based forms on the bank side
  ########################################################################
  -->
  
  <!-- 
   Common General Details for LC-based forms on the bank side 
  -->
  <xsl:template name="lc-bank-general-details">
  <xsl:param name="show-applicant">Y</xsl:param>
  <xsl:param name="show-issuing-bank-ref">Y</xsl:param>
  <xsl:param name="show-issue-date">Y</xsl:param>
  <xsl:param name="show-expiry-date">Y</xsl:param>
  <xsl:param name="show-expiry-place">Y</xsl:param>
  <xsl:param name="additional-content"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:if test="$displaymode='view'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="value" select="ref_id" />
      </xsl:call-template>
     </xsl:if>
     
     <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
      </xsl:call-template>
     </xsl:if>
    
     <!-- Issuing Bank Reference -->
     <xsl:if test="$show-issuing-bank-ref = 'Y'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
      <xsl:with-param name="name">lc_ref_id</xsl:with-param>
      <xsl:with-param name="size">16</xsl:with-param>
      <xsl:with-param name="maxsize">16</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     
     <xsl:if test="$displaymode='view' and bo_ref_id[.!=''] and product_code [.='SR'] and tnx_type_code[.='01']">
     <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="bo_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
     </xsl:if>
    
     <!-- Issue Date -->
     <xsl:if test="$show-issue-date = 'Y'">
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
     <xsl:if test="$swift2019Enabled and product_code[.='SR']">
		<xsl:if test="$displaymode = 'edit'"> 
			<xsl:call-template name="select-field">
			<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
			<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			 <xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="options">
			<xsl:call-template name="exp-date-type-code-options"/>
		     </xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
	</xsl:if>
        	<xsl:if test="$swift2019Enabled and $displaymode = 'view' and product_code [.='SR']">
				<xsl:if test="lc_exp_date_type_code[.!='']">
					<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C088</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
					 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
					 </xsl:call-template>
				</xsl:if>
			</xsl:if>	
    
     <!-- Expiry Date -->
     <xsl:if test="$show-expiry-date = 'Y'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required"><xsl:if test="$product-code='LC' or $product-code='EL' or $product-code='SR'">Y</xsl:if></xsl:with-param>
     </xsl:call-template>
     </xsl:if>
    
    <xsl:if test="$swift2019Enabled and product_code[.='SR'] and security:isBank($rundata)">
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
	       <xsl:with-param name="cols">65</xsl:with-param>
	       <xsl:with-param name="maxlines">12</xsl:with-param>
	       <xsl:with-param name="messageValue"><xsl:value-of select="exp_event"/></xsl:with-param>
	        <xsl:with-param name="required">Y</xsl:with-param>
	      </xsl:call-template>
	     </xsl:with-param>
		</xsl:call-template>
	 </div>
	</xsl:if>
   </xsl:if>
 <xsl:if test="$swift2019Enabled and product_code[.='SR']">
	<xsl:if test="$displaymode = 'view'">
		<xsl:if test="exp_event[.!='']">
			<xsl:call-template name="big-textarea-wrapper-narrative">
				<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
					<xsl:with-param name="content">					
						<xsl:value-of select="exp_event" />
					</xsl:with-param>
			</xsl:call-template>										
		</xsl:if>
	</xsl:if>
</xsl:if>
    <!-- Expiry Place -->
     <xsl:if test="$show-expiry-place = 'Y'">    
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
      <xsl:with-param name="name">expiry_place</xsl:with-param>
      <xsl:with-param name="maxsize">29</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$swift2019Enabled and product_code [.='SR']">	
     <xsl:choose>
     <xsl:when test="$displaymode = 'view' ">
    
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
		</xsl:when>
			<xsl:otherwise>
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
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
    <!-- Amendment Number to be displayed on General details section -->
     <xsl:if test="tnx_type_code[.!='01'] ">
     <xsl:choose>
     	<xsl:when test = "$swift2018Enabled and tnx_type_code[.='03' or .='15']">
     		<div id="amd_no_date_display_mo_div">
      		 	<xsl:call-template name="amendmentNumber"></xsl:call-template>
       		</div>
       		<div id="amd_date_display_mo_div">
       		<xsl:call-template name="amendmentDate"></xsl:call-template>
       		</div>
     	</xsl:when>
     </xsl:choose>
     </xsl:if>
    
     <!-- 
      Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
      Pass in a show-presentation parameter set to Y to display the presentation fields.
      
      If set to N, the template will instead insert a hidden field with the value 1.0
     -->
     <xsl:call-template name="eucp-details">
      <xsl:with-param name="show-eucp" select="$show-eucp"/>
     </xsl:call-template>
    
     <!-- Beneficiary Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="prefix">beneficiary</xsl:with-param>
        <xsl:with-param name="show-entity">Y</xsl:with-param>
        <xsl:with-param name="show-entity-button">Y</xsl:with-param>
        <xsl:with-param name="search-button-type"><xsl:if test="tnx_type_code[.='01']">bank-beneficiary</xsl:if></xsl:with-param>
        <xsl:with-param name="entity-required">N</xsl:with-param>
        <xsl:with-param name="show-abbv">Y</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
        <xsl:with-param name="show-reference">
        <xsl:choose>
        <xsl:when test="(product_code[.='SR'] or product_code[.='EL'])">N</xsl:when>
        <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
       </xsl:call-template>
       <xsl:if test="product_code[.='SR'] or product_code[.='EL']">
       <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
       <xsl:with-param name="name">beneficiary_reference</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="ref"><xsl:value-of select="beneficiary_reference"/></xsl:variable>
         <xsl:value-of select="utils:decryptApplicantReference($ref)"/>
         </xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      </xsl:with-param>
     </xsl:call-template>
    
     <xsl:if test="sub_tnx_type_code[.='12'] or sec_beneficiary_name[.!='']">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_SECOND_BENEFICIARY_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="button-type">sec_beneficiary</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="prefix">sec_beneficiary</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    
     <!-- Applicant Details -->
     <xsl:if test="$show-applicant = 'Y' and (lc_type[.='01' or .='02'] or lc_type[.=''])">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="prefix">applicant</xsl:with-param>
         <xsl:with-param name="show-button">Y</xsl:with-param>
		 <xsl:with-param name="search-button-type">applicant</xsl:with-param>
		  <xsl:with-param name="show-email">Y</xsl:with-param>
        <xsl:with-param name="show-contact-number">Y</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
         <xsl:with-param name="name">applicant_reference</xsl:with-param>
         <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>


      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="issuing_bank">
         <xsl:with-param name="theNodeName">issuing_bank</xsl:with-param>
         <xsl:with-param name="show-button">Y</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>
    
      <xsl:variable name="isMT798Enabled"><xsl:value-of select="is_MT798"/></xsl:variable>
      <xsl:if test="product_code[.='EL'] and $displaymode='view' and prod_stat_code[.='03'] and $swift2018Enabled and $isMT798Enabled = 'Y'">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_FIRST_ADVISING_BANK</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="first_advising_bank">
         <xsl:with-param name="theNodeName">first_advising_bank</xsl:with-param>
         <xsl:with-param name="show-button">Y</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>
      </xsl:if>
     </xsl:if>

     <xsl:if test="sub_tnx_type_code[.='19']">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_ASSIGNEE_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="button-type">beneficiary</xsl:with-param>
       <xsl:with-param name="content">
        <!-- Name. -->
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
         <xsl:with-param name="name">assignee_name</xsl:with-param>
         <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
        </xsl:call-template>
        <script>
		dojo.ready(function()
			{
				if(misys._config.swiftRelatedSection !== undefined)
				{
					misys._config.swiftRelatedSections.push('<xsl:value-of select="name"/>');
				}
			});
   		</script>
     
        <!-- Address Lines -->
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
         <xsl:with-param name="name">assignee_address_line_1</xsl:with-param>
         <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS1_TRADE_LENGTH')"/></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="name">assignee_address_line_2</xsl:with-param>
          <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS2_TRADE_LENGTH')"/></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="name">assignee_dom</xsl:with-param>
         <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('DOM_TRADE_LENGTH')"/></xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
     <xsl:copy-of select="$additional-content"/>
     
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   LC Payment Details (Bank Side)
  -->
  <xsl:template name="lc-bank-payment-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:apply-templates select="credit_available_with_bank">
        <xsl:with-param name="theNodeName">credit_available_with_bank</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="show-button">Y</xsl:with-param>
       </xsl:apply-templates>
       
       <!--
       Credit Available By select box
       -->
       <xsl:apply-templates select="cr_avl_by_code">
        <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL</xsl:with-param>
       </xsl:apply-templates>
      
      <xsl:if test="$displaymode='edit'">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">draft_term</xsl:with-param>
        <xsl:with-param name="label">XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL</xsl:with-param>
        <xsl:with-param name="type">textarea</xsl:with-param>
        <xsl:with-param name="content">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">draft_term</xsl:with-param>
         <xsl:with-param name="rows">4</xsl:with-param>
         <xsl:with-param name="cols">35</xsl:with-param>
         <xsl:with-param name="maxlines">4</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
       </xsl:if>
       <xsl:if test="$displaymode='view' and draft_term[.!='']">
      <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="label">XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL</xsl:with-param>
      <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="draft_term"/>
      </div></xsl:with-param>
     </xsl:call-template>
     </xsl:if>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
     <xsl:when test="drawee_details_bank/name[.!=''] and $displaymode='view'">
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>      
      <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:apply-templates select="drawee_details_bank">
        <xsl:with-param name="theNodeName">drawee_details_bank/name</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="show-button">N</xsl:with-param>
       </xsl:apply-templates>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:when>
     <xsl:when test="$displaymode='edit'">
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>      
      <xsl:with-param name="content">
       <xsl:apply-templates select="drawee_details_bank">
        <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="show-button">Y</xsl:with-param>
       </xsl:apply-templates>
      </xsl:with-param>
     </xsl:call-template>
	</xsl:when>
	</xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:template>
  
  <!--
   LC Shipment Details (Bank Side) 
   -->
  <xsl:template name="lc-bank-shipment-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:with-param>
      <xsl:with-param name="name">ship_from</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_LOADING</xsl:with-param>
      <xsl:with-param name="name">ship_loading</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_DISCHARGE</xsl:with-param>
      <xsl:with-param name="name">ship_discharge</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_TO</xsl:with-param>
      <xsl:with-param name="name">ship_to</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <!-- MPS-32046 Porting issue -->
    <!--  <xsl:call-template name="hidden-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template> -->
	<xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="part_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:when test="part_ship_detl[. = 'NONE']">NONE</xsl:when>
        <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">OTHER</xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
         <option value="ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
         <option value="NONE">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/>
         </option>
         <option value="OTHER">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/>
         </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="part_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/></xsl:when>
          <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">part_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="part_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="security:isBank($rundata)">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <!-- <xsl:call-template name="hidden-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     </xsl:call-template> -->
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:when test="tran_ship_detl[. = 'NONE']">NONE</xsl:when>
        <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">OTHER</xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	      <option value="NONE">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/>
	      </option>
	      <option value="OTHER">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/>
	      </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">tran_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="tran_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="security:isBank($rundata)">
     	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     	</xsl:call-template>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="button-type">date</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="purchase-terms-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
      <xsl:with-param name="name">inco_place</xsl:with-param>
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   LC Narrative Details (Bank Side)
  -->
  <xsl:template name="lc-narrative-full">
   <xsl:param name="label">XSL_HEADER_NARRATIVE_DETAILS</xsl:param>
   <xsl:param name="readonly">N</xsl:param>
   <xsl:param name="button-required">Y</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend" select="$label"/>
    <xsl:with-param name="content">
     <xsl:if test="product_code[.='SR']">
      <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
      <xsl:with-param name="name">applicable_rules</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="lc-rules"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
	   <xsl:with-param name="name">applicable_rules_text</xsl:with-param>
	   <xsl:with-param name="maxsize">35</xsl:with-param>
	   <xsl:with-param name="readonly">Y</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	</xsl:call-template>
     </xsl:if>
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">narrative_full_details</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">narrative_full_details</xsl:with-param>
        <xsl:with-param name="rows">16</xsl:with-param>
        <xsl:with-param name="disabled"><xsl:value-of select="$readonly"/></xsl:with-param>
        <xsl:with-param name="button-type">
        	<xsl:if test="$button-required = 'Y'">phrase</xsl:if>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
   <xsl:template name="lc-rules">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C012</xsl:with-param>
			 <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
		</xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="applicable_rules[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N065', '01')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N065', '02')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '03']"><xsl:value-of select="localization:getDecode($language, 'N065', '03')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '04']"><xsl:value-of select="localization:getDecode($language, 'N065', '04')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '05']"><xsl:value-of select="localization:getDecode($language, 'N065', '05')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '09']"><xsl:value-of select="localization:getDecode($language, 'N065', '09')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '99']"><xsl:value-of select="localization:getDecode($language, 'N065', '99')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 
    
 <xsl:template name="applicable-rules">
      <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
      <xsl:with-param name="name">applicable_rules</xsl:with-param>
      <xsl:with-param name="required">
	      <xsl:choose>
	      	<xsl:when test = "$swift2018Enabled and tnx_type_code!='03'">Y</xsl:when>
	      	<xsl:otherwise>N</xsl:otherwise>
	      </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="lc-rules"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
	   <xsl:with-param name="name">applicable_rules_text</xsl:with-param>
	   <xsl:with-param name="maxsize">35</xsl:with-param>
	   <xsl:with-param name="readonly">Y</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	 </xsl:call-template>
  </xsl:template>
  
   <xsl:template name="purchase-order-view-mode">
  <xsl:if test="$displaymode = 'view'">
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_PURCHASE_ORDER</xsl:with-param>
 <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
	
		<xsl:call-template name="build-line-items-dojo-items">
		<xsl:with-param name="items" select="line_items/lineItems/lineItem" />
		</xsl:call-template> 
			<div>&nbsp;</div>
			<xsl:if test="fake_total_cur_code[.!=''] and fake_total_amt[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="fake_total_cur_code"/>&nbsp;<xsl:value-of select="fake_total_amt"/>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="total_net_cur_code[.!=''] and total_net_amt[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="total_net_cur_code"/>&nbsp;<xsl:value-of select="total_net_amt"/>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
						
		</xsl:with-param>
	   </xsl:call-template> 
	 </xsl:if>
	 
   </xsl:template> 
  <!--
  ########################################################################
  #3 - COMMON TEMPLATES
 
  Below, all templates for LC-based forms on customer/bank sides.
  ########################################################################
  -->
  
  <!-- 
   Narrative details.
   
   Tab0 - Description of Goods
   Tab1 - Documents Required
   Tab2 - Additional Instructions
  -->
  <xsl:template name="lc-narrative-details">
   <xsl:param name="documents-required-required">N</xsl:param>
   <xsl:param name="description-goods-required">Y</xsl:param>
   <xsl:param name="in-fieldset">Y</xsl:param>
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-label">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
    
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:if test="not(security:isBank($rundata)) and $displaymode = 'edit' and (product_code [.= 'LC'] or product_code [.= 'SI'])">	
    	<xsl:call-template name="build-line-items-dojo-items">
				<xsl:with-param name="items" select="line_items/lineItems/lineItem" />
		</xsl:call-template> 
	</xsl:if>	
			 <xsl:if test="not(security:isBank($rundata)) and (product_code [.= 'LC'] or product_code [.= 'SI'])">			
						<xsl:choose>
							<xsl:when test="$option = 'DETAILS' or $option = 'FULL'">
								<br/>
								 <xsl:if test="total_cur_code[.!=''] and total_amt[.!='']">	
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
									<xsl:with-param name="name">fake_total_amt</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$displaymode = 'edit'">
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
										 <xsl:with-param name="product-code">total</xsl:with-param>
										<xsl:with-param name="override-currency-name">fake_total_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">fake_total_amt</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="$displaymode = 'view'">
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
										<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">total_amt</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
			</xsl:if>
			 <xsl:if test="not(security:isBank($rundata)) and (product_code [.= 'LC'] or product_code [.= 'SI'])">
				
			 <xsl:if test="$displaymode = 'edit'">
				<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
							<xsl:with-param name="override-currency-name">total_net_cur_code</xsl:with-param>
							<xsl:with-param name="override-amt-name">total_net_amt</xsl:with-param>
							<xsl:with-param name="amt-readonly">Y</xsl:with-param>
							<xsl:with-param name="currency-readonly">Y</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			</xsl:if>
	   	<xsl:choose>
	   		<xsl:when test="$Goods_description != ''">
	   			<xsl:call-template name="textarea-field">
		   			<xsl:with-param name="name">narrative_description_goods</xsl:with-param>
		   			<xsl:with-param name="messageValue">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled"><xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/></xsl:when>
		   				<xsl:otherwise><xsl:value-of select="narrative_description_goods"/></xsl:otherwise>
		   			</xsl:choose>
		   			</xsl:with-param>
		   			<xsl:with-param name="maxlines">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
			   			<xsl:otherwise>
			   				<xsl:value-of select="$Goods_description"/>
			   			</xsl:otherwise>
		   			</xsl:choose>
		   			</xsl:with-param>   			
				   	<xsl:with-param name="button-type-ext-view">
					   	<xsl:choose>
				   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
				   			<xsl:otherwise/>
			   			</xsl:choose>
				   	</xsl:with-param>
				   	<xsl:with-param name="required"><xsl:value-of select="$description-goods-required"/></xsl:with-param>
			   	</xsl:call-template>
			   	 <xsl:if test="not(security:isBank($rundata)) and (product_code [.= 'LC'] or product_code [.= 'SI']) and $displaymode='view'  and defaultresource:getResource('PURCHASE_ORDER_ASSISTANT') = 'true'">
   			 <xsl:call-template name="purchase-order-view-mode"/>
   			 </xsl:if>
	    		</xsl:when>
	  		<xsl:otherwise>
	       			<xsl:call-template name="textarea-field">
		   			<xsl:with-param name="name">narrative_description_goods</xsl:with-param>
		      		<xsl:with-param name="messageValue">
			   			<xsl:choose>
	      		 			<xsl:when test="$swift2018Enabled and product_code = 'EL' and $displaymode = 'edit' and  ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='19'] and tnx_stat_code[.='03']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)">
	      		 				<xsl:variable name="desc"><xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/></xsl:variable>
	      		 				<xsl:choose>
	      		 					<xsl:when test="desc[.!='']">
	      		 						<xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/>
	      		 					</xsl:when>
	      		 					<xsl:otherwise><xsl:value-of select="narrative_description_goods"/></xsl:otherwise>
	      		 				</xsl:choose>
	      		 			</xsl:when>	      		 			
	      		 			<xsl:when test="$swift2018Enabled and product_code = 'EL' and $displaymode = 'edit'and ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12'] and tnx_stat_code[.='03']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)">
      		 				     <xsl:value-of select="narrative_description_goods"/>
      		 			    </xsl:when>
	      		 			<xsl:when test="$swift2018Enabled and product_code = 'EL' and $displaymode = 'view' and  ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12' or .='19']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)">
	      		 				<xsl:value-of select="narrative_description_goods"/>
	      		 			</xsl:when>
	      		 			<xsl:when test="$swift2018Enabled and product_code = 'EL' and $displaymode = 'edit'and ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12' or .='19']) and (tnx_stat_code[.='05'] and sub_tnx_stat_code[.='05'])or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)">
	      		 				<xsl:value-of select="narrative_description_goods"/>
	      		 			</xsl:when>
				   			<xsl:when test="$swift2018Enabled">
				   				<xsl:variable name="desc"><xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/></xsl:variable>
				   				<xsl:choose>
	      		 					<xsl:when test="$desc != ''">
	      		 						<xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/>
	      		 					</xsl:when>
	      		 					<xsl:otherwise><xsl:value-of select="//narrative_description_goods/text"/></xsl:otherwise>
	      		 				</xsl:choose>
				   			</xsl:when>
			   				<xsl:otherwise><xsl:value-of select="narrative_description_goods"/></xsl:otherwise>
			   			</xsl:choose>
		   			</xsl:with-param>
		   			<xsl:with-param name="maxlines">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
			   			<xsl:otherwise>100</xsl:otherwise>
		   			</xsl:choose>
		   			</xsl:with-param>   			
				   	<xsl:with-param name="button-type-ext-view">
					   	<xsl:choose>
				   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
				   			<xsl:otherwise/>
			   			</xsl:choose>
				   	</xsl:with-param>
				   	<xsl:with-param name="required"><xsl:value-of select="$description-goods-required"/></xsl:with-param>
			  	 </xsl:call-template>
			  	  <xsl:if test="not(security:isBank($rundata)) and (product_code [.= 'LC'] or product_code [.= 'SI']) and $displaymode='view'">
   			 <xsl:call-template name="purchase-order-view-mode"/>
   			 </xsl:if>
	       		</xsl:otherwise>
	   	</xsl:choose>
   	</xsl:with-param>
     
    <!-- Tab 1 - Documents Required  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:choose>
   		<xsl:when test="$Documents_required != ''">
   			<xsl:call-template name="textarea-field">
		      <xsl:with-param name="name">narrative_documents_required</xsl:with-param>
		      		<xsl:with-param name="messageValue">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled"><xsl:value-of select="//narrative_documents_required/issuance/data/datum/text"/></xsl:when>
		   				<xsl:otherwise><xsl:value-of select="narrative_documents_required"/></xsl:otherwise>
		   			</xsl:choose>
		   			</xsl:with-param>
		      		<xsl:with-param name="maxlines">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
			   			<xsl:otherwise>
			   				<xsl:value-of select="$Documents_required"/>
			   			</xsl:otherwise>
		   			</xsl:choose>
		   			</xsl:with-param>
		   	  		<xsl:with-param name="button-type-ext-view">
					   	<xsl:choose>
				   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
				   			<xsl:otherwise/>
			   			</xsl:choose>
				   	</xsl:with-param>
		      <xsl:with-param name="required"><xsl:value-of select="$documents-required-required"/></xsl:with-param>
		    </xsl:call-template>
    	</xsl:when>
  		<xsl:otherwise>
       		<xsl:call-template name="textarea-field">
		      <xsl:with-param name="name">narrative_documents_required</xsl:with-param>
		      <xsl:with-param name="messageValue">
		   			<xsl:choose>
						<xsl:when test="$swift2018Enabled and product_code = 'EL' and ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12' or .='19']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)">      		 				<xsl:value-of select="narrative_documents_required"/>
      		 			</xsl:when>
			   			<xsl:when test="$swift2018Enabled">
				   				<xsl:variable name="desc"><xsl:value-of select="//narrative_documents_required/issuance/data/datum/text"/></xsl:variable>
				   				<xsl:choose>
	      		 					<xsl:when test="$desc != ''">
	      		 						<xsl:value-of select="//narrative_documents_required/issuance/data/datum/text"/>
	      		 					</xsl:when>
	      		 					<xsl:otherwise><xsl:value-of select="//narrative_documents_required/text"/></xsl:otherwise>
	      		 				</xsl:choose>
				   		</xsl:when>
		   				<xsl:otherwise><xsl:value-of select="narrative_documents_required"/></xsl:otherwise>
		   			</xsl:choose>
		   			</xsl:with-param>
		      <xsl:with-param name="maxlines">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
			   			<xsl:otherwise>100</xsl:otherwise>
		   			</xsl:choose>
		   			</xsl:with-param>
		   	  		<xsl:with-param name="button-type-ext-view">
					   	<xsl:choose>
				   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
				   			<xsl:otherwise/>
			   			</xsl:choose>
				   	</xsl:with-param>
		      <xsl:with-param name="required">
		      	<xsl:if test="(product_code = 'EL'and sub_tnx_type_code[.='12' or .='19']) !='true'"> 
		      		<xsl:value-of select="$documents-required-required"/>
		      	</xsl:if>
		      </xsl:with-param>
		    </xsl:call-template>
       	</xsl:otherwise>
   	</xsl:choose>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <xsl:choose>
   		<xsl:when test="$Additional_Conditions != ''">
   			<xsl:call-template name="textarea-field">
		      <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
		      	<xsl:with-param name="messageValue">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled"><xsl:value-of select="//narrative_additional_instructions/issuance/data/datum/text"/></xsl:when>
		   				<xsl:otherwise><xsl:value-of select="narrative_additional_instructions"/></xsl:otherwise>
		   			</xsl:choose>
		   		</xsl:with-param>
		      <xsl:with-param name="maxlines">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
			   			<xsl:otherwise>
			   				<xsl:value-of select="$Additional_Conditions"/>
			   			</xsl:otherwise>
		   			</xsl:choose>
		   	</xsl:with-param>
		   		<xsl:with-param name="button-type-ext-view">
				   	<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
			   			<xsl:otherwise/>
		   			</xsl:choose>
				</xsl:with-param>
		    </xsl:call-template>
    	</xsl:when>
  		<xsl:otherwise>
       		<xsl:call-template name="textarea-field">
		      <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
		      <xsl:with-param name="messageValue">
		   			<xsl:choose>
						<xsl:when test="$swift2018Enabled and product_code = 'EL' and ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12' or .='19']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)">      		 				<xsl:value-of select="narrative_additional_instructions"/>
      		 			</xsl:when>
			   			<xsl:when test="$swift2018Enabled">
				   				<xsl:variable name="desc"><xsl:value-of select="//narrative_additional_instructions/issuance/data/datum/text"/></xsl:variable>
				   				<xsl:choose>
	      		 					<xsl:when test="$desc != ''">
	      		 						<xsl:value-of select="//narrative_additional_instructions/issuance/data/datum/text"/>
	      		 					</xsl:when>
	      		 					<xsl:otherwise><xsl:value-of select="//narrative_additional_instructions/text"/></xsl:otherwise>
	      		 				</xsl:choose>
				   		</xsl:when>
		   				<xsl:otherwise><xsl:value-of select="narrative_additional_instructions"/></xsl:otherwise>
		   			</xsl:choose>
		   		</xsl:with-param>
		      <xsl:with-param name="maxlines">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
			   			<xsl:otherwise>100</xsl:otherwise>
		   			</xsl:choose>
		   	  </xsl:with-param>
		   		<xsl:with-param name="button-type-ext-view">
				   	<xsl:choose>
			   			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
			   			<xsl:otherwise/>
		   			</xsl:choose>
				</xsl:with-param>
		    </xsl:call-template>
       	</xsl:otherwise>
   	</xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="line-items-declaration">
		<!-- Dialog Start -->
			
		<xsl:call-template name="line-item-dialog-declaration" /> 
		<!-- Dialog End -->
		
		<div id="line-item-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_PURCHASE_ORDER')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<!--
				TODO: Only possible if PO currency is selected (total_cur_code)
				-->
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="addPurchaseOrder">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PURCHASE_ORDER')" />
				</button>
			</div>
		</div>
		
		
	</xsl:template>
	
	<!-- TEMPLATE for the declarations of Purchase Order Line items -->
	<xsl:template name="line-item-dialog-declaration">
		<div id="line-item-dialog-template" class="widgetContainer" style="display:none">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

				<div id="line-item-dialog-template-content">
					<div>
						<xsl:if test="$displaymode = 'edit'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="name">line_item_qty_unit_measr_label</xsl:with-param>							
							<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="contact_type">
									<xsl:if test="qty_unit_measr_code != ''">
										<xsl:value-of select="localization:getDecode($language, 'N202', qty_unit_measr_code)" />
									</xsl:if>
								</xsl:when>
								<xsl:otherwise></xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>							
						</xsl:call-template>
						</xsl:if>
					
						<!-- Products section -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_PURCHASE_ORDER_PRODUCT</xsl:with-param>
							<xsl:with-param name="parse-widgets">N</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Product name -->
								<xsl:call-template name="textarea-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRODUCT_NAME_DESCIPTION</xsl:with-param>
									<xsl:with-param name="name">line_item_product_name</xsl:with-param>
									<xsl:with-param name="phrase-params">{'category':'01'}</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="swift-validate">Y</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>

						<!-- Amount section -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Quantity section -->
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_QUANTITY</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										<!-- Quantity unit measure code -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="select-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
													<xsl:with-param name="name">line_item_qty_unit_measr_code</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="options">
														<xsl:call-template name="quantity-unit-measure-codes">
															<xsl:with-param name="field-name">line_item_qty_unit_measr_code</xsl:with-param>
														</xsl:call-template>
													</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="input-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
													<xsl:with-param name="name">line_item_qty_unit_measr_label</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
										<!-- Quantity unit measure: Other -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_unit_measr_other</xsl:with-param>
											<xsl:with-param name="size">35</xsl:with-param>
											<xsl:with-param name="maxsize">35</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										
										<!-- Quantity value -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_VALUE</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_val</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="size">8</xsl:with-param>
											<xsl:with-param name="maxsize">8</xsl:with-param>
											<xsl:with-param name="type">number</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									
										<!-- Tolerance + -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_POS</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_tol_pstv_pct</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">2</xsl:with-param>
											<xsl:with-param name="maxsize">2</xsl:with-param>
											<xsl:with-param name="type">number</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="fieldsize">x-small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Tolerance - -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_NEG</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_tol_neg_pct</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="size">2</xsl:with-param>
											<xsl:with-param name="maxsize">2</xsl:with-param>
											<xsl:with-param name="type">number</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="fieldsize">x-small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>

								<!-- Price section -->
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_PRICE</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										<!-- Price unit measure code -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="select-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_CODE</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="name">line_item_price_unit_measr_code</xsl:with-param>
													<xsl:with-param name="readonly">Y</xsl:with-param>
													<xsl:with-param name="options">
														<xsl:call-template name="quantity-unit-measure-codes" >
															<xsl:with-param name="field-name">line_item_price_unit_measr_code</xsl:with-param>
														</xsl:call-template>
													</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="input-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_CODE</xsl:with-param>
													<xsl:with-param name="name">line_item_price_unit_measr_label</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
										<!-- Price -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_VALUE</xsl:with-param>
													<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
													<xsl:with-param name="override-currency-name">line_item_price_cur_code</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_price_amt</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_VALUE</xsl:with-param>
													<xsl:with-param name="override-currency-name">price_cur_code</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_price_amt</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
													<xsl:with-param name="amt-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
										<!-- Price factor -->
										<!-- <xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_FACTOR</xsl:with-param>
											<xsl:with-param name="name">line_item_price_factor</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">15</xsl:with-param>
											<xsl:with-param name="maxsize">15</xsl:with-param>
											<xsl:with-param name="type">number</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template> -->
										<!-- Tolerance + -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_POS</xsl:with-param>
											<xsl:with-param name="name">line_item_price_tol_pstv_pct</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">2</xsl:with-param>
											<xsl:with-param name="maxsize">2</xsl:with-param>
											<xsl:with-param name="type">number</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="fieldsize">x-small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Tolerance - -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_NEG</xsl:with-param>
											<xsl:with-param name="name">line_item_price_tol_neg_pct</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="size">2</xsl:with-param>
											<xsl:with-param name="maxsize">2</xsl:with-param>
											<xsl:with-param name="type">number</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="fieldsize">x-small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Line Item Amount -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_AMT</xsl:with-param>
													<xsl:with-param name="override-currency-name">line_item_total_cur_code</xsl:with-param>
													<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_total_amt</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
													<xsl:with-param name="readonly">Y</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													<xsl:with-param name="amt-readonly">Y</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_AMT</xsl:with-param>
													<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_total_amt</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
													<xsl:with-param name="amt-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
									</xsl:with-param>
								</xsl:call-template>


								<!-- Line Item Net Amount -->	
								<xsl:choose>							
								<xsl:when test="$section_line_item_total_net_amount_details!='N'">
								<div style="display:block;">	
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_NET_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">line_item_total_net_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">line_item_total_net_amt</xsl:with-param>
									<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
									<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
								</xsl:call-template>
								</div>							
								</xsl:when>
								<xsl:otherwise>
								<div style="display:none;">	
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_NET_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">line_item_total_net_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">line_item_total_net_amt</xsl:with-param>
										<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
										<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									</xsl:call-template>
								</div>	
								</xsl:otherwise>								
								</xsl:choose>
								
								
							</xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
								<xsl:call-template name="label-wrapper">
									<xsl:with-param name="content">
										<button type="button" dojoType="dijit.form.Button">
											<xsl:attribute name="onmouseup">dijit.byId('line-item-dialog-template').hide();</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
										</button>
										<xsl:if test="$displaymode = 'edit'">
											<button dojoType="dijit.form.Button" id="dialogPOSubmit">
												<xsl:attribute name="onClick">dijit.byId('line-item-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
											</button>
										</xsl:if>										
									</xsl:with-param>
								</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>
	<!-- LineItems - Dojo objects -->
	<xsl:template name="build-line-items-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
		<div dojoType="misys.purchaseorder.widget.PurchaseOrders" dialogId="line-item-dialog-template" id="line-items">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PURCHASE_ORDER')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_PURCHASE_ORDER')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_PURCHASE_ORDER')" /></xsl:attribute>
			<xsl:attribute name="headers">
			<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_NUMBER')" />, -->
			<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_PRODUCT_QUANTITY')" />
			</xsl:attribute>
		
			<xsl:for-each select="$items">
				<xsl:variable name="lineItem" select="." />
				<div dojoType="misys.purchaseorder.widget.PurchaseOrder">
					<xsl:attribute name="cust_ref_id">
					<xsl:choose>
						<xsl:when test="$productCode='EA' or $productCode='IO'">
							<xsl:value-of select="$lineItem/line_item_number" />
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$lineItem/cust_ref_id" />
					</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="line_item_number"><xsl:value-of
						select="$lineItem/line_item_number" /></xsl:attribute>
					<xsl:attribute name="po_reference"><xsl:value-of
						select="$lineItem/po_reference" /></xsl:attribute>
					<xsl:attribute name="product_name"><xsl:value-of
						select="$lineItem/product_name" /></xsl:attribute>
					<xsl:attribute name="qty_unit_measr_code"><xsl:value-of select="$lineItem/qty_unit_measr_code" /></xsl:attribute>
					<xsl:attribute name="qty_unit_measr_label">
						<xsl:if test="$lineItem/qty_unit_measr_code != ''">
							<xsl:value-of select="localization:getDecode($language, 'N202', $lineItem/qty_unit_measr_code)" />
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="qty_other_unit_measr"><xsl:value-of
						select="$lineItem/qty_other_unit_measr" /></xsl:attribute>
					<xsl:attribute name="qty_val"><xsl:value-of
						select="$lineItem/qty_val" /></xsl:attribute>
					<xsl:attribute name="qty_tol_pstv_pct"><xsl:value-of
						select="$lineItem/qty_tol_pstv_pct" /></xsl:attribute>
					<xsl:attribute name="qty_tol_neg_pct"><xsl:value-of
						select="$lineItem/qty_tol_neg_pct" /></xsl:attribute>
					<xsl:attribute name="price_unit_measr_code"><xsl:value-of select="$lineItem/price_unit_measr_code" /></xsl:attribute>
					<xsl:attribute name="price_unit_measr_label">
						<xsl:if test="$lineItem/price_unit_measr_code">
							<xsl:value-of select="localization:getDecode($language, 'N202', $lineItem/price_unit_measr_code)" />
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="price_other_unit_measr"><xsl:value-of
						select="$lineItem/price_other_unit_measr" /></xsl:attribute>
					<xsl:attribute name="price_cur_code"><xsl:value-of
						select="$lineItem/price_cur_code" /></xsl:attribute>
					<xsl:attribute name="price_amt"><xsl:value-of
						select="$lineItem/price_amt" /></xsl:attribute>
					<xsl:attribute name="price_factor"><xsl:value-of
						select="$lineItem/price_factor" /></xsl:attribute>
					<xsl:attribute name="price_tol_pstv_pct"><xsl:value-of
						select="$lineItem/price_tol_pstv_pct" /></xsl:attribute>
					<xsl:attribute name="price_tol_neg_pct"><xsl:value-of
						select="$lineItem/price_tol_neg_pct" /></xsl:attribute>
					<xsl:attribute name="total_cur_code"><xsl:value-of
						select="$lineItem/total_cur_code" /></xsl:attribute>
					<xsl:attribute name="total_amt"><xsl:value-of
						select="$lineItem/total_amt" /></xsl:attribute>
					<xsl:attribute name="total_net_cur_code"><xsl:value-of
						select="$lineItem/total_net_cur_code" /></xsl:attribute>
					<xsl:attribute name="total_net_amt"><xsl:value-of
						select="$lineItem/total_net_amt" /></xsl:attribute>
					<xsl:attribute name="is_valid"><xsl:value-of
						select="$lineItem/is_valid" /></xsl:attribute>
					<xsl:attribute name="ref_id"><xsl:value-of
						select="$lineItem/ref_id" /></xsl:attribute>
				</div>
			</xsl:for-each>
			
		</div>

	</xsl:template>
	
	
	<xsl:template name="quantity-unit-measure-codes">
	<xsl:param name="field-name"/>
	 <xsl:choose>
        <xsl:when test="$displaymode='edit'">
		<option value="EA">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'EA')" />
		</option>
		<option value="BG">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BG')" />
		</option>
		<option value="BL">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BL')" />
		</option>
		<option value="BO">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BO')" />
		</option>
		<option value="BX">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BX')" />
		</option>
		<option value="CH">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CH')" />
		</option>
		<option value="CT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CT')" />
		</option>
		<option value="CR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CR')" />
		</option>
		<option value="CLT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CLT')" />
		</option>
		<option value="GRM">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'GRM')" />
		</option>
		<option value="KGM">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'KGM')" />
		</option>
		<option value="LTN">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LTN')" />
		</option>
		<option value="LBR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LBR')" />
		</option>
		<option value="ONZ">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'ONZ')" />
		</option>
		<option value="STN">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'STN')" />
		</option>
		<option value="INQ">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'INQ')" />
		</option>
		<option value="LTR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LTR')" />
		</option>
		<option value="MTQ">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MTQ')" />
		</option>
		<option value="OZA">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'OZA')" />
		</option>
		<option value="OZI">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'OZI')" />
		</option>
		<option value="PT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'PT')" />
		</option>
		<option value="PTI">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'PTI')" />
		</option>
		<option value="QT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'QT')" />
		</option>
		<option value="QTI">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'QTI')" />
		</option>
		<option value="FTK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'FTK')" />
		</option>
		<option value="INK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'INK')" />
		</option>
		<option value="KMK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'KMK')" />
		</option>
		<option value="MIK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MIK')" />
		</option>
		<option value="MMK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MMK')" />
		</option>
		<option value="MTK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MTK')" />
		</option>
		<option value="YDK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'YDK')" />
		</option>
		<option value="CMK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CMK')" />
		</option>
		<option value="1A">
			<xsl:value-of select="localization:getDecode($language, 'N202', '1A')" />
		</option>
		<option value="CMT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CMT')" />
		</option>
		<option value="FOT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'FOT')" />
		</option>
		<option value="INH">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'INH')" />
		</option>
		<option value="KTM">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'KTM')" />
		</option>
		<option value="LY">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LY')" />
		</option>
		<option value="MTR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MTR')" />
		</option>
		<option value="OTHR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'OTHR')" />
		</option>
		<option value="BRL">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BRL')" />
		</option>
		
		<option value="PAR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'PAR')" />
		</option>
		
		<option value="LOT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LOT')" />
		</option>
		
		<option value="GLN">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'GLN')" />
		</option>
		
		<option value="TON">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'TON')" />
		</option>
		
		 </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="$field-name = 'EA'"><xsl:value-of select="localization:getDecode($language, 'N202', 'EA')" /></xsl:when>
          <xsl:when test="$field-name = 'BG'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BG')" /></xsl:when>
          <xsl:when test="$field-name = 'BL'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BL')" /></xsl:when>
          <xsl:when test="$field-name = 'BO'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BO')" /></xsl:when>
          <xsl:when test="$field-name = 'BX'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BX')" /></xsl:when>
          <xsl:when test="$field-name = 'CH'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CH')" /></xsl:when>
          <xsl:when test="$field-name = 'CT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CT')" /></xsl:when>
          <xsl:when test="$field-name = 'CR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CR')" /></xsl:when>
          <xsl:when test="$field-name = 'CLT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CLT')" /></xsl:when>
          <xsl:when test="$field-name = 'GRM'"><xsl:value-of select="localization:getDecode($language, 'N202', 'GRM')" /></xsl:when>
          <xsl:when test="$field-name = 'KGM'"><xsl:value-of select="localization:getDecode($language, 'N202', 'KGM')" /></xsl:when>
          <xsl:when test="$field-name = 'LTN'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LTN')" /></xsl:when>
          <xsl:when test="$field-name = 'LBR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LBR')" /></xsl:when>
          <xsl:when test="$field-name = 'ONZ'"><xsl:value-of select="localization:getDecode($language, 'N202', 'ONZ')" /></xsl:when>
          <xsl:when test="$field-name = 'STN'"><xsl:value-of select="localization:getDecode($language, 'N202', 'STN')" /></xsl:when>
          <xsl:when test="$field-name = 'INQ'"><xsl:value-of select="localization:getDecode($language, 'N202', 'INQ')" /></xsl:when>
          <xsl:when test="$field-name = 'LTR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LTR')" /></xsl:when>
          <xsl:when test="$field-name = 'MTQ'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MTQ')" /></xsl:when>
          <xsl:when test="$field-name = 'OZA'"><xsl:value-of select="localization:getDecode($language, 'N202', 'OZA')" /></xsl:when>
          <xsl:when test="$field-name = 'OZI'"><xsl:value-of select="localization:getDecode($language, 'N202', 'OZI')" /></xsl:when>
          <xsl:when test="$field-name = 'PT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'PT')" /></xsl:when>
          <xsl:when test="$field-name = 'PTI'"><xsl:value-of select="localization:getDecode($language, 'N202', 'PTI')" /></xsl:when>
          <xsl:when test="$field-name = 'QT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'QT')" /></xsl:when>
          <xsl:when test="$field-name = 'QTI'"><xsl:value-of select="localization:getDecode($language, 'N202', 'QTI')" /></xsl:when>
          <xsl:when test="$field-name = 'FTK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'FTK')" /></xsl:when>
          <xsl:when test="$field-name = 'INK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'INK')" /></xsl:when>
          <xsl:when test="$field-name = 'KMK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'KMK')" /></xsl:when>
          <xsl:when test="$field-name = 'MIK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MIK')" /></xsl:when>
          <xsl:when test="$field-name = 'MMK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MMK')" /></xsl:when>
          <xsl:when test="$field-name = 'MTK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MTK')" /></xsl:when>
          <xsl:when test="$field-name = 'YDK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'YDK')" /></xsl:when>
          <xsl:when test="$field-name = 'CMK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CMK')" /></xsl:when>
          <xsl:when test="$field-name = '1A'"><xsl:value-of select="localization:getDecode($language, 'N202', '1A')" /></xsl:when>
          <xsl:when test="$field-name = 'CMT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CMT')" /></xsl:when>
          <xsl:when test="$field-name = 'FOT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'FOT')" /></xsl:when>
          <xsl:when test="$field-name = 'INH'"><xsl:value-of select="localization:getDecode($language, 'N202', 'INH')" /></xsl:when>
          <xsl:when test="$field-name = 'KTM'"><xsl:value-of select="localization:getDecode($language, 'N202', 'KTM')" /></xsl:when>
          <xsl:when test="$field-name = 'LY'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LY')" /></xsl:when>
          <xsl:when test="$field-name = 'MTR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MTR')" /></xsl:when>
          <xsl:when test="$field-name = 'BRL'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BRL')" /></xsl:when>
          
          <xsl:when test="$field-name = 'LOT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LOT')" /></xsl:when>
          <xsl:when test="$field-name = 'PAR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'PAR')" /></xsl:when>
          <xsl:when test="$field-name = 'TON'"><xsl:value-of select="localization:getDecode($language, 'N202', 'TON')" /></xsl:when>
          <xsl:when test="$field-name = 'GLN'"><xsl:value-of select="localization:getDecode($language, 'N202', 'GLN')" /></xsl:when>
          
          <xsl:otherwise></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
	</xsl:template>
  
  <!-- 
   Narrative charges.
   
   Tab0 - Charges Details
   Tab1 - Period for Presentation
   Tab2 - Shipment Period
  -->
  <xsl:template name="lc-narrative-charges">
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">

    <!-- Tab 0 - Charges Details  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_CHARGES</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <!-- Form #4 : Narrative Charges Details -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_charges</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'04'}</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 1 - Period Presentation  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION</xsl:with-param>
    <xsl:with-param name="tab1-content">
      <!-- Form #5 : Narrative Period Presentation -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'07'}</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Shipment Period  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <!-- Form #6 : Shipment Period Details -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'08'}</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Narrative Period Tabgroup.
   
   Tab0 - Period for Presentation
   Tab1 - Shipment Period
   Tab2 - Additional Amount
   -->
  <xsl:template name="lc-narrative-period">
   <!-- Tabgroup #2 : Narrative Period (3 Tabs) -->
	<xsl:param name="in-fieldset">Y</xsl:param>

   <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-period-tabcontainer</xsl:with-param>
    <!-- Tab 0 - Period Presentation  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'07'}</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="maxlines">4</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    
    <!-- Tab 1 - Shipment Period  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'08'}</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Amount  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'05'}</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="maxlines">4</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
   <!--
   Other Narrative Tabgroup.
   
   Tab0 - Period for Presentation
   Tab1 - Shipment Period
   Tab2 - Additional Amount
   -->
  <xsl:template name="lc-narrative-other">
  	<xsl:call-template name="tabgroup-wrapper">
    
    <!-- Tab 0 - Charges Details  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_CHARGES</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <!-- Form #4 : Narrative Charges Details -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_charges</xsl:with-param>
      <xsl:with-param name="phrase-params">{'category':'04'}</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>

    <!-- Tab 1 - Period Presentation  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
      
    <!-- Tab 2 - Other Details  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER</xsl:with-param>
    <xsl:with-param name="tab2-content"> 
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
     </xsl:call-template> 
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
     	 <xsl:if test="security:isBank($rundata))">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="name">next_revolve_date</xsl:with-param>
	       <xsl:with-param name="label">XSL_NEXT_REVOLVE_DATE</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="next_revolve_date[.!='']"><xsl:value-of select="next_revolve_date"/></xsl:if></xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="size">10</xsl:with-param>
	       <xsl:with-param name="maxsize">10</xsl:with-param>
	       <xsl:with-param name="readonly">N</xsl:with-param>
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
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="type">integer</xsl:with-param>
	     </xsl:call-template>
	      <xsl:if test="security:isBank($rundata)">
	     <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="select-field">
			       <xsl:with-param name="label">XSL_CHARGE_UPTO</xsl:with-param>
			       <xsl:with-param name="name">charge_upto</xsl:with-param>
			       <xsl:with-param name="fieldsize">small</xsl:with-param>
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
				       <xsl:with-param name="readonly">Y</xsl:with-param>
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
    Valid For Revolving Frequency Dropdown C049(i.e  D- Days, M- Months)
   -->
   <xd:doc>
	<xd:short>Revolving frequency options.</xd:short>
	<xd:detail>
		This tempalte constructs revolving frequency options by using the parameter C049.
	</xd:detail>
  </xd:doc>
   <xsl:template name="revolving-frequency-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="D">
      <xsl:value-of select="localization:getDecode($language, 'C049', 'D')"/>
     </option>
     <option value="M">
      <xsl:value-of select="localization:getDecode($language, 'C049', 'M')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="revolve_frequency[. = 'D']"><xsl:value-of select="localization:getDecode($language, 'C049', 'D')"/></xsl:when>
      <xsl:when test="revolve_frequency[. = 'M']"><xsl:value-of select="localization:getDecode($language, 'C049', 'M')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  <!--
    Valid For Charge Upto Dropdown C050(i.e  p- First periods, e- Final expiry)
   -->
  <xd:doc>
	<xd:short>Revolving charge upto options.</xd:short>
	<xd:detail>
		This tempalte constructs charges upto options by using the parameter C050.
		<ul>
			<li>p- First periods</li>
			<li>e- Final expiry</li>
		</ul>
	</xd:detail>
  </xd:doc>
  <xsl:template name="charge-upto-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="e">
      <xsl:value-of select="localization:getDecode($language, 'C050', 'e')"/>
     </option>
     <option value="p">
      <xsl:value-of select="localization:getDecode($language, 'C050', 'p')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="charge_upto[. = 'e']"><xsl:value-of select="localization:getDecode($language, 'C050', 'e')"/></xsl:when>
      <xsl:when test="charge_upto[. = 'p']"><xsl:value-of select="localization:getDecode($language, 'C050', 'p')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 
  
  <!--
   Amount Details Fieldset.
   
   Form of LC/SI, Confirmation Instructions, LC Amount,
   Variation in Drawing, Issuing Bank Charges, Outside Country Charges
   Confirmation Charges.
   
   Bank confirmation is only Y for the bank side. Form of LC, Outstanding
   Amount and Variation of Drawing are optional for certain bank forms.
   -->
  <xd:doc>
	<xd:short>Amount Details Fieldset.</xd:short>
	<xd:detail>
		Form of LC/SI, Confirmation Instructions, LC Amount,
		Variation in Drawing, Issuing Bank Charges, Outside Country Charges
		Confirmation Charges.
		
		Bank confirmation is only Y for the bank side. Form of LC, Outstanding
		Amount and Variation of Drawing are optional for certain bank forms.
	</xd:detail>
	<xd:param name="override-product-code">product code to set</xd:param>
	<xd:param name="show-form-lc">Display check box for amount details irrevocable, default is Y.</xd:param>
	<xd:param name="show-variation-drawing">Display variation in drawing, default Y</xd:param>
	<xd:param name="show-bank-confirmation">Shows bank confirmation radio field, default N</xd:param>
	<xd:param name="show-outstanding-amt">Display out standing amount</xd:param>
	<xd:param name="show-available-amt">Display available amount</xd:param>
	<xd:param name="show-standby">Display standby, default N</xd:param>
	<xd:param name="show-revolving">Show revolving details, default N</xd:param>
	<xd:param name="show-amt">show amount, default Y</xd:param>
	<xd:param name="show-form-lc-irv">Shows the amount from irrevocable, default N</xd:param>
	<xd:param name="transferable">shows transferable option, default N</xd:param>
  </xd:doc>
   <xsl:template name="lc-amt-details">
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="show-form-lc">Y</xsl:param>
   <xsl:param name="show-variation-drawing">Y</xsl:param>
   <xsl:param name="show-bank-confirmation">N</xsl:param>
   <xsl:param name="show-outstanding-amt">N</xsl:param>
   <xsl:param name="show-liability-amt">N</xsl:param>
   <xsl:param name="show-available-amt">N</xsl:param>
   <xsl:param name="show-standby">Y</xsl:param>
   <xsl:param name="show-revolving">N</xsl:param>
   <xsl:param name="show-amt">Y</xsl:param>
   <xsl:param name="show-form-lc-irv">N</xsl:param>
   <xsl:param name="transferable">N</xsl:param>
   <xsl:param name="disable-standby-flag">N</xsl:param>
   <xsl:param name="show-applicable-rules">Y</xsl:param>
   
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
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
	          			<xsl:call-template name="input-field">
	          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOCABLE')"/>
	          			</xsl:call-template>
	           		</xsl:when>
	           		<xsl:otherwise>
	          			<xsl:call-template name="input-field">
	          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')"/>
	          			</xsl:call-template>
	          			&nbsp;
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
          					<xsl:call-template name="input-field">
	          					<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')"/>
          					</xsl:call-template>
          					&nbsp;
           				</xsl:when>
           				<xsl:otherwise>
           					<xsl:call-template name="input-field">
	          					<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE')"/>
          					</xsl:call-template>
          					&nbsp;
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
          <xsl:if test="$displaymode='view' and stnd_by_lc_flag='Y' and  $product-code != 'SI'">
	          <xsl:call-template name="input-field">
	     		<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_STAND_BY')"/>
	           </xsl:call-template>
           &nbsp;
           </xsl:if>
         
          <!-- Display the standby checkbox if this is an LC -->
          <xsl:if test="$show-standby='Y' and $displaymode='edit' and $product-code != 'SI'">
           <xsl:call-template name="checkbox-field">
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_STAND_BY</xsl:with-param>
            <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
            <xsl:with-param name="disabled"><xsl:value-of select="$disable-standby-flag"/></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
          
          <xsl:if test="revolving_flag='Y' and $displaymode='view'">
          <xsl:call-template name="input-field">
            <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOLVING')"/>
          </xsl:call-template>
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

      <!-- Bank's Confirmation -->
      <xsl:if test="$show-bank-confirmation='Y'">
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_FLAG_LABEL</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:call-template name="radio-field">
          <xsl:with-param name="label">XSL_YES</xsl:with-param>
          <xsl:with-param name="name">cfm_flag</xsl:with-param>
          <xsl:with-param name="id">cfm_flag_1</xsl:with-param>
          <xsl:with-param name="value">Y</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="radio-field">
          <xsl:with-param name="label">XSL_NO</xsl:with-param>
          <xsl:with-param name="name">cfm_flag</xsl:with-param>
          <xsl:with-param name="id">cfm_flag_2</xsl:with-param>
          <xsl:with-param name="value">N</xsl:with-param>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <!-- LC Currency and Amount -->
     <xsl:choose>
      <xsl:when test="tnx_type_code[.='03'] and tnx_stat_code[.!='04'] and $displaymode='view'">
      <xsl:choose>
      <xsl:when test="product_code[.='LC']">
       <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="org_previous_file/lc_tnx_record/lc_amt"/>
           </div></xsl:with-param>
          </xsl:call-template>
      </xsl:when>
      <xsl:when test="product_code[.='SI']">
       <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="org_previous_file/si_tnx_record/lc_amt"/>
           </div></xsl:with-param>
          </xsl:call-template>
      </xsl:when>
      </xsl:choose>
      </xsl:when>
       <xsl:otherwise>
         <xsl:if test="$show-amt='Y' or $displaymode='view'">
       		<xsl:call-template name="currency-field">
       		<xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
       		<xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
       		<xsl:with-param name="required">Y</xsl:with-param>
      		</xsl:call-template>
      	</xsl:if>
      </xsl:otherwise>      
     </xsl:choose>  
      
      
	  <!-- Can show available amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-available-amt='Y' or $displaymode='view'">
      
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_available_amt</xsl:variable>
       <xsl:variable name="field-cur-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>

       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="type">amount</xsl:with-param>
        <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()=$field-cur-name]"/></xsl:with-param>
        <xsl:with-param name="name"><xsl:value-of select="$field-name"/></xsl:with-param>
        <xsl:with-param name="size">20</xsl:with-param>
        <xsl:with-param name="appendClass">available</xsl:with-param>
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
      
      
      <!-- Can show Liability amt field in the form. -->
      <!-- Also shown in consolidated view -->      
      <xsl:if test="$show-liability-amt='Y' or $displaymode='view' and security:isBank($rundata)">
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
       <xsl:variable name="field-cur-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
       
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
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
      <!-- Can show outstanding amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-outstanding-amt='Y' or $displaymode='view'">
      
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_outstanding_amt</xsl:variable>
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
      <!-- Variation in drawing. -->
      <xsl:if test="$show-variation-drawing='Y' and (lc_type[.!='04'] or tnx_type_code[.!='01'])">
       <xsl:call-template name="label-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:call-template name="hidden-field">
           	<xsl:with-param name="name">DrawingTolerence_spl</xsl:with-param>
           	<xsl:with-param name="value" select="defaultresource:getResource('TOLERANCE_WITH_NOTEXCEEDING')"/>
         </xsl:call-template>
         <!-- <div class="group-fields">  -->
         <xsl:choose>
         <xsl:when test="$displaymode='edit' ">
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
          </xsl:when>
          <xsl:otherwise>
     		 <xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[.!=''] and pstv_tol_pct[. = '']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="org_previous_file/si_tnx_record/pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
          </xsl:if>
            <xsl:if test="org_previous_file/si_tnx_record/neg_tol_pct[.!=''] and neg_tol_pct[. = '']">
            &nbsp;
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="org_previous_file/si_tnx_record/neg_tol_pct"/> 
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[.!=''] and pstv_tol_pct[. = '']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="org_previous_file/lc_tnx_record/pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/lc_tnx_record/neg_tol_pct[.!=''] and neg_tol_pct[. = '']">
            &nbsp;
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="org_previous_file/lc_tnx_record/neg_tol_pct"/> 
              </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
          <xsl:if test="pstv_tol_pct[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="neg_tol_pct[.!='']">
             &nbsp;
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
                <xsl:if test="pstv_tol_pct[.='']">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="neg_tol_pct"/> 
              </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
        </xsl:otherwise>
        </xsl:choose>
         <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL</xsl:with-param>
           <xsl:with-param name="name">max_cr_desc_code</xsl:with-param>
           <xsl:with-param name="options">
            <xsl:choose>
             <xsl:when test="$displaymode='edit'">
                <option/>
	            <option value="3">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
	            </option>
             </xsl:when>
            </xsl:choose>
           </xsl:with-param>
          </xsl:call-template>
          
           </xsl:with-param>
       </xsl:call-template>
          
          <xsl:if test="$displaymode='view' and max_cr_desc_code[.!='']">
          <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
          <xsl:if test="max_cr_desc_code[. = '3']">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
          </xsl:if>
			</div>
          </xsl:with-param>
          </xsl:call-template>
          </xsl:if> 
      
       <!-- Charges borne by flags  -->
       <xsl:if test="open_chrg_brn_by_code !=''">
       	 <xsl:apply-templates select="open_chrg_brn_by_code">
	        <xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
	        <xsl:with-param name="label">XSL_CHRGDETAILS_ISS_LABEL</xsl:with-param>
       	 </xsl:apply-templates>
		   <xsl:call-template name="split_charges">
			<xsl:with-param name="name">open_chrg</xsl:with-param>
		   </xsl:call-template>
       </xsl:if>
       <xsl:if test="corr_chrg_brn_by_code !=''"> 
	       <xsl:apply-templates select="corr_chrg_brn_by_code">
	        <xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
	        <xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
	       </xsl:apply-templates>
		   <xsl:call-template name="split_charges">
			<xsl:with-param name="name">corr_chrg</xsl:with-param>
		   </xsl:call-template>
       </xsl:if>

       <xsl:if test="((cfm_chrg_brn_by_code !='' or tnx_type_code[.='01']) or (($product-code = 'LC' or $product-code = 'SI' or $product-code = 'SR' or $product-code = 'EL') and tnx_type_code[.='03' or .='15'])) and $confirmationChargesEnabled and is_MT798[.='N']"> 
            <xsl:apply-templates select="cfm_chrg_brn_by_code">
	        <xsl:with-param name="node-name">cfm_chrg_brn_by_code</xsl:with-param>
	        <xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
	       </xsl:apply-templates>
  		   <xsl:call-template name="split_charges">
			<xsl:with-param name="name">cfm_chrg</xsl:with-param>
		   </xsl:call-template>
       </xsl:if>
      </xsl:if>
      
      <xsl:if test=" (lc_type ='02' and security:isBank($rundata))">
       <xsl:call-template name="label-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:call-template name="hidden-field">
           	<xsl:with-param name="name">DrawingTolerence_spl</xsl:with-param>
           	<xsl:with-param name="value" select="defaultresource:getResource('TOLERANCE_WITH_NOTEXCEEDING')"/>
         </xsl:call-template>
         <!-- <div class="group-fields">  -->
         <xsl:choose>
         <xsl:when test="$displaymode='view' ">
     		 <xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[.!=''] and pstv_tol_pct[. = '']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="org_previous_file/si_tnx_record/pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
          </xsl:if>
            <xsl:if test="org_previous_file/si_tnx_record/neg_tol_pct[.!=''] and neg_tol_pct[. = '']">
            &nbsp;
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="org_previous_file/si_tnx_record/neg_tol_pct"/> 
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[.!=''] and pstv_tol_pct[. = '']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="org_previous_file/lc_tnx_record/pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/lc_tnx_record/neg_tol_pct[.!=''] and neg_tol_pct[. = '']">
            &nbsp;
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="org_previous_file/lc_tnx_record/neg_tol_pct"/> 
              </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
          <xsl:if test="pstv_tol_pct[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="neg_tol_pct[.!='']">
             &nbsp;
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
                <xsl:if test="pstv_tol_pct[.='']">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="neg_tol_pct"/> 
              </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       </xsl:call-template>
     </xsl:if>
     </div>
    
 <xsl:if test="$show-applicable-rules='Y'">
	     <xsl:if test="(product_code[.='LC'] or product_code[.='EL']) or (product_code[.='SR'] and lc_type[.!=02]) or (product_code[.='SI'] and lc_type[.=02])">
	     	<xsl:call-template name = "applicable-rules"/>
	     </xsl:if>
	 </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  
  <xsl:template name="split_charges">
  	<xsl:param name="name"/>
  	<xsl:param name="applicant-label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT_PART')"/></xsl:param>
  	<xsl:param name="beneficiary-label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY_PART')"/></xsl:param>
  	
  	<xsl:param name="override-currency-name"><xsl:value-of select="$name"/>_currency</xsl:param>  	
  	<xsl:param name="override-applicant-name"><xsl:value-of select="$name"/>_applicant</xsl:param>
  	<xsl:param name="override-beneficiary-name"><xsl:value-of select="$name"/>_beneficiary</xsl:param>

  	<xsl:param name="currency_value" select="lc_cur_code"/> 
  	<xsl:param name="applicant_amt" select="//*[name()=$override-applicant-name]"/>
  	<xsl:param name="beneficiary_amt" select="//*[name()=$override-beneficiary-name]"/>  
  	
  	<xsl:if test="defaultresource:getResource('CHARGE_SPLITTING_LC') = 'true' and $product-code='LC'">
		<xsl:call-template name="multioption-group">
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">
					    <span><xsl:value-of select="$applicant-label"/></span>
					    <div class="small" maxLength="16" dojoType="misys.form.CurrencyTextBox" trim="true">
					     <xsl:attribute name="id"><xsl:value-of select="$override-applicant-name"/></xsl:attribute>
					     <xsl:attribute name="name"><xsl:value-of select="$override-applicant-name"/></xsl:attribute>
					     <xsl:attribute name="value"><xsl:value-of select="$applicant_amt"/></xsl:attribute>     
					     <xsl:attribute name="constraints">{min:0.00}</xsl:attribute>
					     <xsl:attribute name="disabled">true</xsl:attribute>
					     <xsl:attribute name="required">false</xsl:attribute>
					     <xsl:attribute name="readOnly">false</xsl:attribute>
					    </div>
						&nbsp;&nbsp;<span><xsl:value-of select="$beneficiary-label"/></span>
					    <div class="small" maxLength="16" dojoType="misys.form.CurrencyTextBox" trim="true">
					     <xsl:attribute name="id"><xsl:value-of select="$override-beneficiary-name"/></xsl:attribute>
					     <xsl:attribute name="name"><xsl:value-of select="$override-beneficiary-name"/></xsl:attribute>
					     <xsl:attribute name="value"><xsl:value-of select="$beneficiary_amt"/></xsl:attribute>     
					     <xsl:attribute name="constraints">{min:0.00}</xsl:attribute>
					     <xsl:attribute name="disabled">true</xsl:attribute>
					     <xsl:attribute name="required">false</xsl:attribute>
					     <xsl:attribute name="readOnly">false</xsl:attribute>
					    </div>		    	    
				    </xsl:when>
				    <xsl:otherwise>
				    	<xsl:if test="$applicant_amt !=''">
					    	<span><xsl:value-of select="$applicant-label"/></span>
					    	<div class="content"><xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="$applicant_amt"/></div>
					    	&nbsp;&nbsp;
					    </xsl:if>
					    <xsl:if test="$beneficiary_amt !=''">
					    	<span><xsl:value-of select="$beneficiary-label"/></span>
					    	<div class="content"><xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="$beneficiary_amt"/></div>
				    	</xsl:if>
				    </xsl:otherwise>			    
			    </xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	   <script>
	   		dojo.ready(function(){
		        	misys._config = misys._config || {};
					misys._config.charge_splitting_lc = <xsl:value-of select="defaultresource:getResource('CHARGE_SPLITTING_LC') = 'true'"/>;	
				});
	   </script>
	</xsl:if>	
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
  
  <!--
   Credit Available By Code
  -->
 <xsl:template match="cr_avl_by_code">
   <xsl:param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL</xsl:param>
   <xsl:variable name="cr_avl_by_code_value"><xsl:value-of select="."/></xsl:variable>
 <xsl:choose>
    <xsl:when test="$displaymode='edit'">
	   	<xsl:call-template name="multioption-group">
	   	 <xsl:with-param name="group-label" select="$label"/>
	    <xsl:with-param name="content">   
	       <xsl:call-template name="radio-field">
	        <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_PAYMENT</xsl:with-param>
	        <xsl:with-param name="name">cr_avl_by_code</xsl:with-param>
	        <xsl:with-param name="id">cr_avl_by_code_1</xsl:with-param>
	        <xsl:with-param name="value">01</xsl:with-param>
	        <xsl:with-param name="radio-value"><xsl:value-of select="$cr_avl_by_code_value"/></xsl:with-param>
	        <xsl:with-param name="checked"><xsl:if test="cr_avl_by_code[. = '01']">Y</xsl:if></xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="radio-field">
	        <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_ACCEPTANCE</xsl:with-param>
	        <xsl:with-param name="name">cr_avl_by_code</xsl:with-param>
	        <xsl:with-param name="id">cr_avl_by_code_2</xsl:with-param>
	        <xsl:with-param name="value">02</xsl:with-param>
	        <xsl:with-param name="radio-value"><xsl:value-of select="$cr_avl_by_code_value"/></xsl:with-param>
	        <xsl:with-param name="checked"><xsl:if test="cr_avl_by_code[. = '02']">Y</xsl:if></xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="radio-field">
	        <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_NEGOTIATION</xsl:with-param>
	        <xsl:with-param name="name">cr_avl_by_code</xsl:with-param>
	        <xsl:with-param name="id">cr_avl_by_code_3</xsl:with-param>
	        <xsl:with-param name="value">03</xsl:with-param>
	        <xsl:with-param name="radio-value"><xsl:value-of select="$cr_avl_by_code_value"/></xsl:with-param>
	        <xsl:with-param name="checked"><xsl:if test="cr_avl_by_code[. = '03']">Y</xsl:if></xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="radio-field">
	        <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEFERRED</xsl:with-param>
	        <xsl:with-param name="name">cr_avl_by_code</xsl:with-param>
	        <xsl:with-param name="id">cr_avl_by_code_4</xsl:with-param>
	        <xsl:with-param name="value">04</xsl:with-param>
	        <xsl:with-param name="radio-value"><xsl:value-of select="$cr_avl_by_code_value"/></xsl:with-param>
	        <xsl:with-param name="checked"><xsl:if test="cr_avl_by_code[. = '04']">Y</xsl:if></xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="radio-field">
	        <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED</xsl:with-param>
	        <xsl:with-param name="name">cr_avl_by_code</xsl:with-param>
	        <xsl:with-param name="id">cr_avl_by_code_5</xsl:with-param>
	        <xsl:with-param name="value">05</xsl:with-param>
	        <xsl:with-param name="radio-value"><xsl:value-of select="$cr_avl_by_code_value"/></xsl:with-param>
	        <xsl:with-param name="checked"><xsl:if test="cr_avl_by_code[. = '05']">Y</xsl:if></xsl:with-param>
	       </xsl:call-template>
	       <xsl:if test="$product-code='SI' or $product-code='SR'">
		       <xsl:call-template name="radio-field">
		        <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEMAND</xsl:with-param>
		        <xsl:with-param name="name">cr_avl_by_code</xsl:with-param>
		        <xsl:with-param name="id">cr_avl_by_code_6</xsl:with-param>
		        <xsl:with-param name="value">06</xsl:with-param>
		        <xsl:with-param name="radio-value"><xsl:value-of select="$cr_avl_by_code_value"/></xsl:with-param>
		        <xsl:with-param name="checked"><xsl:if test="cr_avl_by_code[. = '06']">Y</xsl:if></xsl:with-param>
		       </xsl:call-template>
	       </xsl:if>	       
	         </xsl:with-param>
	   </xsl:call-template>	
     </xsl:when>
     <xsl:otherwise>
             <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL</xsl:with-param>
		       <xsl:with-param name="value">
		       	 <xsl:choose>
	             	<xsl:when test="$cr_avl_by_code_value = '01'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_PAYMENT')"/></xsl:when>
	             	 <xsl:when test="$cr_avl_by_code_value = '02'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_ACCEPTANCE')"/></xsl:when>
	             	<xsl:when test="$cr_avl_by_code_value = '03'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_NEGOTIATION')"/></xsl:when>
	             	<xsl:when test="$cr_avl_by_code_value = '04'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEFERRED')"/></xsl:when>
	             	<xsl:when test="$cr_avl_by_code_value = '05'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED')"/></xsl:when>
	             	<xsl:when test="$cr_avl_by_code_value = '06' and ($product-code='SI' or $product-code='SR')"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEMAND')"/></xsl:when>
	             </xsl:choose>
		       </xsl:with-param>
		       <xsl:with-param name="displaymode">view</xsl:with-param>
		     </xsl:call-template>   
      </xsl:otherwise>
   </xsl:choose>

  </xsl:template>
 
  <!--
  Renewal Details, used in SI and SR forms.
  -->
  <xd:doc>
	<xd:short>Creates renewal details section.</xd:short>
	<xd:detail>
		This tempalte will create the renewal section.
	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-renewal-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_RENEWAL_DETAILS_LABEL</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Don't show checkbox value in summary -->
     <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="checkbox-field">
       <xsl:with-param name="name">renew_flag</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="renew_flag"/></xsl:with-param>
       <xsl:with-param name="label">XSL_RENEWAL_ALLOWED</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">renew_on_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="01">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
	       </option>
	       <option value="02">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/>
	       </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:when>
          <xsl:when test="renew_on_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="name">renewal_calendar_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_RENEWAL_RENEW_FOR</xsl:with-param>
       <xsl:with-param name="name">renew_for_nb</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">renew_for_period</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="options">
       <xsl:call-template name="renew-time-period-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <xsl:call-template name="checkbox-field">
        <xsl:with-param name="name">advise_renewal_flag</xsl:with-param>
        <xsl:with-param name="label">XSL_RENEWAL_ADVISE</xsl:with-param>
        <xsl:with-param name="disabled">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      	<xsl:if test="advise_renewal_flag[.!='N']">
       <div class="indented-header">
        <h3><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE')"/></h3>
       </div>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_RENEWAL_DAYS_NOTICE</xsl:with-param>
      <xsl:with-param name="name">advise_renewal_days_nb</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <xsl:call-template name="checkbox-field">
        <xsl:with-param name="name">rolling_renewal_flag</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="rolling_renewal_flag"/></xsl:with-param>
        <xsl:with-param name="label">XSL_RENEWAL_ROLLING_RENEWAL</xsl:with-param>
        <xsl:with-param name="disabled">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      <xsl:if test="renew_flag[.!='N']">
       <div class="indented-header">
        <h3><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL')"/></h3>
       </div>
      </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
      <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">rolling_renew_on_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="01">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
	       </option>
	       <option value="03">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
	       </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="rolling_renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:when>
          <xsl:when test="rolling_renew_on_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or ($displaymode='view' and rolling_renew_on_code[.='03'])">
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">FREQUENCY_LABEL</xsl:with-param>
       <xsl:with-param name="name">rolling_renew_for_nb</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">rolling_renew_for_period</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="disabled">Y</xsl:with-param>
       <xsl:with-param name="options">
       <xsl:call-template name="renew-time-period-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ROLLING_DAY_IN_MONTH</xsl:with-param>
       <xsl:with-param name="name">rolling_day_in_month</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">2</xsl:with-param>
       <xsl:with-param name="maxsize">2</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:1,max:31}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_renewal_nb</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_NUMBER_RENEWALS</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
      <xsl:with-param name="value">
      	<xsl:choose>
      		<xsl:when test="rolling_renewal_nb[.!='']"><xsl:value-of select="rolling_renewal_nb"/></xsl:when>
      		<xsl:when test="rolling_renewal_flag[.!='Y'] and renew_flag[.='Y']">1</xsl:when>
      	</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_cancellation_days</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_CANCELLATION_NOTICE</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>  
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">renew_amount_code</xsl:with-param>
       <xsl:with-param name="id">renew_amount_code</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="renew_amt_code"/></xsl:with-param>
     </xsl:call-template>

     <xsl:if test="renew_flag[.!='N'] or $displaymode='edit'">
     <xsl:call-template name="multioption-group">
      <xsl:with-param name="group-label">XSL_RENEWAL_AMOUNT</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:choose>
    		<xsl:when test="$displaymode='edit'">
		        <xsl:call-template name="radio-field">
		         <xsl:with-param name="label">XSL_RENEWAL_ORIGINAL_AMOUNT</xsl:with-param>
		         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
		         <xsl:with-param name="id">renew_amt_code_1</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="value">01</xsl:with-param>
		         <xsl:with-param name="radio-value"><xsl:value-of select="."/></xsl:with-param>
		        </xsl:call-template>
		        <xsl:call-template name="radio-field">
		         <xsl:with-param name="label">XSL_RENEWAL_CURRENT_AMOUNT</xsl:with-param>
		         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
		         <xsl:with-param name="id">renew_amt_code_2</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="value">02</xsl:with-param>
		         <xsl:with-param name="radio-value"><xsl:value-of select="."/></xsl:with-param>
		        </xsl:call-template>
       		</xsl:when>
    		<xsl:otherwise>
     			<xsl:call-template name="input-field">
				<xsl:with-param name="value">		
					<xsl:choose>
						<xsl:when test="renew_amt_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ORIGINAL_AMOUNT')"/></xsl:when>
					  	<xsl:when test="renew_amt_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CURRENT_AMOUNT')"/></xsl:when>
					</xsl:choose>
				</xsl:with-param>
				</xsl:call-template>
    		</xsl:otherwise>
   		</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     
     <xsl:if test="(projected_expiry_date[.!=''] and product_code[.='SI']) or product_code[.='SR'] or product_code[.='LC']">
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">projected_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_PROJECTED_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="readonly">
      	  <xsl:choose>
	      	<xsl:when test="security:isBank($rundata)">N</xsl:when>
	      	<xsl:otherwise>Y</xsl:otherwise>
	      </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">final_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_FINAL_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="readonly">N</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template> 
     <xsl:call-template name="hidden-field"> 
	    <xsl:with-param name="name">is_bank</xsl:with-param>
	    <xsl:with-param name="value">
	      	<xsl:choose>
		    	<xsl:when test="security:isBank($rundata)">Y</xsl:when>
		    	<xsl:otherwise>N</xsl:otherwise>
		    </xsl:choose>
	    </xsl:with-param>
	  </xsl:call-template> 
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Bank type <select> options. 
   -->
  <xsl:template name="bank-type-options">
  <xsl:variable name="type"><xsl:value-of select="//credit_available_with_bank_type"/></xsl:variable>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="Advising Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ADVISING_BANK')"/>
     </option>
     <option value="Any Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ANY_BANK')"/>
     </option>
     <option value="Issuing Bank">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ISSUING_BANK')"/>
     </option>
     <option value="Other">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
	<xsl:when test="translate($type,$up,$lo)='issuing bank'">
		<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ISSUING_BANK')"/>
	</xsl:when>
	<xsl:when test="translate($type,$up,$lo)='advising bank'">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ADVISING_BANK')"/>
	</xsl:when>
	<xsl:when test="translate($type,$up,$lo)='any bank'">
	<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ANY_BANK')"/>
			</xsl:when>		
      <xsl:otherwise>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

  <!--
   Renewal Time Period <select> options 
   -->
  <xsl:template name="renew-time-period-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="D">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/>
     </option>
     <option value="W">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/>
     </option>
     <option value="M">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/>
     </option>
     <option value="Y">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="renew_for_period[. = 'D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:when>
      <xsl:when test="renew_for_period[. = 'W']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:when>
      <xsl:when test="renew_for_period[. = 'M']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:when>
      <xsl:when test="renew_for_period[. = 'Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!-- 
   -->
  <xsl:template name="lc-payment-draft-fields">
   <xsl:param name="show-drawee"/>
   
   <div id="payment-draft">
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
      <xsl:variable name="name">tenor_type</xsl:variable>
      <xsl:variable name="radio-value" select="//*[name()=$name]"/>
      <div class="field multioption-group-label">
       <div class="label">
        <xsl:call-template name="localization-dblclick">
								<xsl:with-param name="xslName">XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL</xsl:with-param>
								<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')" />
		</xsl:call-template>
		<xsl:choose>
 			<xsl:when test="$rundata!='' ">
 				<xsl:value-of select="localization:getGTPString($rundata,$language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')"/>
 			</xsl:when>
	   		<xsl:otherwise>
	   			<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')"/>
	   		</xsl:otherwise>
	  	</xsl:choose>
							
       </div>
       <div id="tenor_type_1_row" class="field radio">
        <label for="tenor_type_1">
        <xsl:call-template name="localization-dblclick">
								<xsl:with-param name="xslName">XSL_PAYMENTDETAILS_TENOR_SIGHT</xsl:with-param>
								<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_PAYMENTDETAILS_TENOR_SIGHT')" />
		</xsl:call-template>
         <input dojoType="dijit.form.RadioButton" type="radio" name="tenor_type" id="tenor_type_1" value="01" disabled="true">
          <xsl:if test="$radio-value = '01'">
           <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>
         </input>
         <xsl:choose>
 			<xsl:when test="$rundata!='' ">
 				<xsl:value-of select="localization:getGTPString($rundata,$language, 'XSL_PAYMENTDETAILS_TENOR_SIGHT')"/>
 			</xsl:when>
	   		<xsl:otherwise>
	   			<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_SIGHT')"/>
	   		</xsl:otherwise>
	  	</xsl:choose>
       </label>
       </div>
       <div id="tenor_type_2_row" class="field radio">
        <label for="tenor_type_2">
        <xsl:call-template name="localization-dblclick">
								<xsl:with-param name="xslName">XSL_PAYMENTDETAILS_TENOR_MATURITY</xsl:with-param>
								<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_PAYMENTDETAILS_TENOR_MATURITY')" />
		</xsl:call-template>
         <input dojoType="dijit.form.RadioButton" type="radio" name="tenor_type" id="tenor_type_2" value="02" disabled="true">
          <xsl:if test="$radio-value = '02'">
           <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>
         </input>
         <xsl:choose>
 			<xsl:when test="$rundata!='' ">
 				<xsl:value-of select="localization:getGTPString($rundata,$language, 'XSL_PAYMENTDETAILS_TENOR_MATURITY')"/>
 			</xsl:when>
	   		<xsl:otherwise>
	   			<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MATURITY')"/>
	   		</xsl:otherwise>
	  	</xsl:choose>
      <!--   </label> -->
         
		 </label>	
        <div class="small" maxLength="10" id="tenor_maturity_date" name="tenor_maturity_date" dojoType="dijit.form.DateTextBox" trim="true">
         <xsl:attribute name="value"><xsl:value-of select="tenor_maturity_date"/></xsl:attribute>
         <xsl:attribute name="displayedValue"><xsl:value-of select="tenor_maturity_date"/></xsl:attribute>
        </div>
       </div>
       <div id="tenor_type_3_row" class="field radio">
        <label for="tenor_type_3">
         <input dojoType="dijit.form.RadioButton" type="radio" name="tenor_type" id="tenor_type_3" value="03" disabled="true">
          <xsl:if test="$radio-value = '03'">
           <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>
         </input>
        </label>
        <div class="x-small" maxLength="3" id="tenor_days" name="tenor_days" dojoType="dijit.form.NumberTextBox" trim="true" value="">
         <xsl:attribute name="value"><xsl:value-of select="tenor_days"/></xsl:attribute>
         <xsl:attribute name="constraints">{places:'0',min:0, max:999}</xsl:attribute>
        </div>
        <!-- TODO Change to use template -->
	    <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="tenor_period" id="tenor_period" class="small">
	     <xsl:attribute name="value"><xsl:value-of select="tenor_period"/></xsl:attribute>
         <option value="D">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/>
         </option>
         <option value="W">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/>
         </option>
         <option value="M">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/>
         </option>
         <option value="Y">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/>
         </option>
        </select>
	    <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="tenor_from_after" id="tenor_from_after" class="small">
	     <xsl:attribute name="value"><xsl:value-of select="tenor_from_after"/></xsl:attribute>
         <option value="F">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_FROM')"/>
         </option>
         <option value="A">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_AFTER')"/>
         </option>
        </select><br/>
        <div id="payment_draft_fields">
	    <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="tenor_days_type" id="tenor_days_type" class="large">
	     <xsl:attribute name="value"><xsl:value-of select="tenor_days_type"/></xsl:attribute>
         <option value="07">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_07')"/>
         </option>
         <option value="04">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_04')"/>
         </option>
         <option value="01">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_01')"/>
         </option>
         <option value="06">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_06')"/>
         </option>
         <option value="05">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_05')"/>
         </option>
         <option value="08">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_08')"/>
         </option>
         <option value="02">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_02')"/>
         </option>
         <option value="03">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_03')"/>
         </option>
         <option value="99">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_99')"/>
         </option>
        </select><br/>
        <xsl:if test = "tenor_days_type[.!='99']">
        <div disabled="disabled" class="medium swift" maxLength="222" id="tenor_type_details" name="tenor_type_details" dojoType="dijit.form.ValidationTextBox" trim="true">
         <xsl:attribute name="value"><xsl:value-of select="tenor_type_details"/></xsl:attribute>
        </div>
        </xsl:if>
         <xsl:if test = "tenor_days_type[.='99']">
        <div class="medium swift" maxLength="222" id="tenor_type_details" name="tenor_type_details" dojoType="dijit.form.ValidationTextBox" trim="true">
         <xsl:attribute name="value"><xsl:value-of select="tenor_type_details"/></xsl:attribute>
        </div>
        </xsl:if>
       </div>
       </div>
      </div> 
    </xsl:when>
    <xsl:otherwise>
     <div class="field">
     	<xsl:if test="$displaymode='view' and cr_avl_by_code[.='05']">
	    	<xsl:attribute name="style">display:none</xsl:attribute>
	   	</xsl:if>
	   	<xsl:if test="$displaymode='view' and tenor_type[.='03'] and draft_term[.=''] and security:isBank($rundata)">
	   	<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')"/></span>
      		<div class="content">
	   			<xsl:call-template name="tenor-types"/>
	   		</div>
	   	</xsl:if>
	   	<xsl:choose>
	   	<xsl:when test = "draft_term != ''">
      		<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')"/></span>
      		<div class="content">
      			<xsl:choose>
					<xsl:when test="tenor_maturity_date[.! = '']">
						<xsl:value-of select="localization:getGTPString($language, 'MATURITY_DATE')"/> 
						&#160;
						<xsl:call-template name="replace-eof-with-br-tag">
				 		 	<xsl:with-param name="text"><xsl:value-of select="draft_term"/></xsl:with-param>
				 		</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="replace-eof-with-br-tag">
				 		 	<xsl:with-param name="text"><xsl:value-of select="draft_term"/></xsl:with-param>
				 		</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
      		</div>
      	</xsl:when>
      	<xsl:otherwise>
      	</xsl:otherwise>
      	</xsl:choose>
     </div>	
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="$show-drawee='Y'">
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
      <xsl:call-template name="select-field">
       <xsl:with-param name="label">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL</xsl:with-param>
       <xsl:with-param name="name">drawee_details_bank_name</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="drawee_details_bank/name"/></xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="options">
        <xsl:call-template name="drawee-details-banks"/>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:when>
     <xsl:when test="drawee_details_bank/name[.!=''] and $displaymode='view'">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
       <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="drawee_details_bank">
         <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="show-button">N</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:when>
    </xsl:choose>
   </xsl:if>
   </div>
  </xsl:template>
  
  <xsl:template name="tenor-types">
	<xsl:if test="tenor_type[.!='01'] and tenor_days[.!=''] and tenor_period[.!='']">
		<xsl:value-of select="tenor_days"/><xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="tenor_period[.='D']">
					  <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_DAYS')"/>
			</xsl:when>
			<xsl:when test="tenor_period[.='W']">
					  <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_WEEKS')"/>
			</xsl:when>
			<xsl:when test="tenor_period[.='M']">
					  <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_MONTHS')"/>
			</xsl:when>
			<xsl:when test="tenor_period[.='Y']">
					  <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_YEARS')"/>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="tenor_from_after[.='A']">
			<xsl:text> </xsl:text>
					  <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
			<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="tenor_from_after[.='E']">
			<xsl:text> </xsl:text>
					  <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
			<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="tenor_from_after[.='F']">
			<xsl:text> </xsl:text>
					  <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
			<xsl:text> </xsl:text>
			</xsl:when>	
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="tenor_days_type[.='O']">
					<xsl:value-of select="tenor_type_details"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="tenor_days_type[.='07']">
				         <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_07')"/>
				    </xsl:when>
			         <xsl:when test="tenor_days_type[.='04']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_04')"/>
			         </xsl:when>
			          <xsl:when test="tenor_days_type[.='01']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_01')"/>
			         </xsl:when>
			          <xsl:when test="tenor_days_type[.='06']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_06')"/>
			         </xsl:when>
			          <xsl:when test="tenor_days_type[.='05']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_05')"/>
			         </xsl:when>
			         <xsl:when test="tenor_days_type[.='08']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_08')"/>
			         </xsl:when>
			         <xsl:when test="tenor_days_type[.='02']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_02')"/>
			         </xsl:when>
			         <xsl:when test="tenor_days_type[.='03']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_03')"/>
			         </xsl:when>
			         <xsl:when test="tenor_days_type[.='99']">
			          <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_99')"/>
			         </xsl:when>
			      </xsl:choose>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:if>
  </xsl:template>
  
   <!--
   Narrative Other Details (Bank Side)
   -->
  <xsl:template name="lc-bank-narrative-other">
   <!-- Tabgroup #2 : Narrative Other (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    
    
    <!-- Tab 2_0 - Charges Details  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
      <xsl:with-param name="rows">485</xsl:with-param>
      <xsl:with-param name="cols">65</xsl:with-param>
      <xsl:with-param name="maxlines">485</xsl:with-param>
     </xsl:call-template> 
    </xsl:with-param>
    
    <!-- Tab 2_1 - Period Presentation  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2_2 - Shipment Period  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
<!--  Transport mode field (MT798)-->
  <xsl:template name="transport-mode-fields"> 
 	<xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRANSPORT_MODE</xsl:with-param>
        <xsl:with-param name="name">transport_mode_nosend</xsl:with-param>
 		<xsl:with-param name="value">
 		<xsl:if test="transport_mode[. = 'AIRT'  or . = 'SEAT' or . = 'RAIL' or . = 'ROAD' or . = 'MULT' or . = 'OTHR']"><xsl:value-of select="transport_mode"/></xsl:if>
       </xsl:with-param>      
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
       	 <!-- <option value=""/> -->
          <option value="AIRT">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_AIRT')"/>
	      </option>
	      <option value="SEAT">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_SEAT')"/>
	      </option>
	      <option value="RAIL">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_RAIL')"/>
	      </option>
	      <option value="ROAD">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_ROAD')"/>
	      </option>
	      <option value="MULT">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_MULT')"/>
	      </option>
	      <option value="OTHR">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_OTHR')"/>
	      </option>		      	      	      
        </xsl:when>
        <xsl:otherwise>
			<xsl:choose>
          		<xsl:when test="transport_mode[. = 'AIRT'  or . = 'SEAT' or . = 'RAIL' or . = 'ROAD' or . = 'MULT']">         
      				<xsl:value-of select="localization:getDecode($language, 'N803', transport_mode)"/>
      			</xsl:when>
      			<xsl:otherwise>
      			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_OTHR')"/>
      			</xsl:otherwise>
      		</xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
    <xsl:if test="$displaymode='edit' or transport_mode[. != '' and . != 'AIRT'  and . != 'SEAT' and . != 'RAIL' and . != 'ROAD' and . != 'MULT']">
     <xsl:call-template name="input-field">
        <xsl:with-param name="name">transport_mode_text_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:if test="transport_mode[. != '' and . != 'AIRT'  and . != 'SEAT' and . != 'RAIL' and . != 'ROAD' and . != 'MULT']"> 
        <xsl:value-of select="transport_mode"/>
       </xsl:if>
      </xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">transport_mode</xsl:with-param>
     </xsl:call-template>
    </xsl:template>  
  
 <!--  Amendment number template as it is used twice in the file-->
 <xsl:template name="amendmentNumber">
 	<xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
       <xsl:with-param name="name">amd_no</xsl:with-param>
       <xsl:with-param name="type">number</xsl:with-param>
       <xsl:with-param name="size">2</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-value">Y</xsl:with-param>
	   <xsl:with-param name="custom-value"><xsl:value-of select="utils:formatAmdNo(amd_no)"/></xsl:with-param>
      </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="amendmentDate">
 	<xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
       <xsl:with-param name="name">amd_date</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="override-value">Y</xsl:with-param>
      </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="replace-eof-with-br-tag">
	  <xsl:param name="text"/>
	  <xsl:choose>
	    <xsl:when test="contains($text, '&#xa;')">
	      <xsl:value-of select="substring-before($text, '&#xa;')"/>
	      <br/>
	      <xsl:call-template name="replace-eof-with-br-tag">
	        <xsl:with-param name="text" select="substring-after($text, '&#xa;')"/>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$text"/>
	    </xsl:otherwise>
	  </xsl:choose>
 </xsl:template>
 
 <xsl:template name="delivery-mode-options">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='N'">
      <option value=""></option>
     </xsl:if>
     	<xsl:if test="($product-code = 'SI')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C083</xsl:with-param>
			 <xsl:with-param name="productCode">SI</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		 <xsl:if test="($product-code = 'LC')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C083</xsl:with-param>
			 <xsl:with-param name="productCode">LC</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
    
 
 <xsl:template name="delivery-to-options">
  <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='Y'">
      <option value=""></option>
     </xsl:if>
     	<xsl:if test="($product-code = 'SI')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C084</xsl:with-param>
			 <xsl:with-param name="productCode">SI</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($product-code = 'LC')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C084</xsl:with-param>
			 <xsl:with-param name="productCode">LC</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
  
   	<xsl:template name="exp-date-type-code-options">
	   <xsl:param name="option-required">Y</xsl:param>
	   <xsl:choose>
	    <xsl:when test="$displaymode='edit'">
	       	<xsl:if test="($product-code = 'SI')">
	            <xsl:call-template name="code-data-options">
				 <xsl:with-param name="paramId">C085</xsl:with-param>
				 <xsl:with-param name="productCode">SI</xsl:with-param>
				 <xsl:with-param name="specificOrder">Y</xsl:with-param>
				 <xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="($product-code = 'SR')">
	            <xsl:call-template name="code-data-options">
				 <xsl:with-param name="paramId">C088</xsl:with-param>
				 <xsl:with-param name="productCode">SR</xsl:with-param>
				 <xsl:with-param name="specificOrder">Y</xsl:with-param>
				 <xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="($product-code ='LC')">
	            <xsl:call-template name="code-data-options">
				 <xsl:with-param name="paramId">C085</xsl:with-param>
				 <xsl:with-param name="productCode">LC</xsl:with-param>
				 <xsl:with-param name="specificOrder">Y</xsl:with-param>
				 <xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:when>
	   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="demand-indicator">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
       	<xsl:if test="($product-code = 'SI')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C089</xsl:with-param>
			 <xsl:with-param name="productCode">SI</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
 
  <xsl:template name="basic-amt-details-with-variation">
   <xsl:param name="show-variation-drawing">Y</xsl:param>
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label" select="$label"/>
      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     <!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view'">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	     <xsl:if test="$field-value !=''">
	      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	     </xsl:if>
	   </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
      <!-- Variation in drawing. -->
      <xsl:if test="$show-variation-drawing='Y' and (lc_type[.!='04'] or tnx_type_code[.!='01'])">
       <xsl:call-template name="label-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="content">
         <!-- <div class="group-fields">  -->
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
       </xsl:with-param>
       </xsl:call-template>
     
      </xsl:if>

    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
    
</xsl:stylesheet>
