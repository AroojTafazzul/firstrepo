<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : 

 Entity Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Laure Blin
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
  <!ENTITY amp "&#38;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization security">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="operation"/>
  <xsl:param name="company"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>

  
  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/system_common.xsl" />
  <xsl:include href="../../../core/xsl/system/sy_jurisdiction.xsl" />
  <xsl:include href="../../../core/xsl/common/maker_checker_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="entity_record">
   <xsl:call-template name="entity"/>
  </xsl:template>
  
  <xsl:template name="entity">
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
      <xsl:call-template name="display-dates"></xsl:call-template>
      <xsl:call-template name="entity-details"/>
      <xsl:apply-templates select="customer_reference/references" />
	    <xsl:call-template name="account-details"/>
	  <div class="widgetContainer">
	    <xsl:call-template name="charge-account-address">
	     <xsl:with-param name="prefix">entity</xsl:with-param>
	    </xsl:call-template>
	   <xsl:call-template name="system-settings"/>
	  </div>
	  <xsl:call-template name="subscription-package-details"/>
	  <xsl:call-template name="entity-roles" />
	  <div class="widgetContainer">
	  <xsl:call-template name="remarks" />
	  </div>
	  
   <xsl:if test="$canCheckerReturnComments = 'true'">
      	<xsl:call-template name="comments-for-return-mc">
      		<xsl:with-param name="value"><xsl:value-of select="role/return_comments"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <xsl:call-template name="maker-checker-menu"/>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="realform"/>
    <xsl:call-template name="account-dialog-template"/>
   </div>
     <script>
     dojo.ready(function(){
  		misys._config = misys._config || {};
  		dojo.mixin(misys._config, {
  		bankAccountTypeMapping: {
  			<xsl:for-each select="/entity_record/account_types">
					<xsl:variable name="account_type_mapping"><xsl:value-of select="account_type_mapping"/></xsl:variable>
         			<xsl:variable name="account_type_description"><xsl:value-of select="account_type_description"/></xsl:variable>
					"<xsl:value-of select="$account_type_mapping"/>":{
					"accountTypeMapping":"<xsl:value-of select="$account_type_mapping"/>",
					"accountDescription":"<xsl:value-of select="$account_type_description"/>"
						},
				</xsl:for-each>
				 "*":{}
			},
	   accountTypeCodeMapping: {
  			<xsl:for-each select="/entity_record/account_types">
					<xsl:variable name="account_type_mapping"><xsl:value-of select="account_type_mapping"/></xsl:variable>
         			<xsl:variable name="account_type_code"><xsl:value-of select="account_type_code"/></xsl:variable>
					"<xsl:value-of select="$account_type_mapping"/>":{
					"accountTypeMapping":"<xsl:value-of select="$account_type_mapping"/>",
					"accountTypeCode":"<xsl:value-of select="$account_type_code"/>"
						},
				</xsl:for-each>
				 "*":{}
	    	
	    	}});
   		});
   		

  </script>
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
   <xsl:with-param name="xml-tag-name">entity</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.entity_mc</xsl:with-param>
    <!-- <xsl:with-param name="override-home-url">CONTEXT_PATH + SERVLET_PATH + '/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>&amp;company=<xsl:value-of select="$company"/>'</xsl:with-param> -->
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>&amp;company=<xsl:value-of select="$company"/>'</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_ENTITY</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="localization-dialog"/>
   	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">swiftBicCodeRegexValue</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BIC_CHARSET')"/></xsl:with-param>
	</xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_abbv_name</xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$operation='MODIFY_FEATURES'">
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">abbv_name</xsl:with-param>
	<xsl:with-param name="id">abbv_name_hidden</xsl:with-param>
	<xsl:with-param name="value"><xsl:value-of select="abbv_name"/></xsl:with-param>
   </xsl:call-template>
   </xsl:if>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">old_abbv_name</xsl:with-param>
    <xsl:with-param name="id">old_abbv_name_hidden</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="abbv_name"/></xsl:with-param>
   </xsl:call-template><!--
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">address_address_line_1</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_1"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">swift_address_address_line_1</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="post_code"/></xsl:with-param>
   </xsl:call-template>
    --><xsl:call-template name="hidden-field">
    <xsl:with-param name="name">total_value_added_services</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="total_value_added_services"/></xsl:with-param>
   </xsl:call-template>
   
   <xsl:if test="count(../product) = 1">
   	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">product_<xsl:value-of select="../product"/></xsl:with-param>
     <xsl:with-param name="id">product_<xsl:value-of select="../product"/>_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value">Y</xsl:with-param>
   	</xsl:call-template>
   </xsl:if>
   <xsl:if test="count(../references_record/customer_reference) = 1">
	<xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">entity_list</xsl:with-param>
 	 <xsl:with-param name="value"><xsl:value-of select="../references_record/customer_reference/reference"/></xsl:with-param>
	</xsl:call-template>
   </xsl:if>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the entity
  -->
 <xsl:template name="entity-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_ENTITY</xsl:with-param>
   		<xsl:with-param name="button-type">
   			<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   		</xsl:with-param>
   		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
   		<xsl:with-param name="content">
			<!-- Company Name -->
	 		<!-- static_company is only passed for customer matrix maintenance on bankgroup side -->
        	<xsl:if test="$option='CUSTOMER_ENTITY_MAINTENANCE_MC'">
        		<xsl:call-template name="input-field">
      				<xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
      				<xsl:with-param name="name">company_abbv_name</xsl:with-param>
      				<xsl:with-param name="override-displaymode">view</xsl:with-param>
     			</xsl:call-template>
        	</xsl:if>
        	<!-- Personal -->
        	  <xsl:call-template name="multichoice-field">
     			 <xsl:with-param name="type">checkbox</xsl:with-param>
      			 <xsl:with-param name="label">XSL_ENTITY_PERSONAL</xsl:with-param>
  	  			 <xsl:with-param name="name">personal</xsl:with-param>
  	  		
     		 </xsl:call-template>
     		 <div>
     		  <xsl:call-template name="select-field">
	     			<xsl:with-param name="label"></xsl:with-param>
	     			<xsl:with-param name="label">XSL_ENTITY_LEGAL_ID_TYPE</xsl:with-param>
	     			<xsl:with-param name="name">legal_id_type</xsl:with-param>
	     			<xsl:with-param name="fieldsize">small</xsl:with-param>
	     			<xsl:with-param name="value"><xsl:value-of select="legal_id_type"/></xsl:with-param>
	     			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	     			<xsl:with-param name="required">Y</xsl:with-param>
	     			<xsl:with-param name="options">
	     				<xsl:call-template name="legal-id-types"/>
	     			</xsl:with-param>
	   			 </xsl:call-template>
	   			  <xsl:call-template name="input-field">
	      			<xsl:with-param name="label"></xsl:with-param>
	      			<xsl:with-param name="name">legal_id_no</xsl:with-param>
	      			<xsl:with-param name="type">text</xsl:with-param>
	      			<xsl:with-param name="maxsize">30</xsl:with-param>
	      			<xsl:with-param name="appendClass">inlineBlock legalType</xsl:with-param>
	      			<xsl:with-param name="required">Y</xsl:with-param>
	     		</xsl:call-template>
	     		 <xsl:call-template name="input-field">
			      <xsl:with-param name="name">country_legalid</xsl:with-param>
			      <xsl:with-param name="size">2</xsl:with-param>
			      <xsl:with-param name="maxsize">2</xsl:with-param>
			      <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			      <xsl:with-param name="uppercase">Y</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="appendClass">inlineBlock legalType</xsl:with-param>
		     	</xsl:call-template>
	     		<xsl:choose>
					 <xsl:when test="$displaymode='edit'"> 
					 	<xsl:call-template name="button-wrapper">
					      <xsl:with-param name="label">XSL_ALT_COUNTRY</xsl:with-param>
					      <xsl:with-param name="show-image">Y</xsl:with-param>
					      <xsl:with-param name="show-border">N</xsl:with-param>
					      <xsl:with-param name="onclick">misys.showCountryCodeDialog('codevalue', "['country_legalid']", 'C006', '', '', 'width:400px;height:400px', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_COUNTRY_LIST')"/>', 'legal' === 'popup');return false;</xsl:with-param>
					      <xsl:with-param name="id">legal_country_img</xsl:with-param>
					      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
					     </xsl:call-template>
					 </xsl:when>
				</xsl:choose>&nbsp;
	     		
     		</div>
			<!-- Abbreviated Name -->
			<xsl:choose>
				<xsl:when test="abbv_name[.='']">
					<xsl:call-template name="input-field">
      				 <xsl:with-param name="label">XSL_ENTITY_ID</xsl:with-param>
      				 <xsl:with-param name="name">abbv_name</xsl:with-param>
      				 <xsl:with-param name="maxsize">32</xsl:with-param>
     				 <xsl:with-param name="required">Y</xsl:with-param>
     				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
                  <xsl:call-template name="input-field">
			    	<xsl:with-param name="label">XSL_ENTITY_ID</xsl:with-param>
			    	<xsl:with-param name="id">abbv_name_view</xsl:with-param>
			    	<xsl:with-param name="value" select="abbv_name" />
			    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
		  		 </xsl:call-template>	    	
	    		<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">abbv_name</xsl:with-param>
	    		</xsl:call-template>
	    		</xsl:otherwise>
			</xsl:choose>
        	<!-- Name
	 		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
      			<xsl:with-param name="name">name</xsl:with-param>
     		</xsl:call-template> -->
     	  <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
		    <xsl:with-param name="name">name</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
		    <xsl:with-param name="maxsize">35</xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="input-field">
		    <xsl:with-param name="name">second_entity_name</xsl:with-param>
		    <xsl:with-param name="maxsize">35</xsl:with-param>
	      </xsl:call-template>
	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>
 
 <!--
  Main Details of the Products
  -->
 <!-- 
  Realform
  -->
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
       <xsl:with-param name="value" select="$operation"></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="$company"/></xsl:with-param>
      	</xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="entity_id[.!='']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">featureid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="entity_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
       <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="tnx_id[.!='']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">tnxid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </div>
    </xsl:with-param>
   </xsl:call-template>
     </xsl:if>
  </xsl:template>
  
  
  <!-- Template for Products List -->
  <xsl:template match="product">
   <xsl:param name="productCode"><xsl:value-of select="."/></xsl:param>

   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:call-template name="multichoice-field">
      <xsl:with-param name="type">checkbox</xsl:with-param>
      <xsl:with-param name="checked-label"><xsl:value-of select="localization:getDecode($language, 'N001', $productCode)"/></xsl:with-param>
  	  <xsl:with-param name="name">product_<xsl:value-of select="$productCode"/></xsl:with-param>
 	  <xsl:with-param name="checked"><xsl:if test="count(../entity/product[.=$productCode])!=0">Y</xsl:if></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="count(../entity/product[.=$productCode])!=0">
      <li><xsl:value-of select="localization:getDecode($language, 'N001', $productCode)"/></li>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  
  	<!-- Template for References List (available) -->
	<xsl:template match="customer_reference" mode="available">
     <xsl:param name="reference"><xsl:value-of select="reference"/></xsl:param>
	  <xsl:if test="count(../../entity/customer_reference[.=$reference])=0">	
	   <option>
		<xsl:attribute name="value"><xsl:value-of select="reference"/></xsl:attribute>
		<xsl:value-of select="description"/>&nbsp;(<xsl:value-of select="reference"/>) [<xsl:value-of select="bank"/>]
	   </option>
      </xsl:if>	
	</xsl:template>
	
	<!-- Template for References List (selected) -->
	<xsl:template match="customer_reference" mode="selected">
     <xsl:param name="reference"><xsl:value-of select="reference"/></xsl:param>

     <xsl:if test="count(../../entity/customer_reference[.=$reference])&gt;0">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
        <option>
         <xsl:attribute name="value"><xsl:value-of select="reference"/></xsl:attribute>
         <xsl:value-of select="description"/>(<xsl:value-of select="reference"/>)
        </option>
       </xsl:when>
       <xsl:otherwise>
	    <xsl:if test="description[.!=''] and reference[.!='']">
         <li><xsl:value-of select="description"/>(<xsl:value-of select="reference"/>)</li>
        </xsl:if>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:if>
	</xsl:template>
	<!-- Legal Id Type Options -->
  <xsl:template name="legal-id-types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <option>
            <xsl:attribute name="value"></xsl:attribute>
    </option>
     <xsl:for-each select="legal_types/legal_id_type">
     	<option>
     		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
     	    <xsl:value-of select="."></xsl:value-of>
     	</option>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="legal_id_type"></xsl:value-of>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  <xsl:template match="customer_reference/references">
   <xsl:call-template name="fieldset-wrapper">
   	   <xsl:with-param name="legend">XSL_ENTITY_CIF_DETAILS</xsl:with-param>
   	   <xsl:with-param name="content">
   	    <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ENTITY_CUSTOMER_CIF</xsl:with-param>
      			<xsl:with-param name="name">reference</xsl:with-param>
      			<xsl:with-param name="type">text</xsl:with-param>
      			<xsl:with-param name="maxsize">19</xsl:with-param>
      			<xsl:with-param name="required">Y</xsl:with-param>
     	</xsl:call-template>
     	 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ENTITY_CUSTOMER_CIF_DESCRIPTION</xsl:with-param>
      			<xsl:with-param name="name">description</xsl:with-param>
      			<xsl:with-param name="type">text</xsl:with-param>
      			<xsl:with-param name="maxsize">40</xsl:with-param>
      			<xsl:with-param name="required">Y</xsl:with-param>
     	</xsl:call-template>
   	   </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- Account Details -->
   <xsl:template name="account-details">
   <xsl:call-template name="fieldset-wrapper">
   	   <xsl:with-param name="legend">XSL_ENTITY_ACCOUNT_DETAILS</xsl:with-param>
   	   <xsl:with-param name="content">
   	   <div id="account-details-section" style="display:block">
		<xsl:call-template name="build-account-dojo-items">
		<xsl:with-param name="items" select="accounts/account"/>
		</xsl:call-template>
		</div>
		<div class="widgetContainer">
		 <xsl:call-template name="select-field">
     			<xsl:with-param name="label">XSL_CHARGING_ACCOUNT</xsl:with-param>
     			<xsl:with-param name="name">charging_account</xsl:with-param>
     			<xsl:with-param name="value"><xsl:value-of select="charging_account"/></xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
     			<xsl:with-param name="options">
     			      <xsl:call-template name="charging-account-options">
     			     	 <xsl:with-param name="items" select="accounts/account"/>
     			      </xsl:call-template>
     			</xsl:with-param>
   		 </xsl:call-template>
    	</div>
     	</xsl:with-param>
   	</xsl:call-template>
  </xsl:template>
  	<!-- ********* -->
	<!-- Accounts -->
	<!-- ********* -->
	<!-- Dialog Start -->
	<xsl:template name="account-dialog-template">
		<div id="account-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<!-- Customer entity -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">ACCOUNTNUMBER</xsl:with-param>
					<xsl:with-param name="name">account_number</xsl:with-param>
					<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ACCOUNT_NUMBER_LENGTH')"/></xsl:with-param>
					<xsl:with-param name="required" >Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
		  		   <xsl:with-param name="button-type">currency</xsl:with-param>
		    	   <xsl:with-param name="label">XSL_JURISDICTION_CURRENCY</xsl:with-param>
		     	   <xsl:with-param name="name">account_ccy_cur_code</xsl:with-param>
		     	   <xsl:with-param name="override-product-code">account_ccy</xsl:with-param>
		     	   <xsl:with-param name="size">3</xsl:with-param>
		     	   <xsl:with-param name="fieldsize">x-small</xsl:with-param>
		     	   <xsl:with-param name="maxsize">3</xsl:with-param>
		     	   <xsl:with-param name="required">Y</xsl:with-param>
		           <xsl:with-param name="uppercase">Y</xsl:with-param>
		  	  	</xsl:call-template>
				<xsl:call-template name="select-field">
    					<xsl:with-param name="label">ACCOUNTTYPE</xsl:with-param>
    					<xsl:with-param name="name">bank_account_type</xsl:with-param>
    					<xsl:with-param name="value"><xsl:value-of select="bank_account_type"/></xsl:with-param>
    					<xsl:with-param name="required">Y</xsl:with-param>
    					<xsl:with-param name="options">
    						<xsl:call-template name="account_types"/>
    					</xsl:with-param>
  				 	</xsl:call-template>
  				 	<xsl:call-template name="select-field">
    					<xsl:with-param name="label">XSL_ACCOUNT_PRODUCT_TYPE</xsl:with-param>
    					<xsl:with-param name="name">account_product_type</xsl:with-param>
    					<xsl:with-param name="value"><xsl:value-of select="account_product_type"/></xsl:with-param>
    					<xsl:with-param name="required">Y</xsl:with-param>
    					<xsl:with-param name="options">
    						<xsl:call-template name="account_product_types"/>
    					</xsl:with-param>
  				 	</xsl:call-template>
  				 	<xsl:call-template name="select-field">
     					<xsl:with-param name="label">XSL_CUSTOMER_ACCOUNT_TYPE</xsl:with-param>
     					<xsl:with-param name="name">cust_account_type</xsl:with-param>
     					<xsl:with-param name="value"><xsl:value-of select="cust_account_type"/></xsl:with-param>
     					<xsl:with-param name="required">Y</xsl:with-param>
     					<xsl:with-param name="options">
     						<xsl:call-template name="customer_account_types"/>
     					</xsl:with-param>
   				 	</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BANK_ID</xsl:with-param>
					<xsl:with-param name="name">bank_id</xsl:with-param>
					<xsl:with-param name="required" >9</xsl:with-param>
					<xsl:with-param name="required" >Y</xsl:with-param>
					<xsl:with-param name="maxsize">9</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BRANCH_CODE</xsl:with-param>
					<xsl:with-param name="name">branch_code</xsl:with-param>
					<xsl:with-param name="required" >9</xsl:with-param>
					<xsl:with-param name="required" >Y</xsl:with-param>
					<xsl:with-param name="maxsize">9</xsl:with-param>
				</xsl:call-template>
  				 	<xsl:call-template name="input-field">
					<xsl:with-param name="label">ACCOUNT_DESCRIPTION</xsl:with-param>
					<xsl:with-param name="name">account_desc</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="required" >Y</xsl:with-param>
					<xsl:with-param name="maxsize">40</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="multichoice-field">
    			 		<xsl:with-param name="type">checkbox</xsl:with-param>
     				 	<xsl:with-param name="label">XSL_ENTITY_ACCOUNT_NRA</xsl:with-param>
 	  					 <xsl:with-param name="name">account_nra</xsl:with-param>
    				 </xsl:call-template>
    				 <xsl:call-template name="hidden-field">
 						  <xsl:with-param name="name">account_type</xsl:with-param>
   				 </xsl:call-template>
   				 <div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button" type="button" id="accountOkButton">
								<xsl:attribute name="onmouseup">misys.fncValidateAccountPopup();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button" id="accountCancelButton">
								<xsl:attribute name="onmouseup">dijit.byId('account-dialog-template').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</div>

		</div>
		<!-- Dialog End -->
		<div id="accounts-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ACCOUNT_DETAILS')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<xsl:if test="$displaymode = 'edit'">
				<button dojoType="dijit.form.Button" type="button" id="addCustomerButton" dojoAttachEvent="onClick: addItem " dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_ENTITY_ADD_ACCOUNT')"/>
				</button>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
  <!-- ************************************************************************** -->
	<!--                          ACCOUNT - START                                 -->
	<!-- ************************************************************************** -->
	<xsl:template name="build-account-dojo-items">
	<xsl:param name="items"/>
		 <div dojoType="misys.system.widget.Accounts" dialogId="account-dialog-template" gridId="accounts-grid" id="accounts">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNUMBER')"/>
			</xsl:attribute>
			<xsl:if test="$displaymode = 'edit'">
				<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ENTITY_ADD_ACCOUNT')"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="viewMode">
    				<xsl:value-of select="$displaymode"/>
    		</xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="account" select="."/>
				<xsl:variable name="position" select="position()" />
				<div dojoType="misys.system.widget.Account">
					<!--<xsl:attribute name="id">account_<xsl:value-of select="$position"/></xsl:attribute>
					--><xsl:attribute name="account_number"><xsl:value-of select="$account/account_no"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:value-of select="$account/owner_type"/></xsl:attribute>
					<xsl:attribute name="owner_type"><xsl:value-of select="$account/bank_account_type"/></xsl:attribute>
					<xsl:attribute name="ccy"><xsl:value-of select="$account/cur_code"/></xsl:attribute>
					<xsl:attribute name="description"><xsl:value-of select="$account/description"/></xsl:attribute>
					<xsl:attribute name="nra"><xsl:value-of select="$account/nra"/></xsl:attribute>
					<xsl:attribute name="account_product_type"><xsl:value-of select="$account/bank_account_product_type"/></xsl:attribute>
					<xsl:attribute name="cust_account_type"><xsl:value-of select="$account/customer_account_type"/></xsl:attribute>
					<xsl:attribute name="bank_id"><xsl:value-of select="$account/bank_id"/></xsl:attribute>
					<xsl:attribute name="branch_code"><xsl:value-of select="$account/branch_no"/></xsl:attribute>
					<xsl:attribute name="account_type"><xsl:value-of select="$account/account_type"/></xsl:attribute>
					<xsl:attribute name="settlement_means"><xsl:value-of select="$account/settlement_means"/></xsl:attribute>
				</div>
				
			</xsl:for-each>
		</div> 
	</xsl:template>
<!--  System Settings Template -->	
<xsl:template name="system-settings">
	<xsl:param name="node-name">ibft_cnaps_code</xsl:param>
 	<xsl:param name="label">XSL_ENTITY_IBFT_CNAPS</xsl:param>
 	<xsl:param name="node-name-2">ibft_bulk_cnaps_code</xsl:param>
 	<xsl:param name="label-2">XSL_ENTITY_BULK_BFT_CNAPS</xsl:param>
  	<xsl:param name="first-value">01</xsl:param> <!-- Value of the first radio button -->
  	<xsl:param name="second-value">02</xsl:param> <!-- Value of the second radio button -->
  	<xsl:param name="enabled-label">XSL_ENABLE</xsl:param>
  	<xsl:param name="disabled-label">XSL_DISABLE</xsl:param>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_ENTITY_SYSTEM_SETTINGS</xsl:with-param>
   		<xsl:with-param name="content">
   		   <xsl:call-template name="multichoice-field">
     			 <xsl:with-param name="type">checkbox</xsl:with-param>
      			 <xsl:with-param name="label">XSL_ENTITY_AUTH_OWN_TNX</xsl:with-param>
  	  			 <xsl:with-param name="name">authorize_own_transaction</xsl:with-param>
     		 </xsl:call-template>
     	<xsl:choose>
     	<xsl:when test="auto_fwd_date[. = '']">
     		<xsl:call-template name="multichoice-field">
     			 <xsl:with-param name="type">checkbox</xsl:with-param>
      			 <xsl:with-param name="label">XSL_ENTITY_AUTO_FORWARD_DATE</xsl:with-param>
  	  			 <xsl:with-param name="name">auto_fwd_date</xsl:with-param>
  	  			 <xsl:with-param name="checked">Y</xsl:with-param>
     		 </xsl:call-template>
    	</xsl:when>
    	<xsl:otherwise>
    		<xsl:call-template name="multichoice-field">
     			 <xsl:with-param name="type">checkbox</xsl:with-param>
      			 <xsl:with-param name="label">XSL_ENTITY_AUTO_FORWARD_DATE</xsl:with-param>
  	  			 <xsl:with-param name="name">auto_fwd_date</xsl:with-param>
     		 </xsl:call-template>
    	</xsl:otherwise>
    	</xsl:choose>
       <xsl:call-template name="input-field">
      		<xsl:with-param name="label">XSL_ENTITY_FILE_ENCRYP_METHOD</xsl:with-param>
      		<xsl:with-param name="name">file_encryption_method</xsl:with-param>
      		<xsl:with-param name="maxsize">20</xsl:with-param>
     	</xsl:call-template><!--
     	 <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label" select="$label"/>
	      <xsl:with-param name="content">
		        <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="group-label" select="$label"/>
			      <xsl:with-param name="label" select="$enabled-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_1</xsl:with-param>
			      <xsl:with-param name="value" select="$first-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $first-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
			    
			     <xsl:call-template name="multichoice-field">
			       <xsl:with-param name="group-label" select="$label"/>
			      <xsl:with-param name="label" select="$disabled-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_2</xsl:with-param>
			      <xsl:with-param name="value" select="$second-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $second-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
	    	</xsl:with-param>
 		 </xsl:call-template>
 		  <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label" select="$label-2"/>
	      <xsl:with-param name="content">
		        <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="group-label" select="$label"/>
			      <xsl:with-param name="label" select="$enabled-label"/>
			      <xsl:with-param name="name" select="$node-name-2"/>
			      <xsl:with-param name="id"><xsl:value-of select="node-name-2"/>_1</xsl:with-param>
			      <xsl:with-param name="value" select="$first-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $first-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
			    
			     <xsl:call-template name="multichoice-field">
			       <xsl:with-param name="group-label" select="$label-2"/>
			      <xsl:with-param name="label" select="$disabled-label"/>
			      <xsl:with-param name="name" select="$node-name-2"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name-2"/>_2</xsl:with-param>
			      <xsl:with-param name="value" select="$second-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $second-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
	    	</xsl:with-param>
 		 </xsl:call-template>
   		--></xsl:with-param>
   	</xsl:call-template>
   	</xsl:template>	
<!--  Template for Subscirption package area + value added services -->   	
<xsl:template name="subscription-package-details">
   <xsl:call-template name="fieldset-wrapper">
   	   <xsl:with-param name="legend">XSL_SUBSCRIPTION_PACKAGE_DETAILS</xsl:with-param>
   	   <xsl:with-param name="content">
		 <xsl:call-template name="select-field">
     			<xsl:with-param name="label">XSL_SUBSCRIPTION_PACKAGE</xsl:with-param>
     			<xsl:with-param name="name">subscription_package</xsl:with-param>
     			<xsl:with-param name="value"><xsl:value-of select="package_id"/></xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
     			<xsl:with-param name="options">
     			          <xsl:call-template name="subscription-package-options"></xsl:call-template>
     			</xsl:with-param>
   		 </xsl:call-template>
   	   </xsl:with-param>
   	   
   </xsl:call-template><!--
     call template for subsciption package area 
   --><xsl:call-template name="subscription-package-charge-details"></xsl:call-template><!--
      call template for value added services 
   --><xsl:call-template name="value-added-services"></xsl:call-template>
   </xsl:template>

<!-- Template for Subsciption Package options -->
<xsl:template name="subscription-package-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:for-each select="subscription_pacakges/packages">
     	<option>
     		<xsl:attribute name="value"><xsl:value-of select="package_id"/></xsl:attribute>
     		<xsl:value-of select="subscription_description"/>
     	</option>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="subscription_package_description"></xsl:value-of>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
<!--  Template for Subscriptoin Package -->
<xsl:template name="subscription-package-charge-details">

  <div class="widgetContainer">
  <table border="0" cellpadding="0" cellspacing="0" class="valueaddedservice">
     <thead>
  		  <tr>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_STANDARD_CHARGE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_SPECIAL_CHARGE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_SPECIAL_CHARGE_EXPIRY')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_WAIVE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_WAIVE_EXPIRY_DATE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_LOCAL_TAX')"/></th>
  		  </tr>
  	 </thead>
  	 <tr>
  	   <td>
  	   <xsl:call-template name="currency-field">
		<xsl:with-param name="label"></xsl:with-param>
		<xsl:with-param name="product-code">stnd_charge</xsl:with-param>
		<xsl:with-param name="override-currency-value"><xsl:value-of select="stnd_charge_cur_code"/></xsl:with-param>
		<xsl:with-param name="override-amt-value"><xsl:value-of select="stnd_charge_amt"/></xsl:with-param>
		<xsl:with-param name="readonly">Y</xsl:with-param>
		<xsl:with-param name="required">N</xsl:with-param>
	   </xsl:call-template>
       </td>
       <td class="widthper25">
        <xsl:call-template name="currency-field">
		<xsl:with-param name="label"></xsl:with-param>
		<xsl:with-param name="product-code">special_charge</xsl:with-param>
		<xsl:with-param name="override-currency-value"><xsl:value-of select="special_charge_cur_code"/></xsl:with-param>
		<xsl:with-param name="override-amt-value"><xsl:value-of select="special_charge_amt"/></xsl:with-param>
		<xsl:with-param name="readonly">Y</xsl:with-param>
		<xsl:with-param name="required">N</xsl:with-param>
	   </xsl:call-template><!--
       <xsl:call-template name="input-field">
  	    <xsl:with-param name="button-type">currency</xsl:with-param>
    	<xsl:with-param name="name">special_charge_cur_code</xsl:with-param>
    	<xsl:with-param name="value" select="special_charge_cur_code"></xsl:with-param>
    	 to give the name to the javascript, normally it's a product code 
    	<xsl:with-param name="override-product-code">special_charge</xsl:with-param>
    	<xsl:with-param name="size">3</xsl:with-param>
        <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       	<xsl:with-param name="maxsize">3</xsl:with-param>
       	<xsl:with-param name="uppercase">Y</xsl:with-param>
       </xsl:call-template>
        --></td>
        <td>
        <xsl:call-template name="input-field">
       	 <xsl:with-param name="name">special_charge_expiry</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
         <xsl:with-param name="type">date</xsl:with-param>
       </xsl:call-template>
       </td>
       <td>
        <xsl:call-template name="multichoice-field">
     	   <xsl:with-param name="type">checkbox</xsl:with-param>
  	  	  	<xsl:with-param name="name">subscription_waive</xsl:with-param>
         </xsl:call-template>
       </td>
       <td>
        <xsl:call-template name="input-field">
       	 <xsl:with-param name="name">waive_expiry_date</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
         <xsl:with-param name="type">date</xsl:with-param>
       </xsl:call-template>
       </td>
       <td>
        <xsl:call-template name="multichoice-field">
     	   <xsl:with-param name="type">checkbox</xsl:with-param>
  	  	  	<xsl:with-param name="name">local_tax</xsl:with-param>
         </xsl:call-template>
       </td>
  	 </tr>
  </table>
  </div>
</xsl:template>
<!-- Template for Value Added Services -->
<xsl:template name="value-added-services">
 <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_VALUE_ADDED_SERVICES</xsl:with-param>
   <xsl:with-param name="legend-type">intended-header</xsl:with-param>
   <xsl:with-param name="content">
   <div class="widgetContainer">
  <table border="0" cellpadding="0" cellspacing="0" class="valueaddedservice">
     <thead>
  		  <tr>
  		     <th class="dojoxGridCell" scope="col"></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_VALUE_ADDEd_SERVICE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_STANDARD_CHARGE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_SPECIAL_CHARGE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_SPECIAL_CHARGE_EXPIRY')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_WAIVE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_WAIVE_EXPIRY_DATE')"/></th>
  		     <th class="dojoxGridCell" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBSCRIPTION_LOCAL_TAX')"/></th>
  		  </tr>
  	 </thead>
  	 <xsl:for-each select="value_added_services">
  	 <xsl:variable name="prefix">
  	 <xsl:value-of select="service_number"></xsl:value-of>
  	 </xsl:variable>
  	  <tr>
  	  <td width="3%">
  	    <xsl:call-template name="multichoice-field">
     	   <xsl:with-param name="type">checkbox</xsl:with-param>
  	  	  	<xsl:with-param name="name">select_service_<xsl:value-of select="$prefix"/></xsl:with-param>
         </xsl:call-template>
  	  </td>
  	   <td width="17%">
  	    <xsl:call-template name="input-field">
       	 <xsl:with-param name="name">sevice_name_<xsl:value-of select="$prefix"/></xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="value_added_service_name"/></xsl:with-param>
         <xsl:with-param name="readonly">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">medium</xsl:with-param>
       </xsl:call-template>
       </td><!--
  	   <td width="8%">
  	    <xsl:call-template name="input-field">
       	 <xsl:with-param name="name">service_std_chge_ccy_<xsl:value-of select="$prefix"/></xsl:with-param>
         <xsl:with-param name="size">3</xsl:with-param>
         <xsl:with-param name="maxsize">3</xsl:with-param>
         <xsl:with-param name="fieldsize">x-small</xsl:with-param>
         <xsl:with-param name="readonly">Y</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="std_ccy"/></xsl:with-param>
       </xsl:call-template>
       </td>
       --><td width="18%">
        <xsl:call-template name="currency-field">
		<xsl:with-param name="label"></xsl:with-param>
		<xsl:with-param name="product-code">service_stnd_charge_<xsl:value-of select="$prefix"/></xsl:with-param>
		<xsl:with-param name="override-amt-name">service_stnd_amt_<xsl:value-of select="$prefix"/></xsl:with-param>
		<xsl:with-param name="override-currency-value"><xsl:value-of select="std_ccy"/></xsl:with-param>
		<xsl:with-param name="override-amt-value"><xsl:value-of select="std_charge"/></xsl:with-param>
		<xsl:with-param name="required">N</xsl:with-param>
		</xsl:call-template>
       </td>
       <td width="18%">
        <xsl:call-template name="currency-field">
		<xsl:with-param name="label"></xsl:with-param>
		<xsl:with-param name="product-code">service_special_chge_<xsl:value-of select="$prefix"/></xsl:with-param>
		<xsl:with-param name="override-amt-name">service_special_amt_<xsl:value-of select="$prefix"/></xsl:with-param>
		<xsl:with-param name="override-currency-value"><xsl:value-of select="special_charge_ccy"/></xsl:with-param>
		<xsl:with-param name="override-amt-value"><xsl:value-of select="special_charge_amt"/></xsl:with-param>
		<xsl:with-param name="required">N</xsl:with-param>
		</xsl:call-template>
      </td><!--
      <td width="11%">
        <xsl:call-template name="input-field">
       	 <xsl:with-param name="name">service_special_charge_<xsl:value-of select="$prefix"/></xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
       </xsl:call-template>
       </td>
        --><td width="17%">
        <xsl:call-template name="input-field">
       	 <xsl:with-param name="name">service_special_charge_expiry_<xsl:value-of select="$prefix"/></xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="special_charge_expiry"/></xsl:with-param>
         <xsl:with-param name="type">date</xsl:with-param>
       </xsl:call-template>
       </td>
       <td width="3%">
        <xsl:call-template name="multichoice-field">
     	   <xsl:with-param name="type">checkbox</xsl:with-param>
  	  	  	<xsl:with-param name="name">service_subscription_waive_<xsl:value-of select="$prefix"/></xsl:with-param>
  	  	  	<xsl:with-param name="value"><xsl:value-of select="subscription_waive"/></xsl:with-param>
         </xsl:call-template>
       </td>
       <td width="17%">
        <xsl:call-template name="input-field">
       	 <xsl:with-param name="name">service_waive_expiry_date<xsl:value-of select="$prefix"/></xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
         <xsl:with-param name="type">date</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="waive_expiry_date"/></xsl:with-param>
       </xsl:call-template>
       </td>
       <td width="3%">
        <xsl:call-template name="multichoice-field">
     	   <xsl:with-param name="type">checkbox</xsl:with-param>
  	  	  	<xsl:with-param name="name">service_local_tax_<xsl:value-of select="$prefix"/></xsl:with-param>
  	  	  	<xsl:with-param name="value"><xsl:value-of select="local_tax"/></xsl:with-param>
         </xsl:call-template>
       </td>
      </tr>
      </xsl:for-each>
  	 </table>
  	</div>
   
   </xsl:with-param>
 </xsl:call-template>
</xsl:template>
 <!-- =========================================================================== -->
 <!-- ======================== Template Entity Role ========================= -->
 <!-- =========================================================================== -->
  <xsl:template name="entity-roles">
  <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_ENTITY_ROLES</xsl:with-param>
  <xsl:with-param name="content">	
 <xsl:if test="$displaymode = 'edit'">
    <xsl:call-template name="multichoice-field">
     <xsl:with-param name="type">checkbox</xsl:with-param>
     <xsl:with-param name="label">XSL_ENTITY_ADDITIONAL_ROLES</xsl:with-param>
  	  <xsl:with-param name="name">enable_additional_role</xsl:with-param>
    </xsl:call-template>
 </xsl:if>
 <xsl:choose>
         <xsl:when test="enable_additional_role[.='Y']">
          <div id="entity-roles">
			<xsl:apply-templates select="group_record" mode="role_input">
    		 <xsl:with-param name="dest">04</xsl:with-param>
	 		 <xsl:with-param name="dest_bis">*</xsl:with-param>
			 <xsl:with-param name="type">01</xsl:with-param>
			</xsl:apply-templates>
		 </div>
         </xsl:when>
         <xsl:when test="$displaymode = 'edit' and (enable_additional_role[.=''] or enable_additional_role[.='N'])">
          <div id="entity-roles" style="display:none">		
			<xsl:apply-templates select="group_record" mode="role_input">
    		 <xsl:with-param name="dest">04</xsl:with-param>
			 <xsl:with-param name="dest_bis">*</xsl:with-param>
			 <xsl:with-param name="type">01</xsl:with-param>
			</xsl:apply-templates>
			<div style="display:none">
    		 <xsl:call-template name="fieldset-wrapper">
	 		 <xsl:with-param name="legend">XSL_HEADER_AVAILABLE_ROLES</xsl:with-param>
	 		 <xsl:with-param name="content">
	   		 <xsl:apply-templates select="group_record" mode="authorisation_input">
	   		 <xsl:with-param name="dest">04</xsl:with-param>
			 <xsl:with-param name="dest_bis">*</xsl:with-param>
			 <xsl:with-param name="type">02</xsl:with-param>
			<xsl:with-param name="give_all">Y</xsl:with-param>
	   		</xsl:apply-templates>
   	  		</xsl:with-param>
   			</xsl:call-template>
   			</div>
          </div>
         </xsl:when>
         <xsl:when test="$displaymode = 'view'">
         	<xsl:apply-templates select="group_record" mode="role_input">
    		 <xsl:with-param name="dest">04</xsl:with-param>
			 <xsl:with-param name="dest_bis">*</xsl:with-param>
			 <xsl:with-param name="type">01</xsl:with-param>
			</xsl:apply-templates>
         </xsl:when>
   </xsl:choose>
</xsl:with-param>
 </xsl:call-template>
</xsl:template>
<!--  Template Remarks -->
<xsl:template name="remarks">
  <xsl:call-template name="big-textarea-wrapper">
	   	 <xsl:with-param name="label">XSL_ENTITY_REMARKS</xsl:with-param>
	   	 <xsl:with-param name="content">
			<xsl:call-template name="textarea-field">
		         <xsl:with-param name="name">remark</xsl:with-param>
		         <xsl:with-param name="rows">10</xsl:with-param>
		         <xsl:with-param name="cols">75</xsl:with-param>
		         <xsl:with-param name="maxlines">10</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		         <xsl:with-param name="button-type"></xsl:with-param>
	        </xsl:call-template>
	     </xsl:with-param>
	   </xsl:call-template>
</xsl:template>
<!-- Charging account options -->
<xsl:template name="charging-account-options">
<xsl:param name="items"/>
   <xsl:choose>
    <xsl:when test="$displaymode='edit' and count($items) >= 1">
    <xsl:for-each select="$items">
	 <xsl:variable name="account" select="."/>
     	<option>
     		<xsl:attribute name="value"><xsl:value-of select="$account/account_no"/></xsl:attribute>
     	   <xsl:value-of select="$account/account_no"></xsl:value-of>
     	</option>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="charging_account"></xsl:value-of>
    </xsl:otherwise>
   </xsl:choose>
</xsl:template>
	<!-- Account Type Options -->
  <xsl:template name="account_types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <option>
            <xsl:attribute name="value"></xsl:attribute>
    </option>
     <xsl:for-each select="account_types/bank_account_type">
     	<option>
     		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
     	    <xsl:value-of select="."></xsl:value-of>
     	</option>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="account_type"></xsl:value-of>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
   <xsl:template name="account_product_types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <option>
            <xsl:attribute name="value"></xsl:attribute>
    </option>
     <xsl:for-each select="account_types/account_product_type">
     	<option>
     		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
     	    <xsl:value-of select="."></xsl:value-of>
     	</option>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="account_product_type"></xsl:value-of>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  <!-- Customer Account Type Options -->
 <xsl:template name="customer_account_types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <option>
            <xsl:attribute name="value"></xsl:attribute>
    </option>
     <xsl:for-each select="customer_account_types/customer_account_type">
     	<option>
     		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
     	    <xsl:value-of select="."></xsl:value-of>
     	</option>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="cust_account_type"></xsl:value-of>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
   <xsl:template name="display-dates">
   <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
                  <xsl:with-param name="content">
                  <xsl:call-template name="input-field">
                      <xsl:with-param name="label">XSL_CREATION_DATE</xsl:with-param>
                      <xsl:with-param name="name">creation_date</xsl:with-param>
                      <xsl:with-param name="type">number</xsl:with-param>
                      <xsl:with-param name="fieldsize">medium</xsl:with-param>
                      <xsl:with-param name="readonly">Y</xsl:with-param>
                      <xsl:with-param name="required">N</xsl:with-param>
                      <xsl:with-param name="override-displaymode">view</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
               <xsl:call-template name="input-field">
                      <xsl:with-param name="label">XSL_AMMEND_DATE</xsl:with-param>
                  	  <xsl:with-param name="name">amend_date</xsl:with-param>
                      <xsl:with-param name="type">number</xsl:with-param>
                      <xsl:with-param name="fieldsize">medium</xsl:with-param>
                      <xsl:with-param name="readonly">Y</xsl:with-param>
                      <xsl:with-param name="required">N</xsl:with-param>
                      <xsl:with-param name="override-displaymode">view</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
   </xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>