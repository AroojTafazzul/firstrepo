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
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
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
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
  
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="arrowDownImage"><xsl:value-of select="$images_path"/>arrow_down.png</xsl:param>
  <xsl:param name="arrowUpImage"><xsl:value-of select="$images_path"/>arrow_up.png</xsl:param>
  
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="entity_record">
   <xsl:apply-templates select="entity"/>
  </xsl:template>
  
  <xsl:template match="entity">
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
      <xsl:call-template name="entity-details"/>
      <xsl:call-template name="products-details"/>
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
   <xsl:with-param name="xml-tag-name">entity</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.entity</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_ENTITY</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>&amp;company=<xsl:value-of select="$company"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
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
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">address_address_line_1</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_1"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">entity_id</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="entity_id"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">swift_address_address_line_1</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="post_code"/></xsl:with-param>
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
   		<xsl:with-param name="content">
	
			<!-- Abbreviated Name -->
			<xsl:choose>
				<xsl:when test="abbv_name[.='']">
					<xsl:call-template name="input-field">
      				 <xsl:with-param name="label">XSL_JURISDICTION_ABBV_NAME</xsl:with-param>
      				 <xsl:with-param name="name">abbv_name</xsl:with-param>
     				 <xsl:with-param name="required">Y</xsl:with-param>
     				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
                 <xsl:call-template name="input-field">
                  <xsl:with-param name="label">XSL_JURISDICTION_ABBV_NAME</xsl:with-param>
                  <xsl:with-param name="name">abbv_name</xsl:with-param>
                  <xsl:with-param name="override-displaymode">view</xsl:with-param>
                 </xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
	 		
	 		<!-- Company Name -->
	 		<!-- static_company is only passed for customer matrix maintenance on bankgroup side -->
        	<xsl:if test="$option='CUSTOMER_ENTITY_MAINTENANCE'">
        		<xsl:call-template name="input-field">
      				<xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
      				<xsl:with-param name="name">company_abbv_name</xsl:with-param>
      				<xsl:with-param name="override-displaymode">view</xsl:with-param>
     			</xsl:call-template>
        	</xsl:if>
        	
        	<!-- Name -->
	 		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
      			<xsl:with-param name="name">name</xsl:with-param>
     		</xsl:call-template>
     		
     		<!-- Swift Address / Postal Address Tabs --><!-- Country Code -->
     		<xsl:call-template name="address-details"/>
     		
     		<!-- Contract Reference -->
    		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_BEI</xsl:with-param>
      			<xsl:with-param name="name">bei</xsl:with-param>
      			<xsl:with-param name="size">11</xsl:with-param>
      			<xsl:with-param name="maxsize">11</xsl:with-param>
                <xsl:with-param name="uppercase">Y</xsl:with-param>
     		</xsl:call-template>
     	</xsl:with-param>
   	</xsl:call-template>
 </xsl:template>
 
 <!--
  Main Details of the Products
  -->
 <xsl:template name="products-details">
  <xsl:if test="count(../references_record/customer_reference) > 1">
   <xsl:call-template name="fieldset-wrapper">
   	 <xsl:with-param name="legend">XSL_HEADER_REFERENCES</xsl:with-param>
   	  <xsl:with-param name="content">
      <div style="text-align:center">
       <xsl:if test="$displaymode = 'edit'">
   	    <xsl:attribute name="class">collapse-label</xsl:attribute>
   	   </xsl:if>
   	   <xsl:if test="$displaymode = 'edit'">
        <xsl:call-template name="select-field">
         <xsl:with-param name="name">avail_list</xsl:with-param>
         <xsl:with-param name="type">multiple</xsl:with-param>
         <xsl:with-param name="size">10</xsl:with-param>
         <xsl:with-param name="options">
          <xsl:choose>
	       <xsl:when test="$displaymode='edit'">
	        <xsl:apply-templates select="../references_record/customer_reference" mode="available"/>
	       </xsl:when>
	       <xsl:otherwise>
	        <ul>
             <xsl:apply-templates select="../references_record/customer_reference" mode="selected"/>
            </ul>
	       </xsl:otherwise>
	      </xsl:choose>
         </xsl:with-param>
        </xsl:call-template>
        <div id="add-remove-buttons" class="multiselect-buttons">
         <button dojoType="dijit.form.Button" type="button" id="add"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />
         <img>
	      	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowDownImage)"/></xsl:attribute>
	      	<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" /></xsl:attribute>
      	</img>
        </button>
        <button dojoType="dijit.form.Button" type="button" id="remove"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
         <img>
      	   <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowUpImage)"/></xsl:attribute>
      	   <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" /></xsl:attribute>
         </img>
        </button>
        </div>
       </xsl:if>
       <xsl:call-template name="select-field">
        <xsl:with-param name="name">entity_list</xsl:with-param>
        <xsl:with-param name="type">multiple</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="options">
         <xsl:choose>
		  <xsl:when test="$displaymode='edit'">
		   <xsl:apply-templates select="../references_record/customer_reference" mode="selected"/>
		  </xsl:when>
		  <xsl:otherwise>
		   <ul class="multi-select">
	        <xsl:apply-templates select="../references_record/customer_reference" mode="selected"/>
	       </ul>
		  </xsl:otherwise>
		 </xsl:choose>
        </xsl:with-param>
       </xsl:call-template>
      </div>	
   	 </xsl:with-param>
     </xsl:call-template>
   	</xsl:if>
   	
   	<div class="clear"></div>

   	<xsl:choose>
	 <xsl:when test="count(../product) > 1">
	  <xsl:call-template name="fieldset-wrapper">
   	   <xsl:with-param name="legend">XSL_HEADER_PRODUCT</xsl:with-param>
   	   <xsl:with-param name="content">
   	    <xsl:choose>
   	     <xsl:when test="$displaymode='edit'">
      	   <xsl:apply-templates select="../product"/>
   	     </xsl:when>
   	     <xsl:otherwise>
   	      <xsl:call-template name="row-wrapper">
           <xsl:with-param name="content">
   	        <ul>
      	     <xsl:apply-templates select="../product">
      	      <xsl:with-param name="mode">text</xsl:with-param>
      	     </xsl:apply-templates>
   	        </ul>
   	       </xsl:with-param>
   	      </xsl:call-template>
   	     </xsl:otherwise>
   	    </xsl:choose>
   	   </xsl:with-param>
   	  </xsl:call-template>
	 </xsl:when>
	 <xsl:otherwise/>
	</xsl:choose>
   
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
   <xsl:with-param name="action">
   		<xsl:choose>
          <xsl:when test="$nextscreen and $nextscreen !=''"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/CustomerSystemFeaturesScreen</xsl:otherwise>
        </xsl:choose>
    </xsl:with-param>
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
	     <xsl:when test="security:isBank($rundata)">CUSTOMER_ENTITY_MAINTENANCE</xsl:when>
		 <xsl:otherwise>ENTITIES_MAINTENANCE</xsl:otherwise>
		</xsl:choose>
	   </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
       <!-- static_company is only passed for customer matrix maintenance on bankgroup side -->
      <xsl:if test="$option='CUSTOMER_ENTITY_MAINTENANCE'">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="company_abbv_name"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <!-- return old entity abbv_name to distinguish new from update -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">old_abbv_name</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="abbv_name"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$operation='MODIFY_FEATURES'">
	     <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">abbv_name</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="abbv_name"/></xsl:with-param>
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
     <xsl:call-template name="checkbox-field">
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
  
</xsl:stylesheet>