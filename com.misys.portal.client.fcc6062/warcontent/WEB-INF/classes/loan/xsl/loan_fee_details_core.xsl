<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:loanutils="xalan://com.misys.portal.common.tools.LoanUtils"
		xmlns:urlencoder="xalan://java.net.URLEncoder"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization loanIQ utils loanutils urlencoder defaultresource">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>
<xsl:param name="facilityid" />
<xsl:param name="borrowerid" />

<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="../../core/xsl/common/ln_common.xsl" />
<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

<!-- main -->
<xsl:template match="/">
	<xsl:apply-templates select="facility"/>
</xsl:template>

  
<!-- 
  LN TNX FORM TEMPLATE.
 -->
 
 

 
<xsl:template match="facility">
	<!-- Preloader -->
	<xsl:call-template name="loading-message"/>
	<!-- Javascript and Dojo imports  -->
	<xsl:call-template name="js-imports"/>
	
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform1</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
			    <xsl:call-template name="fee-details" />
			    <xsl:call-template name="fee-details-grid" />
			</xsl:with-param>
		</xsl:call-template>
	</div>
	<xsl:call-template name="reauthentication"/> 
	
</xsl:template>
<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
		<xsl:with-param name="binding">misys.binding.loan.facility_ongoing_fee</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>		
	</xsl:call-template>
	
</xsl:template>




<!-- Fee details -->
<xsl:template name="fee-details">
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_FACILITIES_DETAILS_TITTLE</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_LOAN_DETAILS_DEAL</xsl:with-param>
 				<xsl:with-param name="value"><xsl:value-of select="dealName" /></xsl:with-param> 
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_LOAN_DETAILS_FAC_NAME</xsl:with-param>
  				
				<xsl:with-param name="value"><xsl:value-of select="facilityName" /></xsl:with-param> 
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
				
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_SUBLIMIT_DETAILS_CURRENCY</xsl:with-param>
				<xsl:with-param name="name">currency</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">facilityId</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="urlencoder:encode($facilityid)" /></xsl:with-param>						
			</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">borrowerId</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="urlencoder:encode($borrowerid)" /></xsl:with-param>						
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">facilityName</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="urlencoder:encode(facilityName)" /></xsl:with-param>						
			</xsl:call-template>	
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">effectiveDate</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="//effectiveDate" /></xsl:with-param>						
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">dueDate</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="//actualDueDate" /></xsl:with-param>						
			</xsl:call-template>		
			
<!-- 			<xsl:call-template name="input-field"> -->
<!--   				<xsl:with-param name="label">XSL_FEE_AVAILABLE</xsl:with-param> -->
<!-- 				<xsl:with-param name="value"><xsl:value-of select="utils:bigDecimalToAmountString(totalCommitmentAmount,currency,$language)" /></xsl:with-param> -->
<!-- 				<xsl:with-param name="override-displaymode">view</xsl:with-param> -->
<!-- 			</xsl:call-template> -->
			
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_SUBLIMIT_DETAILS_EXPIRY_DATE</xsl:with-param>
				<xsl:with-param name="name">expiryDate</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loanutils:convertApiDateToFccDate(expiryDate,$language)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_SUBLIMIT_DETAILS_MATURITY_DATE</xsl:with-param>
				<xsl:with-param name="name">maturityDate</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loanutils:convertApiDateToFccDate(maturityDate,$language)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- Fee details grid -->
<xsl:template name="fee-details-grid">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_FEE_DETAILS_TITTLE</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
		 <xsl:variable name="cur_code"><xsl:value-of select="currency"/></xsl:variable>
		 
		 <div id="feeDetails">
				<script type="text/javascript">
						var feeGridLayout, pluginsData;
						dojo.ready(function(){
					    	feeGridLayout = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FEE_SNO')"/>", "field": "fee_Identifier", "width": "3em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FEE_TYPE')"/>", "field": "fee_type", "width": "23%", "styles":"white-space:nowrap;text-align: left;", "headerStyles":"white-space:nowrap;", "get":misys.getFacilityOngoingFee, "formatter": misys.formatFacilityOngoingFeeActions},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_FACILITY_CURRENCY')"/>", "field": "currency", "width": "5em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                    { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CURRENT_RATE')"/>", "field": "rate", "width": "8em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                     { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_FACILITY_EFFECTIVE_DATE')"/>", "field": "effective_date", "width": "6em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                    { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_DUE_DATE')"/>", "field": "due_date", "width": "18%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                     { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FEE_AMOUNT')"/>", "field": "fee_amount", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"}
<!-- 					                      { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FEE_START_DATE')"/>", "field": "effectiveDate", "width": "9%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
<!-- 					                       { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FEE_END_DATE')"/>", "field": "actualExpiryDate", "width": "9%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
<!-- 					                    { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FEE_STATUS')"/>", "field": "status", "width": "5em", "styles":"text-align: center;white-space:nowrap;", "headerStyles":"white-space:nowrap;"} -->										
					                   ]
					                  					                   
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
					
				<script>
						var gridFeeData = [];
						dojo.ready(function(){
							gridFeeData = [
									<xsl:for-each select="ongoingFees/ongoingFee">
										<xsl:variable name="ongoingFee" select="."/>
										{fee_Identifier:"<xsl:value-of select="position()"/>",
										"fee_type" :  "<xsl:value-of select="$ongoingFee/description"/>",  
										"currency" :  "<xsl:value-of select="$ongoingFee/currency"/>",
										"rate" :  "<xsl:value-of select="loanIQ:formatRateValues($ongoingFee/rate,currency,$language)"/>%",
										"fee_rid" :  "<xsl:value-of select="urlencoder:encode($ongoingFee/feeRID)"/>",
										"effective_date" : "<xsl:value-of select="loanutils:convertApiDateToFccDate($ongoingFee/effectiveDate,$language)"/>",	
										"due_date" :  "<xsl:value-of select="loanutils:convertApiDateToFccDate($ongoingFee/actualDueDate,$language)"/>", 
										"fee_amount" :  "<xsl:value-of select="utils:bigDecimalToAmountString($ongoingFee/dueAmount,$cur_code,$language)"/>" 
<!-- 										"effectiveDate" :  "<xsl:value-of select="$ongoingFee/effectiveDate"/>", -->
<!-- 										<xsl:choose> -->
<!-- 											<xsl:when test="$ongoingFee/actualExpiryDate[.!= '']"> -->
<!-- 												"actualExpiryDate" :  "<xsl:value-of select="$ongoingFee/actualExpiryDate"/>", -->
<!-- 											</xsl:when> -->
<!-- 											<xsl:otherwise> -->
<!-- 											"actualExpiryDate" :  "<xsl:value-of select="$ongoingFee/originalExpiryDate"/>", -->
<!-- 											</xsl:otherwise> -->
<!-- 										</xsl:choose> -->
<!-- 										"status" :  "<xsl:value-of select="$ongoingFee/status"/>"  -->
										}
										<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
								];
						});
					</script>

					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="feeDetailsStore" >
							<xsl:attribute name="data">
								{"identifier":"fee_Identifier","label":"fee_Identifier","items" : gridFeeData}
							</xsl:attribute>
						</div>
						<table rowsPerPage="50" 
							plugins="pluginsData" 
							store="feeDetailsStore" structure="feeGridLayout" class="grid" 
							autoHeight="true" id="gridRepricingLoanTransactions" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
						
						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
					</div>
					
				</xsl:with-param>
		</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
