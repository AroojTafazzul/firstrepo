<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com) All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.interfaces.incoming.BulkFileUploadUtils"
	xmlns:commonutils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
	exclude-result-prefixes="tools utils loanIQ commonutils">

	<xsl:template match="loan_facility">

		<result>
			<com.misys.portal.product.ln.common.LoanFacilityFile>
				<xsl:variable name="facility_id_global" select="id" />
				<xsl:variable name="bor_id" select="borrower/id" />
				<com.misys.portal.product.ln.common.Facility>
					<xsl:variable name="deal_id" select="deal/id" />
					<xsl:variable name="facility_id" select="id" />
					<xsl:variable name="deal_name" select="deal/name" />
					<xsl:variable name="facility_name" select="name" />
					<deal_name>
						<xsl:value-of select="$deal_name" />
					</deal_name>
					<deal_id>
						<xsl:value-of select="$deal_id" />
					</deal_id>
					<facility_ref>
						<xsl:value-of select="$facility_id" />
					</facility_ref>
					<facility_name>
						<xsl:value-of select="name" />
					</facility_name>
					<facility_control_no>
						<xsl:value-of select="fcn" />
					</facility_control_no>
					<facility_type>
						<xsl:value-of select="type" />
					</facility_type>
					<sub_type>
						<xsl:value-of select="subtype" />
					</sub_type>
					<facility_currency>
						<xsl:value-of select="mainCurrency" />
					</facility_currency>
					<status>
						<xsl:value-of select="status" />
					</status>
					<agreement_date>
						<xsl:value-of select="agreementDate" />
					</agreement_date>
					<effective_date>
						<xsl:value-of select="effectiveDate" />
					</effective_date>
					<expiry_date>
						<xsl:value-of select="expiryDate" />
					</expiry_date>
					<maturity_date>
						<xsl:value-of select="maturityDate" />
					</maturity_date>
					<access_type>
						<xsl:value-of select="access_type" />
					</access_type>
					<facility_limit>
						<xsl:value-of select="globalLimitAmount" />
					</facility_limit>
					<outstanding_amount>
						<xsl:value-of select="globalOutstandingAmount" />
					</outstanding_amount>
					<available_amount>
						<xsl:value-of select="globalAvailableAmount" />
					</available_amount>
					<available_pending>
						<xsl:value-of select="facAvailAmtWithPendLoans" />
					</available_pending>
					<access_type>
						<xsl:value-of select="access_type" />
					</access_type>
				</com.misys.portal.product.ln.common.Facility>

				<xsl:apply-templates select="riskTypes">
					<xsl:with-param name="facility_id_global"
						select="$facility_id_global" />
				</xsl:apply-templates>
				<xsl:apply-templates select="pricingOption">
					<xsl:with-param name="facility_id_global"
						select="$facility_id_global" />
				</xsl:apply-templates>
				<xsl:apply-templates select="currency">
					<xsl:with-param name="facility_id_global"
						select="$facility_id_global" />
				</xsl:apply-templates>
				 <xsl:apply-templates select="borrower">
					<xsl:with-param name="facility_id_global"
						select="$facility_id_global" />
				</xsl:apply-templates> 
				<xsl:apply-templates
				select="borrower/currencyLimit">
				<xsl:with-param name="bor_id" select="$bor_id" />
				<xsl:with-param name="facility_id_global" select="$facility_id_global" />
			</xsl:apply-templates>
			<xsl:apply-templates
				select="borrower/riskTypeLimit">
				<xsl:with-param name="bor_id" select="$bor_id" />
				<xsl:with-param name="facility_id_global" select="$facility_id_global" />
			</xsl:apply-templates>
				 <xsl:apply-templates select="remittanceInstruction">
					<xsl:with-param name="bor_id"
						select="$bor_id" />
				</xsl:apply-templates>
				<xsl:apply-templates select="frequency">
				</xsl:apply-templates>
			</com.misys.portal.product.ln.common.LoanFacilityFile>
		</result>
	</xsl:template>

	<xsl:template match="riskTypes">
		<xsl:param name="facility_id_global"></xsl:param>
		<xsl:apply-templates select="riskType">
			<xsl:with-param name="facility_id_global"
				select="$facility_id_global" />
		</xsl:apply-templates>
	</xsl:template>


	<xsl:template match="riskType">
		<xsl:param name="facility_id_global"></xsl:param>
		<com.misys.portal.product.ln.common.RiskType>
			<risk_type_name>
				<xsl:value-of select="riskName"></xsl:value-of>
			</risk_type_name>
			<risk_code>
				<xsl:value-of select="riskCode"></xsl:value-of>
			</risk_code>
			<is_swingline>
				<xsl:value-of select="isSwingline"></xsl:value-of>
			</is_swingline>
			<facility_id>
				<xsl:value-of select="$facility_id_global"></xsl:value-of>
			</facility_id>
		</com.misys.portal.product.ln.common.RiskType>

	</xsl:template>

	<xsl:template match="pricingOption">
		<xsl:param name="facility_id_global"></xsl:param>
		<com.misys.portal.product.ln.common.PricingOption>
			<xsl:variable name="po_id" select="id" />
			<xsl:if test="id">
				<PO_ID>
					<xsl:value-of select="id" />
				</PO_ID>
			</xsl:if>
			<OUTSTANDING_TYPE>
				<xsl:value-of select="outstandingType" />
			</OUTSTANDING_TYPE>
			<MATCH_FUNDED>
				<xsl:value-of select="matchFundedIndicator" />
			</MATCH_FUNDED>
			<MATURITY_DATE_MANDATORY>
				<xsl:value-of select="maturityDateMandatory" />
			</MATURITY_DATE_MANDATORY>
			<INTEND_NOTICE_DAYS>
				<xsl:value-of select="intentDaysInAdvance" />
			</INTEND_NOTICE_DAYS>
			<SWINGLINE>
				<xsl:value-of select="isSwingLinePricingOption" />
			</SWINGLINE>
			<FACILITY_ID>
				<xsl:value-of select="$facility_id_global"></xsl:value-of>
			</FACILITY_ID>
		</com.misys.portal.product.ln.common.PricingOption>
	</xsl:template>

	<xsl:template match="frequency">
			<com.misys.portal.product.ln.common.RepricingFrequency>
			<REPRICING_ID>
				<xsl:value-of select="repricingId"></xsl:value-of>
			</REPRICING_ID>
			<PO_ID>
				<xsl:value-of select="id"></xsl:value-of>
			</PO_ID>
			<repricing_frequency>
				<xsl:value-of select="repricingFrequency"></xsl:value-of>
			</repricing_frequency>
			<interest_frequency>
				<xsl:value-of select="interestFrequency"></xsl:value-of>
			</interest_frequency>
			</com.misys.portal.product.ln.common.RepricingFrequency>
	</xsl:template>

	<xsl:template match="currency">
		<xsl:param name="facility_id_global"></xsl:param>
		<com.misys.portal.product.ln.common.Currency>
			<currency_code>
				<xsl:value-of select="code"></xsl:value-of>
			</currency_code>
			<fx_rate>
				<xsl:value-of select="fxRate"></xsl:value-of>
			</fx_rate>
			<facility_id>
				<xsl:value-of select="$facility_id_global"></xsl:value-of>
			</facility_id>
		</com.misys.portal.product.ln.common.Currency>
	</xsl:template>
	
		<xsl:template match="borrower">
		<xsl:param name="facility_id_global"></xsl:param>
		<com.misys.portal.product.ln.common.Borrower>
			<BORROWER_ID>
				<xsl:value-of select="id"></xsl:value-of>
			</BORROWER_ID>
			<BORROWER_LIMIT_AMT>
				<xsl:value-of select="limitAmount"></xsl:value-of>
			</BORROWER_LIMIT_AMT>
			<BORROWER_NAME>
				<xsl:value-of select="name"></xsl:value-of>
			</BORROWER_NAME>
			<BORROWER_DRAWN_AMT>
				<xsl:value-of select="borrDrawnAmt"></xsl:value-of>
			</BORROWER_DRAWN_AMT>
			<AVAILABLE_AMT>
				<xsl:value-of select="availableAmtForBorrowerLimit"></xsl:value-of>
			</AVAILABLE_AMT>
			<facility_id>
				<xsl:value-of select="$facility_id_global"></xsl:value-of>
			</facility_id>
		</com.misys.portal.product.ln.common.Borrower>
	</xsl:template>
	
	<xsl:template match="currencyLimit">
		<xsl:param name="bor_id"></xsl:param>
		<xsl:param name="facility_id_global"></xsl:param>
		<com.misys.portal.product.ln.common.BorrowerLimit>
			<LIMIT_ID>
				<xsl:value-of select="id"></xsl:value-of>
			</LIMIT_ID>
			<CURRENCY>
				<xsl:value-of select="currency"></xsl:value-of>
			</CURRENCY>
			<BORROWER_REF>
				<xsl:value-of select="$bor_id"></xsl:value-of>
			</BORROWER_REF>
			<AVAILABLE_AMOUNT>
				<xsl:value-of select="availableForCurrency"></xsl:value-of>
			</AVAILABLE_AMOUNT>
			<LIMIT_CURRENCY>
				<xsl:value-of select="limitCurrency"></xsl:value-of>
			</LIMIT_CURRENCY>
			<FX_RATE>
				<xsl:value-of select="limitFXRate"></xsl:value-of>
			</FX_RATE>
			<LIMIT_AMOUNT>
				<xsl:value-of select="limitAmount"></xsl:value-of>
			</LIMIT_AMOUNT>
			<FACILITY_REF>
				<xsl:value-of select="$facility_id_global"></xsl:value-of>
			</FACILITY_REF>
		</com.misys.portal.product.ln.common.BorrowerLimit>
	</xsl:template>
		<xsl:template match="riskTypeLimit">
		<xsl:param name="bor_id"></xsl:param>
		<xsl:param name="facility_id_global"></xsl:param>
		<com.misys.portal.product.ln.common.BorrowerLimit>
			<LIMIT_ID>
				<xsl:value-of select="id"></xsl:value-of>
			</LIMIT_ID>
			<RISK_TYPE>
				<xsl:value-of select="riskType"></xsl:value-of>
			</RISK_TYPE>
			<BORROWER_REF>
				<xsl:value-of select="$bor_id"></xsl:value-of>
			</BORROWER_REF>
			<LIMIT_AMOUNT>
				<xsl:value-of select="limitAmount"></xsl:value-of>
			</LIMIT_AMOUNT>
			<AVAILABLE_AMOUNT>
				<xsl:value-of select="availableAmtForRiskTypeLimit"></xsl:value-of>
			</AVAILABLE_AMOUNT>
			<BORR_RISK_TYPE_DRAWN_AMOUNT>
				<xsl:value-of select="borrRiskTypeDrawnAmt"></xsl:value-of>
			</BORR_RISK_TYPE_DRAWN_AMOUNT>
			<LOAN>
				<xsl:value-of select="loan"></xsl:value-of>
			</LOAN>
			<IS_SWINGLINE>
				<xsl:value-of select="isSwingline"></xsl:value-of>
			</IS_SWINGLINE>
			<FACILITY_REF>
				<xsl:value-of select="$facility_id_global"></xsl:value-of>
			</FACILITY_REF>
		</com.misys.portal.product.ln.common.BorrowerLimit>
	</xsl:template>

	<xsl:template match="remittanceInstruction">
		<xsl:param name="bor_id"></xsl:param>
		<com.misys.portal.product.ln.common.RemittanceInstruction>
			<BORROWER_ID>
				<xsl:value-of select="$bor_id"></xsl:value-of>
			</BORROWER_ID>
			<REMITTANCE_ID>
				<xsl:value-of select="id"></xsl:value-of>
			</REMITTANCE_ID>
			<PAYMENT_METHOD>
				<xsl:value-of select="paymentMethod"></xsl:value-of>
			</PAYMENT_METHOD>
			<CURRENCY>
				<xsl:value-of select="currency"></xsl:value-of>
			</CURRENCY>
			<DESCRIPTION>
				<xsl:value-of select="description"></xsl:value-of>
			</DESCRIPTION>
			<SERVICE_GRP_ALIAS>
				<xsl:value-of select="servicingGroupAlias"></xsl:value-of>
			</SERVICE_GRP_ALIAS>
			<LOCATION_CODE>
				<xsl:value-of select="locationCode"></xsl:value-of>
			</LOCATION_CODE>
			<STANDARD_IND>
				<xsl:value-of select="standardInd"></xsl:value-of>
			</STANDARD_IND>
			<LOAN_PRODUCT_INDICATOR>
				<xsl:value-of select="loanProductIndicator"></xsl:value-of>
			</LOAN_PRODUCT_INDICATOR>
			<SBLC_INDICATOR>
				<xsl:value-of select="sblcProductIndicator"></xsl:value-of>
			</SBLC_INDICATOR>
			<PRINCIPAL_INDICATOR>
				<xsl:value-of select="principalIndicator"></xsl:value-of>
			</PRINCIPAL_INDICATOR>
			<INTEREST_INDICATOR>
				<xsl:value-of select="interestIndicator"></xsl:value-of>
			</INTEREST_INDICATOR>
			<FEES_INDICATOR>
				<xsl:value-of select="feesIndicator"></xsl:value-of>
			</FEES_INDICATOR>
			<INCOMING_TRNSFR_INDICATOR>
				<xsl:value-of select="incomingTransferIndicator"></xsl:value-of>
			</INCOMING_TRNSFR_INDICATOR>
			<OUTGOING_TRNSFR_INDICATOR>
				<xsl:value-of select="outgoingTransferIndicator"></xsl:value-of>
			</OUTGOING_TRNSFR_INDICATOR>
			<PREFERRED_IND>
				<xsl:value-of select="preferredInd"></xsl:value-of>
			</PREFERRED_IND>
			<ACCOUNT_NO>
				<xsl:value-of select="accountNo"></xsl:value-of>
			</ACCOUNT_NO>
			<BENEFICIARY_ACC_NO>
				<xsl:value-of select="beneficiaryAccountNumber"></xsl:value-of>
			</BENEFICIARY_ACC_NO>
			<BENEFICIARY_BANK_NAME>
				<xsl:value-of select="beneficiaryBankName"></xsl:value-of>
			</BENEFICIARY_BANK_NAME>
		</com.misys.portal.product.ln.common.RemittanceInstruction>
	</xsl:template>
</xsl:stylesheet>
