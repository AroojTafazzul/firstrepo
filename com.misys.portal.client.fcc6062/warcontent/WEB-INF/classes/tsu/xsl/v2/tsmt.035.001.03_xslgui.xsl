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
<div id="/SubmitrTxRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnReq_StatusExtensionRequestV03_SubmitrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_SimpleIdentificationInformation_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SubmitrTxRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Desc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_TransactionStatus5_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Desc</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_TransactionStatus5_Desc_definition</xsl:with-param>
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
<xsl:apply-templates select="StsXtnsnReq">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/StsXtnsnReq">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StsXtnsnReq"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnReq_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="ReqId">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnReq')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnReq')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitrTxRef">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnReq')"/>
</xsl:apply-templates>
<xsl:apply-templates select="StsToBeXtnded">
<xsl:with-param name="path" select="concat($path,'/StsXtnsnReq')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StsXtnsnReq/ReqId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnReq_StatusExtensionRequestV03_ReqId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_MessageIdentification1_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsXtnsnReq/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnReq_StatusExtensionRequestV03_TxId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/TxId')"/>
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
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsXtnsnReq/SubmitrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SubmitrTxRef')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnReq_StatusExtensionRequestV03_SubmitrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmitrTxRef')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SubmitrTxRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsXtnsnReq/StsToBeXtnded">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StsToBeXtnded"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_StsXtnsnReq_StatusExtensionRequestV03_StsToBeXtnded_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/StsToBeXtnded')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ChngDtTm">
<xsl:with-param name="path" select="concat($path,'/StsToBeXtnded')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/StsToBeXtnded')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="StsToBeXtnded/Sts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Sts"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'PMTC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ESTD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'COMP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'AMRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'RARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CLRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SCRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SERQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'DARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_TransactionStatus5_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsToBeXtnded/ChngDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ChngDtTm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_TransactionStatus5_ChngDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_TransactionStatus5_ChngDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="StsToBeXtnded/Desc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Desc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_StsXtnsnReq_TransactionStatus5_Desc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_StsXtnsnReq_TransactionStatus5_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
