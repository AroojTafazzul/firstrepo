<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all 

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/15/10
author:    Pascal Marzin
email:     Pascal.Marzin@misys.com
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

 <xsl:template name="xo-details">
 	<xsl:param name="id"/>
 	<xsl:param name="display">Y</xsl:param>
 	<div>
 		<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
 		<xsl:if test="$display='N'">
 			<xsl:attribute name="style">display:none</xsl:attribute>
 		</xsl:if>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="parseWidgets"><xsl:value-of select="$display"/></xsl:with-param>
		    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
		    <xsl:with-param name="content"> 
			   <xsl:call-template name="multioption-group">
			    <xsl:with-param name="group-label">XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL</xsl:with-param>
			    <xsl:with-param name="content">
			     <xsl:call-template name="radio-field">
			      <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL</xsl:with-param>
			      <xsl:with-param name="name">contract_type</xsl:with-param>
			      <xsl:with-param name="id">contract_type_1</xsl:with-param>
			      <xsl:with-param name="value">01</xsl:with-param>
			      <xsl:with-param name="checked"><xsl:if test="contract_type[. = '']">Y</xsl:if></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="radio-field">
			      <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL</xsl:with-param>
			      <xsl:with-param name="name">contract_type</xsl:with-param>
			      <xsl:with-param name="id">contract_type_2</xsl:with-param>
			      <xsl:with-param name="value">02</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="radio-field">
			      <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_CONTACT_LABEL</xsl:with-param>
			      <xsl:with-param name="name">contract_type</xsl:with-param>
			      <xsl:with-param name="id">contract_type_3</xsl:with-param>
			      <xsl:with-param name="value">03</xsl:with-param>
			     </xsl:call-template>
			    </xsl:with-param>
			   </xsl:call-template>
			   
			   <!-- change to combobox -->
			   <xsl:call-template name="select-field">
			     <xsl:with-param name="label">XSL_CONTRACT_XO_EXPIRATION_CODE_LABEL</xsl:with-param>
			     <xsl:with-param name="name">expiration_code</xsl:with-param>			     
			     <xsl:with-param name="required">Y</xsl:with-param>
			     <xsl:with-param name="options">
			       <xsl:choose>
    				  <xsl:when test="$displaymode='edit'">
				     	<xsl:call-template name="xo-options"/>
				      </xsl:when>
             		  <xsl:otherwise>
	             		  <xsl:if test="expiration_code != ''">
	                  		<xsl:value-of select="localization:getDecode($language, 'N412', expiration_code)"/>
	              		  </xsl:if>
             		  </xsl:otherwise>
             		</xsl:choose>  
			     </xsl:with-param>
			     
			   </xsl:call-template>
		      
		      <xsl:call-template name="input-date-term-field">
		        <xsl:with-param name="label">XSL_CONTRACT_XO_EXPIRATION_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">expiration_date</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>	      				
				<xsl:with-param name="term-options">
			     	<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
			     	<option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
			     	<option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
			     	<option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
			     </xsl:with-param>
			    
			    <xsl:with-param name="date">
					<xsl:choose>
						<xsl:when test="expiration_date[.!='']"><xsl:value-of select="expiration_date"/></xsl:when>
						<xsl:when test="expiration_date_term_number[.!='']"><xsl:value-of select="expiration_date_term_number"/></xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="code">
					<xsl:choose>
						<xsl:when test="expiration_date_term_code[.!='']"><xsl:value-of select="expiration_date_term_code"/></xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
		      </xsl:call-template> 
		       
			   <xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_CONTRACT_XO_EXPIRATION_TIME_LABEL</xsl:with-param>
				    <xsl:with-param name="name">expiration_time</xsl:with-param>
				    <xsl:with-param name="type">time</xsl:with-param>
				    <xsl:with-param name="fieldsize">x-medium</xsl:with-param>
				    <xsl:with-param name="value">
						<xsl:if test="expiration_time[.!='']">T<xsl:value-of select="substring-after(expiration_time, '1970 ')"/></xsl:if>
					</xsl:with-param>
			   </xsl:call-template>	
		       		       
			   <xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CURRENCY_LABEL</xsl:with-param>
				    <xsl:with-param name="product-code">counter</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="show-amt">N</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="counter_cur_code"/></xsl:with-param>
			   </xsl:call-template>	
			  			   
			   <xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
				    <xsl:with-param name="product-code">fx</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
     				<xsl:with-param name="override-amt-value"><xsl:value-of select="fx_amt"/></xsl:with-param>
			   </xsl:call-template>

			  <xsl:call-template name="input-date-term-field">
		        <xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">value</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="term-options">
			     	<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
			     	<option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
			     	<option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
			     	<option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
			     </xsl:with-param>
			     <xsl:with-param name="static-options">
			     	<option value="SPOT"><xsl:value-of select="localization:getDecode($language, 'N413', 'SPOT')"/></option>
			    </xsl:with-param>
			    <xsl:with-param name="date">
					<xsl:choose>
						<xsl:when test="value_date[.!='']"><xsl:value-of select="value_date"/></xsl:when>
						<xsl:when test="value_date_term_number[.!='']"><xsl:value-of select="value_date_term_number"/></xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="code">
					<xsl:choose>
						<xsl:when test="value_date_term_code[.!='']"><xsl:value-of select="value_date_term_code"/></xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
		      </xsl:call-template> 
		      
		      
		       <xsl:call-template name="multioption-group">
			    <xsl:with-param name="group-label">XSL_CONTRACT_XO_MARKET_ORDER_LABEL</xsl:with-param>
			    <xsl:with-param name="content">
			     <xsl:call-template name="radio-field">
			      <xsl:with-param name="label">XSL_YES</xsl:with-param>
			      <xsl:with-param name="name">market_order</xsl:with-param>
			      <xsl:with-param name="id">market_order_1</xsl:with-param>
			      <xsl:with-param name="value">Y</xsl:with-param>
			      <xsl:with-param name="checked"><xsl:if test="market_order[. = '']">Y</xsl:if></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="radio-field">
			      <xsl:with-param name="label">XSL_NO</xsl:with-param>
			      <xsl:with-param name="name">market_order</xsl:with-param>
			      <xsl:with-param name="id">market_order_2</xsl:with-param>
			      <xsl:with-param name="value">N</xsl:with-param>
			     </xsl:call-template>
			    </xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_CONTRACT_XO_TRIGGER_POS_LABEL</xsl:with-param>
			     <xsl:with-param name="name">trigger_pos</xsl:with-param>			     
			     <xsl:with-param name="required">N</xsl:with-param>
			     <xsl:with-param name="type">number</xsl:with-param>
			     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_CONTRACT_XO_TRIGGER_STOP_LABEL</xsl:with-param>
			     <xsl:with-param name="name">trigger_stop</xsl:with-param>			     
			     <xsl:with-param name="required">N</xsl:with-param>
			     <xsl:with-param name="type">number</xsl:with-param>
			     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_CONTRACT_XO_TRIGGER_LIMIT_LABEL</xsl:with-param>
			     <xsl:with-param name="name">trigger_limit</xsl:with-param>			     
			     <xsl:with-param name="required">N</xsl:with-param>
			     <xsl:with-param name="type">number</xsl:with-param>
			     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="input-field">
				 <xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
				 <xsl:with-param name="name">remarks</xsl:with-param>
				 <xsl:with-param name="maxsize">70</xsl:with-param>
			  </xsl:call-template>   
			</xsl:with-param>
		</xsl:call-template>
 	</div>
 </xsl:template>
  
 <xsl:template name="xo-options">
 	<option value="EXPDAT/TIM">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'EXPDAT/TIM')"/>
   	</option>
   	<option value="CALICLOSE">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'CALICLOSE')"/>
   	</option>
   	<option value="CALIOPEN">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'CALIOPEN')"/>
   	</option>
   	<option value="GTC">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'GTC')"/>
   	</option>
   	<option value="HKGCLOSE">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'HKGCLOSE')"/>
   	</option>
   	<option value="HKDOPEN">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'HKDOPEN')"/>
   	</option>
   	<option value="LDNCLOSE">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'LDNCLOSE')"/>
   	</option>
   	<option value="LDNOPEN">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'LDNOPEN')"/>
   	</option>
   	<option value="MEXCLOSE">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'MEXCLOSE')"/>
   	</option>
   	<option value="MEXOPEN">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'MEXOPEN')"/>
   	</option>
   	<option value="NYCLOSE">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'NYCLOSE')"/>
   	</option>
   	<option value="NYOPEN">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'NYOPEN')"/>
   	</option>
   	<option value="PARISCLOSE">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'PARISCLOSE')"/>
   	</option>
   	<option value="PARISOPEN">
   		<xsl:value-of select="localization:getDecode($language, 'N412', 'PARISOPEN')"/>
   	</option>
 </xsl:template> 
 
	<!-- validationErrors -->
  	<xsl:template match="errors">
		<div id="validationErrors" style="display:none;">
		<xsl:for-each select="error">
			<span class="validationError"><xsl:value-of select="."/></span>
		</xsl:for-each>
	   	</div>	
  	</xsl:template>
 
</xsl:stylesheet>