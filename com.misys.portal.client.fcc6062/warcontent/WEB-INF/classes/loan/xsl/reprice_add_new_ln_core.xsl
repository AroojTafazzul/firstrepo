<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"		
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
		exclude-result-prefixes="localization backoffice utils defaultresource tools">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode" >edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>

<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="../../core/xsl/common/ln_common.xsl" />
<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

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
	<!-- Additional JS imports -->
    <xsl:call-template name="js-imports"/>
	
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform1</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			
			<xsl:with-param name="content">
			    <xsl:call-template name="Loan-details" />
			    <xsl:call-template name="submit_buttons" />
			</xsl:with-param>
		</xsl:call-template>
	</div>
	
</xsl:template>


		<xsl:template name="js-imports">
			<xsl:call-template name="common-js-imports">
				<xsl:with-param name="binding">misys.binding.loan.reprice_new_loan</xsl:with-param>
				<xsl:with-param name="show-period-js">Y</xsl:with-param>
				<xsl:with-param name="override-help-access-key">LN_0197</xsl:with-param>
			</xsl:call-template>
		</xsl:template>

<!-- Loan details -->
<xsl:template name="Loan-details">
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_REPRICING_ROLL_OVER_DETAILS</xsl:with-param>	 	
		<xsl:with-param name="content">
		
				 <xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
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
						<xsl:with-param name="name">ref_id</xsl:with-param>
						<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
		<!-- 				<xsl:with-param name="override-displaymode">view</xsl:with-param> -->
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>	
					
					<!-- customer reference -->
					<xsl:call-template name="input-field">
			  			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
						<xsl:with-param name="name">cust_ref_id</xsl:with-param>
						<xsl:with-param name="size">20</xsl:with-param>
						<xsl:with-param name="maxsize">34</xsl:with-param>
					</xsl:call-template>
					
													<!-- facility Id-->
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">bo_facility_id</xsl:with-param>
						<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<!-- <xsl:with-param name="store">misys._config.facilitiesStore</xsl:with-param> -->
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="disabled">Y</xsl:with-param>
					</xsl:call-template>
<!-- 					<xsl:call-template name="select-field"> -->
<!-- 						<xsl:with-param name="name">risk_type</xsl:with-param> -->
<!-- 						<xsl:with-param name="required">Y</xsl:with-param> -->
<!-- 						<xsl:with-param name="label">XSL_LOAN_RISK_TYPE</xsl:with-param> -->
<!-- 						<xsl:with-param name="required">Y</xsl:with-param> -->
<!-- 					</xsl:call-template> -->
					
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">risk_type_disp</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_RISK_TYPE</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
		<!-- 				<xsl:with-param name="override-displaymode">view</xsl:with-param> -->
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>	
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">pricing_option</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>						
						<xsl:with-param name="required">Y</xsl:with-param>						
					</xsl:call-template>
					
					
			</xsl:with-param>
			</xsl:call-template>
			
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_LOAN_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">	
			
					<!-- new loan outstanding amount -->

					<xsl:call-template name="row-wrapper">
					
						<xsl:with-param name="content">
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_REPRICING_LOAN_AMT</xsl:with-param>
				    			<xsl:with-param name="disabled">Y</xsl:with-param>
								<xsl:with-param name="override-amt-name">ln_amt</xsl:with-param>
								<xsl:with-param name="override-currency-name">ln_cur_code</xsl:with-param>
								<xsl:with-param name="override-amt-value"><xsl:value-of select="ln_amt"/></xsl:with-param>
								<xsl:with-param name="currency-readonly">Y</xsl:with-param>
								<xsl:with-param name="show-button">N</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
				    		</xsl:call-template> 
						</xsl:with-param>
					</xsl:call-template>
					<div  id="facFXRateId" style="display:none">
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="label">XSL_INDICATIVE_FX_RATE</xsl:with-param>
							<xsl:with-param name="content">
	      						<div id="fx_display" name="fx_display" required="true" trim="true"
	      							 dojoType="dijit.form.TextBox" class="medium"  disabled="true">
									<xsl:attribute name="value"><xsl:value-of select="fx_conversion_rate" /></xsl:attribute>
 									 <xsl:attribute name="displayedValue"><xsl:value-of select="fx_conversion_rate" /></xsl:attribute>
	       							<xsl:attribute name="constraints">{min:0}</xsl:attribute> 
	      						</div>
	      						<div style="font-weight:bold;margin-left:245px;font-style:italic;"><xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_NOTE')"/></div>
	      						<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">fx_conversion_rate</xsl:with-param>
								</xsl:call-template>
	      					</xsl:with-param>
	      				</xsl:call-template>
	      			</div>
					
		    		
		    		<xsl:call-template name="input-field">
		    			<xsl:with-param name="type">date</xsl:with-param>
		    			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
		    			<xsl:with-param name="required">Y</xsl:with-param>
		     			<xsl:with-param name="name">effective_date</xsl:with-param>
		     			<xsl:with-param name="fieldsize">small</xsl:with-param>
		     			<xsl:with-param name="maxsize">10</xsl:with-param>
		     		</xsl:call-template>
		     		
		     		<xsl:call-template name="input-field">
		    			<xsl:with-param name="type">date</xsl:with-param>
		    			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
		    			<xsl:with-param name="required">Y</xsl:with-param>
		     			<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
		     			<xsl:with-param name="fieldsize">small</xsl:with-param>
		     			<xsl:with-param name="maxsize">10</xsl:with-param>
		     		</xsl:call-template>		
			</xsl:with-param>
			</xsl:call-template>
				
		    			<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">match_funding</xsl:with-param>
						</xsl:call-template>						
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">facility_maturity_date</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">facility_effective_date</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">facility_expiry_date</xsl:with-param>
						</xsl:call-template>
					
					  <xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">new_ln_tnxid</xsl:with-param>
					       <xsl:with-param name="value" select="tnx_id"/>
				      </xsl:call-template>
						

                        <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">faciliy_global_available_amount</xsl:with-param>
						</xsl:call-template>
						 <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">fc_access_type</xsl:with-param>
							<xsl:with-param name="value"></xsl:with-param>
						</xsl:call-template>
						

						 <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">dummy_ln_amt</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="ln_amt" /></xsl:with-param>
						</xsl:call-template>
						
						 <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">risk_type</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="risk_type" /></xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">fcn</xsl:with-param>
						</xsl:call-template>	
						<xsl:call-template name="hidden-field">
						   <xsl:with-param name="name">_token</xsl:with-param>
						   <xsl:with-param name="value"><xsl:value-of select="_token"/></xsl:with-param>
						</xsl:call-template>	
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">repricingdate_validation</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('VALIDATE_AMOUNT_WITH_REPRICING_DATE')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">net_cashFlow</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('RESTRICT_NET_CASH_FLOW')"/></xsl:with-param>
						</xsl:call-template>
												
		    			<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPRICING_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">	
			
			<xsl:call-template name="select-field">
					 	<xsl:with-param name="name">repricing_frequency</xsl:with-param>
					 	<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
						<!-- Do not sort the repricing frequencies by id or name. Retain the server side sorting
							based on period and quantity -->
						<xsl:with-param name="sort-filter-select">N</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="input-field">
		    			<xsl:with-param name="type">date</xsl:with-param>
		    			<xsl:with-param name="label">XSL_GENERALDETAILS_REPRICING_DATE</xsl:with-param>
		     			<xsl:with-param name="name">repricing_date</xsl:with-param>
		     			<xsl:with-param name="required">Y</xsl:with-param>
		     			<xsl:with-param name="fieldsize">small</xsl:with-param>
		     			<xsl:with-param name="maxsize">10</xsl:with-param>
		     			<xsl:with-param name="readonly">Y</xsl:with-param>
		     		</xsl:call-template>						
<!-- 					<xsl:call-template name="select-field"> -->
<!-- 					 	<xsl:with-param name="name">interest_cycle_frequency</xsl:with-param> -->
<!-- 					 	<xsl:with-param name="required">Y</xsl:with-param> -->
<!-- 						<xsl:with-param name="label">XLS_REPRICING_LOAN_INTEREST_FREQUENCY</xsl:with-param> -->
<!-- 					</xsl:call-template> -->
			
			
			</xsl:with-param>
			</xsl:call-template>	

		    							
					

		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="submit_buttons">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="content">	
						
				<div style="text-align: center;">
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="label">XSL_ACTION_OK</xsl:with-param>
										<xsl:with-param name="id">addLoan</xsl:with-param>
				<!-- 						<xsl:with-param name="class">submitButton</xsl:with-param> -->
										<xsl:with-param name="onclick">misys.addNewRepriceLoan();</xsl:with-param>
										<xsl:with-param name="show-text-label">Y</xsl:with-param>
									</xsl:call-template>
						
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="label">ACTION_USER_REPRICE_CANCEL</xsl:with-param>
										<xsl:with-param name="id">newLnRepriceCancel</xsl:with-param>
				<!-- 						<xsl:with-param name="class">cancelButton</xsl:with-param> -->
										<xsl:with-param name="onclick">misys.cancelRepriceLoan();</xsl:with-param>
										<xsl:with-param name="show-text-label">Y</xsl:with-param>
									</xsl:call-template>		
				</div>
		</xsl:with-param>
		</xsl:call-template>
</xsl:template>

<!-- interest details -->

</xsl:stylesheet>
