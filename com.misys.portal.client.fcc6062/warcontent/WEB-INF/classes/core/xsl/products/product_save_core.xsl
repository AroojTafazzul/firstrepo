<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2003 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process PRODUCT-->
	<xsl:template match="static_product">
		<result>
			<com.misys.portal.systemfeatures.common.StaticProduct>
				<xsl:attribute name="product_id">
					<xsl:value-of select="product_id"/>
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
				<code>
					<xsl:value-of select="code"/>
				</code>
				<description>
					<xsl:value-of select="description"/>
				</description>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.common.StaticProduct>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
