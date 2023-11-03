<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!--
##########################################################
Templates for

 Open Account - Credit Note (CN) Form, Customer Side.
 
Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      24/03/2014
author:    Prateek Kumar
email:     prateek.kumar@misys.com
##########################################################
	-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	exclude-result-prefixes="localization">
		
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">CN</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="nextscreen" />
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/CreditNoteScreen</xsl:param>
	<xsl:param name="show-template">Y</xsl:param>
	
	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../core/xsl/common/fscm_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

		
<!-- 	<xsl:param name="override-product-code">cn</xsl:param> -->


	<xsl:template match="cn_tnx_record">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message" />		
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
				<!--  Display common menu.  -->
				<xsl:choose>
					<xsl:when test="$mode = 'RESUBMIT' and tnx_type_code ='15'">
						<xsl:call-template name="menu">
							<!-- Set show-template to Y once template is implemented -->
							<xsl:with-param name="show-template">N</xsl:with-param>
							<xsl:with-param name="show-save">N</xsl:with-param>
   							<xsl:with-param name="show-reject">N</xsl:with-param>
							<xsl:with-param name="show-return">N</xsl:with-param>
							<xsl:with-param name="show-submit">N</xsl:with-param>
							<xsl:with-param name="show-resubmit">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="tnx_type_code and tnx_type_code[.='21']">
						<xsl:call-template name="menu">
							<!-- Set show-template to Y once template is implemented -->
							<xsl:with-param name="show-template">N</xsl:with-param>
							<xsl:with-param name="show-return">N</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="tnx_type_code and tnx_type_code[.!='05']">
						<xsl:call-template name="menu">
							<!-- Set show-template to Y once template is implemented -->
							<xsl:with-param name="show-template">Y</xsl:with-param>
							<xsl:with-param name="show-return">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />
					
					<!-- Reauthentication -->	
				 	<xsl:call-template name="server-message">
				 		<xsl:with-param name="name">server_message</xsl:with-param>
				 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
			 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="reauthentication" />

					<xsl:call-template name="hidden-fields"/>
						
					<xsl:call-template name="fscm-general-details" />
					
					<xsl:call-template name="fscm-bank-details" />
					
					<xsl:call-template name="credit-note-amount-details" >
						<xsl:with-param name="amount-product-code">cn</xsl:with-param>
					</xsl:call-template>
		
					<xsl:call-template name="invoice-items-declaration"/>
					
					<xsl:call-template name="credit_note_invoices"/>
					
					<xsl:call-template name="message-freeFormat"/>
					
					 <xsl:if test="tnx_type_code[.= '15']">
						<xsl:call-template name="message-boComment"/>
					</xsl:if>

					<!-- comments for return -->
					<xsl:if test="($mode!= 'ACCEPT' or $mode='RESUBMIT') and (tnx_type_code !='21') ">
				      <xsl:call-template name="comments-for-return">
					  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
					   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
				   	  </xsl:call-template>
			   	  </xsl:if>
					
					<!-- Form #1 : Attach Files -->
					<xsl:choose>
					<xsl:when test="($displaymode != 'edit' and $mode='ACCEPT')">
						<xsl:call-template name="attachments-file-dojo">
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or $mode = 'RESUBMIT'">
						<xsl:call-template name="attachments-file-dojo">
							<!-- <xsl:with-param name="attachment-group">credit_note</xsl:with-param> -->
						</xsl:call-template>
					</xsl:when>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>


	</div>

		<!-- Table of Contents -->
		<xsl:call-template name="toc" />

	<xsl:if test="$mode !='RESUBMIT'">
		<!--  Collaboration Window  -->
		<xsl:call-template name="collaboration">
			<xsl:with-param name="editable">true</xsl:with-param>
			<xsl:with-param name="productCode">
				<xsl:value-of select="$product-code" />
			</xsl:with-param>
			<xsl:with-param name="contextPath">
				<xsl:value-of select="$contextPath" />
			</xsl:with-param>
			<xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
		<!-- Display common menu, this time outside the form -->
		<xsl:choose>
			<xsl:when test="$mode ='RESUBMIT' and tnx_type_code ='15'">
				<xsl:call-template name="menu">
					<xsl:with-param name="second-menu">Y</xsl:with-param>
   					<xsl:with-param name="show-save">N</xsl:with-param>
   					<xsl:with-param name="show-reject">N</xsl:with-param>
					<xsl:with-param name="show-return">N</xsl:with-param>
					<xsl:with-param name="show-submit">N</xsl:with-param>
					<xsl:with-param name="show-resubmit">Y</xsl:with-param>							
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tnx_type_code and tnx_type_code[.='05'] and $mode!='UNSIGNED'">
				<xsl:call-template name="menu">
   					<xsl:with-param name="show-save">N</xsl:with-param>
					<xsl:with-param name="show-reject">Y</xsl:with-param>
					<xsl:with-param name="show-accept">N</xsl:with-param>							
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tnx_type_code and tnx_type_code[.='05'] and $mode ='UNSIGNED'">
				<xsl:call-template name="menu">
   					<xsl:with-param name="show-save">N</xsl:with-param>
   					<xsl:with-param name="show-reject">N</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
					<xsl:with-param name="show-accept">Y</xsl:with-param>							
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tnx_type_code and tnx_type_code[.='21']">
						<xsl:call-template name="menu">
							<!-- Set show-template to Y once template is implemented -->
							<xsl:with-param name="second-menu">Y</xsl:with-param>
							<xsl:with-param name="show-template">N</xsl:with-param>
							<xsl:with-param name="show-return">N</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="menu">
					<xsl:with-param name="second-menu">Y</xsl:with-param>
					<xsl:with-param name="show-template">Y</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>					
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
			
		<!-- The form that's submitted -->
		<xsl:call-template name="realform" />
		
		<!-- Javascript and Dojo imports  -->
		<xsl:call-template name="js-imports" />

	</xsl:template>

<!--                                     -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
			<xsl:if test="$displaymode='view'">
				<!-- This field is sent in the unsigned view -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="issuing_bank/abbv_name" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">program_id</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fscm_programme_code</xsl:with-param>				
			</xsl:call-template>
			  <xsl:call-template name="hidden-field">
		     	 <xsl:with-param name="name">company_type</xsl:with-param>
		     	 <xsl:with-param name="value"><xsl:value-of select="company_type"/></xsl:with-param>
		   	 </xsl:call-template>
		</div>
	</xsl:template>
	
  <!-- Reporting Message Section  -->
     
      <xsl:template name="message-boComment">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_REPORTING_DETAILS</xsl:with-param>
				<xsl:with-param name="content">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
	           			<xsl:with-param name="value" select="bo_comment"/>
			  		</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template> 
			 </xsl:template>
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_cn</xsl:with-param>
			<!-- <xsl:with-param name="show-period-js">Y</xsl:with-param>-->
			<xsl:with-param name="override-help-access-key">CN_01</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
	
		
	<xsl:template name="realform">
		<!--
			Do not display this section when the counterparty mode is
			'counterparty'
		-->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">realform</xsl:with-param>
				<xsl:with-param name="action" select="$realform-action" />
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
							<xsl:with-param name="value" select="$mode" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">tnxtype</xsl:with-param>
							<xsl:with-param name="value" select="tnx_type_code"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="e2ee_transaction"/>
						<xsl:call-template name="reauth_params"/>						
					</div>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>