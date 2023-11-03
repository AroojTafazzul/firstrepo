<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
	   All Rights Reserved. 
	-->
	
	<!-- main template -->
	<xsl:template match="upload_template">
		<upload_template>
		
			<brch_code><xsl:value-of select="brch_code"/></brch_code>
			
	  		<upload_template_id><xsl:value-of select="upload_template_id"/></upload_template_id>
	  		
	  		<company_id><xsl:value-of select="company_id"/></company_id>
	  		
	  		<name><xsl:value-of select="name"/></name>
	  		
	  		<description><xsl:value-of select="description"/></description>
			
			<product_code><xsl:value-of select="product_code"/></product_code>
	  		
	  		<executable><xsl:value-of select="executable"/></executable>
	  		
	  		<definition>
		  		
				<xsl:choose>
					<xsl:when test="mapping='delimited'">
						<delimiter type="dynamic">
							<xsl:choose>
								<xsl:when test="delimiter='OTHER'">
									<xsl:value-of select="delimiter_text"/>
								</xsl:when>
								<xsl:otherwise>
								<!-- Hack to deal with the Dijit FilteringSelect not handling properly comma character value --> 
								<xsl:call-template name="convert-delimiter-value">
									<xsl:with-param name="value" select="delimiter"/>
								</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</delimiter>
					</xsl:when>
					<xsl:otherwise>
						<delimiter type="fixed"/>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:apply-templates select="column"/>
				
			</definition>
		
		</upload_template>
	</xsl:template>
   
	<!-- column template -->
	<xsl:template match="column">
		<column>
			<name><xsl:value-of select="."/></name>
			<xsl:variable name="name"><xsl:value-of select="."/></xsl:variable>
			<type><xsl:value-of select="//*[name()=concat($name, '_type')]"/></type>
			<key><xsl:value-of select="//*[name()=concat($name, '_key')]"/></key>
			<xsl:if test="../mapping='fixed'">
				<start><xsl:value-of select="//*[name()=concat($name, '_start')]"/></start>
				<length><xsl:value-of select="//*[name()=concat($name, '_length')]"/></length>
			</xsl:if>
			<format>
				<xsl:variable name="format"><xsl:value-of select="//*[name()=concat($name, '_format')]"/></xsl:variable>
				<xsl:choose>
					<xsl:when test="$format = 'OTHER'">
						<xsl:value-of select="//*[name()=concat($name, '_format_text')]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="//*[name()=concat($name, '_format')]"/>
					</xsl:otherwise>
				</xsl:choose>
			</format>
		</column>
	</xsl:template>

	<xsl:template name="convert-delimiter-value">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="$value = 'comma'">,</xsl:when>
			<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>