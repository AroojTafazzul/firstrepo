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
	    <xsl:with-param name="legend">XSL_HEADER_FACTOR_PRO_INVOICE_ENQUIRY</xsl:with-param>
	    <xsl:with-param name="content"> 
	    <xsl:call-template name="factor_pro_invoice_enquiry_header_details"/>
	    	    
	    <xsl:call-template name="factor_pro_invoice_enquiry_details"/>
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
		
	<xsl:template name="factor_pro_invoice_enquiry_header_details">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
      <xsl:if test="client_contract_info/client_contract_info//entity[.!='']">
      <tr>      
        <th><b><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></b></th>        
        	<td><xsl:value-of select="client_contract_info/client_contract_info//entity" /></td>
      </tr>
      </xsl:if>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CLIENT_CODE')"/></b></th>
        <td><xsl:value-of select="client_contract_info/client_contract_info/client_code" /> - <xsl:value-of select="client_contract_info/client_contract_info/client_short_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ACCOUNT_TYPE')"/></b></th>
        <td><xsl:value-of select="client_contract_info/client_contract_info/account_type_des" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DEBTOR_CODE')"/></b></th>
        <td><xsl:value-of select="client_contract_info/client_contract_info/customer_code" /><xsl:text> - </xsl:text><xsl:value-of select="client_contract_info/client_contract_info/customer_short_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_FACTOR_CODE')"/></b></th>
        <td><xsl:value-of select="client_contract_info/client_contract_info/factor_code" /><xsl:text> - </xsl:text><xsl:value-of select="client_contract_info/client_contract_info/factor_short_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_INVOICE_CURRENCY')"/></b></th>
        <td><xsl:value-of select="client_contract_info/client_contract_info/currency_code" />
        <xsl:text> - </xsl:text><xsl:value-of select="client_contract_info/client_contract_info/currency_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_TOTAL_OS_AMT')"/></b></th>
        <td><xsl:value-of select="client_invc_info/client_invoice_info/total_os_amt_sign" />
        <xsl:value-of select="client_invc_info/client_invoice_info/total_os_amt" /></td>
      </tr>
    </table> 
  </xsl:template>  
  <xsl:template name="factor_pro_invoice_enquiry_details">
  	   <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="content">
		 <div class="widgetContainer" id="factoringOverDue">
	 		<div id="misysCustomisableTabelHeaderContainer" style="width:100%;">
				<div class="factoringTableCell factoringTableCellHeader width3per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_SERIAL_NUMBER')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width10per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DOC_REF')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width10per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_INVOICE_AMT')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width15per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_INVOICE_OS_AMT')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width15per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DOC_DATE')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width15per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_DUE_DATE')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width15per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_DATE')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width15per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_BATCH_CODE')"/>
				</div>
			</div>
				<xsl:if test="count(client_invc_info/client_invoice_info) > 0">
			       <xsl:for-each select="client_invc_info/client_invoice_info">
			       		<xsl:variable name="documentDatePosition" select="position()"/>
			       		<xsl:choose>
								<xsl:when test="$documentDatePosition mod 2 = 1">
									<div class="factoringTableCell factoringTableCellOdd width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width10per alignCenter">
										<xsl:value-of select="doc_ref"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width10per alignRight">
										<xsl:value-of select="invoice_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignRight">
										<xsl:value-of select="outstanding_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignCenter">
										<xsl:value-of select="document_date"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignCenter">
										<xsl:value-of select="due_date"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignCenter">
										<xsl:value-of select="overdue_days"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width15per alignCenter">
										<xsl:value-of select="batch_code"/>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="factoringTableCell factoringTableCellEven width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width10per alignCenter">
										<xsl:value-of select="doc_ref"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width10per alignRight">
										<xsl:value-of select="invoice_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignRight">
										<xsl:value-of select="outstanding_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignCenter">
										<xsl:value-of select="document_date"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignCenter">
										<xsl:value-of select="due_date"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignCenter">
										<xsl:value-of select="overdue_days"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width15per alignCenter">
										<xsl:value-of select="batch_code"/>
									</div>
								</xsl:otherwise>
						</xsl:choose>
				  </xsl:for-each> 
			   </xsl:if> 
 		 </div>
 		</xsl:with-param>
   </xsl:call-template>
 </xsl:template>  

 </xsl:stylesheet>