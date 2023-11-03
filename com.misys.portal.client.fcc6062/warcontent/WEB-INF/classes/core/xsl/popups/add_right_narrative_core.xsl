<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Form, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2018 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      09/05/18
##########################################################
-->
<xsl:stylesheet 
  	version="1.0" 
  	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization defaultresource">
   
  <xsl:param name="rundata"/>
  <xsl:param name="formLoad">false</xsl:param>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="is798">N</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
   <xsl:param name="node"/>
  
  <xsl:include href="../common/form_templates.xsl" />
  <xsl:include href="../common/trade_common.xsl" />
  <xsl:include href="../common/system_common.xsl" />
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
  	<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>	
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match ="message">
  	<xsl:if test="$swift2018Enabled and defaultresource:getResource('SWIFT_NARRATIVE_AMEND_ENABLE_CODEWORDS')= 'true'">
     	  <xsl:call-template name="multioption-inline-wrapper">
		      <xsl:with-param name="group-id">amendRadioButtons</xsl:with-param>
		      <xsl:with-param name="content">
			        <xsl:call-template name="multichoice-field">
				      <xsl:with-param name="label">XSL_NARRATIVE_ADD</xsl:with-param>
				      <xsl:with-param name="name">adr</xsl:with-param>
				      <xsl:with-param name="id">adr_1</xsl:with-param>
				      <xsl:with-param name="value">ADD</xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				     </xsl:call-template>
				    
				     <xsl:call-template name="multichoice-field">
				      <xsl:with-param name="label">XSL_NARRATIVE_DELETE</xsl:with-param>
				      <xsl:with-param name="name">adr</xsl:with-param>
				      <xsl:with-param name="id">adr_2</xsl:with-param>
				      <xsl:with-param name="value">DELETE</xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				     </xsl:call-template>
				     
				     <xsl:call-template name="multichoice-field">
				      <xsl:with-param name="label">XSL_NARRATIVE_REPALL</xsl:with-param>
				      <xsl:with-param name="name">adr</xsl:with-param>
				      <xsl:with-param name="id">adr_3</xsl:with-param>
				      <xsl:with-param name="value">REPALL</xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
			      	 </xsl:call-template>
		    </xsl:with-param>
	    </xsl:call-template>
	    </xsl:if>
     	<div style="display: inline-block; margin-left:25px; margin-top:10px; width:88%">		     
			<xsl:call-template name="textarea-field">
				<xsl:with-param name="name">narrative_description_goods_popup</xsl:with-param>
				<xsl:with-param name="button-type"/>
				<xsl:with-param name="cols">65</xsl:with-param>
				<xsl:with-param name="rows">14</xsl:with-param>
				<xsl:with-param name="maxlines">
					<xsl:choose>
						<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false'">100</xsl:when>
						<xsl:when test="$swift2018Enabled and $is798 = 'Y' and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">792</xsl:when>
						<xsl:otherwise>800</xsl:otherwise>
					</xsl:choose>		
				</xsl:with-param>
			</xsl:call-template>
		</div>
		<div style="display: inline-block;vertical-align:top">
			<xsl:call-template name="get-button">
	      			<xsl:with-param name="button-type"><xsl:value-of select="$node"/>_popup</xsl:with-param>
	      			<xsl:with-param name="widget-name">narrative_description_goods_popup</xsl:with-param>
	   		</xsl:call-template>
		</div>
   
	  	<div id="amendments-template" style = "margin-left:457px;">
				<div dojoType="dijit.form.Button" type="button" id="addAmendmentButton" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
				</div>
		</div>
		<div id = "RightDiv" style = "display: inline-block;margin-left:25px; margin-top:1px; width:88%; height: 225px; overflow:auto; border:1px solid #B8B8B8;">
			<div id = "gridContent" style = "height : 100%; width : 100%; overflow : hidden">
				<div dojoType="misys.widget.Amendments" dialogId="amendment-dialog-template"  gridId="amendments-grid" id="amendments" style = "width: 100%; height: 100%; overflow-y: scroll">
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/></xsl:attribute>
						<div dojoType="misys.widget.Amendment"></div>
				</div>
			</div>
		</div>
		<div style="display: inline-block;vertical-align:top">
			<xsl:call-template name="get-button">
	      			<xsl:with-param name="button-type">dataGridExtendedView</xsl:with-param>
	      			<xsl:with-param name="messageValue">gridPreviewOverlay</xsl:with-param>
	   		</xsl:call-template>
		</div>
		<div style="margin-left:281px; margin-top:1px;" class="amendNarrativeButtons">
			<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
				<button dojoType="dijit.form.Button" id="saveGridData" type="button">
					<xsl:attribute name="onClick">misys.consolidateGridData()</xsl:attribute>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_OK')"/>
				</button>
				<button dojoType="dijit.form.Button" id="cancelPopup" type="button">
					<xsl:attribute name="onClick">misys.closeAmendmentPopup()</xsl:attribute>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
				</button>
			</xsl:with-param>
			</xsl:call-template>
		</div>
  </xsl:template>
  <xsl:template name="common-js-imports">
  <!-- Required Parameters -->
  <xsl:param name="binding"/>
   
  <!-- HTML -->
  <!-- Message for js-disabled users. -->
 
  
<!--   <script>
   dojo.ready(function(){
  		misys._config = misys._config || {};
    	
   		<xsl:if test="$binding != ''"> and ($displaymode = 'edit' or ($displaymode = 'view' and $mode = 'UNSIGNED'))"
    		dojo.require("<xsl:value-of select="$binding"/>");
   		</xsl:if>
   });
  </script> -->
 </xsl:template>
  

</xsl:stylesheet>