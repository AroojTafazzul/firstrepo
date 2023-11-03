<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->   
   <xsl:template match="user_entity_record">
   	  	<xsl:call-template name ="entity_record">
   	  		<xsl:with-param name="company_id"><xsl:value-of select="static_user/company_id"/></xsl:with-param>
   	  		<xsl:with-param name="company_abbv_name"><xsl:value-of select="static_user/company_abbv_name"/></xsl:with-param>
   	  		<xsl:with-param name="login_id"><xsl:value-of select="static_user/login_id"/></xsl:with-param>   	  	
   	  	</xsl:call-template>
   </xsl:template>
   
   <!-- Process ENTITY -->
   <xsl:template name="entity_record">
   		<xsl:param name ="company_id"/>
   		<xsl:param name ="company_abbv_name"/>
   		<xsl:param name ="login_id"/>
   		<xsl:for-each select="entity_record">
      		<parameter_data>
         		<parm_id>
         			<xsl:choose>
         				<xsl:when test="./@preferred='Y'">P105</xsl:when>
         				<xsl:otherwise>P104</xsl:otherwise>
         			</xsl:choose>
         		</parm_id>
         		<company_id><xsl:value-of select="$company_id"/></company_id>
         		<key_1><xsl:value-of select="$company_abbv_name"/></key_1>
        			<key_2><xsl:value-of select="$login_id"/></key_2>
         		<data_1><xsl:value-of select="abbv_name"/></data_1>
      		</parameter_data>
     	</xsl:for-each>
   </xsl:template>
</xsl:stylesheet>

