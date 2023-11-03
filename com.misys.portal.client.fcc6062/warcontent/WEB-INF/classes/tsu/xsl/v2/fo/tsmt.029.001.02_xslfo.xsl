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
<xsl:apply-templates select="StsChngReqRjctn">
<xsl:with-param name="path">g
                  </xsl:with-param>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/StsChngReqRjctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StsChngReqRjctn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::StsChngReqRjctn) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:block id="XSL_TSU_StsChngReqRjctn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="RjctnId">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitrTxRef">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RjctdStsChng">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RjctnRsn">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="StsChngReqRjctn/RjctnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctnId) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:block id="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_RjctnId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_RjctnId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/RjctnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/RjctnId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="RjctnId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="StsChngReqRjctn/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:block id="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_TxId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_TxId_name')"/>
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
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_SimpleIdentificationInformation_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="StsChngReqRjctn/SubmitrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmitrTxRef) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:block id="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_SubmitrTxRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_SubmitrTxRef_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmitrTxRef')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SubmitrTxRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_SimpleIdentificationInformation_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="StsChngReqRjctn/RjctdStsChng">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctdStsChng"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctdStsChng) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:block id="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_RjctdStsChng_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_RjctdStsChng_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/RjctdStsChng')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctdStsChng/Sts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_TransactionStatus3_Sts_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'COMP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_TransactionStatus3_Sts_code_COMP')"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_TransactionStatus3_Sts_code_CLSD')"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_TransactionStatus3_Sts_code_ACTV')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StsChngReqRjctn/RjctnRsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctnRsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctnRsn) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:block id="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_RjctnRsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_RjctnRsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/RjctnRsn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctnRsn/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_Reason2_Desc_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:apply-templates select="StsChngReqRjctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/StsChngReqRjctn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StsChngReqRjctn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::StsChngReqRjctn) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_StsChngReqRjctn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="RjctnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitrTxRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RjctdStsChng" mode="toc">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RjctnRsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/StsChngReqRjctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="StsChngReqRjctn/RjctnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctnId) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_RjctnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_RjctnId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RjctnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RjctnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctnId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="RjctnId/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="StsChngReqRjctn/TxId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TxId) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_TxId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_TxId_name')"/>
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
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_SimpleIdentificationInformation_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="StsChngReqRjctn/SubmitrTxRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmitrTxRef) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_SubmitrTxRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_SubmitrTxRef_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SubmitrTxRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SubmitrTxRef/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_SimpleIdentificationInformation_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="StsChngReqRjctn/RjctdStsChng" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctdStsChng"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctdStsChng) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_RjctdStsChng_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_RjctdStsChng_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Sts" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RjctdStsChng')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctdStsChng/Sts" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_TransactionStatus3_Sts_name</xsl:variable>
</xsl:template>
<xsl:template match="StsChngReqRjctn/RjctnRsn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RjctnRsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RjctnRsn) &lt; 1 and count(../preceding-sibling::StsChngReqRjctn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_StsChngReqRjctn_RjctnRsn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_StsChngReqRjctn_StatusChangeRequestRejectionV02_RjctnRsn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Desc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RjctnRsn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RjctnRsn/Desc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_StsChngReqRjctn_Reason2_Desc_name</xsl:variable>
</xsl:template>
</xsl:stylesheet>