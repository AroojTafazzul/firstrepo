<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loaniq.LoanIQAdapter"
		exclude-result-prefixes="localization backoffice">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>

<xsl:param name="currencies"/>
<xsl:param name="pricingOptions"/>
<xsl:param name="repricingFrequencies"/>
<xsl:param name="riskTypes"/>


<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="common/common_ln.xsl" />


<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />


<!-- main -->
<xsl:template match="/">
	<xsl:apply-templates select="ln_tnx_record"/>
</xsl:template>

  
<!-- 
  LN TNX FORM TEMPLATE.
 -->
<xsl:template match="ln_tnx_record">
	<!-- Preloader -->
	<xsl:call-template name="loading-message"/>

 	<!-- Javascript and Dojo imports  -->
	<xsl:call-template name="js-imports"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
				</xsl:call-template>
			
				<xsl:call-template name="general-details" />
				
				<!-- Attach Files
				<xsl:if test="$displaymode='edit'">
    				<xsl:call-template name="attachments-file-dojo"/>
    			</xsl:if> -->
				
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="second-menu">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- real form -->
		<xsl:call-template name="realform" />
	</div>
	
	<!-- Table of Contents -->
	<xsl:call-template name="toc"/>
	   
    <!--  Collaboration Window -->     
    <xsl:call-template name="collaboration">
     <xsl:with-param name="editable">true</xsl:with-param>
     <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
     <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    </xsl:call-template>
    
   
	
</xsl:template>


<!-- Additional JS imports -->
<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
		<xsl:with-param name="binding">misys.binding.loan.report_activity_ln</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- general details -->
<xsl:template name="general-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		
		
			<!-- ActivityReportingScreen Fields -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SERVICER_LOAN_NUMBER</xsl:with-param>
				<xsl:with-param name="name">cust_ref_id</xsl:with-param>
				<xsl:with-param name="size">20</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
			</xsl:call-template>
		
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FM_LOAN_NUMBER</xsl:with-param>
				<xsl:with-param name="name">bo_ref_id</xsl:with-param>
				<xsl:with-param name="size">20</xsl:with-param>
				<xsl:with-param name="maxsize">64</xsl:with-param>
			</xsl:call-template>
			
			<!-- Exception codes -->
			<xsl:call-template name="select-field">
				<xsl:with-param name="name">reporting_method</xsl:with-param>
				<xsl:with-param name="label">XSL_REPORTING_METHOD</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="options"><xsl:call-template name="loan-reporting-method" /></xsl:with-param>
			</xsl:call-template>
		
			<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">eoc_ddlpi</xsl:with-param>
     			<xsl:with-param name="label">XSL_EOC_DDLPI</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">tnx_val_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_TRANSACTION_DATE</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">exception_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_EFFECTIVE_EXCEPTION_DATE</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_CURRENT_BALANCE</xsl:with-param>
				<xsl:with-param name="override-amt-name">ln_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">ln_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_PRINCIPAL</xsl:with-param>
				<xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">tnx_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_NET_YIELD_INTEREST</xsl:with-param>
				<xsl:with-param name="override-amt-name">interest_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">interest_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_LATE_FEE</xsl:with-param>
				<xsl:with-param name="override-amt-name">late_fee_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">late_fee_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_DEFAULT_INTEREST</xsl:with-param>
				<xsl:with-param name="override-amt-name">fault_interest_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">fault_interest_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_INTEREST_ON_ARREARS</xsl:with-param>
				<xsl:with-param name="override-amt-name">past_interest_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">past_interest_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_MINIMUM_USAGE_FEE</xsl:with-param>
				<xsl:with-param name="override-amt-name">min_use_fee_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">min_use_fee_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_UNUSED_FACILITY_FEE</xsl:with-param>
				<xsl:with-param name="override-amt-name">unused_fee_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">unused_fee_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_BREAKAGE_FEE</xsl:with-param>
				<xsl:with-param name="override-amt-name">breakage_fee_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">breakage_fee_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_NON_CASH_PRINCIPAL</xsl:with-param>
				<xsl:with-param name="override-amt-name">non_cash_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">non_cash_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_ADDITIONAL_PRINCIPAL</xsl:with-param>
				<xsl:with-param name="override-amt-name">additional_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">additional_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_EXCEPTION_INTEREST</xsl:with-param>
				<xsl:with-param name="override-amt-name">exception_interest_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">exception_interest_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_PREPAYMENT_PREMIUM</xsl:with-param>
				<xsl:with-param name="override-amt-name">premium_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">premium_cur_code</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			
			<!-- Reporting Method -->
			<xsl:call-template name="select-field">
				<xsl:with-param name="name">tnx_stat_code</xsl:with-param>
				<xsl:with-param name="label">XSL_PORTAL_TRANSACTION_STATUS</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="options"><xsl:call-template name="loan-transaction-status" /></xsl:with-param>
			</xsl:call-template>
			
			<!-- Exception codes -->
			<xsl:call-template name="select-field">
				<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				<xsl:with-param name="label">XSL_EXCEPTION_CODES</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="options"><xsl:call-template name="loan-exception-codes" /></xsl:with-param>
			</xsl:call-template>

		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- borrower -->
<xsl:template name="borrower-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BORROWER_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:if test="$displaymode='edit'">
				<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.customerReferences = {};
						<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
					});
				</script>
       		</xsl:if>
			<xsl:call-template name="address">
		        <xsl:with-param name="show-entity">Y</xsl:with-param>
				<xsl:with-param name="prefix">borrower</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- issuing bank -->
<xsl:template name="issuing-bank-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_ISSUING_BANK</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="issuing-bank-tabcontent">
   				<xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
   				<xsl:with-param name="sender-name">borrower</xsl:with-param>
   				<xsl:with-param name="sender-reference-name">borrower_reference</xsl:with-param>
   			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- loan details -->
<xsl:template name="loan-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		
		    <!-- application date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">appl_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     			<xsl:with-param name="value" select="appl_date" />
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>

			<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">eoc_ddlpi</xsl:with-param>
     			<xsl:with-param name="label">XSL_EOC_DDLPI</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">tnx_val_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_TRANSACTION_DATE</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
			</xsl:call-template>
			
		    <!-- issue (effective) date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">iss_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="size">10</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
    		</xsl:call-template>
    		
    		<!-- loan maturity date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
    		</xsl:call-template>

			<!-- loan amount -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_LOAN_AMOUNT</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="content">
							<script>
								// if currenciesStore not already defined
								if (!currenciesStore) {
									var currenciesStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$currencies"/>);
								}						
							</script>
						
				      		<div id="ln_cur_code" name="ln_cur_code" maxLength="3" required="true" trim="true" uppercase="true"
				      			 dojoType="dijit.form.FilteringSelect" style="width: 70px">
		      					<xsl:attribute name="value"><xsl:value-of select="ln_cur_code" /></xsl:attribute>
			      				<xsl:attribute name="store">currenciesStore</xsl:attribute>
	 			      		</div>
		      				<div id="tnx_amt" name="tnx_amt" required="true" trim="true"
      							 dojoType="misys.form.CurrencyTextBox" class="small">
								<xsl:attribute name="value"><xsl:value-of select="tnx_amt" /></xsl:attribute>
								<xsl:attribute name="displayedValue"><xsl:value-of select="tnx_amt" /></xsl:attribute>
      							<xsl:attribute name="constraints">{min:0}</xsl:attribute>
      						</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_AMOUNT</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="ln_cur_code" />&#160;<xsl:value-of select="tnx_amt" /></xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>

			<!-- pricing option -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<script>
						// if pricingOptionsStore not already defined
						if (!pricingOptionsStore) {
							var pricingOptionsStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$pricingOptions"/>);
						}						
					</script>
				
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">pricing_option</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="store">pricingOptionsStore</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'C030', pricing_option)" /></xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>

			<!-- Repricing Frequency -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<script>
						// if repricingFrequenciesStores not already defined
						if (!repricingFrequenciesStores) {
							var repricingFrequenciesStores = <xsl:value-of select="$repricingFrequencies"/>;
						}						
					</script>
					
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">repricing_frequency</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
						<!-- Do not sort the repricing frequencies by id or name. Retain the server side sorting
							based on period and quantity -->
						<xsl:with-param name="sort-filter-select">N</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'C031', repricing_frequency)" /></xsl:with-param>
					</xsl:call-template>				
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- Risk Type -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<script>
						// Define riskTypesStores, if not defined
						if(!riskTypesStores)
						{
							var riskTypesStores = <xsl:value-of select="$riskTypes" />;
						}
					</script>
					
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">risk_type</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_RISK_TYPE</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="store">riskTypesStores</xsl:with-param>						
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_LOAN_RISK_TYPE</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="localization:getDecode($language,'C032', risk_type)" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>			
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- real form -->
<xsl:template name="realform">
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name">realform</xsl:with-param>
		<xsl:with-param name="action"><xsl:value-of select="$realform-action"></xsl:value-of></xsl:with-param>
		<xsl:with-param name="content">
		 <div class="widgetContainer">
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">referenceid</xsl:with-param>
		       <xsl:with-param name="value" select="ref_id"/>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">tnxid</xsl:with-param>
		       <xsl:with-param name="value" select="tnx_id"/>
		      </xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">operation</xsl:with-param>
				<xsl:with-param name="id">realform_operation</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">mode</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$mode"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">tnxtype</xsl:with-param>
				<xsl:with-param name="value">01</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">TransactionData</xsl:with-param>
				<xsl:with-param name="value" />
			</xsl:call-template>
		 </div>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="hidden-fields">
    <xsl:call-template name="common-hidden-fields">
     <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
     <xsl:with-param name="additional-fields">
      <!-- ref_id -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">ref_id</xsl:with-param>
	</xsl:call-template>

	<!-- bo_ref_id -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bo_ref_id</xsl:with-param>
	</xsl:call-template>

	<!-- bo_facility_id -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bo_facility_id</xsl:with-param>
	</xsl:call-template>

	<!-- bo_facility_name -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bo_facility_name</xsl:with-param>
	</xsl:call-template>
	
	<!-- fcn -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">fcn</xsl:with-param>
	</xsl:call-template>

	<!-- bo_deal_id -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bo_deal_id</xsl:with-param>
	</xsl:call-template>

	<!-- bo_deal_name -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bo_deal_name</xsl:with-param>
	</xsl:call-template>

	<!-- facility issue (effective) date -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">facility_effective_date</xsl:with-param>
	</xsl:call-template>
	
	<!-- facility expiry date -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">facility_expiry_date</xsl:with-param>
	</xsl:call-template>
	
	<!-- eoc_ddlpi date -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name"></xsl:with-param>
	</xsl:call-template>
	
	<!-- tnx_val date -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">tnx_val_date</xsl:with-param>
	</xsl:call-template>

	<!-- facility maturity date -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">facility_maturity_date</xsl:with-param>
	</xsl:call-template>

	<!-- appl_date -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">appl_date</xsl:with-param>
	</xsl:call-template>

	<!-- ln_amt -->	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">ln_amt</xsl:with-param>
	</xsl:call-template>
	
	<!-- ln_liab_amt -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">ln_liab_amt</xsl:with-param>
	</xsl:call-template>
	
	<!-- match_funding -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">match_funding</xsl:with-param>
	</xsl:call-template>
				
     </xsl:with-param>
    </xsl:call-template>
</xsl:template>


</xsl:stylesheet>
