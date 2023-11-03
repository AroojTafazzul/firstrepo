<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="default tools localization">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<!--<xsl:param name="context"/>-->
	<xsl:param name="language"/>
	<xsl:param name="BIC"/>
	
	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="Document">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Process TSU Message -->
	<xsl:template match="BaselnMtchRpt">

		<!-- Depending on the BIC, the refId can be either the PO reference Id or the SO reference Id -->			 
		<xsl:variable name="refId"><xsl:value-of select="UsrTxRef[IdIssr/BIC = $BIC]/Id"/></xsl:variable>
		
		<xsl:variable name="nbMismatches"><xsl:value-of select="Rpt/NbOfMisMtchs"/></xsl:variable>
		
		<xsl:if test="$refId != ''">
			<xsl:variable name="productCode"><xsl:value-of select="substring($refId, 1,2)"/></xsl:variable>
			<xsl:choose>
				<xsl:when test="$productCode = 'SO'">
					<xsl:variable name="soFile" select="tools:convertToNode(tools:exportedXMLFile($productCode, $refId))"/>
					<xsl:choose>
						<xsl:when test="$nbMismatches = '0'">
							<so_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/so.xsd">
								<brch_code>00001</brch_code>
								<ref_id><xsl:value-of select="$refId"/></ref_id>
								<company_name><xsl:value-of select="$soFile//*[local-name()='company_name']"/></company_name>
								<tnx_type_code>15</tnx_type_code>
								<sub_tnx_type_code/>
								<prod_stat_code>76</prod_stat_code>
								<tnx_stat_code>04</tnx_stat_code>
								<product_code>SO</product_code>
								<tnx_cur_code><xsl:value-of select="$soFile//*[local-name()='total_net_cur_code']"/></tnx_cur_code>
								<tnx_amt><xsl:value-of select="$soFile//*[local-name()='total_net_amt']"/></tnx_amt>
								<tid><xsl:value-of select="TxId/Id"/></tid>
								<additional_field name="hasLineItem" type="string" scope="none">N</additional_field>
								<!-- This additional field enables the valuation of outstanding amounts/ quantities -->
								<!-- (which is done in a Java component for the sake of simplicity instead of a complex stylesheet) -->
								<xsl:if test="TxSts/Sts = 'ESTD'">
									<additional_field name="IsBaselineEstablished" type="string" scope="none">Y</additional_field>
								</xsl:if>
								<advising_bank>
									<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
									<iso_code><xsl:value-of select="$BIC"/></iso_code>
								</advising_bank>
								<bo_comment><xsl:value-of select="localization:getGTPString($language, 'INTERFACE_SO_ACCEPT')"/></bo_comment>
							</so_tnx_record>
						</xsl:when>
						<xsl:otherwise>
							<so_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/so.xsd">
								<brch_code>00001</brch_code>
								<ref_id><xsl:value-of select="$refId"/></ref_id>
								<company_name><xsl:value-of select="$soFile//*[local-name()='company_name']"/></company_name>
								<tnx_type_code>15</tnx_type_code>
								<sub_tnx_type_code/>
								<prod_stat_code>77</prod_stat_code>
								<tnx_stat_code>04</tnx_stat_code>
								<product_code>SO</product_code>
								<tnx_cur_code><xsl:value-of select="$soFile//*[local-name()='total_net_cur_code']"/></tnx_cur_code>
								<tnx_amt><xsl:value-of select="$soFile//*[local-name()='total_net_amt']"/></tnx_amt>
								<tid><xsl:value-of select="TxId/Id"/></tid>
								<additional_field name="hasLineItem" type="string" scope="none">N</additional_field>
								<advising_bank>
									<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
									<iso_code><xsl:value-of select="$BIC"/></iso_code>
								</advising_bank>
								<bo_comment><xsl:value-of select="localization:getGTPString($language, 'INTERFACE_SO_REJECT')"/></bo_comment>
							</so_tnx_record>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$productCode = 'PO'">
					<xsl:variable name="poFile" select="tools:convertToNode(tools:exportedXMLFile($productCode, $refId))"/>
					<xsl:choose>
						<xsl:when test="$nbMismatches = '0'">
							<po_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/po.xsd">
								<brch_code>00001</brch_code>
								<ref_id><xsl:value-of select="$refId"/></ref_id>
								<company_name><xsl:value-of select="$poFile//*[local-name()='company_name']"/></company_name>
								<tnx_type_code>15</tnx_type_code>
								<sub_tnx_type_code/>
								<prod_stat_code>76</prod_stat_code>
								<tnx_stat_code>04</tnx_stat_code>
								<product_code>PO</product_code>
								<tnx_cur_code><xsl:value-of select="$poFile//*[local-name()='total_net_cur_code']"/></tnx_cur_code>
								<tnx_amt><xsl:value-of select="$poFile//*[local-name()='total_net_amt']"/></tnx_amt>
								<tid><xsl:value-of select="TxId/Id"/></tid>
								<additional_field name="hasLineItem" type="string" scope="none">N</additional_field>
								<!-- This additional field enables the valuation of outstanding amounts/ quantities -->
								<!-- (which is done in a Java component for the sake of simplicity instead of a complex stylesheet) -->
								<xsl:if test="TxSts/Sts = 'ESTD'">
									<additional_field name="IsBaselineEstablished" type="string" scope="none">Y</additional_field>
								</xsl:if>
								<issuing_bank>
									<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
									<iso_code><xsl:value-of select="$BIC"/></iso_code>
								</issuing_bank>
								<bo_comment><xsl:value-of select="localization:getGTPString($language, 'INTERFACE_PO_ACCEPT')"/></bo_comment>
							</po_tnx_record>
						</xsl:when>
						<xsl:otherwise>
							<po_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/po.xsd">
								<brch_code>00001</brch_code>
								<ref_id><xsl:value-of select="$refId"/></ref_id>
								<company_name><xsl:value-of select="$poFile//*[local-name()='company_name']"/></company_name>
								<tnx_type_code>15</tnx_type_code>
								<sub_tnx_type_code/>
								<prod_stat_code>77</prod_stat_code>
								<tnx_stat_code>04</tnx_stat_code>
								<product_code>PO</product_code>
								<tnx_cur_code><xsl:value-of select="$poFile//*[local-name()='total_net_cur_code']"/></tnx_cur_code>
								<tnx_amt><xsl:value-of select="$poFile//*[local-name()='total_net_amt']"/></tnx_amt>
								<tid><xsl:value-of select="TxId/Id"/></tid>
								<additional_field name="hasLineItem" type="string" scope="none">N</additional_field>
								<issuing_bank>
									<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
									<iso_code><xsl:value-of select="$BIC"/></iso_code>
								</issuing_bank>
								<bo_comment><xsl:value-of select="localization:getGTPString($language, 'INTERFACE_PO_REJECT')"/></bo_comment>
							</po_tnx_record>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
