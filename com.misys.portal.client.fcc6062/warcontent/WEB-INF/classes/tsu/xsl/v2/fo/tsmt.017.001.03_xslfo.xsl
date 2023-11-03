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
<xsl:apply-templates select="FwdDataSetSubmissnRpt">
<xsl:with-param name="path">g
                  </xsl:with-param>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/FwdDataSetSubmissnRpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FwdDataSetSubmissnRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="RptId">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdTxRefs">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CmonSubmissnRef">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrCertDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/RptId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_RptId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_RptId_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/RltdTxRefs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdTxRefs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RltdTxRefs) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_RltdTxRefs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_RltdTxRefs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ForcdMtch">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RltdTxRefs/TxId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxId_name</xsl:variable>
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
<xsl:template match="RltdTxRefs/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::RltdTxRefs) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_RltdTxRefs_PurchsOrdrRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_PurchsOrdrRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PurchsOrdrRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:template match="PurchsOrdrRef/DtOfIsse">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RltdTxRefs/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::RltdTxRefs) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_RltdTxRefs_UsrTxRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_Id_name</xsl:variable>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_UsrTxRef_IdIssr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="RltdTxRefs/ForcdMtch">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ForcdMtch"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_ForcdMtch_name</xsl:variable>
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
<xsl:when test="text() = 'true'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/>
</xsl:when>
<xsl:when test="text() = 'false'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RltdTxRefs/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::RltdTxRefs) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_RltdTxRefs_EstblishdBaselnId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_EstblishdBaselnId_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Vrsn_name</xsl:variable>
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
<xsl:template match="RltdTxRefs/TxSts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PROP')"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLSD')"/>
</xsl:when>
<xsl:when test=". = 'PMTC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PMTC')"/>
</xsl:when>
<xsl:when test=". = 'ESTD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ESTD')"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ACTV')"/>
</xsl:when>
<xsl:when test=". = 'COMP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_COMP')"/>
</xsl:when>
<xsl:when test=". = 'AMRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_AMRQ')"/>
</xsl:when>
<xsl:when test=". = 'RARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_RARQ')"/>
</xsl:when>
<xsl:when test=". = 'CLRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLRQ')"/>
</xsl:when>
<xsl:when test=". = 'SCRQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SCRQ')"/>
</xsl:when>
<xsl:when test=". = 'SERQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SERQ')"/>
</xsl:when>
<xsl:when test=". = 'DARQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_DARQ')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/CmonSubmissnRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CmonSubmissnRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CmonSubmissnRef) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_CmonSubmissnRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_CmonSubmissnRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/CmonSubmissnRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CmonSubmissnRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_Submitr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_BuyrBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_BuyrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_SellrBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_SellrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/ComrclDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_ComrclDataSet_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ComrclDataSet_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDocRef">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BllTo">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Goods">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_DataSetId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_DataSetId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DataSetId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
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
<xsl:template match="DataSetId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
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
<xsl:template match="DataSetId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::DataSetId) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_DataSetId_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDataSet/ComrclDocRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDocRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclDocRef) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_ComrclDocRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDocRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="InvcNb">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDocRef/InvcNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InvcNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_InvcNb_name</xsl:variable>
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
<xsl:template match="ComrclDocRef/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_IsseDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclDataSet/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_Buyr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Buyr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Buyr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Buyr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:template match="ComrclDataSet/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_Sellr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Sellr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Sellr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Sellr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="ComrclDataSet/BllTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BllTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BllTo) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_BllTo_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_BllTo_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BllTo/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:template match="BllTo/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::BllTo) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_BllTo_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="BllTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::BllTo) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_BllTo_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="ComrclDataSet/Goods">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Goods"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Goods) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_Goods_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Goods_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FnlSubmissn">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclLineItms">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_PurchsOrdrRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_PurchsOrdrRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/FnlSubmissn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FnlSubmissn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FnlSubmissn_name</xsl:variable>
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
<xsl:when test="text() = 'true'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/>
</xsl:when>
<xsl:when test="text() = 'false'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/ComrclLineItms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclLineItms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclLineItms) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_ComrclLineItms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_ComrclLineItms_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qty">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UnitPric">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctNm">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctIdr">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctChrtcs">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctCtgy">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctOrgn">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlAmt">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclLineItms/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_LineItmId_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/Qty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Qty) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_Qty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Qty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Qty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_name</xsl:variable>
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
<xsl:template match="Qty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Fctr_name</xsl:variable>
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
<xsl:template match="Qty/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Qty/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/UnitPric">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitPric"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UnitPric) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_UnitPric_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_UnitPric_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="UnitPric/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::UnitPric) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitPric_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="UnitPric/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Fctr_name</xsl:variable>
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
<xsl:template match="UnitPric/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="UnitPric/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/PdctNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctNm_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/PdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctIdr) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_PdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctIdr_name')"/>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2Choice_PdctIdr_StrdPdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2Choice_StrdPdctIdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_BINR')"/>
</xsl:when>
<xsl:when test=". = 'COMD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_COMD')"/>
</xsl:when>
<xsl:when test=". = 'EANC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_EANC')"/>
</xsl:when>
<xsl:when test=". = 'HRTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_HRTR')"/>
</xsl:when>
<xsl:when test=". = 'MANI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_MANI')"/>
</xsl:when>
<xsl:when test=". = 'MODL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_MODL')"/>
</xsl:when>
<xsl:when test=". = 'PART'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_PART')"/>
</xsl:when>
<xsl:when test=". = 'QOTA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_QOTA')"/>
</xsl:when>
<xsl:when test=". = 'STYL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_STYL')"/>
</xsl:when>
<xsl:when test=". = 'SUPI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_SUPI')"/>
</xsl:when>
<xsl:when test=". = 'UPCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_UPCC')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Idr_name</xsl:variable>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2Choice_PdctIdr_OthrPdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2Choice_OthrPdctIdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/PdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctChrtcs) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_PdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctChrtcs_name')"/>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1Choice_PdctChrtcs_StrdPdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1Choice_StrdPdctChrtcs_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_BISP')"/>
</xsl:when>
<xsl:when test=". = 'CHNR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_CHNR')"/>
</xsl:when>
<xsl:when test=". = 'CLOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_CLOR')"/>
</xsl:when>
<xsl:when test=". = 'EDSP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_EDSP')"/>
</xsl:when>
<xsl:when test=". = 'ENNR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_ENNR')"/>
</xsl:when>
<xsl:when test=". = 'OPTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_OPTN')"/>
</xsl:when>
<xsl:when test=". = 'ORCR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_ORCR')"/>
</xsl:when>
<xsl:when test=". = 'PCTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_PCTV')"/>
</xsl:when>
<xsl:when test=". = 'SISP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SISP')"/>
</xsl:when>
<xsl:when test=". = 'SIZE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SIZE')"/>
</xsl:when>
<xsl:when test=". = 'SZRG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SZRG')"/>
</xsl:when>
<xsl:when test=". = 'SPRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SPRM')"/>
</xsl:when>
<xsl:when test=". = 'STOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_STOR')"/>
</xsl:when>
<xsl:when test=". = 'VINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_VINR')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Chrtcs_name</xsl:variable>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1Choice_PdctChrtcs_OthrPdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1Choice_OthrPdctChrtcs_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/PdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctCtgy"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctCtgy) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_PdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctCtgy_name')"/>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1Choice_PdctCtgy_StrdPdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1Choice_StrdPdctCtgy_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_HRTR')"/>
</xsl:when>
<xsl:when test=". = 'QOTA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_QOTA')"/>
</xsl:when>
<xsl:when test=". = 'PRGP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_PRGP')"/>
</xsl:when>
<xsl:when test=". = 'LOBU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_LOBU')"/>
</xsl:when>
<xsl:when test=". = 'GNDR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_GNDR')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Ctgy_name</xsl:variable>
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
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1Choice_PdctCtgy_OthrPdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1Choice_OthrPdctCtgy_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/PdctOrgn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctOrgn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctOrgn_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_Adjstmnt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Adjstmnt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrAdjstmntTp">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Adjstmnt/Drctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Drctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:when test=". = 'ADDD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_ADDD')"/>
</xsl:when>
<xsl:when test=". = 'SUBS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_SUBS')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Adjstmnt/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Adjstmnt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Adjstmnt_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Adjstmnt/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_name</xsl:variable>
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
<xsl:when test=". = 'REBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_REBA')"/>
</xsl:when>
<xsl:when test=". = 'DISC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_DISC')"/>
</xsl:when>
<xsl:when test=". = 'CREN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_CREN')"/>
</xsl:when>
<xsl:when test=". = 'SURC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_SURC')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Adjstmnt/OthrAdjstmntTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrAdjstmntTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_FrghtChrgs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_FrghtChrgs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="FrghtChrgs/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
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
<xsl:when test=". = 'CLCT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')"/>
</xsl:when>
<xsl:when test=". = 'PRPD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="FrghtChrgs/Chrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Chrgs) &lt; 1 and count(../preceding-sibling::FrghtChrgs) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_Charge13_FrghtChrgs_Chrgs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Chrgs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrChrgsTp">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Chrgs/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Chrgs) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Chrgs_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Chrgs/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_name</xsl:variable>
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
<xsl:when test=". = 'SIGN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_SIGN')"/>
</xsl:when>
<xsl:when test=". = 'STDE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_STDE')"/>
</xsl:when>
<xsl:when test=". = 'STOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_STOR')"/>
</xsl:when>
<xsl:when test=". = 'PACK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_PACK')"/>
</xsl:when>
<xsl:when test=". = 'PICK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_PICK')"/>
</xsl:when>
<xsl:when test=". = 'DNGR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_DNGR')"/>
</xsl:when>
<xsl:when test=". = 'SECU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_SECU')"/>
</xsl:when>
<xsl:when test=". = 'INSU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_INSU')"/>
</xsl:when>
<xsl:when test=". = 'COLF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_COLF')"/>
</xsl:when>
<xsl:when test=". = 'CHOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_CHOR')"/>
</xsl:when>
<xsl:when test=". = 'CHDE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_CHDE')"/>
</xsl:when>
<xsl:when test=". = 'AIRF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_AIRF')"/>
</xsl:when>
<xsl:when test=". = 'TRPT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_TRPT')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Chrgs/OthrChrgsTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrChrgsTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_OthrChrgsTp_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/Tax">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tax) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_Tax_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Tax_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Tax) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tax_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Tax/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
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
<xsl:when test=". = 'PROV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_PROV')"/>
</xsl:when>
<xsl:when test=". = 'NATI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_NATI')"/>
</xsl:when>
<xsl:when test=". = 'STAT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAT')"/>
</xsl:when>
<xsl:when test=". = 'WITH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_WITH')"/>
</xsl:when>
<xsl:when test=". = 'STAM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAM')"/>
</xsl:when>
<xsl:when test=". = 'COAX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_COAX')"/>
</xsl:when>
<xsl:when test=". = 'VATA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_VATA')"/>
</xsl:when>
<xsl:when test=". = 'CUST'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_CUST')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Tax/OthrTaxTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrTaxTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
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
<xsl:template match="ComrclLineItms/TtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlAmt) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_TtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/LineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_LineItmsTtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_Incotrms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Incotrms_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Othr">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Incotrms/Lctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_name</xsl:variable>
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
<xsl:template match="Incotrms/Cd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_name</xsl:variable>
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
<xsl:when test=". = 'EXW'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_EXW')"/>
</xsl:when>
<xsl:when test=". = 'FCA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FCA')"/>
</xsl:when>
<xsl:when test=". = 'FAS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FAS')"/>
</xsl:when>
<xsl:when test=". = 'FOB'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FOB')"/>
</xsl:when>
<xsl:when test=". = 'CFR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CFR')"/>
</xsl:when>
<xsl:when test=". = 'CIF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CIF')"/>
</xsl:when>
<xsl:when test=". = 'CPT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CPT')"/>
</xsl:when>
<xsl:when test=". = 'CIP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CIP')"/>
</xsl:when>
<xsl:when test=". = 'DAF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DAF')"/>
</xsl:when>
<xsl:when test=". = 'DES'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DES')"/>
</xsl:when>
<xsl:when test=". = 'DEQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DEQ')"/>
</xsl:when>
<xsl:when test=". = 'DDU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DDU')"/>
</xsl:when>
<xsl:when test=". = 'DDP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DDP')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Incotrms/Othr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Othr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Othr_name</xsl:variable>
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
<xsl:template match="Goods/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_Adjstmnt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Adjstmnt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrAdjstmntTp">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_FrghtChrgs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FrghtChrgs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/Tax">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tax) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_Tax_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Tax_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/TtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlNetAmt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_TtlNetAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/BuyrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrDfndInf) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_BuyrDfndInf_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_BuyrDfndInf_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrDfndInf/Labl">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
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
<xsl:template match="BuyrDfndInf/Inf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
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
<xsl:template match="Goods/SellrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrDfndInf) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_SellrDfndInf_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_SellrDfndInf_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrDfndInf/Labl">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
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
<xsl:template match="SellrDfndInf/Inf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
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
<xsl:template match="ComrclDataSet/PmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtTerms) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_PmtTerms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_PmtTerms_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="OthrPmtTerms">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtCd">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Pctg">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PmtTerms/OthrPmtTerms">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrPmtTerms"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_OthrPmtTerms_name</xsl:variable>
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
<xsl:template match="PmtTerms/PmtCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtCd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtCd) &lt; 1 and count(../preceding-sibling::PmtTerms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_PmtTerms_PmtCd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_PmtCd_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/PmtCd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NbOfDays">
<xsl:with-param name="path" select="concat($path,'/PmtCd')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PmtCd/Cd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_name</xsl:variable>
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
<xsl:when test=". = 'CASH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_CASH')"/>
</xsl:when>
<xsl:when test=". = 'EMTD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EMTD')"/>
</xsl:when>
<xsl:when test=". = 'EPRD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EPRD')"/>
</xsl:when>
<xsl:when test=". = 'PRMD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_PRMD')"/>
</xsl:when>
<xsl:when test=". = 'IREC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_IREC')"/>
</xsl:when>
<xsl:when test=". = 'PRMR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_PRMR')"/>
</xsl:when>
<xsl:when test=". = 'EPRR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EPRR')"/>
</xsl:when>
<xsl:when test=". = 'EMTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EMTR')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PmtCd/NbOfDays">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NbOfDays"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_NbOfDays_name</xsl:variable>
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
<xsl:template match="PmtTerms/Pctg">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Pctg"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Pctg_name</xsl:variable>
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
<xsl:template match="PmtTerms/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::PmtTerms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_PmtTerms_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclDataSet/SttlmTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SttlmTerms) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_SttlmTerms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_SttlmTerms_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="CdtrAgt">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CdtrAcct">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAgt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAgt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CdtrAgt) &lt; 1 and count(../preceding-sibling::SttlmTerms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_SttlmTerms_CdtrAgt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAgt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/CdtrAgt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmAndAdr">
<xsl:with-param name="path" select="concat($path,'/CdtrAgt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CdtrAgt/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
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
<xsl:template match="CdtrAgt/NmAndAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmAndAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::NmAndAdr) &lt; 1 and count(../preceding-sibling::CdtrAgt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_FinancialInstitutionIdentification4Choice_CdtrAgt_NmAndAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_FinancialInstitutionIdentification4Choice_NmAndAdr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adr">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="NmAndAdr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_NameAndAddress6_Nm_name</xsl:variable>
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
<xsl:template match="NmAndAdr/Adr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adr) &lt; 1 and count(../preceding-sibling::NmAndAdr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_NameAndAddress6_NmAndAdr_Adr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_NameAndAddress6_Adr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/Adr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/Adr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/Adr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/Adr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/Adr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Adr/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_StrtNm_name</xsl:variable>
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
<xsl:template match="Adr/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_PstCdId_name</xsl:variable>
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
<xsl:template match="Adr/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_TwnNm_name</xsl:variable>
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
<xsl:template match="Adr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_CtrySubDvsn_name</xsl:variable>
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
<xsl:template match="Adr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_Ctry_name</xsl:variable>
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
<xsl:template match="SttlmTerms/CdtrAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAcct"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CdtrAcct) &lt; 1 and count(../preceding-sibling::SttlmTerms) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_SttlmTerms_CdtrAcct_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAcct_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ccy">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CdtrAcct/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Id) &lt; 1 and count(../preceding-sibling::CdtrAcct) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_CdtrAcct_Id_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Id_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="IBAN">
<xsl:with-param name="path" select="concat($path,'/Id')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BBAN">
<xsl:with-param name="path" select="concat($path,'/Id')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UPIC">
<xsl:with-param name="path" select="concat($path,'/Id')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryAcct">
<xsl:with-param name="path" select="concat($path,'/Id')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Id/IBAN">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IBAN"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_IBAN_name</xsl:variable>
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
<xsl:template match="Id/BBAN">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BBAN"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_BBAN_name</xsl:variable>
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
<xsl:template match="Id/UPIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UPIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_UPIC_name</xsl:variable>
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
<xsl:template match="Id/PrtryAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryAcct"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryAcct) &lt; 1 and count(../preceding-sibling::Id) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_Id_PrtryAcct_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_PrtryAcct_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryAcct')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PrtryAcct/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_SimpleIdentificationInformation2_Id_name</xsl:variable>
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
<xsl:template match="CdtrAcct/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tp) &lt; 1 and count(../preceding-sibling::CdtrAcct) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_CdtrAcct_Tp_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Tp_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/Tp')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Prtry">
<xsl:with-param name="path" select="concat($path,'/Tp')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Tp/Cd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_name</xsl:variable>
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
<xsl:when test=". = 'CASH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CASH')"/>
</xsl:when>
<xsl:when test=". = 'CHAR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CHAR')"/>
</xsl:when>
<xsl:when test=". = 'COMM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_COMM')"/>
</xsl:when>
<xsl:when test=". = 'TAXE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_TAXE')"/>
</xsl:when>
<xsl:when test=". = 'CISH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CISH')"/>
</xsl:when>
<xsl:when test=". = 'TRAS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_TRAS')"/>
</xsl:when>
<xsl:when test=". = 'SACC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_SACC')"/>
</xsl:when>
<xsl:when test=". = 'CACC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CACC')"/>
</xsl:when>
<xsl:when test=". = 'SVGS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_SVGS')"/>
</xsl:when>
<xsl:when test=". = 'ONDP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_ONDP')"/>
</xsl:when>
<xsl:when test=". = 'MGLD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_MGLD')"/>
</xsl:when>
<xsl:when test=". = 'NREX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_NREX')"/>
</xsl:when>
<xsl:when test=". = 'MOMA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_MOMA')"/>
</xsl:when>
<xsl:when test=". = 'LOAN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_LOAN')"/>
</xsl:when>
<xsl:when test=". = 'SLRY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_SLRY')"/>
</xsl:when>
<xsl:when test=". = 'ODFT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_ODFT')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Tp/Prtry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Prtry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Prtry_name</xsl:variable>
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
<xsl:template match="CdtrAcct/Ccy">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ccy"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Ccy_name</xsl:variable>
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
<xsl:template match="CdtrAcct/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Nm_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/TrnsprtDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_TrnsprtDataSet_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_TrnsprtDataSet_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipTo">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtInf">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_DataSetId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_DataSetId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDataSet/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Buyr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Buyr_name')"/>
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
<xsl:template match="TrnsprtDataSet/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Sellr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Sellr_name')"/>
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
<xsl:template match="TrnsprtDataSet/Consgnr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgnr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Consgnr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgnr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Consgnr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:template match="Consgnr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Consgnr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgnr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Consgnr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Consgnr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgnr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="TrnsprtDataSet/Consgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgn) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Consgn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Consgn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:template match="Consgn/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Consgn) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgn_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Consgn/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Consgn) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgn_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="TrnsprtDataSet/ShipTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipTo) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_ShipTo_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_ShipTo_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ShipTo/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:template match="ShipTo/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::ShipTo) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_ShipTo_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="ShipTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::ShipTo) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_ShipTo_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="TrnsprtDataSet/TrnsprtInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtInf) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_TrnsprtInf_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtInf_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TrnsprtDocRef">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtdGoods">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnmt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PropsdShipmntDt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ActlShipmntDt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtInf/TrnsprtDocRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDocRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtDocRef) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_TrnsprtDocRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtDocRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDocRef[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDocRef[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDocRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:template match="TrnsprtDocRef/DtOfIsse">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtInf/TrnsprtdGoods">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtdGoods"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtdGoods) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_TrnsprtdGoods_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtdGoods_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="GoodsDesc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtdGoods/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::TrnsprtdGoods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_TrnsprtdGoods_PurchsOrdrRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_PurchsOrdrRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtdGoods/GoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_GoodsDesc_name</xsl:variable>
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
<xsl:template match="TrnsprtdGoods/BuyrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrDfndInf) &lt; 1 and count(../preceding-sibling::TrnsprtdGoods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_TrnsprtdGoods_BuyrDfndInf_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_BuyrDfndInf_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtdGoods/SellrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrDfndInf) &lt; 1 and count(../preceding-sibling::TrnsprtdGoods) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_TrnsprtdGoods_SellrDfndInf_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_SellrDfndInf_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtInf/Consgnmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgnmt) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_Consgnmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Consgnmt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TtlQty">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlVol">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlWght">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Consgnmt/TtlQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlQty) &lt; 1 and count(../preceding-sibling::Consgnmt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_Consgnmt_TtlQty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlQty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/TtlQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/TtlQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/TtlQty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TtlQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
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
<xsl:template match="TtlQty/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TtlQty/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="Consgnmt/TtlVol">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlVol"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlVol) &lt; 1 and count(../preceding-sibling::Consgnmt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_Consgnmt_TtlVol_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlVol_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/TtlVol')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/TtlVol')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/TtlVol')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TtlVol/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
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
<xsl:template match="TtlVol/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TtlVol/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="Consgnmt/TtlWght">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlWght"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlWght) &lt; 1 and count(../preceding-sibling::Consgnmt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_Consgnmt_TtlWght_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlWght_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/TtlWght')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/TtlWght')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/TtlWght')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TtlWght/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
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
<xsl:template match="TtlWght/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TtlWght/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="TrnsprtInf/RtgSummry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RtgSummry) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_RtgSummry_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_RtgSummry_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="IndvTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MltmdlTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RtgSummry/IndvTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IndvTrnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IndvTrnsprt) &lt; 1 and count(../preceding-sibling::RtgSummry) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_RtgSummry_IndvTrnsprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_IndvTrnsprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TrnsprtByAir">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByAir">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByAir) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtByAir_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByAir_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtByAir/DprtureAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DprtureAirprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DprtureAirprt) &lt; 1 and count(../preceding-sibling::TrnsprtByAir) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_TrnsprtByAir_DprtureAirprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DprtureAirprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="AirprtCd">
<xsl:with-param name="path" select="concat($path,'/DprtureAirprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrAirprtDesc">
<xsl:with-param name="path" select="concat($path,'/DprtureAirprt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DprtureAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
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
<xsl:template match="DprtureAirprt/OthrAirprtDesc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAirprtDesc"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrAirprtDesc) &lt; 1 and count(../preceding-sibling::DprtureAirprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_DprtureAirprt_OthrAirprtDesc_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_OthrAirprtDesc_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Twn">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirprtNm">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrAirprtDesc/Twn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Twn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_name</xsl:variable>
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
<xsl:template match="OthrAirprtDesc/AirprtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirprtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_AirprtNm_name</xsl:variable>
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
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DstnAirprt) &lt; 1 and count(../preceding-sibling::TrnsprtByAir) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_TrnsprtByAir_DstnAirprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DstnAirprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="AirprtCd">
<xsl:with-param name="path" select="concat($path,'/DstnAirprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrAirprtDesc">
<xsl:with-param name="path" select="concat($path,'/DstnAirprt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DstnAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
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
<xsl:template match="DstnAirprt/OthrAirprtDesc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAirprtDesc"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrAirprtDesc) &lt; 1 and count(../preceding-sibling::DstnAirprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_DstnAirprt_OthrAirprtDesc_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_OthrAirprtDesc_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Twn">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirprtNm">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtByAir/AirCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_name</xsl:variable>
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
<xsl:template match="IndvTrnsprt/TrnsprtBySea">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtBySea) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtBySea_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtBySea_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="VsslNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfLoadng">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfLoadng"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_name</xsl:variable>
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
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_name</xsl:variable>
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
<xsl:template match="TrnsprtBySea/VsslNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="VsslNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_name</xsl:variable>
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
<xsl:template match="TrnsprtBySea/SeaCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SeaCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_name</xsl:variable>
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
<xsl:template match="IndvTrnsprt/TrnsprtByRoad">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRoad) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtByRoad_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRoad_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfRct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_name</xsl:variable>
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
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_name</xsl:variable>
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
<xsl:template match="TrnsprtByRoad/RoadCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RoadCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_name</xsl:variable>
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
<xsl:template match="IndvTrnsprt/TrnsprtByRail">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRail) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtByRail_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRail_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfRct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_name</xsl:variable>
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
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_name</xsl:variable>
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
<xsl:template match="TrnsprtByRail/RailCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RailCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_name</xsl:variable>
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
<xsl:template match="RtgSummry/MltmdlTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MltmdlTrnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MltmdlTrnsprt) &lt; 1 and count(../preceding-sibling::RtgSummry) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_RtgSummry_MltmdlTrnsprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_MltmdlTrnsprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TakngInChrg">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfFnlDstn">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/TakngInChrg">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TakngInChrg"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_TakngInChrg_name</xsl:variable>
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
<xsl:template match="MltmdlTrnsprt/PlcOfFnlDstn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfFnlDstn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
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
<xsl:template match="TrnsprtInf/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_Incotrms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Incotrms_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Othr">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtInf/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_FrghtChrgs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_FrghtChrgs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtInf/PropsdShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PropsdShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_PropsdShipmntDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtInf/ActlShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ActlShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_ActlShipmntDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/InsrncDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrncDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InsrncDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_InsrncDataSet_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_InsrncDataSet_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FctvDt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfIsse">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDocId">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Trnsprt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrdAmt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrdGoodsDesc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncConds">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncClauses">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Assrd">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClmsPyblAt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClmsPyblIn">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_DataSetId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_DataSetId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSet/Issr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Issr) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_Issr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Issr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Issr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:template match="Issr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Issr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Issr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Issr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Issr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Issr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="InsrncDataSet/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_IsseDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InsrncDataSet/FctvDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FctvDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_FctvDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InsrncDataSet/PlcOfIsse">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfIsse"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PlcOfIsse) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_PlcOfIsse_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_PlcOfIsse_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PlcOfIsse/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:template match="PlcOfIsse/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:template match="PlcOfIsse/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:template match="PlcOfIsse/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:template match="PlcOfIsse/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:template match="InsrncDataSet/InsrncDocId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncDocId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDocId_name</xsl:variable>
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
<xsl:template match="InsrncDataSet/Trnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Trnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Trnsprt) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_Trnsprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Trnsprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TrnsprtByAir">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByAir">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByAir) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtByAir_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByAir_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtBySea">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtBySea) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtBySea_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtBySea_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
</xsl:apply-templates>
<xsl:apply-templates select="VsslNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRoad">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRoad) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtByRoad_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRoad_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRail">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRail) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtByRail_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRail_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrdAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InsrdAmt) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_InsrdAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrdGoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrdGoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdGoodsDesc_name</xsl:variable>
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
<xsl:template match="InsrncDataSet/InsrncConds">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncConds"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncConds_name</xsl:variable>
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
<xsl:template match="InsrncDataSet/InsrncClauses">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncClauses"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_name</xsl:variable>
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
<xsl:when test=". = 'ICCA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCA')"/>
</xsl:when>
<xsl:when test=". = 'ICCB'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCB')"/>
</xsl:when>
<xsl:when test=". = 'ICCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCC')"/>
</xsl:when>
<xsl:when test=". = 'ICAI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICAI')"/>
</xsl:when>
<xsl:when test=". = 'IWCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IWCC')"/>
</xsl:when>
<xsl:when test=". = 'ISCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISCC')"/>
</xsl:when>
<xsl:when test=". = 'IREC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IREC')"/>
</xsl:when>
<xsl:when test=". = 'ICLC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICLC')"/>
</xsl:when>
<xsl:when test=". = 'ISMC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISMC')"/>
</xsl:when>
<xsl:when test=". = 'CMCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_CMCC')"/>
</xsl:when>
<xsl:when test=". = 'IRCE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IRCE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InsrncDataSet/Assrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Assrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Assrd) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_Assrd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Assrd_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Assrd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmAndAdr">
<xsl:with-param name="path" select="concat($path,'/Assrd')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Assrd/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification29Choice_BIC_name</xsl:variable>
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
<xsl:template match="Assrd/NmAndAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmAndAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::NmAndAdr) &lt; 1 and count(../preceding-sibling::Assrd) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification29Choice_Assrd_NmAndAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification29Choice_NmAndAdr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="NmAndAdr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::NmAndAdr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_NmAndAdr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="NmAndAdr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::NmAndAdr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_NmAndAdr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="InsrncDataSet/ClmsPyblAt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ClmsPyblAt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ClmsPyblAt) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_ClmsPyblAt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblAt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ClmsPyblAt/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:template match="ClmsPyblAt/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:template match="ClmsPyblAt/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:template match="ClmsPyblAt/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:template match="ClmsPyblAt/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:template match="InsrncDataSet/ClmsPyblIn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ClmsPyblIn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblIn_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/CertDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CertDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_CertDataSet_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_CertDataSet_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItm">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertfdChrtcs">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfIsse">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InspctnDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AuthrsdInspctrInd">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertId">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Trnsprt">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="GoodsDesc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnr">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Manfctr">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AddtlInf">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_DataSetId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_DataSetId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_name</xsl:variable>
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
<xsl:when test=". = 'ANLY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ANLY')"/>
</xsl:when>
<xsl:when test=". = 'QUAL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAL')"/>
</xsl:when>
<xsl:when test=". = 'QUAN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAN')"/>
</xsl:when>
<xsl:when test=". = 'WEIG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_WEIG')"/>
</xsl:when>
<xsl:when test=". = 'ORIG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ORIG')"/>
</xsl:when>
<xsl:when test=". = 'HEAL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_HEAL')"/>
</xsl:when>
<xsl:when test=". = 'PHYT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_PHYT')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertDataSet/LineItm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItm"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItm) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_LineItm_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_LineItm_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/LineItm[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/LineItm[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="LineItm/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItmId_name</xsl:variable>
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
<xsl:template match="LineItm/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::LineItm) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItm_PurchsOrdrRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_PurchsOrdrRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/CertfdChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertfdChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CertfdChrtcs) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_CertfdChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertfdChrtcs_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Orgn">
<xsl:with-param name="path" select="concat($path,'/CertfdChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qlty">
<xsl:with-param name="path" select="concat($path,'/CertfdChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Anlys">
<xsl:with-param name="path" select="concat($path,'/CertfdChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Wght">
<xsl:with-param name="path" select="concat($path,'/CertfdChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qty">
<xsl:with-param name="path" select="concat($path,'/CertfdChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="HlthIndctn">
<xsl:with-param name="path" select="concat($path,'/CertfdChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhytosntryIndctn">
<xsl:with-param name="path" select="concat($path,'/CertfdChrtcs')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertfdChrtcs/Orgn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Orgn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Orgn_name</xsl:variable>
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
<xsl:template match="CertfdChrtcs/Qlty">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Qlty"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Qlty_name</xsl:variable>
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
<xsl:template match="CertfdChrtcs/Anlys">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Anlys"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Anlys_name</xsl:variable>
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
<xsl:template match="CertfdChrtcs/Wght">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Wght"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Wght) &lt; 1 and count(../preceding-sibling::CertfdChrtcs) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_CertfdChrtcs_Wght_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Wght_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/Wght')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/Wght')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Wght')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Wght')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Wght/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_name</xsl:variable>
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
<xsl:template match="Wght/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Fctr_name</xsl:variable>
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
<xsl:template match="Wght/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_TNE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Wght/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
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
<xsl:template match="CertfdChrtcs/Qty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Qty) &lt; 1 and count(../preceding-sibling::CertfdChrtcs) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_CertfdChrtcs_Qty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Qty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertfdChrtcs/HlthIndctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="HlthIndctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_HlthIndctn_name</xsl:variable>
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
<xsl:when test="text() = 'true'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/>
</xsl:when>
<xsl:when test="text() = 'false'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertfdChrtcs/PhytosntryIndctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhytosntryIndctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_PhytosntryIndctn_name</xsl:variable>
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
<xsl:when test="text() = 'true'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/>
</xsl:when>
<xsl:when test="text() = 'false'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertDataSet/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_IsseDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertDataSet/PlcOfIsse">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfIsse"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PlcOfIsse) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_PlcOfIsse_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_PlcOfIsse_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/Issr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Issr) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Issr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Issr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/InspctnDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InspctnDt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InspctnDt) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_InspctnDt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_InspctnDt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="FrDt">
<xsl:with-param name="path" select="concat($path,'/InspctnDt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ToDt">
<xsl:with-param name="path" select="concat($path,'/InspctnDt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InspctnDt/FrDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FrDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_FrDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InspctnDt/ToDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ToDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_ToDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertDataSet/AuthrsdInspctrInd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AuthrsdInspctrInd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AuthrsdInspctrInd_name</xsl:variable>
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
<xsl:when test="text() = 'true'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/>
</xsl:when>
<xsl:when test="text() = 'false'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertDataSet/CertId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertId_name</xsl:variable>
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
<xsl:template match="CertDataSet/Trnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Trnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Trnsprt) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Trnsprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Trnsprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TrnsprtByAir">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/GoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_GoodsDesc_name</xsl:variable>
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
<xsl:template match="CertDataSet/Consgnr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgnr) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Consgnr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgnr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/Consgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgn) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Consgn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/Manfctr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Manfctr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Manfctr) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Manfctr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Manfctr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Manfctr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:template match="Manfctr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Manfctr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Manfctr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Manfctr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Manfctr) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Manfctr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="CertDataSet/AddtlInf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AddtlInf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AddtlInf_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/OthrCertDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrCertDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrCertDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_OthrCertDataSet_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_OthrCertDataSet_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertId">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertInf">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::OthrCertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_OthrCertDataSet_DataSetId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_DataSetId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertId_name</xsl:variable>
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
<xsl:template match="OthrCertDataSet/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_name</xsl:variable>
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
<xsl:when test=". = 'BENE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_BENE')"/>
</xsl:when>
<xsl:when test=". = 'SHIP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_SHIP')"/>
</xsl:when>
<xsl:when test=". = 'UND1'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND1')"/>
</xsl:when>
<xsl:when test=". = 'UND2'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND2')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OthrCertDataSet/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_IsseDt_name</xsl:variable>
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
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OthrCertDataSet/Issr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Issr) &lt; 1 and count(../preceding-sibling::OthrCertDataSet) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_OthrCertDataSet_Issr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_Issr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertInf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertInf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertInf_name</xsl:variable>
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
<xsl:template match="FwdDataSetSubmissnRpt/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:block id="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_ReqForActn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ReqForActn_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBTW')"/>
</xsl:when>
<xsl:when test=". = 'RSTW'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSTW')"/>
</xsl:when>
<xsl:when test=". = 'RSBS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSBS')"/>
</xsl:when>
<xsl:when test=". = 'ARDM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARDM')"/>
</xsl:when>
<xsl:when test=". = 'ARCS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARCS')"/>
</xsl:when>
<xsl:when test=". = 'ARES'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARES')"/>
</xsl:when>
<xsl:when test=". = 'WAIT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_WAIT')"/>
</xsl:when>
<xsl:when test=". = 'UPDT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_UPDT')"/>
</xsl:when>
<xsl:when test=". = 'SBDS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBDS')"/>
</xsl:when>
<xsl:when test=". = 'ARBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARBA')"/>
</xsl:when>
<xsl:when test=". = 'ARRO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARRO')"/>
</xsl:when>
<xsl:when test=". = 'CINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_CINR')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Desc_name</xsl:variable>
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
<xsl:apply-templates select="FwdDataSetSubmissnRpt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/FwdDataSetSubmissnRpt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FwdDataSetSubmissnRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="RptId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdTxRefs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CmonSubmissnRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDataSet" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtDataSet" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDataSet" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertDataSet" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrCertDataSet" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/RptId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_RptId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_RptId_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="RptId/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/RltdTxRefs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdTxRefs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RltdTxRefs) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_RltdTxRefs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_RltdTxRefs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TxId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ForcdMtch" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RltdTxRefs/TxId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxId_name</xsl:variable>
</xsl:template>
<xsl:template match="RltdTxRefs/PurchsOrdrRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::RltdTxRefs) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_RltdTxRefs_PurchsOrdrRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_PurchsOrdrRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PurchsOrdrRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="PurchsOrdrRef/DtOfIsse" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
</xsl:template>
<xsl:template match="RltdTxRefs/UsrTxRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::RltdTxRefs) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_RltdTxRefs_UsrTxRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IdIssr) &lt; 1 and count(../preceding-sibling::UsrTxRef) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_UsrTxRef_IdIssr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="RltdTxRefs/ForcdMtch" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ForcdMtch"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_ForcdMtch_name</xsl:variable>
</xsl:template>
<xsl:template match="RltdTxRefs/EstblishdBaselnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::EstblishdBaselnId) &lt; 1 and count(../preceding-sibling::RltdTxRefs) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_RltdTxRefs_EstblishdBaselnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_EstblishdBaselnId_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Vrsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Vrsn_name</xsl:variable>
</xsl:template>
<xsl:template match="RltdTxRefs/TxSts" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/CmonSubmissnRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CmonSubmissnRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CmonSubmissnRef) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_CmonSubmissnRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_CmonSubmissnRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CmonSubmissnRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CmonSubmissnRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_Submitr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/BuyrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_BuyrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_BuyrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/SellrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_SellrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_SellrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/ComrclDataSet" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_ComrclDataSet_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ComrclDataSet_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DataSetId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDocRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BllTo" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Goods" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDataSet/DataSetId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_DataSetId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_DataSetId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DataSetId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="DataSetId/Vrsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
</xsl:template>
<xsl:template match="DataSetId/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::DataSetId) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_DataSetId_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Submitr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDataSet/ComrclDocRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDocRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclDocRef) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_ComrclDocRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDocRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="InvcNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDocRef/InvcNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InvcNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_InvcNb_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclDocRef/IsseDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_IsseDt_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclDataSet/Buyr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_Buyr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Buyr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Buyr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="PrtryId/IdTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Buyr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclDataSet/Sellr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_Sellr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Sellr_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Sellr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Sellr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Sellr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Sellr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="ComrclDataSet/BllTo" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BllTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BllTo) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_BllTo_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_BllTo_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BllTo/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="BllTo/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::BllTo) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_BllTo_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="BllTo/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::BllTo) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_BllTo_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="ComrclDataSet/Goods" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Goods"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Goods) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_Goods_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Goods_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PurchsOrdrRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FnlSubmissn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclLineItms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmsTtlAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlNetAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/PurchsOrdrRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_PurchsOrdrRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_PurchsOrdrRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/FnlSubmissn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FnlSubmissn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FnlSubmissn_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/ComrclLineItms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclLineItms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclLineItms) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_ComrclLineItms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_ComrclLineItms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="LineItmId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UnitPric" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctIdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctChrtcs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctCtgy" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctOrgn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclLineItms/LineItmId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_LineItmId_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclLineItms/Qty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Qty) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_Qty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Qty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Qty/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="Qty/Fctr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclLineItms/UnitPric" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitPric"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UnitPric) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_UnitPric_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_UnitPric_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Amt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="UnitPric/Amt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::UnitPric) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitPric_Amt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="UnitPric/Fctr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctNm_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctIdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctIdr) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_PdctIdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctIdr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctChrtcs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctChrtcs) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_PdctChrtcs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctChrtcs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctCtgy" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctCtgy"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctCtgy) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_PdctCtgy_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctCtgy_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctOrgn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctOrgn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctOrgn_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclLineItms/Adjstmnt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_Adjstmnt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Adjstmnt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Drctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Adjstmnt/Drctn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Drctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_name</xsl:variable>
</xsl:template>
<xsl:template match="Adjstmnt/Amt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Adjstmnt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Adjstmnt_Amt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="ComrclLineItms/FrghtChrgs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_FrghtChrgs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_FrghtChrgs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="FrghtChrgs/Tp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="FrghtChrgs/Chrgs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Chrgs) &lt; 1 and count(../preceding-sibling::FrghtChrgs) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_Charge13_FrghtChrgs_Chrgs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Chrgs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Amt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Chrgs/Amt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Chrgs) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Chrgs_Amt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="ComrclLineItms/Tax" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tax) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_Tax_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Tax_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Amt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Tax/Amt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Tax) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tax_Amt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="ComrclLineItms/TtlAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlAmt) &lt; 1 and count(../preceding-sibling::ComrclLineItms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_ComrclLineItms_TtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="Goods/LineItmsTtlAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmsTtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItmsTtlAmt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_LineItmsTtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="Goods/Incotrms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_Incotrms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Incotrms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Lctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Incotrms/Lctn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/Adjstmnt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_Adjstmnt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Adjstmnt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Drctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/FrghtChrgs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_FrghtChrgs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FrghtChrgs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/Tax" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tax) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_Tax_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Tax_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Amt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/TtlNetAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlNetAmt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_TtlNetAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="Goods/BuyrDfndInf" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrDfndInf) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_BuyrDfndInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_BuyrDfndInf_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Labl" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrDfndInf/Labl" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrDfndInf/Inf" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/SellrDfndInf" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrDfndInf) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Goods_SellrDfndInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_SellrDfndInf_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Labl" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrDfndInf/Labl" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrDfndInf/Inf" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
</xsl:template>
<xsl:template match="ComrclDataSet/PmtTerms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtTerms) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_PmtTerms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_PmtTerms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="ComrclDataSet/SttlmTerms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SttlmTerms) &lt; 1 and count(../preceding-sibling::ComrclDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDataSet_SttlmTerms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_SttlmTerms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="CdtrAgt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CdtrAcct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAgt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAgt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CdtrAgt) &lt; 1 and count(../preceding-sibling::SttlmTerms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_SttlmTerms_CdtrAgt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAgt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAcct" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAcct"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CdtrAcct) &lt; 1 and count(../preceding-sibling::SttlmTerms) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_SttlmTerms_CdtrAcct_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAcct_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ccy" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CdtrAcct/Id" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Id) &lt; 1 and count(../preceding-sibling::CdtrAcct) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_CdtrAcct_Id_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Id_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="CdtrAcct/Tp" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tp) &lt; 1 and count(../preceding-sibling::CdtrAcct) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_CdtrAcct_Tp_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Tp_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="CdtrAcct/Ccy" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ccy"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Ccy_name</xsl:variable>
</xsl:template>
<xsl:template match="CdtrAcct/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/TrnsprtDataSet" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_TrnsprtDataSet_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_TrnsprtDataSet_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DataSetId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipTo" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDataSet/DataSetId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_DataSetId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_DataSetId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDataSet/Buyr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Buyr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Buyr_name')"/>
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
<xsl:template match="TrnsprtDataSet/Sellr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Sellr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Sellr_name')"/>
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
<xsl:template match="TrnsprtDataSet/Consgnr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgnr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Consgnr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgnr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Consgnr/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Consgnr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Consgnr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgnr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Consgnr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Consgnr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgnr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="TrnsprtDataSet/Consgn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgn) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_Consgn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Consgn/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Consgn/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Consgn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgn_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Consgn/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Consgn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Consgn_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="TrnsprtDataSet/ShipTo" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipTo) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_ShipTo_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_ShipTo_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ShipTo/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="ShipTo/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::ShipTo) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_ShipTo_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="ShipTo/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::ShipTo) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_ShipTo_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="TrnsprtDataSet/TrnsprtInf" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtInf) &lt; 1 and count(../preceding-sibling::TrnsprtDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtDataSet_TrnsprtInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtInf_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TrnsprtDocRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtdGoods" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtInf/TrnsprtDocRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDocRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtDocRef) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_TrnsprtDocRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtDocRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDocRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtDocRef/DtOfIsse" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtInf/TrnsprtdGoods" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtdGoods"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtdGoods) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_TrnsprtdGoods_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtdGoods_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PurchsOrdrRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GoodsDesc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtdGoods/PurchsOrdrRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::TrnsprtdGoods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_TrnsprtdGoods_PurchsOrdrRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_PurchsOrdrRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtdGoods/GoodsDesc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_GoodsDesc_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtdGoods/BuyrDfndInf" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrDfndInf) &lt; 1 and count(../preceding-sibling::TrnsprtdGoods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_TrnsprtdGoods_BuyrDfndInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_BuyrDfndInf_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Labl" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtdGoods/SellrDfndInf" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrDfndInf) &lt; 1 and count(../preceding-sibling::TrnsprtdGoods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_TrnsprtdGoods_SellrDfndInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_SellrDfndInf_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Labl" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtInf/Consgnmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgnmt) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_Consgnmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Consgnmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TtlQty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlVol" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlWght" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Consgnmt/TtlQty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlQty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlQty) &lt; 1 and count(../preceding-sibling::Consgnmt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_Consgnmt_TtlQty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlQty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TtlQty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TtlQty/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="Consgnmt/TtlVol" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlVol"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlVol) &lt; 1 and count(../preceding-sibling::Consgnmt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_Consgnmt_TtlVol_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlVol_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TtlVol')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TtlVol/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="Consgnmt/TtlWght" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlWght"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlWght) &lt; 1 and count(../preceding-sibling::Consgnmt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_Consgnmt_TtlWght_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlWght_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Val" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TtlWght')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TtlWght/Val" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtInf/RtgSummry" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RtgSummry) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_RtgSummry_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_RtgSummry_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="IndvTrnsprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MltmdlTrnsprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RtgSummry/IndvTrnsprt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IndvTrnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IndvTrnsprt) &lt; 1 and count(../preceding-sibling::RtgSummry) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_RtgSummry_IndvTrnsprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_IndvTrnsprt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TrnsprtByAir" mode="toc">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea" mode="toc">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad" mode="toc">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail" mode="toc">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByAir" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByAir) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtByAir_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByAir_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DprtureAirprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtByAir/DprtureAirprt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DprtureAirprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DprtureAirprt) &lt; 1 and count(../preceding-sibling::TrnsprtByAir) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_TrnsprtByAir_DprtureAirprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DprtureAirprt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DstnAirprt) &lt; 1 and count(../preceding-sibling::TrnsprtByAir) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_TrnsprtByAir_DstnAirprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DstnAirprt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="TrnsprtByAir/AirCrrierNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtBySea" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtBySea) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtBySea_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtBySea_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PortOfLoadng" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="VsslNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfLoadng" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfLoadng"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtBySea/VsslNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="VsslNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtBySea/SeaCrrierNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SeaCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRoad" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRoad) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtByRoad_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRoad_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PlcOfRct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfRct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRoad/RoadCrrierNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RoadCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRail" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRail) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_IndvTrnsprt_TrnsprtByRail_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRail_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PlcOfRct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfRct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRail/RailCrrierNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RailCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="RtgSummry/MltmdlTrnsprt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MltmdlTrnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MltmdlTrnsprt) &lt; 1 and count(../preceding-sibling::RtgSummry) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_RtgSummry_MltmdlTrnsprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_MltmdlTrnsprt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TakngInChrg" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfFnlDstn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/TakngInChrg" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TakngInChrg"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_TakngInChrg_name</xsl:variable>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/PlcOfFnlDstn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfFnlDstn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtInf/Incotrms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_Incotrms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Incotrms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Lctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtInf/FrghtChrgs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::TrnsprtInf) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtInf_FrghtChrgs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_FrghtChrgs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/InsrncDataSet" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrncDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InsrncDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_InsrncDataSet_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_InsrncDataSet_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DataSetId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FctvDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfIsse" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDocId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Trnsprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrdAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrdGoodsDesc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncConds" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncClauses" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Assrd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClmsPyblAt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClmsPyblIn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSet/DataSetId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_DataSetId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_DataSetId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSet/Issr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Issr) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_Issr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Issr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Issr/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Issr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Issr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Issr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Issr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Issr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Issr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="InsrncDataSet/IsseDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_IsseDt_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/FctvDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FctvDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_FctvDt_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/PlcOfIsse" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfIsse"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PlcOfIsse) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_PlcOfIsse_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_PlcOfIsse_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="StrtNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PlcOfIsse/StrtNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PlcOfIsse/PstCdId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
</xsl:template>
<xsl:template match="PlcOfIsse/TwnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PlcOfIsse/CtrySubDvsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
</xsl:template>
<xsl:template match="PlcOfIsse/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrncDocId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncDocId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDocId_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/Trnsprt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Trnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Trnsprt) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_Trnsprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Trnsprt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TrnsprtByAir" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByAir" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByAir) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtByAir_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByAir_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DprtureAirprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtBySea" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtBySea) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtBySea_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtBySea_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PortOfLoadng" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="VsslNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRoad" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRoad) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtByRoad_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRoad_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PlcOfRct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRail" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRail) &lt; 1 and count(../preceding-sibling::Trnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_Trnsprt_TrnsprtByRail_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRail_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="PlcOfRct" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrdAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrdAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InsrdAmt) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_InsrdAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrdGoodsDesc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrdGoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdGoodsDesc_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrncConds" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncConds"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncConds_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrncClauses" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncClauses"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/Assrd" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Assrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Assrd) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_Assrd_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Assrd_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="InsrncDataSet/ClmsPyblAt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ClmsPyblAt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ClmsPyblAt) &lt; 1 and count(../preceding-sibling::InsrncDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDataSet_ClmsPyblAt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblAt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="StrtNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ClmsPyblAt/StrtNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
</xsl:template>
<xsl:template match="ClmsPyblAt/PstCdId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
</xsl:template>
<xsl:template match="ClmsPyblAt/TwnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="ClmsPyblAt/CtrySubDvsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
</xsl:template>
<xsl:template match="ClmsPyblAt/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSet/ClmsPyblIn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ClmsPyblIn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblIn_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/CertDataSet" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CertDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_CertDataSet_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_CertDataSet_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DataSetId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertfdChrtcs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfIsse" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InspctnDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AuthrsdInspctrInd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Trnsprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GoodsDesc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Manfctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AddtlInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/DataSetId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_DataSetId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_DataSetId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/CertTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSet/LineItm" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItm"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItm) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_LineItm_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_LineItm_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="LineItmId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItm[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItm[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="LineItm/LineItmId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItmId_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItm/PurchsOrdrRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::LineItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItm_PurchsOrdrRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_PurchsOrdrRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/CertfdChrtcs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertfdChrtcs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CertfdChrtcs) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_CertfdChrtcs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertfdChrtcs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="CertDataSet/IsseDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_IsseDt_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSet/PlcOfIsse" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfIsse"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PlcOfIsse) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_PlcOfIsse_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_PlcOfIsse_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="StrtNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/Issr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Issr) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Issr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Issr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/InspctnDt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InspctnDt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InspctnDt) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_InspctnDt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_InspctnDt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="FrDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InspctnDt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ToDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InspctnDt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InspctnDt/FrDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FrDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_FrDt_name</xsl:variable>
</xsl:template>
<xsl:template match="InspctnDt/ToDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ToDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_ToDt_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSet/AuthrsdInspctrInd" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AuthrsdInspctrInd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AuthrsdInspctrInd_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSet/CertId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertId_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSet/Trnsprt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Trnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Trnsprt) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Trnsprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Trnsprt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TrnsprtByAir" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/GoodsDesc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_GoodsDesc_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSet/Consgnr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgnr) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Consgnr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgnr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/Consgn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgn) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Consgn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSet/Manfctr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Manfctr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Manfctr) &lt; 1 and count(../preceding-sibling::CertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertDataSet_Manfctr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Manfctr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Manfctr/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Manfctr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Manfctr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Manfctr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name')"/>
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
<xsl:template match="Manfctr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Manfctr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Manfctr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="CertDataSet/AddtlInf" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AddtlInf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AddtlInf_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/OthrCertDataSet" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrCertDataSet"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrCertDataSet) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_OthrCertDataSet_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_OthrCertDataSet_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DataSetId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSet/DataSetId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::DataSetId) &lt; 1 and count(../preceding-sibling::OthrCertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_OthrCertDataSet_DataSetId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_DataSetId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertId_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrCertDataSet/IsseDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_IsseDt_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrCertDataSet/Issr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Issr) &lt; 1 and count(../preceding-sibling::OthrCertDataSet) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_OthrCertDataSet_Issr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_Issr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertInf" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertInf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertInf_name</xsl:variable>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/ReqForActn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ReqForActn) &lt; 1 and count(../preceding-sibling::FwdDataSetSubmissnRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_FwdDataSetSubmissnRpt_ReqForActn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ReqForActn_name')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="ReqForActn/Desc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Desc_name</xsl:variable>
</xsl:template>
</xsl:stylesheet>
