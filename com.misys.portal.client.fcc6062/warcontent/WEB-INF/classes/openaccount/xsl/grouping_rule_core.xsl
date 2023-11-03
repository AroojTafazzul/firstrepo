<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	exclude-result-prefixes="converttools">

	<!--
   Copyright (c) 2000-2007 Misys (http://www.misys.com),
   All Rights Reserved. 
	-->
	
	<xsl:output method="xml" indent="no" cdata-section-elements="report"/>
	<!-- <xsl:output method="xml" indent="no"/>-->
	
	<!-- Get the language code -->
	<xsl:param name="language"/>

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process rules -->
	<xsl:template match="grouping_rule_records">
		<xsl:param name="company_id">
			<xsl:value-of select="company_id"/>
		</xsl:param>
		<xsl:param name="abbv_name">
			<xsl:value-of select="abbv_name"/>
		</xsl:param>
		
		<result>
			<xsl:for-each select="//*[starts-with(name(), 'grouping_rule_details_position_')]">
				<xsl:call-template name="grouping_rule">
					<xsl:with-param name="company_id">
						<xsl:value-of select="$company_id"/>
					</xsl:with-param>
					<xsl:with-param name="abbv_name">
						<xsl:value-of select="$abbv_name"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</result>
		
	</xsl:template>
	
	<!-- Rule -->
	<xsl:template name="grouping_rule">
		<xsl:param name="company_id"/>
		<xsl:param name="abbv_name"/>
		<xsl:variable name="position">
			<xsl:value-of select="substring-after(name(), 'grouping_rule_details_position_')"/>
		</xsl:variable>

		<com.misys.portal.openaccount.product.po.grouping.rule.GroupingRule>
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_rule_id_', $position))]">
				<xsl:attribute name="rule_id">
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_rule_id_', $position))]"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$company_id">
				<xsl:attribute name="company_id">
					<xsl:value-of select="$company_id"/>
				</xsl:attribute>
			</xsl:if>

			<!--<rule_order>
				<xsl:value-of select="$position"/>
			</rule_order>-->
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_rule_order_', $position))]">
				<rule_order>
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_rule_order_', $position))]"/>
				</rule_order>
			</xsl:if>
			<xsl:if test="$abbv_name">
				<company_name>
					<xsl:value-of select="$abbv_name"/>
				</company_name>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_description_', $position))]">
				<description>
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_description_', $position))]"/>
				</description>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_entity_', $position))]">
				<entity>
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_entity_', $position))]"/>
				</entity>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_product_code_', $position))]">
				<destination_product_code>
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_product_code_', $position))]"/>
				</destination_product_code>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_retention_', $position))]">
				<retention_period>
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_retention_', $position))]"/>
				</retention_period>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_min_cur_code_', $position))]">
				<min_cur_code>
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_min_cur_code_', $position))]"/>
				</min_cur_code>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_min_amt_', $position))]">
				<min_amt>
					<xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_min_amt_', $position))]"/>
				</min_amt>
			</xsl:if>
			<report>
				&lt;listdef>
					&lt;column name="ref_id"/>
					&lt;column name="total_amt"/>
					&lt;column name="total_cur_code"/>
					&lt;column name="entity"/>
					&lt;candidate name="purchase_order_master">
						<!-- Filter -->
						&lt;filter>
							<xsl:call-template name="CRITERIA">
								<xsl:with-param name="position"><xsl:value-of select="$position"/></xsl:with-param>
							</xsl:call-template>
						&lt;/filter>
					&lt;/candidate>
					<!-- Group by entity and currency code -->
					&lt;group>
						&lt;column name="entity"/>
						&lt;column name="total_cur_code"/>
					&lt;/group>
				&lt;/listdef>
			</report>
		
		</com.misys.portal.openaccount.product.po.grouping.rule.GroupingRule>
	</xsl:template>
	
	
	<!--*******************-->
	<!-- Filters/Criterias -->
	<!--*******************-->

	<xsl:template name="CRITERIA">
	
		<xsl:param name="position"/>

		<!-- Do not select purchase orders already grouped into a product -->
		&lt;criteria>
			&lt;column name="link_ref_id" type="String"/>
			&lt;operator type="isNull"/>
		&lt;/criteria>
		
		<!-- Select purchase orders associated to the entity defined in the rule -->
		<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_entity_', $position))] and //*[starts-with(name(),concat('grouping_rule_details_entity_', $position))] != '*'">
			&lt;criteria>
				&lt;column name="entity" type="String"/>
				&lt;operator type="equal"/>
				&lt;value type="string"><xsl:value-of select="//*[starts-with(name(),concat('grouping_rule_details_entity_', $position))]"/>&lt;/value>
			&lt;/criteria>
		</xsl:if>
		
		<!-- The minimum amount stands for the minimum amount of the total of the group --> 
		<!--<xsl:if test="//*[starts-with(name(),concat('grouping_rule_details_unformatted_min_amt_', $position))] and //*[starts-with(name(),concat('grouping_rule_details_min_cur_code_', $position))]">
			&lt;criteria>
				&lt;column name="total_cur_code" type="String"/>
				&lt;operator type="supOrEqual"/>
					&lt;value type="string">
						<xsl:variable name="amount">
							<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_details_unformatted_min_amt_', $position))]"/>
						</xsl:variable>
						<xsl:variable name="currency">
							<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_details_min_cur_code_', $position))]"/>
						</xsl:variable>
						<xsl:value-of select="concat(converttools:getDefaultAmountRepresentation($amount, $language), '@', $currency)"/>
					&lt;/value>
			&lt;/criteria>
		</xsl:if>-->

		<xsl:for-each select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_position_'))]">
			<xsl:variable name="criteriaPosition">
				<xsl:value-of select="substring-after(name(), concat('grouping_rule_', $position, '_criteria_details_position_'))"/>
			</xsl:variable>
			
			<xsl:variable name="operator">
				<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_actual_operator_', $criteriaPosition))]"/>
			</xsl:variable>

			&lt;criteria>
				&lt;column
					name="<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_actual_column_', $criteriaPosition))]"/>"
					type="<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_actual_column_type_', $criteriaPosition))]"/>">
				&lt;/column>
				&lt;operator
					type="<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_actual_operator_', $criteriaPosition))]"/>">
				&lt;/operator>
				<xsl:if test="$operator != 'isNull' and $operator != 'isNotNull'"> 
				<xsl:variable name="valueType">
					<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_actual_value_type_', $criteriaPosition))]"/>
				</xsl:variable>
				&lt;value
					type="<xsl:value-of select="$valueType"/>">
					<xsl:choose>
						<xsl:when test="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_string_value_', $criteriaPosition))] != ''">
							<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_string_value_', $criteriaPosition))]"/>
						</xsl:when>
						<xsl:when test="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_amount_value_', $criteriaPosition))] != ''">
							<xsl:variable name="amount">
								<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_amount_value_', $criteriaPosition))]"/>
							</xsl:variable>
							<xsl:variable name="currency">
								<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_amount_currency_value_', $criteriaPosition))]"/>
							</xsl:variable>
							<xsl:value-of select="concat(converttools:getDefaultAmountRepresentation($amount, $language), '@', $currency)"/>
						</xsl:when>
						<xsl:when test="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_date_value_', $criteriaPosition))] != ''">
							<xsl:variable name="date">
								<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_date_value_', $criteriaPosition))]"/>
							</xsl:variable>
							<xsl:value-of select="converttools:getDefaultTimestampRepresentation($date, $language)"></xsl:value-of>
						</xsl:when>
						<xsl:when test="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_values_set_parameter_', $criteriaPosition))] != ''">
							<xsl:value-of select="//*[starts-with(name(), concat('grouping_rule_', $position, '_criteria_details_values_set_parameter_', $criteriaPosition))]"/>
						</xsl:when>
					</xsl:choose>
				&lt;/value>
				</xsl:if>
			&lt;/criteria>

		</xsl:for-each>
				
	</xsl:template>
	
</xsl:stylesheet>
