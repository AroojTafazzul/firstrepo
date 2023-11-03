<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
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
			<xsl:if test="prod_code != ''">
				<key_2>
					<xsl:value-of select="prod_code"/>
				</key_2>
			</xsl:if>
			
			<xsl:choose>
   				<xsl:when test="tnx_type_code!=''">
	   				<key_3>
	   					<xsl:value-of select="tnx_type_code"/>
	   				</key_3>
   				</xsl:when>
   				<xsl:when test="date_code!=''">
   					<xsl:variable name="date" select="date_code"/>
   					
   					<xsl:choose>
	   					<xsl:when test="contains($date,'@')">
	   						<xsl:variable name="childProduct" select="substring-before($date,'@' )"/>
	   						<xsl:variable name="subChildProduct" select="substring-after($date,'@' )"/>
   							<key_17>
	   							<xsl:choose>
		   							<xsl:when test="contains($subChildProduct, '@')">
			   							<xsl:value-of select="concat($childProduct, '@', substring-before($subChildProduct,'@'))"/>
			   						</xsl:when>
			   						<xsl:otherwise>
			   							<xsl:value-of select="$childProduct"/>
			   						</xsl:otherwise>
		   						</xsl:choose>
	   						</key_17>
		   					<key_3>
		   						<xsl:value-of select="$date"/>
		   					</key_3>
	   					</xsl:when>
	   					<xsl:otherwise>
		   					<key_3>
	   							<xsl:value-of select="date_code"/>
	   						</key_3>
	   					</xsl:otherwise>
   					</xsl:choose>
   				</xsl:when>
   				<xsl:otherwise><key_3>*</key_3></xsl:otherwise>
			</xsl:choose>
			
			<xsl:if test="issuer_abbv_name != ''">
				<key_4>
					<xsl:value-of select="issuer_abbv_name"/>
				</key_4>
			</xsl:if>
			<xsl:if test="alertlanguage != ''">
				<key_5>
					<xsl:value-of select="alertlanguage"/>
				</key_5>
			</xsl:if>
			<key_6>
				<xsl:choose>
					<xsl:when test="entity != ''">
						<xsl:value-of select="entity"/>
					</xsl:when>
					<xsl:otherwise>*</xsl:otherwise>		
				</xsl:choose>
			</key_6>
			<key_7>
				<xsl:choose>
					<xsl:when  test="offset != ''">
						<xsl:value-of select="offset"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</key_7>
			<xsl:if test="offsetsign != ''">
				<key_8>
					<xsl:value-of select="offsetsign"/>
				</key_8>
			</xsl:if>
			<xsl:if test="$abbvname != ''">
				<key_9>
					<xsl:value-of select="$abbvname"/>
				</key_9>
			</xsl:if>
			<!--<xsl:if test="address != ''">
				<key_10>
					<xsl:value-of select="address"/>
				</key_10>
			</xsl:if>
			--><xsl:if test="customer_abbv_name != ''">
				<key_11>
					<xsl:value-of select="customer_abbv_name"/>
				</key_11>
			</xsl:if>
			<xsl:if test="tnx_amount_sign != ''">
				<key_12>
					<xsl:value-of select="tnx_amount_sign"/>
				</key_12>
			</xsl:if>
			<xsl:if test="tnx_currency != ''">
				<key_13>
					<xsl:value-of select="tnx_currency"/>
				</key_13>
			</xsl:if>
			<xsl:if test="tnx_amount != ''">
				<key_14>
					<xsl:value-of select="tnx_amount"/>
				</key_14>
			</xsl:if>
			<xsl:if test="prod_stat_code != ''">
				<key_15>
					<xsl:value-of select="prod_stat_code"/>
				</key_15>
			</xsl:if>
			<xsl:if test="sub_prod_code != ''">
				<key_16>
					<xsl:value-of select="sub_prod_code"/>
				</key_16>
			</xsl:if>
			<data_1>
				<xsl:choose>
					<xsl:when test="issuer_abbv_name!='*'">
						<xsl:value-of select="issuer_abbv_name"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="address"/>
					</xsl:otherwise>
				</xsl:choose>
			</data_1>
		</parameter_data>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>


