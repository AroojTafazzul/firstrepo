<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process ACCOUNT-->
	<xsl:template match="account_management">
		<result>
			<com.misys.portal.cash.product.ab.common.BillPayee>
			
			<brch_code><xsl:value-of select="brch_code"/></brch_code>
			<company_id><xsl:value-of select="company_id"/></company_id>
			<entity><xsl:value-of select="entity"/></entity>
						
			<xsl:if test="account_id">
				<account_id>
					<xsl:value-of select="account_id"/>
				</account_id>
			</xsl:if>
			
			<xsl:if test="description">
				<description>
					<xsl:value-of select="description"/>
				</description>
			</xsl:if>
			
			<xsl:if test="actv_flag">
				<actv_flag>
					<xsl:value-of select="actv_flag"/>
				</actv_flag>
			</xsl:if>
			
			<xsl:if test="client_reference">
				<client_reference>
					<xsl:value-of select="client_reference"/>
				</client_reference>
			</xsl:if>
			
		
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.ab.common.BillPayee>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
