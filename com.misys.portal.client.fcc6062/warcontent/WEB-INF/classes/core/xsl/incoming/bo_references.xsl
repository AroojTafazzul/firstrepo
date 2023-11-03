<?xml version="1.0" encoding="UTF-8" ?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.interfaces.incoming.LargeParameterKey"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="tools defaultresource">	
	
	<xsl:template match="assigned_references">
		<result>
			<xsl:apply-templates select="customer"/>
		</result>
	</xsl:template>

	<xsl:template match="customer">
		<xsl:apply-templates select="product">
			<xsl:with-param name="ti_mnemonic"><xsl:value-of select="@reference"/></xsl:with-param>
			<xsl:with-param name="customer_abbv_name"><xsl:value-of select="@abbv_name"/></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="product">
		<xsl:param name="ti_mnemonic"/>
		<xsl:param name="customer_abbv_name"/>
		<xsl:variable name="cust_abbv_name">
  		<xsl:choose>
	 	 <xsl:when test="defaultresource:getResource('USE_ABBV_NAME_FOR_BO_REFERENCE') != 'false' ">
 			 <xsl:value-of select="$customer_abbv_name"/>
		 </xsl:when>
   		<xsl:otherwise>
  			<xsl:value-of select="tools:retrieveCustomerAbbvNameFromTIMnemonic($ti_mnemonic)"/>
   		</xsl:otherwise>
    	 </xsl:choose>
		</xsl:variable>
	
		<xsl:variable name="brch_code">00001</xsl:variable>
		<xsl:variable name="parm_id">P225</xsl:variable>
		
		<xsl:variable name="param_id" select="tools:generateId()"/>
		
		<!-- Take back the company_id of the customer according the provided abbv name -->
		<xsl:variable name="company_id" select="tools:retrieveCompanyIdFromAbbvName($cust_abbv_name)"/>
		
		<xsl:variable name="wild_card_ind">1111111111111111111111</xsl:variable>
		
		<xsl:variable name="customer_reference" select="tools:retrieveCustomerReferenceFromTIMnemonic($ti_mnemonic, $cust_abbv_name)"/>
				
		<!-- Take back the owner of the customer, it works only if the customer is attached to one bank -->
		<xsl:variable name="key_1" select="tools:retrieveBankFromTIMnemonic($ti_mnemonic, $cust_abbv_name)"/>
		
		<xsl:variable name="key_10" select="tools:retrieveTIMnemonic($ti_mnemonic, $cust_abbv_name)"/>
		
		<com.misys.portal.interfaces.incoming.AssignedReferences>
		
			<com.misys.portal.interfaces.incoming.LargeParameterKey>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<parm_id><xsl:value-of select="$parm_id"/></parm_id>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<param_id><xsl:value-of select="$param_id"/></param_id>
				<wild_card_ind><xsl:value-of select="$wild_card_ind"/></wild_card_ind>
				
				<!-- bank abbv name -->
				<key_1><xsl:value-of select="$key_1"/></key_1>
				
				<!-- not used anymore, before there was entity name -->
				<key_2>**</key_2>
				
				<!-- product code -->
				<key_3><xsl:value-of select="@code"/></key_3>
				
				<!-- from -->
				<key_4>**</key_4>
				
				<!-- to -->
				<key_5>**</key_5>
				
				<!-- type of preallocated reference: multiple or unique -->
				<key_6>**</key_6>
				
				<!-- title --><!-- in the case of unique references, the value of the 'title' node is copied in the data_1 of gtp_laarge_param_data -->
				<key_7>**</key_7>
				
				<!-- customer input center -->
				<key_8>**</key_8>
				
				<!-- customer reference -->
				<key_9><xsl:value-of select="$customer_reference"/></key_9>
				
				<!-- back office 1 -->
				<key_10><xsl:value-of select="$ti_mnemonic"/></key_10>
				
				<!-- sub product code -->
				<key_11>**</key_11>
				
				<key_12>**</key_12>
				<key_13>**</key_13>
				<key_14>**</key_14>
				<key_15>**</key_15>
				<key_16>**</key_16>
				<key_17>**</key_17>
				<key_18>**</key_18>
				<key_19>**</key_19>
				<key_20>**</key_20>
				
				<xsl:apply-templates select="reference">
					<xsl:with-param name="param_id_ref"><xsl:value-of select="$param_id"/></xsl:with-param>
				</xsl:apply-templates>
				
			</com.misys.portal.interfaces.incoming.LargeParameterKey>
		</com.misys.portal.interfaces.incoming.AssignedReferences>
	</xsl:template>
	
	<xsl:template match="reference">
		<xsl:param name="param_id_ref"/>
		
		<com.misys.portal.interfaces.incoming.LargeParameterData>
			<param_id><xsl:value-of select="$param_id_ref"/></param_id>
			<data_1><xsl:value-of select="."/></data_1>
			<data_2>N</data_2>
			<data_3></data_3>
			<data_4></data_4>
			<data_5></data_5>
			<data_6></data_6>
			<data_7></data_7>
			<data_8></data_8>
			<data_9></data_9>
			<data_10></data_10>
			<data_11></data_11>
			<data_12></data_12>
			<data_13></data_13>
			<data_14></data_14>
			<data_15></data_15>
			<data_16></data_16>
			<data_17></data_17>
			<data_18></data_18>
			<data_19></data_19>
			<data_20></data_20>
		</com.misys.portal.interfaces.incoming.LargeParameterData>
	</xsl:template>
</xsl:stylesheet>
