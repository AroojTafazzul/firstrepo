<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:misys="http://www.misys.com" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" version="1.0" exclude-result-prefixes="localization tools">
<xsl:import href="../../../../core/xsl/fo/fo_common.xsl"/>
<xsl:import href="../../../../core/xsl/fo/fo_summary.xsl"/>
<xsl:variable name="isdynamiclogo">
<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
</xsl:variable>
<xsl:param name="fop1.extensions" select="1"/>
<xsl:param name="base_url"/>
<xsl:param name="systemDate"/>
<xsl:param name="rundata"/>
<xsl:param name="language"/>
<xsl:template match="/">
<fo:root>
<xsl:attribute name="font-family">
<xsl:value-of select="$pdfFont"/>
</xsl:attribute>
<xsl:attribute name="writing-mode">
<xsl:value-of select="$writingMode"/>
</xsl:attribute>
<xsl:call-template name="general-layout-master"/>
<fo:bookmark-tree>
<xsl:apply-templates select="tu_tnx_record/narrative_xml/Document" mode="toc">
<xsl:with-param name="path" select="/Document"/>
</xsl:apply-templates>
</fo:bookmark-tree>
<fo:page-sequence initial-page-number="1" master-reference="Section1-ps">
<fo:static-content text-align="center" flow-name="xsl-region-start">
<fo:block font-size="8pt" text-align="center" color="#FFFFFF" font-weight="bold">
<xsl:attribute name="font-family">
<xsl:value-of select="$pdfFont"/>
</xsl:attribute>
							
							TMA Message
						</fo:block>
</fo:static-content>
<fo:static-content flow-name="xsl-region-before">
<xsl:apply-templates select="tu_tnx_record" mode="header_issuing_bank">
<xsl:with-param name="bankNode" select="tu_tnx_record/issuing_bank"/>
<xsl:with-param name="productCode" select="tu_tnx_record/product_code"/>
<xsl:with-param name="subProductCode" select="tu_tnx_record/sub_product_code"/>
</xsl:apply-templates>
</fo:static-content>
<fo:flow xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" font-size="9.0pt" font-family="Helvetica" flow-name="xsl-region-body">
<xsl:apply-templates select="tu_tnx_record/narrative_xml/Document">
<xsl:with-param name="path" select="/Document"/>
</xsl:apply-templates>
</fo:flow>
</fo:page-sequence>
</fo:root>
</xsl:template>
<xsl:template match="tu_tnx_record" mode="header_issuing_bank">
<xsl:param name="bankNode"/>
<xsl:param name="productCode"/>
<xsl:param name="subProductCode"/>
<xsl:for-each select="$bankNode">
<fo:block>
<xsl:attribute name="font-family">
<xsl:value-of select="$pdfFont"/>
</xsl:attribute>
<xsl:attribute name="color">
<xsl:value-of select="$backgroundSubtitles3"/>
</xsl:attribute>
<fo:table background-position-vertical="top" table-layout="fixed">
<xsl:attribute name="background-position-horizontal">
<xsl:value-of select="$horizontalAlign"/>
</xsl:attribute>
<xsl:attribute name="background-color">
<xsl:value-of select="$borderColor"/>
</xsl:attribute>
<xsl:attribute name="background-image">url('<xsl:value-of select="$base_url"/>/fo_icons/header.jpg')</xsl:attribute>
<fo:table-column column-width="proportional-column-width(1)"/>
<xsl:if test="name[. != '']">
<fo:table-column column-width="proportional-column-width(1)"/>
<xsl:if test="phone[. != ''] or  fax[. != ''] or telex[. != ''] or  iso_code[. != '']">
<fo:table-column column-width="proportional-column-width(1)"/>
</xsl:if>
</xsl:if>
<fo:table-column column-width="proportional-column-width(1)"/>
<fo:table-body>
<fo:table-row>
<fo:table-cell>
<xsl:call-template name="bank_logo">
<xsl:with-param name="bankName" select="abbv_name" />
</xsl:call-template>
</fo:table-cell>
<xsl:if test="name[.!='']">
<fo:table-cell font-size="8.0pt">
<fo:block/>
</fo:table-cell>
</xsl:if>
<xsl:if test="$productCode != '' and $subProductCode = ''">
<fo:table-cell>
<xsl:attribute name="border-left">1px solid <xsl:value-of select="$backgroundSubtitles"/>
</xsl:attribute>
<xsl:attribute name="font-size">
<xsl:value-of select="number(substring-before($pdfFontSize,'pt'))+2"/>pt</xsl:attribute>
<fo:block font-weight="bold" text-align="center">
<xsl:attribute name="end-indent">
<xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
<xsl:value-of select="localization:getDecode($language, 'N001', $productCode)"/>
</fo:block>
</fo:table-cell>
</xsl:if>
<xsl:if test="$subProductCode != ''">
<fo:table-cell>
<xsl:attribute name="border-left">1px solid <xsl:value-of select="$backgroundSubtitles"/>
</xsl:attribute>
<xsl:attribute name="font-size">
<xsl:value-of select="number(substring-before($pdfFontSize,'pt'))+2"/>pt</xsl:attribute>
<fo:block font-weight="bold" text-align="center">
<xsl:attribute name="end-indent">
<xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
<xsl:value-of select="localization:getDecode($language, 'N047', $subProductCode)"/>
</fo:block>
</fo:table-cell>
</xsl:if>
</fo:table-row>
</fo:table-body>
</fo:table>
</fo:block>
</xsl:for-each>
</xsl:template>
<xsl:template name="repeat">
<xsl:param name="output"/>
<xsl:param name="count"/>
<xsl:if test="$count &gt; 1">
<xsl:value-of select="$output"/>
<xsl:call-template name="repeat">
<xsl:with-param name="output" select="$output"/>
<xsl:with-param name="count" select="$count - 1"/>
</xsl:call-template>
</xsl:if>
</xsl:template>
<xsl:template match="Document">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Document"/>
</xsl:variable>
<xsl:apply-templates select="BaselnMtchRpt">
<xsl:with-param name="path">g
                  </xsl:with-param>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/BaselnMtchRpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BaselnMtchRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BaselnMtchRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="RptId">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BaselnEstblishmtTrils">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CmpardDocRef">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Rpt">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnMtchRpt/RptId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_RptId_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_RptId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/RptId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/RptId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="tools:convertISODateTime2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_TxId_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_TxId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/TxId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TxId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_EstblishdBaselnId_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_EstblishdBaselnId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification3_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification3_Vrsn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/TxSts">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxSts) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_TxSts_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_TxSts_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/TxSts')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TxSts/Sts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:choose>
<xsl:when test=". = 'PROP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_PROP')"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_CLSD')"/>
</xsl:when>
<xsl:when test=". = 'PMTC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_PMTC')"/>
</xsl:when>
<xsl:when test=". = 'ESTD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_ESTD')"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_ACTV')"/>
</xsl:when>
<xsl:when test=". = 'COMP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_COMP')"/>
</xsl:when>
<xsl:when test=". = 'AMRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_AMRQ')"/>
</xsl:when>
<xsl:when test=". = 'RARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_RARQ')"/>
</xsl:when>
<xsl:when test=". = 'CLRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_CLRQ')"/>
</xsl:when>
<xsl:when test=". = 'SCRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_SCRQ')"/>
</xsl:when>
<xsl:when test=". = 'SERQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_SERQ')"/>
</xsl:when>
<xsl:when test=". = 'DARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_code_DARQ')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_UsrTxRef_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_UsrTxRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdIssr">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="UsrTxRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification5_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IdIssr) &lt; 1 and count(../preceding-sibling::UsrTxRef) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_DocumentIdentification5_UsrTxRef_IdIssr_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_DocumentIdentification5_IdIssr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/IdIssr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="IdIssr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_Buyr_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_Buyr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Buyr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Buyr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Buyr_PrtryId_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PrtryId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Buyr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Buyr_PstlAdr_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PstlAdr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_StrtNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_PstCdId_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_TwnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_Sellr_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_Sellr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Sellr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Sellr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Sellr) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Sellr_PrtryId_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PrtryId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Sellr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Sellr) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Sellr_PstlAdr_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PstlAdr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnMtchRpt/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_BuyrBk_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BuyrBk_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/BuyrBk')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_SellrBk_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_SellrBk_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SellrBk')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/BaselnEstblishmtTrils">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BaselnEstblishmtTrils"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BaselnEstblishmtTrils) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_BaselnEstblishmtTrils_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnEstblishmtTrils_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Cur">
<xsl:with-param name="path" select="concat($path,'/BaselnEstblishmtTrils')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Lmt">
<xsl:with-param name="path" select="concat($path,'/BaselnEstblishmtTrils')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnEstblishmtTrils/Cur">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Cur"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_Limit1_Cur_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnEstblishmtTrils/Lmt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lmt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_Limit1_Lmt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/CmpardDocRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CmpardDocRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CmpardDocRef) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_CmpardDocRef_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_CmpardDocRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DocIndx">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CmpardDocRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification4_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CmpardDocRef/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification4_Vrsn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CmpardDocRef/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::CmpardDocRef) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_DocumentIdentification4_CmpardDocRef_Submitr_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_DocumentIdentification4_Submitr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CmpardDocRef/DocIndx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DocIndx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification4_DocIndx_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/Rpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Rpt) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_Rpt_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_Rpt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="NbOfMisMtchs">
<xsl:with-param name="path" select="concat($path,'/Rpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MisMtchInf">
<xsl:with-param name="path" select="concat($path,'/Rpt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Rpt/NbOfMisMtchs">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NbOfMisMtchs"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_MisMatchReport3_NbOfMisMtchs_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Rpt/MisMtchInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MisMtchInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MisMtchInf) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_MisMatchReport3_Rpt_MisMtchInf_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_MisMatchReport3_MisMtchInf_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="SeqNb">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RuleId">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RuleDesc">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MisMtchdElmt">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MisMtchInf/SeqNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SeqNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ValidationResult5_SeqNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="MisMtchInf/RuleId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RuleId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ValidationResult5_RuleId_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="MisMtchInf/RuleDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RuleDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ValidationResult5_RuleDesc_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="MisMtchInf/MisMtchdElmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MisMtchdElmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MisMtchdElmt) &lt; 1 and count(../preceding-sibling::MisMtchInf) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_ValidationResult5_MisMtchInf_MisMtchdElmt_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_ValidationResult5_MisMtchdElmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DocIndx">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ElmtPth">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ElmtNm">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ElmtVal">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MisMtchdElmt/DocIndx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DocIndx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_DocIndx_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="MisMtchdElmt/ElmtPth">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ElmtPth"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_ElmtPth_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="MisMtchdElmt/ElmtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ElmtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_ElmtNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="MisMtchdElmt/ElmtVal">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ElmtVal"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_ElmtVal_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnMtchRpt/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_ReqForActn_name"/>
</xsl:if>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="subtitle">
<xsl:with-param name="text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_ReqForActn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ReqForActn/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:choose>
<xsl:when test=". = 'SBTW'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_SBTW')"/>
</xsl:when>
<xsl:when test=". = 'RSTW'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_RSTW')"/>
</xsl:when>
<xsl:when test=". = 'RSBS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_RSBS')"/>
</xsl:when>
<xsl:when test=". = 'ARDM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_ARDM')"/>
</xsl:when>
<xsl:when test=". = 'ARCS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_ARCS')"/>
</xsl:when>
<xsl:when test=". = 'ARES'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_ARES')"/>
</xsl:when>
<xsl:when test=". = 'WAIT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_WAIT')"/>
</xsl:when>
<xsl:when test=". = 'UPDT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_UPDT')"/>
</xsl:when>
<xsl:when test=". = 'SBDS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_SBDS')"/>
</xsl:when>
<xsl:when test=". = 'ARBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_ARBA')"/>
</xsl:when>
<xsl:when test=". = 'ARRO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_ARRO')"/>
</xsl:when>
<xsl:when test=". = 'CINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_code_CINR')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ReqForActn/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PendingActivity2_Desc_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
<xsl:call-template name="repeat">
<xsl:with-param name="output">    </xsl:with-param>
<xsl:with-param name="count">
<xsl:value-of select="count(ancestor::*)-2"/>
</xsl:with-param>
</xsl:call-template>
<xsl:value-of select="localization:getGTPString($language, $label)"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Document" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Document"/>
</xsl:variable>
<xsl:apply-templates select="BaselnMtchRpt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/BaselnMtchRpt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BaselnMtchRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BaselnMtchRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="RptId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BaselnEstblishmtTrils" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CmpardDocRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Rpt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnMtchRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnMtchRpt/RptId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_RptId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_RptId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="RptId/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/TxId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_TxId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_TxId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TxId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TxId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/EstblishdBaselnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_EstblishdBaselnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_EstblishdBaselnId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification3_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Vrsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification3_Vrsn_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/TxSts" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxSts) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_TxSts_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_TxSts_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Sts" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TxSts')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TxSts/Sts" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_TransactionStatus4_Sts_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/UsrTxRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_UsrTxRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_UsrTxRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdIssr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="UsrTxRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification5_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IdIssr) &lt; 1 and count(../preceding-sibling::UsrTxRef) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_DocumentIdentification5_UsrTxRef_IdIssr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_DocumentIdentification5_IdIssr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/IdIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="IdIssr/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/Buyr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_Buyr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_Buyr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Buyr/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Buyr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PrtryId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PrtryId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_GenericIdentification4_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="PrtryId/IdTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_GenericIdentification4_IdTp_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Buyr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PstlAdr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="StrtNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_StrtNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_PstCdId_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_TwnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PostalAddress5_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/Sellr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_Sellr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_Sellr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Sellr/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Sellr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Sellr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Sellr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PrtryId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Sellr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Sellr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_PartyIdentification26_Sellr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_PartyIdentification26_PstlAdr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="StrtNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnMtchRpt/BuyrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_BuyrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BuyrBk_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrBk/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/SellrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_SellrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_SellrBk_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrBk/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/BaselnEstblishmtTrils" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BaselnEstblishmtTrils"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BaselnEstblishmtTrils) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_BaselnEstblishmtTrils_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnEstblishmtTrils_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Cur" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnEstblishmtTrils')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Lmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnEstblishmtTrils')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnEstblishmtTrils/Cur" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Cur"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_Limit1_Cur_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnEstblishmtTrils/Lmt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lmt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_Limit1_Lmt_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/CmpardDocRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CmpardDocRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CmpardDocRef) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_CmpardDocRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_CmpardDocRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DocIndx" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CmpardDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CmpardDocRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification4_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="CmpardDocRef/Vrsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification4_Vrsn_name</xsl:variable>
</xsl:template>
<xsl:template match="CmpardDocRef/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::CmpardDocRef) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_DocumentIdentification4_CmpardDocRef_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_DocumentIdentification4_Submitr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Submitr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Submitr/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="CmpardDocRef/DocIndx" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DocIndx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_DocumentIdentification4_DocIndx_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/Rpt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Rpt) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_Rpt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_Rpt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="NbOfMisMtchs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Rpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MisMtchInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Rpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Rpt/NbOfMisMtchs" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NbOfMisMtchs"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_MisMatchReport3_NbOfMisMtchs_name</xsl:variable>
</xsl:template>
<xsl:template match="Rpt/MisMtchInf" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MisMtchInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MisMtchInf) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_MisMatchReport3_Rpt_MisMtchInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_MisMatchReport3_MisMtchInf_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="SeqNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RuleId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RuleDesc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MisMtchdElmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MisMtchInf/SeqNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SeqNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ValidationResult5_SeqNb_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchInf/RuleId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RuleId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ValidationResult5_RuleId_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchInf/RuleDesc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RuleDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ValidationResult5_RuleDesc_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchInf/MisMtchdElmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MisMtchdElmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MisMtchdElmt) &lt; 1 and count(../preceding-sibling::MisMtchInf) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_ValidationResult5_MisMtchInf_MisMtchdElmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_ValidationResult5_MisMtchdElmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DocIndx" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ElmtPth" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ElmtNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ElmtVal" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchdElmt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MisMtchdElmt/DocIndx" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DocIndx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_DocIndx_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchdElmt/ElmtPth" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ElmtPth"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_ElmtPth_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchdElmt/ElmtNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ElmtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_ElmtNm_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchdElmt/ElmtVal" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ElmtVal"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_ElementIdentification1_ElmtVal_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnMtchRpt/ReqForActn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::BaselnMtchRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_BaselnMtchRpt_ReqForActn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnMtchRpt_BaselineMatchReportV03_ReqForActn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ReqForActn/Tp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PendingActivity2_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="ReqForActn/Desc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnMtchRpt_PendingActivity2_Desc_name</xsl:variable>
</xsl:template>
</xsl:stylesheet>
