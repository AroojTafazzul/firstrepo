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
<xsl:apply-templates select="InitlBaselnSubmissn">
<xsl:with-param name="path">g
                  </xsl:with-param>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/InitlBaselnSubmissn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InitlBaselnSubmissn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InitlBaselnSubmissn) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="SubmissnId">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitrTxRef">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Instr">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Baseln">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrCtctPrsn">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrCtctPrsn">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBkCtctPrsn">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBkCtctPrsn">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrBkCtctPrsn">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SubmissnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmissnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmissnId) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_SubmissnId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmissnId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SubmissnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SubmissnId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InitlBaselnSubmissn/SubmitrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmitrTxRef) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_SubmitrTxRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmitrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InitlBaselnSubmissn/Instr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Instr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Instr) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_Instr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Instr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Instr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Instr/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'LODG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_code_LODG')"/>
</xsl:when>
<xsl:when test=". = 'FPTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_code_FPTR')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/Baseln">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Baseln"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Baseln) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_Baseln_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Baseln_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="SubmitrBaselnId">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SvcCd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrSdSubmitgBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrSdSubmitgBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BllTo">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipTo">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Goods">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtOblgtn">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstMtchDt">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrCertDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InttToPayXpctd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Baseln/SubmitrBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmitrBaselnId) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SubmitrBaselnId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SubmitrBaselnId_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SubmitrBaselnId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Vrsn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SubmitrBaselnId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::SubmitrBaselnId) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_SubmitrBaselnId_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Submitr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/SvcCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SvcCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'LEV1'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV1')"/>
</xsl:when>
<xsl:when test=". = 'LEV2'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV2')"/>
</xsl:when>
<xsl:when test=". = 'LEV3'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV3')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Baseln/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_PurchsOrdrRef_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PurchsOrdrRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Buyr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Buyr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Buyr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Buyr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Sellr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Sellr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Sellr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Sellr_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_BuyrBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SellrBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/BuyrSdSubmitgBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrSdSubmitgBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrSdSubmitgBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_BuyrSdSubmitgBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrSdSubmitgBk_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/BuyrSdSubmitgBk[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrSdSubmitgBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/SellrSdSubmitgBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrSdSubmitgBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrSdSubmitgBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SellrSdSubmitgBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrSdSubmitgBk_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SellrSdSubmitgBk[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrSdSubmitgBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/BllTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BllTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BllTo) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_BllTo_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BllTo_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_BllTo_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_BllTo_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/ShipTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipTo) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_ShipTo_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_ShipTo_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_ShipTo_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_ShipTo_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/Consgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgn) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Consgn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Consgn_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Consgn_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Consgn_PstlAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/Goods">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Goods"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Goods) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Goods_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Goods_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="GoodsDesc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtlShipmnt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsShipmnt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipmntDtRg">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmDtls">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/GoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Goods/PrtlShipmnt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PrtlShipmnt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_PrtlShipmnt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Goods/TrnsShipmnt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TrnsShipmnt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_TrnsShipmnt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Goods/ShipmntDtRg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntDtRg"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipmntDtRg) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_ShipmntDtRg_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_ShipmntDtRg_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="EarlstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ShipmntDtRg/EarlstShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EarlstShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="ShipmntDtRg/LatstShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LatstShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Goods/LineItmDtls">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmDtls"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItmDtls) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_LineItmDtls_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmDtls_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="QtyTlrnce">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UnitPric">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PricTlrnce">
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
<xsl:apply-templates select="PdctOrgn">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipmntSchdl">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="LineItmDtls/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/Qty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Qty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Qty_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Qty_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_TNE')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_QtyTlrnce_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_QtyTlrnce_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/UnitPric">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitPric"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UnitPric) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_UnitPric_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_UnitPric_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitPric_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_KGM')"/>
</xsl:when>
<xsl:when test=". = 'EA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_EA')"/>
</xsl:when>
<xsl:when test=". = 'LTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LTN')"/>
</xsl:when>
<xsl:when test=". = 'MTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MTR')"/>
</xsl:when>
<xsl:when test=". = 'INH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_INH')"/>
</xsl:when>
<xsl:when test=". = 'LY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LY')"/>
</xsl:when>
<xsl:when test=". = 'GLI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_GLI')"/>
</xsl:when>
<xsl:when test=". = 'GRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_GRM')"/>
</xsl:when>
<xsl:when test=". = 'CMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CMT')"/>
</xsl:when>
<xsl:when test=". = 'MTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MTK')"/>
</xsl:when>
<xsl:when test=". = 'FOT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_FOT')"/>
</xsl:when>
<xsl:when test=". = '1A'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_1A')"/>
</xsl:when>
<xsl:when test=". = 'INK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_INK')"/>
</xsl:when>
<xsl:when test=". = 'FTK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_FTK')"/>
</xsl:when>
<xsl:when test=". = 'MIK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MIK')"/>
</xsl:when>
<xsl:when test=". = 'ONZ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_ONZ')"/>
</xsl:when>
<xsl:when test=". = 'PTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_PTI')"/>
</xsl:when>
<xsl:when test=". = 'PT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_PT')"/>
</xsl:when>
<xsl:when test=". = 'QTI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_QTI')"/>
</xsl:when>
<xsl:when test=". = 'QT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_QT')"/>
</xsl:when>
<xsl:when test=". = 'GLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_GLL')"/>
</xsl:when>
<xsl:when test=". = 'MMT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MMT')"/>
</xsl:when>
<xsl:when test=". = 'KTM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_KTM')"/>
</xsl:when>
<xsl:when test=". = 'YDK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_YDK')"/>
</xsl:when>
<xsl:when test=". = 'MMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MMK')"/>
</xsl:when>
<xsl:when test=". = 'CMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CMK')"/>
</xsl:when>
<xsl:when test=". = 'KMK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_KMK')"/>
</xsl:when>
<xsl:when test=". = 'MMQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MMQ')"/>
</xsl:when>
<xsl:when test=". = 'CLT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CLT')"/>
</xsl:when>
<xsl:when test=". = 'LTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LTR')"/>
</xsl:when>
<xsl:when test=". = 'LBR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LBR')"/>
</xsl:when>
<xsl:when test=". = 'STN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_STN')"/>
</xsl:when>
<xsl:when test=". = 'BLL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BLL')"/>
</xsl:when>
<xsl:when test=". = 'BX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BX')"/>
</xsl:when>
<xsl:when test=". = 'BO'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BO')"/>
</xsl:when>
<xsl:when test=". = 'CT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CT')"/>
</xsl:when>
<xsl:when test=". = 'CH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CH')"/>
</xsl:when>
<xsl:when test=". = 'CR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CR')"/>
</xsl:when>
<xsl:when test=". = 'INQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_INQ')"/>
</xsl:when>
<xsl:when test=". = 'MTQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MTQ')"/>
</xsl:when>
<xsl:when test=". = 'OZI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_OZI')"/>
</xsl:when>
<xsl:when test=". = 'OZA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_OZA')"/>
</xsl:when>
<xsl:when test=". = 'BG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BG')"/>
</xsl:when>
<xsl:when test=". = 'BL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BL')"/>
</xsl:when>
<xsl:when test=". = 'TNE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_TNE')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/PricTlrnce">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PricTlrnce"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PricTlrnce) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PricTlrnce_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PricTlrnce_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctIdr_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_PdctIdr_StrdPdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_StrdPdctIdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_BINR')"/>
</xsl:when>
<xsl:when test=". = 'COMD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_COMD')"/>
</xsl:when>
<xsl:when test=". = 'EANC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_EANC')"/>
</xsl:when>
<xsl:when test=". = 'HRTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_HRTR')"/>
</xsl:when>
<xsl:when test=". = 'MANI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_MANI')"/>
</xsl:when>
<xsl:when test=". = 'MODL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_MODL')"/>
</xsl:when>
<xsl:when test=". = 'PART'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_PART')"/>
</xsl:when>
<xsl:when test=". = 'QOTA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_QOTA')"/>
</xsl:when>
<xsl:when test=". = 'STYL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_STYL')"/>
</xsl:when>
<xsl:when test=". = 'SUPI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_SUPI')"/>
</xsl:when>
<xsl:when test=". = 'UPCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_UPCC')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Idr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_PdctIdr_OthrPdctIdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_OthrPdctIdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctChrtcs_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_PdctChrtcs_StrdPdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_StrdPdctChrtcs_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_BISP')"/>
</xsl:when>
<xsl:when test=". = 'CHNR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_CHNR')"/>
</xsl:when>
<xsl:when test=". = 'CLOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_CLOR')"/>
</xsl:when>
<xsl:when test=". = 'EDSP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_EDSP')"/>
</xsl:when>
<xsl:when test=". = 'ENNR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_ENNR')"/>
</xsl:when>
<xsl:when test=". = 'OPTN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_OPTN')"/>
</xsl:when>
<xsl:when test=". = 'ORCR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_ORCR')"/>
</xsl:when>
<xsl:when test=". = 'PCTV'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_PCTV')"/>
</xsl:when>
<xsl:when test=". = 'SISP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SISP')"/>
</xsl:when>
<xsl:when test=". = 'SIZE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SIZE')"/>
</xsl:when>
<xsl:when test=". = 'SZRG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SZRG')"/>
</xsl:when>
<xsl:when test=". = 'SPRM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SPRM')"/>
</xsl:when>
<xsl:when test=". = 'STOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_STOR')"/>
</xsl:when>
<xsl:when test=". = 'VINR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_VINR')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Chrtcs_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_PdctChrtcs_OthrPdctChrtcs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_OthrPdctChrtcs_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctCtgy_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_PdctCtgy_StrdPdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_StrdPdctCtgy_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_HRTR')"/>
</xsl:when>
<xsl:when test=". = 'QOTA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_QOTA')"/>
</xsl:when>
<xsl:when test=". = 'PRGP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_PRGP')"/>
</xsl:when>
<xsl:when test=". = 'LOBU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_LOBU')"/>
</xsl:when>
<xsl:when test=". = 'GNDR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_GNDR')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Ctgy_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_PdctCtgy_OthrPdctCtgy_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_OthrPdctCtgy_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/PdctOrgn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctOrgn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/ShipmntSchdl">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntSchdl"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipmntSchdl) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_ShipmntSchdl_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_ShipmntSchdl_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="ShipmntDtRg">
<xsl:with-param name="path" select="concat($path,'/ShipmntSchdl')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipmntSubSchdl">
<xsl:with-param name="path" select="concat($path,'/ShipmntSchdl')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ShipmntSchdl/ShipmntDtRg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntDtRg"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipmntDtRg) &lt; 1 and count(../preceding-sibling::ShipmntSchdl) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntSchdl_ShipmntDtRg_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntDtRg_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="EarlstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ShipmntSchdl/ShipmntSubSchdl">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntSubSchdl"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipmntSubSchdl) &lt; 1 and count(../preceding-sibling::ShipmntSchdl) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntSchdl_ShipmntSubSchdl_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntSubSchdl_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="SubQtyVal">
<xsl:with-param name="path" select="concat($path,'/ShipmntSubSchdl[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EarlstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntSubSchdl[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntSubSchdl[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ShipmntSubSchdl/SubQtyVal">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SubQtyVal"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_SubQtyVal_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="ShipmntSubSchdl/EarlstShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EarlstShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_EarlstShipmntDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="ShipmntSubSchdl/LatstShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LatstShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_LatstShipmntDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/RtgSummry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RtgSummry) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_RtgSummry_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_RtgSummry_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_TransportMeans1_RtgSummry_IndvTrnsprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtByAir_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByAir_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_TransportByAir3_TrnsprtByAir_DprtureAirprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DprtureAirprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="AirprtCd">
<xsl:with-param name="path" select="concat($path,'/DprtureAirprt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrAirprtDesc">
<xsl:with-param name="path" select="concat($path,'/DprtureAirprt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DprtureAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_DprtureAirprt_OthrAirprtDesc_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_OthrAirprtDesc_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_TransportByAir3_TrnsprtByAir_DstnAirprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DstnAirprt_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="AirprtCd">
<xsl:with-param name="path" select="concat($path,'/DstnAirprt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrAirprtDesc">
<xsl:with-param name="path" select="concat($path,'/DstnAirprt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="DstnAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_DstnAirprt_OthrAirprtDesc_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_OthrAirprtDesc_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtBySea_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtBySea_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtByRoad_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRoad_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtByRail_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRail_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_TransportMeans1_RtgSummry_MltmdlTrnsprt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_MltmdlTrnsprt_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Incotrms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Incotrms_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Othr">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Incotrms/Lctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_EXW')"/>
</xsl:when>
<xsl:when test=". = 'FCA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FCA')"/>
</xsl:when>
<xsl:when test=". = 'FAS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FAS')"/>
</xsl:when>
<xsl:when test=". = 'FOB'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FOB')"/>
</xsl:when>
<xsl:when test=". = 'CFR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CFR')"/>
</xsl:when>
<xsl:when test=". = 'CIF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CIF')"/>
</xsl:when>
<xsl:when test=". = 'CPT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CPT')"/>
</xsl:when>
<xsl:when test=". = 'CIP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CIP')"/>
</xsl:when>
<xsl:when test=". = 'DAF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DAF')"/>
</xsl:when>
<xsl:when test=". = 'DES'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DES')"/>
</xsl:when>
<xsl:when test=". = 'DEQ'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DEQ')"/>
</xsl:when>
<xsl:when test=". = 'DDU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DDU')"/>
</xsl:when>
<xsl:when test=". = 'DDP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DDP')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Adjstmnt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Adjstmnt_name')"/>
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
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Adjstmnt/Drctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Drctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_ADDD')"/>
</xsl:when>
<xsl:when test=". = 'SUBS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_SUBS')"/>
</xsl:when>
</xsl:choose>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_REBA')"/>
</xsl:when>
<xsl:when test=". = 'DISC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_DISC')"/>
</xsl:when>
<xsl:when test=". = 'CREN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_CREN')"/>
</xsl:when>
<xsl:when test=". = 'SURC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_SURC')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Adjstmnt/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Adjstmnt) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Adjustment3_Adjstmnt_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Adjstmnt/Rate">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_FrghtChrgs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_FrghtChrgs_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_CLCT')"/>
</xsl:when>
<xsl:when test=". = 'PRPD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_PRPD')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Charge12_FrghtChrgs_Chrgs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Chrgs_name')"/>
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
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Chrgs/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_SIGN')"/>
</xsl:when>
<xsl:when test=". = 'STDE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_STDE')"/>
</xsl:when>
<xsl:when test=". = 'STOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_STOR')"/>
</xsl:when>
<xsl:when test=". = 'PACK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_PACK')"/>
</xsl:when>
<xsl:when test=". = 'PICK'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_PICK')"/>
</xsl:when>
<xsl:when test=". = 'DNGR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_DNGR')"/>
</xsl:when>
<xsl:when test=". = 'SECU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_SECU')"/>
</xsl:when>
<xsl:when test=". = 'INSU'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_INSU')"/>
</xsl:when>
<xsl:when test=". = 'COLF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_COLF')"/>
</xsl:when>
<xsl:when test=". = 'CHOR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_CHOR')"/>
</xsl:when>
<xsl:when test=". = 'CHDE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_CHDE')"/>
</xsl:when>
<xsl:when test=". = 'AIRF'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_AIRF')"/>
</xsl:when>
<xsl:when test=". = 'TRPT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_TRPT')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Chrgs/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Chrgs) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Chrgs_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Chrgs/Rate">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/Tax">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tax) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Tax_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Tax_name')"/>
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
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Tax/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_PROV')"/>
</xsl:when>
<xsl:when test=". = 'NATI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_NATI')"/>
</xsl:when>
<xsl:when test=". = 'STAT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAT')"/>
</xsl:when>
<xsl:when test=". = 'WITH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_WITH')"/>
</xsl:when>
<xsl:when test=". = 'STAM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAM')"/>
</xsl:when>
<xsl:when test=". = 'COAX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_COAX')"/>
</xsl:when>
<xsl:when test=". = 'VATA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_VATA')"/>
</xsl:when>
<xsl:when test=". = 'CUST'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_CUST')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::Tax) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Tax13_Tax_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Tax/Rate">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="LineItmDtls/TtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_TtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_LineItmsTtlAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmsTtlAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmsTtlAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/RtgSummry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RtgSummry) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_RtgSummry_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_RtgSummry_name')"/>
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
<xsl:template match="Goods/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_Incotrms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Incotrms_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Othr">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_Adjstmnt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Adjstmnt_name')"/>
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
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_FrghtChrgs_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_FrghtChrgs_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_Tax_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Tax_name')"/>
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
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/TtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlNetAmt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_TtlNetAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_TtlNetAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_TtlNetAmt_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_BuyrDfndInf_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_BuyrDfndInf_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_SellrDfndInf_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_SellrDfndInf_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/PmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtTerms) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_PmtTerms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtTerms_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_OthrPmtTerms_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_PmtTerms_PmtCd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_PmtCd_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_CASH')"/>
</xsl:when>
<xsl:when test=". = 'EMTD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EMTD')"/>
</xsl:when>
<xsl:when test=". = 'EPRD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EPRD')"/>
</xsl:when>
<xsl:when test=". = 'PRMD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_PRMD')"/>
</xsl:when>
<xsl:when test=". = 'IREC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_IREC')"/>
</xsl:when>
<xsl:when test=". = 'PRMR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_PRMR')"/>
</xsl:when>
<xsl:when test=". = 'EPRR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EPRR')"/>
</xsl:when>
<xsl:when test=". = 'EMTR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EMTR')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_NbOfDays_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Pctg_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_PmtTerms_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Baseln/SttlmTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SttlmTerms) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SttlmTerms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SttlmTerms_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_SttlmTerms_CdtrAgt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAgt_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_CdtrAgt_NmAndAdr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_NmAndAdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_NmAndAdr_Adr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Adr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_StrtNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_PstCdId_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_TwnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_Ctry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_SttlmTerms_CdtrAcct_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name')"/>
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_CashAccount7_CdtrAcct_Id_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_Id_PrtryAcct_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_PrtryAcct_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<fo:block id="XSL_TSU_InitlBaselnSubmissn_CashAccount7_CdtrAcct_Tp_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Tp_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CASH')"/>
</xsl:when>
<xsl:when test=". = 'CHAR'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CHAR')"/>
</xsl:when>
<xsl:when test=". = 'COMM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_COMM')"/>
</xsl:when>
<xsl:when test=". = 'TAXE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_TAXE')"/>
</xsl:when>
<xsl:when test=". = 'CISH'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CISH')"/>
</xsl:when>
<xsl:when test=". = 'TRAS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_TRAS')"/>
</xsl:when>
<xsl:when test=". = 'SACC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_SACC')"/>
</xsl:when>
<xsl:when test=". = 'CACC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CACC')"/>
</xsl:when>
<xsl:when test=". = 'SVGS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_SVGS')"/>
</xsl:when>
<xsl:when test=". = 'ONDP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_ONDP')"/>
</xsl:when>
<xsl:when test=". = 'MGLD'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_MGLD')"/>
</xsl:when>
<xsl:when test=". = 'NREX'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_NREX')"/>
</xsl:when>
<xsl:when test=". = 'MOMA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_MOMA')"/>
</xsl:when>
<xsl:when test=". = 'LOAN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_LOAN')"/>
</xsl:when>
<xsl:when test=". = 'SLRY'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_SLRY')"/>
</xsl:when>
<xsl:when test=". = 'ODFT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_ODFT')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/PmtOblgtn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtOblgtn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtOblgtn) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_PmtOblgtn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtOblgtn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="OblgrBk">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RcptBk">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Pctg">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ChrgsAmt">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ChrgsPctg">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="XpryDt">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AplblLaw">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PmtOblgtn/OblgrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OblgrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OblgrBk) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_OblgrBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_OblgrBk_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/OblgrBk')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OblgrBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="PmtOblgtn/RcptBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RcptBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RcptBk) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_RcptBk_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_RcptBk_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/RcptBk')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RcptBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="PmtOblgtn/ChrgsAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ChrgsAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ChrgsAmt) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_ChrgsAmt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PmtOblgtn/ChrgsPctg">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ChrgsPctg"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="PmtOblgtn/XpryDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="XpryDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="PmtOblgtn/AplblLaw">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AplblLaw"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="PmtOblgtn/PmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtTerms) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_PmtTerms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtTerms_name')"/>
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
<xsl:template match="PmtOblgtn/SttlmTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SttlmTerms) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_SttlmTerms_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_SttlmTerms_name')"/>
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
<xsl:template match="PmtOblgtn/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Amt) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_Amt_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_name')"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_name')"/>
</xsl:with-param>
<xsl:with-param name="right_text">
<xsl:value-of select="@Ccy"/>
<xsl:value-of select="."/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PmtOblgtn/Pctg">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Pctg"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Pctg_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/LatstMtchDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LatstMtchDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/ComrclDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_ComrclDataSetReqrd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_ComrclDataSetReqrd_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSetReqrd')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::ComrclDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_ComrclDataSetReqrd_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Baseln/TrnsprtDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_TrnsprtDataSetReqrd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_TrnsprtDataSetReqrd_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSetReqrd')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_TrnsprtDataSetReqrd_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Baseln/InsrncDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrncDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InsrncDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_InsrncDataSetReqrd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_InsrncDataSetReqrd_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIssr">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIsseDt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchTrnsprt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchAmt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClausesReqrd">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchAssrdPty">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::InsrncDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_InsrncDataSetReqrd_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_Submitr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MtchIssr) &lt; 1 and count(../preceding-sibling::InsrncDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_InsrncDataSetReqrd_MtchIssr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIssr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MtchIssr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="MtchIssr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::MtchIssr) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_MtchIssr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name')"/>
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
<xsl:template match="MtchIssr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InsrncDataSetReqrd/MtchIsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIsseDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InsrncDataSetReqrd/MtchTrnsprt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchTrnsprt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchTrnsprt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InsrncDataSetReqrd/MtchAmt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchAmt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAmt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InsrncDataSetReqrd/ClausesReqrd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ClausesReqrd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCA')"/>
</xsl:when>
<xsl:when test=". = 'ICCB'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCB')"/>
</xsl:when>
<xsl:when test=". = 'ICCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCC')"/>
</xsl:when>
<xsl:when test=". = 'ICAI'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICAI')"/>
</xsl:when>
<xsl:when test=". = 'IWCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IWCC')"/>
</xsl:when>
<xsl:when test=". = 'ISCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISCC')"/>
</xsl:when>
<xsl:when test=". = 'IREC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IREC')"/>
</xsl:when>
<xsl:when test=". = 'ICLC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICLC')"/>
</xsl:when>
<xsl:when test=". = 'ISMC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISMC')"/>
</xsl:when>
<xsl:when test=". = 'CMCC'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_CMCC')"/>
</xsl:when>
<xsl:when test=". = 'IRCE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IRCE')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchAssrdPty">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchAssrdPty"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'BUYE'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUYE')"/>
</xsl:when>
<xsl:when test=". = 'SELL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SELL')"/>
</xsl:when>
<xsl:when test=". = 'BUBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUBA')"/>
</xsl:when>
<xsl:when test=". = 'SEBA'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SEBA')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Baseln/CertDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CertDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_CertDataSetReqrd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_CertDataSetReqrd_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIssr">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIsseDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchInspctnDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AuthrsdInspctrInd">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchConsgn">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchManfctr">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::CertDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertDataSetReqrd_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_Submitr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSetReqrd/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ANLY')"/>
</xsl:when>
<xsl:when test=". = 'QUAL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAL')"/>
</xsl:when>
<xsl:when test=". = 'QUAN'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAN')"/>
</xsl:when>
<xsl:when test=". = 'WEIG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_WEIG')"/>
</xsl:when>
<xsl:when test=". = 'ORIG'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ORIG')"/>
</xsl:when>
<xsl:when test=". = 'HEAL'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_HEAL')"/>
</xsl:when>
<xsl:when test=". = 'PHYT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_PHYT')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MtchIssr) &lt; 1 and count(../preceding-sibling::CertDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertDataSetReqrd_MtchIssr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIssr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchIsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIsseDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="CertDataSetReqrd/MtchInspctnDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchInspctnDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchInspctnDt_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="CertDataSetReqrd/AuthrsdInspctrInd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AuthrsdInspctrInd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_AuthrsdInspctrInd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="CertDataSetReqrd/MtchConsgn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchConsgn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchConsgn_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="CertDataSetReqrd/MtchManfctr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchManfctr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MtchManfctr) &lt; 1 and count(../preceding-sibling::CertDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertDataSetReqrd_MtchManfctr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchManfctr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MtchManfctr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="MtchManfctr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::MtchManfctr) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_MtchManfctr_PrtryId_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name')"/>
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
<xsl:template match="MtchManfctr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="CertDataSetReqrd/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="Baseln/OthrCertDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrCertDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrCertDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_OthrCertDataSetReqrd_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_OthrCertDataSetReqrd_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::OthrCertDataSetReqrd) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_OthrCertDataSetReqrd_Submitr_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_Submitr_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_BENE')"/>
</xsl:when>
<xsl:when test=". = 'SHIP'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_SHIP')"/>
</xsl:when>
<xsl:when test=". = 'UND1'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND1')"/>
</xsl:when>
<xsl:when test=". = 'UND2'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND2')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Baseln/InttToPayXpctd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InttToPayXpctd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_InttToPayXpctd_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InitlBaselnSubmissn/BuyrCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_BuyrCtctPrsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_BuyrCtctPrsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'DOCT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')"/>
</xsl:when>
<xsl:when test=". = 'MIST'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')"/>
</xsl:when>
<xsl:when test=". = 'MISS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')"/>
</xsl:when>
<xsl:when test=". = 'MADM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InitlBaselnSubmissn/SellrCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_SellrCtctPrsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SellrCtctPrsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'DOCT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')"/>
</xsl:when>
<xsl:when test=". = 'MIST'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')"/>
</xsl:when>
<xsl:when test=". = 'MISS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')"/>
</xsl:when>
<xsl:when test=". = 'MADM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="SellrCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InitlBaselnSubmissn/OthrBkCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrBkCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrBkCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_OthrBkCtctPrsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_OthrBkCtctPrsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="OthrBkCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="OthrBkCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'DOCT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_DOCT')"/>
</xsl:when>
<xsl:when test=". = 'MIST'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MIST')"/>
</xsl:when>
<xsl:when test=". = 'MISS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MISS')"/>
</xsl:when>
<xsl:when test=". = 'MADM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MADM')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="OthrBkCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="OthrBkCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="OthrBkCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="OthrBkCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InitlBaselnSubmissn/BuyrBkCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBkCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBkCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_BuyrBkCtctPrsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_BuyrBkCtctPrsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/BuyrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/BuyrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/BuyrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/BuyrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/BuyrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/BuyrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/BuyrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrBkCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'DOCT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')"/>
</xsl:when>
<xsl:when test=". = 'MIST'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')"/>
</xsl:when>
<xsl:when test=". = 'MISS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')"/>
</xsl:when>
<xsl:when test=". = 'MADM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrBkCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrBkCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrBkCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="BuyrBkCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="InitlBaselnSubmissn/SellrBkCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBkCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBkCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:block id="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_SellrBkCtctPrsn_name"/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SellrBkCtctPrsn_name')"/>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/SellrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/SellrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/SellrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/SellrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/SellrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/SellrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/SellrBkCtctPrsn[', $index,']')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrBkCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:when test=". = 'DOCT'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')"/>
</xsl:when>
<xsl:when test=". = 'MIST'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')"/>
</xsl:when>
<xsl:when test=". = 'MISS'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')"/>
</xsl:when>
<xsl:when test=". = 'MADM'">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrBkCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrBkCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrBkCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:template match="SellrBkCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
<xsl:call-template name="table_template">
<xsl:with-param name="text">
<xsl:call-template name="table_cell">
<xsl:with-param name="left_text">
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
<xsl:apply-templates select="InitlBaselnSubmissn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/InitlBaselnSubmissn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InitlBaselnSubmissn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InitlBaselnSubmissn) &lt; 1 and count(../preceding-sibling::Document) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="SubmissnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitrTxRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Instr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Baseln" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrCtctPrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrCtctPrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrBkCtctPrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SubmissnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmissnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmissnId) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_SubmissnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmissnId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SubmissnId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="SubmissnId/CreDtTm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_CreDtTm_name</xsl:variable>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SubmitrTxRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmitrTxRef) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_SubmitrTxRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmitrTxRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/Instr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Instr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Instr) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_Instr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Instr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Tp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Instr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Instr/Tp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/Baseln" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Baseln"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Baseln) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_Baseln_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Baseln_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="SubmitrBaselnId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SvcCd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrSdSubmitgBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrSdSubmitgBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BllTo" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipTo" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Goods" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtOblgtn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstMtchDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDataSetReqrd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtDataSetReqrd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDataSetReqrd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertDataSetReqrd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrCertDataSetReqrd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InttToPayXpctd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Baseln/SubmitrBaselnId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrBaselnId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SubmitrBaselnId) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SubmitrBaselnId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SubmitrBaselnId_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Id" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Id" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Vrsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Vrsn_name</xsl:variable>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::SubmitrBaselnId) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_SubmitrBaselnId_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Submitr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/SvcCd" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SvcCd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/PurchsOrdrRef" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PurchsOrdrRef) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_PurchsOrdrRef_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PurchsOrdrRef_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="PurchsOrdrRef/DtOfIsse" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_DtOfIsse_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/Buyr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Buyr) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Buyr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Buyr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Buyr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
</xsl:template>
<xsl:template match="PrtryId/IdTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
</xsl:template>
<xsl:template match="Buyr/PstlAdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PstlAdr) &lt; 1 and count(../preceding-sibling::Buyr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Buyr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
</xsl:template>
<xsl:template match="PstlAdr/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/Sellr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Sellr) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Sellr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Sellr_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Sellr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Sellr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Sellr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Sellr_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/BuyrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_BuyrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/SellrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SellrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrBk_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/BuyrSdSubmitgBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrSdSubmitgBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrSdSubmitgBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_BuyrSdSubmitgBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrSdSubmitgBk_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrSdSubmitgBk[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrSdSubmitgBk/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/SellrSdSubmitgBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrSdSubmitgBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrSdSubmitgBk) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SellrSdSubmitgBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrSdSubmitgBk_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrSdSubmitgBk[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrSdSubmitgBk/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/BllTo" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BllTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BllTo) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_BllTo_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BllTo_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="BllTo/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::BllTo) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_BllTo_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_BllTo_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/ShipTo" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipTo"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipTo) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_ShipTo_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_ShipTo_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="ShipTo/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::ShipTo) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_ShipTo_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_ShipTo_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/Consgn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Consgn) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Consgn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Consgn_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Consgn/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::Consgn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Consgn_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Consgn_PstlAdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')"/>
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
<xsl:template match="Baseln/Goods" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Goods"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Goods) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_Goods_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Goods_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="GoodsDesc" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtlShipmnt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsShipmnt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipmntDtRg" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmDtls" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmsTtlAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlNetAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/GoodsDesc" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/PrtlShipmnt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PrtlShipmnt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_PrtlShipmnt_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/TrnsShipmnt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TrnsShipmnt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_TrnsShipmnt_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/ShipmntDtRg" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntDtRg"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipmntDtRg) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_ShipmntDtRg_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_ShipmntDtRg_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="EarlstShipmntDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ShipmntDtRg/EarlstShipmntDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EarlstShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_name</xsl:variable>
</xsl:template>
<xsl:template match="ShipmntDtRg/LatstShipmntDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LatstShipmntDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/LineItmDtls" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmDtls"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::LineItmDtls) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_LineItmDtls_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmDtls_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="LineItmId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="QtyTlrnce" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UnitPric" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PricTlrnce" mode="toc">
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
<xsl:apply-templates select="PdctOrgn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipmntSchdl" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax" mode="toc">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlAmt" mode="toc">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/Qty" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Qty) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Qty_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Qty_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_name</xsl:variable>
</xsl:template>
<xsl:template match="Qty/Fctr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/QtyTlrnce" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="QtyTlrnce"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::QtyTlrnce) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_QtyTlrnce_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_QtyTlrnce_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
</xsl:template>
<xsl:template match="QtyTlrnce/MnsPct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/UnitPric" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitPric"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::UnitPric) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_UnitPric_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_UnitPric_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitPric_Amt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/PricTlrnce" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PricTlrnce"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PricTlrnce) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PricTlrnce_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PricTlrnce_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
</xsl:template>
<xsl:template match="PricTlrnce/MnsPct" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/PdctNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/PdctIdr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PdctIdr) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PdctIdr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctIdr_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PdctChrtcs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctChrtcs_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_PdctCtgy_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctCtgy_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/PdctOrgn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctOrgn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/ShipmntSchdl" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntSchdl"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ShipmntSchdl) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_ShipmntSchdl_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_ShipmntSchdl_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/RtgSummry" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RtgSummry) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_RtgSummry_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_RtgSummry_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_TransportMeans1_RtgSummry_IndvTrnsprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtByAir_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByAir_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_TransportByAir3_TrnsprtByAir_DprtureAirprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DprtureAirprt_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_TransportByAir3_TrnsprtByAir_DstnAirprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DstnAirprt_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtBySea" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtBySea) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtBySea_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtBySea_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtBySea/SeaCrrierNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SeaCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRoad" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRoad) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtByRoad_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRoad_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRoad/RoadCrrierNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RoadCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRail" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtByRail) &lt; 1 and count(../preceding-sibling::IndvTrnsprt) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_SingleTransport4_IndvTrnsprt_TrnsprtByRail_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRail_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_name</xsl:variable>
</xsl:template>
<xsl:template match="TrnsprtByRail/RailCrrierNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RailCrrierNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_name</xsl:variable>
</xsl:template>
<xsl:template match="RtgSummry/MltmdlTrnsprt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MltmdlTrnsprt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MltmdlTrnsprt) &lt; 1 and count(../preceding-sibling::RtgSummry) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_TransportMeans1_RtgSummry_MltmdlTrnsprt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_MltmdlTrnsprt_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_name</xsl:variable>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/PlcOfFnlDstn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfFnlDstn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/Incotrms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Incotrms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Incotrms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Lctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Incotrms/Lctn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/Adjstmnt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Adjstmnt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Adjstmnt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Drctn" mode="toc">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name</xsl:variable>
</xsl:template>
<xsl:template match="LineItmDtls/FrghtChrgs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::FrghtChrgs) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_FrghtChrgs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_FrghtChrgs_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name</xsl:variable>
</xsl:template>
<xsl:template match="FrghtChrgs/Chrgs" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrgs"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Chrgs) &lt; 1 and count(../preceding-sibling::FrghtChrgs) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Charge12_FrghtChrgs_Chrgs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Chrgs_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/Tax" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Tax) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_Tax_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Tax_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="LineItmDtls/TtlAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlAmt) &lt; 1 and count(../preceding-sibling::LineItmDtls) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmDtls_TtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_LineItmsTtlAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmsTtlAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="Goods/RtgSummry" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RtgSummry) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_RtgSummry_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_RtgSummry_name')"/>
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
<xsl:template match="Goods/Incotrms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Incotrms) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_Incotrms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Incotrms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Lctn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Goods/Adjstmnt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Adjstmnt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_Adjstmnt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Adjstmnt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Drctn" mode="toc">
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_FrghtChrgs_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_FrghtChrgs_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_Tax_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Tax_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="Goods/TtlNetAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlNetAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TtlNetAmt) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_TtlNetAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_TtlNetAmt_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_BuyrDfndInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_BuyrDfndInf_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrDfndInf/Inf" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
</xsl:template>
<xsl:template match="Goods/SellrDfndInf" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrDfndInf"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrDfndInf) &lt; 1 and count(../preceding-sibling::Goods) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_LineItem7_Goods_SellrDfndInf_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_SellrDfndInf_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrDfndInf/Inf" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/PmtTerms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtTerms) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_PmtTerms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtTerms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="Baseln/SttlmTerms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SttlmTerms) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_SttlmTerms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SttlmTerms_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_SttlmTerms_CdtrAgt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAgt_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_SttlmTerms_CdtrAcct_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_CashAccount7_CdtrAcct_Id_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name')"/>
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
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_CashAccount7_CdtrAcct_Tp_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Tp_name')"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_name</xsl:variable>
</xsl:template>
<xsl:template match="CdtrAcct/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/PmtOblgtn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtOblgtn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtOblgtn) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_PmtOblgtn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtOblgtn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="OblgrBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RcptBk" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ChrgsAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ChrgsPctg" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="XpryDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AplblLaw" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms" mode="toc">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="PmtOblgtn/OblgrBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OblgrBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OblgrBk) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_OblgrBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_OblgrBk_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OblgrBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OblgrBk/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="PmtOblgtn/RcptBk" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RcptBk"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::RcptBk) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_RcptBk_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_RcptBk_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/RcptBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="RcptBk/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="PmtOblgtn/ChrgsAmt" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ChrgsAmt"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ChrgsAmt) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_ChrgsAmt_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="PmtOblgtn/ChrgsPctg" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ChrgsPctg"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_name</xsl:variable>
</xsl:template>
<xsl:template match="PmtOblgtn/XpryDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="XpryDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_name</xsl:variable>
</xsl:template>
<xsl:template match="PmtOblgtn/AplblLaw" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AplblLaw"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_name</xsl:variable>
</xsl:template>
<xsl:template match="PmtOblgtn/PmtTerms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PmtTerms) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_PmtTerms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtTerms_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
</xsl:template>
<xsl:template match="PmtOblgtn/SttlmTerms" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SttlmTerms) &lt; 1 and count(../preceding-sibling::PmtOblgtn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtOblgtn_SttlmTerms_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_SttlmTerms_name')"/>
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
<xsl:template match="Baseln/LatstMtchDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LatstMtchDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/ComrclDataSetReqrd" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::ComrclDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_ComrclDataSetReqrd_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_ComrclDataSetReqrd_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="ComrclDataSetReqrd/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::ComrclDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_ComrclDataSetReqrd_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Baseln/TrnsprtDataSetReqrd" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::TrnsprtDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_TrnsprtDataSetReqrd_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_TrnsprtDataSetReqrd_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="TrnsprtDataSetReqrd/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::TrnsprtDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_TrnsprtDataSetReqrd_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Baseln/InsrncDataSetReqrd" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrncDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::InsrncDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_InsrncDataSetReqrd_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_InsrncDataSetReqrd_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIssr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIsseDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchTrnsprt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchAmt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClausesReqrd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchAssrdPty" mode="toc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::InsrncDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_InsrncDataSetReqrd_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_Submitr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchIssr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MtchIssr) &lt; 1 and count(../preceding-sibling::InsrncDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_InsrncDataSetReqrd_MtchIssr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIssr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MtchIssr/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="MtchIssr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::MtchIssr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_MtchIssr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name')"/>
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
<xsl:template match="MtchIssr/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchIsseDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIsseDt_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchTrnsprt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchTrnsprt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchTrnsprt_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchAmt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchAmt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAmt_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/ClausesReqrd" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ClausesReqrd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_name</xsl:variable>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchAssrdPty" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchAssrdPty"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/CertDataSetReqrd" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::CertDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_CertDataSetReqrd_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_CertDataSetReqrd_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIssr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIsseDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchInspctnDt" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AuthrsdInspctrInd" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchConsgn" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchManfctr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSetReqrd/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::CertDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertDataSetReqrd_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_Submitr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSetReqrd/CertTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchIssr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIssr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MtchIssr) &lt; 1 and count(../preceding-sibling::CertDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertDataSetReqrd_MtchIssr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIssr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchIsseDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIsseDt_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchInspctnDt" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchInspctnDt"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchInspctnDt_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSetReqrd/AuthrsdInspctrInd" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AuthrsdInspctrInd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_AuthrsdInspctrInd_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchConsgn" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchConsgn"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchConsgn_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchManfctr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchManfctr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::MtchManfctr) &lt; 1 and count(../preceding-sibling::CertDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertDataSetReqrd_MtchManfctr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchManfctr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry" mode="toc">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="MtchManfctr/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="MtchManfctr/PrtryId" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::PrtryId) &lt; 1 and count(../preceding-sibling::MtchManfctr) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_MtchManfctr_PrtryId_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name')"/>
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
<xsl:template match="MtchManfctr/Ctry" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
</xsl:template>
<xsl:template match="CertDataSetReqrd/LineItmId" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/OthrCertDataSetReqrd" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrCertDataSetReqrd"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrCertDataSetReqrd) &lt; 1 and count(../preceding-sibling::Baseln) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_Baseline3_Baseln_OthrCertDataSetReqrd_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_OthrCertDataSetReqrd_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Submitr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/Submitr" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::Submitr) &lt; 1 and count(../preceding-sibling::OthrCertDataSetReqrd) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_OthrCertDataSetReqrd_Submitr_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_Submitr_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/CertTp" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_name</xsl:variable>
</xsl:template>
<xsl:template match="Baseln/InttToPayXpctd" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InttToPayXpctd"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_InttToPayXpctd_name</xsl:variable>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/BuyrCtctPrsn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::BuyrCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_BuyrCtctPrsn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_BuyrCtctPrsn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/NmPrfx" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/GvnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/Role" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/PhneNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/FaxNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/EmailAdr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SellrCtctPrsn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::SellrCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_SellrCtctPrsn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SellrCtctPrsn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="SellrCtctPrsn/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrCtctPrsn/NmPrfx" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrCtctPrsn/GvnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrCtctPrsn/Role" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrCtctPrsn/PhneNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrCtctPrsn/FaxNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
</xsl:template>
<xsl:template match="SellrCtctPrsn/EmailAdr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/OthrBkCtctPrsn" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrBkCtctPrsn"/>
</xsl:variable>
<xsl:if test="count(ancestor::*) &lt; 6 and count(preceding-sibling::OthrBkCtctPrsn) &lt; 1 and count(../preceding-sibling::InitlBaselnSubmissn) &lt; 1">
<fo:bookmark internal-destination="XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_InitlBaselnSubmissn_OthrBkCtctPrsn_name">
<fo:bookmark-title>
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_OthrBkCtctPrsn_name')"/>
</fo:bookmark-title>
</fo:bookmark>
</xsl:if>
<xsl:apply-templates select="BIC" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Nm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr" mode="toc">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/BIC" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/Nm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/NmPrfx" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/GvnNm" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/Role" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/PhneNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/FaxNb" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_name</xsl:variable>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/EmailAdr" mode="toc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_name</xsl:variable>
</xsl:template>
</xsl:stylesheet>
