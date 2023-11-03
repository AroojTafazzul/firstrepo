<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.neomalogic.gtp.common.localization.Localization"
		exclude-result-prefixes="localization">

<!--
   Copyright (c) 2000-2002 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:output method="html" indent="yes" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	
	<xsl:template match="/">
		<xsl:apply-templates select="static_account"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="static_account">
		
		<!-- Store the account type -->
		<xsl:variable name="type">
			<xsl:value-of select="type"/>
		</xsl:variable>

		<p><br/></p>

		<table border="0" width="100%">
		<tr>
		<td align="center">
		
		<table border="0">
		<tr>
		<td align="left">
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<xsl:if test="company_name[. !='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NAME')"/></td>
					<td><font class="REPORTBLUE"><xsl:value-of select="company_name"/></font></td>
				</tr>
				</xsl:if>
				<xsl:if test="entity[. !='']">
				<tr>
					<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ENTITY')"/></td>
					<td><font class="REPORTBLUE"><xsl:value-of select="entity"/></font></td>
				</tr>
				</xsl:if>
				<xsl:if test="$type !=''">
				<tr>
					<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="localization:getDecode($language, 'N063', $type)"/></font></td>
				</tr>				
				</xsl:if>		
				<xsl:if test="counterparty_name[. !='']">
				<tr>
					<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_COUNTERPARTY')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="counterparty_name"/></font></td>
				</tr>
				</xsl:if>
				<tr>
					<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_NO')"/></td>
					<td><font class="REPORTDATA">
						<xsl:value-of select="account_no"/>
					</font></td>
				</tr>
				<xsl:if test="description[. !='']">
				<tr>
					<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_DESCRIPTION')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="description"/></font></td>
				</tr>
				</xsl:if>
				<xsl:if test="cur_code[. !='']">
				<tr>
					<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="cur_code"/></font></td>
				</tr>
				</xsl:if>
			</table>
	
			<p/>
			<!--Un-comment this to display the address, dom...-->
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_ADDRESS')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="address_line_1"/></font></td>
				</tr>
				<xsl:if test="address_line_2[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">&nbsp;</td>
						<td><font class="REPORTDATA"><xsl:value-of select="address_line_2"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="dom[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">&nbsp;</td>
						<td><font class="REPORTDATA"><xsl:value-of select="dom"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="country[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_COUNTRY')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="country"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="bank_name[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_BANK_NAME')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="bank_name"/></font></td>
					</tr>					
				</xsl:if>
				<xsl:if test="iso_code[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_ISO_CODE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="iso_code"/></font></td>
					</tr>					
				</xsl:if>				
			</table>

			<p><br/></p>
		<form name="fakeform1" onsubmit="return false;">
			<input type="hidden" name="address_line_1">
				<xsl:attribute name="value">
					<xsl:value-of select="address_line_1"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="address_line_2">
				<xsl:attribute name="value">
					<xsl:value-of select="address_line_2"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="dom">
				<xsl:attribute name="value">
					<xsl:value-of select="dom"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="country">
				<xsl:attribute name="value">
					<xsl:value-of select="country"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="bank_name">
				<xsl:attribute name="value">
					<xsl:value-of select="bank_name"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="iso_code">
				<xsl:attribute name="value">
					<xsl:value-of select="iso_code"/>
				</xsl:attribute>
			</input>
		</form>
			
			
		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		</table>

	</xsl:template>
	
</xsl:stylesheet>
