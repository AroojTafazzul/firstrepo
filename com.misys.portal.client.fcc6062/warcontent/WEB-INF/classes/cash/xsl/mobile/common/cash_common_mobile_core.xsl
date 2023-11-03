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
	
	<xsl:template name="key-details">
			<key_details>
				<ref_id>
					<xsl:value-of select="ref_id"/>
				</ref_id>
				<tnx_id>
					<xsl:value-of select="tnx_id"/>
				</tnx_id>
				<productcode>
					<xsl:value-of select="product_code"/>
				</productcode>
				<subproductcode>
					<xsl:value-of select="sub_product_code"/>
				</subproductcode>
				<tnxtype>
					"<xsl:value-of select="tnx_type_code"/>"
				</tnxtype>
				<token>
					<xsl:value-of select="token"/>
				</token>
				<list_keys>
					<xsl:value-of select="list_keys"/>
				</list_keys>
			</key_details>
	</xsl:template>
	
	<xsl:template name="common-general-details">
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
					<xsl:call-template name="mobile-field">
							<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
							<xsl:with-param name="value" select="ref_id"/>
					</xsl:call-template>
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
		</xsl:template>
		<xsl:template name="transfer-to-details">
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
		</xsl:template>
		
		<xsl:template name="beneficiary-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')"></xsl:with-param>
				<xsl:with-param name="value" select="beneficiary_name"/>
			</xsl:call-template>
	       	<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"></xsl:with-param>	
				<xsl:with-param name="value" select="beneficiary_address" />
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="swift-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"></xsl:with-param>
				<xsl:with-param name="value" select="//cpty_bank_swift_bic_code"/>
			</xsl:call-template>
	       	<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_BENEFICIARY_BANK_NAME')"></xsl:with-param>	
				<xsl:with-param name="value" select="//cpty_bank_name" />
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"></xsl:with-param>
				<xsl:with-param name="value" select="//cpty_bank_address_line_1"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"></xsl:with-param>
				<xsl:with-param name="value" select="//cpty_bank_country"/>
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="ft-tnx-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TRANSFER')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/></xsl:with-param> 
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param> 
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="td-tnx-details">
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
		</xsl:template>
		
		<xsl:template name="fx-tnx-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_TYPE_LABEL')"/></xsl:with-param>	
				<xsl:with-param name="value" select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL')"/></xsl:with-param>	
				<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="contract_type[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')"/></xsl:otherwise>
					</xsl:choose>	
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL')"/></xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="fx_cur_code"/>&nbsp;<xsl:value-of select="fx_amt"/></xsl:with-param>	
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_SETTLEMENT_CTAMOUNT_LABEL')"/></xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="counter_cur_code"/>&nbsp;<xsl:value-of select="counter_amt"/></xsl:with-param>	
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_VALUE_DATE_FX_LABEL')"/></xsl:with-param>
				<xsl:with-param name="value" select="value_date" />
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_LABEL')"/></xsl:with-param>
				<xsl:with-param name="value" select="rate" />
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="fx-customer-payment-details">
			<xsl:choose>
				<xsl:when test="counterparties/counterparty/counterparty_type='03' and counterparties/counterparty/counterparty_cur_code[.!=''] ">
					<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_SI_CUSTOMER_INSTRUCTIONS_PAYMENT_CURRENCY')"/></xsl:with-param>	
						<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="mobile-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_SI_CUSTOMER_INSTRUCTIONS_PAYMENT_ACCOUNT')"></xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:template>
		
		<xsl:template name="cheque-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'ACCOUNT_NUMBER_LABEL')"></xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="applicant_act_name"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_CHEQUEDETAILS_CHEQUE_TYPE')"></xsl:with-param>
				<xsl:with-param name="value" select="localization:getDecode($language, 'N115', cheque_type)" />
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="return-comments">
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="value" select="return_comments"/>
					<xsl:with-param name="mobile-textarea">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
		
     <xsl:template name="mobile-field">
			<xsl:param name="label"></xsl:param>
			<xsl:param name="value"></xsl:param>
			<xsl:param name="mobile-textarea"></xsl:param>
			<object>
				<label>
					<xsl:value-of select="$label" />
				</label>
				<value>
					<xsl:value-of select="$value" />
				</value>
				<xsl:if test="$mobile-textarea = 'Y'">
					<mobileTextareaContent>true</mobileTextareaContent>
				</xsl:if>
			</object>
	</xsl:template>
</xsl:stylesheet>