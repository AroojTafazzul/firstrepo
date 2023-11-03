<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
		
	<xsl:template match="/">
		<xsl:apply-templates select="in_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="in_tnx_record">
		
		<!--Define the nodeName -->
		<xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>

		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_template.js"></script>

		<p><br/></p>
		
		<table border="0" width="100%">
		<tr>
		<td align="center">
		
		<table border="0">
		<tr>
		<td align="left">

			<form name="fakeform1" onsubmit="return false;">
			
				<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
				<input type="hidden" name="product_code"><xsl:attribute name="value"><xsl:value-of select="product_code"/></xsl:attribute></input>
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="180"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="template_id"/></font>
							<input type="hidden" name="template_id"><xsl:attribute name="value"><xsl:value-of select="template_id"/></xsl:attribute></input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="180"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_DESCRIPTION')"/></td>
						<td>
							<input name="template_description" type="text" size="45" maxlength="200">
								<xsl:attribute name="value"><xsl:value-of select="template_description"/>	</xsl:attribute>
							</input>
						</td>
					</tr>
				</table>
			
			</form>
			
			<p><br/></p>
	
				<form name="realform" method="POST" action="/gtp/screen/InvoiceScreen">
					<input type="hidden" name="operation" value="SAVE_TEMPLATE"/>
					<input type="hidden" name="mode" value="DRAFT"/>
					<input type="hidden" name="tnxtype" value="01"/>
					<input type="hidden" name="TransactionData"/>
					<xsl:call-template name="hidden-field">
					   <xsl:with-param name="name">referenceid</xsl:with-param>
					   <xsl:with-param name="value" select="ref_id"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
					   <xsl:with-param name="name">tnxid</xsl:with-param>
					   <xsl:with-param name="value" select="tnx_id"/>
					</xsl:call-template>
				</form>
	
		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		</table>

		<center>	
		
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('save','<xsl:value-of select="$nodeName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_save.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_cancel.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('help','<xsl:value-of select="$nodeName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_help.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>
		
		</center>

	</xsl:template>
	
</xsl:stylesheet>
