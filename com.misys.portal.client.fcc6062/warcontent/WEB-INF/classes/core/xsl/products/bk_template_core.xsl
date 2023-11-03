<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Template BK-->
	<xsl:template match="bk_tnx_record">
		<result>
			<com.misys.portal.product.bk.common.TemplateBulk>
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="company_name"/>
					</company_name>
				</xsl:if>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<!-- This field is being used to persist the entity value as  
					the field 'entity' will not be
				    populated when form is loaded in the following cases 
				    1.Add a transaction to the bulk and click on template
				    2.Retrieve the template and change the template and click on template
				    3.Modify an transaction in the bulk 
				    in all the above cases the entity 'field' which is actually a look up
				    wont be displayed and only the field in view mode is displayed. -->
				<xsl:if test="entity_hidden">
					<entity>
						<xsl:value-of select="entity_hidden"/>
					</entity>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code>
						<xsl:value-of select="prod_stat_code"/>
					</prod_stat_code>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="bk_type">
					<bk_type>
						<xsl:value-of select="bk_type"/>
					</bk_type>
				</xsl:if>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
				<xsl:if test="child_product_code">
					<child_product_code>
						<xsl:value-of select="child_product_code"/>
					</child_product_code>
				</xsl:if>
				<xsl:if test="child_sub_product_code">
					<child_sub_product_code>
						<xsl:value-of select="child_sub_product_code"/>
					</child_sub_product_code>
				</xsl:if>
				<xsl:if test="payroll_type">
					<additional_field name="payroll_type" type="string" scope="master" description="Payroll type">
						<xsl:value-of select="payroll_type"/>
					</additional_field>
				</xsl:if>
			   <xsl:if test="clearing_code">
					<additional_field name="clearing_code" type="string" scope="master" description="Clearing Code">
						<xsl:value-of select="clearing_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code"/>
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="applicant_act_pab">
					<additional_field name="applicant_act_pab" type="string" scope="master">
						<xsl:value-of select="applicant_act_pab"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="tnx_stat_code and tnx_stat_code != ''">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code"/>
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="value_date">
					<value_date>
						<xsl:value-of select="value_date"/>
					</value_date>
				</xsl:if>
			<!-- 	<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if> -->
				<xsl:if test="bk_product_code">
					<bk_product_code>
						<xsl:value-of select="bk_product_code"/>
					</bk_product_code>
				</xsl:if>
				<xsl:if test="bk_cur_code">
					<bk_cur_code>
						<xsl:value-of select="bk_cur_code"/>
					</bk_cur_code>
				</xsl:if>
				<xsl:if test="bk_total_amt">
					<bk_total_amt>
						<xsl:value-of select="bk_total_amt"/>
					</bk_total_amt>
				</xsl:if>
				<xsl:if test="bk_highest_amt">
					<bk_highest_amt>
						<xsl:value-of select="bk_highest_amt"/>
					</bk_highest_amt>
				</xsl:if>
				<xsl:if test="record_number">
					<record_number>
						<xsl:value-of select="record_number"/>
					</record_number>
				</xsl:if>
				<xsl:if test="rate">
					<rate>
						<xsl:value-of select="rate"/>
					</rate>
				</xsl:if>
				<xsl:if test="fwd_contract_no">
					<fwd_contract_no>
						<xsl:value-of select="fwd_contract_no"/>
					</fwd_contract_no>
				</xsl:if>
				<xsl:if test="applicant_act_no != '' or applicant_collection_act_no = ''">
					<applicant_act_no>
						<xsl:value-of select="applicant_act_no"/>
					</applicant_act_no>
				</xsl:if>
				<xsl:if test="applicant_collection_act_no != ''">
					<applicant_act_no>
						<xsl:value-of select="applicant_collection_act_no"/>
					</applicant_act_no>
				</xsl:if>
				<xsl:if test="applicant_act_description != '' or applicant_collection_act_description = ''">
					<applicant_act_description>
						<xsl:value-of select="applicant_act_description"/>
					</applicant_act_description>
				</xsl:if>
				<xsl:if test="applicant_collection_act_description != ''">
					<applicant_act_description>
						<xsl:value-of select="applicant_collection_act_description"/>
					</applicant_act_description>
				</xsl:if>
				<xsl:if test="applicant_act_cur_code !='' or applicant_collection_act_cur_code = ''">
					<applicant_act_cur_code>
						<xsl:value-of select="applicant_act_cur_code"/>
					</applicant_act_cur_code>
				</xsl:if>
				<xsl:if test="applicant_collection_act_cur_code != ''">
					<applicant_act_cur_code>
						<xsl:value-of select="applicant_collection_act_cur_code"/>
					</applicant_act_cur_code>
				</xsl:if>				
				<xsl:if test="applicant_act_name != '' or applicant_collection_act_name = ''">
					<applicant_act_name>
						<xsl:value-of select="applicant_act_name"/>
					</applicant_act_name>
				</xsl:if>
				<xsl:if test="applicant_collection_act_name != ''">
					<applicant_act_name>
						<xsl:value-of select="applicant_collection_act_name"/>
					</applicant_act_name>
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
				<xsl:if test="applicant_country">
					<applicant_country>
						<xsl:value-of select="applicant_country"/>
					</applicant_country>
				</xsl:if>
				<xsl:if test="applicant_reference">
					<applicant_reference>
						<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="open_chrg_brn_by_code">
					<open_chrg_brn_by_code>
						<xsl:value-of select="open_chrg_brn_by_code"/>
					</open_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="feeAccount">
					<fee_act_no>
						<xsl:value-of select="feeAccount"/>
					</fee_act_no>
				</xsl:if>
				<xsl:if test="feeAmt">
					<fee_amt>
						<xsl:value-of select="feeAmt"/>
					</fee_amt>
				</xsl:if>
				<xsl:if test="feeCurCode">
					<fee_cur_code>
						<xsl:value-of select="feeCurCode"/>
					</fee_cur_code>
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
				<xsl:if test="adv_send_mode">
					<adv_send_mode>
						<xsl:value-of select="adv_send_mode"/>
					</adv_send_mode>
				</xsl:if>
				<xsl:if test="priority">
					<priority>
						<xsl:value-of select="priority"/>
					</priority>
				</xsl:if>		
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
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
				
				<xsl:if test="pre_approved">
					<additional_field name="pre_approved" type="string" scope="master">
						<xsl:value-of select="pre_approved"/>
					</additional_field>
				</xsl:if>	
				
				<xsl:if test="pre_approved_status">
					<additional_field name="pre_approved_status" type="string" scope="master">
						<xsl:value-of select="pre_approved_status"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="applicant_act_pab">
					<additional_field name="applicant_act_pab" type="string" scope="master">
						<xsl:value-of select="applicant_act_pab"/>
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
     </com.misys.portal.product.bk.common.TemplateBulk>
			<com.misys.portal.product.common.TemplateBank role_code="01">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
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
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="11">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="account_with_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="account_with_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="account_with_bank_name">
					<name>
						<xsl:value-of select="account_with_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="account_with_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="account_with_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="account_with_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="account_with_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="account_with_bank_dom">
					<dom>
						<xsl:value-of select="account_with_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="account_with_bank_iso_code">
					<iso_code>
						<xsl:value-of select="account_with_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="account_with_bank_reference">
					<reference>
						<xsl:value-of select="account_with_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="12">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="pay_through_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="pay_through_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="pay_through_bank_name">
					<name>
						<xsl:value-of select="pay_through_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="pay_through_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="pay_through_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="pay_through_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="pay_through_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="pay_through_bank_dom">
					<dom>
						<xsl:value-of select="pay_through_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="pay_through_bank_iso_code">
					<iso_code>
						<xsl:value-of select="pay_through_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="pay_through_bank_reference">
					<reference>
						<xsl:value-of select="pay_through_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateNarrative type_code="03">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="narrative_additional_instructions">
					<text>
						<xsl:value-of select="narrative_additional_instructions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="11">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="12">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
</xsl:stylesheet>