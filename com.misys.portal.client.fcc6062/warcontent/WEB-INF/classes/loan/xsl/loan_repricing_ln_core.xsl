<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:loaniq="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:stringescapeutils="xalan://org.apache.commons.lang.StringEscapeUtils"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:jetspeedresources="xalan://com.misys.portal.core.util.JetspeedResources"
		exclude-result-prefixes="localization loaniq stringescapeutils utils defaultresource jetspeedresources">
		
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
<xsl:param name="facilitiesAmountList"/>
<xsl:param name="riskTypeAmountList"/>
<xsl:param name="borrowerTypeLimitAmountList"/>
<xsl:param name="currencyTypeLimitAmountList"/>
<xsl:param name="fxConversionRate"/>
<xsl:param name="maturityFacilitiesList"/>
<xsl:param name="remittanceInstructions"/>
<xsl:param name="optionCode">OTHERS</xsl:param>
<xsl:param name="authorizerid"></xsl:param>
<xsl:param name="reviewandprint">false</xsl:param>

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


<xsl:template match="/">
<!-- 	<xsl:apply-templates select="ln_tnx_record"/> -->
	<xsl:apply-templates select="bk_tnx_record"/>
</xsl:template>

  
<!-- 
  LN TNX FORM TEMPLATE.
 -->
<xsl:template match="bk_tnx_record">
 <xsl:variable name="is_legal"><xsl:value-of select="isLegalTextAccepted"/></xsl:variable> 	
 <xsl:variable name="legal_text_value" select="loaniq:getLegalText($language,issuing_bank/abbv_name,facility_type,'REPRICING')"/>
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
				<xsl:call-template name="hidden-fields">
					<xsl:with-param name="legal_text_value"><xsl:value-of select="$legal_text_value"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="general-details"/>  
				
				<xsl:call-template name="linked-loan-details"/>
				<xsl:call-template name="total-repriced-amount"/>
				<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="new-loan-optins"/>
				</xsl:if>
				<xsl:call-template name="new-loan-grid"/>
				<xsl:call-template name="total_new_epriced_amount"/>
				<xsl:call-template name="loan_increase_template"/>
				 <xsl:if test="$displaymode='edit'">
				 	
					<xsl:call-template name="adjust-amount-options"/>
				</xsl:if>
				
				<xsl:call-template name="remittance-instruction-details"/>
				
				<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="interest-payment"/>
				</xsl:if>
				<xsl:if test="$displaymode!='edit'">
					<xsl:call-template name="repricing-view-fields"/>
				</xsl:if>

				<xsl:if test="$displaymode!='edit'">	
					<xsl:if test="interest_payment[.='Y']">		
<!-- 						<xsl:if test="loan_interest_list/loans[.!= '']"> -->
							<xsl:call-template name="saved-interest-payment"/>
<!-- 						</xsl:if> -->
					</xsl:if>
				</xsl:if>
				
				<xsl:if test="$displaymode ='edit'">
					<xsl:call-template name="settle-borrower-net" />	
				</xsl:if>	
				
				<!-- Attach Files -->
    			<xsl:call-template name="attachments-file-dojo"/>
				
			  <!-- comments for return -->
		      <xsl:call-template name="comments-for-return">
			  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
			   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
		   	  </xsl:call-template>

<!-- 				<xsl:call-template name="entity-details" />			 -->
                <xsl:if test="$displaymode ='edit' or ( $displaymode !='edit' and free_format_text !='')">
				 <xsl:call-template name="free-format-message" />
				</xsl:if>
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
 
 
<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
		<xsl:with-param name="binding">misys.binding.loan.repricing_ln</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>
		<xsl:with-param name="override-help-access-key">LN_0197</xsl:with-param>		
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
			<div style="white-space:pre;">
				<xsl:call-template name="input-field">
		    		<xsl:with-param name="name">borrower_reference</xsl:with-param>
		     		<xsl:with-param name="label">XSL_LOAN_BORROWER_REFERENCE</xsl:with-param>
		     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
		     		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(loan_list/loan/loan_borrower_reference)"/></xsl:with-param>
	    		</xsl:call-template>
			</div>
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">deal</xsl:with-param>
				<xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
				<xsl:with-param name="value" select="loan_list/loan/loan_deal_name" />
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">entityName</xsl:with-param>
				<xsl:with-param name="label">XLS_LOAN_DETAILS_ENTITY</xsl:with-param>
				<xsl:with-param name="value" select="loan_list/loan/entity" />
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<!-- application date -->

			<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">appl_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     			<xsl:with-param name="value" select="appl_date" />
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
			<xsl:call-template name="borrower-details" />
			
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- linked-loan-details -->
<xsl:template name="linked-loan-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_REPRICED</xsl:with-param>
		<xsl:with-param name="content">
		
		<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">entity_check</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="entity_presence" /></xsl:with-param>						
					</xsl:call-template>
		
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
						
						misys._config.facilityAvailableAmountStore = {} ; 
					    misys._config.facilityAvailableAmountStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$facilitiesAmountList"/>);
					    
					    misys._config.riskTypeLimitStore = {} ; 
					    misys._config.riskTypeLimitStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$riskTypeAmountList"/>);
					    
					    misys._config.borrowerTypeLimitStore = {} ; 
					    misys._config.borrowerTypeLimitStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$borrowerTypeLimitAmountList"/>);
					    
					    misys._config.currencyTypeLimitStore = {} ; 
					    misys._config.currencyTypeLimitStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$currencyTypeLimitAmountList"/>);
					    
					   <xsl:if test="$maturityFacilitiesList != ''"> 
					    misys._config.MaturedFacilityStore = {} ; 
					    misys._config.MaturedFacilityStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$maturityFacilitiesList"/>);
					    </xsl:if>
					    
				
					});						
				</script>
		
	       	<!-- Start : Build the Grid to show all the Linked Loans for the Repricing -->
			<div>
					<script type="text/javascript">
						var gridLayoutLinkedRepricingLoanTransactions, pluginsData;
						dojo.ready(function(){
					    	gridLayoutLinkedRepricingLoanTransactions = {"cells" : [ 
					                  [
					                  
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "loan_ref_id", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_DETAILS_ENTITY')"/>", "field": "entity", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
<!--                                      <xsl:if test="entity_presence[.= 'Y']"> -->
                                    
<!-- 					                   		 { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_DETAILS_ENTITY')"/>", "field": "entity", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, --> 
					                    
<!-- 					                   </xsl:if> -->
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_DETAILS_DEAL')"/>", "field": "loan_deal_name", "width": "15em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_FAC_NAME')"/>", "field": "loan_facility_name", "width": "20%", "styles":"text-align: centre;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_FACILITY_CURRENCY')"/>", "field": "fac_cur_code", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPRICE_GRID_HEADER_LOAN_ALIAS')"/>", "field": "loan_bo_ref", "width": "10em", "styles":"text-align: center;white-space:pre;", "headerStyles":"white-space:nowrap;"},
					                  
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CUST_REFERENCE')"/>", "field": "loan_cust_ref_id", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:pre;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_LOAN_PRICING_OPTION')"/>", "field": "loan_pricing_option", "width": "11%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/>", "field": "loan_ccy", "width": "3em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURRENT_OUTSTANDING_AMT')"/>", "field": "loan_current_amt", "width": "8em", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                    { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_FX_RATE')"/>", "field": "fx_conversion_rate", "width": "10em", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_EFFECTIVE_DATE')"/>", "field": "loan_effective_date", "width": "6em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_REPRICING_FREQUENCY')"/>", "field": "loan_repricing_frequency", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_REPRICING_DATE')"/>", "field": "loan_repricing_date", "width": "6em", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"}				                   
					                    
					                     <xsl:if test="loan_list/loan/status[.!= 'A']"> 
					                     ,{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LOAN_STATUS')"/>", "field": "loan_status", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"}
					                     
					                     </xsl:if>
					                    
					                    
					                   		,{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SHOW_INTEREST_DUE_AMT')"/>", "field": "action", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "get":misys.getLinkedLoansInterestDetailsAction, "formatter": misys.formatLinkedLoanInterestDetailsPreviewActions}
					                    ]
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
										"loan_deal_name" :  "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/loan_deal_name)"/>", 
										"loan_ccy" :  "<xsl:value-of select="$loan/loan_ccy"/>", 
										"entity" :  "<xsl:value-of select="$loan/entity"/>", 
										"loan_cust_ref_id" :  "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/loan_cust_ref_id)"/>", 
										
										"loan_outstanding_amt" :  "<xsl:value-of select="$loan/loan_outstanding_amt"/>", 
										"loan_repricing_date" :  "<xsl:value-of select="$loan/loan_repricing_date"/>",
										"loan_effective_date" :  "<xsl:value-of select="$loan/loan_effective_date"/>",	
										"loan_repricing_frequency" :  "<xsl:value-of select="concat(translate($loan/loan_repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','') ,' ', localization:getDecode($language, 'C031', translate($loan/loan_repricing_frequency,'0123456789 ','')))"/>",
										"loan_pricing_option" :  "<xsl:value-of select="localization:getCodeData($language,'**','LN','C030', $loan/loan_pricing_option)" />",																											
										"loan_current_amt" :  "<xsl:value-of select="loaniq:getFormatedAmount($loan/loan_current_amt,$loan/loan_ccy,$language)"/>",
										"loan_status" :  "<xsl:value-of select="localization:getDecode($language, 'N431', $loan/status)"/>",
										"loan_facility_id" :  "<xsl:value-of select="$loan/loan_facility_id"/>", 
										"fac_cur_code" :  "<xsl:value-of select="$loan/fac_cur_code"/>", 
										"fx_conversion_rate" :  "<xsl:value-of select="loaniq:formatFXConversionRateValues($loan/fx_conversion_rate,$language)"/>", 
									    "loan_facility_name" : "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/loan_facility_name)"/>"}
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
</xsl:template >

			

<!-- total-repriced-amount -->
<xsl:template name="total-repriced-amount">
   <xsl:variable name="repricingLnAmt" select="sum(loan_list//loan_current_amt)" />
 	
<div class="repricing-amt" style="text-align: right" >	
   <xsl:call-template name="fieldset-wrapper">   
   		<xsl:with-param name="content">   
   		       
	   		<xsl:if test="$displaymode='edit'"> 
	                    <xsl:call-template name="row-wrapper">
							<xsl:with-param name="label">XSL_REPRICING_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="content">			
						
	 							<xsl:value-of select="loan_list/loan/loan_ccy" />&#160;
	      						<div id="total_repricing_ln_amt" name="total_repricing_ln_amt" required="true" trim="true"
	      							 dojoType="dijit.form.CurrencyTextBox" class="small" disabled="true">
									<xsl:attribute name="value">0</xsl:attribute>
									<xsl:attribute name="displayedValue"></xsl:attribute>
	      							<xsl:attribute name="constraints">{min:0}</xsl:attribute>
	      							<xsl:attribute name="amt-readonly">Y</xsl:attribute> 
	      						</div>      				
							</xsl:with-param>						
				         </xsl:call-template>
				</xsl:if>	
			         
			       <xsl:if test="$displaymode !='edit'">
		                 <xsl:if test="number($repricingLnAmt) &gt; 0">
								<xsl:call-template name="input-field">
										 <xsl:with-param name="label">XSL_REPRICING_TOTAL_AMOUNT</xsl:with-param>
		<!-- 								 <xsl:with-param name="class">repricing-amt</xsl:with-param> -->
										 <xsl:with-param name="value"> 
										 <xsl:value-of select="loan_list/loan/loan_ccy" />&#160; <xsl:value-of select="loaniq:getFormatedAmount($repricingLnAmt,loan_list/loan/loan_ccy,$language)"/>
										 </xsl:with-param>
										 <xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
		              
							</xsl:if>
					</xsl:if>
				
				
						<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">deal_name</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="loan_list/loan/loan_deal_name" /></xsl:with-param>						
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bo_deal_name</xsl:with-param>
						
					</xsl:call-template>				
						
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bo_deal_id</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="loan_list/loan/loan_deal_id" /></xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">fxConversionRate</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="$fxConversionRate" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">fac_cur_code</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="loan_list/loan/fac_cur_code" /></xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">loan_cust_ref_id</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">entity</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="loan_list/loan/entity" /></xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">loan_ccy</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bk_cur_code</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="loan_list/loan/loan_ccy" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">recent_repricing_date</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bk_total_amt</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">borrower_reference_validation</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="borrower_reference" /></xsl:with-param>
					</xsl:call-template>
			</xsl:with-param>
   </xsl:call-template>
   </div>
   </xsl:template>
   
<!--    new-loan-optins -->
   <xsl:template name="new-loan-optins">
   <div style="text-align: right">	
   <xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="content">
   		
		<xsl:call-template name="button-wrapper">
			<xsl:with-param name="label">ADDLOAN</xsl:with-param>
			<xsl:with-param name="id">addLoan</xsl:with-param>
			<xsl:with-param name="class">downloadPDF</xsl:with-param>
			<xsl:with-param name="onclick">misys.addNewLoanForRepricing();</xsl:with-param>
			<xsl:with-param name="show-text-label">Y</xsl:with-param>
		</xsl:call-template>
   	</xsl:with-param>
   </xsl:call-template>
   </div>
</xsl:template>


<!--    new-loan-optins -->
   <xsl:template name="repricing-view-fields">
   <div class="repricing-amt" style="text-align: left">	
   <xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="content">
   		<xsl:if test="total_principal_amt[.!= '']">	   		
			<xsl:call-template name="input-field">
					 <xsl:with-param name="label">XSL_REPRICING_TOTAL_PRINCIPAL_PAYMENT_AMOUNT</xsl:with-param>
					 <xsl:with-param name="value"> 
					 <xsl:value-of select="loan_list/loan/loan_ccy" />&#160; <xsl:value-of select="loaniq:getFormatedAmount(total_principal_amt,loan_list/loan/loan_ccy,$language)"/>
					 </xsl:with-param>
					 <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="borrower_settlement_ind[.!= '']">	
			<xsl:call-template name="input-field">
					 <xsl:with-param name="label">XSL_PDF_BORROWER_SETTLEMENT_LABEL</xsl:with-param>
					 <xsl:with-param name="value">
					 			<xsl:if test="borrower_settlement_ind[.='Y']">
							    	<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_BORROWER_SETTLEMENT_YES')"/>
							   </xsl:if>
							   <xsl:if test="borrower_settlement_ind[.!='Y']">
							    	<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_BORROWER_SETTLEMENT_NO')"/>
							   </xsl:if>
					 </xsl:with-param>
					 <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
						
   	</xsl:with-param>
   </xsl:call-template>
   </div>
</xsl:template>

<!--    new-loan-grid -->
   <xsl:template name="new-loan-grid">
   
   <xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_NEW_LOAN_LABEL</xsl:with-param>
		<xsl:with-param name="content">

   <xsl:if test="$displaymode='edit'">
         <xsl:if test="loan_list/loan/loan_ccy != loan_list/loan/fac_cur_code"> 
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">fx_Conversion_rate</xsl:with-param>
				<xsl:with-param name="label">XSL_INDICATIVE_FX_RATE</xsl:with-param>
				<xsl:with-param name="value">1 <xsl:value-of select="loan_list/loan/fac_cur_code"/> = <xsl:value-of select="$fxConversionRate"/>&#160;<xsl:value-of select="loan_list/loan/loan_ccy"/></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>   
       </xsl:if>

	</xsl:if>
	
      <xsl:if test="loan_list/loan/fac_cur_code [.!= ''] and (loan_list/loan/loan_ccy != loan_list/loan/fac_cur_code) and $displaymode !='edit'">
      	 <xsl:choose>
      	 	<xsl:when test="not(tnx_id) or tnx_stat_code[.='04']"> 
      	 		<xsl:call-template name="input-field">
					<xsl:with-param name="label">LN_FX_RATE</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="product_file_set/ln_tnx_record/fx_conversion_rate"/></xsl:with-param>
				</xsl:call-template>
      	 	</xsl:when>
      	 	<xsl:otherwise>
      		<xsl:call-template name="input-field">
				<xsl:with-param name="name">fx_Conversion_rate</xsl:with-param>
					<xsl:with-param name="label">XSL_INDICATIVE_FX_RATE</xsl:with-param>
					<xsl:with-param name="value">1 <xsl:value-of select="product_file_set/ln_tnx_record/fac_cur_code"/> = <xsl:value-of select="product_file_set/ln_tnx_record/fx_conversion_rate"/>&#160;<xsl:value-of select="product_file_set/ln_tnx_record/ln_cur_code"/></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
      	 	</xsl:otherwise>
      	 </xsl:choose>
		</xsl:if>
	       	<!-- Start : Build the Grid to show all the Linked Loans for the Repricing -->
			<div>
					
					<script type="text/javascript">
						var gridLayoutNewRepricingLoanTransactions, newLoanPluginsData;
						dojo.ready(function(){
					    	gridLayoutNewRepricingLoanTransactions = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_REF_ID')"/>", "field": "new_loan_ref_id", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  
					                   <xsl:if test="product_file_set/ln_tnx_record/bo_ref_id[.!= '']"> 
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPRICE_GRID_HEADER_LOAN_ALIAS')"/>", "field": "new_loan_alias", "width": "10em", "styles":"text-align: center;white-space:pre;", "headerStyles":"white-space:nowrap;"},
					                   </xsl:if>

<!-- 										  <xsl:if test="entity_presence[.= 'Y']"> -->
<!-- 					                   		 { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_DETAILS_ENTITY')"/>", "field": "entity", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
					                
<!-- 					                     </xsl:if>				 -->
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_DETAILS_DEAL')"/>", "field": "new_loan_deal_name", "width": "20em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}, -->
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_FAC_NAME')"/>", "field": "new_loan_facility_name", "width": "20%", "styles":"text-align: left;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CUST_REFERENCE')"/>", "field": "new_loan_our_ref", "width": "8%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_LOAN_PRICING_OPTION')"/>", "field": "new_loan_pricing_option_disp", "width": "11%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/>", "field": "new_loan_ccy", "width": "3em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_NEW_OUTSTANDING_AMT')"/>", "field": "new_loan_outstanding_amt_disp", "width": "10em", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_EFFECTIVE_DATE')"/>", "field": "new_loan_effective_date", "width": "6em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_MATURITY_DATE')"/>", "field": "new_loan_maturity_date", "width": "6em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_REPRICING_FREQUENCY')"/>", "field": "new_loan_repricing_frequency", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_REPRICING_DATE')"/>", "field": "new_loan_repricing_date", "width": "6em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}
					                   <xsl:if test="$displaymode='edit'">
					                   		,{ "noresize":"true", "name": "&nbsp;", "field": "action", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "get":misys.getRepricedNewLoansAction, "formatter": misys.newRepricingLoanFormatActions}
					                    ]
					                   </xsl:if>
					                   <xsl:if test="$displaymode!='edit'">
					                    ]
					                   </xsl:if>
					              ]};
							newLoanPluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<script>
						var gridNewLoansData = [];
						dojo.ready(function(){
							gridNewLoansData = [
									<xsl:for-each select="product_file_set/ln_tnx_record">
										<xsl:variable name="loan" select="."/>
										{"new_loan_ref_id" :  "<xsl:value-of select="$loan/ref_id"/>",  
										"new_loan_tnx_id" :  "<xsl:value-of select="$loan/tnx_id"/>", 
										"new_loan_deal_name" :  "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/bo_deal_name)"/>",
										"new_loan_deal_id" :  "<xsl:value-of select="$loan/bo_deal_id"/>", 
										"new_loan_ccy" :  "<xsl:value-of select="$loan/ln_cur_code"/>", 
										"new_loan_entity" :  "<xsl:value-of select="$loan/entity"/>",
										"new_loan_alias" :  "<xsl:value-of select="$loan/bo_ref_id"/>", 
										"new_loan_our_ref":"<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/cust_ref_id)"/>",
										"new_loan_outstanding_amt" :  "<xsl:value-of select="$loan/ln_amt"/>", 
										"new_loan_outstanding_amt_disp" : "<xsl:value-of select="loaniq:getFormatedAmount($loan/ln_amt,$loan/ln_cur_code,$language)"/>",
										"new_loan_repricing_date" :  "<xsl:value-of select="$loan/repricing_date"/>",
										"new_loan_effective_date" :  "<xsl:value-of select="$loan/effective_date"/>",
										"new_loan_maturity_date" :  "<xsl:value-of select="$loan/ln_maturity_date"/>",
										"new_loan_repricing_frequency" :  "<xsl:value-of select="concat(translate($loan/repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','') ,' ', localization:getDecode($language, 'C031', translate($loan/repricing_frequency,'0123456789 ','')))"/>",
										"new_loan_pricing_option" :  "<xsl:value-of select="$loan/pricing_option"/>",
										"new_loan_pricing_option_disp" :  "<xsl:value-of select="localization:getCodeData($language,'**','LN','C030', $loan/pricing_option)" />",	
										"new_loan_facility_id" :  "<xsl:value-of select="$loan/bo_facility_id"/>",	
										"new_loan_repricing_frequency_id" :  "<xsl:value-of select="$loan/repricing_frequency"/>",	
										"new_loan_borrower_reference" :  "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/borrower_reference)"/>",
										"new_loan_fcn" :  "<xsl:value-of select="$loan/fcn"/>",	
										"new_loan_matchFunding":"<xsl:value-of select="$loan/match_funding"/>",
										"new_loan_risk_type" :  "<xsl:value-of select="$loan/risk_type"/>",	
										"new_fx_conversion_rate" :  "<xsl:value-of select="$loan/fx_conversion_rate"/>",	
										"new_fac_cur_code" :  "<xsl:value-of select="$loan/fac_cur_code"/>",										
									    "new_loan_facility_name" : "<xsl:value-of select="stringescapeutils:escapeJavaScript($loan/bo_facility_name)"/>"}
										<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
								];
							
						});
					</script>
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeNewLoanRepricingTransaction" >
							<xsl:attribute name="data">
								{"identifier":"new_loan_ref_id","label":"new_loan_ref_id","items" : gridNewLoansData}
							</xsl:attribute>
						</div>
						<table rowsPerPage="50" 
							plugins="newLoanPluginsData" 
							store="storeNewLoanRepricingTransaction" structure="gridLayoutNewRepricingLoanTransactions" class="grid" 
							autoHeight="true" id="gridNewLoanRepricingTransactions" dojoType="dojox.grid.EnhancedGrid" 
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

<xsl:template name="remittance-instruction-details">
	<div class="widgetContainer">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_description_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_description"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_location_code_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_location_code"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_servicing_group_alias_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_servicing_group_alias"/></xsl:with-param>    
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rem_inst_account_no_view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_account_no"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">screenMode</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$mode"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">remittance_flag</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')"/></xsl:with-param>
		</xsl:call-template>
	</div>
	<xsl:choose>
	 <xsl:when test="tnx_id[.!=''] and ((defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='true' and product_file_set/ln_tnx_record/rem_inst_description[.= ''] and $displaymode = 'view') or
	 	(defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='true' and rem_inst_description_view[.!= ''] and $displaymode = 'view' and $mode = 'UNSIGNED'))">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<div id="remmitance_information" align="center">
					<span class="label"><xsl:value-of select="localization:getGTPString($language, 'NO_REMITTANCE_INSTRUCTION')"/></span>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="tnx_id[.!=''] and (defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='true' or defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='mandatory') and (($displaymode != 'view') or ($mode = 'UNSIGNED')) ">
		<div class="loanRemittanceInst" id = "remittance_inst_section" style="display:block">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS</xsl:with-param>
	 			<xsl:with-param name="content">
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
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_CURRENCY')"/>", "field": "currency", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_ACCOUNT_NO')"/>", "field": "accountNo", "width": "35%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},					                
							                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_DESCRIPTION')"/>", "field": "description", "width": "45%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}
							                  ] 
							              ]};
									pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
								});
							</script>
				
							<div style="width:100%;height:100%;" class="widgetContainer clear">
								<table rowsPerPage="50" 
									plugins="pluginsData" structure="gridLayoutRemittanceInstruction" class="grid"
									canSort="misys.grid.noSortOnAllColumns"
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
				</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:when>
	<xsl:when test="tnx_id[.!=''] and $displaymode !='edit' and (defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='true' or defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='mandatory') and product_file_set/ln_tnx_record/rem_inst_description[.!= '']">
	<xsl:call-template name="saved-repricing-remittance-details">
	</xsl:call-template>
	</xsl:when> 
	</xsl:choose>
</xsl:template>

<xsl:template name="total_new_epriced_amount">
   <xsl:variable name="repricingNewLnAmt" select="translate(bk_total_amt, ',' ,'')"/>
<div class="repricing-amt" style="text-align: right">	
			           <xsl:call-template name="fieldset-wrapper">
					   		<xsl:with-param name="content">  
					   		<xsl:if test="$displaymode ='edit'">
					         			<xsl:call-template name="row-wrapper">
											<xsl:with-param name="label">XSL_REPRICING_TOTAL_NEW_LOAN_AMOUNT</xsl:with-param>
											<xsl:with-param name="content">		
												
					 							<xsl:value-of select="loan_list/loan/loan_ccy" />&#160;
					      						<div id="total_ln_amt" name="total_ln_amt" required="true" trim="true"
					      							 dojoType="dijit.form.CurrencyTextBox" class="small" disabled="true">
													<xsl:attribute name="value">0</xsl:attribute>
													<xsl:attribute name="displayedValue"></xsl:attribute>
					      							<xsl:attribute name="constraints">{min:0}</xsl:attribute>
					      							<xsl:attribute name="amt-readonly">Y</xsl:attribute>     							
					      							
					      						</div>
											</xsl:with-param>
										</xsl:call-template>
								</xsl:if>		
										
					<xsl:if test="$displaymode !='edit'">
						<xsl:call-template name="input-field">
								 <xsl:with-param name="label">XSL_REPRICING_TOTAL_NEW_LOAN_AMOUNT</xsl:with-param>
								 <xsl:with-param name="value"> 
								 <xsl:value-of select="loan_list/loan/loan_ccy" />&#160; <xsl:value-of select="loaniq:getFormatedAmount($repricingNewLnAmt,loan_list/loan/loan_ccy,$language)"/>
								 </xsl:with-param>
								 <xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
										
							</xsl:with-param>
					</xsl:call-template>
	</div>
</xsl:template>

<!--   adjust-amount-options -->
   <xsl:template name="adjust-amount-options">
	<div class="repricing-amt" style="display:inline">
         <xsl:call-template name="fieldset-wrapper">
               <xsl:with-param name="content">  
				<div class="loan-repricing-interest-details">
				<div style="float:left">
					 <xsl:call-template name="checkbox-field">
						 <xsl:with-param name="label">XSL_REPRICING_ADJUST_REMAINING_AMOUNT_OPTIONS</xsl:with-param>
						<xsl:with-param name="name">adjust_amount_option</xsl:with-param>
						<xsl:with-param name="id">adjust_amount_option</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="adjust_payment_options"/></xsl:with-param>
						<xsl:with-param name="checked"><xsl:value-of select="adjust_payment_options"/></xsl:with-param>
					 </xsl:call-template>
					 </div>
				</div>
				<div style="float:left">
					  <xsl:call-template name="row-wrapper">
											<xsl:with-param name="label">XSL_REPRICING_TOTAL_PRINCIPAL_PAYMENT_AMOUNT</xsl:with-param>
											<xsl:with-param name="content">			
												
					 							<xsl:value-of select="loan_list/loan/loan_ccy" />&#160;
					      						<div id="total_principal_amt" name="total_principal_amt" required="true" trim="true"
					      							 dojoType="dijit.form.CurrencyTextBox" class="small" disabled="true">
													<xsl:attribute name="value">0</xsl:attribute>
													<xsl:attribute name="displayedValue"></xsl:attribute>
					      							<xsl:attribute name="constraints">{min:0}</xsl:attribute>
					      							<xsl:attribute name="amt-readonly">Y</xsl:attribute>     							
					      							
					      						</div>
											</xsl:with-param>
							</xsl:call-template>
				
				 </div> 
				   
           </xsl:with-param>
           
        </xsl:call-template>
</div>
    </xsl:template>
    
     <!-- interest-payment -->
    <xsl:template name="interest-payment">
  		<xsl:call-template name="fieldset-wrapper">
 			<xsl:with-param name="content">
 			
 			<xsl:if test="$displaymode='edit'">
 			<xsl:choose>
      	 	   <xsl:when test="defaultresource:getResource('LOAN_INTEREST_PAYMENT_ALLOWED_REPRICING')='true'"> 
      	 	   <div id="loan-repricing-interest-details-checkbox">
	 			     <xsl:call-template name="checkbox-field">
								<xsl:with-param name="label">XSL_ADD_INTEREST_PAYMENT_LABEL</xsl:with-param>
								<xsl:with-param name="name">interest_payment</xsl:with-param>
								<xsl:with-param name="id">interest_payment</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="interest_payment"/></xsl:with-param>
								<xsl:with-param name="checked"><xsl:value-of select="interest_payment"/></xsl:with-param>
							</xsl:call-template>
				</div>
				 	<h2><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_INTEREST_PAYMENT_LABEL')"/></h2>
				
      	 	   </xsl:when>
      	 	   <xsl:otherwise>
	 			<div class="loan-repricing-interest-details">
	 			<xsl:call-template name="checkbox-field">
								<xsl:with-param name="label">XSL_ADD_INTEREST_PAYMENT_LABEL</xsl:with-param>
								<xsl:with-param name="name">interest_payment</xsl:with-param>
								<xsl:with-param name="id">interest_payment</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="interest_payment"/></xsl:with-param>
								<xsl:with-param name="checked"><xsl:value-of select="interest_payment"/></xsl:with-param>
							</xsl:call-template>
				</div>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="$displaymode!='edit'">
				<h2><xsl:value-of select="localization:getGTPString($language, 'XSL_INTEREST_PAYEMENT_GRID_HEADER_LABEL')"/></h2>
			</xsl:if>
					<div>
					<script type="text/javascript">
						var gridLayoutInterestDetailsLoanTransactions, interestDetailsPluginsData;
						dojo.ready(function(){
					    	gridLayoutInterestPaymentTransactions = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPRICE_GRID_HEADER_LOAN_ALIAS')"/>", "field": "loan_alias", "width": "25%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/>", "field": "currency", "width": "5%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_TOTAL_INTEREST_DUE_GRID_LABEL')"/>", "field": "totalProjectedEOCamt_fmt", "width": "40em", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"}
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_INTEREST_PAYEMENT_GRID_HEADER_LABEL')"/>", "field": "total_payment_amt", "width": "40em", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;"} -->
					                   
					                    ]
					              ]};
							interestDetailsPluginsData = {indirectSelection: {headerSelector: "true",width: "20px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<script>
						var gridInterestDetailsData = [];
						dojo.ready(function(){
							gridInterestDetailsData = [
							<xsl:for-each select="loan_interest_list/loans/loan">
										<xsl:variable name="loan" select="."/>
										{"loan_alias" :  "<xsl:value-of select="$loan/alias"/>",  
										"currency" :  "<xsl:value-of select="$loan/currency"/>", 
<!-- 										"cycleStartDate" :  "2016-06-29", -->
										"cycleStartDate" :  "<xsl:value-of select="$loan/current_cycle_start_date"/>",  
										"total_interested_due_amt_fmt" :  "<xsl:value-of select="loaniq:getFormatedAmount($loan/total_interest_amount,$loan/currency,$language)"/>", 
										"total_interested_due_amt" :  "<xsl:value-of select="$loan/total_interest_amount"/>",
										"totalProjectedEOCamt_fmt" :  "<xsl:value-of select="loaniq:getFormatedAmount($loan/totalProjectedEOCamt,$loan/currency,$language)"/>", 
										"totalProjectedEOCamt" :  "<xsl:value-of select="$loan/totalProjectedEOCamt"/>"
										}
										<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
								];
							
						});
					</script>
					<div style="width:100%;height:100%" class="widgetContainer clear" id="loanInterestDetailsGrid">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeInterestDetailsRepricingTransaction" >
							<xsl:attribute name="data">
								{"identifier":"loan_alias","label":"loan_alias","items" : gridInterestDetailsData}
							</xsl:attribute>
						</div>
			<xsl:choose>
      	 	   <xsl:when test="defaultresource:getResource('LOAN_INTEREST_PAYMENT_ALLOWED_REPRICING')='true'">
						<table rowsPerPage="50" 
							plugins="interestDetailsPluginsData" 
							store="storeInterestDetailsRepricingTransaction" structure="gridLayoutInterestPaymentTransactions" class="grid" 
							autoHeight="true" id="gridLayoutInterestDetailsLoanTransactions" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="multiple" selectable="true" 
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
						</xsl:when>
						<xsl:otherwise>
							<table rowsPerPage="50" 
								plugins="interestDetailsPluginsData" 
								store="storeInterestDetailsRepricingTransaction" structure="gridLayoutInterestPaymentTransactions" class="grid" 
								autoHeight="true" id="gridLayoutInterestDetailsLoanTransactions" dojoType="dojox.grid.EnhancedGrid" 
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
						</xsl:otherwise>
						</xsl:choose>
						<div class="clear" style="height:1px">&nbsp;</div>
						
					</div>
				</div>
				</xsl:with-param>
		</xsl:call-template>
    </xsl:template>

    <!-- interest-payment -->
    <xsl:template name="saved-interest-payment">
  		<xsl:call-template name="fieldset-wrapper">
 			<xsl:with-param name="content">
				<h2><xsl:value-of select="localization:getGTPString($language, 'XSL_INTEREST_PAYEMENT_GRID_HEADER_LABEL')"/></h2>

					<div>
					<script type="text/javascript">
						var gridLayoutSavedIntDetailsLoanTransactions, interestDetailsPluginsData;
						dojo.ready(function(){
					    	gridLayoutSavedIntDetailsLoanTransactions = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_REPRICE_GRID_HEADER_LOAN_ALIAS')"/>", "field": "loan_alias", "width": "25%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/>", "field": "currency", "width": "5%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_PRJ_CYC_DUE')"/>", "field": "total_interested_due_amt_fmt", "width": "40em", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"}
					                   
					                    ]
					              ]};
							savedIntDetailsPluginsData = {indirectSelection: {headerSelector: "true",width: "20px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<script>
						var gridInterestDetailsData = [];
						dojo.ready(function(){
							gridInterestDetailsData = [
									<xsl:for-each select="loan_list/loan">
									     <xsl:variable name="loan" select="."/>
									       <xsl:variable name="loanAlias" select="$loan/loan_bo_ref"/>
									    <xsl:if test="../../interest_due_amts/interestDueAmt [loan_alias = $loanAlias]/value!='' ">									   
									    <xsl:variable name="position" select="position()" />
									     <xsl:variable name="intAmtVal" select="../../interest_due_amts/interestDueAmt [loan_alias = $loanAlias]/value"/>
									     {
									          "loan_alias" :  "<xsl:value-of select="$loan/loan_bo_ref"/>",  
									          "currency" :  "<xsl:value-of select="$loan/loan_ccy"/>", 
									          "total_interested_due_amt_fmt" :  "<xsl:value-of select="$intAmtVal"/>", 
									          "total_interested_due_amt" :  "<xsl:value-of select="$intAmtVal"/>"
									     }    
									     <xsl:if test="not(position()=last())">,</xsl:if>
									     </xsl:if>
									</xsl:for-each>
								];
							
						});
					</script>
					<div style="width:100%;height:100%" class="widgetContainer clear" id="loanInterestDetailsGrid">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeSavedIntDetailsRepricingTransaction" >
							<xsl:attribute name="data">
								{"identifier":"loan_alias","label":"loan_alias","items" : gridInterestDetailsData}
							</xsl:attribute>
						</div>
						<table rowsPerPage="50" 
							plugins="savedIntDetailsPluginsData" 
							store="storeSavedIntDetailsRepricingTransaction" structure="gridLayoutSavedIntDetailsLoanTransactions" class="grid" 
							autoHeight="true" id="gridSavedIntDetailsLoanTransactions" dojoType="dojox.grid.EnhancedGrid" 
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
    

     <!-- settle-borrower-net -->
    <xsl:template name="settle-borrower-net">
			<xsl:call-template name="fieldset-wrapper">
	 			<xsl:with-param name="content">
					<div class="loan-repricing-interest-details">
					 <xsl:call-template name="checkbox-field">
						 <xsl:with-param name="label">XSL_BORROWER_SETTLEMENT_LABEL</xsl:with-param>
						<xsl:with-param name="name">borrower_settlement</xsl:with-param>
						<xsl:with-param name="id">borrower_settlement</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="borrower_settlement_ind"/></xsl:with-param>
						<xsl:with-param name="checked"><xsl:value-of select="borrower_settlement_ind"/></xsl:with-param>
					 </xsl:call-template>
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
			
			<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">date_format</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'DATE_FORMAT')"/></xsl:with-param>
			</xsl:call-template>
<!-- 			<xsl:call-template name="hidden-field"> -->
<!-- 				<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param> -->
<!-- 			</xsl:call-template> -->
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">match_funding</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">child_product_code</xsl:with-param>
				<xsl:with-param name="value">LN</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">child_sub_product_code</xsl:with-param>
				<xsl:with-param name="value">BKLN</xsl:with-param>
			</xsl:call-template>			
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>
				<xsl:with-param name="value">BK</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code</xsl:with-param>
				<xsl:with-param name="value">LNRPN</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bk_type</xsl:with-param>
				<xsl:with-param name="value">RPLN</xsl:with-param>
			</xsl:call-template>		
			
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">tnx_type_code</xsl:with-param>
				<xsl:with-param name="value">01</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				<xsl:with-param name="value">97</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">tnx_amt</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">repricingdate_validation</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('VALIDATE_AMOUNT_WITH_REPRICING_DATE')"/></xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="$displaymode!='edit'">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">adjust_amount_option</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="adjust_payment_options"/></xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">borrower_settlement</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="borrower_settlement_ind"/></xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">interest_payment</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="interest_payment"/></xsl:with-param>
					</xsl:call-template>
				
				</xsl:if>
			
			
				<!-- application date -->
				    <xsl:call-template name="hidden-field">	
				    	<xsl:with-param name="type">date</xsl:with-param>
						<xsl:with-param name="name">appl_date</xsl:with-param>
						<xsl:with-param name="value" select="appl_date" />
					</xsl:call-template>

			
<!-- 			<xsl:call-template name="hidden-field"> -->
<!-- 				<xsl:with-param name="name">sub_product_code</xsl:with-param> -->
<!-- 				<xsl:with-param name="value">LN</xsl:with-param> -->
<!-- 			</xsl:call-template> -->
		
<!-- 		<xsl:call-template name="borrower-details" />	 -->

    		
    		<xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
    			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
    		</xsl:call-template>
    		<xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
    			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
    		</xsl:call-template>
    		<xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">borrower_reference</xsl:with-param>
    			<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(loan_list/loan/loan_borrower_reference)"/></xsl:with-param>
    		</xsl:call-template>
					<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">loan_increase_flag</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="jetspeedresources:getString('loan.repricing.loanincrease.flag')"/></xsl:with-param>						
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">limit_validation_flag</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="jetspeedresources:getString('loan.repricing.limitvalidation.flag')"/></xsl:with-param>						
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicant_name</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="loan_list/loan/ln_borrower_name" /></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">interest_Payment_loan_flag</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="jetspeedresources:getString('select.individual.interest.payment')"/></xsl:with-param>						
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">authorizer_id</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$authorizerid"/></xsl:with-param>			
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">legal_text_value</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$legal_text_value"/></xsl:with-param>
			</xsl:call-template>	
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">net_cashFlow</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('RESTRICT_NET_CASH_FLOW')"/></xsl:with-param>
			</xsl:call-template>		
							
		
     </xsl:with-param>
    </xsl:call-template>
</xsl:template>

<!-- Borrower Details -->
<xsl:template name="borrower-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="input-field">
	    		<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
	     		<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
    		</xsl:call-template>
    		<div style="white-space:pre;">
   			<xsl:call-template name="input-field">
	    		<xsl:with-param name="name">borrower_reference</xsl:with-param>
	     		<xsl:with-param name="label">XSL_LOAN_BORROWER_REFERENCE</xsl:with-param>
	     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(loan_list/loan/loan_borrower_reference)"/></xsl:with-param>
    		</xsl:call-template>
    		</div>
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
				<xsl:with-param name="value">BK_LOAN_REPRICING</xsl:with-param>
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

  <xsl:template name="free-format-message">
  <div id="AdditionalSection">
	  			<div class="wipeInOutTabHeader">
					<div id="actionDown" onclick="misys.toggleAdditionalDetails()" style="cursor: pointer; display: block;">
					    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADDITIONAL_DETAILS')"/>
					    <span class="collapsingImgSpan">
					        <img>
					        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
					        </img>
					    </span>
					</div>
					<div id="actionUp" onclick="misys.toggleAdditionalDetails()" style="display: none; cursor: pointer;">
					    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADDITIONAL_DETAILS')"/>
					    <span class="collapsingImgSpan">
					        <img>
					        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
					        </img>
					    </span>
					</div>
				</div>
	  
	  <div id="AdditionalDetailsContainer" >
	  <div id="additionalInnerDetailsGrid">
		   <xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_CORRESPONDENCE_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
				 <xsl:call-template name="textarea-field">	
			        <xsl:with-param name="name">free_format_text</xsl:with-param>
			        <xsl:with-param name="label">XSL_HEADER_CORRESPONDENCE_DETAILS</xsl:with-param>
			        <xsl:with-param name="show-label">N</xsl:with-param>
			        <xsl:with-param name="cols">75</xsl:with-param>
			        <xsl:with-param name="rows">5</xsl:with-param>
			        <xsl:with-param name="maxlines">55</xsl:with-param>	
			        <xsl:with-param name="swift-validate">N</xsl:with-param>
			        <xsl:with-param name="button-type"></xsl:with-param>		        
			        <xsl:with-param name="override-displaymode">
						<xsl:value-of select="$displaymode"/>
					</xsl:with-param>
		     </xsl:call-template>
		    </xsl:with-param>
		   </xsl:call-template>
		   </div>
	   </div>
   </div>
  </xsl:template>
  
  <xsl:template name="loan_increase_template">
    <xsl:variable name="repricingNewLnAmt" select="translate(bk_total_amt, ',' ,'')"/>
    <xsl:variable name="repricingLnAmt" select="sum(loan_list//ln_amt)" />
   <xsl:variable name="loanIncrease" select="($repricingNewLnAmt - $repricingLnAmt)" />
    <div id="loan_increase_Section" class="repricing-amt" style="display:block;text-align:right">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="content">
			<xsl:if test="$displaymode='edit'">
				<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_REPRICING_LOAN_INCREASE_AMOUNT</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:value-of select="loan_list/loan/loan_ccy" />
						&#160;
						<div id="loan_increase_ln_amt" name="loan_increase_ln_amt"
							required="true" trim="true" dojoType="dijit.form.CurrencyTextBox"
							class="small" disabled="true">
							<xsl:attribute name="value">0</xsl:attribute>
							<xsl:attribute name="displayedValue"></xsl:attribute>
							<xsl:attribute name="constraints">{min:0}</xsl:attribute>
							<xsl:attribute name="amt-readonly">Y</xsl:attribute>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
				  <xsl:if test="$displaymode !='edit'">
				 
		                 <xsl:if test="number($loanIncrease) &gt; 0">
								<xsl:call-template name="input-field">
										 <xsl:with-param name="label">XSL_REPRICING_LOAN_INCREASE_AMOUNT</xsl:with-param>
										  <xsl:with-param name="class">repricing-amt</xsl:with-param>
										 <xsl:with-param name="value"> 
										 <xsl:value-of select="loan_list/loan/loan_ccy" />&#160; <xsl:value-of select="loaniq:getFormatedAmount($loanIncrease,loan_list/loan/loan_ccy,$language)"/>		
										 </xsl:with-param>
										 <xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
		              
							</xsl:if>
					</xsl:if>

								
			
		</xsl:with-param>
		
	</xsl:call-template>
  </div>			
</xsl:template>
</xsl:stylesheet>
