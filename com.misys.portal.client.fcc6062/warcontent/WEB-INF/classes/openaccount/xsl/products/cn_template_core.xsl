<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
	
<!--
   Copyright (c) 2000-2006 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	<!-- Common elements to save among all products -->
	<xsl:include href="../../../openaccount/xsl/products/po_save_common.xsl"/>
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	<xsl:include href="../../../openaccount/xsl/products/lt.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Purchase Order -->
	<xsl:template match="cn_tnx_record">
		<result>
			<com.misys.portal.openaccount.product.cn.common.TemplateCreditNote>
				<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute> -->
				<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute> -->

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="company_name"/>
					</company_name>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="template_id">
					<template_id>
						<xsl:value-of select="template_id"/>
					</template_id>
				</xsl:if>
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
				</xsl:if>
				<xsl:if test="fscm_programme_code">
					<fscm_programme_code>
						<xsl:value-of select="fscm_programme_code"/>
					</fscm_programme_code>
				</xsl:if>
				<xsl:if test="program_id">
					<program_id>
						<xsl:value-of select="program_id"/>
					</program_id>
				</xsl:if>
				
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description=" Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				 <!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
				</xsl:if>
				
				
				<!-- Seller -->
				<xsl:if test="seller_abbv_name">
					<seller_abbv_name>
						<xsl:value-of select="seller_abbv_name"/>
					</seller_abbv_name>
				</xsl:if>
				<xsl:if test="seller_name">
					<seller_name>
						<xsl:value-of select="seller_name"/>
					</seller_name>
				</xsl:if>
				<xsl:if test="seller_bei">
					<seller_bei>
						<xsl:value-of select="seller_bei"/>
					</seller_bei>
				</xsl:if>
				
				<xsl:if test="seller_street_name">
					<seller_street_name>
						<xsl:value-of select="seller_street_name"/>
					</seller_street_name>
				</xsl:if>
				<xsl:if test="seller_post_code">
					<seller_post_code>
						<xsl:value-of select="seller_post_code"/>
					</seller_post_code>
				</xsl:if>
				<xsl:if test="seller_town_name">
					<seller_town_name>
						<xsl:value-of select="seller_town_name"/>
					</seller_town_name>
				</xsl:if>
				<xsl:if test="seller_country_sub_div">
					<seller_country_sub_div>
						<xsl:value-of select="seller_country_sub_div"/>
					</seller_country_sub_div>
				</xsl:if>
				<xsl:if test="seller_country">
					<seller_country>
						<xsl:value-of select="seller_country"/>
					</seller_country>
				</xsl:if>
				<xsl:if test="seller_reference">
					<seller_reference>
						<xsl:value-of select="utils:decryptApplicantReference(seller_reference)"/>
					</seller_reference>
				</xsl:if>
				<!-- Buyer -->
				<xsl:if test="buyer_abbv_name">
					<buyer_abbv_name>
						<xsl:value-of select="buyer_abbv_name"/>
					</buyer_abbv_name>
				</xsl:if>
				<xsl:if test="buyer_name">
					<buyer_name>
						<xsl:value-of select="buyer_name"/>
					</buyer_name>
				</xsl:if>
				<xsl:if test="buyer_bei">
					<buyer_bei>
						<xsl:value-of select="buyer_bei"/>
					</buyer_bei>
				</xsl:if>
				<xsl:if test="buyer_street_name">
					<buyer_street_name>
						<xsl:value-of select="buyer_street_name"/>
					</buyer_street_name>
				</xsl:if>
				<xsl:if test="buyer_post_code">
					<buyer_post_code>
						<xsl:value-of select="buyer_post_code"/>
					</buyer_post_code>
				</xsl:if>
				<xsl:if test="buyer_town_name">
					<buyer_town_name>
						<xsl:value-of select="buyer_town_name"/>
					</buyer_town_name>
				</xsl:if>
				<xsl:if test="buyer_country_sub_div">
					<buyer_country_sub_div>
						<xsl:value-of select="buyer_country_sub_div"/>
					</buyer_country_sub_div>
				</xsl:if>
				<xsl:if test="buyer_country">
					<buyer_country>
						<xsl:value-of select="buyer_country"/>
					</buyer_country>
				</xsl:if>
				<xsl:if test="buyer_reference">
					<buyer_reference>
								<xsl:value-of select="utils:decryptApplicantReference(buyer_reference)"/>
					</buyer_reference>
				</xsl:if>
				
				<xsl:if test="invoice_cust_ref_id">
					<additional_field name="invoice_cust_ref_id" type="string" scope="transaction" description="Supplier Invoice customer reference">
						<xsl:value-of select="invoice_cust_ref_id"/>
					</additional_field>
				</xsl:if>
				
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.openaccount.product.cn.common.TemplateCreditNote>
			<!-- issuing bank -->
			<com.misys.portal.product.common.TemplateBank role_code="01">
				<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute> -->
				<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute> -->

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
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
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="02">
				<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute> -->
				<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute> -->

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="advising_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="advising_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advising_bank_name">
					<name>
						<xsl:value-of select="advising_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="advising_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="advising_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advising_bank_dom">
					<dom>
						<xsl:value-of select="advising_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advising_bank_iso_code">
					<iso_code>
						<xsl:value-of select="advising_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advising_bank_reference">
					<reference>
						<xsl:value-of select="advisingB_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="14">
				<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute> -->
				<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute> -->

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="seller_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="seller_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="seller_bank_name">
					<name>
						<xsl:value-of select="seller_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="seller_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="seller_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="seller_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="seller_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="seller_bank_dom">
					<dom>
						<xsl:value-of select="seller_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="seller_bank_iso_code">
					<iso_code>
						<xsl:value-of select="seller_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="seller_bank_reference">
					<reference>
						<xsl:value-of select="seller_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="15">
				<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute> -->
				<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute> -->

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="buyer_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="buyer_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="buyer_bank_name">
					<name>
						<xsl:value-of select="buyer_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="buyer_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="buyer_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="buyer_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="buyer_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="buyer_bank_dom">
					<dom>
						<xsl:value-of select="buyer_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="buyer_bank_iso_code">
					<iso_code>
						<xsl:value-of select="buyer_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="buyer_bank_reference">
					<reference>
						<xsl:value-of select="buyer_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.Narrative type_code="11">
				<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute> -->
				<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute> -->

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="12">
				<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute> -->
				<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute> -->

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<xsl:if test="return_comments">
					<com.misys.portal.product.common.Narrative
						type_code="20">
						<!-- <xsl:attribute name="ref_id"><xsl:value-of select="ref_id" /></xsl:attribute> -->
						<!-- <xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id" /></xsl:attribute> -->
						<xsl:if test="brch_code">
							<brch_code>
								<xsl:value-of select="brch_code" />
							</brch_code>
						</xsl:if>
						<xsl:if test="company_id">
							<company_id>
								<xsl:value-of select="company_id" />
							</company_id>
						</xsl:if>
						<!-- <xsl:if test="return_comments"> -->
							<text>
								<xsl:value-of select="return_comments" />
							</text>
						<!-- </xsl:if> -->
					</com.misys.portal.product.common.Narrative>
				</xsl:if>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
