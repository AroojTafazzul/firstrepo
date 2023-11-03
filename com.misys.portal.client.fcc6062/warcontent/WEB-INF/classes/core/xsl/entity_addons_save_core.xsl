<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->   
   <xsl:template match="entity">
   		
   	  	<xsl:call-template name="products">
   	  		<xsl:with-param name="company_id"><xsl:value-of select="company_id"/></xsl:with-param>
   	  		<xsl:with-param name="company_abbv_name"><xsl:value-of select="company_abbv_name"/></xsl:with-param>
   	  		<xsl:with-param name="abbv_name"><xsl:value-of select="abbv_name"/></xsl:with-param>   	  	
   	  	</xsl:call-template>
   	  	
   	  	<xsl:call-template name="references">
   	  		<xsl:with-param name="company_id"><xsl:value-of select="company_id"/></xsl:with-param>
   	  		<xsl:with-param name="company_abbv_name"><xsl:value-of select="company_abbv_name"/></xsl:with-param>
   	  		<xsl:with-param name="abbv_name"><xsl:value-of select="abbv_name"/></xsl:with-param>   	  	
   	  	</xsl:call-template>
   	  	
   </xsl:template>
   
   <!-- Process ENTITY-PRODUCTS -->
   
   <xsl:template name="products">
		<xsl:param name="company_id"/>
		<xsl:param name="company_abbv_name"/>
		<xsl:param name="abbv_name"/>
		
      <parameter_data>
			<parm_id>P106</parm_id>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<key_1><xsl:value-of select="$company_abbv_name"/></key_1>
  			<key_2><xsl:value-of select="$abbv_name"/></key_2>
			<xsl:for-each select="//*[starts-with(name(), 'product_')]">
				<xsl:variable name="product_code">
					<xsl:value-of select="substring-after(name(), 'product_')"/>
				</xsl:variable>
				<xsl:if test=".='Y'">
         		<data_1><xsl:value-of select="$product_code"/></data_1>
   			</xsl:if>
  			</xsl:for-each>
  		</parameter_data>
  		
   </xsl:template>
 
   <!-- Process ENTITY-REFERENCES -->
   
   <xsl:template name="references">
		<xsl:param name="company_id"/>
		<xsl:param name="company_abbv_name"/>
		<xsl:param name="abbv_name"/>
		
      <parameter_data>
			<parm_id>P107</parm_id>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<key_1><xsl:value-of select="$company_abbv_name"/></key_1>
  			<key_2><xsl:value-of select="$abbv_name"/></key_2>
			<xsl:for-each select="entity_list">
				<data_1><xsl:value-of select="."/></data_1>
			</xsl:for-each>
  		</parameter_data>
  		
   </xsl:template>
  
</xsl:stylesheet>

