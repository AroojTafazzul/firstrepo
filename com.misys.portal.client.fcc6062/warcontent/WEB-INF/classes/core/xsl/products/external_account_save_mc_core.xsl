<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com), All 
		Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process ACCOUNT -->
	<xsl:template match="external-account">
		<result>
			<com.misys.portal.cash.product.ab.common.AccountTnx>
			
				<brch_code>
					<xsl:value-of select="brch_code" />
				</brch_code>
			
				<cur_code>
					<xsl:value-of select="account_cur_code" />	
				</cur_code>
				<xsl:if test="account_no">
				<account_no>
					<xsl:value-of select="account_no" />
				</account_no>
				</xsl:if>
				<xsl:if test="alternative_acct_no">
				<alternative_acct_no>
					<xsl:value-of select="alternative_acct_no" />
				</alternative_acct_no>
				</xsl:if>
				<xsl:if test="description">
				<description>
					<xsl:value-of select="description" />
				</description>
				</xsl:if>
				<xsl:if test="bank_iso_code">
				 <iso_code>
					<xsl:value-of select="bank_iso_code" />
				 </iso_code>
				</xsl:if>
				<xsl:if test="actv_flag">
				<actv_flag>
			   <xsl:value-of select="actv_flag"/>
				</actv_flag>
				</xsl:if>
				<xsl:if test="bank_name">
				<bank_name>
					<xsl:value-of select="bank_name" />
				</bank_name>
				</xsl:if>
				<xsl:if test="account_cur_code">
				<cur_code>
					<xsl:value-of select="account_cur_code" />
				</cur_code>
				</xsl:if>
				<xsl:if test="format">
					<format>
						<xsl:value-of select="format" />
					</format>
				</xsl:if>
				<bank_address_line_1>
					<xsl:value-of select="bank_address_line_1" />
				</bank_address_line_1>
				<bank_address_line_2>
					<xsl:value-of select="bank_address_line_2" />
				</bank_address_line_2>
				<bank_dom>
					<xsl:value-of select="bank_dom" />
				</bank_dom>
				<owner_type>
					<xsl:value-of select="owner_type" />
				</owner_type>
				<account_type>
					<xsl:value-of select="account_type" />
				</account_type>
				<acct_name>
					<xsl:value-of select="acct_name"></xsl:value-of>
				</acct_name>
				<country>
				    <xsl:value-of select="country"></xsl:value-of>
				</country>
				<routing_bic>
				   <xsl:value-of select="routing_bic"></xsl:value-of>
				</routing_bic>
				<xsl:if test="return_comments">
					<return_comments>
						<xsl:value-of select="return_comments"/>
					</return_comments>
				</xsl:if>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.ab.common.AccountTnx>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
