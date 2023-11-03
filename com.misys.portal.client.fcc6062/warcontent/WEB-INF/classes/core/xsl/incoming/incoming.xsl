<?xml version="1.0"?> 
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">

	<xsl:variable name="brch_code" select="'00001'"/>

	<!-- Format Narrative node to GTPDocumentParser syntax -->
	<xsl:template name="bank">
		<xsl:param name="bank"/>
		<xsl:param name="role_code"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		
		<com.misys.portal.product.common.Bank>
			<xsl:attribute name="role_code"><xsl:value-of select="$role_code"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<xsl:if test="$bank/abbv_name"><abbv_name><xsl:value-of select="$bank/abbv_name"/></abbv_name></xsl:if>
			<xsl:if test="$bank/name"><name><xsl:value-of select="$bank/name"/></name></xsl:if>
			<xsl:if test="$bank/address_line_1"><address_line_1><xsl:value-of select="$bank/address_line_1"/></address_line_1></xsl:if>
			<xsl:if test="$bank/address_line_2"><address_line_2><xsl:value-of select="$bank/address_line_2"/></address_line_2></xsl:if>
			<xsl:if test="$bank/dom"><dom><xsl:value-of select="$bank/dom"/></dom></xsl:if>
			<xsl:if test="$bank/address_line_4"><address_line_4><xsl:value-of select="$bank/address_line_4"/></address_line_4></xsl:if>
			<xsl:if test="$bank/iso_code"><iso_code><xsl:value-of select="$bank/iso_code"/></iso_code></xsl:if>
			<xsl:if test="$bank/reference"><reference><xsl:value-of select="$bank/reference"/></reference></xsl:if>
		</com.misys.portal.product.common.Bank>		
	</xsl:template>

	<!-- Format Narrative node to GTPDocumentParser syntax -->
	<xsl:template name="narrative">
		<xsl:param name="narrative"/>
		<xsl:param name="type_code"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		
		<com.misys.portal.product.common.Narrative>
			<xsl:attribute name="type_code"><xsl:value-of select="$type_code"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<xsl:if test="$narrative"><text><xsl:value-of select="$narrative"/></text></xsl:if>
		</com.misys.portal.product.common.Narrative>		
	</xsl:template>

	<!-- Override prod_stat_code values -->
	<xsl:template name="manageProdStatCode">
		<xsl:param name="product"/>		

		<!-- prod_stat_code null if tnx_stat_code=01|02 and prod_stat_code is not 98(Provisional), prod_stat_code=02 if tnx_stat_code=03 and prod_stat_code is not already sent as 98 -->
		<xsl:choose>
			<xsl:when test="$product/prod_stat_code[.='84' or .='87' or .='88'] and $product/product_code[.='BG' or .='SI']">
				<prod_stat_code>
					<xsl:value-of select="$product/prod_stat_code" />
				</prod_stat_code>
			</xsl:when>
			<xsl:when test="$product/prod_stat_code[.='98']">
				<prod_stat_code>
					<xsl:value-of select="$product/prod_stat_code" />
				</prod_stat_code>
				<xsl:if test="$product/product_code[.='BG' or .='SI' or .='LC']">
					<provisional_status>Y</provisional_status>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$product/tnx_stat_code[.='01'] or $product/tnx_stat_code[.='02']">
				<prod_stat_code />
				<xsl:if test="$product/product_code[.='BG' or .='SI' or .='LC']">
					<provisional_status>N</provisional_status>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$product/tnx_stat_code[.='03']">
				<prod_stat_code>02</prod_stat_code>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$product/prod_stat_code">
					<prod_stat_code><xsl:value-of select="$product/prod_stat_code"/></prod_stat_code>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Charges -->
	<xsl:template match="charge">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
	
		<com.misys.portal.product.common.Charge>
			<!-- keys as attributes --> 
			<xsl:attribute name="chrg_id"><xsl:value-of select="chrg_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<xsl:if test="chrg_code">
				<chrg_code><xsl:value-of select="chrg_code"/></chrg_code>
			</xsl:if>
			<xsl:if test="amt">
				<amt><xsl:value-of select="amt"/></amt>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code><xsl:value-of select="cur_code"/></cur_code>
			</xsl:if>
			<xsl:if test="status">
				<status><xsl:value-of select="status"/></status>
			</xsl:if>
			<xsl:if test="bearer_role_code">
				<bearer_role_code><xsl:value-of select="bearer_role_code"/></bearer_role_code>
			</xsl:if>
			<xsl:if test="exchange_rate">
				<exchange_rate><xsl:value-of select="exchange_rate"/></exchange_rate>
			</xsl:if>
			<xsl:if test="eqv_amt">
				<eqv_amt><xsl:value-of select="eqv_amt"/></eqv_amt>
			</xsl:if>
			<xsl:if test="eqv_cur_code">
				<eqv_cur_code><xsl:value-of select="eqv_cur_code"/></eqv_cur_code>
			</xsl:if>
			<xsl:if test="additional_comment">
				<additional_comment><xsl:value-of select="additional_comment"/></additional_comment>
			</xsl:if>
			<xsl:if test="inception_date">
				<inception_date><xsl:value-of select="inception_date"/></inception_date>
			</xsl:if>
			<xsl:if test="settlement_date">
				<settlement_date><xsl:value-of select="settlement_date"/></settlement_date>
			</xsl:if>
			<xsl:if test="created_in_session">
				<created_in_session><xsl:value-of select="created_in_session"/></created_in_session>
			</xsl:if>
			<xsl:if test="chrg_type">
				<chrg_type><xsl:value-of select="chrg_type"/></chrg_type>
			</xsl:if>
		</com.misys.portal.product.common.Charge>
	</xsl:template>

	
	<!-- Document -->
	<xsl:template match="document">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
	
		<com.misys.portal.product.common.Document>
			<!-- keys as attributes -->
			<xsl:attribute name="document_id"><xsl:value-of select="document_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			
			<xsl:if test="code">
				<code>
					<xsl:value-of select="code"/>
				</code>
			</xsl:if>
			<xsl:if test="name">
				<name>
					<xsl:value-of select="name"/>
				</name>
			</xsl:if>
			<xsl:if test="first_mail">
				<first_mail>
					<xsl:value-of select="first_mail"/>
				</first_mail>
			</xsl:if>
			<xsl:if test="second_mail">
				<second_mail>
					<xsl:value-of select="second_mail"/>
				</second_mail>
			</xsl:if>
			<xsl:if test="total">
				<total>
					<xsl:value-of select="total"/>
				</total>
			</xsl:if>
			<xsl:if test="mapped_attachment_name">
				<mapped_attachment_name>
					<xsl:value-of select="mapped_attachment_name"/>
				</mapped_attachment_name>
			</xsl:if>
			<xsl:if test="mapped_attachment_id">
				<mapped_attachment_id>
					<xsl:value-of select="mapped_attachment_id"/>
				</mapped_attachment_id>
			</xsl:if>
			<xsl:if test="doc_no">
				<doc_no>
					<xsl:value-of select="doc_no"/>
				</doc_no>
			</xsl:if>
			<xsl:if test="doc_date">
				<doc_date>
					<xsl:value-of select="doc_date"/>
				</doc_date>
			</xsl:if>
		</com.misys.portal.product.common.Document>
	</xsl:template>
	

	<!-- Attachments -->
	<xsl:template match="attachment">
		<xsl:param name="tnx_stat_code"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		
		<com.misys.portal.product.common.Attachment>
			<!-- keys as attributes --> 
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<xsl:if test="attachment_id">
				<attachment_id><xsl:value-of select="attachment_id"/></attachment_id>
			</xsl:if>
			<xsl:if test="description">
				<description><xsl:value-of select="description"/></description>
			</xsl:if>
			<xsl:if test="file_name">
				<file_name><xsl:value-of select="file_name"/></file_name>
			</xsl:if>
			<xsl:if test="title">
				<title><xsl:value-of select="title"/></title>
			</xsl:if>
			<xsl:choose>
			<xsl:when test="type and type='07'">
				<type><xsl:value-of select="type"/></type>
			</xsl:when>
			<xsl:when test="$tnx_stat_code='01' or $tnx_stat_code='02' or $tnx_stat_code='03'">
				<type>01</type>
			</xsl:when>
			<xsl:otherwise>
				<type>02</type>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="mime_type">
				<mime_type><xsl:value-of select="mime_type"/></mime_type>
			</xsl:if>
			<xsl:if test="file_attachment">
				<file_attachment><xsl:value-of select="file_attachment"/></file_attachment>
			</xsl:if>
			<xsl:if test="doc_id">
				<doc_id><xsl:value-of select="doc_id"/></doc_id>
			</xsl:if>
			<xsl:if test="dms_id">
				<dms_id><xsl:value-of select="dms_id"/></dms_id>
			</xsl:if>
		</com.misys.portal.product.common.Attachment>
	</xsl:template>
	
		
	<!-- Cross Reference  -->
	<xsl:template match="cross_reference">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="product_code"/>
	
		<com.misys.portal.product.common.CrossReference>
			<xsl:if test="cross_reference_id">
				<xsl:attribute name="cross_reference_id">
					<xsl:value-of select="cross_reference_id"/>
				</xsl:attribute>
			</xsl:if>						
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<xsl:choose>
				<xsl:when test="not(ref_id) or ref_id = ''">
					<product_code>
						<xsl:value-of select="$product_code"/>
					</product_code>
					<ref_id>
						<xsl:value-of select="$ref_id"/>
					</ref_id>
					<tnx_id>
						<xsl:value-of select="$tnx_id"/>
					</tnx_id>
				</xsl:when>
				<xsl:otherwise>
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
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="not(child_ref_id) or child_ref_id = ''">
					<child_product_code>
						<xsl:value-of select="$product_code"/>
					</child_product_code>
					<child_ref_id>
						<xsl:value-of select="$ref_id"/>
					</child_ref_id>
<!-- 					<child_tnx_id>
						<xsl:value-of select="$tnx_id"/>
					</child_tnx_id> -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="child_product_code">
						<child_product_code>
							<xsl:value-of select="child_product_code"/>
						</child_product_code>
					</xsl:if>
					<xsl:if test="child_ref_id">
						<child_ref_id>
							<xsl:value-of select="child_ref_id"/>
						</child_ref_id>
					</xsl:if>
					<xsl:if test="child_tnx_id">
						<child_tnx_id>
							<xsl:value-of select="child_tnx_id"/>
						</child_tnx_id>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<type_code>01</type_code>
			<!-- <xsl:if test="type_code">
				<type_code>
					<xsl:value-of select="type_code"/>
				</type_code>
			</xsl:if> -->
		</com.misys.portal.product.common.CrossReference>
	</xsl:template>
	
	<!-- Additional fields -->
	<xsl:template match="additional_field">
		<xsl:copy-of select="."/>
	</xsl:template>
	
	<!--              -->
	<!-- Open Account -->
	<!--              -->
	
	<!-- Buyer Defined Informations -->
	<xsl:template match="user_defined_information">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<com.misys.portal.openaccount.product.baseline.util.UserInfo>
			<xsl:if test="$ref_id">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnx_id">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="user_info_id"><xsl:value-of select="user_info_id"/></xsl:attribute>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<xsl:if test="$company_id">
				<company_id><xsl:value-of select="$company_id"/></company_id>
			</xsl:if>
			<xsl:element name="type"><xsl:value-of select="type"/></xsl:element>
			<xsl:element name="label"><xsl:value-of select="label"/></xsl:element>
			<xsl:element name="information"><xsl:value-of select="information"/></xsl:element>
		</com.misys.portal.openaccount.product.baseline.util.UserInfo>
	</xsl:template>
	
	<!-- Allowance common template -->
	<!-- <xsl:template match="allowance">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<com.misys.portal.openaccount.product.baseline.util.Allowance>
			<xsl:if test="$ref_id">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnx_id">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="allowance_id">
				<xsl:value-of select="allowance_id"/>
			</xsl:attribute>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<xsl:if test="$company_id">
				<company_id><xsl:value-of select="$company_id"/></company_id>
			</xsl:if>
			<allowance_type>
				<xsl:value-of select="allowance_type"/>
			</allowance_type>
			<type>
				<xsl:value-of select="type"/>
			</type>
			<other_type>
				<xsl:value-of select="other_type"/>
			</other_type>
			<amt>
				<xsl:value-of select="amt"/>
			</amt>
			<cur_code>
				<xsl:value-of select="cur_code"/>
			</cur_code>
			<rate>
				<xsl:value-of select="rate"/>
			</rate>
			<direction>
				<xsl:value-of select="direction"/>
			</direction>
			<xsl:if test="cn_reference_id">
				<cn_reference_id><xsl:value-of select="cn_reference_id"/></cn_reference_id> 
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.Allowance>
	</xsl:template>-->
	
	<!-- Inco Term -->
	<!-- <xsl:template match="incoterm">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<com.misys.portal.openaccount.product.baseline.util.IncoTerm>
			<xsl:if test="$ref_id">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnx_id">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="id">
				<xsl:attribute name="inco_term_id">
					<xsl:value-of select="id"/>
				</xsl:attribute>
			</xsl:if>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<xsl:if test="$company_id">
				<company_id><xsl:value-of select="$company_id"/></company_id>
			</xsl:if>
			<xsl:if test="code">
				<code>
					<xsl:value-of select="code"/>
				</code>
			</xsl:if>
			<xsl:if test="other">
				<other>
					<xsl:value-of select="other"/>
				</other>
			</xsl:if>						
			<xsl:if test="location">
				<location>
					<xsl:value-of select="location"/>
				</location>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.IncoTerm>
	</xsl:template> -->
	
	<!-- Payment -->
	<!-- <xsl:template match="payment">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<com.misys.portal.openaccount.product.baseline.util.PaymentTerm>
			<xsl:if test="$ref_id">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnx_id">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="payment_id">
				<xsl:attribute name="payment_id">
					<xsl:value-of select="payment_id"/>
				</xsl:attribute>
			</xsl:if>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<xsl:if test="$company_id">
				<company_id><xsl:value-of select="$company_id"/></company_id>
			</xsl:if>
			<xsl:if test="other_paymt_terms">
				<other_paymt_terms>
					<xsl:value-of select="other_paymt_terms"/>
				</other_paymt_terms>
			</xsl:if>
			<xsl:if test="code">
				<code>
					<xsl:value-of select="code"/>
				</code>
			</xsl:if>
			<xsl:if test="nb_days">
				<nb_days>
					<xsl:value-of select="nb_days"/>
				</nb_days>
			</xsl:if>
			<xsl:if test="amt">
				<amt>
					<xsl:value-of select="amt"/>
				</amt>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code>
					<xsl:value-of select="cur_code"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="pct">
				<pct>
					<xsl:value-of select="pct"/>
				</pct>
			</xsl:if>
			<xsl:if test="paymt_date">
				<paymt_date>
					<xsl:value-of select="paymt_date"/>
				</paymt_date>
			</xsl:if>
			<xsl:if test="created_in_session">
				<created_in_session>
					<xsl:value-of select="created_in_session"/>
				</created_in_session>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.PaymentTerm>
	</xsl:template>-->
	
	<!-- Contact  -->
	<!-- <xsl:template match="contact">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<com.misys.portal.openaccount.product.baseline.util.ContactPerson>
			<xsl:if test="$ref_id">
					<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$tnx_id">
					<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				</xsl:if>
			<xsl:if test="ctcprsn_id">
				<xsl:attribute name="ctcprsn_id">
					<xsl:value-of select="ctcprsn_id"/>
				</xsl:attribute>
			</xsl:if>						
	
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<xsl:if test="$company_id">
				<company_id><xsl:value-of select="$company_id"/></company_id>
			</xsl:if>
			<xsl:if test="type">
				<type>
					<xsl:value-of select="type"/>
				</type>
			</xsl:if>
			<xsl:if test="name">
				<name>
					<xsl:value-of select="name"/>
				</name>
			</xsl:if>
			<xsl:if test="name_prefix">
				<name_prefix>
					<xsl:value-of select="name_prefix"/>
				</name_prefix>
			</xsl:if>
			<xsl:if test="given_name">
				<given_name>
					<xsl:value-of select="given_name"/>
				</given_name>
			</xsl:if>
			<xsl:if test="role">
				<role>
					<xsl:value-of select="role"/>
				</role>
			</xsl:if>
			<xsl:if test="phone_number">
				<phone_number>
					<xsl:value-of select="phone_number"/>
				</phone_number>
			</xsl:if>
			<xsl:if test="fax_number">
				<fax_number>
					<xsl:value-of select="fax_number"/>
				</fax_number>
			</xsl:if>
			<xsl:if test="email">
				<email>
					<xsl:value-of select="email"/>
				</email>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.ContactPerson>
	</xsl:template> -->
	
	<!-- Routing Summary -->
	<xsl:template match="routing_summary">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>	
		<com.misys.portal.openaccount.product.baseline.util.Transport>
		<xsl:if test="$ref_id">
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="$tnx_id">
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
		</xsl:if>
	
		<brch_code><xsl:value-of select="$brch_code"/></brch_code>
		<xsl:if test="$company_id">
			<company_id><xsl:value-of select="$company_id"/></company_id>
		</xsl:if>
		<xsl:if test="transport_type">
			<transport_type>
				<xsl:value-of select="transport_type"/>
			</transport_type>
		</xsl:if>
		<xsl:if test="transport_mode">
			<transport_mode>
				<xsl:value-of select="transport_mode"/>
			</transport_mode>
		</xsl:if>
		<xsl:if test="transport_sub_type">
			<transport_sub_type>
				<xsl:value-of select="transport_sub_type"/>
			</transport_sub_type>
		</xsl:if>
		<xsl:if test="transport_group">
			<transport_group>
				<xsl:value-of select="transport_group"/>
			</transport_group>
		</xsl:if>
		<xsl:if test="airport_loading_code">
			<airport_loading_code>
				<xsl:value-of select="airport_loading_code"/>
			</airport_loading_code>
		</xsl:if>
		<xsl:if test="airport_discharge_code">
			<airport_discharge_code>
				<xsl:value-of select="airport_discharge_code"/>
			</airport_discharge_code>
		</xsl:if>
		<xsl:if test="town_loading">
			<town_loading>
				<xsl:value-of select="town_loading"/>
			</town_loading>
		</xsl:if>
		<xsl:if test="town_discharge">
			<town_discharge>
				<xsl:value-of select="town_discharge"/>
			</town_discharge>
		</xsl:if>
		<xsl:if test="airport_loading_name">
			<airport_loading_name>
				<xsl:value-of select="airport_loading_name"/>
			</airport_loading_name>
		</xsl:if>
		<xsl:if test="airport_discharge_name">
			<airport_discharge_name>
				<xsl:value-of select="airport_discharge_name"/>
			</airport_discharge_name>
		</xsl:if>
		<xsl:if test="place_receipt">
			<place_receipt>
				<xsl:value-of select="place_receipt"/>
			</place_receipt>
		</xsl:if>
		<xsl:if test="place_delivery">
			<place_delivery>
				<xsl:value-of select="place_delivery"/>
			</place_delivery>
		</xsl:if>																							
		<xsl:if test="port_loading">
			<port_loading>
				<xsl:value-of select="port_loading"/>
			</port_loading>
		</xsl:if>
		<xsl:if test="port_discharge">
			<port_discharge>
				<xsl:value-of select="port_discharge"/>
			</port_discharge>
		</xsl:if>																							
	</com.misys.portal.openaccount.product.baseline.util.Transport>
	</xsl:template>

	<!-- Attachments -->
	<xsl:template name="attachment-details">
		<xsl:param name="attachment"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		
			<com.misys.portal.product.common.Attachment>
			<!-- keys as attributes --> 
			<xsl:attribute name="attachment_id"><xsl:value-of select="$attachment/attachment_id"/></xsl:attribute>
			
			<xsl:element name="ref_id"><xsl:value-of select="$ref_id"/></xsl:element>
			<xsl:element name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:element>
			<xsl:element name="company_id"><xsl:value-of select="$company_id"/></xsl:element>
			
			<xsl:if test="$attachment/description">
				<xsl:element name="description"><xsl:value-of select="$attachment/description"/></xsl:element>
			</xsl:if>
			
			<xsl:if test="$attachment/brch_code">
				<xsl:element name="brch_code"><xsl:value-of select="$attachment/brch_code"/></xsl:element>
			</xsl:if>
			<xsl:if test="$attachment/description">
				<xsl:element name="description"><xsl:value-of select="$attachment/description"/></xsl:element>
			</xsl:if>
			<xsl:if test="$attachment/file_name">
				<xsl:element name="file_name"><xsl:value-of select="$attachment/file_name"/></xsl:element>
			</xsl:if>
			<xsl:if test="$attachment/title">
				<xsl:element name="title"><xsl:value-of select="$attachment/title"/></xsl:element>
			</xsl:if>
			<xsl:choose>
			<xsl:when test="$attachment/type='01' or $attachment/type='02' or $attachment/type='03'">
				<xsl:element name="type">01</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="type">02</xsl:element>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="$attachment/mime_type">
				<xsl:element name="mime_type"><xsl:value-of select="$attachment/mime_type"/></xsl:element>
			</xsl:if>
			<xsl:if test="$attachment/doc_id">
				<xsl:element name="doc_id"><xsl:value-of select="$attachment/doc_id"/></xsl:element>
			</xsl:if>
			<xsl:if test="$attachment/dms_id">
				<xsl:element name="dms_id"><xsl:value-of select="$attachment/dms_id"/></xsl:element>
			</xsl:if>
		</com.misys.portal.product.common.Attachment>
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
			<xsl:variable name="lsRefId" select="service:retrieveRefIdFromBoRefId($boRefId, 'LS', $main_bank_name, '01')"/>
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
		<xsl:template match="variation/variation_lines/variation_line_item">
		<xsl:param name="type"/>
		<xsl:param name="advise_flag"/>
		<xsl:param name="advise_reduction_days"/>
		<xsl:param name="maximum_nb_days"/>
		<xsl:param name="frequency"/>
		<xsl:param name="period"/>	
		<xsl:param name="day_in_month"/>
		<xsl:param name="product_code"/>
		<xsl:choose>
		<xsl:when test="$product_code = 'BG'">
			<xsl:call-template name="variationDetails">
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="advise_flag" select="$advise_flag"/>
			<xsl:with-param name="advise_reduction_days" select="$advise_reduction_days"/>
			<xsl:with-param name="maximum_nb_days" select="$maximum_nb_days"/>
			<xsl:with-param name="frequency" select="$frequency"/>
			<xsl:with-param name="period" select="$period"/>
			<xsl:with-param name="day_in_month" select="$day_in_month"/>						
			<xsl:with-param name ="section_type" select="'01'"/>
		    </xsl:call-template>
		</xsl:when>
		<xsl:when test="$product_code = 'BR'">
		    <xsl:call-template name="ruVariationDetails">
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="advise_flag" select="$advise_flag"/>
			<xsl:with-param name="advise_reduction_days" select="$advise_reduction_days"/>
			<xsl:with-param name="maximum_nb_days" select="$maximum_nb_days"/>
			<xsl:with-param name="frequency" select="$frequency"/>
			<xsl:with-param name="period" select="$period"/>
			<xsl:with-param name="day_in_month" select="$day_in_month"/>						
		    </xsl:call-template>
		 </xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="cu_variation/variation_lines/variation_line_item">
		<xsl:param name="type"/>
		<xsl:param name="advise_flag"/>
		<xsl:param name="advise_reduction_days"/>
		<xsl:param name="maximum_nb_days"/>
		<xsl:param name="frequency"/>
		<xsl:param name="period"/>	
		<xsl:param name="day_in_month"/>
		<xsl:call-template name="variationDetails">
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="advise_flag" select="$advise_flag"/>
			<xsl:with-param name="advise_reduction_days" select="$advise_reduction_days"/>
			<xsl:with-param name="maximum_nb_days" select="$maximum_nb_days"/>
			<xsl:with-param name="frequency" select="$frequency"/>
			<xsl:with-param name="period" select="$period"/>
			<xsl:with-param name="day_in_month" select="$day_in_month"/>						
			<xsl:with-param name ="section_type" select="'02'"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="variationDetails">
		<xsl:param name="type"/>
		<xsl:param name="advise_flag"/>
		<xsl:param name="advise_reduction_days"/>
		<xsl:param name="maximum_nb_days"/>
		<xsl:param name="frequency"/>
		<xsl:param name="period"/>	
		<xsl:param name="day_in_month"/>			
		<xsl:param name="section_type"/>
		
		<com.misys.portal.product.common.Variation>
			<xsl:if test="ref_id">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="tnx_id">
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="brch_code">
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id><xsl:value-of select="company_id"/></company_id>
			</xsl:if>
			<xsl:if test="$section_type">
				<section_type><xsl:value-of select="$section_type"/></section_type>
			</xsl:if>
			<xsl:if test="$type">
				<type>
					<xsl:value-of select="$type"/>
				</type>
			</xsl:if>
			<xsl:if test="$advise_flag">
				<advise_flag>
					<xsl:value-of select="$advise_flag"/>
				</advise_flag>
			</xsl:if>
			<xsl:if test="$advise_reduction_days">
				<advise_reduction_days>
					<xsl:value-of select="$advise_reduction_days"/>
				</advise_reduction_days>
			</xsl:if>
			<xsl:if test="$maximum_nb_days">
				<maximum_nb_days>
					<xsl:value-of select="$maximum_nb_days"/>
				</maximum_nb_days>
			</xsl:if>
			<xsl:if test="$frequency">
				<frequency>
					<xsl:value-of select="$frequency"/>
				</frequency>
			</xsl:if>
			<xsl:if test="$period">
				<period>
					<xsl:value-of select="$period"/>
				</period>
			</xsl:if>
			<xsl:if test="$day_in_month">
				<day_in_month>
					<xsl:value-of select="$day_in_month"/>
				</day_in_month>
			</xsl:if>
			<xsl:if test="first_date">
				<first_date>
					<xsl:value-of select="first_date"/>
				</first_date>
			</xsl:if>
			<xsl:if test="percent">
				<percentage>
					<xsl:value-of select="percent"/>
				</percentage>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code>
					<xsl:value-of select="cur_code"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="amount">
				<amount>
					<xsl:value-of select="amount"/>
				</amount>
			</xsl:if>
			<xsl:if test="operation">
				<operation>
					<xsl:value-of select="operation"/>
				</operation>
			</xsl:if>
			<xsl:if test="sequence">
				<sequence>
					<xsl:value-of select="sequence"/>
				</sequence>
			</xsl:if>
		</com.misys.portal.product.common.Variation>
	</xsl:template>
	
	<xsl:template name="ruVariationDetails">
	    <xsl:param name="type"/>
		<xsl:param name="advise_flag"/>
		<xsl:param name="advise_reduction_days"/>
		<xsl:param name="maximum_nb_days"/>
		<xsl:param name="frequency"/>
		<xsl:param name="period"/>	
		<xsl:param name="day_in_month"/>			
		
		<com.misys.portal.product.common.RuVariation>
			<xsl:if test="ref_id">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="tnx_id">
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="brch_code">
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id><xsl:value-of select="company_id"/></company_id>
			</xsl:if>
			<xsl:if test="$type">
				<type>
					<xsl:value-of select="$type"/>
				</type>
			</xsl:if>
			<xsl:if test="$advise_flag">
				<advise_flag>
					<xsl:value-of select="$advise_flag"/>
				</advise_flag>
			</xsl:if>
			<xsl:if test="$advise_reduction_days">
				<advise_reduction_days>
					<xsl:value-of select="$advise_reduction_days"/>
				</advise_reduction_days>
			</xsl:if>
			<xsl:if test="$maximum_nb_days">
				<maximum_nb_days>
					<xsl:value-of select="$maximum_nb_days"/>
				</maximum_nb_days>
			</xsl:if>
			<xsl:if test="$frequency">
				<frequency>
					<xsl:value-of select="$frequency"/>
				</frequency>
			</xsl:if>
			<xsl:if test="$period">
				<period>
					<xsl:value-of select="$period"/>
				</period>
			</xsl:if>
			<xsl:if test="$day_in_month">
				<day_in_month>
					<xsl:value-of select="$day_in_month"/>
				</day_in_month>
			</xsl:if>
			<xsl:if test="first_date">
				<first_date>
					<xsl:value-of select="first_date"/>
				</first_date>
			</xsl:if>
			<xsl:if test="percent">
				<percentage>
					<xsl:value-of select="percent"/>
				</percentage>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code>
					<xsl:value-of select="cur_code"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="amount">
				<amount>
					<xsl:value-of select="amount"/>
				</amount>
			</xsl:if>
			<xsl:if test="operation">
				<operation>
					<xsl:value-of select="operation"/>
				</operation>
			</xsl:if>
			<xsl:if test="sequence">
				<sequence>
					<xsl:value-of select="sequence"/>
				</sequence>
			</xsl:if>
		</com.misys.portal.product.common.RuVariation>
	</xsl:template>	

	
</xsl:stylesheet>