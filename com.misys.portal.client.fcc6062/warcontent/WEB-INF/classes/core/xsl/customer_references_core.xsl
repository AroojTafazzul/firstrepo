<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Customer References -->
	<xsl:template match="customer_references">
		<result>
			<xsl:for-each select="customer_reference">
				<com.misys.portal.product.util.CustomerReference>
					<xsl:if test="customer_abbv_name">
						<customer_abbv_name>
							<xsl:value-of select="customer_abbv_name"/>
						</customer_abbv_name>
					</xsl:if>
					<xsl:if test="customer_id">
						<customer_id>
							<xsl:value-of select="customer_id"/>
						</customer_id>
					</xsl:if>
					<xsl:if test="bank_abbv_name">
						<bank_abbv_name>
							<xsl:value-of select="bank_abbv_name"/>
						</bank_abbv_name>
					</xsl:if>
					<xsl:if test="bank_id">
						<bank_id>
							<xsl:value-of select="bank_id"/>
						</bank_id>
					</xsl:if>
					<xsl:if test="reference">
						<reference>
							<xsl:value-of select="reference"/>
						</reference>
					</xsl:if>
					<xsl:if test="description">
						<description>
							<xsl:value-of select="description"/>
						</description>
					</xsl:if>
					<xsl:if test="back_office_1">
						<back_office_1>
							<xsl:value-of select="back_office_1"/>
						</back_office_1>
					</xsl:if>
					<xsl:if test="back_office_2">
						<back_office_2>
							<xsl:value-of select="back_office_2"/>
						</back_office_2>
					</xsl:if>
					<xsl:if test="back_office_3">
						<back_office_3>
							<xsl:value-of select="back_office_3"/>
						</back_office_3>
					</xsl:if>
					<xsl:if test="back_office_4">
						<back_office_4>
							<xsl:value-of select="back_office_4"/>
						</back_office_4>
					</xsl:if>
					<xsl:if test="back_office_5">
						<back_office_5>
							<xsl:value-of select="back_office_5"/>
						</back_office_5>
					</xsl:if>
					<xsl:if test="back_office_6">
						<back_office_6>
							<xsl:value-of select="back_office_6"/>
						</back_office_6>
					</xsl:if>
					<xsl:if test="back_office_7">
						<back_office_7>
							<xsl:value-of select="back_office_7"/>
						</back_office_7>
					</xsl:if>
					<xsl:if test="back_office_8">
						<back_office_8>
							<xsl:value-of select="back_office_8"/>
						</back_office_8>
					</xsl:if>
					<xsl:if test="back_office_9">
						<back_office_9>
							<xsl:value-of select="back_office_9"/>
						</back_office_9>
					</xsl:if>
					<xsl:if test="default_reference">
						<default_reference>
							<xsl:value-of select="default_reference"/>
						</default_reference>
					</xsl:if>
					<xsl:if test="syncflag">
						<additional_field name="syncflag" type="string"
							scope="master">
							<xsl:value-of select="syncflag" />
						</additional_field>
					</xsl:if>
					<xsl:if test="liquidityenabledflag">
						<additional_field name="liquidityenabledflag" type="string"
							scope="master">
							<xsl:value-of select="liquidityenabledflag" />
						</additional_field>
					</xsl:if>
				</com.misys.portal.product.util.CustomerReference>
			</xsl:for-each>
		</result>
	</xsl:template>
</xsl:stylesheet>
