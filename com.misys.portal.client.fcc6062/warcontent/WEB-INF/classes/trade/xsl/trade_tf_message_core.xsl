<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for general trade messages, customer side.
 
Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved.
 
version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
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
         xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
                  exclude-result-prefixes="localization convertTools">
 
 <!--
  Global Parameters.
  These are used in the imported XSL, and to set global params in the JS
 -->
 <xsl:param name="rundata"/>
 <xsl:param name="language">en</xsl:param>
 <xsl:param name="mode">DRAFT</xsl:param>
 <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
 <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">TF</xsl:param>
 <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="principal-acc-displayed">Y</xsl:param>
  <xsl:param name="fee-acc-displayed">Y</xsl:param>
 <xsl:param name="updatedOutstandingAmt"/>
 
 <!-- These params are empty for trade message -->
 <xsl:param name="realform-action"/>
 
 <!-- Global Imports. -->
 <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/fx_common.xsl" />
   <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
        <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
 <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 
 <xsl:template match="/">
  <xsl:apply-templates/>
 </xsl:template>
 
 <!--
  TRADE MESSAGE TNX FORM TEMPLATE.
 -->
 <xsl:template match="tf_tnx_record">
  <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
  <!-- Lower case product code -->
  <xsl:variable name="lowercase-product-code">
   <xsl:value-of select="translate($product-code,$up,$lo)"/>
  </xsl:variable>
 
  <xsl:variable name="screen-name">
   <xsl:choose>
    <xsl:when test="product_code[.='TF']">FinancingRequestScreen</xsl:when>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>
 
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
     
      <!-- Reauthentication -->
     <xsl:call-template name="server-message">
               <xsl:with-param name="name">server_message</xsl:with-param>
               <xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
               <xsl:with-param name="appendClass">serverMessage</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="reauthentication" />
     
     <!-- Disclaimer Notice -->
     <xsl:call-template name="disclaimer"/>
   
     <xsl:call-template name="hidden-fields">
      <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
      <xsl:with-param name="include-entity" select="entity[.!='']"/>
     </xsl:call-template>
     
     <!-- Hidden cross references -->
     <xsl:apply-templates select="cross_references" mode="hidden_form"/>
     
     <xsl:call-template name="message-general-details">
       <xsl:with-param name="additional-details">
       <!-- Provisional flow for finance request details-->
       <xsl:if test="product_code[.='TF']">
	       <xsl:choose>
	       	<xsl:when test="cross_references/cross_reference/type_code[.='01'] and org_previous_file/tf_tnx_record/prod_stat_code[.='98']">
	       		<xsl:call-template name="select-field">
	                 <xsl:with-param name="label">XSL_GENERALDETAILS_CUSTOMER_RESPONSE</xsl:with-param>
	                 <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	                 <xsl:with-param name="required">Y</xsl:with-param>
	                 <xsl:with-param name="fieldsize">medium</xsl:with-param>
	                 <xsl:with-param name="options">
	                  <xsl:choose>
	                   <xsl:when test="$displaymode='edit'">
	                    <option value="66">
	                     <xsl:value-of select="localization:getDecode($language, 'N003', '66')"/>
	                    </option>
	                    <option value="67">
	                     <xsl:value-of select="localization:getDecode($language, 'N003', '67')"/>
	                    </option>
	                   </xsl:when>
	                   <xsl:otherwise>
	                    <xsl:choose>
	                     <xsl:when test="sub_tnx_type_code[.='66']"><xsl:value-of select="localization:getDecode($language, 'N003', '66')"/></xsl:when>
	                     <xsl:when test="sub_tnx_type_code[.='67']"><xsl:value-of select="localization:getDecode($language, 'N003', '67')"/></xsl:when>
	                    </xsl:choose>
	                   </xsl:otherwise>
	                  </xsl:choose>
	                 </xsl:with-param>        
	             </xsl:call-template>
	       	</xsl:when>
	       	<xsl:otherwise>
	       		<xsl:call-template name="select-field">
	                 <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
	                 <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	                 <xsl:with-param name="required">Y</xsl:with-param>
	                 <xsl:with-param name="fieldsize">medium</xsl:with-param>
	                 <xsl:with-param name="options">
	                  <xsl:choose>
	                   <xsl:when test="$displaymode='edit'">
	                    <option value="24">
	                     <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
	                    </option>
	                   <xsl:if test="$updatedOutstandingAmt != '0'">	
	                    <option value="38">
	                     <xsl:value-of select="localization:getDecode($language, 'N003', '38')"/>
	                    </option>
	                    <option value="39">
	                     <xsl:value-of select="localization:getDecode($language, 'N003', '39')"/>
	                    </option>
	                    </xsl:if>
	                    <!-- <option value="40">
	                     <xsl:value-of select="localization:getDecode($language, 'N003', '40')"/>
	                    </option> -->
	                   </xsl:when>
	                   <xsl:otherwise>
	                    <xsl:choose>
	                     <xsl:when test="sub_tnx_type_code[.='24']"><xsl:value-of select="localization:getDecode($language, 'N003', '24')"/></xsl:when>
	                     <xsl:when test="sub_tnx_type_code[.='38']"><xsl:value-of select="localization:getDecode($language, 'N003', '38')"/></xsl:when>
	                     <xsl:when test="sub_tnx_type_code[.='39']"><xsl:value-of select="localization:getDecode($language, 'N003', '39')"/></xsl:when>
	                     <!-- <xsl:when test="sub_tnx_type_code[.='40']"><xsl:value-of select="localization:getDecode($language, 'N003', '40')"/></xsl:when> -->
	                    </xsl:choose>
	                   </xsl:otherwise>
	                  </xsl:choose>
	                 </xsl:with-param>        
	                 <xsl:with-param name="value">
	               		<xsl:choose>
	                       <xsl:when test="not(sub_tnx_type_code)">25</xsl:when>
	                       <xsl:otherwise><xsl:value-of select="sub_tnx_type_code"/></xsl:otherwise>
	                    </xsl:choose>
	                 </xsl:with-param>      
	                </xsl:call-template>
	       		</xsl:otherwise>
	        </xsl:choose>
            <xsl:if test="$displaymode='view'">
            <xsl:call-template name="hidden-field">
                 <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
                 <xsl:with-param name="value" select="sub_tnx_type_code"/>
                </xsl:call-template>
            </xsl:if>
            
            <div id="request-message-type">
            <!-- Outstanding amount in view mode -->
            <xsl:call-template name="currency-field">
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
            <xsl:with-param name="override-currency-name">fin_liab_cur_code</xsl:with-param>
            <xsl:with-param name="override-amt-name">fin_liab_amt</xsl:with-param>
             <xsl:with-param name="override-currency-value"><xsl:value-of select="fin_cur_code"/></xsl:with-param>
            <xsl:with-param name="override-amt-value"><xsl:value-of select="fin_liab_amt"/></xsl:with-param>
            <xsl:with-param name="currency-readonly">Y</xsl:with-param>
            <xsl:with-param name="amt-readonly">Y</xsl:with-param>
            <xsl:with-param name="show-button">N</xsl:with-param>
           	</xsl:call-template>
            <xsl:call-template name="hidden-field">
              <xsl:with-param name="name">existingaction</xsl:with-param>
              <xsl:with-param name="value" select="fromexisting"/>
             </xsl:call-template>
             <xsl:call-template name="hidden-field">
              <xsl:with-param name="name">standing_amt</xsl:with-param>
              <xsl:with-param name="value" select="fin_liab_amt"/>
             </xsl:call-template>
             <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">updatedOutstandingAmt</xsl:with-param>
		       <xsl:with-param name="value" select="$updatedOutstandingAmt"/>
	     	 </xsl:call-template>
          
          <!-- Repayment mode radio buttons -->
                       <xsl:call-template name="multichoice-field">
                                        <xsl:with-param name="group-label">XSL_REPAYMENT_MODE</xsl:with-param>
                                       <xsl:with-param name="type">radiobutton</xsl:with-param>
                                        <xsl:with-param name="label">XSL_REPAYMENT_PRINCIPAL</xsl:with-param>
                                        <xsl:with-param name="name">repayment_mode</xsl:with-param>
                                        <xsl:with-param name="id">repayment_mode_1</xsl:with-param>
                                        <xsl:with-param name="value">01</xsl:with-param>
                                        <xsl:with-param name="checked">
                                        <xsl:choose>
                                        <xsl:when test="repayment_mode[.='01']">Y</xsl:when>
                                        <xsl:otherwise>N</xsl:otherwise>
                                        </xsl:choose>
                                        </xsl:with-param>
                                </xsl:call-template>
                                 <xsl:call-template name="multichoice-field">
                                       <xsl:with-param name="type">radiobutton</xsl:with-param>
                                        <xsl:with-param name="label">XSL_REPAYMENT_PRINCIPAL_INTEREST</xsl:with-param>
                                        <xsl:with-param name="name">repayment_mode</xsl:with-param>
                                        <xsl:with-param name="id">repayment_mode_2</xsl:with-param>
                                        <xsl:with-param name="value">02</xsl:with-param>
                                        <xsl:with-param name="checked">
                                        <xsl:choose>
                                        <xsl:when test="repayment_mode[.='02']">Y</xsl:when>
                                        <xsl:otherwise>N</xsl:otherwise>
                                        </xsl:choose>
                                        </xsl:with-param>
                                </xsl:call-template>
                                
                           <!-- Repayment Amount Details Start -->
                            <xsl:choose>
                         	<xsl:when test="$displaymode='edit'">
                           <xsl:call-template name="currency-field">
                              <xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
                              <xsl:with-param name="override-currency-name">repayment_cur_code</xsl:with-param>
                              <xsl:with-param name="override-amt-name">repayment_amt</xsl:with-param>
                              <xsl:with-param name="override-amt-value"><xsl:value-of select="repayment_amt"/></xsl:with-param>
                              <xsl:with-param name="required">N</xsl:with-param>
                              <xsl:with-param name="currency-readonly">Y</xsl:with-param>
                              <xsl:with-param name="show-button">N</xsl:with-param>
                            </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="$displaymode='view' and repayment_amt != ''">
                                <xsl:call-template name="currency-field">
                              <xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
                              <xsl:with-param name="override-currency-name">repayment_cur_code</xsl:with-param>
                              <xsl:with-param name="override-amt-name">repayment_amt</xsl:with-param>
                              <xsl:with-param name="override-amt-value"><xsl:value-of select="repayment_amt"/></xsl:with-param>
                              <xsl:with-param name="override-currency-value"><xsl:value-of select="repayment_cur_code"/></xsl:with-param>
                              <xsl:with-param name="required">N</xsl:with-param>
                              <xsl:with-param name="currency-readonly">Y</xsl:with-param>
                              <xsl:with-param name="show-button">N</xsl:with-param>
                            </xsl:call-template>
                            </xsl:when>
                         </xsl:choose>
                            
                            <xsl:if test="$displaymode='view'">
                                <div style="display:none;">
                                        <xsl:call-template name="currency-field">
                                                        <xsl:with-param name="override-amt-name">repayment_amt</xsl:with-param>
                                                        <xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
                                                        <xsl:with-param name="show-button">N</xsl:with-param>
                                                                <xsl:with-param name="required">N</xsl:with-param>
                                        </xsl:call-template>
                              </div>
                              <xsl:call-template name="hidden-field">
                                      <xsl:with-param name="name">repayment_cur_code</xsl:with-param>
                                      <xsl:with-param name="value" select="repayment_cur_code"/>
                                  </xsl:call-template>
                          </xsl:if>
                         <!-- Repayment Amount Details End -->
                         
                         <!-- Interest Amount Details Start -->
                         <xsl:choose>
                         	<xsl:when test="$displaymode='edit'">
                         		<xsl:call-template name="currency-field">
				                     <xsl:with-param name="label">XSL_INTEREST_AMOUNT</xsl:with-param>
				                     <xsl:with-param name="override-currency-name">interest_cur_code</xsl:with-param>
				                     <xsl:with-param name="override-amt-name">interest_amt</xsl:with-param>
				                     <xsl:with-param name="override-currency-value"><xsl:value-of select="fin_cur_code"/></xsl:with-param>
				                     <xsl:with-param name="currency-readonly">Y</xsl:with-param>
				                     <xsl:with-param name="amt-readonly">Y</xsl:with-param>
				                     <xsl:with-param name="show-button">N</xsl:with-param>
                  				</xsl:call-template>
                         	</xsl:when>
                         	<xsl:when test="$displaymode='view' and interest_amt != ''">
                         		<xsl:call-template name="currency-field">
				                     <xsl:with-param name="label">XSL_INTEREST_AMOUNT</xsl:with-param>
				                     <xsl:with-param name="override-currency-name">interest_cur_code</xsl:with-param>
				                     <xsl:with-param name="override-amt-name">interest_amt</xsl:with-param>
				                     <xsl:with-param name="override-amt-value"><xsl:value-of select="interest_amt"/></xsl:with-param>
				                     <xsl:with-param name="override-currency-value"><xsl:value-of select="fin_cur_code"/></xsl:with-param>
				                     <xsl:with-param name="currency-readonly">Y</xsl:with-param>
				                     <xsl:with-param name="amt-readonly">Y</xsl:with-param>
				                     <xsl:with-param name="show-button">N</xsl:with-param>
                  				</xsl:call-template>
                         	</xsl:when>
                         </xsl:choose>
                      <xsl:if test="$displaymode='view'">
                                        <div style="display:none;">
                                                <xsl:call-template name="currency-field">
                                                                <xsl:with-param name="override-amt-name">interest_amt</xsl:with-param>
                                                                <xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
                                                                <xsl:with-param name="show-button">N</xsl:with-param>
                                                                        <xsl:with-param name="required">N</xsl:with-param>
                                                </xsl:call-template>
                                      </div>
                                      <xsl:call-template name="hidden-field">
                                              <xsl:with-param name="name">interest_cur_code</xsl:with-param>
                                              <xsl:with-param name="value" select="fin_cur_code"/>
                                          </xsl:call-template>
                          </xsl:if>
                         <!-- Interest Amount Details End -->
                               
                         <!-- Settlement Method type -->   
                         <xsl:call-template name="select-field">
                 <xsl:with-param name="label">XSL_GENERALDETAILS_SETTLEMENT_METHOD</xsl:with-param>
                 <xsl:with-param name="name">settlement_code</xsl:with-param>
                 <xsl:with-param name="required">N</xsl:with-param>
                 <xsl:with-param name="fieldsize">medium</xsl:with-param>
                 <xsl:with-param name="options">
                  <xsl:choose>
                   <xsl:when test="$displaymode='edit'">
                    <option value="01">
                     <xsl:value-of select="localization:getDecode($language, 'N045', '01')"/>
                    </option>
                    <option value="03">
                     <xsl:value-of select="localization:getDecode($language, 'N045', '03')"/>
                    </option>
                    </xsl:when>
                   <xsl:otherwise>
                    <xsl:choose>
                     <xsl:when test="settlement_code[.='01']"><xsl:value-of select="localization:getDecode($language, 'N045', '01')"/></xsl:when>
                     <xsl:when test="settlement_code[.='03']"><xsl:value-of select="localization:getDecode($language, 'N045', '03')"/></xsl:when>
                    </xsl:choose>
                   </xsl:otherwise>
                  </xsl:choose>
                 </xsl:with-param>
                 <xsl:with-param name="value">
               <xsl:choose>
                       <xsl:when test="not(settlement_code) or settlement_code[.= '']"></xsl:when>
                                        <xsl:otherwise><xsl:value-of select="settlement_code"/></xsl:otherwise>
                                 </xsl:choose>
                        </xsl:with-param>
                </xsl:call-template>

	<xsl:variable name="trade_account_source_static">
		<xsl:value-of select="defaultresource:getResource('TRADE_ACCOUNT_SOURCE_STATIC')"/>
	</xsl:variable>       
     <xsl:if test="$principal-acc-displayed='Y'">
     <xsl:choose>
     	<xsl:when test="$trade_account_source_static = 'true'">
          <xsl:call-template name="principal-account-field">
       		<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
       		<xsl:with-param name="type">account</xsl:with-param>
      		<xsl:with-param name="name">principal_act_no</xsl:with-param>
       		<xsl:with-param name="readonly">Y</xsl:with-param>
       		<xsl:with-param name="size">34</xsl:with-param>
       		<xsl:with-param name="maxsize">34</xsl:with-param>
       		<xsl:with-param name="entity-field">entity</xsl:with-param>
       		<xsl:with-param name="show-product-types">N</xsl:with-param>
         </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
			<xsl:call-template name="user-account-field">
				<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
				<xsl:with-param name="name">principal</xsl:with-param>
				<xsl:with-param name="entity-field">entity</xsl:with-param>
				<xsl:with-param name="dr-cr">debit</xsl:with-param>
				<xsl:with-param name="show-product-types">N</xsl:with-param>
				<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
				<xsl:with-param name="product-types-required">N</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
				<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
			</xsl:call-template>     			
     	</xsl:otherwise>      
     </xsl:choose>
    </xsl:if>
     <xsl:if test="$fee-acc-displayed='Y'">
     <xsl:choose>
     	<xsl:when test="$trade_account_source_static = 'true'">
             <xsl:call-template name="principal-account-field">
                <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
     		    <xsl:with-param name="type">account</xsl:with-param>
                <xsl:with-param name="name">fee_act_no</xsl:with-param>
                <xsl:with-param name="readonly">Y</xsl:with-param>
     			<xsl:with-param name="size">34</xsl:with-param>
      			<xsl:with-param name="maxsize">34</xsl:with-param>
      			<xsl:with-param name="entity-field">entity</xsl:with-param>
                <xsl:with-param name="show-product-types">N</xsl:with-param>
              </xsl:call-template>
       </xsl:when>
     	 <xsl:otherwise>
   			<xsl:call-template name="user-account-field">
				<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
				<xsl:with-param name="name">fee</xsl:with-param>
				<xsl:with-param name="entity-field">entity</xsl:with-param>
				<xsl:with-param name="dr-cr">debit</xsl:with-param>
				<xsl:with-param name="show-product-types">N</xsl:with-param>
				<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
	      		<xsl:with-param name="product-types-required">N</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
				<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
			</xsl:call-template>     			
     	</xsl:otherwise>      
      </xsl:choose>	   		
     </xsl:if>
   
                  <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
                   <xsl:call-template name="hidden-field">
                      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
                      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
               </xsl:call-template>
                   <xsl:call-template name="hidden-field">
                      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
                     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
                   </xsl:call-template>
                   <xsl:call-template name="hidden-field">
               <xsl:with-param name="name">product_code</xsl:with-param>
               <xsl:with-param name="value"><xsl:value-of select="$product-code"></xsl:value-of></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
               </div>   
               </xsl:if>
       </xsl:with-param>
     </xsl:call-template>
     
     <!--<div id="source-of-fund-type" >
     <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_SOURCE_FUND_HEADER_LABEL</xsl:with-param>
       <xsl:with-param name="content">
       <xsl:call-template name="select-field">
                                <xsl:with-param name="label">XSL_SOURCE_FUND_LABEL</xsl:with-param>
                                <xsl:with-param name="name">source_fund</xsl:with-param>
                                <xsl:with-param name="fieldsize">medium</xsl:with-param>
                                <xsl:with-param name="options">
                                        <option value='01'>
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPORT_PROCEEDS')" />
                                        </option>
                                        <option value='02'>
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_POST_SHIPMENT_PROCEEDS')" />
                                        </option>
                                        <option value='03'>
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_OWN_FUNDS')" />
                                        </option>
                                        <option value='04'>
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_COMBINATION')" />
                                        </option>
                                </xsl:with-param>
                        </xsl:call-template>    
       </xsl:with-param>   
     </xsl:call-template>
     </div>
     
     -->
     <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
     <div id="fx-message-type" >
      <xsl:call-template name="fx-template"/>
     </div>
     </xsl:if>
     <xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
                <xsl:call-template name="fx-details-for-view" />
         </xsl:if>
          
		<xsl:call-template name="message-freeformat"/>
      <!-- comments for return -->
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
    
   </xsl:with-param>
   </xsl:call-template>
  
   <!-- Form #1 : Attach Files -->
   <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
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
 
  <!-- Javascript and Dojo imports  -->
  <xsl:call-template name="js-imports">
   <xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
   <xsl:with-param name="lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:param name="product-code"/>
  <xsl:param name="lowercase-product-code"/>
  <xsl:param name="action"/>
 
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.trade.message_tf</xsl:with-param>
   <xsl:with-param name="override-product-code" select="$product-code"/>
   <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
   <xsl:with-param name="override-action" select="$action"/>
   <xsl:with-param name="override-help-access-key">TF_02</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:param name="lowercase-product-code"/>
  <xsl:param name="include-entity"/>
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="show-tnx-amt">Y</xsl:with-param>
   <xsl:with-param name="additional-fields">
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">prod_stat_code</xsl:with-param>
      <xsl:with-param name="value"></xsl:with-param>
      </xsl:call-template>
    <xsl:if test="$include-entity">
                <xsl:call-template name="hidden-field">
               <xsl:with-param name="name">entity</xsl:with-param>
       </xsl:call-template>
    </xsl:if>
         <xsl:call-template name="hidden-field">
                <xsl:with-param name="name">fin_type</xsl:with-param>
         </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">sub_product_code</xsl:with-param>
    </xsl:call-template>
    
    <!-- This below parameters are needed for re-authentication in edit/view mode -->
         <!-- Start  -->
        <div style="display:none;">
     <xsl:call-template name="currency-field">
                <xsl:with-param name="override-amt-name">fin_amt</xsl:with-param>
                <xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
                <xsl:with-param name="show-button">N</xsl:with-param>
                <xsl:with-param name="required">N</xsl:with-param>
          </xsl:call-template>
         </div>
         <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">fin_cur_code</xsl:with-param>
    </xsl:call-template>
   <!-- End  -->
   
   <!-- Displaying the bank details. -->
   <xsl:choose>
    <xsl:when test="product_code[.='TF']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
      <xsl:with-param name="value" select="issuing_bank/name"/>
     </xsl:call-template>
    </xsl:when>
   </xsl:choose>
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
      <xsl:with-param name="value">13</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">attIds</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">TransactionData</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
              <xsl:call-template name="hidden-field">
                <xsl:with-param name="name">fxinteresttoken</xsl:with-param>
              </xsl:call-template>
     </xsl:if>
      <xsl:call-template name="e2ee_transaction"/>
     <xsl:call-template name="reauth_params"/>
    </div>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--
  Hidden Collection Document Details
 -->
 <xsl:template name="hidden-document-fields">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">documents_details_position_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="position()"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">documents_details_document_id_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="document_id"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">documents_details_code_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="code"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">documents_details_name_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="name"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">documents_details_first_mail_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="first_mail"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">documents_details_second_mail_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="second_mail"/>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">documents_details_total_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="total"/>
   </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>