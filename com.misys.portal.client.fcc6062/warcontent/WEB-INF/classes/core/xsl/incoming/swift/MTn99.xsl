<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2008 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT707 into lc_tnx_record. -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>	
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>    
   
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT799']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT799']">
      <lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
        <brch_code>00001</brch_code>
        <bo_ref_id><xsl:value-of select="TRN"/></bo_ref_id>
		<adv_send_mode>01</adv_send_mode>
		<tnx_type_code>15</tnx_type_code>
		<sub_tnx_type_code/>		
		<prod_stat_code>07</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>  
		<product_code>LC</product_code>			
       
        <xsl:apply-templates select="Narrative"/>      
      </lc_tnx_record>
    </xsl:template>
    
	<xsl:template match="Narrative">		
		<bo_comment><xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>
		</bo_comment>	
	</xsl:template>	
	    
</xsl:stylesheet>