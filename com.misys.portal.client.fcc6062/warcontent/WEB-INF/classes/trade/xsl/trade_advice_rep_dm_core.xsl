<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization converttools">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:include href="../../core/xsl/common/trade_common.xsl"/>

<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="endImage"><xsl:value-of select="$images_path"/>pic_end.gif</xsl:param>
	
	<xsl:template match="/">
		<!-- The following javascript is used for the advice generation handling -->
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>
		<xsl:apply-templates select="dm_tnx_record" mode="advice"/>
	</xsl:template>

	<!--TEMPLATE Main-->
	<xsl:template match="dm_tnx_record" mode="advice">

		<!--Document Selection-->
		
		<form name="documentsform">
			<xsl:choose>
				<!--Test if documents exist -->
				<xsl:when test="documents/document/document_id[.!='']">
					<table border="0" width="600" cellpadding="0" cellspacing="0">
						<tr>
							<!--Choose between DRAFT/PREVIEW and VIEWmode, based on the transaction status code-->
							<xsl:choose>
								<xsl:when test="tnx_id[.!=''] and tnx_stat_code[.!='03']">
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PREVIEW_DOCUMENT_LIST')"/></td>
								</xsl:when>
								<xsl:otherwise>
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_DOCUMENT_LIST')"/></td>
								</xsl:otherwise>
							</xsl:choose>
						</tr>
					</table>
					<!--All documents-->
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="40" align="center">&nbsp;</td>
						</tr>
						<xsl:apply-templates select="documents/document[document_id!='']" mode="advice_list"/>
					</table>
					<p><br/></p>

				</xsl:when>
				<xsl:otherwise>
					<table border="0" width="650" cellpadding="0" cellspacing="0">
						<tr>
							<td><xsl:value-of select="localization:getGTPString($language, 'XSL_EMPTY_DOCUMENT_LIST')"/></td>
						</tr>
					</table>
					<p><br/></p>
				</xsl:otherwise>
			</xsl:choose>
		</form>
			
	</xsl:template>

	<!--TEMPLATE Collection Document-->
	<xsl:template match="document" mode="advice_list">
		<tr>
			<td width="40" align="center">&nbsp;</td>
			<td>
				<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
				<font class="REPORTDATA">- <xsl:value-of select="cust_ref_id"/>&nbsp;(<xsl:value-of select="localization:getDecode($language, 'C064', $localization_key)"/>)
				</font>
			</td>
			<!-- Display the pdf generation icon-->
			<xsl:choose>
				<xsl:when test="transformation and (type[.='01'] or attachment_id[.!=''])">
					<td align="left">
						<select>
							<xsl:attribute name="name">option_<xsl:value-of select="document_id"/>_transformation</xsl:attribute>
			                  		<option>
			                  			<xsl:attribute name="name">N036_HTML</xsl:attribute>
			                  			<xsl:attribute name="value">N036_HTML</xsl:attribute>
			                  			<xsl:value-of select="localization:getDecode($language, 'N036', 'HTML')"/>
			                  		</option>
							<xsl:apply-templates select="transformation"/>
						</select>
					</td>
					<td align="left">
						<a name="anchor_preview" href="javascript:void(0)" target="_blank">
							<xsl:attribute name="onclick">var transformation = option_<xsl:value-of select="document_id"/>_transformation.options[option_<xsl:value-of select="document_id"/>_transformation.selectedIndex].value; if (transformation=='N036_HTML') fncViewDocument('<xsl:value-of select="ref_id"/>','<xsl:value-of select="document_id"/>'); else fncExportDocument(transformation,'<xsl:value-of select="document_id"/>','<xsl:value-of select="code"/>','<xsl:value-of select="format"/>','<xsl:value-of select="ref_id"/>');return false;</xsl:attribute>
							<img border="0" name="img_preview">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($endImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ADVICE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>
	
	<xsl:template match="transformation">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<!--xsl:attribute name="selected"/-->
			<xsl:variable name="localization_key"><xsl:value-of select="transformation_code"/></xsl:variable>
			<xsl:value-of select="localization:getDecode($language, 'N036', $localization_key)"/>
		</option>
	</xsl:template>
	
	
</xsl:stylesheet>
