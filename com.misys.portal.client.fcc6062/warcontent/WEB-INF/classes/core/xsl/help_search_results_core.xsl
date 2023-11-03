<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	exclude-result-prefixes="localization securitycheck">
	
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
  <xsl:param name="main-form-name"/>
  <xsl:param name="productcode"/>
  <xsl:param name="permission"/>
  <xsl:param name="navigation"/>
  <xsl:param name="sectionid"/>
   <xsl:param name="token"/>
	
   <!-- Global Imports. -->
   <xsl:include href="common/help_common.xsl" />	
   
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />   
	
	<xsl:template match="/">
		<div id="onlineHelpNav">
		<xsl:value-of select="$navigation" disable-output-escaping="yes"/>
		</div>
		<div class="widgetContainer">
		<xsl:call-template name="help-search"/>
		</div>
		<div id="searchsummary"><span class="emphasize"><xsl:value-of select="count(search_results/search_result/url[.!=''])"/></span>
		<xsl:text> </xsl:text>
		<xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCHRESULTS_NBRESULTS')"/>
		<xsl:text> </xsl:text><span class="emphasize"><xsl:value-of select="$search"/></span>
		</div>
		<div id="searchresults">
		<xsl:apply-templates select="search_results"/>
		</div>
	   <!-- Javascript imports  -->
	   <xsl:call-template name="js-imports"/>		
	</xsl:template>
	
		
	<xsl:template match="search_results">
		<xsl:choose>
		<xsl:when test="count(search_result/url[.!='']) = 0">
		<xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCHRESULTS_NOMATCHMSG')"/>
		</xsl:when>
		<xsl:otherwise>
		<ol>
		<xsl:apply-templates select="search_result"/>
		</ol>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="search_result">
		<!-- Empty URL means generally that the user has not access
		to the resource (no permission) -->
		<xsl:if test="url[. !='']">
		<li><xsl:value-of select="url" disable-output-escaping="yes"/>
		<xsl:apply-templates select="data"/>
		</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="data">
		<br/><xsl:value-of select="." disable-output-escaping="yes"/>
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
</xsl:stylesheet>