<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization security">

	<!-- Columns definition import -->
	<xsl:import href="../../../core/xsl/report/report.xsl"/>

	<!-- Static document upload -->
	<xsl:import href="../../../core/xsl/common/static_document_upload_templates.xsl"/>
	
<!--
   Copyright (c) 2000-2009 Misys (http://www.misys.com),
   All Rights Reserved.
   
   Guarantee type form stylesheet.
-->
	<xsl:output method="html" indent="yes"/>

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
	<xsl:param name="token"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="operation"/>

	<xsl:param name="isTemplate">false</xsl:param>	<!-- This parameter is used by the report templates -->

	<!-- Global Imports. -->
	<xsl:include href="../../../core/xsl/common/system_common.xsl" />
	<xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
	<!-- <xsl:include href="../report/report_addons.xsl"/>
	<xsl:include href="../report/report_columns_definition.xsl"/>
	<xsl:include href="../report/report_product_columns_definition.xsl"/>-->

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select= "standbyLC"/>
	</xsl:template>
	
	<!--TEMPLATE Main-->
		
	<xsl:template match="standbyLC">
		<!-- Loading message  -->
		<xsl:call-template name="loading-message"/>
	
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="hidden-fields"/>
					<xsl:call-template name="SBLC-details"/>
					<!--  Display common menu. -->
					<xsl:call-template name="system-menu"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="realform">
				<xsl:with-param name="option"><xsl:value-of select="$option"/></xsl:with-param>
				<xsl:with-param name="featureid">
					<xsl:if test="name_[.!=''] and $operation!='ADD_FEATURES'">
						<xsl:value-of select="name_"/>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</div>

		<!-- Javascript imports  -->
		<xsl:call-template name="js-imports"/>
		
		<!-- Add the definition of columns (used in the RTE editor) -->
		<script>
			// Instantiate columns arrays
			<xsl:call-template name="product-arraylist-initialisation"/>
			
			// Add columns definitions
			<xsl:call-template name="Columns_Definitions"/>
			
			<!-- Include some eventual additional columns -->
			<xsl:call-template name="report_addons"/>
		</script>

		<!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
		<xsl:call-template name="Products_Columns_Candidates"/>

		<!-- Widgets templates -->
		<xsl:call-template name="customer-dialog-template"/>
		
	</xsl:template>	

 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">standbyLC</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.standbyLC</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_SBLC</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
  </xsl:call-template>
  
 </xsl:template>

 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
    <xsl:template name="hidden-fields">
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">user_company_id</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="company_id" /></xsl:with-param>
        </xsl:call-template>
    </xsl:template>

 <!-- ***************************************************************************************** -->
 <!-- ************************************* STATIC ROLE FORM ********************************** -->
 <!-- ***************************************************************************************** -->

<xsl:template name="SBLC-details">

   <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
	<xsl:with-param name="parse-widgets">N</xsl:with-param>
	<xsl:with-param name="content">

    <!-- Guarantee name -->
   
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SBLC_NAME</xsl:with-param>
     <xsl:with-param name="name">name_</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">40</xsl:with-param>
     <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('SYSTEM_FEATURES_STANDBYLC_MAINTENANCE_NAME_REGEX')"/></xsl:with-param>
    </xsl:call-template>

    <!-- Guarantee description -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SBLC_DESCRIPTION</xsl:with-param>
     <xsl:with-param name="name">description</xsl:with-param>
     <xsl:with-param name="size">40</xsl:with-param>
     <xsl:with-param name="maxsize">255</xsl:with-param>
     <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('SYSTEM_FEATURES_STANDBYLC_MAINTENANCE_DESCRIPTION_REGEX')"/></xsl:with-param>
    </xsl:call-template>

    <!-- Guarantee type -->
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
      <xsl:with-param name="name">si_type_code</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="type_code"/></xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="product_type_code_options"/> 	
      </xsl:with-param>
     </xsl:call-template>

    <!-- Guarantee type -->
    <!-- <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GUARANTEE_TYPE</xsl:with-param>
     <xsl:with-param name="name">bg_type_code</xsl:with-param>
     <xsl:with-param name="size">6</xsl:with-param>
     <xsl:with-param name="maxsize">6</xsl:with-param>
    </xsl:call-template>-->

	<!-- Activated checkbox -->
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_SBLC_ACTIVED</xsl:with-param>
     <xsl:with-param name="name">activated</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="multioption-group">
     <!-- <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_FLAG_LABEL</xsl:with-param>-->
     <xsl:with-param name="content">
      <xsl:call-template name="radio-field">
       <xsl:with-param name="label">XSL_SBLC_STANDARD</xsl:with-param>
       <xsl:with-param name="name">text_type_code</xsl:with-param>
       <xsl:with-param name="id">text_type_code_1</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
       <xsl:with-param name="checked"><xsl:if test="text_type_code = '01'">Y</xsl:if></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="radio-field">
       <xsl:with-param name="label">XSL_SBLC_EDITOR</xsl:with-param>
       <xsl:with-param name="name">text_type_code</xsl:with-param>
       <xsl:with-param name="id">text_type_code_2</xsl:with-param>
       <xsl:with-param name="value">02</xsl:with-param>
       <xsl:with-param name="checked"><xsl:if test="text_type_code = '02'">Y</xsl:if></xsl:with-param>
      </xsl:call-template>
	</xsl:with-param>
   </xsl:call-template>
   
   <div id="specimen-checkbox-div" style="display:none;">
   <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_SBLC_SPECIMEN</xsl:with-param>
     <xsl:with-param name="name">specimen</xsl:with-param>
    </xsl:call-template>
   </div>
   <!-- Specimen Name Input -->
   <div id="specimen-section" style="display:none;">
     <div class="clear"/>     
	 <xsl:call-template name="static-document">
	   <!-- <xsl:param name="max-files">5</xsl:param>-->
	   <xsl:with-param name="existing-static-document"><xsl:value-of select="specimen_name"/></xsl:with-param>
	   <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
	   <xsl:with-param name="add-button-label">XSL_SBLC_ADD_SPECIMEN</xsl:with-param>
	   <xsl:with-param name="add-button-id">staticDocumentAddButton</xsl:with-param>
	   <xsl:with-param name="static-document-field-id">specimen_name</xsl:with-param>
	   <xsl:with-param name="static-document-field-label">XSL_SBLC_SPECIMEN_NAME</xsl:with-param>
	   <xsl:with-param name="document-id-field-id">document_id</xsl:with-param>
	 </xsl:call-template>
	    <!-- <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GUARANTEE_SPECIMEN_NAME</xsl:with-param>
	     <xsl:with-param name="name">specimen_name</xsl:with-param>
	     <xsl:with-param name="size">40</xsl:with-param>
	     <xsl:with-param name="maxsize">40</xsl:with-param>
	    </xsl:call-template>
	    <button dojoType="dijit.form.Button" type="button" id="buttonAddSpecimen"><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_SPECIMEN')"/></button>-->
	</div>

	<!-- WYSIWYG Editor -->
	<div id="document-editor" style="display:none;">
     <div class="clear"/>
		<xsl:call-template name="richtextarea-field">
			<xsl:with-param name="label">XSL_REPORT_SI</xsl:with-param>
			<xsl:with-param name="name">si_document</xsl:with-param>
			<xsl:with-param name="rows">13</xsl:with-param>
			<xsl:with-param name="cols">40</xsl:with-param>
			<xsl:with-param name="value"><xsl:apply-templates select="si_document"/></xsl:with-param>
			<xsl:with-param name="instantiation-event">/document-editor/display</xsl:with-param>
		</xsl:call-template>
	</div>
	
	<div id="autoSpecimen-section" style="display:none;">	
	<div class="clear"/>    		
     	<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SBLC_AUTO_SPECIMEN_NAME</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="name">auto_specimen_name</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="auto_specimen_name"/></xsl:with-param>
		</xsl:call-template>
	</div>

   <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_SBLC_CUSTOMERS</xsl:with-param>
	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
	<xsl:with-param name="parse-widgets">N</xsl:with-param>
	<xsl:with-param name="content">
		<!-- Standard checkbox -->
		<xsl:call-template name="checkbox-field">
			<xsl:with-param name="label">XSL_SBLC_FOR_ALL_CUSTOMERS</xsl:with-param>
			<xsl:with-param name="name">standard</xsl:with-param>
		</xsl:call-template>
		<!-- Customers grid -->
		<div id="customers-section">
		<xsl:call-template name="build-customers-dojo-items">
			<xsl:with-param name="items" select="customers/customer"/>
		</xsl:call-template>
		</div>
	</xsl:with-param>
   </xsl:call-template>
	</xsl:with-param>
	</xsl:call-template>
 </xsl:template>

	
 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <xsl:param name="option"/>
  <xsl:param name="featureid"/>
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action">
   		<xsl:choose>
          <xsl:when test="$nextscreen and $nextscreen !=''"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:otherwise>
        </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
     
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="$featureid != ''">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">featureid</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$featureid"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>

      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">token</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

	<xsl:template name="customer-dialog-template">
		<div id="customer-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<!-- Customer entity -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
				<xsl:with-param name="name">customer_entity</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="button-type">system-standby-maintenance-entity</xsl:with-param>
			</xsl:call-template>
    
			<!-- Customer abbreviated name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">customer_abbv_name</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
			</xsl:call-template>
			<!-- Customer name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">customer_name</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
			</xsl:call-template>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button dojoType="dijit.form.Button" type="button" id="customerOkButton">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
						</button>
						<button dojoType="dijit.form.Button" type="button" id="customerCancelButton">
							<xsl:attribute name="onmouseup">dijit.byId('customer-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
		<!-- Dialog End -->
		<div id="customers-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NO_CUSTOMER_SETUP')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<button dojoType="dijit.form.Button" type="button" id="addCustomerButton" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_CUSTOMER')"/>
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<!-- **************************************************************************
	                         CUSTOMERS - START                                
	************************************************************************** -->
	<xsl:template name="build-customers-dojo-items">
		<xsl:param name="items"/>
		
		<div dojoType="misys.system.widget.Customers" dialogId="customer-dialog-template" gridId="customers-grid" id="customers">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'ABBVNAME')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'NAME')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_CUSTOMER')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="customer" select="."/>
				<xsl:variable name="position" select="position()" />
				<div dojoType="misys.system.widget.Customer">
					<xsl:attribute name="id">customer_<xsl:value-of select="$position"/></xsl:attribute>
					<xsl:attribute name="name_"><xsl:value-of select="$customer/name_"/></xsl:attribute>
					<xsl:attribute name="abbv_name"><xsl:value-of select="$customer/abbv_name"/></xsl:attribute>
					<xsl:attribute name="entity"><xsl:value-of select="$customer/entity"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>
	
	<xsl:template match="si_document">
	  <xsl:copy-of select="child::node()"/>
	</xsl:template>
	

	<!-- ************************************************************************* -->
	<!--                          COLUMNS - END                                    -->
	<!-- ************************************************************************* -->
</xsl:stylesheet>
