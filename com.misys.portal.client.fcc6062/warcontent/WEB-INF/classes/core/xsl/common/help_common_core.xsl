<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
XSLT templates that are common to all system pages (profile,user, bank, company etc).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    exclude-result-prefixes="localization">

 <xsl:strip-space elements="*"/>

 <!-- Empty global params -->
 <xsl:param name="lowercase-product-code"/>
 <xsl:param name="realform-action"/>
 <xsl:param name="product-code"/>
 <xsl:param name="rundata"/>
 <xsl:param name="mode"/>
  <xsl:param name="token"/>
 <!-- Search word  -->
 <xsl:param name="search"/>

 <!--                                                  -->
 <!-- Common templates for help forms .                -->
 <!--                                                  -->
 <xsl:include href="common.xsl" />
 <xsl:include href="form_templates.xsl" />
 

 <!-- NOT USED FOR THE MOMENT 
  Commonly used menu for system pages (e.g. profile)
  -->
 <xsl:template name="help-menu">
  <xsl:param name="node-name"/>
  <xsl:param name="screen-name"/>
  <xsl:param name="show-help"/>
  <div class="menu widgetContainer">
  	<xsl:call-template name="localization-dialog"/>
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="button-wrapper">
     <xsl:with-param name="label">XSL_ACTION_SAVE</xsl:with-param>
     <xsl:with-param name="onclick">misys.submit('SUBMIT', 30);return false;
     </xsl:with-param>
     <xsl:with-param name="show-text-label">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="button-wrapper">
     <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
     <xsl:with-param name="onclick">misys.submit('CANCEL');return false;</xsl:with-param>
     <xsl:with-param name="show-text-label">Y</xsl:with-param>
    </xsl:call-template>
    
    <!-- Confirmation Dialog -->
    <xsl:call-template name="dialog">
     <xsl:with-param name="id">confirmationDialog</xsl:with-param>
     <xsl:with-param name="title">Confirmation</xsl:with-param>
     <xsl:with-param name="content"><div id="confirmationDialog_content"></div></xsl:with-param>
     <xsl:with-param name="buttons">
      <div id="submitProgressDialog_button" class="dialogButtons">
      <button dojoType="dijit.form.Button" type="button" id="acceptConfirmation" title="OK">OK</button>
      <button dojoType="dijit.form.Button" type="button" id="dismissConfirmation" title="Cancel" onmouseup="dijit.byId('confirmationDialog').hide()">Cancel</button>
     </div>
     </xsl:with-param>
    </xsl:call-template>

     <!-- Progress Dialog -->
     <xsl:call-template name="dialog">
	  <xsl:with-param name="id">submitProgressDialog</xsl:with-param>
	  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'DIALOG_DEFAULT_TITLE')"/></xsl:with-param>
	  <xsl:with-param name="content"><div id="submitProgressDialog_content"></div></xsl:with-param>
	  <xsl:with-param name="buttons"><div id="submitProgressDialog_button" class="dialogButtons"><button dojoType="dijit.form.Button" type="button" id="dismiss" title="OK" onmouseup="dijit.byId('submitProgressDialog').hide()">OK</button></div></xsl:with-param>
	</xsl:call-template>
   </xsl:if>
  </div>
 </xsl:template>
 
 <!-- Search Form -->
 <xsl:template name="help-search">
   <xsl:param name="class">search-form</xsl:param>
   <!-- Form #0 : Main Form -->
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">helpSearchForm</xsl:with-param>
    <xsl:with-param name="class"><xsl:value-of select="$class"/></xsl:with-param>
    <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/OnlineHelpScreen</xsl:with-param>
    <xsl:with-param name="content">
    <div id="standardSearchContainer">
    <span trim="true" dojoType="dijit.form.ValidationTextBox" name="search" id="search" required="true" class="x-large">
    	<xsl:attribute name="value"><xsl:value-of select="$search"/></xsl:attribute>
    </span>
    <button dojoType="dijit.form.Button" id="submit" type="submit"><xsl:value-of select="localization:getGTPString($language, 'HELPSEARCHGLOBAL_SEARCHBTN')"/></button>
   	<a>
		<xsl:attribute name="onclick">misys.toggleHelpSearchMode()</xsl:attribute>
		<xsl:attribute name="href">javascript:void(0)</xsl:attribute>
		<xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_ADVANCED')"/>
	</a>
	</div>
    <div id="advancedSearchContainer">  
	 <xsl:call-template name="fieldset-wrapper"> 
	    <xsl:with-param name="legend">XSL_HELPSEARCH_OPTIONS</xsl:with-param>
	    <xsl:with-param name="parse-widgets">N</xsl:with-param>
	    <xsl:with-param name="content">
	 	 <!-- ANDS -->
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_HELPSEARCH_FORM_ANDS</xsl:with-param>
	      <xsl:with-param name="name">searchInputAnds</xsl:with-param>
	      <xsl:with-param name="size">34</xsl:with-param>
	      <xsl:with-param name="maxsize">34</xsl:with-param>
	      <xsl:with-param name="required">N</xsl:with-param>
	     </xsl:call-template>
	 	 <!-- ORS -->
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_HELPSEARCH_FORM_ORS</xsl:with-param>
	      <xsl:with-param name="name">searchInputOrs</xsl:with-param>
	      <xsl:with-param name="size">34</xsl:with-param>
	      <xsl:with-param name="maxsize">34</xsl:with-param>
	      <xsl:with-param name="required">N</xsl:with-param>
	     </xsl:call-template>
	 	 <!-- Phrase -->
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_HELPSEARCH_FORM_PHRASE</xsl:with-param>
	      <xsl:with-param name="name">searchInputPhrase</xsl:with-param>
	      <xsl:with-param name="size">34</xsl:with-param>
	      <xsl:with-param name="maxsize">34</xsl:with-param>
	      <xsl:with-param name="required">N</xsl:with-param>
	     </xsl:call-template>
	     <!-- Nots -->
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_HELPSEARCH_FORM_NOTS</xsl:with-param>
	      <xsl:with-param name="name">searchInputNots</xsl:with-param>
	      <xsl:with-param name="size">34</xsl:with-param>
	      <xsl:with-param name="maxsize">34</xsl:with-param>
	      <xsl:with-param name="required">N</xsl:with-param>
	     </xsl:call-template>
	    <xsl:call-template name="row-wrapper">
	     <xsl:with-param name="id">submitAdvancedRow</xsl:with-param>
	     <xsl:with-param name="content">
			<button dojoType="dijit.form.Button" id="submitAdvanced" type="button" onclick="misys.buildLuceneQuery()"><xsl:value-of select="localization:getGTPString($language, 'HELPSEARCHGLOBAL_SEARCHBTN')"/></button>
	     </xsl:with-param>
	    </xsl:call-template>
		   	<a>
				<xsl:attribute name="onclick">misys.toggleHelpSearchMode()</xsl:attribute>
				<xsl:attribute name="href">javascript:void(0)</xsl:attribute>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_STANDARD')"/>
			</a>	 
			
			<xsl:call-template name="hidden-field">
      <xsl:with-param name="name">operation</xsl:with-param>
      <xsl:with-param name="value">SEARCH_FEATURES</xsl:with-param>
     </xsl:call-template>   
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">featureid</xsl:with-param>
      <xsl:with-param name="id">featureid</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="$sectionid"/></xsl:with-param>
     </xsl:call-template>  
	  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
     	
	   </xsl:with-param>
	  </xsl:call-template>
    </div>
     
    </xsl:with-param>
   </xsl:call-template>
   <!-- Javascript imports  -->
   <!--<xsl:call-template name="js-imports"/>-->
  </xsl:template> 
 
 <!-- ************************************************************** -->
 <!-- ********************* COMMON SYSTEM IMPORTS ****************** -->
 <!-- ************************************************************** -->
 
 <!--
  Common javascript imports for system pages with forms 
  
   Javascript variables
     - context paths and other vars
     - common dojo imports
     - dojo onloads and parser call 
  -->
 <xsl:template name="help-common-js-imports">
  <xsl:param name="xml-tag-name"/>
  <xsl:param name="binding"/>
 
  <!-- Message for js-disabled users. -->
  <noscript>
   <p><xsl:value-of select="localization:getGTPString($language, 'NOSCRIPT_MSG')"/></p>
   <style type="text/css">
    /* Hide the preloader and form*/
    #loading-message,
    #edit
    {
        display:none;
    }
   </style>
  </noscript>

   <script>
    dojo.ready(function(){
	    misys._config = (misys._config) || {};
	    dojo.mixin(misys._config, {
	    	xmlTagName: '<xsl:value-of select="$xml-tag-name"/>',
	    	homeUrl: misys.getServletURL('/screen/OnlineHelpScreen?option=SECTIONS_MAINTENANCE&amp;operation=DISPLAY_FEATURES&amp;featureid=<xsl:value-of select="$sectionid"/>'),
	    	onlineHelpUrl: misys.getServletURL('/screen/OnlineHelpScreen?option=SECTIONS_MAINTENANCE&amp;operation=DISPLAY_FEATURES&amp;featureid=<xsl:value-of select="$sectionid"/>')
	    });
	    <xsl:if test="$displaymode='edit'">
     		dojo.require("<xsl:value-of select="$binding"/>");
    	</xsl:if>
 	});
   </script>
 </xsl:template>
 
  <!--
   Preloader 
   -->
  <xsl:template name="onlinehelp-loading-message">
     <div id="loading-message">
       <p>
        <xsl:value-of select="localization:getGTPString($language, 'LOADING_ALERT')"/>
       </p>
       <div id="loadingProgressBar"></div>
     </div>
  </xsl:template> 
  
</xsl:stylesheet>
