<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Bank Beneficiary (On customer side) Screen, System Form.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
All Rights Reserved. 
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization securityCheck defaultresource utils security">
 
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
  <xsl:param name="isE2EEEnabled">false</xsl:param>
  <xsl:param name="counterparty_email_required">
	<xsl:value-of select="defaultresource:getResource('COUNTERPARTY_EMAIL_REQUIRED')"/>
  </xsl:param>
  <xsl:param name="fscmEnableIpAutoAcceptance">
	<xsl:value-of select="defaultresource:getResource('FSCM_ENABLE_IP_AUTOACCEPTANCE')"/>
  </xsl:param>
  <xsl:param name="counterpartyCaseSensitive">true</xsl:param>
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="static_beneficiary | static_bank">
   <!--Define the nodeName variable for the current static data -->
   <xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
  
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="id"><xsl:value-of select="$main-form-name"/></xsl:with-param>
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
      <xsl:if test="$nodeName = 'static_bank' and securityCheck:hasPermission($rundata,'sy_correspondent_bank_ec') = 'true'">
      	<xsl:call-template name="correspondent-bank-details"/>
      </xsl:if>
      <!--  Display common menu. -->
      <xsl:call-template name="system-menu"/>
      
     </xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="realform">
     <xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
    </xsl:call-template>
   </div>
   
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports">
    <xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
 <xsl:param name="nodeName"/>
 <xsl:variable name="help_access_key">
  <xsl:choose>
 		<xsl:when test="security:isBank($rundata)"><xsl:value-of select="'SY_DATA'"></xsl:value-of></xsl:when>
 		<xsl:otherwise><xsl:value-of select="'DATAM_BNKS'"></xsl:value-of></xsl:otherwise>
 	</xsl:choose>
 	</xsl:variable>  
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name"><xsl:value-of select="$nodeName"/></xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.bank_beneficiary</xsl:with-param>
   <xsl:with-param name="override-help-access-key"><xsl:value-of select="$help_access_key"/></xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:param name="nodeName"/>
  <div class="widgetContainer">
  <xsl:call-template name="localization-dialog"/>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">brch_code</xsl:with-param>
	<xsl:with-param name="id">sy_brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">swiftregexValue</xsl:with-param>
   <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">swiftBicCodeRegexValue</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BIC_CHARSET')"/></xsl:with-param>
	</xsl:call-template>
   <xsl:choose>
	<xsl:when test="contains($nodeName,'static_bank')">
	 <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">bank_id</xsl:with-param>
     </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	 <xsl:call-template name="hidden-field">
  	  <xsl:with-param name="name">beneficiary_id</xsl:with-param>
 	 </xsl:call-template>
	</xsl:otherwise>
   </xsl:choose>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">address_address_line_1</xsl:with-param>
	<xsl:with-param name="value"><xsl:value-of select="address_line_1"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">swift_address_address_line_1</xsl:with-param>
	<xsl:with-param name="value"><xsl:value-of select="post_code"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
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
       <xsl:with-param name="button-type">system-entity</xsl:with-param>
       <xsl:with-param name="entity-label">XSL_JURISDICTION_ENTITY</xsl:with-param>
       <!-- TODO This is a temp solution to entity problem -->
       <xsl:with-param name="required">
        <xsl:choose>
        <xsl:when test="count(entities)=0">N</xsl:when>
        <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
 	 </xsl:when>
   	 <xsl:otherwise>
   	  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">entity</xsl:with-param>
       <xsl:with-param name="value">*</xsl:with-param>
      </xsl:call-template>
     </xsl:otherwise>
   	</xsl:choose>
 	
 	<!-- Abbreviated Name -->   
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
     <xsl:with-param name="name">abbv_name</xsl:with-param>
    <!--  <xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,35}</xsl:with-param> -->
    <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BANK_ABBVNAME_VALIDATION_REGEX')"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="readonly"><xsl:if test="abbv_name != ''">Y</xsl:if></xsl:with-param>
     <xsl:with-param name="uppercase">
    	<xsl:choose>
			<xsl:when test="$counterpartyCaseSensitive = 'true'">N</xsl:when>
			<xsl:otherwise>Y</xsl:otherwise>
		</xsl:choose>
	 </xsl:with-param>
     
    </xsl:call-template>
     
 	<!-- Name -->    
	<xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
     <xsl:with-param name="name">name</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
    </xsl:call-template>
    
	<!--FSCM Enabled -->
	<!-- Add this checkbox only for counterparty and not for banks  -->
	<xsl:if test="security:isCustomer($rundata) and $nodeName = 'static_beneficiary' and (securityCheck:hasCompanyPermission($rundata,'in_access') or securityCheck:hasCompanyPermission($rundata,'ip_access') or securityCheck:hasCompanyPermission($rundata,'cn_access') or securityCheck:hasCompanyPermission($rundata,'cn_access'))"> 
		    <xsl:call-template name="multichoice-field">
			 <xsl:with-param name="name">fscm_enabled</xsl:with-param>
			 <xsl:with-param name="checked">N</xsl:with-param>
			 <xsl:with-param name="type">checkbox</xsl:with-param>
			 <xsl:with-param name="disabled">N</xsl:with-param>
			 <xsl:with-param name="label">XSL_FSCM_ENABLED</xsl:with-param>
			</xsl:call-template>
	</xsl:if>
	
    
    <!-- Collaboration template to deal with security verifications -->
     <xsl:call-template name="collaboration-security-check">
     	 <xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
     </xsl:call-template>
      <xsl:if test="$nodeName = 'static_beneficiary'">
	 	<!-- Inclusion of Credit Note Product Sub Header-->
	 	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">MENU_DETAILS</xsl:with-param><!--TODO: Have to create localized header -->
	    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	    <xsl:with-param name="content">
			<!-- TMA Proprietary Id Field only for IO products -->
			<!-- TMA Proprietary Id field appears Only for beneficiary and Non-invoice Financing programme,
				 and with counterparty collaboration disabled and Non-credit note products -->
			<xsl:if test="contains($nodeName,'static_beneficiary') and $companyType and $companyType='03'"> 
				<xsl:if test="securityCheck:hasCompanyPermission($rundata,'io_access') or securityCheck:hasCompanyPermission($rundata,'ea_access')">
					<xsl:call-template name="multichoice-field">
						<xsl:with-param name="name">prtry_id_type_flag</xsl:with-param>
						<xsl:with-param name="checked">N</xsl:with-param>
						<xsl:with-param name="type">checkbox</xsl:with-param>
						<xsl:with-param name="disabled">N</xsl:with-param>
						<xsl:with-param name="label">XSL_TMA_PROPRIETARY_ID</xsl:with-param>
					</xsl:call-template>
					<div id="prtry_id_type_div" >
				   	 <xsl:call-template name="input-field">
				      <xsl:with-param name="label">XSL_PROPRIETARY_ID_AND_TYPE_LABEL</xsl:with-param>
				      <xsl:with-param name="name">prtry_id_type</xsl:with-param>
				      <xsl:with-param name="maxsize">71</xsl:with-param>
				      <xsl:with-param name="required">Y</xsl:with-param>
				     </xsl:call-template>
					</div>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">prtry_id_type_separator</xsl:with-param>
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
      <xsl:with-param name="size">30</xsl:with-param>
      <xsl:with-param name="maxsize">30</xsl:with-param>
     </xsl:call-template>	
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_PHONE</xsl:with-param>
      <xsl:with-param name="name">phone</xsl:with-param>
      <xsl:with-param name="size">32</xsl:with-param>
      <xsl:with-param name="maxsize">32</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_FAX</xsl:with-param>
      <xsl:with-param name="name">fax</xsl:with-param>
      <xsl:with-param name="size">32</xsl:with-param>
      <xsl:with-param name="maxsize">32</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_TELEX</xsl:with-param>
      <xsl:with-param name="name">telex</xsl:with-param>
      <xsl:with-param name="size">32</xsl:with-param>
      <xsl:with-param name="maxsize">32</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
	  <xsl:when test="contains($nodeName,'static_bank')">
    	<xsl:call-template name="input-field">
      	 <xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>
      	 <xsl:with-param name="name">iso_code</xsl:with-param>
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
		 <xsl:with-param name="size">11</xsl:with-param>
		 <xsl:with-param name="maxsize">11</xsl:with-param>
         <xsl:with-param name="uppercase">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
		</xsl:call-template>
	   </xsl:when>
	  </xsl:choose>
	 
	  <xsl:if test="$displaymode='edit'">
		<xsl:call-template name="input-field">
		 <xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
		 <xsl:with-param name="name">email</xsl:with-param>
		 <xsl:with-param name="size">24</xsl:with-param>
		 <xsl:with-param name="maxsize">255</xsl:with-param>
		 <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('COUNTERPARTY_EMAILID_VALIDATION_REGEX')"/></xsl:with-param>
		 <xsl:with-param name="required">
			<xsl:choose>
				<xsl:when test="$counterparty_email_required = 'true'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		 </xsl:with-param>
	    </xsl:call-template>
      </xsl:if>

	<xsl:if test="$displaymode='view' and email[.!='']">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
				<div class="label">
					<span class="field">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_EMAIL')" />
					</span>
				</div>
					<span style="word-break:break-all;padding-right:30px;display:inline-block;max-width:925px;text-align:left;position:absolute">
						<xsl:value-of select="email" />
					</span>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	 
      <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_JURISDICTION_WEB</xsl:with-param>
	   <xsl:with-param name="name">web_address</xsl:with-param>
	   <xsl:with-param name="size">24</xsl:with-param>
	   <xsl:with-param name="maxsize">40</xsl:with-param>
      </xsl:call-template>	
   	 </xsl:with-param>
   	</xsl:call-template>
  </xsl:template>
  
  <xsl:template name="correspondent-bank-details">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CORRESPONDENT_BANK</xsl:with-param>
	<xsl:with-param name="content">
    <div class="widgetContainer">
    <div class="correspondentBankTableMergedCellContainer">
		<xsl:attribute name="id">corr_bank_currency_div</xsl:attribute>
		<xsl:attribute name="style">width:98%;</xsl:attribute>
		<xsl:variable name="displayModeClass">corr_bank_currency_<xsl:value-of select="$displaymode"/></xsl:variable>
		<div>
			<xsl:attribute name="class"><xsl:value-of select="$displayModeClass"/></xsl:attribute>
			<div class="correspondentBankMergedCell">
			<xsl:choose>
		     <xsl:when test="$displaymode = 'edit'">
			     <div class="inlineBlock correspondentBankMultiSelect">
			     <xsl:call-template name="select-field">
			      <xsl:with-param name="label"></xsl:with-param>
			  	  <xsl:with-param name="id">corr_bank_currency_avail_nosend</xsl:with-param>
			   	  <xsl:with-param name="type">multiple</xsl:with-param>
			      <xsl:with-param name="size">10</xsl:with-param>
			      <xsl:with-param name="options">
				      <xsl:apply-templates select="avail_cur_details/avail_currency_details"/>
			  	  </xsl:with-param>
			  	 </xsl:call-template>
			  	 </div>
			      <div id="add-remove-buttons" class="multiselect-buttons inlineBlock" style="text-align:center;">
			       <div>
				       <div>
					       <button dojoType="dijit.form.Button" type="button"><xsl:attribute name="id">addCurButton</xsl:attribute>
						       <xsl:attribute name="onClick">misys.addCurrencyMultiSelectItems(true);</xsl:attribute>
						     
						       <xsl:if test="$language = 'ar'">
						       		<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&#8592;&nbsp;
						       </xsl:if>
						       <xsl:if test="$language != 'ar'">
						       		<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&nbsp;&#8594;
						       </xsl:if>
						       
						   </button>
					   </div>
					   <div>
					       <button dojoType="dijit.form.Button" type="button"><xsl:attribute name="id">removeCurButton</xsl:attribute>
						       <xsl:attribute name="onClick">misys.addCurrencyMultiSelectItems(false);</xsl:attribute>
						       
						        <xsl:if test="$language = 'ar'">
						       		&nbsp;&#8594;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
						       </xsl:if>
						       <xsl:if test="$language != 'ar'">
						       		&#8592;&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
						       </xsl:if>														       														       
						   </button>
					   </div>
				   </div>
				   <div>
				   </div>
			      </div>
		      <div class="inlineBlock correspondentBankMultiSelect">
			      <xsl:call-template name="select-field">
			       <xsl:with-param name="label"></xsl:with-param>
				   <xsl:with-param name="name">corr_bank_currency_exist_nosend</xsl:with-param>
				   <xsl:with-param name="type">multiple</xsl:with-param>
			       <xsl:with-param name="size">10</xsl:with-param>
				   <xsl:with-param name="options">
				    <xsl:choose>
				     <xsl:when test="$displaymode='edit'">
				      <xsl:apply-templates select="existing_cur_details/existing_currency_details"/>
				     </xsl:when>
				     <xsl:otherwise>
				      <ul class="multi-select">
			           <xsl:apply-templates select="existing_cur_details/existing_currency_details"/>
			          </ul>
				     </xsl:otherwise>
				    </xsl:choose>
				   </xsl:with-param>
			      </xsl:call-template>
		      </div>
		      </xsl:when>
		      <xsl:otherwise>
		      	<xsl:call-template name="select-field">
			       <xsl:with-param name="label"></xsl:with-param>
				   <xsl:with-param name="name">corr_bank_currency_exist_nosend</xsl:with-param>
				   <xsl:with-param name="type">multiple</xsl:with-param>
			       <xsl:with-param name="size">10</xsl:with-param>
				   <xsl:with-param name="options">
				      <ul class="multi-select">
			           <xsl:apply-templates select="existing_cur_details/existing_currency_details"/>
			          </ul>
				   </xsl:with-param>
			      </xsl:call-template>
		      </xsl:otherwise>
		      </xsl:choose>
		    </div>
	    </div>
	</div>
	</div>
	</xsl:with-param>
	</xsl:call-template>
  </xsl:template>
  
  <xsl:template match="avail_cur_details/avail_currency_details">
	<xsl:choose>
	   <xsl:when test="$displaymode='edit'">
	    <option>
	    <xsl:attribute name="value"><xsl:value-of select="currency_code"/></xsl:attribute>
	     <xsl:value-of select="currency_description"/>
	    </option>
	   </xsl:when>
	   <xsl:otherwise>
	   	<xsl:attribute name="value"><xsl:value-of select="currency_code"/></xsl:attribute>
	    <li><xsl:value-of select="currency_description"/></li>
	   </xsl:otherwise>
	</xsl:choose>
 </xsl:template>
 <xsl:template match="existing_cur_details/existing_currency_details">
	<xsl:choose>
	   <xsl:when test="$displaymode='edit'">
	    <option>
	    <xsl:attribute name="value"><xsl:value-of select="currency_code"/></xsl:attribute>
	     <xsl:value-of select="currency_description"/>
	    </option>
	   </xsl:when>
	   <xsl:otherwise>
	   	<xsl:attribute name="value"><xsl:value-of select="currency_code"/></xsl:attribute>
	    <li><xsl:value-of select="currency_description"/></li>
	   </xsl:otherwise>
	</xsl:choose>
 </xsl:template>

 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <xsl:param name="nodeName"/>
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
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
       	<xsl:with-param name="value">
		 <xsl:choose>
		  <xsl:when test="contains($nodeName,'static_bank')">
		  	<xsl:choose>
		  		<xsl:when test="security:isBank($rundata) or security:isGroup($rundata)"><xsl:value-of select="abbv_name"/></xsl:when>
		  		<xsl:otherwise><xsl:value-of select="bank_id"/></xsl:otherwise>
		  	</xsl:choose>
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
       			<xsl:with-param name="value"><xsl:value-of select="$formname"/></xsl:with-param>
      		</xsl:call-template>
	  </xsl:if>	
	  <xsl:if test="$fields != ''">
	  		<xsl:call-template name="hidden-field">
       			<xsl:with-param name="name">fields</xsl:with-param>
       			<xsl:with-param name="value"><xsl:value-of select="$fields"/></xsl:with-param>
      		</xsl:call-template>
	  </xsl:if>
	  <xsl:if test="$productCode != ''">
	  		<xsl:call-template name="hidden-field">
       			<xsl:with-param name="name">productcode</xsl:with-param>
       			<xsl:with-param name="value"><xsl:value-of select="$productCode"/></xsl:with-param>
      		</xsl:call-template>
	  </xsl:if>		
      <xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
      
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  	<!-- =========================================================================== -->
  	<!-- ================= COLLABORATION TEMPLATE : CHECK SECURITY  ================ -->
  	<!-- =========================================================================== -->
  <xsl:template name="collaboration-security-check">
	<xsl:param name="nodeName"/>
	<div class="widgetContainer clear">		
	<!-- Replace this list of hardcoded programmes by a callback to fscm.programmes and a apply-templates -->
	<!-- Replace permission by a callback to have fscm.counterparty.01.role -->
	<xsl:if test="contains($nodeName,'static_beneficiary')">  <!-- Only for beneficiary -->
	<xsl:call-template name="hidden-field">
  	   <xsl:with-param name="name">beneficiary_company_abbv_name</xsl:with-param>
 	  </xsl:call-template>
	<div id="open_account_fields_div">
	
	<!--Credit Note Enabled -->
	 <xsl:if test="security:isCustomer($rundata) and securityCheck:hasPermission($rundata,'cn_access') = 'true' or securityCheck:hasPermission($rundata,'cr_access') = 'true'">
	    <xsl:call-template name="multichoice-field">
		 <xsl:with-param name="name">credit_note_enabled</xsl:with-param>
		 <xsl:with-param name="checked">N</xsl:with-param>
		 <xsl:with-param name="type">checkbox</xsl:with-param>
		 <xsl:with-param name="disabled">N</xsl:with-param>
		 <xsl:with-param name="label">XSL_CN_ENABLED</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<!--Buyer Role -->
	<xsl:if test="security:isCustomer($rundata)">
	    <xsl:call-template name="multichoice-field">
		 <xsl:with-param name="name">buyer_role</xsl:with-param>
		 <xsl:with-param name="checked">N</xsl:with-param>
		 <xsl:with-param name="type">checkbox</xsl:with-param>
		 <xsl:with-param name="disabled">N</xsl:with-param>
		 <xsl:with-param name="label">XSL_BUYER_ROLE</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	
	<!--Seller Role -->
	<xsl:if test="security:isCustomer($rundata)">
		<xsl:call-template name="multichoice-field">
		 <xsl:with-param name="name">seller_role</xsl:with-param>
		 <xsl:with-param name="checked">N</xsl:with-param>
		 <xsl:with-param name="type">checkbox</xsl:with-param>
		 <xsl:with-param name="disabled">N</xsl:with-param>
		 <xsl:with-param name="label">XSL_SELLER_ROLE</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	
	
	<xsl:if test="securityCheck:hasCompanyPermission($rundata,'collaboration_sy_open_counterparty_access')">
	  <xsl:call-template name="multichoice-field">
	   <xsl:with-param name="name">access_opened</xsl:with-param>
	   <xsl:with-param name="checked">N</xsl:with-param>
	   <xsl:with-param name="type">checkbox</xsl:with-param>
	   <xsl:with-param name="disabled">N</xsl:with-param>
	   <xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_COLLABORATION</xsl:with-param>
	  </xsl:call-template>
	</xsl:if>
	
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_ERP_ID</xsl:with-param>
		<xsl:with-param name="name">erp_id</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./erp_id"/></xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_LEGAL_ID_NO</xsl:with-param>
		<xsl:with-param name="name">legal_id_no</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./legal_id_no"/></xsl:with-param>
		<xsl:with-param name="size">30</xsl:with-param>
		<xsl:with-param name="maxsize">30</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_ACCOUNT</xsl:with-param>
		<xsl:with-param name="name">account</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./account"/></xsl:with-param>
		<xsl:with-param name="size">34</xsl:with-param>
		<xsl:with-param name="maxsize">34</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
		<xsl:with-param name="name">bank_iso_code</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./bank_iso_code"/></xsl:with-param>
		<xsl:with-param name="size">11</xsl:with-param>
		<xsl:with-param name="maxsize">11</xsl:with-param>
		<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
		<xsl:with-param name="fieldsize">small</xsl:with-param>
		<xsl:with-param name="swift-validate">N</xsl:with-param>
	</xsl:call-template>
  	<xsl:if  test= "$displaymode = 'edit'">
  	  <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['bank_name', 'bank_address_line_1', 'bank_address_line_2', 'bank_dom', 'bank_iso_code', 'bank_contact_name', 'bank_phone']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', 'bank title');return false;</xsl:with-param>
		  <xsl:with-param name="id">bank_iso_img</xsl:with-param>
	      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
	      <xsl:with-param name="swift-validate">N</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
    
    <xsl:call-template name="select-field">
		  <xsl:with-param name="label">XSL_BENEFICIARY_LOCAL_CLEARANCE_TYPE</xsl:with-param>
		  <xsl:with-param name="name">account_type</xsl:with-param>
		  <xsl:with-param name="options">
		  <xsl:choose>
        	<xsl:when test="$displaymode='edit'">
				<option value=""></option>
				<option value="IBAN">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" />
				</option>
				<option value="BBAN">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" />
				</option>
				<option value="UPIC">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" />
				</option>
				<option value="OTHER">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" />
				</option>
			 </xsl:when>
	       </xsl:choose>
    	   </xsl:with-param>
    </xsl:call-template>
    <!-- BANK NAME -->
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME</xsl:with-param>
		<xsl:with-param name="name">bank_name</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./bank_name"/></xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="swift-validate">N</xsl:with-param>
	</xsl:call-template>
	<!-- BANK ADDRESS -->
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_BENEFICIARY_BANK_STREET</xsl:with-param>
		<xsl:with-param name="name">bank_address_line_1</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./bank_address_line_1"/></xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="swift-validate">N</xsl:with-param>
		</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_BENEFICIARY_BANK_TOWN</xsl:with-param>
		<xsl:with-param name="name">bank_address_line_2</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./bank_address_line_2"/></xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="swift-validate">N</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_BENEFICIARY_BANK_COUNTRY_SUB_DIV</xsl:with-param>
		<xsl:with-param name="name">bank_dom</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="./bank_dom"/></xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="swift-validate">N</xsl:with-param>
	</xsl:call-template>
	 <xsl:if test="$fscmEnableIpAutoAcceptance = 'true'">
	      <xsl:call-template name="input-field">
		    	<xsl:with-param name="label">XSL_INVOICE_AUTOACCEPTANCE_DAYS</xsl:with-param>
		      	<xsl:with-param name="name">autoacceptance_day</xsl:with-param>
		      	<xsl:with-param name="size">3</xsl:with-param>
		       	<xsl:with-param name="maxsize">3</xsl:with-param>
		       	<xsl:with-param name="type">number</xsl:with-param>
		       	<xsl:with-param name="fieldsize">x-small</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<div id="reset_password_div">
		<xsl:if test="has_counterparty_company[.='Y'] and $isE2EEEnabled ='true'">
			<xsl:call-template name="multichoice-field">
			   <xsl:with-param name="name">reset_password</xsl:with-param>
			   <xsl:with-param name="checked">N</xsl:with-param>
			   <xsl:with-param name="type">checkbox</xsl:with-param>
			   <xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_RESET_PASSWORD</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_JURISDICTION_PASSWORD</xsl:with-param>
		         <xsl:with-param name="name">password_value</xsl:with-param>
		         <xsl:with-param name="id">password_value</xsl:with-param>
		         <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
		         <xsl:with-param name="type">password</xsl:with-param>
		         <xsl:with-param name="fieldsize">small</xsl:with-param>
		         <xsl:with-param name="required">Y</xsl:with-param>
		    </xsl:call-template>
	        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_JURISDICTION_CONFIRM_PASSWORD</xsl:with-param>
		         <xsl:with-param name="id">password_confirm</xsl:with-param>
		         <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
		         <xsl:with-param name="type">password</xsl:with-param>
		         <xsl:with-param name="fieldsize">small</xsl:with-param>
		         <xsl:with-param name="required">Y</xsl:with-param> 
	        </xsl:call-template>
		 </xsl:if>
	</div>
	
	</div>
	</xsl:if>	
	</div>	
   </xsl:template>
  </xsl:stylesheet>