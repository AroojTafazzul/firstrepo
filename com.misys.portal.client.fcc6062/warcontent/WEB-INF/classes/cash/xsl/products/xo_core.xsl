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
	<!-- Process Foreign Exchange -->
	<xsl:template match="xo_tnx_record">
		<result>
			<com.misys.portal.cash.product.xo.common.ForeignExchangeOrder>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
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
				<xsl:if test="fx_cur_code">
					<fx_cur_code>
						<xsl:value-of select="fx_cur_code"/>
					</fx_cur_code>
				</xsl:if>
				<xsl:if test="fx_amt">
					<fx_amt>
						<xsl:value-of select="fx_amt"/>
					</fx_amt>
				</xsl:if>
				<xsl:if test="fx_liab_amt">
					<fx_liab_amt>
						<xsl:value-of select="fx_liab_amt"/>
					</fx_liab_amt>
				</xsl:if>
				<xsl:if test="fx_type">
					<fx_type>
						<xsl:value-of select="fx_type"/>
					</fx_type>
				</xsl:if>
				<xsl:if test="expiration_code">
					<expiration_code>
						<xsl:value-of select="expiration_code"/>
					</expiration_code>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="expiration_date_date and expiration_date_number[.='']">
						<expiration_date>
							<xsl:value-of select="expiration_date_date"/>
						</expiration_date>
					</xsl:when>
					<xsl:otherwise>
						<expiration_date></expiration_date>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="expiration_date_number">
					<expiration_date_term_number>
						<xsl:value-of select="expiration_date_number"/>
					</expiration_date_term_number>
				</xsl:if>				
				<xsl:if test="expiration_date_code">
					<expiration_date_term_code>
						<xsl:value-of select="expiration_date_code"/>
					</expiration_date_term_code>
				</xsl:if>				
				<xsl:if test="expiration_time">
					<expiration_time>
						<xsl:value-of select="expiration_time"/>
					</expiration_time>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="value_date and value_number[.='']">
						<value_date>
							<xsl:value-of select="value_date"/>
						</value_date>
					</xsl:when>
					<xsl:otherwise>
						<value_date></value_date>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="value_number">
					<value_date_term_number>
						<xsl:value-of select="value_number"/>
					</value_date_term_number>
				</xsl:if>				
				
				<xsl:if test="value_code">
					<value_date_term_code>
						<xsl:value-of select="value_code"/>
					</value_date_term_code>
				</xsl:if>				
				
				<xsl:if test="market_order">
					<market_order>
						<xsl:value-of select="market_order"/>
					</market_order>
				</xsl:if>
				<xsl:if test="trigger_pos">
					<trigger_pos>
						<xsl:value-of select="trigger_pos"/>
					</trigger_pos>
				</xsl:if>
				<xsl:if test="trigger_stop">
					<trigger_stop>
						<xsl:value-of select="trigger_stop"/>
					</trigger_stop>
				</xsl:if>
				<xsl:if test="trigger_limit">
					<trigger_limit>
						<xsl:value-of select="trigger_limit"/>
					</trigger_limit>
				</xsl:if>
				<xsl:if test="counter_cur_code">
					<counter_cur_code>
						<xsl:value-of select="counter_cur_code"/>
					</counter_cur_code>
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
						<xsl:value-of select="applicant_reference"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no"/>
					</fee_act_no>
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
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="settlement_amt">
					<settlement_amt>
						<xsl:value-of select="settlement_amt"/>
					</settlement_amt>
				</xsl:if>
				<xsl:if test="settlement_cur_code">
					<settlement_cur_code>
						<xsl:value-of select="settlement_cur_code"/>
					</settlement_cur_code>
				</xsl:if>
				<xsl:if test="rate">
					<rate>
						<xsl:value-of select="rate"/>
					</rate>
				</xsl:if>
				<xsl:if test="contract_type">
					<contract_type>
						<xsl:value-of select="contract_type"/>
					</contract_type>
				</xsl:if>
				<xsl:if test="purchase_sale_code">
					<purchase_sale_code>
						<xsl:value-of select="purchase_sale_code"/>
					</purchase_sale_code>
				</xsl:if>
				<xsl:if test="trade_id">
					<trade_id>
						<xsl:value-of select="trade_id"/>
					</trade_id>
				</xsl:if>
				
				<!-- Cancel raison -->
				<xsl:if test="reason">
					<additional_field name="cancel_reason" type="string" scope="transaction" description="Cancel reason">
						<xsl:value-of select="reason"/>
					</additional_field>
				</xsl:if>
				<!-- Previous ctl date, used for synchronization issues -->
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
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="remarks">
					<remarks>
						<xsl:value-of select="remarks"></xsl:value-of>
					</remarks>
				</xsl:if>
				<xsl:if test="seq">
					<seq>
						<xsl:value-of select="seq"></xsl:value-of>
					</seq>
				</xsl:if>
				<xsl:if test="watcher">
					<watcher>
						<xsl:value-of select="watcher"></xsl:value-of>
					</watcher>
				</xsl:if>
				<xsl:if test="action">
					<action>
						<xsl:value-of select="action"></xsl:value-of>
					</action>
				</xsl:if>
				<xsl:if test="trader">
					<trader>
						<xsl:value-of select="trader"></xsl:value-of>
					</trader>
				</xsl:if>

			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.xo.common.ForeignExchangeOrder>
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
				<type_code>12</type_code>
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
					<xsl:with-param name="brchCode"><xsl:value-of select="//ft_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ft_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ft_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ft_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ft_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ft_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ft_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ft_tnx_record/tnx_id"/></xsl:with-param>
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
