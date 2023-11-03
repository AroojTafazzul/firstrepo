<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2008 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Help section-->
	<xsl:template match="help_text">
		<result>
			<com.misys.portal.help.common.GTPHelpText>
				<!-- keys must be attributes -->
				<xsl:attribute name="text_id"><xsl:value-of select="text_id"/></xsl:attribute>
       			 <content>
					<xsl:value-of select="content"/>
				</content>
				<parent_id>
					<xsl:value-of select="parent_id"/>
				</parent_id>	
				<savetype>
					<xsl:value-of select="savetype"/>
				</savetype>
				<language>
					<xsl:value-of select="language"/>
				</language>		
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.help.common.GTPHelpText>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
