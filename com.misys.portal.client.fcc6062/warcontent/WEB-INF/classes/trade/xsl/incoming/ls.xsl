<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:utils="xalan://com.misys.portal.common.tools.LicenseUtils"
				xmlns:util="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="service utils util">
			
	<!-- Process License-->
	<xsl:template match="ls_tnx_record">
	
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageReferences(//product_code, //ref_id, //tnx_id, //bo_ref_id, //cust_ref_id, //company_id, //company_name, //applicant_reference, //issuing_bank/abbv_name, '01')"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
		
	
		<result>
			<com.misys.portal.product.ls.common.License>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<xsl:variable name="lsName"><xsl:value-of select="ls_name"></xsl:value-of></xsl:variable>
				<xsl:variable name="licenseDetails" select="utils:getLicenseDetails($lsName)"/>
				<xsl:variable name="lsdefid"><xsl:value-of select="$licenseDetails/ls_details/def_id"/></xsl:variable>
				<xsl:variable name="lstype"><xsl:value-of select="$licenseDetails/ls_details/ls_type"/></xsl:variable>
				<ls_def_id>
					<xsl:value-of select="$lsdefid"/>
				</ls_def_id>
				<ls_type>
						<xsl:value-of select="$lstype"/>
				</ls_type>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<xsl:if test="entity">
					<entity><xsl:value-of select="entity"/></entity>
				</xsl:if>
				<xsl:if test="$entity!='' and not(entity)">
					<entity><xsl:value-of select="$entity"/></entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="inp_user_id">
					<inp_user_id><xsl:value-of select="inp_user_id"/></inp_user_id>
				</xsl:if>
				<xsl:if test="inp_user_dttm">
					<inp_user_dttm><xsl:value-of select="inp_user_dttm"/></inp_user_dttm>
				</xsl:if>
				<xsl:if test="ctl_user_id">
					<ctl_user_id><xsl:value-of select="ctl_user_id"/></ctl_user_id>
				</xsl:if>
				<xsl:if test="ctl_user_dttm">
					<ctl_user_dttm><xsl:value-of select="ctl_user_dttm"/></ctl_user_dttm>
				</xsl:if>
				<xsl:if test="release_user_id">
					<release_user_id><xsl:value-of select="release_user_id"/></release_user_id>
				</xsl:if>
				<xsl:if test="release_user_dttm">
					<release_user_dttm><xsl:value-of select="release_user_dttm"/></release_user_dttm>
				</xsl:if>
				<xsl:if test="bo_inp_user_id">
					<bo_inp_user_id><xsl:value-of select="bo_inp_user_id"/></bo_inp_user_id>
				</xsl:if>
				<xsl:if test="bo_inp_user_dttm">
					<bo_inp_user_dttm><xsl:value-of select="bo_inp_user_dttm"/></bo_inp_user_dttm>
				</xsl:if>
				<xsl:if test="bo_ctl_user_id">
					<bo_ctl_user_id><xsl:value-of select="bo_ctl_user_id"/></bo_ctl_user_id>
				</xsl:if>
				<xsl:if test="bo_ctl_user_dttm">
					<bo_ctl_user_dttm><xsl:value-of select="bo_ctl_user_dttm"/></bo_ctl_user_dttm>
				</xsl:if>
				<xsl:if test="bo_release_user_id">
					<bo_release_user_id><xsl:value-of select="bo_release_user_id"/></bo_release_user_id>
				</xsl:if>
				<xsl:if test="bo_release_user_dttm">
					<bo_release_user_dttm><xsl:value-of select="bo_release_user_dttm"/></bo_release_user_dttm>
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
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date"/>
					</exp_date>
				</xsl:if>
				<xsl:if test="amd_date">
					<amd_date>
						<xsl:value-of select="amd_date"/>
					</amd_date>
				</xsl:if>
				<xsl:if test="amd_no">
					<amd_no>
						<xsl:value-of select="amd_no"/>
					</amd_no>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="ls_cur_code">
					<ls_cur_code>
						<xsl:value-of select="ls_cur_code"/>
					</ls_cur_code>
				</xsl:if>
				<xsl:if test="ls_amt">
					<ls_amt>
						<xsl:value-of select="ls_amt"/>
					</ls_amt>
				</xsl:if>
				<xsl:if test="ls_liab_amt">
					<ls_liab_amt>
						<xsl:value-of select="ls_liab_amt"/>
					</ls_liab_amt>
				</xsl:if>
				<xsl:if test="ls_name">
					<ls_name>
						<xsl:value-of select="ls_name"/>
					</ls_name>
				</xsl:if>
				<xsl:if test="ls_number">
					<ls_number>
						<xsl:value-of select="ls_number"/>
					</ls_number>
				</xsl:if>
				<xsl:if test="ls_outstanding_amt">
					<ls_outstanding_amt>
						<xsl:value-of select="ls_outstanding_amt"/>
					</ls_outstanding_amt>
				</xsl:if>

			<xsl:choose>
				<xsl:when test="inco_term_year and inco_term_year[. != ''] and util:validateIncoYear(//inco_term_year,$main_bank_abbv_name)">
					<inco_term_year>
						<xsl:value-of select="inco_term_year"/>
					</inco_term_year>
				</xsl:when>
				<xsl:when test="not(inco_term_year) and inco_term and inco_term[. != ''] ">
				<inco_term_year>OTHER</inco_term_year>
				</xsl:when>

				<xsl:when test="inco_term_year">
				<inco_term_year>
						<xsl:value-of select="inco_term_year"/>
				</inco_term_year>
				</xsl:when>


				</xsl:choose>
				
				<xsl:choose>
				<xsl:when test="inco_term_year and inco_term and (inco_term[. != ''] or inco_term_year[. != '']) and util:validateIncoTerm(//inco_term_year,//inco_term,$main_bank_abbv_name)">
					<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:when>
				<xsl:when test="not(inco_term_year) and inco_term and inco_term[. != ''] and util:validateIncoTerm('OTHER',//inco_term,$main_bank_abbv_name)">
				<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:when>
				<xsl:when test="inco_term">
				<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:when>
				</xsl:choose>
				<xsl:if test="inco_place">
					<inco_place>
						<xsl:value-of select="inco_place"/>
					</inco_place>
				</xsl:if>
				<xsl:if test="neg_tol_pct">
					<neg_tol_pct>
						<xsl:value-of select="neg_tol_pct"/>
					</neg_tol_pct>
				</xsl:if>
				<xsl:if test="pstv_tol_pct">
					<pstv_tol_pct>
						<xsl:value-of select="pstv_tol_pct"/>
					</pstv_tol_pct>
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

				<xsl:call-template name="manageProdStatCode">
					<xsl:with-param name="product" select="."/>
				</xsl:call-template>

				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="sub_tnx_stat_code">
					<sub_tnx_stat_code>
						<xsl:value-of select="sub_tnx_stat_code"/>
					</sub_tnx_stat_code>
				</xsl:if>
				<xsl:if test="beneficiary_abbv_name">
					<beneficiary_abbv_name>
						<xsl:value-of select="beneficiary_abbv_name"/>
					</beneficiary_abbv_name>
				</xsl:if>
				<xsl:if test="beneficiary_name">
					<beneficiary_name>
						<xsl:value-of select="beneficiary_name"/>
					</beneficiary_name>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_1">
					<beneficiary_address_line_1>
						<xsl:value-of select="beneficiary_address_line_1"/>
					</beneficiary_address_line_1>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_2">
					<beneficiary_address_line_2>
						<xsl:value-of select="beneficiary_address_line_2"/>
					</beneficiary_address_line_2>
				</xsl:if>
				<xsl:if test="beneficiary_dom">
					<beneficiary_dom>
						<xsl:value-of select="beneficiary_dom"/>
					</beneficiary_dom>
				</xsl:if>
				<xsl:if test="beneficiary_country">
					<beneficiary_country>
						<xsl:value-of select="beneficiary_country"/>
					</beneficiary_country>
				</xsl:if>
				<xsl:if test="beneficiary_reference">
					<beneficiary_reference>
						<xsl:value-of select="beneficiary_reference"/>
					</beneficiary_reference>
				</xsl:if>
				<xsl:if test="applicant_abbv_name">
					<applicant_abbv_name>
						<xsl:value-of select="applicant_abbv_name"/>
					</applicant_abbv_name>
				</xsl:if>
				<xsl:if test="applicant_name">
					<applicant_name>
						<xsl:value-of select="applicant_name"/>
					</applicant_name>
				</xsl:if>
				<xsl:if test="applicant_address_line_1">
					<applicant_address_line_1>
						<xsl:value-of select="applicant_address_line_1"/>
					</applicant_address_line_1>
				</xsl:if>
				<xsl:if test="applicant_address_line_2">
					<applicant_address_line_2>
						<xsl:value-of select="applicant_address_line_2"/>
					</applicant_address_line_2>
				</xsl:if>
				<xsl:if test="applicant_dom">
					<applicant_dom>
						<xsl:value-of select="applicant_dom"/>
					</applicant_dom>
				</xsl:if>
				<xsl:if test="applicant_reference">
					<applicant_reference>
						<xsl:value-of select="$customer_bank_reference"/>
					</applicant_reference>
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
				<xsl:if test="auth_reference">
					<auth_reference>
						<xsl:value-of select="auth_reference"/>
					</auth_reference>
				</xsl:if>
				<xsl:if test="further_identification">
					<further_identification>
						<xsl:value-of select="further_identification"/>
					</further_identification>
				</xsl:if>
				<xsl:if test="additional_amt">
					<additional_amt>
						<xsl:value-of select="additional_amt"/>
					</additional_amt>
				</xsl:if>

				<xsl:choose>
					<xsl:when test="additional_cur_code">
						<additional_cur_code>
							<xsl:value-of select="additional_cur_code"/>
						</additional_cur_code>
					</xsl:when>
					<xsl:otherwise>
					<xsl:if test="ls_cur_code">
						<additional_cur_code>
						  <xsl:value-of select="ls_cur_code"/>
						</additional_cur_code>
					</xsl:if>
					</xsl:otherwise>				
				</xsl:choose>

				<xsl:if test="origin_country">
					<origin_country>
						<xsl:value-of select="origin_country"/>
					</origin_country>
				</xsl:if>
				<xsl:if test="supply_country">
					<supply_country>
						<xsl:value-of select="supply_country"/>
					</supply_country>
				</xsl:if>
				<xsl:if test="latest_payment_date">
					<latest_payment_date>
						<xsl:value-of select="latest_payment_date"/>
					</latest_payment_date>
				</xsl:if>
				<xsl:if test="total_amt">
					<total_amt>
						<xsl:value-of select="total_amt"/>
					</total_amt>
				</xsl:if>
				<xsl:if test="total_cur_code">
					<total_cur_code>
						<xsl:value-of select="total_cur_code"/>
					</total_cur_code>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="reg_date">
					<reg_date>
						<xsl:value-of select="reg_date"/>
					</reg_date>
				</xsl:if>
				<xsl:if test="valid_to_date">
					<valid_to_date>
						<xsl:value-of select="valid_to_date"/>
					</valid_to_date>
				</xsl:if>
				<xsl:if test="valid_from_date">
					<valid_from_date>
						<xsl:value-of select="valid_from_date"/>
					</valid_from_date>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="valid_for_nb">
						<valid_for_nb>
							<xsl:value-of select="valid_for_nb"/>
						</valid_for_nb>
					</xsl:when>
					<xsl:otherwise>
						<valid_for_nb/>
					</xsl:otherwise>
				</xsl:choose>	
				<xsl:choose>
					<xsl:when test="valid_for_period">
						<valid_for_period>
							<xsl:value-of select="valid_for_period"/>
						</valid_for_period>
					</xsl:when>
					<xsl:otherwise>
						<valid_for_period/>
					</xsl:otherwise>
				</xsl:choose>		
				<xsl:if test="allow_multi_cur">
					<allow_multi_cur>
						<xsl:value-of select="allow_multi_cur"/>
					</allow_multi_cur>
				</xsl:if>
				<xsl:if test="ls_settlement_amt">
					<ls_settlement_amt>
						<xsl:value-of select="ls_settlement_amt"/>
					</ls_settlement_amt>
				</xsl:if>
				<xsl:if test="add_settlement_amt">
					<add_settlement_amt>
						<xsl:value-of select="add_settlement_amt"/>
					</add_settlement_amt>
				</xsl:if>
					<xsl:choose>
						<xsl:when test="prod_stat_code[.='08'] and sub_tnx_type_code[.='84'] and tnx_type_code[.='15']">
						<ls_clear>Y</ls_clear></xsl:when>
						<xsl:otherwise><ls_clear>N</ls_clear></xsl:otherwise>
					</xsl:choose>
				
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
				
				<xsl:apply-templates select="additional_field"/>
				
			</com.misys.portal.product.ls.common.License>
			
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="issuing_bank/name"><name><xsl:value-of select="issuing_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(issuing_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="issuing_bank/address_line_1"><address_line_1><xsl:value-of select="issuing_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="issuing_bank/address_line_2"><address_line_2><xsl:value-of select="issuing_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="issuing_bank/dom"><dom><xsl:value-of select="issuing_bank/dom"/></dom></xsl:if>
				<xsl:if test="issuing_bank/iso_code"><iso_code><xsl:value-of select="issuing_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="issuing_bank/reference"><reference><xsl:value-of select="issuing_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
						
			<!-- Narratives -->
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_description_goods"/>
				<xsl:with-param name="type_code">01</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_additional_instructions"/>
				<xsl:with-param name="type_code">03</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_additional_amount"/>
				<xsl:with-param name="type_code">05</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="bo_comment"/>
				<xsl:with-param name="type_code">11</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="free_format_text"/>
				<xsl:with-param name="type_code">12</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="amd_details"/>
				<xsl:with-param name="type_code">13</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			<!-- Create Charges elements -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
			
			<!-- Create Attachment elements for attachments which are part of the incoming xml-->
			<xsl:if test="tnx_stat_code">
				<xsl:apply-templates select="attachments/attachment">
					<xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
				</xsl:apply-templates>
			</xsl:if> 
			<!-- Creating attachments elements for existing attachments in database-->
			<xsl:for-each select="$references/references/attachments/attachment">
				<xsl:call-template name="attachment-details">
					<xsl:with-param name="attachment" select="."></xsl:with-param>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
		 		</xsl:call-template>
			</xsl:for-each>
			
			<!-- Following piece of code to retain the cross references if there are no referencs in the i\
				 incoming xml: Retrieve existing cross references and do the update on same -->
			<xsl:for-each select="$references/references/cross_references/cross_reference">
				<xsl:call-template name="cross_reference_details">
					<xsl:with-param name="cross_reference" select="."></xsl:with-param>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
		 		</xsl:call-template>
			</xsl:for-each>
			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="product_code" select="product_code"/>
			</xsl:apply-templates>
		
		</result>
	</xsl:template>
</xsl:stylesheet>
