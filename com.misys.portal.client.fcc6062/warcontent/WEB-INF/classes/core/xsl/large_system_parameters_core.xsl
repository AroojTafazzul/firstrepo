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
			<parm_id>P121</parm_id>
			<company_id>*</company_id>
			<!-- Sample -->
			<!-- xsl:for-each select="//*[starts-with(name(), 'forbiddenwords_details_word_')]">
				<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'forbiddenwords_details_position_')"/>
				</xsl:variable>
				<xsl:variable name="word">
					<xsl:value-of select="//*[starts-with(name(),concat('forbiddenwords_details_word_', $position))]"/>
				</xsl:variable>
         		<data_1><xsl:value-of select="$word"/></data_1>
  			</xsl:for-each-->
  		</parameter_data>
   	</xsl:template>
   
</xsl:stylesheet>

