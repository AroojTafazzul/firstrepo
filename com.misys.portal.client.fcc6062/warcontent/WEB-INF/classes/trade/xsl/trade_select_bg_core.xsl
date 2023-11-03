<?xml version="1.0" encoding="UTF-8" ?>
<!--
#############################################################
Templates for

 Select a Guarantee based on its type and name, Customer Side

Copyright (c) 2000-2009 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/13/09
author:    Gilles Weber
email:     gilles.weber@misys.com
##############################################################
-->
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
	<xsl:param name="product-code">BG</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankerGuaranteeScreen</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="option"></xsl:param>

	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="guarantees"/>
	</xsl:template>

	<!--TEMPLATE Main-->
  <xsl:template match="guarantees">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <!-- <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>-->
      
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_SELECT_GUARANTEE</xsl:with-param>
       <xsl:with-param name="content">
       
         <!-- Name of Guarantee -->
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_TYPE_LABEL</xsl:with-param>
	      <xsl:with-param name="name">bg_type_code</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="bg-type-codes"/>
	      </xsl:with-param>
	     </xsl:call-template>

         <!-- Type of Guarantee -->
	     <xsl:apply-templates select="guarantee"/>

       </xsl:with-param>
      </xsl:call-template>

   <!-- Actions -->
   <xsl:call-template name="bg-select-menu"/>
      
    </xsl:with-param>
   </xsl:call-template>
    
   <!-- Realform -->
   <xsl:call-template name="realform"/>
  </div>

  <!-- Table of Contents -->
  <!-- <xsl:call-template name="toc"/>-->
  
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/>
  
 </xsl:template>


<!--                                     -->  
<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
<!--                                     -->

 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.trade.select_bg</xsl:with-param>
  </xsl:call-template>  
 </xsl:template>

<xsl:template match="guarantee">
	<div>
		<xsl:attribute name="id"><xsl:value-of select="concat('bg_name_section_', @type)"/></xsl:attribute>
		<xsl:attribute name="style">display:none</xsl:attribute>

     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GUARANTEE_NAME</xsl:with-param>
      <xsl:with-param name="name">bg_name_select_<xsl:value-of select="@type"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:apply-templates select="name"/>
      </xsl:with-param>
     </xsl:call-template>
		
	</div>
</xsl:template>

<xsl:template match="name">
	<option>
		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
		<xsl:value-of select="."/>
	</option>
</xsl:template>

	<xsl:template name="bg-select-menu">
	
	<div class="menu widgetContainer">
       <xsl:call-template name="button-wrapper">
        <xsl:with-param name="label">XSL_ACTION_OK</xsl:with-param>
        <xsl:with-param name="id">select_guarantee_button</xsl:with-param>
        <xsl:with-param name="show-text-label">Y</xsl:with-param>
       </xsl:call-template>
     
      <xsl:call-template name="button-wrapper">
       <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
       <xsl:with-param name="id">cancel_guarantee_button</xsl:with-param>
       <xsl:with-param name="show-text-label">Y</xsl:with-param>
      </xsl:call-template>
     </div>
	</xsl:template>

  <!--
   BG Realform
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
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="id">realform_option</xsl:with-param>
       <xsl:with-param name="value">SCRATCH</xsl:with-param>
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
	       <xsl:with-param name="value">BG</xsl:with-param>
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
      </div>
     </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
 
	<!--Other Templates-->

	<xsl:template match="guarantee" mode="list">
		<xsl:element name="option">
			<xsl:attribute name="value"><xsl:value-of select="@type_code"/></xsl:attribute>
			<xsl:variable name="type">N026_<xsl:value-of select="@type_code"/></xsl:variable>
  			<xsl:value-of select="localization:getGTPString($language, $type)"/>
   			
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="guaranteeOld" mode="specific">
		<xsl:element name="option">
			<xsl:attribute name="value"><xsl:value-of select="@text_type_code"/></xsl:attribute>
	  		<xsl:value-of select="@type_code"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="guaranteeOld" mode="init">
		gtees['<xsl:value-of select="@type_code"/>'] = new Array('','',<xsl:apply-templates select="text"/>'02','<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_ATTACHED')"/>');
	</xsl:template>
	
	<xsl:template match="textOld">
		'<xsl:value-of select="@name"/>','<xsl:call-template name="quote_replace"><xsl:with-param name="input_text" select="."/></xsl:call-template>',
	</xsl:template>
	
</xsl:stylesheet>
