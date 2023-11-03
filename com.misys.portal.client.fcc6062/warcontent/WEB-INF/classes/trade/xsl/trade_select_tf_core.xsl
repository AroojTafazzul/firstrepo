<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp	"&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">

<!--
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<!-- Get the language code -->
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="nextscreen"/>
	<xsl:param name="company"/>
	<xsl:param name="product-code">TF</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FinancingRequestScreen</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="option" />
	<xsl:param name="ref_id" />
	<xsl:param name="tnx_id" />
	<xsl:param name="modulename" />
	<!--  <xsl:param name="subproductcode" />-->

	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/common/tf_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="select-financ-type"/>
	</xsl:template>

	<!--TEMPLATE Main-->
  <xsl:template match="select-financ-type">
  <xsl:call-template name="loading-message"/>
   <div>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_SELECT_FINANCING</xsl:with-param>
       <xsl:with-param name="content">
       
         <!-- Name of Guarantee -->
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_SELECT_FINANCING_TYPE</xsl:with-param>
	      <xsl:with-param name="name">sub_product_code</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:choose>
	      	<xsl:when test="option[.='FROM_IMPORT_SCRATCH']">
	        <xsl:call-template name="tf-import-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_EXPORT_SCRATCH']">
	        <xsl:call-template name="tf-export-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_IMPORT_LC']">
	        <xsl:call-template name="tf-import-LC-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_IMPORT_COLLECTION']">
	        <xsl:call-template name="tf-import-IC-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_EXPORT_LC']">
	        <xsl:call-template name="tf-export-LC-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_EXPORT_COLLECTION']">
	        <xsl:call-template name="tf-export-Collection-financing-types"/>
	        </xsl:when>
	        <xsl:otherwise>
	        </xsl:otherwise>
	       </xsl:choose>
	      </xsl:with-param>
	     </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
   <!-- Actions -->
   <xsl:call-template name="tf-select-menu"/>
    </xsl:with-param>
   </xsl:call-template>
   <!-- Realform -->
   <xsl:call-template name="realform"/>
  </div>
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/>
 </xsl:template>

 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.trade.select_tf</xsl:with-param>
   <xsl:with-param name="override-help-access-key">TF_01</xsl:with-param>
  </xsl:call-template>  
 </xsl:template>
 
 <xsl:template name="tf-select-menu">
	
	<div class="menu widgetContainer">
	<xsl:call-template name="localization-dialog"/>
       <xsl:call-template name="button-wrapper">
        <xsl:with-param name="label">XSL_ACTION_OK</xsl:with-param>
        <xsl:with-param name="onclick">misys.select('OK');return false;</xsl:with-param>
        <xsl:with-param name="show-text-label">Y</xsl:with-param>
       </xsl:call-template>
     
      <xsl:call-template name="button-wrapper">
       <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
       <xsl:with-param name="onclick">misys.select('CANCEL');return false;</xsl:with-param>
       <xsl:with-param name="show-text-label">Y</xsl:with-param>
      </xsl:call-template>
     </div>
</xsl:template>

  <!--
   TF Realform
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
       <xsl:with-param name="value" select="$ref_id"/>
      </xsl:call-template>
       <xsl:if test="option[.='FROM_IMPORT_LC'] or option[.='FROM_EXPORT_LC']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxid</xsl:with-param>
       <xsl:with-param name="value" select="$tnx_id"/>
      </xsl:call-template>
      </xsl:if>
      <xsl:if test="option[.!='FROM_IMPORT_LC'] and option[.!='FROM_EXPORT_LC']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxid</xsl:with-param>
       <xsl:with-param name="value" select="tnx_id"/>
      </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="id">realform_option</xsl:with-param>
       <xsl:with-param name="value" select="$option" />
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="id">realform_tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>
		<xsl:if test="$nextscreen='TradeAdminScreen'">
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">productcode</xsl:with-param>
	       <xsl:with-param name="id">realform_productcode</xsl:with-param>
	       <xsl:with-param name="value">TF</xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">operation</xsl:with-param>
	       <xsl:with-param name="id">realform_operation</xsl:with-param>
	       <xsl:with-param name="value">CREATE_REPORTING</xsl:with-param>
	      </xsl:call-template>
		</xsl:if>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">featureid</xsl:with-param>
       <xsl:with-param name="id">realform_featureid</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">company</xsl:with-param>
       <xsl:with-param name="id">realform_company</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">modulename</xsl:with-param>
       <xsl:with-param name="value" select="$modulename" />
      </xsl:call-template>
      <!--
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">subproductcode</xsl:with-param>
       <xsl:with-param name="value" select="$subproductcode" />
      </xsl:call-template>
      --></div>
     </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
 
</xsl:stylesheet>
