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
	 
	<xsl:template match="td_tnx_record">
		<key_details>
			<ref_id>
				<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
								<xsl:with-param name="value" select="ref_id"/>
				</xsl:call-template>	
			</ref_id>
			<tnx_id>
				<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'TRANSACTIONID')"/>
								<xsl:with-param name="value" select="tnx_id"/>
				</xsl:call-template>	
			</tnx_id>
			<product_code>
				<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
								<xsl:with-param name="value" select="product_code"/>
				</xsl:call-template>
			</product_code>
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
							<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/></xsl:with-param>
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
			           <xsl:with-param name="value" select="localization:getDecode($language, 'N047', 'CSTD')"/>
		         	</xsl:call-template> 
				    <xsl:call-template name="mobile-field">
			           <xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/></xsl:with-param>
			           <xsl:with-param name="value" select="applicant_act_name"/>
			         </xsl:call-template>	
				  </xsl:otherwise>
			</xsl:choose>
		</sections>
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')"/>
			</label>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_TD_PLACEMENT_AMOUNT')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="td_cur_code"/>&nbsp;<xsl:value-of select="td_amt"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR')"></xsl:with-param>
				<xsl:with-param name="value">><xsl:value-of select="value_date_term_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', value_date_term_code)"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TD_CREDIT_ACCOUNT')"></xsl:with-param>
				<xsl:with-param name="value" select="credit_act_name" />
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TD_DEPOSIT_TYPE')"></xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N414', td_type)"/></xsl:with-param>
			</xsl:call-template>
		</sections>
			
	</xsl:template>
	 <xsl:template name="mobile-section">
		<xsl:param name="label"></xsl:param>
		<section>
			<label>
				<xsl:value-of select="$label"/>
			</label>
		</section>
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