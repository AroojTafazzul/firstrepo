<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for news maintenance

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Saïd SAI
##########################################################
-->

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
  <xsl:param name="channeltype"/>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/NewsScreen</xsl:param>
  
  <!-- These params are empty for maintain news -->
  <xsl:param name="product-code"/>
  
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates select="news_record"/>
  </xsl:template>
  
  <!-- 
   NEWS MAINTAIN TEMPLATE.
  -->
  <xsl:template match="news_record">
  <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="menu">
	     <xsl:with-param name="show-template">N</xsl:with-param>
	     <xsl:with-param name="show-save">N</xsl:with-param>
	  </xsl:call-template>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
     </xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="attachments-file-dojo"/>
    
    <!-- The form that is submitted -->
    <xsl:call-template name="realform"/>
    
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="show-save">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->

  <!-- Additional javascript for this form are  -->
  <!-- added here. -->
  <xsl:template name="js-imports">
    <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.news</xsl:with-param>
    <xsl:with-param name="xml-tag-name">news_record</xsl:with-param>
    <xsl:with-param name="override-help-access-key">NE_01</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">channel_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">item_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">display_order</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">last_modified</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">IsNewsItemNew</xsl:with-param>
    </xsl:call-template>
   </div>
  </xsl:template>
  
  <!-- General Details -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_NEWS_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">
      
      <xsl:call-template name="select-field">
       <xsl:with-param name="label">TOPIC_LABEL</xsl:with-param>
       <xsl:with-param name="name">topic_id</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="options">
        <xsl:apply-templates select="topics">
        	<xsl:with-param name="currenttopic" select="topic_id"/>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">TITLE_LABEL</xsl:with-param>
       <xsl:with-param name="name">title</xsl:with-param>
       <xsl:with-param name="id">news-title</xsl:with-param>
       <xsl:with-param name="size">35</xsl:with-param>
       <xsl:with-param name="maxsize">255</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">LINK</xsl:with-param>
       <xsl:with-param name="name">link</xsl:with-param>
       <xsl:with-param name="size">35</xsl:with-param>
       <xsl:with-param name="maxsize">255</xsl:with-param>
       <xsl:with-param name="regular-expression">(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&amp;%@!\-\/]))?</xsl:with-param>
      </xsl:call-template>
      
      <!--  News Start Date. --> 
	  <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_NEWS_START_DATE</xsl:with-param>
	    <xsl:with-param name="name">start_display_date</xsl:with-param>
	    <xsl:with-param name="size">10</xsl:with-param>
	    <xsl:with-param name="maxsize">10</xsl:with-param>
	    <xsl:with-param name="fieldsize">small</xsl:with-param>
	    <xsl:with-param name="type">date</xsl:with-param>
	    <xsl:with-param name="swift-validate">N</xsl:with-param>
	    <xsl:with-param name="required">N</xsl:with-param>
	  </xsl:call-template>
	  
	  <!--  News End Date. --> 
	  <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_NEWS_END_DATE</xsl:with-param>
	    <xsl:with-param name="name">end_display_date</xsl:with-param>
	    <xsl:with-param name="size">10</xsl:with-param>
	    <xsl:with-param name="maxsize">10</xsl:with-param>
	    <xsl:with-param name="fieldsize">small</xsl:with-param>
	    <xsl:with-param name="type">date</xsl:with-param>
	    <xsl:with-param name="swift-validate">N</xsl:with-param>
	    <xsl:with-param name="required">N</xsl:with-param>
	  </xsl:call-template>
	  
     
	   <br/>
	   <div dojoType="dijit.Editor" id="description" name="description" style="width:60%; margin-left:auto; margin-right:auto;">
   			<xsl:apply-templates select="description"/>
	   </div>
      
     </div>
    </xsl:with-param>
   </xsl:call-template>
   
   
  </xsl:template>
  
  <!-- 
   -->
   
    <xsl:template match="description">
	  <xsl:value-of select="child::node()" disable-output-escaping="yes"/>
	</xsl:template>
   
  <xsl:template match="topics">
     <xsl:param name="currenttopic"/>
     <xsl:for-each select="topic">
      	<xsl:sort data-type="text"/>
      	<option>
	   	  <xsl:if test="topic_id[ . = $currenttopic]">
	   	    <xsl:attribute name="selected">selected</xsl:attribute>
	   	  </xsl:if> 
	      <xsl:attribute name="value"><xsl:value-of select="topic_id"/></xsl:attribute> 
	      <xsl:value-of select="title"/>
	    </option>
     </xsl:for-each>
  </xsl:template>
  
  
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">NEWS</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">channeltype</xsl:with-param>
       <xsl:with-param name="value" select="$channeltype"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attachment_type</xsl:with-param>
       <xsl:with-param name="value">news</xsl:with-param>
      </xsl:call-template>
        <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
</xsl:stylesheet>