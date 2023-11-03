<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
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
  <!-- Columns definition import -->
	<xsl:import href="../report/report.xsl"/>
	<xsl:param name="rundata"/>	
  <xsl:param name="language">en</xsl:param>
  <!-- <xsl:param name="languages"/>-->
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
  <!-- 
  <xsl:param name="fields"/>
  <xsl:param name="formname"/>
  -->  	

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="phrase"/>
  </xsl:template>
  
  <xsl:template match="phrase">
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
      <!-- Call phrase-details for customer side where dynamic and static both are applicable.
      		Call static-phrase-details for bank side where only static phrase is applicable. -->
      <xsl:choose>
	      <xsl:when test="security:isCustomer($rundata)">
	      	<xsl:call-template name="phrase-details"/>
	      </xsl:when>
		  <xsl:otherwise>
		  	<xsl:call-template name="static-phrase-details"/>
		  </xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="system-menu"/>
      
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="realform"/>
   </div>
    <script>
	dojo.ready(function(){
	  		misys._config = misys._config || {};
	  		
	  		dojo.mixin(misys._config, {
	  			
	   		phraseTypesProductMap : {
	    			<xsl:if test="count(/phrase/avail_products/products) > 0" >
		        		<xsl:for-each select="/phrase/avail_products/products/type" >
		        			<xsl:variable name="phrase-type" select="."/>
		        			'<xsl:value-of select="$phrase-type"/>': [
		        			<xsl:for-each select="/phrase/avail_products/products[type=$phrase-type]/product_code" >
			        			<xsl:variable name="productCode">
									<xsl:value-of select="."/>
   							  	</xsl:variable>
	   							{ value:"<xsl:value-of select="."/>",
			         				name:
   							  		<xsl:choose>
	   									<xsl:when test="defaultresource:isSwift2019Enabled() and $productCode = 'BG'">
	   										"<xsl:value-of select="localization:getDecode($language, 'N001', 'IU' )"/>"
	   									</xsl:when>
	   									<xsl:when test="defaultresource:isSwift2019Enabled() and $productCode = 'BR'">
	   										"<xsl:value-of select="localization:getDecode($language, 'N001', 'RU' )"/>"
	   									</xsl:when>
	   									<xsl:otherwise>
	   										"<xsl:value-of select="localization:getDecode($language, 'N001', . )"/>"
	   									</xsl:otherwise>
	   								</xsl:choose>
			         			},
	   						</xsl:for-each>]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				},
	   		
  			productCategoryMap : {
	    			<xsl:if test="count(/phrase/phrase_categories/product_category_map/product) > 0" >
		        		<xsl:for-each select="/phrase/phrase_categories/product_category_map/product/product_code" >
		        			<xsl:variable name="productCode" select="." />
	   						'<xsl:value-of select="."/>': [
		   						<xsl:for-each select="/phrase/phrase_categories/product_category_map/product[product_code=$productCode]/category" >
		   							<xsl:variable name="categoryDescription" select="category_desc" />
		   							<xsl:variable name="categoryCode" select="category_code" />
		   							{ value:"<xsl:value-of select="$categoryCode"/>",
				         				name:"<xsl:value-of select="$categoryDescription"/>"},
		   						</xsl:for-each>
	   							]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				}
			});
   		});
		
  	</script>
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
   <script>
			// Instantiate columns arrays
			<xsl:call-template name="product-arraylist-initialisation"/>
			
			// Add columns definitions
			<xsl:call-template name="Columns_Definitions"/>
			
			<!-- Include some eventual additional columns -->
			<xsl:call-template name="report_addons"/>
		</script>

		<!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
		<xsl:call-template name="Products_Columns_Candidates"/>
  </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:variable name="help_access_key">
  <xsl:choose>
 		<xsl:when test="security:isBank($rundata)"><xsl:value-of select="'SY_DATA'"></xsl:value-of></xsl:when>
 		<xsl:otherwise><xsl:value-of select="'DATAM_PHRS'"></xsl:value-of></xsl:otherwise>
 	</xsl:choose>
 	</xsl:variable> 
  <xsl:call-template name="system-common-js-imports">
    <xsl:with-param name="binding">misys.binding.system.phrase</xsl:with-param>
    <xsl:with-param name="xml-tag-name">phrase</xsl:with-param>
    <xsl:with-param name="override-help-access-key"><xsl:value-of select="$help_access_key"/></xsl:with-param>
    <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
   </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="localization-dialog"/>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">phrase_id</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
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
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="phrase-details">
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
 	 		<xsl:call-template name="input-field">
    			<xsl:with-param name="button-type">system-entity</xsl:with-param>
    			<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
    			<xsl:with-param name="name">entity</xsl:with-param>
    			<xsl:with-param name="readonly">Y</xsl:with-param>
       			<xsl:with-param name="required">Y</xsl:with-param>
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
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_NAME</xsl:with-param>
      <xsl:with-param name="name">abbv_name</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     
     <xsl:if test="$displaymode='edit'">
     	  <xsl:call-template name="select-field">
		      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_TYPE</xsl:with-param>
		      <xsl:with-param name="name">phrase_type</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="phrase_type[.!='']"><xsl:value-of select="phrase_type"/></xsl:if></xsl:with-param>
		      <xsl:with-param name="options">
		      	<xsl:call-template name="phrase_type_options" />
		      	<!-- <xsl:call-template name="code-data-options">
		         	<xsl:with-param name="paramId">C047</xsl:with-param>
		         	<xsl:with-param name="productCode">*</xsl:with-param>
		         </xsl:call-template> -->
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
			<xsl:variable name="parameterId">C048</xsl:variable>
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
      <xsl:with-param name="size">50</xsl:with-param>
      <xsl:with-param name="maxsize">100</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode = 'edit'">
		     <!-- Content -->
		    <div id="static-text-editor">
		      <xsl:call-template name="big-textarea-wrapper">
			   	 <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CONTENT</xsl:with-param>
			   	 <xsl:with-param name="required">Y</xsl:with-param>
			   	 <xsl:with-param name="content">
		    		 <xsl:call-template name="textarea-field">
				       <xsl:with-param name="name">static_text</xsl:with-param>
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
					<xsl:with-param name="rows">13</xsl:with-param>
					<xsl:with-param name="cols">40</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:if test="phrase_type[.= '02']"><xsl:apply-templates select="text"/></xsl:if> 
					</xsl:with-param>
					<xsl:with-param name="instantiation-event">/rich-text-editor/display</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:if>
		<xsl:if test="$displaymode='view'">
		  <xsl:if test="phrase_type[.= '01']">
			<xsl:call-template name="big-textarea-wrapper">
	   	 		 <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CONTENT</xsl:with-param>
	   			 <xsl:with-param name="content">
    			 <xsl:call-template name="textarea-field">
		    	 <xsl:with-param name="name">text</xsl:with-param>
		      	 <xsl:with-param name="rows">13</xsl:with-param>
				 <xsl:with-param name="cols">40</xsl:with-param>
				 <xsl:with-param name="required">Y</xsl:with-param>
		   		 </xsl:call-template>
     			</xsl:with-param>
    		</xsl:call-template>
    	  </xsl:if>
    	  <xsl:if test="phrase_type[.= '02']">
    		<div class="big-textarea-wrapper-content-dynamic-phrase">
    			<xsl:call-template name="textarea-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_CONTENT</xsl:with-param>
						<xsl:with-param name="name">text</xsl:with-param>
						<xsl:with-param name="rows">13</xsl:with-param>
						<xsl:with-param name="cols">40</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="text"/></xsl:with-param>
				</xsl:call-template>
			</div>
    	  </xsl:if>	
		</xsl:if>
		 
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
 	 		<xsl:call-template name="input-field">
    			<xsl:with-param name="button-type">system-entity</xsl:with-param>
    			<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
    			<xsl:with-param name="name">entity</xsl:with-param>
    			<xsl:with-param name="readonly">Y</xsl:with-param>
       			<xsl:with-param name="required">Y</xsl:with-param>
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
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_NAME</xsl:with-param>
      <xsl:with-param name="name">abbv_name</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     
     <xsl:if test="$displaymode='edit'">
     	  <xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">phrase_type</xsl:with-param>
   			<xsl:with-param name="value">01</xsl:with-param>
   		</xsl:call-template>
      </xsl:if>

     
     <xsl:if test="$displaymode='edit'">
		   <xsl:call-template name="hidden-field">
		   	<xsl:with-param name="name">product_code</xsl:with-param>
		   	<xsl:with-param name="value">*</xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
		   	<xsl:with-param name="name">product_code_hidden</xsl:with-param>
		   	<xsl:with-param name="value">*</xsl:with-param>
		   </xsl:call-template>
      </xsl:if>

     <xsl:if test="$displaymode='edit'">
		   <xsl:call-template name="hidden-field">
			   	<xsl:with-param name="name">category</xsl:with-param>
			   	<xsl:with-param name="value">99</xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
			   	<xsl:with-param name="name">category_code_hidden</xsl:with-param>
			   	<xsl:with-param name="value">99</xsl:with-param>
		   </xsl:call-template>
    </xsl:if>

     <!-- Description -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_PHRASE_DESCRIPTION</xsl:with-param>
      <xsl:with-param name="name">description</xsl:with-param>
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
       <xsl:with-param name="value">PHRASES_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
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
	  <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <xsl:template name ="phrase_type_options">
  <xsl:for-each select="/phrase/avail_phrases/phrase_types">
	  	<option>
			<xsl:attribute name="value">
		       <xsl:value-of select="phrase_code"/>
		    </xsl:attribute>
		    <xsl:value-of select="phrase_desc"/>
	    </option>
   </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>