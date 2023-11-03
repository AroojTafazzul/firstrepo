<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) beneficiary notification
 
Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      26/10/2012
author:    Mauricio Moura da Silva
email:     mauricio.mouradasilva@misys.com
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:jetspeedresources="xalan://com.misys.portal.core.util.JetspeedResources"
        xmlns:java="http://xml.apache.org/xalan/java"        
        exclude-result-prefixes="localization jetspeedresources java">
       
	<xsl:param name="language">en</xsl:param>

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

	<xsl:template match="/">
		<xsl:apply-templates select="ft_tnx_record"/>
	</xsl:template>
	
	<xsl:template match="ft_tnx_record">
		<!-- prepare an array with the body parameters -->
		<xsl:variable name="arrayList1" select="java:java.util.ArrayList.new()" />
		<xsl:variable name="void" select="java:add($arrayList1, concat('', ft_cur_code))"/>
		<xsl:variable name="void" select="java:add($arrayList1, concat('', ft_amt))"/>
		<xsl:variable name="void" select="java:add($arrayList1, concat('', applicant_name))"/>
		<xsl:variable name="void" select="java:add($arrayList1, concat('', applicant_act_no))"/>
		<xsl:variable name="void" select="java:add($arrayList1, concat('', counterparties/counterparty/counterparty_name))"/>
		<xsl:variable name="void" select="java:add($arrayList1, concat('', counterparties/counterparty/counterparty_act_no))"/>
		<xsl:variable name="void" select="java:add($arrayList1, concat('', ref_id))"/>
		<xsl:variable name="args1" select="java:toArray($arrayList1)"/>
		<beneficiary_notification_record>
			<message_from_address><xsl:value-of select="jetspeedresources:getString('alert.email.from.address', 'portal@misys.com')" /></message_from_address>
			<message_from_personal><xsl:value-of select="jetspeedresources:getString('alert.email.from.personal', 'Misys Portal')" /></message_from_personal>
			<message_reply_to></message_reply_to>
			<message_cc></message_cc>
			<message_bcc></message_bcc>
			<message_to><xsl:value-of select="additional_field[@name='notify_beneficiary_email']" /></message_to>
			<message_subject><xsl:value-of select="localization:getGTPString($language, 'FT_BENEFICIARY_NOTIFICATION_TITLE')" /></message_subject>
			<message_body><xsl:value-of select="localization:getFormattedString($language, 'FT_BENEFICIARY_NOTIFICATION_BODY', $args1)" /></message_body>
		</beneficiary_notification_record>  
	</xsl:template>
</xsl:stylesheet>