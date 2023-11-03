<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
		<xsl:param name="company_id">
			<xsl:value-of select="company_id"/>
		</xsl:param>
		<xsl:param name="abbv_name">
			<xsl:value-of select="abbv_name"/>
		</xsl:param>
		<xsl:for-each select="//alert_type_code">
			<xsl:call-template name="alert_type">
				<xsl:with-param name="alertcode">
					<xsl:value-of select="."/>
				</xsl:with-param>
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id"/>
				</xsl:with-param>
        <xsl:with-param name="abbv_name">
					<xsl:value-of select="$abbv_name"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<!-- Alert References -->
	<xsl:template name="alert_type">
		<xsl:param name="alertcode"/>
		<xsl:param name="company_id"/>
    <xsl:param name="abbv_name"/>
		<xsl:for-each select="//*[starts-with(name(), concat('alerts_', $alertcode, '_details_position_'))]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), concat('alerts_', $alertcode, '_details_position_'))"/>
			</xsl:variable>
 			<xsl:variable name="prodcode">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_prodcode_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="tnxtypecode">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_tnxtypecode_', $position))]"/>
			</xsl:variable>
			 <xsl:variable name="datecode">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_datecode_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="langcode">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_langcode_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="tnxstatcode">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_tnxstatcode_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="usercode">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_usercode_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="entity">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_entity_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="offset">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_offsetcode_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="offsetsign">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_offsetsigncode_', $position))]"/>
			</xsl:variable>
 			<xsl:variable name="output">
				<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_output_', $position))]"/>
			</xsl:variable>
   		<parameter_data>
				<xsl:element name="parm_id">
					<xsl:value-of select="$parm_id"/>
				</xsl:element>
				<xsl:element name="company_id">
					<xsl:value-of select="$company_id"/>
				</xsl:element>
				<xsl:element name="key_1">
					<xsl:value-of select="$alertcode"/>
				</xsl:element>
				<xsl:element name="key_2">
					<xsl:value-of select="$prodcode"/>
				</xsl:element>
				<xsl:element name="key_3">
   				<xsl:choose>
   					<xsl:when test="$tnxtypecode!=''">
   						<xsl:value-of select="$tnxtypecode"/>
   					</xsl:when>
   					<xsl:when test="$datecode!=''">
   						<xsl:value-of select="$datecode"/>
   					</xsl:when>
   					<xsl:otherwise>*</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<!--xsl:element name="key_4">
					<xsl:choose>
						<xsl:when test="$tnxstatcode!=''">
							<xsl:value-of select="$tnxstatcode"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element-->
				<xsl:element name="key_5">
					<xsl:choose>
						<xsl:when test="$langcode!=''">
							<xsl:value-of select="$langcode"/>
						</xsl:when>
						<!--  DO NOT SET **, see GTPB1985 -->
						<xsl:otherwise>*</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="data_1">
					<xsl:choose>
						<xsl:when test="$usercode!=''">
							<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_usercode_', $position))]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="//*[starts-with(name(),concat('alerts_', $alertcode, '_details_address_', $position))]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="key_6">
					<xsl:choose>
						<xsl:when test="$entity!=''">
							<xsl:value-of select="$entity"/>
						</xsl:when>
						<xsl:otherwise>**</xsl:otherwise>
					</xsl:choose>
				</xsl:element>  
				<xsl:element name="key_7">
					<xsl:choose>
						<xsl:when test="$offset!=''">
							<xsl:value-of select="$offset"/>
						</xsl:when>
						<xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="key_8">
					<xsl:choose>
						<xsl:when test="$offsetsign!=''">
							<xsl:value-of select="$offsetsign"/>
						</xsl:when>
						<xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="key_9">
					<xsl:choose>
						<xsl:when test="$abbv_name!=''">
							<xsl:value-of select="$abbv_name"/>
						</xsl:when>
						<xsl:otherwise>*</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="key_10">
					<xsl:choose>
						<xsl:when test="$output!=''">
							<xsl:value-of select="$output"/>
						</xsl:when>
						<xsl:otherwise>*</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</parameter_data>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
