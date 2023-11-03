<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process BANK-->
	<xsl:template match="static_bank">
		<result>
			<com.misys.portal.systemfeatures.common.StaticBank>
				<!-- keys must be attributes -->
				<xsl:attribute name="bank_id"><xsl:value-of select="bank_id"/></xsl:attribute>

				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
				<entity>
					<xsl:value-of select="entity"/>
				</entity>
				<abbv_name>
					<xsl:value-of select="abbv_name"/>
				</abbv_name>
				<name>
					<xsl:value-of select="name"/>
				</name>
				<address_line_1>
					<xsl:value-of select="address_line_1"/>
				</address_line_1>
				<address_line_2>
					<xsl:value-of select="address_line_2"/>
				</address_line_2>
				<dom>
					<xsl:value-of select="dom"/>
				</dom>
				<country>
					<xsl:value-of select="country"/>
				</country>
				<contact_name>
					<xsl:value-of select="contact_name"/>
				</contact_name>
				<phone>
					<xsl:value-of select="phone"/>
				</phone>
				<fax>
					<xsl:value-of select="fax"/>
				</fax>
				<telex>
					<xsl:value-of select="telex"/>
				</telex>
				<iso_code>
					<xsl:value-of select="iso_code"/>
				</iso_code>
				<reference>
					<xsl:value-of select="reference"/>
				</reference>
				<email>
					<xsl:value-of select="email"/>
				</email>
				<web_address>
					<xsl:value-of select="web_address"/>
				</web_address>	
				<xsl:if test="street_name">
					<additional_field name="street_name" type="string" scope="master" description=" Street name">
						<xsl:value-of select="street_name"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="post_code">
					<additional_field name="post_code" type="string" scope="master" description=" Post code">
						<xsl:value-of select="post_code"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="town_name">
					<additional_field name="town_name" type="string" scope="master" description=" Town name">
						<xsl:value-of select="town_name"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="country_sub_div">
					<additional_field name="country_sub_div" type="string" scope="master" description=" Country sub division">
						<xsl:value-of select="country_sub_div"/>
					</additional_field>
				</xsl:if>				
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.common.StaticBank>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
