<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Transaction Bulk (BK) Form, Bank Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      05/10/2011
author:    Mauricio Moura da Silva
email:     mauricio.mouradasilva@misys.com
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    exclude-result-prefixes="localization xmlRender">

	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="product-code">BK</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
	<xsl:param name="show-eucp">N</xsl:param>
 
	<!-- Global Imports. -->
	<xsl:include href="common/bank_common.xsl" /> 
	<xsl:include href="../../collaboration/xsl/collaboration.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="bk_tnx_record"/>
	</xsl:template>
 
	<!-- 
	BK TNX FORM TEMPLATE.
	-->
	<xsl:template match="bk_tnx_record">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message"/>

		    <div id="{$displaymode}">

		    <!-- Display common reporting area -->
		    <xsl:call-template name="bank-reporting-area"/>
		    
		    <!-- Attachments -->
		    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
		     <xsl:call-template name="attachments-file-dojo">
		       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
		       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
		      </xsl:call-template> 
			</xsl:if>
    
			<!-- Link to display transaction contents -->
			<xsl:call-template name="transaction-details-link"/>
			
			 <div id="transactionDetails">
		      <xsl:if test="tnx_type_code[.='01']">
		       <xsl:attribute name="style">display:block;</xsl:attribute>
		      </xsl:if>
		      <xsl:call-template name="form-wrapper">
		       <xsl:with-param name="name" select="$main-form-name"/>
		       <xsl:with-param name="validating">Y</xsl:with-param>
		       <xsl:with-param name="content">
		        <xsl:if test="tnx_type_code[.!='01']">
		         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
		        </xsl:if>
		        
		        <!-- Disclaimer Notice -->
		        <xsl:call-template name="disclaimer"/>
		        
		        <xsl:call-template name="hidden-fields"/>
		        <xsl:call-template name="general-details" />
		        
		       </xsl:with-param>
		      </xsl:call-template>
		     </div>
		   </div>  
		  <xsl:call-template name="menu">
		   <xsl:with-param name="show-template">N</xsl:with-param>
		   <xsl:with-param name="second-menu">Y</xsl:with-param>
		  </xsl:call-template>
		  
		  <!--  Collaboration Window -->   
		   <xsl:if test="$collaborationmode != 'none'">
		   	<xsl:call-template name="collaboration">
			    <xsl:with-param name="editable">true</xsl:with-param>
			    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
			    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
			    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
				<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
			</xsl:call-template>
		   </xsl:if>
		
		 <!-- Javascript imports  -->
		 <xsl:call-template name="js-imports"/>
		</xsl:template>
		 
		 <!--                                     -->  
		 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
		 <!--                                     -->
		 
		 <!-- Additional JS imports for this form are -->
		 <!-- added here. -->
		 <xsl:template name="js-imports">
		  <xsl:call-template name="common-js-imports">
		   <xsl:with-param name="binding">misys.binding.bank.report_bk</xsl:with-param>
		   <xsl:with-param name="override-help-access-key">
			   <xsl:choose>
			   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
			   	<xsl:otherwise>PR_01</xsl:otherwise>
			   </xsl:choose>
		   </xsl:with-param> 
		   <xsl:with-param name="show-period-js">Y</xsl:with-param>
		  </xsl:call-template>
		 </xsl:template>
		 
		 <!-- Additional hidden fields for this form are -->
		 <!-- added here. -->
		 <xsl:template name="hidden-fields">
		  <xsl:call-template name="common-hidden-fields">
		  <xsl:with-param name="additional-fields">
		   <xsl:call-template name="hidden-field">
		   </xsl:call-template>
		  </xsl:with-param>
		  </xsl:call-template>
		 </xsl:template>
		 
		 <!--
		  General Details 
		  -->
		<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
				<xsl:with-param name="content">
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
							<div class="field">
								<!-- The Issue Date needs to be shown only for a reporting, 
									  it is in the reporting section for the New Upload -->
								<xsl:if test="tnx_type_code[.='15' or .='13']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
										<xsl:with-param name="name">iss_date</xsl:with-param>
										<xsl:with-param name="size">10</xsl:with-param>
										<xsl:with-param name="maxsize">10</xsl:with-param>
										<xsl:with-param name="type">date</xsl:with-param>
										<xsl:with-param name="fieldsize">small</xsl:with-param>
									</xsl:call-template>
								</xsl:if>						
							
								<!-- 
								Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
								Pass in a show-presentation parameter set to Y to display the presentation fields.
								
								If set to N, the template will instead insert a hidden field with the value 1.0
								-->
								<xsl:call-template name="eucp-details">
									<xsl:with-param name="show-eucp" select="$show-eucp"/>
								</xsl:call-template>
					     	</div>
							<xsl:if test="entities[number(.) &gt; 0]">
							<div id="display_entity_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
								<div class="content" id="display_entity"><xsl:value-of select="entity"/></div> 
							</div>
							</xsl:if>
							<xsl:if test="bk_type='PAYMT' or bk_type='PAYRL'">
							<div id="display_account_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/></span>
								<div class="content" id="display_account"><xsl:value-of select="applicant_act_name"/></div> 
							</div>
							</xsl:if>
							<xsl:if test="bk_type ='COLLE'">
							<div id="display_to_account_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_TO')"/></span>
								<div class="content" id="display_to_account"><xsl:value-of select="applicant_act_name"/></div> 
							</div>
							</xsl:if>
							<div id="display_child_sub_product_code_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/></span>
								<div class="content" id="display_child_sub_product_code"><xsl:if test="child_sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', child_sub_product_code)"/></xsl:if></div> 
							</div>
							<xsl:if test="child_sub_product_code ='MUPS')">
									<div id="display_clearing_code_row" class="field">
										<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_NAME')"/>&nbsp;</span>
										<div class="content" id="display_clearing_code"><xsl:value-of select="clearing_code"/></div> 
									</div>
							</xsl:if>
						    <xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_BK_TOTAL_AMT</xsl:with-param>
								<xsl:with-param name="override-currency-name">bk_total_amt_cur_code</xsl:with-param>
								<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
								<xsl:with-param name="override-amt-name">bk_total_amt</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="amt-readonly">Y</xsl:with-param>
								<xsl:with-param name="currency-readonly">Y</xsl:with-param>
								<xsl:with-param name="show-button">N</xsl:with-param>
								<xsl:with-param name="constraints">N</xsl:with-param>
							</xsl:call-template>
							<!-- amount access permission -->
							<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
							    <xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_BK_HIGHEST_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">bk_highest_amt_cur_code</xsl:with-param>
									<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
									<xsl:with-param name="override-amt-name">bk_highest_amt</xsl:with-param>
									<xsl:with-param name="required">N</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="constraints">N</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						    <xsl:call-template name="hidden-field">
						       <xsl:with-param name="name">record_number</xsl:with-param>
						    </xsl:call-template>
							<xsl:call-template name="hidden-field">
						       <xsl:with-param name="name">sub_product_code</xsl:with-param>
						    </xsl:call-template>
						    <xsl:call-template name="hidden-field">
						       <xsl:with-param name="name">child_product_code</xsl:with-param>
						    </xsl:call-template>
						    <xsl:if test="product_code[.='BK'] and narrative_additional_instructions/text[.!='']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_GENERALDETAILS_BULK_DESCRIPTION</xsl:with-param>
										<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
										<xsl:with-param name="value" select="narrative_additional_instructions/text" />
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
									</xsl:call-template>
							</xsl:if>
							<div id="display_record_number_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_RECORD_NUMBER')"/></span>
								<div class="content" id="display_record_number"><xsl:value-of select="record_number"/></div>
							</div>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
								<xsl:with-param name="value" select="issuing_bank/name" />
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						  	<xsl:call-template name="common-general-details">
					     		<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
					     		<xsl:with-param name="show-template-id">N</xsl:with-param>
					  		</xsl:call-template>
					  		
					  		<div id="product_group_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_PRODUCT_GROUP')"/>&nbsp;</span>
								<xsl:if test="$displaymode='edit' or $displaymode='view'">
									<div class="content" id="product_group"><xsl:value-of select="sub_product_code"/></div>
								</xsl:if>
							</div>
							<div id="payrolltype" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_PAYROLL_TYPE_LABEL')"/>&nbsp;</span>
								<xsl:if test="$displaymode='edit' or $displaymode='view'">
									<div class="content" id="product_group"><xsl:value-of select="payroll_type"/></div>
								</xsl:if>
							</div>
							<div id="transfer_date_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TRANSFER_DATE')"/>&nbsp;</span>
								<xsl:if test="$displaymode='edit' or $displaymode='view'">
									<div class="content" id="transfer_date"><xsl:value-of select="value_date"/></div>
								</xsl:if>
							</div>
							 <xsl:if test="product_code[.='BK'] and cust_ref_id[.!='']">
							 	<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_GENERALDETAILS_BULK_REF_ID</xsl:with-param>
										<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
										<xsl:with-param name="value" select="cust_ref_id" />
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
									</xsl:call-template>
							 </xsl:if>
							<div id="dialogTransaction" />
							<div dojoType="dijit.form.Form" id="transactionForm" method="post" />
							<div dojoType="dijit.form.Form" id="existingForm" method="post" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<p>&nbsp;</p>
				<xsl:if test="not(item_access) or  (item_access[.='true'])  ">
					<xsl:call-template name="topic-transaction-grid" />
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>

	</xsl:template>

	<xsl:template name="topic-transaction-grid">
		<p>&nbsp;</p>
		<div id="transactionGridContainer" class="widgetContainer">
			<div>
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_OPTIONS')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="prefix">searchCriteria</xsl:with-param>
			   	</xsl:call-template>
				<div id="searchCriteria">
					<div class="widgetContainer clear">
<!-- 						<small><xsl:value-of select="localization:getGTPString($language, 'LIST_HELP_SDATA')"/></small> -->
						<div name="TransactionSearchForm" id="TransactionSearchForm" dojoType="dijit.form.Form">
							<div id="search_ref_id_row" class="field">
								<label for="search_ref_id"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="search_ref_id" name="search_ref_id" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
								<input type="hidden" name="bulk_ref_id" id="search_bulk_ref_id" value="{ref_id}" dojoType="dijit.form.TextBox"/>
								<input type="hidden" name="bulk_tnx_id" id="search_bulk_tnx_id" value="{tnx_id}" dojoType="dijit.form.TextBox"/>
							</div>
							<xsl:if test="child_sub_product_code!='TPT' and child_sub_product_code!='INT' and child_sub_product_code!= 'MT103' and child_sub_product_code!= 'HVXB' and child_sub_product_code!= 'HVPS' and child_sub_product_code!= 'MUPS'">
							<div id="bank_code_row" class="field">
								<label for="bank_code"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANK_CODE')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="bank_code" name="bank_code" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							<div id="branch_code_row" class="field">
								<label for="branch_code"><xsl:value-of select="localization:getGTPString($language, 'XSL_BRANCH_CODE')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="branch_code" name="branch_code" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							</xsl:if>
							<xsl:if test="child_sub_product_code[.='MUPS']">
								<div id="ifsc_code_row" class="field">
									<label for="ifsc_code"><xsl:value-of select="localization:getGTPString($language, 'XSL_IFSC_CODE')"/></label>
									<input trim="true" style="width: 14em" class="medium" id="ifsc_code" name="ifsc_code" dojoType="dijit.form.TextBox" maxlength="15" value="" size="14" />
								</div>
							</xsl:if>
							<div id="ben_account_no_row" class="field">
								<label for="ben_account_no"><xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNO_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="ben_account_no" name="ben_account_no" dojoType="dijit.form.TextBox" maxlength="32" value="" size="14" />
							</div>
							<div id="ben_account_name_row" class="field">
								<label for="ben_account_name"><xsl:value-of select="localization:getGTPString($language, 'ACCOUNT_NAME_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="ben_account_name" name="ben_account_name" dojoType="dijit.form.TextBox" maxlength="35" value="" size="14" />
							</div>
							<div id="searchSubmitButton_row" class="field">
								<label for="searchSubmitButton"></label>
								<button dojoType="dijit.form.Button" id="searchSubmitButton" onClick="misys.grid.setListKey(dijit.byId('gridBulkTransaction'));" type="submit">
									<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SEARCH')"/>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
				<p/>
				<div>
				   <script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "ref_id", "width": "15%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   <xsl:if test="child_sub_product_code!='TPT' and child_sub_product_code!='INT' and child_sub_product_code!= 'MT103' and child_sub_product_code!= 'MUPS' and child_sub_product_code!= 'MEPS' and child_sub_product_code!= 'RTGS' and child_sub_product_code!= 'HVPS' and child_sub_product_code!= 'HVXB'">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_BANK_CODE')"/>", "field": "Counterparty@cpty_bank_code", "width": "12%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_BRANCH_CODE')"/>", "field": "Counterparty@cpty_branch_code", "width": "12%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   </xsl:if>
					                   <xsl:if test="child_sub_product_code [.='MUPS']">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_IFSC_CODE')"/>", "field": "Counterparty@cpty_bank_swift_bic_code", "width": "15%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   </xsl:if>
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNUMBER')"/>", "field": "Counterparty@counterparty_act_no", "width": "15%", "styles":"white-space:prewrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ACCOUNT_NAME')"/>", "field": "Counterparty@counterparty_name", "width": "25%", "styles":"white-space:prewrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "ft_cur_code", "width": "4em", "styles":"text-align: center;white-space:prewrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/>", "field": "ft_amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "status", "width": "15%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "&nbsp;", "field": "transaction_detail_view", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center","get":misys.grid.getActions,"formatter": misys.grid.formatActions}]]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">
								<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=core/listdef/customer/BK/listTransactionsInBK.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>&amp;bulk_tnx_id=<xsl:value-of select='tnx_id'/>
							</xsl:attribute>
						</div>
						<table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid subscribeTopic" 
							autoHeight="true" id="gridBulkTransaction" dojoType="misys.grid.TopicListenerDataGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}">
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
	</xsl:template>
	
</xsl:stylesheet>