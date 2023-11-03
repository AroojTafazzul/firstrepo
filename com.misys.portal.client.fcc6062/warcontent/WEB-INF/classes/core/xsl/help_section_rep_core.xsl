<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:helptool="xalan://com.misys.portal.help.util.HelpTool"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"	
	exclude-result-prefixes="localization securitycheck helptool utils">
	
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
 <xsl:strip-space elements="*"/>

 <!-- Empty global params -->
  <xsl:param name="lowercase-product-code"/>
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code"/>
  <xsl:param name="rundata"/>
  <xsl:param name="mode"/>  
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="displaymode">edit</xsl:param>  
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->   
  <xsl:param name="action"/>
  <xsl:param name="productcode"/>
  <xsl:param name="permission"/>
  <xsl:param name="token"/>
  <xsl:param name="sectionid">
  <xsl:choose>
  <xsl:when test="help_section/section_id[. !='']"><xsl:value-of select="help_section/section_id"/></xsl:when>
  <xsl:otherwise>-1</xsl:otherwise>
  </xsl:choose>
  </xsl:param>
 <xsl:param name="admin">
 	<xsl:choose>
	<xsl:when test="securitycheck:hasPermission(utils:getUserACL($rundata),'admin_help',utils:getUserEntities($rundata))">Y</xsl:when>
	<xsl:otherwise>N</xsl:otherwise>
	</xsl:choose> 
 </xsl:param>	  
	
	<!--
   Copyright (c) 2000-2007 Misys (http://www.misys.com),
   All Rights Reserved. 
	-->
	<!--xsl:import href="com_cross_references.xsl"/-->
  <!-- Global Imports. -->
 <!--                                                  -->
 <!-- Common templates for help.                       -->
 <!--                                                  -->
 <xsl:include href="common/common.xsl" />
 <xsl:include href="common/form_templates.xsl" />

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:template match="/">
		<!-- <xsl:value-of select="$navigation" disable-output-escaping="yes"/>	
		<xsl:call-template name="help-search"/>	
		<xsl:value-of select="$prev-next-navigation" disable-output-escaping="yes"/>-->
		<xsl:choose>
		<!-- No record to display. For instance, if the user try to see a section for which
		he does not have access to -->
		<xsl:when test="help_section/content[.= ''] and count(help_section/help_section) = 0">
		<xsl:value-of select="localization:getGTPString($language, 'XSL_DISPLAYHELP_EMTPY_SECTION')"/><br/>
		</xsl:when>	
		<xsl:otherwise>	
		<!-- We are displaying a common section, in this case, we display the section,
		its sub sections and its texts -->
		<ul>
		<xsl:apply-templates select="help_section"/>
		</ul>
		<!-- Content of the section -->
		<div>
		<span>
  			<xsl:value-of select="helptool:addContextPath(help_section/content)" disable-output-escaping="yes"/>		 
		</span>		
		</div>	
		<!-- Add buttons -->
		<xsl:if test="$admin = 'Y'">	
			<button dojoType="dijit.form.Button" type="submit">
	          <xsl:attribute name="onclick">dojo.global.location='<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/OnlineHelpScreen?option=SECTIONS_MAINTENANCE&amp;operation=ADD_FEATURES&amp;featureid=<xsl:value-of select="help_section/section_id"/>';</xsl:attribute>
              <xsl:attribute name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_DISPLAYHELP_ADD_SECTION')"/></xsl:attribute>
           	</button> 	
		</xsl:if>		
		</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
	<!-- Display a section and its sub sections -->
	<xsl:template match="help_section">
		<li>
		<div>
		<span>
			<a>
				<xsl:attribute name="onclick">misys.getHelpData(<xsl:value-of select="section_id"/>)</xsl:attribute>
				<!-- <xsl:attribute name="href"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/OnlineHelpScreen?option=SECTIONS_MAINTENANCE&amp;operation=DISPLAY_FEATURES&amp;featureid=<xsl:value-of select="section_id"/></xsl:attribute> -->
				<xsl:attribute name="href">javascript:void(0)</xsl:attribute>
				<xsl:value-of select="title"/>
			</a>
		</span>
		<xsl:call-template name="delete-edit-links">
			<xsl:with-param name="id"><xsl:value-of select="section_id"/></xsl:with-param>
			<xsl:with-param name="option">SECTIONS_MAINTENANCE</xsl:with-param>			
		</xsl:call-template>		
		</div>
		<!-- sub sections -->
		<xsl:if test="count(help_section) > 0 and count(ancestor::node()) = 1">
			<ul>
			<xsl:apply-templates select="help_section"/>
			</ul>
		</xsl:if>
		</li>
	</xsl:template>
	
	<xsl:template name="delete-edit-links">
		<xsl:param name="id"/>
		<xsl:param name="option"/>
		<xsl:if test="$admin = 'Y'">
	    	<button dojoType="dijit.form.Button" type="submit">
	         <xsl:attribute name="onclick">misys.editHelpData('<xsl:value-of select="$option"/>', <xsl:value-of select="$id"/>);</xsl:attribute>
              <xsl:attribute name="label"><![CDATA[<img src="]]><xsl:value-of select="$contextPath"/><![CDATA[/content/images/edit.png" alt="edit"/>]]></xsl:attribute>
           	</button> 		
          <div dojoType="dijit.form.DropDownButton">
           <xsl:attribute name="label"><![CDATA[<img src="]]><xsl:value-of select="$contextPath"/><![CDATA[/content/images/delete.png" alt="delete"/>]]></xsl:attribute>
           <span/>
           <div dojoType="dijit.TooltipDialog">
            <xsl:attribute name="execute">misys.deleteHelpData('<xsl:value-of select="$option"/>', <xsl:value-of select="$id"/>,'<xsl:value-of select="$token"/>');</xsl:attribute>
            <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_HELP_DELETE')"/></xsl:attribute>
            <p><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_HELP_NOTICE')"/></p>
            <button dojoType="dijit.form.Button" type="submit"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_HELP_DELETE')"/></button>
           </div>         
          </div>
		</xsl:if>	
	</xsl:template>
	
</xsl:stylesheet>