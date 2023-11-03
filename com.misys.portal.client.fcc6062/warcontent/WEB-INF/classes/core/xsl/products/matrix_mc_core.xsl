<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<!--
##########################################################
Templates for

 Save Matrix

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

	Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	
	<xsl:template match="matrix_record">
		<result>
			<com.misys.portal.systemfeatures.authorisation.AuthorisationTnx>
				<xsl:if test="matrix_id">
					<matrix_id>
						<xsl:value-of select="matrix_id"/>
					</matrix_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
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
				<xsl:if test="maker_id">
					<maker_id>
						<xsl:value-of select="maker_id"/>
					</maker_id>
				</xsl:if>
				<xsl:if test="checker_id">
					<checker_id>
						<xsl:value-of select="checker_id"/>
					</checker_id>
				</xsl:if>
				<xsl:if test="mc_tnx_stat_code">
					<mc_tnx_stat_code>
						<xsl:value-of select="mc_tnx_stat_code"/>
					</mc_tnx_stat_code>
				</xsl:if>
				<xsl:if test="mc_tnx_type_code">
					<mc_tnx_type_code>
						<xsl:value-of select="mc_tnx_type_code"/>
					</mc_tnx_type_code>
				</xsl:if>
				<xsl:if test="maker_dttm">
					<maker_dttm>
						<xsl:value-of select="maker_dttm"/>
					</maker_dttm>
				</xsl:if>
				<xsl:if test="checker_dttm">
					<checker_dttm>
						<xsl:value-of select="checker_dttm"/>
					</checker_dttm>
				</xsl:if>
				<xsl:if test="return_comments">
					<return_comments>
						<xsl:value-of select="return_comments"/>
					</return_comments>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code"/>
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="account_no">		
					<account_no>
						<xsl:value-of select="account_no"/>
					</account_no>
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
				
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.authorisation.AuthorisationTnx>
			<xsl:for-each select="//*[starts-with(name(), 'authorization_level_role_id_')]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), 'authorization_level_role_id_')"/>
				</xsl:variable>
				<xsl:call-template name="LEVELTNX">
					<xsl:with-param name="levelId"><xsl:value-of select="/matrix_record/level_id"/></xsl:with-param>
					<xsl:with-param name="matrixId"><xsl:value-of select="/matrix_record/matrix_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="/matrix_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="roleId"><xsl:value-of select="//*[starts-with(name(),concat('authorization_level_role_id_', $position))]"/></xsl:with-param>
					<xsl:with-param name="orderNumber"><xsl:value-of select="//*[starts-with(name(),concat('authorization_level_order_number_', $position))]"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/matrix_record/company_id"/></xsl:with-param>
					<xsl:with-param name="entityParam"><xsl:value-of select="/matrix_record/entity"/></xsl:with-param>
					<xsl:with-param name="makerId"><xsl:value-of select="/matrix_record/maker_id"/></xsl:with-param>
					<xsl:with-param name="checkerId"><xsl:value-of select="/matrix_record/checker_id"/></xsl:with-param>
					<xsl:with-param name="mcTnxStatCode"><xsl:value-of select="/matrix_record/mc_tnx_stat_code"/></xsl:with-param>
					<xsl:with-param name="mcTnxTypeCode"><xsl:value-of select="/matrix_record/mc_tnx_type_code"/></xsl:with-param>
					<xsl:with-param name="makerDttm"><xsl:value-of select="/matrix_record/maker_dttm"/></xsl:with-param>
					<xsl:with-param name="checkerDttm"><xsl:value-of select="/matrix_record/checker_dttm"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
		</result>
	</xsl:template>
	
	
	
	<xsl:template name="LEVELTNX">
		<xsl:param name="levelId"/>
		<xsl:param name="matrixId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="roleId"/>
		<xsl:param name="orderNumber"/>
		<xsl:param name="companyId"/>
		<xsl:param name="entityParam" />
		<xsl:param name="makerId" />
		<xsl:param name="checkerId" />
		<xsl:param name="mcTnxStatCode" />
		<xsl:param name="mcTnxTypeCode" />
		<xsl:param name="makerDttm" />
		<xsl:param name="checkerDttm" />
							
		
		<com.misys.portal.systemfeatures.authorisation.LevelTnx>
			<xsl:if test="$levelId">
				<level_id>
					<xsl:value-of select="$levelId"/>
				</level_id>
			</xsl:if>
			<xsl:if test="$matrixId">
				<matrix_id>
					<xsl:value-of select="$matrixId"/>
				</matrix_id>
			</xsl:if>
			<xsl:if test="$tnxId">
				<tnx_id>
					<xsl:value-of select="$tnxId"/>
				</tnx_id>
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
			<xsl:if test="$makerId">
				<maker_id>
					<xsl:value-of select="$makerId"/>
				</maker_id>
			</xsl:if>
			<xsl:if test="$checkerId">
				<checker_id>
					<xsl:value-of select="$checkerId"/>
				</checker_id>
			</xsl:if>
			<xsl:if test="$mcTnxStatCode">
				<mc_tnx_stat_code>
					<xsl:value-of select="$mcTnxStatCode"/>
				</mc_tnx_stat_code>
			</xsl:if>
			<xsl:if test="$mcTnxTypeCode">
				<mc_tnx_type_code>
					<xsl:value-of select="$mcTnxTypeCode"/>
				</mc_tnx_type_code>
			</xsl:if>
			<xsl:if test="$makerDttm">
				<maker_dttm>
					<xsl:value-of select="$makerDttm"/>
				</maker_dttm>
			</xsl:if>
			<xsl:if test="$checkerDttm">
				<checker_dttm>
					<xsl:value-of select="$checkerDttm"/>
				</checker_dttm>
			</xsl:if>
			
			
		</com.misys.portal.systemfeatures.authorisation.LevelTnx>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
