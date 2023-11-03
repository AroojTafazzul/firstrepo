<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="ack_status" />
	<xsl:param name="ack_error" />
	
	<xsl:variable name="status">
		<xsl:choose>
			<xsl:when test="$ack_status = '0000000'">ACK</xsl:when>
			<xsl:otherwise>NACK</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="error">
		<xsl:choose>
			<xsl:when test="$ack_error !=''"><xsl:value-of select="$ack_error"/></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="exchange_rate_record">
		<root>
				<exchange_rate_ack_record>
				<xsl:if test="bank_abbv_name">
					<bank_abbv_name>
						<xsl:value-of select="bank_abbv_name" />
					</bank_abbv_name>
				</xsl:if>
				<xsl:if test="iso_code">
					<iso_code>
						<xsl:value-of select="iso_code" />
					</iso_code>
				</xsl:if>
				<xsl:if test="base_iso_code">
					<base_iso_code>
						<xsl:value-of select="base_iso_code" />
					</base_iso_code>
				</xsl:if>
				<xsl:if test="buy_tt_rate">
					<buy_tt_rate><xsl:value-of select="buy_tt_rate" /></buy_tt_rate>
				</xsl:if>
				<xsl:if test="mid_tt_rate">
					<mid_tt_rate><xsl:value-of select="mid_tt_rate" /></mid_tt_rate>
				</xsl:if>
				<xsl:if test="sell_tt_rate">
					<sell_tt_rate><xsl:value-of select="sell_tt_rate" /></sell_tt_rate>
				</xsl:if>
				<xsl:if test="start_value_date">
					<start_value_date><xsl:value-of select="start_value_date"/></start_value_date>
				</xsl:if>
				<StatusCode><xsl:value-of select="$status"/></StatusCode>
				<xsl:if test="$ack_error !=''">
				<error><xsl:value-of select="$error"/></error>
				</xsl:if>
			</exchange_rate_ack_record>
		</root>	
	</xsl:template>
</xsl:stylesheet>