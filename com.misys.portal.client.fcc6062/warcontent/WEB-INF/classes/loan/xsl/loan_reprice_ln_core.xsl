<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loaniq.LoanIQAdapter"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:stringescapeutils="xalan://org.apache.commons.lang.StringEscapeUtils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization backoffice utils stringescapeutils defaultresource">
		
<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>


<xsl:param name="facilitiesList"/>
<xsl:param name="pricingOptionsStores"/>
<xsl:param name="riskTypesStores" />
<xsl:param name="repricingFrequenciesStores"/>

<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="../../core/xsl/common/ln_common.xsl" />
<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />


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
			<xsl:with-param name="name">fakeform1</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
				</xsl:call-template>
			
				
	   			<xsl:call-template name="hidden-fields"/> 
	 			<xsl:call-template name="general-details" />
				<xsl:call-template name="linked-loan-details"/>
				<xsl:call-template name="facility-repricing-details"/>
				<xsl:call-template name="loan-details-create" /> 
				
				      <!-- comments for return -->
		      <xsl:call-template name="comments-for-return">
			  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
			   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
		   	  </xsl:call-template>
				
				<!-- Attach Files -->
				<xsl:if test="$displaymode='edit'">
    				<xsl:call-template name="attachments-file-dojo"/>
    			</xsl:if>
    			
    			<!-- Display Name of authorised user -->
				<xsl:call-template name="display-authorizer-name" />
				
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
		<xsl:with-param name="binding">misys.binding.loan.reprice_ln</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>
		<xsl:with-param name="override-help-access-key">LN_0197</xsl:with-param>
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
										{"loan_ref_id" :  "<xsl:value-of select="$loan/loan_ref_id"/>",  
										"loan_bo_ref" :  "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/loan_bo_ref)"/>", 
										"loan_ccy" :  "<xsl:value-of select="$loan/loan_ccy"/>", 
										"loan_outstanding_amt" :  "<xsl:value-of select="$loan/loan_outstanding_amt"/>", 
										"loan_repricing_date" :  "<xsl:value-of select="$loan/loan_repricing_date"/>",
									    "loan_facility_name" : "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/loan_facility_name)"/>"}
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
			</xsl:call-template>
			</div>
		
			<!-- customer reference -->
			<div style="white-space:pre;">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
				<xsl:with-param name="name">cust_ref_id</xsl:with-param>
				<xsl:with-param name="size">20</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
			</xsl:call-template>
			</div>
			
			<xsl:call-template name="borrower-details" />
			<xsl:call-template name="entity-details" />
				
		</xsl:with-param>
	</xsl:call-template>	
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

<xsl:template name="facility-repricing-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_FACILITY_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<div class="widgetContainer">
			<script>
				// if pricingOptionsStore not already defined
				dojo.ready(function(){
				
					misys._config.facilitiesStore = {} ; 
					misys._config.facilitiesStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$facilitiesList"/>);
					
					misys._config.riskTypesStores = {} ; 
					misys._config.riskTypesStores = <xsl:value-of select="$riskTypesStores"/>;
					
					misys._config.pricingOptionsStores = {} ; 
					misys._config.pricingOptionsStores = <xsl:value-of select="$pricingOptionsStores"/>;
					
					misys._config.repricingFrequenciesStores = {} ; 
					misys._config.repricingFrequenciesStores = <xsl:value-of select="$repricingFrequenciesStores"/>;
				});						
			</script>
			
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<!-- deal -->
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bo_deal_name</xsl:with-param>
					</xsl:call-template>				
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
						<xsl:with-param name="name">bo_deal_name</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bo_deal_id</xsl:with-param>
					</xsl:call-template>	
					
					<!-- facility Id-->
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">bo_facility_id</xsl:with-param>
						<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="store">misys._config.facilitiesStore</xsl:with-param>
					</xsl:call-template>
					
					<!-- facility Name -->
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bo_facility_name</xsl:with-param>
					</xsl:call-template>
					
					<div id="facilityDependentFields" style="display:none;">
						<!-- facility fcn -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FACILITYDETAILS_ID</xsl:with-param>
							<xsl:with-param name="name">fcn_view</xsl:with-param>
							<xsl:with-param name="value">""</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">fcn</xsl:with-param>
						</xsl:call-template>
						<!-- facility Name -->
						
						<!-- facility issue (effective) date -->
			   			<xsl:call-template name="input-field">
			   				<xsl:with-param name="type">date</xsl:with-param>
			     			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
			   	 			<xsl:with-param name="name">facility_effective_date_view</xsl:with-param>
			   	 			<xsl:with-param name="value">""</xsl:with-param>
			   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">facility_effective_date</xsl:with-param>
						</xsl:call-template>
			    		
			   			<!-- facility expiry date -->
			   			<xsl:call-template name="input-field">
			   				<xsl:with-param name="type">date</xsl:with-param>
			     			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
			   	 			<xsl:with-param name="name">facility_expiry_date_view</xsl:with-param>
			   	 			<xsl:with-param name="value">""</xsl:with-param>
			   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			    		</xsl:call-template>
			   			<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">facility_expiry_date</xsl:with-param>
						</xsl:call-template>
						
			   			<!-- facility maturity date -->
			   			<xsl:call-template name="input-field">
			   				<xsl:with-param name="type">date</xsl:with-param>
			     			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
			   	 			<xsl:with-param name="name">facility_maturity_date_view</xsl:with-param>
			   	 			<xsl:with-param name="value">""</xsl:with-param>
			   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			   			</xsl:call-template>
			   			<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">facility_maturity_date</xsl:with-param>
						</xsl:call-template>
			   		
						<!-- match_funding -->
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">match_funding</xsl:with-param>
						</xsl:call-template>
						
			   			<!-- borrower limit amount -->
			   			<xsl:call-template name="input-field">
			     			<xsl:with-param name="label">XSL_FACILITY_BORROWER_LIMIT</xsl:with-param>
			   	 			<xsl:with-param name="name">borrower_limit_view</xsl:with-param>
			   	 			<xsl:with-param name="value">""</xsl:with-param>
			   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			   			</xsl:call-template>
			   			<div style="display:none;">
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_FACILITY_BORROWER_LIMIT</xsl:with-param>
								<xsl:with-param name="product-code">borrower_limit</xsl:with-param>
								<xsl:with-param name="amt-readonly">Y</xsl:with-param>
		   						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
		   						<xsl:with-param name="show-button">N</xsl:with-param>
							</xsl:call-template>
						</div>
				   		<!-- borrower available to draw -->
				   		<xsl:call-template name="input-field">
			   				<xsl:with-param name="type">date</xsl:with-param>
			     			<xsl:with-param name="label">XSL_FACILITY_BORROWER_AVAILABLE</xsl:with-param>
			   	 			<xsl:with-param name="name">borrower_available_view</xsl:with-param>
			   	 			<xsl:with-param name="value">""</xsl:with-param>
			   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			   			</xsl:call-template>
			   			<div style="display:none;">
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_FACILITY_BORROWER_AVAILABLE</xsl:with-param>
								<xsl:with-param name="product-code">borrower_available</xsl:with-param>
								<xsl:with-param name="amt-readonly">Y</xsl:with-param>
		   						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
		   						<xsl:with-param name="show-button">N</xsl:with-param>
							</xsl:call-template>
						</div>
					</div>
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
			</div>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- loan details -->
<xsl:template name="loan-details-create">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		
		    <!-- application date -->
		    <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">appl_date</xsl:with-param>
			</xsl:call-template>
			
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">appl_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     			<xsl:with-param name="value" select="appl_date" />
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
    		
    		<!-- Linked loans Effective date = loan Repricing Date -->
    		<div style="display:none;">
				<xsl:call-template name="input-field">
	    			<xsl:with-param name="name">effective_date</xsl:with-param>
	    			<xsl:with-param name="type">date</xsl:with-param>
	     			<xsl:with-param name="value" select="effective_date" />
	     		</xsl:call-template>
     		</div>
			
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="name">effective_date_view</xsl:with-param>
     			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
     			<xsl:with-param name="value" select="effective_date" />
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
    		    
    		     <xsl:if test="fx_conversion_rate[.!=''] and fac_cur_code[.!=''] and (string(ln_cur_code)!=string(fac_cur_code))">
					 		<xsl:if test="not(tnx_id) or tnx_stat_code[.='04']">
						 		<xsl:call-template name="input-field">
									<xsl:with-param name="label">XLS_FX_RATE</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="fx_conversion_rate"/></xsl:with-param>
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
    		   		
			<!-- new loan outstanding amount -->
    		<xsl:call-template name="currency-field">
    			<xsl:with-param name="label">XSL_REPRICEDLOAN_OUT_AMT</xsl:with-param>
    			<xsl:with-param name="product-code">ln</xsl:with-param>
    			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
    			<xsl:with-param name="override-currency-value" select="ln_cur_code"/>
    			<xsl:with-param name="amt-readonly">Y</xsl:with-param>
    		</xsl:call-template>
    		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">ln_cur_code</xsl:with-param>
    			<xsl:with-param name="value" select="ln_cur_code"/>
			</xsl:call-template>
							
    		
    		<!-- pricing option -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">pricing_option</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">pricing_option_view</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="pricing_option"/></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="localization:getDecode($language, 'C030', pricing_option)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- Repricing frequency -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<xsl:call-template name="select-field">
					 	<xsl:with-param name="name">repricing_frequency</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">repricing_frequency_view</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="repricing_frequency"/></xsl:with-param>
						<!-- Do not sort the repricing frequencies by id or name. Retain the server side sorting
							based on period and quantity -->
						<xsl:with-param name="sort-filter-select">N</xsl:with-param>
					</xsl:call-template> 
				</xsl:when>
				<xsl:otherwise>
				  <xsl:if test="repricing_frequency[.!='']">
					<xsl:variable name="scalarOfRepricingFrequency">
						<xsl:value-of select="translate(repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','')"/>
					</xsl:variable>
					<xsl:variable name="unitOfRepricingFrequency">
						<xsl:value-of select="translate(repricing_frequency,'0123456789 ','')"/>
					</xsl:variable>
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="concat($scalarOfRepricingFrequency, ' ', localization:getDecode($language, 'C031', $unitOfRepricingFrequency))"/>
						</xsl:with-param>
					</xsl:call-template>
				  </xsl:if>
				</xsl:otherwise>
			</xsl:choose>

           <!-- Linked loans repricing date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="label">XSL_GENERALDETAILS_REPRICING_DATE</xsl:with-param>
     			<xsl:with-param name="name">repricing_date</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     		</xsl:call-template>
			     					
			<!-- Risk Type -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view'">
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">risk_type</xsl:with-param>
						<xsl:with-param name="label">XSL_LOAN_RISK_TYPE</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">risk_type_view</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="risk_type"/></xsl:with-param>
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

    		<!-- loan maturity date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
     			<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     		</xsl:call-template>
     		     		
     		<xsl:call-template name="hidden-field">    			    		
     			<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
          		</xsl:call-template>
     	     		
			
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
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
		</xsl:call-template>
		
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
</xsl:stylesheet>