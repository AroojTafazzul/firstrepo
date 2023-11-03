<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Bank Beneficiary (On customer side) Screen, System Form.
 
 Note that no JavaScript calls can be made in this template as its loaded via an AJAX
 href call. Dojo currently does no evaluate inline JavaScript in HTML content loaded
 in this manner.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      30/04/08
author:    Laure Blin
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization securityCheck utils defaultresource">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="companyType" />
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="formname"/>
  <xsl:param name="token"/>
  <xsl:param name="productcode"/>
  <xsl:param name="productCode">
   <xsl:choose>
    <xsl:when test="not (productcode[.=''])"><xsl:value-of select="$productcode"/></xsl:when>
    <xsl:otherwise>*</xsl:otherwise>
   </xsl:choose>
  </xsl:param>
  <xsl:param name="fields"/>
  <xsl:param name="submitscreen">
   <xsl:choose>
    <xsl:when test="security:isCustomer($rundata)">CustomerSystemFeaturesScreen</xsl:when>
    <xsl:otherwise>TradeAdminScreen</xsl:otherwise>
   </xsl:choose>
  </xsl:param>
  <xsl:param name="counterparty_email_required">
	 <xsl:value-of select="defaultresource:getResource('COUNTERPARTY_EMAIL_REQUIRED')"/>
  </xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="static_beneficiary | static_bank">
   <!--Define the nodeName variable for the current static data  --> 
   <xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="id">popup_<xsl:value-of select="$main-form-name"/></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields">
      	<xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="bank-beneficiary-details">
      	<xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="bankBeneficiary-other-details">
      	<xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="popup-menu"/> 
     </xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="realform">
     <xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
    </xsl:call-template>
    
    
  </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:param name="nodeName"/>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"></xsl:with-param>
	<xsl:with-param name="id">node_name</xsl:with-param>
	<xsl:with-param name="value" select="$nodeName"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">brch_code</xsl:with-param>
	<xsl:with-param name="id">popup_brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">company_id</xsl:with-param>
	<xsl:with-param name="id">popup_company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:choose>
	<xsl:when test="contains($nodeName,'static_bank')">
	 <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">bank_id</xsl:with-param>
	  <xsl:with-param name="id">popup_bank_id</xsl:with-param>
     </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	 <xsl:call-template name="hidden-field">
  	  <xsl:with-param name="name">beneficiary_id</xsl:with-param>
  	  <xsl:with-param name="id">popup_beneficiary_id</xsl:with-param>
 	 </xsl:call-template>
	</xsl:otherwise>
   </xsl:choose>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">address_address_line_1</xsl:with-param>
	<xsl:with-param name="id">popup_address_address_line_1</xsl:with-param>
	<xsl:with-param name="value"><xsl:value-of select="address_line_1"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">swift_address_address_line_1</xsl:with-param>
	<xsl:with-param name="id">popup_swift_address_address_line_1</xsl:with-param>
	<xsl:with-param name="value"><xsl:value-of select="post_code"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	 <xsl:with-param name="id">popup_token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
    </xsl:call-template>
  </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank Beneficiary
  -->
 <xsl:template name="bank-beneficiary-details">
  <xsl:param name="nodeName"/>
  <!-- add title if popup-->
  <xsl:if test="$formname != ''">
   <xsl:choose>
	<xsl:when test="$nodeName ='static_bank'">
	 <xsl:value-of select="localization:getGTPString($language, 'OpenAddBankCSF')"/>
	</xsl:when>
	<xsl:when test="$nodeName ='static_beneficiary'">
	 <xsl:value-of select="localization:getGTPString($language, 'OpenAddBeneficiaryCSF')"/>
    </xsl:when>				
   </xsl:choose>				
  </xsl:if>
  
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <!-- Entity -->
 	<xsl:choose>
     <xsl:when test="entities">
      <xsl:call-template name="entity-field">
       <xsl:with-param name="popup-entity-prefix">sy_</xsl:with-param>
       <xsl:with-param name="button-type">popup-entity</xsl:with-param>
       <xsl:with-param name="entity-label">XSL_JURISDICTION_ENTITY</xsl:with-param>
       <xsl:with-param name="override-product-code"><xsl:value-of select="$productCode"/></xsl:with-param>
       <xsl:with-param name="required">
        <xsl:choose>
        <xsl:when test="entities[.='0']">N</xsl:when>
        <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
 	 </xsl:when>
   	 <xsl:otherwise>
   	  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">entity</xsl:with-param>
       <xsl:with-param name="id">popup_entity</xsl:with-param>
       <xsl:with-param name="value">*</xsl:with-param>
      </xsl:call-template>
     </xsl:otherwise>
   	</xsl:choose>
 	
 	<!-- Abbreviated Name -->   
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
     <xsl:with-param name="name">abbv_name</xsl:with-param>
     <xsl:with-param name="id">popup_abbv_name</xsl:with-param>
     <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BANK_ABBVNAME_VALIDATION_REGEX')"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
     
 	<!-- Name -->    
	<xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
     <xsl:with-param name="name">name</xsl:with-param>
     <xsl:with-param name="id">popup_name</xsl:with-param>
     <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>

     <xsl:if test="$nodeName = 'static_beneficiary'">
	 	<!-- Inclusion of Credit Note Product Sub Header-->
	 	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">MENU_CHANGE_PRODUCTS</xsl:with-param><!--TODO: Have to create localized header -->
	    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	    <xsl:with-param name="content">
			<!-- TMA Proprietary Id Field only for IO products -->
			<!-- TMA Proprietary Id field appears Only for beneficiary and Non-invoice Financing programme,
				 and with counterparty collaboration disabled and Non-credit note products -->
			<xsl:if test="contains($nodeName,'static_beneficiary') and $companyType and $companyType='03'"> 
				<xsl:if test="securityCheck:hasCompanyPermission($rundata,'io_access') or securityCheck:hasCompanyPermission($rundata,'ea_access')">
					<xsl:call-template name="multichoice-field">
						<xsl:with-param name="name">prtry_id_type_flag</xsl:with-param>
						<xsl:with-param name="id">popup_prtry_id_type_flag</xsl:with-param>
						<xsl:with-param name="checked">N</xsl:with-param>
						<xsl:with-param name="type">checkbox</xsl:with-param>
						<xsl:with-param name="disabled">N</xsl:with-param>
						<xsl:with-param name="label">XSL_TMA_PROPRIETARY_ID</xsl:with-param>
					</xsl:call-template>
					<div id="popup_prtry_id_type_div" style="display:none;">
				   	 <xsl:call-template name="input-field">
				      <xsl:with-param name="label">XSL_PROPRIETARY_ID_AND_TYPE_LABEL</xsl:with-param>
				      <xsl:with-param name="name">prtry_id_type</xsl:with-param>
				      <xsl:with-param name="id">popup_prtry_id_type</xsl:with-param>
				      <xsl:with-param name="maxsize">71</xsl:with-param>
				      <xsl:with-param name="required">Y</xsl:with-param>
				     </xsl:call-template>
					</div>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">prtry_id_type_separator</xsl:with-param>
						<xsl:with-param name="id">popup_prtry_id_type_separator</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="substring(defaultresource:getResource('TMA_PROPRIETARY_ID_SEPARATOR'), 1, 1)"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
	    </xsl:with-param>
	   </xsl:call-template>
    </xsl:if>
 	
 	<!-- Template in "system_common.xsl":
 		To deal with Main details (Tabs for SWIFT and POSTAL address -->
   <xsl:call-template name="address-details">
	<xsl:with-param name="addressMandatory">Y</xsl:with-param>   
    <xsl:with-param name="prefix">popup</xsl:with-param>
   </xsl:call-template>
  </xsl:with-param>
 </xsl:call-template>
</xsl:template>
 
 
 <!--
 	Bank Beneficiary Others Details 
  -->
  <xsl:template name="bankBeneficiary-other-details">
   <xsl:param name="nodeName"/>
  	
   <xsl:call-template name="fieldset-wrapper">
   	<xsl:with-param name="legend">XSL_HEADER_OTHER_DETAILS</xsl:with-param>
   	<xsl:with-param name="content">
   	 <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_CONTACT_NAME</xsl:with-param>
      <xsl:with-param name="name">contact_name</xsl:with-param>
      <xsl:with-param name="id">popup_contact_name</xsl:with-param>
      <xsl:with-param name="size">30</xsl:with-param>
      <xsl:with-param name="maxsize">30</xsl:with-param>
     </xsl:call-template>	
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_PHONE</xsl:with-param>
      <xsl:with-param name="name">phone</xsl:with-param>
      <xsl:with-param name="id">popup_phone</xsl:with-param>
      <xsl:with-param name="size">32</xsl:with-param>
      <xsl:with-param name="maxsize">32</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_FAX</xsl:with-param>
      <xsl:with-param name="name">fax</xsl:with-param>
      <xsl:with-param name="id">popup_fax</xsl:with-param>
      <xsl:with-param name="size">32</xsl:with-param>
      <xsl:with-param name="maxsize">32</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_TELEX</xsl:with-param>
      <xsl:with-param name="name">telex</xsl:with-param>
      <xsl:with-param name="id">popup_telex</xsl:with-param>
      <xsl:with-param name="size">32</xsl:with-param>
      <xsl:with-param name="maxsize">32</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
	  <xsl:when test="contains($nodeName,'static_bank')">
    	<xsl:call-template name="input-field">
      	 <xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>
      	 <xsl:with-param name="name">iso_code</xsl:with-param>
      	 <xsl:with-param name="id">popup_iso_code</xsl:with-param>
      	 <xsl:with-param name="size">11</xsl:with-param>
       	 <xsl:with-param name="maxsize">11</xsl:with-param>
         <xsl:with-param name="uppercase">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
    	</xsl:call-template>
      </xsl:when>		
	  <xsl:when test="$nodeName ='static_beneficiary'">
		<xsl:call-template name="input-field">
		 <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_BEI</xsl:with-param>
		 <xsl:with-param name="name">bei</xsl:with-param>
		 <xsl:with-param name="id">popup_bei</xsl:with-param>
		 <xsl:with-param name="size">11</xsl:with-param>
		 <xsl:with-param name="maxsize">11</xsl:with-param>
         <xsl:with-param name="uppercase">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
		</xsl:call-template>
	   </xsl:when>
	  </xsl:choose>
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
	   <xsl:with-param name="name">email</xsl:with-param>
	   <xsl:with-param name="required">
          <xsl:choose>
            <xsl:when test="$counterparty_email_required = 'true'">Y</xsl:when>
            <xsl:otherwise>N</xsl:otherwise>
          </xsl:choose>
       </xsl:with-param>
	   <xsl:with-param name="id">popup_email</xsl:with-param>
	   <xsl:with-param name="size">24</xsl:with-param>
 	   <xsl:with-param name="maxsize">255</xsl:with-param>
	  </xsl:call-template>
      <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_JURISDICTION_WEB</xsl:with-param>
	   <xsl:with-param name="name">web_address</xsl:with-param>
	   <xsl:with-param name="id">popup_web_address</xsl:with-param>
	   <xsl:with-param name="size">24</xsl:with-param>
	   <xsl:with-param name="maxsize">40</xsl:with-param>
      </xsl:call-template>	
   	 </xsl:with-param>
   	</xsl:call-template>
  </xsl:template>

 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <xsl:param name="nodeName"/>
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="id">popup_realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$submitscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">responsetype</xsl:with-param>
       <xsl:with-param name="id">popup_responsetype</xsl:with-param>
       <xsl:with-param name="value">AJAX</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">popup_realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="id">popup_option</xsl:with-param>
       <xsl:with-param name="value">
		<xsl:choose>
		 <!-- The option below is used to manage the addition of financial insitution or more generally, a bank with a SWIFT address (post_code, street_name...) -->
		 <xsl:when test="contains($nodeName,'static_bank') and $formname != '' and $option = 'baseline_bank'">BASELINE_BANKS_MAINTENANCE</xsl:when>
		 <xsl:when test="contains($nodeName,'static_bank')">BANKS_MAINTENANCE</xsl:when>
		 <xsl:otherwise>BENEFICIARIES_MAINTENANCE</xsl:otherwise>
		</xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">featureid</xsl:with-param>
       	<xsl:with-param name="id">popup_featureid</xsl:with-param>
       	<xsl:with-param name="value">
		 <xsl:choose>
		  <xsl:when test="contains($nodeName,'static_bank')">
			<xsl:value-of select="bank_id"/>
		  </xsl:when>
		  <xsl:otherwise>
			<xsl:value-of select="beneficiary_id"/>
		  </xsl:otherwise>
		</xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$formname != ''">
	  		<xsl:call-template name="hidden-field">
       			<xsl:with-param name="name">formname</xsl:with-param>
       			<xsl:with-param name="id">popup_formname</xsl:with-param>
       			<xsl:with-param name="value"><xsl:value-of select="$formname"/></xsl:with-param>
      		</xsl:call-template>
	  </xsl:if>	
	  <xsl:if test="$fields != ''">
	  		<xsl:call-template name="hidden-field">
       			<xsl:with-param name="name">fields</xsl:with-param>
       			<xsl:with-param name="id">popup_fields</xsl:with-param>
       			<xsl:with-param name="value"><xsl:value-of select="$fields"/></xsl:with-param>
      		</xsl:call-template>
	  </xsl:if>
	  <xsl:if test="$productCode != ''">
	  		<xsl:call-template name="hidden-field">
       			<xsl:with-param name="name">productcode</xsl:with-param>
       			<xsl:with-param name="id">popup_productcode</xsl:with-param>
       			<xsl:with-param name="value"><xsl:value-of select="$productCode"/></xsl:with-param>
      		</xsl:call-template>
	  </xsl:if>		
      <xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">TransactionData</xsl:with-param>
       		<xsl:with-param name="id">popup_TransactionData</xsl:with-param>
      </xsl:call-template>
      </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  	<!-- =========================================================================== -->
  	<!-- ================= COLLABORATION TEMPLATE : CHECK SECURITY  ================ -->
  	<!-- =========================================================================== -->
  <xsl:template name="collaboration-security-check">
	<xsl:param name="nodeName"/>		
	<div class="widgetContainer clear">
	<xsl:if test="contains($nodeName,'static_beneficiary')">  <!-- Only for beneficiary -->
 	 <xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'collaboration_sy_open_counterparty_access',utils:getUserEntities($rundata))">
	  <xsl:call-template name="checkbox-field">
	   <xsl:with-param name="name">access_opened</xsl:with-param>
	   <xsl:with-param name="id">popup_access_opened</xsl:with-param>
	   <xsl:with-param name="checked">N</xsl:with-param>
	   <xsl:with-param name="label">XSL_JURISDICTION_OPEN_ACCESS_TO_COUNTERPARTY</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
  	   <xsl:with-param name="name">beneficiary_company_abbv_name</xsl:with-param>
  	   <xsl:with-param name="id">popup_beneficiary_company_abbv_name</xsl:with-param>
 	  </xsl:call-template>				
	</xsl:if>
	<xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'collaboration_sy_open_counterparty_notification',utils:getUserEntities($rundata))">
      <xsl:call-template name="checkbox-field">
       <xsl:with-param name="name">notification_enabled</xsl:with-param>
       <xsl:with-param name="id">popup_notification_enabled</xsl:with-param>
       <xsl:with-param name="checked"><xsl:if test="notification_enabled = 'Y'">Y</xsl:if></xsl:with-param>
       <xsl:with-param name="label">XSL_JURISDICTION_OPEN_NOTIFICATION_TO_COUNTERPARTY</xsl:with-param>
       <xsl:with-param name="disabled">Y</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_JURISDICTION_SELECT_COUNTERPARTY_PRODUCTS</xsl:with-param>
       <xsl:with-param name="id">counterparty-products</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'LC')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_LC</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_LC</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/LC">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_LC</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'EL')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_EL</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_EL</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/EL">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_EL</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'BG')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_BG</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_BG</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/BG">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_BG</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'SG')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_SG</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_SG</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/SG">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_SG</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'EC')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_EC</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_EC</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/EC">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_EC</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'IC')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_IC</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_IC</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/IC">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_IC</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'IR')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_IR</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_IR</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/IR">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_IR</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'FT')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_FT</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_FT</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/FT">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_FT</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'TF')">   
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_TF</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_TF</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/TF">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_TF</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'SI')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_SI</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_SI</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/SI">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_SI</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'SR')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_SR</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_SR</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/SR">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_SR</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'PO')">   
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_PO</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_PO</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/PO">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_PO</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="securityCheck:hasCompanyProductPermission($rundata, 'SO')">
         <xsl:call-template name="checkbox-field">
          <xsl:with-param name="name">counterparty_permission_SO</xsl:with-param>
          <xsl:with-param name="id">popup_counterparty_permission_SO</xsl:with-param>
          <xsl:with-param name="checked"><xsl:if test="counterparty_products/SO">Y</xsl:if></xsl:with-param>
          <xsl:with-param name="label">N001_SO</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
       </xsl:with-param>
      </xsl:call-template>    
	 </xsl:if>
	</xsl:if>
	</div>	
   </xsl:template>
  </xsl:stylesheet>