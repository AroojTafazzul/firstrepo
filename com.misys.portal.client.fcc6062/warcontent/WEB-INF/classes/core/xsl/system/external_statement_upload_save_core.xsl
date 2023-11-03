<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="statement_upload">
		<result>
		<com.misys.portal.systemfeatures.common.ExternalAccountStatementUpload>
		<!-- keys must be attributes -->
				<xsl:attribute name="statement_upload_id"><xsl:value-of select="statement_upload_id" /></xsl:attribute>				
				<customer_abbv_name>
				    <xsl:value-of select="customer_abbv_name" />
				</customer_abbv_name>	
				<bank_id>
				   <xsl:value-of select="bank_id" />
				</bank_id>
				<bank_abbv_name>
				   <xsl:value-of select="bank_abbv_name" />
				</bank_abbv_name>
				<description>
					<xsl:value-of select="description" />
				</description>
				<status>
				    <xsl:value-of select="status" />
				</status>				
				<creation_date>
				    <xsl:value-of select="creation_date" />
				</creation_date>
				<last_maintenance_date>
				    <xsl:value-of select="last_maintenance_date" />
				</last_maintenance_date>
				<created_user>
				    <xsl:value-of select="created_user" />
				</created_user>
				<attachment_id>
				    <xsl:value-of select="attachments-OTHER/attachment/attachment_id" />
				</attachment_id>
				<error_details>
				    <xsl:value-of select="error_details" />
				</error_details>
				<last_maintenance_user>
				    <xsl:value-of select="last_maintenance_user" />
				</last_maintenance_user>	
		</com.misys.portal.systemfeatures.common.ExternalAccountStatementUpload>	
		</result>
	</xsl:template>
</xsl:stylesheet>