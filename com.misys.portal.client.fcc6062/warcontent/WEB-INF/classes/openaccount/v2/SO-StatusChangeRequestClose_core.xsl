<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:intools="xalan://com.misys.portal.interfaces.tools.InterfacesTools"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:idgenerator="xalan://com.misys.portal.product.util.generator.ReferenceIdGenerator"
	xmlns:tools="xalan://com.misys.portal.common.tools.ConvertTools"
	exclude-result-prefixes="tools default intools idgenerator">
	
	<xsl:import href="common.xsl"/>
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" cdata-section-elements="narrative_xml"/>
	
	<!-- Get the interface environment -->
	<xsl:param name="context"/>
	<xsl:param name="language"/>
	
	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process PO-->
	<xsl:template match="so_tnx_record">
		
		<xsl:variable name="tuRefId"><xsl:value-of select="idgenerator:generate('TU')"/></xsl:variable>
							
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code><xsl:value-of select="default:getResource('BRANCH_CODE')"/></brch_code>
			<ref_id><xsl:value-of select="$tuRefId"/></ref_id>
    		<tnx_type_code>38</tnx_type_code>
			<prod_stat_code>77</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TU</product_code>
			<tid></tid>
			<po_ref_id><xsl:value-of select="ref_id"/></po_ref_id>
			<cpty_ref_id><xsl:value-of select="issuer_ref_id"/></cpty_ref_id>
			<cpty_bank></cpty_bank>
			<role><xsl:value-of select="submission_type"/></role>
			<cur_code><xsl:value-of select="total_cur_code"/></cur_code>
			<ordered_amt><xsl:value-of select="total_amt"/></ordered_amt>
			<accepted_amt></accepted_amt>
			<buyer_name><xsl:value-of select="buyer_name"/></buyer_name>
			<seller_name><xsl:value-of select="seller_name"/></seller_name>
			<message_type>012</message_type>
			<baseline_stat_code></baseline_stat_code>
			<baseline_ref_id></baseline_ref_id>
			<request_for_action></request_for_action>
			<link_ref_id></link_ref_id>
			<issuing_bank>
				<abbv_name><xsl:value-of select="advising_bank/abbv_name"/></abbv_name>
				<name><xsl:value-of select="advising_bank/name"/></name>
			</issuing_bank>
			<!-- TSU MESSAGE -->
			<narrative_xml>
			&lt;Doc:Document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:Doc="urn:swift:xsd:$tsmt.026.001.01">
			&lt;Doc:tsmt.026.001.01>
				&lt;Doc:SubmissnId>
					&lt;Doc:Id><xsl:value-of select="$tuRefId"/>&lt;/Doc:Id>
					&lt;Doc:CreDtTm><xsl:value-of select="tools:getW3CIsoDateTime()"/>&lt;/Doc:CreDtTm>
				&lt;/Doc:SubmissnId>
				&lt;Doc:TxId>
					&lt;Doc:Id><xsl:value-of select="tid"/>&lt;/Doc:Id>
				&lt;/Doc:TxId>
				&lt;Doc:SubmitrTxRef>
					&lt;Doc:Id><xsl:value-of select="ref_id"/>&lt;/Doc:Id>
					&lt;Doc:IdIssr>
						&lt;Doc:BIC>
							<!-- submit by buyer -->
							<xsl:when test="issuer_type_code[.='01']">
								<xsl:choose>
									<xsl:when test="buyer_bank/iso_code[.!= '']"><xsl:value-of select="buyer_bank/iso_code"/></xsl:when>
									<xsl:when test="buyer_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(buyer_bank/abbv_name, $context)"/></xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:when>
							<!-- submit by seller -->
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="seller_bank/iso_code[.!= '']"><xsl:value-of select="seller_bank/iso_code"/></xsl:when>
									<xsl:when test="submission_type[.='LODG']">
										<xsl:choose>
											<xsl:when test="buyer_bank/iso_code[.!= '']"><xsl:value-of select="buyer_bank/iso_code"/></xsl:when>
											<xsl:when test="buyer_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(buyer_bank/abbv_name, $context)"/></xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</xsl:when>
									<xsl:when test="seller_bank/abbv_name != ''"><xsl:value-of select="intools:retrieveBICFromAbbvName(seller_bank/abbv_name, $context)"/></xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:otherwise>
						&lt;/Doc:BIC>
					&lt;/Doc:IdIssr>
				&lt;/Doc:SubmitrTxRef>
				&lt;Doc:ReqdSts>
					&lt;Doc:Sts>CLSD&lt;/Doc:Sts>
				&lt;/Doc:ReqdSts>
			&lt;/Doc:tsmt.026.001.01>
		&lt;/Doc:Document>
		</narrative_xml>
	</tu_tnx_record>
		
	</xsl:template>
</xsl:stylesheet>
