<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Phrase Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      02/05/08
author:    Laure Blin
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization security securitycheck utils defaultresource"> 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
   
  <xsl:param name="language">en</xsl:param>
  <!-- <xsl:param name="languages"/>-->
  <xsl:param name="rundata"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="screen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="phrase"/>
  </xsl:template>
  
  <xsl:template match="phrase">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>

   <div id="popupscreen">
    <!-- Form #0 : Main Form -->
    <xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="id">popup_<xsl:value-of select="$main-form-name"/></xsl:with-param>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields">
        <xsl:with-param name="nodeName"><xsl:value-of select="$nodeName"/></xsl:with-param>
      </xsl:call-template>
      <!-- Call phrase-details for products where dynamic and static both are applicable.
      		Call static-phrase-details for products where only static phrase is applicable. -->
      <xsl:choose>
	      <xsl:when test="security:isCustomer($rundata) and ($productcode='LC' or $productcode='SI')">
	      	<xsl:call-template name="phrase-details"/>
	      </xsl:when>
		  <xsl:otherwise>
		  	<xsl:call-template name="static-phrase-details"/>
		  </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="popup-menu"/> 
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
    <xsl:with-param name="binding">misys.binding.dialog.phrase</xsl:with-param>
    <xsl:with-param name="xml-tag-name">phrase</xsl:with-param>
   </xsl:call-template>
 </xsl:template>
 
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
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">phrase_id</xsl:with-param>
    <xsl:with-param name="id">popup_phrase_id</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
  <!-- Used for products where dynamic and static both are applicable. -->
  <xsl:template name="phrase-details">
 	 <xsl:param name="productCode">
      <xsl:choose>
        <xsl:when test="not (productcode[.=''])"><xsl:value-of select="$productcode"/></xsl:when>
        <xsl:otherwise>*</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
 
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_MAIN_PHRASE_DETAILS</xsl:with-param>
     <xsl:with-param name="content">
 	 <!-- Entity -->
 	 <xsl:choose>
         <xsl:when test="entities">
 	 		<xsl:call-template name="entity-field">
    			<xsl:with-param name="popup-entity-prefix">sy_</xsl:with-param>
	       		<xsl:with-param name="button-type">popup-entity</xsl:with-param>
    			<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
    			<xsl:with-param name="name">entity</xsl:with-param>
    			<xsl:with-param name="readonly">Y</xsl:with-param>
       			<xsl:with-param name="required">Y</xsl:with-param>
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
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_NAME</xsl:with-param>
      <xsl:with-param name="name">abbv_name</xsl:with-param>
      <xsl:with-param name="id">popup_abbv_name</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     <xsl:if test="$displaymode='edit'">
     	  <xsl:call-template name="select-field">
		      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_TYPE</xsl:with-param>
		      <xsl:with-param name="name">phrase_type</xsl:with-param>
		      <xsl:with-param name="id">popup_phrase_type</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="phrase_type[.!='']"><xsl:value-of select="phrase_type"/></xsl:if></xsl:with-param>
		      <xsl:with-param name="options">
		      	<xsl:call-template name="phrase_type_options" />
		      </xsl:with-param>
		   </xsl:call-template>
      </xsl:if>
      <xsl:if test="$displaymode='view'">
      		<xsl:variable name="phrase_type_code"><xsl:value-of select="phrase_type"></xsl:value-of></xsl:variable>
			<xsl:variable name="productCode">*</xsl:variable>
			<xsl:variable name="subProductCode">*</xsl:variable>
			<xsl:variable name="parameterId">C047</xsl:variable>
      		<xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_TYPE</xsl:with-param>
		      <xsl:with-param name="name">phrase_type</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="phrase_type[.!='']"><xsl:value-of select="localization:getCodeData($language,'$subProductCode',$productCode,$parameterId, $phrase_type_code)"/></xsl:if></xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
     
     <xsl:if test="$displaymode='edit'">
     	  <xsl:call-template name="select-field">
		      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_PRODUCT</xsl:with-param>
		      <xsl:with-param name="name">product_code</xsl:with-param>
		      <xsl:with-param name="id">popup_product_code</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="product_code[.!='']"><xsl:value-of select="product_code"/></xsl:if></xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
		   	<xsl:with-param name="name">product_code_hidden</xsl:with-param>
		   	<xsl:with-param name="value"><xsl:if test="product_code[.!='']"><xsl:value-of select="product_code"/></xsl:if></xsl:with-param>
		   </xsl:call-template>
      </xsl:if>
      <xsl:if test="$displaymode='view'">
      	<xsl:variable name="productCode"><xsl:value-of select="product_code" /></xsl:variable>
      	 <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_PRODUCT</xsl:with-param>
		      <xsl:with-param name="name">product_code</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N001', $productCode )"/></xsl:if></xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
     <xsl:if test="$displaymode='edit'">
     	  <xsl:call-template name="select-field">
		      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CATEGORY</xsl:with-param>
		      <xsl:with-param name="name">category</xsl:with-param>
		      <xsl:with-param name="id">popup_category</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="category[.!='']"><xsl:value-of select="category"/></xsl:if></xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
		   	<xsl:with-param name="name">category_code_hidden</xsl:with-param>
		   	<xsl:with-param name="value"><xsl:if test="category[.!='']"><xsl:value-of select="category"/></xsl:if></xsl:with-param>
		   </xsl:call-template>
    </xsl:if>
      <xsl:if test="$displaymode='view'">
      		<xsl:variable name="category_code"><xsl:value-of select="category"></xsl:value-of></xsl:variable>
			<xsl:variable name="productCode"><xsl:value-of select="product_code" /></xsl:variable>
			<xsl:variable name="subProductCode">*</xsl:variable>
			<xsl:variable name="parameterId">C046</xsl:variable>
      	 <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CATEGORY</xsl:with-param>
		      <xsl:with-param name="name">category</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="category[.!='']"><xsl:value-of select="localization:getCodeData($language,'$subProductCode',$productCode,$parameterId, $category_code)"/></xsl:if></xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
    
     
     <!-- Description -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_DESCRIPTION</xsl:with-param>
      <xsl:with-param name="name">description</xsl:with-param>
      <xsl:with-param name="id">popup_description</xsl:with-param>
      <xsl:with-param name="size">50</xsl:with-param>
      <xsl:with-param name="maxsize">100</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
		     <!-- Content -->
		    <div id="static-text-editor">
		      <xsl:call-template name="big-textarea-wrapper">
			   	 <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CONTENT</xsl:with-param>
			   	 <xsl:with-param name="required">Y</xsl:with-param>
			   	 <xsl:with-param name="content">
		    		 <xsl:call-template name="textarea-field">
				       <xsl:with-param name="name">static_text</xsl:with-param>
       				   <xsl:with-param name="id">static_text</xsl:with-param>
				       <xsl:with-param name="rows">12</xsl:with-param>
				       <xsl:with-param name="cols">65</xsl:with-param>
				       <xsl:with-param name="required">Y</xsl:with-param>
				       <xsl:with-param name="maxlines">30</xsl:with-param>
				       <xsl:with-param name="messageValue">
					   	<xsl:if test="phrase_type[.= '01']"><xsl:value-of select="text"/></xsl:if> 
					   </xsl:with-param>
				      <!--  Necessary to avoid having a popup window linked to the textarea -->
				       <xsl:with-param name="button-type"></xsl:with-param>
				      </xsl:call-template>
		     	</xsl:with-param>
		    </xsl:call-template>
		   </div>
		   <div id="rich-text-editor" style="display:none;">
		     <div class="clear"/>
				<xsl:call-template name="richtextarea-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CONTENT</xsl:with-param>
					<xsl:with-param name="name">dynamic_text</xsl:with-param>
					<xsl:with-param name="id">dynamic_text</xsl:with-param>
					<xsl:with-param name="rows">13</xsl:with-param>
					<xsl:with-param name="cols">40</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:if test="phrase_type[.= '02']"><xsl:apply-templates select="text"/></xsl:if> 
					</xsl:with-param>
					<xsl:with-param name="instantiation-event">/rich-text-editor/display</xsl:with-param>
				</xsl:call-template>
			</div>
		 
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 <!-- Use this template for products where dynamic phrases are not applicable.Can be removed once all products have dynamic phrase applicable. -->
 <xsl:template name="static-phrase-details">
 	 <xsl:param name="productCode">
      <xsl:choose>
        <xsl:when test="not (productcode[.=''])"><xsl:value-of select="$productcode"/></xsl:when>
        <xsl:otherwise>*</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
 
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
     <xsl:with-param name="content">
 	 <!-- Entity -->
 	 <xsl:choose>
         <xsl:when test="entities">
 	 		<xsl:call-template name="entity-field">
    			<xsl:with-param name="popup-entity-prefix">sy_</xsl:with-param>
	       		<xsl:with-param name="button-type">popup-entity</xsl:with-param>
    			<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
    			<xsl:with-param name="name">entity</xsl:with-param>
    			<xsl:with-param name="readonly">Y</xsl:with-param>
       			<xsl:with-param name="required">Y</xsl:with-param>
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
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_NAME</xsl:with-param>
      <xsl:with-param name="name">abbv_name</xsl:with-param>
      <xsl:with-param name="id">popup_abbv_name</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     <xsl:if test="$displaymode='edit'">
		<xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">phrase_type</xsl:with-param>
   			<xsl:with-param name="id">popup_phrase_type</xsl:with-param>
   			<xsl:with-param name="value">01</xsl:with-param>
   		</xsl:call-template>
      </xsl:if>   
     
     <xsl:if test="$displaymode='edit'">
	 	<xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">product_code</xsl:with-param>
   			<xsl:with-param name="id">popup_product_code</xsl:with-param>
   			<xsl:with-param name="value"><xsl:if test="$productcode !=''"><xsl:value-of select="$productcode"/></xsl:if></xsl:with-param>
   		</xsl:call-template>
      </xsl:if>

     <xsl:if test="$displaymode='edit'">
		   <xsl:call-template name="hidden-field">
		   	<xsl:with-param name="name">category</xsl:with-param>
		   	<xsl:with-param name="id">popup_category</xsl:with-param>
		   	<xsl:with-param name="value">99</xsl:with-param>
		   </xsl:call-template>
    </xsl:if>
   
     
     <!-- Description -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_DESCRIPTION</xsl:with-param>
      <xsl:with-param name="name">description</xsl:with-param>
      <xsl:with-param name="id">popup_description</xsl:with-param>
      <xsl:with-param name="size">50</xsl:with-param>
      <xsl:with-param name="maxsize">100</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template> 
		     <!-- Content -->
		    <div id="static-text-editor">
		      <xsl:call-template name="big-textarea-wrapper">
			   	 <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CONTENT</xsl:with-param>
			   	 <xsl:with-param name="required">Y</xsl:with-param>
			   	 <xsl:with-param name="content">
		    		 <xsl:call-template name="textarea-field">
				       <xsl:with-param name="name">static_text</xsl:with-param>
       				   <xsl:with-param name="id">static_text</xsl:with-param>
				       <xsl:with-param name="rows">12</xsl:with-param>
				       <xsl:with-param name="cols">65</xsl:with-param>
				       <xsl:with-param name="required">Y</xsl:with-param>
				       <xsl:with-param name="maxlines">30</xsl:with-param>
				       <xsl:with-param name="messageValue">
					   	<xsl:if test="phrase_type[.= '01']"><xsl:value-of select="text"/></xsl:if> 
					   </xsl:with-param>
				      <!--  Necessary to avoid having a popup window linked to the textarea -->
				       <xsl:with-param name="button-type"></xsl:with-param>
				      </xsl:call-template>
		     	</xsl:with-param>
		    </xsl:call-template>
		   </div>	 
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
	<xsl:template match="text">
	  <xsl:copy-of select="child::node()|node()"/>
	</xsl:template>
 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="id">popup_realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">popup_realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="id">popup_option</xsl:with-param>
       <xsl:with-param name="value">PHRASES_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="id">popup_TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	 <xsl:with-param name="id">popup_token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">companyNameRegexValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('COMPANYNAME_VALIDATION_REGEX')"/></xsl:with-param>
	</xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">blacklistspecialcharregexvalue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BLACKLIST_SPECIALCHAR_REGEX')"/></xsl:with-param>
	  </xsl:call-template>	      
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  
  
</xsl:stylesheet>
