<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process PHRASE-->
	<xsl:template match="phrase">
		<result>
			<com.misys.portal.systemfeatures.common.Phrase>
				<xsl:attribute name="phrase_id">
					<xsl:value-of select="phrase_id"/>
				</xsl:attribute>

				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
       			 <entity>
					<xsl:value-of select="entity"/>
				</entity>
				<abbv_name>
					<xsl:value-of select="abbv_name"/>
				</abbv_name>
				<description>
					<xsl:value-of select="description"/>
				</description>
				<text>
					<xsl:choose>
						<xsl:when test="phrase_type[.!= '02']">
							<xsl:value-of select="static_text"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="dynamic_text"/>
						</xsl:otherwise>
					</xsl:choose>
				</text>
				<product_code>
					<xsl:value-of select="product_code"/>
				</product_code>
				<category>
					<xsl:value-of select="category"/>
				</category>
				<phrase_type>
					<xsl:value-of select="phrase_type"/>
				</phrase_type>
				<xsl>
					<xsl:value-of select="xsl"/>
				</xsl>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.common.Phrase>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
