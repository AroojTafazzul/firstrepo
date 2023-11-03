<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for Invoice Request for Financing, customer side.
 
Copyright (c) 2000-2017 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      25/01/17
author:    Meenal Sahasrabudhe
email:     meenal.sahasrabudhe@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"		  
       	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
        xmlns:fscmTools="xalan://com.misys.portal.openaccount.util.FSCMUtils"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization convertTools fscmTools defaultresource">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="option">IN_FINANCE_REQUEST</xsl:param>
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/InvoiceScreen</xsl:param>
  <xsl:param name="product-code"/>
  
   <xsl:variable name="fscm_cash_customization_enable">
  		<xsl:value-of select="defaultresource:getResource('FSCM_CASH_CUSTOMIZATION_ENABLE')"/>
  	</xsl:variable>
  
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/fx_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:param name="product-code"/>
   <xsl:param name="lowercase-product-code"/>
   <xsl:param name="action"/>

   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.openaccount.financing_request_in</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
	<xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
	<xsl:with-param name="override-help-access-key">IN_01</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  <xsl:template match="in_tnx_record">
  
  <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
  
  
  <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>
   <xsl:variable name="screen-name">InvoiceScreen</xsl:variable>
   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>
   <xsl:variable name ="totalDiscount" select="fscmTools:getTotalDiscountSingleFinance(//ref_id,//product_code)"/>
  
   
   
  <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports">
	    <xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
	    <xsl:with-param name="lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
	    <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
   </xsl:call-template>

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
	       <xsl:with-param name="node-name" select="name(.)"/>
	       <xsl:with-param name="screen-name" select="$screen-name"/>
	       <xsl:with-param name="show-template">N</xsl:with-param>
	       <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      
      <!-- Reauthentication -->	
	 	<xsl:call-template name="server-message">
	 		<xsl:with-param name="name">server_message</xsl:with-param>
	 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
	 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
		</xsl:call-template>
	  	<xsl:call-template name="reauthentication" />
    
		<xsl:call-template name="hidden-fields">
		 <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
		</xsl:call-template>
      
      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="display_form"/>
      
      <xsl:call-template name="message-general-details">
      	<xsl:with-param name="additional-details">
      		<xsl:call-template name="input-field">
			     <xsl:with-param name="label">BUYER_NAME_LABEL</xsl:with-param>
			     <xsl:with-param name="name">buyer_name</xsl:with-param>
			     <xsl:with-param name="size">35</xsl:with-param>
			     <xsl:with-param name="maxsize">35</xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<div id="request_amount_div">
			<xsl:call-template name="currency-field"> 
				<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_AMOUNT</xsl:with-param>
      			<xsl:with-param name="product-code">total</xsl:with-param>
      			<xsl:with-param name="show-amt">Y</xsl:with-param>
      			<xsl:with-param name="override-currency-value"><xsl:value-of select="total_net_cur_code"/></xsl:with-param>
      			<xsl:with-param name="override-amt-value"><xsl:value-of select="total_net_amt"/></xsl:with-param>
      			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
      			<xsl:with-param name="swift-validate">N</xsl:with-param>
      			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
      			<xsl:with-param name="show-button">N</xsl:with-param>
      			<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
      			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
    		</xsl:call-template>
    		
    		<xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="eligibility_flag">
				<xsl:value-of select="eligibility_flag"/>
			</xsl:variable>
		         
			<xsl:call-template name="row-wrapper">
			  <xsl:with-param name="label">XSL_ELIGIBILITY_STATUS_LABEL</xsl:with-param>
			  <xsl:with-param name="id">eligibility_flag_content</xsl:with-param>
			  <xsl:with-param name="override-displaymode">view</xsl:with-param>
			  <xsl:with-param name="content">
			    <div class="content" id = "eligibility_content">
			   	<xsl:value-of select="localization:getDecode($language, 'N085',$eligibility_flag)"/>
			   </div>
			  </xsl:with-param>
			 </xsl:call-template>
			  <xsl:if test=" ($fscm_cash_customization_enable = 'true')">
				 <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_DISCOUNT_AMOUNT</xsl:with-param>
				     <xsl:with-param name="name">total_discount</xsl:with-param>
				      <xsl:with-param name="id">total_discount</xsl:with-param>
				     <xsl:with-param name="value" select = "$totalDiscount"/>
				     <xsl:with-param name="size">3</xsl:with-param>
				     <xsl:with-param name="maxsize">5</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="readonly">Y</xsl:with-param>
				     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
    		</div>
	   		<xsl:call-template name="hidden-field">
		      	<xsl:with-param name="name">tnx_amt</xsl:with-param>  
		     	<xsl:with-param name="value">
			      <xsl:choose>
			    	<xsl:when test="tnx_amt[.='']"><xsl:value-of select="total_net_amt"/></xsl:when>
			    	<xsl:otherwise><xsl:value-of select="tnx_amt"/></xsl:otherwise>
			      </xsl:choose>
		    	</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">tnx_cur_code</xsl:with-param>
		      <xsl:with-param name="value">
			      <xsl:choose>
			    	<xsl:when test="tnx_cur_code[.='']"><xsl:value-of select="total_net_cur_code"/></xsl:when>
			    	<xsl:otherwise><xsl:value-of select="tnx_cur_code"/></xsl:otherwise>
			      </xsl:choose>
		   	  </xsl:with-param>
		    </xsl:call-template>
		
		    <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">inv_eligible_amt</xsl:with-param>  
		      	<xsl:with-param name="value"><xsl:value-of select="inv_eligible_amt"/></xsl:with-param>
		    </xsl:call-template>
	 		<xsl:call-template name="hidden-field">
			     <xsl:with-param name="name">invoice_outstanding_amt</xsl:with-param>
		   </xsl:call-template>
		 	 <xsl:if test="discount_exp_date[. != '']">
 	         <xsl:call-template name="hidden-field">
     	        <xsl:with-param name="name">discount_exp_date</xsl:with-param>
   		        <xsl:with-param name="value"><xsl:value-of select="discount_exp_date"/></xsl:with-param>
 	         </xsl:call-template>
 	         </xsl:if>
			    
		    <!-- <xsl:call-template name="currency-field"> 
				<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_ELIGIBLE_AMT</xsl:with-param>
      			<xsl:with-param name="product-code">inv_eligible</xsl:with-param>
      			<xsl:with-param name="show-amt">Y</xsl:with-param>
      			<xsl:with-param name="override-currency-value">
      				<xsl:choose>
		    			<xsl:when test="inv_eligible_cur_code[.='']"><xsl:value-of select="total_net_cur_code"/></xsl:when>
		    			<xsl:otherwise><xsl:value-of select="inv_eligible_cur_code"/></xsl:otherwise>
		    		</xsl:choose>
      			</xsl:with-param>
      			<xsl:with-param name="override-amt-value">
      				<xsl:choose>
		    			<xsl:when test="inv_eligible_amt[.=''] or eligibility_flag[.!='E']">0.00</xsl:when>
		    			<xsl:otherwise><xsl:value-of select="inv_eligible_amt"/></xsl:otherwise>
		    		</xsl:choose>
      			</xsl:with-param>
      			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
      			<xsl:with-param name="swift-validate">N</xsl:with-param>
      			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
      			<xsl:with-param name="show-button">N</xsl:with-param>
      			<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
      			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
    		</xsl:call-template> -->
	    	<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_CURRENCY</xsl:with-param>
     			<xsl:with-param name="product-code">finance</xsl:with-param>
     			<xsl:with-param name="show-amt">N</xsl:with-param>
     			<xsl:with-param name="override-currency-value">
     				<xsl:choose>
		    			<xsl:when test="finance_requested_cur_code[.='']"><xsl:value-of select="total_net_cur_code"/></xsl:when>
		    			<xsl:otherwise><xsl:value-of select="finance_requested_cur_code"/></xsl:otherwise>
		    		</xsl:choose>
     			</xsl:with-param>
     			<xsl:with-param name="show-button">N</xsl:with-param>
     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
	   		</xsl:call-template>
	   		<xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_REQUESTED_PCT</xsl:with-param>
			     <xsl:with-param name="name">inv_eligible_pct</xsl:with-param>
			     <xsl:with-param name="size">3</xsl:with-param>
			     <xsl:with-param name="maxsize">5</xsl:with-param>
			     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_REQUESTED_AMT</xsl:with-param>
				<xsl:with-param name="product-code">finance_requested</xsl:with-param>
				<xsl:with-param name="override-currency-value">
      				<xsl:choose>
		    			<xsl:when test="finance_requested_cur_code[.='']"><xsl:value-of select="total_cur_code"/></xsl:when>
		    			<xsl:otherwise><xsl:value-of select="finance_requested_cur_code"/></xsl:otherwise>
		    		</xsl:choose>
      			</xsl:with-param>
				<xsl:with-param name="override-amt-value">
					<xsl:if test="inv_eligible_pct[.!='']">
			    		<xsl:value-of select="finance_requested_amt"/>
					</xsl:if>
		    	</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
			</xsl:call-template>
		    <xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
				<xsl:with-param name="product-code">liab_total_net</xsl:with-param>
				<xsl:with-param name="override-currency-value">
      				<xsl:choose>
		    			<xsl:when test="liab_total_net_cur_code[.='']"><xsl:value-of select="total_net_cur_code"/></xsl:when>
		    			<xsl:otherwise><xsl:value-of select="liab_total_net_cur_code"/></xsl:otherwise>
		    		</xsl:choose>
      			</xsl:with-param>
				<xsl:with-param name="override-amt-value">
					<xsl:if test="inv_eligible_pct[.!='']">
						<xsl:value-of select="liab_total_net_amt"/>
					</xsl:if>
		    	</xsl:with-param>	
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
			</xsl:call-template>
		    <br/>		   	
   	
		   	<xsl:call-template name="message-freeformat"/>
		   	<xsl:call-template name="comments-for-return">
				<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
				<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  		</xsl:call-template>
      	</xsl:with-param>
      </xsl:call-template>
      
    </xsl:with-param>
    </xsl:call-template>
    
     <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>
   
    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>
  
	<xsl:call-template name="menu">
		<xsl:with-param name="node-name" select="name(.)"/>
		<xsl:with-param name="screen-name" select="$screen-name"/>
		<xsl:with-param name="show-template">N</xsl:with-param>
		<xsl:with-param name="second-menu">Y</xsl:with-param>
		<xsl:with-param name="show-return">Y</xsl:with-param>
	</xsl:call-template>
   </div>
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
		<xsl:with-param name="editable">true</xsl:with-param>
		<xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
		<xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
		<xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
		<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>

   
  </xsl:template>
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
    <xsl:if test="entity and entity[. != '']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">entity</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">eligibility_flag</xsl:with-param>
     </xsl:call-template>

   	<xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">product_code</xsl:with-param>
   		 <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
 	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
	   	 <xsl:with-param name="name">access_opened</xsl:with-param>
	   	 <xsl:with-param name="value"><xsl:value-of select="access_opened"/></xsl:with-param>
    </xsl:call-template> 
   </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   Hidden fields for Message
   -->
  <xsl:template name="realform">
   <xsl:param name="action"/>
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$action"/>
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
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">63</xsl:with-param>
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
     	 <xsl:with-param name="name">subproductcode</xsl:with-param>
     	 <xsl:with-param name="value" select="sub_product_code"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">cashCustomizationEnable</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$fscm_cash_customization_enable"/></xsl:with-param>							
	 </xsl:call-template>
     
     <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">option</xsl:with-param>
     	 <xsl:with-param name="value">IN_FINANCE_REQUEST</xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="disclaimer-column-wrapper">
  	<xsl:param name="rightStyle">margin-left: 265px;</xsl:param>
  	<xsl:param name="leftContent">&nbsp;</xsl:param>
  	<xsl:param name="rightContent" />

		<div>
			<xsl:attribute name="style"><xsl:value-of select="$rightStyle" /></xsl:attribute>
			<xsl:value-of select="$rightContent" /> 
		</div>
  </xsl:template>
  <!-- comments for return -->
   <xsl:template name="comments-for-return">
    <xsl:param name="value" />
    <xsl:param name="mode" />
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_MC_COMMENTS_FOR_RETURN</xsl:with-param>
	   		<xsl:with-param name="id">comments-for-return</xsl:with-param>
	   		<xsl:with-param name="content">
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">return_comments</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			   		<xsl:with-param name="override-displaymode">
			   			<xsl:choose>
			   				<xsl:when test="$mode = 'UNSIGNED'">edit</xsl:when>
			   				<xsl:otherwise>view</xsl:otherwise>
			   			</xsl:choose>
			   		</xsl:with-param>
			 	</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   </xsl:template>
</xsl:stylesheet>