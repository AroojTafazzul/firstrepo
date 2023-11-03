<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<!--
   Copyright (c) 2000-2003 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	
	<!-- Charge template -->
	
	<xsl:template name="CHARGE">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="prefix"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="position"/>
		<com.misys.portal.product.common.Charge>
			<!-- keys as attributes -->
			<xsl:attribute name="chrg_id"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_chrg_id_', $position))]"/></xsl:attribute>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>
			
			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:element name="chrg_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_chrg_code_', $position))]"/></xsl:element>
			<xsl:element name="amt"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_amt_', $position))]"/></xsl:element>
			<xsl:element name="cur_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_cur_code_', $position))]"/></xsl:element>
			<xsl:element name="status"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_status_', $position))]"/></xsl:element>
			<xsl:element name="bearer_role_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_bearer_role_code_', $position))]"/></xsl:element>
			<xsl:element name="exchange_rate"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_exchange_rate_', $position))]"/></xsl:element>
			<xsl:element name="eqv_amt"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_eqv_amt_', $position))]"/></xsl:element>
			<xsl:element name="eqv_cur_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_eqv_cur_code_', $position))]"/></xsl:element>
			<xsl:element name="additional_comment"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_additional_comment_', $position))]"/></xsl:element>
			<xsl:element name="inception_date"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_inception_date_', $position))]"/></xsl:element>
			<xsl:element name="settlement_date"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_settlement_date_', $position))]"/></xsl:element>
			<xsl:element name="created_in_session"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_created_in_session_', $position))]"/></xsl:element>
			<xsl:element name="chrg_type"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_chrg_type_', $position))]"/></xsl:element>
		</com.misys.portal.product.common.Charge>
	</xsl:template>

	<!-- Fee template -->
	
	<xsl:template name="FEE">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="prefix"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="position"/>
		<com.misys.portal.product.common.Charge>
			<!-- keys as attributes -->
			<xsl:attribute name="chrg_id"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'fee_details_chrg_id_', $position))]"/></xsl:attribute>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>
			
			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:element name="chrg_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_chrg_code_', $position))]"/></xsl:element>
			<xsl:element name="amt"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_amt_', $position))]"/></xsl:element>
			<xsl:element name="cur_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_cur_code_', $position))]"/></xsl:element>
			<xsl:element name="status"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_status_', $position))]"/></xsl:element>
			<xsl:element name="bearer_role_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_bearer_role_code_', $position))]"/></xsl:element>
			<xsl:element name="exchange_rate"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_exchange_rate_', $position))]"/></xsl:element>
			<xsl:element name="eqv_amt"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_eqv_amt_', $position))]"/></xsl:element>
			<xsl:element name="eqv_cur_code"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_eqv_cur_code_', $position))]"/></xsl:element>
			<xsl:element name="additional_comment"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_additional_comment_', $position))]"/></xsl:element>
			<xsl:element name="inception_date"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_inception_date_', $position))]"/></xsl:element>
			<xsl:element name="settlement_date"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_settlement_date_', $position))]"/></xsl:element>
			<xsl:element name="created_in_session"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_created_in_session_', $position))]"/></xsl:element>
			<xsl:element name="chrg_type"><xsl:value-of select="//*[starts-with(name(),concat($prefix,'charge_details_chrg_type_', $position))]"/></xsl:element>
		</com.misys.portal.product.common.Charge>
	</xsl:template>	
	
	<!-- Old charge template -->
	
	<xsl:template name="OLD_CHARGE">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="position"/>
		<com.misys.portal.product.common.Charge>
			<!-- keys as attributes -->
			<xsl:attribute name="chrg_id"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_chrg_id_', $position))]"/></xsl:attribute>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>

			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:element name="chrg_code"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_chrg_code_', $position))]"/></xsl:element>
			<xsl:element name="amt"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_amt_', $position))]"/></xsl:element>
			<xsl:element name="cur_code"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_cur_code_', $position))]"/></xsl:element>
			<xsl:element name="status"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_status_', $position))]"/></xsl:element>
			<xsl:element name="bearer_role_code"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_bearer_role_code_', $position))]"/></xsl:element>
			<xsl:element name="exchange_rate"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_exchange_rate_', $position))]"/></xsl:element>
			<xsl:element name="eqv_amt"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_eqv_amt_', $position))]"/></xsl:element>
			<xsl:element name="eqv_cur_code"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_eqv_cur_code_', $position))]"/></xsl:element>
			<xsl:element name="additional_comment"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_additional_comment_', $position))]"/></xsl:element>
			<xsl:element name="inception_date"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_inception_date_', $position))]"/></xsl:element>
			<xsl:element name="settlement_date"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_settlement_date_', $position))]"/></xsl:element>
			<xsl:element name="created_in_session"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_created_in_session_', $position))]"/></xsl:element>
			<xsl:element name="chrg_type"><xsl:value-of select="//*[starts-with(name(),concat('old_charge_details_chrg_type_', $position))]"/></xsl:element>
		</com.misys.portal.product.common.Charge>
	</xsl:template>

	<!-- Document template -->
	
	<xsl:template name="DOCUMENT">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="position"/>
		<com.misys.portal.product.common.Document>
			<!-- keys as attributes -->
			<xsl:attribute name="document_id"><xsl:value-of select="//*[starts-with(name(),concat('documents_details_document_id_', $position))]"/></xsl:attribute>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>

			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:element name="code"><xsl:value-of select="//*[starts-with(name(),concat('documents_details_code_', $position))]"/></xsl:element>
			<xsl:element name="name">
				<xsl:if test="//*[starts-with(name(),concat('documents_details_code_', $position))][.= '99']">
					<xsl:value-of select="//*[starts-with(name(),concat('documents_details_name_', $position))]"/>
				</xsl:if>
			</xsl:element>
			<xsl:element name="first_name"><xsl:value-of select="//*[starts-with(name(),concat('documents_details_first_name_', $position))]"/></xsl:element>
			<xsl:element name="second_name"><xsl:value-of select="//*[starts-with(name(),concat('documents_details_second_name_', $position))]"/></xsl:element>
		</com.misys.portal.product.common.Document>
	</xsl:template>

	<!-- Document template (for collection templates) -->
	
	<xsl:template name="TEMPLATE_DOCUMENT">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
		<xsl:param name="position"/>
		<com.misys.portal.product.common.TemplateDocument>
			<!-- keys must be attributes -->
			<xsl:if test="$companyId">
				<xsl:attribute name="company_id"><xsl:value-of select="$companyId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$templateId">
				<xsl:attribute name="template_id"><xsl:value-of select="$templateId"/></xsl:attribute>
			</xsl:if>
		
			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:element name="code"><xsl:value-of select="//*[starts-with(name(),concat('documents_details_code_', $position))]"/></xsl:element>
			<xsl:element name="name">
				<xsl:if test="//*[starts-with(name(),concat('documents_details_code_', $position))][.= '99']">
					<xsl:value-of select="//*[starts-with(name(),concat('documents_details_name_', $position))]"/>
				</xsl:if>
			</xsl:element>
			<xsl:element name="first_name"><xsl:value-of select="//*[starts-with(name(),concat('documents_details_first_name_', $position))]"/></xsl:element>
			<xsl:element name="second_name"><xsl:value-of select="//*[starts-with(name(),concat('documents_details_second_name_', $position))]"/></xsl:element>
		</com.misys.portal.product.common.TemplateDocument>
	</xsl:template>
	
		
	<!-- Counterparty template (for collection templates) -->
	<xsl:template name="TEMPLATE_COUNTERPARTY">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="templateId"/>
			<xsl:if test="count(//*[starts-with(name(), 'counterparty_details_position_')]) != 0">
			<xsl:for-each select="//*[starts-with(name(), 'counterparty_details_position_')]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), 'counterparty_details_position_')"/>
				</xsl:variable>
				<xsl:if test="not(contains($position ,'nbElement'))">
				<com.misys.portal.product.common.TemplateCounterparty>
					<!-- keys must be attributes -->
					<xsl:if test="//*[starts-with(name(), concat('counterparty_details_id_', $position))]">
						<xsl:attribute name="counterparty_id"><xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_id_', $position))]"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="$companyId">
						<xsl:attribute name="company_id"><xsl:value-of select="$companyId"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="$templateId">
						<xsl:attribute name="template_id"><xsl:value-of select="$templateId"/></xsl:attribute>
					</xsl:if>

					<xsl:if test="$brchCode">
						<brch_code><xsl:value-of select="$brchCode"/></brch_code>
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
					<xsl:if test="//*[starts-with(name(), concat('counterparty_details_act_iso_code_', $position))]">
							<counterparty_act_iso_code>
								<xsl:value-of select="//*[starts-with(name(), concat('counterparty_details_act_iso_code_', $position))]"/>
							</counterparty_act_iso_code>
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
					</com.misys.portal.product.common.TemplateCounterparty>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<!-- Document template -->
	
	<xsl:template name="CROSS_REFERENCE">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="position"/>
		<com.misys.portal.product.common.CrossReference>
			<!-- keys must be attributes -->
			<xsl:attribute name="cross_reference_id"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_cross_reference_id', $position))]"/></xsl:attribute>

			<xsl:if test="$brchCode"><brch_code><xsl:value-of select="$brchCode"/></brch_code></xsl:if>
			<xsl:if test="$companyId"><company_id><xsl:value-of select="$companyId"/></company_id></xsl:if>
			<xsl:element name="ref_id"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_ref_id_', $position))]"/></xsl:element>
			<xsl:element name="tnx_id"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_tnx_id_', $position))]"/></xsl:element>
			<xsl:element name="product_code"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_product_code_', $position))]"/></xsl:element>
			<xsl:element name="child_ref_id"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_child_ref_id_', $position))]"/></xsl:element>
			<xsl:element name="child_tnx_id"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_child_tnx_id_', $position))]"/></xsl:element>
			<xsl:element name="child_product_code"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_child_product_code_', $position))]"/></xsl:element>
			<xsl:element name="type_code"><xsl:value-of select="//*[starts-with(name(),concat('cross_ref_type_code_', $position))]"/></xsl:element>
			</com.misys.portal.product.common.CrossReference>
	</xsl:template>
	
	<!-- Re authentication -->
	<xsl:template name="AUTHENTICATION">
		<xsl:if test="reauth_pwd">
			<additional_field name="reauth_pwd" type="string" scope="none" description="">
				<xsl:value-of select="reauth_pwd"/>
			</additional_field>
		</xsl:if>
		<!-- TODO Remove. Not sure if any stylesheets still use the Client version of save_common,
		 but this needs to go away once everything is migrated -->
		<xsl:if test="reauth_password">
			<additional_field name="reauth_password" type="string" scope="none" description="">
				<xsl:value-of select="reauth_password"/>
			</additional_field>
		</xsl:if>
		<!-- xsl:if test="reauth_token">
			<additional_field name="reauth_token" type="string" scope="none" description="">
				<xsl:value-of select="reauth_token"/>
			</additional_field>
		</xsl:if>				
		<xsl:if test="reauth_sig">
			<additional_field name="reauth_sig" type="string" scope="none" description="">
				<xsl:value-of select="reauth_sig"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="reauth_org">
			<additional_field name="reauth_org" type="string" scope="none" description="">
				<xsl:value-of select="reauth_org"/>
			</additional_field>
		</xsl:if-->
	</xsl:template>
	
	
	<!-- collaboration -->
	<xsl:template name="collaboration">
		<!-- collaboration todo_list_id -->
		<xsl:if test="todo_list_id">
			<additional_field name="todo_list_id" type="id" scope="none" description="TODO list ID associated with this product">
				<xsl:value-of select="todo_list_id"/>
			</additional_field>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="bulk_fields">
		<xsl:if test="bulk_ref_id">
			<bulk_ref_id>
				<xsl:value-of select="bulk_ref_id"/>
			</bulk_ref_id>
		</xsl:if>								
		<xsl:if test="bulk_tnx_id">
			<bulk_tnx_id>
				<xsl:value-of select="bulk_tnx_id"/>
			</bulk_tnx_id>
		</xsl:if>
	</xsl:template>
	
	<!-- FX Details common Fields -->
	<xsl:template name="FX_DETAILS">
	<!-- FX Option Type -->
	<xsl:if test="fx_rates_type">
			<additional_field name="fx_rates_type" type="string" scope="master" description="Board Rates or Utilise Contracts">
				<xsl:value-of select="fx_rates_type"/>
			</additional_field>
	</xsl:if>		
	<!-- Exchange Rate Field -->
	<xsl:if test="fx_exchange_rate">
	<!-- Exchange Rate Equivalent Amount Field -->
		<additional_field name="fx_exchange_rate" type="string" scope="master" description="Exchange Rate Value">
			<xsl:value-of select="fx_exchange_rate"/>
		</additional_field>
	</xsl:if>
	<!-- Exchange Rate Equivalent Amount  Currency Field -->
	<xsl:if test="fx_exchange_rate_cur_code">
		<additional_field name="fx_exchange_rate_cur_code" type="string" scope="master" description="Exchange Rate Equilvalent Amount Currency">
			<xsl:value-of select="fx_exchange_rate_cur_code"/>
		</additional_field>
	</xsl:if>	
	<!-- Exchange Rate Equivalent Amount Field -->
	<xsl:if test="fx_exchange_rate_amt">
		<additional_field name="fx_exchange_rate_amt" type="amount" scope="master" description="Exchange Rate Equilvalent Amount">
			 <xsl:attribute name="currency">fx_exchange_rate_cur_code</xsl:attribute> 
			<xsl:value-of select="fx_exchange_rate_amt"/>
		</additional_field>
	</xsl:if>
	
	<!-- Tolerance Rate Field -->
	<xsl:if test="fx_tolerance_rate">
	<!-- Exchange Rate Equivalent Amount Field -->
		<additional_field name="fx_tolerance_rate" type="string" scope="master" description="Tolerance Rate Value">
			<xsl:value-of select="fx_tolerance_rate"/>
		</additional_field>
	</xsl:if>
	<!-- Tolerance Rate Equivalent Amount  Currency Field -->
	<xsl:if test="fx_tolerance_rate_cur_code">
		<additional_field name="fx_tolerance_rate_cur_code" type="string" scope="master" description="Tolerance Rate Amount Currency">
			<xsl:value-of select="fx_tolerance_rate_cur_code"/>
		</additional_field>
	</xsl:if>		
	<!-- Tolerance Rate Equivalent Amount Field -->  
	<xsl:if test="fx_tolerance_rate_amt">
		<additional_field name="fx_tolerance_rate_amt" type="amount" scope="master" description="Tolerance Rate Amount">
			  <xsl:attribute name="currency">fx_tolerance_rate_cur_code</xsl:attribute>
			<xsl:value-of select="fx_tolerance_rate_amt"/>
		</additional_field>
	</xsl:if>
	
	<!-- Contract Number Fields -->
	<xsl:for-each select="//*[starts-with(name(), 'fx_contract_nbr_')]">
	<xsl:variable name="position">
		<xsl:value-of select="substring-after(name(), 'fx_contract_nbr_')"/>
	</xsl:variable>
	<xsl:variable name="column_name">
		<xsl:value-of select="concat('fx_contract_nbr_', $position)"/>
	</xsl:variable>
	<xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_', $position))]">
		<additional_field type="string" scope="master" description="FX Contract Number">
		    <xsl:attribute name="name"><xsl:value-of select="$column_name"/></xsl:attribute>
			<xsl:value-of select="."/>
		</additional_field>
	</xsl:if>
	</xsl:for-each>
	<!-- Contract Number Equivalent Amount Fields -->
	<xsl:for-each select="//*[starts-with(name(), 'fx_contract_nbr_amt_')]">
	<xsl:variable name="position">
		<xsl:value-of select="substring-after(name(), 'fx_contract_nbr_amt_')"/>
	</xsl:variable>
	<xsl:variable name="column_name">
		<xsl:value-of select="concat('fx_contract_nbr_amt_', $position)"/>
	</xsl:variable>
	<xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $position))]">
		<additional_field type="amount" scope="master" description="FX Contract Equivalent Amount">
		    <xsl:attribute name="name"><xsl:value-of select="$column_name"/></xsl:attribute>
		    <xsl:attribute name="currency">fx_contract_nbr_cur_code_<xsl:value-of select="$position"/></xsl:attribute>
			<xsl:value-of select="."/>
		</additional_field>
	</xsl:if>
	</xsl:for-each>
	<xsl:if test="fx_nbr_contracts">
		<additional_field name="fx_nbr_contracts" type="integer" scope="master" description="Number of contracts">
			<xsl:value-of select="fx_nbr_contracts"/>
		</additional_field>
	</xsl:if>
	<xsl:if test="fx_amt_utilse_enabled">
		<additional_field name="fx_amt_utilse_enabled" type="string" scope="master" description="Amount Utilise Enabled or not">
			<xsl:value-of select="fx_amt_utilse_enabled"/>
		</additional_field>
	</xsl:if>
	<!-- Contract Number Equivalent Amount Currency Fields -->
	<xsl:for-each select="//*[starts-with(name(), 'fx_contract_nbr_cur_code_')]">
	<xsl:variable name="position">
		<xsl:value-of select="substring-after(name(), 'fx_contract_nbr_cur_code_')"/>
	</xsl:variable>
	<xsl:variable name="column_name">
		<xsl:value-of select="concat('fx_contract_nbr_cur_code_', $position)"/>
	</xsl:variable>
	<xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_cur_code_', $position))]">
		<additional_field type="string" scope="master" description="FX Contract Equivalent Amount Currency">
		    <xsl:attribute name="name"><xsl:value-of select="$column_name"/></xsl:attribute>
			<xsl:value-of select="."/>
		</additional_field>
	</xsl:if>
	</xsl:for-each>
	<xsl:if test="fx_total_utilise_cur_code">
		<additional_field name="fx_total_utilise_cur_code" type="string" scope="master" description="Total Utilise Amount">
			<xsl:value-of select="fx_total_utilise_cur_code"/>
		</additional_field>
	</xsl:if>
	<xsl:if test="fx_total_utilise_amt">
		<additional_field name="fx_total_utilise_amt" type="amount" scope="master" description="Total Utilise Amount">
		    <xsl:attribute name="currency"><xsl:value-of select="fx_total_utilise_cur_code"/></xsl:attribute>
			<xsl:value-of select="fx_total_utilise_amt"/>
		</additional_field>
	</xsl:if>
	</xsl:template>
	
	<!-- Bank Instrcutions Principal,Fee and Margin Accounts related fields -->
	<xsl:template name="bank-instructions-act-fields">
		<!-- Principal Account Additional Fields -->
		<xsl:if test="principal_act_name">
			<additional_field name="principal_act_name" type="string" scope="master" description="Principal Account Name">
				<xsl:value-of select="principal_act_name"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="principal_act_cur_code">
			<additional_field name="principal_act_cur_code" type="string" scope="master" description="Principal Account Currency Code">
				<xsl:value-of select="principal_act_cur_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="principal_act_description">
			<additional_field name="principal_act_description" type="string" scope="master" description="Principal Account Description">
				<xsl:value-of select="principal_act_description"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="principal_act_pab">
			<additional_field name="principal_act_pab" type="string" scope="master" description="Principal Account Pre Approval Beneficiary">
				<xsl:value-of select="principal_act_pab"/>
			</additional_field>
		</xsl:if>
		
		<!-- Fee Account Additional Fields -->
		<xsl:if test="fee_act_name">
			<additional_field name="fee_act_name" type="string" scope="master" description="Fee Account Name">
				<xsl:value-of select="fee_act_name"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="fee_act_cur_code">
			<additional_field name="fee_act_cur_code" type="string" scope="master" description="Fee Account Currency Code">
				<xsl:value-of select="fee_act_cur_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="fee_act_description">
			<additional_field name="fee_act_description" type="string" scope="master" description="Fee Account Description">
				<xsl:value-of select="fee_act_description"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="fee_act_pab">
			<additional_field name="fee_act_pab" type="string" scope="master" description="Fee Account Pre Approval Beneficiary">
				<xsl:value-of select="fee_act_pab"/>
			</additional_field>
		</xsl:if>
		
		<!-- Margin Account Additional Fields -->
		<xsl:if test="margin_act_cur_code">
			<additional_field name="margin_act_cur_code" type="string" scope="master" description="Margin Account Currency Code">
				<xsl:value-of select="margin_act_cur_code"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="margin_act_description">
			<additional_field name="margin_act_description" type="string" scope="master" description="Margin Account Description">
				<xsl:value-of select="margin_act_description"/>
			</additional_field>
		</xsl:if>
		<xsl:if test="margin_act_pab">
			<additional_field name="margin_act_pab" type="string" scope="master" description="Margin Account Pre Approval Beneficiary">
				<xsl:value-of select="margin_act_pab"/>
			</additional_field>
		</xsl:if>
	</xsl:template>


     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>