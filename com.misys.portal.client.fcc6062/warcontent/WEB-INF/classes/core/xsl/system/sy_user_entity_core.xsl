<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Bank Company Screen, System Form (Attached Banks Screen).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      13/05/08
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
		exclude-result-prefixes="localization">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="token"/>
  <xsl:param name="action"/>
  <xsl:param name="company"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="arrowDownImage"><xsl:value-of select="$images_path"/>arrow_down.png</xsl:param>
  <xsl:param name="arrowUpImage"><xsl:value-of select="$images_path"/>arrow_up.png</xsl:param>
  
	
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="sy_jurisdiction.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="user_entities_record"/>
  </xsl:template>
  
  <xsl:template match="user_entities_record">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!-- Show the user details -->
	  <xsl:apply-templates select="static_user" mode="display"/>
	  <!-- Show the company's entities -->
	  <!-- <xsl:apply-templates select="." mode="input"/>-->
    
      <xsl:call-template name="user_entities_details"/>

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
   <xsl:with-param name="xml-tag-name">company_entity_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.user_entity</xsl:with-param>
     <xsl:with-param name="override-home-url">'/screen/BankSystemFeaturesScreen?option=<xsl:value-of select="$option"/>&amp;company=<xsl:value-of select="$company"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 

  <!-- Template for Entities related to a given Company in Input Mode -->
  <xsl:template name="user_entities_details">
  <!-- <xsl:template match="user_entities_record" mode="input">-->
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_ENTITY</xsl:with-param>
   <xsl:with-param name="content">

   <xsl:choose>
    <xsl:when test="count(avail_entities/entity) != 0">
	 <!-- Banks Attached to the Company --><!-- Use template?!!!! -->
    <div style="text-align:center">
     <xsl:if test="$displaymode = 'edit'">
   	  <xsl:attribute name="class">collapse-label</xsl:attribute>
   	 </xsl:if>
   	  <xsl:if test="$displaymode = 'edit'">
     <xsl:call-template name="select-field">
  	  <xsl:with-param name="id">avail_list_nosend</xsl:with-param>
  	  <xsl:with-param name="name"></xsl:with-param>
   	  <xsl:with-param name="type">multiple</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
	    <xsl:when test="$displaymode='edit'">
	     <xsl:apply-templates select="avail_entities/entity" mode="input"/>
	    </xsl:when>
	    <xsl:otherwise>
	     <ul class="multi-select">
	      <xsl:apply-templates select="avail_entities/entity" mode="input"/>
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
	   <xsl:with-param name="name">user_list</xsl:with-param>
	   <xsl:with-param name="type">multiple</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
	   <xsl:with-param name="options">
	    <xsl:choose>
	     <xsl:when test="$displaymode='edit'">
	      <xsl:apply-templates select="entities/entity[not(@preferred)]" mode="input"/>
	     </xsl:when>
	     <xsl:otherwise>
	      <ul class="multi-select">
           <xsl:apply-templates select="entities/entity[not(@preferred)]" mode="input"/>
          </ul>
	     </xsl:otherwise>
	    </xsl:choose>
	   </xsl:with-param>
      </xsl:call-template>
    </div>
    </xsl:when>
    <xsl:otherwise>
     <p><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NO_USER_ENTITY')"/></p>
    </xsl:otherwise>
   </xsl:choose>
   <div class="clear"></div>
  </xsl:with-param>
 </xsl:call-template>
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
     <xsl:when test="$nextscreen"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
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
         <xsl:when test="$nextscreen">CUSTOMER_USER_ENTITIES_MAINTENANCE</xsl:when>
         <xsl:otherwise>USER_ENTITY_MAINTENANCE</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">featureid</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="static_user/login_id"/></xsl:with-param>
   	  </xsl:call-template>	 
		<xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">token</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template>
   	  <xsl:if test="$nextscreen='BankSystemFeaturesScreen'">
   	  	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="static_user/company_id"/></xsl:with-param>
      	</xsl:call-template>
   	  </xsl:if> 
   	  
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <!-- Template for Company Entities (whether already given or still available) in Input Mode -->
  <xsl:template match="avail_entities/entity" mode="input">
 
   <xsl:variable name="current_entity"><xsl:value-of select="abbv_name"/></xsl:variable>
   <!-- Check if the current entity belongs to the user -->
   <xsl:if test="count(../../entities/entity/abbv_name[.=$current_entity])=0">
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
      <xsl:if test="abbv_name[.!='']">
       <option>
        <xsl:attribute name="value"><xsl:value-of select="abbv_name"/></xsl:attribute>
        <xsl:value-of select="abbv_name"/>
       </option>
      </xsl:if>
     </xsl:when>
     <xsl:otherwise>
      <xsl:if test="abbv_name[.!='']">
       <li><xsl:value-of select="abbv_name"/></li>
      </xsl:if>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
  </xsl:template>
	
  <!-- Template for User's Entities (whether already given or still available) in Input Mode -->
  <xsl:template match="entities/entity" mode="input">
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
      <xsl:if test="abbv_name[.!='']">
       <option>
        <xsl:attribute name="value"><xsl:value-of select="abbv_name"/></xsl:attribute>
        <xsl:value-of select="abbv_name"/>
       </option>
      </xsl:if>
     </xsl:when>
     <xsl:otherwise>
      <xsl:if test="abbv_name[.!='']">
       <li><xsl:value-of select="abbv_name"/></li>
      </xsl:if>
     </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>