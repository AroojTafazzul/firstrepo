<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:encryption="xalan://com.misys.portal.common.security.sso.Cypher" 
	exclude-result-prefixes="converttools encryption">

	<!--
		Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
		All Rights Reserved. 
	-->
	
	<!-- Get the parameters -->
	<!-- <xsl:include href="product_params.xsl"/>-->

	<xsl:output method="xml" indent="no"/>
	
	<!-- Get the language code -->
	<xsl:param name="language"/>
	

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process TSU Message -->
	<xsl:template match="tu_tnx_record">
		<result>
			<com.misys.portal.tsu.common.TSUMessage>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code><xsl:value-of select="brch_code"/></brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id><xsl:value-of select="company_id"/></company_id>
				</xsl:if>
				<!-- <xsl:if test="entity">
					<entity> <xsl:value-of select="entity"/> </entity>
				</xsl:if>-->
				<xsl:if test="company_name">
					<company_name><xsl:value-of select="company_name"/></company_name>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code><xsl:value-of select="product_code"/></product_code>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code><xsl:value-of select="tnx_type_code"/></tnx_type_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code><xsl:value-of select="sub_tnx_type_code"/></sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code><xsl:value-of select="prod_stat_code"/></prod_stat_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code><xsl:value-of select="tnx_stat_code"/></tnx_stat_code>
				</xsl:if>
				<xsl:if test="org_tnx_id">
					<org_tnx_id><xsl:value-of select="org_tnx_id"/></org_tnx_id>
				</xsl:if>
				<xsl:if test="creation_date">
					<creation_date><xsl:value-of select="creation_date"/></creation_date>
				</xsl:if>
				<!-- Amount and Currency -->
				<xsl:if test="ordered_amount">
					<ordered_amt><xsl:value-of select="ordered_amt"/></ordered_amt>
				</xsl:if>
				<xsl:if test="accepted_amount">
					<accepted_amt><xsl:value-of select="accepted_amt"/></accepted_amt>
				</xsl:if>
				<xsl:if test="cur_code">
					<cur_code><xsl:value-of select="cur_code"/></cur_code>
				</xsl:if>
				<!-- Tnx Amount and Currency -->
				<xsl:if test="tnx_val_date">
					<tnx_val_date><xsl:value-of select="tnx_val_date"/></tnx_val_date>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt><xsl:value-of select="tnx_amt"/></tnx_amt>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code><xsl:value-of select="tnx_cur_code"/></tnx_cur_code>
				</xsl:if>
				<!-- TSU id -->
				<xsl:if test="tid">
					<tid><xsl:value-of select="tid"/></tid>
				</xsl:if>
				<!-- Purchase order reference id -->
				<xsl:if test="po_ref_id">
					<po_ref_id><xsl:value-of select="po_ref_id"/></po_ref_id>
				</xsl:if>
				<!-- Counterparty -->
				<xsl:if test="cpty_ref_id">
					<cpty_ref_id><xsl:value-of select="cpty_ref_id"/></cpty_ref_id>
				</xsl:if>
				<xsl:if test="cpty_bank">
					<cpty_bank><xsl:value-of select="cpty_bank"/></cpty_bank>
				</xsl:if>
				<!-- Role -->
				<xsl:if test="role_code">
					<role_code><xsl:value-of select="role_code"/></role_code>
				</xsl:if>
				<!-- Buyer/Seller -->
				<xsl:if test="buyer_name">
					<buyer_name><xsl:value-of select="buyer_name"/></buyer_name>
				</xsl:if>
				<xsl:if test="seller_name">
					<seller_name><xsl:value-of select="seller_name"/></seller_name>
				</xsl:if>
				<!-- Customer -->
				<xsl:if test="company_id">
					<company_id><xsl:value-of select="company_id"/></company_id>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name><xsl:value-of select="company_name"/></company_name>
				</xsl:if>
				
				<xsl:if test="message_type">
					<message_type><xsl:value-of select="message_type"/></message_type>
				</xsl:if>
				
				<xsl:if test="tnx_type_code">
					<tnx_type_code><xsl:value-of select="tnx_type_code"/></tnx_type_code>
				</xsl:if>
				
				<xsl:if test="request_id">
					<request_id><xsl:value-of select="request_id"/></request_id>
				</xsl:if>

				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description="Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
				</xsl:if>

			</com.misys.portal.tsu.common.TSUMessage>
			
			<!-- Issuing Bank  -->
			<xsl:if test="issuing_bank_abbv_name">
				<com.misys.portal.product.common.Bank>
					<role_code>01</role_code>
					<xsl:if test="brch_code">
						<brch_code>
							<xsl:value-of select="brch_code"/>
						</brch_code>
					</xsl:if>
					<xsl:if test="ref_id">
						<ref_id>
							<xsl:value-of select="ref_id"/>
						</ref_id>
					</xsl:if>
					<xsl:if test="tnx_id">
						<tnx_id>
							<xsl:value-of select="tnx_id"/>
						</tnx_id>
					</xsl:if>
					<xsl:if test="company_id">
						<company_id>
							<xsl:value-of select="company_id"/>
						</company_id>
					</xsl:if>
					<xsl:if test="issuing_bank_abbv_name">
						<abbv_name>
							<xsl:value-of select="issuing_bank_abbv_name"/>
						</abbv_name>
					</xsl:if>
					<xsl:if test="issuing_bank_name">
						<name>
							<xsl:value-of select="issuing_bank_name"/>
						</name>
					</xsl:if>
					<xsl:if test="issuing_bank_address_line_1">
						<address_line_1>
							<xsl:value-of select="issuing_bank_address_line_1"/>
						</address_line_1>
					</xsl:if>
					<xsl:if test="issuing_bank_address_line_2">
						<address_line_2>
							<xsl:value-of select="issuing_bank_address_line_2"/>
						</address_line_2>
					</xsl:if>
					<xsl:if test="issuing_bank_dom">
						<dom>
							<xsl:value-of select="issuing_bank_dom"/>
						</dom>
					</xsl:if>
					<xsl:if test="issuing_bank_iso_code">
						<iso_code>
							<xsl:value-of select="issuing_bank_iso_code"/>
						</iso_code>
					</xsl:if>
					<xsl:if test="issuing_bank_reference">
						<reference>
							<xsl:value-of select="issuing_bank_reference"/>
						</reference>
					</xsl:if>
				</com.misys.portal.product.common.Bank>
			</xsl:if>

			<!-- TSU XML message -->
			<com.misys.portal.product.common.Narrative>
				<xsl:if test="brch_code">
					<brch_code><xsl:value-of select="brch_code"/></brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id><xsl:value-of select="company_id"/></company_id>
				</xsl:if>
				<xsl:if test="ref_id">
					<ref_id><xsl:value-of select="ref_id"/></ref_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id><xsl:value-of select="tnx_id"/></tnx_id>
				</xsl:if>
				<type_code>16</type_code>
				<xsl:if test="narrative_xml">
					<text><xsl:value-of select="narrative_xml"/></text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>

		</result>
	</xsl:template>
			
</xsl:stylesheet>
