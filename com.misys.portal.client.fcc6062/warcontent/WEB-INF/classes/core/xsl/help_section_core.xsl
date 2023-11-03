<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Help section Screen, System Form.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      
author:    
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
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->  
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
  <xsl:param name="token"/>
  <xsl:param name="permission"/>
  <xsl:param name="sectionid"><xsl:value-of select="/help_section/section_id"/></xsl:param>  
  <xsl:param name="actioncode"/>
  <!-- 
  <xsl:param name="fields"/>
  <xsl:param name="formname"/>
  -->  	
   
  <!-- Global Imports. -->
  <xsl:include href="common/help_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="help_section"/>
  </xsl:template>
  
  <xsl:template match="help_section">
   <!-- Loading message  -->
   <xsl:call-template name="onlinehelp-loading-message"/>
   
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="help-section-details"/>
     </xsl:with-param>
    </xsl:call-template>
     
    <xsl:call-template name="realform"/>
   
    <!--  Display common menu. -->
    <xsl:call-template name="help-menu"/>
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
  <xsl:call-template name="help-common-js-imports">
   <xsl:with-param name="xml-tag-name">help_section</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.help</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">section_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">parent_id</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">save_type</xsl:with-param>
	<xsl:with-param name="value">H</xsl:with-param>
    </xsl:call-template>    
  </div>
 </xsl:template>
 
 <!--
  Main Details of the Help Section 
  -->
 <xsl:template name="help-section-details">
    <xsl:call-template name="fieldset-wrapper"> 
    <xsl:with-param name="legend"><xsl:value-of select="$actioncode"/></xsl:with-param>
    <xsl:with-param name="content">
 	 <!-- Title -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_EDITHELPSECTION_MSG</xsl:with-param>
      <xsl:with-param name="name">title</xsl:with-param>
      <xsl:with-param name="size">34</xsl:with-param>
      <xsl:with-param name="maxsize">34</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     <!-- Display order -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_EDITHELPSECTION_ORDERNUMMSG</xsl:with-param>
      <xsl:with-param name="name">display_order</xsl:with-param>
      <xsl:with-param name="size">5</xsl:with-param>
      <xsl:with-param name="maxsize">5</xsl:with-param>      
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="type">number</xsl:with-param>      
     </xsl:call-template>
     
     <!-- Access key -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_EDITHELPSECTION_ACCESSKEYMSG</xsl:with-param>
      <xsl:with-param name="name">access_key</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
     </xsl:call-template>
     
     <!-- Permission -->
     <xsl:call-template name="select-field">
     	<xsl:with-param name="label">XSL_EDITHELPSECTION_PERMISSION</xsl:with-param>
     	<xsl:with-param name="name">permission</xsl:with-param>
     	<xsl:with-param name="options">
     		<xsl:call-template name="permission-options"/>
    	</xsl:with-param>
    </xsl:call-template>
    
	<!-- Selection of the language -->
	<!-- 10 is the first section with a language (Guide Utilisateur, User Guide...) -->
	<xsl:variable name="current"><xsl:value-of select="language"/></xsl:variable>
	<xsl:variable name="language-required">
		<xsl:choose>
		<xsl:when test="section_id[. &lt; '10']">N</xsl:when>	
		<xsl:otherwise>Y</xsl:otherwise>
		</xsl:choose>	
	</xsl:variable>
	<xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_EDITHELPSECTION_LANGUAGE</xsl:with-param>
			<xsl:with-param name="name">language</xsl:with-param>
				<xsl:with-param name="disabled">
					<xsl:choose>
					<xsl:when test="section_id[. &lt; '10']">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>	
				<xsl:with-param name="required"><xsl:value-of select="$language-required"/></xsl:with-param>	
				<xsl:with-param name="options">
				<xsl:if test="section_id[. &lt; '10']">
					<option value="">
						<xsl:attribute name="selected"/>
					</option>
				</xsl:if>
				<!-- Go through all the defined help languages -->
  				<xsl:for-each select="//languages/help_languages/language">
   					<xsl:variable name="optionLanguage"><xsl:value-of select="."/></xsl:variable>
					<option>
						<xsl:attribute name="value"><xsl:value-of select="$optionLanguage"/></xsl:attribute>
						<xsl:if test="$current = $optionLanguage">
							<xsl:attribute name="selected"/>
						</xsl:if>
						<xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
					</option>
  				</xsl:for-each>
				</xsl:with-param>
		</xsl:call-template>  
   
     <!-- Save type
     <xsl:call-template name="select-field">
     	<xsl:with-param name="label">XSL_EDITHELPSECTION_CONTENT_TYPE</xsl:with-param>
     	<xsl:with-param name="name">save_type</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>     	
     	<xsl:with-param name="options">
     		<xsl:call-template name="savetype-options"/>
    	</xsl:with-param>
    </xsl:call-template> -->		
		
	 <!-- Content -->
	 <xsl:choose>
	 <xsl:when test="//save_type[.='H'] or //save_type[.='']">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">content</xsl:with-param>
      <xsl:with-param name="label">XSL_EDITHELPSECTION_CONTENT</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="onlinehelp-richtextarea-field">
       		<xsl:with-param name="name">content</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
	</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">content</xsl:with-param>
      <xsl:with-param name="label">XSL_EDITHELPSECTION_CONTENT</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">	
	  <xsl:call-template name="textarea-field">
       <xsl:with-param name="name">content</xsl:with-param>
       <xsl:with-param name="rows">20</xsl:with-param>
       <xsl:with-param name="cols">50</xsl:with-param>
       <xsl:with-param name="required">N</xsl:with-param>
       <!-- Necessary to avoid having a popup window linked to the textarea -->
      <xsl:with-param name="button-type"></xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
	</xsl:call-template>       
	</xsl:otherwise>	
	</xsl:choose>
     
     </xsl:with-param>
     </xsl:call-template>     
 </xsl:template>

 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/OnlineHelpScreen</xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template> 
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">SECTIONS_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">featureid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="section_id"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">token</xsl:with-param>
	   <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  	  </xsl:call-template>        
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
   <!--
    Permissions options.
   -->
  <xsl:template name="permission-options">
  	<xsl:apply-templates select="//permission"/>
  </xsl:template>
  
   <!--
    Permission option.
   -->
  <xsl:template match="permission">
  	<option>
  		<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
		<xsl:if test="name [ .= /help_section/permission]"><xsl:attribute name="selected"/></xsl:if>   		
  		<xsl:value-of select="name"/> 		
  	</option>
  </xsl:template>  
  <!-- Content save type options, only ollow HTML option -->
  <xsl:template name="savetype-options">
  	<option value="H">
		<xsl:if test="//save_type[.='H']"><xsl:attribute name="selected"/></xsl:if>   		
  		<xsl:value-of select="localization:getGTPString($language, 'XSL_EDITHELPSECTION_CONTENT_TYPE_HTML')"/> 		
  	</option>
  	<option value="P">
		<xsl:if test="//save_type[.='P']"><xsl:attribute name="selected"/></xsl:if>   		
		<xsl:value-of select="localization:getGTPString($language, 'XSL_EDITHELPSECTION_CONTENT_TYPE_PLAIN')"/>  		
  	</option> 	 	
  </xsl:template>   
  
  <xsl:template name="onlinehelp-richtextarea-field">
   <!-- Required Parameters -->
   <xsl:param name="name"/>
   
   <!-- Optional -->
   <xsl:param name="label"/>
   <xsl:param name="id" select="$name"/>
   <xsl:param name="value" select="//*[name()=$name]" />
  <!-- Rich text area -->
  <div dojoType="dijit.Editor" style="width:auto;">
      <xsl:attribute name="plugins">[
    'bold','italic','|','insertUnorderedList','|','createLink','insertImage','|',
    {name: 'dojox.editor.plugins.TablePlugins', command: 'insertTable'},
    {name: 'dojox.editor.plugins.TablePlugins', command: 'modifyTable'},
    {name: 'dojox.editor.plugins.TablePlugins', command: 'InsertTableRowBefore'},
    {name: 'dojox.editor.plugins.TablePlugins', command: 'InsertTableRowAfter'},
    {name: 'dojox.editor.plugins.TablePlugins', command: 'insertTableColumnBefore'},
    {name: 'dojox.editor.plugins.TablePlugins', command: 'insertTableColumnAfter'},
    {name: 'dojox.editor.plugins.TablePlugins', command: 'deleteTableRow'},
    {name: 'dojox.editor.plugins.TablePlugins', command: 'deleteTableColumn'}
    ]
    </xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>    
      <xsl:value-of select="$value" disable-output-escaping="yes"/>
	</div>
</xsl:template>
  
  
  
</xsl:stylesheet>