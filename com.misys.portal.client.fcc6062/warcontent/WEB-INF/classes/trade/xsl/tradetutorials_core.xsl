<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="contextPath"/>
 	<xsl:param name="servletPath"/>
	
	<xsl:template match="/root">
		<div style="display:none;">
			<a target="_blank">
				<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
				<img alt="image">
					<xsl:attribute name="src"><xsl:value-of select="concat($contextPath, image)"/></xsl:attribute>
				</img>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>