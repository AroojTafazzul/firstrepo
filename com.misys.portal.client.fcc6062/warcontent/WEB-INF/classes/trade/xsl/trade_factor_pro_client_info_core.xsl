<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

Factoring (FA) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      25/03/2011
author:    Ramesh M
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization security">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">FA</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FactoringScreen</xsl:param>
   
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
  <xsl:template match="/">
    <xsl:apply-templates select="fa_tnx_record"/>
  </xsl:template>
    
   <xsl:template name="hidden-fields">
    <xsl:call-template name="common-hidden-fields">
     <xsl:with-param name="show-type">N</xsl:with-param>
    </xsl:call-template>
   </xsl:template>
  
  <!-- 
   FA TNX FORM TEMPLATE.
  -->
  <xsl:template match="fa_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
	
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">

      
            
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
      </xsl:with-param>
    </xsl:call-template>
        

    <xsl:call-template name="realform"/>
   </div>

   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
  <!--  Collaboration Window -->     

  	<xsl:call-template name="collaboration">
     <xsl:with-param name="editable">true</xsl:with-param>
     <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
     <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
   </xsl:call-template>
 
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template> 

  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.client_avail_info_fa</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
     Common General Details
  -->

  <xsl:template name="general-details">
  <div id="clientActInfo">
	  <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_FACTOR_PRO_ACCOUNT_INFO</xsl:with-param>
	    <xsl:with-param name="content">    
	    <xsl:call-template name="factor_pro_client_avail_header_info"/>
	  </xsl:with-param>
	  
	  </xsl:call-template> 
	    <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_FACTOR_PRO_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">    
	    <xsl:call-template name="factor_pro_client_avail_info"/>
	    </xsl:with-param>
	  </xsl:call-template>
	   <a href="javascript:void(0)" onclick="misys.viewExposureEnquiry();">
	   <xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_EXPOSURE_ENQUIRY')"/></a>
  </div>
  <div id="clientExpoInfo">
	  <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_FACTOR_PRO_DEBTOR_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">    
	    <xsl:call-template name="factor_pro_client_avail_header_info"/>
	  </xsl:with-param>
	  </xsl:call-template>
	  <xsl:for-each select="client_expo_info/client_expo_info">
	  <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CUSTOMER_SHORT_NAME')"/>&nbsp;<xsl:value-of select="customer_code"></xsl:value-of> - <xsl:value-of select="customer_short_name" /></xsl:with-param>
	    <xsl:with-param name="localized">N</xsl:with-param>
	    <xsl:with-param name="content">   
	     
	    <xsl:call-template name="factor_pro_details"/>
	    
	  </xsl:with-param>
	  </xsl:call-template> 
	  </xsl:for-each>
	  
	  <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_FACTOR_PRO_EXPO_TOTAL</xsl:with-param>
	    <xsl:with-param name="content">    
	    <xsl:call-template name="factor_pro_expo_total"/>
	  </xsl:with-param>
	  </xsl:call-template>
	  <a href="javascript:void(0)" onclick="misys.hideDebtorDetails();">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_CLIENT_AVAIL_INFO')"/></a> 
   </div>    
  </xsl:template> 
  
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

   <xsl:template name="factor_pro_client_avail_header_info">
    <table border="0" width="100%" cellpadding="0" cellspacing="0" style='table-layout:fixed'>
      <xsl:if test="client_avail_info/client_avail_info/entity[.!='']">
      <tr>      
        <th><b><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></b></th>        
        	<td><xsl:value-of select="client_avail_info/client_avail_info/entity" /></td>
      </tr>
      </xsl:if>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CLIENT_CODE')"/></b></th>
        <td><xsl:value-of select="client_avail_info/client_avail_info/client_code" />-<xsl:value-of select="client_avail_info/client_avail_info/client_short_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ACCOUNT_TYPE')"/></b></th>
        <td><xsl:value-of select="client_avail_info/client_avail_info/account_type_des" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ADVANCE_CURRENCY')"/></b></th>
        <td><xsl:value-of select="client_avail_info/client_avail_info/adv_currency" /> - <xsl:value-of select="client_avail_info/client_avail_info/adv_currency_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_MAX_ADV_LIMIT')"/></b></th>
        <td><xsl:value-of select="client_avail_info/client_avail_info/client_mal" /></td>
      </tr>
    </table> 
  </xsl:template>

  <xsl:template name="factor_pro_client_avail_info">

    <table border="0" width="100%">
     
      <tr>
        <td width="300"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_APROVED_DEBTS')"/></b></td>
        <td width="200"/>
        <td width="100"/>
		<td width="250"/>
        <td width="200" class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/approved_debts_sign" /><xsl:value-of select="client_avail_info/client_avail_info/approved_debts" /></td>
      </tr>
      <tr>
        <td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_UNAPPROVED_DEBTS')"/></b></td>
        <td/>
        <td/>
		<td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/unapproved_debts_sign" /><xsl:value-of select="client_avail_info/client_avail_info/unapproved_debts" /></td>
      </tr>
      <tr>
        <td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OUTSTANDING_BAL')"/></b></td>
        <td/>
        <td/>
		<td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/os_bal_sign" /><xsl:value-of select="client_avail_info/client_avail_info/os_bal" /></td>
      </tr>
      <tr>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_LESS')"/></b></td>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DISPUTE')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/dispute_sign" /><xsl:value-of select="client_avail_info/client_avail_info/dispute" /></td>
        <td/>
        <td></td>
      </tr>
      
      <tr>
        <td></td>
        <td class="alignLeft" ><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_INELIGIBLE_INVOICE')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/ineligible_invoice_sign" /><xsl:value-of select="client_avail_info/client_avail_info/ineligible_invoice" /></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
       	<td class="alignLeft" ><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_RESERVE')"/></b></td>
       	<td/>
       	<td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/reserve_sign" /><xsl:value-of select="client_avail_info/client_avail_info/reserve" /></td>
        <td></td>
      </tr>
      <tr>
        <td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_AVAIL_BEFORE_FIU_BAL')"/></b></td>
        <td/>
        <td/>
		<td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/avail_before_fiu_bal_sign" /><xsl:value-of select="client_avail_info/client_avail_info/avail_before_fiu_bal" /></td>
      </tr>
      <tr>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_FIU_BAL_LESS_ADD')"/></b></td>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_FIU_BAL_LESS_ADD_FIU_BALANCE')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/fiu_bal_sign" /><xsl:value-of select="client_avail_info/client_avail_info/fiu_bal" /></td>
        <td/>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ADDL_RESERVES')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/addl_reserves_sign" /><xsl:value-of select="client_avail_info/client_avail_info/addl_reserves" /></td>
        <td></td>
      </tr>
      <tr>
       <td></td>
       <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_PREV_REQUESTED')"/></b></td>
       <td/>
       <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/prev_requested_sign" /><xsl:value-of select="client_avail_info/client_avail_info/prev_requested" /></td>
        <td></td>
      </tr>
      <tr>
        <td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_AMT_BEFORE_ON_ACCOUNT')"/></b></td> 
        <td/>
        <td/>
		<td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/amt_before_on_acc_payment_sign" /><xsl:value-of select="client_avail_info/client_avail_info/amt_before_on_acc_payment" /></td>       
      </tr>
      <tr>
        <td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_PAYMENT_OVER_PAYMENT')"/></b></td>
        <td/>
        <td/>
		<td/>
		<td/>
	  </tr>
      <tr>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_FIU_BAL_LESS_ADD')"/></b></td>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVER_PAYMENT_LESS_ADD_OVER_PAYMENT')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/over_payment_sign" /><xsl:value-of select="client_avail_info/client_avail_info/over_payment" /></td>
		<td/>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ON_ACCOUNT_PAYMENT')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/on_acc_payment_sign" /><xsl:value-of select="client_avail_info/client_avail_info/on_acc_payment" /></td>
        <td></td>
      </tr>
      <tr>
        <td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DRAWDOWN_AMT_AVAILABLE')"/></b></td>
        <td/>
        <td/>
		<td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/amt_avail_for_adv_payment_sign" /><xsl:value-of select="client_avail_info/client_avail_info/amt_avail_for_adv_payment" /></td>
      </tr>
      <tr>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_ADV_PLUS_REQUEST')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/total_adv_plus_request_sign" /><xsl:value-of select="client_avail_info/client_avail_info/total_adv_plus_request" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DEBTOR_ACTUAL_OMAL')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/customer_actual_omal_sign" /><xsl:value-of select="client_avail_info/client_avail_info/customer_actual_omal" /></td>
      </tr>
      <tr>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CLIENT_MAL')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/client_mal_sign" /><xsl:value-of select="client_avail_info/client_avail_info/client_mal" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DEBTOR_THEORETICAL_OMAL')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/customer_theoretical_omal_sign" /><xsl:value-of select="client_avail_info/client_avail_info/customer_theoretical_omal" /></td>
      </tr>
      <tr>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVER_CLIENT_MAL')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/over_client_mal_sign" /><xsl:value-of select="client_avail_info/client_avail_info/over_client_mal" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ELIGIBLE_INITIAL_DEBT')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/eligible_initial_debt_sign" /><xsl:value-of select="client_avail_info/client_avail_info/eligible_initial_debt" /></td>
      </tr>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVER_CLIENT_LIMIT')"/></b></td>
        <td/>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/over_credit_limit_sign" /><xsl:value-of select="client_avail_info/client_avail_info/over_credit_limit" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CHQ_PENDING_CLEARANCE_AMT')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_avail_info/client_avail_info/chq_pending_clearance_amt_sign" /><xsl:value-of select="client_avail_info/client_avail_info/chq_pending_clearance_amt" /></td>
      <tr>
      </tr>
    </table><br></br>
  </xsl:template>
  
  <xsl:template name="factor_pro_details">

    <table border="0" width="100%" cellpadding="0" cellspacing="0" style='table-layout:fixed'> 
       
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CREDIT_LIMIT')"/></b></td>
        <td class="alignRight"><xsl:value-of select="credit_limit_sign" /><xsl:value-of select="credit_limit" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_MAX_ADV_LIMIT')"/></b></td>
        <td class="alignRight"><xsl:value-of select="max_adv_limit_sign" /><xsl:value-of select="max_adv_limit" /></td>
      </tr>
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OS_BALANCE')"/></b></td>
        <td class="alignRight"><xsl:value-of select="os_bal_sign" /><xsl:value-of select="os_bal" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DISPUTES')"/></b></td>
        <td class="alignRight"><xsl:value-of select="dispute_sign" /><xsl:value-of select="dispute" /></td>
      </tr>
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_APROVED_DEBTS')"/></b></td>
        <td class="alignRight"><xsl:value-of select="approved_debts_sign" /><xsl:value-of select="approved_debts" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_INELIGIBLE_INVOICE')"/></b></td>
        <td class="alignRight"><xsl:value-of select="ineligible_invoice_sign" /><xsl:value-of select="ineligible_invoice" /></td>
      </tr>
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_UNAPPROVED_DEBTS')"/></b></td>
        <td class="alignRight"><xsl:value-of select="unapproved_debts_sign" /><xsl:value-of select="unapproved_debts" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_UNFUNDED_INVOICE')"/></b></td>
        <td class="alignRight"><xsl:value-of select="unfunded_invoice_amt_sign" /><xsl:value-of select="unfunded_invoice_amt" /></td>
      </tr>
    
    </table><br></br>    
  </xsl:template>
  
  <xsl:template name="factor_pro_expo_total">

    <table border="0" width="100%" cellpadding="0" cellspacing="0" style='table-layout:fixed'>
     <xsl:if test="count(client_expo_info/client_expo_info) > 0">
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_CREDIT_LIMIT')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_credit_limit_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_credit_limit" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_MAX_ADV_LIMIT')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_max_adv_limit_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_max_adv_limit" /></td>
      </tr>
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_OS_BAL')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_os_balance_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_os_balance" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_DISPUTES')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_dispute_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_dispute" /></td>
      </tr>
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_APPROVED_DEBTS')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_appr_debts_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_appr_debts" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_INELIGIBLE_INVOICE')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_ineligible_invc_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_ineligible_invc" /></td>
      </tr>
      <tr>
        <td class="alignLeft"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_UNAPPROVED_DEBTS')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_unappr_debts_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_unappr_debts" /></td>
        <td class="alignRight"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_UNFUNDED_INVOICE')"/></b></td>
        <td class="alignRight"><xsl:value-of select="client_expo_info/client_expo_info/total_unfunded_invc_amt_sign" /><xsl:value-of select="client_expo_info/client_expo_info/total_unfunded_invc_amt" /></td>
      </tr>
      </xsl:if>
    </table><br></br>	
  </xsl:template> 

 </xsl:stylesheet>