<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
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
	<!-- Process IR-->
	<xsl:template match="ir_tnx_record">
		<result>
			<com.misys.portal.product.ir.common.InwardRemittance>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<!--  Product fields -->
				<!--  Missing cust_ref_id and appl_date  -->
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="company_name"/>
					</company_name>
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
				
				<!--  Transaction Product Fields -->
				<!--  Missing bo_inp, _ctl and _release fields -->
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
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
				<xsl:if test="remitter_country">
					<remitter_country>
						<xsl:value-of select="remitter_country"/>
					</remitter_country>
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
     </com.misys.portal.product.ir.common.InwardRemittance>
			<com.misys.portal.product.common.Bank role_code="06">
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
				<xsl:if test="remitting_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="remitting_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="remitting_bank_name">
					<name>
						<xsl:value-of select="remitting_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="remitting_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="remitting_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="remitting_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="remitting_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="remitting_bank_dom">
					<dom>
						<xsl:value-of select="remitting_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="remitting_bank_iso_code">
					<iso_code>
						<xsl:value-of select="remitting_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="remitting_bank_reference">
					<reference>
						<xsl:value-of select="remitting_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
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
			<com.misys.portal.product.common.Bank role_code="08">
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
				<xsl:if test="remitter_name">
					<name>
						<xsl:value-of select="remitter_name"/>
					</name>
				</xsl:if>
				<xsl:if test="remitter_address_line_1">
					<address_line_1>
						<xsl:value-of select="remitter_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="remitter_address_line_2">
					<address_line_2>
						<xsl:value-of select="remitter_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="remitter_dom">
					<dom>
						<xsl:value-of select="remitter_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="remitter_reference">
					<reference>
						<xsl:value-of select="remitter_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative type_code="06">
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
				<xsl:if test="narrative_payment_details">
					<text>
						<xsl:value-of select="narrative_payment_details"/>
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
			
			<xsl:if test="return_comments">
				<com.misys.portal.product.common.Narrative type_code="20">
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
					<xsl:if test="return_comments">
						<text>
							<xsl:value-of select="return_comments"/>
						</text>
					</xsl:if>
				</com.misys.portal.product.common.Narrative>
			</xsl:if>

			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ir_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ir_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ir_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ir_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ir_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ir_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ir_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ir_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'old_charge_details_position_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Cross References -->
			<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
				<xsl:call-template name="CROSS_REFERENCE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/company_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>