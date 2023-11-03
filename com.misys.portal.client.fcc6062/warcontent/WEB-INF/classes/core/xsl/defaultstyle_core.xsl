<?xml version="1.0" encoding="UTF-8" ?>

<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
	Originally Written by Stefano Mazzocchi "stefano@apache.org"
	This product includes software developed by the Java Apache Project
   (http://java.apache.org/)."
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="portlets">
  <table align="center" cellpadding="0" cellspacing="0">
	<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
  	<tr>
	  	<td width="50%" valign="top">
  			<xsl:apply-templates select="portlet[position() mod 2 = 1]"/>
	  	</td>
	  	<td width="5"></td>
	  	<td width="50%" valign="top">
	  		<xsl:apply-templates select="portlet[position() mod 2 = 0]"/> 
	  	</td>
  	</tr>
  </table>
  </xsl:template>

  <xsl:template match="portlet">
	<table cellspacing="0" cellpadding="0">
		<xsl:attribute name="width"><xsl:value-of select="skin/width"/></xsl:attribute>
		<tr><td width="100%">
				<xsl:attribute name="bgcolor"><xsl:value-of select="./skin/color"/></xsl:attribute>
		<table width="100%" cellpadding="0" cellspacing="0">
		<tr height="30">
			<td height="30" width="90%">
				<font>
					<xsl:attribute name="color"><xsl:value-of select="./skin/titlecolor"/></xsl:attribute>
					<xsl:value-of select=".//title"/>
				</font>
			</td>
			<td height="30" width="10%" align="center"><b>Edit</b></td>
		</tr>
		</table>
		</td></tr>
		<tr>
			<td valign="top">
				<xsl:attribute name="bgcolor"><xsl:value-of select="skin/backgroundcolor"/></xsl:attribute>
			<xsl:apply-templates/>
			</td>
		</tr>
	</table>
	<table cellspacing="0" cellpadding="0">
		<xsl:attribute name="width"><xsl:value-of select="skin/width"/></xsl:attribute>
		<tr height="10"><td height="10"></td></tr>
	</table>

  </xsl:template>

  <xsl:template match="channel">
	<xsl:apply-templates select="image"/>
	<xsl:if test="item">
	<ul>
		<xsl:apply-templates select="item"/>
	</ul>
	</xsl:if>
  </xsl:template>

  <xsl:template match="item">
	<li>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
			<xsl:value-of select="title"/>
		</a>
	</li>
  </xsl:template>

  <xsl:template match="image">
	<a>
		<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
		<img align="right" vspace="5" hspace="5" border="0">
			<xsl:attribute name="src"><xsl:value-of select="url"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="title"/></xsl:attribute>
		</img>
	</a>
  </xsl:template>

  <!-- remove all skin elements, they should not be displayed -->
  <xsl:template match="skin">
  </xsl:template>

  <!-- copy all unknown elements, they may be pre-formatted text -->
  <xsl:template match="*|@*|text()">
	<xsl:copy>
		<xsl:apply-templates/>
	</xsl:copy>
  </xsl:template>

</xsl:stylesheet>
