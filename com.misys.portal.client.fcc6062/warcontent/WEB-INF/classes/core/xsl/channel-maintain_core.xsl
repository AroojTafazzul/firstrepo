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
  xmlns:company="xalan://com.misys.portal.security.GTPCompany"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
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
   <xsl:apply-templates select="channel_record"/>
  </xsl:template>
  
  
  <xsl:template match="channel_record">
  <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
   <div>
   		
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
	      
	      <xsl:call-template name="new_topic_dialogs"/>
	      
	     </xsl:with-param>
	    </xsl:call-template>
   		
   		
   		
   		<!-- The form that is submitted -->
	    <xsl:call-template name="realform"/>
	    
	    <xsl:call-template name="menu">
	     <xsl:with-param name="show-template">N</xsl:with-param>
	     <xsl:with-param name="show-save">N</xsl:with-param>
	     <xsl:with-param name="second-menu">Y</xsl:with-param>
	    </xsl:call-template>
	   
	   <!-- Javascript imports  -->
	   <xsl:call-template name="js-imports"/>
   		
   		
   		
   		
   </div>
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
       <xsl:with-param name="value">CHANNEL</xsl:with-param>
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
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
   <xsl:template name="hidden-fields">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">parm_id</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">brch_code</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">channel_id</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">channel_type</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">company_id</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">IsChannelNew</xsl:with-param>
      </xsl:call-template>
     </div>
   </xsl:template>
   
   <xsl:template name="js-imports">
     <xsl:call-template name="common-js-imports">
      <xsl:with-param name="binding">misys.binding.channel</xsl:with-param>
      <xsl:with-param name="xml-tag-name">channel_record</xsl:with-param>
      <xsl:with-param name="override-help-access-key">NC_01</xsl:with-param>
     </xsl:call-template>
   </xsl:template>
   
   
   <!-- General Details -->
  <xsl:template name="general-details">
	   <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_CHANNEL_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	     <div id="generaldetails">      
	       <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_CHANNEL_TITLE</xsl:with-param>
	        <xsl:with-param name="name">channel_name</xsl:with-param>
	        <xsl:with-param name="maxsize">255</xsl:with-param>
	        <xsl:with-param name="required">Y</xsl:with-param>
	       </xsl:call-template>
	      <xsl:if test="defaultresource:getResource('SHOW_NEWSDEST_CONTENTPROVIDER_BANKGROUP') = 'true' and security:isGroup($rundata) = 'true'">
			  <xsl:call-template name="select-field">
			    <xsl:with-param name="label">XSL_NEWS_DESTINATION</xsl:with-param>
			    <xsl:with-param name="name">news_destination</xsl:with-param>
			    <xsl:with-param name="required">Y</xsl:with-param>
			    <xsl:with-param name="options">
				    <option value="01"><xsl:value-of select="localization:getGTPString($language, 'XSL_NEWS_DESTINATION_BANK')"/></option>
   				    <option value="03"><xsl:value-of select="localization:getGTPString($language, 'XSL_NEWS_DESTINATION_CUSTOMER')"/></option>
			    </xsl:with-param>
		  </xsl:call-template> 
		  </xsl:if>       
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="label">XSL_CHANNEl_DESCRIPTION</xsl:with-param>
	        <xsl:with-param name="name">description</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	        <xsl:with-param name="rows">8</xsl:with-param>
	        <xsl:with-param name="cols">40</xsl:with-param>
	        <xsl:with-param name="maxlines">15</xsl:with-param>
	        <xsl:with-param name="button-type"/>
		  </xsl:call-template>
	      <xsl:call-template name="select-field">
		    <xsl:with-param name="label">XSL_NEWS_DISPLAY</xsl:with-param>
		    <xsl:with-param name="name">data_1</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
		    <xsl:with-param name="options">
			    <xsl:apply-templates select="layouts"/>
		    </xsl:with-param>
		  </xsl:call-template>      
	     </div>
	    </xsl:with-param>
	   </xsl:call-template>
	   
	   <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_TOPICS_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	     <div id="topics-details">
	       <xsl:call-template name="topics-table"/>
	     </div>
	    </xsl:with-param>
	   </xsl:call-template>
	   
	   <div id="topic_fields" />
	
	   <script>
	     dojo.ready(function(){ 
			 misys._config = misys._config || {};
		 	dojo.mixin(misys._config,  {
				topicAttached : <xsl:value-of select="count(//topics/topic)"/>
		 	});
		 });
	   </script>   
  </xsl:template>
  
  <xsl:template match="layouts">
     <xsl:for-each select="layout">
      	<xsl:sort select="localization:getGTPString($language, name)" data-type="text"/>
      	<option>
	   	  <xsl:if test="key_1[.//default_layout/data_1]">
	   	    <xsl:attribute name="selected">selected</xsl:attribute>
	   	  </xsl:if> 
	      <xsl:attribute name="value"><xsl:value-of select="key_1"/></xsl:attribute> 
	      <xsl:value-of select="localization:getGTPString($language, data_1)"/>
	    </option>
     </xsl:for-each>
  </xsl:template>  
  
 <xsl:template name="topics-table">
	<xsl:call-template name="attachments-table">
		<xsl:with-param name="max-attachments">-1</xsl:with-param>
		<xsl:with-param name="existing-attachments" select="//topic" />
		<xsl:with-param name="table-thead">
			<th class="ctr-acc-tblheader" style="width : 18%" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_TOPIC_IMG_HEADER')"/></th>
			<th class="ctr-acc-tblheader" style="width : 18%" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_TOPIC_TITLE_HEADER')"/></th>
			<th class="ctr-acc-tblheader" style="width : 48%" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_TOPIC_LINK_HEADER')"/></th>
		</xsl:with-param>
		<xsl:with-param name="table-row-type">topic</xsl:with-param>
		<xsl:with-param name="empty-table-notice">XSL_JURISDICTION_NO_TOPICS_SETUP</xsl:with-param>
		<xsl:with-param name="delete-attachments-notice">XSL_JURISDICTION_TOPIC_NOTICE</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="$displaymode='edit'">
		<button dojoType="dijit.form.Button" type="button">
			<xsl:attribute name="id">openTopicDialog</xsl:attribute>
			<xsl:attribute name="onclick">misys.showTransactionAddonsDialog('topic');</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_TOPIC')" />
		</button>
	</xsl:if>
 </xsl:template>
  
  <xsl:template name="new_topic_dialogs">
	<div class="widgetContainer">
	<xsl:call-template name="dialog">
	  <xsl:with-param name="id">topicDialog</xsl:with-param>
	  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'DIALOG_TOPIC_DETAILS')" /></xsl:with-param>
	  <xsl:with-param name="content">	   	
		<xsl:call-template name="input-field">
		 <xsl:with-param name="label">XSL_TOPIC_TITLE_LABEL</xsl:with-param>
		 <xsl:with-param name="id">title_offsetcode_nosend</xsl:with-param>
		 <xsl:with-param name="name"></xsl:with-param>
		 <xsl:with-param name="maxsize">100</xsl:with-param>
		 <xsl:with-param name="required">Y</xsl:with-param>
		 <xsl:with-param name="value"/>
		</xsl:call-template>		
		<xsl:call-template name="input-field">
		 <xsl:with-param name="label">XSL_TOPIC_LINK_LABEL</xsl:with-param>
		 <xsl:with-param name="id">link_offsetcode_nosend</xsl:with-param>
		 <xsl:with-param name="name"></xsl:with-param>
		 <xsl:with-param name="maxsize">255</xsl:with-param>
		 <xsl:with-param name="value"/>
		</xsl:call-template>		
		<xsl:call-template name="hidden-field">
         <xsl:with-param name="id">img_file_id_offsetcode_nosend</xsl:with-param>
         <xsl:with-param name="name"></xsl:with-param>
         <xsl:with-param name="value"/>
        </xsl:call-template>        
        <xsl:call-template name="hidden-field">
         <xsl:with-param name="id">dialog_topic_id_offsetcode_nosend</xsl:with-param>
         <xsl:with-param name="name"></xsl:with-param>
         <xsl:with-param name="value"/>
        </xsl:call-template>
        
		<!--<button dojoType="dijit.form.Button" type="button" onclick="fncOpenImageUploadDialog()">
		    <xsl:attribute name="id">openUploadDialog</xsl:attribute>
		    <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_SET_NEW_LOGO_BTN')"/></xsl:attribute>
		    <xsl:value-of select="localization:getGTPString($language, 'XSL_SET_NEW_LOGO_BTN')"/>
		</button>
		<img>
		   <xsl:attribute name="id">image_new</xsl:attribute>
		   <xsl:attribute name="src"></xsl:attribute>
		</img>-->
		
		<xsl:call-template name="upload-logo">
		 <xsl:with-param name="name">new</xsl:with-param>
		 <xsl:with-param name="button-label">XSL_SET_NEW_LOGO_BTN</xsl:with-param>
		</xsl:call-template>
	  </xsl:with-param>
	  <xsl:with-param name="buttons">
	  <xsl:call-template name="row-wrapper">
		<xsl:with-param name="id">addTopicButton</xsl:with-param>
		<xsl:with-param name="content">
		<button dojoType="dijit.form.Button" type="button">
			<xsl:attribute name="id">cancelTopicButton</xsl:attribute>
			<xsl:attribute name="onclick">misys.hideTransactionAddonsDialog('topic');</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
		</button>			
		<button dojoType="dijit.form.Button" type="button">
			<xsl:attribute name="id">addTopicButton</xsl:attribute>
			<xsl:attribute name="onclick">misys.addTransactionAddon('topic');</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
		</button>
		</xsl:with-param>
	</xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </div>
</xsl:template>   

<xsl:template name="add-topic-dialog"> 
    <xsl:call-template name="dialog">
      <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_DETAILS')"/></xsl:with-param>
      <xsl:with-param name="id">fileUploadDialog</xsl:with-param>
      <xsl:with-param name="content">
         <xsl:call-template name="form-wrapper">
           <xsl:with-param name="name">sendfiles</xsl:with-param>
           <xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
           <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadScreen</xsl:with-param>
           <xsl:with-param name="override-displaymode">edit</xsl:with-param>
           <xsl:with-param name="content">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_FILESDETAILS_FILE</xsl:with-param>
	           <xsl:with-param name="name">file</xsl:with-param>
	           <xsl:with-param name="value"/>
	           <xsl:with-param name="type">file</xsl:with-param>
	           <xsl:with-param name="size">20</xsl:with-param>
	           <xsl:with-param name="maxsize">255</xsl:with-param>
	           <xsl:with-param name="required">Y</xsl:with-param>
	           <xsl:with-param name="swift-validate">N</xsl:with-param>
	          </xsl:call-template>
           </xsl:with-param>
         </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="buttons">
        <xsl:call-template name="row-wrapper">
           <xsl:with-param name="id">uploadButton</xsl:with-param>
           <xsl:with-param name="content">
            <button dojoType="dijit.form.Button" id="cancelUpload" onclick="fncCancelImageUpload();" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
            </button>
            <button dojoType="dijit.form.Button" id="uploadButton" onclick="fncDoUploadImage()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/>
            </button>
 	       </xsl:with-param>
   		</xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
 </xsl:template>    
</xsl:stylesheet>  