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
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization security">
		
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  
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
  <xsl:param name="main_bank_abbv_name_begin"><xsl:value-of select="fa_tnx_record/client_avail_info/client_avail_info/main_bank_abbv_name"/></xsl:param>
  <xsl:param name="main_bank_abbv_name_draft"><xsl:value-of select="fa_tnx_record/issuing_bank/abbv_name"/></xsl:param>
  <xsl:param name="main_bank_name"><xsl:value-of select="fa_tnx_record/account_type_info/client_act_infos/main_bank_name"/></xsl:param>
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bk_upl_trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
  <xsl:template match="/">
    <xsl:apply-templates select="fa_tnx_record"/>
  </xsl:template>
    
   <xsl:template name="hidden-fields">
    <xsl:call-template name="common-hidden-fields">
     <xsl:with-param name="show-type">N</xsl:with-param>
    </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">applicant_reference</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="applicant_reference"/></xsl:with-param>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
	   <xsl:with-param name="value" select="issuing_bank/name"/>
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
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="show-template">N</xsl:with-param>
        <xsl:with-param name="show-reject">Y</xsl:with-param>
      </xsl:call-template>
      
            
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
      </xsl:with-param>
    </xsl:call-template>
        

    <xsl:call-template name="realform"/>
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
      <xsl:with-param name="show-reject">Y</xsl:with-param>
    </xsl:call-template>
   </div>

   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
  <!--  Collaboration Window -->     

  	<xsl:call-template name="collaboration">
     <xsl:with-param name="editable">true</xsl:with-param>
     <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
     <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
     <xsl:with-param name="bank_name_widget_id">main_bank_name</xsl:with-param>
     <xsl:with-param name="bank_abbv_name_widget_id">main_bank_abbv_name</xsl:with-param>
	</xsl:call-template>
 
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
   
    <!-- Add the definition of columns (used in the RTE editor) -->
  <xsl:if test="$displaymode = 'edit'">
      
   <!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
   <xsl:call-template name="Products_Columns_Candidates"/>
  </xsl:if>
   
   
  </xsl:template> 

  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.create_fa</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
     Common General Details, Applicant Details, Beneficiary Details.
  -->
    
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    
    <xsl:call-template name="common-general-details-client"/>
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
   	</xsl:with-param>
   	</xsl:call-template>

	<xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
	  <xsl:with-param name="label">XSL_REQUEST_MAX_AMOUNT</xsl:with-param>
	  <xsl:with-param name="name">request_max_amt</xsl:with-param>
	</xsl:call-template>		   
	 
	  <!-- FA Currency and Amount -->
	  <xsl:if test="account_type_info">
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_FA_AMT_LABEL</xsl:with-param>
	   <xsl:with-param name="product-code">fa</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="currency-readonly">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>  
       <xsl:with-param name="override-currency-value"><xsl:value-of select="account_type_info/client_act_infos/adv_currency"/></xsl:with-param>
  	  <xsl:with-param name="override-amt-value"><xsl:value-of select="client_avail_info/client_avail_info/amt_avail_for_adv_payment"/></xsl:with-param>  	    
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="not(account_type_info)">
	     <xsl:call-template name="currency-field">
	       <xsl:with-param name="label">XSL_AMOUNTDETAILS_FA_AMT_LABEL</xsl:with-param>
		   <xsl:with-param name="product-code">fa</xsl:with-param>
	       <xsl:with-param name="required">Y</xsl:with-param>
	       <xsl:with-param name="currency-readonly">Y</xsl:with-param>
	       <xsl:with-param name="show-button">N</xsl:with-param>  
	       <xsl:with-param name="override-currency-value"><xsl:value-of select="adv_currency"/></xsl:with-param>
	  	  <xsl:with-param name="override-amt-value"><xsl:value-of select="tnx_amt"/></xsl:with-param>  	    
	     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$displaymode='edit'">
     <div style="text-align:left; margin-left: 25%;font-weight:bold;"><xsl:value-of select="localization:getGTPString($language, 'FACTORING_CLAUSE')"/></div>
     </xsl:if>
     </xsl:with-param>
     </xsl:call-template>  
           
  </xsl:template>
 
  <!--
   Hidden fields for Factoring
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
      <xsl:if test="client_avail_info">
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">main_bank_abbv_name</xsl:with-param>
	    	<xsl:with-param name="value" select="$main_bank_abbv_name_begin"/>
		</xsl:call-template>
	  </xsl:if>
	<xsl:if test="not(client_avail_info)">
	  <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">main_bank_abbv_name</xsl:with-param>
	    <xsl:with-param name="value" select="$main_bank_abbv_name_draft"/>
	  </xsl:call-template>
	</xsl:if>
	<xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">main_bank_name</xsl:with-param>
	  <xsl:with-param name="value" select="$main_bank_name"/>
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
      <xsl:with-param name="name">curCode</xsl:with-param>
      <xsl:with-param name="value" select="adv_currency"/>
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
     <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="common-general-details-client">
    <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>   
   	 <xsl:if test="account_type_info">
   	 <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">entity</xsl:with-param>
	    <xsl:with-param name="value" select="account_type_info/client_act_infos/entity" />
	 </xsl:call-template>
	 </xsl:if>	
	 <xsl:if test="not(account_type_info)">
	 <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">entity</xsl:with-param>
	    <xsl:with-param name="value" select="entity" />
	 </xsl:call-template> 
	 </xsl:if>	 
	 <xsl:if test="account_type_info">
	 <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">client_code</xsl:with-param>
		<xsl:with-param name="value" select="account_type_info/client_act_infos/client_code"/>
	 </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(account_type_info)">
	 <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">client_code</xsl:with-param>
		<xsl:with-param name="value" select="client_code"/>
	 </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="account_type_info">	
	 <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">short_name</xsl:with-param>
		<xsl:with-param name="value" select="account_type_info/client_act_infos/short_name"/>
	 </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(account_type_info)">	
	 <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">short_name</xsl:with-param>
		<xsl:with-param name="value" select="short_name"/>
	 </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="account_type_info">         
    <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">account_type</xsl:with-param>
	    <xsl:with-param name="value" select="account_type_info/client_act_infos/account_type"/>
   	</xsl:call-template>
   	</xsl:if>
   	<xsl:if test="not(account_type_info)">
   	<xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">account_type</xsl:with-param>
	    <xsl:with-param name="value" select="account_type"/>
   	</xsl:call-template> 
   	</xsl:if>
   	<xsl:if test="account_type_info">
   	<xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">account_type_des</xsl:with-param>
	    <xsl:with-param name="value" select="account_type_info/client_act_infos/account_type_des"/>
   	</xsl:call-template>
   	</xsl:if>
   	<xsl:if test="not(account_type_info)">
   	<xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">account_type_des</xsl:with-param>
	    <xsl:with-param name="value" select="account_type_des"/>
   	</xsl:call-template>
   	</xsl:if> 
   	<xsl:if test="account_type_info">  	                
    <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">processing_date</xsl:with-param>
	    <xsl:with-param name="value" select="account_type_info/client_act_infos/processing_date"/>
    </xsl:call-template>
    </xsl:if>
    <xsl:if test="not(account_type_info)">  	                
    <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">processing_date</xsl:with-param>
	    <xsl:with-param name="value" select="processing_date"/>
    </xsl:call-template>
    </xsl:if>    
    <xsl:if test="account_type_info">      
    <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">adv_currency</xsl:with-param>
	   <xsl:with-param name="value" select="account_type_info/client_act_infos/adv_currency"/>
    </xsl:call-template>
    </xsl:if>
    <xsl:if test="not(account_type_info)">      
    <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">adv_currency</xsl:with-param>
	   <xsl:with-param name="value" select="adv_currency"/>
    </xsl:call-template>
    </xsl:if>
    <xsl:if test="account_type_info">      
   	<xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">adv_currency_name</xsl:with-param>
	    <xsl:with-param name="value" select="client_avail_info/client_avail_info/adv_currency_name"/>
   	</xsl:call-template> 
    </xsl:if>
    <xsl:if test="not(account_type_info)">      
    <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">adv_currency_name</xsl:with-param>
	   <xsl:with-param name="value" select="adv_currency_name"/>
    </xsl:call-template>
    </xsl:if> 
     
    <xsl:if test="account_type_info">
    <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">amt_avail_for_adv_payment</xsl:with-param>
	   <xsl:with-param name="value" select="client_avail_info/client_avail_info/amt_avail_for_adv_payment"/>
    </xsl:call-template>
    </xsl:if>
    <xsl:if test="not(account_type_info)">
    <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">amt_avail_for_adv_payment</xsl:with-param>
	   <xsl:with-param name="value" select="amt_avail_for_adv_payment"/>
    </xsl:call-template>
    </xsl:if>
     
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
   <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id" />
    </xsl:call-template>
   </xsl:if>
   
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="cross_references">
    <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
   </xsl:if>
 
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
	     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	     <xsl:with-param name="size">20</xsl:with-param>
	     <xsl:with-param name="maxsize">64</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <!--  Entity. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
     <xsl:with-param name="id">general_entity_view</xsl:with-param>
     <xsl:with-param name="value" select="account_type_info/client_act_infos/entity" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <!--  Factor Pro Client Code -->
    <xsl:if test="account_type_info">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_FACTOR_PRO_CLIENT_CODE</xsl:with-param>
	     <xsl:with-param name="id">client_code_short_name_view</xsl:with-param>
	     <xsl:with-param name="value" select='concat(account_type_info/client_act_infos/client_code, " ", account_type_info/client_act_infos/short_name)'/>
	     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
    </xsl:if> 
    
    <xsl:if test="not(account_type_info)">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_FACTOR_PRO_CLIENT_CODE</xsl:with-param>
	     <xsl:with-param name="id">client_code_short_name_view</xsl:with-param>
	     <xsl:with-param name="value" select='concat(client_code, " ", short_name)'/>
	     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
    </xsl:if> 
    
   <!--  Factor Pro Account Type. -->
   <xsl:if test="account_type_info">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_ACCOUNT_TYPE</xsl:with-param>
     <xsl:with-param name="id">account_type_view</xsl:with-param>
     <xsl:with-param name="value" select='concat(account_type_info/client_act_infos/account_type, " ", account_type_info/client_act_infos/account_type_des)'/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template> 
    </xsl:if> 
    
    <xsl:if test="not(account_type_info)">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_ACCOUNT_TYPE</xsl:with-param>
     <xsl:with-param name="id">account_type_view</xsl:with-param>
     <xsl:with-param name="value" select='concat(account_type, " ", account_type_des)'/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template> 
    </xsl:if>   
    
   
   <!--  Factor Pro Advance Currency. -->
   <xsl:if test="account_type_info">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_ADVANCE_CURRENCY</xsl:with-param>
     <xsl:with-param name="id">adv_currency_view</xsl:with-param>
     <xsl:with-param name="value" select='concat(account_type_info/client_act_infos/adv_currency, " ", account_type_info/client_act_infos/adv_currency_name)'/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template> 
    </xsl:if>
    
    <xsl:if test="not(account_type_info)">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_ADVANCE_CURRENCY</xsl:with-param>
     <xsl:with-param name="id">adv_currency_view</xsl:with-param>
     <xsl:with-param name="value" select='concat(adv_currency, " ", adv_currency_name)'/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template> 
    </xsl:if>
    
   <!--  Factor Pro Advance Currency. -->
   <xsl:if test="account_type_info">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_DRAWDOWN_AMOUNT</xsl:with-param>
     <xsl:with-param name="id">amt_avail_for_adv_payment_view</xsl:with-param>
     <xsl:with-param name="value" select="client_avail_info/client_avail_info/amt_avail_for_adv_payment" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>   
    <xsl:if test="account_type_info/client_act_infos/processing_date[.!='']">
    <xsl:if test="$displaymode='edit'">
 	 <div style="text-align:left; margin-left: 25%;font-weight:bold;">(<xsl:value-of select="localization:getGTPString($language, 'PROCESSING_DATE_MSG')"/><xsl:text>  </xsl:text><xsl:if test="account_type_info"><xsl:value-of select="account_type_info/client_act_infos/processing_date"/></xsl:if><xsl:if test="not(account_type_info)"><xsl:value-of select="processing_date"/></xsl:if>)</div>
    </xsl:if>
    </xsl:if>
   </xsl:if>
       
    <xsl:if test="not(account_type_info)">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_DRAWDOWN_AMOUNT</xsl:with-param>
     <xsl:with-param name="id">amt_avail_for_adv_payment_view</xsl:with-param>
     <xsl:with-param name="value" select="amt_avail_for_adv_payment" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>        
    <xsl:if test="$displaymode='edit'">
 	 <div style="text-align:left; margin-left: 25%;font-weight:bold;">(<xsl:value-of select="localization:getGTPString($language, 'PROCESSING_DATE_MSG')"/><xsl:text>  </xsl:text><xsl:value-of select="processing_date"/>)</div>
     </xsl:if>
    </xsl:if>
   
   <!--  Factor Pro Latest Available Amount. -->
    <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_FACTOR_PRO_LATEST_AVAIL_AMOUNT</xsl:with-param>
	   <xsl:with-param name="name">latest_avail_amount</xsl:with-param>
	   <xsl:with-param name="readonly">Y</xsl:with-param>
	   <xsl:with-param name="size">20</xsl:with-param>
	   <xsl:with-param name="maxsize">34</xsl:with-param>
	   <xsl:with-param name="button-type">factorProRetrieve</xsl:with-param>	   
   </xsl:call-template>
    
  </xsl:template>  
 </xsl:stylesheet>