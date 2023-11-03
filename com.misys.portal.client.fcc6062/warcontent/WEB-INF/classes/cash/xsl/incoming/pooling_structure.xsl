<?xml version="1.0" encoding="UTF-8" ?>
<!-- Copyright (c) 2000-2018 Misys , All Rights Reserved. -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:liquidityUtils="xalan://com.misys.portal.cash.product.lbo.common.LiquidityUtils"
	xmlns:facilityUtils="xalan://com.misys.portal.common.facility.FacilityUtils"
	exclude-result-prefixes="service liquidityUtils facilityUtils">

	<xsl:param name="banks"/>
	<xsl:param name="bo_type"/>

	<!-- Process pooling structure file -->	
	<xsl:template match="pooling_structure_record/convention">
		<xsl:variable name="custRef"><xsl:value-of select="facilityUtils:getCustomerReferencebyBOType(customer_reference, $bo_type)"/></xsl:variable>
		<xsl:variable name="references" select="liquidityUtils:manageReferences($custRef)"/>	

		<xsl:variable name="companyId" select="$references/references/company_id"/>
		<xsl:variable name="companyAbbvName" select="$references/references/company_abbv_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="mainBankAbbvName" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="customerBankReference" select="$references/references/customer_bank_reference"/>

		<result>
	 		<com.misys.portal.cash.product.lbo.common.PoolingStructureFile>
				<xsl:variable name="poolingStructureId"><xsl:value-of select="liquidityUtils:retrieveStructureId(structure_code)"/></xsl:variable>
				<com.misys.portal.cash.product.lbo.common.PoolingStructure>
					<!-- keys must be attributes -->
					<xsl:attribute name="structure_id"><xsl:value-of select="$poolingStructureId"/></xsl:attribute>
					<!-- 
					<structure_id>
						<xsl:value-of select="structure_id"/>
					</structure_id>
					 -->
					<structure_code>
						<xsl:value-of select="structure_code"/>
					</structure_code>
					<customer_reference>
						<xsl:value-of select="$customerBankReference"/>
					</customer_reference>
					<xsl:if test="$entity != ''">
						<entity>
							<xsl:value-of select="$entity"/>
						</entity>
					</xsl:if>
					<xsl:if test="$entity != '' and $companyId != ''">
						<entity_id>
							<xsl:value-of select="liquidityUtils:retrieveEntityId($entity, $companyId)"/>
						</entity_id>
					</xsl:if>
					<xsl:if test="$companyId != ''">
						<company_id>
							<xsl:value-of select="$companyId"/>
						</company_id>
					</xsl:if>
					<xsl:if test="$companyAbbvName != ''">
						<company_abbv_name>
							<xsl:value-of select="$companyAbbvName"/>
						</company_abbv_name>
					</xsl:if>
					<description>
						<xsl:value-of select="description"/>
					</description>
					<effective_date>
						<xsl:value-of select="effective_date"/>
					</effective_date>
				</com.misys.portal.cash.product.lbo.common.PoolingStructure>
	
				<!--  Balancing groups -->
				<xsl:apply-templates select="balancing_groups/balancing_group">
					<xsl:with-param name="paramPoolingStructureId"><xsl:value-of select="$poolingStructureId"/></xsl:with-param>
				</xsl:apply-templates>
			</com.misys.portal.cash.product.lbo.common.PoolingStructureFile>
		</result>
	</xsl:template>	
	
	<xsl:template match="balancing_groups/balancing_group">
		<xsl:param name="paramPoolingStructureId"/>
		
		<xsl:variable name="balanceGroupId"><xsl:value-of select="liquidityUtils:generateNextBalanceGroupId()"/></xsl:variable>
		<com.misys.portal.cash.product.lbo.common.BalancingGroup>
			<!-- keys must be attributes -->
			<xsl:attribute name="group_id"><xsl:value-of select="$balanceGroupId"/></xsl:attribute>
			<!-- 
			<group_id>
				<xsl:value-of select="group_id" />
			</group_id>
			-->
			<group_code>
				<xsl:value-of select="group_code"/>
			</group_code>
			<description>
				<xsl:value-of select="description"/>
			</description>
			<frequency>
				<xsl:value-of select="frequency"/>
			</frequency>
			<balance_type>
				<xsl:value-of select="balance_type"/>
			</balance_type>
			<company_id>
				<xsl:value-of select="company_id"/>
			</company_id>
			<structure_id>
				<xsl:value-of select="$paramPoolingStructureId"/>
			</structure_id>
			<structure_code>
				<xsl:value-of select="structure_code"/>
			</structure_code>
			<currency>
				<xsl:value-of select="cur_code"/>
			</currency>
			<minimum>
				<xsl:value-of select="minimum"/>
			</minimum>
			<rounding>
				<xsl:value-of select="rounding"/>
			</rounding>
			<group_order>
				<xsl:value-of select="group_order"/>
			</group_order>
		</com.misys.portal.cash.product.lbo.common.BalancingGroup>
		
		<!--  Balancing sub groups -->
		<xsl:apply-templates select="balancing_sub_groups/balancing_sub_group">
			<xsl:with-param name="paramBalanceGroupId"><xsl:value-of select="$balanceGroupId"/></xsl:with-param>
		</xsl:apply-templates>
		
	</xsl:template>

	<xsl:template match="balancing_sub_groups/balancing_sub_group">
		<xsl:param name="paramBalanceGroupId"/>
		
		<xsl:variable name="balanceSubGroupId"><xsl:value-of select="liquidityUtils:generateNextBalanceGroupId()"/></xsl:variable>
		<com.misys.portal.cash.product.lbo.common.BalancingSubGroup>
			<!-- keys must be attributes -->
			<xsl:attribute name="sub_group_id"><xsl:value-of select="$balanceSubGroupId"/></xsl:attribute>
			<!--
			<sub_group_id>
				<xsl:value-of select="sub_group_id"/>
			</sub_group_id>
			-->
			<sub_group_code>
				<xsl:value-of select="sub_group_code"/>
			</sub_group_code>
			<group_id>
				<xsl:value-of select="$paramBalanceGroupId"/>
			</group_id>
			<description>
				<xsl:value-of select="description"/>
			</description>
			<group_code>
				<xsl:value-of select="group_code"/>
			</group_code>
			<sub_group_pivot>
				<xsl:value-of select="sub_group_pivot"/>
			</sub_group_pivot>
			<sub_group_type>
				<xsl:value-of select="sub_group_type"/>
			</sub_group_type>
			<company_id>
				<xsl:value-of select="company_id"/>
			</company_id>
			<sub_group_pivot>
				<xsl:value-of select="sub_group_pivot"/>
			</sub_group_pivot>
			<balance_target>
				<xsl:value-of select="balance_target"/>
			</balance_target> 
			<low_balance_target>
				<xsl:value-of select="low_balance_target"/>
			</low_balance_target>
			<high_balance_target>
				<xsl:value-of select="high_balance_target"/>
			</high_balance_target>
			<low_target>
				<xsl:value-of select="low_target"/>
			</low_target>
			<high_target>
				<xsl:value-of select="high_target"/>
			</high_target>
			<indirect>
				<xsl:value-of select="indirect"/>
			</indirect>
		</com.misys.portal.cash.product.lbo.common.BalancingSubGroup>
		
		<!--  Balancing sub group accounts -->
		<xsl:apply-templates select="balancing_sub_group_accounts/balancing_sub_group_account">
			<xsl:with-param name="paramBalanceSubGroupId"><xsl:value-of select="$balanceSubGroupId"/></xsl:with-param>
		</xsl:apply-templates>
		
	</xsl:template>

	<xsl:template match="balancing_sub_group_accounts/balancing_sub_group_account">
		<xsl:param name="paramBalanceSubGroupId"/>
		
		<xsl:variable name="balanceSubGroupAccountId"><xsl:value-of select="liquidityUtils:generateNextBalanceSubGroupAccountId()"/></xsl:variable>
		<com.misys.portal.cash.product.lbo.common.AccountSubGroup>
			<!-- keys must be attributes -->
			<xsl:attribute name="account_id"><xsl:value-of select="$balanceSubGroupAccountId"/></xsl:attribute>
			<!-- 
			<account_id>
				<xsl:value-of select="account_id"/>
			</account_id>
			 -->
			<account_no>
				<xsl:value-of select="account_no"/>
			</account_no>
			<sub_group_id>
				<xsl:value-of select="$paramBalanceSubGroupId"/>
			</sub_group_id>
			<sub_group_code>
				<xsl:value-of select="sub_group_code"/>
			</sub_group_code>
			<sub_group_pivot>
				<xsl:value-of select="sub_group_pivot"/>
			</sub_group_pivot>
			<description>
				<xsl:value-of select="description"/>
			</description>
		</com.misys.portal.cash.product.lbo.common.AccountSubGroup>
		
	</xsl:template>

	<xsl:template name="product-additional-fields"/>
	
</xsl:stylesheet>