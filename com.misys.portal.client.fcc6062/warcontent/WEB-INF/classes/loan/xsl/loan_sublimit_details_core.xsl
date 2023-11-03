<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loaniq.LoanIQAdapter"
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:loanutils="xalan://com.misys.portal.common.tools.LoanUtils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization backoffice loanutils java utils defaultresource">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>
<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>

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
			    <xsl:call-template name="Sublimits-details" />
			    <xsl:call-template name="sublimits-type-details-grid" />
			     <xsl:call-template name="risk-type-details-grid" />
			       <xsl:call-template name="currency-type-details-grid" />
			  			    
			   
			</xsl:with-param>
		</xsl:call-template>
	</div>
	<xsl:call-template name="reauthentication"/> 
	
</xsl:template>

<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
		<xsl:with-param name="binding">misys.binding.loan.sublimits_ln</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>
		
	</xsl:call-template>
	
</xsl:template>


<!-- Sublimits details -->
<xsl:template name="Sublimits-details">
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_SUBLIMIT_DETAILS_TITTLE</xsl:with-param>
		<xsl:with-param name="content">
		
		
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_LOAN_DETAILS_DEAL</xsl:with-param>
 				<xsl:with-param name="value"><xsl:value-of select="deal/name" /></xsl:with-param> 
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_LOAN_DETAILS_FAC_NAME</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="name" /></xsl:with-param> 
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_LOAN_DETAILS_FAC_NAME</xsl:with-param>
				<xsl:with-param name="name">id</xsl:with-param>
				<xsl:with-param name="override-displaymode">hidden</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_SUBLIMIT_DETAILS_CURRENCY</xsl:with-param>
				<xsl:with-param name="name">mainCurrency</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_SUBLIMIT_DETAILS_EFFECTIVE_DATE</xsl:with-param>
				<xsl:with-param name="name">effectiveDate</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loanutils:convertApiDateToFccDate(effectiveDate,$language)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
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
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_SUBLIMIT_DETAILS_BORROWER_LIMIT</xsl:with-param>
  				
				<xsl:with-param name="value">
				<xsl:value-of select="mainCurrency" />&#160; <xsl:value-of select="utils:bigDecimalToAmountString(borrower/limitAmount,mainCurrency,$language)" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>	
			
					
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="sublimits-type-details-grid">
			<xsl:call-template name="fieldset-wrapper">
		
		<xsl:with-param name="content">
	        <xsl:variable name="cur_code"><xsl:value-of select="mainCurrency"/></xsl:variable>
			<xsl:variable name="sublimitcount" select="count(borrower/sublimits/sublimit)"/>
			<xsl:variable name="arrayList" select="java:java.util.ArrayList.new()"/>
			<xsl:variable name="void" select="java:add($arrayList, $sublimitcount)"/>
			<xsl:variable name="args" select="java:toArray($arrayList)"/>
				
				<div class="wipeInOutTabHeaderAsPerWindowSize">
				<div id="actionDown" onclick="misys.togglesublimitsInst()" style="cursor: pointer; display: block;">
				    
				    <span class="collapsingImgSpanLeftSide">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>&#160;
				    <xsl:value-of select="localization:getFormattedString($language, 'XSL_HEADER_SUBLIMIT_DETAILS', $args)"/>
				</div>
				<div id="actionUp" onclick="misys.togglesublimitsInst()" style="display: none; cursor: pointer;">
				    
				    <span class="collapsingImgSpanLeftSide">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>&#160;
				   <xsl:value-of select="localization:getFormattedString($language, 'XSL_HEADER_SUBLIMIT_DETAILS', $args)"/>
				</div>
				</div>
			<div id="sublimitInstContainer">
				<div class="clear multigrid">
						<script type="text/javascript">
						var sublimitGridLayout, pluginsData;
						dojo.ready(function(){
					    	sublimitGridLayout = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LIMIT_TYPE')"/>", "field": "sublimit_name", "width": "30%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LIMIT_AMOUNT')"/>", "field": "limitAmount", "width": "20%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                    { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CURRENCY')"/>", "field": "currency", "width": "3em", "styles":"text-align: center;white-space:nowrap;", "headerStyles":"white-space:nowrap;"}
					                   ]
					                  					                   
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
				<script>
						var gridData = [];
						dojo.ready(function(){
							gridData = [
									<xsl:for-each select="borrower/sublimits/sublimit">
										<xsl:variable name="sublimit" select="."/>
										{"sublimit_name" :  "<xsl:value-of select="$sublimit/sublimit_name"/>",  
										"limitAmount" :  "<xsl:value-of select="utils:bigDecimalToAmountString($sublimit/global_amount,$cur_code,$language)"/>", 
										"currency" :  "<xsl:value-of select="$sublimit/currency"/>" 
										}
										<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
								];
							
						});
					</script>
		<div style="width:95%;height:100%;align:center;" class="widgetContainer clear">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeRepricingLoanTransaction" >
							<xsl:attribute name="data">
								{"identifier":"sublimit_name","label":"sublimit_name","items" : gridData}
							</xsl:attribute>
						</div>
						
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeRepricingLoanTransaction" structure="sublimitGridLayout" class="grid" 
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
</div>
				</xsl:with-param></xsl:call-template>
</xsl:template>

<xsl:template name="risk-type-details-grid">
			<xsl:call-template name="fieldset-wrapper">
		
		<xsl:with-param name="content">
	       <xsl:variable name="cur_code"><xsl:value-of select="mainCurrency"/></xsl:variable>
			<xsl:variable name="riskTypecount" select="count(borrower/riskTypeLimit)"/>
			<xsl:variable name="arrayList" select="java:java.util.ArrayList.new()"/>
			<xsl:variable name="void" select="java:add($arrayList, $riskTypecount)"/>
			<xsl:variable name="args" select="java:toArray($arrayList)"/>
				<div class="wipeInOutTabHeaderAsPerWindowSize">
				<div id="actionDownRisk" onclick="misys.toggleRiskSublimitsInst()" style="cursor: pointer; display: block;">
				    
				    <span class="collapsingImgSpanLeftSide">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>&#160;
				  
				    <xsl:value-of select="localization:getFormattedString($language, 'XSL_HEADER_RISK_SUBLIMIT_DETAILS', $args)"/>
				</div>
				<div id="actionUpRisk" onclick="misys.toggleRiskSublimitsInst()" style="display: none; cursor: pointer;">
				    
				    <span class="collapsingImgSpanLeftSide">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>&#160;
				   <xsl:value-of select="localization:getFormattedString($language, 'XSL_HEADER_RISK_SUBLIMIT_DETAILS', $args)"/>
				</div>
				</div>
			<div id="riskSublimitInstContainer">
			
						<script type="text/javascript">
						var riskSublimitGridLayout, pluginsDataRisk;
						dojo.ready(function(){
					    	riskSublimitGridLayout = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LIMIT_TYPE')"/>", "field": "sublimit_name", "width": "30%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LIMIT_AMOUNT')"/>", "field": "limitAmount", "width": "20%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                    { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CURRENCY')"/>", "field": "currency", "width": "3em", "styles":"text-align: center;white-space:nowrap;", "headerStyles":"white-space:nowrap;"}
					                   ]
					                  					                   
					              ]};
							pluginsDataRisk = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
				<script>
						var gridRiskData = [];
						dojo.ready(function(){
							gridRiskData = [
									<xsl:for-each select="borrower/riskTypeLimit">
										<xsl:variable name="riskTypeLimit" select="."/>
										{"sublimit_name" :  "<xsl:value-of select="$riskTypeLimit/riskType"/>",  
										"limitAmount" :  "<xsl:value-of select="utils:bigDecimalToAmountString($riskTypeLimit/limitAmount,$cur_code,$language)"/>", 
										"currency" :  "<xsl:value-of select="$riskTypeLimit/currency"/>" 
										}
										<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
								];
							
						});
					</script>
		  <div style="width:95%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeRiskSublimitsTransaction" >
							<xsl:attribute name="data">
								{"identifier":"sublimit_name","label":"sublimit_name","items" : gridRiskData}
							</xsl:attribute>
						</div>
						
					    <table rowsPerPage="50" 
							plugins="pluginsDataRisk" 
							store="storeRiskSublimitsTransaction" structure="riskSublimitGridLayout" class="grid" 
							autoHeight="true" id="gridRiskSublimits" dojoType="dojox.grid.EnhancedGrid" 
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

<xsl:template name="currency-type-details-grid">
			<xsl:call-template name="fieldset-wrapper">
		
		<xsl:with-param name="content">
		<xsl:variable name="cur_code"><xsl:value-of select="mainCurrency"/></xsl:variable>
		<xsl:variable name="currencyTypecount" select="count(borrower/currencyLimit)"/>
			<xsl:variable name="arrayList" select="java:java.util.ArrayList.new()"/>
			<xsl:variable name="void" select="java:add($arrayList, $currencyTypecount)"/>
			<xsl:variable name="args" select="java:toArray($arrayList)"/>
		
				
				<div class="wipeInOutTabHeaderAsPerWindowSize">
				
				<div id="actionDownCurrency" onclick="misys.toggleCurrencySublimitsInst()" style="cursor: pointer; display: block;">
				    
				    <span class="collapsingImgSpanLeftSide">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>&#160;
				   
				     <xsl:value-of select="localization:getFormattedString($language, 'XSL_HEADER_CURRENCY_SUBLIMIT_DETAILS', $args)"/>
				</div>
				<div id="actionUpCurrency" onclick="misys.toggleCurrencySublimitsInst()" style="display: none; cursor: pointer;">
				   
				    <span class="collapsingImgSpanLeftSide">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>&#160;
				    <xsl:value-of select="localization:getFormattedString($language, 'XSL_HEADER_CURRENCY_SUBLIMIT_DETAILS', $args)"/>
				</div>
				</div>
			<div id="currencySublimitInstContainer">
			
						<script type="text/javascript">
						var currencySublimitGridLayout, pluginsData;
						dojo.ready(function(){
					    	currencySublimitGridLayout = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LIMIT_TYPE')"/>", "field": "sublimit_name", "width": "30%", "styles":"width:auto;white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LIMIT_AMOUNT')"/>", "field": "limit_amt", "width": "20%", "styles":"width:auto;white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                    { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CURRENCY')"/>", "field": "currency", "width": "3em", "styles":"text-align: center;white-space:nowrap;width:auto;", "headerStyles":"white-space:nowrap;"}
					                   ]
					                  					                   
					              ]};
							pluginsDataCurrency = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
				<script>
						var gridCurrencyData = [];
						dojo.ready(function(){
							gridCurrencyData = [
									<xsl:for-each select="borrower/currencyLimit">
										<xsl:variable name="currencyLimit" select="."/>
										{"sublimit_name" :  "<xsl:value-of select="$currencyLimit/currency"/>",  
										"limit_amt" :  "<xsl:value-of select="utils:bigDecimalToAmountString($currencyLimit/limitAmount,$cur_code,$language)"/>", 
										"currency" :  "<xsl:value-of select="$currencyLimit/limitCurrency"/>" 
										}
										<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
								];
							
						});
					</script>
		  <div style="width:95%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeCurrencySublimitsTransaction" >
							<xsl:attribute name="data">
								{"identifier":"sublimit_name","label":"sublimit_name","items" : gridCurrencyData}
							</xsl:attribute>
						</div>
						
					    <table rowsPerPage="50" 
							plugins="pluginsDataCurrency" 
							store="storeCurrencySublimitsTransaction" structure="currencySublimitGridLayout" class="grid" 
							autoHeight="true" id="gridCurrencySublimits" dojoType="dojox.grid.EnhancedGrid" 
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
