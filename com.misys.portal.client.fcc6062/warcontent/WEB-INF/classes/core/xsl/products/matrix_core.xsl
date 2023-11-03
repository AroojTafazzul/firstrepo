<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<!--
##########################################################
Templates for

 Save Matrix

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      30/12/2010
author:    Saïd SAI
##########################################################
-->


	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	
	<xsl:template match="matrix_record">
		<result>
			<com.misys.portal.systemfeatures.authorisation.Authorisation>
				<xsl:if test="matrix_id">
					<matrix_id>
						<xsl:value-of select="matrix_id"/>
					</matrix_id>
				</xsl:if>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="lmt_cur_code">
					<iso_code>
						<xsl:value-of select="lmt_cur_code"/>
					</iso_code>
				</xsl:if>
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
				<xsl:if test="lmt_amt">
					<lmt_amt>
						<xsl:value-of select="lmt_amt"/>
					</lmt_amt>
				</xsl:if>
				<xsl:if test="min_lmt_amt">
					<min_lmt_amt>
						<xsl:value-of select="min_lmt_amt"/>
					</min_lmt_amt>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code"/>
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code"/>
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="amt_type">
					<amt_type>
						<xsl:value-of select="amt_type"/>
					</amt_type>
				</xsl:if>
				<xsl:if test="wild_card_ind">
					<wild_card_ind>
						<xsl:value-of select="wild_card_ind"/>
					</wild_card_ind>
				</xsl:if>
				<xsl:if test="sequential">
					<sequential>
						<xsl:value-of select="sequential"/>
					</sequential>
				</xsl:if>
				<xsl:if test="account_no">		
					<account_no>
						<xsl:value-of select="account_no"/>
					</account_no>
				</xsl:if>
				<xsl:if test="product_type_code">
					<product_type_code>
						<xsl:value-of select="product_type_code"/>
					</product_type_code>
				</xsl:if>
				<xsl:if test="tenor_type_code">
					<tenor_type_code>
						<xsl:value-of select="tenor_type_code"/>
					</tenor_type_code>
				</xsl:if>
				<xsl:if test="business_area">
	    			<additional_field name="business_area" type="string" scope="master" description="Decides which business area is chosen">
						<xsl:value-of select="business_area"/>
					</additional_field>	
				</xsl:if>
				<xsl:if test="verify">
					<additional_field name="verify" type="string" scope="master" description="Verify">
						<xsl:value-of select="verify"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="send">
					<additional_field name="send" type="string" scope="master" description="Send">
						<xsl:value-of select="send"/>
					</additional_field>
				</xsl:if>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.authorisation.Authorisation>
			<xsl:for-each select="//*[starts-with(name(), 'authorization_level_role_id_')]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), 'authorization_level_role_id_')"/>
				</xsl:variable>
				<xsl:call-template name="LEVEL">
					<xsl:with-param name="levelId"><xsl:value-of select="/matrix_record/level_id"/></xsl:with-param>
					<xsl:with-param name="matrixId"><xsl:value-of select="/matrix_record/matrix_id"/></xsl:with-param>
					<xsl:with-param name="roleId"><xsl:value-of select="//*[starts-with(name(),concat('authorization_level_role_id_', $position))]"/></xsl:with-param>
					<xsl:with-param name="orderNumber"><xsl:value-of select="//*[starts-with(name(),concat('authorization_level_order_number_', $position))]"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/matrix_record/company_id"/></xsl:with-param>
					<xsl:with-param name="entityParam"><xsl:value-of select="/matrix_record/entity"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
		</result>
	</xsl:template>
	
	
	
	<xsl:template name="LEVEL">
		<xsl:param name="levelId"/>
		<xsl:param name="matrixId"/>
		<xsl:param name="roleId"/>
		<xsl:param name="orderNumber"/>
		<xsl:param name="companyId"/>
		<xsl:param name="entityParam"/>
		
		<com.misys.portal.systemfeatures.authorisation.Level>
			<xsl:if test="$levelId">
				<matrix_id>
					<xsl:value-of select="$levelId"/>
				</matrix_id>
			</xsl:if>
			<xsl:if test="$matrixId">
				<matrix_id>
					<xsl:value-of select="$matrixId"/>
				</matrix_id>
			</xsl:if>
			<xsl:if test="$roleId">
				<role_id>
					<xsl:value-of select="$roleId"/>
				</role_id>
			</xsl:if>
			<xsl:if test="$orderNumber">
				<order_number>
					<xsl:value-of select="$orderNumber"/>
				</order_number>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id>
					<xsl:value-of select="$companyId"/>
				</company_id>
			</xsl:if>
			<xsl:if test="$entityParam">
				<entity>
					<xsl:value-of select="$entityParam"/>
				</entity>
			</xsl:if>
		</com.misys.portal.systemfeatures.authorisation.Level>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
