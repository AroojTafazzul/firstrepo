<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process BENEFICIARY-->
	<xsl:template match="static_beneficiary">
		<result>
			<com.misys.portal.systemfeatures.common.StaticBeneficiary>
				<!-- keys must be attributes -->
				<xsl:attribute name="beneficiary_id"><xsl:value-of select="beneficiary_id"/></xsl:attribute>

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
				<reference>
					<xsl:value-of select="reference"/>
				</reference>
				<email>
					<xsl:value-of select="email"/>
				</email>
				<web_address>
					<xsl:value-of select="web_address"/>
				</web_address>
				<autoacceptance_day>
					<xsl:value-of select="autoacceptance_day"/>
				</autoacceptance_day>
				<prtry_id_type>
					<xsl:value-of select="prtry_id_type"/>
				</prtry_id_type>
				
				<fscm_enabled>
					<xsl:value-of select="fscm_enabled"/>
				</fscm_enabled>
				
				<credit_note_enabled>
					<xsl:value-of select="credit_note_enabled"/>
				</credit_note_enabled>
				
				<buyer_role>
					<xsl:value-of select="buyer_role"/>
				</buyer_role>
				
				<seller_role>
					<xsl:value-of select="seller_role"/>
				</seller_role>
				
				<xsl:if test="bei">
					<additional_field name="bei" type="string" scope="master" description=" BEI">
						<xsl:value-of select="bei"/>
					</additional_field>
				</xsl:if>		
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

        		<!-- Collaboration Suite -->
				<access_opened>
					<xsl:value-of select="access_opened"/>
				</access_opened>
		        <notification_enabled>
		          <xsl:value-of select="notification_enabled"/>
		        </notification_enabled>
				<beneficiary_company_abbv_name>
					<xsl:value-of select="beneficiary_company_abbv_name"/>
				</beneficiary_company_abbv_name>
        		<!-- End Collaboration Suite -->
        		<!-- FSCM Fields -->
        		<xsl:if test="access_opened_prog_01">
					<additional_field name="access_opened_prog_01" type="string" scope="master" description="">
						<xsl:value-of select="access_opened_prog_01"/>
					</additional_field>
				</xsl:if>
        		<xsl:if test="access_opened_prog_02">
					<additional_field name="access_opened_prog_02" type="string" scope="master" description="">
						<xsl:value-of select="access_opened_prog_02"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="access_opened_prog_03">
					<additional_field name="access_opened_prog_03" type="string" scope="master" description="">
						<xsl:value-of select="access_opened_prog_03"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="access_opened_prog_04">
					<additional_field name="access_opened_prog_04" type="string" scope="master" description="">
						<xsl:value-of select="access_opened_prog_04"/>
					</additional_field>
				</xsl:if>
        		<xsl:if test="erp_id">
					<additional_field name="erp_id" type="string" scope="master" description="">
						<xsl:value-of select="erp_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="legal_id_no">
					<additional_field name="legal_id_no" type="string" scope="master" description="">
						<xsl:value-of select="legal_id_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="account">
					<additional_field name="account" type="string" scope="master" description="">
						<xsl:value-of select="account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bank_iso_code">
					<additional_field name="bank_iso_code" type="string" scope="master" description="">
						<xsl:value-of select="bank_iso_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="account_type">
					<additional_field name="account_type" type="string" scope="master" description="">
						<xsl:value-of select="account_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bank_name">
					<additional_field name="bank_name" type="string" scope="master" description="">
						<xsl:value-of select="bank_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bank_address_line_1">
					<additional_field name="bank_address_line_1" type="string" scope="master" description="">
						<xsl:value-of select="bank_address_line_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bank_address_line_2">
					<additional_field name="bank_address_line_2" type="string" scope="master" description="">
						<xsl:value-of select="bank_address_line_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bank_dom">
					<additional_field name="bank_dom" type="string" scope="master" description="">
						<xsl:value-of select="bank_dom"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="access_credit_note_product">
			     <additional_field name="access_credit_note_product" type="string" scope="master" description="">
			      <xsl:value-of select="access_credit_note_product"/>
			     </additional_field>
			    </xsl:if>
				<xsl:if test="cpty_cust_code">
					<additional_field name="cpty_cust_code" type="string" scope="master" description="">
						<xsl:value-of select="cpty_cust_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="cpty_company">
					<additional_field name="cpty_company" type="string" scope="master" description="">
						<xsl:value-of select="cpty_company"/>
					</additional_field>
				</xsl:if>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.common.StaticBeneficiary>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
