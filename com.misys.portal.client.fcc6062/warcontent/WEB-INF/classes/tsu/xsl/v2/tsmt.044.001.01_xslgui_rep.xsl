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
<div id="/Tp">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_CashAccount7_Tp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHAR">
<xsl:if test=". = 'CHAR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_CHAR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMM">
<xsl:if test=". = 'COMM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_COMM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TAXE">
<xsl:if test=". = 'TAXE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_TAXE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CISH">
<xsl:if test=". = 'CISH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_CISH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TRAS">
<xsl:if test=". = 'TRAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_TRAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SACC">
<xsl:if test=". = 'SACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_SACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CACC">
<xsl:if test=". = 'CACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_CACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SVGS">
<xsl:if test=". = 'SVGS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_SVGS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONDP">
<xsl:if test=". = 'ONDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_ONDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MGLD">
<xsl:if test=". = 'MGLD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_MGLD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NREX">
<xsl:if test=". = 'NREX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_NREX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MOMA">
<xsl:if test=". = 'MOMA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_MOMA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOAN">
<xsl:if test=". = 'LOAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_LOAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SLRY">
<xsl:if test=". = 'SLRY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_SLRY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ODFT">
<xsl:if test=". = 'ODFT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_code_ODFT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_CashAccountType2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccountType2_Prtry_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/Prtry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_CashAccountType2_Prtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Ccy">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccount7_Ccy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Ccy</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{3,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_CashAccount7_Ccy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Nm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccount7_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/SttlmTerms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPay1_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_IBAN_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/IBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_IBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_BBAN_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/BBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_BBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_UPIC_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/UPIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{8,17}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_UPIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_AccountIdentification3Choice_PrtryAcct_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation2_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SttlmTerms/CdtrAcct/Id/PrtryAcct/Id</xsl:with-param>
<xsl:with-param name="maxsize">34</xsl:with-param>
<xsl:with-param name="size">34</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation2_Id_definition</xsl:with-param>
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
<div id="/SubmitrTxRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPayNotificationV01_SubmitrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SubmitrTxRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/StrtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_PostalAddress2_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/StrtNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_PostalAddress2_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CtrySubDvsn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_PostalAddress2_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CtrySubDvsn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_PostalAddress2_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_ReportLine2_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_ReportLine3_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_ReportLine4_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InttToPayNtfctn_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BrkdwnByPurchsOrdr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_ReportLine4_BrkdwnByPurchsOrdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_ReportLine2_TxId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BrkdwnByPurchsOrdr/TxId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_ReportLine2_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_ReportLine2_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BrkdwnByPurchsOrdr/PurchsOrdrRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/BrkdwnByPurchsOrdr/NetAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_InttToPayNtfctn_ReportLine2_NetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/BrkdwnByPurchsOrdr/NetAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/BrkdwnByPurchsOrdr/NetAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_ReportLine2_NetAmt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/CdtrAgt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_SettlementTerms2_CdtrAgt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_FinancialInstitutionIdentification4Choice_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_FinancialInstitutionIdentification4Choice_NmAndAdr_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_NameAndAddress6_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_NameAndAddress6_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_NameAndAddress6_Adr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_PostalAddress2_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/PstCdId</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_PostalAddress2_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_PostalAddress2_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/TwnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_PostalAddress2_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_PostalAddress2_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_PostalAddress2_Ctry_definition</xsl:with-param>
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
<xsl:apply-templates select="InttToPayNtfctn">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/InttToPayNtfctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InttToPayNtfctn"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_name</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="NtfctnId">
<xsl:with-param name="path" select="concat($path,'/InttToPayNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/InttToPayNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SubmitrTxRef">
<xsl:with-param name="path" select="concat($path,'/InttToPayNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/InttToPayNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/InttToPayNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InttToPay">
<xsl:with-param name="path" select="concat($path,'/InttToPayNtfctn')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InttToPayNtfctn/NtfctnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NtfctnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPayNotificationV01_NtfctnId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_MessageIdentification1_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InttToPayNtfctn/TxId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPayNotificationV01_TxId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InttToPayNtfctn/SubmitrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SubmitrTxRef')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPayNotificationV01_SubmitrTxRef_name</xsl:with-param>
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
</div>
</xsl:template>
<xsl:template match="SubmitrTxRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InttToPayNtfctn/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPayNotificationV01_BuyrBk_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InttToPayNtfctn/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPayNotificationV01_SellrBk_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InttToPayNtfctn/InttToPay">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InttToPay"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPayNotificationV01_InttToPay_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_IntentToPay1_XpctdPmtDt_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_IntentToPay1_XpctdPmtDt_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_IntentToPay1_SttlmTerms_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_SettlementTerms2_CdtrAgt_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_SettlementTerms2_CdtrAcct_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_CashAccount7_Id_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_InttToPayNtfctn_CashAccount7_Tp_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccount7_Ccy_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_CashAccount7_Ccy_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_InttToPayNtfctn_CashAccount7_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_InttToPayNtfctn_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
