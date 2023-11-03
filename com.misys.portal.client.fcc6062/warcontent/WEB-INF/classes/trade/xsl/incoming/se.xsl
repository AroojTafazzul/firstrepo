<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">
				
	<!-- Process SG -->
	<xsl:template match="se_tnx_record">
		<xsl:param name="incoming_mode" />
		<xsl:param name="param_company_id" />
		<xsl:param name="param_ref_id" />
		<xsl:param name="param_tnx_id" />
		<xsl:param name="param_company_name" />
		<xsl:param name="param_entity" />
		<xsl:param name="param_main_bank_abbv_name" />
		<xsl:param name="param_main_bank_name" />

		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageReferences(//product_code, //ref_id, //tnx_id, //bo_ref_id, //bo_tnx_id, //cust_ref_id, //company_id, //company_name, //applicant_reference, //issuing_bank/abbv_name, '01')[$incoming_mode != 'bulk']"/>
			
			<xsl:variable name="ref_id">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_ref_id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/ref_id"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tnx_id">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_tnx_id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/tnx_id"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="company_id">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_company_id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/company_id"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="company_name">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_company_name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/company_name"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="entity">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_entity"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/entity"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="main_bank_abbv_name">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_main_bank_abbv_name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/main_bank_abbv_name"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="main_bank_name">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_main_bank_name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/main_bank_name"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<result>
			<com.misys.portal.product.se.common.SecureEmail>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<xsl:attribute name="entity"><xsl:value-of select="$entity"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>
				<xsl:if test="entity and $entity =''">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
				<product_code>SE</product_code>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
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
				<xsl:if test="contact_type">
					<contact_type>
						<xsl:value-of select="contact_type"/>
					</contact_type>
				</xsl:if>
				<xsl:if test="exec_date">
					<exec_date>
						<xsl:value-of select="exec_date"/>
					</exec_date>
				</xsl:if>
				<xsl:if test="se_type">
					<se_type>
						<xsl:value-of select="se_type"/>
					</se_type>
				</xsl:if>
				<xsl:if test="se_liab_amt">
					<se_liab_amt>
						<xsl:value-of select="se_liab_amt"/>
					</se_liab_amt>
				</xsl:if>
				<xsl:if test="issuer_type">
					<issuer_type>
						<xsl:value-of select="issuer_type"/>
					</issuer_type>
				</xsl:if>
				<xsl:if test="topic">
					<topic>
						<xsl:value-of select="topic"/>
					</topic>
				</xsl:if>
				<xsl:if test="req_read_receipt">
					<req_read_receipt>
						<xsl:value-of select="req_read_receipt"/>
					</req_read_receipt>
				</xsl:if>
				<xsl:if test="priority">
					<priority>
						<xsl:value-of select="priority"/>
					</priority>
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
				<!--xsl:if test="goods_desc">
					<goods_desc>
						<xsl:value-of select="goods_desc"/>
					</goods_desc>
				</xsl:if-->
				<xsl:if test="se_cur_code">
					<se_cur_code>
						<xsl:value-of select="se_cur_code"/>
					</se_cur_code>
				</xsl:if>
				<xsl:if test="se_amt">
					<se_amt>
						<xsl:value-of select="se_amt"/>
					</se_amt>
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
				<xsl:if test="bol_number">
					<bol_number>
						<xsl:value-of select="bol_number"/>
					</bol_number>
				</xsl:if>
				<xsl:if test="shipping_mode">
					<shipping_mode>
						<xsl:value-of select="shipping_mode"/>
					</shipping_mode>
				</xsl:if>
				<xsl:if test="shipping_by">
					<shipping_by>
						<xsl:value-of select="shipping_by"/>
					</shipping_by>
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
						<xsl:value-of select="applicant_reference"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="act_no">
					<applicant_act_no>
						<xsl:value-of select="act_no"/>
					</applicant_act_no>
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
				<xsl:if test="doc_track_id">
					<doc_track_id>
						<xsl:value-of select="doc_track_id"/>
					</doc_track_id>
				</xsl:if>
				
				<xsl:if test="borrower_reference">
					<borrower_reference>
						<xsl:value-of select="borrower_reference"/>
					</borrower_reference>
				</xsl:if>

				<xsl:if test="document_type">
					<document_type>
						<xsl:value-of select="document_type"/>
					</document_type>
				</xsl:if>		
				
				<xsl:if test="document_date">
					<document_date>
						<xsl:value-of select="document_date"/>
					</document_date>
				</xsl:if>								

				<xsl:if test="due_date">
					<due_date>
						<xsl:value-of select="due_date"/>
					</due_date>
				</xsl:if>								

				<xsl:if test="customer">
					<customer>
						<xsl:value-of select="customer"/>
					</customer>
				</xsl:if>								

				<xsl:if test="deal_name">
					<deal_name>
						<xsl:value-of select="deal_name"/>
					</deal_name>
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
						<!--  Bulk File Upload  Start -->
				   <xsl:if test="format_name">
					<additional_field name="format_name" type="string" scope="master" description="Format name of the file being uploaded">
						<xsl:value-of select="format_name"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="map_code">
					<additional_field name="map_code" type="string" scope="master" description="Contains the actual name of the Map_ to be sent to Data Mapper">
						<xsl:value-of select="map_code"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="format_type">
					<additional_field name="format_type" type="string" scope="master" description="Format type of the file being uploaded">
						<xsl:value-of select="format_type"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="amendable">
					<additional_field name="amendable" type="string" scope="master" description="Ammendable file or non ammendable file">
						<xsl:value-of select="amendable"/>
					</additional_field>
				    </xsl:if>	
				    <xsl:if test="file_encrypted">
					<additional_field name="file_encrypted" type="string" scope="master" description="Uploaded file is encrypted">
						<xsl:value-of select="file_encrypted"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="override_duplicate_reference">
					<additional_field name="override_duplicate_reference" type="string" scope="master" description="This file type requires override duplicate reference">
						<xsl:value-of select="override_duplicate_reference"/>
					</additional_field>
				    </xsl:if>	
				    <xsl:if test="upload_description">
					<additional_field name="upload_description" type="string" scope="master" description="Description of the file bulk upload">
						<xsl:value-of select="upload_description"/>
					</additional_field>
				    </xsl:if>	
				    <xsl:if test="reference">
					<additional_field name="reference" type="string" scope="master" description="Reference of the file bulk upload">
						<xsl:value-of select="reference"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="upload_file_type">
					<additional_field name="file_type" type="string" scope="master" description="Type of the file being uploaded">
						<xsl:value-of select="upload_file_type"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="file_upload_act_name">
					<additional_field name="file_upload_act_name" type="string" scope="master" description="Account number ">
						<xsl:value-of select="file_upload_act_name"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="value_date">
					<additional_field name="value_date" type="date" scope="master" description="Value date of the uploaded file">
						<xsl:value-of select="value_date"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="reference">
					<additional_field name="reference" type="string" scope="master" description="Reference to file bulk upload">
						<xsl:value-of select="reference"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="payroll_type">
					<additional_field name="payroll_type" type="string" scope="master" description="Payroll type for the file being uploaded">
						<xsl:value-of select="payroll_type"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="margin_act_no">
				    <applicant_act_no>
					<xsl:value-of select="margin_act_no"/>
					</applicant_act_no>
				    </xsl:if>
				     <xsl:if test="margin_act_name">
				    <applicant_act_name>
					<xsl:value-of select="margin_act_name"/>
					</applicant_act_name>
				    </xsl:if>
				    <xsl:if test="file_upload_act_no">
				    <additional_field name="file_upload_act_no" type="string" scope="master" description="File upload account no">
						<xsl:value-of select="file_upload_act_no"/>
					</additional_field>
				    </xsl:if>
					<xsl:if test="file_upload_act_cur_code">
					  <additional_field name="file_upload_act_cur_code" type="string" scope="master" description="File upload account currency">
						<xsl:value-of select="file_upload_act_cur_code"/>
					  </additional_field>
					</xsl:if>	
					<xsl:if test="file_upload_act_description">
					   <additional_field name="file_upload_act_description" type="string" scope="master" description="File upload account description">
						<xsl:value-of select="file_upload_act_description"/>
					  </additional_field>
					</xsl:if>	
					<xsl:if test="file_upload_act_name">
					  <additional_field name="file_upload_act_name" type="string" scope="master" description="File upload account Name">
						<xsl:value-of select="file_upload_act_name"/>
					  </additional_field>
					</xsl:if>	
					<xsl:if test="entity_check_file_hash_value">
					  <additional_field name="entity_check_file_hash_value" type="string" scope="master" description="File upload file hash check flag at entity level">
						<xsl:value-of select="entity_check_file_hash_value"/>
					  </additional_field>
					</xsl:if>
					<xsl:if test="product_group">
					  <additional_field name="product_group" type="string" scope="master" description="File upload product group">
						<xsl:value-of select="product_group"/>
					  </additional_field>
					</xsl:if>
					<xsl:if test="product_type">
					  <additional_field name="product_type" type="string" scope="master" description="File upload product type">
						<xsl:value-of select="product_type"/>
					  </additional_field>
					</xsl:if>
					<xsl:if test="org_file_creation">
					  <additional_field name="org_file_creation" type="date" scope="master" description="File upload orginal creation date">
						<xsl:value-of select="product_type"/>
					  </additional_field>
					</xsl:if>
					<xsl:if test="upload_time">
					  <additional_field name="upload_time" type="string" scope="master" description="File upload orginal upload time">
						<xsl:value-of select="upload_time"/>
					  </additional_field>
					</xsl:if>
					<xsl:if test="file_name">
					  <additional_field name="file_name" type="string" scope="master" description="Name of the file being uploaded">
						<xsl:value-of select="file_name"/>
					  </additional_field>
					</xsl:if>
					<xsl:if test="file_type_permission">
					  <additional_field name="file_type_permission" type="string" scope="master" description="Permission Associated with file type selected">
						<xsl:value-of select="file_type_permission"/>
					  </additional_field>
					</xsl:if>
					<xsl:if test="upload_time">
					  <additional_field name="upload_time" type="string" scope="master" description="Upload time of the file in portal">
						<xsl:value-of select="upload_time"/>
					  </additional_field>
					</xsl:if>
					
				<!--  Bulk File Upload End -->
				
				<xsl:apply-templates select="additional_field"/>
				
			</com.misys.portal.product.se.common.SecureEmail>
			
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
				<xsl:with-param name="narrative" select="bo_comment"/>
				<xsl:with-param name="type_code">11</xsl:with-param>
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="free_format_text"/>
				<xsl:with-param name="type_code">12</xsl:with-param>
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="goods_desc"/>
				<xsl:with-param name="type_code">14</xsl:with-param>
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:call-template>
			
			<!-- Create Charge element -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:apply-templates>
			
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:apply-templates select="charges/charge">
						<xsl:with-param name="ref_id" select="ref_id"/>
						<xsl:with-param name="tnx_id" select="tnx_id"/>
						<xsl:with-param name="company_id" select="company_id"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="$references/references/charges/charge">
						<xsl:call-template name="CHARGES_EXISTING">
						 	<xsl:with-param name="charge" select="."></xsl:with-param>
							<xsl:with-param name="brchCode" select="brch_code"></xsl:with-param>
							<xsl:with-param name="companyId" select="company_id"></xsl:with-param>
							<xsl:with-param name="refId" select="ref_id"></xsl:with-param>
							<xsl:with-param name="tnxId" select="tnx_id"></xsl:with-param>
				 		</xsl:call-template>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<!-- Create Attachment elements -->
			<xsl:if test="tnx_stat_code">
				<xsl:apply-templates select="attachments/attachment">
					<xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
					<xsl:with-param name="ref_id" select="ref_id"/>
					<xsl:with-param name="tnx_id" select="tnx_id"/>
					<xsl:with-param name="company_id" select="company_id"/>
				</xsl:apply-templates>
			</xsl:if>
			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference"/>
			
			<!-- Error -->
			<xsl:apply-templates select="errors/error">
			    <xsl:with-param name="ref_id"><xsl:value-of select="$ref_id"/></xsl:with-param>
			    <xsl:with-param name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:with-param>
			</xsl:apply-templates>
			
		</result>
	</xsl:template>
</xsl:stylesheet>
