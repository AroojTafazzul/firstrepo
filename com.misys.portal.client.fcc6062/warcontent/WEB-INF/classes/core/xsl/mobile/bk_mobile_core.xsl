<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all 

Copyright (c) 2000-2008 Misys (http://www.misys.com),
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
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="localization">
	<xsl:output method="xml" omit-xml-declaration="yes"/>
	 <xsl:param name="language">en</xsl:param>
	
	<xsl:template match="ft_tnx_record | se_tnx_record | bk_tnx_record">
	<key_details>
		<ref_id>
			<xsl:value-of select="ref_id"/>
		</ref_id>
		<tnx_id>
			<xsl:value-of select="tnx_id"/>
		</tnx_id>
		<product_code>
			<xsl:value-of select="product_code"/>
		</product_code>
		<token>
			<xsl:value-of select="token"/>
		</token>
		<list_keys>
			<xsl:value-of select="list_keys"/>
		</list_keys>
	</key_details>
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
			</label>
			<xsl:choose>
				<xsl:when test="bulk_ref_id[.!='']">
					<xsl:call-template name="mobile-field">
							<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/>
							<xsl:with-param name="value" select="bulk_ref_id"/>
					</xsl:call-template>
					
					<xsl:if test="entities[number(.) &gt; 0]">
						<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
								<xsl:with-param name="value" select="entity"/>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:call-template name="mobile-field">
			          <xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/>
			           <xsl:with-param name="value" select="applicant_act_name"/>
			         </xsl:call-template>
			         
			         <xsl:call-template name="mobile-field">
			          <xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>
			           <xsl:with-param name="value">
			           	<xsl:if test="sub_product_code[.!='']">
			           		<xsl:value-of select="localization:getDecode($language, 'N047', concat(sub_product_code,'_BK'))"/>
			           	</xsl:if>
			           </xsl:with-param>
			         </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				<xsl:if test="entities[number(.) &gt; 0]">                                     
	 	 				<xsl:call-template name="mobile-field">
			           <xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
			           <xsl:with-param name="value" select="entity"/>
			         </xsl:call-template>                                                  
	 	 			 	</xsl:if>
					<xsl:call-template name="mobile-field">
			           <xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>
			           <xsl:with-param name="value" select="localization:getDecode($language, 'N047', sub_product_code)"/>
		         	</xsl:call-template> 
				    <xsl:call-template name="mobile-field">
			           <xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/>
			           <xsl:with-param name="value" select="applicant_act_name"/>
			         </xsl:call-template>	
				  </xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label">
						<xsl:choose>
							<xsl:when test="sub_product_code[.='INT']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_TO')"></xsl:value-of>
							</xsl:when>		
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')"></xsl:value-of>
							</xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty/counterparty_name" />
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT')"></xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty/counterparty_act_no"/>
			</xsl:call-template>
	       	<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'BANK_LABEL')"></xsl:with-param>	
				<xsl:with-param name="value" select="issuing_bank/name" />
			</xsl:call-template>
		</sections>
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')"/>
			</label>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TRANSFER')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/></xsl:with-param> 
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param> 
			</xsl:call-template>
		</sections>
			
	</xsl:template>
     <xsl:template name="mobile-field">
		<xsl:param name="label"></xsl:param>
		<xsl:param name="value"></xsl:param>
		<object>
			<label>
				<xsl:value-of select="$label"/>
			</label>
			<value>
				<xsl:value-of select="$value" />
			</value>
		</object>
	</xsl:template>
</xsl:stylesheet>