<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Standard Payment Initiation PAIN.001 Core XSL file.

Copyright (c) 2019-2020 FINASTRA (http://www.finastra.com),
All Rights Reserved. 

version:   1.0
date:      26/06/2019
author:    Avilash Ghosh
##########################################################
-->

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
    xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" 
    xmlns:jetSpeed="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:technicalResource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
    exclude-result-prefixes="default converttools jetSpeed technicalResource">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <!-- Get the interface environment -->
    <xsl:param name="context"/>
    <xsl:param name="language">en</xsl:param>
             <xsl:include href="payment_common.xsl" />
    
    <!-- Match template -->
    <xsl:template match="/">
        <xsl:apply-templates select="ft_tnx_record"/>
    </xsl:template>

    <xsl:template match="ft_tnx_record">
    	<Document>    	
    		<InitiationContext>	
	    		<xsl:call-template name="initiation-context"></xsl:call-template>
    		</InitiationContext>
    		<CstmrCdtTrfInitn>
	    		<GrpHdr>
	    			<xsl:call-template name="group-Header"></xsl:call-template>
				</GrpHdr>
				<PmtInf>
					<xsl:call-template name="PmtInf"></xsl:call-template>
				</PmtInf>
	    	</CstmrCdtTrfInitn>
    	</Document>
    </xsl:template>
    
</xsl:stylesheet>
