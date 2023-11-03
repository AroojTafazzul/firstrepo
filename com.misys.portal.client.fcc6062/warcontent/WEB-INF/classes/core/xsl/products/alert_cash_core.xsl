<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
							  xmlns:tools="xalan://com.misys.portal.common.tools.ConvertTools"
							  exclude-result-prefixes="tools">							  
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:param name="parm_id"/>

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Alerts -->
	<xsl:template match="alert_records">
		<xsl:for-each select="//alerts01/alert01">
			<xsl:call-template name="build_alert">
				<xsl:with-param name="companyid"><xsl:value-of select="//company_id"/></xsl:with-param>
				<xsl:with-param name="abbvname"><xsl:value-of select="//abbv_name"/></xsl:with-param>
				<xsl:with-param name="alerttype">01</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="//alerts02/alert02">
			<xsl:call-template name="build_alert">
				<xsl:with-param name="companyid"><xsl:value-of select="//company_id"/></xsl:with-param>
				<xsl:with-param name="abbvname"><xsl:value-of select="//abbv_name"/></xsl:with-param>
				<xsl:with-param name="alerttype">02</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="//alerts03/alert03">
			<xsl:call-template name="build_alert">
				<xsl:with-param name="companyid"><xsl:value-of select="//company_id"/></xsl:with-param>
				<xsl:with-param name="abbvname"><xsl:value-of select="//abbv_name"/></xsl:with-param>
				<xsl:with-param name="alerttype">03</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	
	
	<xsl:template name="build_alert">
		<xsl:param name="companyid"/>
		<xsl:param name="abbvname"/>
		<xsl:param name="alerttype"/>
		<xsl:param name="language">en</xsl:param>
		
		<parameter_data>
			<xsl:element name="parm_id">
				<xsl:value-of select="$parm_id"/>
			</xsl:element>
			<xsl:element name="company_id">
				<xsl:value-of select="$companyid"/>
			</xsl:element>
			<key_1>
				<xsl:value-of select="$alerttype"/>
			</key_1>
			<key_3>
				<xsl:choose>
	   				<xsl:when test="tnx_type_code!=''">
	   					<xsl:value-of select="tnx_type_code"/>
	   				</xsl:when>
	   				<xsl:when test="date_code!=''">
	   					<xsl:value-of select="date_code"/>
	   				</xsl:when>
	   				<xsl:otherwise>*</xsl:otherwise>
				</xsl:choose>
			</key_3>
			<xsl:if test="bank_abbv_name != ''">
				<key_4>
					<xsl:value-of select="bank_abbv_name"/>
				</key_4>
			</xsl:if>
			<xsl:if test="alertlanguage != ''">
				<key_5>
					<xsl:value-of select="alertlanguage"/>
				</key_5>
			</xsl:if>
			<xsl:if test="entity != ''">
				<key_6>
					<xsl:value-of select="entity"/>
				</key_6>
			</xsl:if>
			<xsl:if test="$abbvname != ''">
				<key_7>
					<xsl:value-of select="$abbvname"/>
				</key_7>
			</xsl:if>
			<xsl:if test="address != ''">
				<key_8>
					<xsl:value-of select="address"/>
				</key_8>
			</xsl:if>
			<xsl:if test="customer_abbv_name != ''">
				<key_9>
					<xsl:value-of select="customer_abbv_name"/>
				</key_9>
			</xsl:if>
			<xsl:if test="account_num != ''">
				<key_10>
					<xsl:value-of select="account_num"/>
				</key_10>
			</xsl:if>
			<xsl:if test="threshold_cur != ''">
				<key_11>
					<xsl:value-of select="threshold_cur"/>
				</key_11>
			</xsl:if>
			<xsl:if test="threshold_amt != ''">
				<key_12>
					<xsl:value-of select="tools:getDefaultBigDecimalRepresentation(threshold_amt, $language)" />
				</key_12>
			</xsl:if>
			<xsl:if test="threshold_sign != ''">
				<key_13>
					<xsl:value-of select="threshold_sign"/>
				</key_13>
			</xsl:if>
			
			<xsl:if test="credit_amt != ''">
				<key_15>
					<xsl:value-of select="credit_amt"/>
				</key_15>
			</xsl:if>
			<xsl:if test="credit_cur != ''">
				<key_14>
					<xsl:value-of select="credit_cur"/>
				</key_14>
			</xsl:if>
			<xsl:if test="debit_cur != ''">
				<key_16>
					<xsl:value-of select="debit_cur"/>
				</key_16>
			</xsl:if>
			<xsl:if test="debit_amt != ''">
				<key_17>
					<xsl:value-of select="debit_amt"/>
				</key_17>
			</xsl:if>
			
			<data_1>
				<xsl:if test="account_num != ''">
					<key_10>
						<xsl:value-of select="account_num"/>
					</key_10>
				</xsl:if>
			</data_1>
		</parameter_data>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>


