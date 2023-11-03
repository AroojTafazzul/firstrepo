<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:misys="http://www.misys.com" xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" version="1.0" exclude-result-prefixes="localization tools">
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
<xsl:value-of select="$servletPath"/>/screen/TMAScreen</xsl:param>
<xsl:include href="../../../core/xsl/common/e2ee_common.xsl"/>
<xsl:include href="../../../core/xsl/common/trade_common.xsl"/>
<xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl"/>
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template name="templates">
<div id="templates" style="display:none">
<div id="/PrtryId">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_PartyIdentification28_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Desc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PendingActivity1_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Desc</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PendingActivity1_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/TxId">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_TxId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TxId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/TxSts">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_TxSts_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_TransactionStatus4_Sts_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TxSts/Sts</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="PROP">
<xsl:if test=". = 'PROP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLSD">
<xsl:if test=". = 'CLSD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PMTC">
<xsl:if test=". = 'PMTC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ESTD">
<xsl:if test=". = 'ESTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ACTV">
<xsl:if test=". = 'ACTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMP">
<xsl:if test=". = 'COMP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AMRQ">
<xsl:if test=". = 'AMRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RARQ">
<xsl:if test=". = 'RARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLRQ">
<xsl:if test=". = 'CLRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SCRQ">
<xsl:if test=". = 'SCRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SERQ">
<xsl:if test=". = 'SERQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DARQ">
<xsl:if test=". = 'DARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_TransactionStatus4_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SubmitrTxRef">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_SubmitrTxRef_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SubmitrTxRef</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_SubmitrTxRef_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/NttiesToBeRptd">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_NttiesToBeRptd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/NttiesToBeRptd/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Crspdt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_Crspdt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Crspdt/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SubmitgBk">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_SubmitgBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SubmitgBk/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/OblgrBk">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_OblgrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OblgrBk/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Buyr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_Buyr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Buyr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Sellr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_Sellr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Sellr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BuyrCtry">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_BuyrCtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrCtry</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_BuyrCtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/SellrCtry">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_SellrCtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrCtry</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_SellrCtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CrspdtCtry">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_CrspdtCtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CrspdtCtry</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_CrspdtCtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PdgReqForActn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_PdgReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PendingActivity1_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdgReqForActn/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="SBTW">
<xsl:if test=". = 'SBTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PendingActivity1_Tp_definition</xsl:with-param>
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
<xsl:call-template name="reauthentication"/>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="realform"/>
<xsl:call-template name="menu">
<xsl:with-param name="second-menu">Y</xsl:with-param>
<xsl:with-param name="show-return">Y</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="js-imports"/>
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
<xsl:template name="js-imports">
<xsl:call-template name="common-js-imports">
<xsl:with-param name="binding">misys.binding.tma.create_tm</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="convertYesNoIndicatorValue">
<xsl:param name="yesNoIndicatorValue"/>
<xsl:choose>
<xsl:when test="$yesNoIndicatorValue = 'true'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/>
</xsl:when>
<xsl:when test="$yesNoIndicatorValue = 'false'">
<xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/>
</xsl:when>
</xsl:choose>
</xsl:template>
<xsl:template match="Document">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Document"/>
</xsl:variable>
<xsl:apply-templates select="TxRptReq">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/TxRptReq">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxRptReq"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="ReqId">
<xsl:with-param name="path" select="concat($path,'/TxRptReq')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RptSpcfctn">
<xsl:with-param name="path" select="concat($path,'/TxRptReq')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TxRptReq/ReqId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_TransactionReportRequestV03_ReqId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/ReqId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/ReqId')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ReqId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_MessageIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ReqId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TxRptReq/RptSpcfctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptSpcfctn"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_TransactionReportRequestV03_RptSpcfctn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitrTxRef">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NttiesToBeRptd">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Crspdt">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitgBk">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OblgrBk">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrCtry">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrCtry">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CrspdtCtry">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgReqForActn">
<xsl:with-param name="path" select="concat($path,'/RptSpcfctn')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RptSpcfctn/TxId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_TxId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TxId[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/TxSts">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TxSts[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_TxSts_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/TxSts[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TxSts/Sts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_TransactionStatus4_Sts_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Sts')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<xsl:choose>
<xsl:when test=". = 'PROP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'PMTC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ESTD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'COMP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'AMRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'RARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CLRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SCRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SERQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'DARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_TransactionStatus4_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_TransactionStatus4_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/SubmitrTxRef">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_SubmitrTxRef_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/SubmitrTxRef[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_SubmitrTxRef_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/NttiesToBeRptd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NttiesToBeRptd"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/NttiesToBeRptd[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_NttiesToBeRptd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/NttiesToBeRptd[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="NttiesToBeRptd/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/Crspdt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Crspdt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Crspdt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_Crspdt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Crspdt[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Crspdt/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/SubmitgBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitgBk"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SubmitgBk[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_SubmitgBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SubmitgBk[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SubmitgBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/OblgrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OblgrBk"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/OblgrBk[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_OblgrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/OblgrBk[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OblgrBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Buyr[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_Buyr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Buyr[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Buyr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Buyr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_TxRptReq_PartyIdentification28_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
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
<xsl:variable name="label">XSL_TSU_TxRptReq_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_TxRptReq_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Sellr[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_Sellr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Sellr[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Sellr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Sellr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PartyIdentification28_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_TxRptReq_PartyIdentification28_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/BuyrCtry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BuyrCtry"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_BuyrCtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/BuyrCtry[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_BuyrCtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/SellrCtry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SellrCtry"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_SellrCtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/SellrCtry[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_SellrCtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/CrspdtCtry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CrspdtCtry"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_ReportSpecification4_CrspdtCtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CrspdtCtry[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_ReportSpecification4_CrspdtCtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="RptSpcfctn/PdgReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgReqForActn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PdgReqForActn[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_TxRptReq_ReportSpecification4_PdgReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/PdgReqForActn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/PdgReqForActn[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PdgReqForActn/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PendingActivity1_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<xsl:choose>
<xsl:when test=". = 'SBTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'RSTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'RSBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARDM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARCS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARES'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'WAIT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'UPDT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SBDS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_TxRptReq_PendingActivity1_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PendingActivity1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PdgReqForActn/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_TxRptReq_PendingActivity1_Desc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_TxRptReq_PendingActivity1_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
