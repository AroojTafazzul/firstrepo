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
	    <xsl:with-param name="legend">XSL_HEADER_FACTOR_PRO_OVERDUE_ANALYSIS_INFO</xsl:with-param>
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
      <xsl:if test="client_overdue_info/client_overdue_info/entity[.!='']">
      <tr>      
        <th><b><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></b></th>        
        	<td><xsl:value-of select="client_overdue_info/client_overdue_info/entity" /></td>
      </tr>
      </xsl:if>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_CLIENT_CODE')"/></b></th>
        <td><xsl:value-of select="client_overdue_info/client_overdue_info/client_code" /> - <xsl:value-of select="client_overdue_info/client_overdue_info/client_short_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ACCOUNT_TYPE')"/></b></th>
        <td><xsl:value-of select="client_overdue_info/client_overdue_info/account_type_des" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_ADVANCE_CURRENCY')"/></b></th>
        <td><xsl:value-of select="client_overdue_info/client_overdue_info/currency_code" />
        <xsl:text> - </xsl:text><xsl:value-of select="client_overdue_info/client_overdue_info/currency_name" /></td>
      </tr>
      <tr>
        <th><b><xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_AGED_FROM')"/></b></th>
        <td>
	        <xsl:call-template name="select-field">
	        	<xsl:with-param name="name">document_date_filter</xsl:with-param>
	        	<xsl:with-param name="fieldsize">small</xsl:with-param>
	        	<xsl:with-param name="appendClass">inlineBlockNoLabel</xsl:with-param>
	        	<xsl:with-param name="options">
	        		 <option value="document_date">
			          	<xsl:value-of select="localization:getGTPString($language, 'FACTOR_PRO_DOCUMENT_DATE')"/>
			         </option>
			         <option value="due_date">
			          	<xsl:value-of select="localization:getGTPString($language, 'FACTOR_PRO_DUE_DATE')"/>
			         </option>
	        	</xsl:with-param>
	        </xsl:call-template>       
       </td>
       </tr>
    </table> 
  </xsl:template>  
  <xsl:template name="factor_pro_invoice_enquiry_details">
  
  	<script>
  		dojo.subscribe("ready",function(){ 
  			misys.connect('document_date_filter','onChange',function(){
  				if(this.get('value') === 'document_date')
  				{
  					misys.animate('wipeOut','dueDateDiv',function(){
  						misys.animate('wipeIn','documentDateDiv');
  					});
  				}
  				else
  				{
  					misys.animate('wipeOut','documentDateDiv',function(){
  						misys.animate('wipeIn','dueDateDiv');
  					});
  				}
  			});
  		});
  	</script>
   <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_FACTOR_PRO_OVERDUE_DETAILS</xsl:with-param>
	     <xsl:with-param name="content">
		 <div class="widgetContainer" id="factoringOverDue">
	 		<div id="misysCustomisableTabelHeaderContainer" style="width:100%;">
				<div class="factoringTableCell factoringTableCellHeader width3per alignCenter">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_SERIAL_NUMBER')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width13per">
					<xsl:value-of select="localization:getGTPString($language, 'FA_DEBTOR_NAME')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_INVC_CCY')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_CURRENT_BAL')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_ZERO_THIRTY')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_THIRTY_ONE_SIXTY')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_SIXTY_ONE_NINETY')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_NINETY_ONE_ONETWENTY')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_GREATER_THAN_ONETWENTY')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_GUARANTEE_AMT')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_CREDIT_NOTE')"/>
				</div>
				<div class="factoringTableCell factoringTableCellHeader width8per">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FACTOR_PRO_OVERDUE_TOTAL_BAL')"/>
				</div>
			</div>
			<div id="documentDateDiv" style="display:none;">
				<xsl:if test="count(client_overdue_info/client_overdue_info) > 0">
			       <xsl:for-each select="client_overdue_info/client_overdue_info[(aged_from='Document Date')]">
			       		<xsl:variable name="documentDatePosition" select="position()"/>
			       		<xsl:choose>
								<xsl:when test="$documentDatePosition mod 2 = 1">
									<div class="factoringTableCell factoringTableCellOdd width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width13per">
										<xsl:value-of select="customer_short_name"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignCenter">
										<xsl:value-of select="currency_code"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignRight">
										<xsl:value-of select="current_bal"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period1"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period2"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period3"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period4"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period5"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignRight">
										<xsl:value-of select="guarantee_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="credit_note_receipt" />
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignRight">
										<xsl:value-of select="total_bal"/>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="factoringTableCell factoringTableCellEven width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width13per">
										<xsl:value-of select="customer_short_name"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignCenter">
										<xsl:value-of select="currency_code"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignRight">
										<xsl:value-of select="current_bal"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period1"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period2"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period3"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period4"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period5"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignRight">
										<xsl:value-of select="guarantee_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="credit_note_receipt"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignRight">
										<xsl:value-of select="total_bal"/>
									</div>
								</xsl:otherwise>
						</xsl:choose>
				  </xsl:for-each> 
			   </xsl:if> 
			</div>
			<div id="dueDateDiv" style="display:none;">
				<xsl:if test="count(client_overdue_info/client_overdue_info) > 0">
			       <xsl:for-each select="client_overdue_info/client_overdue_info[(aged_from='Due Date')]">
			       		<xsl:variable name="dueDatePosition" select="position()"/>
			       		<xsl:choose>
								<xsl:when test="$dueDatePosition mod 2 = 1">
									<div class="factoringTableCell factoringTableCellOdd width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width13per">
										<xsl:value-of select="customer_short_name"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignCenter">
										<xsl:value-of select="currency_code"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignRight">
										<xsl:value-of select="current_bal"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period1"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period2"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period3"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period4"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="period5"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignRight">
										<xsl:value-of select="guarantee_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per">
										<xsl:value-of select="credit_note_receipt" />
									</div>
									<div class="factoringTableCell factoringTableCellOdd width8per alignRight">
										<xsl:value-of select="total_bal"/>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="factoringTableCell factoringTableCellEven width3per alignCenter">
										<xsl:value-of select="position()"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width13per">
										<xsl:value-of select="customer_short_name"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignCenter">
										<xsl:value-of select="currency_code"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignRight">
										<xsl:value-of select="current_bal"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period1"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period2"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period3"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period4"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="period5"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignRight">
										<xsl:value-of select="guarantee_amt"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per">
										<xsl:value-of select="credit_note_receipt"/>
									</div>
									<div class="factoringTableCell factoringTableCellEven width8per alignRight">
										<xsl:value-of select="total_bal"/>
									</div>
								</xsl:otherwise>
						</xsl:choose>
				  </xsl:for-each> 
			   </xsl:if> 
			</div>
 		 </div>
 		</xsl:with-param>
   </xsl:call-template>
 </xsl:template>  
</xsl:stylesheet>