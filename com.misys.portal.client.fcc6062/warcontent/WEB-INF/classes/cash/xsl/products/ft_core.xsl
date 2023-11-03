<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
                exclude-result-prefixes="utils service">

	<!--
	   Copyright (c) 2000-2012 Misys (http://www.misys.com),
	   All Rights Reserved. 
	-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	<xsl:include href="../../../cash/xsl/cash_save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process FT -->
	<xsl:template match="ft_tnx_record">
		<result>
			<com.misys.portal.cash.product.ft.common.FundTransfer>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>			
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
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date"/>
					</iss_date>
				</xsl:if>
				<xsl:if test="not(iss_date)">
			     <iss_date>
			      <xsl:value-of select="iss_date_unsigned"/>
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
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
				<xsl:if test="ft_cur_code">
					<ft_cur_code>
						<xsl:value-of select="ft_cur_code"/>
					</ft_cur_code>
				</xsl:if>
				<xsl:if test="applicant_cur_code">
					<ft_cur_code>
						<xsl:value-of select="applicant_cur_code"/>
					</ft_cur_code>
				</xsl:if>
				<xsl:if test="ft_amt">
					<ft_amt>
						<xsl:value-of select="ft_amt"/>
					</ft_amt>
				</xsl:if>
				<xsl:if test="ft_type">
					<ft_type>
						<xsl:value-of select="ft_type"/>
					</ft_type>
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
				<xsl:if test="debitAccountNumber">
					<applicant_act_no>
						<xsl:value-of select="debitAccountNumber"/>
					</applicant_act_no>
				</xsl:if>	
				<xsl:if test="debitAccountCurr">
					<applicant_act_cur_code>
						<xsl:value-of select="debitAccountCurr"/>
					</applicant_act_cur_code>
				</xsl:if>	
				<xsl:if test="debitAccountDescription">
					<applicant_act_description>
						<xsl:value-of select="debitAccountDescription"/>
					</applicant_act_description>
				</xsl:if>	
				<xsl:if test="debitAccountName">
					<applicant_act_name>
						<xsl:value-of select="debitAccountName"/>
					</applicant_act_name>
				</xsl:if>	
				<xsl:if test="applicant_act_no">
					<applicant_act_no>
						<xsl:value-of select="applicant_act_no"/>
					</applicant_act_no>
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
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no"/>
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
				<xsl:if test="particular">
					<additional_field name="particular" type="string" scope="master" description="Particular">
						<xsl:value-of select="particular"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bk_particular">
					<additional_field name="bk_particular" type="string" scope="master" description="Bulk Particulars when a fundtransfer added from bulk">
						<xsl:value-of select="bk_particular"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bk_transaction_code">
					<additional_field name="bk_transaction_code" type="string" scope="master" description="Bulk Transaction  when a fundtransfer added from bulk">
						<xsl:value-of select="bk_transaction_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bk_reference">
					<additional_field name="bk_reference" type="string" scope="master" description="reference">
						<xsl:value-of select="bk_reference"/>
					</additional_field>
				</xsl:if>
                <!-- applicant_act_no might come in the transfer_from field. -->
				<xsl:if test="transfer_from">
					<applicant_act_no>
							<xsl:value-of select="transfer_from"/>
					</applicant_act_no>
				</xsl:if>
				<xsl:if test="applicant_act_cur_code">
					<applicant_act_cur_code>
							<xsl:value-of select="applicant_act_cur_code"/>
					</applicant_act_cur_code>
				</xsl:if>
				<xsl:if test="(payment_cur_code and payment_cur_code[.!= '']) and (payment_amt[.!= ''] and sub_product_code[.='TRTPT'])">
					<ft_cur_code>
						<xsl:value-of select="payment_cur_code" />
					</ft_cur_code>
				</xsl:if>
				<xsl:if test="payment_amt and payment_amt[.!= ''] and sub_product_code[.='TRTPT']">
					<ft_amt>
						<xsl:value-of select="payment_amt" />
					</ft_amt>
				</xsl:if>
				<xsl:if test="applicant_act_amt and applicant_act_amt[.!= ''] and sub_product_code[.='TRTPT']">
					<ft_amt>
						<xsl:value-of select="applicant_act_amt" />
					</ft_amt>
				</xsl:if>
								
				<xsl:if test="applicant_act_name">
					<applicant_act_name>
							<xsl:value-of select="applicant_act_name"/>
					</applicant_act_name>
				</xsl:if>
				<xsl:if test="applicant_act_description">
					<applicant_act_description>
							<xsl:value-of select="applicant_act_description"/>
					</applicant_act_description>
				</xsl:if>
		
				<xsl:if test="bo_account_id">
					<additional_field name="bo_account_id" type="string" scope="master">
							<xsl:value-of select="bo_account_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_type">
					<additional_field name="bo_account_type" type="string" scope="master">
							<xsl:value-of select="bo_account_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_currency">
					<additional_field name="bo_account_currency" type="string" scope="master">
							<xsl:value-of select="bo_account_currency"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_branch_code">
					<additional_field name="bo_branch_code" type="string" scope="master">
							<xsl:value-of select="bo_branch_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_product_type">
					<additional_field name="bo_product_type" type="string" scope="master">
							<xsl:value-of select="bo_product_type"/>
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
				<xsl:if test="pre_approved_dttm">
					<additional_field name="pre_approved_dttm" type="date" scope="master">
						<xsl:value-of select="pre_approved_dttm"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="beneficiary_mode">
					<additional_field name="beneficiary_mode" type="string" scope="master">
						<xsl:value-of select="beneficiary_mode"/>
					</additional_field>
				</xsl:if>					
				<xsl:if test="product_type">
					<additional_field name="product_type" type="string" scope="master">
						<xsl:value-of select="product_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_customer_name">
					<additional_field name="ordering_customer_name" type="string" scope="master">
						<xsl:value-of select="ordering_customer_name"/>
					</additional_field>
				</xsl:if>	
				 <xsl:if test="urgent_transfer">
            <additional_field name="urgent_transfer" type="string" scope="master">
                <xsl:value-of select="urgent_transfer" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="business_type">
            <additional_field name="business_type" type="string" scope="master">
                <xsl:value-of select="business_type" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="business_detail_type">
            <additional_field name="business_detail_type" type="string" scope="master">
                <xsl:value-of select="business_detail_type" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="cnaps_bank_code">
            <additional_field name="cnaps_bank_code" type="string" scope="master">
                <xsl:value-of select="cnaps_bank_code" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="cnaps_bank_name">
            <additional_field name="cnaps_bank_name" type="string" scope="master">
                <xsl:value-of select="cnaps_bank_name" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="related_transaction_date">
            <additional_field name="related_transaction_date" type="date" scope="master">
                <xsl:value-of select="related_transaction_date" />
                
            </additional_field>
        </xsl:if>				
        <xsl:if test="cross_border_remark">
            <additional_field name="cross_border_remark" type="string" scope="master">
                <xsl:value-of select="cross_border_remark" />
            </additional_field>
        </xsl:if>				
		<xsl:if test="routing_identifier_nra">
            <additional_field name="routing_identifier_nra" type="string" scope="master">
                <xsl:value-of select="routing_identifier_nra" />
            </additional_field>
        </xsl:if>
										
		<xsl:if test="ordering_customer_address_line_1">
			<additional_field name="ordering_customer_address_line_1" type="string" scope="master">
				<xsl:value-of select="ordering_customer_address_line_1"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_customer_address_line_2">
			<additional_field name="ordering_customer_address_line_2" type="string" scope="master">
				<xsl:value-of select="ordering_customer_address_line_2"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_customer_dom">
			<additional_field name="ordering_customer_dom" type="string" scope="master">
				<xsl:value-of select="ordering_customer_dom"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_customer_account">
			<additional_field name="ordering_customer_account" type="string" scope="master">
				<xsl:value-of select="ordering_customer_account"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_customer_swift_bic_code">
			<additional_field name="ordering_customer_swift_bic_code" type="string" scope="master">
				<xsl:value-of select="ordering_customer_swift_bic_code"/>
			</additional_field>
		</xsl:if>	
		<xsl:if test="ordering_customer_bank_swift_bic_code">
			<additional_field name="ordering_customer_bank_swift_bic_code" type="string" scope="master">
				<xsl:value-of select="ordering_customer_bank_swift_bic_code"/>
			</additional_field>
		</xsl:if>		
		<xsl:if test="ordering_customer_bank_name">
			<additional_field name="ordering_customer_bank_name" type="string" scope="master">
				<xsl:value-of select="ordering_customer_bank_name"/>
			</additional_field>
		</xsl:if>							
		<xsl:if test="ordering_customer_bank_address_line_1">
			<additional_field name="ordering_customer_bank_address_line_1" type="string" scope="master">
				<xsl:value-of select="ordering_customer_bank_address_line_1"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_customer_bank_address_line_2">
			<additional_field name="ordering_customer_bank_address_line_2" type="string" scope="master">
				<xsl:value-of select="ordering_customer_bank_address_line_2"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_customer_bank_dom">
			<additional_field name="ordering_customer_bank_dom" type="string" scope="master">
				<xsl:value-of select="ordering_customer_bank_dom"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="ordering_customer_bank_country">
			<additional_field name="ordering_customer_bank_country" type="string" scope="master">
				<xsl:value-of select="ordering_customer_bank_country"/>
			</additional_field>
		</xsl:if>									
		<xsl:if test="ordering_customer_bank_account">
			<additional_field name="ordering_customer_bank_account" type="string" scope="master">
				<xsl:value-of select="ordering_customer_bank_account"/>
			</additional_field>
		</xsl:if>	
								
		<xsl:if test="ordering_institution_swift_bic_code">
			<additional_field name="ordering_institution_swift_bic_code" type="string" scope="master">
				<xsl:value-of select="ordering_institution_swift_bic_code"/>
			</additional_field>
		</xsl:if>	
		<xsl:if test="ordering_institution_name">
			<additional_field name="ordering_institution_name" type="string" scope="master">
				<xsl:value-of select="ordering_institution_name"/>
			</additional_field>
		</xsl:if>							
		<xsl:if test="ordering_institution_address_line_1">
			<additional_field name="ordering_institution_address_line_1" type="string" scope="master">
				<xsl:value-of select="ordering_institution_address_line_1"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_institution_address_line_2">
			<additional_field name="ordering_institution_address_line_2" type="string" scope="master">
				<xsl:value-of select="ordering_institution_address_line_2"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_institution_dom">
			<additional_field name="ordering_institution_dom" type="string" scope="master">
				<xsl:value-of select="ordering_institution_dom"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_institution_country">
			<additional_field name="ordering_institution_country" type="string" scope="master">
				<xsl:value-of select="ordering_institution_country"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_institution_account">
			<additional_field name="ordering_institution_account" type="string" scope="master">
				<xsl:value-of select="ordering_institution_account"/>
			</additional_field>
		</xsl:if>							
		<xsl:if test="beneficiary_institution_swift_bic_code">
			<additional_field name="beneficiary_institution_swift_bic_code" type="string" scope="master">
				<xsl:value-of select="beneficiary_institution_swift_bic_code"/>
			</additional_field>
		</xsl:if>									
		<xsl:if test="beneficiary_bank_swift_bic_code">
			<additional_field name="beneficiary_bank_swift_bic_code" type="string" scope="master">
				<xsl:value-of select="beneficiary_bank_swift_bic_code"/>
			</additional_field>
		</xsl:if>								
		<xsl:if test="beneficiary_bank_country">
			<additional_field name="beneficiary_bank_country" type="string" scope="master">
				<xsl:value-of select="beneficiary_bank_country"/>
			</additional_field>
		</xsl:if>					
		<xsl:if test="branch_address_flag">
			<additional_field name="branch_address_flag" type="string" scope="master">
				<xsl:value-of select="branch_address_flag"/>
			</additional_field>
		</xsl:if>								
		<xsl:if test="beneficiary_bank_branch_address_line_1">
			<additional_field name="beneficiary_bank_branch_address_line_1" type="string" scope="master">
				<xsl:value-of select="beneficiary_bank_branch_address_line_1"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="beneficiary_bank_branch_address_line_2">
			<additional_field name="beneficiary_bank_branch_address_line_2" type="string" scope="master">
				<xsl:value-of select="beneficiary_bank_branch_address_line_2"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="beneficiary_bank_branch_dom">
			<additional_field name="beneficiary_bank_branch_dom" type="string" scope="master">
				<xsl:value-of select="beneficiary_bank_branch_dom"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="beneficiary_bank_clearing_code">
			<additional_field name="beneficiary_bank_clearing_code" type="string" scope="master">
				<xsl:value-of select="beneficiary_bank_clearing_code"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="beneficiary_bank_clearing_code_desc">
			<additional_field name="beneficiary_bank_clearing_code_desc" type="string" scope="master">
				<xsl:value-of select="beneficiary_bank_clearing_code_desc"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="intermediary_bank_swift_bic_code">
			<additional_field name="intermediary_bank_swift_bic_code" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_swift_bic_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="ordering_bank_swift_bic_code">
			<additional_field name="ordering_bank_swift_bic_code" type="string" scope="master">
				<xsl:value-of select="ordering_bank_swift_bic_code"/>
			</additional_field>
		</xsl:if>						
		<xsl:if test="ordering_institution_name">
			<additional_field name="ordering_institution_name" type="string" scope="master">
				<xsl:value-of select="ordering_institution_name"/>
			</additional_field>
		</xsl:if>							
		<xsl:if test="ordering_institution_address_line_1">
			<additional_field name="ordering_institution_address_line_1" type="string" scope="master">
				<xsl:value-of select="ordering_institution_address_line_1"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_institution_address_line_2">
			<additional_field name="ordering_institution_address_line_2" type="string" scope="master">
				<xsl:value-of select="ordering_institution_address_line_2"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="ordering_institution_dom">
			<additional_field name="ordering_institution_dom" type="string" scope="master">
				<xsl:value-of select="ordering_institution_dom"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="ordering_institution_country">
			<additional_field name="ordering_institution_country" type="string" scope="master">
				<xsl:value-of select="ordering_institution_country"/>
			</additional_field>
		</xsl:if>									
		<xsl:if test="intermediary_bank_name">
			<additional_field name="intermediary_bank_name" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_name"/>
			</additional_field>
		</xsl:if>							
		<xsl:if test="intermediary_bank_address_line_1">
			<additional_field name="intermediary_bank_address_line_1" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_address_line_1"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="intermediary_bank_address_line_2">
			<additional_field name="intermediary_bank_address_line_2" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_address_line_2"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="intermediary_bank_dom">
			<additional_field name="intermediary_bank_dom" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_dom"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="intermediary_bank_country">
			<additional_field name="intermediary_bank_country" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_country"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="intermediary_bank_clearing_code">
			<additional_field name="intermediary_bank_clearing_code" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_clearing_code"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="intermediary_bank_clearing_code_desc">
			<additional_field name="intermediary_bank_clearing_code_desc" type="string" scope="master">
				<xsl:value-of select="intermediary_bank_clearing_code_desc"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="charge_option">
			<additional_field name="charge_option" type="string" scope="master">
				<xsl:value-of select="charge_option"/>
			</additional_field>
		</xsl:if>						
		<xsl:if test="related_reference">
			<additional_field name="related_reference" type="string" scope="master">
				<xsl:value-of select="related_reference"/>
			</additional_field>
		</xsl:if>		
		<xsl:if test="payment_details_to_beneficiary">
			<additional_field name="payment_details_to_beneficiary" type="text" scope="master">
				<xsl:value-of select="payment_details_to_beneficiary"/>
			</additional_field>
		</xsl:if>	
		
		<xsl:if test="sub_product_code [.='MEPS']">
			<additional_field name="CustMemoLine1" type="string" scope="master"></additional_field>
		</xsl:if>
		
		  	<xsl:if test="sub_product_code [.='MEPS']">
			<additional_field name="CustMemoLine2" type="string" scope="master"></additional_field>
		</xsl:if>
		
		<xsl:if test="sub_product_code [.='MT103']">
			<additional_field name="CustMemoLine3" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,1,35)"/>
			</additional_field>
		</xsl:if>
				
		<xsl:if test="sub_product_code [.='MT103']">
			<additional_field name="CustMemoLine4" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,36,35)"/>
			</additional_field>
		</xsl:if>	
		
		<xsl:if test="sub_product_code [.='MT103']">
			<additional_field name="CustMemoLine5" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,71,35)"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="sub_product_code [.='MT103']">
			<additional_field name="CustMemoLine6" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,105,35)"/>
			</additional_field>
		</xsl:if>
						
		<xsl:if test="sub_product_code [.='MEPS']">
			<additional_field name="CustMemoLine3" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,1,35)"/>
			</additional_field>
		</xsl:if>
				
		<xsl:if test="sub_product_code [.='MEPS']">
			<additional_field name="CustMemoLine4" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,36,35)"/>
			</additional_field>
		</xsl:if>	
		
		<xsl:if test="sub_product_code [.='MEPS']">
			<additional_field name="CustMemoLine5" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,71,35)"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="sub_product_code [.='MEPS']">
			<additional_field name="CustMemoLine6" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,105,35)"/>
			</additional_field>
		</xsl:if>
		
		
		<xsl:if test="sub_product_code [.='RTGS']">
			<additional_field name="CustMemoLine3" type="string" scope="master">
				<xsl:value-of select="substring(transfer_purpose,1,35)"/>
			</additional_field>
		</xsl:if>
						
		<xsl:if test="sub_product_code [.='RTGS']">
			<additional_field name="CustMemoLine4" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,1,35)"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="sub_product_code [.='RTGS']">
			<additional_field name="CustMemoLine5" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,36,35)"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="sub_product_code [.='RTGS']">
			<additional_field name="CustMemoLine6" type="string" scope="master">
				<xsl:value-of select="substring(payment_details_to_beneficiary,71,35)"/>
			</additional_field>
		</xsl:if>
			
		<xsl:if test="sender_to_receiver_info">
			<additional_field name="sender_to_receiver_info" type="text" scope="master">
				<xsl:value-of select="sender_to_receiver_info"/>
			</additional_field>
		</xsl:if>			
		<xsl:if test="processing_date">
			<additional_field name="processing_date" type="date" scope="master">
				<xsl:value-of select="processing_date"/>
			</additional_field>
		</xsl:if>										
		<xsl:if test="request_date">
			<additional_field name="request_date" type="date" scope="master">
				<xsl:value-of select="request_date"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="not(request_date)">
			<additional_field name="request_date" type="date" scope="master">
				<xsl:value-of select="request_date_unsigned"/>
			</additional_field>
		</xsl:if>	
		<xsl:if test="debit_account_for_charges">
			<additional_field name="debit_account_for_charges" type="string" scope="master">
				<xsl:value-of select="debit_account_for_charges"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="charge_act_cur_code">
			<additional_field name="charge_act_cur_code" type="string" scope="master">
				<xsl:value-of select="charge_act_cur_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="base_cur_code">
			<additional_field name="base_cur_code" type="string" scope="master">
				<xsl:value-of select="base_cur_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="charge_act_no">
			<additional_field name="charge_act_no" type="string" scope="master">
				<xsl:value-of select="charge_act_no"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="instruction_to_bank">
			<additional_field name="instruction_to_bank" type="text" scope="master">
				<xsl:value-of select="instruction_to_bank"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="transaction_remarks">
			<additional_field name="transaction_remarks" type="text" scope="master">
				<xsl:value-of select="transaction_remarks"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_rtgs_country">
			<additional_field name="bene_rtgs_country" type="text" scope="master">
				<xsl:value-of select="bene_rtgs_country"/>
			</additional_field>
		</xsl:if>				
		<!-- Bill Payment Additional fields -->		
		
		<xsl:if test="customer_payee_id">
			<additional_field name="customer_payee_id" type="string" scope="master">
				<xsl:value-of select="customer_payee_id"/>
			</additional_field>
		</xsl:if>	
		<xsl:if test="master_payee_id">
			<additional_field name="master_payee_id" type="string" scope="master">
				<xsl:value-of select="master_payee_id"/>
			</additional_field>
		</xsl:if>					
		<xsl:if test="payee_type">
			<additional_field name="payee_type" type="string" scope="master">
				<xsl:value-of select="payee_type"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="payee_code">
			<additional_field name="payee_code" type="string" scope="master">
				<xsl:value-of select="payee_code"/>
			</additional_field>
		</xsl:if>				
		
		<xsl:if test="service_code">
			<additional_field name="service_code" type="string" scope="master">
				<xsl:value-of select="service_code"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="service_name">
			<additional_field name="service_name" type="string" scope="master">
				<xsl:value-of select="service_name"/>
			</additional_field>
		</xsl:if>					
		<xsl:if test="description">
			<additional_field name="payee_desc" type="string" scope="master">
				<xsl:value-of select="description"/>
			</additional_field>
		</xsl:if>			
			
		<xsl:if test="transfer_date">
			<additional_field name="transfer_date" type="date" scope="master">
				<xsl:value-of select="transfer_date"/>
			</additional_field>
		</xsl:if>	
					<xsl:for-each select="//*[starts-with(name(),'customer_payee_ref_')]">
			<additional_field  type="string" scope="master">
				 <xsl:attribute name="name"><xsl:value-of select="name()" /></xsl:attribute>
				 <xsl:value-of select="."/>
			</additional_field>
		</xsl:for-each>
		
		<!-- Recurring payment -->
		<xsl:if test="recurring_payment_enabled">
			<additional_field name="recurring_payment_enabled" type="string" scope="master">
				<xsl:value-of select="recurring_payment_enabled"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="recurring_start_date">
			<additional_field name="recurring_start_date" type="date" scope="master">
				<xsl:value-of select="recurring_start_date"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="not(recurring_start_date)">
			<additional_field name="recurring_start_date" type="date" scope="master">
				<xsl:value-of select="recurring_start_date_unsigned"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="recurring_end_date">
			<additional_field name="recurring_end_date" type="date" scope="master">
				<xsl:value-of select="recurring_end_date"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="not(recurring_end_date)">
			<additional_field name="recurring_end_date" type="date" scope="master">
				<xsl:value-of select="recurring_end_date_unsigned"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_email_no_send">
			<additional_field name="bene_adv_email_no_send" type="string" scope="master">
				<xsl:value-of select="bene_adv_email_no_send"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="recurring_frequency">
			<additional_field name="recurring_frequency" type="string" scope="master">
				<xsl:value-of select="recurring_frequency"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="recurring_on">
			<additional_field name="recurring_on" type="string" scope="master">
				<xsl:value-of select="recurring_on"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="recurring_number_transfers">
			<additional_field name="recurring_number_transfers" type="integer" scope="master">
				<xsl:value-of select="recurring_number_transfers"/>
			</additional_field>
		</xsl:if>			
		
		<!-- GPP Fee Charges Additional field -->
		<xsl:if test="payment_fee_details">
			<additional_field name="payment_fee_details" type="text" scope="master">
				<xsl:value-of select="payment_fee_details"/>
			</additional_field>
		</xsl:if>
					
		<!-- DDA Additional fields -->
						
		<xsl:if test="action">
			<additional_field name="action" type="string" scope="master">
				<xsl:value-of select="action"/>
			</additional_field>
		</xsl:if>	
		<xsl:if test="start_date">
			<additional_field name="start_date" type="date" scope="master">
				<xsl:value-of select="start_date"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="not(start_date)">
			<additional_field name="start_date" type="date" scope="master">
				<xsl:value-of select="start_date_unsigned"/>
			</additional_field>
		</xsl:if>	
		<xsl:if test="end_date">
			<additional_field name="end_date" type="date" scope="master">
				<xsl:value-of select="end_date"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="not(end_date)">
			<additional_field name="end_date" type="date" scope="master">
				<xsl:value-of select="end_date_unsigned"/>
			</additional_field>
		</xsl:if>	
		<!-- Security -->
		<xsl:if test="token">
			<additional_field name="token" type="string" scope="none" description="Security token">
				<xsl:value-of select="token"/>
			</additional_field>
		</xsl:if>
		
		<!-- Paper Instruments Additional fields START -->
		
		<xsl:if test="beneficiary_name_2">
			<additional_field name="beneficiary_name_2" type="string" scope="master">
				<xsl:value-of select="beneficiary_name_2"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="beneficiary_name_3">
			<additional_field name="beneficiary_name_3" type="string" scope="master">
				<xsl:value-of select="beneficiary_name_3"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="beneficiary_address_line_4">
			<additional_field name="beneficiary_address_line_4" type="string" scope="master">
				<xsl:value-of select="beneficiary_address_line_4"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="beneficiary_postal_code">
			<additional_field name="beneficiary_postal_code" type="string" scope="master">
				<xsl:value-of select="beneficiary_postal_code"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="drawn_on_country">
			<additional_field name="drawn_on_country" type="string" scope="master">
				<xsl:value-of select="drawn_on_country"/>
			</additional_field>
		</xsl:if>
						
		<xsl:if test="collecting_bank_code">
			<additional_field name="collecting_bank_code" type="string" scope="master">
				<xsl:value-of select="collecting_bank_code"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="collecting_branch_code">
			<additional_field name="collecting_branch_code" type="string" scope="master">
				<xsl:value-of select="collecting_branch_code"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="collectors_name">
			<additional_field name="collectors_name" type="string" scope="master">
				<xsl:value-of select="collectors_name"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="collectors_id">
			<additional_field name="collectors_id" type="string" scope="master">
				<xsl:value-of select="collectors_id"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="mailing_other_name_address">
			<additional_field name="mailing_other_name_address" type="string" scope="master">
				<xsl:value-of select="mailing_other_name_address"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="mailing_other_name_2">
			<additional_field name="mailing_other_name_2" type="string" scope="master">
				<xsl:value-of select="mailing_other_name_2"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="mailing_other_name_3">
			<additional_field name="mailing_other_name_3" type="string" scope="master">
				<xsl:value-of select="mailing_other_name_3"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="mailing_other_address_1">
			<additional_field name="mailing_other_address_1" type="string" scope="master">
				<xsl:value-of select="mailing_other_address_1"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="mailing_other_address_2">
			<additional_field name="mailing_other_address_2" type="string" scope="master">
				<xsl:value-of select="mailing_other_address_2"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="mailing_other_address_3">
			<additional_field name="mailing_other_address_3" type="string" scope="master">
				<xsl:value-of select="mailing_other_address_3"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="mailing_other_postal_code">
			<additional_field name="mailing_other_postal_code" type="string" scope="master">
				<xsl:value-of select="mailing_other_postal_code"/>
			</additional_field>
		</xsl:if>
		
		<xsl:if test="mailing_other_country">
			<additional_field name="mailing_other_country" type="string" scope="master">
				<xsl:value-of select="mailing_other_country"/>
			</additional_field>
		</xsl:if>
		
		<!-- Paper Instruments Additional fields END -->
		<!-- Beneficiary Advice Additional Fields -->
		<xsl:if test="bene_adv_flag">
			<additional_field name="bene_adv_flag" type="string" scope="master">
				<xsl:value-of select="bene_adv_flag"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_email_flag">
			<additional_field name="bene_adv_email_flag" type="string" scope="master">
				<xsl:value-of select="bene_adv_email_flag"/>
			</additional_field>
		</xsl:if>
			<xsl:if test="bene_email_1">
			<additional_field name="bene_email_1" type="string" scope="master">
				<xsl:value-of select="bene_email_1"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_email_no_send1">
			<additional_field name="bene_adv_email_no_send1" type="string" scope="master">
				<xsl:value-of select="bene_adv_email_no_send1"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_email_no_send">
			<additional_field name="bene_adv_email_no_send" type="string" scope="master">
				<xsl:value-of select="bene_adv_email_no_send"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_email_1">
			<additional_field name="bene_adv_email_1" type="string" scope="master">
				<xsl:value-of select="bene_adv_email_1"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_email_21">
			<additional_field name="bene_adv_email_21" type="string" scope="master">
				<xsl:value-of select="bene_adv_email_21"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_email_22">
			<additional_field name="bene_adv_email_22" type="string" scope="master">
				<xsl:value-of select="bene_adv_email_22"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_phone_flag">
			<additional_field name="bene_adv_phone_flag" type="string" scope="master">
				<xsl:value-of select="bene_adv_phone_flag"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_phone">
			<additional_field name="bene_adv_phone" type="string" scope="master">
				<xsl:value-of select="bene_adv_phone"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_fax_flag">
			<additional_field name="bene_adv_fax_flag" type="string" scope="master">
				<xsl:value-of select="bene_adv_fax_flag"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_fax">
			<additional_field name="bene_adv_fax" type="string" scope="master">
				<xsl:value-of select="bene_adv_fax"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_ivr_flag">
			<additional_field name="bene_adv_ivr_flag" type="string" scope="master">
				<xsl:value-of select="bene_adv_ivr_flag"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_ivr">
			<additional_field name="bene_adv_ivr" type="string" scope="master">
				<xsl:value-of select="bene_adv_ivr"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_print_flag">
			<additional_field name="bene_adv_print_flag" type="string" scope="master">
				<xsl:value-of select="bene_adv_print_flag"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_mail_flag">
			<additional_field name="bene_adv_mail_flag" type="string" scope="master">
				<xsl:value-of select="bene_adv_mail_flag"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_mailing_name_add_1">
			<additional_field name="bene_adv_mailing_name_add_1" type="string" scope="master">
				<xsl:value-of select="bene_adv_mailing_name_add_1"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_mailing_name_add_2">
			<additional_field name="bene_adv_mailing_name_add_2" type="string" scope="master">
				<xsl:value-of select="bene_adv_mailing_name_add_2"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_mailing_name_add_3">
			<additional_field name="bene_adv_mailing_name_add_3" type="string" scope="master">
				<xsl:value-of select="bene_adv_mailing_name_add_3"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_mailing_name_add_4">
			<additional_field name="bene_adv_mailing_name_add_4" type="string" scope="master">
				<xsl:value-of select="bene_adv_mailing_name_add_4"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_mailing_name_add_5">
			<additional_field name="bene_adv_mailing_name_add_5" type="string" scope="master">
				<xsl:value-of select="bene_adv_mailing_name_add_5"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_mailing_name_add_6">
			<additional_field name="bene_adv_mailing_name_add_6" type="string" scope="master">
				<xsl:value-of select="bene_adv_mailing_name_add_6"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_postal_code">
			<additional_field name="bene_adv_postal_code" type="string" scope="master">
				<xsl:value-of select="bene_adv_postal_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_country">
			<additional_field name="bene_adv_country" type="string" scope="master">
				<xsl:value-of select="bene_adv_country"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_beneficiary_id">
			<additional_field name="bene_adv_beneficiary_id" type="string" scope="master">
				<xsl:value-of select="bene_adv_beneficiary_id"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_payer_name_1">
			<additional_field name="bene_adv_payer_name_1" type="string" scope="master">
				<xsl:value-of select="bene_adv_payer_name_1"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_payer_name_2">
			<additional_field name="bene_adv_payer_name_2" type="string" scope="master">
				<xsl:value-of select="bene_adv_payer_name_2"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_payer_ref_no">
			<additional_field name="bene_adv_payer_ref_no" type="string" scope="master">
				<xsl:value-of select="bene_adv_payer_ref_no"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_free_format_msg">
			<additional_field name="bene_adv_free_format_msg" type="text" scope="master">
				<xsl:value-of select="bene_adv_free_format_msg"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_table_format">
			<additional_field name="bene_adv_table_format" type="string" scope="master">
				<xsl:value-of select="bene_adv_table_format"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_table_format_description and bene_adv_table_format !=''">
				<additional_field name="bene_adv_table_format_description" type="string" scope="master">
					<xsl:value-of select="bene_adv_table_format_description"/>
				</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_table_format_json and bene_adv_table_format !=''">
				<additional_field name="bene_adv_table_format_json" type="string" scope="master">
					<xsl:value-of select="bene_adv_table_format_json"/>
				</additional_field>
		</xsl:if>
		<xsl:if test="bene_adv_table_format_time and bene_adv_table_format !=''">
				<additional_field name="bene_adv_table_format_time" type="string" scope="master">
					<xsl:value-of select="bene_adv_table_format_time"/>
				</additional_field>
		</xsl:if>
		
		<xsl:if test="bene_advices and bene_adv_table_format !=''">
				<additional_field name="bene_advice_table_data" type="string" scope="master">
					[<xsl:for-each select="bene_advices/bene_advice">{<xsl:for-each select="child::*">'<xsl:value-of select="name(.)"/>':'<xsl:value-of select="."/>'<xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>}<xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>]
				</additional_field>
		</xsl:if>
		
		<xsl:if test="notify_beneficiary">
				<additional_field name="notify_beneficiary" type="string" scope="master">
					<xsl:value-of select="notify_beneficiary"/>
				</additional_field>
		</xsl:if>
		<xsl:if test="notify_beneficiary_choice">
				<additional_field name="notify_beneficiary_choice" type="string" scope="master">
					<xsl:value-of select="notify_beneficiary_choice"/>
				</additional_field>
		</xsl:if>
		<xsl:if test="notify_beneficiary_email">
				<additional_field name="notify_beneficiary_email" type="string" scope="master">
					<xsl:value-of select="notify_beneficiary_email"/>
				</additional_field>
		</xsl:if>
		<xsl:if test="remittance_code">
				<additional_field name="remittance_code" type="string" scope="master">
					<xsl:value-of select="remittance_code"/>
				</additional_field>
		</xsl:if>
		<xsl:if test="remittance_description">
				<additional_field name="remittance_description" type="string" scope="master">
					<xsl:value-of select="remittance_description"/>
				</additional_field>
		</xsl:if>			
		<xsl:if test="transfer_purpose">
			<transfer_purpose>
				<xsl:value-of select="transfer_purpose"/>
			</transfer_purpose>
		</xsl:if>
		<!--  Treasury Specific -->
		
		<!--  Debit amount  -->
		<xsl:if test="debit_amt">
			<additional_field name="debit_amt" type="string" scope="master" description="debit_amt">
				<xsl:value-of select="debit_amt"/>
			</additional_field>
		</xsl:if>				
		<!--  Debit Currency  -->
		<xsl:if test="debit_ccy">
			<additional_field name="debit_ccy" type="string" scope="master" description="debit_ccy">
				<xsl:value-of select="debit_ccy"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="trade_id">
			<additional_field name="trade_id" type="string" scope="transaction" description="trade_id">
				<xsl:value-of select="trade_id"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="execution_date">
			<additional_field name="execution_date" type="date" scope="master" description="execution_date">
				<xsl:value-of select="execution_date"/>
			</additional_field>
		</xsl:if>	
		<xsl:if test="beneficiary_bank_account">
			<additional_field name="beneficiary_bank_account" type="string" scope="master"  description="Beneficiary Bank Account">
				<xsl:value-of select="beneficiary_bank_account"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="rec_id">
			<additional_field name="rec_id" type="string" scope="none" description="Opics Request Id.">
				<xsl:value-of select="rec_id"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="fx_deal_no">
			<additional_field name="fx_deal_no" type="string" scope="none" description="Opics FX Deal number only for cross currency. Wire and Transfer.">
				<xsl:value-of select="fx_deal_no"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="xfer_deal_no">
			<additional_field name="xfer_deal_no" type="string" scope="none" description="Opics credit side deal number. Transfer only">
				<xsl:value-of select="xfer_deal_no"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="payment_deal_no">
			<additional_field name="payment_deal_no" type="string" scope="none" description="Opics debit side deal number Wire and Transfer.">
				<xsl:value-of select="payment_deal_no"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="instructions_type">
			<additional_field name="instructions_type" type="string" scope="transaction" description="indicator on the type of instruction : 01 Bank Instruction, 02 Free Format instruction">
				<xsl:value-of select="instructions_type"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="payment_amt">
			<additional_field name="payment_amt" type="string" scope="transaction" description="payment_amt.">
				<xsl:value-of select="payment_amt"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="applicant_act_amt">
			<additional_field name="applicant_act_amt" type="string" scope="transaction" description="applicant_act_amt.">
				<xsl:value-of select="applicant_act_amt"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="clearing_code">
			<additional_field name="clearing_code" type="string" scope="master" description="clearingcode">
				<xsl:value-of select="clearing_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="mups_description_address_line_1">
			<additional_field name="mups_description_address_line_1" type="string" scope="master" description="Description Address line 1">
				<xsl:value-of select="mups_description_address_line_1"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="mups_description_address_line_2">
			<additional_field name="mups_description_address_line_2" type="string" scope="master" description="Description Address line 2">
				<xsl:value-of select="mups_description_address_line_2"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="mups_description_address_line_3">
			<additional_field name="mups_description_address_line_3" type="string" scope="master" description="Description Address line 3">
				<xsl:value-of select="mups_description_address_line_3"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="mups_description_address_line_4">
			<additional_field name="mups_description_address_line_4" type="string" scope="master" description="Description Address line 4">
				<xsl:value-of select="mups_description_address_line_4"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="business_purpose">
			<additional_field name="business_purpose" type="string" scope="master" description="Additional field for domestic transfer">
				<xsl:value-of select="business_purpose"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="payment_mode">
			<additional_field name="payment_mode" type="string" scope="master" description="Additional field for domestic transfer">
				<xsl:value-of select="payment_mode"/>
			</additional_field>
		</xsl:if>
		
		<!-- Lending Specific -->
		<xsl:if test="fee_description">
			<fee_description>
				<xsl:value-of select="fee_description" />
			</fee_description>
		</xsl:if>
		
		<xsl:if test="fee_rid">
			<fee_rid>
				<xsl:value-of select="fee_rid" />
			</fee_rid>
		</xsl:if>
		
		<xsl:if test="fee_type">
			<fee_type>
				<xsl:value-of select="fee_type" />
			</fee_type>
		</xsl:if>
		
		<xsl:if test="cycle_id">
			<cycle_id>
				<xsl:value-of select="cycle_id" />
			</cycle_id>
		</xsl:if>
		
		<xsl:if test="cycle_start_date">
			<cycle_start_date>
				<xsl:value-of select="cycle_start_date" />
			</cycle_start_date>
		</xsl:if>
		
		<xsl:if test="cycle_end_date">
			<cycle_end_date>
				<xsl:value-of select="cycle_end_date" />
			</cycle_end_date>
		</xsl:if>
		
		<xsl:if test="cycle_due_date">
			<cycle_due_date>
				<xsl:value-of select="cycle_due_date" />
			</cycle_due_date>
		</xsl:if>
		
		<xsl:if test="cycle_due_amt">
			<cycle_due_amt>
				<xsl:value-of select="cycle_due_amt" />
			</cycle_due_amt>
		</xsl:if>
		
		<xsl:if test="cycle_paid_amt">
			<cycle_paid_amt>
				<xsl:value-of select="cycle_paid_amt" />
			</cycle_paid_amt>
		</xsl:if>
		
		<!--  Treasury Specific -->
		<xsl:call-template name="COUNTERPARTY_NB"/>
		<!-- Re authentication -->
		<xsl:call-template name="AUTHENTICATION"/>
		<!-- collaboration -->
		<xsl:call-template name="collaboration" />
		
		<xsl:call-template name="bulk_fields" />
		
		<!-- FX Common Fields -->
		<xsl:call-template name="FX_DETAILS" />

     	<!-- Custom additional fields -->
     	<xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.ft.common.FundTransfer>

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
				<xsl:choose>
					<xsl:when test="issuing_bank_abbv_name and issuing_bank_abbv_name[.!='']">
						<abbv_name>
							<xsl:value-of select="issuing_bank_abbv_name"/>
						</abbv_name>
					</xsl:when>
					<xsl:when test="customer_bank and customer_bank[.!='']">
						<abbv_name>
							<xsl:value-of select="customer_bank"/>
						</abbv_name>
					</xsl:when>
				</xsl:choose>
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
			<com.misys.portal.product.common.Bank role_code="11">
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
				<xsl:if test="beneficiary_bank_country">
					<country>
						<xsl:value-of select="beneficiary_bank_country"/>
					</country>
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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="12">
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
				<xsl:choose>
				<xsl:when test="intermediary_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="intermediary_bank_abbv_name"/>
					</abbv_name>
				</xsl:when>
  				<xsl:when test="pay_through_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="pay_through_bank_abbv_name"/>
					</abbv_name>
				</xsl:when>
  				</xsl:choose>
  				<xsl:choose>
				<xsl:when test="intermediary_bank_name">
					<name>
						<xsl:value-of select="intermediary_bank_name"/>
					</name>
				</xsl:when>
  				<xsl:when test="pay_through_bank_name">
					<name>
						<xsl:value-of select="pay_through_bank_name"/>
					</name>
  				</xsl:when>
  				</xsl:choose>
  				<xsl:choose>
				<xsl:when test="intermediary_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="intermediary_bank_address_line_1"/>
					</address_line_1>
				</xsl:when>
  				<xsl:when test="pay_through_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="pay_through_bank_address_line_1"/>
					</address_line_1>
				</xsl:when>
  				</xsl:choose>
  				<xsl:choose>
				<xsl:when test="intermediary_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="intermediary_bank_address_line_2"/>
					</address_line_2>
				</xsl:when>
  				<xsl:when test="pay_through_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="pay_through_bank_address_line_2"/>
					</address_line_2>
				</xsl:when>
  				</xsl:choose>
  				<xsl:choose>
				<xsl:when test="intermediary_bank_dom">
					<dom>
						<xsl:value-of select="intermediary_bank_dom"/>
					</dom>
				</xsl:when>
  				<xsl:when test="pay_through_bank_dom">
					<dom>
						<xsl:value-of select="pay_through_bank_dom"/>
					</dom>
  				</xsl:when>
  				</xsl:choose>
				<xsl:if test="intermediary_bank_country">
					<country>
						<xsl:value-of select="intermediary_bank_country"/>
					</country>
				</xsl:if>
				<xsl:choose>
				<xsl:when test="intermediary_bank_iso_code">
					<iso_code>
						<xsl:value-of select="intermediary_bank_iso_code"/>
					</iso_code>
				</xsl:when>
  				<xsl:when test="pay_through_bank_iso_code">
					<iso_code>
						<xsl:value-of select="pay_through_bank_iso_code"/>
					</iso_code>
  				</xsl:when>
  				</xsl:choose>
				<xsl:choose>
				<xsl:when test="intermediary_bank_reference">
					<reference>
						<xsl:value-of select="intermediary_bank_reference"/>
					</reference>
				</xsl:when>
  				<xsl:when test="pay_through_bank_reference">
					<reference>
						<xsl:value-of select="pay_through_bank_reference"/>
					</reference>
				</xsl:when>
  				</xsl:choose>				
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative type_code="03">
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
				<xsl:if test="narrative_additional_instructions">
					<text>
						<xsl:value-of select="narrative_additional_instructions"/>
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
			
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license"></xsl:apply-templates>
			</xsl:if>
			
			<!-- Create counterparties elements  -->
			<!-- xsl:call-template name="COUNTERPARTY">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ft_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ft_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ft_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ft_tnx_record/tnx_id"/></xsl:with-param>
			</xsl:call-template-->			
			<xsl:if test="creditAccountNumber and (sub_product_code [.!= 'TRINT'] and sub_product_code [.!= 'TRTPT'])" >
				<com.misys.portal.product.common.Counterparty counterparty_type="01">
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
					<xsl:if test="creditAccountNumber">
						<counterparty_act_no>
							<xsl:value-of select="creditAccountNumber"/>
						</counterparty_act_no>
					</xsl:if>
					<xsl:if test="creditAccountName">
						<counterparty_name>
							<xsl:value-of select="substring(creditAccountName,0,151)"/>
						</counterparty_name>
					</xsl:if>
					<xsl:if test="counterparty_amt">
						<counterparty_amt>
							<xsl:value-of select="counterparty_amt"/>
						</counterparty_amt>
					</xsl:if>
					<xsl:if test="counterparty_cur_code">
						<counterparty_cur_code>
							<xsl:value-of select="counterparty_cur_code"/>
						</counterparty_cur_code>
					</xsl:if>
				</com.misys.portal.product.common.Counterparty>
			</xsl:if>					
			<xsl:if test="sub_product_code [.!= 'TRTPT']">
				<com.misys.portal.product.common.Counterparty>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				<xsl:attribute name="counterparty_id"><xsl:value-of select="counterparty_id"/></xsl:attribute>
				<xsl:choose>
					 <xsl:when test="beneficiary_mode[.!='']">
					   <counterparty_type><xsl:value-of select="beneficiary_mode"/></counterparty_type>
					 </xsl:when>
					 <xsl:otherwise>
					   <counterparty_type>02</counterparty_type>
					 </xsl:otherwise>
				</xsl:choose>
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
				<xsl:if test="counterparty_act_no">
					<counterparty_act_no>
						<xsl:value-of select="counterparty_act_no"/>
					</counterparty_act_no>
				</xsl:if>			
				<xsl:if test="counterparty_details_act_no">
					<counterparty_act_no>
						<xsl:value-of select="counterparty_details_act_no"/>
					</counterparty_act_no>
				</xsl:if>
				<xsl:if test="beneficiary_account">
					<counterparty_act_no>
						<xsl:value-of select="beneficiary_account"/>
					</counterparty_act_no>
				</xsl:if>
				<xsl:if test="beneficiary_act_no">
					<counterparty_act_no>
						<xsl:value-of select="beneficiary_act_no"/>
					</counterparty_act_no>
				</xsl:if>
				<xsl:if test="beneficiary_reference">
					<counterparty_reference>
						<xsl:value-of select="beneficiary_reference"/>
					</counterparty_reference>
				</xsl:if>
				<xsl:if test="counterparty_reference">
					<counterparty_reference>
						<xsl:value-of select="counterparty_reference"/>
					</counterparty_reference>
				</xsl:if>
				<xsl:if test="beneficiary_address">
					<counterparty_address_line_1>
						<xsl:value-of select="beneficiary_address"/>
					</counterparty_address_line_1>
				</xsl:if>							
				<xsl:if test="beneficiary_city">
					<counterparty_address_line_2>
						<xsl:value-of select="beneficiary_city"/>
					</counterparty_address_line_2>
				</xsl:if>
				<xsl:if test="counterparty_address_line_1">
					<counterparty_address_line_1>
						<xsl:value-of select="counterparty_address_line_1"/>
					</counterparty_address_line_1>
				</xsl:if>							
				<xsl:if test="counterparty_address_line_2">
					<counterparty_address_line_2>
						<xsl:value-of select="counterparty_address_line_2"/>
					</counterparty_address_line_2>
				</xsl:if>
				<xsl:if test="counterparty_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="counterparty_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:if test="beneficiary_country">
					<counterparty_country>
						<xsl:value-of select="beneficiary_country"/>
					</counterparty_country>
				</xsl:if>
				<xsl:if test="ft_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="ft_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:if test="beneficiary_abbv_name">
					<counterparty_abbv_name>
						<xsl:value-of select="beneficiary_abbv_name"/>
					</counterparty_abbv_name>
				</xsl:if>
				<xsl:if test="beneficiary_iso_code and (not(beneficiary_swift_bic_code))">
					<counterparty_act_iso_code>
						<xsl:value-of select="beneficiary_iso_code"/>
					</counterparty_act_iso_code>
				</xsl:if>
				<xsl:if test="beneficiary_swift_bic_code and (not(beneficiary_iso_code))">
					<counterparty_act_iso_code>
						<xsl:value-of select="beneficiary_swift_bic_code"/>
					</counterparty_act_iso_code>
				</xsl:if>
				<xsl:if test="beneficiary_name">
					<counterparty_name>
						<xsl:value-of select="substring(beneficiary_name,0,151)"/>
					</counterparty_name>
				</xsl:if>
				<xsl:if test="beneficiary_act_name">
					<counterparty_name>
						<xsl:value-of select="substring(beneficiary_act_name,0,51)"/>
					</counterparty_name>
				</xsl:if>
				<xsl:if test="payee_name">
					<counterparty_name>
						<xsl:value-of select="substring(payee_name,0,151)"/>
					</counterparty_name>
				</xsl:if>
				<xsl:if test="beneficiary_dom">
					<counterparty_dom>
						<xsl:value-of select="beneficiary_dom"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="counterparty_dom">
					<counterparty_dom>
						<xsl:value-of select="counterparty_dom"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="payment_amt">
					<counterparty_amt>
						<xsl:value-of select="payment_amt"/>
					</counterparty_amt>
				</xsl:if>
				<!-- Treasury FT sends this element counterparty_amt -->
				<xsl:if test="counterparty_amt">
					<counterparty_amt>
						<xsl:value-of select="counterparty_amt"/>
					</counterparty_amt>
				</xsl:if>
				<xsl:if test="payment_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="payment_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:if test="beneficiary_act_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="beneficiary_act_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:if test="cpty_bank_swift_bic_code">
					<cpty_bank_swift_bic_code name="cpty_bank_swift_bic_code" type="text" scope="master">
						<xsl:value-of select="cpty_bank_swift_bic_code"/>
					</cpty_bank_swift_bic_code>	
				</xsl:if>
				<xsl:if test="counterparty_name">
					<counterparty_name>
						<xsl:value-of select="counterparty_name"/>
					</counterparty_name>
				</xsl:if>
				<xsl:if test="cpty_bank_code">
					<cpty_bank_code>
						<xsl:value-of select="cpty_bank_code"/>
					</cpty_bank_code>
				</xsl:if>
				<xsl:if test="cpty_bank_name">
					<cpty_bank_name>
						<xsl:value-of select="cpty_bank_name"/>
					</cpty_bank_name>
				</xsl:if>
				<xsl:if test="cpty_bank_address_line_1">
					<cpty_bank_address_line_1>
						<xsl:value-of select="cpty_bank_address_line_1"/>
					</cpty_bank_address_line_1>
				</xsl:if>
				<xsl:if test="cpty_bank_address_line_2">
					<cpty_bank_address_line_2>
						<xsl:value-of select="cpty_bank_address_line_2"/>
					</cpty_bank_address_line_2>
				</xsl:if>
				<xsl:if test="cpty_bank_country">
					<cpty_bank_country>
						<xsl:value-of select="cpty_bank_country"/>
					</cpty_bank_country>
				</xsl:if>
				<xsl:if test="cpty_bank_dom">
					<cpty_bank_dom>
						<xsl:value-of select="cpty_bank_dom"/>
					</cpty_bank_dom>
				</xsl:if>
				<xsl:if test="cpty_branch_code">
					<cpty_branch_code>
						<xsl:value-of select="cpty_branch_code"/>
					</cpty_branch_code>
				</xsl:if>
				<xsl:if test="cpty_branch_name">
					<cpty_branch_name>
						<xsl:value-of select="cpty_branch_name"/>
					</cpty_branch_name>
				</xsl:if>
				<xsl:if test="beneficiary_bank_branch_address_line_1">
					<cpty_branch_address_line_1>
						<xsl:value-of select="beneficiary_bank_branch_address_line_1"/>
					</cpty_branch_address_line_1>
				</xsl:if>
				<xsl:if test="beneficiary_bank_branch_address_line_2">
					<cpty_branch_address_line_2>
						<xsl:value-of select="beneficiary_bank_branch_address_line_2"/>
					</cpty_branch_address_line_2>
				</xsl:if>
				<xsl:if test="beneficiary_bank_branch_dom">
					<cpty_branch_dom>
						<xsl:value-of select="beneficiary_bank_branch_dom"/>
					</cpty_branch_dom>
				</xsl:if>	
				
				<!--<xsl:if test="beneficiary_bank_name">
					<cpty_bank_name>
						<xsl:value-of select="beneficiary_bank_name"/>
					</cpty_bank_name>
				</xsl:if>
				
				<xsl:if test="beneficiary_bank_address_line_1">
					<cpty_bank_address_line_1>
						<xsl:value-of select="beneficiary_bank_address_line_1"/>
					</cpty_bank_address_line_1>
				</xsl:if>
				
				<xsl:if test="beneficiary_bank_address_line_2">
					<cpty_bank_address_line_2>
						<xsl:value-of select="beneficiary_bank_address_line_2"/>
					</cpty_bank_address_line_2>
				</xsl:if>
				<xsl:if test="beneficiary_bank_dom">
					<cpty_bank_dom>
						<xsl:value-of select="beneficiary_bank_dom"/>
					</cpty_bank_dom>
				</xsl:if>
				-->
				
					
			</com.misys.portal.product.common.Counterparty>
			</xsl:if>
			<xsl:if test="sub_product_code [.= 'TRTPT']">
			<com.misys.portal.product.common.Counterparty counterparty_type="04">
			<xsl:choose>
						<xsl:when test="bank_payment/instruction_indicator[.!='']">
							<xsl:call-template name="bank-payment"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="free-format"/>
						</xsl:otherwise>
			</xsl:choose>
			</com.misys.portal.product.common.Counterparty>
			</xsl:if>
		
		</result>
	</xsl:template>
	
	<xsl:template match="linked_licenses/license">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<xsl:param name="main_bank_name"/>
		
		<com.misys.portal.product.ls.common.ProductLicenseLink>
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			<xsl:variable name="boRefId" select="bo_ref_id"/>
			<xsl:variable name="lsRefId" select="service:retrieveRefIdFromBoRefId($boRefId, 'LS', main_bank_name, '01')"/>
			<xsl:choose>
				<xsl:when test="ls_ref_id">
					<ls_ref_id>
						<xsl:value-of select="ls_ref_id"/>
					</ls_ref_id>
				</xsl:when>
				<xsl:otherwise>
					<ls_ref_id>
						<xsl:value-of select="$lsRefId"/>
					</ls_ref_id>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="bo_ref_id">
				<bo_ref_id>
					<xsl:value-of select="bo_ref_id"/>
				</bo_ref_id>
			</xsl:if>
			<xsl:if test="ls_number">
				<ls_number>
					<xsl:value-of select="ls_number"/>
				</ls_number>
			</xsl:if>
			<xsl:if test="ls_allocated_amt">
				<ls_allocated_amt>
					<xsl:value-of select="ls_allocated_amt"/>
				</ls_allocated_amt>
			</xsl:if>
			<!-- <xsl:if test="ls_allocated_add_amt">
				<ls_allocated_add_amt>
					<xsl:value-of select="ls_allocated_add_amt"/>
				</ls_allocated_add_amt>
			</xsl:if> -->
			<xsl:if test="ls_amt">
				<ls_amt>
					<xsl:value-of select="ls_amt"/>
				</ls_amt>
			</xsl:if>
			<xsl:if test="ls_os_amt">
				<ls_os_amt>
					<xsl:value-of select="ls_os_amt"/>
				</ls_os_amt>
			</xsl:if>
			<xsl:if test="converted_os_amt">
				<converted_os_amt>
					<xsl:value-of select="converted_os_amt"/>
				</converted_os_amt>
			</xsl:if>
			<xsl:if test="allow_overdraw">
				<allow_overdraw>
					<xsl:value-of select="allow_overdraw"/>
				</allow_overdraw>
			</xsl:if>
			<brch_code><xsl:value-of select="brch_code"/></brch_code>
			<company_id><xsl:value-of select="company_id"/></company_id>
		</com.misys.portal.product.ls.common.ProductLicenseLink>
	</xsl:template>
	
	<xsl:template name="COUNTERPARTY">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:if test="count(//*[starts-with(name(), 'counterparty_details_document_id_')]) != 0">
			<xsl:for-each select="//*[starts-with(name(), 'counterparty_details_document_id_')]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), 'counterparty_details_document_id_')"/>
				</xsl:variable>
				<xsl:if test="not(contains($position ,'nbElement'))">
						<com.misys.portal.product.common.Counterparty>
						<xsl:if test="$refId">
							<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="$tnxId">
							<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_id_', $position))]">
							<xsl:attribute name="counterparty_id">
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_id_', $position))]"/>
							</xsl:attribute>
						</xsl:if>

						<xsl:if test="$brchCode">
							<brch_code><xsl:value-of select="$brchCode"/></brch_code>
						</xsl:if>
						<xsl:if test="$companyId">
							<company_id><xsl:value-of select="$companyId"/></company_id>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_act_no_', $position))]">
							<counterparty_act_no>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_act_no_', $position))]"/>
							</counterparty_act_no>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_label_', $position))]">
							<counterparty_label>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_label_', $position))]"/>
							</counterparty_label>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_abbv_name_', $position))]">
							<counterparty_abbv_name>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_abbv_name_', $position))]"/>
							</counterparty_abbv_name>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_name_', $position))]">
							<counterparty_name>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_name_', $position))]"/>
							</counterparty_name>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_address_line_1_', $position))]">
							<counterparty_address_line_1>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_address_line_1_', $position))]"/>
							</counterparty_address_line_1>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_address_line_2_', $position))]">
							<counterparty_address_line_2>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_address_line_2_', $position))]"/>
							</counterparty_address_line_2>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_dom_', $position))]">
							<counterparty_dom>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_dom_', $position))]"/>
							</counterparty_dom>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_ft_cur_code_', $position))]">
							<counterparty_cur_code>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_ft_cur_code_', $position))]"/>
							</counterparty_cur_code>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_reference_', $position))]">
							<counterparty_reference>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_reference_', $position))]"/>
							</counterparty_reference>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_ft_amt_', $position))]">
							<counterparty_amt>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_ft_amt_', $position))]"/>
							</counterparty_amt>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_act_iso_code_', $position))]">
							<counterparty_act_iso_code>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_act_iso_code_', $position))]"/>
							</counterparty_act_iso_code>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_iss_date_', $position))]">
							<counterparty_iss_date>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_iss_date_', $position))]"/>
							</counterparty_iss_date>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_country_', $position))]">
							<counterparty_country>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_country_', $position))]"/>
							</counterparty_country>
						</xsl:if>						
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_open_chrg_brn_by_code_', $position))]">
							<open_chrg_brn_by_code>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_open_chrg_brn_by_code_', $position))]"/>
							</open_chrg_brn_by_code>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_regulatory_reporting_code_', $position))]">
							<regulatory_reporting_code>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_regulatory_reporting_code_', $position))]"/>
							</regulatory_reporting_code>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat('counterparty_details_regulatory_reporting_country_code_', $position))]">
							<regulatory_reporting_country>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_regulatory_reporting_country_code_', $position))]"/>
							</regulatory_reporting_country>
						</xsl:if>		
					</com.misys.portal.product.common.Counterparty>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<!-- Add a additionnal field to store number of beneficiaries -->
	<!-- and the name of the beneficiary if there is only one -->
	<xsl:template name="COUNTERPARTY_NB">
		<!-- save  the number of beneficiaries-->
		<xsl:variable name="counterparty_nb">
			<xsl:value-of select="count(//*[starts-with(name(), 'counterparty_details_position_')])-count(//*[starts-with(name(), 'counterparty_details_position_nbElement')])"/>
		</xsl:variable>
		<additional_field name="counterparty_nb" type="integer" scope="master" description=" Number of counterparties.">
			<xsl:value-of select="$counterparty_nb"/>
		</additional_field>				
		<!-- save the name too if there is only one beneficiary-->
		<xsl:if test="$counterparty_nb = '1'">
			<additional_field name="objectdata_counterparty_name" type="string" scope="master" description=" Name of the counterparty .">
				<xsl:value-of select="//*[starts-with(name(), 'counterparty_details_name_') and not(contains(substring-after(name(), 'counterparty_details_name_') ,'nbElement'))][1]"/>
			</additional_field>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="bene_advice"> 
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="@*|node()">
		<xsl:element name="{@name}">
			<xsl:copy-of select="node()" />
		</xsl:element>
	    <xsl:apply-templates select="@*|node()" />
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>