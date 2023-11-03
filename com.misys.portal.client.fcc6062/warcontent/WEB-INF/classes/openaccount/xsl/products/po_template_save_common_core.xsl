<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	
	<!-- Buyer Defined Information template-->
	<xsl:template name="BUYER_DEFINED_INFORMATION">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="position"/>
		<xsl:if test="$position !='nbElement'">
		<com.misys.portal.openaccount.product.baseline.util.TemplateUserInfo>
			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:if test="$templateId">
				<template_id><xsl:value-of select="$templateId"/></template_id>
			</xsl:if>
			<xsl:element name="type">01</xsl:element>
			<xsl:element name="user_info_id"><xsl:value-of select="//*[starts-with(name(),concat('po_buyer_defined_information_details_user_info_id_', $position))]"/></xsl:element>
			<xsl:element name="label"><xsl:value-of select="//*[starts-with(name(),concat('po_buyer_defined_information_details_label_', $position))]"/></xsl:element>
			<xsl:element name="information"><xsl:value-of select="//*[starts-with(name(),concat('po_buyer_defined_information_details_information_', $position))]"/></xsl:element>
		</com.misys.portal.openaccount.product.baseline.util.TemplateUserInfo>
		</xsl:if>
	</xsl:template>	
	
	<!-- Seller Defined Information template -->
	<xsl:template name="SELLER_DEFINED_INFORMATION">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="position"/>
		<xsl:if test="$position !='nbElement'">
			<com.misys.portal.openaccount.product.baseline.util.TemplateUserInfo>
				<xsl:if test="$brchCode">
					<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				</xsl:if>
				<xsl:if test="$companyId">
					<company_id><xsl:value-of select="$companyId"/></company_id>
				</xsl:if>
				<xsl:if test="$templateId">
					<template_id><xsl:value-of select="$templateId"/></template_id>
				</xsl:if>
				<xsl:element name="type">02</xsl:element>
				<xsl:element name="user_info_id"><xsl:value-of select="//*[starts-with(name(),concat('po_seller_defined_information_details_user_info_id_', $position))]"/></xsl:element>
				<xsl:element name="label"><xsl:value-of select="//*[starts-with(name(),concat('po_seller_defined_information_details_label_', $position))]"/></xsl:element>
				<xsl:element name="information"><xsl:value-of select="//*[starts-with(name(),concat('po_seller_defined_information_details_information_', $position))]"/></xsl:element>
			</com.misys.portal.openaccount.product.baseline.util.TemplateUserInfo>
		</xsl:if>
	</xsl:template>	
	
	<xsl:template name="ADJUSTMENT">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structure_name"/>
		<xsl:call-template name="ALLOWANCE">
			<xsl:with-param name="brchCode"><xsl:value-of select="$brchCode"/></xsl:with-param>
			<xsl:with-param name="companyId"><xsl:value-of select="$companyId"/></xsl:with-param>
			<xsl:with-param name="templateId"><xsl:value-of select="$templateId"/></xsl:with-param>
			<xsl:with-param name="structure_name"><xsl:value-of select="$structure_name"/></xsl:with-param>
			<xsl:with-param name="allowance_type">02</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="TAX">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structure_name"/>
		<xsl:call-template name="ALLOWANCE">
			<xsl:with-param name="brchCode"><xsl:value-of select="$brchCode"/></xsl:with-param>
			<xsl:with-param name="companyId"><xsl:value-of select="$companyId"/></xsl:with-param>
			<xsl:with-param name="templateId"><xsl:value-of select="$templateId"/></xsl:with-param>
			<xsl:with-param name="structure_name"><xsl:value-of select="$structure_name"/></xsl:with-param>
			<xsl:with-param name="allowance_type">01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="FREIGHT_CHARGE">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structure_name"/>
		<xsl:call-template name="ALLOWANCE">
			<xsl:with-param name="brchCode"><xsl:value-of select="$brchCode"/></xsl:with-param>
			<xsl:with-param name="companyId"><xsl:value-of select="$companyId"/></xsl:with-param>
			<xsl:with-param name="templateId"><xsl:value-of select="$templateId"/></xsl:with-param>
			<xsl:with-param name="structure_name"><xsl:value-of select="$structure_name"/></xsl:with-param>
			<xsl:with-param name="allowance_type">03</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Allowance common template -->
	<xsl:template name="ALLOWANCE">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structure_name"/>
		<xsl:param name="allowance_type"/>
		<!-- Adjustment -->
		<xsl:if test="count(//*[starts-with(name(), concat($structure_name,'_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structure_name,'_details_position_'))]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), concat($structure_name,'_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($position ,'nbElement'))">
					<com.misys.portal.openaccount.product.baseline.util.TemplateAllowance>
						<xsl:if test="$brchCode">
							<brch_code><xsl:value-of select="$brchCode"/></brch_code>
						</xsl:if>
						<xsl:if test="$companyId">
							<company_id><xsl:value-of select="$companyId"/></company_id>
						</xsl:if>
						<xsl:if test="$templateId">
							<template_id><xsl:value-of select="$templateId"/></template_id>
						</xsl:if>
						<allowance_type>
							<xsl:value-of select="$allowance_type"/>
						</allowance_type>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_select_type_', $position))]">
							<type>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_select_type_', $position))]"/>
							</type>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_other_type_', $position))]">
							<other_type>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_other_type_', $position))]"/>
							</other_type>
						</xsl:if>						
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_id_', $position))]">
							<allowance_id>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_allowance_id_', $position))]"/>
							</allowance_id>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_radio_direction_', $position))]">
							<direction>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_radio_direction_', $position))]"/>
							</direction>
						</xsl:if>
					</com.misys.portal.openaccount.product.baseline.util.TemplateAllowance>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
		<!-- Contact template -->
	<xsl:template name="CONTACT">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structure_name"/>
		<xsl:if test="count(//*[starts-with(name(), concat($structure_name,'_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structure_name,'_details_position_'))]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), concat($structure_name,'_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($position ,'nbElement'))">
					<com.misys.portal.openaccount.product.baseline.util.TemplateContactPerson>
						<xsl:if test="$brchCode">
							<brch_code><xsl:value-of select="$brchCode"/></brch_code>
						</xsl:if>
						<xsl:if test="$companyId">
							<company_id><xsl:value-of select="$companyId"/></company_id>
						</xsl:if>
						<xsl:if test="$templateId">
							<template_id><xsl:value-of select="$templateId"/></template_id>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_type_', $position))]">
							<type>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_type_', $position))]"/>
							</type>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_ctcprsn_id_', $position))]">
							<ctcprsn_id>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_ctcprsn_id_', $position))]"/>
							</ctcprsn_id>
						</xsl:if>						
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_name_', $position))]">
							<name>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_name_', $position))]"/>
							</name>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_name_prefix_', $position))]">
							<name_prefix>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_name_prefix_', $position))]"/>
							</name_prefix>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_given_name_', $position))]">
							<given_name>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_given_name_', $position))]"/>
							</given_name>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_role_', $position))]">
							<role>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_role_', $position))]"/>
							</role>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_phone_number_', $position))]">
							<phone_number>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_phone_number_', $position))]"/>
							</phone_number>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_fax_number_', $position))]">
							<fax_number>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_fax_number_', $position))]"/>
							</fax_number>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_email_', $position))]">
							<email>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_email_', $position))]"/>
							</email>
						</xsl:if>
					</com.misys.portal.openaccount.product.baseline.util.TemplateContactPerson>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<!-- Payment template -->
	<xsl:template name="PAYMENT">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structure_name"/>
		<xsl:if test="count(//*[starts-with(name(), concat($structure_name,'_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structure_name,'_details_position_'))]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), concat($structure_name,'_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($position ,'nbElement'))">
					<com.misys.portal.openaccount.product.baseline.util.TemplatePaymentTerm>
						<xsl:if test="$brchCode">
							<brch_code><xsl:value-of select="$brchCode"/></brch_code>
						</xsl:if>
						<xsl:if test="$companyId">
							<company_id><xsl:value-of select="$companyId"/></company_id>
						</xsl:if>
						<xsl:if test="$templateId">
							<template_id><xsl:value-of select="$templateId"/></template_id>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_payment_id_', $position))]">
							<payment_id>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_payment_id_', $position))]"/>
							</payment_id>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_other_paymt_terms_', $position))]">
							<other_paymt_terms>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_other_paymt_terms_', $position))]"/>
							</other_paymt_terms>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_select_code_', $position))]">
							<code>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_select_code_', $position))]"/>
							</code>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_nb_days_', $position))]">
							<nb_days>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_nb_days_', $position))]"/>
							</nb_days>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_pct_', $position))]">
							<pct>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_pct_', $position))]"/>
							</pct>
						</xsl:if>
					</com.misys.portal.openaccount.product.baseline.util.TemplatePaymentTerm>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		</xsl:template>

	<!-- Incoterms template -->
	<xsl:template name="INCO_TERMS">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structure_name"/>
		<!-- Incoterms -->
		<xsl:if test="count(//*[starts-with(name(), concat($structure_name,'_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structure_name,'_details_position_'))]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), concat($structure_name,'_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($position ,'nbElement'))">
					<com.misys.portal.openaccount.product.baseline.util.TemplateIncoTerm>
						<xsl:if test="$brchCode">
							<brch_code><xsl:value-of select="$brchCode"/></brch_code>
						</xsl:if>
						<xsl:if test="$companyId">
							<company_id><xsl:value-of select="$companyId"/></company_id>
						</xsl:if>
						<xsl:if test="$templateId">
							<template_id><xsl:value-of select="$templateId"/></template_id>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_select_code_', $position))]">
							<code>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_select_code_', $position))]"/>
							</code>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_other_', $position))]">
							<other>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_other_', $position))]"/>
							</other>
						</xsl:if>						
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_id_', $position))]">
							<inco_term_id>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_id_', $position))]"/>
							</inco_term_id>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(), concat($structure_name,'_details_location_', $position))]">
							<location>
								<xsl:value-of select="//*[starts-with(name(), concat($structure_name,'_details_location_', $position))]"/>
							</location>
						</xsl:if>
					</com.misys.portal.openaccount.product.baseline.util.TemplateIncoTerm>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	
	
	<!-- Routing Summary (Transports) template-->
	<xsl:template name="INDIVIDUAL_TRANSPORTS">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structureName"/>
		<!-- AIR mode -->
		<xsl:if test="count(//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_details_position_'))]">
				<xsl:variable name="parentTransportPosition">
					<xsl:value-of select="substring-after(name(), concat($structureName, '_routing_summary_individual_air_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($parentTransportPosition ,'nbElement'))">
					<xsl:for-each select="//*[starts-with(name(),concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_position_'))]">
						<xsl:variable name="position">
							<xsl:value-of select="substring-after(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_position_'))"/>
						</xsl:variable>							
						<xsl:if test="not(contains($position ,'nbElement'))">
							<xsl:variable name="transport_sub_type"><xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_transport_sub_type_', $position))]"/></xsl:variable>
							
							<com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
								<xsl:if test="$brchCode">
									<brch_code><xsl:value-of select="$brchCode"/></brch_code>
								</xsl:if>
								<xsl:if test="$companyId">
									<company_id><xsl:value-of select="$companyId"/></company_id>
								</xsl:if>
								<xsl:if test="$templateId">
									<template_id><xsl:value-of select="$templateId"/></template_id>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_transport_type_', $position))]">
									<transport_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_transport_type_', $position))]"/>
									</transport_type>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_transport_mode_', $position))]">
									<transport_mode>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_transport_mode_', $position))]"/>
									</transport_mode>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_transport_sub_type_', $position))]">
									<transport_sub_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_transport_sub_type_', $position))]"/>
									</transport_sub_type>
								</xsl:if>
								<transport_group>
									<xsl:value-of select="$parentTransportPosition"/>
								</transport_group>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_code_', $position))] and $transport_sub_type = '01'">
									<airport_loading_code>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_code_', $position))]"/>
									</airport_loading_code>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_code_', $position))] and $transport_sub_type = '02'">
									<airport_discharge_code>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_code_', $position))]"/>
									</airport_discharge_code>
								</xsl:if>								
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_town_', $position))]  and $transport_sub_type = '01'">
									<town_loading>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_town_', $position))]"/>
									</town_loading>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_town_', $position))]  and $transport_sub_type = '02' ">
									<town_discharge>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_town_', $position))]"/>
									</town_discharge>
								</xsl:if>								
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_name_', $position))] and $transport_sub_type = '01'">
									<airport_loading_name>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_name_', $position))]"/>
									</airport_loading_name>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_name_', $position))]	and $transport_sub_type = '02'">
									<airport_discharge_name>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_airport_name_', $position))]"/>
									</airport_discharge_name>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_place_', $position))] and $transport_sub_type = '01'">
									<place_receipt>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_place_', $position))]"/>
									</place_receipt>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_place_', $position))] and $transport_sub_type = '02'">
									<place_delivery>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$structureName,'_airport_details_place_', $position))]"/>
									</place_delivery>
								</xsl:if>																										
							</com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
						</xsl:if>
					</xsl:for-each>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
			<!-- SEA mode-->
			<xsl:if test="count(//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_details_position_'))]">
				<xsl:variable name="parentTransportPosition">
					<xsl:value-of select="substring-after(name(), concat($structureName, '_routing_summary_individual_sea_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($parentTransportPosition ,'nbElement'))">
					<xsl:for-each select="//*[starts-with(name(),concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName, '_port_details_position_'))]">
						<xsl:variable name="position">
							<xsl:value-of select="substring-after(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_position_'))"/>
						</xsl:variable>							
						<xsl:if test="not(contains($position ,'nbElement'))">
							<xsl:variable name="transport_sub_type"><xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_transport_sub_type_', $position))]"/></xsl:variable>
							
							<com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
								<xsl:if test="$brchCode">
									<brch_code><xsl:value-of select="$brchCode"/></brch_code>
								</xsl:if>
								<xsl:if test="$companyId">
									<company_id><xsl:value-of select="$companyId"/></company_id>
								</xsl:if>
								<xsl:if test="$templateId">
									<template_id><xsl:value-of select="$templateId"/></template_id>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_transport_type_', $position))]">
									<transport_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_transport_type_', $position))]"/>
									</transport_type>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_transport_mode_', $position))]">
									<transport_mode>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_transport_mode_', $position))]"/>
									</transport_mode>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_transport_sub_type_', $position))]">
									<transport_sub_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_transport_sub_type_', $position))]"/>
									</transport_sub_type>
								</xsl:if>
								<transport_group>
									<xsl:value-of select="$parentTransportPosition"/>
								</transport_group>															
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_port_', $position))] and $transport_sub_type = '01'">
									<port_loading>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_port_', $position))]"/>
									</port_loading>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_port_', $position))] and $transport_sub_type = '02'">
									<port_discharge>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_sea_',$parentTransportPosition, '_', $structureName,'_port_details_port_', $position))]"/>
									</port_discharge>
								</xsl:if>																										
							</com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
						</xsl:if>
					</xsl:for-each>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>			
			<!--  ROAD mode -->
			<xsl:if test="count(//*[starts-with(name(), concat($structureName,'_routing_summary_individual_road_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_details_position_'))]">
				<xsl:variable name="parentTransportPosition">
					<xsl:value-of select="substring-after(name(), concat($structureName,'_routing_summary_individual_road_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($parentTransportPosition ,'nbElement'))">
					<xsl:for-each select="//*[starts-with(name(),concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition, '_', $structureName,'_road_place_details_position_'))]">
						<xsl:variable name="position">
							<xsl:value-of select="substring-after(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition, '_', $structureName,'_road_place_details_position_'))"/>
						</xsl:variable>							
						<xsl:if test="not(contains($position ,'nbElement'))">
							<xsl:variable name="transport_sub_type"><xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_transport_sub_type_', $position))]"/></xsl:variable>
							
							<com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
								<xsl:if test="$brchCode">
									<brch_code><xsl:value-of select="$brchCode"/></brch_code>
								</xsl:if>
								<xsl:if test="$companyId">
									<company_id><xsl:value-of select="$companyId"/></company_id>
								</xsl:if>
								<xsl:if test="$templateId">
									<template_id><xsl:value-of select="$templateId"/></template_id>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_transport_type_', $position))]">
									<transport_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_transport_type_', $position))]"/>
									</transport_type>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_transport_mode_', $position))]">
									<transport_mode>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_transport_mode_', $position))]"/>
									</transport_mode>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_transport_sub_type_', $position))]">
									<transport_sub_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_transport_sub_type_', $position))]"/>
									</transport_sub_type>
								</xsl:if>
								<transport_group>
									<xsl:value-of select="$parentTransportPosition"/>
								</transport_group>															
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_place_', $position))] and $transport_sub_type = '01'">
									<place_receipt>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_place_', $position))]"/>
									</place_receipt>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_place_', $position))] and $transport_sub_type = '02'">
									<place_delivery>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_road_',$parentTransportPosition,'_',$structureName,'_road_place_details_place_', $position))]"/>
									</place_delivery>
								</xsl:if>																										
							</com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
						</xsl:if>
					</xsl:for-each>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>			
			<!--  RAIL mode -->
			<xsl:if test="count(//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_details_position_'))]">
				<xsl:variable name="parentTransportPosition">
					<xsl:value-of select="substring-after(name(), concat($structureName,'_routing_summary_individual_rail_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($parentTransportPosition ,'nbElement'))">
					<xsl:for-each select="//*[starts-with(name(),concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_position_'))]">
						<xsl:variable name="position">
							<xsl:value-of select="substring-after(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_position_'))"/>
						</xsl:variable>							
						<xsl:if test="not(contains($position ,'nbElement'))">
							<xsl:variable name="transport_sub_type"><xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_transport_sub_type_', $position))]"/></xsl:variable>
							
							<com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
								<xsl:if test="$brchCode">
									<brch_code><xsl:value-of select="$brchCode"/></brch_code>
								</xsl:if>
								<xsl:if test="$companyId">
									<company_id><xsl:value-of select="$companyId"/></company_id>
								</xsl:if>
								<xsl:if test="$templateId">
									<template_id><xsl:value-of select="$templateId"/></template_id>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_transport_type_', $position))]">
									<transport_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_transport_type_', $position))]"/>
									</transport_type>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_transport_mode_', $position))]">
									<transport_mode>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_transport_mode_', $position))]"/>
									</transport_mode>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_transport_sub_type_', $position))]">
									<transport_sub_type>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_transport_sub_type_', $position))]"/>
									</transport_sub_type>
								</xsl:if>
								<transport_group>
									<xsl:value-of select="$parentTransportPosition"/>
								</transport_group>															
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_place_', $position))] and $transport_sub_type = '01'">
									<place_receipt>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_place_', $position))]"/>
									</place_receipt>
								</xsl:if>
								<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_place_', $position))] and $transport_sub_type = '02'">
									<place_delivery>
										<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_rail_',$parentTransportPosition,'_',$structureName,'_rail_place_details_place_', $position))]"/>
									</place_delivery>
								</xsl:if>																										
							</com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
						</xsl:if>
					</xsl:for-each>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>				
	</xsl:template>	
	
	<!-- Routing Summary (Transports) template-->
	<xsl:template name="MULTIMODAL_TRANSPORTS">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="structureName"/>
		<xsl:if test="count(//*[starts-with(name(), concat($structureName,'_details_position_'))]) != 0">
		<xsl:for-each select="//*[starts-with(name(),concat($structureName,'_details_position_'))]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), concat($structureName,'_details_position_'))"/>
			</xsl:variable>							
			<xsl:if test="not(contains($position ,'nbElement'))">
				<xsl:variable name="transportSubType"><xsl:value-of select="//*[starts-with(name(), concat($structureName , '_details_transport_sub_type_', $position))]"/></xsl:variable>
				<com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
					<xsl:if test="$brchCode">
						<brch_code><xsl:value-of select="$brchCode"/></brch_code>
					</xsl:if>
					<xsl:if test="$companyId">
						<company_id><xsl:value-of select="$companyId"/></company_id>
					</xsl:if>
					<xsl:if test="$templateId">
						<template_id><xsl:value-of select="$templateId"/></template_id>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_transport_type_', $position))]">
						<transport_type>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_transport_type_', $position))]"/>
						</transport_type>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_transport_mode_', $position))]">
						<transport_mode>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_transport_mode_', $position))]"/>
						</transport_mode>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_transport_sub_type_', $position))]">
						<transport_sub_type>
							<xsl:value-of select="$transportSubType"/>
						</transport_sub_type>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_place_', $position))] and $transportSubType = '01'">
						<place_receipt>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_place_', $position))]"/>
						</place_receipt>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_place_', $position))] and $transportSubType = '02'">
						<place_delivery>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_place_', $position))]"/>
						</place_delivery>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_airport_name_', $position))] and $transportSubType = '01'">
						<airport_loading_name>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_airport_name_', $position))]"/>
						</airport_loading_name>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_airport_name_', $position))] and $transportSubType = '02'">
						<airport_discharge_name>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_airport_name_', $position))]"/>
						</airport_discharge_name>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_port_', $position))] and $transportSubType = '01'">
						<port_loading>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_port_', $position))]"/>
						</port_loading>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_port_', $position))] and $transportSubType = '02'">
						<port_discharge>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_port_', $position))]"/>
						</port_discharge>
					</xsl:if>					
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_town_', $position))] and $transportSubType = '01'">
						<town_loading>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_town_', $position))]"/>
						</town_loading>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_town_', $position))] and $transportSubType = '02'">
						<town_discharge>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_town_', $position))]"/>
						</town_discharge>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_airport_code_', $position))] and $transportSubType = '01'">
						<airport_loading_code>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_airport_code_', $position))]"/>
						</airport_loading_code>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_airport_code_', $position))] and $transportSubType = '02'">
						<airport_discharge_code>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_airport_code_', $position))]"/>
						</airport_discharge_code>
					</xsl:if>															
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_taking_in_charge_', $position))]">
						<taking_in_charge>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_taking_in_charge_', $position))]"/>
						</taking_in_charge>
					</xsl:if>
					<xsl:if test="//*[starts-with(name(), concat($structureName ,'_details_place_final_dest_', $position))]">
						<place_final_dest>
							<xsl:value-of select="//*[starts-with(name(), concat($structureName ,'_details_place_final_dest_', $position))]"/>
						</place_final_dest>
					</xsl:if>																										
				</com.misys.portal.openaccount.product.baseline.util.TemplateTransport>
			</xsl:if>
		</xsl:for-each>
		</xsl:if>	
	</xsl:template>
	
	<!-- Rename a node. Used for dynamic structure -->
	<xsl:template name="rename_structured_field">
		<xsl:param name="prefix"/>
		<xsl:element name="{substring-after(name(), concat($prefix, '_'))}">
			<xsl:copy-of select="child::node()"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="rename_field">
		<xsl:param name="new_name"/>
		<xsl:element name="{$new_name}">
			<xsl:copy-of select="child::node()"/>
		</xsl:element>
	</xsl:template>


     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>