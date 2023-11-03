<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!--
##########################################################
Templates for

 Open Account - Credit Note (CR) Form, Customer Side.
 
Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      24/03/2014
author:    Prateek Kumar
email:     prateek.kumar@misys.com
##########################################################
	-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="localization utils">
		
	
	<xsl:param name="override-product-code">cr</xsl:param>


	<xsl:template match="cr_tnx_record">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message" />
		
		<!-- ***************************** -->
		<!-- Widgets' template declaration -->
	<!-- ***************************** -->		
		
		<!-- User defined informations declaration seller -->
		<!-- <xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">02</xsl:with-param>
		</xsl:call-template> -->
		
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
				<!--  Display common menu.  -->
					<xsl:call-template name="menu">
						<!-- Set show-template to Y once template is implemented -->
						<xsl:with-param name="show-template">Y</xsl:with-param>
						<xsl:with-param name="show-return">Y</xsl:with-param>
					</xsl:call-template>

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />
					
					<!-- Reauthentication -->	
				 	<xsl:call-template name="server-message">
				 		<xsl:with-param name="name">server_message</xsl:with-param>
				 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
			 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="reauthentication" />

					<!-- <xsl:apply-templates select="cross_references"
						mode="hidden_form" /> -->
					<xsl:call-template name="hidden-fields"/>
						
					<xsl:call-template name="general-details" />
					
					<xsl:call-template name="bank-details" />
					
					<xsl:call-template name="amount-details" />
		
					<xsl:call-template name="invoice-items-declaration"/>
					
					<xsl:call-template name="credit_note_invoices"/>
					
					<xsl:call-template name="message-freeFormat"/>
					
					<xsl:if test ="free_format_text/text[.!='']">
					<xsl:call-template name="fieldset-wrapper">
				    	<xsl:with-param name="legend">XSL_HEADER_FREE_FORMAT</xsl:with-param>
					    <xsl:with-param name="content">
					     <xsl:call-template name="row-wrapper">
					      <xsl:with-param name="id">free_format_text</xsl:with-param>
					      <xsl:with-param name="required">Y</xsl:with-param>
					      <xsl:with-param name="type">textarea</xsl:with-param>
					      <xsl:with-param name="content">
					       <xsl:call-template name="textarea-field">
					        	<xsl:with-param name="value"><xsl:value-of select="free_format_text/text"/></xsl:with-param>
					        	<xsl:with-param name="override-displaymode">view</xsl:with-param>
					        </xsl:call-template>
					       </xsl:with-param>
					      </xsl:call-template>
					     </xsl:with-param>
				     </xsl:call-template>
				    </xsl:if>
					<!-- comments for return -->
			      <xsl:call-template name="comments-for-return">
				  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
				   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
			   	  </xsl:call-template>
					
					<!-- Form #1 : Attach Files -->
					<xsl:choose>
					<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
						<xsl:call-template name="attachments-file-dojo">
							<!-- <xsl:with-param name="attachment-group">credit_note</xsl:with-param> -->
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$option ='DETAILS'">
						<xsl:call-template name="attachments-file-dojo">
				          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
				          	<xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
				          	<xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
			          	</xsl:call-template>
			          	<xsl:call-template name="attachments-file-dojo">
				          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
				          	<xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
				          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
			          	</xsl:call-template>
			          	</xsl:if>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>


	</div>

		<!-- Table of Contents -->
		<xsl:call-template name="toc" />

		<!--  Collaboration Window  -->
		<xsl:call-template name="collaboration">
			<xsl:with-param name="editable">true</xsl:with-param>
			<xsl:with-param name="productCode">
				<xsl:value-of select="$product-code" />
			</xsl:with-param>
			<xsl:with-param name="contextPath">
				<xsl:value-of select="$contextPath" />
			</xsl:with-param>
			<xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>

		<!-- Display common menu, this time outside the form -->
		<xsl:call-template name="menu">
			<xsl:with-param name="second-menu">Y</xsl:with-param>
			<xsl:with-param name="show-template">Y</xsl:with-param>
			<xsl:with-param name="show-return">Y</xsl:with-param>					
		</xsl:call-template>
		
		<!-- The form that's submitted -->
		<xsl:call-template name="realform" />
		
		<!-- Javascript and Dojo imports  -->
		<xsl:call-template name="js-imports" />

	</xsl:template>
	
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			   	<xsl:variable name="show-cust-ref-id">Y</xsl:variable>
			  	<xsl:variable name="show-bo-ref-id">Y</xsl:variable>
			  	<xsl:variable name="show-template">Y</xsl:variable>
			   	<xsl:variable name="override-cust-ref-id-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:variable>
			   	<!-- Hidden fields. -->
			   	<xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">ref_id</xsl:with-param>
			   	</xsl:call-template>
			   	<!-- Don't display this in unsigned mode. -->
			   	<xsl:if test="$displaymode='edit'">
			    	<xsl:call-template name="hidden-field">
			     		<xsl:with-param name="name">appl_date</xsl:with-param>
			    	</xsl:call-template>
			   	</xsl:if>
			   
			   	<!--  System ID. -->
			  	<xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
				    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
				    <xsl:with-param name="value" select="ref_id" />
				    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			   	</xsl:call-template>
	   
			   <!-- Bank Reference -->
			   <!-- Shown in consolidated view -->
			   <xsl:if test="$show-bo-ref-id='Y' and $displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
			    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
			     <xsl:with-param name="value" select="bo_ref_id" />
			    </xsl:call-template>
			   </xsl:if>
	   
			   <!-- Cross Refs -->
			   <!-- Shown in consolidated view  -->
			   <xsl:if test="cross_references">
			    <!-- <xsl:apply-templates select="cross_references" mode="display_table_tnx"/> -->
			   </xsl:if>
			    
			   <!-- Template ID. -->
			   <xsl:if test="$show-template='Y'">
			    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
			     <xsl:with-param name="name">template_id</xsl:with-param>
			     <xsl:with-param name="size">15</xsl:with-param>
			     <xsl:with-param name="maxsize">20</xsl:with-param>
			     <xsl:with-param name="fieldsize">small</xsl:with-param>
			    </xsl:call-template>
			   </xsl:if>
	    
			    <!-- Customer reference -->
			    <xsl:if test="$show-cust-ref-id='Y'">
				    <xsl:call-template name="input-field">
				     <xsl:with-param name="label"><xsl:value-of select="$override-cust-ref-id-label"/></xsl:with-param>
				     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
				     <xsl:with-param name="size">20</xsl:with-param>
				     <xsl:with-param name="maxsize">16</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
	
				<!-- Credit Note Reference -->
	 			<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_CN_REFERENCE</xsl:with-param>
				     <xsl:with-param name="name">cn_reference</xsl:with-param>
				     <xsl:with-param name="size">20</xsl:with-param>
				     <xsl:with-param name="maxsize">16</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
	    		<!-- FSCM Program -->
	    		<xsl:choose>
					<xsl:when test="$displaymode='edit'">
			    		<xsl:call-template name="select-field">
			    			<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
			    			<xsl:with-param name="name">fscm_program_code</xsl:with-param>
			    			<xsl:with-param name="required">Y</xsl:with-param>
			    			<xsl:with-param name="options">	
			    				<xsl:call-template name="fscm_program_options_cr" />		    				
			    			</xsl:with-param>
			    		</xsl:call-template>
			    	</xsl:when>
			    	<xsl:otherwise>
			    		<xsl:if test = "fscm_program_code[.!='']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N084',fscm_program_code )"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
			    	</xsl:otherwise>
			    </xsl:choose>
			    <!--  Application date. -->
			    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
			     <xsl:with-param name="id">appl_date_view</xsl:with-param>
			     <xsl:with-param name="value" select="appl_date" />
			     <xsl:with-param name="type">date</xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    
			    <!-- Seller Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">Y</xsl:with-param>
							<xsl:with-param name="show-entity">
								<xsl:choose>
									<xsl:when test="$displaymode = 'view' and fscm_program_code[.!=''] and fscm_program_code[.='04']">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
		
				<!-- Buyer Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:choose>
							<xsl:when test="$displaymode='edit' and entities[.= '1'] and entity[.!= '']">
								<xsl:call-template name="input-field">
							       <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
							       <xsl:with-param name="value" select="entity"/>
							       <xsl:with-param name="id">buyer_entity</xsl:with-param>
							       <xsl:with-param name="override-displaymode">view</xsl:with-param>
							      </xsl:call-template>
							</xsl:when>
							<xsl:when test ="$displaymode='edit' and entities[.!= '1']">
								<xsl:call-template name="entity-field">
									<xsl:with-param name="prefix">buyer</xsl:with-param>
									<xsl:with-param name="popup-entity-prefix">buyer</xsl:with-param>
									<xsl:with-param name="override_company_abbv_name"><xsl:value-of select="company_name"/></xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="fscm_program_code[.!=''] and fscm_program_code[.='04']">
									<xsl:call-template name="entity-field">
										<xsl:with-param name="prefix">buyer</xsl:with-param>
										<xsl:with-param name="popup-entity-prefix">buyer</xsl:with-param>
										<xsl:with-param name="override_company_abbv_name"><xsl:value-of select="company_name"/></xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">Y</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
		
				<!-- seller Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
				<xsl:call-template name="party-details">
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="show-BEI">Y</xsl:with-param>
					<xsl:with-param name="prefix">seller</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="show-country-icon">Y</xsl:with-param>
				</xsl:call-template>
				</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Invoice addition -->
	<xsl:template name="invoice-items-declaration">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INVOICE_ITEMS</xsl:with-param>
			<xsl:with-param name="content">
				<div id="invoice-items-template">
					<div class="clear multigrid">
						<script type="text/javascript">
							var gridLayoutInvoice, pluginsData;
							dojo.ready(function(){
						    	gridLayoutInvoice = {"cells" : [
						                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "REFERENCEID", "width": "25%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "INVOICE_REFERENCE", "width": "25%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "CURCODE", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')"/>", "field": "INVOICE_AMOUNT", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'INVOICE_SETTLEMENT_AMT')"/>", "field":"INVOICE_SETTLEMENT_AMT", "type": dojox.grid.cells._Widget, "width": "15%", "styles":"white-space:nowrap;text-align: center;"}
						                   <xsl:if test="$displaymode='edit'">
						                   		,{ "noresize":"true", "name": "&nbsp;", "field": "ACTION", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "formatter": misys.grid.formatHTML}
						                    ]
						                   </xsl:if>
						        ]};
								pluginsData = {indirectSelection: {headerSelector: "false",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
							});
						</script>
						<div style="width:100%;height:100%;" class="widgetContainer clear">
						<xsl:choose>
	
						 <xsl:when test="$mode='DRAFT' and  $displaymode = 'edit'">
							<table class="grid" plugins="pluginsData" structure="gridLayoutInvoice"
								autoHeight="true" id="gridInvoice" dojoType="dojox.grid.EnhancedGrid" selectionMode="none" selectable="false" singleClickEdit="true"
								noDataMessage="{localization:getGTPString($language, 'XSL_CN_NO_INVOICE_ITEM')}" 
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
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
						     <xsl:attribute name="id">invoice_table</xsl:attribute>
						      <xsl:choose>
						      	<xsl:when test="invoice-items/invoice">
							      <thead>
							       <tr>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')"/></th>						       
							       	<th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_SETTLEMENT_AMT')"/></th>
									</tr>
							      </thead>
							      <tbody>
									<xsl:attribute name="id">invoice_table_details</xsl:attribute>      
							         <xsl:for-each select="invoice-items/invoice">
							          <tr>
							         	<td><xsl:value-of select="invoice_ref_id"/></td>
							           	<td><xsl:value-of select="invoice_reference"/></td>
							           	<td><xsl:value-of select="invoice_currency"/></td>
							           	<td><xsl:value-of select="invoice_amount"/></td>
							           	<td><xsl:value-of select="invoice_settlement_amt"/></td>							          </tr>
							         </xsl:for-each>
							      </tbody>
							    </xsl:when>
							    <xsl:otherwise>
							      	<div><xsl:value-of select="localization:getGTPString($language, 'XSL_CN_NO_INVOICE_ITEM')"/></div>
							      	<tbody></tbody>
							    </xsl:otherwise>
						      </xsl:choose>
						     </table>
						</xsl:otherwise>
						</xsl:choose>
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
						<xsl:if test="$displaymode='edit'">
						<div id="invoice-items-add" class="widgetContainer">
							<div id="invoice_lookup" type="button" dojoType="dijit.form.Button">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_ADD_INVOICE_ITEM')" />
							</div>
						</div>
						</xsl:if>	
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!--  Bank Details Fieldset. -->
	<xsl:template name="bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:if test="$displaymode='edit'">
			         <script>
			         	dojo.ready(function(){
			         		misys._config = misys._config || {};
							misys._config.customerReferences = {};
							<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
							misys._config.customerBanksMT798Channel = {};
							<xsl:apply-templates select="avail_main_banks/bank" mode="customer_banks_communication_channel"/>
						});
					</script>
			     </xsl:if>
				<xsl:if test = "fscm_program_code[.!=''] and fscm_program_code[.!='04']" >
					<xsl:call-template name="main-bank-selectbox">
				         <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
				         <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
				         <xsl:with-param name="sender-name">seller</xsl:with-param>
				         <xsl:with-param name="sender-reference-name">seller_reference</xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="customer-reference-selectbox">	
				         <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
				         <xsl:with-param name="sender-name">seller</xsl:with-param>
				         <xsl:with-param name="sender-reference-name">seller_reference</xsl:with-param>
				      </xsl:call-template>
			    </xsl:if>
			    <xsl:if test = "fscm_program_code[.!=''] and fscm_program_code[.='04']" >
					<xsl:call-template name="main-bank-selectbox">
				         <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
				         <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
				         <xsl:with-param name="sender-name">buyer</xsl:with-param>
				         <xsl:with-param name="sender-reference-name">buyer_reference</xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="customer-reference-selectbox">	
				         <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
				         <xsl:with-param name="sender-name">buyer</xsl:with-param>
				         <xsl:with-param name="sender-reference-name">buyer_reference</xsl:with-param>
				      </xsl:call-template>
			    </xsl:if>
			    <xsl:if test = "fscm_program_code[.='']" >
					<xsl:call-template name="main-bank-selectbox">
				         <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
				         <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
				         <xsl:with-param name="sender-name">buyer</xsl:with-param>
				         <xsl:with-param name="sender-reference-name">buyer_reference</xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="customer-reference-selectbox">	
				         <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
				         <xsl:with-param name="sender-name">buyer</xsl:with-param>
				         <xsl:with-param name="sender-reference-name">buyer_reference</xsl:with-param>
				      </xsl:call-template>
			    </xsl:if>
			      <!-- <xsl:if test="$displaymode ='view' and $mode = 'UNSIGNED'">
			      	<xsl:call-template name="input-field">
			      		<xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
			      		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(seller_reference)"/></xsl:with-param>
			      	</xsl:call-template>
			      </xsl:if> -->      	
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	
	<xsl:template name="realform">
		<!--
			Do not display this section when the counterparty mode is
			'counterparty'
		-->
		<xsl:if test="$collaborationmode != 'counterparty'">
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">realform</xsl:with-param>
				<xsl:with-param name="action" select="$realform-action" />
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
							<xsl:with-param name="value" select="$mode" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">tnxtype</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="e2ee_transaction"/>
						<xsl:call-template name="reauth_params"/>						
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="amount-details">
		<div>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<div>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_CN_AMOUNT</xsl:with-param>
						<xsl:with-param name="product-code">cn</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-button">Y</xsl:with-param>
					</xsl:call-template>	
				</div>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
	<xsl:template name="credit_note_invoices">
		<script type="text/javascript">
			var invoiceItems =[];
			<xsl:for-each select="invoice-items/invoice">
				var refInv = "<xsl:value-of select="invoice_ref_id"/>";
				invoiceItems.push({ "REFERENCEID" :"<xsl:value-of select="invoice_ref_id"/>","INVOICE_REFERENCE":"<xsl:value-of select="invoice_reference"/>","CURCODE":"<xsl:value-of select="invoice_currency"/>","INVOICE_AMOUNT":"<xsl:value-of select="invoice_amount"/>",  "INVOICE_SETTLEMENT_AMT" :"<xsl:value-of select="invoice_settlement_amt"/>", "ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteInvoiceRecord(refInv)\"/>]]>"});
			</xsl:for-each>	
		</script>
	</xsl:template>
	
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>				
			</xsl:call-template>
		</div>
	</xsl:template>
	
	<xsl:template name="message-freeFormat">
		<xsl:param name="required">N</xsl:param>
		<xsl:param name="value"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_FREE_FORMAT</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="id">free_format_text</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="type">textarea</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="textarea-field">
							<xsl:with-param name="name">free_format_text</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="rows">12</xsl:with-param>
							<xsl:with-param name="maxlines">35</xsl:with-param>
							<xsl:with-param name="cols">50</xsl:with-param>
							<xsl:with-param name="required">
								<xsl:value-of select="$required"/>
							</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="$value"/>
							</xsl:with-param>
							<xsl:with-param name="override-displaymode">
								<xsl:choose>
									<xsl:when test="$mode ='ACCEPT' or $displaymode = 'edit'">edit</xsl:when>
									<xsl:otherwise>view</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template> 
	</xsl:template>
	
	<xsl:template name="fscm_program_options_cr">
		<xsl:choose>
			<xsl:when test="security:isCustomer($rundata)">
				<option value="04">
					<xsl:value-of select="localization:getDecode($language, 'N084','04')" />
				</option>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>