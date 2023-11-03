<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2011 Misys , All Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process customer payee -->
	<xsl:template match="trust_realtionship_record">
		<result>
			<com.misys.portal.common.trustrelationship.TrustRealtionshipTnx>
				<!-- keys must be attributes -->
				<xsl:attribute name="trust_relationship_id"><xsl:value-of select="trust_relationship_id" /></xsl:attribute>
				<from_bank>
					<xsl:value-of select="from_bank" />
				</from_bank>
				<from_bank_id>
					<xsl:value-of select="from_bank_id_hidden" />
				</from_bank_id>
				<from_company>
					<xsl:value-of select="from_company" />
				</from_company>
				<from_company_id>
					<xsl:value-of select="from_company_id_hidden" />
				</from_company_id>
				<to_bank>
					<xsl:value-of select="to_bank" />
				</to_bank>
				<to_bank_id>
					<xsl:value-of select="to_bank_id_hidden" />
				</to_bank_id>
				<to_company>
					<xsl:value-of select="to_company" />
				</to_company>
				<to_company_id>
					<xsl:value-of select="to_company_id_hidden" />
				</to_company_id>
				<direction>
					<xsl:value-of select="trust_direction_status" />
				</direction>
				<status>
					<xsl:value-of select="trust_relationship_status" />
				</status>
				<return_comments>
					<xsl:value-of select="return_comments" />
				</return_comments>
			  
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.common.trustrelationship.TrustRealtionshipTnx>
			</result>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>

