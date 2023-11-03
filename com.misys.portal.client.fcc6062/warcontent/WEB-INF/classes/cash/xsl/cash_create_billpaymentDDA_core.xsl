<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      28/09/11
author:    Lithwin
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils">
       
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen</xsl:param>
  <xsl:param name="isMultiBank">N</xsl:param>
  <xsl:param name="option_for_app_date">PENDING</xsl:param>
  <xsl:param name="nicknameEnabled"/>
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />  
  <xsl:include href="./common/ft_common.xsl" />
  <xsl:include href="./common/bp_dda_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../cash/xsl/cash_create_billpaymentDDA_details.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ft_tnx_record"/>
  </xsl:template>
  
  	
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.cash.create_bp_dda</xsl:with-param>
    <xsl:with-param name="override-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen?option=BILL</xsl:with-param>
    <xsl:with-param name="override-product-code" select="product_code"/>
   	<xsl:with-param name="override-help-access-key">BILLP_02</xsl:with-param>
  </xsl:call-template>
  <script>
		dojo.ready(function(){
			misys._config = (misys._config) || {};	
			misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
			misys._config.option_for_app_date = "<xsl:value-of select="$option_for_app_date"/>"	;	
			misys._config.offset = misys._config.offset ||
			[ 
			{
			<xsl:for-each select="start_dt_offset/offset">
					'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
					<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>	
			}
			];
			 misys._config.recurring_product = misys._config.recurring_product ||
			 {
	                        <xsl:for-each select="recurring_payment/recurring_product">
	                                        '<xsl:value-of select="sub_prod_type" />':'<xsl:value-of select="flag" />'
	                                        <xsl:if test="position()!=last()">,</xsl:if>
	                        </xsl:for-each>
	         };
	                 			
			misys._config.frequency_mode = misys._config.frequency_mode || 
			[
			{
			<xsl:for-each select="frequency/frequency_mode">
				'<xsl:value-of select="frequency_type"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
            	<xsl:if test="position()!=last()">,</xsl:if>
            </xsl:for-each>
            }
            ];
            misys._config.singleBankRecurring =  misys._config.singleBankRecurring||
            
            {
  				 		<xsl:if test ="count(/ft_tnx_record/recurring_payment/recurring_product)>0">
  				 			<xsl:for-each select="/ft_tnx_record/recurring_payment/recurring_product">
  				 				"<xsl:value-of select="sub_prod_type"/>": "<xsl:value-of select="flag"/>"
  				 				<xsl:if test="not(position()=last())">,</xsl:if>
  				 			</xsl:for-each>
  				 		</xsl:if>
  			};
            misys._config.isMultiBank =<xsl:choose>
									 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 			<xsl:otherwise>false</xsl:otherwise>
									 		</xsl:choose>;
               <xsl:if test="$isMultiBank='Y'">
	           		<xsl:call-template name="per-bank-recurring"/>
		            <xsl:call-template name="per-bank-recurring-frequency"/>
	            	<xsl:call-template name="multibank-common-details"/> 
			   </xsl:if>	
		});
  	</script>
  
 </xsl:template>
	
</xsl:stylesheet>