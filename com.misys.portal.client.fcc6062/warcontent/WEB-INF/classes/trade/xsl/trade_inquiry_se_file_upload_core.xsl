<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Secure Email (SE) Form, Customer Side.
 
Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      03/12/10
author:    Saïd SAI
email:     said.sai0@misys.com
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/SecureEmailScreen</xsl:param>
  <xsl:param name="thecase">
  	<xsl:choose>
  		<xsl:when test="//se_type!=''">
  			<xsl:choose>
  				<xsl:when test="//se_type='02'">SE_DEPOSIT</xsl:when>
  				<xsl:when test="//se_type='06'">SE_CHEQUE</xsl:when>
  				<xsl:when test="//se_type='07'">SE_FILE_UPLOAD</xsl:when>
  				<xsl:otherwise>SE_CORRESPONDENCE</xsl:otherwise>
  			</xsl:choose>
  		</xsl:when>
  		<xsl:when test="$option!=''"><xsl:value-of select="$option"/></xsl:when>
  		<xsl:otherwise>SE_CORRESPONDENCE</xsl:otherwise>
  	</xsl:choose>
  </xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
  
    
    <xsl:variable name="setype">
        <xsl:choose>
            <xsl:when test="$thecase='SE_CHEQUE'">06</xsl:when>
            <xsl:when test="$thecase='SE_DEPOSIT'">02</xsl:when>
            <xsl:when test="$thecase='SE_FILE_UPLOAD'">07</xsl:when>
            <xsl:otherwise><xsl:value-of select="se_type"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
   
 
  <!-- Global Imports. -->
  
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="se_tnx_record"/>
  </xsl:template>
  
  
  
  
  <!-- 
   SE TNX FORM TEMPLATE.
   
  -->
  <xsl:template match="se_tnx_record"> 
   <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
   
   
   <div>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
     
      <xsl:call-template name="menu">
      <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-reject">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      
      <xsl:choose>
      	
      	<xsl:when test="$thecase='SE_FILE_UPLOAD'">
      		<xsl:call-template name="general-details" />
      	</xsl:when>
      	<xsl:otherwise>
			<xsl:call-template name="general-details" />
      	</xsl:otherwise>
      </xsl:choose>
      
     </xsl:with-param>
    </xsl:call-template>
      
    <xsl:choose>
 		<xsl:when test="$thecase='SE_FILE_UPLOAD'">
 			<!-- Attach Files -->
    		<xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
		    	<xsl:call-template name="attachments-file-dojo"/>
		    </xsl:if>
      	</xsl:when>
	</xsl:choose>
    

    <!-- The form that is submitted -->
    <xsl:call-template name="realform"/>

    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-template">N</xsl:with-param>
      <xsl:with-param name="show-reject">Y</xsl:with-param>
    </xsl:call-template>
   </div>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>


 
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">
	    <xsl:choose>
	 		<xsl:when test="$thecase='SE_FILE_UPLOAD'">misys.binding.BankReportingSeBinding</xsl:when>
		</xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">brch_code</xsl:with-param>
     <xsl:with-param name="value" select="brch_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_id</xsl:with-param>
     <xsl:with-param name="value" select="company_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_name</xsl:with-param>
     <xsl:with-param name="value" select="company_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_id</xsl:with-param>
     <xsl:with-param name="value" select="tnx_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
     <xsl:with-param name="value" select="//ctl_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
     <xsl:with-param name="value" select="inp_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">prod_stat_code</xsl:with-param>
     <xsl:with-param name="value" select="prod_stat_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">date_time</xsl:with-param>
   </xsl:call-template>
   </div>
  </xsl:template>
 
  <!--
   General Details Fieldset. 
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="se-general-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
  
  <xsl:template name="se-general-details">
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <!-- Don't display this in unsigned mode. -->
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </div>
   
   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <!--  Application date. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
    <xsl:with-param name="id">appl_date_view</xsl:with-param>
    <xsl:with-param name="value" select="appl_date" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <xsl:if test="prod_stat_code[.='03']">
   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	    <xsl:with-param name="id">prod_status_view</xsl:with-param>
	    <xsl:with-param name="value" select="localization:getGTPString($language, 'FEATURES_ACTION_APPROVED')" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   </xsl:if>
   
   <xsl:if test="prod_stat_code[.='01']">
   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	    <xsl:with-param name="id">prod_status_view</xsl:with-param>
	    <xsl:with-param name="value" select="localization:getGTPString($language, 'FEATURES_ACTION_REVERTED')" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   </xsl:if>
   
       
   <xsl:if test="bo_ref_id[.!='']">
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
		    <xsl:with-param name="id">bo_ref_id_view</xsl:with-param>
		    <xsl:with-param name="value" select="bo_ref_id" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   
   <xsl:if test="bo_comment[.!='']">
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT</xsl:with-param>
		    <xsl:with-param name="id">bo_comment_view</xsl:with-param>
		    <xsl:with-param name="value" select="bo_comment" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
  </xsl:if>
   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
    <xsl:with-param name="id">general_entity_view</xsl:with-param>
    <xsl:with-param name="value" select="entity" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   


   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
    <xsl:with-param name="value" select="issuing_bank_name" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   

   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
    <xsl:with-param name="id">issuing_bank_abbv_name_view</xsl:with-param>
    <xsl:with-param name="value" select="issuing_bank_abbv_name" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   

   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">UPLOAD_FILE_TYPE</xsl:with-param>
    <xsl:with-param name="id">upload_file_type_view</xsl:with-param>
    <xsl:with-param name="value" select="upload_file_type" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
  </xsl:template>
  
  <xsl:template name="instruction-types">
  	  <xsl:choose>
	  	<xsl:when test="$displaymode='edit'">
	  		<option value="01">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '01')"/>
		    </option>
		    <option value="03">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '03')"/>
		     </option>
		     <option value="04">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '04')"/>
		     </option>
		     <option value="05">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '05')"/>
		     </option>
		     <option value="07">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '07')"/>
		     </option>
		     
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<option>
	  		  <xsl:attribute name="value"><xsl:value-of select="//se_type"/> </xsl:attribute>
		      <xsl:value-of select="localization:getDecode($language, 'N430', //se_type)"/>
		    </option>
	  	</xsl:otherwise>
	  </xsl:choose>

  </xsl:template>

  
  <!--
   LC Realform.
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
   <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="name">realform</xsl:with-param>
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
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">mode</xsl:with-param>
       <xsl:with-param name="value" select="$mode"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">SE_GENERIC_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">fileHashCode</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      

     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
</xsl:stylesheet>