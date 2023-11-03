<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
   <xsl:template match="system_parameters">
      <xsl:apply-templates/>
   </xsl:template>

   <!-- Process System Parameters -->
   
	<xsl:template match="system_parameters">
	   	<parameter_data>
	         <parm_id>P120</parm_id>
	         <company_id>*</company_id>
	         <!-- data_1><xsl:value-of select="nb_record_per_list"/></data_1>
	         <data_2><xsl:value-of select="password_forbidden_characters"/></data_2>
	         <data_3><xsl:value-of select="password_expiry"/></data_3>
	         <data_4><xsl:value-of select="password_inactivity"/></data_4>
	         <data_5><xsl:value-of select="password_login_failures"/></data_5-->
	      </parameter_data>
   	</xsl:template>
   
</xsl:stylesheet>

