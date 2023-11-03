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
	<xsl:template match="help_section">
		<result>
			<com.misys.portal.help.common.GTPHelpSection>
				<!-- keys must be attributes -->
				<xsl:attribute name="section_id"><xsl:value-of select="section_id"/></xsl:attribute>
       			 <title>
					<xsl:value-of select="title"/>
				</title>
				<parent_id>
					<xsl:value-of select="parent_id"/>
				</parent_id>
				<permission>
					<xsl:value-of select="permission"/>
				</permission>
				<access_key>
					<xsl:value-of select="access_key"/>
				</access_key>
				<display_order>
					<xsl:value-of select="display_order"/>				
				</display_order>
				<language>
					<xsl:value-of select="language"/>				
				</language>	
				<save_type>
					<xsl:value-of select="save_type"/>
				</save_type>				
				<content>
					<xsl:value-of select="content"/>
				</content>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.help.common.GTPHelpSection>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
