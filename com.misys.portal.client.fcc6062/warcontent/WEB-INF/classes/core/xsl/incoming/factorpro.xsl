<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	exclude-result-prefixes="tools">
	<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->

	<!-- Process Client Account Info -->
	<xsl:template match="client_act_infos/client_act_info">
		<xsl:param name="references" select="tools:retrieveCompanyInfosFrom('FA', client_cif)" />
		<xsl:variable name="company_id" select="$references/references/company_id" />
		<xsl:variable name="entity" select="$references/references/entity" />
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name" />
		<xsl:variable name="brch_code" select="$brch_code" />
		<result>
			<com.misys.portal.interfaces.incoming.FAClientActInfoHolder>
				<com.misys.portal.interfaces.incoming.FAClientAccountInfo>
					<company_id>
						<xsl:value-of select="$company_id" />
					</company_id>
					<xsl:if test="$company_id">
						<company_id>
							<xsl:value-of select="$company_id" />
						</company_id>
					</xsl:if>
					<xsl:if test="$entity">
						<entity>
							<xsl:value-of select="$entity" />
						</entity>
					</xsl:if>
					<xsl:if test="$entity">
						<entity>
							<xsl:value-of select="$entity" />
						</entity>
					</xsl:if>
					<xsl:if test="$brch_code">
						<brch_code>
							<xsl:value-of select="$brch_code" />
						</brch_code>
					</xsl:if>
					<xsl:if test="client_code">
						<client_code>
							<xsl:value-of select="client_code" />
						</client_code>
					</xsl:if>
					<xsl:if test="client_short_name">
						<client_short_name>
							<xsl:value-of select="client_short_name" />
						</client_short_name>
					</xsl:if>
					<xsl:if test="client_cif">
						<client_cif>
							<xsl:value-of select="client_cif" />
						</client_cif>
					</xsl:if>
					<xsl:if test="processing_date">
						<processing_date>
							<xsl:value-of select="processing_date" />
						</processing_date>
					</xsl:if>
					<xsl:if test="cif_type">
						<cif_type>
							<xsl:value-of select="cif_type" />
						</cif_type>
					</xsl:if>
					<xsl:if test="short_name">
						<short_name>
							<xsl:value-of select="short_name" />
						</short_name>
					</xsl:if>
					<xsl:if test="full_name">
						<full_name>
							<xsl:value-of select="full_name" />
						</full_name>
					</xsl:if>
					<xsl:if test="account_type">
						<account_type>
							<xsl:value-of select="account_type" />
						</account_type>
					</xsl:if>
					<xsl:if test="account_type_des">
						<account_type_des>
							<xsl:value-of select="account_type_des" />
						</account_type_des>
					</xsl:if>
					<xsl:if test="processing_date">
						<processing_date>
							<xsl:value-of select="processing_date" />
						</processing_date>
					</xsl:if>
					<xsl:if test="adv_currency">
						<adv_currency>
							<xsl:value-of select="adv_currency" />
						</adv_currency>
					</xsl:if>
					<xsl:if test="adv_currency_name">
						<adv_currency_name>
							<xsl:value-of select="adv_currency_name" />
						</adv_currency_name>
					</xsl:if>
					<has_transactions>
				      <xsl:choose>
				       <xsl:when test="count(client_transactions/client_transaction)>0">Y</xsl:when>
				       <xsl:otherwise>N</xsl:otherwise>
				      </xsl:choose>
    				</has_transactions>

				</com.misys.portal.interfaces.incoming.FAClientAccountInfo>

				<xsl:apply-templates select="client_contract_infos/client_contract_info">
					<xsl:with-param name="company_id" select="$company_id" />
					<xsl:with-param name="entity" select="$entity" />
					<xsl:with-param name="brch_code" select="$brch_code" />	
					<xsl:with-param name="main_bank_abbv_name" select="$main_bank_abbv_name" />
					<xsl:with-param name="client_code" select="client_code" />
					<xsl:with-param name="client_short_name" select="client_short_name" />
					<xsl:with-param name="account_type" select="account_type" />
					<xsl:with-param name="account_type_des" select="account_type_des" />
					<xsl:with-param name="adv_currency" select="adv_currency" />
					<xsl:with-param name="adv_currency_name" select="adv_currency_name" />
					<xsl:with-param name="processing_date" select="processing_date" />
					
				</xsl:apply-templates>

				<xsl:apply-templates select="client_transactions/client_transaction">
					<xsl:with-param name="company_id" select="$company_id" />
					<xsl:with-param name="entity" select="$entity" />
					<xsl:with-param name="brch_code" select="$brch_code" />
					<xsl:with-param name="main_bank_abbv_name" select="$main_bank_abbv_name" />
					<xsl:with-param name="client_code" select="client_code" />
					<xsl:with-param name="client_short_name" select="client_short_name" />
					<xsl:with-param name="short_name" select="short_name" />
					<xsl:with-param name="account_type" select="account_type" />
					<xsl:with-param name="account_type_des" select="account_type_des" />
					<xsl:with-param name="processing_date" select="processing_date" />
				</xsl:apply-templates>

				<xsl:apply-templates select="client_availability_info">
					<xsl:with-param name="company_id" select="$company_id" />
					<xsl:with-param name="entity" select="$entity" />
					<xsl:with-param name="brch_code" select="$brch_code" />
					<xsl:with-param name="main_bank_abbv_name" select="$main_bank_abbv_name" />
					<xsl:with-param name="client_code" select="client_code" />
					<xsl:with-param name="client_short_name" select="client_short_name" />
					<xsl:with-param name="short_name" select="short_name" />
					<xsl:with-param name="account_type" select="account_type" />
					<xsl:with-param name="account_type_des" select="account_type_des" />
					<xsl:with-param name="adv_currency" select="adv_currency" />
					<xsl:with-param name="adv_currency_name" select="adv_currency_name" />
					<xsl:with-param name="processing_date" select="processing_date" />
				</xsl:apply-templates>

			</com.misys.portal.interfaces.incoming.FAClientActInfoHolder>
		</result>
	</xsl:template>

	<!-- Process Client Contract Info -->
	<xsl:template match="client_contract_info">
		<xsl:param name="company_id" />
		<xsl:param name="entity" />
		<xsl:param name="brch_code" />
		<xsl:param name="main_bank_abbv_name" />
		<xsl:param name="client_code" />
		<xsl:param name="client_short_name" />
		<xsl:param name="account_type" />
		<xsl:param name="account_type_des" />
		<xsl:param name="adv_currency" />
		<xsl:param name="adv_currency_name" />
		<xsl:param name="processing_date" />

		<com.misys.portal.interfaces.incoming.FAClientContractInfoHolder>
			<com.misys.portal.interfaces.incoming.FAClientContractInfo>

				<xsl:if test="$company_id">
					<company_id>
						<xsl:value-of select="$company_id" />
					</company_id>
				</xsl:if>
				<xsl:if test="$entity">
					<entity>
						<xsl:value-of select="$entity" />
					</entity>
				</xsl:if>
				<xsl:if test="$brch_code">
					<brch_code>
						<xsl:value-of select="$brch_code" />
					</brch_code>
				</xsl:if>
				<xsl:if test="$main_bank_abbv_name">
					<main_bank_abbv_name>
						<xsl:value-of select="$main_bank_abbv_name" />
					</main_bank_abbv_name>
				</xsl:if>
				<xsl:if test="$client_code">
					<client_code>
						<xsl:value-of select="$client_code" />
					</client_code>
				</xsl:if>
				<xsl:if test="cont_code">
					<cont_code>
						<xsl:value-of select="cont_code" />
					</cont_code>
				</xsl:if>
				<xsl:if test="$client_short_name">
					<client_short_name>
						<xsl:value-of select="$client_short_name" />
					</client_short_name>
				</xsl:if>
				<xsl:if test="$account_type">
					<account_type>
						<xsl:value-of select="$account_type" />
					</account_type>
				</xsl:if>
				<xsl:if test="$account_type_des">
					<account_type_des>
						<xsl:value-of select="$account_type_des" />
					</account_type_des>
				</xsl:if>
				<xsl:if test="$processing_date">
					<processing_date>
						<xsl:value-of select="$processing_date" />
					</processing_date>
				</xsl:if>
				<xsl:if test="factor_code">
					<factor_code>
						<xsl:value-of select="factor_code" />
					</factor_code>
				</xsl:if>
				<xsl:if test="factor_short_name">
					<factor_short_name>
						<xsl:value-of select="factor_short_name" />
					</factor_short_name>
				</xsl:if>
				<xsl:if test="customer_code">
					<customer_code>
						<xsl:value-of select="customer_code" />
					</customer_code>
				</xsl:if>
				<xsl:if test="customer_short_name">
					<customer_short_name>
						<xsl:value-of select="customer_short_name" />
					</customer_short_name>
				</xsl:if>
				<xsl:if test="currency_code">
					<currency_code>
						<xsl:value-of select="currency_code" />
					</currency_code>
				</xsl:if>
				<xsl:if test="currency_name">
					<currency_name>
						<xsl:value-of select="currency_name" />
					</currency_name>
				</xsl:if>
				
				<has_debtor_payments>
				      <xsl:choose>
				       <xsl:when test="count(client_debtor_payments/client_debtor_payment)>0">Y</xsl:when>
				       <xsl:otherwise>N</xsl:otherwise>
				      </xsl:choose>
    			</has_debtor_payments>
    			
    			<has_overdue_analysis>
				      <xsl:choose>
				       <xsl:when test="count(client_overdue_analysiss/client_overdue_analysis)>0">Y</xsl:when>
				       <xsl:otherwise>N</xsl:otherwise>
				      </xsl:choose>
    			</has_overdue_analysis>
				
			</com.misys.portal.interfaces.incoming.FAClientContractInfo>
			<xsl:apply-templates select="client_debtor_payments/client_debtor_payment">
				<xsl:with-param name="company_id" select="$company_id" />
				<xsl:with-param name="entity" select="$entity" />
				<xsl:with-param name="brch_code" select="$brch_code" />
				<xsl:with-param name="main_bank_abbv_name" select="$main_bank_abbv_name" />
				<xsl:with-param name="client_code" select="$client_code" />
				<xsl:with-param name="cont_code" select="cont_code" />
				<xsl:with-param name="client_short_name" select="$client_short_name" />
				<xsl:with-param name="account_type" select="$account_type" />
				<xsl:with-param name="account_type_des" select="$account_type_des" />
				<xsl:with-param name="factor_code" select="factor_code" />
				<xsl:with-param name="factor_short_name" select="factor_short_name" />
				<xsl:with-param name="customer_code" select="customer_code" />
				<xsl:with-param name="customer_short_name" select="customer_short_name" />
				<xsl:with-param name="currency_code" select="currency_code" />
				<xsl:with-param name="currency_name" select="currency_name" />
				<xsl:with-param name="processing_date" select="processing_date" />

			</xsl:apply-templates>
			<xsl:apply-templates select="client_invoice_enquirys/client_invoice_enquiry">
				<xsl:with-param name="company_id" select="$company_id" />
				<xsl:with-param name="entity" select="$entity" />
				<xsl:with-param name="brch_code" select="$brch_code" />
				<xsl:with-param name="main_bank_abbv_name" select="$main_bank_abbv_name" />
				<xsl:with-param name="cont_code" select="cont_code" />
				<xsl:with-param name="client_code" select="$client_code" />
				<xsl:with-param name="client_short_name" select="$client_short_name" />
				<xsl:with-param name="account_type" select="$account_type" />
				<xsl:with-param name="account_type_des" select="$account_type_des" />
				<xsl:with-param name="factor_code" select="factor_code" />
				<xsl:with-param name="factor_short_name" select="factor_short_name" />
				<xsl:with-param name="customer_code" select="customer_code" />
				<xsl:with-param name="customer_short_name" select="customer_short_name" />
				<xsl:with-param name="currency_code" select="currency_code" />
				<xsl:with-param name="currency_name" select="currency_name" />
				<xsl:with-param name="processing_date" select="processing_date" />
			</xsl:apply-templates>
			<xsl:apply-templates select="client_overdue_analysiss/client_overdue_analysis">
				<xsl:with-param name="company_id" select="$company_id" />
				<xsl:with-param name="entity" select="$entity" />
				<xsl:with-param name="brch_code" select="$brch_code" />
				<xsl:with-param name="main_bank_abbv_name" select="$main_bank_abbv_name" />
				<xsl:with-param name="client_code" select="$client_code" />
				<xsl:with-param name="client_short_name" select="$client_short_name" />
				<xsl:with-param name="account_type" select="$account_type" />
				<xsl:with-param name="account_type_des" select="$account_type_des" />
				<xsl:with-param name="adv_currency" select="adv_currency" />
				<xsl:with-param name="adv_currency_name" select="adv_currency_name" />
				<xsl:with-param name="factor_code" select="factor_code" />
				<xsl:with-param name="factor_short_name" select="factor_short_name" />
				<xsl:with-param name="customer_code" select="customer_code" />
				<xsl:with-param name="customer_short_name" select="customer_short_name" />
				<xsl:with-param name="currency_code" select="currency_code" />
				<xsl:with-param name="currency_name" select="currency_name" />
				<xsl:with-param name="processing_date" select="processing_date" />
			</xsl:apply-templates>
			<xsl:apply-templates select="client_expo_enquiry">
				<xsl:with-param name="company_id" select="$company_id" />
				<xsl:with-param name="entity" select="$entity" />
				<xsl:with-param name="brch_code" select="$brch_code" />
				<xsl:with-param name="main_bank_abbv_name" select="$main_bank_abbv_name" />
				<xsl:with-param name="cont_code" select="cont_code" />
				<xsl:with-param name="client_code" select="$client_code" />
				<xsl:with-param name="client_short_name" select="client_short_name" />
				<xsl:with-param name="short_name" select="short_name" />
				<xsl:with-param name="full_name" select="full_name" />
				<xsl:with-param name="account_type" select="$account_type" />
				<xsl:with-param name="account_type_des" select="$account_type_des" />
				<xsl:with-param name="adv_currency" select="$adv_currency" />
				<xsl:with-param name="adv_currency_name" select="adv_currency_name" />
				<xsl:with-param name="customer_code" select="customer_code" />
				<xsl:with-param name="customer_short_name" select="customer_short_name" />
				<xsl:with-param name="factor_code" select="factor_code" />
				<xsl:with-param name="factor_short_name" select="factor_short_name" />
				<xsl:with-param name="processing_date" select="processing_date" />
			</xsl:apply-templates>

		</com.misys.portal.interfaces.incoming.FAClientContractInfoHolder>
	</xsl:template>

	<xsl:template match="client_debtor_payment">
		<xsl:param name="company_id" />
		<xsl:param name="entity" />
		<xsl:param name="brch_code" />
		<xsl:param name="main_bank_abbv_name" />
		<xsl:param name="client_code" />
		<xsl:param name="cont_code" />
		<xsl:param name="client_short_name" />
		<xsl:param name="account_type" />
		<xsl:param name="account_type_des" />
		<xsl:param name="factor_code" />
		<xsl:param name="factor_short_name" />
		<xsl:param name="customer_code" />
		<xsl:param name="customer_short_name" />
		<xsl:param name="currency_code" />
		<xsl:param name="currency_name" />
		<xsl:param name="processing_date" />

		<com.misys.portal.interfaces.incoming.FAClientDebtorPayment>
			<xsl:if test="$company_id">
				<company_id>
					<xsl:value-of select="$company_id" />
				</company_id>
			</xsl:if>
			<xsl:if test="$entity">
				<entity>
					<xsl:value-of select="$entity" />
				</entity>
			</xsl:if>
			<xsl:if test="$brch_code">
				<brch_code>
					<xsl:value-of select="$brch_code" />
				</brch_code>
			</xsl:if>
			<xsl:if test="$main_bank_abbv_name">
				<main_bank_abbv_name>
					<xsl:value-of select="$main_bank_abbv_name" />
				</main_bank_abbv_name>
			</xsl:if>
			<xsl:if test="$cont_code">
				<cont_code>
					<xsl:value-of select="$cont_code" />
				</cont_code>
			</xsl:if>
			<xsl:if test="$client_code">
				<client_code>
					<xsl:value-of select="$client_code" />
				</client_code>
			</xsl:if>
			<xsl:if test="$client_short_name">
				<client_short_name>
					<xsl:value-of select="$client_short_name" />
				</client_short_name>
			</xsl:if>
			<xsl:if test="$account_type">
				<account_type>
					<xsl:value-of select="$account_type" />
				</account_type>
			</xsl:if>
			<xsl:if test="$account_type_des">
				<account_type_des>
					<xsl:value-of select="$account_type_des" />
				</account_type_des>
			</xsl:if>
			<xsl:if test="$processing_date">
				<processing_date>
					<xsl:value-of select="$processing_date" />
				</processing_date>
				</xsl:if>
			<xsl:if test="$factor_code">
				<factor_code>
					<xsl:value-of select="$factor_code" />
				</factor_code>
			</xsl:if>
			<xsl:if test="$factor_short_name">
				<factor_short_name>
					<xsl:value-of select="$factor_short_name" />
				</factor_short_name>
			</xsl:if>
			<xsl:if test="$customer_code">
				<customer_code>
					<xsl:value-of select="$customer_code" />
				</customer_code>
			</xsl:if>
			<xsl:if test="$customer_short_name">
				<customer_short_name>
					<xsl:value-of select="$customer_short_name" />
				</customer_short_name>
			</xsl:if>
			<xsl:if test="$currency_code">
				<currency_code>
					<xsl:value-of select="$currency_code" />
				</currency_code>
			</xsl:if>
			<xsl:if test="$currency_name">
				<currency_name>
					<xsl:value-of select="$currency_name" />
				</currency_name>
			</xsl:if>
			<xsl:if test="doc_ref">
				<doc_ref>
					<xsl:value-of select="doc_ref" />
				</doc_ref>
			</xsl:if>
			<xsl:if test="payment_date">
				<payment_date>
					<xsl:value-of select="payment_date" />
				</payment_date>
			</xsl:if>
			<xsl:if test="document_amt">
				<document_amt>
					<xsl:value-of select="document_amt" />
				</document_amt>
			</xsl:if>
			<xsl:if test="mtd_amt">
				<mtd_amt>
					<xsl:value-of select="mtd_amt" />
				</mtd_amt>
			</xsl:if>
			<xsl:if test="total_invoice_amt">
				<total_invoice_amt>
					<xsl:value-of select="total_invoice_amt" />
				</total_invoice_amt>
			</xsl:if>
			<xsl:if test="remark">
				<remark>
					<xsl:value-of select="remark" />
				</remark>
			</xsl:if>

		</com.misys.portal.interfaces.incoming.FAClientDebtorPayment>

	</xsl:template>

	<xsl:template match="client_invoice_enquiry">
		<xsl:param name="company_id" />
		<xsl:param name="entity" />
		<xsl:param name="brch_code" />
		<xsl:param name="main_bank_abbv_name" />
		<xsl:param name="cont_code" />
		<xsl:param name="client_code" />
		<xsl:param name="client_short_name" />
		<xsl:param name="account_type" />
		<xsl:param name="account_type_des" />
		<xsl:param name="factor_code" />
		<xsl:param name="factor_short_name" />
		<xsl:param name="customer_code" />
		<xsl:param name="customer_short_name" />
		<xsl:param name="currency_code" />
		<xsl:param name="currency_name" />
		<xsl:param name="processing_date" />

		<com.misys.portal.interfaces.incoming.FAClientInvoiceEnquiry>
			<xsl:if test="$company_id">
				<company_id>
					<xsl:value-of select="$company_id" />
				</company_id>
			</xsl:if>
			<xsl:if test="$entity">
				<entity>
					<xsl:value-of select="$entity" />
				</entity>
			</xsl:if>
			<xsl:if test="$brch_code">
				<brch_code>
					<xsl:value-of select="$brch_code" />
				</brch_code>
			</xsl:if>
			<xsl:if test="$main_bank_abbv_name">
				<main_bank_abbv_name>
					<xsl:value-of select="$main_bank_abbv_name" />
				</main_bank_abbv_name>
			</xsl:if>
			<xsl:if test="$cont_code">
				<cont_code>
					<xsl:value-of select="$cont_code" />
				</cont_code>
			</xsl:if>
			<xsl:if test="$client_code">
				<client_code>
					<xsl:value-of select="$client_code" />
				</client_code>
			</xsl:if>
			<xsl:if test="$client_short_name">
				<client_short_name>
					<xsl:value-of select="$client_short_name" />
				</client_short_name>
			</xsl:if>
			<xsl:if test="$account_type">
				<account_type>
					<xsl:value-of select="$account_type" />
				</account_type>
			</xsl:if>
			<xsl:if test="$account_type_des">
				<account_type_des>
					<xsl:value-of select="$account_type_des" />
				</account_type_des>
			</xsl:if>
			<xsl:if test="$processing_date">
				<processing_date>
					<xsl:value-of select="$processing_date" />
				</processing_date>
			</xsl:if>
			<xsl:if test="$factor_code">
				<factor_code>
					<xsl:value-of select="$factor_code" />
				</factor_code>
			</xsl:if>
			<xsl:if test="$factor_short_name">
				<factor_short_name>
					<xsl:value-of select="$factor_short_name" />
				</factor_short_name>
			</xsl:if>
			<xsl:if test="$customer_code">
				<customer_code>
					<xsl:value-of select="$customer_code" />
				</customer_code>
			</xsl:if>
			<xsl:if test="$customer_short_name">
				<customer_short_name>
					<xsl:value-of select="$customer_short_name" />
				</customer_short_name>
			</xsl:if>
			<xsl:if test="$currency_code">
				<currency_code>
					<xsl:value-of select="$currency_code" />
				</currency_code>
			</xsl:if>
			<xsl:if test="$currency_name">
				<currency_name>
					<xsl:value-of select="$currency_name" />
				</currency_name>
			</xsl:if>
			<xsl:if test="doc_type">
				<doc_type>
					<xsl:value-of select="doc_type" />
				</doc_type>
			</xsl:if>
			<xsl:if test="doc_ref">
				<doc_ref>
					<xsl:value-of select="doc_ref" />
				</doc_ref>
			</xsl:if>
			<xsl:if test="invoice_amt">
				<invoice_amt>
					<xsl:value-of select="invoice_amt" />
				</invoice_amt>
			</xsl:if>
			<xsl:if test="total_amt_paid">
				<total_amt_paid>
					<xsl:value-of select="total_amt_paid" />
				</total_amt_paid>
			</xsl:if>
			<xsl:if test="outstanding_amt">
				<outstanding_amt>
					<xsl:value-of select="outstanding_amt" />
				</outstanding_amt>
			</xsl:if>
			<xsl:if test="document_date">
				<document_date>
					<xsl:value-of select="document_date" />
				</document_date>
			</xsl:if>
			<xsl:if test="due_date">
				<due_date>
					<xsl:value-of select="due_date" />
				</due_date>
			</xsl:if>
			<xsl:if test="remarks">
				<remarks>
					<xsl:value-of select="remarks" />
				</remarks>
			</xsl:if>
			<xsl:if test="batch_code">
				<batch_code>
					<xsl:value-of select="batch_code" />
				</batch_code>
			</xsl:if>
			<xsl:if test="overdue_days">
				<overdue_days>
					<xsl:value-of select="overdue_days" />
				</overdue_days>
			</xsl:if>
			<xsl:if test="total_os_amt_sign">
				<total_os_amt_sign>
					<xsl:value-of select="total_os_amt_sign" />
				</total_os_amt_sign>
			</xsl:if>
			<xsl:if test="total_os_amt">
				<total_os_amt>
					<xsl:value-of select="total_os_amt" />
				</total_os_amt>
			</xsl:if>
			<xsl:if test="unfunded_invoice_amt">
				<unfunded_invoice_amt>
					<xsl:value-of select="unfunded_invoice_amt" />
				</unfunded_invoice_amt>
			</xsl:if>
		</com.misys.portal.interfaces.incoming.FAClientInvoiceEnquiry>
	</xsl:template>

	<xsl:template match="client_overdue_analysis">
		<xsl:param name="company_id" />
		<xsl:param name="entity" />
		<xsl:param name="brch_code" />
		<xsl:param name="main_bank_abbv_name" />
		<xsl:param name="client_code" />
		<xsl:param name="client_short_name" />
		<xsl:param name="account_type" />
		<xsl:param name="account_type_des" />
		<xsl:param name="adv_currency" />
		<xsl:param name="adv_currency_name" />
		<xsl:param name="factor_code" />
		<xsl:param name="factor_short_name" />
		<xsl:param name="customer_code" />
		<xsl:param name="customer_short_name" />
		<xsl:param name="currency_code" />
		<xsl:param name="currency_name" />
		<xsl:param name="processing_date" />

		<com.misys.portal.interfaces.incoming.FAClientOverdueAnalysis>
			<xsl:if test="$company_id">
				<company_id>
					<xsl:value-of select="$company_id" />
				</company_id>
			</xsl:if>
			<xsl:if test="$entity">
				<entity>
					<xsl:value-of select="$entity" />
				</entity>
			</xsl:if>
			<xsl:if test="$brch_code">
				<brch_code>
					<xsl:value-of select="$brch_code" />
				</brch_code>
			</xsl:if>
			<xsl:if test="$main_bank_abbv_name">
				<main_bank_abbv_name>
					<xsl:value-of select="$main_bank_abbv_name" />
				</main_bank_abbv_name>
			</xsl:if>
			<xsl:if test="cont_code">
				<cont_code>
					<xsl:value-of select="cont_code" />
				</cont_code>
			</xsl:if>
			<xsl:if test="$client_code">
				<client_code>
					<xsl:value-of select="$client_code" />
				</client_code>
			</xsl:if>
			<xsl:if test="$client_short_name">
				<client_short_name>
					<xsl:value-of select="$client_short_name" />
				</client_short_name>
			</xsl:if>
			<xsl:if test="$account_type">
				<account_type>
					<xsl:value-of select="$account_type" />
				</account_type>
			</xsl:if>
			<xsl:if test="$account_type_des">
				<account_type_des>
					<xsl:value-of select="$account_type_des" />
				</account_type_des>
			</xsl:if>
			<xsl:if test="$processing_date">
				<processing_date>
					<xsl:value-of select="$processing_date" />
				</processing_date>
			</xsl:if>
			<xsl:if test="$adv_currency">
				<adv_currency>
					<xsl:value-of select="$adv_currency" />
				</adv_currency>
			</xsl:if>
			<xsl:if test="$adv_currency_name">
				<adv_currency_name>
					<xsl:value-of select="$adv_currency_name" />
				</adv_currency_name>
			</xsl:if>
			<xsl:if test="$factor_code">
				<factor_code>
					<xsl:value-of select="$factor_code" />
				</factor_code>
			</xsl:if>
			<xsl:if test="$factor_short_name">
				<factor_short_name>
					<xsl:value-of select="$factor_short_name" />
				</factor_short_name>
			</xsl:if>
			<xsl:if test="$customer_code">
				<customer_code>
					<xsl:value-of select="$customer_code" />
				</customer_code>
			</xsl:if>
			<xsl:if test="$customer_short_name">
				<customer_short_name>
					<xsl:value-of select="$customer_short_name" />
				</customer_short_name>
			</xsl:if>
			<xsl:if test="$currency_code">
				<currency_code>
					<xsl:value-of select="$currency_code" />
				</currency_code>
			</xsl:if>
			<xsl:if test="$currency_name">
				<currency_name>
					<xsl:value-of select="$currency_name" />
				</currency_name>
			</xsl:if>
			<xsl:if test="aged_from">
				<aged_from>
					<xsl:value-of select="aged_from" />
				</aged_from>
			</xsl:if>
			<xsl:if test="view_in">
				<view_in>
					<xsl:value-of select="view_in" />
				</view_in>
			</xsl:if>
			<xsl:if test="aged_until_date">
				<aged_until_date>
					<xsl:value-of select="aged_until_date" />
				</aged_until_date>
			</xsl:if>
			<xsl:if test="current_bal">
				<current_bal>
					<xsl:value-of select="current_bal" />
				</current_bal>
			</xsl:if>
			<xsl:if test="overdue_bal">
				<overdue_bal>
					<xsl:value-of select="overdue_bal" />
				</overdue_bal>
			</xsl:if>
			<xsl:if test="guarantee_amt">
				<guarantee_amt>
					<xsl:value-of select="guarantee_amt" />
				</guarantee_amt>
			</xsl:if>
			<xsl:if test="credit_note_receipt">
				<credit_note_receipt>
					<xsl:value-of select="credit_note_receipt" />
				</credit_note_receipt>
			</xsl:if>
			<xsl:if test="total_bal">
				<total_bal>
					<xsl:value-of select="total_bal" />
				</total_bal>
			</xsl:if>
			<xsl:if test="period1">
				<period1>
					<xsl:value-of select="period1" />
				</period1>
			</xsl:if>
			<xsl:if test="period2">
				<period2>
					<xsl:value-of select="period2" />
				</period2>
			</xsl:if>
			<xsl:if test="period3">
				<period3>
					<xsl:value-of select="period3" />
				</period3>
			</xsl:if>
			<xsl:if test="period4">
				<period4>
					<xsl:value-of select="period4" />
				</period4>
			</xsl:if>
			<xsl:if test="period5">
				<period5>
					<xsl:value-of select="period5" />
				</period5>
			</xsl:if>
			<xsl:if test="overdue_id">
				<overdue_id>
					<xsl:value-of select="overdue_id" />
				</overdue_id>
			</xsl:if>

		</com.misys.portal.interfaces.incoming.FAClientOverdueAnalysis>

	</xsl:template>

	<xsl:template match="client_expo_enquiry">
		<xsl:param name="company_id" />
		<xsl:param name="entity" />
		<xsl:param name="brch_code" />
		<xsl:param name="main_bank_abbv_name" />
		<xsl:param name="cont_code" />
		<xsl:param name="client_short_name" />
		<xsl:param name="client_code" />
		<xsl:param name="short_name" />
		<xsl:param name="full_name" />
		<xsl:param name="account_type" />
		<xsl:param name="account_type_des" />
		<xsl:param name="adv_currency" />
		<xsl:param name="adv_currency_name" />
		<xsl:param name="customer_code" />
		<xsl:param name="customer_short_name" />
		<xsl:param name="factor_code" />
		<xsl:param name="factor_short_name" />
		<xsl:param name="processing_date" />

		<com.misys.portal.interfaces.incoming.FAClientExpoEnquiry>
			<xsl:if test="$company_id">
				<company_id>
					<xsl:value-of select="$company_id" />
				</company_id>
			</xsl:if>
			<xsl:if test="$entity">
				<entity>
					<xsl:value-of select="$entity" />
				</entity>
			</xsl:if>
			<xsl:if test="$brch_code">
				<brch_code>
					<xsl:value-of select="$brch_code" />
				</brch_code>
			</xsl:if>
			<xsl:if test="$main_bank_abbv_name">
				<main_bank_abbv_name>
					<xsl:value-of select="$main_bank_abbv_name" />
				</main_bank_abbv_name>
			</xsl:if>
			<xsl:if test="$cont_code">
				<cont_code>
					<xsl:value-of select="$cont_code" />
				</cont_code>
			</xsl:if>
			<xsl:if test="$client_code">
				<client_code>
					<xsl:value-of select="$client_code" />
				</client_code>
			</xsl:if>
			<xsl:if test="$client_short_name">
				<client_short_name>
					<xsl:value-of select="$client_short_name" />
				</client_short_name>
			</xsl:if>
			<xsl:if test="$short_name">
				<short_name>
					<xsl:value-of select="$short_name" />
				</short_name>
			</xsl:if>
			<xsl:if test="$full_name">
				<full_name>
					<xsl:value-of select="$full_name" />
				</full_name>
			</xsl:if>
			<xsl:if test="$account_type">
				<account_type>
					<xsl:value-of select="$account_type" />
				</account_type>
			</xsl:if>
			<xsl:if test="$account_type_des">
				<account_type_des>
					<xsl:value-of select="$account_type_des" />
				</account_type_des>
			</xsl:if>
			<xsl:if test="$processing_date">
				<processing_date>
					<xsl:value-of select="$processing_date" />
				</processing_date>
			</xsl:if>
			<xsl:if test="$adv_currency">
				<adv_currency>
					<xsl:value-of select="$adv_currency" />
				</adv_currency>
			</xsl:if>
			<xsl:if test="$adv_currency_name">
				<adv_currency_name>
					<xsl:value-of select="$adv_currency_name" />
				</adv_currency_name>
			</xsl:if>
			<xsl:if test="$customer_code">
				<customer_code>
					<xsl:value-of select="$customer_code" />
				</customer_code>
			</xsl:if>
			<xsl:if test="$customer_short_name">
				<customer_short_name>
					<xsl:value-of select="$customer_short_name" />
				</customer_short_name>
			</xsl:if>
			<xsl:if test="$factor_code">
				<factor_code>
					<xsl:value-of select="$factor_code" />
				</factor_code>
			</xsl:if>
			<xsl:if test="$factor_short_name">
				<factor_short_name>
					<xsl:value-of select="$factor_short_name" />
				</factor_short_name>
			</xsl:if>
			<xsl:if test="market_name">
				<market_name>
					<xsl:value-of select="market_name" />
				</market_name>
			</xsl:if>
			<xsl:if test="os_bal_sign">
				<os_bal_sign>
					<xsl:value-of select="os_bal_sign" />
				</os_bal_sign>
			</xsl:if>
			<xsl:if test="os_bal">
				<os_bal>
					<xsl:value-of select="os_bal" />
				</os_bal>
			</xsl:if>
			<xsl:if test="credit_limit">
				<credit_limit>
					<xsl:value-of select="credit_limit" />
				</credit_limit>
			</xsl:if>
			<xsl:if test="max_adv_limit">
				<max_adv_limit>
					<xsl:value-of select="max_adv_limit" />
				</max_adv_limit>
			</xsl:if>
			<xsl:if test="dispute_sign">
				<dispute_sign>
					<xsl:value-of select="dispute_sign" />
				</dispute_sign>
			</xsl:if>
			<xsl:if test="dispute">
				<dispute>
					<xsl:value-of select="dispute" />
				</dispute>
			</xsl:if>
			<xsl:if test="approved_debts_sign">
				<approved_debts_sign>
					<xsl:value-of select="approved_debts_sign" />
				</approved_debts_sign>
			</xsl:if>
			<xsl:if test="approved_debts">
				<approved_debts>
					<xsl:value-of select="approved_debts" />
				</approved_debts>
			</xsl:if>
			<xsl:if test="unapproved_debts_sign">
				<unapproved_debts_sign>
					<xsl:value-of select="unapproved_debts_sign" />
				</unapproved_debts_sign>
			</xsl:if>
			<xsl:if test="unapproved_debts">
				<unapproved_debts>
					<xsl:value-of select="unapproved_debts" />
				</unapproved_debts>
			</xsl:if>
			<xsl:if test="ineligible_invoice_sign">
				<ineligible_invoice_sign>
					<xsl:value-of select="ineligible_invoice_sign" />
				</ineligible_invoice_sign>
			</xsl:if>
			<xsl:if test="ineligible_invoice">
				<ineligible_invoice>
					<xsl:value-of select="ineligible_invoice" />
				</ineligible_invoice>
			</xsl:if>
			<xsl:if test="unfunded_invoice_amt_sign">
				<unfunded_invoice_amt_sign>
					<xsl:value-of select="unfunded_invoice_amt_sign" />
				</unfunded_invoice_amt_sign>
			</xsl:if>
			<xsl:if test="unfunded_invoice_amt">
				<unfunded_invoice_amt>
					<xsl:value-of select="unfunded_invoice_amt" />
				</unfunded_invoice_amt>
			</xsl:if>
			<xsl:if test="total_credit_limit">
				<total_credit_limit>
					<xsl:value-of select="total_credit_limit" />
				</total_credit_limit>
			</xsl:if>
			<xsl:if test="total_max_adv_limit">
				<total_max_adv_limit>
					<xsl:value-of select="total_max_adv_limit" />
				</total_max_adv_limit>
			</xsl:if>
			<xsl:if test="total_os_balance_sign">
				<total_os_balance_sign>
					<xsl:value-of select="total_os_balance_sign" />
				</total_os_balance_sign>
			</xsl:if>
			<xsl:if test="total_os_balance">
				<total_os_balance>
					<xsl:value-of select="total_os_balance" />
				</total_os_balance>
			</xsl:if>
			<xsl:if test="total_dispute_sign">
				<total_dispute_sign>
					<xsl:value-of select="total_dispute_sign" />
				</total_dispute_sign>
			</xsl:if>
			<xsl:if test="total_dispute">
				<total_dispute>
					<xsl:value-of select="total_dispute" />
				</total_dispute>
			</xsl:if>
			<xsl:if test="total_appr_debts_sign">
				<total_appr_debts_sign>
					<xsl:value-of select="total_appr_debts_sign" />
				</total_appr_debts_sign>
			</xsl:if>
			<xsl:if test="total_appr_debts">
				<total_appr_debts>
					<xsl:value-of select="total_appr_debts" />
				</total_appr_debts>
			</xsl:if>
			<xsl:if test="total_unappr_debts_sign">
				<total_unappr_debts_sign>
					<xsl:value-of select="total_unappr_debts_sign" />
				</total_unappr_debts_sign>
			</xsl:if>
			<xsl:if test="total_unappr_debts">
				<total_unappr_debts>
					<xsl:value-of select="total_unappr_debts" />
				</total_unappr_debts>
			</xsl:if>
			<xsl:if test="total_ineligible_invc_sign">
				<total_ineligible_invc_sign>
					<xsl:value-of select="total_ineligible_invc_sign" />
				</total_ineligible_invc_sign>
			</xsl:if>
			<xsl:if test="total_ineligible_invc">
				<total_ineligible_invc>
					<xsl:value-of select="total_ineligible_invc" />
				</total_ineligible_invc>
			</xsl:if>
			<xsl:if test="total_unfunded_invc_amt_sign">
				<total_unfunded_invc_amt_sign>
					<xsl:value-of select="total_unfunded_invc_amt_sign" />
				</total_unfunded_invc_amt_sign>
			</xsl:if>
			<xsl:if test="total_unfunded_invc_amt">
				<total_unfunded_invc_amt>
					<xsl:value-of select="total_unfunded_invc_amt" />
				</total_unfunded_invc_amt>
			</xsl:if>

		</com.misys.portal.interfaces.incoming.FAClientExpoEnquiry>

	</xsl:template>

	<xsl:template match="client_transaction">
		<xsl:param name="company_id" />
		<xsl:param name="entity" />
		<xsl:param name="brch_code" />
		<xsl:param name="main_bank_abbv_name" />
		<xsl:param name="client_code" />
		<xsl:param name="client_short_name" />
		<xsl:param name="short_name" />
		<xsl:param name="account_type" />
		<xsl:param name="account_type_des" />
		<xsl:param name="processing_date" />
		
			<com.misys.portal.interfaces.incoming.FAClientTransactionHolder>
			<com.misys.portal.interfaces.incoming.FAClientTransaction>

				<company_id>
					<xsl:value-of select="$company_id" />
				</company_id>

				<xsl:if test="$company_id">
					<company_id>
						<xsl:value-of select="$company_id" />
					</company_id>
				</xsl:if>
				<xsl:if test="$brch_code">
					<brch_code>
						<xsl:value-of select="$brch_code" />
					</brch_code>
				</xsl:if>
				<xsl:if test="$entity">
					<entity>
						<xsl:value-of select="$entity" />
					</entity>
				</xsl:if>
				<xsl:if test="$main_bank_abbv_name">
					<main_bank_abbv_name>
						<xsl:value-of select="$main_bank_abbv_name" />
					</main_bank_abbv_name>
				</xsl:if>
				<xsl:if test="$client_code">
					<client_code>
						<xsl:value-of select="$client_code" />
					</client_code>
				</xsl:if>
				<xsl:if test="$client_short_name">
					<client_short_name>
						<xsl:value-of select="$client_short_name" />
					</client_short_name>
				</xsl:if>
				<xsl:if test="$short_name">
					<short_name>
						<xsl:value-of select="$short_name" />
					</short_name>
				</xsl:if>
				<xsl:if test="$account_type">
					<account_type>
						<xsl:value-of select="$account_type" />
					</account_type>
				</xsl:if>
				<xsl:if test="$account_type_des">
					<account_type_des>
						<xsl:value-of select="$account_type_des" />
					</account_type_des>
				</xsl:if>
				<xsl:if test="$processing_date">
					<processing_date>
						<xsl:value-of select="$processing_date" />
					</processing_date>
				</xsl:if>
				<xsl:if test="adv_currency">
					<adv_currency>
						<xsl:value-of select="adv_currency" />
					</adv_currency>
				</xsl:if>
				<xsl:if test="adv_currency_name">
					<adv_currency_name>
						<xsl:value-of select="adv_currency_name" />
					</adv_currency_name>
				</xsl:if>
				<xsl:if test="capt_fiu_sign">
					<capt_fiu_sign>
						<xsl:value-of select="capt_fiu_sign" />
					</capt_fiu_sign>
				</xsl:if>
				<xsl:if test="capt_fiu">
					<capt_fiu>
						<xsl:value-of select="capt_fiu" />
					</capt_fiu>
				</xsl:if>
				<xsl:if test="capt_cca_sign">
					<capt_cca_sign>
						<xsl:value-of select="capt_cca_sign" />
					</capt_cca_sign>
				</xsl:if>
				<xsl:if test="capt_cca">
					<capt_cca>
						<xsl:value-of select="capt_cca" />
					</capt_cca>
				</xsl:if>
				<xsl:if test="opening_fiu_sign">
					<opening_fiu_sign>
						<xsl:value-of select="opening_fiu_sign" />
					</opening_fiu_sign>
				</xsl:if>
				<xsl:if test="opening_fiu">
					<opening_fiu>
						<xsl:value-of select="opening_fiu" />
					</opening_fiu>
				</xsl:if>
				<xsl:if test="opening_cca_sign">
					<opening_cca_sign>
						<xsl:value-of select="opening_cca_sign" />
					</opening_cca_sign>
				</xsl:if>
				<xsl:if test="opening_cca">
					<opening_cca>
						<xsl:value-of select="opening_cca" />
					</opening_cca>
				</xsl:if>
				<xsl:if test="closing_fiu_sign">
					<closing_fiu_sign>
						<xsl:value-of select="closing_fiu_sign" />
					</closing_fiu_sign>
				</xsl:if>
				<xsl:if test="closing_fiu">
					<closing_fiu>
						<xsl:value-of select="closing_fiu" />
					</closing_fiu>
				</xsl:if>
				<xsl:if test="value_date">
					<value_date>
						<xsl:value-of select="value_date" />
					</value_date>
				</xsl:if>
				<xsl:if test="tnx_type">
					<tnx_type>
						<xsl:value-of select="tnx_type" />
					</tnx_type>
				</xsl:if>
				<xsl:if test="tnx_ref">
					<tnx_ref>
						<xsl:value-of select="tnx_ref" />
					</tnx_ref>
				</xsl:if>
				<xsl:if test="tnx_fiu_adv_sign">
					<tnx_fiu_adv_sign>
						<xsl:value-of select="tnx_fiu_adv_sign" />
					</tnx_fiu_adv_sign>
				</xsl:if>
				<xsl:if test="tnx_fiu_adv">
					<tnx_fiu_adv>
						<xsl:value-of select="tnx_fiu_adv" />
					</tnx_fiu_adv>
				</xsl:if>
				<xsl:if test="tnx_cca_adv_sign">
					<tnx_cca_adv_sign>
						<xsl:value-of select="tnx_cca_adv_sign" />
					</tnx_cca_adv_sign>
				</xsl:if>
				<xsl:if test="tnx_cca_adv">
					<tnx_cca_adv>
						<xsl:value-of select="tnx_cca_adv" />
					</tnx_cca_adv>
				</xsl:if>
				<xsl:if test="description1">
					<description1>
						<xsl:value-of select="description1" />
					</description1>
				</xsl:if>
				<xsl:if test="description2">
					<description2>
						<xsl:value-of select="description2" />
					</description2>
				</xsl:if>

			</com.misys.portal.interfaces.incoming.FAClientTransaction>
		</com.misys.portal.interfaces.incoming.FAClientTransactionHolder>

	</xsl:template>

	<xsl:template match="client_availability_info">
		<xsl:param name="company_id" />
		<xsl:param name="entity" />
		<xsl:param name="brch_code" />
		<xsl:param name="main_bank_abbv_name" />
		<xsl:param name="client_code" />
		<xsl:param name="client_short_name" />
		<xsl:param name="short_name" />
		<xsl:param name="account_type" />
		<xsl:param name="account_type_des" />
		<xsl:param name="adv_currency" />
		<xsl:param name="adv_currency_name" />
		<xsl:param name="processing_date" />

		<com.misys.portal.interfaces.incoming.FAClientAvailInfoHolder>
			<com.misys.portal.interfaces.incoming.FAClientAvailInfo>

				<xsl:if test="$company_id">
					<company_id>
						<xsl:value-of select="$company_id" />
					</company_id>
				</xsl:if>
				<xsl:if test="$entity">
					<entity>
						<xsl:value-of select="$entity" />
					</entity>
				</xsl:if>
				<xsl:if test="$brch_code">
					<brch_code>
						<xsl:value-of select="$brch_code" />
					</brch_code>
				</xsl:if>
				<xsl:if test="$main_bank_abbv_name">
					<main_bank_abbv_name>
						<xsl:value-of select="$main_bank_abbv_name" />
					</main_bank_abbv_name>
				</xsl:if>
				<xsl:if test="$client_code">
					<client_code>
						<xsl:value-of select="$client_code" />
					</client_code>
				</xsl:if>
				<xsl:if test="$client_short_name">
					<client_short_name>
						<xsl:value-of select="$client_short_name" />
					</client_short_name>
				</xsl:if>
				<xsl:if test="$short_name">
					<short_name>
						<xsl:value-of select="$short_name" />
					</short_name>
				</xsl:if>
				<xsl:if test="$account_type">
					<account_type>
						<xsl:value-of select="$account_type" />
					</account_type>
				</xsl:if>
				<xsl:if test="$account_type_des">
					<account_type_des>
						<xsl:value-of select="$account_type_des" />
					</account_type_des>
				</xsl:if>
				<xsl:if test="$processing_date">
					<processing_date>
						<xsl:value-of select="$processing_date" />
					</processing_date>
				</xsl:if>
				<xsl:if test="$adv_currency">
					<adv_currency>
						<xsl:value-of select="$adv_currency" />
					</adv_currency>
				</xsl:if>
				<xsl:if test="$adv_currency_name">
					<adv_currency_name>
						<xsl:value-of select="$adv_currency_name" />
					</adv_currency_name>
				</xsl:if>
				<xsl:if test="max_adv_limit">
					<max_adv_limit>
						<xsl:value-of select="max_adv_limit" />
					</max_adv_limit>
				</xsl:if>
				<xsl:if test="approved_debts_sign">
					<approved_debts_sign>
						<xsl:value-of select="approved_debts_sign" />
					</approved_debts_sign>
				</xsl:if>
				<xsl:if test="approved_debts">
					<approved_debts>
						<xsl:value-of select="approved_debts" />
					</approved_debts>
				</xsl:if>
				<xsl:if test="unapproved_debts_sign">
					<unapproved_debts_sign>
						<xsl:value-of select="unapproved_debts_sign" />
					</unapproved_debts_sign>
				</xsl:if>
				<xsl:if test="unapproved_debts">
					<unapproved_debts>
						<xsl:value-of select="unapproved_debts" />
					</unapproved_debts>
				</xsl:if>
				<xsl:if test="os_bal_sign">
					<os_bal_sign>
						<xsl:value-of select="os_bal_sign" />
					</os_bal_sign>
				</xsl:if>
				<xsl:if test="os_bal">
					<os_bal>
						<xsl:value-of select="os_bal" />
					</os_bal>
				</xsl:if>
				<xsl:if test="dispute_sign">
					<dispute_sign>
						<xsl:value-of select="dispute_sign" />
					</dispute_sign>
				</xsl:if>
				<xsl:if test="dispute">
					<dispute>
						<xsl:value-of select="dispute" />
					</dispute>
				</xsl:if>
				<xsl:if test="ineligible_invoice_sign">
					<ineligible_invoice_sign>
						<xsl:value-of select="ineligible_invoice_sign" />
					</ineligible_invoice_sign>
				</xsl:if>
				<xsl:if test="ineligible_invoice">
					<ineligible_invoice>
						<xsl:value-of select="ineligible_invoice" />
					</ineligible_invoice>
				</xsl:if>
				<xsl:if test="reserve_ratio">
					<reserve_ratio>
						<xsl:value-of select="reserve_ratio" />
					</reserve_ratio>
				</xsl:if>
				<xsl:if test="reserve_sign">
					<reserve_sign>
						<xsl:value-of select="reserve_sign" />
					</reserve_sign>
				</xsl:if>
				<xsl:if test="reserve">
					<reserve>
						<xsl:value-of select="reserve" />
					</reserve>
				</xsl:if>
				<xsl:if test="avail_before_fiu_bal_sign">
					<avail_before_fiu_bal_sign>
						<xsl:value-of select="avail_before_fiu_bal_sign" />
					</avail_before_fiu_bal_sign>
				</xsl:if>
				<xsl:if test="avail_before_fiu_bal">
					<avail_before_fiu_bal>
						<xsl:value-of select="avail_before_fiu_bal" />
					</avail_before_fiu_bal>
				</xsl:if>
				<xsl:if test="fiu_bal_sign">
					<fiu_bal_sign>
						<xsl:value-of select="fiu_bal_sign" />
					</fiu_bal_sign>
				</xsl:if>
				<xsl:if test="fiu_bal">
					<fiu_bal>
						<xsl:value-of select="fiu_bal" />
					</fiu_bal>
				</xsl:if>
				<xsl:if test="addl_reserves_sign">
					<addl_reserves_sign>
						<xsl:value-of select="addl_reserves_sign" />
					</addl_reserves_sign>
				</xsl:if>
				<xsl:if test="addl_reserves">
					<addl_reserves>
						<xsl:value-of select="addl_reserves" />
					</addl_reserves>
				</xsl:if>
				<xsl:if test="prev_requested_sign">
					<prev_requested_sign>
						<xsl:value-of select="prev_requested_sign" />
					</prev_requested_sign>
				</xsl:if>
				<xsl:if test="prev_requested">
					<prev_requested>
						<xsl:value-of select="prev_requested" />
					</prev_requested>
				</xsl:if>
				<xsl:if test="amt_before_on_acc_payment_sign">
					<amt_before_on_acc_payment_sign>
						<xsl:value-of select="amt_before_on_acc_payment_sign" />
					</amt_before_on_acc_payment_sign>
				</xsl:if>
				<xsl:if test="amt_before_on_acc_payment">
					<amt_before_on_acc_payment>
						<xsl:value-of select="amt_before_on_acc_payment" />
					</amt_before_on_acc_payment>
				</xsl:if>
				<xsl:if test="over_payment_sign">
					<over_payment_sign>
						<xsl:value-of select="over_payment_sign" />
					</over_payment_sign>
				</xsl:if>
				<xsl:if test="over_payment">
					<over_payment>
						<xsl:value-of select="over_payment" />
					</over_payment>
				</xsl:if>
				<xsl:if test="on_acc_payment_sign">
					<on_acc_payment_sign>
						<xsl:value-of select="on_acc_payment_sign" />
					</on_acc_payment_sign>
				</xsl:if>
				<xsl:if test="on_acc_payment">
					<on_acc_payment>
						<xsl:value-of select="on_acc_payment" />
					</on_acc_payment>
				</xsl:if>
				<xsl:if test="amt_avail_for_adv_payment_sign">
					<amt_avail_for_adv_payment_sign>
						<xsl:value-of select="amt_avail_for_adv_payment_sign" />
					</amt_avail_for_adv_payment_sign>
				</xsl:if>
				<xsl:if test="amt_avail_for_adv_payment">
					<amt_avail_for_adv_payment>
						<xsl:value-of select="amt_avail_for_adv_payment" />
					</amt_avail_for_adv_payment>
				</xsl:if>
				<xsl:if test="total_adv_plus_request_sign">
					<total_adv_plus_request_sign>
						<xsl:value-of select="total_adv_plus_request_sign" />
					</total_adv_plus_request_sign>
				</xsl:if>
				<xsl:if test="total_adv_plus_request">
					<total_adv_plus_request>
						<xsl:value-of select="total_adv_plus_request" />
					</total_adv_plus_request>
				</xsl:if>
				<xsl:if test="client_mal">
					<client_mal>
						<xsl:value-of select="client_mal" />
					</client_mal>
				</xsl:if>
				<xsl:if test="over_client_mal_sign">
					<over_client_mal_sign>
						<xsl:value-of select="over_client_mal_sign" />
					</over_client_mal_sign>
				</xsl:if>
				<xsl:if test="over_client_mal">
					<over_client_mal>
						<xsl:value-of select="over_client_mal" />
					</over_client_mal>
				</xsl:if>
				<xsl:if test="over_credit_limit_sign">
					<over_credit_limit_sign>
						<xsl:value-of select="over_credit_limit_sign" />
					</over_credit_limit_sign>
				</xsl:if>
				<xsl:if test="over_credit_limit">
					<over_credit_limit>
						<xsl:value-of select="over_credit_limit" />
					</over_credit_limit>
				</xsl:if>
				<xsl:if test="customer_actual_omal_sign">
					<customer_actual_omal_sign>
						<xsl:value-of select="customer_actual_omal_sign" />
					</customer_actual_omal_sign>
				</xsl:if>
				<xsl:if test="customer_actual_omal">
					<customer_actual_omal>
						<xsl:value-of select="customer_actual_omal" />
					</customer_actual_omal>
				</xsl:if>
				<xsl:if test="customer_theoretical_omal_sign">
					<customer_theoretical_omal_sign>
						<xsl:value-of select="customer_theoretical_omal_sign" />
					</customer_theoretical_omal_sign>
				</xsl:if>
				<xsl:if test="customer_theoretical_omal">
					<customer_theoretical_omal>
						<xsl:value-of select="customer_theoretical_omal" />
					</customer_theoretical_omal>
				</xsl:if>
				<xsl:if test="eligible_initial_debt_sign">
					<eligible_initial_debt_sign>
						<xsl:value-of select="eligible_initial_debt_sign" />
					</eligible_initial_debt_sign>
				</xsl:if>
				<xsl:if test="eligible_initial_debt">
					<eligible_initial_debt>
						<xsl:value-of select="eligible_initial_debt" />
					</eligible_initial_debt>
				</xsl:if>
				<xsl:if test="chq_pending_clearance_amt">
					<chq_pending_clearance_amt>
						<xsl:value-of select="chq_pending_clearance_amt" />
					</chq_pending_clearance_amt>
				</xsl:if>

			</com.misys.portal.interfaces.incoming.FAClientAvailInfo>
		</com.misys.portal.interfaces.incoming.FAClientAvailInfoHolder>

	</xsl:template>
</xsl:stylesheet>
