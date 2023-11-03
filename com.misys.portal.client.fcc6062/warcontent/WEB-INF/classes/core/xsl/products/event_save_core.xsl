<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Event -->
	<xsl:template match="event_record">
		<result>
			<com.misys.portal.calendar.common.Event>
				<xsl:attribute name="evt_id">
					<xsl:value-of select="evt_id"/>
				</xsl:attribute>

				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
        		<entity>
					<xsl:value-of select="entity"/>
				</entity>
				<tnx_id>
					<xsl:value-of select="tnx_id"/>
				</tnx_id>
				<product_code>
					<xsl:value-of select="product_code"/>
				</product_code>
				<ref_id>
					<xsl:value-of select="ref_id"/>
				</ref_id>
				<evt_date>
					<xsl:value-of select="evt_date"/>
				</evt_date>
				<title>
					<xsl:value-of select="title"/>
				</title>
				<description>
					<xsl:value-of select="description"/>
				</description>
				<type>
					<xsl:value-of select="type"/>
				</type>
				<owner_id>
					<xsl:value-of select="owner_id"/>
				</owner_id>
				<occurrence_id>
					<xsl:value-of select="occurrence_id"/>
				</occurrence_id>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.calendar.common.Event>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
