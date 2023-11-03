<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2012 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">
			
	<!-- Process IR-->
	<xsl:template match="ir_tnx_record">
	
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageTradeReferences(//product_code, //ref_id, //tnx_id, //bo_ref_id, //bo_tnx_id, //cust_ref_id, //company_id, //company_name, //beneficiary_reference, //remitting_bank/abbv_name, '06', //prod_stat_code, //tnx_type_code)"/>
		
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
	
		<result>
			<com.misys.portal.product.ir.common.InwardRemittance>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>

				<!--  Product fields -->
				<!--  Missing cust_ref_id and appl_date  -->
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="$entity!='' and not(entity)">
					<entity><xsl:value-of select="$entity"/></entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
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
				<xsl:if test="sub_tnx_stat_code">
					<sub_tnx_stat_code>
						<xsl:value-of select="sub_tnx_stat_code"/>
					</sub_tnx_stat_code>
				</xsl:if>
				<product_code>IR</product_code>
				
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
				
				<!--  Transaction Product Fields -->
				<!--  Missing bo_inp, _ctl and _release fields -->
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
				<xsl:if test="inp_user_id">
					<inp_user_id>
						<xsl:value-of select="inp_user_id"/>
					</inp_user_id>
				</xsl:if>
				<xsl:if test="inp_dttm">
					<inp_dttm>
						<xsl:value-of select="inp_dttm"/>
					</inp_dttm>
				</xsl:if>
				<xsl:if test="ctl_user_id">
					<ctl_user_id>
						<xsl:value-of select="ctl_user_id"/>
					</ctl_user_id>
				</xsl:if>
				<xsl:if test="ctl_dttm">
					<ctl_dttm>
						<xsl:value-of select="ctl_dttm"/>
					</ctl_dttm>
				</xsl:if>
				<xsl:if test="release_user_id">
					<release_user_id>
						<xsl:value-of select="release_user_id"/>
					</release_user_id>
				</xsl:if>
				<xsl:if test="release_dttm">
					<release_dttm>
						<xsl:value-of select="release_dttm"/>
					</release_dttm>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
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
				<!--  Inward Remittance Fields -->
	  			<xsl:if test="fwd_contract_no">
					<fwd_contract_no>
						<xsl:value-of select="fwd_contract_no"/>
					</fwd_contract_no>
				</xsl:if>
				<xsl:if test="act_no">
					<act_no>
						<xsl:value-of select="act_no"/>
					</act_no>
				</xsl:if>
	  			<xsl:if test="link_tnx_id">
					<link_tnx_id>
						<xsl:value-of select="link_tnx_id"/>
					</link_tnx_id>
				</xsl:if>
	  			<xsl:if test="instructions_required">
					<instructions_required>
						<xsl:value-of select="instructions_required"/>
					</instructions_required>
				</xsl:if>
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no"/>
					</fee_act_no>
				</xsl:if>
				<xsl:if test="remittance_date">
					<remittance_date>
						<xsl:value-of select="remittance_date"/>
					</remittance_date>
				</xsl:if>
				<xsl:if test="ir_cur_code">
					<ir_cur_code>
						<xsl:value-of select="ir_cur_code"/>
					</ir_cur_code>
				</xsl:if>
				<xsl:if test="ir_amt">
					<ir_amt>
						<xsl:value-of select="ir_amt"/>
					</ir_amt>
				</xsl:if>
				<xsl:if test="ir_liab_amt">
					<ir_liab_amt>
						<xsl:value-of select="ir_liab_amt"/>
					</ir_liab_amt>
				</xsl:if>
				<xsl:if test="ir_outstanding_amt">
					<ir_outstanding_amt>
						<xsl:value-of select="ir_outstanding_amt"/>
					</ir_outstanding_amt>
				</xsl:if>
				<xsl:if test="ir_type_code">
					<ir_type_code>
						<xsl:value-of select="ir_type_code"/>
					</ir_type_code>
				</xsl:if>
				<xsl:if test="ir_sub_type_code">
					<ir_sub_type_code>
						<xsl:value-of select="ir_sub_type_code"/>
					</ir_sub_type_code>
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
				<xsl:if test="beneficiary_reference">
					<beneficiary_reference>
						<xsl:value-of select="$customer_bank_reference"/>
					</beneficiary_reference>
				</xsl:if>
				<xsl:if test="remitter_abbv_name">
					<remitter_abbv_name>
						<xsl:value-of select="remitter_abbv_name"/>
					</remitter_abbv_name>
				</xsl:if>
				<xsl:if test="remitter_name">
					<remitter_name>
						<xsl:value-of select="remitter_name"/>
					</remitter_name>
				</xsl:if>
				<xsl:if test="remitter_address_line_1">
					<remitter_address_line_1>
						<xsl:value-of select="remitter_address_line_1"/>
					</remitter_address_line_1>
				</xsl:if>
				<xsl:if test="remitter_address_line_2">
					<remitter_address_line_2>
						<xsl:value-of select="remitter_address_line_2"/>
					</remitter_address_line_2>
				</xsl:if>
				<xsl:if test="remitter_dom">
					<remitter_dom>
						<xsl:value-of select="remitter_dom"/>
					</remitter_dom>
				</xsl:if>
				<xsl:if test="remitter_reference">
					<remitter_reference>
						<xsl:value-of select="remitter_reference"/>
					</remitter_reference>
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
				
				<xsl:if test="bo_release_dttm">
				<additional_field name="bo_release_dttm" type="time" scope="none" description=" back office release dttm">
				<xsl:value-of select="bo_release_dttm"/>
				</additional_field>
				</xsl:if>
				<xsl:apply-templates select="additional_field"/>
			</com.misys.portal.product.ir.common.InwardRemittance>
			
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="06">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="remitting_bank/name"><name><xsl:value-of select="remitting_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(remitting_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="remitting_bank/address_line_1"><address_line_1><xsl:value-of select="remitting_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="remitting_bank/address_line_2"><address_line_2><xsl:value-of select="remitting_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="remitting_bank/dom"><dom><xsl:value-of select="remitting_bank/dom"/></dom></xsl:if>
				<xsl:if test="remitting_bank/iso_code"><iso_code><xsl:value-of select="remitting_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="remitting_bank/reference"><reference><xsl:value-of select="remitting_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>

			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="issuing_bank"/>
				<xsl:with-param name="role_code">01</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
						
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="remitter"/>
				<xsl:with-param name="role_code">09</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
				
			<!-- Narratives -->
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_payment_details"/>
				<xsl:with-param name="type_code">06</xsl:with-param>
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
			
			<!-- Create Charge element -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
			
			<!-- Create Attachment elements -->
			<xsl:if test="tnx_stat_code">
				<xsl:apply-templates select="attachments/attachment">
					<xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
				</xsl:apply-templates>
			</xsl:if>
					
			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference"/>
			
		</result>
	</xsl:template>
</xsl:stylesheet>