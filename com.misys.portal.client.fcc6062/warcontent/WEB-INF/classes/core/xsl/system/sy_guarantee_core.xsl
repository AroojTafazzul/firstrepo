<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization security defaultresource">

	<!-- Columns definition import -->
	<xsl:import href="../report/report.xsl"/>

	<!-- Static document upload -->
	<xsl:import href="../common/static_document_upload_templates.xsl"/>
	
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
	<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
    <xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
    <xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>
    <xsl:variable name="swift2019Enabled" select="defaultresource:isSwift2019Enabled()"/>
	

	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl" />
	<xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
	<!-- <xsl:include href="../report/report_addons.xsl"/>
	<xsl:include href="../report/report_columns_definition.xsl"/>
	<xsl:include href="../report/report_product_columns_definition.xsl"/>-->

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!--TEMPLATE Main-->
	
	<xsl:template match="guarantee">
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
					<xsl:call-template name="guarantee-details"/>
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
   <xsl:with-param name="xml-tag-name">guarantee</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.guarantee</xsl:with-param>
   <xsl:with-param name="override-help-access-key">BA_GU_MA</xsl:with-param>
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
 <xsl:template name="guarantee-details">
 <!-- Enabling Domestic Guarantees -->
	<xsl:variable name="domesticGuaranteeEnabled" select="defaultresource:getResource('DOMESTIC_GUARANTEE_ENABLED')"></xsl:variable>
   <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
	<xsl:with-param name="parse-widgets">N</xsl:with-param>
	<xsl:with-param name="content">

    <!-- Guarantee name -->
   
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GUARANTEE_NAME</xsl:with-param>
     <xsl:with-param name="name">name_</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">35</xsl:with-param>
    </xsl:call-template>
    
    <!-- Domestic Guarantee field -->
     <xsl:if test="$domesticGuaranteeEnabled= 'true'">
    <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_GUARANTEE_FORM_MASK</xsl:with-param>
      <xsl:with-param name="name">form_mask</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="form_mask"/></xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="06">
	       	<xsl:value-of select="localization:getGTPString($language, 'GTEEDETAILS_ACT_MASK_PR03G1')"/>
	       </option>
	       <option value="07">
	      	 <xsl:value-of select="localization:getGTPString($language, 'GTEEDETAILS_ACT_MASK_PR05CS')"/>
	       </option>
	    </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="form_mask[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'GTEEDETAILS_ACT_MASK_PR03G1')"/></xsl:when>
          <xsl:when test="form_mask[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'GTEEDETAILS_ACT_MASK_PR05CS')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
    </xsl:if>
    

    <!-- Guarantee description -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GUARANTEE_DESCRIPTION</xsl:with-param>
     <xsl:with-param name="name">description</xsl:with-param>
     <xsl:with-param name="size">40</xsl:with-param>
     <xsl:with-param name="maxsize">255</xsl:with-param>
    </xsl:call-template>
    
   
     <!-- Undertaking subproduct code (SWIFT2021 Enabled scenario) -->
    <xsl:choose>
    <xsl:when test = "$swift2019Enabled">
     <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_UNDERTAKING_SUBPRODUCT_LABEL</xsl:with-param>
     <xsl:with-param name="name">sub_product_code</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
		   <xsl:when test="$displaymode='edit'">
		      <option value="*">
		       <xsl:value-of select="localization:getDecode($language, 'N047', '*')"/>
		      </option>
		      <option value="STBY">
		       <xsl:value-of select="localization:getDecode($language, 'N047', 'STBY')"/>
		      </option>
		      <option value="DEPU">
		       <xsl:value-of select="localization:getDecode($language, 'N047', 'DEPU')"/>
		      </option>
		      <option value="DGAR">
		       <xsl:value-of select="localization:getDecode($language, 'N047', 'DGAR')"/>
		      </option>
		   </xsl:when>
	   <xsl:otherwise>
		    <xsl:choose>
		      <xsl:when test="sub_product_code[. = '*']"><xsl:value-of select="localization:getDecode($language, 'N047', '*')"/></xsl:when>
	          <xsl:when test="sub_product_code[. = 'STBY']"><xsl:value-of select="localization:getDecode($language, 'N047', 'STBY')"/></xsl:when>
	          <xsl:when test="sub_product_code[. = 'DEPU']"><xsl:value-of select="localization:getDecode($language, 'N047', 'DEPU')"/></xsl:when>
	          <xsl:when test="sub_product_code[. = 'DGAR']"><xsl:value-of select="localization:getDecode($language, 'N047', 'DGAR')"/></xsl:when>
	         </xsl:choose>
	   </xsl:otherwise>
	  </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    </xsl:when>  
    <xsl:otherwise>
	    <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">sub_product_code</xsl:with-param>
		   <xsl:with-param name="value">**</xsl:with-param>
	    </xsl:call-template>
    </xsl:otherwise>
</xsl:choose>

    <!-- Guarantee type -->
     <xsl:choose>
     <xsl:when test = "$swift2019Enabled">
	     <xsl:call-template name="select-field">    
	      <xsl:with-param name="label">XSL_UNDERTAKINGDETAILS_TYPE_LABEL</xsl:with-param>       
	      <xsl:with-param name="name">bg_type_code</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="type_code"/></xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="product_type_code_options"/>	
	      </xsl:with-param>
	     </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
         <xsl:call-template name="select-field">    
	      <xsl:with-param name="label">XSL_GTEEDETAILS_TYPE_LABEL</xsl:with-param>
	      <xsl:with-param name="name">bg_type_code</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="type_code"/></xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="product_type_code_options"/>	
	      </xsl:with-param>
	     </xsl:call-template>
     </xsl:otherwise>
     </xsl:choose>

    <!-- Guarantee type -->
    <!-- <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GUARANTEE_TYPE</xsl:with-param>
     <xsl:with-param name="name">bg_type_code</xsl:with-param>
     <xsl:with-param name="size">6</xsl:with-param>
     <xsl:with-param name="maxsize">6</xsl:with-param>
    </xsl:call-template>-->

	<!-- Activated checkbox -->
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_GUARANTEE_ACTIVED</xsl:with-param>
     <xsl:with-param name="name">activated</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="multioption-group">
     <!-- <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_FLAG_LABEL</xsl:with-param>-->
     <xsl:with-param name="content">
      <xsl:call-template name="radio-field">
       <xsl:with-param name="label">XSL_GUARANTEE_STANDARD</xsl:with-param>
       <xsl:with-param name="name">text_type_code</xsl:with-param>
       <xsl:with-param name="id">text_type_code_1</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
       <xsl:with-param name="checked"><xsl:if test="text_type_code = '01'">Y</xsl:if></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="radio-field">
       <xsl:with-param name="label">XSL_GUARANTEE_EDITOR</xsl:with-param>
       <xsl:with-param name="name">text_type_code</xsl:with-param>
       <xsl:with-param name="id">text_type_code_2</xsl:with-param>
       <xsl:with-param name="value">02</xsl:with-param>
       <xsl:with-param name="checked"><xsl:if test="text_type_code = '02'">Y</xsl:if></xsl:with-param>
      </xsl:call-template>
	</xsl:with-param>
   </xsl:call-template>
   
   <div id="specimen-checkbox-div" style="display:none;">
   <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_GUARANTEE_SPECIMEN</xsl:with-param>
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
	   <xsl:with-param name="add-button-label">XSL_GUARANTEE_ADD_SPECIMEN</xsl:with-param>
	   <xsl:with-param name="add-button-id">staticDocumentAddButton</xsl:with-param>
	   <xsl:with-param name="static-document-field-id">specimen_name</xsl:with-param>
	   <xsl:with-param name="static-document-field-label">XSL_GUARANTEE_SPECIMEN_NAME</xsl:with-param>
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
			<xsl:with-param name="label">XSL_REPORT_BG</xsl:with-param>
			<xsl:with-param name="name">bg_document</xsl:with-param>
			<xsl:with-param name="rows">13</xsl:with-param>
			<xsl:with-param name="cols">40</xsl:with-param>
			<xsl:with-param name="value"><xsl:apply-templates select="bg_document"/></xsl:with-param>
			<xsl:with-param name="instantiation-event">/document-editor/display</xsl:with-param>
		</xsl:call-template>
	</div>
	
	<div id="autoSpecimen-section" style="display:none;">	
	<div class="clear"/>    		
     	<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GUARANTEE_AUTO_SPECIMEN_NAME</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="name">auto_specimen_name</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="auto_specimen_name"/></xsl:with-param>
		</xsl:call-template>
	</div>

   <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_GUARANTEE_CUSTOMERS</xsl:with-param>
	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
	<xsl:with-param name="parse-widgets">N</xsl:with-param>
	<xsl:with-param name="content">
		<!-- Standard checkbox -->
		<xsl:call-template name="checkbox-field">
			<xsl:with-param name="label">XSL_GUARANTEE_FOR_ALL_CUSTOMERS</xsl:with-param>
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

	<!-- 
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"/>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"/>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/sy_guarantee.js"/>
		<script type="text/javascript">
			fncPreloadImages('/content/images/edit.png', '/content/images/delete.png'); 
		</script>		

		<table border="0" width="100%">
		<tr>
		<td align="center">
		
		<table border="0">
		<tr>
		<td align="left">

			<div style="position:absolute;visibility:hidden;">
				<table>
					<tbody id="customers_template">
						<xsl:call-template name="customer_record">
							<xsl:with-param name="structure_name">customers</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>

			<form name="fakeform1" onsubmit="return false;">
				<input type="hidden" name="company_id">
					<xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute>
				</input>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_MAIN_DETAILS')"/></b>
						</td>
					</tr>
				</table>

				<br/>

				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="200">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NAME')"/>
							</font>
						</td>
						<td>
							<xsl:choose>
								<xsl:when test="$operation!='ADD_FEATURES'">
									<xsl:value-of select="name"/>
									<input type="hidden" name="name">
										<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
									</input>
								</xsl:when>
								<xsl:otherwise>
									<input type="text" size="20" maxlength="40" name="name" onblur="fncRestoreInputStyle('fakeform1','name');fncValidateGTEEName(this);">
										<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
									</input>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="200">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_DESCRIPTION')"/>
							</font>
						</td>
						<td>
							<input type="text" size="40" maxlength="255" name="description" onblur="fncRestoreInputStyle('fakeform1','description')">
								<xsl:attribute name="value"><xsl:value-of select="description"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="200">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_TYPE')"/>
							</font>
						</td>
						<td>
							<input type="text" size="6" maxlength="6" name="type_code" readOnly="readOnly">
								<xsl:attribute name="value"><xsl:value-of select="type_code"/></xsl:attribute>
							</input>
							<a name="anchor_search_type" href="javascript:void(0)" style="margin-left:5px;">
								<xsl:attribute name="onclick">fncSearchPopup('codevalue', 'fakeform1',"['type_code']", 'C900');return false;</xsl:attribute>
								<img border="0" src="/content/images/search.png" name="img_search_bg_type">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PRODUCT')"/></xsl:attribute>
								</img>         										
						    </a>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td width="200">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ACTIVED')"/>
						</td>
						<td>
							<input type="checkbox" name="activated">
								<xsl:if test="activated[. = 'Y']">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>
						</td>
					</tr>
				</table>
				<br/>					

				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_CUSTOMERS')"/></b>
						</td>
					</tr>
				</table>

				<br/>

				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="200">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_STANDARD')"/>
						</td>
						<td>
							<input type="checkbox" onclick="fncShowHideCustomersDetails(this);">
								<xsl:attribute name="name">standard</xsl:attribute>
								<xsl:if test="standard[. = 'Y']">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>
						</td>
					</tr>
				</table>

				<br/>
						
				<xsl:element name="div">
					<xsl:attribute name="id">customers_section</xsl:attribute>
					<xsl:if test="standard[. = 'Y']">
						<xsl:attribute name="style">display:none</xsl:attribute>
					</xsl:if>
					<xsl:variable name="countrecords">
						<xsl:value-of select="count(//customer)"/>
					</xsl:variable>
          
		          <table border="0" width="570" cellpadding="0" cellspacing="0">
		            <tr>
		              <td width="40">&nbsp;</td>
		                <td>
		
		                  <div id="customers_disclaimer">
		                    <xsl:if test="$countrecords != 0">
		                      <xsl:attribute name="style">display:none</xsl:attribute>
		                    </xsl:if>
		                    <b><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NO_CUSTOMER_SETUP')"/></b>
		                  </div>
		                  
		                  <table border="0" width="530" cellpadding="0" cellspacing="1" id="customers_master_table">
		                    <xsl:if test="$countrecords = 0">
		                      <xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
		                    </xsl:if>
		                    <tbody id="customers_table">
		                      <tr id="customers_table_header_1">
		                        <xsl:if test="$countrecords = 0">
		                          <xsl:attribute name="style">visibility:hidden;</xsl:attribute>
		                        </xsl:if>
		                        <th class="FORMH2" align="center" width="200">
		                          <xsl:value-of select="localization:getGTPString($language, 'ABBVNAME')"/>
		                        </th>
		                        <th class="FORMH2" align="center">
		                          <xsl:value-of select="localization:getGTPString($language, 'NAME')"/>
		                        </th>
		                        <th class="FORMH2" align="center">
		                          <xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>
		                        </th>
		                        <th class="FORMH2" align="center" width="10%">&nbsp;</th>
		                      </tr>
		                      <xsl:apply-templates select="//customer"/>
		                    </tbody>
		                  </table>
		                  <br/>
		                  
		                  <a href="javascript:void(0)">
		                    <xsl:attribute name="onClick">fncPreloadImages('/content/images/search.png', '/content/images/edit.png', '/content/images/delete.png'); fncLaunchProcess("fncAddElement('fakeform1', 'customers', '')");</xsl:attribute>
		                    <xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_CUSTOMER')"/>
		                  </a>
		            
		              </td>
		            </tr>
		          </table>
				</xsl:element>


			</form>

		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		</table>
		
		<center>
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('save');return false;">
							<img border="0" src="/content/images/pic_form_save.gif"/>
							<br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
							<img border="0" src="/content/images/pic_form_cancel.gif"/>
							<br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
				</tr>
			</table>
		</center>
		<form name="realform" method="POST">
			<xsl:attribute name="action">/gtp/screen/<xsl:value-of select="$nextscreen"/></xsl:attribute>
			<input type="hidden" name="operation" value="SAVE_FEATURES"/>
			<input type="hidden" name="option">
				<xsl:attribute name="value"><xsl:value-of select="$option"/></xsl:attribute>
			</input>
			<xsl:if test="name[.!=''] and $operation!='ADD_FEATURES'">
				<input type="hidden" name="featureid">
					<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
				</input>
			</xsl:if>
			<input type="hidden" name="TransactionData"/>
		</form>-->

	</xsl:with-param>
	</xsl:call-template>
 </xsl:template>


	<!-- <xsl:template match="customer">
		<xsl:call-template name="customer_record">
			<xsl:with-param name="structure_name">customers</xsl:with-param>
			<xsl:with-param name="mode">existing</xsl:with-param>
		</xsl:call-template>
	</xsl:template>-->

	<xsl:template name="customer_record">
	
		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'">
				<xsl:value-of select="position()"/>
			</xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		
		<!-- HEADER -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td width="200">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_abbv_name_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="abbv_name"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_name_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="name"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_entity_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="entity"/>
					</xsl:if>
				</div>
			</td>
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0">
					    <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>
		
		<!-- DETAILS displayed on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="3" width="100%">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td>
         				<table border="1" width="100%">
         					<tr>
         						<td>
         							<table width="100%" cellpadding="0" cellspacing="0">
         								<tr>
         									<td colspan="2">&nbsp;</td>
         								</tr>
         								<tr>
         									<td width="200">
         										<font class="FORMMANDATORY">
         											<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ENTITY')"/>
         										</font>
         									</td>
         									<td>
         										<input type="text" onFocus="javascript:blur()">
         											<xsl:attribute name="name">
         												<xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         											<xsl:attribute name="value">
         												<xsl:if test="$mode = 'existing'">
         													<xsl:value-of select="entity"/>
         												</xsl:if>
         											</xsl:attribute>
         											<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/>');</xsl:attribute>
         										</input>&nbsp;
         										
         										<!-- <a href="javascript:void(0)" name="anchor_search_bg_customer">
         											<xsl:attribute name="onclick">fncSearchPopup('customers', 'fakeform1', "['<xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_abbv_name_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/>']", '', 'CalyonSearchPopup');return false;</xsl:attribute>
         											<img src="/content/images/pic_search.gif" border="0"/>
         										</a>
         										-->
         										<!-- Add customer search popup -->
         										<a name="anchor_search_applicant" href="javascript:void(0)">
													<xsl:attribute name="onclick">misys.showEntityDialog('entity', "['<xsl:value-of select="$structure_name"/>_details_company_id_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_abbv_name_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/>']",'BG','SYSTEM');return false;</xsl:attribute>
						   							<img border="0" name="anchor_search_bg_customer">
						   								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/>s</xsl:attribute>
						   								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_CUSTOMER')"/></xsl:attribute>
						   							</img>
						   						</a>
						   						
						   						<input type="hidden">
         											<xsl:attribute name="name">
         												<xsl:value-of select="$structure_name"/>_details_company_id_<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         											<xsl:attribute name="value">
         												<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         										</input>
         										
         										<input type="hidden">
         											<xsl:attribute name="name">
         												<xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         											<xsl:attribute name="value">
         												<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         										</input>
         									</td>
         								</tr>
         								<tr>
         									<td width="200">
         										<font class="FORMMANDATORY">
         											<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ABREVIATED_NAME')"/>
         										</font>
         									</td>
         									<td>
         										<input type="text" onFocus="javascript:blur()">
         											<xsl:attribute name="name">
         												<xsl:value-of select="$structure_name"/>_details_abbv_name_<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         											<xsl:attribute name="value">
         												<xsl:if test="$mode = 'existing'">
         													<xsl:value-of select="abbv_name"/>
         												</xsl:if>
         											</xsl:attribute>
         											<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_abbv_name_<xsl:value-of select="$suffix"/>');</xsl:attribute>
         										</input>&nbsp;
         										<input type="hidden">
         											<xsl:attribute name="name">
         												<xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         											<xsl:attribute name="value">
         												<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         										</input>
         									</td>
         								</tr>
         								<tr>
         									<td width="200">
         										<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NAME')"/>
         									</td>
         									<td>
         										<input type="text" onFocus="javascript:blur()">
         											<xsl:attribute name="name">
         												<xsl:value-of select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         											<xsl:attribute name="value">
         												<xsl:if test="$mode = 'existing'">
         													<xsl:value-of select="name"/>
         												</xsl:if>
         											</xsl:attribute>
         											<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/>');</xsl:attribute>
         										</input>
         										<input type="hidden">
         											<xsl:attribute name="name">
         												<xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         											<xsl:attribute name="value">
         												<xsl:value-of select="$suffix"/>
         											</xsl:attribute>
         										</input>
         									</td>
         								</tr>
         								<tr>
         									<td colpan="2">&nbsp;</td>
         								</tr>
         								<tr>
         									<td colspan="2">
         										<table width="100%">
         											<td align="right" width="45%">
         												<a href="javascript:void(0)">
         													<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['abbv_name'], ['abbv_name','name', 'entity'], ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
         													<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
         												</a>
         											</td>
         											<td width="10%"/>
         											<td align="left" width="45%">
         												<a href="javascript:void(0)">
         													<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'abbv_name', ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
         													<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
         												</a>
         											</td>
         										</table>
         									</td>
         								</tr>
         							</table>
         						</td>
         					</tr>
         				</table>
         			</td>
         		</tr>
         	</table>
				</div>
			</td>
		</tr>
		
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

	<!-- ********* -->
	<!-- Customers -->
	<!-- ********* -->
	<!-- Dialog Start -->
	<xsl:template name="customer-dialog-template">
		<div id="customer-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<!-- Customer entity -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
				<xsl:with-param name="name">customer_entity</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="button-type">system-guarantee-maintenance-entity</xsl:with-param>
			</xsl:call-template>
    
			<!-- Customer abbreviated name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
				<xsl:with-param name="name">customer_abbv_name</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
			</xsl:call-template>
			<!-- Customer name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
				<xsl:with-param name="name">customer_name</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
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

	<!-- ************************************************************************** -->
	<!--                          CUSTOMERS - START                                 -->
	<!-- ************************************************************************** -->
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
	
	  <!-- commented for BG V1.9 
  	<xsl:template name="bg-type-codes">
  	<xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_STANDARD')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NON_STANDARD')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
     	<xsl:when test="bg_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_STANDARD')"/></xsl:when>
      	<xsl:when test="bg_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NON_STANDARD')"/></xsl:when>
     </xsl:choose>
     </xsl:otherwise>
    </xsl:choose> 
  
  </xsl:template>-->
	
	<xsl:template match="bg_document">
	  <xsl:copy-of select="child::node()"/>
	</xsl:template>
	

	<!-- ************************************************************************* -->
	<!--                          COLUMNS - END                                    -->
	<!-- ************************************************************************* -->
</xsl:stylesheet>
