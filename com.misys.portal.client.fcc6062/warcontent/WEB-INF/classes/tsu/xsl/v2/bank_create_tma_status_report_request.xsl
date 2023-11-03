<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Form, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
  	version="1.0" 
  	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc"
	exclude-result-prefixes="xmlRender localization securitycheck utils defaultresource security xd">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <!-- Columns definition import -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="submitterBICCode"></xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">TM</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TMAScreen</xsl:param>
  
  <xsl:include href="../../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="tu_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC TNX FORM TEMPLATE.
   
  -->
  <xsl:template match="tu_tnx_record">
   <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
   
   <xsl:call-template name="entities-to-be-reported-declaration" />
   
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu.  -->
      <xsl:call-template name="menu" >
      	<xsl:with-param name="show-return">N</xsl:with-param>
      	<xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>


      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details" />
      <xsl:call-template name="request-status-report" />
      <xsl:call-template name="entities-to-be-reported-details" />
      	
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- The form that's submitted -->
    <xsl:call-template name="realform"/>
    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">N</xsl:with-param>
     <xsl:with-param name="show-template">N</xsl:with-param>
    </xsl:call-template>
   </div>
   
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->
 
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.tma.create_tm_status_request</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="issuing_bank/abbv_name" />
				</xsl:with-param>
			</xsl:call-template> 
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="issuing_bank/name" />
				</xsl:with-param>
			</xsl:call-template>  
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">tnx_type_code</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="tnx_type_code" />
				</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">message_type</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="message_type" />
				</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">ref_id</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="ref_id" />
				</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">submitter_bic</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$submitterBICCode" /></xsl:with-param>
			</xsl:call-template>
		</div>
  </xsl:template>
 
  <!--
   General Details Fieldset. 
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ref_id</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">appl_date</xsl:with-param>
				<xsl:with-param name="value" select="appl_date" />
			</xsl:call-template>
		<!--  System ID. -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
			<xsl:with-param name="id">general_ref_id_view</xsl:with-param>
			<xsl:with-param name="value" select="ref_id" />
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template> 
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="request-status-report">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_REQUEST_IDENTIFICATION_HEADER</xsl:with-param>
    <xsl:with-param name="content">
    	<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_REQUEST_ID</xsl:with-param>
			<xsl:with-param name="name">request_id</xsl:with-param>
			<xsl:with-param name="size">35</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="swift-validate">N</xsl:with-param>
			<xsl:with-param name="value">
			<xsl:value-of select = "narrative_xml/Document/StsRptReq/ReqId/Id" ></xsl:value-of>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">request_id</xsl:with-param>
			<xsl:with-param name="value">
			<xsl:value-of select = "narrative_xml/Document/StsRptReq/ReqId/Id" ></xsl:value-of>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_REQUEST_CREATION_DATE</xsl:with-param>
			<xsl:with-param name="name">creation_dt</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="swift-validate">N</xsl:with-param>
			<xsl:with-param name="value" select="appl_date" />
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">creation_dt</xsl:with-param>
			<xsl:with-param name="value" select="creation_dt" />
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">creation_dt_time</xsl:with-param>
			<xsl:with-param name="value" select="narrative_xml/Document/StsRptReq/ReqId/CreDtTm" />
		</xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
  
  <!--
   LC Realform.
   -->
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
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">45</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">messagetype</xsl:with-param>
       <xsl:with-param name="value">037</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xd:doc>
		<xd:short>Entities to be Reported</xd:short>
		<xd:detail>
			This displays message of no Entities to be Reported if no Entities to be Reportedis available and add button to add Entities to be Reported.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="entities-to-be-reported-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="entities-to-be-reported-dialog-declaration" />
		<!-- Dialog End -->
		<div id= "entities-to-be-reported-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_ENTITES_TO_BE_REPORTED')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="add_pymt_transport_ds_button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_ENTITES_TO_BE_REPORTED')" />
				</button>
			</div>
		</div>
	</xsl:template>
  
  <xd:doc>
		<xd:short>Entities to be Reported dialog declare</xd:short>
		<xd:detail>
			This templates displays BIC label and set the BIC parameters,also adds button of cancel and OK to confirm submitting
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="entities-to-be-reported-dialog-declaration">
		<div id="entities-to-be-reported-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">			
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
					<xsl:with-param name="name">entity_bic</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="bic" />
					</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>		
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('entities-to-be-reported-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('entities-to-be-reported-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Entities to be Reported </xd:short>
		<xd:detail>
			This template contains Entities to be Reported  section adds different parameters for this.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="entities-to-be-reported-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_ENTITES_TO_BE_REPORTED_HEADER</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-entities-to-be-reported-dojo-items">
					<xsl:with-param name="items" select="narrative_xml/Document/StsRptReq/NttiesToBeRptd" />
					<xsl:with-param name="id" select="entities-to-be-reported-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
  
  <xd:doc>
		<xd:short>Build Entities to be Reported detail</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes submitter bic header.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-entities-to-be-reported-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<xsl:value-of select="override-displaymode"/>
		<div dojoType="misys.openaccount.widget.EntitiesToBeReportedDetails" dialogId="entities-to-be-reported-dialog-template" id="entities-to-be-reported-ds">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_ENTITES_TO_BE_REPORTED')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_ENTITES_TO_BE_REPORTED')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_ENTITES_TO_BE_REPORTED')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PO_SUBMITTER_BIC')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="submitr" select="." />
				<div dojoType="misys.openaccount.widget.EntitiesToBeReportedDetail">
				<xsl:attribute name="BIC"><xsl:value-of
						select="$submitr/BIC" /></xsl:attribute>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
  
  
  
</xsl:stylesheet>