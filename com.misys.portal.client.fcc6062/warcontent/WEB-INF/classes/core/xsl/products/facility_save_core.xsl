<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2011 Misys , All Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process facility-->
	<xsl:template match="master_facility_record">
		<result>
			<com.misys.portal.common.facility.FacilityMaster>
				<!-- keys must be attributes -->
				<xsl:attribute name="facility_id"><xsl:value-of select="facility_id" /></xsl:attribute>
				<facility_reference>
					<xsl:value-of select="facility_reference" />
				</facility_reference>
				<company_abbv_name>
					<xsl:value-of select="company_abbv_name" />
				</company_abbv_name>
				<brch_code>
					<xsl:value-of select="brch_code" />
				</brch_code>
				<bank_abbv_name>
					<xsl:value-of select="bank_abbv_name" />
				</bank_abbv_name>
				<facility_description>
					<xsl:value-of select="facility_description" />
				</facility_description>
				<cur_code>
					<xsl:value-of select="base_cur_code" />
				</cur_code>
				<facility_amt>
					<xsl:value-of select="facility_amt" />
				</facility_amt>
				<utilised_amt>
					<xsl:value-of select="utilised_amt" />
				</utilised_amt>
				<outstanding_amt>
					<xsl:value-of select="facility_outstanding_amt" />
				</outstanding_amt>
				<review_date>
					<xsl:value-of select="review_date" />
				</review_date>
				<facility_pricing_details>
					<xsl:value-of select="facility_pricing_details" />
				</facility_pricing_details>
				<bo_reference>
					<xsl:value-of select="bo_reference" />
				</bo_reference>
				<status>
					<xsl:value-of select="facility_status" />
				</status>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.common.facility.FacilityMaster>
			<xsl:call-template name="facilityEntities"/>
			<xsl:for-each select="//*[starts-with(name(), 'limits')]">
			  <xsl:call-template name="limits"></xsl:call-template>
			</xsl:for-each>
		</result>
	</xsl:template>
	<xsl:template name="facilityEntities">
	  <xsl:for-each select="/master_facility_record/attached_entities/entity">
	     <com.misys.portal.common.facility.FacilityEntity>
	      	<entity_abbv_name><xsl:value-of select="entity_abbv_name"/></entity_abbv_name>
	     </com.misys.portal.common.facility.FacilityEntity>
	  </xsl:for-each>
	</xsl:template>
	<xsl:template name="limitEntities">
	  <xsl:param name="limit_ref"></xsl:param>
	  <xsl:for-each select="attached_entities/entity">
	     <com.misys.portal.common.facility.LimitEntity>
	      	<entity_abbv_name><xsl:value-of select="entity_abbv_name"/></entity_abbv_name>
	      	<limit_reference><xsl:value-of select="$limit_ref"/></limit_reference>
	     </com.misys.portal.common.facility.LimitEntity>
	  </xsl:for-each>
	</xsl:template>
	<xsl:template name="limits">
		<xsl:for-each select="limit">
		     <com.misys.portal.common.facility.LimitMaster>
		     	<limit_id>
		     		<xsl:value-of select="limit_id"/>
		     	</limit_id>
		      	<limit_reference>
		      		<xsl:value-of select="limit_ref"/>
		      	</limit_reference>
		      	<cur_code>
		      		<xsl:value-of select="limit_cur_code" />
		      	</cur_code>
		      	<limit_amt>
		      		<xsl:value-of select="limit_amt" />
		      	</limit_amt>
		      	<utilised_amt>
		      		<xsl:value-of select="utilised_amt" />
		      	</utilised_amt>
		      	<outstanding_amt>
		      		<xsl:value-of select="outstanding_amt" />
		      	</outstanding_amt>
		      	<review_date>
					<xsl:value-of select="limit_review_date" />
				</review_date>
				<limit_pricing_details>
					<xsl:value-of select="limit_pricing" />
				</limit_pricing_details>
				<product_code>
					<xsl:value-of select="product_code" />
				</product_code>
				<sub_product_code>
					<xsl:value-of select="sub_product_code" />
				</sub_product_code>
				<product_type_code>
					<xsl:value-of select="product_type_code" />
				</product_type_code>
				<product_template>
					<xsl:value-of select="product_template" />
				</product_template>
				<counterparty>
					<xsl:value-of select="limit_counterparty" />
				</counterparty>
				<country>
					<xsl:value-of select="beneficiary_country" />
				</country>
				<status>
					<xsl:value-of select="limit_status" />
				</status>
		     </com.misys.portal.common.facility.LimitMaster>
		       	<xsl:call-template name="limitEntities">
			  		<xsl:with-param name="limit_ref"><xsl:value-of select="limit_ref"/></xsl:with-param>
			  	</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>

