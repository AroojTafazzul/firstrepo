<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:output method="xml" omit-xml-declaration="yes"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="el_tnx_record"/>
	</xsl:template>
	<!-- Create a Document preparation data from the el record-->
	<xsl:template match="el_tnx_record">
		<xsl:element name="CountryOfOrigin">
			<xsl:element name="countryName"/>
		</xsl:element>
		<xsl:element name="CountryOfDestination">
			<xsl:element name="countryName"/>
		</xsl:element>
		<xsl:element name="purchaseOrderReference"/>
		<xsl:element name="commercialInvoiceReference"/>
		<xsl:element name="documentaryCreditReference">
			<xsl:value-of select="lc_ref_id"/>
		</xsl:element>
		<xsl:element name="exportDocumentaryCreditReference">
			<xsl:value-of select="bo_ref_id"/>
		</xsl:element>
		<xsl:element name="Shipper">
			<xsl:element name="organizationName">
				<xsl:value-of select="beneficiary_name"/>
			</xsl:element>
			<xsl:element name="addressLine1">
				<xsl:value-of select="beneficiary_address_line_1"/>
			</xsl:element>
			<xsl:element name="addressLine2">
				<xsl:value-of select="beneficiary_address_line_2"/>
			</xsl:element>
			<xsl:element name="addressLine3">
				<xsl:value-of select="beneficiary_dom"/>
			</xsl:element>
			<xsl:element name="organizationReference">
				<xsl:value-of select="beneficiary_reference"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="Consignee">
			<xsl:element name="organizationName">
				<xsl:value-of select="applicant_name"/>
			</xsl:element>
			<xsl:element name="addressLine1">
				<xsl:value-of select="applicant_address_line_1"/>
			</xsl:element>
			<xsl:element name="addressLine2">
				<xsl:value-of select="applicant_address_line_2"/>
			</xsl:element>
			<xsl:element name="addressLine3">
				<xsl:value-of select="applicant_dom"/>
			</xsl:element>
			<xsl:element name="organizationReference">
				<xsl:value-of select="applicant_reference"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="BillTo">
			<xsl:element name="organizationName">
				<xsl:value-of select="applicant_name"/>
			</xsl:element>
			<xsl:element name="addressLine1">
				<xsl:value-of select="applicant_address_line_1"/>
			</xsl:element>
			<xsl:element name="addressLine2">
				<xsl:value-of select="applicant_address_line_2"/>
			</xsl:element>
			<xsl:element name="addressLine3">
				<xsl:value-of select="applicant_dom"/>
			</xsl:element>
			<xsl:element name="organizationReference">
				<xsl:value-of select="applicant_reference"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="Buyer">
			<xsl:element name="organizationName">
				<xsl:value-of select="applicant_name"/>
			</xsl:element>
			<xsl:element name="addressLine1">
				<xsl:value-of select="applicant_address_line_1"/>
			</xsl:element>
			<xsl:element name="addressLine2">
				<xsl:value-of select="applicant_address_line_2"/>
			</xsl:element>
			<xsl:element name="addressLine3">
				<xsl:value-of select="applicant_dom"/>
			</xsl:element>
			<xsl:element name="organizationReference">
				<xsl:value-of select="applicant_reference"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="RoutingSummary">
			<xsl:element name="transportService"/>
			<xsl:element name="transportType"/>
			<xsl:element name="departureDate"/>
			<xsl:element name="PlaceOfLoading">
				<xsl:element name="locationName">
					<xsl:value-of select="ship_from"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="PlaceOfDischarge">
				<xsl:element name="locationName">
					<xsl:value-of select="ship_to"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="PlaceOfReceipt">
				<xsl:element name="locationName"/>
			</xsl:element>
			<xsl:element name="transportReference"/>
			<xsl:element name="vesselName"/>
			<xsl:element name="PlaceOfReceipt">
				<xsl:element name="locationName"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="Incoterms">
			<xsl:element name="incotermsCode">
				<xsl:value-of select="inco_term"/>
			</xsl:element>
			<xsl:element name="incotermsPlace">
				<xsl:value-of select="inco_place"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="AdditionalInformation"/>
		<xsl:element name="TermsAndConditions"/>
		<xsl:element name="PaymentTerms">
			<xsl:choose>
				<xsl:when test="cr_avl_by_code[. = '01']">
					<xsl:element name="line">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL')"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_PAYMENT')"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="cr_avl_by_code[. = '02']">
					<xsl:element name="line">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL')"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_ACCEPTANCE')"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="cr_avl_by_code[. = '03']">
					<xsl:element name="line">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL')"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_NEGOTIATION')"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="cr_avl_by_code[. = '04']">
					<xsl:element name="line">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL')"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEFERRED')"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="cr_avl_by_code[. = '05']">
					<xsl:element name="line">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL')"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED')"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<xsl:if test="draft_term[.!='']">
				<xsl:element name="line">
					<xsl:choose>
						<xsl:when test="cr_avl_by_code[. = '02'] or cr_avl_by_code[. = '03']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_LABEL')"/>
							<xsl:value-of select="draft_term" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_PAYMT_LABEL')"/>
							<xsl:value-of select="draft_term" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<xsl:element name="LineItemDetails"/>
		<xsl:element name="PackingDetail"/>
		<xsl:element name="Totals">
			<xsl:element name="Total">
				<xsl:element name="totalAmount">
					<xsl:value-of select="lc_amt"/>
				</xsl:element>
				<xsl:element name="totalCurrencyCode">
					<xsl:value-of select="lc_cur_code"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>


     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
