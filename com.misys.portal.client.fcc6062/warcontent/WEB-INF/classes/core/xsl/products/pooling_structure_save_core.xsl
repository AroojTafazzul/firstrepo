<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:balgrp="xalan://com.misys.portal.cash.product.lbo.common.BalancingGroup"
	xmlns:balsubgrp="xalan://com.misys.portal.cash.product.lbo.common.BalancingSubGroup"
	exclude-result-prefixes="balgrp balsubgrp"
	>
	<!-- Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com), All 
		Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process ACCOUNT -->
	<xsl:template match="pooling_structure">
		<result>
		
			<com.misys.portal.cash.product.lbo.common.PoolingStructure>
				<!-- keys must be attributes -->
				<xsl:attribute name="structure_id"><xsl:value-of select="structure_id" /></xsl:attribute>
				<xsl:if test="company_id">				
				<company_id>
					<xsl:value-of select="company_id" />
				</company_id>
				</xsl:if>
				<xsl:if test="structure_code">
				<structure_code>
					<xsl:value-of select="structure_code" />
				</structure_code>
				</xsl:if>
				<xsl:if test="structure_description">
				<description>
					<xsl:value-of select="structure_description" />
				</description>
				</xsl:if>
				<xsl:if test="effective_date">
				<effective_date>
					<xsl:value-of select="effective_date" />
				</effective_date>
				</xsl:if>
				<xsl:if test="reference">
				<reference>
					<xsl:value-of select="reference" />
				</reference>
				</xsl:if>	
		     <!-- Custom additional fields -->
		     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.lbo.common.PoolingStructure>
     <!-- Balancing Groups -->
       <xsl:apply-templates select="BalGroups/BalGroup">
        	<xsl:with-param name="companyId"><xsl:value-of select="company_id"/></xsl:with-param>
        	<xsl:with-param name="structureId"><xsl:value-of select="structure_id"/></xsl:with-param>
        	<xsl:with-param name="structureCode"><xsl:value-of select="structure_code"/></xsl:with-param>
       </xsl:apply-templates>
      
	</result>
	</xsl:template>
	
	<xsl:template match="BalGroups/BalGroup">
	   <xsl:param name="companyId"/>
	   <xsl:param name="structureId"/>
	   <xsl:param name="structureCode"/>
		<xsl:call-template name="balGrpTemplate">
		<xsl:with-param name="company_Id"><xsl:value-of select="$companyId"/></xsl:with-param>
		<xsl:with-param name="structure_Id"><xsl:value-of select="$structureId"/></xsl:with-param>
		<xsl:with-param name="structure_Code"><xsl:value-of select="$structureCode"/></xsl:with-param>
		
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="balGrpTemplate">		
        <xsl:param name="company_Id"/>
         <xsl:param name="structure_Id"/>
          <xsl:param name="structure_Code"/>
       <!--   <xsl:param name="grpId"/> -->
       
       <xsl:variable name="balgrp_id">
       
        <xsl:choose>
			   	<xsl:when test ="group_id">
			   	</xsl:when>	
		    	<xsl:otherwise>
					<xsl:value-of select="balgrp:generateId()"/>					
				</xsl:otherwise>
	   </xsl:choose>
       
       </xsl:variable>
       
      
       
		<com.misys.portal.cash.product.lbo.common.BalancingGroup>			
			<xsl:if test="group_code">
				<group_code>
					<xsl:value-of select="group_code"/>
				</group_code>
			</xsl:if>
			<xsl:if test="$structure_Code">
				<structure_code>
					<xsl:value-of select="$structure_Code"/>
				</structure_code>
			</xsl:if>
			<xsl:if test="description">
				<description>
					<xsl:value-of select="description"/>
				</description>
			</xsl:if>
			<xsl:if test="frequency">
				<frequency>
					<xsl:value-of select="frequency"/>
				</frequency>
			</xsl:if>
			<xsl:if test="balance_type">
				<balance_type>
					<xsl:value-of select="balance_type"/>
				</balance_type>
			</xsl:if>
			<xsl:if test="currency">
				<currency>
					<xsl:value-of select="currency"/>
				</currency>
			</xsl:if>
			<xsl:if test="minimum">
				<minimum>
					<xsl:value-of select="minimum"/>
				</minimum>
			</xsl:if>
			<xsl:if test="rounding">
				<rounding>
					<xsl:value-of select="rounding"/>
				</rounding>
			</xsl:if>
			<xsl:if test="bal_grp_order">
				<bal_grp_order>
					<xsl:value-of select="bal_grp_order"/>
				</bal_grp_order>
			</xsl:if>
			<xsl:if test="$company_Id">
				<company_id>
					<xsl:value-of select="$company_Id"/>
				</company_id>
			</xsl:if>
			<xsl:if test="$structure_Id">
				<structure_id>
					<xsl:value-of select="$structure_Id"/>
				</structure_id>
			</xsl:if>
			<xsl:choose>
			   	<xsl:when test="group_id">
			   	<group_id>
						<xsl:value-of select="group_id"/>
				</group_id>		    	
		    	</xsl:when>
		    	<xsl:otherwise>					
					<group_id>
						<xsl:value-of select="$balgrp_id"/>
					</group_id>	
				</xsl:otherwise>
	       </xsl:choose>		
			
		</com.misys.portal.cash.product.lbo.common.BalancingGroup>
		
		<xsl:apply-templates select="balsubgroups/balsubgroup">  		     
		      <xsl:with-param name="company"><xsl:value-of select="$company_Id"/></xsl:with-param>		      
		        <xsl:with-param name="groupId">
		        <xsl:choose>
		          <xsl:when test="group_id"> 
		          <xsl:value-of select="group_id"/>	
		          </xsl:when>
		          <xsl:otherwise>
		           <xsl:value-of select="$balgrp_id"/>	
		          </xsl:otherwise>
		        </xsl:choose>	
		        </xsl:with-param>
		        <xsl:with-param name="groupCode"><xsl:value-of select="group_code"/></xsl:with-param>  	
       </xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="balsubgroups/balsubgroup">		 
	   <xsl:param name="company"/>
	    <xsl:param name="groupId"/>
	    <xsl:param name="groupCode"/>	    
		<xsl:call-template name="balsubGrpTemplate">
		  <xsl:with-param name="company1"><xsl:value-of select="$company"/></xsl:with-param>
		  <xsl:with-param name="groupid"><xsl:value-of select="$groupId"/></xsl:with-param>
		  <xsl:with-param name="groupcode"><xsl:value-of select="$groupCode"/></xsl:with-param>		
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="balsubGrpTemplate">	
       <xsl:param name="company1"/>
        <xsl:param name="groupid"/>
        <xsl:param name="groupcode"/>
        
        <xsl:variable name="balsubgrp_id">
	        <xsl:choose>
				   	<xsl:when test ="sub_group_id">
				   	</xsl:when>	
			    	<xsl:otherwise>
						<xsl:value-of select="balsubgrp:generateId()"/>					
					</xsl:otherwise>
		   </xsl:choose>
	   </xsl:variable>
        
		<com.misys.portal.cash.product.lbo.common.BalancingSubGroup>			
			<xsl:if test="sub_group_code">
				<sub_group_code>
					<xsl:value-of select="sub_group_code"/>
				</sub_group_code>
			</xsl:if>
			<xsl:if test="$groupcode">
				<group_code>
					<xsl:value-of select="$groupcode"/>
				</group_code>
			</xsl:if>
			<xsl:if test="$company1">
				<company_id>
					<xsl:value-of select="$company1"/>
				</company_id>
			</xsl:if>
			<xsl:if test="subgrp_description">
				<description>
					<xsl:value-of select="subgrp_description"/>
				</description>
			</xsl:if>
			<xsl:if test="subGrpPivot">
				<subGrpPivot>
					<xsl:value-of select="subGrpPivot"/>
				</subGrpPivot>
			</xsl:if>
			<xsl:if test="subGrpType">
				<subGrpType>
					<xsl:value-of select="subGrpType"/>
				</subGrpType>
			</xsl:if>
			<xsl:if test="balance_target">
				<balance_target>
					<xsl:value-of select="balance_target"/>
				</balance_target>
			</xsl:if>
			<xsl:if test="low_target">
				<low_target>
					<xsl:value-of select="low_target"/>
				</low_target>
			</xsl:if>
			<xsl:if test="high_target">
				<high_target>
					<xsl:value-of select="high_target"/>
				</high_target>
			</xsl:if>
			<xsl:choose>
			   	<xsl:when test="sub_group_id">
			   	<sub_group_id>
						<xsl:value-of select="sub_group_id"/>
				</sub_group_id>		    	
		    	</xsl:when>
		    	<xsl:otherwise>
					<sub_group_id>
						<xsl:value-of select="$balsubgrp_id"/>
					</sub_group_id>
				</xsl:otherwise>
	       </xsl:choose>
			
			
			<xsl:if test="$groupid">
				<group_id>
					<xsl:value-of select="$groupid"/>
				</group_id>
			</xsl:if>				
			
		</com.misys.portal.cash.product.lbo.common.BalancingSubGroup>
		<xsl:apply-templates select="acctsubgroups/acctsubgroup">  		     
		      <xsl:with-param name="company"><xsl:value-of select="$company1"/></xsl:with-param>		      
		        <xsl:with-param name="subGroupId">
		        <xsl:choose>
		          <xsl:when test="sub_group_id"> 
		          <xsl:value-of select="sub_group_id"/>	
		          </xsl:when>
		          <xsl:otherwise>
		           <xsl:value-of select="$balsubgrp_id"/>	
		          </xsl:otherwise>
		        </xsl:choose>	
		        </xsl:with-param>	
		        <xsl:with-param name="subGroupCode"><xsl:value-of select="sub_group_code"/></xsl:with-param>	 	     
       </xsl:apply-templates>
		
	</xsl:template>
	
	<!-- Balancing Sub Group Accounts -->	
	<xsl:template match ="acctsubgroups/acctsubgroup">
		 <xsl:param name="company"/>
		    <xsl:param name="subGroupId"/>
		     <xsl:param name="subGroupCode"/>	
			<xsl:call-template name="acctsubGrpTemplate">
			  <xsl:with-param name="company2"><xsl:value-of select="$company"/></xsl:with-param>
			  <xsl:with-param name="subGroupId"><xsl:value-of select="$subGroupId"/></xsl:with-param>
			  <xsl:with-param name="subGroupCode"><xsl:value-of select="$subGroupCode"/></xsl:with-param>		
			</xsl:call-template>
	</xsl:template>
	
	<xsl:template name ="acctsubGrpTemplate">
	  		<xsl:param name="company2"/>
		    <xsl:param name="subGroupId"/>
		    <xsl:param name="subGroupCode"/>
		<com.misys.portal.cash.product.lbo.common.AccountSubGroup>
		
			<xsl:if test="$subGroupCode">
				<sub_group_code>
					<xsl:value-of select="$subGroupCode"/>
				</sub_group_code>
			</xsl:if>
			<xsl:if test="account_no">
				<account_no>
					<xsl:value-of select="account_no"/>
				</account_no>
			</xsl:if>
			<xsl:if test="$company2">
				<company_id>
					<xsl:value-of select="$company2"/>
				</company_id>
			</xsl:if>
			<xsl:if test="$subGroupId">
				<sub_group_id>
					<xsl:value-of select="$subGroupId"/>
				</sub_group_id>
			</xsl:if>
			<xsl:if test="sub_group_pivot">
				<sub_group_pivot>
					<xsl:value-of select="sub_group_pivot"/>
				</sub_group_pivot>
			</xsl:if>
			<xsl:if test="description">
				<description>
					<xsl:value-of select="description"/>
				</description>
			</xsl:if>
	</com.misys.portal.cash.product.lbo.common.AccountSubGroup>
</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
