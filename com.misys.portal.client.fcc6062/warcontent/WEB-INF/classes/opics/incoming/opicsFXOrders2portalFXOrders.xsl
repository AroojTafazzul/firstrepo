<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="tools">
	
	<xsl:variable name="brch_code" select="'00001'"/>
	<xsl:variable name="tnx_stat_code" select="'04'"/>
	<xsl:variable name="product_code" select="'XO'"/>
	
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	
	<xsl:template match="Publications" mode="xo">
		<xsl:apply-templates select="Publication/ItemArray/anyType"/>
	</xsl:template>
		
	<xsl:template match="anyType[PublishedEventName='OREV']">

		<xsl:variable name="ref_id" select="tools:retrieveRefIdFromBoRefId(ORDERNO, $product_code, null, null)"/>
		<xsl:variable name="cust_ref_id" ><xsl:value-of select="BR"/>/<xsl:value-of select="CNO"/></xsl:variable>
		<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
		<!-- Retrieve references from DB -->
		<xsl:variable name="company_id" select="$companyInfos/references/company_id"/>
		<xsl:variable name="company_name" select="$companyInfos/references/company_name"/>
		<xsl:variable name="companyAddress" select="tools:retrieveCompanyAddressNodesFromCompanyId($company_id)"/>
		<xsl:variable name="company_address_name" select="$companyAddress/references/company_name"/>
		<xsl:variable name="company_address_1" select="$companyAddress/references/company_adress_1"/>
		<xsl:variable name="company_address_2" select="$companyAddress/references/company_adress_2"/>
		<xsl:variable name="company_address_dom" select="$companyAddress/references/company_dom"/>
		
		<transactions>
		<orders xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
		<xo_tnx_record>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<ref_id><xsl:value-of select="$ref_id"/></ref_id>
			<bo_ref_id><xsl:value-of select="ORDERNO"/></bo_ref_id>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<company_name><xsl:value-of select="$company_name"/></company_name>
			<bo_tnx_id><xsl:value-of select="RECIDENTITY"/></bo_tnx_id>
			<tnx_type_code>01</tnx_type_code>
			
			<xsl:if test="CUST">
				<cust_ref_id>
					<xsl:value-of select="CUST"/>
				</cust_ref_id>
				
			</xsl:if>
			
			<xsl:if test="STATUS">
				<prod_stat_code>
					<xsl:choose>
						<xsl:when test="STATUS='ACTIVE'">90</xsl:when>
						<xsl:when test="STATUS='ACTIVE/LINKED'">91</xsl:when>
						<xsl:when test="STATUS='CANCELED'">06</xsl:when>
						<xsl:when test="STATUS='CONFIRMED'">92</xsl:when>
						<xsl:when test="STATUS='EXPIRED'">42</xsl:when>
						<xsl:when test="STATUS='FILLED'">93</xsl:when>
						<xsl:when test="STATUS='INTERIM EXPIRED'">94</xsl:when>
						<xsl:when test="STATUS='PENDING'">95</xsl:when>
					</xsl:choose>
				</prod_stat_code>
			</xsl:if>
	
			<tnx_stat_code>
				<xsl:value-of select="$tnx_stat_code"/>
			</tnx_stat_code>
			
			<xsl:if test="INSTRUMENT">
				<tnx_cur_code>
					<xsl:value-of select="substring-before(INSTRUMENT,'/')"/>
				</tnx_cur_code>
			</xsl:if>
			<xsl:if test="AMT">
				<tnx_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="AMT"/></xsl:with-param>
					</xsl:call-template>
					<!-- <xsl:value-of select="format-number(AMT, '###,###,###.00')"/> -->
				</tnx_amt>
			</xsl:if>
			<xsl:if test="INSTRUMENT">
				<counter_cur_code>
					<xsl:value-of select="substring-after(INSTRUMENT,'/')"/>
				</counter_cur_code>
				<fx_cur_code>
					<xsl:value-of select="substring-before(INSTRUMENT,'/')"/>
				</fx_cur_code>
			</xsl:if>
			<xsl:if test="AMT">
				<fx_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="AMT"/></xsl:with-param>
					</xsl:call-template>
					<!-- <xsl:value-of select="format-number(AMT, '###,###,###.00')"/> -->
				</fx_amt>
			</xsl:if>
			<xsl:if test="EXPIRATIONCODE">
				<expiration_code><xsl:value-of select="EXPIRATIONCODE"/></expiration_code>
			</xsl:if>
			<xsl:if test="EXPIREDATE">
				<expiration_date_date>
					<xsl:call-template name="opicsDate2portalDate">
						<xsl:with-param name="date">
							<xsl:value-of select="EXPIREDATE"/>
						</xsl:with-param>
					</xsl:call-template>
				</expiration_date_date>
				<!-- <expiration_date_number></expiration_date_number> -->
			</xsl:if>
			<xsl:if test="EXPIRETIME">
				<expiration_time>01/01/1970 <xsl:choose><xsl:when test="EXPIRETIME != ''"><xsl:value-of select="EXPIRETIME"/></xsl:when><xsl:otherwise>00:00:00</xsl:otherwise></xsl:choose></expiration_time>
			</xsl:if>
			
			<xsl:if test="PSC">
				<contract_type>
					<xsl:choose>
						<xsl:when test="PSC='P'">01</xsl:when>
						<xsl:when test="PSC='S'">02</xsl:when>
						<xsl:when test="PSC='C'">03</xsl:when>
					</xsl:choose>
				</contract_type>
			</xsl:if>
			
			<xsl:choose>
				<xsl:when test="PERIOD and PERIOD != ''">
					<xsl:choose>
						<xsl:when test="PERIOD='SPOT'">
							<value_code><xsl:value-of select="PERIOD"/></value_code>
						</xsl:when>
						<xsl:otherwise>
							<value_code><xsl:value-of select="translate(substring(PERIOD, string-length(PERIOD)), $uppercase, $smallcase)"/></value_code>
							<value_number><xsl:value-of select="substring(PERIOD, 1, string-length(PERIOD)-1)"/></value_number>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="VDATE">
					<value_date>
						<xsl:call-template name="opicsDate2portalDate">
							<xsl:with-param name="date">
								<xsl:value-of select="VDATE"/>
							</xsl:with-param>
						</xsl:call-template>
					</value_date>
					<value_number></value_number>
				</xsl:when>
			</xsl:choose>
			
			<product_code>
				<xsl:value-of select="$product_code"/>
			</product_code>
			
			<xsl:if test="ORDERTYPE">
				<fx_type>
					<xsl:choose>
						<xsl:when test="ORDERTYPE='M'">MARKET_ORDER</xsl:when>
						<xsl:when test="ORDERTYPE='POS'">POSITION_ORDER</xsl:when>
						<xsl:when test="ORDERTYPE='S/L'">STOP_LIMIT_ORDER</xsl:when>
						<xsl:when test="ORDERTYPE='T/P'">TAKE_PROFIT_ORDER</xsl:when>
					</xsl:choose>
				</fx_type>
				<xsl:choose>
					<xsl:when test="ORDERTYPE='M'">
						<market_order>Y</market_order>
					</xsl:when>
					<xsl:otherwise>
						<market_order>N</market_order>
						<xsl:choose>
							<xsl:when test="ORDERTYPE='POS'">
								<trigger_pos><xsl:value-of select="TRIGGER_8"/></trigger_pos>
							</xsl:when>
							<xsl:when test="ORDERTYPE='S/L'">
								<trigger_stop><xsl:value-of select="TRIGGER_8"/></trigger_stop>
							</xsl:when>
							<xsl:when test="ORDERTYPE='T/P'">
								<trigger_limit><xsl:value-of select="TRIGGER_8"/></trigger_limit>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			
			<applicant_abbv_name><xsl:value-of select="$company_name"/></applicant_abbv_name>
			<applicant_name><xsl:value-of select="$company_address_name"/></applicant_name>
			<applicant_address_line_1><xsl:value-of select="$company_address_1"/></applicant_address_line_1>
			<applicant_address_line_2><xsl:value-of select="$company_address_2"/></applicant_address_line_2>
			<applicant_dom><xsl:value-of select="$company_address_dom"/></applicant_dom>
			<applicant_reference><xsl:value-of select="$cust_ref_id"/></applicant_reference>
				
			<xsl:if test="SEQ">
				<seq>
					<xsl:value-of select="SEQ"/>
				</seq>
			</xsl:if>
			<xsl:if test="ORDERREMARKS">
				<remarks>
					<xsl:value-of select="ORDERREMARKS"/>
				</remarks>
			</xsl:if>
			
			<xsl:if test="WATCHER">
				<watcher>
					<xsl:value-of select="WATCHER"/>
				</watcher>
			</xsl:if>
			<xsl:if test="ACTION">
				<action>
					<xsl:value-of select="ACTION"/>
				</action>
			</xsl:if>
			<xsl:if test="TRAD">
				<trader>
					<xsl:value-of select="TRAD"/>
				</trader>
			</xsl:if>
			<xsl:if test="INPUTDATE">
				<input_date>
					<xsl:call-template name="opicsDate2portalDate">
						<xsl:with-param name="date">
							<xsl:value-of select="INPUTDATE"/>
						</xsl:with-param>
					</xsl:call-template>
				</input_date>
			</xsl:if>
			<xsl:if test="FILLPRICE_8">
				<fill_price>
					<xsl:value-of select="FILLPRICE_8"/>
				</fill_price>
			</xsl:if>
			<xsl:if test="CANCELLINK">
				<cancel_link>
					<xsl:value-of select="CANCELLINK"/>
				</cancel_link>
			</xsl:if>
			<xsl:if test="ACTIVATELINK">
				<activate_link>
					<xsl:value-of select="ACTIVATELINK"/>
				</activate_link>
			</xsl:if>
			<xsl:if test="FEDEALNO">
				<fx_dealno>
					<xsl:value-of select="FEDEALNO"/>
				</fx_dealno>
			</xsl:if>
		</xo_tnx_record>
		</orders>
		</transactions>

	</xsl:template>

</xsl:stylesheet>