<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################

 Phrase Screen, System Form.

Copyright (c) 2000-20011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      26/04/11
author:    Pascal Marzin
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
<!--  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/CustomerSystemFeaturesScreen</xsl:param>-->
  <xsl:param name="productcode"/>
  
  <!-- 
  <xsl:param name="fields"/>
  <xsl:param name="formname"/>
  -->  	
   
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
	<xsl:apply-templates select="account_balance"/>
  </xsl:template>
  
  <xsl:template match="account_balance">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="account-details"/>
      
      <!--  Display common menu. -->
      <xsl:call-template name="system-menu"/>
      
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="realform"/>
   </div>
   
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
	<xsl:call-template name="system-common-js-imports">
		<xsl:with-param name="binding">misys.binding.system.account_management</xsl:with-param>
		<xsl:with-param name="xml-tag-name">account_management</xsl:with-param>
	</xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">owner_type</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">format</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">type</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_name</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bank_abbv_name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">account_id</xsl:with-param>
   </xsl:call-template>
<!--   <xsl:call-template name="hidden-field">-->
<!--    <xsl:with-param name="name">country</xsl:with-param>-->
<!--   </xsl:call-template>-->
<!--   <xsl:call-template name="hidden-field">-->
<!--    <xsl:with-param name="name">bank_name</xsl:with-param>-->
<!--   </xsl:call-template>-->
<!--   <xsl:call-template name="hidden-field">-->
<!--    <xsl:with-param name="name">iso_code</xsl:with-param>-->
<!--   </xsl:call-template>-->
  </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="account-details">
     
    <xsl:call-template name="fieldset-wrapper">
    	<xsl:with-param name="legend">XSL_SYSTEMFEATURES_ACCOUNT_DETAILS</xsl:with-param>
    	<xsl:with-param name="content">
    		<!-- Entity -->
			<xsl:call-template name="entity-field">
				<xsl:with-param name="button-type">system-entity</xsl:with-param>
				<xsl:with-param name="required">
					<xsl:choose>
						<xsl:when test="count(entities)=0">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
 	 
			<!-- Account Type -->
			<xsl:if test="owner_type[.='02'] or owner_type[.='04']">
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_FORMAT</xsl:with-param>
					<xsl:with-param name="name">format_acct</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="options">
						<xsl:call-template name="accountType-options"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- Active Flag -->
			<xsl:call-template name="checkbox-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACTIVE_FLAG_LABEL</xsl:with-param>
				<xsl:with-param name="name">actv_flag</xsl:with-param>
				<xsl:with-param name="id">actv_flag</xsl:with-param>
				<xsl:with-param name="value">01</xsl:with-param>
				<xsl:with-param name="checked"><xsl:if test="actv_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
			</xsl:call-template>
			<!-- Account Number -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_NO</xsl:with-param>
				<xsl:with-param name="name">account_no</xsl:with-param>
				<xsl:with-param name="size">34</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			<!-- Account Name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_NAME</xsl:with-param>
				<xsl:with-param name="name">account_name</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="name"/></xsl:with-param>
				<xsl:with-param name="size">34</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			<!-- Description -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_DESCRIPTION</xsl:with-param>
				<xsl:with-param name="name">description</xsl:with-param>
				<xsl:with-param name="size">34</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
			</xsl:call-template>
			<!-- Account currency -->
     		<xsl:call-template name="currency-field">
			    <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
			    <xsl:with-param name="product-code">currency</xsl:with-param>
			    <xsl:with-param name="override-currency-value"><xsl:value-of select="cur_code"/></xsl:with-param>
			    <xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
			    <xsl:with-param name="required">Y</xsl:with-param>
		   	</xsl:call-template>
    		<!-- Email -->
    		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_SYSTEMFEATURES_EMAIL</xsl:with-param>
      			<xsl:with-param name="name">email</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="./email"/></xsl:with-param>
      			<xsl:with-param name="size">40</xsl:with-param>
       			<xsl:with-param name="maxsize">255</xsl:with-param>
    		</xsl:call-template>
    		<!-- Max Transfer Limit -->
    		<xsl:if test="owner_type[.='02'] or owner_type[.='04']">
	     		<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_SYSTEMFEATURES_MAX_TRANSFER</xsl:with-param>
				    <xsl:with-param name="product-code">max_transfert</xsl:with-param>
				     <xsl:with-param name="override-amt-value"><xsl:value-of select="max_transfer_limit"/></xsl:with-param>
				    <xsl:with-param name="override-currency-displaymode">N</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
			   	</xsl:call-template>
		   	</xsl:if>
     	</xsl:with-param>
     </xsl:call-template>
     
     <xsl:if test="owner_type[.='02'] or owner_type[.='04']">
	     <xsl:call-template name="fieldset-wrapper">
	    	<xsl:with-param name="legend">XSL_SYSTEMFEATURES_OPTIONAL_BANK_DETAILS</xsl:with-param>
	    	<xsl:with-param name="content">
	    		<!-- Bank country code -->    	
	 	 		<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_COUNTRY</xsl:with-param>
					<xsl:with-param name="name">bank_country</xsl:with-param>
					<xsl:with-param name="prefix">bank</xsl:with-param>
					<xsl:with-param name="button-type">codevalue</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
					<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				    <xsl:with-param name="size">2</xsl:with-param>
				    <xsl:with-param name="maxsize">2</xsl:with-param>
				    <xsl:with-param name="value"><xsl:value-of select="country"/></xsl:with-param>
				</xsl:call-template>
				<!-- Bank Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_NAME</xsl:with-param>
					<xsl:with-param name="name">bank_name</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<!-- Routing Bic -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_ROUTING_BIC</xsl:with-param>
					<xsl:with-param name="name">iso_code</xsl:with-param>
					<xsl:with-param name="size">11</xsl:with-param>
					<xsl:with-param name="maxsize">11</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<!-- Bank Address -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_ADDRESS</xsl:with-param>
					<xsl:with-param name="name">bank_address_line_1</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">bank_address_line_2</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">bank_dom</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
	     	</xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     <xsl:if test="owner_type[.='03'] or owner_type[.='05']">
	     <xsl:call-template name="fieldset-wrapper">
	    	<xsl:with-param name="legend">XSL_SYSTEMFEATURES_BENEFICIARY_BANK_DETAILS</xsl:with-param>
	    	<xsl:with-param name="content">
	    		<!-- Bank country code -->    	
	 	 		<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_COUNTRY</xsl:with-param>
					<xsl:with-param name="name">bank_country</xsl:with-param>
					<xsl:with-param name="prefix">bank</xsl:with-param>
					<xsl:with-param name="button-type">codevalue</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
					<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				    <xsl:with-param name="size">2</xsl:with-param>
				    <xsl:with-param name="maxsize">2</xsl:with-param>
				    <xsl:with-param name="value"><xsl:value-of select="country"/></xsl:with-param>
				</xsl:call-template>
				<!-- Bank Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_NAME</xsl:with-param>
					<xsl:with-param name="name">bank_name</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				<!-- Beneficiary Bic -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BENEFICIARY_ROUTING_BIC</xsl:with-param>
					<xsl:with-param name="name">iso_code</xsl:with-param>
					<xsl:with-param name="size">11</xsl:with-param>
					<xsl:with-param name="maxsize">11</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				<!-- Sort Code -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BENEFICIARY_SORT_CODE</xsl:with-param>
					<xsl:with-param name="name">branch_no</xsl:with-param>
				    <xsl:with-param name="size">11</xsl:with-param>
				    <xsl:with-param name="maxsize">11</xsl:with-param>
				    <xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<!-- Chips Uid -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_CHIPS_UID</xsl:with-param>
					<xsl:with-param name="name">bank_chips_uid</xsl:with-param>
				    <xsl:with-param name="size">6</xsl:with-param>
				    <xsl:with-param name="maxsize">6</xsl:with-param>
				    <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				</xsl:call-template>
				<!-- Bank Address -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_ADDRESS</xsl:with-param>
					<xsl:with-param name="name">bank_address_line_1</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">bank_address_line_2</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">bank_dom</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
	     	</xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     <xsl:if test="owner_type[.='03']">
	     <xsl:call-template name="fieldset-wrapper">
	    	<xsl:with-param name="legend">XSL_SYSTEMFEATURES_INTERMEDIARY_BANK_DETAILS</xsl:with-param>
	    	<xsl:with-param name="content">
	    		<!-- Intermediary Bank country code -->
	 	 		<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_COUNTRY</xsl:with-param>
					<xsl:with-param name="name">intermediary_bank_country</xsl:with-param>
					<xsl:with-param name="prefix">intermediary_bank</xsl:with-param>
					<xsl:with-param name="button-type">codevalue</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
					<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				    <xsl:with-param name="size">2</xsl:with-param>
				    <xsl:with-param name="maxsize">2</xsl:with-param>
				    <xsl:with-param name="value"><xsl:value-of select="intermediary_country"/></xsl:with-param>
				</xsl:call-template>
				<!-- Intermediary Bank Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_NAME</xsl:with-param>
					<xsl:with-param name="name">intermediary_bank_name</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<!-- Intermediary Bic -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BENEFICIARY_ROUTING_BIC</xsl:with-param>
					<xsl:with-param name="name">routing_bic</xsl:with-param>
					<xsl:with-param name="size">11</xsl:with-param>
					<xsl:with-param name="maxsize">11</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<!-- Intermediary Sort Code -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BENEFICIARY_SORT_CODE</xsl:with-param>
					<xsl:with-param name="name">intermediary_branch_no</xsl:with-param>
				    <xsl:with-param name="size">11</xsl:with-param>
				    <xsl:with-param name="maxsize">11</xsl:with-param>
				    <xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<!-- Intermediary Chips Uid -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_CHIPS_UID</xsl:with-param>
					<xsl:with-param name="name">intermediary_chips_uid</xsl:with-param>
				    <xsl:with-param name="size">6</xsl:with-param>
				    <xsl:with-param name="maxsize">6</xsl:with-param>
				    <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				</xsl:call-template>
				<!-- Intermediary Bank Address -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_BANK_ADDRESS</xsl:with-param>
					<xsl:with-param name="name">intermed_bank_address_line_1</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">intermed_bank_address_line_2</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">intermediary_bank_dom</xsl:with-param>
					<xsl:with-param name="size">34</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
	     	</xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
 </xsl:template>

 <!-- 
  Realform
  -->
 <xsl:template name="realform">
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
       <xsl:with-param name="value">SAVE_ACCOUNT</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">
       	<xsl:choose>
       		<xsl:when test="owner_type[.='03']">SWIFT_ACCOUNT_MAINTENANCE</xsl:when>
       		<xsl:when test="owner_type[.='04']">BILL_PAYEE_MAINTENANCE</xsl:when>
       		<xsl:when test="owner_type[.='05']">OTHER_ACCOUNT_MAINTENANCE</xsl:when>
       		<xsl:otherwise>BENEFICIARY_ACCOUNT_MAINTENANCE</xsl:otherwise>
       	</xsl:choose>
      </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">companyid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="company_id"/></xsl:with-param>
      </xsl:call-template>
      <!-- 
      <xsl:if test="$formname != ''">
		<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">formname</xsl:with-param>
       		<xsl:with-param name="value"/>
      	</xsl:call-template>	
	  </xsl:if>	
	  <xsl:if test="$fields != ''">
	  	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">fields</xsl:with-param>
       		<xsl:with-param name="value"/>
      	</xsl:call-template>	
	  </xsl:if>			
	  <xsl:if test="$productcode != '' ">
		  <xsl:call-template name="hidden-field">
	   		<xsl:with-param name="name">productcode</xsl:with-param>
       		<xsl:with-param name="value"/>
      	  </xsl:call-template>	
	  </xsl:if>
	  -->
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <!--
    Account Type options.
   -->
  <xsl:template name="accountType-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_INTRA')"/>
     </option>
     <option value="02">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_EXTER')"/>
     </option>
     <option value="03">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_CARD')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="format[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_BBAN')"/></xsl:if>
     <xsl:if test="format[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_IBAN')"/></xsl:if>
     <xsl:if test="format[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_UPIC')"/></xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
</xsl:stylesheet>