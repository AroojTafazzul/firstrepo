<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Internal Fund Transfer (FT-INT) Form.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      21/11/2012
author:    Satyanarayana Raghupathi
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security collabutils defaultresource">

	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="product-code">FT</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="optionmode">edit</xsl:param>
	<xsl:param name="option"></xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen</xsl:param>
	<xsl:param name="isMultiBank">N</xsl:param>
	<xsl:param name="nicknameEnabled"/>
	<xsl:param name="option_for_app_date"/>
	<xsl:param name="gpp_payment_flag"/>
	<xsl:param name="gpp_fee_config_cur_code"/>
	<xsl:param name="gpp_fee_config_amt"/>
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="./common/ft_common.xsl" />
	<xsl:include href="../../core/xsl/common/fx_common_multibank.xsl" />
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../cash/xsl/cash_ft_fee_details.xsl" />

  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="ft_tnx_record"/>
	</xsl:template>
	
	<xsl:template match="ft_tnx_record">
		<!-- Preloader -->
		<xsl:call-template name="loading-message"/>
		<div>
		<script>
			dojo.ready(function(){			
         	  	misys._config = misys._config || {};
         	  	misys._config.gpp_payment_flag = '<xsl:value-of select="$gpp_payment_flag"/>';
         	  	misys._config.gpp_fee_config_cur_code = '<xsl:value-of select="$gpp_fee_config_cur_code"/>';
         	  	misys._config.gpp_fee_config_amt = '<xsl:value-of select="$gpp_fee_config_amt"/>';			
			});
	  	</script>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />
					<xsl:call-template name="hidden-fields" />
					<xsl:if test="$displaymode='edit'">
						<div id="INT_DISCLAIMER" class="ftDisclaimer intDisclaimer">
							<xsl:call-template name="simple-disclaimer">
								<xsl:with-param name="label">XSL_FT_INT_DISCLAIMER</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:if>
					<div>
						
						<!-- Display common menu. -->
						<xsl:call-template name="menu">
							<xsl:with-param name="show-reject">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-return">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						   <xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="($optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y']))">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-save">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-template">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="server-message">
							<xsl:with-param name="name">server_message</xsl:with-param>
							<xsl:with-param name="content"><xsl:value-of select="message" /></xsl:with-param>
							<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
						</xsl:call-template>
						<!-- Reauthentication -->
						<xsl:call-template name="reauthentication" />
						<xsl:call-template name="bank-message"/>
						<!-- Transfer sections -->						
						<xsl:call-template name="int-general-details"/>
						<xsl:call-template name="recurring_content">
							<xsl:with-param name="isMultiBank"><xsl:value-of select="$isMultiBank"/></xsl:with-param>
							<xsl:with-param name="override-displaymode"><xsl:value-of select="$displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="int-transfer-to-details" />
						<xsl:call-template name="int-transaction-details" />
						<!-- FX Snippets Start -->
							<xsl:if test="not(amount_access) or  (amount_access[.='true'])">
								<xsl:if test="$displaymode='edit'and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
									<xsl:call-template name="fx-template"/>
								</xsl:if>  
								<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
									<xsl:call-template name="fx-details-for-view" /> 
								</xsl:if>
							</xsl:if>
							<!-- FX Snippets End -->  
						<!-- <xsl:call-template name="int-notify-beneficiary-details" /> -->
					  <div id="ftFeeFetails"  style="display: none;">
						<xsl:if test="$gpp_payment_flag='true'">
						<xsl:call-template name="ft-fee-details" />
						</xsl:if>
					</div>
					 <xsl:if test="$displaymode='view' and (not(recurring_payment_enabled) or recurring_payment_enabled[.='N'])">
						 <xsl:call-template name="ft-fee-details-view" />
					</xsl:if>
						<xsl:call-template name="transaction-remarks-details" />
						<!-- comments for return -->
						<xsl:if test="$optionmode!='CANCEL'">
     						<xsl:call-template name="comments-for-return">
	  							<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   							<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 						</xsl:call-template>
						</xsl:if>

						<!-- Display common menu, this time under the form -->
						<xsl:call-template name="menu">
							<xsl:with-param name="second-menu">Y</xsl:with-param>
							<xsl:with-param name="show-reject">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-return">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-template">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.='']">Y</xsl:when>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="($optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y']))">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-save">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="realform" />    
		</div>
		
	   <!--  Collaboration Window -->   
	   <xsl:if test="$collaborationmode != 'none' and (not(bulk_ref_id) or bulk_ref_id[.=''])">
	   	<xsl:call-template name="collaboration">
		    <xsl:with-param name="editable">true</xsl:with-param>
		    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
		    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
		    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>
		<script>
			dojo.ready(function(){			
         	  	misys._config = misys._config || {};
         	  	misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';			
				misys._config.task_mode = '<xsl:value-of select="collabutils:getProductTaskMode($rundata, $product-code, sub_product_code)"/>';
			});
	  	</script>
	   </xsl:if>
		   
		<!-- Javascript imports  -->
		<xsl:call-template name="js-imports"/>
		 
	</xsl:template>
 
	<!--
	Real form for FT INT
	-->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
		    <xsl:with-param name="name">realform</xsl:with-param>
		    <xsl:with-param name="method">POST</xsl:with-param>
		    <xsl:with-param name="action" select="$realform-action"/>
		    <xsl:with-param name="content">
				<div class="widgetContainer">
				<xsl:call-template name="hidden-field">
						<xsl:with-param name="id">gpp_fee_config_flag</xsl:with-param>
						<xsl:with-param name="value" select="$gpp_payment_flag"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="id">gpp_fee_config_amt_cur_code</xsl:with-param>
						<xsl:with-param name="value" select="$gpp_fee_config_cur_code"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="id">gpp_fee_config_amt_val</xsl:with-param>
						<xsl:with-param name="value" select="$gpp_fee_config_amt"/>
					</xsl:call-template>
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
					<xsl:if test="$option='CANCEL'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option</xsl:with-param>
							<xsl:with-param name="value" select="$option"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option_for_tnx</xsl:with-param>
							<xsl:with-param name="value" select="$option"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">mode</xsl:with-param>
						<xsl:with-param name="value" select="$mode"/>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxtype</xsl:with-param>
						<xsl:with-param name="value">01</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">attIds</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">TransactionData</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">fxinteresttoken</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">productcode</xsl:with-param>
				      <xsl:with-param name="value" select="$product-code"/>
				     </xsl:call-template>
				     <xsl:call-template name="hidden-field">
				    	<xsl:with-param name="name">subproductcode</xsl:with-param>
				    	<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
				   	 </xsl:call-template>
					<xsl:call-template name="e2ee_transaction"/>
					<xsl:call-template name="reauth_params"/>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">currency_res</xsl:with-param>
						 <xsl:with-param name="value"><xsl:value-of select="currency_res"/></xsl:with-param>
					 </xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.cash.create_ft_int</xsl:with-param>
			<xsl:with-param name="override-help-access-key">
			     <xsl:choose>
			       <xsl:when test="$option ='CANCEL'">FT_CANCEL</xsl:when>
			       <xsl:otherwise>CASH_FT</xsl:otherwise>
			     </xsl:choose>
 		  </xsl:with-param> 
		</xsl:call-template>
		<script>
			dojo.ready(function(){
				misys._config = (misys._config) || {}; 
				<xsl:if test="$isMultiBank !='Y'">
					misys._config.offset = misys._config.offset ||
					[ 
					{
					<xsl:for-each select="start_dt_offset/offset">
							'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
							<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>	
					}
					];	
					misys._config.frequency_mode = misys._config.frequency_mode || 
					[
					{
					<xsl:for-each select="frequency/frequency_mode">
						'<xsl:value-of select="frequency_type"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
		            	<xsl:if test="position()!=last()">,</xsl:if>
		            </xsl:for-each>
		            }
		            ];		
				</xsl:if>
				<xsl:if test="$isMultiBank ='Y'">
					misys._config.offset = misys._config.offset ||
						[ 
						{
						<xsl:for-each select="start_dt_offset/offset">
								'<xsl:value-of select="sub_prod_type_offset" />_<xsl:value-of select="bank" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
								<xsl:if test="position()!=last()">,</xsl:if>
						</xsl:for-each>	
						}
						];
						misys._config.frequency_mode = misys._config.frequency_mode || 
			            [
			            {
			            <xsl:for-each select="/ft_tnx_record/frequency/frequency_per_bank">
				   						<xsl:for-each select="frequency_mode">
											'<xsl:value-of select="frequency_type"/>_<xsl:value-of select="bank_abbv_name"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
				            					<xsl:if test="position()!=last()">,</xsl:if>
				            			</xsl:for-each>
				            			<xsl:if test="count(frequency_mode) > 0">
				            				<xsl:if test="position()!=last()">,</xsl:if>
				            			</xsl:if>
			         	</xsl:for-each>
			         	}
			         	];
				</xsl:if>
			misys._config.recurring_product = misys._config.recurring_product || 
			{
			<xsl:for-each select="recurring_payment/recurring_product">
					'<xsl:value-of select="sub_prod_type" />':'<xsl:value-of select="flag" />'
					<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>	
			};
            misys._config.isMultiBank =<xsl:choose>
								 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
								 			<xsl:otherwise>false</xsl:otherwise>
								 		</xsl:choose>;
			misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
			misys._config.option_for_app_date ='<xsl:value-of select="$option_for_app_date"/>';
            <xsl:if test="$isMultiBank='Y'">
	            <xsl:call-template name="per-bank-recurring"/>
	            <xsl:call-template name="per-bank-recurring-frequency"/>
            	<xsl:call-template name="multibank-common-details"/>
			</xsl:if>	
		});
		</script>
 	</xsl:template>
	<xsl:template name="int-transfer-to-details">
		<xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata)))"/>

	   	<!-- Transfer to options for 3rd party transfer -->
		<xsl:call-template name="fieldset-wrapper">
		  <xsl:with-param name="legend">XSL_HEADER_TRANSFER_TO_DETAILS</xsl:with-param>
		   <xsl:with-param name="content">
			 <xsl:call-template name="column-container">
			  <xsl:with-param name="content">
			    <xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
			        <xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_TRANSFER_TO</xsl:with-param>
						<xsl:with-param name="name">beneficiary_name</xsl:with-param>		
						<xsl:with-param name="swift-validate">Y</xsl:with-param>
						<!-- <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/>&nbsp;<xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param> -->
						<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>	
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="$displaymode='edit'">
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
							<xsl:with-param name="show-image">Y</xsl:with-param>
							<xsl:with-param name="show-border">N</xsl:with-param>
							<xsl:with-param name="id">beneficiary_img</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$nicknameEnabled='true' and security:isCustomer($rundata) and securitycheck:hasPermission($rundata,'sy_account_nickname_access')">
						<div id="beneficiary_name_nickname_row" class="field">
								<span class="label" id="ben_label">
									<xsl:attribute name="style">
										<xsl:choose>
											<xsl:when test="counterparties/counterparty/counterparty_act_nickname!=''">display:inline-block</xsl:when>
											<xsl:otherwise>display:none</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>			
									<xsl:value-of select="localization:getGTPString($language,'BENEFICIARY_NICKNAME_LABEL')"/>
								</span>
								<div id="ben_nickname" class="content">
									<xsl:attribute name="style">
										<xsl:choose>
											<xsl:when test="counterparties/counterparty/counterparty_act_nickname!=''">display:inline</xsl:when>
											<xsl:otherwise>display:none</xsl:otherwise>
										</xsl:choose>
								  </xsl:attribute>
								  <xsl:if test="counterparties/counterparty/counterparty_act_nickname!=''">
								 	<xsl:value-of select="counterparties/counterparty/counterparty_act_nickname"/> 
								  </xsl:if>
							</div> 
						</div>
					</xsl:if>
				    <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">beneficiary_act_cur_code</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:with-param>
				    </xsl:call-template>
				    <xsl:if test="$displaymode='edit'">
					    <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">beneficiary_account</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
					    </xsl:call-template>
				    </xsl:if>
				    <!-- <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">beneficiary_name</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
				    </xsl:call-template> -->
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bk_sub_product_code</xsl:with-param>
				    </xsl:call-template>
				     <xsl:call-template name="hidden-field">
						<xsl:with-param name="id">currency_res</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="currency_res"/></xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
		</xsl:call-template>
		</xsl:with-param>
		</xsl:call-template>
	 </xsl:with-param>
	</xsl:call-template>
	</xsl:template>
    
	<xsl:template name="int-transaction-details">	 	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			  <xsl:call-template name="column-container">
			     <xsl:with-param name="content">
			       <xsl:call-template name="column-wrapper">
			             <xsl:with-param name="content">
			         <xsl:call-template name="transaction-amt-details">
				       <xsl:with-param name="override-product-code">ft</xsl:with-param>
				     </xsl:call-template>				
				<xsl:if test="bulk_ref_id[.!=''] and sub_product_code [.='IBG' or .='IBGEX']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_BK_PARTICULARS</xsl:with-param>
						<xsl:with-param name="name">bk_particular</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="size">12</xsl:with-param>
						<xsl:with-param name="maxsize">12</xsl:with-param>	
					</xsl:call-template> 
				</xsl:if>

				<div id="transfer_date_div">
					<xsl:choose>
						<xsl:when test="$displaymode='edit' and bulk_ref_id[.='']">
							<xsl:call-template name="business-date-field">
								<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
								<xsl:with-param name="name">iss_date</xsl:with-param>
								<xsl:with-param name="size">10</xsl:with-param>
								<xsl:with-param name="maxsize">10</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
								<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
								<xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
								<xsl:with-param name="override-displaymode">
									<xsl:choose>
										<xsl:when test="bulk_ref_id[.='']">
											<xsl:choose>
												<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
					    						<xsl:otherwise>view</xsl:otherwise>
											</xsl:choose>
				  							</xsl:when>
				  							<xsl:otherwise>view</xsl:otherwise>
				  						</xsl:choose>
				  					</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">sub_product_code_custom</xsl:with-param>
				   			</xsl:call-template>
						</xsl:when>
						<xsl:when test="$displaymode='view'">				
							<xsl:if test="not(recurring_payment_enabled) or recurring_payment_enabled[.='N']">
								<xsl:call-template name="business-date-field">
									<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
									<xsl:with-param name="name">iss_date</xsl:with-param>
									<xsl:with-param name="size">10</xsl:with-param>
									<xsl:with-param name="maxsize">10</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
									<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
									<xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
									<!--<xsl:with-param name="override-displaymode">
										<xsl:choose>
											<xsl:when test="bulk_ref_id[.='']">
												<xsl:choose>
													<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
													<xsl:otherwise>view</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>view</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
								--></xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">sub_product_code_custom</xsl:with-param>
								</xsl:call-template>					
							</xsl:if>
						</xsl:when>
					</xsl:choose>	
				</div>				
			
						
				<!-- Verifying amount access from bulk -->
	   			<div>
					<xsl:if test="bulk_ref_id[.!='']">
						<xsl:variable name="transactionCodeRequired">
							<xsl:choose>
								<xsl:when test="sub_product_code[.='IBGEX'] or sub_product_code[.='IBG']">
									<xsl:value-of select="'Y'"></xsl:value-of>
								</xsl:when>
								<xsl:otherwise>	
									<xsl:value-of select="'N'"></xsl:value-of>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:if test="bulk_ref_id[.!=''] and transaction_code and transaction_code/transaction_codes[.!='']">
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_BK_TRANSACTION_CODE</xsl:with-param>
								<xsl:with-param name="name">bk_transaction_code</xsl:with-param>
								<xsl:with-param name="fieldsize">medium</xsl:with-param>
								<xsl:with-param name="required"><xsl:value-of select="$transactionCodeRequired"/></xsl:with-param>
								<xsl:with-param name="options">			       		
									<xsl:choose>
										<xsl:when test="$displaymode='edit'">
											<xsl:for-each select="transaction_code/transaction_codes">
												<option value="{transaction_code_id}">
													<xsl:value-of select="tranaction_code_des"/>
												</option>
											</xsl:for-each>
										</xsl:when>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
				</div>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="entity"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">ft_cur_code_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="ft_cur_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">applicant_act_cur_code_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="applicant_act_cur_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">ft_amt_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="ft_amt"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">recurring_start_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="recurring_start_date"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">recurring_end_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="recurring_end_date"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">				
					<xsl:with-param name="name">base_cur_code</xsl:with-param>
				    <xsl:with-param name="value" select="base_cur_code"></xsl:with-param>
				</xsl:call-template> 
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">payment_fee_details</xsl:with-param>
					<xsl:with-param name="id">payment_fee_details</xsl:with-param>
				</xsl:call-template>
				<!-- changes for report designer issue With INT transfer, added missing attributes as hidden fields -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">regexValue</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param>
				</xsl:call-template>						
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">allowedProducts</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_EXCLUDED_PRODUCTS')"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">product_type</xsl:with-param>
					<xsl:with-param name="value">INT</xsl:with-param>
				</xsl:call-template>
				<!-- <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">ref_id</xsl:with-param>
				</xsl:call-template> -->
				</xsl:with-param>
	    	</xsl:call-template>
	    	 <xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				 	<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
					<xsl:with-param name="name">cust_ref_id</xsl:with-param>
					<xsl:with-param name="size">16</xsl:with-param>
					<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
					<xsl:with-param name="regular-expression">
							<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
					</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
					<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
					<xsl:with-param name="size">19</xsl:with-param>
					<xsl:with-param name="maxsize">19</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				 </xsl:with-param>
			</xsl:call-template>	
			<xsl:call-template name="hidden-field"> 
  					<xsl:with-param name="name">tnx_cur_code</xsl:with-param> 
 				  </xsl:call-template>  
		   </xsl:with-param>
	       </xsl:call-template>
	    </xsl:with-param>
	  </xsl:call-template>				
	</xsl:template>
	
	<xsl:template name="int-general-details">
		<xsl:param name="show-template-id">Y</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			  <xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
			  <xsl:call-template name="column-wrapper">
			     <xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="bulk_ref_id[.!='']">
						<div id="display_bulk_ref_id_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/>&nbsp;</span>
							<div class="content"><xsl:value-of select="bulk_ref_id"/></div> 
						</div>
						<xsl:if test="entities[number(.) &gt; 0]">
							<div id="display_entity_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
								<div class="content"><xsl:value-of select="entity"/></div> 
							</div>
							<xsl:call-template name="hidden-field">
						       <xsl:with-param name="name">entity</xsl:with-param>
						    </xsl:call-template>
						</xsl:if>
						<!-- START- Multibank fields -->
						<div id="display_customer_bank_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BANK_LABEL')"/>&nbsp;</span>
							<div class="content" id="display_customer_bank"><xsl:value-of select="issuing_bank/name"/></div> 
						</div>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">customer_bank</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="customer_banks_details_ft/customer_bank"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="customer_banks_details_ft/customer_bank_hidden"/></xsl:with-param>
						</xsl:call-template>
						<!-- END- Multibank fields -->
						<xsl:call-template name="user-account-field">
				          <xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
				          <xsl:with-param name="name">applicant</xsl:with-param>
				          <xsl:with-param name="entity-field">entity</xsl:with-param>
				          <xsl:with-param name="dr-cr">debit</xsl:with-param>
				          <xsl:with-param name="show-product-types">N</xsl:with-param>
				          <xsl:with-param name="product_types">FT:INT</xsl:with-param>
				          <xsl:with-param name="product-types-required">Y</xsl:with-param>
				          <xsl:with-param name="required">Y</xsl:with-param>
				          <xsl:with-param name="override-displaymode">view</xsl:with-param>
				          <xsl:with-param name="isMultiBankParam">
					    		<xsl:choose>
					    			<xsl:when test="$isMultiBank='Y'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
					    		</xsl:choose>
					    	</xsl:with-param>
				         </xsl:call-template>
				         <xsl:call-template name="nickname-field-template"/>
						 <div id="display_sub_product_code_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>&nbsp;</span>
							<div class="content"><xsl:if test="sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', concat(sub_product_code,'_BK'))"/></xsl:if></div> 
						</div>
					</xsl:when>
					<xsl:otherwise>
					<!-- <xsl:if test="$isMultiBank!='Y' and $displaymode='view' and entities[number(.) &gt; 0]">-->
					<xsl:if test="$displaymode='view' and entity[.!=''] and sub_product_code[.!='INT']">                                   
 	 	 				 <div id="display_entity_row" class="field">
 	 	 				 <span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
 	 	 				 <div class="content"><xsl:value-of select="entity"/></div> 
 	 	 				 </div>                                                  
 	 				 </xsl:if>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_JURISDICTION_SUB_PRODUCT</xsl:with-param>	
							<xsl:with-param name="id">sub_product_view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', 'INT')"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="entities[number(.) &gt; 0] and $displaymode='edit'">	
							<xsl:call-template name="entity-field">
								<xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="button-type">entity</xsl:with-param>
							    <xsl:with-param name="prefix">applicant</xsl:with-param>
							    <xsl:with-param name="override-sub-product-code">FT:INT</xsl:with-param>
						    </xsl:call-template>
						</xsl:if>
						<!-- Bank to which beneficiary needs to be linked to. -->
						<xsl:if test="$isMultiBank='Y'">
							<xsl:call-template name="customer-bank-field"/>
						</xsl:if>
				    	<xsl:call-template name="user-account-field">
					     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
						    <xsl:with-param name="name">applicant</xsl:with-param>
						    <xsl:with-param name="entity-field">entity</xsl:with-param>
						    <xsl:with-param name="dr-cr">debit</xsl:with-param>
						    <xsl:with-param name="show-product-types">N</xsl:with-param>
						    <xsl:with-param name="product_types">FT:INT</xsl:with-param>
						    <xsl:with-param name="product-types-required">Y</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
						    <xsl:with-param name="isMultiBankParam">
	                            <xsl:choose>
	                                <xsl:when test="$isMultiBank='Y'">Y</xsl:when>
                    	                <xsl:otherwise>N</xsl:otherwise>
	                            </xsl:choose>
                            </xsl:with-param>
				    	</xsl:call-template>
				    	<xsl:call-template name="nickname-field-template"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$displaymode='edit'">
			        <script>
			        	dojo.ready(function(){
			        		misys._config = misys._config || {};
							misys._config.customerReferences = {};
							<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
						});
					</script>
				</xsl:if>
					<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="recurring_checkbox" />
				</xsl:if>
			
				</xsl:with-param>
			 </xsl:call-template>
				 <xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				  <xsl:if test="bulk_ref_id = ''">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
						<xsl:with-param name="value" select="issuing_bank/name" />
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="common-general-details">
					<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
					<xsl:with-param name="show-template-id">
						<xsl:choose>
							<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
							<xsl:otherwise><xsl:value-of select="$show-template-id"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>				  		
			</xsl:with-param>
		</xsl:call-template>
		</xsl:with-param>
		</xsl:call-template>
	  </xsl:with-param>
    </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="int-notify-beneficiary-details">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_FT_BENEFICIARY_NOTIFICATION</xsl:with-param>
					<xsl:with-param name="content">
					<div class="ft-notify-beneficiary-details">
						<div class="multioption-group-label">
							<!-- the dijits are declared directly here because of some limitations on the way they're disposed in 
							the page when using the templates. Particulary because radio and check box are centered and 
							when having a text box in the same line as a radio button -->
                            <div class="field checkbox">
    							<label for="notify_beneficiary">
    								<input dojoType="dijit.form.CheckBox" type="checkbox" name="notify_beneficiary" id="notify_beneficiary">
    									<xsl:if test="notify_beneficiary[.='Y']">
    										<xsl:attribute name="checked">checked</xsl:attribute>
    									</xsl:if>
    									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_NOTIFY_BENEFICIARY')"/>
    								</input>
    							</label>
                            </div>
                            <div class="field radio">
    							<label for="notify_beneficiary_choice_1" id="label_notify_beneficiary_choice_1">
    								<input dojoType="dijit.form.RadioButton" type="radio" name="notify_beneficiary_choice" id="notify_beneficiary_choice_1" value="default_email">
    									<xsl:if test="notify_beneficiary_choice[.='default_email']">
    										<xsl:attribute name="checked">checked</xsl:attribute>
    									</xsl:if>
    									<xsl:if test="not(notify_beneficiary[.='Y'])">
    										<xsl:attribute name="disabled">disabled</xsl:attribute>
    									</xsl:if>
    									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEFAULT_EMAIL')"/>
    								</input>
    							</label>
    							<xsl:if test="notify_beneficiary_choice[.='default_email']">
    								<span id="notify_beneficiary_email_node">
    									<div trim="true" dojoType="dijit.form.ValidationTextBox" name="notify_beneficiary_email" id="notify_beneficiary_email" 
    										maxLength="254" size="35" class="medium" value="{notify_beneficiary_email}" readOnly="readOnly" />
    								</span>
    							</xsl:if>
							</div>
                            <div class="field radio">
    							<label for="notify_beneficiary_choice_2" id="label_notify_beneficiary_choice_2">
    								<input dojoType="dijit.form.RadioButton" type="radio" name="notify_beneficiary_choice" id="notify_beneficiary_choice_2" value="alternative_email">
    									<xsl:if test="notify_beneficiary_choice[.='alternative_email']">
    										<xsl:attribute name="checked">checked</xsl:attribute>
    									</xsl:if>
    									<xsl:if test="not(notify_beneficiary[.='Y'])">
    										<xsl:attribute name="disabled">disabled</xsl:attribute>
    									</xsl:if>
    									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_ALTERNATIVE_EMAIL')"/>
    								</input>
    							</label>
    							<xsl:if test="not(notify_beneficiary_choice[.='default_email'])">
    								<span id="notify_beneficiary_email_node">
    									<div trim="true" dojoType="dijit.form.ValidationTextBox" name="notify_beneficiary_email" id="notify_beneficiary_email" 
    										maxLength="254" size="35" class="medium" value="{notify_beneficiary_email}">
    										<xsl:if test="not(notify_beneficiary[.='Y'])">
    											<xsl:attribute name="disabled">disabled</xsl:attribute>
    										</xsl:if>
    									</div>
    								</span>
    							</xsl:if>
                            </div>
						</div>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="notify_beneficiary[.='Y']">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_FT_BENEFICIARY_NOTIFICATION</xsl:with-param>
						<xsl:with-param name="content">
						  	<div id="notify_beneficiary_row" class="field">
								<span class="label">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_NOTIFY_BENEFICIARY')"/>
								</span>
								<div class="content">
									<xsl:value-of select="notify_beneficiary_email"/>
								</div>
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>			
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	
	<xsl:template name="transaction-amt-details">
	  <xsl:param name="override-product-code" select="$lowercase-product-code"/>
	  <div>
	     <xsl:choose>
	     <xsl:when test="$displaymode='edit'">
	     <xsl:call-template name="select-field">
		     <xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
		     <xsl:with-param name="name">ft_cur_code</xsl:with-param>
		     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
		     <xsl:with-param name="required">Y</xsl:with-param>
		     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
		     <xsl:with-param name="readonly">N</xsl:with-param>
		      <xsl:with-param name="options">
			     <option value="{ft_cur_code}">
						<xsl:value-of select="ft_cur_code"/>
				 </option>
			 </xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="currency-field">
		     <xsl:with-param name="fieldsize">small</xsl:with-param>
		     <xsl:with-param name="product-code">ft</xsl:with-param>
		     <xsl:with-param name="show-currency">N</xsl:with-param>
		     <xsl:with-param name="show-button">N</xsl:with-param>
		     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select="ft_amt"/></xsl:with-param>
		     <xsl:with-param name="override-amt-name">ft_amt</xsl:with-param>
		     <xsl:with-param name="required">Y</xsl:with-param>
	     </xsl:call-template>
	     </xsl:when>
	     <xsl:when test="$displaymode='view'">
	      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
	       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_amt</xsl:with-param>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       <xsl:with-param name="value">
	         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
	         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
	         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
		     <xsl:if test="$field-value !=''">
		      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
		     </xsl:if>
		   </xsl:with-param>
	      </xsl:call-template>
		 </xsl:when>
	     </xsl:choose>
	  </div>
	  </xsl:template>							   	

</xsl:stylesheet>