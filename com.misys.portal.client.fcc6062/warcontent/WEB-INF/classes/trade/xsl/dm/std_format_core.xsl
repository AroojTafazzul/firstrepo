<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cmp="http://www.bolero.net" 
		xmlns:gtp="http://www.neomalogic.com">

		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

<xsl:output method="xml" indent="no"/>
<xsl:strip-space elements="*"/>
<xsl:template match="/">
  <xsl:copy-of select="."/>
</xsl:template>
</xsl:stylesheet>