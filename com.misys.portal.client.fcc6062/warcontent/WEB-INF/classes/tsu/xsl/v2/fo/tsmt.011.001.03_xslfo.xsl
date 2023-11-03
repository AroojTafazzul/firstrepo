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
<xsl:apply-templates select="BaselnRpt">
<xsl:with-param name="path">g
                  </xsl:with-param>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/BaselnRpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BaselnRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BaselnRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="RptId">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdMsgRef">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptTp">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdLineItm">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnRpt/RptId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RptId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RptId_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:template match="BaselnRpt/RltdMsgRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdMsgRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RltdMsgRef) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RltdMsgRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RltdMsgRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/RltdMsgRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/RltdMsgRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RltdMsgRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:template match="RltdMsgRef/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:template match="BaselnRpt/RptTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptTp"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptTp) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RptTp_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RptTp_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/RptTp')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptTp/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ReportType2_Tp_name</xsl:variable>
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
<xsl:when test=". = 'PREC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ReportType2_Tp_code_PREC')"/>
</xsl:when>
<xsl:when test=". = 'CURR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ReportType2_Tp_code_CURR')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnRpt/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_TxId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_TxId_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:template match="BaselnRpt/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_EstblishdBaselnId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_EstblishdBaselnId_name')"/>
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
<xsl:apply-templates select="AmdmntSeqNb">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_Vrsn_name</xsl:variable>
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
<xsl:template match="EstblishdBaselnId/AmdmntSeqNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AmdmntSeqNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_AmdmntSeqNb_name</xsl:variable>
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
<xsl:template match="BaselnRpt/TxSts">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxSts) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_TxSts_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_TxSts_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_TransactionStatus4_Sts_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_PROP')"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_CLSD')"/>
</xsl:when>
<xsl:when test=". = 'PMTC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_PMTC')"/>
</xsl:when>
<xsl:when test=". = 'ESTD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_ESTD')"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_ACTV')"/>
</xsl:when>
<xsl:when test=". = 'COMP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_COMP')"/>
</xsl:when>
<xsl:when test=". = 'AMRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_AMRQ')"/>
</xsl:when>
<xsl:when test=". = 'RARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_RARQ')"/>
</xsl:when>
<xsl:when test=". = 'CLRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_CLRQ')"/>
</xsl:when>
<xsl:when test=". = 'SCRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_SCRQ')"/>
</xsl:when>
<xsl:when test=". = 'SERQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_SERQ')"/>
</xsl:when>
<xsl:when test=". = 'DARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_DARQ')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnRpt/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_UsrTxRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification5_Id_name</xsl:variable>
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
<fo:block id="XSL_TSU_BaselnRpt_DocumentIdentification5_UsrTxRef_IdIssr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="BaselnRpt/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_Buyr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_Buyr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<fo:block id="XSL_TSU_BaselnRpt_PartyIdentification26_Buyr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<fo:block id="XSL_TSU_BaselnRpt_PartyIdentification26_Buyr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:template match="BaselnRpt/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_Sellr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_Sellr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<fo:block id="XSL_TSU_BaselnRpt_PartyIdentification26_Sellr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PrtryId_name')"/>
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
<fo:block id="XSL_TSU_BaselnRpt_PartyIdentification26_Sellr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="BaselnRpt/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_BuyrBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_BuyrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="BaselnRpt/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_SellrBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_SellrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="BaselnRpt/RptdLineItm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdLineItm"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptdLineItm) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RptdLineItm_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RptdLineItm_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="LineItmDtls">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptdLineItm/LineItmDtls">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmDtls"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItmDtls) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_LineItmDtls_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_LineItmDtls_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctNm">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctIdr">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctChrtcs">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctCtgy">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="QtyTlrnce">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PricTlrnce">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="LineItmDtls/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_LineItmId_name</xsl:variable>
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
<xsl:template match="LineItmDtls/PdctNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_PdctNm_name</xsl:variable>
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
<xsl:template match="LineItmDtls/PdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctIdr) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdctIdr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrdPdctIdr">
<xsl:with-param name="path" select="concat($path,'/PdctIdr[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrPdctIdr">
<xsl:with-param name="path" select="concat($path,'/PdctIdr[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PdctIdr/StrdPdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrdPdctIdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::StrdPdctIdr) &lt; 1 and count(../preceding-sibling::PdctIdr) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_ProductIdentifier2Choice_PdctIdr_StrdPdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2Choice_StrdPdctIdr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/StrdPdctIdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Idr">
<xsl:with-param name="path" select="concat($path,'/StrdPdctIdr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="StrdPdctIdr/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_name</xsl:variable>
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
<xsl:when test=". = 'BINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_BINR')"/>
</xsl:when>
<xsl:when test=". = 'COMD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_COMD')"/>
</xsl:when>
<xsl:when test=". = 'EANC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_EANC')"/>
</xsl:when>
<xsl:when test=". = 'HRTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_HRTR')"/>
</xsl:when>
<xsl:when test=". = 'MANI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_MANI')"/>
</xsl:when>
<xsl:when test=". = 'MODL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_MODL')"/>
</xsl:when>
<xsl:when test=". = 'PART'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_PART')"/>
</xsl:when>
<xsl:when test=". = 'QOTA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_QOTA')"/>
</xsl:when>
<xsl:when test=". = 'STYL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_STYL')"/>
</xsl:when>
<xsl:when test=". = 'SUPI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_SUPI')"/>
</xsl:when>
<xsl:when test=". = 'UPCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_UPCC')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StrdPdctIdr/Idr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Idr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductIdentifier2_Idr_name</xsl:variable>
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
<xsl:template match="PdctIdr/OthrPdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPdctIdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrPdctIdr) &lt; 1 and count(../preceding-sibling::PdctIdr) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_ProductIdentifier2Choice_PdctIdr_OthrPdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2Choice_OthrPdctIdr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/OthrPdctIdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/OthrPdctIdr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrPdctIdr/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:template match="OthrPdctIdr/IdTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:template match="LineItmDtls/PdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctChrtcs) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdctChrtcs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrdPdctChrtcs">
<xsl:with-param name="path" select="concat($path,'/PdctChrtcs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrPdctChrtcs">
<xsl:with-param name="path" select="concat($path,'/PdctChrtcs[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PdctChrtcs/StrdPdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrdPdctChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::StrdPdctChrtcs) &lt; 1 and count(../preceding-sibling::PdctChrtcs) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_ProductCharacteristics1Choice_PdctChrtcs_StrdPdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1Choice_StrdPdctChrtcs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/StrdPdctChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrtcs">
<xsl:with-param name="path" select="concat($path,'/StrdPdctChrtcs')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="StrdPdctChrtcs/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_name</xsl:variable>
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
<xsl:when test=". = 'BISP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_BISP')"/>
</xsl:when>
<xsl:when test=". = 'CHNR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_CHNR')"/>
</xsl:when>
<xsl:when test=". = 'CLOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_CLOR')"/>
</xsl:when>
<xsl:when test=". = 'EDSP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_EDSP')"/>
</xsl:when>
<xsl:when test=". = 'ENNR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_ENNR')"/>
</xsl:when>
<xsl:when test=". = 'OPTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_OPTN')"/>
</xsl:when>
<xsl:when test=". = 'ORCR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_ORCR')"/>
</xsl:when>
<xsl:when test=". = 'PCTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_PCTV')"/>
</xsl:when>
<xsl:when test=". = 'SISP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SISP')"/>
</xsl:when>
<xsl:when test=". = 'SIZE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SIZE')"/>
</xsl:when>
<xsl:when test=". = 'SZRG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SZRG')"/>
</xsl:when>
<xsl:when test=". = 'SPRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SPRM')"/>
</xsl:when>
<xsl:when test=". = 'STOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_STOR')"/>
</xsl:when>
<xsl:when test=". = 'VINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_VINR')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StrdPdctChrtcs/Chrtcs">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Chrtcs"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCharacteristics1_Chrtcs_name</xsl:variable>
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
<xsl:template match="PdctChrtcs/OthrPdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPdctChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrPdctChrtcs) &lt; 1 and count(../preceding-sibling::PdctChrtcs) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_ProductCharacteristics1Choice_PdctChrtcs_OthrPdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1Choice_OthrPdctChrtcs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/OthrPdctChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/OthrPdctChrtcs')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrPdctChrtcs/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:template match="OthrPdctChrtcs/IdTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:template match="LineItmDtls/PdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctCtgy"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctCtgy) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdctCtgy_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrdPdctCtgy">
<xsl:with-param name="path" select="concat($path,'/PdctCtgy[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrPdctCtgy">
<xsl:with-param name="path" select="concat($path,'/PdctCtgy[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PdctCtgy/StrdPdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrdPdctCtgy"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::StrdPdctCtgy) &lt; 1 and count(../preceding-sibling::PdctCtgy) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_ProductCategory1Choice_PdctCtgy_StrdPdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1Choice_StrdPdctCtgy_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/StrdPdctCtgy')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctgy">
<xsl:with-param name="path" select="concat($path,'/StrdPdctCtgy')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="StrdPdctCtgy/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCategory1_Tp_name</xsl:variable>
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
<xsl:when test=". = 'HRTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_HRTR')"/>
</xsl:when>
<xsl:when test=". = 'QOTA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_QOTA')"/>
</xsl:when>
<xsl:when test=". = 'PRGP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_PRGP')"/>
</xsl:when>
<xsl:when test=". = 'LOBU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_LOBU')"/>
</xsl:when>
<xsl:when test=". = 'GNDR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_GNDR')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StrdPdctCtgy/Ctgy">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctgy"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCategory1_Ctgy_name</xsl:variable>
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
<xsl:template match="PdctCtgy/OthrPdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPdctCtgy"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrPdctCtgy) &lt; 1 and count(../preceding-sibling::PdctCtgy) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_ProductCategory1Choice_PdctCtgy_OthrPdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1Choice_OthrPdctCtgy_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/OthrPdctCtgy')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/OthrPdctCtgy')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrPdctCtgy/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:template match="OthrPdctCtgy/IdTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:template match="LineItmDtls/OrdrdQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OrdrdQty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdQty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OrdrdQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
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
<xsl:template match="OrdrdQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
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
<xsl:template match="OrdrdQty/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:when test=". = 'KGM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OrdrdQty/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="LineItmDtls/AccptdQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_AccptdQty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_AccptdQty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="AccptdQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
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
<xsl:template match="AccptdQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
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
<xsl:template match="AccptdQty/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:when test=". = 'KGM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="AccptdQty/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="LineItmDtls/OutsdngQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OutsdngQty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngQty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OutsdngQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
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
<xsl:template match="OutsdngQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
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
<xsl:template match="OutsdngQty/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:when test=". = 'KGM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OutsdngQty/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="LineItmDtls/PdgQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdgQty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdgQty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PdgQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
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
<xsl:template match="PdgQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
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
<xsl:template match="PdgQty/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:when test=". = 'KGM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PdgQty/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="LineItmDtls/QtyTlrnce">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="QtyTlrnce"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::QtyTlrnce) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_QtyTlrnce_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_QtyTlrnce_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PlusPct">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="QtyTlrnce/PlusPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
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
<xsl:template match="QtyTlrnce/MnsPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
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
<xsl:template match="LineItmDtls/OrdrdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OrdrdAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/AccptdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_AccptdAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/OutsdngAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OutsdngAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/PdgAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdgAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/PricTlrnce">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PricTlrnce"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PricTlrnce) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PricTlrnce_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PricTlrnce_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PlusPct">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PricTlrnce/PlusPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
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
<xsl:template match="PricTlrnce/MnsPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
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
<xsl:template match="RptdLineItm/OrdrdLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OrdrdLineItmsTtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OrdrdLineItmsTtlAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OrdrdLineItmsTtlAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/AccptdLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_AccptdLineItmsTtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_AccptdLineItmsTtlAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_AccptdLineItmsTtlAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/OutsdngLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OutsdngLineItmsTtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OutsdngLineItmsTtlAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OutsdngLineItmsTtlAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/PdgLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_PdgLineItmsTtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_PdgLineItmsTtlAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_PdgLineItmsTtlAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/OrdrdTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OrdrdTtlNetAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OrdrdTtlNetAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OrdrdTtlNetAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/AccptdTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_AccptdTtlNetAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_AccptdTtlNetAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_AccptdTtlNetAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/OutsdngTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OutsdngTtlNetAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OutsdngTtlNetAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OutsdngTtlNetAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/PdgTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_PdgTtlNetAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_PdgTtlNetAmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_PdgTtlNetAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnRpt/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:block id="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_ReqForActn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_ReqForActn_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBTW')"/>
</xsl:when>
<xsl:when test=". = 'RSTW'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSTW')"/>
</xsl:when>
<xsl:when test=". = 'RSBS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSBS')"/>
</xsl:when>
<xsl:when test=". = 'ARDM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARDM')"/>
</xsl:when>
<xsl:when test=". = 'ARCS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARCS')"/>
</xsl:when>
<xsl:when test=". = 'ARES'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARES')"/>
</xsl:when>
<xsl:when test=". = 'WAIT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_WAIT')"/>
</xsl:when>
<xsl:when test=". = 'UPDT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_UPDT')"/>
</xsl:when>
<xsl:when test=". = 'SBDS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBDS')"/>
</xsl:when>
<xsl:when test=". = 'ARBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARBA')"/>
</xsl:when>
<xsl:when test=". = 'ARRO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARRO')"/>
</xsl:when>
<xsl:when test=". = 'CINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_CINR')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Desc_name</xsl:variable>
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
<xsl:apply-templates select="BaselnRpt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/BaselnRpt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BaselnRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BaselnRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="RptId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdMsgRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptTp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdLineItm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BaselnRpt/RptId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RptId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RptId_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="RptId/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/RltdMsgRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdMsgRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RltdMsgRef) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RltdMsgRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RltdMsgRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdMsgRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdMsgRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RltdMsgRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="RltdMsgRef/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/RptTp" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptTp"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptTp) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RptTp_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RptTp_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptTp')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptTp/Tp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ReportType2_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/TxId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_TxId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_TxId_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/EstblishdBaselnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_EstblishdBaselnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_EstblishdBaselnId_name')"/>
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
<xsl:apply-templates select="AmdmntSeqNb" mode="toc">
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Vrsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_Vrsn_name</xsl:variable>
</xsl:template>
<xsl:template match="EstblishdBaselnId/AmdmntSeqNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AmdmntSeqNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_AmdmntSeqNb_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/TxSts" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxSts) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_TxSts_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_TxSts_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_TransactionStatus4_Sts_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/UsrTxRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_UsrTxRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification5_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IdIssr) &lt; 1 and count(../preceding-sibling::UsrTxRef) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_DocumentIdentification5_UsrTxRef_IdIssr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/Buyr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_Buyr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_Buyr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_PartyIdentification26_Buyr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="PrtryId/IdTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_PartyIdentification26_Buyr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/Sellr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_Sellr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_Sellr_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Sellr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Sellr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_PartyIdentification26_Sellr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PrtryId_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_PartyIdentification26_Sellr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="BaselnRpt/BuyrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_BuyrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_BuyrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/SellrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_SellrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_SellrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="BaselnRpt/RptdLineItm" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdLineItm"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptdLineItm) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_RptdLineItm_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_RptdLineItm_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="LineItmDtls" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdLineItmsTtlAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdLineItmsTtlAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngLineItmsTtlAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgLineItmsTtlAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdTtlNetAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdTtlNetAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngTtlNetAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgTtlNetAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptdLineItm/LineItmDtls" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmDtls"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItmDtls) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_LineItmDtls_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_LineItmDtls_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="LineItmId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctIdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctChrtcs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctCtgy" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdQty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdQty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngQty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgQty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="QtyTlrnce" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PricTlrnce" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="LineItmDtls/LineItmId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_LineItmId_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/PdctNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_PdctNm_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/PdctIdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctIdr) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdctIdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdctIdr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/PdctChrtcs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctChrtcs) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdctChrtcs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdctChrtcs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/PdctCtgy" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctCtgy"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctCtgy) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdctCtgy_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdctCtgy_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/OrdrdQty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OrdrdQty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdQty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OrdrdQty/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="OrdrdQty/Fctr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/AccptdQty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_AccptdQty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_AccptdQty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="AccptdQty/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="AccptdQty/Fctr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/OutsdngQty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OutsdngQty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngQty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OutsdngQty/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="OutsdngQty/Fctr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/PdgQty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgQty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdgQty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdgQty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PdgQty/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="PdgQty/Fctr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/QtyTlrnce" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="QtyTlrnce"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::QtyTlrnce) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_QtyTlrnce_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_QtyTlrnce_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PlusPct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="QtyTlrnce/PlusPct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
</xsl:template>
<xsl:template match="QtyTlrnce/MnsPct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/OrdrdAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OrdrdAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/AccptdAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_AccptdAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/OutsdngAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_OutsdngAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/PdgAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PdgAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/PricTlrnce" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PricTlrnce"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PricTlrnce) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItemDetails8_LineItmDtls_PricTlrnce_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItemDetails8_PricTlrnce_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PlusPct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PricTlrnce/PlusPct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
</xsl:template>
<xsl:template match="PricTlrnce/MnsPct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
</xsl:template>
<xsl:template match="RptdLineItm/OrdrdLineItmsTtlAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OrdrdLineItmsTtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OrdrdLineItmsTtlAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="RptdLineItm/AccptdLineItmsTtlAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_AccptdLineItmsTtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_AccptdLineItmsTtlAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="RptdLineItm/OutsdngLineItmsTtlAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OutsdngLineItmsTtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OutsdngLineItmsTtlAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="RptdLineItm/PdgLineItmsTtlAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgLineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgLineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_PdgLineItmsTtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_PdgLineItmsTtlAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="RptdLineItm/OrdrdTtlNetAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OrdrdTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OrdrdTtlNetAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OrdrdTtlNetAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="RptdLineItm/AccptdTtlNetAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::AccptdTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_AccptdTtlNetAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_AccptdTtlNetAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="RptdLineItm/OutsdngTtlNetAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OutsdngTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_OutsdngTtlNetAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_OutsdngTtlNetAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="RptdLineItm/PdgTtlNetAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgTtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgTtlNetAmt) &lt; 1 and count(../preceding-sibling::RptdLineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_LineItem8_RptdLineItm_PdgTtlNetAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_LineItem8_PdgTtlNetAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="BaselnRpt/ReqForActn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::BaselnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_BaselnRpt_BaselineReportV03_BaselnRpt_ReqForActn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_BaselnRpt_BaselineReportV03_ReqForActn_name')"/>
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
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="ReqForActn/Desc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Desc_name</xsl:variable>
</xsl:template>
</xsl:stylesheet>
