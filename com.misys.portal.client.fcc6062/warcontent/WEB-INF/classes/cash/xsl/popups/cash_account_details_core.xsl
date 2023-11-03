<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
##########################################################

Display account details in a popup.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      09/12/2012
author:    Mauricio Moura
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization defaultresource">
 
	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="displaymode">view</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param>
	 
	<!-- Global Imports. -->
	<xsl:include href="../../../core/xsl/common/system_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="static_account"/>
	</xsl:template>
  
	<xsl:template match="static_account">
		<div id="popupscreen">
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="account-details"/>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="content">
					<xsl:call-template name="bank-details"/>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS_ACCOUNT_TYPE_<xsl:value-of select="account_type"/></xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="extended-account-details"/>
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
	<xsl:template name="account-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
	
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_NO</xsl:with-param>
					<xsl:with-param name="name">account_no</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACTIVE_FLAG_LABEL</xsl:with-param>
					<xsl:with-param name="actv_flag">actv_flag</xsl:with-param>
					<xsl:with-param name="value">
                       <xsl:if test="actv_flag[.='Y' or .='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:if>
                       <xsl:if test="not(actv_flag[.='Y' or .=''])"><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_AB_ACCOUNT_TYPE</xsl:with-param>
					<xsl:with-param name="name">account_type</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N068', account_type)"/></xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_DESCRIPTION</xsl:with-param>
					<xsl:with-param name="name">description</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BANK_CODE</xsl:with-param>
					<xsl:with-param name="name">bank_id</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BRANCH_NO</xsl:with-param>
					<xsl:with-param name="name">branch_no</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
					<xsl:with-param name="name">cur_code</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_MAX_TRANSFER_LIMIT</xsl:with-param>
					<xsl:with-param name="name">limit_amount</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ALTERNATE_ACCOUNT_NO</xsl:with-param>
					<xsl:with-param name="name">alternate_account_no1</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="(account_type[.='04']) or (account_type[.='05'])">
                    <xsl:call-template name="input-field">
		      			 <xsl:with-param name="label">XSL_BANK_CUST_NUMBER</xsl:with-param>
		      			 <xsl:with-param name="id">bo_cust_numb</xsl:with-param>
		      			 <xsl:with-param name="value"><xsl:value-of select="bo_cust_number"/></xsl:with-param>
		      			<xsl:with-param name="override-displaymode">view</xsl:with-param> 
	      			 </xsl:call-template>
	      		</xsl:if>
				

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--
	Extended details of the account
	-->
	<xsl:template name="extended-account-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
				<xsl:if test="overdraft_limit[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_OVERDRAFT_LIMIT</xsl:with-param>
						<xsl:with-param name="name">overdraft_limit</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="overdraft_limit"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="principal_amount[.!='']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_PRINCIPLE_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">start_date</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="principal_amount"/></xsl:with-param>
						</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_START_DATE</xsl:with-param>
					<xsl:with-param name="name">start_date</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="end_date[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_END_DATE</xsl:with-param>
						<xsl:with-param name="name">end_date</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
							    <xsl:when test="end_date[.='01/01/3000']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_MATURITY_OPEN')"/>
								</xsl:when>
								<xsl:otherwise>
							    	<xsl:value-of select="end_date"/>
						    	</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="interest_on_maturity[.!=''] and defaultresource:getResource('TD_INTEREST_AMT_DISPLAY') = 'true'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_ON_MATURITY</xsl:with-param>
						<xsl:with-param name="name">interest_on_maturity</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="interest_on_maturity"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="maturity_amount[.!='']">
					<xsl:call-template name="hidden-field">
						<!-- <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_MATURITY_AMOUNT</xsl:with-param> -->
						<xsl:with-param name="name">maturity_amount</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="maturity_amount"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_RATE_CREDIT</xsl:with-param>
					<xsl:with-param name="name">interest_rate_credit</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="interest_rate_credit"/><xsl:if test="interest_rate_credit[.!='']">
					<xsl:text>%</xsl:text>
					</xsl:if></xsl:with-param>
					
				</xsl:call-template>
				<!-- TODO: Need to check if these fields are really required-->
				<!-- <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_FUNDING_ACCOUNT_NO</xsl:with-param>
					<xsl:with-param name="name">funding_account_no</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_MONTHLY_PAYMENT</xsl:with-param>
					<xsl:with-param name="name">monthly_payment</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_NEXT_PAYMENT_DATE</xsl:with-param>
					<xsl:with-param name="name">next_payment_date</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_REPAYMENT_DATE</xsl:with-param>
					<xsl:with-param name="name">repayment_date</xsl:with-param>
				</xsl:call-template> -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_RATE_DEBIT</xsl:with-param>
					<xsl:with-param name="name">interest_rate_debit</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="interest_rate_debit"/><xsl:if test="interest_rate_debit[.!='']">
					<xsl:text>%</xsl:text>
					</xsl:if></xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="bank-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_BANK_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_NAME</xsl:with-param>
      			<xsl:with-param name="id">bank_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_1</xsl:with-param>
      			<xsl:with-param name="id">bank_address_line_1_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_address_line_1"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_2</xsl:with-param>
       	  		<xsl:with-param name="id">bank_address_line_2_view</xsl:with-param>
       	  		<xsl:with-param name="value"><xsl:value-of select="bank_address_line_2"/></xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_BANK_DOM</xsl:with-param>
      			 <xsl:with-param name="id">bank_dom</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_dom"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
    </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>
	



</xsl:stylesheet>