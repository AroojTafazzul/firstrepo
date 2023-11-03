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
		xmlns:stringescapeutils="xalan://org.apache.commons.lang.StringEscapeUtils"
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
		xmlns:jetspeedresources="xalan://com.misys.portal.core.util.JetspeedResources"
		exclude-result-prefixes="localization loanIQ utils defaultresource stringescapeutils tools jetspeedresources">

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
<xsl:param name="riskTypes" />
<xsl:param name="repricingFrequencies"/>
<xsl:param name="remittanceInstructions"/>
<xsl:param name="facCurrencies"/>
<xsl:param name="operationValue"/>

<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
<xsl:param name="optionCode">OTHERS</xsl:param>
<xsl:param name="authorizerid"></xsl:param>
<xsl:param name="reviewandprint">false</xsl:param>

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
<xsl:variable name="is_legal"><xsl:value-of select="isLegalTextAccepted"/></xsl:variable>
<xsl:variable name="legal_text_value" select="loanIQ:getLegalText($language,issuing_bank/abbv_name,facility_type,'SWINGLINE')"/>
<xsl:variable name="is_legal"><xsl:value-of select="isLegalTextAccepted"/></xsl:variable>

		<script>
				dojo.ready(function(){			
					  	misys._config = misys._config || {};			
					    misys._config.legalTextEnabled = false;
									
					});
	  			</script>
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
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
				</xsl:call-template>
				
			
				<xsl:call-template name="hidden-fields" >
					<xsl:with-param name="legal_text_value"><xsl:value-of select="$legal_text_value"/></xsl:with-param>
				</xsl:call-template>>
				<xsl:call-template name="general-details" />
				<xsl:if test="bulk_ref_id[.!=''] and count(/loan_list/loan) > 0 ">
					<xsl:call-template name="linked-loan-details"/>
				</xsl:if> 
				<xsl:call-template name="loan-details-create" />
				<xsl:call-template name="remittance-instruction-details" />
	
				      <!-- comments for return -->
		      <xsl:call-template name="comments-for-return">
			  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
			   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
		   	  </xsl:call-template>
				
				<!-- Attach Files -->
    			<xsl:call-template name="attachments-file-dojo"/>
    		
				<xsl:choose>
    				<xsl:when test = "($mode = 'DRAFT' or $mode = 'UNSIGNED') and ($optionCode != 'SNAPSHOT' and $reviewandprint != 'true') and $legal_text_value != ''">
						<xsl:call-template name="legal_text_popup_template" >
							<xsl:with-param name="legal">
								<xsl:value-of select="$legal_text_value"/>
							</xsl:with-param>
						</xsl:call-template>
    				</xsl:when>
    				<xsl:otherwise>
    					<xsl:if test = "$displaymode = 'view' and legal_text_value != '' and ($optionCode = 'SNAPSHOT' or $reviewandprint = 'true') and defaultresource:getResource('DISPLAY_LEGAL_TEXT_FOR_LOAN') = 'true' and $is_legal != 'N'" >
    						<xsl:call-template name="legal_text_template" >
								<xsl:with-param name="legal">
									<xsl:value-of select="legal_text_value"/>
								</xsl:with-param>
							</xsl:call-template>
    					</xsl:if>
    				</xsl:otherwise>
    			</xsl:choose>
    			
    			<xsl:if test="$optionCode = 'SNAPSHOT' or $reviewandprint = 'true' and $is_legal != 'N'">
    				<!-- For displaying all Authorizer's name -->
	    			<xsl:call-template name="display-authorizer-name">
	    				<xsl:with-param name="list"><xsl:value-of select="authorizer_id"/></xsl:with-param>
	    			</xsl:call-template>
    			</xsl:if>
    			
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="second-menu">Y</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- real form -->
		<xsl:call-template name="realform" />
	</div>
	
	<!-- Table of Contents -->
	<xsl:call-template name="toc"/>
	
	<xsl:call-template name="reauthentication"/>
	   
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
		<xsl:with-param name="binding">misys.binding.loan.create_ln_swg</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>
		<xsl:with-param name="override-help-access-key">LN_01</xsl:with-param>
	</xsl:call-template>
	<script type="text/javascript">
		dojo.ready(function(){
			misys._config.warnFacilityAmtExceeded = {};
			misys._config.warnFacilityAmtExceeded = <xsl:value-of select="defaultresource:getResource('FACILITY_LIMIT_EXCEEDED_WARNING')" />
		});
	</script>
</xsl:template>

<!-- linked-loan-details -->
<xsl:template name="linked-loan-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LINKED_LOAN_DETAILS</xsl:with-param>
		<xsl:with-param name="content">

	       	<!-- Start : Build the Grid to show all the Linked Loans for the Repricing -->
			<div>
					<script type="text/javascript">
						var gridLayoutLinkedRepricingLoanTransactions, pluginsData;
						dojo.ready(function(){
					    	gridLayoutLinkedRepricingLoanTransactions = {"cells" : [ 
					                  [
<!-- 					                   { "noresize":"true", "name": "&nbsp;", "field": "action", "width": "3em", "styles": "text-align:center;", "headerStyles": "text-align: center", "get":misys.getLinkedLoansAction, "formatter": misys.formatLinkedLoanPreviewActions}, -->
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_REF_ID')"/>", "field": "loan_ref_id", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_BO_REF')"/>", "field": "loan_bo_ref", "width": "20%", "styles":"white-space:pre;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/>", "field": "loan_ccy", "width": "3em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_OUTSTANDING_AMT')"/>", "field": "loan_outstanding_amt", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_REPRICING_DATE')"/>", "field": "loan_repricing_date", "width": "8em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_FACILITY_NAME')"/>", "field": "loan_facility_name", "width": "15%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"}
<!-- 					                   <xsl:if test="$displaymode='edit'"> -->
<!-- 					                   		,{ "noresize":"true", "name": "&nbsp;", "field": "action", "width": "3em", "styles": "text-align:center;", "headerStyles": "text-align: center", "get":misys.getLinkedLoansAction, "formatter": misys.formatLinkedLoanDeleteActions} -->
<!-- 					                    ] -->
<!-- 					                   </xsl:if> -->
<!-- 					                   <xsl:if test="$displaymode!='edit'"> -->
					                    ]
<!-- 					                   </xsl:if> -->
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<script>
						var gridData = [];
						dojo.ready(function(){
							gridData = [
									<xsl:for-each select="loan_list/loan">
										<xsl:variable name="loan" select="."/>
										{"loan_ref_id" :  "<xsl:value-of select="$loan/loan_ref_id)"/>",  
										"loan_bo_ref" :  "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/loan_bo_ref)"/>", 
										"loan_ccy" :  "<xsl:value-of select="$loan/loan_ccy"/>", 
										"loan_outstanding_amt" :  "<xsl:value-of select="$loan/loan_outstanding_amt"/>", 
										"loan_repricing_date" :  "<xsl:value-of select="$loan/loan_repricing_date"/>",
									    "loan_facility_name" : "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/loan_facility_name))"/>"}
<!-- 									    "loan_facility_name" :  "<xsl:value-of select="$loan/loan_facility_name"/>", -->
<!-- 									    "loan_facility_id" : "<xsl:value-of select="$loan/loan_facility_id"/>"} -->
<!-- 										<xsl:if test="not(position()=last())">,</xsl:if> -->
											<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
								];
							
						});
					</script>
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeRepricingLoanTransaction" >
							<xsl:attribute name="data">
								{"identifier":"loan_ref_id","label":"loan_ref_id","items" : gridData}
							</xsl:attribute>
						</div>
						<table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeRepricingLoanTransaction" structure="gridLayoutLinkedRepricingLoanTransactions" class="grid" 
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
			<!-- End : Linked Loan Grid -->	       	
         </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- general details -->
<xsl:template name="general-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<!-- system id -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">ref_id</xsl:with-param>
				<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="bulk_ref_id[.!='']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">bulk_ref_id</xsl:with-param>
					<xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			

			<!-- bo ref id -->
			<div style="white-space:pre;">
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">bo_ref_id</xsl:with-param>
				<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				<xsl:with-param name="appendClass">loanAlias</xsl:with-param>
			</xsl:call-template>
			</div>
		
			<!-- customer reference -->
			<xsl:if test="$displaymode != 'view'">
				<xsl:call-template name="input-field">
	  				<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
					<xsl:with-param name="name">cust_ref_id</xsl:with-param>
					<xsl:with-param name="size">20</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
				</xsl:call-template>
			</xsl:if>		
		
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<xsl:call-template name="facility-details" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
						<xsl:with-param name="name">bo_deal_name</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
						<xsl:with-param name="name">bo_facility_name</xsl:with-param>
					</xsl:call-template>						
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:call-template name="borrower-details" />
			<xsl:call-template name="entity-details" />
						
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="remittance-instruction-details">
	<div class="widgetContainer">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_description_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="rem_inst_description"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_location_code_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="rem_inst_location_code"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_servicing_group_alias_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="rem_inst_servicing_group_alias"/></xsl:with-param>    
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_account_no_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="rem_inst_account_no"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">screenMode</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$mode"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">remittance_flag</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="jetspeedresources:getString('remittance.instruction.section.required')"/></xsl:with-param>
		</xsl:call-template>
	</div>
	<xsl:choose>
	 <xsl:when test="tnx_id[.!=''] and ((defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' and rem_inst_description[.= ''] and $displaymode = 'view') or
	 (defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' and rem_inst_description_view[.!= ''] and $displaymode = 'view' and $mode = 'UNSIGNED'))">
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS</xsl:with-param>
	<xsl:with-param name="content">
	<div id="remmitance_information" align="center">
		<span class="label"><xsl:value-of select="localization:getGTPString($language, 'NO_REMITTANCE_INSTRUCTION')"/></span>
	</div>
	</xsl:with-param>
	</xsl:call-template>
	</xsl:when>
	<xsl:when test="tnx_id[.!=''] and (defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' or defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='mandatory') and (($displaymode != 'view') or ($mode = 'UNSIGNED')) ">
		<div class="loanRemittanceInst">
			<!-- Header with toggle link -->
			<div class="wipeInOutTabHeader">
				<div id="actionDown" onclick="misys.toggleRemittanceInst()" style="cursor: pointer; display: block;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
				<div id="actionUp" onclick="misys.toggleRemittanceInst()" style="display: none; cursor: pointer;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
			</div>
			<div id="remittanceInstContainer">
				<div class="clear multigrid">
					<script type="text/javascript">
						var gridLayoutRemittanceInstruction, pluginsData;
						dojo.ready(function(){
							misys._config.remittanceInstructions = {} ; 
							misys._config.remittanceInstructions = <xsl:value-of select="$remittanceInstructions"/>;
					    	gridLayoutRemittanceInstruction = {"cells" : [ 
					                  [
<!-- 					                  MPSSC-11649,commenting the below columns -->					                  
<!-- 					             	{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_DESCRIPTION')"/>", "field": "description", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_CURRENCY')"/>", "field": "currency", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_ACCOUNT_NO')"/>", "field": "accountNo", "width": "35%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},					                
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_DESCRIPTION')"/>", "field": "description", "width": "45%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}

<!-- 					               	   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_PAYMENT_METHOD')"/>", "field": "paymentMethod", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_SG_ALIAS')"/>", "field": "servicingGroupAlias", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},					                    -->
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_BANK_NAME')"/>", "field": "bankName", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_ACCOUNT_NO')"/>", "field": "accountNo", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}					                 -->
					                  ] 
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<table rowsPerPage="50" 
							plugins="pluginsData" structure="gridLayoutRemittanceInstruction" class="grid" 
							autoHeight="true" id="gridRemittanceInstruction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="single" selectable="true" 
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
	</xsl:when>
	<xsl:when test="tnx_id[.!=''] and $displaymode !='edit' and (defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' or defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='mandatory') and rem_inst_description[.!= '']">
	<xsl:call-template name="saved-remittance-details">
	</xsl:call-template>
	</xsl:when> 
	</xsl:choose>
</xsl:template>



<!-- Entity Details -->
<xsl:template name="entity-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_ENTITY_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
				<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.customerReferences = {};
						<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
					});
				</script>
				<xsl:call-template name="address">
		        <xsl:with-param name="show-entity">Y</xsl:with-param>
				<xsl:with-param name="prefix">borrower</xsl:with-param>
				</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- loan details -->
<xsl:template name="loan-details-create">
<xsl:variable name="interestDetails" select="loanIQ:getInterestDetails(bo_ref_id)"/>	
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

		
    		
 			<!-- pricing option -->
			<script>
					// if pricingOptionsStore not already defined
					dojo.ready(function(){
							misys._config.pricingOptionsStore = {} ; 
							misys._config.pricingOptionsStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$pricingOptions"/>);
							misys._config.maturityMandatoryOptions = <xsl:value-of select="$pricingOptions"/>;
							misys._config.matchFundingOfPricingOption = <xsl:value-of select="$pricingOptions"/>;
						});						
			</script>
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
				
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">pricing_option</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="store">misys._config.pricingOptionsStore</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="localization:getCodeData($language,'**','LN','C030', pricing_option)" />
						</xsl:with-param>
						<xsl:with-param name="store">misys._config.pricingOptionsStore</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- loan amount -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<xsl:call-template name="row-wrapper">
					<xsl:with-param name="name">ln_amt</xsl:with-param>						
						<xsl:with-param name="label">XSL_SWINGLINE_LOAN_AMOUNT</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="content">
							<script>
								// if currenciesStore not already defined
									
								dojo.ready(function(){
						
								misys._config.currenciesStore = {} ; 
								misys._config.currenciesStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$currencies"/>);
								misys._config.facCurrencyStores = {} ;
								misys._config.facCurrencyStores = <xsl:value-of select="$facCurrencies"/>;
							
								});				
							</script>
						
				      		<div id="ln_cur_code" name="ln_cur_code" maxLength="3" required="true" trim="true" uppercase="true"
				      			  dojoType="misys.form.SortedFilteringSelect" style="width: 70px">
		      					<xsl:attribute name="value"><xsl:value-of select="ln_cur_code" /></xsl:attribute>
			      				<xsl:attribute name="store">misys._config.currenciesStore</xsl:attribute>
	 			      		</div>
	 			      		<label for = "ln_cur_code" class = "sr-only">STAR
	 			      			<xsl:value-of select="localization:getGTPString($language,'XSL_LOAN_AMOUNT')" />
	 			      		</label>
		      				<!-- <div id="tnx_amt" name="tnx_amt" required="true" trim="true"
      							 dojoType="dijit.form.CurrencyTextBox" class="small">
								<xsl:attribute name="value"><xsl:value-of select="tnx_amt" /></xsl:attribute>
								<xsl:attribute name="displayedValue"><xsl:value-of select="tnx_amt" /></xsl:attribute>
      							<xsl:attribute name="constraints">{min:0}</xsl:attribute>
      						</div> -->
      						<div id="ln_amt" name="ln_amt" required="true" trim="true" maxLength="15"
      							 dojoType="misys.form.CurrencyTextBox" class="small" >
								<xsl:attribute name="value"><xsl:value-of select="ln_amt" /></xsl:attribute>
								<xsl:attribute name="displayedValue"><xsl:value-of select="ln_amt" /></xsl:attribute>
       							<xsl:attribute name="constraints">{min:0}</xsl:attribute> 
      						</div>
      						
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
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="ln_amt[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_AMOUNT</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="ln_cur_code" />&#160;<xsl:value-of select="ln_amt" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">ln_cur_code_unsigned</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="ln_cur_code"/></xsl:with-param>
					</xsl:call-template> 
					</xsl:if>
					 <xsl:if test="fx_conversion_rate[.!=''] and fac_cur_code[.!=''] and (string(ln_cur_code)!=string(fac_cur_code))">
					 		<xsl:if test="not(tnx_id) or tnx_stat_code[.='04']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XLS_FX_RATE</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fx_conversion_rate" /></xsl:with-param>
						</xsl:call-template>
					 		</xsl:if>
					 		<xsl:if test="tnx_id [.!=''] and tnx_stat_code[.!='04']">
					 			<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_INDICATIVE_FX_RATE</xsl:with-param>
								<xsl:with-param name="value">1 <xsl:value-of select="fac_cur_code"/> = <xsl:value-of select="fx_conversion_rate"/>&#160;<xsl:value-of select="ln_cur_code" /></xsl:with-param>
							</xsl:call-template>
							<div style="font-weight:bold;margin-left:245px;font-style:italic;"><xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_NOTE')"/></div>
							</xsl:if>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- Loan Liable amount -->
			<xsl:if test="not(tnx_id) and ln_liab_amt[.!='']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="ln_cur_code" />&#160;<xsl:value-of select="ln_liab_amt" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>		

<!-- issue (effective) date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
     			<xsl:with-param name="name">effective_date</xsl:with-param>
     			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="size">10</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
    		</xsl:call-template> 
    		
    		<!-- Risk Type -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<script>
						// Define riskTypesStore, if not defined
						dojo.ready(function(){
												
							misys._config.riskTypesStore = {} ; 
							misys._config.riskTypesStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$riskTypes"/>);
						});	
					</script>
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">risk_type</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_RISK_TYPE</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="store">misys._config.riskTypesStore</xsl:with-param>
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
			
			<!-- Repricing frequency -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<script>
						// if repricingFrequenciesStores not already defined
						<!-- if (!repricingFrequenciesStores) {
							var repricingFrequenciesStores = <xsl:value-of select="$repricingFrequencies"/>;
						}	 -->	
						dojo.ready(function(){
						
							misys._config.repricingFrequenciesStores = {} ; 
							misys._config.repricingFrequenciesStores = <xsl:value-of select="$repricingFrequencies"/>;
							
						});
					</script>
					<xsl:call-template name="select-field">
					 	<xsl:with-param name="name">repricing_frequency</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
						<!-- Do not sort the repricing frequencies by id or name. Retain the server side sorting
							based on period and quantity -->
						<xsl:with-param name="sort-filter-select">N</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">repricing_frequency_view</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="repricing_frequency"/></xsl:with-param>
					</xsl:call-template> 
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="scalarOfRepricingFrequency">
						<xsl:value-of select="translate(repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','')"/>
					</xsl:variable>
					<xsl:variable name="unitOfRepricingFrequency">
						<xsl:value-of select="translate(repricing_frequency,'0123456789 ','')"/>
					</xsl:variable>
					<xsl:if test="repricing_frequency[.!='']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="concat($scalarOfRepricingFrequency, ' ', localization:getDecode($language, 'C031', $unitOfRepricingFrequency))"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>

			<!-- loan repricing date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="label">XSL_GENERALDETAILS_REPRICING_DATE</xsl:with-param>
     			<xsl:with-param name="name">repricing_date</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     		</xsl:call-template>
     					
    		<!-- loan maturity date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
     			<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     		</xsl:call-template>
     		     		
     		<!-- Loan status -->
			<xsl:if test="$displaymode = 'view'">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_LOAN_STATUS</xsl:with-param>
					<xsl:with-param name="value">
					<xsl:choose>
				 	<xsl:when test="status[.='I']">
				 		<xsl:value-of select="localization:getGTPString($language, 'STATUS_CODE_LOAN_INACTIVE_IN_PORTAL')"/>
				 	</xsl:when>
				 	
				 	<xsl:otherwise>
				 	         <xsl:value-of select="localization:getDecode($language,'N431', status)" />
				 	</xsl:otherwise>
				 </xsl:choose>
				</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="$displaymode = 'view'">
			<xsl:if test="not(tnx_id)">	
				<xsl:if test="$interestDetails[.!= '']">
				 <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_INTEREST_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">	
						
						<xsl:if test="$interestDetails/interest_cycle_frequency[.!= '']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name"></xsl:with-param>
								<xsl:with-param name="label">XLS_INTEREST_DETAILS_INTEREST_CYC_FREQUENCY</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="$interestDetails/interest_cycle_frequency" /></xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>				
			
						<!-- base_rate -->
						<xsl:if test="$interestDetails/base_rate[.!= '']">
						<xsl:call-template name="input-field">
			  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_BASE_RATE</xsl:with-param>
			  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/base_rate,$interestDetails/currency,$language)" />%</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="$interestDetails/spread[.!= '']">
							<xsl:call-template name="input-field">
				  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_SPREAD</xsl:with-param>
				  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/spread,$interestDetails/currency,$language)" />%</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="$interestDetails/rac_rate[.!= '']">
							<xsl:call-template name="input-field">
				  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_RAC_RATE</xsl:with-param>
				  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/rac_rate,$interestDetails/currency,$language)" />%</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>	
			
						<xsl:if test="$interestDetails/all_in_rate[.!= '']">
							<xsl:call-template name="input-field">
				  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_ALL_IN_RATE</xsl:with-param>
				  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/all_in_rate,$interestDetails/currency,$language)" />%</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>	
						<xsl:if test="$interestDetails/projected_interested_due[.!= '']">
										<xsl:call-template name="input-field">
							  				<xsl:with-param name="label">XLS_PROJECTED_INTERESTED_DUE</xsl:with-param>
							  				<xsl:with-param name="value"><xsl:value-of select="$interestDetails/projected_interested_due" /></xsl:with-param>
											<xsl:with-param name="override-displaymode">view</xsl:with-param>
										</xsl:call-template>	
									</xsl:if>		
						
																			
		  									
		
										<xsl:if test="$interestDetails/total_interest_amount[.!= '']">
										<xsl:call-template name="fieldset-wrapper">
											<xsl:with-param name="content">			
					
												<xsl:variable name="arrayList1" select="java:java.util.ArrayList.new()" />
												<xsl:variable name="void"
													select="java:add($arrayList1, concat('', $interestDetails/today_date))" />
												<xsl:variable name="void"
													select="java:add($arrayList1, concat('', $interestDetails/currency))" />
												<xsl:variable name="void"
													select="java:add($arrayList1, concat('', loanIQ:getFormatedAmount($interestDetails/total_interest_amount,$interestDetails/currency,$language)))" />
												<xsl:variable name="args1" select="java:toArray($arrayList1)" />
					
												<xsl:value-of
													select="localization:getFormattedString($language, 'LOAN_DETAILS_INTEREST_DUE', $args1)"
													disable-output-escaping="yes" />
					
												<!-- system id -->
												<xsl:call-template name="input-field">
													<xsl:with-param name="name">
														total_interest_Due_Amt
													</xsl:with-param>
													<xsl:with-param name="override-displaymode">
														view
													</xsl:with-param>
												</xsl:call-template>
					
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
						
								
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:if>			
<!-- 							<xsl:if test="not(tnx_id)"> -->
								<xsl:call-template name="loanInterestCycle-details" />
<!-- 							</xsl:if> -->
						</xsl:if>
			</xsl:if>
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
				<xsl:with-param name="name">option</xsl:with-param>
				<xsl:with-param name="value">LOAN_SWINGLINE</xsl:with-param>
			</xsl:call-template>	
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">TransactionData</xsl:with-param>
				<xsl:with-param name="value" />
			</xsl:call-template>
		  <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">attIds</xsl:with-param>
		       <xsl:with-param name="value"/>
     	 </xsl:call-template>
         	
     	 <xsl:call-template name="e2ee_transaction"/>
         <xsl:call-template name="reauth_params"/>
		 </div>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="hidden-fields">
	<xsl:param name="legal_text_value"></xsl:param>
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
	
		<!-- operation Value -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">operationValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$operationValue" /></xsl:with-param>						
		</xsl:call-template>
	
		<!-- facility maturity date -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">facility_maturity_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">sublimit_name</xsl:with-param>
		</xsl:call-template>
	
		<!-- appl_date -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">appl_date</xsl:with-param>
		</xsl:call-template>
		
			      <!-- access_type -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ln_access_type</xsl:with-param>
		</xsl:call-template>
		
	
		<!-- ln_amt -->	
		<!-- <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ln_amt</xsl:with-param>
		</xsl:call-template> -->
		
		<!-- ln_liab_amt -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ln_liab_amt</xsl:with-param>
		</xsl:call-template>
		
		<!-- match_funding -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">match_funding</xsl:with-param>
		</xsl:call-template>
		
		 <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code</xsl:with-param>
				<xsl:with-param name="value">SWG</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				<xsl:with-param name="value">B1</xsl:with-param>
		</xsl:call-template>
		
		<!-- effective_date_hidden_field -->
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">effective_date_hidden_field</xsl:with-param>
		</xsl:call-template>
		
		<!-- match_funding -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">borrower_limit_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">intendNoticeDayValidationEnabled</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="jetspeedresources:getString('loan.repricing.intendNoticeDays.validation.enabled')"/></xsl:with-param>						
		</xsl:call-template>
		
		<xsl:if test="$mode = 'UNSIGNED'">
			<!-- effective_date_hidden_field -->
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">effective_date_unsigned</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="effective_date" /></xsl:with-param>
			</xsl:call-template>
			
			<!-- Pricing option hidden field -->
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">pricing_option_unsigned</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="pricing_option" /></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">default_effective_date</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">authorizer_id</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select= "$authorizerid"/></xsl:with-param>
		</xsl:call-template>
			
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">legal_text_value</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select= "$legal_text_value"/></xsl:with-param>
		</xsl:call-template>
		
     </xsl:with-param>
    </xsl:call-template>
</xsl:template>


<xsl:template name="loan_interest">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_ALL_IN_RATE</xsl:with-param>
				<xsl:with-param name="name">interest_rateType</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>    
</xsl:template>


<xsl:template name="loanInterestCycle-details">

		<div class="loanInterestDetails">
			<!-- Header with toggle link -->
			<div class="wipeInOutTabHeader">
				<div id="actionDown" onclick="misys.toggleLoanInterestDetails()" style="cursor: pointer; display: block;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTEREST_CYCLE_DETAILS')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
				<div id="actionUp" onclick="misys.toggleLoanInterestDetails()" style="display: none; cursor: pointer;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTEREST_CYCLE_DETAILS')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
			</div>
			<div id="loanInterestDetailsContainer" >
				<div class="clear multigrid">

					<script type="text/javascript">
						var interestDetailsGridLayout, pluginsData;
						dojo.ready(function(){
					    	interestDetailsGridLayout = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_INTEREST_CYCLE_NO')"/>", "field": "interest_cycle", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_START_DATE')"/>", "field": "start_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_END_DATE')"/>", "field": "end_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_DUE_DATE')"/>", "field": "adjusted_due_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_PRJ_CYC_DUE')"/>", "field": "projected_cycleDue_amt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_ACCURED_TO_DATE')"/>", "field": "accrued_toDate_amt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_PAID_TO_DATE')"/>", "field": "paid_toDate_amt", "width": "10%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_BILLED_INTEREST')"/>", "field": "billed_interest_amt", "width": "10%", "styles":"text-align: right;white-space:nowrap;", "headerStyles":"white-space:nowrap;"}
					                   ]
					                  					                   
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeInterestDetails" requestMethod="post">
							<xsl:attribute name="url">								
									
										<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=loan/listdef/customer/LN/inquiryLNInterestCycleInfo.xml&amp;borefid=<xsl:value-of select='bo_ref_id'/>
									
								
							</xsl:attribute>
						</div>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeInterestDetails" structure="interestDetailsGridLayout" class="grid" 
							autoHeight="true" id="gridLoanInterestDetails" dojoType="dojox.grid.EnhancedGrid" 
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

<!-- 		</xsl:with-param> -->
<!-- 	</xsl:call-template> -->
	</div></div></div>
</xsl:template>
</xsl:stylesheet>
