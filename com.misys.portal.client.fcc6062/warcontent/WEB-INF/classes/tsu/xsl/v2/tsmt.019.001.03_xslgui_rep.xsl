<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="localization tools" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:misys="http://www.misys.com" xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools" xmlns:localization="xalan://com.misys.portal.common.localization.Localization">
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="displaymode">view</xsl:param>
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
<div id="/AirprtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AirprtNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/BuyrSdSubmitgBk">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrSdSubmitgBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrSdSubmitgBk/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SellrSdSubmitgBk">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrSdSubmitgBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrSdSubmitgBk/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BllTo">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_BllTo_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BllTo/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BllTo/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/ShipTo">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_ShipTo_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ShipTo/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ShipTo/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Consgn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_Consgn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgn/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PmtTerms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_OthrPmtTerms_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_1</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_OthrPmtTerms_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/OthrPmtTerms</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_OthrPmtTerms_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_PmtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_1</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/PmtCd/Cd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="CASH">
<xsl:if test=". = 'CASH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EMTD">
<xsl:if test=". = 'EMTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EMTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EPRD">
<xsl:if test=". = 'EPRD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EPRD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRMD">
<xsl:if test=". = 'PRMD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_PRMD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IREC">
<xsl:if test=". = 'IREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRMR">
<xsl:if test=". = 'PRMR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_PRMR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EPRR">
<xsl:if test=". = 'EPRR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EPRR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EMTR">
<xsl:if test=". = 'EMTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_EMTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Pctg_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_2</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Pctg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/Pctg</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Pctg_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_2</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/PmtTerms/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/PmtTerms/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/PmtTerms/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SttlmTerms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/IBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/BBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/3</xsl:with-param>
<xsl:with-param name="value">3</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/UPIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{8,17}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_PrtryAcct_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/4</xsl:with-param>
<xsl:with-param name="value">4</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/PrtryAcct/Id</xsl:with-param>
<xsl:with-param name="maxsize">34</xsl:with-param>
<xsl:with-param name="size">34</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_definition</xsl:with-param>
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
<div id="/PmtOblgtn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtOblgtn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_OblgrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtOblgtn/OblgrBk/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_RcptBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtOblgtn/RcptBk/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtOblgtn/choice_3</xsl:with-param>
<xsl:with-param name="id">/PmtOblgtn/choice_3/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/PmtOblgtn/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/PmtOblgtn/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/PmtOblgtn/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_definition</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Pctg_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtOblgtn/choice_3</xsl:with-param>
<xsl:with-param name="id">/PmtOblgtn/choice_3/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Pctg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtOblgtn/Pctg</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Pctg_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtOblgtn/XpryDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/LatstMtchDt">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LatstMtchDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/TrnsprtDataSetReqrd">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_TrnsprtDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/InsrncDataSetReqrd">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_InsrncDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIsseDt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSetReqrd/MtchIsseDt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchTrnsprt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSetReqrd/MtchTrnsprt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAmt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSetReqrd/MtchAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/CertDataSetReqrd">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_CertDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSetReqrd/CertTp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="ANLY">
<xsl:if test=". = 'ANLY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ANLY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAL">
<xsl:if test=". = 'QUAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAN">
<xsl:if test=". = 'QUAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WEIG">
<xsl:if test=". = 'WEIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_WEIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ORIG">
<xsl:if test=". = 'ORIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ORIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="HEAL">
<xsl:if test=". = 'HEAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_HEAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PHYT">
<xsl:if test=". = 'PHYT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_PHYT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIsseDt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSetReqrd/MtchIsseDt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchInspctnDt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSetReqrd/MtchInspctnDt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_AuthrsdInspctrInd_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSetReqrd/AuthrsdInspctrInd</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchConsgn_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSetReqrd/MtchConsgn</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/OthrCertDataSetReqrd">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_OthrCertDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSetReqrd/CertTp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="BENE">
<xsl:if test=". = 'BENE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_BENE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SHIP">
<xsl:if test=". = 'SHIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_SHIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND1">
<xsl:if test=". = 'UND1'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND2">
<xsl:if test=". = 'UND2'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Tp">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Tp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tp/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHAR">
<xsl:if test=". = 'CHAR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CHAR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMM">
<xsl:if test=". = 'COMM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_COMM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TAXE">
<xsl:if test=". = 'TAXE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_TAXE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CISH">
<xsl:if test=". = 'CISH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CISH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TRAS">
<xsl:if test=". = 'TRAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_TRAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SACC">
<xsl:if test=". = 'SACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_SACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CACC">
<xsl:if test=". = 'CACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_CACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SVGS">
<xsl:if test=". = 'SVGS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_SVGS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONDP">
<xsl:if test=". = 'ONDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_ONDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MGLD">
<xsl:if test=". = 'MGLD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_MGLD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NREX">
<xsl:if test=". = 'NREX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_NREX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MOMA">
<xsl:if test=". = 'MOMA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_MOMA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOAN">
<xsl:if test=". = 'LOAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_LOAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SLRY">
<xsl:if test=". = 'SLRY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_SLRY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ODFT">
<xsl:if test=". = 'ODFT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_ODFT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tp/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/Prtry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Ccy">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Ccy</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{3,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Nm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Chrgs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Charge12_Chrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/choice_1</xsl:with-param>
<xsl:with-param name="id">/Chrgs/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="SIGN">
<xsl:if test=". = 'SIGN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_SIGN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STDE">
<xsl:if test=". = 'STDE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_STDE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STOR">
<xsl:if test=". = 'STOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_STOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PACK">
<xsl:if test=". = 'PACK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_PACK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PICK">
<xsl:if test=". = 'PICK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_PICK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DNGR">
<xsl:if test=". = 'DNGR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_DNGR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SECU">
<xsl:if test=". = 'SECU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_SECU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INSU">
<xsl:if test=". = 'INSU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_INSU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COLF">
<xsl:if test=". = 'COLF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_COLF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHOR">
<xsl:if test=". = 'CHOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_CHOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHDE">
<xsl:if test=". = 'CHDE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_CHDE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AIRF">
<xsl:if test=". = 'AIRF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_AIRF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TRPT">
<xsl:if test=". = 'TRPT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_TRPT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/choice_1</xsl:with-param>
<xsl:with-param name="id">/Chrgs/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/OthrChrgsTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/choice_2</xsl:with-param>
<xsl:with-param name="id">/Chrgs/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Chrgs/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Chrgs/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Chrgs/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_definition</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/choice_2</xsl:with-param>
<xsl:with-param name="id">/Chrgs/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/Rate</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/NmPrfx">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/NmPrfx</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="DOCT">
<xsl:if test=". = 'DOCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIST">
<xsl:if test=". = 'MIST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MISS">
<xsl:if test=". = 'MISS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MADM">
<xsl:if test=". = 'MADM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/GvnNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/GvnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Role">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Role</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PhneNb">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PhneNb</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/FaxNb">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/FaxNb</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/EmailAdr">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/EmailAdr</xsl:with-param>
<xsl:with-param name="maxsize">256</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/NmPrfx">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/NmPrfx</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="DOCT">
<xsl:if test=". = 'DOCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIST">
<xsl:if test=". = 'MIST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MISS">
<xsl:if test=". = 'MISS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MADM">
<xsl:if test=". = 'MADM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/GvnNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/GvnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Role">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Role</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PhneNb">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PhneNb</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/FaxNb">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/FaxNb</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/EmailAdr">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/EmailAdr</xsl:with-param>
<xsl:with-param name="maxsize">256</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Lctn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Lctn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/BuyrCtctPrsn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_BuyrCtctPrsn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrCtctPrsn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SellrCtctPrsn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SellrCtctPrsn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrCtctPrsn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BuyrBkCtctPrsn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrBkCtctPrsn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SellrBkCtctPrsn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrBkCtctPrsn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/OthrBkCtctPrsn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_OthrBkCtctPrsn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrBkCtctPrsn/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrBkCtctPrsn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/GoodsDesc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/GoodsDesc</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/TrnsShipmnt">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_TrnsShipmnt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsShipmnt</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/ShipmntDtRg">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_ShipmntDtRg_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/LineItmDtls">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmDtls_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/LineItmId</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Qty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/Qty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/Qty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/Qty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/Qty/choice_1</xsl:with-param>
<xsl:with-param name="id">/LineItmDtls/Qty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/Qty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmDtls/Qty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/LineItmDtls/TtlAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/LineItmDtls/TtlAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/LineItmDtls/TtlAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/RtgSummry">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_RtgSummry_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Incotrms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Cd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="EXW">
<xsl:if test=". = 'EXW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_EXW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FCA">
<xsl:if test=". = 'FCA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FAS">
<xsl:if test=". = 'FAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOB">
<xsl:if test=". = 'FOB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FOB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CFR">
<xsl:if test=". = 'CFR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CFR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIF">
<xsl:if test=". = 'CIF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CIF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CPT">
<xsl:if test=". = 'CPT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CPT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIP">
<xsl:if test=". = 'CIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DAF">
<xsl:if test=". = 'DAF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DAF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DES">
<xsl:if test=". = 'DES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DEQ">
<xsl:if test=". = 'DEQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DEQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDU">
<xsl:if test=". = 'DDU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DDU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDP">
<xsl:if test=". = 'DDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Othr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_2</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_definition</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_2</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Rate</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/FrghtChrgs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_FrghtChrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/FrghtChrgs/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="CLCT">
<xsl:if test=". = 'CLCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Tax">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="PROV">
<xsl:if test=". = 'PROV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<!-- <div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/OthrTaxTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div> -->
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_2</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Tax/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_definition</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_2</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/Rate</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BuyrDfndInf">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_BuyrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrDfndInf/Labl</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrDfndInf/Inf</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SellrDfndInf">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_SellrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrDfndInf/Labl</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrDfndInf/Inf</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/QtyTlrnce">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_QtyTlrnce_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/UnitPric">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_UnitPric_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UnitPric/choice_1</xsl:with-param>
<xsl:with-param name="id">/UnitPric/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UnitPric/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UnitPric/choice_1</xsl:with-param>
<xsl:with-param name="id">/UnitPric/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UnitPric/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/UnitPric/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/UnitPric/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/UnitPric/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PricTlrnce">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PricTlrnce_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PdctNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PdctIdr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctIdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_StrdPdctIdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctIdr/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_BINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMD">
<xsl:if test=". = 'COMD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_COMD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EANC">
<xsl:if test=". = 'EANC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_EANC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="HRTR">
<xsl:if test=". = 'HRTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_HRTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MANI">
<xsl:if test=". = 'MANI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_MANI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MODL">
<xsl:if test=". = 'MODL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_MODL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PART">
<xsl:if test=". = 'PART'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_PART')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QOTA">
<xsl:if test=". = 'QOTA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_QOTA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STYL">
<xsl:if test=". = 'STYL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_STYL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUPI">
<xsl:if test=". = 'SUPI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_SUPI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPCC">
<xsl:if test=". = 'UPCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_UPCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Idr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/StrdPdctIdr/Idr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Idr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_OthrPdctIdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctIdr/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/OthrPdctIdr/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/OthrPdctIdr/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctChrtcs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_StrdPdctChrtcs_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctChrtcs/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_BISP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHNR">
<xsl:if test=". = 'CHNR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_CHNR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLOR">
<xsl:if test=". = 'CLOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_CLOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EDSP">
<xsl:if test=". = 'EDSP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_EDSP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ENNR">
<xsl:if test=". = 'ENNR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_ENNR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OPTN">
<xsl:if test=". = 'OPTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_OPTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ORCR">
<xsl:if test=". = 'ORCR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_ORCR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PCTV">
<xsl:if test=". = 'PCTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_PCTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SISP">
<xsl:if test=". = 'SISP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SISP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SIZE">
<xsl:if test=". = 'SIZE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SIZE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SZRG">
<xsl:if test=". = 'SZRG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SZRG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SPRM">
<xsl:if test=". = 'SPRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_SPRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STOR">
<xsl:if test=". = 'STOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_STOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VINR">
<xsl:if test=". = 'VINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_VINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Chrtcs_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/StrdPdctChrtcs/Chrtcs</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Chrtcs_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_OthrPdctChrtcs_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctChrtcs/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/OthrPdctChrtcs/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/OthrPdctChrtcs/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctCtgy_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_StrdPdctCtgy_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctCtgy/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_HRTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QOTA">
<xsl:if test=". = 'QOTA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_QOTA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRGP">
<xsl:if test=". = 'PRGP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_PRGP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOBU">
<xsl:if test=". = 'LOBU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_LOBU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GNDR">
<xsl:if test=". = 'GNDR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_GNDR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Ctgy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/StrdPdctCtgy/Ctgy</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Ctgy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_OthrPdctCtgy_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/choice_1</xsl:with-param>
<xsl:with-param name="id">/PdctCtgy/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/OthrPdctCtgy/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/OthrPdctCtgy/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PdctOrgn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctOrgn</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/ShipmntSchdl">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_ShipmntSchdl_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntDtRg_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ShipmntSchdl/choice_1</xsl:with-param>
<xsl:with-param name="id">/ShipmntSchdl/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntSubSchdl_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ShipmntSchdl/choice_1</xsl:with-param>
<xsl:with-param name="id">/ShipmntSchdl/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/RtgSummry">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_RtgSummry_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Incotrms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Cd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="EXW">
<xsl:if test=". = 'EXW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_EXW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FCA">
<xsl:if test=". = 'FCA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FAS">
<xsl:if test=". = 'FAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOB">
<xsl:if test=". = 'FOB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_FOB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CFR">
<xsl:if test=". = 'CFR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CFR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIF">
<xsl:if test=". = 'CIF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CIF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CPT">
<xsl:if test=". = 'CPT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CPT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIP">
<xsl:if test=". = 'CIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_CIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DAF">
<xsl:if test=". = 'DAF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DAF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DES">
<xsl:if test=". = 'DES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DEQ">
<xsl:if test=". = 'DEQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DEQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDU">
<xsl:if test=". = 'DDU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DDU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDP">
<xsl:if test=". = 'DDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_DDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Othr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_1</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_2</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_definition</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/choice_2</xsl:with-param>
<xsl:with-param name="id">/Adjstmnt/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/Rate</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/FrghtChrgs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_FrghtChrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/FrghtChrgs/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="CLCT">
<xsl:if test=". = 'CLCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Tax">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/Tp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="PROV">
<xsl:if test=". = 'PROV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<!-- <div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/OthrTaxTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div> -->
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_2</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Tax/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_definition</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_2</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/Rate</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PrtryId">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PrtryId">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/ChrgsAmt">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/ChrgsAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/ChrgsAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/ChrgsAmt</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_definition</xsl:with-param>
</xsl:call-template>
</div>
<div id="/ChrgsPctg">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ChrgsPctg</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/AplblLaw">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AplblLaw</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PmtTerms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_OthrPmtTerms_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_1</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_OthrPmtTerms_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/OthrPmtTerms</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_OthrPmtTerms_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_PmtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_1</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/PmtCd/Cd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="CASH">
<xsl:if test=". = 'CASH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EMTD">
<xsl:if test=". = 'EMTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_EMTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EPRD">
<xsl:if test=". = 'EPRD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_EPRD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRMD">
<xsl:if test=". = 'PRMD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_PRMD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IREC">
<xsl:if test=". = 'IREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRMR">
<xsl:if test=". = 'PRMR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_PRMR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EPRR">
<xsl:if test=". = 'EPRR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_EPRR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EMTR">
<xsl:if test=". = 'EMTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_EMTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EPAM">
<xsl:if test=". = 'EPAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_EPAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Pctg_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_2</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Pctg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/Pctg</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'10'}</xsl:with-param>
<xsl:with-param name="size">11</xsl:with-param>
<xsl:with-param name="maxsize">11</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Pctg_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_2</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/PmtTerms/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/PmtTerms/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/PmtTerms/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SttlmTerms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/IBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/BBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/3</xsl:with-param>
<xsl:with-param name="value">3</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/UPIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{8,17}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_PrtryAcct_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/SttlmTerms/CdtrAcct/Id/choice_1/4</xsl:with-param>
<xsl:with-param name="value">4</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/PrtryAcct/Id</xsl:with-param>
<xsl:with-param name="maxsize">34</xsl:with-param>
<xsl:with-param name="size">34</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_definition</xsl:with-param>
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
<div id="/NbOfDays">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_NbOfDays_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/NbOfDays</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_NbOfDays_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/NbOfDays">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_NbOfDays_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/NbOfDays</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_NbOfDays_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/StrtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/StrtNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CtrySubDvsn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CtrySubDvsn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/StrtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/StrtNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PstCdId">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PstCdId</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/TwnNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TwnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CtrySubDvsn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CtrySubDvsn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Fctr">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Fctr</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Submitr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Submitr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/MtchIssr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MtchIssr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MtchIssr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/ClausesReqrd">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ClausesReqrd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="ICCA">
<xsl:if test=". = 'ICCA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCB">
<xsl:if test=". = 'ICCB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCC">
<xsl:if test=". = 'ICCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICAI">
<xsl:if test=". = 'ICAI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICAI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IWCC">
<xsl:if test=". = 'IWCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IWCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISCC">
<xsl:if test=". = 'ISCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IREC">
<xsl:if test=". = 'IREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICLC">
<xsl:if test=". = 'ICLC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICLC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISMC">
<xsl:if test=". = 'ISMC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISMC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMCC">
<xsl:if test=". = 'CMCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_CMCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IRCE">
<xsl:if test=". = 'IRCE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IRCE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/MtchAssrdPty">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MtchAssrdPty</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="BUYE">
<xsl:if test=". = 'BUYE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUYE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SELL">
<xsl:if test=". = 'SELL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SELL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BUBA">
<xsl:if test=". = 'BUBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SEBA">
<xsl:if test=". = 'SEBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SEBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Submitr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/MtchIssr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MtchIssr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MtchIssr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/MtchManfctr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchManfctr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MtchManfctr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MtchManfctr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/LineItmId">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmId</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Submitr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/CdtrAgt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAgt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/choice_1</xsl:with-param>
<xsl:with-param name="id">/CdtrAgt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_NmAndAdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/choice_1</xsl:with-param>
<xsl:with-param name="id">/CdtrAgt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Adr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/PstCdId</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/TwnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress2_Ctry_definition</xsl:with-param>
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
<div id="/EarlstShipmntDt">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/EarlstShipmntDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/LatstShipmntDt">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LatstShipmntDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/EarlstShipmntDt">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_EarlstShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/EarlstShipmntDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_EarlstShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/LatstShipmntDt">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_LatstShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LatstShipmntDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_LatstShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/ShipmntSubSchdl">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_SubQtyVal_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ShipmntSubSchdl/SubQtyVal</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_SubQtyVal_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByAir">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByAir_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtBySea">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtBySea_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByRoad">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRoad_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByRail">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRail_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/DprtureAirprt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DprtureAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/DprtureAirprt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DprtureAirprt/AirprtCd</xsl:with-param>
<xsl:with-param name="maxsize">6</xsl:with-param>
<xsl:with-param name="size">6</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_OthrAirprtDesc_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DprtureAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/DprtureAirprt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DprtureAirprt/OthrAirprtDesc/Twn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/DstnAirprt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DstnAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DstnAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/DstnAirprt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DstnAirprt/AirprtCd</xsl:with-param>
<xsl:with-param name="maxsize">6</xsl:with-param>
<xsl:with-param name="size">6</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_OthrAirprtDesc_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DstnAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/DstnAirprt/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/DstnAirprt/OthrAirprtDesc/Twn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/AirCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AirCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PlcOfRct">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PlcOfRct</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PlcOfDlvry">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PlcOfDlvry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/RailCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RailCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PlcOfRct">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PlcOfRct</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PlcOfDlvry">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PlcOfDlvry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/RoadCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RoadCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PortOfLoadng">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PortOfLoadng</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PortOfDschrge">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PortOfDschrge</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/SeaCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SeaCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/MltmdlTrnsprt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportMeans1_MltmdlTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MltmdlTrnsprt/TakngInChrg</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MltmdlTrnsprt/PlcOfFnlDstn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Fctr">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Fctr</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_definition</xsl:with-param>
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
<xsl:apply-templates select="InitlBaselnSubmissn">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/InitlBaselnSubmissn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InitlBaselnSubmissn"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_name</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
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
<xsl:apply-templates select="OthrBkCtctPrsn">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SubmissnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmissnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmissnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="SubmissnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SubmissnId/CreDtTm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SubmitrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmitrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmitrTxRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="SubmitrTxRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/Instr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Instr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Instr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Instr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Instr/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_name</xsl:variable>
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
<option value="LODG">
<xsl:if test=". = 'LODG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_code_LODG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FPTR">
<xsl:if test=". = 'FPTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_code_FPTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'LODG'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_code_LODG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'FPTR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_code_FPTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/Baseln">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Baseln"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Baseln_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="SubmitrBaselnId">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SvcCd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrSdSubmitgBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrSdSubmitgBk">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BllTo">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipTo">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Goods">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtOblgtn">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstMtchDt">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrCertDataSetReqrd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InttToPayXpctd">
<xsl:with-param name="path" select="concat($path,'/Baseln')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Baseln/SubmitrBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrBaselnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_SubmitrBaselnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/SvcCd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SvcCd"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/SvcCd')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="LEV1">
<xsl:if test=". = 'LEV1'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LEV2">
<xsl:if test=". = 'LEV2'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LEV3">
<xsl:if test=". = 'LEV3'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV3')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="SvcCd = 'LEV1'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="SvcCd = 'LEV2'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="SvcCd = 'LEV3'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_LEV3')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
<xsl:with-param name="readOnly"/>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_Buyr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Buyr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_Sellr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Sellr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrBk_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrBk_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/BuyrSdSubmitgBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrSdSubmitgBk"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/BuyrSdSubmitgBk[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrSdSubmitgBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/BuyrSdSubmitgBk[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BuyrSdSubmitgBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/SellrSdSubmitgBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrSdSubmitgBk"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SellrSdSubmitgBk[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrSdSubmitgBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SellrSdSubmitgBk[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SellrSdSubmitgBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/BllTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BllTo"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/BllTo')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_BllTo_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BllTo/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BllTo/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BllTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/ShipTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipTo"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ShipTo')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_ShipTo_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ShipTo/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ShipTo/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ShipTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/Consgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Consgn')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_Consgn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgn/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgn/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/Goods">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Goods"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_Goods_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="GoodsDesc">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtlShipmnt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsShipmnt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipmntDtRg">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmDtls">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/GoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/GoodsDesc')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Goods/PrtlShipmnt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PrtlShipmnt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_PrtlShipmnt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PrtlShipmnt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/TrnsShipmnt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TrnsShipmnt"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_TrnsShipmnt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TrnsShipmnt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Goods/ShipmntDtRg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntDtRg"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ShipmntDtRg')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_ShipmntDtRg_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="EarlstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ShipmntDtRg/EarlstShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EarlstShipmntDt"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/EarlstShipmntDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ShipmntDtRg/LatstShipmntDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LatstShipmntDt"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/LatstShipmntDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Goods/LineItmDtls">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmDtls"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmDtls_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="QtyTlrnce">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UnitPric">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PricTlrnce">
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
<xsl:apply-templates select="PdctOrgn">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipmntSchdl">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlAmt">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/Qty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Qty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Qty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Qty/Fctr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_QtyTlrnce_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/UnitPric">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitPric"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/UnitPric')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_UnitPric_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="UnitPric/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_definition</xsl:with-param>
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
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PricTlrnce_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctIdr_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctChrtcs_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctCtgy_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdctOrgn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctOrgn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PdctOrgn[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/ShipmntSchdl">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntSchdl"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ShipmntSchdl')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_ShipmntSchdl_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/RtgSummry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/RtgSummry')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_RtgSummry_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="IndvTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MltmdlTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RtgSummry/IndvTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IndvTrnsprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TrnsprtByAir">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByAir">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByAir_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/DprtureAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DprtureAirprt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/DprtureAirprt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DstnAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtByAir/AirCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AirCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtBySea">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtBySea_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfLoadng">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfLoadng"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfLoadng[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfDschrge[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/SeaCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SeaCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/SeaCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRoad">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRoad_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfRct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/RoadCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RoadCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/RoadCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRail">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRail_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfRct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/RailCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RailCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/RailCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="RtgSummry/MltmdlTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MltmdlTrnsprt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportMeans1_MltmdlTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TakngInChrg">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfFnlDstn">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/TakngInChrg">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TakngInChrg"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TakngInChrg')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/PlcOfFnlDstn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfFnlDstn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfFnlDstn')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Incotrms/Lctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Lctn')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Drctn">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Drctn')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="ADDD">
<xsl:if test=". = 'ADDD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Drctn = 'ADDD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Drctn = 'SUBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/FrghtChrgs')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_FrghtChrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FrghtChrgs/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name</xsl:variable>
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
<option value="CLCT">
<xsl:if test=". = 'CLCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'CLCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'PRPD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FrghtChrgs/Chrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrgs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Charge12_Chrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/Tax">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Tax[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="LineItmDtls_Tax_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="LineItmDtls_Tax_choice_2">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_Tax_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name')&#10;            "/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="OthrTaxTp">
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<!-- <div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition')"/>
</xsl:attribute>
</img>
</div> -->
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="Tax/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
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
<option value="PROV">
<xsl:if test=". = 'PROV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'PROV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'NATI'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'WITH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'COAX'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'VATA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CUST'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Tax/OthrTaxTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrTaxTp"/>
</xsl:variable>
<!-- <div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OthrTaxTp')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div> -->
</xsl:template>
<xsl:template name="LineItmDtls_Tax_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_2</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_2</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Rate">
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<!-- <div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Rate</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " size="11" maxlength="11" value="">
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/Rate</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/Rate</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition')"/>
</xsl:attribute>
</img>
</div> -->
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_definition</xsl:with-param>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Rate')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/TtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/TtlAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/TtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_TtlAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/LineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmsTtlAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/LineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/LineItmsTtlAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/LineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmsTtlAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/RtgSummry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/RtgSummry')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_RtgSummry_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="IndvTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MltmdlTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RtgSummry/IndvTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IndvTrnsprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TrnsprtByAir">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail">
<xsl:with-param name="path" select="concat($path,'/IndvTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByAir">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByAir_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/DprtureAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DprtureAirprt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/DprtureAirprt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DstnAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtByAir/AirCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AirCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AirCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtBySea">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtBySea_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfLoadng">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfLoadng"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfLoadng[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfDschrge[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/SeaCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="SeaCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/SeaCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRoad">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRoad_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfRct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/RoadCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RoadCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/RoadCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="IndvTrnsprt/TrnsprtByRail">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRail_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfRct">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/RailCrrierNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="RailCrrierNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/RailCrrierNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="RtgSummry/MltmdlTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MltmdlTrnsprt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_TransportMeans1_MltmdlTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TakngInChrg">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfFnlDstn">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/TakngInChrg">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TakngInChrg"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TakngInChrg')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/PlcOfFnlDstn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfFnlDstn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfFnlDstn')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Incotrms/Lctn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Lctn')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Goods/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Drctn">
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Drctn')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="ADDD">
<xsl:if test=". = 'ADDD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Drctn = 'ADDD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Drctn = 'SUBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/FrghtChrgs')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_FrghtChrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FrghtChrgs/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name</xsl:variable>
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
<option value="CLCT">
<xsl:if test=". = 'CLCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'CLCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'PRPD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FrghtChrgs/Chrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrgs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Charge12_Chrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/Tax">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Tax[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="Goods_Tax_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="Goods_Tax_choice_2">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="Goods_Tax_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name')&#10;            "/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:otherwise>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_1</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="OthrTaxTp">
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<!-- <div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " minlength="1" maxlength="35" size="35" value="">
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition')"/>
</xsl:attribute>
</img>
</div> -->
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="Tax/Tp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name</xsl:variable>
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
<option value="PROV">
<xsl:if test=". = 'PROV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'PROV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'NATI'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'WITH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'COAX'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'VATA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CUST'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Tax/OthrTaxTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrTaxTp"/>
</xsl:variable>
<!-- <div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/OthrTaxTp')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div> -->
</xsl:template>
<xsl:template name="Goods_Tax_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_2</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="$path"/>/choice_2</xsl:with-param>
<xsl:with-param name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="displaymode">view</xsl:with-param>
<xsl:with-param name="override-displaymode">view</xsl:with-param>
</xsl:call-template>
<div class="section">
<xsl:choose>
<xsl:when test="Rate">
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<!-- <div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Rate</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name')&#10;            "/>
</label>
<input class="&#10;            input-box&#10;            &#10;              mandatory&#10;            " size="11" maxlength="11" value="">
<xsl:attribute name="onblur">fncCheckLeds(this);</xsl:attribute>
<xsl:attribute name="name">
<xsl:value-of select="$path"/>/Rate</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/Rate</xsl:attribute>
</input>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition')"/>
</xsl:attribute>
</img>
</div> -->
</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:template>
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_definition</xsl:with-param>
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
<!-- <div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Rate')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition</xsl:with-param>
</xsl:call-template>
</div> -->
</xsl:template>
<xsl:template match="Goods/TtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlNetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_TtlNetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_LineItem7_TtlNetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/TtlNetAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/TtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_LineItem7_TtlNetAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/BuyrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrDfndInf"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_BuyrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BuyrDfndInf/Labl">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Labl')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BuyrDfndInf/Inf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Inf')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/SellrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrDfndInf"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_LineItem7_SellrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SellrDfndInf/Labl">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Labl')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SellrDfndInf/Inf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Inf')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/PmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Baseln/SttlmTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SttlmTerms')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="CdtrAgt">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CdtrAcct">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
<xsl:with-param name="readOnly"/>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAgt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAcct"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ccy">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Tp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Baseln/PmtOblgtn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtOblgtn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtOblgtn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="OblgrBk">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RcptBk">
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
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/OblgrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OblgrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_OblgrBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/OblgrBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="OblgrBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/RcptBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RcptBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_RcptBk_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/RcptBk')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RcptBk/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/ChrgsAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ChrgsAmt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ChrgsAmt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/ChrgsAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/ChrgsAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/ChrgsAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/ChrgsPctg">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ChrgsPctg"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/ChrgsPctg')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/XpryDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="XpryDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/XpryDt')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/AplblLaw">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AplblLaw"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AplblLaw')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/PmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/SttlmTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SttlmTerms')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="CdtrAgt">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CdtrAcct">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
<xsl:with-param name="readOnly"/>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAgt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAcct"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ccy">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/CdtrAcct')"/>
<xsl:with-param name="readOnly"/>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
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
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Tp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Baseln/LatstMtchDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LatstMtchDt"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/LatstMtchDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Baseln/ComrclDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDataSetReqrd"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_ComrclDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/TrnsprtDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDataSetReqrd"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtDataSetReqrd')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_TrnsprtDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/InsrncDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrncDataSetReqrd"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/InsrncDataSetReqrd')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_InsrncDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIssr">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIsseDt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchTrnsprt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchAmt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClausesReqrd">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchAssrdPty">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSetReqrd')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIssr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/MtchIssr')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchIssr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchIsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIsseDt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MtchIsseDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchTrnsprt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchTrnsprt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchTrnsprt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MtchTrnsprt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchAmt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchAmt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAmt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MtchAmt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/ClausesReqrd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ClausesReqrd"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/ClausesReqrd[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="ICCA">
<xsl:if test=". = 'ICCA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCB">
<xsl:if test=". = 'ICCB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCC">
<xsl:if test=". = 'ICCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICAI">
<xsl:if test=". = 'ICAI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICAI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IWCC">
<xsl:if test=". = 'IWCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IWCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISCC">
<xsl:if test=". = 'ISCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IREC">
<xsl:if test=". = 'IREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICLC">
<xsl:if test=". = 'ICLC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICLC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISMC">
<xsl:if test=". = 'ISMC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISMC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMCC">
<xsl:if test=". = 'CMCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_CMCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IRCE">
<xsl:if test=". = 'IRCE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IRCE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="ClausesReqrd = 'ICCA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'ICCB'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'ICCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'ICAI'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICAI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'IWCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IWCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'ISCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'IREC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'ICLC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ICLC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'ISMC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_ISMC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'CMCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_CMCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="ClausesReqrd = 'IRCE'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_IRCE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchAssrdPty">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchAssrdPty"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MtchAssrdPty')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="BUYE">
<xsl:if test=". = 'BUYE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUYE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SELL">
<xsl:if test=". = 'SELL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SELL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BUBA">
<xsl:if test=". = 'BUBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SEBA">
<xsl:if test=". = 'SEBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SEBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="MtchAssrdPty = 'BUYE'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUYE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="MtchAssrdPty = 'SELL'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SELL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="MtchAssrdPty = 'BUBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_BUBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="MtchAssrdPty = 'SEBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_SEBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Baseln/CertDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertDataSetReqrd"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_CertDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIssr">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchIsseDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchInspctnDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AuthrsdInspctrInd">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchConsgn">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="MtchManfctr">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/CertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CertTp')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="ANLY">
<xsl:if test=". = 'ANLY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ANLY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAL">
<xsl:if test=". = 'QUAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAN">
<xsl:if test=". = 'QUAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WEIG">
<xsl:if test=". = 'WEIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_WEIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ORIG">
<xsl:if test=". = 'ORIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ORIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="HEAL">
<xsl:if test=". = 'HEAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_HEAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PHYT">
<xsl:if test=". = 'PHYT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_PHYT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="CertTp = 'ANLY'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ANLY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'QUAL'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'QUAN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_QUAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'WEIG'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_WEIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'ORIG'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_ORIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'HEAL'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_HEAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'PHYT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_PHYT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIssr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/MtchIssr')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchIssr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchIsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIsseDt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MtchIsseDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchInspctnDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchInspctnDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchInspctnDt_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MtchInspctnDt')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/AuthrsdInspctrInd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AuthrsdInspctrInd"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_AuthrsdInspctrInd_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AuthrsdInspctrInd')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchConsgn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="MtchConsgn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchConsgn_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/MtchConsgn')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchManfctr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchManfctr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/MtchManfctr')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchManfctr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchManfctr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchManfctr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="MtchManfctr/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/LineItmId[', $index,']')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Baseln/OthrCertDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrCertDataSetReqrd"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_Baseline3_OthrCertDataSetReqrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CertTp')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="BENE">
<xsl:if test=". = 'BENE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_BENE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SHIP">
<xsl:if test=". = 'SHIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_SHIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND1">
<xsl:if test=". = 'UND1'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND2">
<xsl:if test=". = 'UND2'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="CertTp = 'BENE'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_BENE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'SHIP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_SHIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'UND1'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'UND2'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_UND2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Baseln/InttToPayXpctd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InttToPayXpctd"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_Baseline3_InttToPayXpctd_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InttToPayXpctd')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/BuyrCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrCtctPrsn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_BuyrCtctPrsn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/BuyrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
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
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="DOCT">
<xsl:if test=". = 'DOCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIST">
<xsl:if test=". = 'MIST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MISS">
<xsl:if test=". = 'MISS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MADM">
<xsl:if test=". = 'MADM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="NmPrfx = 'DOCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MIST'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MISS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MADM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/GvnNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Role')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">256</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SellrCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrCtctPrsn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SellrCtctPrsn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/SellrCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name</xsl:variable>
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
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="DOCT">
<xsl:if test=". = 'DOCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIST">
<xsl:if test=". = 'MIST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MISS">
<xsl:if test=". = 'MISS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MADM">
<xsl:if test=". = 'MADM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="NmPrfx = 'DOCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MIST'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MISS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MADM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/GvnNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Role')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">256</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/OthrBkCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrBkCtctPrsn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_OthrBkCtctPrsn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="NmPrfx">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GvnNm">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Role">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PhneNb">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FaxNb">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EmailAdr">
<xsl:with-param name="path" select="concat($path,'/OthrBkCtctPrsn[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/BIC">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_name</xsl:variable>
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
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<xsl:choose>
<xsl:when test="$displaymode='edit'">
<option value="DOCT">
<xsl:if test=". = 'DOCT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIST">
<xsl:if test=". = 'MIST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MISS">
<xsl:if test=". = 'MISS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MADM">
<xsl:if test=". = 'MADM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="NmPrfx = 'DOCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_DOCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MIST'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MIST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MISS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MISS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="NmPrfx = 'MADM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_MADM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/GvnNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Role')"/>
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
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">256</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
