<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

Adding a new template for Invoice Screen.

Copyright (c) 2000-2016 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/08/16
author:    Jayron Lester Sanchez
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:technicalresource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization technicalresource securitycheck security utils defaultresource">
<!-- 
  Global Parameters.
  These are used in the imported XSL, and to set global params in the JS 
 -->
 <xsl:param name="rundata"/>
 <xsl:param name="language">en</xsl:param>
 <xsl:param name="languages"/>
 <xsl:param name="nextscreen"/>
 <xsl:param name="option"/>
 <xsl:param name="action"/>
 <xsl:param name="displaymode">edit</xsl:param>
 <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
 <xsl:param name="main-form-name">fakeform1</xsl:param>
 <xsl:param name="operation">SIMPLIFIED_UPLOAD_TEMPLATE_SAVE</xsl:param>
 <xsl:param name="token"/>
 <xsl:param name="currentOpe"/>
 
 <xsl:param name="screen"/>
 <xsl:param name="productcode"/>
 <xsl:param name="default_template"/>
 <xsl:param name="invoice_type"/>
 
 <!-- Global Imports. -->
  
  <xsl:include href="../../core/xsl/common/system_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../openaccount/xsl/baseline_upload_template.xsl" />
 
 <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 <xsl:template match="/">
   <xsl:apply-templates select="upload_template"/>
  </xsl:template>
  
  <xsl:template match="upload_template">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message" />
   
   <script type="text/javascript">
      		<xsl:call-template name="Columns_Definitions"/>
   </script>
  
 <div>
	 <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
	 
	 <!-- Form #0 : Main Form -->
	 <xsl:call-template name="form-wrapper">
	  <xsl:with-param name="name" select="$main-form-name"/>
	  <xsl:with-param name="validating">Y</xsl:with-param>
	  <xsl:with-param name="content">
	   <xsl:call-template name="hidden-fields"/>
	   <xsl:call-template name="upload-template-general-details" />
	   <xsl:call-template name="upload-template-mapping-columns" />
	   <xsl:call-template name="update-column-information" />
	   </xsl:with-param>
	  </xsl:call-template>
	
	<!--  Display common menu.  -->
	<xsl:choose>
	   	<xsl:when test="default_template != 'Y'">
	 		<xsl:call-template name="system-menu"/>
	 	</xsl:when>
	 	<xsl:otherwise>
	 		<xsl:call-template name="menu" >
				<xsl:with-param name="show-template">N</xsl:with-param>
				<xsl:with-param name="show-submit">N</xsl:with-param>
				<xsl:with-param name="show-save">N</xsl:with-param>
			</xsl:call-template>
	    </xsl:otherwise>
	</xsl:choose> 	
	   
	   <xsl:call-template name="realform"/>
	 <!--  Display common menu. -->
	 
	  <!-- Javascript imports  -->
	<xsl:call-template name="js-imports"/>
</div>
</xsl:template>

<!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">upload_template</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.openaccount.simplified_upload_ip_template</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$screen"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--   Real form  -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SIMPLIFIED_UPLOAD_TEMPLATE_SAVE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
	  <xsl:if test="upload_template_id[.!='']">
	  <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">featureid</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="upload_template_id"/></xsl:with-param>
      </xsl:call-template>
	  </xsl:if>
	  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">productcode</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$productcode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
 
<!--  Delimeter options -->
 <xsl:template name="delimiter-options">
	 <option value=""></option>	 
	 <option value="comma"><xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_COMMA')"/></option>
	 <option value=";;"><xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_SEMICOLON')"/></option>
	 <option value="OTHER"><xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_OTHER')"/></option>
 </xsl:template>
  
  <!-- Create one column entry -->
<xsl:template name="avail_column">
	<xsl:param name="column_name" />
	<xsl:param name="column_type" />
	<xsl:param name="column_name_label" select="$column_name"/>
	<xsl:variable name="codeval">XSL_REPORT_COL_<xsl:value-of select="$column_name_label"/></xsl:variable>
	<xsl:if test="count(definition/column/name[.=$column_name])=0">
	<option>
		<xsl:attribute name="value"><xsl:value-of select="$column_name"/></xsl:attribute>
		<xsl:value-of select="localization:getGTPString($language, $codeval)"/>
	</option>
</xsl:if>
</xsl:template>
 

 <xsl:template name="avail_columns">
 <xsl:if test="default_template != 'Y'">
  		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CUST_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">
				<xsl:choose>
					<xsl:when test="$productcode = 'IP'">invoice_ref_id</xsl:when>
					<xsl:otherwise>issuer_ref_id</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
		<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUE_DATE')"/></xsl:with-param>
		<xsl:with-param name="column_type">Date</xsl:with-param>
			<xsl:with-param name="column_name_label">
				<xsl:choose>
					<xsl:when test="$productcode = 'IP'">invoice_date</xsl:when>
					<xsl:otherwise>iss_date</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_DUE_DATE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Date</xsl:with-param>
		</xsl:call-template>
			<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_BEI')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_STREET_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_TOWN_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_COUNTRY_SUB_DIV')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_POST_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_COUNTRY')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_BEI')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_STREET_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_TOWN_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_COUNTRY_SUB_DIV')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_POST_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_COUNTRY')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_DESCRIPTION')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_ADJUSTMENT_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
		</xsl:call-template>
			<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_CUSTOMER_REFERENCE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
 </xsl:template>
 
 <!-- Definition of columns -->
 <xsl:template name="Columns_Definitions">
 dojo.ready(function()
 {
 	misys._config = (misys._config) || {};
	misys._config.arrColumn = misys._config.arrColumn || [];
 	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_REF_ID')"/>"] = new Array("String", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CUST_REF_ID')"/>"] = new Array("String", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUE_DATE')"/>"] = new Array("Date", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_DUE_DATE')"/>"] = new Array("Date", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_ABBREVIATED_NAME')"/>"] = new Array("String", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_BEI')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_STREET_NAME')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_TOWN_NAME')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_COUNTRY_SUB_DIV')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_POST_CODE')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_COUNTRY')"/>"] = new Array("String", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ABBREVIATED_NAME')"/>"] = new Array("String", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_NAME')"/>"] = new Array("String", false);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/>"] = new Array("String", true);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_BEI')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_STREET_NAME')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_TOWN_NAME')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_COUNTRY_SUB_DIV')"/>"] = new Array("String", false);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_POST_CODE')"/>"] = new Array("String", false);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_COUNTRY')"/>"] = new Array("String", true);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_DESCRIPTION')"/>"] = new Array("String", false);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_CUR_CODE')"/>"] = new Array("String", true);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/>"] = new Array("String", true);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_ADJUSTMENT_AMT')"/>"] = new Array("Number", false);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_AMT')"/>"] = new Array("Number", true);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/>"] = new Array("Number", true);
	misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/>"] = new Array("String", true);
    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_CUSTOMER_REFERENCE')"/>"] = new Array("String", false);
    misys._config.amountFormatOptions = [{value:"english",name:"<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DECIMAL_ENGLISH')"/>"},{value:"french",name:"<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DECIMAL_FRENCH')"/>" }];
    misys._config.amountFormatSelectOptions = {
					   						comma: 	[{ 
			   								value:"english",
					         				name:"<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DECIMAL_ENGLISH')"/>"
					         				}],
			
										'.' : 
											[{ 
			   								value:"french",
					         				name:"<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DECIMAL_FRENCH')"/>"
					         				}]
										
							};
  });
 </xsl:template>
 
 <!-- Creates an editing form for a selected column -->
<!--  <xsl:call-template name="column-information" /> -->
 
 <!-- Creates a new Option element for the list of column -->
<xsl:template match="column" mode="list">
	<xsl:variable name="codeval">
		<xsl:choose>
			<xsl:when test="name='iss_date' and $productcode='IP'">XSL_REPORT_COL_invoice_date</xsl:when>
			<xsl:when test="name='issuer_ref_id' and  $productcode='IP'">XSL_REPORT_COL_invoice_ref_id</xsl:when>
			<xsl:otherwise>XSL_REPORT_COL_<xsl:value-of select="name"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<option>
		<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
		<xsl:value-of select="localization:getGTPString($language, $codeval)"/>
	</option>
</xsl:template>

<xsl:template name="update-column-information">
	<script>
		dojo.ready(function(){
		misys._config = (misys._config) || {};
		misys._config.mappedColumns = misys._config.mappedColumns || [];
		misys._config.matchedColumn = "Y";

		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_REF_ID')"/>"]     ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CUST_REF_ID')"/>"]    ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUE_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_DUE_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_ABBREVIATED_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/>"]     ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_BEI')"/>"]    ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_STREET_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_TOWN_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_COUNTRY_SUB_DIV')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_POST_CODE')"/>"]     ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_COUNTRY')"/>"]    ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ABBREVIATED_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_BEI')"/>"]     ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_STREET_NAME')"/>"]    ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_TOWN_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_COUNTRY_SUB_DIV')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_POST_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_COUNTRY')"/>"]     ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_DESCRIPTION')"/>"]    ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_ADJUSTMENT_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_AMT')"/>"]    ={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_CUSTOMER_REFERENCE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
		
		<!-- Before populating the column parameters, checking if the template is old or new. If template is old dispaly appropriate message --> 
		<xsl:for-each select="definition/column">
			if(misys._config.mappedColumns['<xsl:value-of select="name"/>'] === undefined)
			{
				misys._config.matchedColumn = "N";
				return;
			}
		</xsl:for-each>
		
		<!-- Populating column parameters -->
		<xsl:for-each select="definition/column">
			<xsl:if test="start[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].start 	= <xsl:value-of select="start"/>;
			</xsl:if>
			<xsl:if test="length[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].formatLength = <xsl:value-of select="length"/>;
			</xsl:if>
			<xsl:if test="type[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].dataType = '<xsl:value-of select="type"/>';
			</xsl:if>
			<xsl:if test="key[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].key = '<xsl:value-of select="key"/>';
			</xsl:if>
			<xsl:if test="format[.!='']">
				<xsl:choose>
					<xsl:when test="type[.='Number']">
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].amountFormat = '<xsl:value-of select="format"/>';
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].amountFormatText = '<xsl:value-of select="format"/>';
					</xsl:when>
					<xsl:when test="type[.='Date']">
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].dateFormatText = '<xsl:value-of select="format"/>';
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].dateFormat = '<xsl:value-of select="format"/>';
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
	  });	
	</script>
</xsl:template>

<xsl:template name="convert-delimiter-value">
<xsl:param name="value"/>
<xsl:choose>
	<xsl:when test="$value = ','">comma</xsl:when>
	<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>