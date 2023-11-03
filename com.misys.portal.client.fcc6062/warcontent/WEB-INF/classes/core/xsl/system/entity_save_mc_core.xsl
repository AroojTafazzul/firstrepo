<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils">
	
<!--
##########################################################
Templates for

 Save Matrix

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      30/12/2010
author:    Saïd SAI
##########################################################
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="entity">
		<result>
			<com.misys.portal.entity.common.EntityTnx>
				<xsl:if test="entity_id">
			   		<entity_id>
			    	  <xsl:value-of select="entity_id"/>
			  	   </entity_id>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="company_abbv_name">
					<company_abbv_name>
						<xsl:value-of select="company_abbv_name"/>
					</company_abbv_name>
				</xsl:if>
				<xsl:if test="abbv_name">
					<abbv_name>
						<xsl:value-of select="abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="name">
					<name>
						<xsl:value-of select="name"/>
					</name>
				</xsl:if>
				<xsl:if test="address_line_1">
					<address_line_1>
						<xsl:value-of select="address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="address_line_2">
					<address_line_2>
						<xsl:value-of select="address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="address_line_3">
					<address_line_3>
						<xsl:value-of select="address_line_3"/>
					</address_line_3>
				</xsl:if>
				<xsl:if test="address_line_4">
					<address_line_4>
						<xsl:value-of select="address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="dom">
					<dom>
						<xsl:value-of select="dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="subscription_code">
					<package_id>
						<xsl:value-of select="subscription_code"/>
					</package_id>
				</xsl:if>
				<xsl:if test="customise_package">
					<customise_package>
						<xsl:value-of select="customise_package"/>
					</customise_package>
				</xsl:if>
				<xsl:if test="country">
					<country>
						<xsl:value-of select="country"/>
					</country>
				</xsl:if>
				<xsl:if test="bei">
					<bei>
						<xsl:value-of select="bei"/>
					</bei>
				</xsl:if>
				<xsl:if test="street_name">
					<street_name>
						<xsl:value-of select="street_name"/>
					</street_name>
				</xsl:if>
				<xsl:if test="post_code">
					<post_code>
						<xsl:value-of select="post_code"/>
					</post_code>
				</xsl:if>
				<xsl:if test="town_name">
					<town_name>
						<xsl:value-of select="town_name"/>
					</town_name>
				</xsl:if>
				<xsl:if test="country_sub_div">
					<country_sub_div>
						<xsl:value-of select="country_sub_div"/>
					</country_sub_div>
				</xsl:if>
				<xsl:if test="crm_email">
					<crm_email>
						<xsl:value-of select="crm_email"/>
					</crm_email>
				</xsl:if>
				<xsl:if test="email">
					<contact_email>
						<xsl:value-of select="email"/>
					</contact_email>
				</xsl:if>
				<xsl:if test="contact_person">
					<contact_person>
						<xsl:value-of select="contact_person"/>
					</contact_person>
				</xsl:if>
				<xsl:if test="subscription_package">
				     <package_id>
				        <xsl:value-of select="subscription_package"/>
				     </package_id>
				</xsl:if>
				<xsl:if test="return_comments">
					<return_comments>
						<xsl:value-of select="return_comments"/>
					</return_comments>
				</xsl:if>
			</com.misys.portal.entity.common.EntityTnx>
			
			<com.misys.portal.product.util.EntityReferenceTnx>
			<xsl:for-each select="//*[starts-with(name(), 'references')]">
			    <reference>
			       <xsl:value-of select="reference"></xsl:value-of>
			    </reference>
			    <description>
			       <xsl:value-of select="description"></xsl:value-of>
			    </description>
			</xsl:for-each>
			</com.misys.portal.product.util.EntityReferenceTnx>
			
			<xsl:for-each select="//*[starts-with(name(), 'accounts')]">
			  <xsl:call-template name="account"></xsl:call-template>
			</xsl:for-each>
			<xsl:for-each select="//*[starts-with(name(), 'existing_roles')]">
			  <xsl:call-template name="entity-roles"></xsl:call-template>
			</xsl:for-each>
			 
			
		</result>
	</xsl:template>
	<xsl:template name="account">
		<xsl:for-each select="account">
		<com.misys.portal.cash.product.ab.common.AccountTnx>
		<xsl:variable name="curCode" ><xsl:value-of select="ccy"/></xsl:variable>
		<xsl:variable name="acctNo" ><xsl:value-of select="account_number"/></xsl:variable>
		<xsl:variable name="acctDescription" ><xsl:value-of select="description"/></xsl:variable>
		<xsl:variable name="accountName"><xsl:value-of select="concat($curCode,' ',$acctNo,' ',$acctDescription)"/></xsl:variable>
			    <cur_code>
			       <xsl:value-of select="ccy"></xsl:value-of>
			    </cur_code>
			    <account_no>
			    	<xsl:value-of select="account_number"></xsl:value-of>
			    </account_no>
			     <description>
			    	<xsl:value-of select="description"></xsl:value-of>
			    </description>
			    <bank_id>
			    	<xsl:value-of select="bank_id"></xsl:value-of>
			    </bank_id>
			     <branch_no>
			    	<xsl:value-of select="branch_code"></xsl:value-of>
			    </branch_no>
			    <acct_name>
			       <xsl:value-of select="$accountName"></xsl:value-of>
			    </acct_name>
			    <account_type>
			    	<xsl:value-of select="account_type"></xsl:value-of>
			    </account_type>
			    <additional_field name="nra" type="string" scope="master">
						<xsl:value-of select="nra"/>
				</additional_field>
				<additional_field name="bank_account_type" type="string" scope="master">
						<xsl:value-of select="type"/>
				</additional_field>
				<additional_field name="customer_account_type" type="string" scope="master">
						<xsl:value-of select="cust_account_type"/>
				</additional_field>
				<additional_field name="bank_account_product_type" type="string" scope="master">
						<xsl:value-of select="account_product_type"/>
				</additional_field>
				<xsl:if test="settlement_means">
					<additional_field name="settlement_means" type="string" scope="master">
							<xsl:value-of select="settlement_means"/>
					</additional_field>
				</xsl:if>
		</com.misys.portal.cash.product.ab.common.AccountTnx>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="entity-roles">
	  <xsl:for-each select="roles_desc_record">
	     <com.misys.portal.product.util.EntityRoleTnx>
	     <xsl:if test="role">
	     <xsl:variable name="role_desc"><xsl:value-of select="role"></xsl:value-of></xsl:variable>
	      	<role_id><xsl:value-of select="utils:getRoleId($role_desc)"/></role_id>
	      </xsl:if>
	     </com.misys.portal.product.util.EntityRoleTnx>
	  </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
