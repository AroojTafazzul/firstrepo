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
<div id="/Desc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Desc</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/EstblishdBaselnId">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_EstblishdBaselnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/EstblishdBaselnId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/EstblishdBaselnId/Vrsn</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/UsrTxRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_UsrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification5_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification5_IdIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/IdIssr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_ReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARRO">
<xsl:if test=". = 'ARRO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CINR">
<xsl:if test=". = 'CINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Desc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Desc</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Desc_definition</xsl:with-param>
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
<xsl:apply-templates select="StsXtnsnNtfctn">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/StsXtnsnNtfctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StsXtnsnNtfctn"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_name</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="NtfctnId">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="XtndedSts">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StsXtnsnNtfctn/NtfctnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NtfctnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_NtfctnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="NtfctnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_MessageIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="NtfctnId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsXtnsnNtfctn/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_TxId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsXtnsnNtfctn/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/EstblishdBaselnId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_EstblishdBaselnId_name</xsl:with-param>
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
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="EstblishdBaselnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification3_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsXtnsnNtfctn/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/UsrTxRef[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_UsrTxRef_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification5_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_DocumentIdentification5_IdIssr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsXtnsnNtfctn/XtndedSts">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="XtndedSts"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_XtndedSts_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/XtndedSts')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ChngDtTm">
<xsl:with-param name="path" select="concat($path,'/XtndedSts')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/XtndedSts')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="XtndedSts/Sts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLSD">
<xsl:if test=". = 'CLSD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PMTC">
<xsl:if test=". = 'PMTC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ESTD">
<xsl:if test=". = 'ESTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ACTV">
<xsl:if test=". = 'ACTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMP">
<xsl:if test=". = 'COMP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AMRQ">
<xsl:if test=". = 'AMRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RARQ">
<xsl:if test=". = 'RARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLRQ">
<xsl:if test=". = 'CLRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SCRQ">
<xsl:if test=". = 'SCRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SERQ">
<xsl:if test=". = 'SERQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DARQ">
<xsl:if test=". = 'DARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Sts = 'PROP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'CLSD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'PMTC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'ESTD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'ACTV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'COMP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'AMRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'RARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'CLRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'SCRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'SERQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Sts = 'DARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="XtndedSts/ChngDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ChngDtTm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_ChngDtTm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/ChngDtTm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_ChngDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="XtndedSts/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Desc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_TransactionStatus5_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="StsXtnsnNtfctn/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ReqForActn')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnNtfctn_StatusExtensionNotificationV03_ReqForActn_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARRO">
<xsl:if test=". = 'ARRO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CINR">
<xsl:if test=". = 'CINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'SBTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'RSTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'RSBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARDM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARCS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARES'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'WAIT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'UPDT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'SBDS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARRO'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CINR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Tp_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Desc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnNtfctn_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
