<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com), All 
		Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process ACCOUNT -->
	<xsl:template match="customer_entity_token">
		<result>
			<com.misys.portal.common.security.token.SecurityTokenTnxImpl>
			
				<brch_code>
					<xsl:value-of select="brch_code" />
				</brch_code>
				<company_id>
					<xsl:value-of select="company_id" />
				</company_id>
				<entity>
					<xsl:value-of select="entity_abbv_name" />
				</entity>
				<xsl:if test="serial_no">
				<serial_no>
					<xsl:value-of select="serial_no" />
				</serial_no>
				</xsl:if>
				<xsl:if test="type">
				<type>
					<xsl:value-of select="type" />
				</type>
				</xsl:if>
				<xsl:if test="charge_type">
				 <charge_type>
					<xsl:value-of select="charge_type" />
				 </charge_type>
				</xsl:if>
				<xsl:if test="remarks">
				 <remarks>
					<xsl:value-of select="remarks" />
				 </remarks>
				</xsl:if>
				
				<xsl:if test="bank_name">
				<bank_name>
					<xsl:value-of select="bank_name" />
				</bank_name>
				</xsl:if>
				<xsl:if test="to_generate">
				 <to_generate>
					<xsl:value-of select="to_generate" />
				 </to_generate>
				</xsl:if>
				<xsl:if test="to_waive">
				 <to_waive>
					<xsl:value-of select="to_waive" />
				 </to_waive>
				</xsl:if>
				<xsl:if test="return_comments">
					<return_comments>
						<xsl:value-of select="return_comments"/>
					</return_comments>
				</xsl:if>
			</com.misys.portal.common.security.token.SecurityTokenTnxImpl>
		</result>
	</xsl:template>
</xsl:stylesheet>
