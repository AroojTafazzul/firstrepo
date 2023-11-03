<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com) All Rights Reserved. -->
<!--  This file acts as  holder to transform the bulk information and the secured email transaction information -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	exclude-result-prefixes="tools">
	<xsl:template match="bulk_upload_holder">
	<result>
 		<com.misys.portal.interfaces.incoming.BulkUploadHolder>
		<xsl:for-each select="bk_tnx_record">
			<xsl:apply-templates select="."></xsl:apply-templates>
		</xsl:for-each>

	   <xsl:for-each select="se_tnx_record">
	   <xsl:variable name="references" select="tools:manageReferences(product_code, ref_id, tnx_id, bo_ref_id, bo_tnx_id, cust_ref_id, company_id ,company_name, applicant_reference, issuing_bank/abbv_name,'01')"/>
	   <xsl:variable name="ref_id" select="$references/references/ref_id"/>
	   <xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
	   <xsl:variable name="company_id" select="$references/references/company_id"/>
	   <xsl:variable name="company_name" select="$references/references/company_name"/>
	   <xsl:variable name="entity" select="$references/references/entity"/>	
	   <xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name" />
	   <xsl:variable name="main_bank_name" select="$references/references/main_bank_name" />
	   	  <com.misys.portal.product.se.common.SecureEmailFile>
	   		<xsl:apply-templates select=".">
	     		<xsl:with-param name="incoming_mode">bulk</xsl:with-param>
	     		<xsl:with-param name="param_company_id" select="$company_id" />
				<xsl:with-param name="param_ref_id" select="$ref_id" />
				<xsl:with-param name="param_tnx_id" select="$tnx_id" />
				<xsl:with-param name="param_company_name" select="$company_name" />
				<xsl:with-param name="param_entity" select="$entity" />
				<xsl:with-param name="param_main_bank_abbv_name" select="$main_bank_abbv_name" />
				<xsl:with-param name="param_main_bank_name" select="$main_bank_name" />
	   		</xsl:apply-templates>
	   	 </com.misys.portal.product.se.common.SecureEmailFile>
	   </xsl:for-each>
	</com.misys.portal.interfaces.incoming.BulkUploadHolder>
	</result>
	</xsl:template>
</xsl:stylesheet>
