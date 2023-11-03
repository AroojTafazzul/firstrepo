<?xml version="1.0" encoding="UTF-8"?>
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
   Copyright (c) 2000-2003 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

<xsl:import href="../../core/xsl/common/trade_common.xsl"/>
<xsl:import href="com_attachment.xsl"/>
<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="lc_tnx_record">

		<p><br/></p>
		
		<!-- Event Details -->

		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1" colspan="3">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DISCREPANT_DETAILS')"/>&nbsp;&nbsp;</b>
				</td>
			</tr>
		</table>
		<br/>
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<!-- Event Summary Header -->
			<xsl:if test="bo_release_dttm[.!='']">
   			<tr>
      			<td width="40">&nbsp;</td>
      			<td width="190"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_DATE')"/></td>
   				<td >
   					<font class="REPORTDATA"><xsl:value-of select="converttools:formatDttmToDate(bo_release_dttm,$language)"/></font>
      			</td>
      		</tr>
   		</xsl:if>
		<xsl:if test="imp_bill_ref_id[.!='']">
			<tr>
				<td width="40">&nbsp;</td>
         		<td width="190"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_IMP_BILL_REF_ID')"/></td>
          		<td>
            		<font class="REPORTDATA"><xsl:value-of select="imp_bill_ref_id"/></font>
          		</td>
        	</tr>
      	</xsl:if>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="190"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')"/></td>
				<td><font class="REPORTDATA"><xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/></font></td>
			</tr>
			<xsl:if test="doc_ref_no[.!='']">
   			<tr>
   				<td width="40">&nbsp;</td>
   				<td width="190"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOC_REF_NO')"/></td>
   				<td><font class="REPORTDATA"><xsl:value-of select="doc_ref_no"/></font></td>
   			</tr>
			</xsl:if>
			<xsl:if test="maturity_date[.!='']">
   			<tr>
   				<td width="40">&nbsp;</td>
   				<td width="190"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')"/></td>
   				<td><font class="REPORTDATA"><xsl:value-of select="maturity_date"/></font></td>
   			</tr>
			</xsl:if>
		</table>
			
		<table border="0" width="570" cellpadding="0" cellspacing="0">	
   		<!-- Back-Office comment -->
   		<xsl:if test="bo_comment[.!='']">
   			<tr><td colspan="3">&nbsp;</td></tr>
   			<tr>
   				<td width="40">&nbsp;</td>
   				<td align="left" colspan="2"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT_BANK')"/></b></td>
   			</tr>
   			<tr>
   				<td width="40">&nbsp;</td>
   				<td colspan="2">
   					<font class="REPORTNORMAL">
   						<xsl:call-template name="string_replace">
   							<xsl:with-param name="input_text" select="bo_comment"/>
   						</xsl:call-template>
   					</font>
   				</td>
   			</tr>
   		</xsl:if>
		</table>
		<!-- Attachments -->
		<xsl:if test="attachments/attachment[type = '02']">
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OPTIONAL_FILE_UPLOAD')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			<br/>
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<th width="18">&nbsp;</th>
					<th class="FORMH2" align="center" width="275"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/></th>
					<th width="2">&nbsp;</th>
					<th class="FORMH2" align="center" width="275"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/></th>
				</tr>
				<xsl:apply-templates select="attachments/attachment[type = '02']" mode="bank"/>
			</table>
			<br/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
