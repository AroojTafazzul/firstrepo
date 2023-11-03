<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" indent="yes" />
	
	<xsl:template match="io_tnx_record">
		<xsl:copy>
			<xsl:apply-templates select="*"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="io_tnx_record/@*|io_tnx_record/node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="line_items/lt_tnx_record | attachments/attachment | routing_summaries/rs_tnx_record | routing_summaries/air_routing_summaries | routing_summaries/sea_routing_summaries |routing_summaries/rail_routing_summaries |routing_summaries/road_routing_summaries | contacts/contact | payments/payment | incoterms/incoterm | adjustments/adjustment | taxes/tax | freight_charges/freight_charge | user_defined_informations/user_defined_information |  buyer_bank/node() | issuing_bank/node() | seller_bank/node() | advising_bank/node()">
	       <xsl:copy-of select="."/>
    </xsl:template>
	
    <xsl:template match="bank_payment_obligation/PmtOblgtn">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="commercial_dataset/ComrclDataSetReqrd">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="transport_dataset/TrnsprtDataSetReqrd">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="insurance_dataset/InsrncDataSetReqrd">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="certificate_dataset/CertDataSetReqrd">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="other_certificate_dataset/OthrCertDataSetReqrd">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>

	<xsl:template match="forward_dataset_submission/FwdDataSetSubmissnRpt">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="dataset_match_report/DataSetMtchRpt">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="baseline_report/BaselnRpt">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="full_push_through_report/FullPushThrghRpt">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="delta_report/DltaRpt">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="payment_transport_dataset/TrnsprtDataSet">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="payment_insurance_dataset/InsrncDataSet">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="payment_certificate_dataset/CertDataSet">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="payment_other_certificate_dataset/OthrCertDataSet">
    	<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:template>
</xsl:stylesheet>