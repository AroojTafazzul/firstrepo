<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Export Collection (EC) Form, Bank Side.
 
 Some templates called below, can be found in common.xsl.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    exclude-result-prefixes="localization defaultresource securitycheck">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">EC</xsl:param>
  <xsl:param name="companyType" />
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ec_tnx_record"/>
  </xsl:template>
 
 <!-- 
   EC TNX FORM TEMPLATE.
  -->
  <xsl:template match="ec_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
      <xsl:call-template name="build-inco-terms-data"/>
    
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
	<xsl:choose>
				<xsl:when test ="sub_tnx_stat_code[.='17']">
					     <xsl:call-template name="attachments-file-dojo">
					       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
					       <xsl:with-param name="title-size">35</xsl:with-param>
					      </xsl:call-template> 
				</xsl:when>
				<xsl:otherwise>
					     <xsl:call-template name="attachments-file-dojo">
					       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
					       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02' or type = '01']"/>
					       <xsl:with-param name="title-size">35</xsl:with-param>
					      </xsl:call-template> 
				</xsl:otherwise>
			</xsl:choose>

	</xsl:if>

   <!-- <xsl:choose>
      <xsl:when test="tnx_type_code[.='15' or .='13']">  -->
      
      <!-- Link to display transaction contents (hidden by default) -->
      <xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] and $displaymode='edit' or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
					<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="show-hyperlink">
			<xsl:choose>
				<xsl:when test="(tnx_type_code[.='01'] or tnx_type_code[.='03']) and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='13'] and defaultresource:getResource('ENABLE_EDITING_MSG_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='15']">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	 </xsl:call-template>
      
      <div id="transactionDetails">
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         
         <!-- Disclaimer Notice -->
         <xsl:call-template name="disclaimer"/>
         
         <xsl:call-template name="hidden-fields"/>
         <xsl:call-template name="general-details"/>
         <xsl:call-template name="amt-details"/>
         
         <xsl:if test="securitycheck:hasPermission($rundata,'tradeadmin_ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	 	 </xsl:if>
         
         <!-- Bank Details -->
         <xsl:call-template name="bank-details"/>
         <xsl:call-template name="description-goods"/>
         <xsl:call-template name="ec-shipment-details"/>
         <xsl:call-template name="ec-collection-instructions"/>
         <xsl:call-template name="attachments-documents">
	      	<xsl:with-param name="product_code">EC</xsl:with-param>
	      </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </div>
     <!-- </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="common-hidden-fields">
         <xsl:with-param name="show-type">N</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>  -->
    
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>

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
   <xsl:with-param name="binding">misys.binding.bank.report_ec</xsl:with-param>
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param>   
   </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="override-product-code">ec</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ec_type_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">principal_act_no</xsl:with-param>
    <xsl:with-param name="value" select="principal_act_no"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">fee_act_no</xsl:with-param>
    <xsl:with-param name="value" select="fee_act_no"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_type</xsl:with-param>
    <xsl:with-param name="value" select="$companyType" />
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- 
  EC General Details
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
   <xsl:if test="$displaymode='view'">
    <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>  
      <xsl:if test="appl_date[. != '']">
        <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="appl_date"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	    </xsl:if>
	   <xsl:if test="cust_ref_id[. != '']">
	    <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="cust_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:if test="template_id[. != '']">
    <xsl:call-template name="row-wrapper">
    <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="template_id"/>
       </div></xsl:with-param>
    </xsl:call-template>
    </xsl:if>
    </xsl:if>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_COLL_TYPE_LABEL</xsl:with-param>
     <xsl:with-param name="id">collection_type_view</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <xsl:when test="ec_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_REGULAR')"/></xsl:when>
       <xsl:when test="ec_type_code[.='02'] or ec_type_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_DIRECT')"/></xsl:when>
      </xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <xsl:if test="$displaymode='edit'">
	  <xsl:call-template name="select-field">
	   <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
	   <xsl:with-param name="name">term_code</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	   <xsl:with-param name="fieldsize">x-large</xsl:with-param>
	   <xsl:with-param name="options">
	    <xsl:call-template name="ec-tenor-types"/>
	   </xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="name">tenor_desc</xsl:with-param>
	   <xsl:with-param name="maxsize">35</xsl:with-param>
	   <xsl:with-param name="readonly">N</xsl:with-param>
	  </xsl:call-template>
	  <xsl:variable name="radio-value" select="tenor_type"/>
	     <xsl:call-template name="multioption-inline-wrapper">
		      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
		      <xsl:with-param name="content">
			        <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
					  <xsl:with-param name="label">XSL_PAYMENTDETAILS_TENOR_SIGHT</xsl:with-param>
				      <xsl:with-param name="name">tenor_type</xsl:with-param>
				      <xsl:with-param name="id">tenor_type_1</xsl:with-param>
				      <xsl:with-param name="value">01</xsl:with-param>
				      <xsl:with-param name="checked"><xsl:if test="$radio-value = '01'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
					  <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_ACEP</xsl:with-param>
				      <xsl:with-param name="name">tenor_type</xsl:with-param>
				      <xsl:with-param name="id">tenor_type_2</xsl:with-param>
				      <xsl:with-param name="value">02</xsl:with-param>
				      <xsl:with-param name="checked"><xsl:if test="$radio-value = '02'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
					  <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_AVAL</xsl:with-param>
				      <xsl:with-param name="name">tenor_type</xsl:with-param>
				      <xsl:with-param name="id">tenor_type_3</xsl:with-param>
				      <xsl:with-param name="value">03</xsl:with-param>
				      <xsl:with-param name="checked"><xsl:if test="$radio-value = '03'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
				     </xsl:call-template>
		    	</xsl:with-param>
	    </xsl:call-template>
    
  <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_TENOR_MATURITY</xsl:with-param>
    <xsl:with-param name="name">tenor_maturity_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="swift-validate">N</xsl:with-param>
    <xsl:with-param name="readonly">N</xsl:with-param>
   </xsl:call-template>
       <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label">XSL_TENOR_PERIOD</xsl:with-param>
	      <xsl:with-param name="group-id">tenor_period_label</xsl:with-param>
	      <xsl:with-param name="show-required-prefix">N</xsl:with-param>
	      <xsl:with-param name="content">
	
	        <div class="x-small" maxLength="3" id="tenor_days" name="tenor_days" dojoType="dijit.form.NumberTextBox" trim="true" value="">
	         <xsl:attribute name="value"><xsl:value-of select="tenor_days"/></xsl:attribute>
	         <xsl:attribute name="required">N</xsl:attribute>
	         <xsl:attribute name="constraints">{places:'0',min:0, max:999}</xsl:attribute>
	        </div>
	        <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="tenor_period" id="tenor_period" class="small">
		     <xsl:attribute name="value"><xsl:value-of select="tenor_period"/></xsl:attribute>
	         <option value="D">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_DAYS')"/>
	         </option>
	         <option value="W">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_WEEKS')"/>
	         </option>
	         <option value="M">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_MONTHS')"/>
	         </option>
	         <option value="Y">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_YEARS')"/>
	         </option>
	        </select>
	        <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="tenor_from_after" id="tenor_from_after" class="medium">
		     <xsl:attribute name="value"><xsl:value-of select="tenor_from_after"/></xsl:attribute>
		     <xsl:call-template name="tenor-period-details-options"/>
	        </select><br/>
	        
	        </xsl:with-param>
	      </xsl:call-template>
	       <xsl:call-template name="select-field">
			   <xsl:with-param name="label">XSL_TENOR_START</xsl:with-param>
			   <xsl:with-param name="name">tenor_days_type</xsl:with-param>
			   <xsl:with-param name="fieldsize">large</xsl:with-param>
			   <xsl:with-param name="options">
			   <xsl:call-template name="tenor-days-types-options"/>
			   </xsl:with-param>
	  		</xsl:call-template>
	  		<xsl:call-template name="input-field">
		      <xsl:with-param name="name">tenor_type_details</xsl:with-param>
		      <xsl:with-param name="maxsize">222</xsl:with-param>
	  		</xsl:call-template>
	  		<xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_BASE_DATE</xsl:with-param>
		    <xsl:with-param name="name">tenor_base_date</xsl:with-param>
		    <xsl:with-param name="required">N</xsl:with-param>
		    <xsl:with-param name="size">10</xsl:with-param>
		    <xsl:with-param name="maxsize">10</xsl:with-param>
		    <xsl:with-param name="fieldsize">small</xsl:with-param>
		    <xsl:with-param name="type">date</xsl:with-param>
	   		</xsl:call-template>  
	         </xsl:if>
	         <xsl:if test="$displaymode='view'">
			     	 <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
					     <xsl:with-param name="value">
					     	<xsl:call-template name="ec-tenor-types"/>
					     	<xsl:if test="tenor_desc[.!='']"><xsl:text> / </xsl:text><xsl:value-of select="tenor_desc"/></xsl:if>
					     	<xsl:if test="term_code[.!='01'] and (term_code[.!='03'] or tenor_type[.!='01'])">
					     	<xsl:text> / </xsl:text><xsl:value-of select="tenor_days"/>
					     	&#160;
					     	<xsl:choose>
					     	<xsl:when test="tenor_period[.='D']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_DAYS')"/>
					     	</xsl:when>
					     	<xsl:when test="tenor_period[.='W']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_WEEKS')"/>
					     	</xsl:when>
					     	<xsl:when test="tenor_period[.='M']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_MONTHS')"/>
					     	</xsl:when>
					     	<xsl:when test="tenor_period[.='Y']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_YEARS')"/>
					     	</xsl:when>
					     	</xsl:choose>
					     	<xsl:choose>
							    	<xsl:when test="tenor_from_after[.='A']">
							     	          <xsl:text> after </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_from_after[.='E']">
							     	          <xsl:text> from(exclude start date)</xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_from_after[.='F']">
							     	          <xsl:text> from(include start date) </xsl:text>
							     	</xsl:when>
						     </xsl:choose>
					     	<xsl:choose>
					     	<xsl:when test="tenor_days_type[.='O']">
					     			<xsl:value-of select="tenor_type_details"/>
					     	</xsl:when>
					     	<xsl:otherwise>
	     					     	 <xsl:value-of select="localization:getDecode($language, 'C053', tenor_days_type)"/>
					     	</xsl:otherwise>
					     	</xsl:choose>
					     	</xsl:if>
					     </xsl:with-param>
			     	  </xsl:call-template>
			     	   <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_DRAFT_AGAINST</xsl:with-param>
					     <xsl:with-param name="value">
					     <xsl:choose>
					     <xsl:when test="tenor_type[.='01']">
					     <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_SIGHT')"></xsl:value-of>
					     </xsl:when>
   					     <xsl:when test="tenor_type[.='02']">
   					     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_ACEP')"></xsl:value-of>
   					     </xsl:when>
   					     <xsl:when test="tenor_type[.='03']">
   					     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"></xsl:value-of>
   					     </xsl:when>
					     </xsl:choose>
					     </xsl:with-param>
					    </xsl:call-template>
			     	  <xsl:if test="tenor_type[.='02'] or tenor_type[.='03']">
			     	  	 <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_PAYMENTDETAILS_TENOR_MATURITY</xsl:with-param>
					     <xsl:with-param name="value">
					     <xsl:value-of select="tenor_maturity_date"></xsl:value-of>
					     </xsl:with-param>
					     </xsl:call-template>
			     	  </xsl:if>
	         </xsl:if>
 

    <!-- Beneficiary Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_DRAWER_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-entity">
        <xsl:choose>
         <xsl:when test="entity[.='']">N</xsl:when>
         <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="show-entity-button">N</xsl:with-param>
       <xsl:with-param name="entity-required">N</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="prefix">drawer</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Remitter Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type">drawee</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="prefix">drawee</xsl:with-param>
       <xsl:with-param name="show-country">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Ec tenor Types -->
 <xsl:template name="ec-tenor-types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/>
      </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="term_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/></xsl:when>
      <xsl:when test="term_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/></xsl:when>
      <xsl:when test="term_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/></xsl:when>
      <xsl:when test="term_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!-- Options for tenor period -->
  <xsl:template name="tenor-period-details-options">
	<xsl:for-each select="tenor_period_details/tenor_period_detail">
		<option>
		<xsl:attribute name="value">
		<xsl:value-of select="tenor_period_code"></xsl:value-of>
		</xsl:attribute>
		<xsl:value-of select="tenor_period_desc"></xsl:value-of>
		</option>
	</xsl:for-each>
	</xsl:template>
  
  <!-- Options for tenor days type -->
  <xsl:template name="tenor-days-types-options">
	<xsl:for-each select="tenor_days_types/tenor_days_type">
		<option>
		<xsl:attribute name="value">
		<xsl:value-of select="tenor_days_code"></xsl:value-of>
		</xsl:attribute>
		<xsl:value-of select="tenor_days_desc"></xsl:value-of>
		</option>
	</xsl:for-each>
	</xsl:template>
 <!-- 
  EC Amount Details
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="product-code">ec</xsl:with-param>
    </xsl:call-template>
    <!--MPS-41651 - Start-->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="name">ec_outstanding_amt</xsl:with-param>
     <xsl:with-param name="appendClass">outstanding</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()='ec_cur_code']"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="ec_outstanding_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="ec_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="ec_outstanding_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="ec_outstanding_amt"/></xsl:otherwise>
       </xsl:choose>
       </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ec_outstanding_amt</xsl:with-param>
     <xsl:with-param name="value" select="ec_outstanding_amt"></xsl:with-param>
    </xsl:call-template>
    <!--MPS-41651 - End-->
    <!-- MPS-55947(In case of of collections liability amount won't be updated as per banks perspective so making the field as hidden field ) -->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="name">ec_liab_amt</xsl:with-param>
     <xsl:with-param name="appendClass">outstanding</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()='ec_cur_code']"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="ec_liab_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="ec_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="ec_liab_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="ec_liab_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ec_liab_amt</xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  EC Bank Details
  -->
 <xsl:template name="bank-details">
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   <!-- Tab 1_0 - Presenting Bank  -->
   <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_PRESENTING_BANK</xsl:with-param>
   <xsl:with-param name="tab0-content"> 
    <!-- Presenting Bank -->
    <xsl:apply-templates select="presenting_bank">
     <xsl:with-param name="prefix" select="'presenting_bank'"/>
     <xsl:with-param name="required">N</xsl:with-param>
     <xsl:with-param name="theNodeName" select="'presenting_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
   <!-- Tab 1_1 - Documents Required  -->
   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_COLLECTING_BANK</xsl:with-param>
   <xsl:with-param name="tab1-content">
   <!-- Collecting Bank -->
    <xsl:apply-templates select="collecting_bank">
     <xsl:with-param name="prefix" select="'collecting_bank'"/>
     <xsl:with-param name="required">N</xsl:with-param>
     <xsl:with-param name="theNodeName" select="'collecting_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
  </xsl:call-template> 
 </xsl:template>
 
 <!-- Description of Goods -->
  <xsl:template name="description-goods">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="id">narrative_description_goods</xsl:with-param>
      <xsl:with-param name="label">XSL_LABEL_DESCRIPTION_GOODS</xsl:with-param>
	  <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
        <xsl:with-param name="rows">12</xsl:with-param>
        <xsl:with-param name="maxlines">100</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 <!--
  Presenting or collecting bank  
 -->
 <xsl:template match="presenting_bank | collecting_bank">
  <xsl:param name="prefix"/>
  <xsl:param name="required">N</xsl:param>
  <xsl:param name="theNodeName"/>

   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="value" select="name"/>
    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="override-product-code"><xsl:value-of select="product-code"/></xsl:with-param>
    <xsl:with-param name="required" select="$required"/>
   </xsl:call-template>
   
   <!-- Address Lines -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
    <xsl:with-param name="value" select="address_line_1"/>
    <xsl:with-param name="required" select="$required"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
    <xsl:with-param name="value" select="address_line_2"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
    <xsl:with-param name="value" select="dom"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
    <xsl:with-param name="value" select="address_line_4"/>
   </xsl:call-template>
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
     <xsl:with-param name="value" select="reference"></xsl:with-param>
    </xsl:call-template>
    
    <xsl:if test="$theNodeName = 'presenting_bank'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_DETAILS_CONTACT_PERSON_DETAILS</xsl:with-param>
	     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_contact_name</xsl:with-param>
	     <xsl:with-param name="value" select="contact_name" />
	     <xsl:with-param name="size">35</xsl:with-param>
	     <xsl:with-param name="maxsize">35</xsl:with-param>
	     <xsl:with-param name="disabled">Y</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_PHONE_NUMBER</xsl:with-param>
	     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_phone</xsl:with-param>
	     <xsl:with-param name="value" select="phone" />
	     <xsl:with-param name="size">32</xsl:with-param>
	     <xsl:with-param name="maxsize">32</xsl:with-param>
	     <xsl:with-param name="disabled">Y</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
	     <xsl:with-param name="value" select="iso_code"/>
	    </xsl:call-template>    
   </xsl:if>
   
   </div>
 </xsl:template>
 
 <xsl:template name="remitting_bank">
   <xsl:param name="prefix"/>
   <xsl:variable name="remitting-bank-name-value">
     <xsl:value-of select="//*[name()=$prefix]/name"/>
   </xsl:variable>
   
   <xsl:variable name="appl_ref">
	  <xsl:value-of select="drawer_reference"/>
   </xsl:variable>
   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="value" select="$remitting-bank-name-value"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
  
   <xsl:call-template name="input-field">
  	   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
  	   <xsl:with-param name="value">
  	   	<xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
  	   </xsl:with-param>
  <xsl:with-param name="readonly">Y</xsl:with-param>
  </xsl:call-template>
  
 </xsl:template>
</xsl:stylesheet>
