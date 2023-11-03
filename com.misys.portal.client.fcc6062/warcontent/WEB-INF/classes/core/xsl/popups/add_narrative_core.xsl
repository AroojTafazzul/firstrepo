<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Form, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2018 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      09/05/18
author:    ajithkumar balakrishnan
email:     ajithkumar.balakrishnan@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  	version="1.0" 
  	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization defaultresource">
   
  <xsl:param name="rundata"/>
  <xsl:param name="formLoad">false</xsl:param>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="node"/>
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 
  <xsl:include href="../common/trade_common.xsl" />
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/form_templates.xsl" />
  <xsl:template match="/">
  	
    <xsl:apply-templates select="message"/>
  </xsl:template>
  
  <xsl:template match="message">
	<div id = "LeftDiv" style = "width:99%; height: 522px; overflow:auto;">
		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		<xsl:if test = "//message/issuance"><xsl:apply-templates select="issuance"/></xsl:if>
		<xsl:if test = "//message/amendments"><xsl:apply-templates select="amendments"/></xsl:if>
	</div>
  </xsl:template>

  <xsl:template match="issuance">
	<div>
	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVE_SUB_ISSUANCE</xsl:with-param>
	    <xsl:with-param name="button-type">extended-preview-issuance</xsl:with-param>
	    <xsl:with-param name="messageValue">&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;<xsl:value-of select="//data/datum/text"/></xsl:with-param>
	    <xsl:with-param name="content">
	    <xsl:call-template name="fieldset-wrapper">
	    	<xsl:with-param name="legend">XSL_NARRATIVE_SUB_ISSUANCE</xsl:with-param>
		    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		    <xsl:with-param name="content">
    		<xsl:choose>
				<xsl:when test="data/datum/text != ''">
				    <p style="white-space: pre-wrap;">
				    <xsl:value-of select="convertTools:displaySwiftNarrative(data/datum/text, 6)" />
				    </p></xsl:when>
				<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ISSUANCE_DATA')"/></xsl:otherwise>
			</xsl:choose>
		    </xsl:with-param>
	    </xsl:call-template>
	    </xsl:with-param>
    </xsl:call-template>	
	</div>
	</xsl:template>
	
	<xsl:template match="amendments">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_NARRATIVE_SUB_AMENDMENT</xsl:with-param>
			<xsl:with-param name="button-type">extended-preview-amendments</xsl:with-param>
			<xsl:with-param name="messageValue">
			<xsl:for-each select="amendment">
				&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
				<xsl:for-each select="data/datum">
					<xsl:if test="verb != ''">
						&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
					</xsl:if>
					<xsl:if test="text != ''">
					<p style="white-space: pre-wrap;">
					<xsl:value-of select="text" />&lt;br&gt;
					</p>
					</xsl:if>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:for-each>
			</xsl:with-param>
			<xsl:with-param name="content">
				<table>
					<xsl:for-each select="amendment">
						<tr>
							<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="localized">N</xsl:with-param>
							<xsl:with-param name="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/></xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:for-each select="data/datum">
									<xsl:if test="verb != ''">
										<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
										<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
										<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>
									</xsl:if>
									<xsl:if test="text != ''">
									<p style="white-space: pre-wrap;">
									<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" /><br/>
									</p>
									</xsl:if>
								</xsl:for-each>
							</xsl:with-param>
							</xsl:call-template>	
						</tr>					
					</xsl:for-each>
				</table>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
  
  <xsl:template name="common-js-imports">
  <!-- Required Parameters -->
  <xsl:param name="binding"/>
   
  <!-- HTML -->
  <!-- Message for js-disabled users. -->
 
  
  <script>
   dojo.ready(function(){
  		misys._config = misys._config || {};
    	
   		<xsl:if test="$binding != ''"> <!-- and ($displaymode = 'edit' or ($displaymode = 'view' and $mode = 'UNSIGNED'))"-->
    		dojo.require("<xsl:value-of select="$binding"/>");
   		</xsl:if>
   });
  </script>
 </xsl:template>
  

</xsl:stylesheet>