<?xml version="1.0"?>
<!-- 
Version: 1.0
Base Version: 1.6 -->
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
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
	<!-- Process TF -->
	<xsl:template match="tf_tnx_record">
		<result>
			<com.misys.portal.product.tf.common.FinancingRequest>
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
				<xsl:if test="fwd_contract_no">
					<fwd_contract_no>
						<xsl:value-of select="fwd_contract_no"/>
					</fwd_contract_no>
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
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
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
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="fin_cur_code">
					<fin_cur_code>
						<xsl:value-of select="fin_cur_code"/>
					</fin_cur_code>
				</xsl:if>
				<xsl:if test="fin_amt">
					<fin_amt>
						<xsl:value-of select="fin_amt"/>
					</fin_amt>
				</xsl:if>
				<xsl:if test="fin_liab_amt">
					<fin_liab_amt>
						<xsl:value-of select="fin_liab_amt"/>
					</fin_liab_amt>
				</xsl:if>
				<xsl:if test="fin_outstanding_amt">
					<fin_outstanding_amt>
						<xsl:value-of select="fin_outstanding_amt"/>
					</fin_outstanding_amt>
				</xsl:if>
				<xsl:if test="fin_type">
					<fin_type>
						<xsl:value-of select="fin_type"/>
					</fin_type>
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
				<xsl:if test="tenor">
					<tenor>
						<xsl:value-of select="tenor"/>
					</tenor>
				</xsl:if>
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="provisional_status">
					<provisional_status>
						<xsl:value-of select="provisional_status"/>
					</provisional_status>
				</xsl:if>
				<xsl:if test="req_pct">
					<req_pct>
						<xsl:value-of select="req_pct"/>
					</req_pct>
				</xsl:if>
				<xsl:if test="req_amt">
					<req_amt>
						<xsl:value-of select="req_amt"/>
					</req_amt>
				</xsl:if>
				<xsl:if test="req_cur_code">
					<req_cur_code>
						<xsl:value-of select="req_cur_code"/>
					</req_cur_code>
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
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
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
				<xsl:if test="related_reference">
					<additional_field name="related_reference" type="string" scope="master" description="Related Reference">
						<xsl:value-of select="related_reference"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bill_amt">
					<additional_field name="bill_amt" type="amount" scope="master" description="Bill Amount">
					<xsl:attribute name="currency">bill_amt_cur_code</xsl:attribute>
						<xsl:value-of select="bill_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bill_amt_cur_code">
					<additional_field name="bill_amt_cur_code" type="string" scope="master" description="Bill Amount Currency Code">
						<xsl:value-of select="bill_amt_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="description_of_goods">
					<additional_field name="description_of_goods" type="string" scope="master" description="Description of Goods">
						<xsl:value-of select="description_of_goods"/>
					</additional_field>
				</xsl:if>
				<!-- Client TF Message to Bank additional Fields -->
				<xsl:if test="interest_amt">
					<additional_field name="interest_amt" type="amount" scope="master" description="Interest Amount from Interface">
						<xsl:attribute name="currency">interest_cur_code</xsl:attribute>
						<xsl:value-of select="interest_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="interest_cur_code">
					<additional_field name="interest_cur_code" type="string" scope="master" description="Interest Currency Code">
						<xsl:value-of select="interest_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="repayment_mode">
					<additional_field name="repayment_mode" type="string" scope="master" description="Repayment Mode">
						<xsl:value-of select="repayment_mode"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="repayment_amt">
					<additional_field name="repayment_amt" type="amount" scope="master" description="Repayment Amount">
						<xsl:attribute name="currency">repayment_cur_code</xsl:attribute>
						<xsl:value-of select="repayment_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="repayment_cur_code">
					<additional_field name="repayment_cur_code" type="string" scope="master" description="Repayment Currency Code">
						<xsl:value-of select="repayment_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="settlement_code">
					<additional_field name="settlement_code" type="string" scope="master" description="Settlement Code">
						<xsl:value-of select="settlement_code"/>
					</additional_field>
				</xsl:if>
				<!--<xsl:if test="source_fund">
					<additional_field name="source_fund" type="string" scope="master" description="Settlement Code">
						<xsl:value-of select="source_fund"/>
					</additional_field>
				</xsl:if>
				--><!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="subject">
					<additional_field name="subject" type="string" scope="transaction" description="subject">
						<xsl:value-of select="subject"/>
			         </additional_field>
			    </xsl:if>
			    <xsl:if test="ibReference">
						<additional_field name="ibReference" type="string" scope="master">
							<xsl:value-of select="ibReference"/>
						</additional_field>
				</xsl:if>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
				<xsl:if test="subject">
					<additional_field name="subject" type="string" scope="transaction" description="subject">
						<xsl:value-of select="subject"/>
			         </additional_field>
			    </xsl:if>
			    <xsl:if test="sub_product_code_text">
					<additional_field name="sub_product_code_text" type="string" scope="master" description="sub_product_code_text">
						<xsl:value-of select="sub_product_code_text"/>
			         </additional_field>
			    </xsl:if>
			    			    
			    <xsl:call-template name="bank-instructions-act-fields"/>
			    
				<!-- FX Common Fields -->
				<xsl:call-template name="FX_DETAILS" />
			    
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.tf.common.FinancingRequest>
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
						<text>
							<xsl:value-of select="return_comments"/>
						</text>
				</com.misys.portal.product.common.Narrative>
			</xsl:if>
			<com.misys.portal.product.common.Narrative type_code="14">
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
				<xsl:if test="goods_desc">
					<text>
						<xsl:value-of select="goods_desc"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<!-- Create Charge element -->
			
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
			
			<!-- Cross References -->
			<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
				<xsl:call-template name="CROSS_REFERENCE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/company_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license"></xsl:apply-templates>
			</xsl:if>
			
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
