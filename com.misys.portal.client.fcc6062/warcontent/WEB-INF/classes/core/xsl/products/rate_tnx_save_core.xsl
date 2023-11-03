<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!--xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template-->
	<!-- Process RATE-->
	<!-- All rates are equal to mid_tt_rate -->
	<xsl:template match="static_rate">
		<result>
			<com.misys.portal.common.currency.RateTnx>
				<xsl:attribute name="iso_code">
					<xsl:value-of select="iso_code"/>
				</xsl:attribute>
				<xsl:attribute name="base_iso_code">
					<xsl:value-of select="base_iso_code"/>
				</xsl:attribute>
				<bank_abbv_name><xsl:value-of select="bank_abbv_name"/></bank_abbv_name>
				<paty_val>
					<xsl:value-of select="paty_val"/>
				</paty_val>
				<buy_tt_rate>
					<xsl:value-of select="buy_tt_rate"/>
					<!-- <xsl:value-of select="mid_tt_rate"/> -->
				</buy_tt_rate>
				<mid_tt_rate>
					<xsl:value-of select="mid_tt_rate"/>
				</mid_tt_rate>
				<sell_tt_rate>
					<xsl:value-of select="sell_tt_rate"/>
					<!-- <xsl:value-of select="mid_tt_rate"/> -->
				</sell_tt_rate>
				<return_comments>
					<xsl:value-of select="return_comments" />
				</return_comments>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.common.currency.RateTnx>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
