<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:encryption="xalan://com.misys.portal.common.security.sso.Cypher" 
	exclude-result-prefixes="encryption converttools"
	>

	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	
	<!-- Get the language code -->
	<xsl:param name="language"/>
	

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Document Preparation-->
	<xsl:template match="document_tnx_record">
		<result>
			<com.misys.portal.product.dm.common.DocumentInstance>
					<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
					<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
					<xsl:attribute name="document_id"><xsl:value-of select="document_id"/></xsl:attribute>
			
					<brch_code><xsl:value-of select="brch_code"/></brch_code>
					<company_id><xsl:value-of select="company_id"/></company_id>
					<!-- The tnx id is specific to the document -->
					<description><xsl:value-of select="description"/></description>
					<code><xsl:value-of select="code"/></code>
					<title><xsl:value-of select="title"/></title>
					<type><xsl:value-of select="type"/></type>
					<xsl:if test="from_template">
						<additional_field name="from_template" type="string" scope="none"><xsl:value-of select="from_template"/></additional_field>
					</xsl:if>
					<xsl:if test="from_document_id">
						<additional_field name="from_document_id" type="string" scope="transaction"><xsl:value-of select="from_document_id"/></additional_field>
					</xsl:if>
					<xsl:if test="from_version">
						<additional_field name="from_version" type="string" scope="none"><xsl:value-of select="from_version"/></additional_field>
					</xsl:if>
					<xsl:if test="from_folder">
						<additional_field name="from_folder" type="string" scope="none"><xsl:value-of select="from_folder"/></additional_field>
					</xsl:if>
					<xsl:if test="attached">
						<additional_field name="attached" type="string" scope="none"><xsl:value-of select="attached"/></additional_field>
					</xsl:if>
					<xsl:if test="deleted">
						<additional_field name="deleted" type="string" scope="none"><xsl:value-of select="deleted"/></additional_field>
					</xsl:if>
					<xsl:if test="file_name">
						<additional_field name="file_name" type="string" scope="none"><xsl:value-of select="file_name"/></additional_field>
					</xsl:if>
					<format><xsl:value-of select="format"/></format>
					<version><xsl:value-of select="version"/></version>
					<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
					<prep_date><xsl:value-of select="prep_date"/></prep_date>
					
				<!-- Template data -->
				<!-- The following test make sure the data is generated only for document generation (and not upload) -->
				<!-- The total_currency existence cjecking also makes sure the data element won't be created at control time -->
				<xsl:if test="type[.='01']">
				
					<!-- Full document preparation folder -->
					<!-- The data is stored as text. We therefore need to convert all amounts and dates - received in user locale - to a standard default format for future use -->
					
					<xsl:element name="data">
						<xsl:element name="gtp:BillOfExchange"  xmlns:gtp="http://www.neomalogic.com" xmlns:cmp="http://www.bolero.net">
							<!--Header: empty so far -->
							<xsl:element name="gtp:Header">
								<xsl:element name="gtp:DocumentID">
									<xsl:element name="gtp:RID">
										<xsl:value-of select="cust_ref_id"/>
									</xsl:element>
									<xsl:element name="gtp:GeneralID">
										<xsl:value-of select="cust_ref_id"/>
									</xsl:element>
								</xsl:element>
								<xsl:element name="gtp:DocType">
									<xsl:element name="gtp:DocTypeCode"/>
								</xsl:element>
								<xsl:element name="gtp:Status"/>
							</xsl:element>
							<!--Body -->
							<xsl:element name="gtp:Body">
								<!--General information section -->
								<xsl:element name="gtp:GeneralInformation">
									<xsl:element name="gtp:dateOfIssue">
										<xsl:if test="prep_date[.!='']">
											<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
											 received in user locale to a standard default format for future use -->
											<xsl:variable name="date"><xsl:value-of select="prep_date"/></xsl:variable>
											<xsl:value-of select="converttools:getDefaultTimestampRepresentation($date,$language)"/>
										</xsl:if>
									</xsl:element>
									<xsl:element name="gtp:PlaceOfIssue">
										<xsl:element name="gtp:locationName">
											<xsl:value-of select="country_of_origin"/>
										</xsl:element>
									</xsl:element>
									<!--Purchase Order -->
									<xsl:element name="gtp:PurchaseOrderIdentifier">
										<xsl:element name="gtp:documentNumber">
											<xsl:value-of select="purchase_order_identifier"/>
										</xsl:element>
									</xsl:element>
									<!--Documentary credit: Issuing bank ref -->
									<xsl:element name="gtp:DocumentaryCreditIdentifier">
										<xsl:element name="gtp:documentNumber">
											<xsl:value-of select="issuing_bank_reference"/>
										</xsl:element>
									</xsl:element>
								</xsl:element>
								<!--Parties -->
								<xsl:element name="gtp:Parties">
									<xsl:element name="gtp:Seller">
										<xsl:element name="gtp:organizationName">
											<xsl:value-of select="seller_name"/>
										</xsl:element>
										<xsl:element name="gtp:OrganizationIdentification">
											<xsl:element name="gtp:organizationReference">
												<xsl:value-of select="seller_reference"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="gtp:AddressInformation">
											<xsl:element name="gtp:FullAddress">
												<xsl:element name="gtp:line">
													<xsl:value-of select="seller_address_line_1"/>
												</xsl:element>
												<xsl:element name="gtp:line">
													<xsl:value-of select="seller_address_line_2"/>
												</xsl:element>
												<xsl:element name="gtp:line">
													<xsl:value-of select="seller_dom"/>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:element>
									<xsl:element name="gtp:BillTo">
										<xsl:element name="gtp:organizationName">
											<xsl:value-of select="bill_to_name"/>
										</xsl:element>
										<xsl:element name="gtp:OrganizationIdentification">
											<xsl:element name="gtp:organizationReference">
												<xsl:value-of select="bill_to_reference"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="gtp:AddressInformation">
											<xsl:element name="gtp:FullAddress">
												<xsl:element name="gtp:line">
													<xsl:value-of select="bill_to_address_line_1"/>
												</xsl:element>
												<xsl:element name="gtp:line">
													<xsl:value-of select="bill_to_address_line_2"/>
												</xsl:element>
												<xsl:element name="gtp:line">
													<xsl:value-of select="bill_to_dom"/>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:element>
								</xsl:element>
								
								<!--Totals-->
								<xsl:element name="gtp:Totals">
									<xsl:element name="gtp:TotalAmount">
										<xsl:element name="gtp:MultiCurrency">
											<xsl:element name="gtp:value">
												<xsl:if test="total_amount[.!='']">
													<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
												 received in user locale to a standard default format for future use -->
													<xsl:variable name="amount"><xsl:value-of select="total_amount"/></xsl:variable>
													<xsl:variable name="currency"><xsl:value-of select="total_currency"/></xsl:variable>
													<xsl:value-of select="converttools:getDefaultAmountRepresentation($amount, $language)"/>
												</xsl:if>
											</xsl:element>
											<xsl:element name="gtp:currencyCode">
												<xsl:value-of select="total_currency"/>
											</xsl:element>
										</xsl:element>
									</xsl:element>
								</xsl:element>
								
								<xsl:element name="gtp:AdditionalInformation">
									<xsl:element name="gtp:line">
										<xsl:value-of select="additionnal_information"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</com.misys.portal.product.dm.common.DocumentInstance>
		</result>
	</xsl:template>
	
</xsl:stylesheet>
