<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
##########################################################

Display additional account details in a popup.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      03/04/2013
author:    veena jyothi 
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
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="displaymode">view</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param>
	 
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/system_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="account_statement_record"/>
	</xsl:template>
  
	<xsl:template match="account_statement_record">
		<div id="popupscreen">
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="additional-posting-details"/>
				</xsl:with-param>
			</xsl:call-template>			
		</div>

	</xsl:template>

	<!--                                     -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->

	<!--
	Main Details of the Account 
	-->
	<xsl:template name="additional-posting-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
	            <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_STATEMENT_ACCOUNT_NAME_LABEL</xsl:with-param>
					<xsl:with-param name="id">static_account_name_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="static_account/acct_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_STATEMENT_ACCOUNT_NUMBER_LABEL</xsl:with-param>
					<xsl:with-param name="id">static_account_no_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="static_account/account_no"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CUSTOMER_REFERENCE_LABEL</xsl:with-param>
					<xsl:with-param name="id">cust_ref_id_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/cust_ref_id"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BACK_OFFICE_REFERENCE_LABEL</xsl:with-param>
					<xsl:with-param name="id">bo_ref_id_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/bo_ref_id"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CHEQUE_NUMBER_LABEL</xsl:with-param>
					<xsl:with-param name="id">cheque_number_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/cheque_number"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="account_statement_line/runbal_cleared !=''">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BALANCE_LABEL</xsl:with-param>
					<xsl:with-param name="id">statement_cur_code_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/cur_code"/>&nbsp;<xsl:value-of select="account_statement_line/runbal_cleared"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_VALUE_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="id">value_date_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/value_date"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
      			</xsl:call-template>
      			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_Reference1_LABEL</xsl:with-param>
					<xsl:with-param name="id">act_stmt_reference_1_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/reference_1"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
      			</xsl:call-template>	
      			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_Reference2_LABEL</xsl:with-param>
					<xsl:with-param name="id">act_stmt_reference_2_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/reference_2"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
      			</xsl:call-template>	
      			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_Reference3_LABEL</xsl:with-param>
					<xsl:with-param name="id">act_stmt_reference_3_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/reference_3"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
      			</xsl:call-template>	
      			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_Reference4_LABEL</xsl:with-param>
					<xsl:with-param name="id">act_stmt_reference_4_view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/reference_4"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
      			</xsl:call-template>	
      			<!-- <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_Reference5</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="account_statement_line/reference_5"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
      			</xsl:call-template> -->					
				
				
				
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	

</xsl:stylesheet>