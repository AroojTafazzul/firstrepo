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
<xsl:apply-templates select="MisMtchRjctnNtfctn">
<xsl:with-param name="path">g
                  </xsl:with-param>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/MisMtchRjctnNtfctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MisMtchRjctnNtfctn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MisMtchRjctnNtfctn) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="NtfctnId">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DataSetMtchRptRef">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RjctnRsn">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/NtfctnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NtfctnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::NtfctnId) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_NtfctnId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_NtfctnId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="NtfctnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:template match="NtfctnId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:template match="MisMtchRjctnNtfctn/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_TxId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_TxId_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:template match="MisMtchRjctnNtfctn/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_EstblishdBaselnId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_EstblishdBaselnId_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification3_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification3_Vrsn_name</xsl:variable>
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
<xsl:template match="MisMtchRjctnNtfctn/TxSts">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxSts) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_TxSts_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_TxSts_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_PROP')"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_CLSD')"/>
</xsl:when>
<xsl:when test=". = 'PMTC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_PMTC')"/>
</xsl:when>
<xsl:when test=". = 'ESTD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_ESTD')"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_ACTV')"/>
</xsl:when>
<xsl:when test=". = 'COMP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_COMP')"/>
</xsl:when>
<xsl:when test=". = 'AMRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_AMRQ')"/>
</xsl:when>
<xsl:when test=". = 'RARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_RARQ')"/>
</xsl:when>
<xsl:when test=". = 'CLRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_CLRQ')"/>
</xsl:when>
<xsl:when test=". = 'SCRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_SCRQ')"/>
</xsl:when>
<xsl:when test=". = 'SERQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_SERQ')"/>
</xsl:when>
<xsl:when test=". = 'DARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_code_DARQ')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_UsrTxRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification5_Id_name</xsl:variable>
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
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification5_UsrTxRef_IdIssr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="MisMtchRjctnNtfctn/DataSetMtchRptRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetMtchRptRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetMtchRptRef) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_DataSetMtchRptRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_DataSetMtchRptRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetMtchRptRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/DataSetMtchRptRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DataSetMtchRptRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:template match="DataSetMtchRptRef/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:template match="MisMtchRjctnNtfctn/RjctnRsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctnRsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctnRsn) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_RjctnRsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_RjctnRsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="GblRjctnRsn">
<xsl:with-param name="path" select="concat($path,'/RjctnRsn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RjctdElmt">
<xsl:with-param name="path" select="concat($path,'/RjctnRsn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctnRsn/GblRjctnRsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="GblRjctnRsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::GblRjctnRsn) &lt; 1 and count(../preceding-sibling::RjctnRsn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_RejectionReason1Choice_RjctnRsn_GblRjctnRsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_RejectionReason1Choice_GblRjctnRsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/GblRjctnRsn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="GblRjctnRsn/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_Reason2_Desc_name</xsl:variable>
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
<xsl:template match="RjctnRsn/RjctdElmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctdElmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctdElmt) &lt; 1 and count(../preceding-sibling::RjctnRsn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_RejectionReason1Choice_RjctnRsn_RjctdElmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_RejectionReason1Choice_RjctdElmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="ElmtSeqNb">
<xsl:with-param name="path" select="concat($path,'/RjctdElmt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IndvRjctnRsn">
<xsl:with-param name="path" select="concat($path,'/RjctdElmt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctdElmt/ElmtSeqNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ElmtSeqNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_RejectedElement1_ElmtSeqNb_name</xsl:variable>
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
<xsl:template match="RjctdElmt/IndvRjctnRsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IndvRjctnRsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_RejectedElement1_IndvRjctnRsn_name</xsl:variable>
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
<xsl:template match="MisMtchRjctnNtfctn/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:block id="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_ReqForActn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_ReqForActn_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_SBTW')"/>
</xsl:when>
<xsl:when test=". = 'RSTW'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_RSTW')"/>
</xsl:when>
<xsl:when test=". = 'RSBS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_RSBS')"/>
</xsl:when>
<xsl:when test=". = 'ARDM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_ARDM')"/>
</xsl:when>
<xsl:when test=". = 'ARCS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_ARCS')"/>
</xsl:when>
<xsl:when test=". = 'ARES'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_ARES')"/>
</xsl:when>
<xsl:when test=". = 'WAIT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_WAIT')"/>
</xsl:when>
<xsl:when test=". = 'UPDT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_UPDT')"/>
</xsl:when>
<xsl:when test=". = 'SBDS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_SBDS')"/>
</xsl:when>
<xsl:when test=". = 'ARBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_ARBA')"/>
</xsl:when>
<xsl:when test=". = 'ARRO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_ARRO')"/>
</xsl:when>
<xsl:when test=". = 'CINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_code_CINR')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Desc_name</xsl:variable>
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
<xsl:apply-templates select="MisMtchRjctnNtfctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/MisMtchRjctnNtfctn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MisMtchRjctnNtfctn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MisMtchRjctnNtfctn) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="NtfctnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DataSetMtchRptRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RjctnRsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MisMtchRjctnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/NtfctnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NtfctnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::NtfctnId) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_NtfctnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_NtfctnId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="NtfctnId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="NtfctnId/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/TxId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_TxId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_TxId_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_SimpleIdentificationInformation_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/EstblishdBaselnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_EstblishdBaselnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_EstblishdBaselnId_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification3_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Vrsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification3_Vrsn_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/TxSts" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxSts) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_TxSts_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_TxSts_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_TransactionStatus4_Sts_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/UsrTxRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_UsrTxRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification5_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IdIssr) &lt; 1 and count(../preceding-sibling::UsrTxRef) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification5_UsrTxRef_IdIssr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/DataSetMtchRptRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetMtchRptRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetMtchRptRef) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_DataSetMtchRptRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_DataSetMtchRptRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetMtchRptRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetMtchRptRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DataSetMtchRptRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="DataSetMtchRptRef/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/RjctnRsn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctnRsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctnRsn) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_RjctnRsn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_RjctnRsn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="MisMtchRjctnNtfctn/ReqForActn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::MisMtchRjctnNtfctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_MisMtchRjctnNtfctn_ReqForActn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_MisMtchRjctnNtfctn_MisMatchRejectionNotificationV03_ReqForActn_name')"/>
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
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="ReqForActn/Desc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_MisMtchRjctnNtfctn_PendingActivity2_Desc_name</xsl:variable>
</xsl:template>
</xsl:stylesheet>
