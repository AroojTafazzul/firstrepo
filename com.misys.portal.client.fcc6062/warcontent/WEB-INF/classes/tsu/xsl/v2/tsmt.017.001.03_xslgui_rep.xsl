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
<div id="/AirprtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_AirprtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AirprtNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_AirprtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Tp">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Tp_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHAR">
<xsl:if test=". = 'CHAR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CHAR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMM">
<xsl:if test=". = 'COMM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_COMM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TAXE">
<xsl:if test=". = 'TAXE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_TAXE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CISH">
<xsl:if test=". = 'CISH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CISH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TRAS">
<xsl:if test=". = 'TRAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_TRAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SACC">
<xsl:if test=". = 'SACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_SACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CACC">
<xsl:if test=". = 'CACC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_CACC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SVGS">
<xsl:if test=". = 'SVGS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_SVGS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONDP">
<xsl:if test=". = 'ONDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_ONDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MGLD">
<xsl:if test=". = 'MGLD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_MGLD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NREX">
<xsl:if test=". = 'NREX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_NREX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MOMA">
<xsl:if test=". = 'MOMA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_MOMA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOAN">
<xsl:if test=". = 'LOAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_LOAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SLRY">
<xsl:if test=". = 'SLRY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_SLRY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ODFT">
<xsl:if test=". = 'ODFT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_code_ODFT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Prtry_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Prtry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tp/Prtry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccountType2_Prtry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Ccy">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Ccy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Ccy</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{3,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Ccy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Nm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/LineItm">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_LineItm_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItm/PurchsOrdrRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItm/PurchsOrdrRef/DtOfIsse</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PlcOfIsse">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_PlcOfIsse_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PlcOfIsse/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/InspctnDt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_InspctnDt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_FrDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InspctnDt/FrDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_FrDt_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_ToDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InspctnDt/ToDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_ToDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/AuthrsdInspctrInd">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AuthrsdInspctrInd_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AuthrsdInspctrInd</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Trnsprt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Trnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/GoodsDesc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_GoodsDesc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/GoodsDesc</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_GoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Consgnr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgnr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgnr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgnr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgn/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Manfctr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Manfctr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Manfctr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Manfctr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/AddtlInf">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AddtlInf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AddtlInf</xsl:with-param>
<xsl:with-param name="maxsize">350</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AddtlInf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Chrgs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Chrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/choice_1</xsl:with-param>
<xsl:with-param name="id">/Chrgs/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_SIGN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STDE">
<xsl:if test=". = 'STDE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_STDE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STOR">
<xsl:if test=". = 'STOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_STOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PACK">
<xsl:if test=". = 'PACK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_PACK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PICK">
<xsl:if test=". = 'PICK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_PICK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DNGR">
<xsl:if test=". = 'DNGR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_DNGR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SECU">
<xsl:if test=". = 'SECU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_SECU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INSU">
<xsl:if test=". = 'INSU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_INSU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COLF">
<xsl:if test=". = 'COLF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_COLF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHOR">
<xsl:if test=". = 'CHOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_CHOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHDE">
<xsl:if test=". = 'CHDE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_CHDE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AIRF">
<xsl:if test=". = 'AIRF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_AIRF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TRPT">
<xsl:if test=". = 'TRPT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_code_TRPT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_OthrChrgsTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/choice_1</xsl:with-param>
<xsl:with-param name="id">/Chrgs/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_OthrChrgsTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Chrgs/OthrChrgsTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_OthrChrgsTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Chrgs/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Chrgs/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Chrgs/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BllTo">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_BllTo_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BllTo/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BllTo/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Goods">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Goods_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Goods/PurchsOrdrRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Goods/PurchsOrdrRef/DtOfIsse</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FnlSubmissn_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Goods/FnlSubmissn</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Goods/LineItmsTtlAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Goods/LineItmsTtlAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Goods/LineItmsTtlAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_definition</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Goods/TtlNetAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Goods/TtlNetAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Goods/TtlNetAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PmtTerms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_PmtTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_OthrPmtTerms_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_1</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_OthrPmtTerms_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/OthrPmtTerms</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_OthrPmtTerms_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_PmtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_1</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_1/2</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_CASH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EMTD">
<xsl:if test=". = 'EMTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EMTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EPRD">
<xsl:if test=". = 'EPRD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EPRD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRMD">
<xsl:if test=". = 'PRMD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_PRMD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IREC">
<xsl:if test=". = 'IREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRMR">
<xsl:if test=". = 'PRMR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_PRMR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EPRR">
<xsl:if test=". = 'EPRR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EPRR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EMTR">
<xsl:if test=". = 'EMTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_code_EMTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Pctg_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_2</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_2/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Pctg_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Pctg_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Amt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PmtTerms/choice_2</xsl:with-param>
<xsl:with-param name="id">/PmtTerms/choice_2/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/PmtTerms/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/PmtTerms/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/PmtTerms/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentTerms1_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TtlQty">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/TtlQty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlQty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlQty/choice_1</xsl:with-param>
<xsl:with-param name="id">/TtlQty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlQty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlQty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TtlVol">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlVol_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlVol/choice_1</xsl:with-param>
<xsl:with-param name="id">/TtlVol/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlVol/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlVol/choice_1</xsl:with-param>
<xsl:with-param name="id">/TtlVol/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlVol/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlVol/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TtlWght">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlWght_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlWght/choice_1</xsl:with-param>
<xsl:with-param name="id">/TtlWght/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlWght/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlWght/choice_1</xsl:with-param>
<xsl:with-param name="id">/TtlWght/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlWght/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TtlWght/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/UsrTxRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_UsrTxRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_IdIssr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UsrTxRef/IdIssr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/RltdTxRefs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_RltdTxRefs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdTxRefs/TxId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdTxRefs/PurchsOrdrRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdTxRefs/PurchsOrdrRef/DtOfIsse</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_ForcdMtch_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdTxRefs/ForcdMtch</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_EstblishdBaselnId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdTxRefs/EstblishdBaselnId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdTxRefs/EstblishdBaselnId/Vrsn</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RltdTxRefs/TxSts</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="PROP">
<xsl:if test=". = 'PROP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLSD">
<xsl:if test=". = 'CLSD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PMTC">
<xsl:if test=". = 'PMTC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ESTD">
<xsl:if test=". = 'ESTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ACTV">
<xsl:if test=". = 'ACTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMP">
<xsl:if test=". = 'COMP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AMRQ">
<xsl:if test=". = 'AMRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RARQ">
<xsl:if test=". = 'RARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLRQ">
<xsl:if test=". = 'CLRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SCRQ">
<xsl:if test=". = 'SCRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SERQ">
<xsl:if test=". = 'SERQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DARQ">
<xsl:if test=". = 'DARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/ComrclDataSet">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ComrclDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/DataSetId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/DataSetId/Vrsn</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/DataSetId/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDocRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_InvcNb_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/ComrclDocRef/InvcNb</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_InvcNb_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_IsseDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/ComrclDocRef/IsseDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Buyr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/Buyr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/Buyr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Sellr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/Sellr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/Sellr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_SttlmTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAcct_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Id_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_IBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/IBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z]{2,2}[0-9]{2,2}[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_IBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_BBAN_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/BBAN</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[a-zA-Z0-9]{1,30}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_BBAN_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1/3</xsl:with-param>
<xsl:with-param name="value">3</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_UPIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/UPIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{8,17}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_UPIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AccountIdentification3Choice_PrtryAcct_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1</xsl:with-param>
<xsl:with-param name="id">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/choice_1/4</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_SimpleIdentificationInformation2_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclDataSet/SttlmTerms/CdtrAcct/Id/PrtryAcct/Id</xsl:with-param>
<xsl:with-param name="maxsize">34</xsl:with-param>
<xsl:with-param name="size">34</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_SimpleIdentificationInformation2_Id_definition</xsl:with-param>
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
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtDataSet">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_TrnsprtDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/DataSetId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/DataSetId/Vrsn</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/DataSetId/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgnr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/Consgnr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/Consgnr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_RtgSummry_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_IndvTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_PropsdShipmntDt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/TrnsprtInf/choice_5</xsl:with-param>
<xsl:with-param name="id">/TrnsprtDataSet/TrnsprtInf/choice_5/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_PropsdShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/TrnsprtInf/PropsdShipmntDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_PropsdShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_ActlShipmntDt_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/TrnsprtInf/choice_5</xsl:with-param>
<xsl:with-param name="id">/TrnsprtDataSet/TrnsprtInf/choice_5/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_ActlShipmntDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDataSet/TrnsprtInf/ActlShipmntDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_ActlShipmntDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/InsrncDataSet">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_InsrncDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/DataSetId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/DataSetId/Vrsn</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/DataSetId/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Issr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/Issr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/Issr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_IsseDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/IsseDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDocId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/InsrncDocId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDocId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/InsrncDataSet/InsrdAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/InsrncDataSet/InsrdAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/InsrncDataSet/InsrdAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_definition</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Assrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification29Choice_BIC_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/Assrd/choice_1</xsl:with-param>
<xsl:with-param name="id">/InsrncDataSet/Assrd/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification29Choice_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/Assrd/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification29Choice_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification29Choice_NmAndAdr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/Assrd/choice_1</xsl:with-param>
<xsl:with-param name="id">/InsrncDataSet/Assrd/choice_1/2</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/Assrd/NmAndAdr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/Assrd/NmAndAdr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
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
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblAt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncDataSet/ClmsPyblAt/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/CertDataSet">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_CertDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/DataSetId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/DataSetId/Vrsn</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/DataSetId/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertTp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="ANLY">
<xsl:if test=". = 'ANLY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ANLY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAL">
<xsl:if test=". = 'QUAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAN">
<xsl:if test=". = 'QUAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WEIG">
<xsl:if test=". = 'WEIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_WEIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ORIG">
<xsl:if test=". = 'ORIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ORIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="HEAL">
<xsl:if test=". = 'HEAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_HEAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PHYT">
<xsl:if test=". = 'PHYT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_PHYT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertfdChrtcs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Orgn_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Orgn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Orgn</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Orgn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Qlty_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Qlty_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Qlty</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Qlty_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Anlys_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/choice_1/3</xsl:with-param>
<xsl:with-param name="value">3</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Anlys_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Anlys</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Anlys_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Wght_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/choice_1/4</xsl:with-param>
<xsl:with-param name="value">4</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Wght/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/Wght/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Wght/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Wght/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/Wght/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Wght/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Wght/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_Qty_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/choice_1/5</xsl:with-param>
<xsl:with-param name="value">5</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend"/>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Qty/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/Qty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Qty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Qty/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/Qty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Qty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/Qty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_HlthIndctn_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/choice_1/6</xsl:with-param>
<xsl:with-param name="value">6</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_HlthIndctn_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/HlthIndctn</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_PhytosntryIndctn_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/choice_1</xsl:with-param>
<xsl:with-param name="id">/CertDataSet/CertfdChrtcs/choice_1/7</xsl:with-param>
<xsl:with-param name="value">7</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertifiedCharacteristics1Choice_PhytosntryIndctn_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertfdChrtcs/PhytosntryIndctn</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_IsseDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/IsseDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Issr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/Issr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/Issr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertDataSet/CertId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/OthrCertDataSet">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_OthrCertDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/DataSetId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/DataSetId/Vrsn</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'0'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/DataSetId/Submitr/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/CertId</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertId_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/CertTp</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="BENE">
<xsl:if test=". = 'BENE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_BENE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SHIP">
<xsl:if test=". = 'SHIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_SHIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND1">
<xsl:if test=". = 'UND1'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND2">
<xsl:if test=". = 'UND2'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_IsseDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/IsseDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_Issr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/Issr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/OthrCertDataSet/Issr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
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
<div id="/ReqForActn">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ReqForActn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARRO">
<xsl:if test=". = 'ARRO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CINR">
<xsl:if test=". = 'CINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/FctvDt">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_FctvDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/FctvDt</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_FctvDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PlcOfIsse">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_PlcOfIsse_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PlcOfIsse/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Trnsprt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Trnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/InsrdGoodsDesc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdGoodsDesc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrdGoodsDesc</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdGoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/InsrncConds">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncConds_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncConds</xsl:with-param>
<xsl:with-param name="maxsize">350</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncConds_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/InsrncClauses">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/InsrncClauses</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="ICCA">
<xsl:if test=". = 'ICCA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCB">
<xsl:if test=". = 'ICCB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCC">
<xsl:if test=". = 'ICCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICAI">
<xsl:if test=". = 'ICAI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICAI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IWCC">
<xsl:if test=". = 'IWCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IWCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISCC">
<xsl:if test=". = 'ISCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IREC">
<xsl:if test=". = 'IREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICLC">
<xsl:if test=". = 'ICLC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICLC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISMC">
<xsl:if test=". = 'ISMC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISMC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMCC">
<xsl:if test=". = 'CMCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_CMCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IRCE">
<xsl:if test=". = 'IRCE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IRCE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/ClmsPyblIn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblIn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ClmsPyblIn</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{3,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblIn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/ComrclLineItms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_ComrclLineItms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_LineItmId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclLineItms/LineItmId</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Qty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclLineItms/Qty/choice_1</xsl:with-param>
<xsl:with-param name="id">/ComrclLineItms/Qty/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclLineItms/Qty/UnitOfMeasrCd</xsl:with-param>
<xsl:with-param name="fieldsize">small</xsl:with-param>
<xsl:with-param name="options">
<option value=""/>
<option value="KGM">
<xsl:if test=". = 'KGM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclLineItms/Qty/choice_1</xsl:with-param>
<xsl:with-param name="id">/ComrclLineItms/Qty/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclLineItms/Qty/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ComrclLineItms/Qty/Val</xsl:with-param>
<xsl:with-param name="type">integer</xsl:with-param>
<xsl:with-param name="fieldsize">x-small</xsl:with-param>
<xsl:with-param name="override-constraints">{places:'17'}</xsl:with-param>
<xsl:with-param name="size">18</xsl:with-param>
<xsl:with-param name="maxsize">18</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/ComrclLineItms/TtlAmt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/ComrclLineItms/TtlAmt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/ComrclLineItms/TtlAmt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Incotrms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_EXW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FCA">
<xsl:if test=". = 'FCA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FAS">
<xsl:if test=". = 'FAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOB">
<xsl:if test=". = 'FOB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FOB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CFR">
<xsl:if test=". = 'CFR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CFR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIF">
<xsl:if test=". = 'CIF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CIF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CPT">
<xsl:if test=". = 'CPT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CPT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIP">
<xsl:if test=". = 'CIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DAF">
<xsl:if test=". = 'DAF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DAF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DES">
<xsl:if test=". = 'DES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DEQ">
<xsl:if test=". = 'DEQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DEQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDU">
<xsl:if test=". = 'DDU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DDU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDP">
<xsl:if test=". = 'DDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Othr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Othr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Othr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Othr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Lctn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/FrghtChrgs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FrghtChrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Tax">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/OthrTaxTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Tax/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/BuyrDfndInf">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_BuyrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrDfndInf/Labl</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrDfndInf/Inf</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SellrDfndInf">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_SellrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrDfndInf/Labl</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrDfndInf/Inf</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/LineItmId">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItmId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/LineItmId</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/UnitPric">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_UnitPric_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UnitPric/choice_1</xsl:with-param>
<xsl:with-param name="id">/UnitPric/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_KGM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EA">
<xsl:if test=". = 'EA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_EA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTN">
<xsl:if test=". = 'LTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTR">
<xsl:if test=". = 'MTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INH">
<xsl:if test=". = 'INH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_INH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LY">
<xsl:if test=". = 'LY'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLI">
<xsl:if test=". = 'GLI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_GLI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GRM">
<xsl:if test=". = 'GRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_GRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMT">
<xsl:if test=". = 'CMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTK">
<xsl:if test=". = 'MTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOT">
<xsl:if test=". = 'FOT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_FOT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="1A">
<xsl:if test=". = '1A'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_1A')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INK">
<xsl:if test=". = 'INK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_INK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FTK">
<xsl:if test=". = 'FTK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_FTK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MIK">
<xsl:if test=". = 'MIK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MIK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ONZ">
<xsl:if test=". = 'ONZ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_ONZ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PTI">
<xsl:if test=". = 'PTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_PTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PT">
<xsl:if test=". = 'PT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_PT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QTI">
<xsl:if test=". = 'QTI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_QTI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QT">
<xsl:if test=". = 'QT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_QT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GLL">
<xsl:if test=". = 'GLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_GLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMT">
<xsl:if test=". = 'MMT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MMT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KTM">
<xsl:if test=". = 'KTM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_KTM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="YDK">
<xsl:if test=". = 'YDK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_YDK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMK">
<xsl:if test=". = 'MMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMK">
<xsl:if test=". = 'CMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="KMK">
<xsl:if test=". = 'KMK'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_KMK')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MMQ">
<xsl:if test=". = 'MMQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MMQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLT">
<xsl:if test=". = 'CLT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CLT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LTR">
<xsl:if test=". = 'LTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LBR">
<xsl:if test=". = 'LBR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_LBR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STN">
<xsl:if test=". = 'STN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_STN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BLL">
<xsl:if test=". = 'BLL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BLL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BX">
<xsl:if test=". = 'BX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BO">
<xsl:if test=". = 'BO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CT">
<xsl:if test=". = 'CT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CH">
<xsl:if test=". = 'CH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CR">
<xsl:if test=". = 'CR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_CR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="INQ">
<xsl:if test=". = 'INQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_INQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MTQ">
<xsl:if test=". = 'MTQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_MTQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZI">
<xsl:if test=". = 'OZI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_OZI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OZA">
<xsl:if test=". = 'OZA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_OZA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BG">
<xsl:if test=". = 'BG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="BL">
<xsl:if test=". = 'BL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_BL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="TNE">
<xsl:if test=". = 'TNE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_code_TNE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_UnitOfMeasrCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UnitPric/choice_1</xsl:with-param>
<xsl:with-param name="id">/UnitPric/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_OthrUnitOfMeasr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/UnitPric/OthrUnitOfMeasr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_OthrUnitOfMeasr_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/UnitPric/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/UnitPric/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/UnitPric/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/PdctNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PdctIdr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctIdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2Choice_StrdPdctIdr_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_BINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMD">
<xsl:if test=". = 'COMD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_COMD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EANC">
<xsl:if test=". = 'EANC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_EANC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="HRTR">
<xsl:if test=". = 'HRTR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_HRTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MANI">
<xsl:if test=". = 'MANI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_MANI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="MODL">
<xsl:if test=". = 'MODL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_MODL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PART">
<xsl:if test=". = 'PART'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_PART')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QOTA">
<xsl:if test=". = 'QOTA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_QOTA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STYL">
<xsl:if test=". = 'STYL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_STYL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUPI">
<xsl:if test=". = 'SUPI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_SUPI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPCC">
<xsl:if test=". = 'UPCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_code_UPCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Idr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/StrdPdctIdr/Idr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2_Idr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductIdentifier2Choice_OthrPdctIdr_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/OthrPdctIdr/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctIdr/OthrPdctIdr/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctChrtcs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1Choice_StrdPdctChrtcs_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_BISP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CHNR">
<xsl:if test=". = 'CHNR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_CHNR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLOR">
<xsl:if test=". = 'CLOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_CLOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="EDSP">
<xsl:if test=". = 'EDSP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_EDSP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ENNR">
<xsl:if test=". = 'ENNR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_ENNR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="OPTN">
<xsl:if test=". = 'OPTN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_OPTN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ORCR">
<xsl:if test=". = 'ORCR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_ORCR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PCTV">
<xsl:if test=". = 'PCTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_PCTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SISP">
<xsl:if test=". = 'SISP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SISP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SIZE">
<xsl:if test=". = 'SIZE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SIZE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SZRG">
<xsl:if test=". = 'SZRG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SZRG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SPRM">
<xsl:if test=". = 'SPRM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_SPRM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STOR">
<xsl:if test=". = 'STOR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_STOR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VINR">
<xsl:if test=". = 'VINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_code_VINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Chrtcs_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/StrdPdctChrtcs/Chrtcs</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1_Chrtcs_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCharacteristics1Choice_OthrPdctChrtcs_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/OthrPdctChrtcs/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctChrtcs/OthrPdctChrtcs/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctCtgy_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1Choice_StrdPdctCtgy_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_HRTR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QOTA">
<xsl:if test=". = 'QOTA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_QOTA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRGP">
<xsl:if test=". = 'PRGP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_PRGP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="LOBU">
<xsl:if test=". = 'LOBU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_LOBU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="GNDR">
<xsl:if test=". = 'GNDR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_code_GNDR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Ctgy_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/StrdPdctCtgy/Ctgy</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1_Ctgy_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_ProductCategory1Choice_OthrPdctCtgy_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/OthrPdctCtgy/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctCtgy/OthrPdctCtgy/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctOrgn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PdctOrgn</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctOrgn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Adjstmnt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_REBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DISC">
<xsl:if test=". = 'DISC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_DISC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CREN">
<xsl:if test=". = 'CREN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_CREN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SURC">
<xsl:if test=". = 'SURC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_code_SURC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_OthrAdjstmntTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Adjstmnt/OthrAdjstmntTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_OthrAdjstmntTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Adjstmnt/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Adjstmnt/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/FrghtChrgs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_FrghtChrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Tax">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/choice_1</xsl:with-param>
<xsl:with-param name="id">/Tax/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Tax/OthrTaxTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="currency-field">
<xsl:with-param name="name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">/Tax/Amt/@Ccy</xsl:with-param>
<xsl:with-param name="override-amt-name">/Tax/Amt</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/CertInf">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertInf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CertInf</xsl:with-param>
<xsl:with-param name="maxsize">350</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertInf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PrtryId">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PrtryId/IdTp</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/NbOfDays">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_NbOfDays_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PaymentPeriod1_NbOfDays_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Desc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Desc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Desc</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/StrtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/StrtNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CtrySubDvsn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CtrySubDvsn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/StrtNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/StrtNm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/PstCdId">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/PstCdId</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/TwnNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TwnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CtrySubDvsn">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CtrySubDvsn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Fctr">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Fctr</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/CdtrAgt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAgt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_FinancialInstitutionIdentification4Choice_BIC_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/BIC</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{6,6}[A-Z2-9][A-NP-Z0-9]([A-Z0-9]{3,3}){0,1}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_FinancialInstitutionIdentification4Choice_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_FinancialInstitutionIdentification4Choice_NmAndAdr_name</xsl:variable>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_NameAndAddress6_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_NameAndAddress6_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_NameAndAddress6_Adr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_PstCdId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/PstCdId</xsl:with-param>
<xsl:with-param name="maxsize">16</xsl:with-param>
<xsl:with-param name="size">16</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_TwnNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/TwnNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/CdtrAgt/NmAndAdr/Adr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress2_Ctry_definition</xsl:with-param>
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
<div id="/TrnsprtByAir">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByAir_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DprtureAirprt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/AirprtCd</xsl:with-param>
<xsl:with-param name="maxsize">6</xsl:with-param>
<xsl:with-param name="size">6</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_OthrAirprtDesc_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DprtureAirprt/choice_1/2</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/OthrAirprtDesc/Twn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DstnAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DstnAirprt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/AirprtCd</xsl:with-param>
<xsl:with-param name="maxsize">6</xsl:with-param>
<xsl:with-param name="size">6</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_OthrAirprtDesc_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DstnAirprt/choice_1/2</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/OthrAirprtDesc/Twn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_definition</xsl:with-param>
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
<div id="/TrnsprtBySea">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtBySea_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtBySea/PortOfLoadng</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtBySea/PortOfDschrge</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByRoad">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRoad_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRoad/PlcOfRct</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRoad/PlcOfDlvry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByRail">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRail_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRail/PlcOfRct</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRail/PlcOfDlvry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByAir">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByAir_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DprtureAirprt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/AirprtCd</xsl:with-param>
<xsl:with-param name="maxsize">6</xsl:with-param>
<xsl:with-param name="size">6</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_OthrAirprtDesc_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DprtureAirprt/choice_1/2</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DprtureAirprt/OthrAirprtDesc/Twn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DstnAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DstnAirprt/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/AirprtCd</xsl:with-param>
<xsl:with-param name="maxsize">6</xsl:with-param>
<xsl:with-param name="size">6</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_AirprtCd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportName1Choice_OthrAirprtDesc_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/choice_1</xsl:with-param>
<xsl:with-param name="id">/TrnsprtByAir/DstnAirprt/choice_1/2</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByAir/DstnAirprt/OthrAirprtDesc/Twn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_AirportDescription1_Twn_definition</xsl:with-param>
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
<div id="/TrnsprtBySea">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtBySea_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtBySea/PortOfLoadng</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtBySea/PortOfDschrge</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByRoad">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRoad_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRoad/PlcOfRct</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRoad/PlcOfDlvry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtByRail">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRail_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRail/PlcOfRct</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtByRail/PlcOfDlvry</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/AirCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/AirCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/RailCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RailCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/RoadCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/RoadCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/VsslNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/VsslNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/SeaCrrierNm">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SeaCrrierNm</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/Buyr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Buyr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Buyr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Buyr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Sellr">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Sellr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Sellr/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Sellr/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgn_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgn/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Consgn/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_ShipTo_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ShipTo/Nm</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/ShipTo/PstlAdr/Ctry</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtDocRef">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtDocRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDocRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtDocRef/DtOfIsse</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/TrnsprtdGoods">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtdGoods_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_PurchsOrdrRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtdGoods/PurchsOrdrRef/Id</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/TrnsprtdGoods/PurchsOrdrRef/DtOfIsse</xsl:with-param>
<xsl:with-param name="type">date</xsl:with-param>
<xsl:with-param name="size">10</xsl:with-param>
<xsl:with-param name="maxsize">10</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Consgnmt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Consgnmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Incotrms">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/1</xsl:with-param>
<xsl:with-param name="value">1</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_EXW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FCA">
<xsl:if test=". = 'FCA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FAS">
<xsl:if test=". = 'FAS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FAS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="FOB">
<xsl:if test=". = 'FOB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_FOB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CFR">
<xsl:if test=". = 'CFR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CFR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIF">
<xsl:if test=". = 'CIF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CIF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CPT">
<xsl:if test=". = 'CPT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CPT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CIP">
<xsl:if test=". = 'CIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_CIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DAF">
<xsl:if test=". = 'DAF'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DAF')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DES">
<xsl:if test=". = 'DES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DEQ">
<xsl:if test=". = 'DEQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DEQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDU">
<xsl:if test=". = 'DDU'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DDU')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DDP">
<xsl:if test=". = 'DDP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_code_DDP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Cd_definition</xsl:with-param>
</xsl:call-template>
</div>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Othr_name</xsl:variable>
<xsl:call-template name="radio-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/choice_1</xsl:with-param>
<xsl:with-param name="id">/Incotrms/choice_1/2</xsl:with-param>
<xsl:with-param name="value">2</xsl:with-param>
<xsl:with-param name="override-displaymode">edit</xsl:with-param>
</xsl:call-template>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Othr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Othr</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Othr_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Incotrms/Lctn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/FrghtChrgs">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_FrghtChrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/MltmdlTrnsprt">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_MltmdlTrnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_TakngInChrg_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MltmdlTrnsprt/TakngInChrg</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_TakngInChrg_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/MltmdlTrnsprt/PlcOfFnlDstn</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_PlcOfFnlDstn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/GoodsDesc">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_GoodsDesc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/GoodsDesc</xsl:with-param>
<xsl:with-param name="maxsize">70</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_GoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
<div id="/BuyrDfndInf">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_BuyrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrDfndInf/Labl</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/BuyrDfndInf/Inf</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/SellrDfndInf">
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_SellrDfndInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="parse-widgets">N</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrDfndInf/Labl</xsl:with-param>
<xsl:with-param name="maxsize">35</xsl:with-param>
<xsl:with-param name="size">35</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
</xsl:call-template>
</div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/SellrDfndInf/Inf</xsl:with-param>
<xsl:with-param name="maxsize">140</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
<div id="/Fctr">
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Fctr_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">/Fctr</xsl:with-param>
<xsl:with-param name="regular-expression">[0-9]{1,15}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Fctr_definition</xsl:with-param>
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
<xsl:apply-templates select="FwdDataSetSubmissnRpt">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
</xsl:template>
<xsl:template match="Document/FwdDataSetSubmissnRpt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FwdDataSetSubmissnRpt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_name</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="RptId">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RltdTxRefs">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CmonSubmissnRef">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrBk">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrBk">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="OthrCertDataSet">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ReqForActn">
<xsl:with-param name="path" select="concat($path,'/FwdDataSetSubmissnRpt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/RptId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RptId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_RptId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_CreDtTm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_MessageIdentification1_CreDtTm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/RltdTxRefs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RltdTxRefs"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_RltdTxRefs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TxId">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UsrTxRef">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ForcdMtch">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="EstblishdBaselnId">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TxSts">
<xsl:with-param name="path" select="concat($path,'/RltdTxRefs[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="RltdTxRefs/TxId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RltdTxRefs/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_PurchsOrdrRef_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RltdTxRefs/UsrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UsrTxRef"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/UsrTxRef[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_UsrTxRef_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="UsrTxRef/IdIssr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdIssr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification5_IdIssr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RltdTxRefs/ForcdMtch">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ForcdMtch"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_ForcdMtch_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/ForcdMtch')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RltdTxRefs/EstblishdBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EstblishdBaselnId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_EstblishdBaselnId_name</xsl:with-param>
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
</xsl:template>
<xsl:template match="EstblishdBaselnId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification3_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="RltdTxRefs/TxSts">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TxSts"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TxSts')"/>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLSD">
<xsl:if test=". = 'CLSD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PMTC">
<xsl:if test=". = 'PMTC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ESTD">
<xsl:if test=". = 'ESTD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ACTV">
<xsl:if test=". = 'ACTV'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COMP">
<xsl:if test=". = 'COMP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="AMRQ">
<xsl:if test=". = 'AMRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RARQ">
<xsl:if test=". = 'RARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CLRQ">
<xsl:if test=". = 'CLRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SCRQ">
<xsl:if test=". = 'SCRQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SERQ">
<xsl:if test=". = 'SERQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="DARQ">
<xsl:if test=". = 'DARQ'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="TxSts = 'PROP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PROP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'CLSD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLSD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'PMTC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_PMTC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'ESTD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ESTD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'ACTV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_ACTV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'COMP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_COMP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'AMRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_AMRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'RARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_RARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'CLRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_CLRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'SCRQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SCRQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'SERQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_SERQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="TxSts = 'DARQ'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_code_DARQ')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DataSetSubmissionReferences4_TxSts_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/CmonSubmissnRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CmonSubmissnRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_CmonSubmissnRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/CmonSubmissnRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CmonSubmissnRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_SimpleIdentificationInformation_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_SimpleIdentificationInformation_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_Submitr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_BuyrBk_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_SellrBk_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/ComrclDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDataSet"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ComrclDataSet')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ComrclDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclDocRef">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BllTo">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Goods">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PmtTerms">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SttlmTerms">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="DataSetId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDataSet/ComrclDocRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDocRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_ComrclDocRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="InvcNb">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/ComrclDocRef')"/>
<xsl:with-param name="readOnly"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_InvcNb_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_InvcNb_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_IsseDt_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InvoiceIdentification1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDataSet/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Buyr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Buyr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDataSet/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Sellr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Sellr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDataSet/BllTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BllTo"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/BllTo')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_BllTo_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="BllTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDataSet/Goods">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Goods"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_Goods_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FnlSubmissn">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ComrclLineItms">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_PurchsOrdrRef_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/FnlSubmissn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FnlSubmissn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FnlSubmissn_name</xsl:variable>
<xsl:call-template name="checkbox-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/FnlSubmissn')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/ComrclLineItms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclLineItms"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_ComrclLineItms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Qty">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="UnitPric">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctNm">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctIdr">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctChrtcs">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctCtgy">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdctOrgn">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adjstmnt">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Tax">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlAmt">
<xsl:with-param name="path" select="concat($path,'/ComrclLineItms[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclLineItms/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_LineItmId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/Qty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Qty_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Val_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Fctr_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity4_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/UnitPric">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitPric"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/UnitPric')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_UnitPric_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Amt_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Fctr_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UnitPrice9_Fctr_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PdctIdr[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctIdr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctChrtcs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PdctChrtcs[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctChrtcs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctCtgy"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PdctCtgy[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctCtgy_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/PdctOrgn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PdctOrgn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctOrgn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PdctOrgn')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{2,2}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_PdctOrgn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/Adjstmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Drctn = 'ADDD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Drctn = 'SUBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclLineItms/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/FrghtChrgs')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_FrghtChrgs_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'CLCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'PRPD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Chrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Chrgs/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclLineItms/Tax">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Tax[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="ComrclLineItms_Tax_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="ComrclLineItms_Tax_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
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
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name')&#10;            "/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_definition')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
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
<xsl:when test="OthrTaxTp">
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name')&#10;            "/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_definition')"/>
</xsl:attribute>
</img>
</div>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'PROV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'NATI'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'WITH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'COAX'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'VATA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CUST'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Tax/OthrTaxTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrTaxTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclLineItms/TtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemDetails9_TtlAmt_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/LineItmsTtlAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_LineItmsTtlAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Goods/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Incotrms')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_name</xsl:variable>
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
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_definition</xsl:with-param>
</xsl:call-template>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Adjstmnt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SUBS">
<xsl:if test=". = 'SUBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Drctn = 'ADDD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_ADDD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Drctn = 'SUBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_code_SUBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Drctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Adjustment4_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_FrghtChrgs_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'CLCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'PRPD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Chrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Chrgs/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_Tax_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:call-template name="Goods_Tax_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template name="Goods_Tax_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
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
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/Tp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name')&#10;            "/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_definition')"/>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
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
<xsl:when test="OthrTaxTp">
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<div class="formField">
<label class="FORMMANDATORY">
<xsl:attribute name="for">
<xsl:value-of select="$path"/>/OthrTaxTp</xsl:attribute>
<xsl:value-of select="&#10;              localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name')&#10;            "/>
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
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_definition')"/>
</xsl:attribute>
</img>
</div>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="NATI">
<xsl:if test=". = 'NATI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAT">
<xsl:if test=". = 'STAT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WITH">
<xsl:if test=". = 'WITH'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="STAM">
<xsl:if test=". = 'STAM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="COAX">
<xsl:if test=". = 'COAX'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="VATA">
<xsl:if test=". = 'VATA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CUST">
<xsl:if test=". = 'CUST'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'PROV'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_PROV')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'NATI'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_NATI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'WITH'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_WITH')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'STAM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_STAM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'COAX'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_COAX')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'VATA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_VATA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CUST'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_code_CUST')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_Tp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Tax/OthrTaxTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="OthrTaxTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Tax12_OthrTaxTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Goods/TtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlNetAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/TtlNetAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_TtlNetAmt_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_BuyrDfndInf_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItem9_SellrDfndInf_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ComrclDataSet/PmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_PmtTerms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ComrclDataSet/SttlmTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SttlmTerms"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CommercialDataSet3_SttlmTerms_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAgt_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SettlementTerms2_CdtrAcct_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Id_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Tp_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Ccy_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Ccy_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CashAccount7_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/TrnsprtDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDataSet"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtDataSet')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_TrnsprtDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Buyr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Sellr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ShipTo">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtInf">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="DataSetId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSet/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Buyr')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Buyr_name</xsl:with-param>
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
</div>
</xsl:template>
<xsl:template match="Buyr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Buyr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSet/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Sellr')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Sellr_name</xsl:with-param>
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
</div>
</xsl:template>
<xsl:template match="Sellr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Sellr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSet/Consgnr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgnr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Consgnr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSet/Consgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Consgn')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_Consgn_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgn/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSet/ShipTo">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipTo"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ShipTo')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_ShipTo_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="ShipTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSet/TrnsprtInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtInf"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDataSet3_TrnsprtInf_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TrnsprtDocRef">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtdGoods">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnmt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RtgSummry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Incotrms">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
<xsl:apply-templates select="FrghtChrgs">
<xsl:with-param name="path" select="concat($path,'/TrnsprtInf')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtInf/TrnsprtDocRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtDocRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtDocRef_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDocRef[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtDocRef/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtDocRef/DtOfIsse">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtInf/TrnsprtdGoods">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtdGoods"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_TrnsprtdGoods_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GoodsDesc">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf">
<xsl:with-param name="path" select="concat($path,'/TrnsprtdGoods[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtdGoods/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_PurchsOrdrRef_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtdGoods/GoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_GoodsDesc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_GoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="TrnsprtdGoods/BuyrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrDfndInf"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_BuyrDfndInf_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtdGoods/SellrDfndInf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrDfndInf"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportedGoods1_SellrDfndInf_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Labl_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_UserDefinedInformation1_Inf_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtInf/Consgnmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnmt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Consgnmt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Consgnmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TtlQty">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlVol">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TtlWght">
<xsl:with-param name="path" select="concat($path,'/Consgnmt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnmt/TtlQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlQty"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TtlQty')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlQty_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/TtlQty')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TtlQty/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnmt/TtlVol">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlVol"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TtlVol')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlVol_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/TtlVol')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TtlVol/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnmt/TtlWght">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TtlWght"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TtlWght')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Consignment1_TtlWght_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/TtlWght')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TtlWght/Val">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Quantity3_Val_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtInf/RtgSummry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RtgSummry"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_RtgSummry_name</xsl:with-param>
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
</xsl:template>
<xsl:template match="RtgSummry/IndvTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IndvTrnsprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_IndvTrnsprt_name</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByAir_name</xsl:with-param>
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
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DstnAirprt_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtBySea_name</xsl:with-param>
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
<xsl:apply-templates select="VsslNm">
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfLoadng')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfDschrge')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/VsslNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="VsslNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/VsslNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_definition</xsl:with-param>
</xsl:call-template>
</div>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRoad_name</xsl:with-param>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport5_TrnsprtByRail_name</xsl:with-param>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportMeans2_MltmdlTrnsprt_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_TakngInChrg_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_TakngInChrg_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_PlcOfFnlDstn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_MultimodalTransport3_PlcOfFnlDstn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtInf/Incotrms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Incotrms')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_Incotrms_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_name</xsl:variable>
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
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Incoterms2_Lctn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtInf/FrghtChrgs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FrghtChrgs"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/FrghtChrgs')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportDetails2_FrghtChrgs_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PRPD">
<xsl:if test=". = 'PRPD'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'CLCT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_CLCT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'PRPD'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_code_PRPD')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Tp_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_Charge13_Chrgs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Chrgs/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_name</xsl:with-param>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_ChargesDetails2_Amt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/InsrncDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrncDataSet"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/InsrncDataSet')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_InsrncDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="FctvDt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfIsse">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncDocId">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Trnsprt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrdAmt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrdGoodsDesc">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncConds">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InsrncClauses">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Assrd">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClmsPyblAt">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ClmsPyblIn">
<xsl:with-param name="path" select="concat($path,'/InsrncDataSet')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="DataSetId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/Issr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Issr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Issr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Issr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Issr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_IsseDt_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/FctvDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FctvDt"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_FctvDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/FctvDt')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_FctvDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/PlcOfIsse">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfIsse"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PlcOfIsse')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_PlcOfIsse_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrncDocId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncDocId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDocId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InsrncDocId')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncDocId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/Trnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Trnsprt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Trnsprt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Trnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TrnsprtByAir">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByAir">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByAir')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByAir_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
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
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DstnAirprt_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtBySea">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtBySea')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtBySea_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="VsslNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfLoadng')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfDschrge')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/VsslNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="VsslNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/VsslNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_definition</xsl:with-param>
</xsl:call-template>
</div>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRoad">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRoad')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRoad_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRail">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRail')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRail_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InsrdAmt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<xsl:call-template name="currency-field">
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InsrdAmt')"/>
</xsl:with-param>
<xsl:with-param name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_name</xsl:with-param>
<xsl:with-param name="override-currency-name">
<xsl:value-of select="concat($path,'/InsrdAmt/@Ccy')"/>
</xsl:with-param>
<xsl:with-param name="override-currency-value">
<xsl:value-of select="@Ccy"/>
</xsl:with-param>
<xsl:with-param name="override-amt-name">
<xsl:value-of select="concat($path,'/InsrdAmt')"/>
</xsl:with-param>
<xsl:with-param name="override-amt-value">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</xsl:with-param>
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdAmt_definition</xsl:with-param>
</xsl:call-template>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrdGoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrdGoodsDesc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdGoodsDesc_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InsrdGoodsDesc')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrdGoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrncConds">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncConds"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncConds_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InsrncConds[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">350</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncConds_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/InsrncClauses">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="InsrncClauses"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_name</xsl:variable>
<xsl:call-template name="select-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/InsrncClauses[', $index,']')"/>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCB">
<xsl:if test=". = 'ICCB'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICCC">
<xsl:if test=". = 'ICCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICAI">
<xsl:if test=". = 'ICAI'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICAI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IWCC">
<xsl:if test=". = 'IWCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IWCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISCC">
<xsl:if test=". = 'ISCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IREC">
<xsl:if test=". = 'IREC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ICLC">
<xsl:if test=". = 'ICLC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICLC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ISMC">
<xsl:if test=". = 'ISMC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISMC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CMCC">
<xsl:if test=". = 'CMCC'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_CMCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="IRCE">
<xsl:if test=". = 'IRCE'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IRCE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="InsrncClauses = 'ICCA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'ICCB'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCB')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'ICCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'ICAI'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICAI')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'IWCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IWCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'ISCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'IREC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IREC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'ICLC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ICLC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'ISMC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_ISMC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'CMCC'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_CMCC')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="InsrncClauses = 'IRCE'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_code_IRCE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_InsrncClauses_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/Assrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Assrd"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_Assrd_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="InsrncDataSet/ClmsPyblAt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ClmsPyblAt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblAt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/ClmsPyblAt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="ClmsPyblAt/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ClmsPyblAt/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ClmsPyblAt/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ClmsPyblAt/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="ClmsPyblAt/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InsrncDataSet/ClmsPyblIn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ClmsPyblIn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblIn_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/ClmsPyblIn')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="regular-expression">[A-Z]{3,3}</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_InsuranceDataSet1_ClmsPyblIn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/CertDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertDataSet"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/CertDataSet[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_CertDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="LineItm">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertfdChrtcs">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfIsse">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="InspctnDt">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AuthrsdInspctrInd">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertId">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Trnsprt">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="GoodsDesc">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgnr">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Consgn">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Manfctr">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AddtlInf">
<xsl:with-param name="path" select="concat($path,'/CertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="DataSetId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ANLY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAL">
<xsl:if test=". = 'QUAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="QUAN">
<xsl:if test=". = 'QUAN'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WEIG">
<xsl:if test=". = 'WEIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_WEIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ORIG">
<xsl:if test=". = 'ORIG'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ORIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="HEAL">
<xsl:if test=". = 'HEAL'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_HEAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="PHYT">
<xsl:if test=". = 'PHYT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_PHYT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="CertTp = 'ANLY'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ANLY')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'QUAL'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'QUAN'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_QUAN')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'WEIG'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_WEIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'ORIG'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_ORIG')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'HEAL'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_HEAL')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'PHYT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_code_PHYT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/LineItm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItm"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/LineItm[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_LineItm_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/LineItm[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PurchsOrdrRef">
<xsl:with-param name="path" select="concat($path,'/LineItm[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItm/LineItmId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItmId_name</xsl:variable>
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
<xsl:with-param name="required">Y</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_LineItmId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="LineItm/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_LineItemAndPOIdentification1_PurchsOrdrRef_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification7_DtOfIsse_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/CertfdChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertfdChrtcs"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertfdChrtcs_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="CertDataSet/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_IsseDt_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/PlcOfIsse">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfIsse"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PlcOfIsse')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_PlcOfIsse_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="StrtNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstCdId">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TwnNm">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CtrySubDvsn">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/PlcOfIsse')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/StrtNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/PstCdId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/TwnNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="PlcOfIsse/Ctry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/Issr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Issr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Issr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Issr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Issr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/InspctnDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InspctnDt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/InspctnDt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_InspctnDt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="FrDt">
<xsl:with-param name="path" select="concat($path,'/InspctnDt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="ToDt">
<xsl:with-param name="path" select="concat($path,'/InspctnDt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InspctnDt/FrDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="FrDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_FrDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/FrDt')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_FrDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="InspctnDt/ToDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="ToDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_ToDt_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/ToDt')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DatePeriodDetails_ToDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/AuthrsdInspctrInd">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AuthrsdInspctrInd"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AuthrsdInspctrInd_name</xsl:variable>
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
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="CertDataSet/CertId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CertId')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_CertId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/Trnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Trnsprt"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Trnsprt')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Trnsprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="TrnsprtByAir">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtBySea">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRoad">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="TrnsprtByRail">
<xsl:with-param name="path" select="concat($path,'/Trnsprt')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByAir">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByAir"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByAir')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByAir_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir')"/>
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
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DprtureAirprt_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section"/>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_DstnAirprt_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByAir2_AirCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtBySea">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtBySea"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtBySea')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtBySea_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="VsslNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfLoadng')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfLoadng_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PortOfDschrge')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_PortOfDschrge_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/VsslNm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="VsslNm"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/VsslNm')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_VsslNm_definition</xsl:with-param>
</xsl:call-template>
</div>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportBySea4_SeaCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRoad">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRoad"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRoad')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRoad_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_PlcOfDlvry_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRoad2_RoadCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="Trnsprt/TrnsprtByRail">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsprtByRail"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/TrnsprtByRail')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_SingleTransport3_TrnsprtByRail_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail')"/>
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
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfRct')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfRct_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/PlcOfDlvry')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_PlcOfDlvry_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_TransportByRail2_RailCrrierNm_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="CertDataSet/GoodsDesc">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_GoodsDesc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_GoodsDesc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="CertDataSet/Consgnr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgnr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Consgnr')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgnr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgnr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgnr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/Consgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Consgn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Consgn')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Consgn_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
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
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Consgn/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/Manfctr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Manfctr"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/Manfctr')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_Manfctr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Manfctr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Manfctr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Manfctr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Manfctr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="CertDataSet/AddtlInf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="AddtlInf"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AddtlInf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/AddtlInf[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">350</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_CertificateDataSet1_AddtlInf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/OthrCertDataSet">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrCertDataSet"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/OthrCertDataSet[', $index,']')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_OthrCertDataSet_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="DataSetId">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertId">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="IsseDt">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Issr">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertInf">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSet[', $index,']')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSet/DataSetId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DataSetId"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_DataSetId_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/DataSetId')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="DataSetId/Id">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Id_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Vrsn">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Vrsn_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DataSetId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_DocumentIdentification1_Submitr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_BICIdentification1_BIC_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertId">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertId"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertId_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CertId')"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertId_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertTp">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_BENE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SHIP">
<xsl:if test=". = 'SHIP'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_SHIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND1">
<xsl:if test=". = 'UND1'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UND2">
<xsl:if test=". = 'UND2'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="CertTp = 'BENE'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_BENE')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'SHIP'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_SHIP')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'UND1'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND1')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="CertTp = 'UND2'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_code_UND2')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSet/IsseDt">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="IsseDt"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_IsseDt_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_IsseDt_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSet/Issr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Issr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_Issr_name</xsl:with-param>
<xsl:with-param name="legend-type">indented-header</xsl:with-param>
<xsl:with-param name="content">
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Issr')"/>
<xsl:with-param name="readOnly"/>
</xsl:apply-templates>
</div>
</xsl:with-param>
</xsl:call-template>
</xsl:template>
<xsl:template match="Issr/Nm">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_Nm_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Issr/PrtryId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryId"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/PrtryId')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PrtryId_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_Id_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_GenericIdentification4_IdTp_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Issr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_PartyIdentification26_PstlAdr_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_StrtNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_PstCdId_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_TwnNm_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_CtrySubDvsn_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PostalAddress5_Ctry_definition</xsl:with-param>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSet/CertInf">
<xsl:param name="path"/>
<xsl:param name="readOnly"/>
<xsl:variable name="index">
<xsl:number count="CertInf"/>
</xsl:variable>
<div>
<div class="formField">
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertInf_name</xsl:variable>
<xsl:call-template name="input-field">
<xsl:with-param name="label">
<xsl:value-of select="$label"/>
</xsl:with-param>
<xsl:with-param name="name">
<xsl:value-of select="concat($path,'/CertInf[', $index,']')"/>
</xsl:with-param>
<xsl:with-param name="value">
<xsl:value-of select="text()"/>
</xsl:with-param>
<xsl:with-param name="maxsize">350</xsl:with-param>
<xsl:with-param name="size">40</xsl:with-param>
<xsl:with-param name="override-displaymode">
<xsl:value-of select="$displaymode"/>
</xsl:with-param>
<xsl:with-param name="show-help">Y</xsl:with-param>
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_OtherCertificateDataSet1_CertInf_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
<xsl:template match="FwdDataSetSubmissnRpt/ReqForActn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ReqForActn"/>
</xsl:variable>
<div>
<xsl:attribute name="id">
<xsl:value-of select="concat($path,'/ReqForActn')"/>
</xsl:attribute>
<xsl:call-template name="fieldset-wrapper">
<xsl:with-param name="legend">XSL_TSU_FwdDataSetSubmissnRpt_ForwardDataSetSubmissionReportV03_ReqForActn_name</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_name</xsl:variable>
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
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSTW">
<xsl:if test=". = 'RSTW'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="RSBS">
<xsl:if test=". = 'RSBS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARDM">
<xsl:if test=". = 'ARDM'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARCS">
<xsl:if test=". = 'ARCS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARES">
<xsl:if test=". = 'ARES'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="WAIT">
<xsl:if test=". = 'WAIT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="UPDT">
<xsl:if test=". = 'UPDT'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="SBDS">
<xsl:if test=". = 'SBDS'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARBA">
<xsl:if test=". = 'ARBA'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="ARRO">
<xsl:if test=". = 'ARRO'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
<option value="CINR">
<xsl:if test=". = 'CINR'">
<xsl:attribute name="selected"/>
</xsl:if>
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</option>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="Tp = 'SBTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'RSTW'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSTW')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'RSBS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_RSBS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARDM'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARDM')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARCS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARCS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARES'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARES')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'WAIT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_WAIT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'UPDT'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_UPDT')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'SBDS'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_SBDS')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARBA'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARBA')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'ARRO'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_ARRO')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
</xsl:when>
<xsl:when test="Tp = 'CINR'">
<xsl:value-of select="&#10;&#9;&#9;&#9;&#9;&#9;&#9;localization:getGTPString($language, 'XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_code_CINR')&#10;&#9;&#9;&#9;&#9;&#9;&#9;"/>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Tp_definition</xsl:with-param>
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
<xsl:variable name="label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Desc_name</xsl:variable>
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
<xsl:with-param name="help-label">XSL_TSU_FwdDataSetSubmissnRpt_PendingActivity2_Desc_definition</xsl:with-param>
</xsl:call-template>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
