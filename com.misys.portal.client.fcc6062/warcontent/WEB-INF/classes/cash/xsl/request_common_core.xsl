<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common for request pattern 

Use this file in association of next js files :
- create your binding file with misys.binding.cash.TradeCreateTemplateBinding.js
- misys.binding.cash.request.RequestAction.js
- misys.binding.cash.request.Timer.js
- create your AjaxCall file with misys.binding.cash.request.TemplateAjaxCall.js

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/27/10
author:    Pillon Gauthier
email:     Pillon.Gauthier@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  exclude-result-prefixes="localization">
 
<!-- 
Button Submit
 --> 
<xsl:template name="submit-button">
	<div id="submit-button" style="display:none" class="widgetContainer">
	<xsl:call-template name="row-wrapper">
		<xsl:with-param name="content">
			<xsl:call-template name="button-wrapper">
				<xsl:with-param name="id">cash_submit_button</xsl:with-param>
				<xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
				<xsl:with-param name="onclick">misys.submit('SUBMIT');return false;</xsl:with-param>
				<xsl:with-param name="show-text-label">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	</div>
</xsl:template>

<!-- 
Button Request and Clear
 -->   
<xsl:template name="request-button">
<xsl:param name="display">Y</xsl:param>

	<div id="request-button" class="widgetContainer">
	<xsl:if test="$display='N'">
		<xsl:attribute name="style">display:none</xsl:attribute>
	</xsl:if>
  	<xsl:if test="$displaymode='edit'">
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
				<xsl:call-template name="button-wrapper">
					<xsl:with-param name="id">request_button</xsl:with-param>
					<xsl:with-param name="label">XSL_ACTION_REQUEST</xsl:with-param>
					<xsl:with-param name="onclick">misys.fncPerformRequest();return false;</xsl:with-param>
					<xsl:with-param name="show-text-label">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="button-wrapper">
					<xsl:with-param name="id">request_clear_button</xsl:with-param>
					<xsl:with-param name="label">XSL_ACTION_CLEAR</xsl:with-param>
					<xsl:with-param name="onclick">misys.fncPerformClearWithDialog();</xsl:with-param>
					<xsl:with-param name="show-text-label">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
  </div>		    
</xsl:template>
 
<!-- 
Button Accept and Reject
 -->   
<xsl:template name="accept-button">
  	<xsl:call-template name="row-wrapper">
		<xsl:with-param name="content">
	       <xsl:call-template name="button-wrapper">
	       		<xsl:with-param name="id">buttonAcceptRequest</xsl:with-param>
		       <xsl:with-param name="label">XSL_ACTION_ACCEPT</xsl:with-param>
		       <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="button-wrapper">
		       <xsl:with-param name="label">XSL_ACTION_REJECT</xsl:with-param>
		       <xsl:with-param name="id">buttonCancelRequest</xsl:with-param>
		       <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
       </xsl:with-param>
    </xsl:call-template>
  </xsl:template> 
  
<!-- dialog displayed during ajax call -->
<xsl:template name="loading-Dialog">
 <div class="widgetContainer">
	<xsl:call-template name="dialog">
		<xsl:with-param name="id">loadingDialog</xsl:with-param>
    	<xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_LOADING_DIALOG_TITLE')" /></xsl:with-param>
    	<xsl:with-param name="content">
    		<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_LOADING_DISCLAIMER')" />
    	</xsl:with-param>
	</xsl:call-template>
 </div>
</xsl:template>

<xsl:template name="trade-details">
 <xsl:param name="content"/>
   
 <xsl:if test="$content != ''">
  	<div id="trade-details">
  	<xsl:if test="$displaymode='edit'">
			<xsl:attribute name="style">display:none</xsl:attribute>
		</xsl:if>
  	<xsl:call-template name="fieldset-wrapper">
  	<xsl:with-param name="parseWidgets">N</xsl:with-param>
	<xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
	<xsl:with-param name="content"> 	
  		<xsl:copy-of select="$content"/>
		<xsl:if test="$displaymode='edit'">
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="content">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_RATES_DISCLAIMER')"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="content">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_RATE_VALIDITY_DISCLAIMER_PREFIX')"/>
					<span id="validitySpan"></span>
				</xsl:with-param>
			</xsl:call-template>
			<div id="progressBarCash" class="field">
				<label for="customerReference_details_nosend">&nbsp;</label>
				<div dojoType="dijit.ProgressBar" style="width:300px" jsId="jsProgress" id="countdownProgress" maximum="10"></div>
			</div>
			<xsl:call-template name="accept-button"/>
		</xsl:if>
	</xsl:with-param>
	</xsl:call-template>
	</div>
 </xsl:if>
</xsl:template>

<xsl:template name="waiting-Dialog">
 <div class="widgetContainer">
	<xsl:call-template name="dialog">
		<xsl:with-param name="id">delayDialog</xsl:with-param>
	    <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DELAY_DIALOG_TITLE')" /></xsl:with-param>
	    <xsl:with-param name="content">
	    	<div id="waitingMessage">
	    		<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DELAY_DISCLAIMER')" />
	    	</div>
	    	<div id="continueMessage">
	    		<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DELAY_CONTINUE_DISCLAIMER')" />
	    	</div>
	    	<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">quote_id</xsl:with-param>
			</xsl:call-template>   
	    </xsl:with-param>
		<xsl:with-param name="buttons">
		   	<xsl:call-template name="row-wrapper">
				<xsl:with-param name="content">
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="id">continueDelayId</xsl:with-param>
						<xsl:with-param name="label">XSL_ACTION_CONTINUE</xsl:with-param>
						<xsl:with-param name="onclick">misys.fncContinueDelayDialog();</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="id">cancelDelayId</xsl:with-param>
						<xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
						<xsl:with-param name="onclick">misys.fncCancelDelayRequest();</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	    </xsl:with-param>
	</xsl:call-template>
 	</div>
  </xsl:template>
   
</xsl:stylesheet>
