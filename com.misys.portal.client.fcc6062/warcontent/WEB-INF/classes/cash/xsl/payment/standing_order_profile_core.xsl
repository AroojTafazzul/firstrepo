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
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    xmlns:technicalResource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
    exclude-result-prefixes="default converttools jetSpeed utils technicalResource">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <!-- Get the interface environment -->
    <xsl:param name="context"/>
    <xsl:param name="language">en</xsl:param>
         
    <!-- Match template -->
    <xsl:template match="/">
        <xsl:apply-templates select="ft_tnx_record"/>
    </xsl:template>

    <xsl:template match="ft_tnx_record">
      <xsl:call-template name="standing-order-request"></xsl:call-template>
    </xsl:template>
    
    
     <xsl:template name="standing-order-request">
     <so_profile_record>
     <initiatingParty>
    	 <xsl:value-of select="issuing_bank/name" />
     </initiatingParty>
     
     <name>
     <xsl:value-of select="utils:generateSequenceNo()" />
     </name>
     
     <paymentType>ORDER</paymentType>
     
     <primaryTemplate>CREDIT-TEMPLATE</primaryTemplate>
     
     <xsl:call-template name="range-of-recurrence"></xsl:call-template>
     
     <frequency>
          <xsl:if test = "additional_field[@name='recurring_frequency']">
	     		<xsl:value-of select="additional_field[@name='recurring_frequency']" />
	    </xsl:if>
     </frequency>
     <xsl:call-template name="frequency-execution"></xsl:call-template>
     <recurrenceFrequency>1</recurrenceFrequency>
     <timeRecurrence>12:00</timeRecurrence>
     <businessDayAdjustment>NEXT-BUSINESS-DATE</businessDayAdjustment>
     <startDate>
     <xsl:if test = "additional_field[@name='recurring_start_date']">
	     		<xsl:value-of select="additional_field[@name='recurring_start_date']" />
	 </xsl:if>
     </startDate>
     <templateId>
     	<xsl:if test = "additional_field[@name='templateId']">
	     		<xsl:value-of select="additional_field[@name='templateId']" />
	     	</xsl:if>
     </templateId>
     </so_profile_record>
     </xsl:template>
     
     <xsl:template name="range-of-recurrence">
      <rangeOfRecurrence>
     <endAfter>
     	<xsl:if test = "additional_field[@name='recurring_number_transfers']">
	     		<xsl:value-of select="additional_field[@name='recurring_number_transfers']" />
	    </xsl:if>
     </endAfter>
     <endBy></endBy>
     </rangeOfRecurrence>
     </xsl:template>
     
     
     <xsl:template name="frequency-execution">
      <frequencyExecution>
     <dayOfWeek></dayOfWeek>
     <dayOfMonth>
     <xsl:if test = "additional_field[@name='recurring_start_date']">
	     		<xsl:value-of select="substring(additional_field[@name='recurring_start_date']/text(), 1,2)" />
	 </xsl:if>
     </dayOfMonth>
     <month></month>
     </frequencyExecution>
     </xsl:template>
    
</xsl:stylesheet>
