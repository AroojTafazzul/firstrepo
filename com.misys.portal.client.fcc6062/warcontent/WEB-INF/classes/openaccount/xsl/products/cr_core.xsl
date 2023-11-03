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
	<xsl:template match="cr_tnx_record">
		<result>
			<com.misys.portal.openaccount.product.cr.common.CreditNoteCR>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
				<xsl:if test="issuer_ref_id">
					<issuer_ref_id>
						<xsl:value-of select="issuer_ref_id"/>
					</issuer_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
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
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date"/>
					</iss_date>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>		
				
				<xsl:if test="cn_cur_code">
					<cn_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(total_net_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="cn_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</cn_cur_code>
				</xsl:if>
				<xsl:if test="cn_amt">
					<cn_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(total_net_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="cn_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</cn_amt>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code"/>
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code"/>
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code>
						<xsl:value-of select="prod_stat_code"/>
					</prod_stat_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
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
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_name>
				</xsl:if>
				<xsl:if test="seller_bei">
					<seller_bei>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_bei))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_bei"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_bei>
				</xsl:if>
				
				<xsl:if test="seller_street_name">
					<seller_street_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_street_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_street_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_street_name>
				</xsl:if>
				<xsl:if test="seller_post_code">
					<seller_post_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_post_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_post_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_post_code>
				</xsl:if>
				<xsl:if test="seller_town_name">
					<seller_town_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_town_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_town_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_town_name>
				</xsl:if>
				<xsl:if test="seller_country_sub_div">
					<seller_country_sub_div>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_country_sub_div))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_country_sub_div"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_country_sub_div>
				</xsl:if>
				<xsl:if test="seller_country">
					<seller_country>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_country))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_country"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
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
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_name>
				</xsl:if>
				<xsl:if test="buyer_bei">
					<buyer_bei>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_bei))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_bei"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_bei>
				</xsl:if>
				<xsl:if test="buyer_street_name">
					<buyer_street_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_street_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_street_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_street_name>
				</xsl:if>
				<xsl:if test="buyer_post_code">
					<buyer_post_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_post_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_post_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_post_code>
				</xsl:if>
				<xsl:if test="buyer_town_name">
					<buyer_town_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_town_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_town_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_town_name>
				</xsl:if>
				<xsl:if test="buyer_country_sub_div">
					<buyer_country_sub_div>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_country_sub_div))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_country_sub_div"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_country_sub_div>
				</xsl:if>
				<xsl:if test="buyer_country">
					<buyer_country>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_country))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_country"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_country>
				</xsl:if>
				<xsl:if test="buyer_reference">
					<buyer_reference>
								<xsl:value-of select="utils:decryptApplicantReference(buyer_reference)"/>
					</buyer_reference>
				</xsl:if>
				
				<!-- Credit Note Reference. -->
				<xsl:if test="cn_reference">
					<cn_reference>
						<xsl:value-of select="cn_reference"/>
					</cn_reference>
				</xsl:if>
				
				<!-- Seller Account -->
				<xsl:if test="seller_account_name">
					<seller_account_name>
						<xsl:value-of select="seller_account_name"/>
					</seller_account_name>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="seller_account_type[.='IBAN']">
						<seller_account_iban>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_iban>
						<seller_account_bban/>
						<seller_account_upic/>
						<seller_account_id/>
					</xsl:when>
					<xsl:when test="seller_account_type[.='BBAN']">
						<seller_account_bban>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_bban>
						<seller_account_iban/>
						<seller_account_upic/>
						<seller_account_id/>
					</xsl:when>
					<xsl:when test="seller_account_type[.='UPIC']">
						<seller_account_upic>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_upic>
						<seller_account_bban/>
						<seller_account_iban/>
						<seller_account_id/>
					</xsl:when>
					<xsl:when test="seller_account_type[.='OTHER']">
						<seller_account_id>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_id>
						<seller_account_bban/>
						<seller_account_upic/>
						<seller_account_iban/>
					</xsl:when>
				</xsl:choose>
				
				
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
     </com.misys.portal.openaccount.product.cr.common.CreditNoteCR>
			<!-- issuing bank -->
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="02">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="14">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="15">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative type_code="11">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//cr_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//cr_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//cr_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//cr_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//cr_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//cr_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//cr_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//cr_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'old_charge_details_position_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<xsl:if test="return_comments">
					<com.misys.portal.product.common.Narrative
						type_code="20">
						<xsl:attribute name="ref_id"><xsl:value-of select="ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id" /></xsl:attribute>
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
			<xsl:if test="invoice-items">
				<xsl:apply-templates select="invoice-items/invoice"></xsl:apply-templates>
			</xsl:if>
		</result>
	</xsl:template>
	<xsl:template match="invoice-items/invoice">
		<com.misys.portal.openaccount.product.baselinecn.util.CreditNoteInvoice>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:if test="invoice_ref_id">
				<invoice_ref_id>
					<xsl:value-of select="invoice_ref_id"/>
				</invoice_ref_id>
			</xsl:if>
			<xsl:if test="invoice_reference">
				<invoice_reference>
					<xsl:value-of select="invoice_reference"/>
				</invoice_reference>
			</xsl:if>
			<xsl:if test="invoice_currency">
				<invoice_currency>
					<xsl:value-of select="invoice_currency"/>
				</invoice_currency>
			</xsl:if>
			<xsl:if test="invoice_amount">
				<invoice_amount>
					<xsl:value-of select="invoice_amount"/>
				</invoice_amount>
			</xsl:if>
			<xsl:if test="invoice_settlement_amt">
				<invoice_settlement_amt>
					<xsl:value-of select="invoice_settlement_amt"/>
				</invoice_settlement_amt>
			</xsl:if>
			<xsl:if test="credit_note_reference">
				<credit_note_reference>
					<xsl:value-of select="credit_note_reference"/>
				</credit_note_reference>
			</xsl:if>
			<brch_code><xsl:value-of select="brch_code"/></brch_code>
			<company_id><xsl:value-of select="company_id"/></company_id>
			<!-- <entity><xsl:value-of select="entity"/></entity> -->
		</com.misys.portal.openaccount.product.baselinecn.util.CreditNoteInvoice>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
