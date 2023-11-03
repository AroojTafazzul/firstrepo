<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Secure Email (SE) Form, Customer Side.
 
Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      01/02/12
author:    Raja Rao 
email:     
##########################################################
-->

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
  <xsl:param name="option"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SE</xsl:param>
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen</xsl:param>
  <xsl:param name="isMultiBank">N</xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="option_for_app_date">PENDING</xsl:param>
    
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../cash/xsl/common/se_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../cash/xsl/cash_create_se_chequeservices_details.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="se_tnx_record"/>
  </xsl:template>

   <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports"> 
    <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.cash.create_chqService</xsl:with-param>
     <xsl:with-param name="override-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen?option=CQS</xsl:with-param>
     <xsl:with-param name="override-help-access-key"><xsl:value-of select="sub_product_code"/>_01</xsl:with-param>   
  	</xsl:call-template>
  	<script>
		dojo.ready(function(){
			misys._config = (misys._config) || {};  
			misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';  
			misys._config.option_for_app_date = "<xsl:value-of select="$option_for_app_date"/>"	;
			misys._config.customerReferences = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
  	</script>
  </xsl:template>
  
</xsl:stylesheet>