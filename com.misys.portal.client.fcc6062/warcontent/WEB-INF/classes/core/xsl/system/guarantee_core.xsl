<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2008 Misys (http://www.misys.com),
   All Rights Reserved.
   
   Guarantee type save stylesheet.
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Guarantee -->
	<xsl:template match="guarantee">
		<parameter_data>
			<brch_code>00001</brch_code>
			<!-- <company_id><xsl:value-of select="user_company_id"/></company_id> -->
			<parm_id>P226</parm_id>
			<key_1><xsl:value-of select="name_"/></key_1>
			<data_1><xsl:value-of select="bg_type_code"/></data_1>
			<data_2><xsl:value-of select="description"/></data_2>
			<data_3><xsl:value-of select="activated"/></data_3>
			<data_4><xsl:value-of select="standard"/></data_4>
			<!-- Domestic Guarantee -->
			<data_5><xsl:value-of select="form_mask"/></data_5>
			<data_6><xsl:value-of select="text_type_code"/></data_6>
			<data_7><xsl:value-of select="bg_document"/></data_7>
			<!-- Static specimen  -->
			<data_8><xsl:value-of select="specimen_name"/></data_8>
			<data_9><xsl:value-of select="document_id"/></data_9>
			<!-- <data_5><xsl:value-of select="form_mask"/></data_5>-->
			<!-- <data_6><xsl:value-of select="legal_form"/></data_6>  -->
			<!-- <data_7><xsl:value-of select="date_type"/></data_7>  -->
			<!-- <data_8>Y</data_8>
			<data_9>SP</data_9>-->
            <!-- <data_13><xsl:value-of select="text_type_code"/></data_13>
			<data_14><xsl:value-of select="type_code_imex"/></data_14>
			<data_15><xsl:value-of select="marche"/></data_15>
			<data_16><xsl:value-of select="bg_type"/></data_16>
			<data_17><xsl:value-of select="bg_sub_type"/></data_17>
			<data_18><xsl:value-of select="party"/></data_18>-->
			<!-- For BG requirement FDST006 V1.9 -->			
			<data_11><xsl:value-of select="auto_specimen_name"/></data_11>
			<!-- For Undertaking issued sub product code -->
			<data_12><xsl:value-of select="sub_product_code"/></data_12>
			
		</parameter_data>
	</xsl:template>
	
	<xsl:template match="standbyLC">
	  <parameter_data>
	   <brch_code>00001</brch_code>
	   <!-- <company_id><xsl:value-of select="user_company_id"/></company_id> -->
	   <parm_id>P799</parm_id>
	   <key_1><xsl:value-of select="name_"/></key_1>
	   <data_1><xsl:value-of select="si_type_code"/></data_1>
	   <data_2><xsl:value-of select="description"/></data_2>
	   <data_3><xsl:value-of select="activated"/></data_3>
	   <data_4><xsl:value-of select="standard"/></data_4>
	   <data_6><xsl:value-of select="text_type_code"/></data_6>
	   <data_7><xsl:value-of select="si_document"/></data_7>
	   <!-- Static specimen  -->
	   <data_8><xsl:value-of select="specimen_name"/></data_8>
	   <data_9><xsl:value-of select="document_id"/></data_9>  
	   <data_11><xsl:value-of select="auto_specimen_name"/></data_11>  
	   
	  </parameter_data>
	 </xsl:template>
</xsl:stylesheet>
