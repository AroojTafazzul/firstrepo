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
<xsl:apply-templates select="ActvtyRpt">
<xsl:with-param name="path">g
                  </xsl:with-param>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/ActvtyRpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ActvtyRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ActvtyRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="RptId">
<xsl:with-param name="path" select="concat($path,'/ActvtyRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdMsgRef">
<xsl:with-param name="path" select="concat($path,'/ActvtyRpt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Rpt">
<xsl:with-param name="path" select="concat($path,'/ActvtyRpt')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ActvtyRpt/RptId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::ActvtyRpt) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityReportV03_ActvtyRpt_RptId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportV03_RptId_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="ActvtyRpt/RltdMsgRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdMsgRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RltdMsgRef) &lt; 1 and count(../preceding-sibling::ActvtyRpt) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityReportV03_ActvtyRpt_RltdMsgRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportV03_RltdMsgRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="ActvtyRpt/Rpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Rpt) &lt; 1 and count(../preceding-sibling::ActvtyRpt) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityReportV03_ActvtyRpt_Rpt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportV03_Rpt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdNtty">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdItm">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgReqForActn">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Rpt/TxId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_ActivityReportItems2_TxId_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Rpt/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_UsrTxRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_DocumentIdentification5_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_ActvtyRpt_DocumentIdentification5_UsrTxRef_IdIssr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Rpt/RptdNtty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdNtty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptdNtty) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_RptdNtty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_RptdNtty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/RptdNtty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptdNtty/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Rpt/RptdItm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdItm"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptdItm) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_RptdItm_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_RptdItm_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="DtTm">
<xsl:with-param name="path" select="concat($path,'/RptdItm[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Actvty">
<xsl:with-param name="path" select="concat($path,'/RptdItm[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Initr">
<xsl:with-param name="path" select="concat($path,'/RptdItm[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptdItm/DtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_ActivityDetails1_DtTm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="RptdItm/Actvty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Actvty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Actvty) &lt; 1 and count(../preceding-sibling::RptdItm) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityDetails1_RptdItm_Actvty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityDetails1_Actvty_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="MsgNm">
<xsl:with-param name="path" select="concat($path,'/Actvty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/Actvty')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Actvty/MsgNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MsgNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_Activity1_MsgNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Actvty/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_Activity1_Desc_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="RptdItm/Initr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Initr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Initr) &lt; 1 and count(../preceding-sibling::RptdItm) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityDetails1_RptdItm_Initr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityDetails1_Initr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Initr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Initr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Rpt/PdgReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgReqForActn) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:block id="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_PdgReqForActn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_PdgReqForActn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/PdgReqForActn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/PdgReqForActn[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PdgReqForActn/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_PendingActivity2_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_SBTW')"/>
</xsl:when>
<xsl:when test=". = 'RSTW'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_RSTW')"/>
</xsl:when>
<xsl:when test=". = 'RSBS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_RSBS')"/>
</xsl:when>
<xsl:when test=". = 'ARDM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_ARDM')"/>
</xsl:when>
<xsl:when test=". = 'ARCS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_ARCS')"/>
</xsl:when>
<xsl:when test=". = 'ARES'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_ARES')"/>
</xsl:when>
<xsl:when test=". = 'WAIT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_WAIT')"/>
</xsl:when>
<xsl:when test=". = 'UPDT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_UPDT')"/>
</xsl:when>
<xsl:when test=". = 'SBDS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_SBDS')"/>
</xsl:when>
<xsl:when test=". = 'ARBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_ARBA')"/>
</xsl:when>
<xsl:when test=". = 'ARRO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_ARRO')"/>
</xsl:when>
<xsl:when test=". = 'CINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_PendingActivity2_Tp_code_CINR')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PdgReqForActn/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_PendingActivity2_Desc_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:apply-templates select="ActvtyRpt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/ActvtyRpt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ActvtyRpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ActvtyRpt) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="RptId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ActvtyRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdMsgRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ActvtyRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Rpt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ActvtyRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ActvtyRpt/RptId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptId) &lt; 1 and count(../preceding-sibling::ActvtyRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityReportV03_ActvtyRpt_RptId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportV03_RptId_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="RptId/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="ActvtyRpt/RltdMsgRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdMsgRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RltdMsgRef) &lt; 1 and count(../preceding-sibling::ActvtyRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityReportV03_ActvtyRpt_RltdMsgRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportV03_RltdMsgRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="RltdMsgRef/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="ActvtyRpt/Rpt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rpt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Rpt) &lt; 1 and count(../preceding-sibling::ActvtyRpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityReportV03_ActvtyRpt_Rpt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportV03_Rpt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="TxId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdNtty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdItm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgReqForActn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Rpt[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Rpt/TxId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_ActivityReportItems2_TxId_name</xsl:variable>
</xsl:template>
<xsl:template match="Rpt/UsrTxRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UsrTxRef) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_UsrTxRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_UsrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_DocumentIdentification5_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::IdIssr) &lt; 1 and count(../preceding-sibling::UsrTxRef) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_DocumentIdentification5_UsrTxRef_IdIssr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_DocumentIdentification5_IdIssr_name')"/>
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
<xsl:variable name="label">XSL_TSU_ActvtyRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Rpt/RptdNtty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdNtty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptdNtty) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_RptdNtty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_RptdNtty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdNtty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptdNtty/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Rpt/RptdItm" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdItm"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RptdItm) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_RptdItm_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_RptdItm_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="DtTm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdItm[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Actvty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdItm[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Initr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RptdItm[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RptdItm/DtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_ActivityDetails1_DtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="RptdItm/Actvty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Actvty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Actvty) &lt; 1 and count(../preceding-sibling::RptdItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityDetails1_RptdItm_Actvty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityDetails1_Actvty_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="MsgNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Actvty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Actvty')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Actvty/MsgNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MsgNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_Activity1_MsgNm_name</xsl:variable>
</xsl:template>
<xsl:template match="Actvty/Desc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_Activity1_Desc_name</xsl:variable>
</xsl:template>
<xsl:template match="RptdItm/Initr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Initr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Initr) &lt; 1 and count(../preceding-sibling::RptdItm) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityDetails1_RptdItm_Initr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityDetails1_Initr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Initr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Initr/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Rpt/PdgReqForActn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgReqForActn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdgReqForActn) &lt; 1 and count(../preceding-sibling::Rpt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_ActvtyRpt_ActivityReportItems2_Rpt_PdgReqForActn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_ActvtyRpt_ActivityReportItems2_PdgReqForActn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PdgReqForActn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PdgReqForActn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PdgReqForActn/Tp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_PendingActivity2_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="PdgReqForActn/Desc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_ActvtyRpt_PendingActivity2_Desc_name</xsl:variable>
</xsl:template>
</xsl:stylesheet>
