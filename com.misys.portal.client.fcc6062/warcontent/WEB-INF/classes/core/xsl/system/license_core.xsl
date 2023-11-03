<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2008 Misys (http://www.misys.com),
   All Rights Reserved.
   
   Guarantee type save stylesheet.
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Guarantee -->
	<xsl:template match="license">
		<result>
			<com.misys.portal.common.license.LicenseDefinition>
				<xsl:if test="owner_company_id">
					<owner_company_id>
						<xsl:value-of select="owner_company_id"/>
					</owner_company_id>
				</xsl:if>
				<xsl:if test="ls_def_id">
					<ls_def_id>
						<xsl:value-of select="ls_def_id"/>
					</ls_def_id>
				</xsl:if>
				<xsl:if test="ls_type">
					<ls_type>
						<xsl:value-of select="ls_type"/>
					</ls_type>
				</xsl:if>
				<xsl:if test="ls_name">
					<ls_name>
						<xsl:value-of select="ls_name"/>
					</ls_name>
				</xsl:if>
				<xsl:if test="ls_desc">
					<ls_desc>
						<xsl:value-of select="ls_desc"/>
					</ls_desc>
				</xsl:if>
				<xsl:if test="multi_cur">
					<multi_cur>
						<xsl:value-of select="multi_cur"/>
					</multi_cur>
				</xsl:if>
				<xsl:if test="multi_cur_override">
					<multi_cur_override>
						<xsl:value-of select="multi_cur_override"/>
					</multi_cur_override>
				</xsl:if>
				<xsl:if test="allow_overdraw">
					<allow_overdraw>
						<xsl:value-of select="allow_overdraw"/>
					</allow_overdraw>
				</xsl:if>
				<xsl:if test="allow_multi_ls">
					<allow_multi_ls>
						<xsl:value-of select="allow_multi_ls"/>
					</allow_multi_ls>
				</xsl:if>
				<xsl:if test="principal_override">
					<principal_override>
						<xsl:value-of select="principal_override"/>
					</principal_override>
				</xsl:if>
				<xsl:if test="principal_label">
					<principal_label>
						<xsl:value-of select="principal_label"/>
					</principal_label>
				</xsl:if>
				<xsl:if test="non_principal_override">
					<non_principal_override>
						<xsl:value-of select="non_principal_override"/>
					</non_principal_override>
				</xsl:if>
				<xsl:if test="non_principal_label">
					<non_principal_label>
						<xsl:value-of select="non_principal_label"/>
					</non_principal_label>
				</xsl:if>
				<xsl:if test="non_principal_default">
					<non_principal_default>
						<xsl:value-of select="non_principal_default"/>
					</non_principal_default>
				</xsl:if>
			</com.misys.portal.common.license.LicenseDefinition>
			<xsl:apply-templates select="customers/customer">
				<xsl:with-param name="ls_def_id" select="ls_def_id"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="products/product">
				<xsl:with-param name="ls_def_id" select="ls_def_id"/>
			</xsl:apply-templates>
		</result>
	 </xsl:template>
	 
	 <xsl:template match="customers/customer">
	 	<xsl:param name="ls_def_id"/>
		<xsl:call-template name="customer">
			<xsl:with-param name="ls_def_id" select="$ls_def_id"/>
		</xsl:call-template>	
	</xsl:template>
	<xsl:template name="customer">
		<xsl:param name="ls_def_id"/>
		<com.misys.portal.common.license.LicenseCustomer>
			<xsl:attribute name="ls_def_id"><xsl:value-of select="$ls_def_id"/></xsl:attribute>
			<ls_def_id><xsl:value-of select="$ls_def_id"/></ls_def_id>
			<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
			</xsl:if>
			<xsl:if test="abbv_name">
					<abbv_name>
						<xsl:value-of select="abbv_name"/>
					</abbv_name>
			</xsl:if>
			<xsl:if test="name_">
					<name>
						<xsl:value-of select="name_"/>
					</name>
			</xsl:if>
			<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
			</xsl:if>
			<xsl:if test="entity_id">
					<entity_id>
						<xsl:value-of select="entity_id"/>
					</entity_id>
			</xsl:if>
		</com.misys.portal.common.license.LicenseCustomer>	
	</xsl:template>
	<xsl:template match="products/product">
	 	<xsl:param name="ls_def_id"/>
		<xsl:call-template name="product">
			<xsl:with-param name="ls_def_id" select="$ls_def_id"/>
		</xsl:call-template>	
	</xsl:template>
	<xsl:template name="product">
		<xsl:param name="ls_def_id"/>
		<com.misys.portal.common.license.LicenseProduct>
			<xsl:attribute name="ls_def_id"><xsl:value-of select="$ls_def_id"/></xsl:attribute>
			<ls_def_id><xsl:value-of select="$ls_def_id"/></ls_def_id>
			<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
			</xsl:if>
			<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
			</xsl:if>
			<xsl:if test="product_type_code">
					<product_type_code>
						<xsl:value-of select="product_type_code"/>
					</product_type_code>
			</xsl:if>
		</com.misys.portal.common.license.LicenseProduct>	
	</xsl:template>
</xsl:stylesheet>
