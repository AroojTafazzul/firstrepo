<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2011 Misys , All Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process Trust Relationship -->
	<xsl:template match="trust_relationship_user_record">
		<result>
			<com.misys.portal.common.trustrelationship.TrustRealtionshipUserTnx>
				<!-- keys must be attributes -->
				<xsl:attribute name="trust_relation_user_id"><xsl:value-of select="trust_relation_user_id" /></xsl:attribute>
				<from_company_id>
					<xsl:value-of select="from_company_id_hidden" />
				</from_company_id>
				<from_user>
					<xsl:value-of select="from_user" />
				</from_user>
				<from_user_id>
					<xsl:value-of select="from_user_id_hidden" />
				</from_user_id>
				<to_company_id>
					<xsl:value-of select="to_company_id_hidden" />
				</to_company_id>
				<to_user>
					<xsl:value-of select="to_user" />
				</to_user>
				<to_user_id>
					<xsl:value-of select="to_user_id_hidden" />
				</to_user_id>
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
     </com.misys.portal.common.trustrelationship.TrustRealtionshipUserTnx>
			</result>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>

