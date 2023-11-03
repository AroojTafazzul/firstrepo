<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:tsutools="xalan://com.misys.portal.tsu.util.common.Tools"
				exclude-result-prefixes="service">
			
	<!-- Process Fees And Billing-->
	<xsl:template match="fb_tnx_record">
	
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="retrieve_ref_id" select="service:retrieveRefIdFromBoRefId(bo_ref_id, product_code, null, null)"/>
		<xsl:variable name="retrieve_tnx_id" select="service:retrieveTnxIdFromBoTnxId($retrieve_ref_id,bo_tnx_id, product_code, null, null)"/>
		<xsl:variable name= "bo_type" select="service:getBackOfficeType(product_code)"/>
		<xsl:variable name= "back_office_ref" select="service:getReferenceByBORef(./applicant_reference,$bo_type)"/>
		<xsl:variable name="references" select="service:manageReferences(./product_code, $retrieve_ref_id, $retrieve_tnx_id, ./bo_ref_id, ./cust_ref_id, ./company_id, ./company_name, $back_office_ref, ./issuing_bank/abbv_name, '01')"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="sub_prod_code" select="$references/references/sub_prod_code"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
	
		<result>
			<com.misys.portal.cash.product.fb.common.FeesAndBilling>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<xsl:choose>
                       <xsl:when test="entity">
                               <entity><xsl:value-of select="entity"/></entity>
                       </xsl:when>
                       <xsl:when test="$entity!='' and not(entity)">
                               <entity><xsl:value-of select="$entity"/></entity>
                       </xsl:when>
               	</xsl:choose>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="sub_product_code">
						<sub_product_code>
							<xsl:value-of select="sub_product_code"/>
						</sub_product_code>
					</xsl:when>
					<xsl:when test="$sub_prod_code!=''">
						<sub_product_code>
							<xsl:value-of select="$sub_prod_code"/>
						</sub_product_code>
					</xsl:when>
					<xsl:when test="product_code[.='FB']">
						<sub_product_code>INVB</sub_product_code>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
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
				<xsl:if test="bo_release_user_id">
					<bo_release_user_id><xsl:value-of select="bo_release_user_id"/></bo_release_user_id>
				</xsl:if>
				<xsl:if test="bo_release_user_dttm">
					<bo_release_user_dttm><xsl:value-of select="bo_release_user_dttm"/></bo_release_user_dttm>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="tsutools:getCurrentDateTime()"/>
					</appl_date>
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
				<xsl:if test="fb_cur_code">
					<fb_cur_code>
						<xsl:value-of select="fb_cur_code"/>
					</fb_cur_code>
				</xsl:if>
				<xsl:if test="fb_amt">
					<fb_amt>
						<xsl:value-of select="fb_amt"/>
					</fb_amt>
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

				<!-- <xsl:call-template name="manageProdStatCode">
					<xsl:with-param name="product" select="."/>
				</xsl:call-template> -->
				<xsl:if test="prod_stat_code">
					<prod_stat_code>03</prod_stat_code>
				</xsl:if>
				
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>04</tnx_stat_code>
				</xsl:if>
				<xsl:if test="sub_tnx_stat_code">
					<sub_tnx_stat_code>
						<xsl:value-of select="sub_tnx_stat_code"/>
					</sub_tnx_stat_code>
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
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				
				<xsl:apply-templates select="additional_field"/>
				
				<!-- FAB specific fields -->
				<xsl:if test="inv_due_date">
					<inv_due_date>
						<xsl:value-of select="inv_due_date"/>
					</inv_due_date>
				</xsl:if>
				<xsl:if test="inv_tax_amt">
					<inv_tax_amt>
						<xsl:value-of select="inv_tax_amt"/>
					</inv_tax_amt>
				</xsl:if>
				<xsl:if test="inv_amt">
					<inv_amt>
						<xsl:value-of select="inv_amt"/>
					</inv_amt>
				</xsl:if>
				<xsl:if test="bill_amt">
					<bill_amt>
						<xsl:value-of select="bill_amt"/>
					</bill_amt>
				</xsl:if>
				<xsl:if test="recd_amt">
					<recd_amt>
						<xsl:value-of select="recd_amt"/>
					</recd_amt>
				</xsl:if>
				<xsl:if test="inv_loc">
					<inv_loc>
						<xsl:value-of select="inv_loc"/>
					</inv_loc>
				</xsl:if>
				<xsl:if test="payment_status">
					<payment_status>
						<xsl:value-of select="payment_status"/>
					</payment_status>
				</xsl:if>
				<xsl:if test="group_no">
					<group_no>
						<xsl:value-of select="group_no"/>
					</group_no>
				</xsl:if>
				<xsl:if test="parent_group_no">
					<parent_group_no>
						<xsl:value-of select="parent_group_no"/>
					</parent_group_no>
				</xsl:if>
				<xsl:if test="lob_code">
					<lob_code>
						<xsl:value-of select="lob_code"/>
					</lob_code>
				</xsl:if>
				<xsl:if test="lob_name">
					<lob_name>
						<xsl:value-of select="lob_name"/>
					</lob_name>
				</xsl:if>
				<xsl:if test="status">
					<status>
						<xsl:value-of select="status"/>
					</status>
				</xsl:if>
					<xsl:if test="prev_due_amt">
					<prev_due_amt>
						<xsl:value-of select="prev_due_amt"/>
					</prev_due_amt>
				</xsl:if>
				<xsl:if test="due_amt">
					<due_amt>
						<xsl:value-of select="due_amt"/>
					</due_amt>
				</xsl:if>
			</com.misys.portal.cash.product.fb.common.FeesAndBilling>
			
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
		</result>
	</xsl:template>
</xsl:stylesheet>
