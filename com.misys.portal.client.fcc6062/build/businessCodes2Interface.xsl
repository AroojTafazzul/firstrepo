<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   		Copyright (c) 2000-2007 Misys (http://www.misys.com),
  		 All Rights Reserved. 
	-->
	<xsl:param name="Business_specific_file"/>
	<xsl:output method="html"/>

	<!-- Match template -->
	<xsl:template match="business_codes">	
	<xsl:variable name="specific" select="document($Business_specific_file)"/>
		/**
		* This interface is auto generated
		* DO NOT WRITE IN THIS FILE
		**/
		package com.misys.portal.common.resources;
		public interface BusinessCodes {
 
			<xsl:apply-templates select="business_code"/>
			
			/*****************/
    		/* SPECIFIC KEYS */
    		/*****************/
    		<xsl:apply-templates select="$specific/business_codes/business_code" mode="specific"/>
    		
			}
	</xsl:template>
	
	
	<xsl:template match="business_code">
		// <xsl:value-of select="normalize-space(description)"/>
		<xsl:apply-templates select="values/value[name!='']"/>
	</xsl:template>
	

	<xsl:template match="value">
		static final String <xsl:value-of select="normalize-space(../../key)"/>_<xsl:value-of select="normalize-space(name)"/> ="<xsl:value-of select="normalize-space(code)"/>";
	</xsl:template>

	<xsl:template match="business_code" mode ="specific">
		// <xsl:value-of select="normalize-space(description)"/>
		<xsl:apply-templates select="values/value[name!='']" mode ="specific"/>
	</xsl:template>
	
	<xsl:template match="value" mode ="specific">
		static final String <xsl:value-of select="normalize-space(../../key)"/>_<xsl:value-of select="normalize-space(name)"/> ="<xsl:value-of select="normalize-space(code)"/>";
	</xsl:template>
	
</xsl:stylesheet>
