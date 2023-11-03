<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Batch Transactions Information Screen

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      18/04/2012
author:    Gurudath Reddy
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        exclude-result-prefixes="xmlRender localization securitycheck utils security">
 
 <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
 <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">BT</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/MessageCenterScreen</xsl:param>
  <xsl:param name="e2ee_pubkey"/>
  <xsl:param name="e2ee_server_random"/>
  <xsl:param name="e2ee_pki"/>
  
  
  <xsl:include href="trade_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="generate_esign_request"/>
	<xsl:apply-templates select="proxy_authorise"/>
  </xsl:template>
  
  <xsl:template match="generate_esign_request">
  	<!-- Preloader  -->
	<xsl:call-template name="loading-message"/>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name" select="$main-form-name"/>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content" >
				 <xsl:call-template name="fieldset-wrapper">
				      <xsl:with-param name="legend">XSL_HEADER_DETAILS</xsl:with-param>
				      <xsl:with-param name="content">
						<div class="remoteAuthContainer">
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCHID')"/>:</span>
								<div class="content"><xsl:value-of select="batch_id"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_DATE')"/>:</span>
								<div class="content"><xsl:value-of select="batch_dttm"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_TNX_COUNT')"/>:</span>
								<div class="content"><xsl:value-of select="batch_total_tnx"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_AMOUNT')"/>:</span>
								<div class="content"><xsl:value-of select="batch_cur_code"/>&nbsp;<xsl:value-of select="batch_amt_new"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_ESIGN_FIELD_1')"/>:</span>
								<div class="content">
									<xsl:choose>
										<xsl:when test="esign_field_1[.!='']"><xsl:value-of select="esign_field_1"/></xsl:when>
										<xsl:otherwise>-</xsl:otherwise>
									</xsl:choose>
								</div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_ESIGN_FIELD_2')"/>:</span>
								<div class="content">
									<xsl:choose>
										<xsl:when test="esign_field_2[.!='']"><xsl:value-of select="esign_field_2"/></xsl:when>
										<xsl:otherwise>-</xsl:otherwise>
									</xsl:choose>
								</div>
							</div>  
							<xsl:call-template name="input-field">
								 <xsl:with-param name="label">XSL_AUTHORISER</xsl:with-param>
								 <xsl:with-param name="name">authoriser_name</xsl:with-param>		
								 <xsl:with-param name="maxsize">70</xsl:with-param>
								 <xsl:with-param name="readonly">Y</xsl:with-param>	
								 <xsl:with-param name="required">Y</xsl:with-param>	
								 <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>		
							</xsl:call-template>
							<xsl:call-template name="button-wrapper">
						      <xsl:with-param name="label">XSL_ALT_USERS</xsl:with-param>
						      <xsl:with-param name="show-image">Y</xsl:with-param>
						      <xsl:with-param name="show-border">N</xsl:with-param>
						      <xsl:with-param name="onclick">misys.showSearchDialog('company_user', "['mobile_phone','email','authoriser_id','authoriser_name']", {companyId: <xsl:value-of select="company_id"/>, entity: '<xsl:value-of select="entity_abbv_name"/>'}, '', '', '', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_USERS_LIST')"/>');return false;</xsl:with-param>
						      <xsl:with-param name="id">users_img</xsl:with-param>
						     </xsl:call-template>
							<xsl:call-template name="multioption-inline-wrapper">
							      <xsl:with-param name="group-label"></xsl:with-param>
							      <xsl:with-param name="content">
								        <xsl:call-template name="multichoice-field">
										      <xsl:with-param name="group-label"></xsl:with-param>
										      <xsl:with-param name="label">XSL_SMS</xsl:with-param>
										      <xsl:with-param name="name">esign_request_mode</xsl:with-param>
										      <xsl:with-param name="id">esign_request_mode_sms</xsl:with-param>
										      <xsl:with-param name="type">radiobutton</xsl:with-param>
										      <xsl:with-param name="disabled">Y</xsl:with-param>
										      <xsl:with-param name="inline">Y</xsl:with-param>
									     </xsl:call-template>
									     <xsl:call-template name="multichoice-field">
										      <xsl:with-param name="group-label"></xsl:with-param>
										      <xsl:with-param name="label">XSL_EMAIL</xsl:with-param>
										      <xsl:with-param name="name">esign_request_mode</xsl:with-param>
										      <xsl:with-param name="id">esign_request_mode_email</xsl:with-param>
										      <xsl:with-param name="type">radiobutton</xsl:with-param>
										      <xsl:with-param name="disabled">Y</xsl:with-param>
										      <xsl:with-param name="inline">Y</xsl:with-param>
									     </xsl:call-template>
							    	</xsl:with-param>
						    </xsl:call-template>
						    <div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_MOBILE_PHONE')"/></span>
								<div class="content" id="mobile_phone_display">-</div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_EMAIL')"/>:</span>
								<div class="content" id="email_display">-</div>
							</div>
						</div>
				  		<div style="text-align:right;" class="widgetContainer">
					  		<div dojoType="dijit.form.Button" id="sendEsignRequest">
					  			<!--<xsl:attribute name="disabled">true</xsl:attribute>-->
					  			<xsl:attribute name="onClick">misys.sendEsignRequest('OPERATION_SEND_ESIGN_REQUEST')</xsl:attribute>
					  			<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_ESIGN_SEND_REQUEST')"/>
					  		</div>
					  		<xsl:call-template name="button-wrapper">
						        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
						        <xsl:with-param name="id">cancelButton1</xsl:with-param>
						        <xsl:with-param name="class">cancelButton</xsl:with-param>
						        <xsl:with-param name="show-text-label">Y</xsl:with-param>
						    </xsl:call-template>
						    <xsl:call-template name="button-wrapper">
						        <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
						        <xsl:with-param name="id">helpButton</xsl:with-param>
						        <xsl:with-param name="class">helpButton</xsl:with-param>
						        <xsl:with-param name="show-text-label">Y</xsl:with-param>
						    </xsl:call-template>
				  		</div>
				  	</xsl:with-param>
				  </xsl:call-template>
		  	</xsl:with-param>
	  	</xsl:call-template>
	  	
	  	<xsl:call-template name="realform"/>
	</div>
	<xsl:call-template name="js-imports"/> 
  </xsl:template>
  
  <xsl:template match="proxy_authorise">
    <!-- Preloader  -->
	<xsl:call-template name="loading-message"/>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name" select="$main-form-name"/>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
				      <xsl:with-param name="legend">XSL_HEADER_DETAILS</xsl:with-param>
				      <xsl:with-param name="content">
						<div class="remoteAuthContainer">
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCHID')"/>:</span>
								<div class="content"><xsl:value-of select="batch_id"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_DATE')"/>:</span>
								<div class="content"><xsl:value-of select="batch_dttm"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_TNX_COUNT')"/>:</span>
								<div class="content"><xsl:value-of select="batch_total_tnx"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_AMOUNT')"/>:</span>
								<div class="content"><xsl:value-of select="batch_cur_code"/>&nbsp;<xsl:value-of select="batch_amt_new"/></div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_ESIGN_FIELD_1')"/>:</span>
								<div class="content">
									<xsl:choose>
										<xsl:when test="esign_field_1[.!='']"><xsl:value-of select="esign_field_1"/></xsl:when>
										<xsl:otherwise>-</xsl:otherwise>
									</xsl:choose>
								</div>
							</div>
							<div class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_ESIGN_FIELD_2')"/>:</span>
								<div class="content">
									<xsl:choose>
										<xsl:when test="esign_field_2[.!='']"><xsl:value-of select="esign_field_2"/></xsl:when>
										<xsl:otherwise>-</xsl:otherwise>
									</xsl:choose>
								</div>
							</div>
							<xsl:call-template name="select-field">
					      		<xsl:with-param name="label">XSL_AUTHORISER</xsl:with-param>
							    <xsl:with-param name="name">authoriser</xsl:with-param>
							    <xsl:with-param name="fieldsize">medium</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="options">
									 <xsl:if test="authoriser_id_1">
									 	<option>
										 	<xsl:attribute name="value"><xsl:value-of select="authoriser_id_1"/></xsl:attribute>
									      	<xsl:value-of select="authoriser_name_1"/>
									     </option>
									 </xsl:if>
									 <xsl:if test="authoriser_id_2">
									 	<option>
										 	<xsl:attribute name="value"><xsl:value-of select="authoriser_id_2"/></xsl:attribute>
									      	<xsl:value-of select="authoriser_name_2"/>
									     </option>
									 </xsl:if>
									 <xsl:if test="authoriser_id_3">
									 	<option>
										 	<xsl:attribute name="value"><xsl:value-of select="authoriser_id_3"/></xsl:attribute>
									      	<xsl:value-of select="authoriser_name_3"/>
									     </option>
									 </xsl:if>
									 <xsl:if test="authoriser_id_4">
									 	<option>
										 	<xsl:attribute name="value"><xsl:value-of select="authoriser_id_4"/></xsl:attribute>
									      	<xsl:value-of select="authoriser_name_4"/>
									     </option>
									 </xsl:if>
									 <xsl:if test="authoriser_id_5">
									 	<option>
										 	<xsl:attribute name="value"><xsl:value-of select="authoriser_id_5"/></xsl:attribute>
									      	<xsl:value-of select="authoriser_name_5"/>
									     </option>
									 </xsl:if>						      
							    </xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								 <xsl:with-param name="label">XSL_OTP_RESPONSE</xsl:with-param>
								 <xsl:with-param name="name">remote_auth_otp_response</xsl:with-param>		
								 <xsl:with-param name="maxsize">8</xsl:with-param>
								 <xsl:with-param name="fieldsize">small</xsl:with-param>
								 <xsl:with-param name="required">Y</xsl:with-param>			
							</xsl:call-template>  
				  		</div>
				  		<div style="text-align:right;" class="widgetContainer">
					  		<div dojoType="dijit.form.Button">
					  			<xsl:attribute name="onClick">misys.submitProxyAuthorise('<xsl:value-of select="batch_id"/>','OPERATION_SUBMIT_PROXY_AUTHORISE');</xsl:attribute>
					  			<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_PROXY_AUTHORISE')"/>
					  		</div>
					  		<xsl:call-template name="button-wrapper">
						        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
						       <xsl:with-param name="id">cancelButton1</xsl:with-param>
						        <xsl:with-param name="class">cancelButton</xsl:with-param>
						        <xsl:with-param name="show-text-label">Y</xsl:with-param>
						    </xsl:call-template>
						    <xsl:call-template name="button-wrapper">
						        <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
						        <xsl:with-param name="id">helpButton</xsl:with-param>
						        <xsl:with-param name="class">helpButton</xsl:with-param>
						        <xsl:with-param name="show-text-label">Y</xsl:with-param>
						    </xsl:call-template>
				  		</div>
				  	</xsl:with-param>
				  </xsl:call-template>
		  	</xsl:with-param>
	  	</xsl:call-template>
	  	
	  	<xsl:call-template name="realform"/>
	</div>
	<xsl:call-template name="js-imports"/> 
  </xsl:template>
  
  <xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.common.remote_authorisation</xsl:with-param>
		</xsl:call-template>
  </xsl:template>
  
  <!--
	Real form for Bulk
	-->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="method">POST</xsl:with-param>
			<xsl:with-param name="action" select="$realform-action"/>
			<xsl:with-param name="content">
				<div class="widgetContainer">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">featureid</xsl:with-param>
						<xsl:with-param name="value" select="batch_id"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">operation</xsl:with-param>
						<xsl:with-param name="id">realform_operation</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">TransactionData</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">mobile_phone</xsl:with-param>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">email</xsl:with-param>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">authoriser_id</xsl:with-param>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">request_mode</xsl:with-param>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">otp_response</xsl:with-param>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">e2ee_pubkey</xsl:with-param>
						 <xsl:with-param name="value" select="$e2ee_pubkey"/>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">e2ee_server_random</xsl:with-param>
						 <xsl:with-param name="value" select="$e2ee_server_random"/>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						 <xsl:with-param name="name">e2ee_pki</xsl:with-param>
						 <xsl:with-param name="value" select="$e2ee_pki"/>		
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">autoForward</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>