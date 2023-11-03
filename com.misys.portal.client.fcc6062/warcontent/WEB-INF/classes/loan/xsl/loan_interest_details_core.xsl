<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:stringescapeutils="xalan://org.apache.commons.lang.StringEscapeUtils"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"		
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
		exclude-result-prefixes="localization loanIQ stringescapeutils utils defaultresource tools">


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
	<xsl:apply-templates select="loan"/>
</xsl:template>

  
<!-- 
  LN TNX FORM TEMPLATE.
 -->
 
 

 
<xsl:template match="loan">
	<!-- Preloader -->
	<xsl:call-template name="loading-message"/>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform1</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
			    <xsl:call-template name="Loan-details" />
				<xsl:call-template name="interest-details" />
				<xsl:call-template name="loanInterest-details-grid" />
			</xsl:with-param>
		</xsl:call-template>
	</div>
	<xsl:call-template name="reauthentication"/> 
	
</xsl:template>

<!-- Loan details -->
<xsl:template name="Loan-details">
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_LOAN_DETAILS</xsl:with-param>
	
	 
	
		<xsl:with-param name="content">
			<!-- system id -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">entity</xsl:with-param>
				<xsl:with-param name="label">XLS_LOAN_DETAILS_ENTITY</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_LOAN_DETAILS_DEAL</xsl:with-param>
				<xsl:with-param name="name">deal_name</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="stringescapeutils:unescapeXml(deal_name)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_LOAN_DETAILS_FAC_NAME</xsl:with-param>
				<xsl:with-param name="name">facility_name</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="stringescapeutils:unescapeXml(facility_name)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
									
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">loan_alias</xsl:with-param>
				<xsl:with-param name="label">XLS_LOAN_DETAILS_LOAN_ALIAS</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="stringescapeutils:unescapeXml(loan_alias)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				<xsl:with-param name="appendClass">loanAlias</xsl:with-param>
			</xsl:call-template>	
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XLS_FX_CONVERSION_RATE_USED</xsl:with-param>
				<xsl:with-param name="name">fx_conversion</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatFXConversionRateValues(fx_conversion,$language)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>

		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- interest details -->
<xsl:template name="interest-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_INTEREST_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<!-- system id -->
			<xsl:if test="interest_rateType[.!= '']">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="localization:getCodeData($language,'**','LN','C030', interest_rateType)" />
						</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>	
			</xsl:if>
			
			<xsl:if test="interest_cycle_frequency[.!= '']">
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">interest_cycle_frequency</xsl:with-param>
				<xsl:with-param name="label">XLS_INTEREST_DETAILS_INTEREST_CYC_FREQUENCY</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		
			<xsl:if test="base_rate[.!= '']">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_BASE_RATE</xsl:with-param>
  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues(base_rate,currency,$language)" />%</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="spread[.!= '']">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_SPREAD</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues(spread,currency,$language)" />%</xsl:with-param>				
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="rac_rate[.!= '']">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_RAC_RATE</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues(rac_rate,currency,$language)" />%</xsl:with-param>	
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="all_in_rate[.!= '']">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_ALL_IN_RATE</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues(all_in_rate,currency,$language)" />%</xsl:with-param>	
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			</xsl:if>	
			<xsl:if test="totalProjectedEOCamt[.!= '']">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="content">
					
					
					<xsl:variable name="arrayList1" select="java:java.util.ArrayList.new()" />
					<xsl:variable name="void" select="java:add($arrayList1, concat('', today_date))"/>
					<xsl:variable name="void" select="java:add($arrayList1, concat('', currency))"/>
					<xsl:variable name="void" select="java:add($arrayList1, concat('', loanIQ:getFormatedAmount(totalProjectedEOCamt,currency,$language)))"/>		
					<xsl:variable name="args1" select="java:toArray($arrayList1)"/>
					
					<xsl:value-of select="localization:getFormattedString($language, 'LOAN_DETAILS_INTEREST_DUE', $args1)" disable-output-escaping="yes"/>
					
						<!-- system id -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">total_interest_Due_Amt</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
							
					</xsl:with-param>
				</xsl:call-template>
		</xsl:if>
			
	
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="loanInterest-details-grid">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_INTEREST_CYCLE_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">	

<p>&nbsp;</p>
<div>
</div>

<div>
					<script type="text/javascript">
						var sublimitGridLayout, pluginsData;
						dojo.ready(function(){
					    	sublimitGridLayout = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_INTEREST_CYCLE_NO')"/>", "field": "interest_cycle", "width": "10%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_START_DATE')"/>", "field": "start_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_END_DATE')"/>", "field": "end_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_DUE_DATE')"/>", "field": "adjusted_due_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_PRJ_CYC_DUE')"/>", "field": "projected_cycleDue_amt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_ACCURED_TO_DATE')"/>", "field": "accrued_toDate_amt", "width": "10%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_PAID_TO_DATE')"/>", "field": "paid_toDate_amt", "width": "10%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_BILLED_INTEREST')"/>", "field": "billed_interest_amt", "width": "10%", "styles":"text-align: right;white-space:nowrap;", "headerStyles":"white-space:nowrap;"}
					                   ]
					                  					                   
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeSublimits" requestMethod="post">
							<xsl:attribute name="url">								
									
										<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=loan/listdef/customer/LN/inquiryLNInterestCycleInfo.xml&amp;borefid=<xsl:value-of select='loan_alias'/>
									
								
							</xsl:attribute>
						</div>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeSublimits" structure="sublimitGridLayout" class="grid" 
							autoHeight="true" id="gridsublimits" dojoType="dojox.grid.EnhancedGrid" 
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
