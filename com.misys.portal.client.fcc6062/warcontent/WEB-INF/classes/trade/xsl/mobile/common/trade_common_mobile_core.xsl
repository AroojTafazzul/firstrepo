<?xml version="1.0" encoding="UTF-8"?>
<!-- ########################################################## Templates 
	for displaying transaction summaries. Copyright (c) 2000-2008 Misys (http://www.misys.com), 
	All Rights Reserved. version: 1.0 date: 12/03/08 author: Cormac Flynn email: 
	cormac.flynn@misys.com ########################################################## -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization converttools xmlRender utils defaultresource security">

	<xsl:output method="xml" indent="yes" />
	<xsl:param name="rundata"/>
	<xsl:param name="language"/>

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
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"
							select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')" />
						<xsl:with-param name="value" select="ref_id" />
			</xsl:call-template>
			<xsl:if test="bo_ref_id[.!='']">
				<xsl:call-template name="mobile-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
						<xsl:with-param name="value">
							<xsl:value-of select="bo_ref_id" />
						</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')" />
					<xsl:with-param name="value" select="localization:getDecode($language, 'N001', product_code)" />
				</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')" />
				<xsl:with-param name="value" select="appl_date" />
			</xsl:call-template>
		</xsl:template>
	
		<xsl:template name="applicant-details">
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
								<xsl:with-param name="value" select="entity"/>
			</xsl:call-template>
			<!-- <xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="applicant_name"/>
			</xsl:call-template> -->
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
				<xsl:with-param name="value">
					<xsl:choose>
	      				<xsl:when test="applicant_name[.!='']"><xsl:value-of select="applicant_name" /></xsl:when>
	      				<xsl:when test="drawer_name[.!='']"><xsl:value-of select="drawer_name" /></xsl:when>
	      				<xsl:when test="beneficiary_name[.!=''] and product_code[.='IR']"><xsl:value-of select="beneficiary_name" /></xsl:when>
	      				<xsl:otherwise><xsl:value-of select="applicant_name" /></xsl:otherwise>
	      			</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
	
		<xsl:template name="beneficiary-details">
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value">
									<xsl:choose>
					      				<xsl:when test="remitter_name[.!=''] and product_code[.='IR']"><xsl:value-of select="remitter_name" /></xsl:when>
					      				<xsl:otherwise><xsl:value-of select="beneficiary_name" /></xsl:otherwise>
					      			</xsl:choose>
								</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
								<xsl:with-param name="value" select="beneficiary_country"/>
			</xsl:call-template>
		</xsl:template>
	
		<xsl:template name="issuing-bank-details">
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
					<xsl:with-param name="value" select="issuing_bank/abbv_name"/>
			</xsl:call-template>
			<xsl:call-template name="applicant-reference-details"/>
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
		
		<xsl:template name="applicant-reference-details">
		<xsl:variable name="appl_ref">
                	<xsl:value-of select="applicant_reference"/>
           </xsl:variable>
		<xsl:call-template name="mobile-field">
		<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
		<xsl:with-param name="value">
			    <xsl:choose>
					<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) &gt;= 1 or count(//*/avail_main_banks/bank/entity/customer_reference) &gt;= 1">
					<xsl:choose>
					<xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
					<xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/reference)"/>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
					</xsl:otherwise>
					</xsl:choose>
				    </xsl:when>
				     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0 or count(//*/avail_main_banks/bank/entity/customer_reference) = 0">
				         <xsl:choose>
				                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
				                      <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
				                 </xsl:when>  
				                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') [.!= 'true']">
				                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
				                 </xsl:when>
				                 <xsl:otherwise>
				                          <xsl:choose>
									<xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'false'">
                                                     <xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
                                                </xsl:when>   
                                                <xsl:otherwise>
                                                     <xsl:value-of select="utils:decryptApplicantReference(//*/customer_references/customer_reference[reference=$appl_ref]/reference)"/>
                                                </xsl:otherwise>										
                                                </xsl:choose>  
				                 </xsl:otherwise>
				         </xsl:choose>
				    </xsl:when>
				     <xsl:otherwise>
				     	<xsl:choose>
					     	<xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
			                      <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference/description"/>
			                 </xsl:when>  
			                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') [.!= 'true']">
			                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/entity/customer_reference/reference)"/>
			                 </xsl:when>
			                 <xsl:when test="//*/avail_main_banks/bank/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
			                      <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
			                 </xsl:when>  
			                 <xsl:when test="//*/avail_main_banks/bank/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') [.!= 'true']">
			                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
			                 </xsl:when>
				        </xsl:choose>         
				     </xsl:otherwise>
				</xsl:choose>
			  </xsl:with-param>  
		</xsl:call-template>
	</xsl:template>
		
	<xsl:template name="remitting-bank-details">
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
				<xsl:with-param name="value" select="remitting_bank/abbv_name"/>
		</xsl:call-template>
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
				<xsl:with-param name="value">
				<xsl:choose>
			     	<xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
	                      <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference/description"/>
	                 </xsl:when>  
	                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') != 'true'">
	                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/entity/customer_reference/reference)"/>
	                 </xsl:when>
	                 <xsl:when test="//*/avail_main_banks/bank/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
	                      <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
	                 </xsl:when>  
	                 <xsl:when test="//*/avail_main_banks/bank/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') != 'true'">
	                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
	                 </xsl:when>
		        </xsl:choose> 
		 </xsl:with-param>             
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="recipient-bank-details">
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
				<xsl:with-param name="value" select="recipient_bank/abbv_name"/>
		</xsl:call-template>
		<xsl:call-template name="applicant-reference-details"/>
	</xsl:template>
	
	<xsl:template name="drawee-details">
		<xsl:call-template name="mobile-field">
							<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
							<xsl:with-param name="value" select="drawee_name"/>
		</xsl:call-template>
		<xsl:call-template name="mobile-field">
							<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
							<xsl:with-param name="value" select="drawee_country"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="drawer-details">
		<xsl:call-template name="mobile-field">
							<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
							<xsl:with-param name="value" select="drawer_name"/>
		</xsl:call-template>
		<xsl:call-template name="mobile-field">
							<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
							<xsl:with-param name="value" select="drawer_country"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="presenting-bank-details">
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
				<xsl:with-param name="value" select="presenting_bank/abbv_name"/>
		</xsl:call-template>
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
				<xsl:with-param name="value">
				<xsl:choose>
			     	<xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
	                      <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference/description"/>
	                 </xsl:when>  
	                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') != 'true'">
	                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/entity/customer_reference/reference)"/>
	                 </xsl:when>
	                 <xsl:when test="//*/avail_main_banks/bank/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
	                      <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
	                 </xsl:when>  
	                 <xsl:when test="//*/avail_main_banks/bank/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') != 'true'">
	                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
	                 </xsl:when>
		        </xsl:choose> 
		 </xsl:with-param>             
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>