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
<div id="/RptdNtty">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_StatusReportItems2_RptdNtty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RptdNtty/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SubSts">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_StatusReportItems2_SubSts_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SubSts</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsRpt_StatusReportItems2_SubSts_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/RptdItms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_StatusReportV03_RptdItms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_StatusReportItems2_TxId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RptdItms/TxId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsRpt_StatusReportItems2_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_StatusReportItems2_RptdNtty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RptdItms/RptdNtty/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_StatusReportItems2_Sts_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RptdItms/Sts</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="PROP">
<xsl:if test=". = 'PROP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLSD">
<xsl:if test=". = 'CLSD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PMTC">
<xsl:if test=". = 'PMTC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ESTD">
<xsl:if test=". = 'ESTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ACTV">
<xsl:if test=". = 'ACTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMP">
<xsl:if test=". = 'COMP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AMRQ">
<xsl:if test=". = 'AMRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RARQ">
<xsl:if test=". = 'RARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLRQ">
<xsl:if test=". = 'CLRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SCRQ">
<xsl:if test=". = 'SCRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SERQ">
<xsl:if test=". = 'SERQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DARQ">
<xsl:if test=". = 'DARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsRpt_StatusReportItems2_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
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
<xsl:apply-templates select="StsRpt">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/StsRpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StsRpt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_name</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="RptId">
<xsl:with-param name="path" select="concat($path,'/StsRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdMsgRef">
<xsl:with-param name="path" select="concat($path,'/StsRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdItms">
<xsl:with-param name="path" select="concat($path,'/StsRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StsRpt/RptId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_StatusReportV03_RptId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsRpt_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_MessageIdentification1_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsRpt/RltdMsgRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdMsgRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_StatusReportV03_RltdMsgRef_name</xsl:with-param>
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
</xsl:template>
<xsl:template match="RltdMsgRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_MessageIdentification1_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsRpt/RptdItms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdItms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/RptdItms[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_StatusReportV03_RptdItms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/RptdItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptdNtty">
<xsl:with-param name="path" select="concat($path,'/RptdItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/RptdItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubSts">
<xsl:with-param name="path" select="concat($path,'/RptdItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptdItms/TxId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_StatusReportItems2_TxId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TxId')"/>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_StatusReportItems2_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptdItms/RptdNtty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptdNtty"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/RptdNtty[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsRpt_StatusReportItems2_RptdNtty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/RptdNtty[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptdNtty/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptdItms/Sts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_StatusReportItems2_Sts_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLSD">
<xsl:if test=". = 'CLSD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PMTC">
<xsl:if test=". = 'PMTC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ESTD">
<xsl:if test=". = 'ESTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ACTV">
<xsl:if test=". = 'ACTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMP">
<xsl:if test=". = 'COMP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AMRQ">
<xsl:if test=". = 'AMRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RARQ">
<xsl:if test=". = 'RARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLRQ">
<xsl:if test=". = 'CLRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SCRQ">
<xsl:if test=". = 'SCRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SERQ">
<xsl:if test=". = 'SERQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DARQ">
<xsl:if test=". = 'DARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Sts = 'PROP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'CLSD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'PMTC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'ESTD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'ACTV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'COMP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'AMRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'RARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'CLRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'SCRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'SERQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'DARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsRpt_StatusReportItems2_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_StatusReportItems2_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptdItms/SubSts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SubSts"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsRpt_StatusReportItems2_SubSts_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/SubSts')"/>
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
<xsl:with-param name="help-label">XSL_TSU_StsRpt_StatusReportItems2_SubSts_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
