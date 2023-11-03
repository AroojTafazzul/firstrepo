<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2006 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<xsl:template match="/*">
		<!-- Copy original document -->
		<xsl:element name="{name()}">
			<xsl:for-each select="*">
				<xsl:if test="name() !='template_content'">
					<xsl:copy-of select="."/>
				</xsl:if>
			</xsl:for-each>
			<!-- Merge with content -->
			<xsl:for-each select="template_content/*/*">
				<xsl:variable name="name">
					<xsl:value-of select="name()"/>
				</xsl:variable>
				<xsl:choose>
					<!-- copy from template if node does not exist and is not empty and is not template_description -->
					<xsl:when test="count(../../../*[name()=$name]) = 0 and .!=''">
						<!-- too many cases -->
						<xsl:choose>
							<!-- security -->
							<xsl:when test="name()='template_description' or name()='company_id'"/>
							<!-- narratives -->
							<xsl:when test="contains(name(), 'narrative_')">
								<xsl:if test="text[.!='']">
									<xsl:element name="{name()}">
										<xsl:value-of select="text"/>
									</xsl:element>
								</xsl:if>
							</xsl:when>
							<!-- banks -->
							<xsl:when test="contains(name(), '_bank')">
								<xsl:if test="name[.!='']">
									<xsl:element name="{name()}">
										<xsl:element name="abbv_name">
											<xsl:value-of select="abbv_name"/>
										</xsl:element>
										<xsl:element name="name">
											<xsl:value-of select="name"/>
										</xsl:element>
										<xsl:element name="address_line_1">
											<xsl:value-of select="address_line_1"/>
										</xsl:element>
										<xsl:element name="address_line_2">
											<xsl:value-of select="address_line_2"/>
										</xsl:element>
										<xsl:element name="dom">
											<xsl:value-of select="dom"/>
										</xsl:element>
										<xsl:element name="reference">
											<xsl:value-of select="reference"/>
										</xsl:element>
									</xsl:element>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
