<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:encryption="xalan://com.misys.portal.common.security.sso.Cypher" 
	exclude-result-prefixes="converttools encryption">

	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<xsl:output method="xml" indent="no"/>
	
	<!-- Get the language code -->
	<xsl:param name="language"/>
	

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Document Preparation-->
	<xsl:template match="dm_tnx_record">
		<result>
			<com.misys.portal.product.dm.common.DocumentFolder>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code><xsl:value-of select="brch_code"/></brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id><xsl:value-of select="company_id"/></company_id>
				</xsl:if>
				<xsl:if test="entity">
					<entity> <xsl:value-of select="entity"/> </entity>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name><xsl:value-of select="company_name"/></company_name>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code><xsl:value-of select="product_code"/></product_code>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
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
				<xsl:if test="appl_date">
					<appl_date><xsl:value-of select="appl_date"/></appl_date>
				</xsl:if>
				<xsl:if test="prep_date">
					<prep_date><xsl:value-of select="prep_date"/></prep_date>
				</xsl:if>
				<xsl:if test="amd_no">
					<amd_no><xsl:value-of select="amd_no"/></amd_no>
				</xsl:if>
				<xsl:if test="type">
					<type><xsl:value-of select="type"/></type>
				</xsl:if>
				<!-- Amount and Currency -->
				<xsl:if test="total_amount">
					<dm_amt><xsl:value-of select="total_amount"/></dm_amt>
				</xsl:if>
				<xsl:if test="total_currency">
					<cur_code><xsl:value-of select="total_currency"/></cur_code>
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
				<!-- Presentation reference -->
				<xsl:if test="pres_ref_id">
					<pres_ref_id><xsl:value-of select="pres_ref_id"/></pres_ref_id>
				</xsl:if>
				<!-- Internal link references -->
				<xsl:if test="parent_ref_id">
					<parent_ref_id><xsl:value-of select="parent_ref_id"/></parent_ref_id>
				</xsl:if>
				<xsl:if test="parent_product_code">
					<parent_product_code><xsl:value-of select="parent_product_code"/></parent_product_code>
				</xsl:if>
				<xsl:if test="parent_bo_ref_id">
					<parent_bo_ref_id><xsl:value-of select="parent_bo_ref_id"/></parent_bo_ref_id>
				</xsl:if>
				<!-- Counterparty details -->
				<xsl:if test="consignee_name">
					<counterparty_name><xsl:value-of select="consignee_name"/></counterparty_name>
				</xsl:if>
				<xsl:if test="consignee_address_line_1">
					<counterparty_address_line_1><xsl:value-of select="consignee_address_line_1"/></counterparty_address_line_1>
				</xsl:if>
				<xsl:if test="consignee_address_line_2">
					<counterparty_address_line_2><xsl:value-of select="consignee_address_line_2"/></counterparty_address_line_2>
				</xsl:if>
				<xsl:if test="consignee_dom">
					<counterparty_dom><xsl:value-of select="consignee_dom"/></counterparty_dom>
				</xsl:if>
				<xsl:if test="consignee_country">
					<counterparty_country><xsl:value-of select="consignee_country"/></counterparty_country>
				</xsl:if>
				<xsl:if test="consignee_reference">
					<counterparty_reference><xsl:value-of select="consignee_reference"/></counterparty_reference>
				</xsl:if>
				<!-- eUCP data -->
				<xsl:if test="eucp_flag">
					<eucp_flag><xsl:value-of select="eucp_flag"/></eucp_flag>
				</xsl:if>
				<xsl:if test="eucp_version">
					<eucp_version><xsl:value-of select="eucp_version"/></eucp_version>
				</xsl:if>
				<xsl:if test="eucp_reference">
					<eucp_reference><xsl:value-of select="eucp_reference"/></eucp_reference>
				</xsl:if>
				<xsl:if test="eucp_presentation_place">
					<eucp_presentation_place><xsl:value-of select="eucp_presentation_place"/></eucp_presentation_place>
				</xsl:if>
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description=" Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>

				<!-- Template data -->
				<!-- The following test make sure the data is generated only for document generation (and not upload) -->
				<!-- The total_currency existence cjecking also makes sure the data element won't be created at control time -->
				<xsl:if test="tnx_type_code[.='01'] or tnx_type_code[.='02']">
				
					<!-- Full document preparation folder -->
					<!-- The data is stored as text. We therefore need to convert all amounts and dates - received in user locale - to a standard default format for future use -->
					
					<xsl:element name="data">
						<xsl:element name="CountryOfOrigin">
							<xsl:element name="countryName">
								<xsl:value-of select="country_of_origin"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="CountryOfDestination">
							<xsl:element name="countryName">
								<xsl:value-of select="country_of_destination"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="purchaseOrderReference">
							<xsl:value-of select="purchase_order_identifier"/>
						</xsl:element>
						<xsl:element name="commercialInvoiceReference">
							<xsl:value-of select="comercial_invoice_identifier"/>
						</xsl:element>
						<xsl:element name="documentaryCreditReference">
							<xsl:value-of select="issuing_bank_reference"/>
						</xsl:element>
						<xsl:element name="exportDocumentaryCreditReference">
							<xsl:value-of select="advising_bank_reference"/>
						</xsl:element>
						<xsl:element name="exporterReference">
							<xsl:value-of select="exporter_reference"/>
						</xsl:element>
						<xsl:element name="Shipper">
							<xsl:element name="organizationName">
								<xsl:value-of select="shipper_name"/>
							</xsl:element>
							<xsl:element name="addressLine1">
								<xsl:value-of select="shipper_address_line_1"/>
							</xsl:element>
							<xsl:element name="addressLine2">
								<xsl:value-of select="shipper_address_line_2"/>
							</xsl:element>
							<xsl:element name="addressLine3">
								<xsl:value-of select="shipper_dom"/>
							</xsl:element>
							<xsl:element name="organizationReference">
								<xsl:value-of select="shipper_reference"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="Consignee">
							<xsl:element name="organizationName">
								<xsl:value-of select="consignee_name"/>
							</xsl:element>
							<xsl:element name="addressLine1">
								<xsl:value-of select="consignee_address_line_1"/>
							</xsl:element>
							<xsl:element name="addressLine2">
								<xsl:value-of select="consignee_address_line_2"/>
							</xsl:element>
							<xsl:element name="addressLine3">
								<xsl:value-of select="consignee_dom"/>
							</xsl:element>
							<xsl:element name="organizationReference">
								<xsl:value-of select="consignee_reference"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="BillTo">
							<xsl:element name="organizationName">
								<xsl:value-of select="bill_to_name"/>
							</xsl:element>
							<xsl:element name="addressLine1">
								<xsl:value-of select="bill_to_address_line_1"/>
							</xsl:element>
							<xsl:element name="addressLine2">
								<xsl:value-of select="bill_to_address_line_2"/>
							</xsl:element>
							<xsl:element name="addressLine3">
								<xsl:value-of select="bill_to_dom"/>
							</xsl:element>
							<xsl:element name="organizationReference">
								<xsl:value-of select="bill_to_reference"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="Buyer">
							<xsl:element name="organizationName">
								<xsl:value-of select="buyer_name"/>
							</xsl:element>
							<xsl:element name="addressLine1">
								<xsl:value-of select="buyer_address_line_1"/>
							</xsl:element>
							<xsl:element name="addressLine2">
								<xsl:value-of select="buyer_address_line_2"/>
							</xsl:element>
							<xsl:element name="addressLine3">
								<xsl:value-of select="buyer_dom"/>
							</xsl:element>
							<xsl:element name="organizationReference">
								<xsl:value-of select="buyer_reference"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="RoutingSummary">
							<xsl:element name="transportService">
								<xsl:value-of select="transport_service"/>
							</xsl:element>
							<xsl:element name="transportType">
								<xsl:value-of select="transport_type"/>
							</xsl:element>
							<xsl:element name="departureDate">
								<xsl:if test="departure_date[.!='']">
									<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
									 received in user locale to a standard default format for future use -->
									<xsl:variable name="date"><xsl:value-of select="departure_date"/></xsl:variable>
									<xsl:value-of select="converttools:getDefaultTimestampRepresentation($date,$language)"/>
								</xsl:if>
							</xsl:element>
							<xsl:element name="PlaceOfLoading">
								<xsl:element name="locationName">
									<xsl:value-of select="place_of_loading"/>
								</xsl:element>
							</xsl:element>
							<xsl:element name="PlaceOfDischarge">
								<xsl:element name="locationName">
									<xsl:value-of select="place_of_discharge"/>
								</xsl:element>
							</xsl:element>
							<xsl:element name="PlaceOfDelivery">
								<xsl:element name="locationName">
									<xsl:value-of select="place_of_delivery"/>
								</xsl:element>
							</xsl:element>
							<xsl:element name="transportReference">
								<xsl:value-of select="transport_reference"/>
							</xsl:element>
							<xsl:element name="vesselName">
								<xsl:value-of select="vessel_name"/>
							</xsl:element>
							<xsl:element name="PlaceOfReceipt">
								<xsl:element name="locationName">
									<xsl:value-of select="place_of_receipt"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						<xsl:element name="Incoterms">
							<xsl:element name="incotermsCode">
								<xsl:value-of select="inco_term"/>
							</xsl:element>
							<xsl:element name="incotermsPlace">
								<xsl:value-of select="incoterm_place"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="AdditionalInformation">
							<xsl:element name="line">
								<xsl:value-of select="additionnal_information"/>
							</xsl:element>
						</xsl:element>
						
						
						<!--*****************-->
						<!-- Term details -->
						<!--*****************-->
						<xsl:element name="TermsAndConditions">
							<xsl:call-template name="TERM_DETAILS"/>
						</xsl:element>
						
						
						<xsl:element name="PaymentTerms">
							<xsl:element name="line">
								<xsl:value-of select="payment_terms"/>
							</xsl:element>
						</xsl:element>
						
						
						<!--*****************-->
						<!-- Product details -->
						<!--*****************-->
						
						<xsl:element name="LineItemDetails">
							<xsl:call-template name="PRODUCT_DETAILS"/>
						</xsl:element>
						
						
						<!--**********************-->
						<!-- Charges or Discounts -->
						<!--**********************-->
						
						<xsl:call-template name="CHARGE_DETAILS"/>
						


						<xsl:element name="Totals">
							<xsl:element name="Total">
								<xsl:element name="totalAmount">
									<xsl:if test="total_amount[.!='']">
										<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
									 received in user locale to a standard default format for future use -->
										<xsl:variable name="amount"><xsl:value-of select="total_amount"/></xsl:variable>
										<xsl:variable name="currency"><xsl:value-of select="total_currency"/></xsl:variable>
										<xsl:value-of select="converttools:getDefaultAmountRepresentation($amount, $language)"/>
									</xsl:if>
								</xsl:element>
								<xsl:element name="totalCurrencyCode">
									<xsl:value-of select="total_currency"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						
						
						<!--*****************-->
						<!-- Packing details -->
						<!--*****************-->
						<xsl:element name="PackingDetail">
							
							<xsl:call-template name="PACKING_DETAILS"/>
							
							<xsl:element name="totalNetWeightValue">
								<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_net_weight,$language)"/>
								<!--
								<xsl:value-of select="total_net_weight"/>
								-->
							</xsl:element>
							<xsl:element name="totalNetWeightUnitCode">
								<xsl:value-of select="total_net_weight_unit"/>
							</xsl:element>
							<xsl:element name="totalGrossWeightValue">
								<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_gross_weight,$language)"/>
								<!--
								<xsl:value-of select="total_gross_weight"/>
								-->
							</xsl:element>
							<xsl:element name="totalGrossWeightUnitCode">
								<xsl:value-of select="total_gross_weight_unit"/>
							</xsl:element>
							<xsl:element name="totalNetVolumeValue">
								<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_net_volume,$language)"/>
								<!--
								<xsl:value-of select="total_net_volume"/>
								-->
							</xsl:element>
							<xsl:element name="totalNetVolumeUnitCode">
								<xsl:value-of select="total_net_volume_unit"/>
							</xsl:element>
							<xsl:element name="totalGrossVolumeValue">
								<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_gross_volume,$language)"/>
								<!--
								<xsl:value-of select="total_gross_volume"/>
								-->
							</xsl:element>
							<xsl:element name="totalGrossVolumeUnitCode">
								<xsl:value-of select="total_gross_volume_unit"/>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.dm.common.DocumentFolder>
			
			<xsl:apply-templates select="documents/document">
				<xsl:with-param name="brch_code"><xsl:value-of select="brch_code"/></xsl:with-param>
				<xsl:with-param name="company_id"><xsl:value-of select="company_id"/></xsl:with-param>
				<xsl:with-param name="ref_id"><xsl:value-of select="ref_id"/></xsl:with-param>
				<xsl:with-param name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:with-param>
			</xsl:apply-templates>
			
			<xsl:apply-templates select="versionned_documents/document">
				<xsl:with-param name="brch_code"><xsl:value-of select="brch_code"/></xsl:with-param>
				<xsl:with-param name="company_id"><xsl:value-of select="company_id"/></xsl:with-param>
				<xsl:with-param name="ref_id"><xsl:value-of select="ref_id"/></xsl:with-param>
			</xsl:apply-templates>
			
			<!-- Issuing Bank (presentation to bank) -->
			<xsl:if test="issuing_bank_abbv_name">
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
			</xsl:if>
			<com.misys.portal.product.common.Narrative>
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
				<type_code>11</type_code>
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative>
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
		</result>
	</xsl:template>
	
	<xsl:template match="documents/document">
		<xsl:param name="brch_code"/>
		<xsl:param name="company_id"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		
		<!-- Filter out the new unused documents -->
			<com.misys.portal.product.dm.common.DocumentInstance>
					<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
					<xsl:if test="tnx_id">
						<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="document_id"><xsl:value-of select="document_id"/></xsl:attribute>

					<brch_code><xsl:value-of select="$brch_code"/></brch_code>
					<company_id><xsl:value-of select="$company_id"/></company_id>
					<xsl:if test="description">
						<description><xsl:value-of select="description"/></description>
					</xsl:if>
					<xsl:if test="code">
						<code><xsl:value-of select="code"/></code>
					</xsl:if>
					<xsl:if test="type">
						<type><xsl:value-of select="type"/></type>	
					</xsl:if>
					<xsl:if test="from_template">
						<additional_field name="from_template" type="string" scope="none" description="New document created from the template data."><xsl:value-of select="from_template"/></additional_field>
					</xsl:if>
					<xsl:if test="from_document_id">
						<additional_field name="from_document_id" type="string" scope="none" description="New document created from this existing document id data."><xsl:value-of select="from_document_id"/></additional_field>
					</xsl:if>
					<xsl:if test="from_folder">
						<additional_field name="from_folder" type="string" scope="none" description="New document created from the folder data."><xsl:value-of select="from_folder"/></additional_field>
					</xsl:if>
					<xsl:if test="title">
						<title><xsl:value-of select="title"/></title>
					</xsl:if>
					<xsl:if test="attached">
						<additional_field name="attached" type="string" scope="none" description="This document is selected to be attached to the presentation."><xsl:value-of select="attached"/></additional_field>
					</xsl:if>
					<xsl:if test="deleted">
						<additional_field name="deleted" type="string" scope="none" description="This document is selected to be deleted."><xsl:value-of select="deleted"/></additional_field>
					</xsl:if>
					<xsl:if test="versionned">
						<additional_field name="versionned" type="string" scope="none" description="This document is selected to be versionned."><xsl:value-of select="versionned "/></additional_field >
					</xsl:if>
					<xsl:if test="file_name">
						<additional_field name="file_name" type="string" scope="none" description="File name for the uploaded document creation."><xsl:value-of select="file_name"/></additional_field>
					</xsl:if>
					<xsl:if test="format">
						<format><xsl:value-of select="format"/></format>
					</xsl:if>
					<xsl:if test="version">
						<version><xsl:value-of select="version"/></version>
					</xsl:if>
					<xsl:if test="cust_ref_id">
						<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
					</xsl:if>
					<xsl:if test="transformation_code">
						<transformation_code><xsl:value-of select="transformation_code"/></transformation_code>
					</xsl:if>
			</com.misys.portal.product.dm.common.DocumentInstance>
	</xsl:template>
	
	<!-- Master documents may be sent for Purge -->
	<xsl:template match="versionned_documents/document">
		<xsl:param name="brch_code"/>
		<xsl:param name="company_id"/>
		<xsl:param name="ref_id"/>
		
		<!-- Filter out the new unused documents -->
			<com.misys.portal.product.dm.common.MasterDocumentInstance>
					<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
					<xsl:attribute name="document_id"><xsl:value-of select="document_id"/></xsl:attribute>

					<brch_code><xsl:value-of select="$brch_code"/></brch_code>
					<company_id><xsl:value-of select="$company_id"/></company_id>
					<xsl:if test="description">
						<description><xsl:value-of select="description"/></description>
					</xsl:if>
					<xsl:if test="code">
						<code><xsl:value-of select="code"/></code>
					</xsl:if>
					<xsl:if test="type">
						<type><xsl:value-of select="type"/></type>
					</xsl:if>
					<xsl:if test="title">
						<title><xsl:value-of select="title"/></title>
					</xsl:if>
					<xsl:if test="deleted">
						<additional_field name="deleted" type="string" scope="none" description="This document is selected to be deleted."><xsl:value-of select="deleted"/></additional_field>
					</xsl:if>
					<xsl:if test="format">
						<format><xsl:value-of select="format"/></format>
					</xsl:if>
					<xsl:if test="version">
						<version><xsl:value-of select="version"/></version>
					</xsl:if>
					<xsl:if test="cust_ref_id">
						<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
					</xsl:if>
			</com.misys.portal.product.dm.common.MasterDocumentInstance>
	</xsl:template>


	<!--**************************-->
	<!-- Product details template -->
	<!--**************************-->
	<xsl:template name="PRODUCT_DETAILS">
		<xsl:for-each select="//*[starts-with(name(), 'product_details_position_')]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'product_details_position_')"/>
			</xsl:variable>
			<xsl:element name="Item">
				<xsl:element name="itemNumber">
					<xsl:value-of select="$position"/>
				</xsl:element>
				<xsl:element name="productIdentification">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_product_identifier_', $position))]"/>
				</xsl:element>
				<xsl:element name="productName">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_product_description_', $position))]"/>
				</xsl:element>
				<xsl:element name="purchaseOrderReference">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_purchase_order_id_', $position))]"/>
				</xsl:element>
				<xsl:element name="exportLicenseReference">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_export_license_id_', $position))]"/>
				</xsl:element>
				<xsl:element name="baseCurrencyCode">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_base_currency_', $position))]"/>
				</xsl:element>
				<xsl:element name="basePrice">
					<xsl:if test="//*[starts-with(name(), concat('product_details_base_price_', $position))] != ''">
						<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
						 received in user locale to a standard default format for future use -->
						<xsl:value-of select="converttools:getDefaultAmountRepresentation(//*[starts-with(name(), concat('product_details_base_price_', $position))], //*[starts-with(name(), concat('product_details_base_currency_', $position))], $language)"/>
					</xsl:if>
				</xsl:element>
				<xsl:element name="baseUnitOfMeasureCode">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_base_unit_', $position))]"/>
				</xsl:element>
				<xsl:element name="itemQuantity">
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('product_details_product_quantity_', $position))], $language)"/>
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_product_quantity_', $position))]"/>
					-->
				</xsl:element>
				<xsl:element name="itemQuantityUnitOfMeasureCode">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_product_unit_', $position))]"/>
				</xsl:element>
				<xsl:element name="rate">
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('product_details_product_rate_', $position))], $language)"/>
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_product_rate_', $position))]"/>
					-->
				</xsl:element>
				<xsl:element name="totalPrice">
					<xsl:if test="//*[starts-with(name(), concat('product_details_product_price_', $position))] != ''">
						<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
						 received in user locale to a standard default format for future use -->
						<xsl:value-of select="converttools:getDefaultAmountRepresentation(//*[starts-with(name(), concat('product_details_product_price_', $position))], //*[starts-with(name(), concat('product_details_product_currency_', $position))], $language)"/>
					</xsl:if>
				</xsl:element>
				<xsl:element name="totalCurrencyCode">
					<xsl:value-of select="//*[starts-with(name(), concat('product_details_product_currency_', $position))]"/>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>


	<!--*******************************-->
	<!-- Charges or Discounts template -->
	<!--*******************************-->
	<xsl:template name="CHARGE_DETAILS">
		<xsl:for-each select="//*[starts-with(name(), 'charge_details_position_')]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'charge_details_position_')"/>
			</xsl:variable>
			<xsl:variable name="amount">
				<xsl:value-of select="//*[starts-with(name(), concat('charge_details_charge_currency_', $position))]"/>
			</xsl:variable>
			<xsl:element name="GeneralChargesOrDiscounts">
				<xsl:element name="chargeType">
					<xsl:value-of select="//*[starts-with(name(), concat('charge_details_charge_type_', $position))]"/>
				</xsl:element>
				<xsl:element name="chargeAmount">
					<xsl:if test="//*[starts-with(name(), concat('charge_details_charge_amount_', $position))] != ''">
						<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
						 received in user locale to a standard default format for future use -->
						<xsl:value-of select="converttools:getDefaultAmountRepresentation(//*[starts-with(name(), concat('charge_details_charge_amount_', $position))], //*[starts-with(name(), concat('charge_details_charge_currency_', $position))], $language)"/>
					</xsl:if>
				</xsl:element>
				<xsl:element name="chargeCurrencyCode">
					<xsl:value-of select="//*[starts-with(name(), concat('charge_details_charge_currency_', $position))]"/>
				</xsl:element>
				<xsl:element name="rate">
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('charge_details_charge_rate_', $position))], $language)"/>
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('charge_details_charge_rate_', $position))]"/>
					-->
				</xsl:element>
				<xsl:element name="chargeReportingAmount">
					<xsl:variable name="amount"><xsl:value-of select="//*[starts-with(name(), concat('charge_details_charge_reporting_amount_', $position))]"/></xsl:variable>
					<xsl:if test="//*[starts-with(name(), concat('charge_details_charge_reporting_amount_', $position))] != ''">
						<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
						 received in user locale to a standard default format for future use -->
						<xsl:value-of select="converttools:getDefaultAmountRepresentation(//*[starts-with(name(), concat('charge_details_charge_reporting_amount_', $position))], //*[starts-with(name(), concat('charge_details_charge_reporting_currency_', $position))], $language)"/>
					</xsl:if>
				</xsl:element>
				<xsl:element name="chargeReportingCurrencyCode">
					<xsl:value-of select="//*[starts-with(name(), concat('charge_details_charge_reporting_currency_', $position))]"/>
				</xsl:element>
				<xsl:element name="chargeDescription">
					<xsl:value-of select="//*[starts-with(name(), concat('charge_details_charge_description_', $position))]"/>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
		
	<!--**************************-->
	<!-- Packing details template -->
	<!--**************************-->
	<xsl:template name="PACKING_DETAILS">
		<xsl:for-each select="//*[starts-with(name(), 'packing_details_position_')]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'packing_details_position_')"/>
			</xsl:variable>
			<xsl:element name="Package">
				<xsl:element name="numberOfPackages">
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_number_', $position))], $language)"/>
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_number_', $position))]"/>
					-->
				</xsl:element>
				<xsl:element name="typeOfPackage">
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_type_', $position))]"/>
				</xsl:element>
				<xsl:element name="marksAndNumbers">
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_marks_', $position))]"/>
				</xsl:element>
				<xsl:element name="heightValue">
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_height_', $position))]"/>
					-->
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_height_', $position))], $language)"/>
				</xsl:element>
				<xsl:element name="widthValue">
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_width_', $position))]"/>
					-->
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_width_', $position))], $language)"/>
				</xsl:element>
				<xsl:element name="lengthValue">
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_length_', $position))]"/>
					-->
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_length_', $position))], $language)"/>
				</xsl:element>
				<xsl:element name="dimensionUnitCode">
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_dimension_unit_', $position))]"/>
				</xsl:element>
				<xsl:element name="netWeightValue">
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_netweight_', $position))]"/>
					-->
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_netweight_', $position))], $language)"/>
				</xsl:element>
				<xsl:element name="grossWeightValue">
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_grossweight_', $position))]"/>
					-->
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_grossweight_', $position))], $language)"/>
				</xsl:element>
				<xsl:element name="weightUnitCode">
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_weight_unit_', $position))]"/>
				</xsl:element>
				<xsl:element name="grossVolumeValue">
					<!--
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_grossvolume_', $position))]"/>
					-->
					<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_grossvolume_', $position))], $language)"/>
				</xsl:element>
				<xsl:element name="volumeUnitCode">
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_volume_unit_', $position))]"/>
				</xsl:element>
				<xsl:element name="productName">
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_description_', $position))]"/>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>

	<!--***********************-->
	<!-- Term details template -->
	<!--***********************-->
	<xsl:template name="TERM_DETAILS">
		<xsl:for-each select="//*[starts-with(name(), 'term_details_position_')]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'term_details_position_')"/>
			</xsl:variable>
			<xsl:element name="clause">
				<xsl:value-of select="//*[starts-with(name(), concat('term_details_term_clause_', $position))]"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
		

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
