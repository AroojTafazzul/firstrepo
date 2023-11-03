<?xml version="1.0" encoding="UTF-8" ?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="parameters">
		<result>
			<com.misys.portal.interfaces.incoming.ParameterDataFile/>
			<xsl:apply-templates select="parameter"/>
		</result>
	</xsl:template>

	<xsl:template match="parameter">
		<com.misys.portal.incoming.Parameter>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="company_id"/></company_id>
			<parm_id><xsl:value-of select="parm_id"/></parm_id>
			<xsl:if test="key_1"><key_1><xsl:value-of select="key_1"/></key_1></xsl:if>
			<xsl:if test="key_2"><key_2><xsl:value-of select="key_2"/></key_2></xsl:if>
			<xsl:if test="key_3"><key_3><xsl:value-of select="key_3"/></key_3></xsl:if>
			<xsl:if test="key_4"><key_4><xsl:value-of select="key_4"/></key_4></xsl:if>
			<xsl:if test="key_5"><key_5><xsl:value-of select="key_5"/></key_5></xsl:if>
			<xsl:if test="key_6"><key_6><xsl:value-of select="key_6"/></key_6></xsl:if>
			<xsl:if test="key_7"><key_7><xsl:value-of select="key_7"/></key_7></xsl:if>
			<xsl:if test="key_8"><key_8><xsl:value-of select="key_8"/></key_8></xsl:if>
			<xsl:if test="key_9"><key_9><xsl:value-of select="key_9"/></key_9></xsl:if>
			<xsl:if test="key_10"><key_10><xsl:value-of select="key_10"/></key_10></xsl:if>
			<xsl:if test="data_1"><data_1><xsl:value-of select="data_1"/></data_1></xsl:if>
			<xsl:if test="data_2"><data_2><xsl:value-of select="data_2"/></data_2></xsl:if>
			<xsl:if test="data_3"><data_3><xsl:value-of select="data_3"/></data_3></xsl:if>
			<xsl:if test="data_4"><data_4><xsl:value-of select="data_4"/></data_4></xsl:if>
			<xsl:if test="data_5"><data_5><xsl:value-of select="data_5"/></data_5></xsl:if>
			<xsl:if test="data_6"><data_6><xsl:value-of select="data_6"/></data_6></xsl:if>
			<xsl:if test="data_7"><data_7><xsl:value-of select="data_7"/></data_7></xsl:if>
			<xsl:if test="data_8"><data_8><xsl:value-of select="data_8"/></data_8></xsl:if>
			<xsl:if test="data_9"><data_9><xsl:value-of select="data_9"/></data_9></xsl:if>
			<xsl:if test="data_10"><data_10><xsl:value-of select="data_10"/></data_10></xsl:if>
			<xsl:if test="data_11"><data_11><xsl:value-of select="data_11"/></data_11></xsl:if>
			<xsl:if test="data_12"><data_12><xsl:value-of select="data_12"/></data_12></xsl:if>
			<xsl:if test="data_13"><data_13><xsl:value-of select="data_13"/></data_13></xsl:if>
			<xsl:if test="data_14"><data_14><xsl:value-of select="data_14"/></data_14></xsl:if>
			<xsl:if test="data_15"><data_15><xsl:value-of select="data_15"/></data_15></xsl:if>
			<xsl:if test="data_16"><data_16><xsl:value-of select="data_16"/></data_16></xsl:if>
			<xsl:if test="data_17"><data_17><xsl:value-of select="data_17"/></data_17></xsl:if>
			<xsl:if test="data_18"><data_18><xsl:value-of select="data_18"/></data_18></xsl:if>
			<xsl:if test="data_19"><data_19><xsl:value-of select="data_19"/></data_19></xsl:if>
			<xsl:if test="data_20"><data_20><xsl:value-of select="data_20"/></data_20></xsl:if>
		</com.misys.portal.incoming.Parameter>
	</xsl:template>
</xsl:stylesheet>
