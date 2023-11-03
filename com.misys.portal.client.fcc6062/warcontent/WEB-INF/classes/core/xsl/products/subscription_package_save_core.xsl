<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2011 Misys , All Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process ACCOUNT -->
	<xsl:template match="subscription_package">
		<result>
			<com.misys.portal.systemfeatures.common.SubscriptionPackage>
				<!-- keys must be attributes -->
				<xsl:attribute name="package_id"><xsl:value-of select="package_id" /></xsl:attribute>
				<subscription_code>
					<xsl:value-of select="subscription_code" />
				</subscription_code>
				<subscription_description>
					<xsl:value-of select="subscription_description" />
				</subscription_description>
				<xsl:if test="charging_cur_code">
					<charging_currency>
						<xsl:value-of select="charging_cur_code"/>
					</charging_currency>
				</xsl:if>
				<xsl:if test="charging_amt">
					<standard_charge>
						<xsl:value-of select="charging_amt"/>
					</standard_charge>
				</xsl:if>
				<local_tax>
					<xsl:value-of select="local_tax" />
				</local_tax>
				<creation_date>
					<xsl:value-of select="creation_date" />
				</creation_date>
				<last_maintenance_date>
					<xsl:value-of select="last_maintenance_date" />
				</last_maintenance_date>
				<last_maintenance_user>
					<xsl:value-of select="last_maintenance_user" />
				</last_maintenance_user>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.common.SubscriptionPackage>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
