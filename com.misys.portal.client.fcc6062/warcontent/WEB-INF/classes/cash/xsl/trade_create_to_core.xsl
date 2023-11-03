<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer Order (TO) Form, Customer Side.
 
Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      16/02/11
author:    Marzin Pascal
email:     Marzin.Pascal@misys.com
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        exclude-result-prefixes="localization">
       
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">TO</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TransferOrderScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="cash_common.xsl" />
  <xsl:include href="request_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="to_tnx_record"/>
  </xsl:template>
  
  <!-- 
   TO TNX FORM TEMPLATE.
  -->
  <xsl:template match="to_tnx_record">
	<!-- Preloader  -->
	<xsl:call-template name="loading-message"/>
		<div >
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!--  Display common menu. -->
					<xsl:call-template name="menu">
						<xsl:with-param name="show-save">N</xsl:with-param>
						<xsl:with-param name="show-template">N</xsl:with-param>
					</xsl:call-template>
					      
					<!-- Disclaimer Notice -->
					 <xsl:call-template name="disclaimer"/>
					      
					<xsl:apply-templates select="cross_references" mode="hidden_form"/>
					<xsl:call-template name="hidden-fields"/>
					<xsl:call-template name="general-details" />
					<!-- Choose Actions -->
					<xsl:if test="tnxtype[.='02']">
						<xsl:call-template name="action-details"/>
					</xsl:if>
					<!-- Details -->
					<xsl:call-template name="to-transfer-details"/>
					<!-- Account popup -->
					<xsl:call-template name="account-popup">
						<xsl:with-param name="id">orderingAccount</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="realform"/>
		    
			<xsl:call-template name="menu">
				<xsl:with-param name="show-save">N</xsl:with-param>
				<xsl:with-param name="show-template">N</xsl:with-param>
				<xsl:with-param name="second-menu">Y</xsl:with-param>
			</xsl:call-template>
		</div>
     
		<!-- Table of Contents -->
		<xsl:call-template name="toc"/>
  
		<!--  Collaboration Window -->     
<!--		<xsl:call-template name="collaboration">-->
<!--			<xsl:with-param name="editable">true</xsl:with-param>-->
<!--			<xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>-->
<!--			<xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
				<xsl:with-param name="bank_name_widget_id"></xsl:with-param>
				<xsl:with-param name="bank_abbv_name_widget_id"></xsl:with-param>-->
<!--		</xsl:call-template>-->
  
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
		<xsl:with-param name="binding">misys.binding.cash.TradeCreateToBinding</xsl:with-param>
	</xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
	<xsl:call-template name="common-hidden-fields">
	 <xsl:with-param name="additional-fields">
	  <xsl:call-template name="hidden-field">
 		<xsl:with-param name="name">bo_tnx_id</xsl:with-param> 
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bo_ref_id</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">applicantName</xsl:with-param>
	  </xsl:call-template>
	 </xsl:with-param>
	</xsl:call-template>
 </xsl:template>

  <xsl:template name="action-details">
	<div id="action-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ACTION_DETAILS</xsl:with-param>
			<xsl:with-param name="content"> 
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_TD_UPDATE_ACTION_LABEL</xsl:with-param>
					<xsl:with-param name="name">to_action</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="options">
						<option value=""></option>
						<option value="18">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TO_UPDATE_ACTION_LABEL')"/>
						</option>
						<option value="22">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TO_DELETE_ACTION_LABEL')"/>
						</option>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</div>
 </xsl:template>

 <!--
   TO General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   
    	<xsl:with-param name="button-type"><xsl:if test="tnxtype[.='02']">summary-details</xsl:if></xsl:with-param>
   
    <xsl:with-param name="content">
     <div id="generaldetails">
      <!-- Common general details. -->
   		<xsl:call-template name="common-general-details">
			<xsl:with-param name="show-template-id">N</xsl:with-param>
		</xsl:call-template>
      	<!-- Applicant Details -->
			<!-- Hidden fields since show-name and show-address disabled after -->
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_name</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_name"/>
		     </xsl:call-template>
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_address_line_1"/>
		     </xsl:call-template>
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_address_line_2"/>
		     </xsl:call-template>
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_dom</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_dom"/>
		     </xsl:call-template>
		    <xsl:if test="entities[.!='0']">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:if test="$displaymode='edit'">
							<script>
								dojo.ready(function(){
									misys._config = misys._config || {};
									misys._config.customerReferences = {};
									<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
								});
							</script>
						</xsl:if>
						<!-- Applicant Details -->				
						<xsl:call-template name="address">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-name">N</xsl:with-param>
							<xsl:with-param name="show-address">N</xsl:with-param>
							<xsl:with-param name="prefix">applicant</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
    	<xsl:call-template name="input-field">
          <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
          <xsl:with-param name="name">applicant_reference</xsl:with-param>
          <xsl:with-param name="readonly">Y</xsl:with-param>
          <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
         </xsl:call-template>
     </div>    
       </xsl:with-param>
      </xsl:call-template>
  </xsl:template>
  
  <!-- 
   TO Transfer Details
   -->
  <xsl:template name="to-transfer-details">
  	<div id="to-transfer-details">
  	<xsl:if test="tnxtype[.='02']">
  		<xsl:attribute name="style">display:none</xsl:attribute>
  	</xsl:if>
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="parseWidgets">
		<xsl:choose>
			<xsl:when test="tnxtype[.='02']">N</xsl:when>
			<xsl:otherwise>Y</xsl:otherwise>
		</xsl:choose>
	</xsl:with-param>
		<xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<!-- Ordering details -->
			<xsl:if test="$displaymode='edit'">
				<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.customerReferences = {};
						<xsl:apply-templates select="avail_main_banks/bank"	mode="customer_references" />
					});
				</script>
			</xsl:if>
			<xsl:if test="isMultipleCounterparties">
				<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_LABEL</xsl:with-param>
				<xsl:with-param name="name">multipleCT</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="isMultipleCounterparties"/></xsl:with-param>
			</xsl:call-template>
			</xsl:if>
<!--					<xsl:call-template name="main-bank-selectbox">-->
<!--						<xsl:with-param name="label">-->
<!--							<xsl:choose>-->
<!--								<xsl:when test="ft_type[.='01']">XSL_PARTIESDETAILS_BANK_NAME</xsl:when>-->
<!--								<xsl:otherwise>XSL_PARTIESDETAILS_BANK_NAME</xsl:otherwise>-->
<!--							</xsl:choose>-->
<!--						</xsl:with-param>-->
<!--						<xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>-->
<!--						<xsl:with-param name="sender-name">applicant</xsl:with-param>-->
<!--						<xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>-->
<!--					</xsl:call-template>-->
<!--					<xsl:call-template name="customer-reference-selectbox">-->
<!--						<xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>-->
<!--						<xsl:with-param name="sender-name">applicant</xsl:with-param>-->
<!--						<xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>-->
<!--					</xsl:call-template>-->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_LABEL</xsl:with-param>
				<xsl:with-param name="name">applicant_act_no</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="button-type">account</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_ACCOUNT_NAME</xsl:with-param>
				<xsl:with-param name="name">applicant_act_name</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_CURRENCY</xsl:with-param>
				<xsl:with-param name="product-code">applicant_act</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
			<!-- Period -->
			<div id="periodicity-div">
			<xsl:call-template name="multioption-group">
				<xsl:with-param name="group-label">XSL_TO_PERIOD_LABEL</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_ANNUAL_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_annual</xsl:with-param>
						<xsl:with-param name="value">ANNUAL</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_SEMI_ANNUAL_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_semi_annual</xsl:with-param>
						<xsl:with-param name="value">SEMI_ANNUAL</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_QUATERLY_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_quaterly</xsl:with-param>
						<xsl:with-param name="value">QUARTERLY</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_MONTHLY_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_monthly</xsl:with-param>
						<xsl:with-param name="value">MONTHLY</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_FORTNIGHTLY_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_fortnightly</xsl:with-param>
						<xsl:with-param name="value">FORTNIGHTLY</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_WEEKLY_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_weekly</xsl:with-param>
						<xsl:with-param name="value">WEEKLY</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_DAILY_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_daily</xsl:with-param>
						<xsl:with-param name="value">DAILY</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="tnxtype[.='01']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PERIOD_ONCE_LABEL</xsl:with-param>
						<xsl:with-param name="name">periode</xsl:with-param>
						<xsl:with-param name="id">periode_once</xsl:with-param>
						<xsl:with-param name="value">ONCE</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			</div>
			<xsl:call-template name="multioption-group">
				<xsl:with-param name="group-label">XSL_TO_PAY_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PAY_DATE_PREC_LABEL</xsl:with-param>
						<xsl:with-param name="name">pay_date</xsl:with-param>
						<xsl:with-param name="id">pay_date_prec</xsl:with-param>
						<xsl:with-param name="value">PRECEDING</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PAY_DATE_SUCC_LABEL</xsl:with-param>
						<xsl:with-param name="name">pay_date</xsl:with-param>
						<xsl:with-param name="id">pay_date_succ</xsl:with-param>
						<xsl:with-param name="value">SUCCEEDING</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PAY_DATE_MOD_LABEL</xsl:with-param>
						<xsl:with-param name="name">pay_date</xsl:with-param>
						<xsl:with-param name="id">pay_date_mod</xsl:with-param>
						<xsl:with-param name="value">MODIFIED</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_TO_PAY_DATE_DEF_LABEL</xsl:with-param>
						<xsl:with-param name="name">pay_date</xsl:with-param>
						<xsl:with-param name="id">pay_date_def</xsl:with-param>
						<xsl:with-param name="value">DEFAULT</xsl:with-param>
						<xsl:with-param name="checked">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TO_FIRST_PAY_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">first_payement_date</xsl:with-param>
				<xsl:with-param name="maxsize">10</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
			    <xsl:with-param name="label">XSL_TO_FIRST_PAY_AMT_LABEL</xsl:with-param>
			    <xsl:with-param name="product-code">first_payement</xsl:with-param>
			    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
			    <xsl:with-param name="override-currency-value"><xsl:value-of select="to_cur_code"/></xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			    <xsl:with-param name="show-button">N</xsl:with-param>
			</xsl:call-template>
			<br/>
			<div id="periode-div">
				<!--end of payement_day -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_TO_NEXT_PAY_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="name">next_payement_date</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<!-- payement_day -->
				<!-- the good select box is selected with periode selection -->
				<div id="payement-day-days">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_TO_PAY_DAY_LABEL</xsl:with-param>
						<xsl:with-param name="name">payement_day_days</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						<xsl:with-param name="options">
					       <xsl:choose>
		    				  <xsl:when test="$displaymode='edit'">
						     	<xsl:call-template name="daynumber-options"/>
						      </xsl:when>
		             		  <xsl:otherwise>
		             		  		<xsl:if test="periode!='WEEKLY' and period!='FORTHNIGHTLY'">
			                  			<xsl:value-of select="payement_day"/>
			                  		</xsl:if>
		             		  </xsl:otherwise>
		             		</xsl:choose>  
						</xsl:with-param>
					</xsl:call-template>
				</div>
				<div id="payement-day-weeks">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_TO_PAY_DAY_LABEL</xsl:with-param>
						<xsl:with-param name="name">payement_day_weeks</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="options">
					       <xsl:choose>
		    				  <xsl:when test="$displaymode='edit'">
									<xsl:call-template name="dayofweek-options"/>
						      </xsl:when>
		             		  <xsl:otherwise>
		             		  		<xsl:if test="periode='WEEKLY' or period='FORTHNIGHTLY'">
		             		  			<xsl:value-of select="payement_day"/>
<!--										<xsl:value-of select="localization:getDecode($language, 'N082', payement_day_weeks)"/>-->
									</xsl:if>
		             		  </xsl:otherwise>
		             		</xsl:choose>  
						</xsl:with-param>
					</xsl:call-template>
				</div>
				<!-- Value field in javascipt with good select box value -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">payement_day</xsl:with-param>
				</xsl:call-template>
				<!-- Payment amount -->
				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_TO_PAY_AMT_LABEL</xsl:with-param>
				    <xsl:with-param name="product-code">to</xsl:with-param>
				    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="to_cur_code"/></xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
			</div>
			<br/>
			<div id="final-payement-div">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_TO_FINAL_PAY_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="name">final_payement_date</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_TO_FINAL_PAY_AMT_LABEL</xsl:with-param>
				    <xsl:with-param name="product-code">final_payement</xsl:with-param>
				    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
				    <xsl:with-param name="show-button">N</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="to_cur_code"/></xsl:with-param>
				</xsl:call-template>
				<br></br>
			</div>
<!--			<xsl:call-template name="input-field">-->
<!--				<xsl:with-param name="label">XSL_TO_TRANSACTION_CODE_LABEL</xsl:with-param>-->
<!--				<xsl:with-param name="name">transaction_code</xsl:with-param>-->
<!--				<xsl:with-param name="maxsize">10</xsl:with-param>-->
<!--				<xsl:with-param name="fieldsize">small</xsl:with-param>-->
<!--				<xsl:with-param name="required">N</xsl:with-param>-->
<!--			</xsl:call-template>-->
<!--			<xsl:call-template name="input-field">-->
<!--				<xsl:with-param name="label">XSL_TO_PROCESSING_DAY_LABEL</xsl:with-param>-->
<!--				<xsl:with-param name="name">processing_days</xsl:with-param>-->
<!--				<xsl:with-param name="maxsize">3</xsl:with-param>-->
<!--				<xsl:with-param name="type">number</xsl:with-param>-->
<!--				<xsl:with-param name="fieldsize">x-small</xsl:with-param>-->
<!--				<xsl:with-param name="required">N</xsl:with-param>-->
<!--			</xsl:call-template>-->
			
			<!-- 
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
				<xsl:with-param name="label">XSL_TO_DESCRIPTION_LABEL</xsl:with-param>
				<xsl:with-param name="type">textarea</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="textarea-field">
						<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
						<xsl:with-param name="rows">4</xsl:with-param>
						<xsl:with-param name="maxlines">4</xsl:with-param>
						<xsl:with-param name="cols">35</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			 -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TO_STANDING_ORDER_TEXT_LABEL</xsl:with-param>
				<xsl:with-param name="name">standing_order_text</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
			<!-- 
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TO_ACCOUNT_OWNER_REF_LABEL</xsl:with-param>
				<xsl:with-param name="name">account_owner_ref</xsl:with-param>
				<xsl:with-param name="maxsize">16</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
			 -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TO_USUAL_ID_LABEL</xsl:with-param>
				<xsl:with-param name="name">usual_id</xsl:with-param>
				<xsl:with-param name="maxsize">15</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="$displaymode='view'">
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">review_bo_ref_id</xsl:with-param>
					<xsl:with-param name="label">XSL_TO_DEAL_SUMMARY_LABEL_ORDER_NUMBER</xsl:with-param>
					<xsl:with-param name="value" select="bo_ref_id"/>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">review_executionDate</xsl:with-param>
					<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_APPLICATION_DATE</xsl:with-param>
					<xsl:with-param name="value" select="appl_date"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	</div>
</xsl:template>
 
  <!--
   Hidden fields for Letter of Credit 
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
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
       <xsl:with-param name="value" select="$mode"/>
      </xsl:call-template> 
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="tnxtype"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">displaymode</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$displaymode"/></xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>