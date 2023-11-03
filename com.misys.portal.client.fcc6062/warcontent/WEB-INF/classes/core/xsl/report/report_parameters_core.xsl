<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:business_codes="xalan://com.misys.portal.common.resources.BusinessCodesResourceProvider"
		exclude-result-prefixes="localization securityCheck security converttools business_codes">

<!--
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
    <xsl:param name="nextscreen"/>
    <xsl:param name="option"/>
    <xsl:param name="operation"/>
    <xsl:param name="token"/>
    <xsl:param name="displaymode">edit</xsl:param>
 	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
    <xsl:param name="main-form-name">fakeform1</xsl:param>
    
	<!-- Global Imports. -->
    <xsl:include href="../common/system_common.xsl" />
    <xsl:include href="../common/file_upload_templates.xsl" />
    <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
	<xsl:template match="/">
		<xsl:apply-templates select="report_parameters_record"/>
	</xsl:template>
	
	<!--TEMPLATE Main-->
	<xsl:template match="report_parameters_record">
			<!-- Preloader -->
		   <xsl:call-template name="loading-message"/>
		   
		    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		
		    <!-- Form #0 : Main Form -->
		    <xsl:call-template name="form-wrapper">
			    <xsl:with-param name="name" select="$main-form-name"/>
			    <xsl:with-param name="validating">Y</xsl:with-param>
			    <xsl:with-param name="content">
				    <xsl:call-template name="disclaimer"/>		
					<xsl:call-template name="hidden-fields"/>
		     		<xsl:call-template name="general-details" />
		     		<xsl:call-template name="realform"/>
		     		<xsl:call-template name="js-imports"/>
		     		<xsl:call-template name="system-menu"/>
	     		</xsl:with-param>
     		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_PARAMETERS_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	    <xsl:if test="data_1!=''">
			<div class="field">
				<label style="float:left">
				 <xsl:if test="$rundata!='' ">
					<xsl:call-template name="localization-dblclick">
						<xsl:with-param name="xslName">XSL_ACTUAL_LOGO</xsl:with-param>
						<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_ACTUAL_LOGO')" />
					</xsl:call-template>
					</xsl:if>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTUAL_LOGO')"/>
				</label>
				<img>
					<xsl:attribute name="id">image</xsl:attribute>
					<xsl:attribute name="src"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetCustomerLogo?logoid=<xsl:value-of select="data_1"/></xsl:attribute>
				</img>
	        </div>
     	</xsl:if>
        <div style="margin-left: 5%">
        	<xsl:value-of select="localization:getGTPString($language, 'XSL_PARAMETER_LOGO_DESCRIPTION')"/>
        </div>
		<xsl:call-template name="upload-logo">
			<xsl:with-param name="name">new</xsl:with-param>
			<xsl:with-param name="button-label">XSL_SET_NEW_LOGO_BTN</xsl:with-param>
		</xsl:call-template>
        <xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARAMETER_HEADER_LOGO</xsl:with-param>
			<xsl:with-param name="name">data_4</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">data_5</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">data_6</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARAMETER_FOOTER</xsl:with-param>
			<xsl:with-param name="name">data_3</xsl:with-param>
			 <xsl:with-param name="size">65</xsl:with-param>   
			  <xsl:with-param name="maxsize">65</xsl:with-param>  
		</xsl:call-template>
		
		</xsl:with-param>
		</xsl:call-template>
		
		
	
	</xsl:template>
	
	
	<xsl:template name="hidden-fields">
	 <div class="widgetContainer">
		<xsl:call-template name="localization-dialog"/>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">brch_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">parm_id</xsl:with-param>
		</xsl:call-template> 
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">company_id</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">data_1</xsl:with-param>
		</xsl:call-template>
	 </div>
	</xsl:template>

	<!-- Report Realform. -->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="action">
				<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/>
			</xsl:with-param>
			<xsl:with-param name="content">
				<div class="widgetContainer">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">operation</xsl:with-param>
					<xsl:with-param name="id">realform_operation</xsl:with-param>
					<xsl:with-param name="value">SAVE</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">TransactionData</xsl:with-param>
					<xsl:with-param name="value"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
			       	<xsl:with-param name="name">token</xsl:with-param>
			       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
			    </xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">attachment_id</xsl:with-param>
					<xsl:with-param name="value"/>
				</xsl:call-template>
				<xsl:call-template name="e2ee_transaction"/>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Additional JS imports for this form are -->
	 <!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="system-common-js-imports">
			<xsl:with-param name="binding">misys.binding.report_parameters</xsl:with-param>
			<xsl:with-param name="xml-tag-name">parameters_data</xsl:with-param>
			<xsl:with-param name="override-help-access-key">
			 	<xsl:choose>
	   				<xsl:when test="security:isBank($rundata)">SY_PRA_BNK</xsl:when>
	   				<xsl:when test="security:isCustomer($rundata)">SY_PRA_C</xsl:when>
	   			</xsl:choose>
	  		</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
