<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">	
	<!-- Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All 
		Rights Reserved. -->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl" />

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/se_save_common.xsl" />

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process FA -->
	<xsl:template match="fa_tnx_record">
	<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<result>
			<com.misys.portal.product.fa.common.Factoring>
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
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity" />
					</entity>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="company_name" />
					</company_name>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code" />
					</product_code>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id" />
					</bo_tnx_id>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id" />
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id" />
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date" />
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date" />
					</appl_date>
				</xsl:if>
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date" />
					</iss_date>
				</xsl:if>
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date" />
					</exp_date>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code" />
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt" />
					</tnx_amt>
				</xsl:if>
				<xsl:if test="fa_cur_code">
					<fa_cur_code>
						<xsl:value-of select="fa_cur_code" />
					</fa_cur_code>
				</xsl:if>
				<xsl:if test="fa_amt">
					<fa_amt>
						<xsl:value-of select="fa_amt" />
					</fa_amt>
				</xsl:if>
				<xsl:if test="imp_bill_ref_id">
					<imp_bill_ref_id>
						<xsl:value-of select="imp_bill_ref_id" />
					</imp_bill_ref_id>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code" />
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code" />
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code>
						<xsl:value-of select="prod_stat_code" />
					</prod_stat_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code" />
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="applicant_abbv_name">
					<applicant_abbv_name>
						<xsl:value-of select="applicant_abbv_name" />
					</applicant_abbv_name>
				</xsl:if>
				<xsl:if test="applicant_name">
					<applicant_name>
						<xsl:value-of select="applicant_name" />
					</applicant_name>
				</xsl:if>
				<xsl:if test="applicant_address_line_1">
					<applicant_address_line_1>
						<xsl:value-of select="applicant_address_line_1" />
					</applicant_address_line_1>
				</xsl:if>
				<xsl:if test="applicant_address_line_2">
					<applicant_address_line_2>
						<xsl:value-of select="applicant_address_line_2" />
					</applicant_address_line_2>
				</xsl:if>
				<xsl:if test="applicant_dom">
					<applicant_dom>
						<xsl:value-of select="applicant_dom" />
					</applicant_dom>
				</xsl:if>
				<xsl:if test="applicant_country">
					<applicant_country>
						<xsl:value-of select="applicant_country" />
					</applicant_country>
				</xsl:if>
				<xsl:if test="applicant_reference">
					<applicant_reference>
						<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="principal_act_no">
					<principal_act_no>
						<xsl:value-of select="principal_act_no" />
					</principal_act_no>
				</xsl:if>
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no" />
					</fee_act_no>
				</xsl:if>
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time"
						scope="none" description="Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm" />
					</additional_field>
				</xsl:if>
				<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time"
						scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm" />
					</additional_field>
				</xsl:if>
				<xsl:if test="request_max_amt">
					<request_max_amt>
						<xsl:value-of select="request_max_amt" />
					</request_max_amt>
				</xsl:if>
				<xsl:if test="credit_act_no">
					<credit_act_no>
						<xsl:value-of select="credit_act_no" />
					</credit_act_no>
				</xsl:if>
				
				<xsl:if test="client_code">
					<additional_field name="client_code" type="string"
						scope="master" description="Client Code">
						<xsl:value-of select="client_code" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="short_name">
					<additional_field name="short_name" type="string"
						scope="master" description="Client Short Name">
						<xsl:value-of select="short_name" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="account_type">
					<additional_field name="account_type" type="string"
						scope="master" description="Account Type">
						<xsl:value-of select="account_type" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="account_type_des">
					<additional_field name="account_type_des" type="string"
						scope="master" description="Account Type Description">
						<xsl:value-of select="account_type_des" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="processing_date">
					<additional_field name="processing_date" type="string"
						scope="master" description="Processing Date">
						<xsl:value-of select="processing_date" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="amt_avail_for_adv_payment">
					<additional_field name="amt_avail_for_adv_payment" type="string"
						scope="master" description="Drawdown Amount">
						<xsl:value-of select="amt_avail_for_adv_payment" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="adv_currency">
					<additional_field name="adv_currency" type="string"
						scope="master" description="Advance Currency">
						<xsl:value-of select="adv_currency" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="adv_currency_name">
					<additional_field name="adv_currency_name" type="string"
						scope="master" description="Advance Currency Name">
						<xsl:value-of select="adv_currency_name" />
					</additional_field>
				</xsl:if>
				
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string"
						scope="none" description="Security token">
						<xsl:value-of select="token" />
					</additional_field>
				</xsl:if>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION" />
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
				
				<xsl:call-template name="bank-instructions-act-fields"/>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.fa.common.Factoring>
			<com.misys.portal.product.common.Bank
				role_code="01">
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
				<xsl:if test="issuing_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="issuing_bank_abbv_name" />
					</abbv_name>
				</xsl:if>
				<xsl:if test="issuing_bank_name">
					<name>
						<xsl:value-of select="issuing_bank_name" />
					</name>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="issuing_bank_address_line_1" />
					</address_line_1>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="issuing_bank_address_line_2" />
					</address_line_2>
				</xsl:if>
				<xsl:if test="issuing_bank_dom">
					<dom>
						<xsl:value-of select="issuing_bank_dom" />
					</dom>
				</xsl:if>
				<xsl:if test="issuing_bank_iso_code">
					<iso_code>
						<xsl:value-of select="issuing_bank_iso_code" />
					</iso_code>
				</xsl:if>
				<xsl:if test="issuing_bank_reference">
					<reference>
						<xsl:value-of select="issuing_bank_reference" />
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative
				type_code="11">
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
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative
				type_code="12">
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
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative
				type_code="14">
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
				<xsl:if test="goods_desc">
					<text>
						<xsl:value-of select="goods_desc" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>

			<!-- Create Charge element -->

			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each
				select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode">
						<xsl:value-of select="//fa_tnx_record/brch_code" />
					</xsl:with-param>
					<xsl:with-param name="companyId">
						<xsl:value-of select="//fa_tnx_record/company_id" />
					</xsl:with-param>
					<xsl:with-param name="refId">
						<xsl:value-of select="//fa_tnx_record/ref_id" />
					</xsl:with-param>
					<xsl:with-param name="tnxId">
						<xsl:value-of select="//fa_tnx_record/tnx_id" />
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of
							select="substring-after(name(), 'charge_details_chrg_details_')" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>

			<!-- Second, the charges inputted earlier -->
			<xsl:for-each
				select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode">
						<xsl:value-of select="//fa_tnx_record/brch_code" />
					</xsl:with-param>
					<xsl:with-param name="companyId">
						<xsl:value-of select="//fa_tnx_record/company_id" />
					</xsl:with-param>
					<xsl:with-param name="refId">
						<xsl:value-of select="//fa_tnx_record/ref_id" />
					</xsl:with-param>
					<xsl:with-param name="tnxId">
						<xsl:value-of select="//fa_tnx_record/tnx_id" />
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of
							select="substring-after(name(), 'old_charge_details_position_')" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>

			<!-- Cross References -->
			<xsl:for-each
				select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
				<xsl:call-template name="CROSS_REFERENCE">
					<xsl:with-param name="brchCode">
						<xsl:value-of select="/brch_code" />
					</xsl:with-param>
					<xsl:with-param name="companyId">
						<xsl:value-of select="/company_id" />
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of
							select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>

		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
