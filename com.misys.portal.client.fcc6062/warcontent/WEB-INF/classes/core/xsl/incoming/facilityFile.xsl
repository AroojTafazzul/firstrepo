<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com) All Rights Reserved. -->
<!--  This file acts as  holder to transform the bulk information and the secured email transaction information -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:user="xalan://com.misys.portal.security.GTPUser"
		xmlns:facilityUtils="xalan://com.misys.portal.common.facility.FacilityUtils"
			exclude-result-prefixes="security user">
			
	<xsl:param name="banks"/>
	<xsl:param name="bo_type"/>
	
	<xsl:template match="facility_details">
	<result>
 		<com.misys.portal.common.facility.FacilityFile>
 			<xsl:apply-templates select="master_facility_record">
 				<xsl:with-param name="operation_type"><xsl:value-of select="/master_facility_record/operation_type"/></xsl:with-param>
 			</xsl:apply-templates>
		</com.misys.portal.common.facility.FacilityFile>
	</result>
	</xsl:template>
	
	<xsl:template match="master_facility_record">
		<xsl:param name="operation_type"/>
		
		<xsl:variable name="custRef"><xsl:value-of select="facilityUtils:getCustomerReferencebyBOType(bo_reference, $bo_type)"/></xsl:variable>
		<xsl:variable name="ownerId"><xsl:value-of select="facilityUtils:getCompanyId($banks)"/></xsl:variable>
		
		<com.misys.portal.common.facility.FacilityMaster>
				<xsl:if test="facility_id">
					<facility_id>
						<xsl:value-of select="facility_id"/>
					</facility_id>
				</xsl:if>
				<owner_id>
					<xsl:value-of select="$ownerId"/>
				</owner_id>
				<xsl:if test="facility_reference">
					<facility_reference>
						<xsl:value-of select="facility_reference"/>
					</facility_reference>
				</xsl:if>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_abbv_name">
					<company_abbv_name>
						<xsl:value-of select="company_abbv_name"/>
					</company_abbv_name>
				</xsl:if>
				<xsl:if test="bank_abbv_name">
					<bank_abbv_name>
						<xsl:value-of select="bank_abbv_name"/>
					</bank_abbv_name>
				</xsl:if>
				<xsl:if test="facility_description">
					<facility_description>
						<xsl:value-of select="facility_description"/>
					</facility_description>
				</xsl:if>
				<xsl:if test="cur_code">
					<cur_code>
						<xsl:value-of select="cur_code"/>
					</cur_code>
				</xsl:if>
				<xsl:if test="facility_amt">
					<facility_amt>
						<xsl:value-of select="facility_amt"/>
					</facility_amt>
				</xsl:if>
				<xsl:if test="utilised_amt">
					<utilised_amt>
						<xsl:value-of select="utilised_amt"/>
					</utilised_amt>
				</xsl:if>
				<xsl:if test="outstanding_amt">
					<outstanding_amt>
						<xsl:value-of select="outstanding_amt"/>
					</outstanding_amt>
				</xsl:if>
				<xsl:if test="review_date">
					<review_date>
						<xsl:value-of select="review_date"/>
					</review_date>
				</xsl:if>
				<xsl:if test="facility_pricing_details">
					<facility_pricing_details>
						<xsl:value-of select="facility_pricing_details"/>
					</facility_pricing_details>
				</xsl:if>
				<xsl:if test="bo_reference">
					<bo_reference>
						<xsl:value-of select="$custRef"/>
					</bo_reference>
				</xsl:if>
				<xsl:if test="facility_status">
					<status>
						<xsl:value-of select="facility_status" />
					</status>
				</xsl:if>
				
				<additional_field name="operation_type" type="string" scope="none">
					<xsl:value-of select="operation_type"/>
				</additional_field>	
				<!-- presentationFields -->
		</com.misys.portal.common.facility.FacilityMaster>
		
		<xsl:apply-templates select="facility_entities"/>
 		<xsl:apply-templates select="limits"/>
 			
	</xsl:template>
	
	<xsl:template match="facility_entities">
		<result>
			<xsl:for-each select="facility_entity">
					<com.misys.portal.common.facility.FacilityEntity>
						<xsl:if test="facility_id">
							<facility_id>
								<xsl:value-of select="facility_id"/>
							</facility_id>
						</xsl:if>
						<xsl:if test="entity_id">
							<entity_id>
								<xsl:value-of select="entity_id"/>
							</entity_id>
						</xsl:if>
						<xsl:if test="entity_abbv_name">
							<entity_abbv_name>
								<xsl:value-of select="entity_abbv_name"/>
							</entity_abbv_name>
						</xsl:if>
						<!-- <additional_field name="limit_amt" type="string" scope="none">
							<xsl:value-of select="limit_amt"/>
						</additional_field> -->
					</com.misys.portal.common.facility.FacilityEntity>
			</xsl:for-each>
		</result>
	</xsl:template>
	
	<xsl:template match="limits">
		<result>
			<xsl:for-each select="limit">
				<com.misys.portal.common.facility.LimitMaster>
					<xsl:if test="limit_id">
							<limit_id>
								<xsl:value-of select="limit_id"/>
							</limit_id>
					</xsl:if>
					<xsl:if test="facility_id">
							<facility_id>
								<xsl:value-of select="facility_id"/>
							</facility_id>
					</xsl:if>
					<xsl:if test="limit_reference">
							<limit_reference>
								<xsl:value-of select="limit_reference"/>
							</limit_reference>
					</xsl:if>
					<xsl:if test="cur_code">
							<cur_code>
								<xsl:value-of select="cur_code"/>
							</cur_code>
					</xsl:if>
					<xsl:if test="limit_amt">
							<limit_amt>
								<xsl:value-of select="limit_amt"/>
							</limit_amt>
					</xsl:if>
					<xsl:if test="utilised_amt">
							<utilised_amt>
								<xsl:value-of select="utilised_amt"/>
							</utilised_amt>
					</xsl:if>	
					<xsl:if test="review_date">
							<review_date>
								<xsl:value-of select="review_date"/>
							</review_date>
					</xsl:if>
					<xsl:if test="limit_pricing_details">
							<limit_pricing_details>
								<xsl:value-of select="limit_pricing_details"/>
							</limit_pricing_details>
					</xsl:if>
					<xsl:if test="limit_product_code">
							<product_code>
								<xsl:value-of select="limit_product_code"/>
							</product_code>
					</xsl:if>
					<xsl:if test="limit_sub_product_code">
							<sub_product_code>
								<xsl:value-of select="limit_sub_product_code"/>
							</sub_product_code>
					</xsl:if>
					<xsl:if test="product_type_code">
							<product_type_code>
								<xsl:value-of select="product_type_code"/>
							</product_type_code>
					</xsl:if>
					<xsl:if test="product_template">
							<product_template>
								<xsl:value-of select="product_template"/>
							</product_template>
					</xsl:if>
					<xsl:if test="country">
							<country>
								<xsl:value-of select="country"/>
							</country>
					</xsl:if>
					<xsl:if test="limit_counterparty">
							<counterparty>
								<xsl:value-of select="limit_counterparty"/>
							</counterparty>
					</xsl:if>
					<xsl:if test="outstanding_amt">
							<outstanding_amt>
								<xsl:value-of select="outstanding_amt"/>
							</outstanding_amt>
					</xsl:if>
					
					<xsl:if test="limit_status">
						<status>
							<xsl:value-of select="limit_status" />
						</status>
					</xsl:if>
				</com.misys.portal.common.facility.LimitMaster>
				<xsl:for-each select="limit_entities/limit_entity">
					<com.misys.portal.common.facility.LimitEntity>
						<xsl:if test="limit_id">
							<limit_id>
								<xsl:value-of select="limit_id"/>
							</limit_id>
						</xsl:if>
						<xsl:if test="entity_id">
							<entity_id>
								<xsl:value-of select="entity_id"/>
							</entity_id>
						</xsl:if>
						<xsl:if test="entity_abbv_name">
							<entity_abbv_name>
								<xsl:value-of select="entity_abbv_name"/>
							</entity_abbv_name>
						</xsl:if>
						<xsl:if test="limit_reference">
							<limit_reference>
								<xsl:value-of select="limit_reference"/>
							</limit_reference>
						</xsl:if>
					</com.misys.portal.common.facility.LimitEntity>
				</xsl:for-each>
			</xsl:for-each>
		</result>
	</xsl:template>
</xsl:stylesheet>