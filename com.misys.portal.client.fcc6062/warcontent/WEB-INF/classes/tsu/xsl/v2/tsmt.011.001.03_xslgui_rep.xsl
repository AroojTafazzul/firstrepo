<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="localization tools" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:misys="http://www.misys.com" xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools" xmlns:localization="xalan://com.misys.portal.common.localization.Localization">
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">TU</xsl:param>
<xsl:param name="tnx-type-code"/>
<xsl:param name="main-form-name">fakeform1</xsl:param>
<xsl:param name="realform-action">
<xsl:value-of select="$contextPath"/>
<xsl:value-of select="$servletPath"/>/screen/TSUScreen</xsl:param>
<xsl:include href="../../../core/xsl/common/e2ee_common.xsl"/>
<xsl:include href="../../../core/xsl/common/trade_common.xsl"/>
<xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl"/>
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template name="templates">
<div id="templates" style="display:none">
<div id="/RltdMsgRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_RltdMsgRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdMsgRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdMsgRef/CreDtTm</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/UsrTxRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_UsrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification5_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_DocumentIdentification5_IdIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/IdIssr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/ReqForActn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_ReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ReqForActn/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="SBTW">
<xsl:if test=". = 'SBTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARRO">
<xsl:if test=". = 'ARRO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CINR">
<xsl:if test=". = 'CINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PendingActivity2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/AmdmntSeqNb">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_AmdmntSeqNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AmdmntSeqNb</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_DocumentIdentification6_AmdmntSeqNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/LineItmDtls">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_LineItmDtls_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_LineItmId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/LineItmId</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OrdrdQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/OrdrdQty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OrdrdQty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OrdrdQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/OrdrdQty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OrdrdQty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OrdrdQty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_AccptdQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/AccptdQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/AccptdQty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/AccptdQty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/AccptdQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/AccptdQty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/AccptdQty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/AccptdQty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OutsdngQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/OutsdngQty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OutsdngQty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OutsdngQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/OutsdngQty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OutsdngQty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/OutsdngQty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdgQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/PdgQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/PdgQty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/PdgQty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/PdgQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/PdgQty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/PdgQty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/PdgQty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/LineItmDtls/OrdrdAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/LineItmDtls/OrdrdAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/LineItmDtls/OrdrdAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_definition</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/LineItmDtls/AccptdAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/LineItmDtls/AccptdAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/LineItmDtls/AccptdAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_definition</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/LineItmDtls/OutsdngAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/LineItmDtls/OutsdngAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/LineItmDtls/OutsdngAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_definition</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/LineItmDtls/PdgAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/LineItmDtls/PdgAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/LineItmDtls/PdgAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PdctNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_PdctNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_PdctNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PdctIdr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdctIdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductIdentifier2Choice_StrdPdctIdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctIdr/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/StrdPdctIdr/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="BINR">
<xsl:if test=". = 'BINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_BINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMD">
<xsl:if test=". = 'COMD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_COMD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EANC">
<xsl:if test=". = 'EANC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_EANC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="HRTR">
<xsl:if test=". = 'HRTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_HRTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MANI">
<xsl:if test=". = 'MANI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_MANI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MODL">
<xsl:if test=". = 'MODL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_MODL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PART">
<xsl:if test=". = 'PART'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_PART')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QOTA">
<xsl:if test=". = 'QOTA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_QOTA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STYL">
<xsl:if test=". = 'STYL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_STYL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUPI">
<xsl:if test=". = 'SUPI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_SUPI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPCC">
<xsl:if test=". = 'UPCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_code_UPCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_ProductIdentifier2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductIdentifier2_Idr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/StrdPdctIdr/Idr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_ProductIdentifier2_Idr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductIdentifier2Choice_OthrPdctIdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctIdr/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/OthrPdctIdr/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/OthrPdctIdr/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PdctChrtcs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdctChrtcs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCharacteristics1Choice_StrdPdctChrtcs_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctChrtcs/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/StrdPdctChrtcs/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="BISP">
<xsl:if test=". = 'BISP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_BISP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHNR">
<xsl:if test=". = 'CHNR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_CHNR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLOR">
<xsl:if test=". = 'CLOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_CLOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EDSP">
<xsl:if test=". = 'EDSP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_EDSP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ENNR">
<xsl:if test=". = 'ENNR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_ENNR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OPTN">
<xsl:if test=". = 'OPTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_OPTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ORCR">
<xsl:if test=". = 'ORCR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_ORCR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PCTV">
<xsl:if test=". = 'PCTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_PCTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SISP">
<xsl:if test=". = 'SISP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SISP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SIZE">
<xsl:if test=". = 'SIZE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SIZE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SZRG">
<xsl:if test=". = 'SZRG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SZRG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SPRM">
<xsl:if test=". = 'SPRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_SPRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STOR">
<xsl:if test=". = 'STOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_STOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VINR">
<xsl:if test=". = 'VINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_code_VINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_ProductCharacteristics1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCharacteristics1_Chrtcs_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/StrdPdctChrtcs/Chrtcs</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_ProductCharacteristics1_Chrtcs_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCharacteristics1Choice_OthrPdctChrtcs_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctChrtcs/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/OthrPdctChrtcs/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/OthrPdctChrtcs/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PdctCtgy">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdctCtgy_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCategory1Choice_StrdPdctCtgy_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctCtgy/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCategory1_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/StrdPdctCtgy/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="HRTR">
<xsl:if test=". = 'HRTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_HRTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QOTA">
<xsl:if test=". = 'QOTA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_QOTA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRGP">
<xsl:if test=". = 'PRGP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_PRGP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOBU">
<xsl:if test=". = 'LOBU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_LOBU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GNDR">
<xsl:if test=". = 'GNDR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ProductCategory1_Tp_code_GNDR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_ProductCategory1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCategory1_Ctgy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/StrdPdctCtgy/Ctgy</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_ProductCategory1_Ctgy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_BaselnRpt_ProductCategory1Choice_OthrPdctCtgy_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctCtgy/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/OthrPdctCtgy/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/OthrPdctCtgy/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/QtyTlrnce">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_QtyTlrnce_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/QtyTlrnce/PlusPct</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/QtyTlrnce/MnsPct</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PricTlrnce">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PricTlrnce_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PricTlrnce/PlusPct</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PricTlrnce/MnsPct</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PrtryId">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Desc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Desc</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/StrtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/StrtNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PstCdId">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PstCdId</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/TwnNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TwnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CtrySubDvsn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CtrySubDvsn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Fctr">
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Fctr</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<xsl:text>End templates</xsl:text>
</div>
</xsl:template>
<xsl:template match="/">
<xsl:apply-templates select="tu_tnx_record"/>
</xsl:template>
<xsl:template match="tu_tnx_record">
<xsl:call-template name="loading-message"/>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$displaymode"/>
</xsl:attribute>
<xsl:call-template name="templates"/>
<xsl:call-template name="form-wrapper">
<xsl:with-param name="name">xmsForm</xsl:with-param>
<xsl:with-param name="validating">N</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="menu">
<xsl:with-param name="show-return">Y</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="disclaimer"/>
<xsl:apply-templates select="narrative_xml/Document">
<xsl:with-param name="path" select="/Document"/>
</xsl:apply-templates>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="form-wrapper">
<xsl:with-param name="name" select="$main-form-name"/>
<xsl:with-param name="validating">Y</xsl:with-param>
<xsl:with-param name="content">
<xsl:apply-templates select="cross_references" mode="hidden_form"/>
<xsl:call-template name="hidden-fields"/>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="realform"/>
<xsl:call-template name="menu">
<xsl:with-param name="second-menu">Y</xsl:with-param>
<xsl:with-param name="show-return">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="realform">
<xsl:call-template name="form-wrapper">
<xsl:with-param name="name">realform</xsl:with-param>
<xsl:with-param name="action" select="$realform-action"/>
<xsl:with-param name="content">
<div class="widgetContainer">
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">referenceid</xsl:with-param>
<xsl:with-param name="value" select="ref_id"/>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">tnxid</xsl:with-param>
<xsl:with-param name="value" select="tnx_id"/>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">operation</xsl:with-param>
<xsl:with-param name="id">realform_operation</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">mode</xsl:with-param>
<xsl:with-param name="value" select="$mode"/>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">tnxtype</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="$tnx-type-code"/>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">attIds</xsl:with-param>
<xsl:with-param name="value"/>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">fileActIds</xsl:with-param>
<xsl:with-param name="value"/>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">TransactionData</xsl:with-param>
<xsl:with-param name="value"/>
</xsl:call-template>
<xsl:call-template name="e2ee_transaction"/>
<xsl:call-template name="reauth_params"/>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="hidden-fields">
<div class="widgetContainer">
<xsl:call-template name="common-hidden-fields">
<xsl:with-param name="additional-fields">
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="issuing_bank/abbv_name"/>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="issuing_bank/name"/>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">data</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
<xsl:with-param name="name">ref_id</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Document">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Document"/>
</xsl:variable>
<xsl:apply-templates select="BaselnRpt">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/BaselnRpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BaselnRpt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_name</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="RptId">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdMsgRef">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptTp">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdLineItm">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/BaselnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnRpt/RptId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_RptId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/RptId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/RptId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CreDtTm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODateTime2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/RltdMsgRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdMsgRef"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/RltdMsgRef')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_RltdMsgRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/RltdMsgRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/RltdMsgRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RltdMsgRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_MessageIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RltdMsgRef/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CreDtTm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODateTime2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/RptTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptTp"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_RptTp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/RptTp')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptTp/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_ReportType2_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="PREC">
<xsl:if test=". = 'PREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ReportType2_Tp_code_PREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CURR">
<xsl:if test=". = 'CURR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ReportType2_Tp_code_CURR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'PREC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ReportType2_Tp_code_PREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CURR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_ReportType2_Tp_code_CURR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_ReportType2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_TxId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/TxId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TxId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_EstblishdBaselnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AmdmntSeqNb">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_DocumentIdentification6_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Vrsn')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_DocumentIdentification6_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="EstblishdBaselnId/AmdmntSeqNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AmdmntSeqNb"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification6_AmdmntSeqNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AmdmntSeqNb')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_DocumentIdentification6_AmdmntSeqNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/TxSts">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_TxSts_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/TxSts')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TxSts/Sts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_TransactionStatus4_Sts_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Sts')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="PROP">
<xsl:if test=". = 'PROP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLSD">
<xsl:if test=". = 'CLSD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PMTC">
<xsl:if test=". = 'PMTC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ESTD">
<xsl:if test=". = 'ESTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ACTV">
<xsl:if test=". = 'ACTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMP">
<xsl:if test=". = 'COMP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AMRQ">
<xsl:if test=". = 'AMRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RARQ">
<xsl:if test=". = 'RARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLRQ">
<xsl:if test=". = 'CLRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SCRQ">
<xsl:if test=". = 'SCRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SERQ">
<xsl:if test=". = 'SERQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DARQ">
<xsl:if test=". = 'DARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Sts = 'PROP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'CLSD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'PMTC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'ESTD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'ACTV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'COMP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'AMRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'RARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'CLRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'SCRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'SERQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'DARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_TransactionStatus4_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_TransactionStatus4_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/UsrTxRef[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_UsrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdIssr">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="UsrTxRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_DocumentIdentification5_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_DocumentIdentification5_IdIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/IdIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="IdIssr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_Buyr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Buyr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Buyr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Buyr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_Sellr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Sellr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Sellr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Sellr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PstlAdr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_BuyrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/BuyrBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BuyrBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_SellrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SellrBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="SellrBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BaselnRpt/RptdLineItm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdLineItm"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_RptdLineItm_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="LineItmDtls">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/RptdLineItm')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/LineItmDtls">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmDtls"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_LineItmDtls_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctNm">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctIdr">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctChrtcs">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctCtgy">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="QtyTlrnce">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PricTlrnce">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_LineItmId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/LineItmId')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdctNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_LineItemDetails8_PdctNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PdctNm')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_PdctNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PdctIdr[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdctIdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctChrtcs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PdctChrtcs[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdctChrtcs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctCtgy"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PdctCtgy[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdctCtgy_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/OrdrdQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdQty"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/OrdrdQty')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OrdrdQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Val')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OrdrdQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Fctr')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/AccptdQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdQty"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_AccptdQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/AccptdQty')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="AccptdQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Val')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="AccptdQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Fctr')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/OutsdngQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngQty"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/OutsdngQty')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OutsdngQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Val')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OutsdngQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Fctr')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdgQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgQty"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdgQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/PdgQty')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PdgQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Val')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PdgQty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Fctr')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/QtyTlrnce">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="QtyTlrnce"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/QtyTlrnce')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_QtyTlrnce_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlusPct">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="QtyTlrnce/PlusPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlusPct')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="QtyTlrnce/MnsPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MnsPct')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/OrdrdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OrdrdAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/OrdrdAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/OrdrdAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_OrdrdAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/AccptdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AccptdAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/AccptdAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/AccptdAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_AccptdAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/OutsdngAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OutsdngAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/OutsdngAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/OutsdngAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_OutsdngAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/PdgAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PdgAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/PdgAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/PdgAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItemDetails8_PdgAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="LineItmDtls/PricTlrnce">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PricTlrnce"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PricTlrnce')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItemDetails8_PricTlrnce_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlusPct">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PricTlrnce/PlusPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlusPct')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_PlusPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PricTlrnce/MnsPct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MnsPct')"/>
</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PercentageTolerance1_MnsPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptdLineItm/OrdrdLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdLineItmsTtlAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_OrdrdLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OrdrdLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_OrdrdLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/OrdrdLineItmsTtlAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/OrdrdLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_OrdrdLineItmsTtlAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/AccptdLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdLineItmsTtlAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_AccptdLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AccptdLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_AccptdLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/AccptdLineItmsTtlAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/AccptdLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_AccptdLineItmsTtlAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/OutsdngLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngLineItmsTtlAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_OutsdngLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OutsdngLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_OutsdngLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/OutsdngLineItmsTtlAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/OutsdngLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_OutsdngLineItmsTtlAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/PdgLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgLineItmsTtlAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_PdgLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PdgLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_PdgLineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/PdgLineItmsTtlAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/PdgLineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_PdgLineItmsTtlAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/OrdrdTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdTtlNetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_OrdrdTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OrdrdTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_OrdrdTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/OrdrdTtlNetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/OrdrdTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_OrdrdTtlNetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/AccptdTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdTtlNetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_AccptdTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AccptdTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_AccptdTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/AccptdTtlNetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/AccptdTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_AccptdTtlNetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/OutsdngTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngTtlNetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_OutsdngTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OutsdngTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_OutsdngTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/OutsdngTtlNetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/OutsdngTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_OutsdngTtlNetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptdLineItm/PdgTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgTtlNetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_LineItem8_PdgTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PdgTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_BaselnRpt_LineItem8_PdgTtlNetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/PdgTtlNetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/PdgTtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_LineItem8_PdgTtlNetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BaselnRpt/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ReqForActn')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_BaselnRpt_BaselineReportV03_ReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ReqForActn/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="SBTW">
<xsl:if test=". = 'SBTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARRO">
<xsl:if test=". = 'ARRO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CINR">
<xsl:if test=". = 'CINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'SBTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'RSTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'RSBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARDM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARCS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARES'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'WAIT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'UPDT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'SBDS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARRO'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CINR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_BaselnRpt_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PendingActivity2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ReqForActn/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_BaselnRpt_PendingActivity2_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Desc')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_BaselnRpt_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
