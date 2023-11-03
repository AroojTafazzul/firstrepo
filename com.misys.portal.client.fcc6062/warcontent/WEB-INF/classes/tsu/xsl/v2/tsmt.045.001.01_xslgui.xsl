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
<div id="/Tp">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Tp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tp/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/Cd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="CASH">
<xsl:if test=". = 'CASH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHAR">
<xsl:if test=". = 'CHAR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CHAR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMM">
<xsl:if test=". = 'COMM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_COMM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TAXE">
<xsl:if test=". = 'TAXE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TAXE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CISH">
<xsl:if test=". = 'CISH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CISH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TRAS">
<xsl:if test=". = 'TRAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TRAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SACC">
<xsl:if test=". = 'SACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CACC">
<xsl:if test=". = 'CACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SVGS">
<xsl:if test=". = 'SVGS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SVGS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONDP">
<xsl:if test=". = 'ONDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ONDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MGLD">
<xsl:if test=". = 'MGLD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MGLD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NREX">
<xsl:if test=". = 'NREX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_NREX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MOMA">
<xsl:if test=". = 'MOMA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MOMA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOAN">
<xsl:if test=". = 'LOAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_LOAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SLRY">
<xsl:if test=". = 'SLRY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SLRY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ODFT">
<xsl:if test=". = 'ODFT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ODFT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tp/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/Prtry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Ccy">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Ccy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Ccy</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{3,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Ccy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Nm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/UsrTxRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_UsrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification5_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification5_IdIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/IdIssr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_ReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARRO">
<xsl:if test=". = 'ARRO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CINR">
<xsl:if test=". = 'CINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SttlmTerms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_IntentToPay1_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/IBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/BBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/3</xsl:with-param>
<xsl:with-param name="value">3</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/UPIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{8,17}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_PrtryAcct_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/4</xsl:with-param>
<xsl:with-param name="value">4</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/PrtryAcct/Id</xsl:with-param>
<xsl:with-param name="maxsize">34</xsl:with-param>
<xsl:with-param name="size">34</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Desc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Desc</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/StrtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/StrtNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CtrySubDvsn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CtrySubDvsn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="REBA">
<xsl:if test=". = 'REBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Drctn</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="ADDD">
<xsl:if test=". = 'ADDD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine3_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="REBA">
<xsl:if test=". = 'REBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Drctn</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="ADDD">
<xsl:if test=". = 'ADDD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="REBA">
<xsl:if test=". = 'REBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Drctn</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="ADDD">
<xsl:if test=". = 'ADDD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BrkdwnByPurchsOrdr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_BrkdwnByPurchsOrdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_TxId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BrkdwnByPurchsOrdr/TxId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BrkdwnByPurchsOrdr/PurchsOrdrRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BrkdwnByPurchsOrdr/PurchsOrdrRef/DtOfIsse</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/BrkdwnByPurchsOrdr/NetAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_NetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/BrkdwnByPurchsOrdr/NetAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/BrkdwnByPurchsOrdr/NetAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_NetAmt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/CdtrAgt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_SettlementTerms2_CdtrAgt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/choice_1</xsl:with-param>
<xsl:with-param name="id">/CdtrAgt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_NmAndAdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/choice_1</xsl:with-param>
<xsl:with-param name="id">/CdtrAgt/choice_1/2</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Adr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/PstCdId</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/TwnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
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
<xsl:apply-templates select="FwdInttToPayNtfctn">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/FwdInttToPayNtfctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FwdInttToPayNtfctn"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="NtfctnId">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="InttToPay">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/FwdInttToPayNtfctn')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/NtfctnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NtfctnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_NtfctnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/NtfctnId')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_MessageIdentification1_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_TxId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_EstblishdBaselnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/EstblishdBaselnId')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification3_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification3_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification3_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification3_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/TxSts">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_TxSts_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Sts">
<xsl:with-param name="path" select="concat($path,'/TxSts')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CLSD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'PMTC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ESTD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ACTV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'COMP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'AMRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'RARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CLRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SCRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SERQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'DARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_TransactionStatus4_Sts_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/UsrTxRef[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_UsrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdIssr">
<xsl:with-param name="path" select="concat($path,'/UsrTxRef[', $index,']')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification5_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification5_IdIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/IdIssr')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_BuyrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/BuyrBk')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_SellrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SellrBk')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/InttToPay">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InttToPay"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_InttToPay_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="FwdInttToPayNtfctn_InttToPay_ByPurchsOrdr_ByComrclInvc_choice">
<xsl:with-param name="path" select="concat($path,'/InttToPay')"/>
</xsl:call-template>
<xsl:apply-templates select="XpctdPmtDt">
<xsl:with-param name="path" select="concat($path,'/InttToPay')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms">
<xsl:with-param name="path" select="concat($path,'/InttToPay')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InttToPay/XpctdPmtDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="XpctdPmtDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_IntentToPay1_XpctdPmtDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/XpctdPmtDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_IntentToPay1_XpctdPmtDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InttToPay/SttlmTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SttlmTerms')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_IntentToPay1_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="CdtrAgt">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CdtrAcct">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAgt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAgt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/CdtrAgt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_SettlementTerms2_CdtrAgt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="SttlmTerms_CdtrAgt_BIC_NmAndAdr_choice">
<xsl:with-param name="path" select="concat($path,'/CdtrAgt')"/>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="SttlmTerms_CdtrAgt_BIC_NmAndAdr_choice">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAgt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="BIC">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/BIC</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/BIC</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/BIC</xsl:attribute>
<xsl:attribute name="onblur">fncCheckStringPattern(this, '^[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}$'); fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_NmAndAdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
</xsl:call-template>
<xsl:choose>
<xsl:when test="NmAndAdr">
<xsl:apply-templates select="NmAndAdr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/NmAndAdr/Nm</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="70" size="&#10;                  40&#10;                " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/NmAndAdr/Nm</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/NmAndAdr/Nm</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Adr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_name</xsl:variable>
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
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/PstCdId</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="16" size="16" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/PstCdId</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/PstCdId</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_name</xsl:variable>
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
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/TwnNm</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/TwnNm</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/TwnNm</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/Ctry</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/Ctry</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/NmAndAdr/Adr/Ctry</xsl:attribute>
<xsl:attribute name="onblur">fncCheckStringPattern(this, '^[A-Z]{2,2}$'); fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>
<xsl:template match="CdtrAgt/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CdtrAgt/NmAndAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmAndAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adr">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="NmAndAdr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="NmAndAdr/Adr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_NameAndAddress6_Adr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
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
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Adr/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Adr/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_name</xsl:variable>
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
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Adr/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_name</xsl:variable>
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
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Adr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Adr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PostalAddress2_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAcct"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
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
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CdtrAcct/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="CdtrAcct_Id_IBAN_BBAN_UPIC_PrtryAcct_choice">
<xsl:with-param name="path" select="concat($path,'/Id')"/>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="CdtrAcct_Id_IBAN_BBAN_UPIC_PrtryAcct_choice">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="IBAN">
<xsl:apply-templates select="IBAN">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/IBAN')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/IBAN</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/IBAN</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/IBAN</xsl:attribute>
<xsl:attribute name="onblur">fncCheckStringPattern(this, '^[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}$'); fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="BBAN">
<xsl:apply-templates select="BBAN">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/BBAN')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/BBAN</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/BBAN</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/BBAN</xsl:attribute>
<xsl:attribute name="onblur">fncCheckStringPattern(this, '^[a-zA-Z0-9]{1,30}$'); fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/3</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/3</xsl:with-param>
<xsl:with-param name="value">3</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="UPIC">
<xsl:apply-templates select="UPIC">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/UPIC')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{8,17}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/UPIC</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/UPIC</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/UPIC</xsl:attribute>
<xsl:attribute name="onblur">fncCheckStringPattern(this, '^[0-9]{8,17}$'); fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/4</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_PrtryAcct_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/4</xsl:with-param>
<xsl:with-param name="value">4</xsl:with-param>
</xsl:call-template>
<xsl:choose>
<xsl:when test="PrtryAcct">
<xsl:apply-templates select="PrtryAcct">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_name</xsl:variable>
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
<xsl:with-param name="maxsize">34</xsl:with-param>
<xsl:with-param name="size">34</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/PrtryAcct/Id</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="34" size="34" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/PrtryAcct/Id</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/PrtryAcct/Id</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>
<xsl:template match="Id/IBAN">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IBAN"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/IBAN')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_IBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Id/BBAN">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BBAN"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/BBAN')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_BBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Id/UPIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="UPIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/UPIC')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{8,17}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_AccountIdentification3Choice_UPIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Id/PrtryAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryAcct"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryAcct')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PrtryAcct/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_name</xsl:variable>
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
<xsl:with-param name="maxsize">34</xsl:with-param>
<xsl:with-param name="size">34</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_SimpleIdentificationInformation2_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CdtrAcct/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Tp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="CdtrAcct_Tp_Cd_Prtry_choice">
<xsl:with-param name="path" select="concat($path,'/Tp')"/>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="CdtrAcct_Tp_Cd_Prtry_choice">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Cd">
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="CASH">
<xsl:if test=". = 'CASH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHAR">
<xsl:if test=". = 'CHAR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CHAR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMM">
<xsl:if test=". = 'COMM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_COMM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TAXE">
<xsl:if test=". = 'TAXE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TAXE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CISH">
<xsl:if test=". = 'CISH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CISH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TRAS">
<xsl:if test=". = 'TRAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TRAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SACC">
<xsl:if test=". = 'SACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CACC">
<xsl:if test=". = 'CACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SVGS">
<xsl:if test=". = 'SVGS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SVGS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONDP">
<xsl:if test=". = 'ONDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ONDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MGLD">
<xsl:if test=". = 'MGLD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MGLD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NREX">
<xsl:if test=". = 'NREX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_NREX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MOMA">
<xsl:if test=". = 'MOMA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MOMA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOAN">
<xsl:if test=". = 'LOAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_LOAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SLRY">
<xsl:if test=". = 'SLRY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SLRY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ODFT">
<xsl:if test=". = 'ODFT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ODFT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test=". = 'CASH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CHAR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CHAR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'COMM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_COMM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'TAXE'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TAXE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CISH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CISH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'TRAS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TRAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SACC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CACC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SVGS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SVGS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ONDP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ONDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'MGLD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MGLD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'NREX'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_NREX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'MOMA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MOMA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'LOAN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_LOAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SLRY'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SLRY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ODFT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ODFT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Cd</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_name')&#10;            "/>
</label>
<select class="&#10;            input-box&#10;            &#10;              mandatory&#10;            ">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/Cd</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/Cd</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
<option value=""/>
</select>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Prtry">
<xsl:apply-templates select="Prtry">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Prtry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Prtry</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/Prtry</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/Prtry</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="Tp/Cd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<xsl:choose>
<xsl:when test=". = 'CASH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CHAR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CHAR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'COMM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_COMM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'TAXE'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TAXE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CISH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CISH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'TRAS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_TRAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SACC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CACC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_CACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SVGS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SVGS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ONDP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ONDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'MGLD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MGLD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'NREX'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_NREX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'MOMA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_MOMA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'LOAN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_LOAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SLRY'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_SLRY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ODFT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_code_ODFT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Tp/Prtry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Prtry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Prtry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccountType2_Prtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CdtrAcct/Ccy">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ccy"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Ccy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Ccy')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{3,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Ccy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="CdtrAcct/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Nm_name</xsl:variable>
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
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template name="FwdInttToPayNtfctn_InttToPay_ByPurchsOrdr_ByComrclInvc_choice">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InttToPay"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_IntentToPay1_ByPurchsOrdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
</xsl:call-template>
<xsl:choose>
<xsl:when test="ByPurchsOrdr">
<xsl:apply-templates select="ByPurchsOrdr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine3_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/ByPurchsOrdr/PurchsOrdrRef/Id</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByPurchsOrdr/PurchsOrdrRef/Id</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByPurchsOrdr/PurchsOrdrRef/Id</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_definition')"/>
</xsl:attribute>
</img>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/DtOfIsse')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/ByPurchsOrdr/PurchsOrdrRef/DtOfIsse</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            &#10;              date&#10;            " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByPurchsOrdr/PurchsOrdrRef/DtOfIsse</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByPurchsOrdr/PurchsOrdrRef/DtOfIsse</xsl:attribute>
<xsl:attribute name="onblur">fncCheckDate(this); fncCheckLeds(this);</xsl:attribute>
<xsl:attribute name="size">10</xsl:attribute>
<xsl:attribute name="maxlength">10</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_definition')"/>
</xsl:attribute>
</img>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/ByPurchsOrdr/NetAmt</xsl:attribute>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_ReportLine3_NetAmt_name')&#10;                "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " size="3" maxlength="3" value="">
<xsl:attribute name="onblur">fncCheckValidCurrency(this);fncFormatAmount(document.forms['xmsForm'].elements['<xsl:value-of select="$path"/>/ByPurchsOrdr/NetAmt'], fncGetCurrencyDecNo(this.value)); fncCheckLeds(this);</xsl:attribute>
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByPurchsOrdr/NetAmt/@Ccy</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByPurchsOrdr/NetAmt/@Ccy</xsl:attribute>
</input>
<input class="&#10;            input-box amount&#10;            &#10;              mandatory&#10;            " value="">
<xsl:attribute name="onblur">
            fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['xmsForm'].elements['<xsl:value-of select="$path"/>/ByPurchsOrdr/NetAmt/@Ccy'].value)); fncCheckLeds(this);
          </xsl:attribute>
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByPurchsOrdr/NetAmt</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByPurchsOrdr/NetAmt</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_ReportLine3_NetAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_IntentToPay1_ByComrclInvc_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
</xsl:call-template>
<xsl:choose>
<xsl:when test="ByComrclInvc">
<xsl:apply-templates select="ByComrclInvc">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_ComrclDocRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_InvcNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InvcNb')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_InvcNb_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/ByComrclInvc/ComrclDocRef/InvcNb</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_InvcNb_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByComrclInvc/ComrclDocRef/InvcNb</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByComrclInvc/ComrclDocRef/InvcNb</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_InvcNb_definition')"/>
</xsl:attribute>
</img>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_IsseDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/IsseDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/ByComrclInvc/ComrclDocRef/IsseDt</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_IsseDt_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            &#10;              date&#10;            " value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByComrclInvc/ComrclDocRef/IsseDt</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByComrclInvc/ComrclDocRef/IsseDt</xsl:attribute>
<xsl:attribute name="onblur">fncCheckDate(this); fncCheckLeds(this);</xsl:attribute>
<xsl:attribute name="size">10</xsl:attribute>
<xsl:attribute name="maxlength">10</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_IsseDt_definition')"/>
</xsl:attribute>
</img>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/ByComrclInvc/NetAmt</xsl:attribute>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_ReportLine4_NetAmt_name')&#10;                "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " size="3" maxlength="3" value="">
<xsl:attribute name="onblur">fncCheckValidCurrency(this);fncFormatAmount(document.forms['xmsForm'].elements['<xsl:value-of select="$path"/>/ByComrclInvc/NetAmt'], fncGetCurrencyDecNo(this.value)); fncCheckLeds(this);</xsl:attribute>
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByComrclInvc/NetAmt/@Ccy</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByComrclInvc/NetAmt/@Ccy</xsl:attribute>
</input>
<input class="&#10;            input-box amount&#10;            &#10;              mandatory&#10;            " value="">
<xsl:attribute name="onblur">
            fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['xmsForm'].elements['<xsl:value-of select="$path"/>/ByComrclInvc/NetAmt/@Ccy'].value)); fncCheckLeds(this);
          </xsl:attribute>
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/ByComrclInvc/NetAmt</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/ByComrclInvc/NetAmt</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_ReportLine4_NetAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>
<xsl:template match="InttToPay/ByPurchsOrdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ByPurchsOrdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/ByPurchsOrdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/ByPurchsOrdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NetAmt">
<xsl:with-param name="path" select="concat($path,'/ByPurchsOrdr')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ByPurchsOrdr/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine3_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="PurchsOrdrRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PurchsOrdrRef/DtOfIsse">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/DtOfIsse')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ByPurchsOrdr/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine3_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="ByPurchsOrdr_Adjstmnt_Tp_OthrAdjstmntTp_choice">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Drctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Drctn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Drctn')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<xsl:choose>
<xsl:when test=". = 'ADDD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SUBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/Amt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="ByPurchsOrdr_Adjstmnt_Tp_OthrAdjstmntTp_choice">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<option value="REBA">
<xsl:if test=". = 'REBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test=". = 'REBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'DISC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CREN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SURC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name')&#10;            "/>
</label>
<select class="&#10;            input-box&#10;            &#10;              mandatory&#10;            ">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
<option value=""/>
</select>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="OthrAdjstmntTp">
<xsl:apply-templates select="OthrAdjstmntTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OthrAdjstmntTp')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<xsl:when test=". = 'REBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'DISC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CREN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SURC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/OthrAdjstmntTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrAdjstmntTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OthrAdjstmntTp')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ByPurchsOrdr/NetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine3_NetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/NetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_ReportLine3_NetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/NetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/NetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_ReportLine3_NetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InttToPay/ByComrclInvc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ByComrclInvc"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="ComrclDocRef">
<xsl:with-param name="path" select="concat($path,'/ByComrclInvc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/ByComrclInvc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NetAmt">
<xsl:with-param name="path" select="concat($path,'/ByComrclInvc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BrkdwnByPurchsOrdr">
<xsl:with-param name="path" select="concat($path,'/ByComrclInvc')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ByComrclInvc/ComrclDocRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDocRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_ComrclDocRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="InvcNb">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclDocRef/InvcNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InvcNb"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_InvcNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InvcNb')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_InvcNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDocRef/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_IsseDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/IsseDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_InvoiceIdentification1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ByComrclInvc/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="ByComrclInvc_Adjstmnt_Tp_OthrAdjstmntTp_choice">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="ByComrclInvc_Adjstmnt_Tp_OthrAdjstmntTp_choice">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<option value="REBA">
<xsl:if test=". = 'REBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test=". = 'REBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'DISC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CREN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SURC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name')&#10;            "/>
</label>
<select class="&#10;            input-box&#10;            &#10;              mandatory&#10;            ">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
<option value=""/>
</select>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="OthrAdjstmntTp">
<xsl:apply-templates select="OthrAdjstmntTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OthrAdjstmntTp')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="ByComrclInvc/NetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_NetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/NetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_NetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/NetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/NetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_NetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ByComrclInvc/BrkdwnByPurchsOrdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BrkdwnByPurchsOrdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine4_BrkdwnByPurchsOrdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/BrkdwnByPurchsOrdr[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/BrkdwnByPurchsOrdr[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/BrkdwnByPurchsOrdr[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NetAmt">
<xsl:with-param name="path" select="concat($path,'/BrkdwnByPurchsOrdr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BrkdwnByPurchsOrdr/TxId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_TxId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BrkdwnByPurchsOrdr/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="BrkdwnByPurchsOrdr/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="BrkdwnByPurchsOrdr_Adjstmnt_Tp_OthrAdjstmntTp_choice">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="BrkdwnByPurchsOrdr_Adjstmnt_Tp_OthrAdjstmntTp_choice">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<option value="REBA">
<xsl:if test=". = 'REBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test=". = 'REBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'DISC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CREN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SURC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_name')&#10;            "/>
</label>
<select class="&#10;            input-box&#10;            &#10;              mandatory&#10;            ">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
<option value=""/>
</select>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="OthrAdjstmntTp">
<xsl:apply-templates select="OthrAdjstmntTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$displaymode = 'edit'">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OthrAdjstmntTp')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/OthrAdjstmntTp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="BrkdwnByPurchsOrdr/NetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_NetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/NetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_NetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/NetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/NetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_ReportLine2_NetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="FwdInttToPayNtfctn/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ReqForActn')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdInttToPayNtfctn_ForwardIntentToPayNotificationV01_ReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Desc">
<xsl:with-param name="path" select="concat($path,'/ReqForActn')"/>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'RSTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'RSBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARDM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARCS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARES'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'WAIT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'UPDT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'SBDS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'ARRO'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test=". = 'CINR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Tp_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Desc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdInttToPayNtfctn_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
