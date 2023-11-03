<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:param name="ack_status"/>
	<xsl:param name="ack_error"/>
	
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

	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="fx_tnx_record">
		<root>
			<fx_ack_record>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<StatusCode><xsl:value-of select="$status"/></StatusCode>
				<applicant_reference><xsl:value-of select="applicant_reference"/></applicant_reference>
				<error><xsl:value-of select="$error"/></error>
			</fx_ack_record>
		</root>	
	</xsl:template>
</xsl:stylesheet>