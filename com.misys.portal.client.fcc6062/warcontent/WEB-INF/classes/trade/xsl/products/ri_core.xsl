<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:encryption="xalan://com.misys.portal.common.security.sso.Cypher" 
	exclude-result-prefixes="encryption">
	<!--
   Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<!-- BNPP SPECIFIC: in SSO configuraiton, some fields are encrypted -->

	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process RI -->
	<xsl:template match="ri_tnx_record">
		<result>
			<com.misys.portal.product.ri.common.ReceivedLetterOfIndemnity>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="lc_ref_id">
					<lc_ref_id>
						<xsl:value-of select="lc_ref_id"/>
					</lc_ref_id>
				</xsl:if>
				<xsl:if test="alt_lc_ref_id">
					<alt_lc_ref_id>
						<xsl:value-of select="alt_lc_ref_id"/>
					</alt_lc_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="bo_lc_ref_id">
					<bo_lc_ref_id>
						<xsl:value-of select="bo_lc_ref_id"/>
					</bo_lc_ref_id>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="deal_ref_id">
					<deal_ref_id>
						<xsl:value-of select="deal_ref_id"/>
					</deal_ref_id>
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
				<xsl:if test="imp_bill_ref_id">
					<imp_bill_ref_id>
						<xsl:value-of select="imp_bill_ref_id"/>
					</imp_bill_ref_id>
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
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="applicant_abbv_name">
					<applicant_abbv_name>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(applicant_abbv_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="applicant_abbv_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</applicant_abbv_name>
				</xsl:if>
				<xsl:if test="applicant_name">
					<applicant_name>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(applicant_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="applicant_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</applicant_name>
				</xsl:if>
				<xsl:if test="applicant_address_line_1">
					<applicant_address_line_1>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(applicant_address_line_1))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="applicant_address_line_1"/>
							</xsl:otherwise>
						</xsl:choose>
					</applicant_address_line_1>
				</xsl:if>
				<xsl:if test="applicant_address_line_2">
					<applicant_address_line_2>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(applicant_address_line_2))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="applicant_address_line_2"/>
							</xsl:otherwise>
						</xsl:choose>
					</applicant_address_line_2>
				</xsl:if>
				<xsl:if test="applicant_dom">
					<applicant_dom>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(applicant_dom))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="applicant_dom"/>
							</xsl:otherwise>
						</xsl:choose>
					</applicant_dom>
				</xsl:if>
				<!--  ajout country -->
				<xsl:if test="applicant_country">
					<applicant_country>
						<xsl:value-of select="applicant_country"/>
					</applicant_country>
				</xsl:if>
				<xsl:if test="applicant_reference">
					<applicant_reference>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(applicant_reference))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="applicant_reference"/>
							</xsl:otherwise>
						</xsl:choose>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="beneficiary_abbv_name">
					<beneficiary_abbv_name>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(beneficiary_abbv_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="beneficiary_abbv_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</beneficiary_abbv_name>
				</xsl:if>
				<xsl:if test="beneficiary_name">
					<beneficiary_name>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(beneficiary_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="beneficiary_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</beneficiary_name>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_1">
					<beneficiary_address_line_1>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(beneficiary_address_line_1))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="beneficiary_address_line_1"/>
							</xsl:otherwise>
						</xsl:choose>
					</beneficiary_address_line_1>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_2">
					<beneficiary_address_line_2>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(beneficiary_address_line_2))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="beneficiary_address_line_2"/>
							</xsl:otherwise>
						</xsl:choose>
					</beneficiary_address_line_2>
				</xsl:if>
				<xsl:if test="beneficiary_dom">
					<beneficiary_dom>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(beneficiary_dom))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="beneficiary_dom"/>
							</xsl:otherwise>
						</xsl:choose>
					</beneficiary_dom>
				</xsl:if>
				<!-- ajout Country-->
				<xsl:if test="beneficiary_country">
					<beneficiary_country>
						<xsl:value-of select="beneficiary_country"/>
					</beneficiary_country>
				</xsl:if>
				
				<xsl:if test="beneficiary_reference">
					<beneficiary_reference>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(beneficiary_reference))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="beneficiary_reference"/>
							</xsl:otherwise>
						</xsl:choose>
					</beneficiary_reference>
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
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date"/>
					</exp_date>
				</xsl:if>
				<xsl:if test="ri_cur_code">
					<ri_cur_code>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(ri_cur_code))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="ri_cur_code"/>
							</xsl:otherwise>
						</xsl:choose>
					</ri_cur_code>
				</xsl:if>
				<xsl:if test="ri_amt">
					<ri_amt>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(ri_amt))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="ri_amt"/>
							</xsl:otherwise>
						</xsl:choose>
					</ri_amt>
				</xsl:if>
				<xsl:if test="ri_liab_amt">
					<ri_liab_amt>
						<xsl:value-of select="ri_liab_amt"/>
					</ri_liab_amt>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(tnx_amt))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tnx_amt"/>
							</xsl:otherwise>
						</xsl:choose>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="ri_type_code">
					<ri_type_code>
						<xsl:value-of select="ri_type_code"/>
					</ri_type_code>
				</xsl:if>
				<xsl:if test="ri_type_details">
					<ri_type_details>
						<xsl:value-of select="ri_type_details"/>
					</ri_type_details>
				</xsl:if>
				<xsl:if test="countersign_flag">
					<countersign_flag>
						<xsl:value-of select="countersign_flag"/>
					</countersign_flag>
				</xsl:if>
				<xsl:if test="bol_number">
					<bol_number>
						<xsl:value-of select="bol_number"/>
					</bol_number>
				</xsl:if>
				<xsl:if test="bol_date">
					<bol_date>
						<xsl:value-of select="bol_date"/>
					</bol_date>
				</xsl:if>
				<xsl:if test="shipping_mode">
					<shipping_mode>
						<xsl:value-of select="shipping_mode"/>
					</shipping_mode>
				</xsl:if>
				<xsl:if test="shipping_by">
					<shipping_by>
						<xsl:value-of select="shipping_by"/>
					</shipping_by>
				</xsl:if>
				<xsl:if test="principal_act_no">
					<principal_act_no>
						<xsl:value-of select="principal_act_no"/>
					</principal_act_no>
				</xsl:if>
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no"/>
					</fee_act_no>
				</xsl:if>
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
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
     </com.misys.portal.product.ri.common.ReceivedLetterOfIndemnity>
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
			<com.misys.portal.product.common.Narrative type_code="01">
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
				<xsl:if test="narrative_description_goods">
					<text>
						<xsl:value-of select="narrative_description_goods"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
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

			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/*/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/*/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="/*/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="/*/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/*/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/*/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="/*/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="/*/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'old_charge_details_position_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
