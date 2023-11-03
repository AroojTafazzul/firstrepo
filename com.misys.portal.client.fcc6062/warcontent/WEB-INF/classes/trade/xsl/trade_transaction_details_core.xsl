<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

Factoring (FA) Inquiry Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      15/06/2011
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
   </xsl:call-template>
  </xsl:template>

  <!--
     Common General Details
  -->

 	  
  <xsl:template name="general-details">
	  <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_FACTOR_PRO_TRANSACTION_INFO</xsl:with-param>
	    <xsl:with-param name="content"> 
	    <xsl:call-template name="factor_pro_transaction_header_details"/>	    
	    <xsl:call-template name="factor_pro_transaction_details"/>
	    </xsl:with-param>	  
	  </xsl:call-template>	    
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
		
	<xsl:template name="factor_pro_transaction_header_details">

    <table border="0" width="100%" cellpadding="0" cellspacing="0">
      <xsl:if test="client_tnx_info/client_tnx_info/entity[.!='']">
      <tr>      
        <th><b><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></b></th>        
        	<td><xsl:value-of select="client_tnx_info/client_tnx_info/entity" /></td>
      </tr>
      </xsl:if>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CLIENT_CODE')"/></b></th>
        <td><xsl:value-of select="client_tnx_info/client_tnx_info/client_code" /> - <xsl:value-of select="client_tnx_info/client_tnx_info/client_short_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ACCOUNT_TYPE')"/></b></th>
        <td><xsl:value-of select="client_tnx_info/client_tnx_info/account_type" /><xsl:text> - </xsl:text><xsl:value-of select="client_tnx_info/client_tnx_info/account_type_des" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ADVANCE_CURRENCY')"/></b></th>
        <td><xsl:value-of select="client_tnx_info/client_tnx_info/adv_currency" />
        <xsl:text> - </xsl:text><xsl:value-of select="client_tnx_info/client_tnx_info/adv_currency_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_FIU')"/></b></th>
        <td><xsl:value-of select="client_tnx_info/client_tnx_info/capt_fiu_sign" /><xsl:value-of select="client_tnx_info/client_tnx_info/capt_fiu" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_CCA')"/></b></th>
        <td><xsl:value-of select="client_tnx_info/client_tnx_info/capt_cca_sign" /><xsl:value-of select="client_tnx_info/client_tnx_info/capt_cca" /></td>
      </tr>

    </table> 
  </xsl:template>  
  <xsl:template name="factor_pro_transaction_details">
  	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="content">
			<div class="widgetContainer" id="factoringOverDue">
			 	<div id="misysCustomisableTabelHeaderContainer" style="width:100%;">
					<div class="factoringTableCell factoringTableCellHeader width3per">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_SERIAL_NUMBER')"/>
					</div>
					<div class="factoringTableCell factoringTableCellHeader width15per">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_VALUE_DATE')"/>
					</div>
					<div class="factoringTableCell factoringTableCellHeader width20per">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_REF')"/>
					</div>
					<div class="factoringTableCell factoringTableCellHeader width15per">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_FIU_DETAILS')"/>
					</div>
					<div class="factoringTableCell factoringTableCellHeader width15per">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_FIU_DES1')"/>
					</div>
					<div class="factoringTableCell factoringTableCellHeader width15per">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_FIU_DES2')"/>
					</div>
					<div class="factoringTableCell factoringTableCellHeader width15per">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_CCA_DETAILS')"/>
					</div>
				</div>
				<xsl:if test="count(client_tnx_info/client_tnx_info) > 0"> 
					<div class="factoringTableCell factoringTableCellAggregate width3per alignCenter">
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignCenter">
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width20per alignCenter">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_OPENING_BAL_MSG')"/></b><xsl:text> </xsl:text><b><xsl:value-of select="client_tnx_info/client_tnx_info/processing_date" /></b>
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignRight">
						<b><xsl:value-of select="client_tnx_info/client_tnx_info/opening_fiu_sign" /><xsl:value-of select="client_tnx_info/client_tnx_info/opening_fiu" /></b>
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignRight">
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignCenter">
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignRight">
						<b><xsl:value-of select="client_tnx_info/client_tnx_info/opening_cca_sign" /><xsl:value-of select="client_tnx_info/client_tnx_info/opening_cca" /></b>
					</div>       
				 </xsl:if>  
				 <xsl:if test="count(client_tnx_info/client_tnx_info) > 0">
			       <xsl:for-each select="client_tnx_info/client_tnx_info">
			       		<xsl:variable name="documentDatePosition" select="position()"/>
			       		<xsl:choose>
								<xsl:when test="$documentDatePosition mod 2 = 1">
									<div class="factoringTableCell factoringTableCellOdd width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignCenter">
										<xsl:value-of select="value_date"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width20per alignCenter">
										<xsl:value-of select="tnx_ref"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignRight">
										<xsl:value-of select="tnx_fiu_adv_sign"></xsl:value-of><xsl:value-of select="tnx_fiu_adv"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignCenter">
										<xsl:value-of select="description1"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignCenter">
										<xsl:value-of select="description2"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignRight">
										<xsl:value-of select="tnx_cca_adv_sign"></xsl:value-of><xsl:value-of select="tnx_cca_adv"/>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="factoringTableCell factoringTableCellEven width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignCenter">
										<xsl:value-of select="value_date"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width20per alignCenter">
										<xsl:value-of select="tnx_ref"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignRight">
										<xsl:value-of select="tnx_fiu_adv_sign"></xsl:value-of><xsl:value-of select="tnx_fiu_adv"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignCenter">
										<xsl:value-of select="description1"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignCenter">
										<xsl:value-of select="description2"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignRight">
										<xsl:value-of select="tnx_cca_adv_sign"></xsl:value-of><xsl:value-of select="tnx_cca_adv"/>
									</div>
								</xsl:otherwise>
						</xsl:choose>
				  </xsl:for-each> 
			   </xsl:if> 
			   <xsl:if test="count(client_tnx_info/client_tnx_info) > 0">
			   		<div class="factoringTableCell factoringTableCellAggregate width3per alignCenter">
					</div>
					<div class="factoringTableCell factoringTableCellAggregate  width15per alignCenter">
					</div>
					<div class="factoringTableCell  factoringTableCellAggregate width20per alignCenter">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TNX_CLOSING_BAL_MSG')"/></b>
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignRight">
						<b><xsl:value-of select="client_tnx_info/client_tnx_info/closing_fiu_sign" /><xsl:value-of select="client_tnx_info/client_tnx_info/closing_fiu" /></b>
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignRight">
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignCenter">
					</div>
					<div class="factoringTableCell factoringTableCellAggregate width15per alignRight">
						<b><xsl:value-of select="client_tnx_info/client_tnx_info/capt_cca_sign" /><xsl:value-of select="client_tnx_info/client_tnx_info/capt_cca" /></b>
					</div>      
			   </xsl:if>
 		    </div>
 		</xsl:with-param>
   </xsl:call-template>
 </xsl:template>  

 </xsl:stylesheet>