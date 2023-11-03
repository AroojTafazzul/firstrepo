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
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:technicalResource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
		exclude-result-prefixes="localization loanIQ utils defaultresource tools">


<!-- Parameters -->  

<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>

<xsl:param name="PrincipalPlusInterest"><xsl:value-of select="technicalResource:getTechnicalResource('LN_PRINCIPAL_PLUS_INTEREST')"/></xsl:param>
<xsl:param name="NoLoanAlias"><xsl:value-of select="technicalResource:getTechnicalResource('LN_NO_LOAN_ALIAS')"/></xsl:param>
<xsl:param name="PrincipalOnly"><xsl:value-of select="technicalResource:getTechnicalResource('LN_PRICIPAL_ONLY')"/></xsl:param>
<xsl:param name="Bullet"><xsl:value-of select="technicalResource:getTechnicalResource('LN_BULLET')"/></xsl:param>
<xsl:param name="FixedPayment"><xsl:value-of select="technicalResource:getTechnicalResource('LN_FIXED_PAYMENT')"/></xsl:param>
<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="previewImage"><xsl:value-of select="$images_path"/>preview.png</xsl:param>
<xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>



<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="../../core/xsl/common/ln_common.xsl" />
<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
<!-- <xsl:include href="../../core/xsl/common/form_templates_core.xsl" />-->


<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />


<xsl:template match="/">
	<xsl:apply-templates select="lnRepaymentDetails"/>
</xsl:template>

<xsl:template match="lnRepaymentDetails">

		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

		<xsl:call-template name="js-imports"/>
		<xsl:call-template name="loan-repayment-schedule" />


	
</xsl:template>

<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
		<xsl:with-param name="binding">misys.binding.loan.repayment_details_ln</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>
		
	</xsl:call-template>
	
</xsl:template>

<!-- loan details -->
<xsl:template name="loan-repayment-schedule">

	<xsl:if test="repaymentType[.= '']">
	<xsl:call-template name="fieldset-wrapper">

		<xsl:with-param name="content">	
		
					<xsl:call-template name="input-field">
						<!-- <xsl:with-param name="label">XLS_NO_REPAYMENT_DETAILS</xsl:with-param> -->
						<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XLS_NO_REPAYMENT_DETAILS')"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	</xsl:if>
	<xsl:if test="repaymentType[.= $NoLoanAlias]">
	<xsl:call-template name="fieldset-wrapper">

		<xsl:with-param name="content">	
		
					<xsl:call-template name="input-field">
						<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XLS_NO_LOAN_ALIAS')"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	</xsl:if>
	<xsl:if test="repaymentType[.!= ''] and repaymentType[.!= $NoLoanAlias]">
	<xsl:call-template name="fieldset-wrapper">

		<xsl:with-param name="content">	
					<xsl:variable name="cur_code"><xsl:value-of select="currency"/></xsl:variable>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">repaymentType</xsl:with-param>
						<xsl:with-param name="label">XLS_REPAYMENT_DETAILS_REPAYMENT_TYPE</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">repaymentFrequency</xsl:with-param>
						<xsl:with-param name="label">XLS_REPAYMENT_DETAILS_REPAYMENT_FREQUENCY</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						
						<xsl:with-param name="label">XLS_REPAYMENT_DETAILS_REPAYMENT_OUTSTANDING_AMT</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="utils:bigDecimalToAmountString(currentOutstandingAmt,$cur_code,$language)" /></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
			
								
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="repaymentType[.= $PrincipalPlusInterest 
		or .= $PrincipalOnly or .= $Bullet]"> 
		<xsl:call-template name="LoanRepaymentDetailsFixed-Bullet-Principle"/>

	</xsl:if>
	<xsl:if test="repaymentType[.= $FixedPayment]">
		<xsl:call-template name="LoanRepaymentDetailsFixed"/>
	</xsl:if>
	</xsl:if>

		    
</xsl:template>

<xsl:template name="LoanRepaymentDetailsFixed-Bullet-Principle">
	<!-- <xsl:call-template name="download-button1">
	  			<xsl:with-param name="label">Download File</xsl:with-param>
	  			<xsl:with-param name="divId">loanRepaymentDetailsFixedBulletPrincipleContainer</xsl:with-param>
	  			<xsl:with-param name="showcsv">Y</xsl:with-param>
	  			<xsl:with-param name="showxls">Y</xsl:with-param>
	</xsl:call-template> -->
	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
			<xsl:variable name="cur_code"><xsl:value-of select="currency"/></xsl:variable>
			<xsl:call-template name="download-button1">
	  								<xsl:with-param name="label">Download File</xsl:with-param>
	  								<xsl:with-param name="divId">loanRepaymentDetailsContainerBullet</xsl:with-param>
	  								<xsl:with-param name="showcsv">Y</xsl:with-param>
	  								<xsl:with-param name="showxls">Y</xsl:with-param>
	  		</xsl:call-template>				
					<div class="loanRepaymentDetailsFixed">
					<div id="loanRepaymentDetailsContainerBullet">
								
						<div class="clear multigrid">

		
							<script type="text/javascript">
								var loanRepaymentDetailsFixedGridLayout, pluginsData;
								dojo.ready(function(){
							    	loanRepaymentDetailsFixedGridLayout = {"cells" : [ 
							                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_CYCLE_NO')"/>", "field": "cycleNo", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_PRINCIPLE_AMT')"/>", "field": "principleAmt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_UNPAID_PRINCIPLE_AMT')"/>", "field": "unpaidPrincipleAmt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_DUE_DATE')"/>", "field": "dueDate", "width": "10%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_REMAINING_AMT')"/>", "field": "remainingAmt", "width": "10%", "styles":"text-align: right;white-space:nowrap;", "headerStyles":"white-space:nowrap;"}
							                   ]
							                  					                   
							              ]};
									pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
								});
							</script>

							<script>
								var gridData = [];
								dojo.ready(function(){
									gridData = [
											<xsl:for-each select="scheduleItems/scheduleItem">
												<xsl:variable name="loanDetails" select="."/>
												{"cycleNo" :  "<xsl:value-of select="$loanDetails/cycleNo"/>",
												"principleAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($loanDetails/principleAmt,$cur_code,$language)"/>", 
												"unpaidPrincipleAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($loanDetails/unpaidPrincipleAmt,$cur_code,$language)"/>", 
												"dueDate" :  "<xsl:value-of select="$loanDetails/dueDate"/>", 
												"remainingAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($loanDetails/remainingAmt,$cur_code,$language)"/>"}
												<xsl:if test="not(position()=last())">,</xsl:if>
											</xsl:for-each>
										];
								});
							</script>				
							<div style="width:100%;height:100%;" class="widgetContainer clear">
								<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeLoanRepaymentDetails" requestMethod="post">
							<xsl:attribute name="data">
								{"identifier":"cycleNo","label":"cycleNo","items" : gridData}
							</xsl:attribute>
								</div>
							    <table rowsPerPage="50" 
									plugins="pluginsData" 
									store="storeLoanRepaymentDetails" structure="loanRepaymentDetailsFixedGridLayout" class="grid" 
									autoHeight="true" id="gridLoanRepaymentDetails" dojoType="dojox.grid.EnhancedGrid" 
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
					</div>

				</xsl:with-param>
			</xsl:call-template>
</xsl:template>
<xsl:template name="LoanRepaymentDetailsFixed">

		<xsl:call-template name="fieldset-wrapper">
		
			<xsl:with-param name="content">
			<xsl:variable name="cur_code"><xsl:value-of select="currency"/></xsl:variable>
			<xsl:call-template name="download-button1">
	  								<xsl:with-param name="label">Download File</xsl:with-param>
	  								<xsl:with-param name="divId">loanRepaymentDetailsContainer</xsl:with-param>
	  								<xsl:with-param name="showcsv">Y</xsl:with-param>
	  								<xsl:with-param name="showxls">Y</xsl:with-param>
	  		</xsl:call-template>				
					<div class="loanRepaymentDetailsFixed">
					<div id="loanRepaymentDetailsContainer">
								
						<div class="clear multigrid">

		
							<script type="text/javascript">
								var loanRepaymentDetailsFixedGridLayout, pluginsData;
								dojo.ready(function(){
							    	loanRepaymentDetailsFixedGridLayout = {"cells" : [ 
							                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_CYCLE_NO')"/>", "field": "cycleNo", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_AMT')"/>", "field": "paymentAmt", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_INTEREST_AMT')"/>", "field": "interestAmt", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_UNPAID_INTEREST_AMT')"/>", "field": "unpaidInterestAmt", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_PRINCIPLE_AMT')"/>", "field": "principleAmt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_UNPAID_PRINCIPLE_AMT')"/>", "field": "unpaidPrincipleAmt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_DUE_DATE')"/>", "field": "dueDate", "width": "10%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_REMAINING_AMT')"/>", "field": "remainingAmt", "width": "10%", "styles":"text-align: right;white-space:nowrap;", "headerStyles":"white-space:nowrap;"}
							                   ]
							                  					                   
							              ]};
									pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
								});
							</script>

							<script>
								var gridData = [];
								dojo.ready(function(){
									gridData = [
											<xsl:for-each select="scheduleItems/scheduleItem">
												<xsl:variable name="scheduleItem" select="."/>
												{"cycleNo" :  "<xsl:value-of select="$scheduleItem/cycleNo"/>",
												"paymentAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($scheduleItem/paymentAmt,$cur_code,$language)"/>", 
												"interestAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($scheduleItem/interestAmt,$cur_code,$language)"/>", 
												"unpaidInterestAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($scheduleItem/unpaidInterestAmt,$cur_code,$language)"/>",  
												"principleAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($scheduleItem/principleAmt,$cur_code,$language)"/>", 
												"unpaidPrincipleAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($scheduleItem/unpaidPrincipleAmt,$cur_code,$language)"/>",
												"dueDate" :  "<xsl:value-of select="$scheduleItem/dueDate"/>", 
												"remainingAmt" :  "<xsl:value-of select="loanIQ:getFormatedAmount($scheduleItem/remainingAmt,$cur_code,$language)"/>"}		
												<xsl:if test="not(position()=last())">,</xsl:if>
											</xsl:for-each>
										];
								});
							</script>		
							<div style="width:100%;height:100%;" class="widgetContainer clear">
								<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeLoanRepaymentDetails" requestMethod="post">
							<xsl:attribute name="data">
								{"identifier":"cycleNo","label":"cycleNo","items" : gridData}
							</xsl:attribute>
								</div>
							    <table rowsPerPage="50" 
									plugins="pluginsData" 
									store="storeLoanRepaymentDetails" structure="loanRepaymentDetailsFixedGridLayout" class="grid" 
									autoHeight="true" id="gridLoanRepaymentDetails" dojoType="dojox.grid.EnhancedGrid" 
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
					</div>

				</xsl:with-param>
		</xsl:call-template>
</xsl:template>

    <xsl:template name="download-button1">
   		<xsl:param name="label"/>
   		<xsl:param name="divId"/>
   		<xsl:param name="showcsv">Y</xsl:param>
   		<xsl:param name="showxls">Y</xsl:param>
   		<xsl:param name="onClickFlag">Y</xsl:param> <!-- Show arrows with actions on the header or not -->
   		<div class="widgetContainer clear exportContainer">
	   		
				<xsl:call-template name="download-button-wrapper1">
			      <xsl:with-param name="label">ACTION_USER_DOWNLOAD_FILE</xsl:with-param>
			      <xsl:with-param name="show-image">Y</xsl:with-param>
			      <xsl:with-param name="show-border">Y</xsl:with-param>
			      <!-- <xsl:with-param name="id">DropDownButton</xsl:with-param> -->
			      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
			      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
			      <xsl:with-param name="divId"><xsl:value-of select="$divId"/></xsl:with-param>
		     	</xsl:call-template>
		</div>
   </xsl:template>
   
   
   <xsl:template name="download-button-wrapper1">
   <xsl:param name="label"/>
   <xsl:param name="id"/>
   <xsl:param name="divId"/>
   <xsl:param name="onclick"/>
   <xsl:param name="img-src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:param>
   <xsl:param name="img-width"></xsl:param>
   <xsl:param name="img-height"></xsl:param>
   <xsl:param name="show-text-label">Y</xsl:param>
   <xsl:param name="show-image">N</xsl:param>
   <xsl:param name="non-dijit-button">N</xsl:param>
   <xsl:param name="show-border">Y</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="dojo-attach-event"/>
   <xsl:param name="class"/>
   
   <button type="button">
    <xsl:if test="$non-dijit-button='N'"><xsl:attribute name="dojoType">dijit.form.DropDownButton</xsl:attribute></xsl:if>
    <xsl:if test="$onclick!=''"><xsl:attribute name="onclick"><xsl:value-of select="$onclick"/></xsl:attribute></xsl:if>
    <xsl:if test="$id!=''"><xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute></xsl:if>
    <xsl:if test="$disabled='Y'"><xsl:attribute name="disabled">true</xsl:attribute></xsl:if>
    <xsl:attribute name="style">float:right;</xsl:attribute>
    <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, $label)"/></xsl:attribute>
    <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, $label)"/></xsl:attribute>
    <xsl:if test="$divId='loanRepaymentDetailsContainer'">
   	<span><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DOWNLOAD_FILE')"/></span> 
    <div class="toolTipFromDropDown" style="outline: none;cursor:pointer;" dojoType="dijit.TooltipDialog">
		<div>
			<a onclick="misys.exportListToFormatInXslPdfRpmntSc('csv', true);" href="javascript:void(0);return false;">CSV</a>
			<br/>
			<a onclick="misys.exportListToFormatInXslPdfRpmntSc('xls', true); " href="javascript:void(0);return false;">Spreadsheet</a>
			<br/>
			<a onclick="misys.exportListToFormatInXslPdfRpmntSc('pdf', true); " href="javascript:void(0);return false;">PDF</a>
		</div>
    </div>
    </xsl:if>
    <xsl:if test="$divId='loanRepaymentDetailsContainerBullet'">
   	<span><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DOWNLOAD_FILE')"/></span> 
    <div class="toolTipFromDropDown" style="outline: none;cursor:pointer;" dojoType="dijit.TooltipDialog">
		<div>
			<a onclick="misys.exportListToFormatInXslPdfRpmntSc('csv', false);" href="javascript:void(0);return false;">CSV</a>
			<br/>
			<a onclick="misys.exportListToFormatInXslPdfRpmntSc('xls', false); " href="javascript:void(0);return false;">Spreadsheet</a>
			<br/>
			<a onclick="misys.exportListToFormatInXslPdfRpmntSc('pdf', true); " href="javascript:void(0);return false;">PDF</a>
		</div>
    </div>
    </xsl:if>
   </button>
  </xsl:template>
</xsl:stylesheet>
