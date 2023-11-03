<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="ack_error" />
	
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="interface_error_event">
		<xsl:variable name="error">
			<xsl:choose>
				<xsl:when test="$ack_error !=''"><xsl:value-of select="$ack_error"/></xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="varTrigger"><xsl:value-of select="trigger"/></xsl:variable>
		<root>
			<exchange_rate_ack_record>
				<StatusCode>NACK</StatusCode>
				<xsl:if test="$ack_error!=''">
				<error><xsl:value-of select="$error" disable-output-escaping="yes"/></error>
				</xsl:if>
				<xsl:if test="trigger">
					<org_exchange_rate_record>
					<xsl:value-of select="concat('&lt;![CDATA[' , $varTrigger,' ]>')" disable-output-escaping="yes"/>
					</org_exchange_rate_record>
				</xsl:if>
			</exchange_rate_ack_record>
		</root>	
	</xsl:template>
</xsl:stylesheet>