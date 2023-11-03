<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="localization tools" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools" xmlns:localization="xalan://com.misys.portal.common.localization.Localization">
<xsl:output method="html" indent="yes"/>
<xsl:param name="language"/>
<xsl:param name="rundata"/>
<xsl:param name="tnxTypeCode"/>
<xsl:param name="type"/>
 <xsl:param name="contextPath"/>
 <xsl:param name="servletPath"/>

<xsl:template match="/">
<xsl:apply-templates select="bn_tnx_record"/>
</xsl:template>
<xsl:template match="bn_tnx_record">
<html>
<head>
<title>Document</title>
<style type="text/css">
            label { width: 15em; float: left; text-align: left; margin: 0 1em 5px 0; clear: both; }
            .input-box { margin-bottom: 5px; }
            .section { margin-left: 25px; }
            .headerSection {color: BLACK; background-color: #D7D9EC; height: 1.6em; margin: 0.5em;}
            .headerText {float:left; margin-left: 0.2em; margin-top: 0.15em; margin-bottom: 0.2em;}
            .headerIcon {float:right; margin-right: 0.2em; margin-top: 0.15em; margin-bottom: 0.2em;}
            .spacerLeft {padding-left: 0.8em;}
            .embracingSection { border-left: 1px dotted;}
            .FORMMANDATORY { color: BLUE; }
            .command {margin-bottom: 0.5em;}
            .command A {font-family:verdana, arial, sans-serif; font-size: x-small; color: NAVY;}
            .command A:link  {color: NAVY;}
            .command A:visited {color: NAVY;}
            .command A:hover {text-decoration: none; background-color: #CCCCCC; color: #000000;}            
            .ledon
            .ledoff
            #.tooltip {visibility:hidden; position:absolute; border:1px solid black; width:228px; background-color:#FFFFCC;}
          </style>
</head>
<body>
<script type="text/javascript" src="/content/OLD/javascript/com_date.js"/>
<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"/>
<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"/>
<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"/>
<script type="text/javascript">
<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
</script>
<script type="text/javascript" src="/content/OLD/javascript/tsu/tsu.js"/>
<xsl:choose>
<xsl:when test="$type = 'INQUIRY'">
<table align="center">
<tr>
<td width="100%">
<div id="toolbar">
<table border="0" cellpadding="8" cellspacing="2">
<tr>
<td align="center" valign="center">
<a href="javascript:fncPerform('print')">
<img src="/content/images/pic_printer.gif" border="0"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_PRINT')"/>
</a>
</td>
<td align="center" valign="center">
<a href="javascript:fncPerform('close')">
<img src="/content/images/pic_form_cancel.gif" border="0"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_CLOSE')"/>
</a>
</td>
</tr>
</table>
</div>
</td>
</tr>
</table>
</xsl:when>
<xsl:when test="$type = 'UNSIGNED'">
<table align="center">
<tr>
<td width="100%">
<table border="0" cellspacing="2" cellpadding="8">
<tr>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
<img border="0" src="/content/images/pic_form_send.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
</a>
</td>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('template');return false;">
<img border="0" src="/content/images/pic_form_template.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_TEMPLATE')"/>
</a>
</td>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
<img border="0" src="/content/images/pic_form_cancel.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
</a>
</td>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
<img border="0" src="/content/images/pic_form_help.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
</a>
</td>
</tr>
</table>
</td>
</tr>
</table>
</xsl:when>
</xsl:choose>
<xsl:apply-templates select="narrative_xml/Baseln">
<xsl:with-param name="path" select="/Baseln"/>
</xsl:apply-templates>
<br/>
<form name="fakeform1" onsubmit="return false;">
<input type="hidden" name="brch_code">
<xsl:attribute name="value">
<xsl:value-of select="brch_code"/>
</xsl:attribute>
</input>
<input type="hidden" name="company_id">
<xsl:attribute name="value">
<xsl:value-of select="company_id"/>
</xsl:attribute>
</input>
<input type="hidden" name="company_name">
<xsl:attribute name="value">
<xsl:value-of select="company_name"/>
</xsl:attribute>
</input>
<input type="hidden" name="ref_id">
<xsl:attribute name="value">
<xsl:value-of select="ref_id"/>
</xsl:attribute>
</input>
<input type="hidden" name="tnx_id">
<xsl:attribute name="value">
<xsl:value-of select="tnx_id"/>
</xsl:attribute>
</input>
<input type="hidden" name="org_tnx_id">
<xsl:attribute name="value">
<xsl:value-of select="org_tnx_id"/>
</xsl:attribute>
</input>
<input type="hidden" name="tnx_amt">
<xsl:attribute name="value">
<xsl:value-of select="tnx_amt"/>
</xsl:attribute>
</input>
<input type="hidden" name="old_ctl_dttm">
<xsl:attribute name="value">
<xsl:value-of select="ctl_dttm"/>
</xsl:attribute>
</input>
<input type="hidden" name="old_inp_dttm">
<xsl:attribute name="value">
<xsl:value-of select="inp_dttm"/>
</xsl:attribute>
</input>
<input type="hidden" name="issuing_bank_abbv_name">
<xsl:attribute name="value">
<xsl:value-of select="issuing_bank/abbv_name"/>
</xsl:attribute>
</input>
<input type="hidden" name="issuing_bank_name">
<xsl:attribute name="value">
<xsl:value-of select="issuing_bank/name"/>
</xsl:attribute>
</input>
</form>
<form name="realform" accept-charset="UNKNOWN" method="POST" enctype="multipart/form-data"><xsl:attribute name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TMAScreen</xsl:attribute>
<input type="hidden" name="operation" value=""/>
<input type="hidden" name="mode" value="DRAFT"/>
<input type="hidden" name="tnxtype">
<xsl:attribute name="value">
<xsl:value-of select="$tnxTypeCode"/>
</xsl:attribute>
</input>
<input type="hidden" name="TransactionData"/>
</form>
<xsl:if test="$type = 'UNSIGNED'">
<table align="center">
<tr>
<td width="100%">
<table border="0" cellspacing="2" cellpadding="8">
<tr>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
<img border="0" src="/content/images/pic_form_send.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
</a>
</td>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('template');return false;">
<img border="0" src="/content/images/pic_form_template.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_TEMPLATE')"/>
</a>
</td>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
<img border="0" src="/content/images/pic_form_cancel.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
</a>
</td>
<td align="middle" valign="center">
<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
<img border="0" src="/content/images/pic_form_help.gif"/>
<br/>
<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
</a>
</td>
</tr>
</table>
</td>
</tr>
</table>
</xsl:if>
</body>
</html>
</xsl:template>
<xsl:template match="Document">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Document"/>
</xsl:variable>
<br/>
<xsl:apply-templates select="InitlBaselnSubmissn">
<xsl:with-param name="path" select="concat($path,'/Document')"/>
</xsl:apply-templates>
<br/>
</xsl:template>
<xsl:template match="Document/InitlBaselnSubmissn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InitlBaselnSubmissn"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                            localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_name')&#10;                          "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
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
<xsl:call-template name="Document_InitlBaselnSubmissn_choice_1">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:call-template>
<xsl:apply-templates select="OthrBkCtctPrsn">
<xsl:with-param name="path" select="concat($path,'/InitlBaselnSubmissn')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SubmissnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmissnId"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmissnId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CreDtTm">
<xsl:with-param name="path" select="concat($path,'/SubmissnId')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="SubmissnId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SubmissnId/CreDtTm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CreDtTm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CreDtTm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_CreDtTm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODateTime2MTPDateTime(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MessageIdentification1_CreDtTm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SubmitrTxRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrTxRef"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SubmitrTxRef_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmitrTxRef')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="SubmitrTxRef/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/Instr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Instr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Instr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/Instr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Instr/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InstructionType1_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/Baseln">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Baseln"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_Baseln_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="Baseln/SubmitrBaselnId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubmitrBaselnId"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SubmitrBaselnId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Vrsn">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/SubmitrBaselnId')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Vrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Vrsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Vrsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Vrsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Vrsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SubmitrBaselnId/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification1_Submitr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/SvcCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SvcCd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/SvcCd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SvcCd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/PurchsOrdrRef">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PurchsOrdrRef"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PurchsOrdrRef_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DtOfIsse">
<xsl:with-param name="path" select="concat($path,'/PurchsOrdrRef')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="PurchsOrdrRef/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PurchsOrdrRef/DtOfIsse">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DtOfIsse"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/DtOfIsse')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_DtOfIsse_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_DocumentIdentification7_DtOfIsse_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/Buyr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Buyr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Buyr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Buyr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Buyr/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Buyr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/Sellr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Sellr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Sellr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Sellr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Sellr/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Sellr/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/BuyrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBk"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrBk_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/BuyrBk')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="BuyrBk/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/SellrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBk"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrBk_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SellrBk')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="SellrBk/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BuyrSdSubmitgBk_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/BuyrSdSubmitgBk[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="BuyrSdSubmitgBk/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SellrSdSubmitgBk_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/SellrSdSubmitgBk[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="SellrSdSubmitgBk/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_BllTo_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/BllTo')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="BllTo/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BllTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_ShipTo_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/ShipTo')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="ShipTo/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="ShipTo/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Consgn_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PstlAdr">
<xsl:with-param name="path" select="concat($path,'/Consgn')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="Consgn/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Consgn/PstlAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstlAdr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification26_PstlAdr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="PstlAdr/StrtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_StrtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/PstCdId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/TwnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_CtrySubDvsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PstlAdr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress5_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/Goods">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Goods"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_Goods_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
<xsl:apply-templates select="OrdrdLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngLineItmsTtlAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgLineItmsTtlAmt">
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
<xsl:apply-templates select="OrdrdTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgTtlNetAmt">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="BuyrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SellrDfndInf">
<xsl:with-param name="path" select="concat($path,'/Goods')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Goods/GoodsDesc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="GoodsDesc"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/GoodsDesc')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_GoodsDesc_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Goods/PrtlShipmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtlShipmnt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PrtlShipmnt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PrtlShipmnt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PrtlShipmnt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Goods/TrnsShipmnt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TrnsShipmnt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TrnsShipmnt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_TrnsShipmnt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_TrnsShipmnt_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_ShipmntDtRg_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="EarlstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="ShipmntDtRg/EarlstShipmntDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EarlstShipmntDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EarlstShipmntDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="ShipmntDtRg/LatstShipmntDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LatstShipmntDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/LatstShipmntDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Goods/LineItmDtls">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmDtls"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_LineItmDtls_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="LineItmId">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OrdrdQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngQty">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgQty">
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
<xsl:apply-templates select="OrdrdAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AccptdAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="OutsdngAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PdgAmt">
<xsl:with-param name="path" select="concat($path,'/LineItmDtls[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/LineItmId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/LineItmId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_LineItmId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>

<xsl:template match="LineItmDtls/OrdrdQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdQty"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OrdrdQty_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_Qty_choice_1">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:call-template>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
</div>
</xsl:template>

<xsl:template match="LineItmDtls/AccptdQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdQty"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_AccptdQty_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_Qty_choice_1">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:call-template>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
</div>
</xsl:template>

<xsl:template match="LineItmDtls/OutsdngQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngQty"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OutsdngQty_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_Qty_choice_1">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:call-template>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
</div>
</xsl:template>

<xsl:template match="LineItmDtls/PdgQty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgQty"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdgQty_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_Qty_choice_1">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:call-template>
<xsl:apply-templates select="Val">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/Qty')"/>
</xsl:apply-templates>
</div>
</xsl:template>

<xsl:template match="Qty/Val">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Val"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Val')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_Val_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Qty/Fctr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Fctr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_Fctr_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_Qty_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Qty"/>
</xsl:variable>
<xsl:if test="UnitOfMeasrCd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="UnitOfMeasrCd">
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Quantity4_UnitOfMeasrCd_nameXSL_TSU_tsmt.019.001.03_Quantity4_UnitOfMeasrCd_definitionXSL_TSU_tsmt.019.001.03_Quantity4_UnitOfMeasrCd_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrUnitOfMeasr">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_OthrUnitOfMeasr_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrUnitOfMeasr">
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Qty/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/UnitOfMeasrCd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_UnitOfMeasrCd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Qty/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrUnitOfMeasr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_OthrUnitOfMeasr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Quantity4_OthrUnitOfMeasr_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_QtyTlrnce_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PlusPct">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct">
<xsl:with-param name="path" select="concat($path,'/QtyTlrnce')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="QtyTlrnce/PlusPct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlusPct')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="QtyTlrnce/MnsPct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MnsPct')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_UnitPric_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_UnitPric_choice_1">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:call-template>
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Fctr">
<xsl:with-param name="path" select="concat($path,'/UnitPric')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="UnitPric/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="UnitPric/Fctr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Fctr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Fctr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_Fctr_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_UnitPric_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitPric"/>
</xsl:variable>
<xsl:if test="UnitOfMeasrCd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="UnitOfMeasrCd">
<xsl:apply-templates select="UnitOfMeasrCd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_UnitPrice9_UnitOfMeasrCd_nameXSL_TSU_tsmt.019.001.03_UnitPrice9_UnitOfMeasrCd_definitionXSL_TSU_tsmt.019.001.03_UnitPrice9_UnitOfMeasrCd_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrUnitOfMeasr">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_OthrUnitOfMeasr_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrUnitOfMeasr">
<xsl:apply-templates select="OthrUnitOfMeasr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="UnitPric/UnitOfMeasrCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UnitOfMeasrCd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/UnitOfMeasrCd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_UnitOfMeasrCd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="UnitPric/OthrUnitOfMeasr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrUnitOfMeasr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrUnitOfMeasr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_OthrUnitOfMeasr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UnitPrice9_OthrUnitOfMeasr_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PricTlrnce_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PlusPct">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MnsPct">
<xsl:with-param name="path" select="concat($path,'/PricTlrnce')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PricTlrnce/PlusPct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlusPct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlusPct')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_PlusPct_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PricTlrnce/MnsPct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MnsPct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MnsPct')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PercentageTolerance1_MnsPct_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdctNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PdctNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctIdr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_PdctIdr_choice_1">
<xsl:with-param name="path" select="concat($path,'/PdctIdr[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_PdctIdr_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctIdr"/>
</xsl:variable>
<xsl:if test="StrdPdctIdr">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_StrdPdctIdr_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="StrdPdctIdr">
<xsl:apply-templates select="StrdPdctIdr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_ ProductIdentifier2Choice_StrdPdctIdr_nameXSL_TSU_tsmt.019.001.03_ ProductIdentifier2Choice_StrdPdctIdr_definitionXSL_TSU_tsmt.019.001.03_ ProductIdentifier2Choice_StrdPdctIdr_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
<xsl:if test="OthrPdctIdr">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2Choice_OthrPdctIdr_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="OthrPdctIdr">
<xsl:apply-templates select="OthrPdctIdr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="PdctIdr/StrdPdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrdPdctIdr"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/StrdPdctIdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Idr">
<xsl:with-param name="path" select="concat($path,'/StrdPdctIdr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="StrdPdctIdr/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="StrdPdctIdr/Idr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Idr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Idr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Idr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductIdentifier2_Idr_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PdctIdr/OthrPdctIdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPdctIdr"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/OthrPdctIdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/OthrPdctIdr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OthrPdctIdr/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrPdctIdr/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctChrtcs_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_PdctChrtcs_choice_1">
<xsl:with-param name="path" select="concat($path,'/PdctChrtcs[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_PdctChrtcs_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctChrtcs"/>
</xsl:variable>
<xsl:if test="StrdPdctChrtcs">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_StrdPdctChrtcs_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="StrdPdctChrtcs">
<xsl:apply-templates select="StrdPdctChrtcs">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_ProductCharacteristics1Choice_StrdPdctChrtcs_nameXSL_TSU_tsmt.019.001.03_ProductCharacteristics1Choice_StrdPdctChrtcs_definitionXSL_TSU_tsmt.019.001.03_ProductCharacteristics1Choice_StrdPdctChrtcs_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
<xsl:if test="OthrPdctChrtcs">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1Choice_OthrPdctChrtcs_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="OthrPdctChrtcs">
<xsl:apply-templates select="OthrPdctChrtcs">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="PdctChrtcs/StrdPdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrdPdctChrtcs"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/StrdPdctChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrtcs">
<xsl:with-param name="path" select="concat($path,'/StrdPdctChrtcs')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="StrdPdctChrtcs/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="StrdPdctChrtcs/Chrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrtcs"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Chrtcs')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Chrtcs_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCharacteristics1_Chrtcs_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PdctChrtcs/OthrPdctChrtcs">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPdctChrtcs"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/OthrPdctChrtcs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/OthrPdctChrtcs')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OthrPdctChrtcs/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrPdctChrtcs/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctCtgy_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_PdctCtgy_choice_1">
<xsl:with-param name="path" select="concat($path,'/PdctCtgy[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_PdctCtgy_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctCtgy"/>
</xsl:variable>
<xsl:if test="StrdPdctCtgy">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_StrdPdctCtgy_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="StrdPdctCtgy">
<xsl:apply-templates select="StrdPdctCtgy">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_ProductCategory1Choice_StrdPdctCtgy_nameXSL_TSU_tsmt.019.001.03_ProductCategory1Choice_StrdPdctCtgy_definitionXSL_TSU_tsmt.019.001.03_ProductCategory1Choice_StrdPdctCtgy_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
<xsl:if test="OthrPdctCtgy">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1Choice_OthrPdctCtgy_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="OthrPdctCtgy">
<xsl:apply-templates select="OthrPdctCtgy">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="PdctCtgy/StrdPdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrdPdctCtgy"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/StrdPdctCtgy')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctgy">
<xsl:with-param name="path" select="concat($path,'/StrdPdctCtgy')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="StrdPdctCtgy/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="StrdPdctCtgy/Ctgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctgy"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctgy')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Ctgy_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ProductCategory1_Ctgy_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PdctCtgy/OthrPdctCtgy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPdctCtgy"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/OthrPdctCtgy')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/OthrPdctCtgy')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OthrPdctCtgy/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrPdctCtgy/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="LineItmDtls/PdctOrgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdctOrgn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PdctOrgn[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdctOrgn_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_ShipmntSchdl_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_ShipmntSchdl_choice_1">
<xsl:with-param name="path" select="concat($path,'/ShipmntSchdl')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_ShipmntSchdl_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntSchdl"/>
</xsl:variable>
<xsl:if test="ShipmntDtRg">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntDtRg_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="ShipmntDtRg">
<xsl:apply-templates select="ShipmntDtRg">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_ShipmentSchedule1Choice_ShipmntDtRg_nameXSL_TSU_tsmt.019.001.03_ShipmentSchedule1Choice_ShipmntDtRg_definitionXSL_TSU_tsmt.019.001.03_ShipmentSchedule1Choice_ShipmntDtRg_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
<xsl:if test="ShipmntSubSchdl">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentSchedule1Choice_ShipmntSubSchdl_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="ShipmntSubSchdl">
<xsl:apply-templates select="ShipmntSubSchdl">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="ShipmntSchdl/ShipmntDtRg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntDtRg"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="EarlstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntDtRg')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="ShipmntDtRg/EarlstShipmntDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EarlstShipmntDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EarlstShipmntDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_EarlstShipmntDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="ShipmntDtRg/LatstShipmntDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LatstShipmntDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/LatstShipmntDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange1_LatstShipmntDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="ShipmntSchdl/ShipmntSubSchdl">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ShipmntSubSchdl"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="SubQtyVal">
<xsl:with-param name="path" select="concat($path,'/ShipmntSubSchdl[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="EarlstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntSubSchdl[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="LatstShipmntDt">
<xsl:with-param name="path" select="concat($path,'/ShipmntSubSchdl[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="ShipmntSubSchdl/SubQtyVal">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SubQtyVal"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/SubQtyVal')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_SubQtyVal_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_SubQtyVal_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="ShipmntSubSchdl/EarlstShipmntDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EarlstShipmntDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EarlstShipmntDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_EarlstShipmntDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_EarlstShipmntDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="ShipmntSubSchdl/LatstShipmntDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LatstShipmntDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/LatstShipmntDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_LatstShipmntDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ShipmentDateRange2_LatstShipmntDt_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_RtgSummry_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="IndvTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MltmdlTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="RtgSummry/IndvTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IndvTrnsprt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByAir_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DprtureAirprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="TrnsprtByAir_DprtureAirprt_choice_1">
<xsl:with-param name="path" select="concat($path,'/DprtureAirprt[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="TrnsprtByAir_DprtureAirprt_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DprtureAirprt"/>
</xsl:variable>
<xsl:if test="AirprtCd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="AirprtCd">
<xsl:apply-templates select="AirprtCd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_AirportName1Choice_AirprtCd_nameXSL_TSU_tsmt.019.001.03_AirportName1Choice_AirprtCd_definitionXSL_TSU_tsmt.019.001.03_AirportName1Choice_AirprtCd_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrAirprtDesc">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_OthrAirprtDesc_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="OthrAirprtDesc">
<xsl:apply-templates select="OthrAirprtDesc">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="DprtureAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtCd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="DprtureAirprt/OthrAirprtDesc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAirprtDesc"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Twn">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirprtNm">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/Twn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Twn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Twn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/AirprtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DstnAirprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="TrnsprtByAir_DstnAirprt_choice_1">
<xsl:with-param name="path" select="concat($path,'/DstnAirprt[', $index,']')"/>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="TrnsprtByAir_DstnAirprt_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<xsl:if test="AirprtCd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="AirprtCd">
<xsl:apply-templates select="AirprtCd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_AirportName1Choice_AirprtCd_nameXSL_TSU_tsmt.019.001.03_AirportName1Choice_AirprtCd_definitionXSL_TSU_tsmt.019.001.03_AirportName1Choice_AirprtCd_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrAirprtDesc">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_OthrAirprtDesc_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="OthrAirprtDesc">
<xsl:apply-templates select="OthrAirprtDesc">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="DstnAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtCd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="DstnAirprt/OthrAirprtDesc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAirprtDesc"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Twn">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirprtNm">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/Twn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Twn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Twn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/AirprtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/AirCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtBySea_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfLoadng">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PortOfLoadng"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PortOfLoadng[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PortOfDschrge[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/SeaCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SeaCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/SeaCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRoad_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfRct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/RoadCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RoadCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/RoadCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRail_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfRct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/RailCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RailCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/RailCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_MltmdlTrnsprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="TakngInChrg">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfFnlDstn">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/TakngInChrg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TakngInChrg"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TakngInChrg')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/PlcOfFnlDstn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfFnlDstn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfFnlDstn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Incotrms_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_Incotrms_choice_1">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="Incotrms/Lctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Lctn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_Incotrms_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="Cd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Cd">
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Incoterms1_Cd_nameXSL_TSU_tsmt.019.001.03_Incoterms1_Cd_definitionXSL_TSU_tsmt.019.001.03_Incoterms1_Cd_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Othr">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Othr">
<xsl:apply-templates select="Othr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Incotrms/Cd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Incotrms/Othr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Othr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Othr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Adjstmnt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_Adjstmnt_choice_1">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="LineItmDtls_Adjstmnt_choice_2">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Drctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Drctn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Drctn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_Adjstmnt_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="Tp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Adjustment3_Tp_nameXSL_TSU_tsmt.019.001.03_Adjustment3_Tp_definitionXSL_TSU_tsmt.019.001.03_Adjustment3_Tp_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrAdjstmntTp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrAdjstmntTp">
<xsl:apply-templates select="OthrAdjstmntTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Adjstmnt/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/OthrAdjstmntTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAdjstmntTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrAdjstmntTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_Adjstmnt_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Adjustment3_Amt_nameXSL_TSU_tsmt.019.001.03_Adjustment3_Amt_definitionXSL_TSU_tsmt.019.001.03_Adjustment3_Amt_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Rate">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Rate">
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Adjstmnt/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Rate">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Rate')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_FrghtChrgs_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="FrghtChrgs/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Chrgs_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="FrghtChrgs_Chrgs_choice_1">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="FrghtChrgs_Chrgs_choice_2">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="FrghtChrgs_Chrgs_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrgs"/>
</xsl:variable>
<xsl:if test="Tp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_ChargesDetails1_Tp_nameXSL_TSU_tsmt.019.001.03_ChargesDetails1_Tp_definitionXSL_TSU_tsmt.019.001.03_ChargesDetails1_Tp_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrChrgsTp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrChrgsTp">
<xsl:apply-templates select="OthrChrgsTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Chrgs/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Chrgs/OthrChrgsTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrChrgsTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrChrgsTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="FrghtChrgs_Chrgs_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Chrgs"/>
</xsl:variable>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_ChargesDetails1_Amt_nameXSL_TSU_tsmt.019.001.03_ChargesDetails1_Amt_definitionXSL_TSU_tsmt.019.001.03_ChargesDetails1_Amt_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Rate">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Rate">
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Chrgs/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Chrgs/Rate">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Rate')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_Tax_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="LineItmDtls_Tax_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="LineItmDtls_Tax_choice_2">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_Tax_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="Tp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Tax13_Tp_nameXSL_TSU_tsmt.019.001.03_Tax13_Tp_definitionXSL_TSU_tsmt.019.001.03_Tax13_Tp_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrTaxTp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrTaxTp">
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Tax/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Tax/OthrTaxTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrTaxTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrTaxTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="LineItmDtls_Tax_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Tax13_Amt_nameXSL_TSU_tsmt.019.001.03_Tax13_Amt_definitionXSL_TSU_tsmt.019.001.03_Tax13_Amt_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Rate">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Rate">
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Tax/Rate">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Rate')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>

<xsl:template match="LineItmDtls/OrdrdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OrdrdAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OrdrdAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OrdrdAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OrdrdAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>


<xsl:template match="LineItmDtls/AccptdAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_AccptdAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AccptdAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_AccptdAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_AccptdAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>


<xsl:template match="LineItmDtls/OutsdngAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OutsdngAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OutsdngAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OutsdngAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_OutsdngAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>


<xsl:template match="LineItmDtls/PdgAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdgAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PdgAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdgAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItemDetails7_PdgAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>


<xsl:template match="Goods/OrdrdLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdLineItmsTtlAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OrdrdLineItmsTtlAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OrdrdLineItmsTtlAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OrdrdLineItmsTtlAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OrdrdLineItmsTtlAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>


<xsl:template match="Goods/AccptdLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdLineItmsTtlAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_AccptdLineItmsTtlAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AccptdLineItmsTtlAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_AccptdLineItmsTtlAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_AccptdLineItmsTtlAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>


<xsl:template match="Goods/OutsdngLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngLineItmsTtlAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OutsdngLineItmsTtlAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OutsdngLineItmsTtlAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OutsdngLineItmsTtlAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OutsdngLineItmsTtlAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>



<xsl:template match="Goods/PdgLineItmsTtlAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmsTtlAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PdgLineItmsTtlAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PdgLineItmsTtlAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PdgLineItmsTtlAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PdgLineItmsTtlAmt_definition')"/>
</xsl:attribute>
</img>
</div>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_RtgSummry_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="IndvTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
</xsl:apply-templates>
<xsl:apply-templates select="MltmdlTrnsprt">
<xsl:with-param name="path" select="concat($path,'/RtgSummry')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="RtgSummry/IndvTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IndvTrnsprt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_IndvTrnsprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByAir_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="DprtureAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="DstnAirprt">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByAir[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DprtureAirprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="TrnsprtByAir_DprtureAirprt_choice_1">
<xsl:with-param name="path" select="concat($path,'/DprtureAirprt[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="DprtureAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtCd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="DprtureAirprt/OthrAirprtDesc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAirprtDesc"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Twn">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirprtNm">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/Twn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Twn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Twn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/AirprtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/DstnAirprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="DstnAirprt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_DstnAirprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="TrnsprtByAir_DstnAirprt_choice_1">
<xsl:with-param name="path" select="concat($path,'/DstnAirprt[', $index,']')"/>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="DstnAirprt/AirprtCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtCd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtCd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportName1Choice_AirprtCd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="DstnAirprt/OthrAirprtDesc">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAirprtDesc"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Twn">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
<xsl:apply-templates select="AirprtNm">
<xsl:with-param name="path" select="concat($path,'/OthrAirprtDesc')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/Twn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Twn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Twn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_Twn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrAirprtDesc/AirprtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirprtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirprtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AirportDescription1_AirprtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByAir/AirCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AirCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AirCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByAir3_AirCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtBySea_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PortOfLoadng">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PortOfDschrge">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="SeaCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtBySea[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfLoadng">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PortOfLoadng"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PortOfLoadng[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfLoadng_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/PortOfDschrge">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PortOfDschrge"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PortOfDschrge[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_PortOfDschrge_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtBySea/SeaCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SeaCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/SeaCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportBySea3_SeaCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRoad_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RoadCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRoad[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfRct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfRct_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_PlcOfDlvry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRoad/RoadCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RoadCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/RoadCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRoad3_RoadCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SingleTransport4_TrnsprtByRail_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="PlcOfRct">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfDlvry">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RailCrrierNm">
<xsl:with-param name="path" select="concat($path,'/TrnsprtByRail[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfRct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfRct"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfRct[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfRct_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/PlcOfDlvry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfDlvry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfDlvry[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_PlcOfDlvry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="TrnsprtByRail/RailCrrierNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RailCrrierNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/RailCrrierNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportByRail3_RailCrrierNm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_TransportMeans1_MltmdlTrnsprt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="TakngInChrg">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PlcOfFnlDstn">
<xsl:with-param name="path" select="concat($path,'/MltmdlTrnsprt')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/TakngInChrg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TakngInChrg"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TakngInChrg')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_TakngInChrg_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="MltmdlTrnsprt/PlcOfFnlDstn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PlcOfFnlDstn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PlcOfFnlDstn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_MultimodalTransport3_PlcOfFnlDstn_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Incotrms_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="Goods_Incotrms_choice_1">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Lctn">
<xsl:with-param name="path" select="concat($path,'/Incotrms[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="Incotrms/Lctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Lctn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Lctn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Lctn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="Goods_Incotrms_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Incotrms"/>
</xsl:variable>
<xsl:if test="Cd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Cd">
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Incoterms1_Cd_nameXSL_TSU_tsmt.019.001.03_Incoterms1_Cd_definitionXSL_TSU_tsmt.019.001.03_Incoterms1_Cd_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Othr">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Othr">
<xsl:apply-templates select="Othr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Incotrms/Cd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Cd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Incotrms/Othr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Othr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Othr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Incoterms1_Othr_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Adjstmnt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="Goods_Adjstmnt_choice_1">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="Goods_Adjstmnt_choice_2">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:call-template>
<xsl:apply-templates select="Drctn">
<xsl:with-param name="path" select="concat($path,'/Adjstmnt[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Drctn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Drctn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Drctn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Drctn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="Goods_Adjstmnt_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="Tp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Adjustment3_Tp_nameXSL_TSU_tsmt.019.001.03_Adjustment3_Tp_definitionXSL_TSU_tsmt.019.001.03_Adjustment3_Tp_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrAdjstmntTp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrAdjstmntTp">
<xsl:apply-templates select="OthrAdjstmntTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Adjstmnt/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/OthrAdjstmntTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrAdjstmntTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrAdjstmntTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_OthrAdjstmntTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="Goods_Adjstmnt_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adjstmnt"/>
</xsl:variable>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Adjustment3_Amt_nameXSL_TSU_tsmt.019.001.03_Adjustment3_Amt_definitionXSL_TSU_tsmt.019.001.03_Adjustment3_Amt_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Rate">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Rate">
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Adjstmnt/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adjstmnt/Rate">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Rate')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Adjustment3_Rate_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_FrghtChrgs_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Chrgs">
<xsl:with-param name="path" select="concat($path,'/FrghtChrgs')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="FrghtChrgs/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Tp_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Charge12_Chrgs_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="FrghtChrgs_Chrgs_choice_1">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="FrghtChrgs_Chrgs_choice_2">
<xsl:with-param name="path" select="concat($path,'/Chrgs[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="Chrgs/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Chrgs/OthrChrgsTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrChrgsTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrChrgsTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_OthrChrgsTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Chrgs/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Chrgs/Rate">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Rate')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ChargesDetails1_Rate_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_Tax_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="Goods_Tax_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="Goods_Tax_choice_2">
<xsl:with-param name="path" select="concat($path,'/Tax[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="Goods_Tax_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="Tp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Tp">
<xsl:apply-templates select="Tp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Tax13_Tp_nameXSL_TSU_tsmt.019.001.03_Tax13_Tp_definitionXSL_TSU_tsmt.019.001.03_Tax13_Tp_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="OthrTaxTp">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrTaxTp">
<xsl:apply-templates select="OthrTaxTp">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Tax/Tp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Tp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Tp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Tax/OthrTaxTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrTaxTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrTaxTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_OthrTaxTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="Goods_Tax_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tax"/>
</xsl:variable>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_Tax13_Amt_nameXSL_TSU_tsmt.019.001.03_Tax13_Amt_definitionXSL_TSU_tsmt.019.001.03_Tax13_Amt_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Rate">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Rate">
<xsl:apply-templates select="Rate">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Tax/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Tax/Rate">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Rate"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Rate')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Tax13_Rate_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>

<xsl:template match="Goods/OrdrdTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OrdrdTtlNetAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OrdrdTtlNetAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OrdrdTtlNetAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OrdrdTtlNetAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OrdrdTtlNetAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>

<xsl:template match="Goods/AccptdTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AccptdTtlNetAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_AccptdTtlNetAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AccptdTtlNetAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_AccptdTtlNetAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_AccptdTtlNetAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>

<xsl:template match="Goods/OutsdngTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OutsdngTtlNetAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OutsdngTtlNetAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OutsdngTtlNetAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OutsdngTtlNetAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_OutsdngTtlNetAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>

<xsl:template match="Goods/PdgTtlNetAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PdgTtlNetAmt"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PdgTtlNetAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PdgTtlNetAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PdgTtlNetAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_PdgTtlNetAmt_definition')"/>
</xsl:attribute>
</img>
</div>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_BuyrDfndInf_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/BuyrDfndInf[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="BuyrDfndInf/Labl">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Labl')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrDfndInf/Inf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Inf')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_LineItem7_SellrDfndInf_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Labl">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Inf">
<xsl:with-param name="path" select="concat($path,'/SellrDfndInf[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="SellrDfndInf/Labl">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Labl"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Labl')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Labl_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrDfndInf/Inf">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Inf"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Inf')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_UserDefinedInformation1_Inf_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/PmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtTerms_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="Baseln_PmtTerms_choice_1">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="Baseln_PmtTerms_choice_2">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="Baseln_PmtTerms_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="OthrPmtTerms">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_OthrPmtTerms_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrPmtTerms">
<xsl:apply-templates select="OthrPmtTerms">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_PaymentTerms1_OthrPmtTerms_nameXSL_TSU_tsmt.019.001.03_PaymentTerms1_OthrPmtTerms_definitionXSL_TSU_tsmt.019.001.03_PaymentTerms1_OthrPmtTerms_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="PmtCd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_PmtCd_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="PmtCd">
<xsl:apply-templates select="PmtCd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="PmtTerms/OthrPmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPmtTerms"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrPmtTerms')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_OthrPmtTerms_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_OthrPmtTerms_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtTerms/PmtCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtCd"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/PmtCd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NbOfDays">
<xsl:with-param name="path" select="concat($path,'/PmtCd')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="PmtCd/Cd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_Cd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtCd/NbOfDays">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NbOfDays"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/NbOfDays')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_NbOfDays_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod1_NbOfDays_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="Baseln_PmtTerms_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="Pctg">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Pctg_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Pctg">
<xsl:apply-templates select="Pctg">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_PaymentTerms1_Pctg_nameXSL_TSU_tsmt.019.001.03_PaymentTerms1_Pctg_definitionXSL_TSU_tsmt.019.001.03_PaymentTerms1_Pctg_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_name')&#10;                "/>
</B>
</div>
<br/>
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
</xsl:if>
</xsl:template>
<xsl:template match="PmtTerms/Pctg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Pctg"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Pctg')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Pctg_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Pctg_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtTerms/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms1_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_SttlmTerms_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="CdtrAgt">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CdtrAcct">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
</div>
<br/>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAgt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="SttlmTerms_CdtrAgt_choice_1">
<xsl:with-param name="path" select="concat($path,'/CdtrAgt')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="SttlmTerms_CdtrAgt_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAgt"/>
</xsl:variable>
<xsl:if test="BIC">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="BIC">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_FinancialInstitutionIdentification4Choice_BIC_nameXSL_TSU_tsmt.019.001.03_FinancialInstitutionIdentification4Choice_BIC_definitionXSL_TSU_tsmt.019.001.03_FinancialInstitutionIdentification4Choice_BIC_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="NmAndAdr">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_NmAndAdr_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="NmAndAdr">
<xsl:apply-templates select="NmAndAdr">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="CdtrAgt/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CdtrAgt/NmAndAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmAndAdr"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adr">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="NmAndAdr/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="NmAndAdr/Adr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Adr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
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
</xsl:template>
<xsl:template match="Adr/StrtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_StrtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_StrtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/PstCdId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_PstCdId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/TwnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_TwnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_CtrySubDvsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_CtrySubDvsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAcct"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
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
</xsl:template>
<xsl:template match="CdtrAcct/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="CdtrAcct_Id_choice_1">
<xsl:with-param name="path" select="concat($path,'/Id')"/>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template name="CdtrAcct_Id_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<xsl:if test="IBAN">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="IBAN">
<xsl:apply-templates select="IBAN">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_AccountIdentification3Choice_IBAN_nameXSL_TSU_tsmt.019.001.03_AccountIdentification3Choice_IBAN_definitionXSL_TSU_tsmt.019.001.03_AccountIdentification3Choice_IBAN_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="BBAN">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="BBAN">
<xsl:apply-templates select="BBAN">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="UPIC">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/3</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="UPIC">
<xsl:apply-templates select="UPIC">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="PrtryAcct">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/4</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_PrtryAcct_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="PrtryAcct">
<xsl:apply-templates select="PrtryAcct">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Id/IBAN">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IBAN"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IBAN')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Id/BBAN">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BBAN"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BBAN')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Id/UPIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UPIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/UPIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Id/PrtryAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryAcct"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryAcct')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="PrtryAcct/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Tp_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="CdtrAcct_Tp_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tp')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="CdtrAcct_Tp_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Tp"/>
</xsl:variable>
<xsl:if test="Cd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Cd">
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_CashAccountType2_Cd_nameXSL_TSU_tsmt.019.001.03_CashAccountType2_Cd_definitionXSL_TSU_tsmt.019.001.03_CashAccountType2_Cd_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Prtry">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Prtry">
<xsl:apply-templates select="Prtry">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="Tp/Cd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Tp/Prtry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Prtry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Prtry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CdtrAcct/Ccy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ccy"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ccy')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CdtrAcct/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_PmtOblgtn_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="OblgrBk">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="RcptBk">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:apply-templates>
<xsl:call-template name="Baseln_PmtOblgtn_choice_1">
<xsl:with-param name="path" select="concat($path,'/PmtOblgtn[', $index,']')"/>
</xsl:call-template>
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
<br/>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/OblgrBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OblgrBk"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_OblgrBk_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/OblgrBk')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="OblgrBk/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/RcptBk">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="RcptBk"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_RcptBk_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/RcptBk')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="RcptBk/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/ChrgsAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsAmt_definition')"/>
</xsl:attribute>
</img>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/ChrgsPctg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ChrgsPctg"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/ChrgsPctg')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_ChrgsPctg_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/XpryDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="XpryDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/XpryDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_XpryDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/AplblLaw">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AplblLaw"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AplblLaw')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_AplblLaw_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_PmtTerms_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="PmtOblgtn_PmtTerms_choice_1">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:call-template>
<xsl:call-template name="PmtOblgtn_PmtTerms_choice_2">
<xsl:with-param name="path" select="concat($path,'/PmtTerms[', $index,']')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template name="PmtOblgtn_PmtTerms_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="OthrPmtTerms">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_OthrPmtTerms_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="OthrPmtTerms">
<xsl:apply-templates select="OthrPmtTerms">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_PaymentTerms2_OthrPmtTerms_nameXSL_TSU_tsmt.019.001.03_PaymentTerms2_OthrPmtTerms_definitionXSL_TSU_tsmt.019.001.03_PaymentTerms2_OthrPmtTerms_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="PmtCd">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_PmtCd_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="PmtCd">
<xsl:apply-templates select="PmtCd">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="PmtTerms/OthrPmtTerms">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="OthrPmtTerms"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/OthrPmtTerms')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_OthrPmtTerms_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_OthrPmtTerms_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtTerms/PmtCd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtCd"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Cd">
<xsl:with-param name="path" select="concat($path,'/PmtCd')"/>
</xsl:apply-templates>
<xsl:apply-templates select="NbOfDays">
<xsl:with-param name="path" select="concat($path,'/PmtCd')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="PmtCd/Cd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_Cd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtCd/NbOfDays">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NbOfDays"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/NbOfDays')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_NbOfDays_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentPeriod2_NbOfDays_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="PmtOblgtn_PmtTerms_choice_2">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtTerms"/>
</xsl:variable>
<xsl:if test="Pctg">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Pctg_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Pctg">
<xsl:apply-templates select="Pctg">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_PaymentTerms2_Pctg_nameXSL_TSU_tsmt.019.001.03_PaymentTerms2_Pctg_definitionXSL_TSU_tsmt.019.001.03_PaymentTerms2_Pctg_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_2/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Amt_name')&#10;                "/>
</B>
</div>
<br/>
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
</xsl:if>
</xsl:template>
<xsl:template match="PmtTerms/Pctg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Pctg"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Pctg')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Pctg_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Pctg_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtTerms/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentTerms2_Amt_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_SttlmTerms_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="CdtrAgt">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CdtrAcct">
<xsl:with-param name="path" select="concat($path,'/SttlmTerms')"/>
</xsl:apply-templates>
</div>
<br/>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAgt_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="SttlmTerms_CdtrAgt_choice_1">
<xsl:with-param name="path" select="concat($path,'/CdtrAgt')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="CdtrAgt/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_FinancialInstitutionIdentification4Choice_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CdtrAgt/NmAndAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmAndAdr"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Adr">
<xsl:with-param name="path" select="concat($path,'/NmAndAdr')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="NmAndAdr/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="NmAndAdr/Adr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Adr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_NameAndAddress6_Adr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
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
</xsl:template>
<xsl:template match="Adr/StrtNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="StrtNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/StrtNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_StrtNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_StrtNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/PstCdId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PstCdId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PstCdId')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_PstCdId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_PstCdId_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/TwnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="TwnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/TwnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_TwnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_TwnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/CtrySubDvsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CtrySubDvsn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CtrySubDvsn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_CtrySubDvsn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_CtrySubDvsn_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Adr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PostalAddress2_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SttlmTerms/CdtrAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CdtrAcct"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SettlementTerms2_CdtrAcct_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
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
</xsl:template>
<xsl:template match="CdtrAcct/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Id_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="CdtrAcct_Id_choice_1">
<xsl:with-param name="path" select="concat($path,'/Id')"/>
</xsl:call-template>
</div>
</xsl:template>
<xsl:template match="Id/IBAN">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IBAN"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IBAN')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_IBAN_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Id/BBAN">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BBAN"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BBAN')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_BBAN_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Id/UPIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="UPIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/UPIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_AccountIdentification3Choice_UPIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Id/PrtryAcct">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PrtryAcct"/>
</xsl:variable>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryAcct')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="PrtryAcct/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_SimpleIdentificationInformation2_Id_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Tp_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:call-template name="CdtrAcct_Tp_choice_1">
<xsl:with-param name="path" select="concat($path,'/Tp')"/>
</xsl:call-template>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="Tp/Cd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Cd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Cd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Cd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Tp/Prtry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Prtry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Prtry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccountType2_Prtry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CdtrAcct/Ccy">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ccy"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ccy')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Ccy_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CdtrAcct/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_CashAccount7_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="Baseln_PmtOblgtn_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PmtOblgtn"/>
</xsl:variable>
<xsl:if test="Amt">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Amt">
<xsl:apply-templates select="Amt">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_PaymentObligation1_Amt_nameXSL_TSU_tsmt.019.001.03_PaymentObligation1_Amt_definitionXSL_TSU_tsmt.019.001.03_PaymentObligation1_Amt_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</div>
</xsl:if>
<xsl:if test="Pctg">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Pctg_name')&#10;                "/>
</B>
</div>
<br/>
<div class="section">
<xsl:choose>
<xsl:when test="Pctg">
<xsl:apply-templates select="Pctg">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="PmtOblgtn/Amt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Amt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Amt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                          localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_name')&#10;                        "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="@Ccy"/>
</font>
<span style="margin-left: 7px">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertTSUAmount2MTPAmount(text(), @Ccy, $language)"/>
</font>
</span>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Amt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PmtOblgtn/Pctg">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Pctg"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Pctg')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Pctg_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PaymentObligation1_Pctg_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/LatstMtchDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LatstMtchDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/LatstMtchDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="tools:convertISODate2MTPDate(text(), $language)"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_LatstMtchDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/ComrclDataSetReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ComrclDataSetReqrd"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_ComrclDataSetReqrd_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/ComrclDataSetReqrd')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="ComrclDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_TrnsprtDataSetReqrd_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/TrnsprtDataSetReqrd')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="TrnsprtDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission2_Submitr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_InsrncDataSetReqrd_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_Submitr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIssr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchIsseDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MtchIsseDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIsseDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchIsseDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchTrnsprt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchTrnsprt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MtchTrnsprt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchTrnsprt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchTrnsprt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchAmt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchAmt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MtchAmt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAmt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAmt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/ClausesReqrd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="ClausesReqrd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/ClausesReqrd[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_ClausesReqrd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InsrncDataSetReqrd/MtchAssrdPty">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchAssrdPty"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MtchAssrdPty')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission3_MtchAssrdPty_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_CertDataSetReqrd_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_Submitr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/CertTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CertTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_CertTp_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIssr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchIssr')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="MtchIssr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchIsseDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchIsseDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MtchIsseDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIsseDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchIsseDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchInspctnDt">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchInspctnDt"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MtchInspctnDt')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchInspctnDt_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchInspctnDt_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/AuthrsdInspctrInd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="AuthrsdInspctrInd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/AuthrsdInspctrInd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_AuthrsdInspctrInd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_AuthrsdInspctrInd_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/MtchConsgn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="MtchConsgn"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/MtchConsgn')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchConsgn_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchConsgn_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_MtchManfctr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Nm">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="PrtryId">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
</xsl:apply-templates>
<xsl:apply-templates select="Ctry">
<xsl:with-param name="path" select="concat($path,'/MtchManfctr')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="MtchManfctr/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Nm_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_PrtryId_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Id">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
<xsl:apply-templates select="IdTp">
<xsl:with-param name="path" select="concat($path,'/PrtryId')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="PrtryId/Id">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Id"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Id')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_Id_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="PrtryId/IdTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="IdTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/IdTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_GenericIdentification4_IdTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="MtchManfctr/Ctry">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Ctry"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Ctry')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_PartyIdentification27_Ctry_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="CertDataSetReqrd/LineItmId">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="LineItmId"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/LineItmId[', $index,']')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission4_LineItmId_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_OthrCertDataSetReqrd_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="Submitr">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
<xsl:apply-templates select="CertTp">
<xsl:with-param name="path" select="concat($path,'/OthrCertDataSetReqrd[', $index,']')"/>
</xsl:apply-templates>
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/Submitr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Submitr"/>
</xsl:variable>
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_Submitr_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
<xsl:apply-templates select="BIC">
<xsl:with-param name="path" select="concat($path,'/Submitr[', $index,']')"/>
</xsl:apply-templates>
</div>
</xsl:template>
<xsl:template match="Submitr/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_BICIdentification1_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrCertDataSetReqrd/CertTp">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="CertTp"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/CertTp')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_RequiredSubmission5_CertTp_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="Baseln/InttToPayXpctd">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InttToPayXpctd"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/InttToPayXpctd')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_InttToPayXpctd_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:choose>
<xsl:when test=". = 'true'">
<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
</xsl:otherwise>
</xsl:choose>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_Baseline3_InttToPayXpctd_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_BuyrCtctPrsn_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/GvnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Role')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SellrCtctPrsn_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/GvnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Role')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_definition')"/>
</xsl:attribute>
</img>
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
<br/>
<div class="FORMH1">
<div style="float:left">
<B>
<xsl:value-of select="&#10;                        localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_OthrBkCtctPrsn_name')&#10;                      "/>
</B>
</div>
<div style="float:right">
<span>
<img src="/content/images/pic_arrowdown.gif" onclick="fncSwitchSectionVisibility(this)"/>
<img src="/content/images/pic_arrowright.gif" onclick="fncSwitchSectionVisibility(this)" style="display:none"/>
</span>
</div>
               
            </div>
<br/>
<div class="section">
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
</div>
<br/>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/BIC">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BIC"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/BIC')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_BIC_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_NmPrfx_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/GvnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_GvnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Role')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_Role_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_PhneNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_FaxNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="OthrBkCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification3_EmailAdr_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template name="Document_InitlBaselnSubmissn_choice_1">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="InitlBaselnSubmissn"/>
</xsl:variable>
<xsl:if test="BuyrBkCtctPrsn">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/1</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_BuyrBkCtctPrsn_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="BuyrBkCtctPrsn">
<xsl:apply-templates select="BuyrBkCtctPrsn">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_BuyrBkCtctPrsn_nameXSL_TSU_tsmt.019.001.03_BuyrBkCtctPrsn_definitionXSL_TSU_tsmt.019.001.03_BuyrBkCtctPrsn_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
<xsl:if test="SellrBkCtctPrsn">
<div>
<xsl:attribute name="id">
<xsl:value-of select="$path"/>/choice_1/2</xsl:attribute>
<div class="FORMH1">
<B>
<xsl:value-of select="&#10;                  localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_InitialBaselineSubmissionV03_SellrBkCtctPrsn_name')&#10;                "/>
</B>
</div>
<br/>
<xsl:choose>
<xsl:when test="SellrBkCtctPrsn">
<xsl:apply-templates select="SellrBkCtctPrsn">
<xsl:with-param name="path" select="$path"/>
</xsl:apply-templates>
</xsl:when>
<xsl:otherwise>XSL_TSU_tsmt.019.001.03_SellrBkCtctPrsn_nameXSL_TSU_tsmt.019.001.03_SellrBkCtctPrsn_definitionXSL_TSU_tsmt.019.001.03_SellrBkCtctPrsn_multiplicity</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/BuyrBkCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="BuyrBkCtctPrsn"/>
</xsl:variable>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/GvnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Role')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="BuyrBkCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="InitlBaselnSubmissn/SellrBkCtctPrsn">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="SellrBkCtctPrsn"/>
</xsl:variable>
<div class="section">
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
</div>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/Nm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Nm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Nm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Nm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/NmPrfx">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="NmPrfx"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/NmPrfx')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:variable name="localizationKey">
<xsl:value-of select="&#10;&#9;&#9;                concat('XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_code_', .)&#10;&#9;&#9;              "/>
</xsl:variable>
<xsl:value-of select="localization:getGTPString($language, $localizationKey)"/>
</font>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_NmPrfx_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/GvnNm">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="GvnNm"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/GvnNm')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_GvnNm_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/Role">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="Role"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/Role')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_Role_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/PhneNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="PhneNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/PhneNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_PhneNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/FaxNb">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="FaxNb"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/FaxNb')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_FaxNb_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
<xsl:template match="SellrBkCtctPrsn/EmailAdr">
<xsl:param name="path"/>
<xsl:variable name="index">
<xsl:number count="EmailAdr"/>
</xsl:variable>
<label>
<xsl:attribute name="for">
<xsl:value-of select="concat($path,'/EmailAdr')"/>
</xsl:attribute>
<xsl:value-of select="&#10;                localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_name')&#10;              "/>
</label>
<div class="input-box">
<font class="REPORTDATA">
<xsl:value-of select="text()"/>
</font>
<xsl:text/>
<img border="0" src="/content/images/pic_helpicon.gif">
<xsl:attribute name="title">
<xsl:value-of select="localization:getGTPString($language, 'XSL_TSU_InitlBaselnSubmissn_ContactIdentification1_EmailAdr_definition')"/>
</xsl:attribute>
</img>
</div>
</xsl:template>
</xsl:stylesheet>
