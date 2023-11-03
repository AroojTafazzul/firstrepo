<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
<!--
   Copyright (c) 2000-2008 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/se_save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Secure Email -->
	<xsl:template match="se_tnx_record">
		<result>
			<com.misys.portal.product.se.common.SecureEmail>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="ref_id">
					<ref_id>
						<xsl:value-of select="ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>
				<xsl:if test="exec_date">
					<exec_date>
						<xsl:value-of select="exec_date"/>
					</exec_date>
				</xsl:if>
				<xsl:if test="se_amt">
					<se_amt>
						<xsl:value-of select="se_amt"/>
					</se_amt>
				</xsl:if>
				<xsl:if test="se_cur_code">
					<se_cur_code>
						<xsl:value-of select="se_cur_code"/>
					</se_cur_code>
				</xsl:if>
				<xsl:if test="se_type">
					<se_type>
						<xsl:value-of select="se_type"/>
					</se_type>
				</xsl:if>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
				<xsl:if test="term_type_radio">
					<term_type_radio>
						<xsl:value-of select="term_type_radio"/>
					</term_type_radio>
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
				<xsl:if test="org_tnx_id">
					<org_tnx_id>
						<xsl:value-of select="org_tnx_id"/>
					</org_tnx_id>
				</xsl:if>
				<xsl:if test="priority">
					<priority>
						<xsl:value-of select="priority"/>
					</priority>
				</xsl:if>
				<xsl:if test="issuer_type">
					<issuer_type>
						<xsl:value-of select="issuer_type"/>
					</issuer_type>
				</xsl:if>
				<xsl:if test="contact_type">
					<contact_type>
						<xsl:value-of select="contact_type"/>
					</contact_type>
				</xsl:if>
				<xsl:if test="req_read_receipt">
					<req_read_receipt>
						<xsl:value-of select="req_read_receipt"/>
					</req_read_receipt>
				</xsl:if>
				<xsl:if test="read_dttm">
					<read_dttm>
						<xsl:value-of select="read_dttm"/>
					</read_dttm>
				</xsl:if>
				<xsl:if test="topic">
					<topic>
						<xsl:value-of select="topic"/>
					</topic>
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
				<xsl:if test="release_dttm">
					<release_dttm>
						<xsl:value-of select="release_dttm"/>
					</release_dttm>
				</xsl:if>
				<xsl:if test="release_user_id">
					<release_user_id>
						<xsl:value-of select="release_user_id"/>
					</release_user_id>
				</xsl:if>
<!-- 				<xsl:if test="ctl_dttm">
					<ctl_dttm>
						<xsl:value-of select="ctl_dttm"/>
					</ctl_dttm>
				</xsl:if> -->
				<xsl:if test="ctl_user_id">
					<ctl_user_id>
						<xsl:value-of select="ctl_user_id"/>
					</ctl_user_id>
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
				
				<!-- Client SPECIFIC -->
				<!--<xsl:if test="margin_account">
					<additional_field name="margin_account" type="string" scope="master" description="Margin_deposit_account">
						<xsl:value-of select="margin_account"/>
					</additional_field>
				</xsl:if>
				--><xsl:if test="upload_file_type">
					<additional_field name="upload_file_type" type="string" scope="master">
						<xsl:value-of select="upload_file_type"/>
					</additional_field>				
				</xsl:if>
				<xsl:if test="file_system_name">
					<additional_field name="file_system_name" type="string" scope="master">
						<xsl:value-of select="file_system_name"/>
					</additional_field>				
				</xsl:if>
				<xsl:if test="file_system_name">
					<additional_field name="file_type_name" type="string" scope="master">
						<xsl:value-of select="file_type_name"/>
					</additional_field>				
				</xsl:if>				
				
				<!-- Client SPECIFIC -->
				
	        	<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="cur_code">
					<additional_field name="cur_code" type="string" scope="master">
						<xsl:value-of select="cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="amt">
					<additional_field name="amt" type="string" scope="master">
						<xsl:value-of select="amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="act_no">
					<additional_field name="act_no" type="string" scope="master">
						<xsl:value-of select="act_no"/>
					</additional_field>
					<applicant_act_no>
						<xsl:value-of select="act_no"/>
					</applicant_act_no>
				</xsl:if>
				<xsl:if test="tenor_days_type">
					<additional_field name="tenor_days_type" type="string" scope="master">
						<xsl:value-of select="tenor_days_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="tenor_maturity_date">
					<additional_field name="tenor_maturity_date" type="date" scope="master">
						<xsl:value-of select="tenor_maturity_date"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="deduct_cur_code">
					<additional_field name="deduct_cur_code" type="string" scope="transaction">
						<xsl:value-of select="deduct_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="deduct_amt">
					<additional_field name="deduct_amt" type="string" scope="transaction">
						<xsl:value-of select="deduct_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="to_act_no">
					<additional_field name="to_act_no" type="string" scope="transaction">
						<xsl:value-of select="to_act_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="add_cur_code">
					<additional_field name="add_cur_code" type="string" scope="transaction">
						<xsl:value-of select="add_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="add_amt">
					<additional_field name="add_amt" type="string" scope="transaction">
						<xsl:value-of select="add_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="from_act_no">
					<additional_field name="from_act_no" type="string" scope="transaction">
						<xsl:value-of select="from_act_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="close_act_no">
					<additional_field name="close_act_no" type="string" scope="transaction">
						<xsl:value-of select="close_act_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="instruction_radio">
					<additional_field name="instruction_radio" type="string" scope="transaction">
						<xsl:value-of select="instruction_radio"/>
					</additional_field>
				</xsl:if>
				<!-- Cheque book specific -->
				<xsl:if test="checkbook_no">
					<additional_field name="checkbook_no" type="string" scope="master">
						<xsl:value-of select="checkbook_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="chequebook_format">
					<additional_field name="chequebook_format" type="string" scope="master">
						<xsl:value-of select="chequebook_format"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="date_time">
					<additional_field name="date_time" type="string" scope="master">
						<xsl:value-of select="date_time"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="se_act_no">
					<additional_field name="se_act_no" type="string" scope="master">
						<xsl:value-of select="se_act_no"/>
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
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
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
				<xsl:if test="topic_description">
					<additional_field name="topic_description" type="string" scope="master" description="Contact helpdesk topic description">
						<xsl:value-of select="topic_description"/>
					</additional_field>
				</xsl:if>
				
				<!--  Cheque Services Start -->
					<xsl:if test="applicant_act_name">
						<applicant_act_name>
							<xsl:value-of select="applicant_act_name" />
						</applicant_act_name>
				    </xsl:if>
					<xsl:if test="applicant_act_no">
						<applicant_act_no>
							<xsl:value-of select="applicant_act_no" />
						</applicant_act_no>
					</xsl:if>			
				    <xsl:if test="cheque_type">
					<additional_field name="cheque_type" type="string" scope="master" description="Cheque Type For Cheque Services">
						<xsl:value-of select="cheque_type"/>
					</additional_field>
				    </xsl:if>	
				    <xsl:if test="cheque_number_from">
					<additional_field name="cheque_number_from" type="string" scope="master" description="From Cheque Number For Cheque Services">
						<xsl:value-of select="cheque_number_from"/>
					</additional_field>
				    </xsl:if>	
				    <xsl:if test="cheque_number_to">
					<additional_field name="cheque_number_to" type="string" scope="master" description="To Cheque Number For Cheque Services">
						<xsl:value-of select="cheque_number_to"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="no_of_cheque_books">
					<additional_field name="no_of_cheque_books" type="string" scope="master" description="Number of Requested Cheque Books For Cheque Services">
						<xsl:value-of select="no_of_cheque_books"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="no_of_cheques">
					<additional_field name="no_of_cheques" type="string" scope="master" description="Number of Requested Cheque Books For Stop Cheque Services">
						<xsl:value-of select="no_of_cheques"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="cheque_number">
					<additional_field name="cheque_number" type="string" scope="master" description="Single cheque number For Cheque Services">
						<xsl:value-of select="cheque_number"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="cheque_number_sequence">
					<additional_field name="cheque_number_sequence" type="string" scope="master" description="Sequence of cheque numbers For Cheque Services">
						<xsl:value-of select="cheque_number_sequence"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="stop_reason">
					<additional_field name="stop_reason" type="string" scope="master" description="Sequence of cheque numbers For Cheque Services">
						<xsl:value-of select="stop_reason"/>
					</additional_field>
				    </xsl:if>
				    <xsl:if test="applicant_act_no">
					<additional_field name="adv_send_mode" type="string" scope="master" description="Delivery Mode For Cheque Services">
						<xsl:value-of select="adv_send_mode"/>
					</additional_field>
				    </xsl:if>		
				<!--  Cheque Services End -->
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
				<xsl:call-template name="bank-instructions-act-fields"/>
				
				
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.se.common.SecureEmail>
			<com.misys.portal.product.common.Bank  role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
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
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
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
				<xsl:if test="issuing_bank_customer_reference">
					<reference>
						<xsl:value-of select="issuing_bank_customer_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative  type_code="12">
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
				<xsl:if test="ref_id">
					<ref_id>
						<xsl:value-of select="ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>12</type_code>
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
				<xsl:if test="ref_id">
					<ref_id>
						<xsl:value-of select="ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>11</type_code>
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_id_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//se_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//se_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//se_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//se_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_id_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_chrg_id_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//se_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//se_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//se_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//se_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'old_charge_details_chrg_id_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
