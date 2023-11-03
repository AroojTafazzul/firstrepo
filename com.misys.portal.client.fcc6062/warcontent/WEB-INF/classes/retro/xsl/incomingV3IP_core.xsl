<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="in_tnx_record">
		<xsl:copy>
			<xsl:apply-templates select="*" mode="copy_element"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>