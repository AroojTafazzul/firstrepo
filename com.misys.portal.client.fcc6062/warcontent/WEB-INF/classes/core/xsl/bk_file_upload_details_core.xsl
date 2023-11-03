<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for


 
Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      25/02/12
author:    Pavan Kumar
email:     pavankumar.c@misys.com
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
  <xsl:param name="displaymode">view</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SE</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BulkScreen</xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
  <!-- Global Imports. -->
  
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />   
  <xsl:include href="bk_file_upload_errors.xsl"/> 
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="bulk_upload_file_details"/>
  </xsl:template>
  
  <!-- 
   SE TNX FORM TEMPLATE.
   
  -->
  <xsl:template match="bulk_upload_file_details"> 
   <!-- Pre loader -->
   <xsl:call-template name="loading-message"/>
    <div class="widgetContainer">
   <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name" select="$main-form-name"/>
    <xsl:with-param name="validating">Y</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:apply-templates select="se_tnx_record"/>
			 <xsl:if test="count(error_log/errors/error) >=1">
				<xsl:call-template name="failed-records"/>
			 </xsl:if>
			 <xsl:if test="count(bo_comment/bkftrecords/bkftrecord) >=1">
				<xsl:call-template name="successful-records"/>
			 </xsl:if>
	   <xsl:call-template name="js-imports"/>
     </xsl:with-param>
     </xsl:call-template>
   </div>
  </xsl:template>
<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">	                                        
	    	<xsl:with-param name="binding">misys.binding.core.bk_error_file_upload</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>
   <!--  File Details Template -->
	<xsl:template match="se_tnx_record">
	<xsl:variable name="prodStadCode" select="prod_stat_code"/>
	<xsl:variable name="status">
	   <xsl:choose>
          <xsl:when test="prod_stat_code[.='01']">
             <xsl:value-of select="localization:getString($language, 'FILE_PROCESS_FAILED')"/>
          </xsl:when>	
           <xsl:when test="prod_stat_code[.='02']">
             <xsl:value-of select="localization:getString($language, 'FILE_PROCESS_PROGRESS')"/>
           </xsl:when>	
           <xsl:when test="prod_stat_code[.='25']">
             <xsl:value-of select="localization:getString($language, 'FILE_PROCESS_PARTIAL')"/>
           </xsl:when>	
           <xsl:when test="prod_stat_code[.='03']">
             <xsl:value-of select="localization:getString($language, 'FILE_PROCESS_SUCCESS')"/>
           </xsl:when>	
	   </xsl:choose>
	</xsl:variable>
    <xsl:call-template name="fieldset-wrapper">   		
	  <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
	  <xsl:with-param name="content"> 
	  <xsl:call-template name="column-container">
	  <xsl:with-param name="content">
	    <xsl:call-template name="column-wrapper">
		  <xsl:with-param name="content">	
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_REF_ID</xsl:with-param>	
				<xsl:with-param name="value" select="ref_id" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_UPLOADED_DATE_TIME</xsl:with-param>	
				<xsl:with-param name="value" select="inp_dttm" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_SIZE</xsl:with-param>	
				<xsl:with-param name="value" select="file_size" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_REFERENCE</xsl:with-param>	
				<xsl:with-param name="value" select="reference" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_NAME</xsl:with-param>	
				<xsl:with-param name="value" select="file_name" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_DESCRIPTION</xsl:with-param>	
				<xsl:with-param name="value" select="upload_description" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_BANK</xsl:with-param>	
				<xsl:with-param name="value" select="name" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_TYPE</xsl:with-param>	
				<xsl:with-param name="value" select="file_type" />
			</xsl:call-template>
				<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_FORMAT</xsl:with-param>	
				<xsl:with-param name="value" select="format_name" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_FORMAT_TYPE</xsl:with-param>	
				<xsl:with-param name="value" select="format_type" />
			</xsl:call-template>
			<xsl:choose>
			 	<xsl:when test="file_encrypted[.='N']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FILE_ENCRYPTED</xsl:with-param>	
						<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N034','N')"/></xsl:with-param>
			 	    </xsl:call-template>
			 	</xsl:when>
			 	<xsl:otherwise>
			 		<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FILE_ENCRYPTED</xsl:with-param>	
			 	   		<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N034','Y')"/></xsl:with-param>
			 	   	</xsl:call-template>
			 	</xsl:otherwise>
			 </xsl:choose>
			 
	  	  </xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="column-wrapper">
		  <xsl:with-param name="content">
		    <xsl:choose>
			   <xsl:when test="amendable[.='N']">
			 	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_AMENDABLE</xsl:with-param>	
			 	 <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N034','N')"/></xsl:with-param>
			    </xsl:call-template>
			   </xsl:when>
			 	<xsl:otherwise>
			 	  <xsl:call-template name="input-field">
				   <xsl:with-param name="label">XSL_FILE_AMENDABLE</xsl:with-param>	
			 	   <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N034','Y')"/></xsl:with-param>
			 	   </xsl:call-template>
			 	</xsl:otherwise>
			 </xsl:choose>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_PRODUCT_GROUP</xsl:with-param>	
				<xsl:with-param name="value" select="product_group" />
			</xsl:call-template>
			<xsl:if test="payroll_type[.!='**']">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_PAYROL_TYPE</xsl:with-param>	
				<xsl:with-param name="value" select="payroll_type" />
			</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_PRODUCT_TYPE</xsl:with-param>	
				<xsl:with-param name="value" select="product_type" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_ENTITY</xsl:with-param>	
				<xsl:with-param name="value" select="entity" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_ACCOUNT</xsl:with-param>	
				<xsl:with-param name="value" select="file_upload_act_no" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_VALUE_DATE</xsl:with-param>	
				<xsl:with-param name="value" select="value_date" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_STATUS</xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="$status"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_USER</xsl:with-param>	
				<xsl:with-param name="value" select="user" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_country</xsl:with-param>	
				<xsl:with-param name="value" select="user_country" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FILE_COMPANY</xsl:with-param>	
				<xsl:with-param name="value" select="company_name" />
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">
					<xsl:choose>
						<xsl:when test="tnx_id">XSL_FILE_NO_BULK_RESULTING</xsl:when>
						<xsl:otherwise>XSL_FILE_NO_BULK_PROCESSED</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>	
				<xsl:with-param name="value" select="upload_resulting_bulk" />
			</xsl:call-template>
			
		  </xsl:with-param>
	   </xsl:call-template>
	  </xsl:with-param>
	 </xsl:call-template>
	 </xsl:with-param>
	</xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>