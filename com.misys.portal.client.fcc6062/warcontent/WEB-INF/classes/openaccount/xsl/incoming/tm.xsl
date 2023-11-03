<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">
			
	<!-- Process TMA transaction -->
	<xsl:template match="tu_tnx_record">
	
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageReferences('TM', //ref_id, //tnx_id, //bo_ref_id, //cust_ref_id, //company_id, //company_name, //applicant_reference, //issuing_bank/abbv_name, '01')"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
	
		<result>
			<com.misys.portal.tsu.common.TSUMessage>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code><xsl:value-of select="brch_code"/></brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id><xsl:value-of select="company_id"/></company_id>
				</xsl:if>
				<!-- <xsl:if test="entity">
					<entity> <xsl:value-of select="entity"/> </entity>
				</xsl:if>-->
				<xsl:if test="company_name">
					<company_name><xsl:value-of select="company_name"/></company_name>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code><xsl:value-of select="product_code"/></product_code>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code><xsl:value-of select="tnx_type_code"/></tnx_type_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code><xsl:value-of select="sub_tnx_type_code"/></sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code><xsl:value-of select="prod_stat_code"/></prod_stat_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code><xsl:value-of select="tnx_stat_code"/></tnx_stat_code>
				</xsl:if>
				<xsl:if test="org_tnx_id">
					<org_tnx_id><xsl:value-of select="org_tnx_id"/></org_tnx_id>
				</xsl:if>
				<xsl:if test="creation_date">
					<creation_date><xsl:value-of select="creation_date"/></creation_date>
				</xsl:if>
				<xsl:if test="bo_release_dttm">
					<bo_release_dttm><xsl:value-of select="bo_release_dttm"/></bo_release_dttm>
				</xsl:if>
				<!-- Amount and Currency -->
				<xsl:if test="ordered_amt">
					<ordered_amt><xsl:value-of select="ordered_amt"/></ordered_amt>
				</xsl:if>
				<xsl:if test="accepted_amount">
					<accepted_amt><xsl:value-of select="accepted_amt"/></accepted_amt>
				</xsl:if>
				<xsl:if test="cur_code">
					<cur_code><xsl:value-of select="cur_code"/></cur_code>
				</xsl:if>
				<!-- Tnx Amount and Currency -->
				<xsl:if test="tnx_val_date">
					<tnx_val_date><xsl:value-of select="tnx_val_date"/></tnx_val_date>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt><xsl:value-of select="tnx_amt"/></tnx_amt>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code><xsl:value-of select="tnx_cur_code"/></tnx_cur_code>
				</xsl:if>
				<xsl:if test="message_type">
					<message_type><xsl:value-of select="message_type"/></message_type>
				</xsl:if>
				<!-- TSU id -->
				<xsl:if test="tid">
					<tid><xsl:value-of select="tid"/></tid>
				</xsl:if>
				<xsl:if test="baseline_stat_code">
					<baseline_stat_code><xsl:value-of select="baseline_stat_code"/></baseline_stat_code>
				</xsl:if>
				<xsl:if test="link_ref_id">
					<link_ref_id><xsl:value-of select="link_ref_id"/></link_ref_id>
				</xsl:if>
				<xsl:if test="request_for_action">
					<request_for_action><xsl:value-of select="request_for_action"/></request_for_action>
				</xsl:if>
				<!-- Purchase order reference id -->
				<xsl:if test="po_ref_id">
					<po_ref_id><xsl:value-of select="po_ref_id"/></po_ref_id>
				</xsl:if>
				<!-- Counterparty -->
				<xsl:if test="cpty_ref_id">
					<cpty_ref_id><xsl:value-of select="cpty_ref_id"/></cpty_ref_id>
				</xsl:if>
				<xsl:if test="cpty_bank">
					<cpty_bank><xsl:value-of select="cpty_bank"/></cpty_bank>
				</xsl:if>
				<!-- Role -->
				<xsl:if test="role_code">
					<role_code><xsl:value-of select="role_code"/></role_code>
				</xsl:if>
				<!-- Buyer/Seller -->
				<xsl:if test="buyer_name">
					<buyer_name><xsl:value-of select="buyer_name"/></buyer_name>
				</xsl:if>
				<xsl:if test="seller_name">
					<seller_name><xsl:value-of select="seller_name"/></seller_name>
				</xsl:if>
				<!-- Customer -->
				<xsl:if test="company_id">
					<company_id><xsl:value-of select="company_id"/></company_id>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name><xsl:value-of select="company_name"/></company_name>
				</xsl:if>

				<xsl:if test="outstanding_amt">
					<outstanding_amt><xsl:value-of select="outstanding_amt" /></outstanding_amt>
				</xsl:if>
				<xsl:if test="pending_amt">
					<pending_amt><xsl:value-of select="pending_amt" /></pending_amt>
				</xsl:if>
				<xsl:if test="seller_bank_bic">
					<seller_bank_bic>
						<xsl:value-of select="seller_bank_bic"/>
					</seller_bank_bic>
				</xsl:if>
				<xsl:if test="buyer_bank_bic">
					<buyer_bank_bic>
						<xsl:value-of select="buyer_bank_bic"/>
					</buyer_bank_bic>
				</xsl:if>
				<xsl:if test="buyer_submitting_bank_bic">
					<buyer_submitting_bank_bic>
						<xsl:value-of select="buyer_submitting_bank_bic"/>
					</buyer_submitting_bank_bic>
				</xsl:if>
				<xsl:if test="seller_submitting_bank_bic">
					<seller_submitting_bank_bic>
						<xsl:value-of select="seller_submitting_bank_bic"/>
					</seller_submitting_bank_bic>
				</xsl:if>
				<xsl:if test="total_net_amt">
					<total_net_amt>
						<xsl:value-of select="total_net_amt"/>
					</total_net_amt>
				</xsl:if>
				<xsl:if test="po_issue_date">
					<po_issue_date>
						<xsl:value-of select="po_issue_date"/>
					</po_issue_date>
				</xsl:if>
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
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
				<!-- Report Type -->
				<xsl:if test="report_type">
					<report_type><xsl:value-of select="report_type"/></report_type>
				</xsl:if>
				
				<xsl:if test="rptid">
					<rptid><xsl:value-of select="rptid"/></rptid>
				</xsl:if>
				<xsl:if test="rptdate">
					<rptdate><xsl:value-of select="rptdate"/></rptdate>
				</xsl:if>				
				<xsl:if test="invoice_no">
					<invoice_no><xsl:value-of select="invoice_no"/></invoice_no>
				</xsl:if>
				<xsl:if test="error_msg">
					<error_msg><xsl:value-of select="error_msg"/></error_msg>
				</xsl:if>
				<xsl:if test="error_code">
					<error_code><xsl:value-of select="error_code"/></error_code>
				</xsl:if>
				<xsl:if test="tma_ack">
					<tma_ack><xsl:value-of select="tma_ack"/></tma_ack>
				</xsl:if>

			</com.misys.portal.tsu.common.TSUMessage>
			
			<!-- Issuing Bank  -->
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
			<!-- TSU XML message -->
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_xml"/>
				<xsl:with-param name="type_code">16</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
		</result>
	</xsl:template>
</xsl:stylesheet>
