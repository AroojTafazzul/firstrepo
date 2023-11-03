<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to SE forms on the customer side. This
stylesheet should be the first thing imported by customer-side
XSLTs if needed.

This should be the first include for forms on the customer side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      05/12/11
author:    Raja Rao

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization securitycheck utils">
	
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields-se">
	<xsl:call-template name="common-hidden-fields">
	    <xsl:with-param name="show-cust_ref_id">N</xsl:with-param>
		<xsl:with-param name="additional-fields">					
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">issuing_bank_iso_code</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/iso_code"/></xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_name</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_dom</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_reference</xsl:with-param>
		    </xsl:call-template>
		     <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicant_act_nickname</xsl:with-param>
				<xsl:with-param name="value" select="applicant_act_nickname"/>
			</xsl:call-template> 	    	    	     	   
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>  
   
  

</xsl:stylesheet>

 