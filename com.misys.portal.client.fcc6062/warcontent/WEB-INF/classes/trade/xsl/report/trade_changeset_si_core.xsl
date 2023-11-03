<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Issued Standby LC (SI) Form, Customer Side.
 
 Note: Templates beginning with lc_ are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;"> 
]>

<xsl:stylesheet 
  version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:common="http://exslt.org/common"
	exclude-result-prefixes="localization utils common">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SI</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/StandbyIssuedScreen</xsl:param>
  <xsl:param name="featureid"></xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../../core/xsl/common/lc_common.xsl" />
  <xsl:include href="../../../core/xsl/common/static_document_upload_templates.xsl" />
  <xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../../trade/xsl/report/lc_changeset_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="si_tnx_record"/>
  </xsl:template>
  
  <!-- 
   SI TNX FORM TEMPLATE.
  -->
  <xsl:template match="si_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <xsl:call-template name="static-document-dialog"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->    
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu.  -->
      <xsl:call-template name="menu" >
      <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>

      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details" />
      <xsl:call-template name="applicant-details"/>
      <xsl:call-template name="beneficiary-details"/>
      <xsl:call-template name="lc-amt-details-header">
       <xsl:with-param name="show-standby">N</xsl:with-param>
       <xsl:with-param name="override-product-code">lc</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="lc-renewal-details-header"/>
      <xsl:call-template name="lc-payment-details-header"/>
      <xsl:call-template name="lc-shipment-details-header"/>
      
      <!-- Bank Details -->
      <xsl:call-template name="lc-bank-details-new"/>
      
      <!-- Standby LC details -->
      <xsl:call-template name="standby-lc-details-header">
       	<xsl:with-param name="featureId"><xsl:value-of select="featureid"></xsl:value-of></xsl:with-param>
      </xsl:call-template>
      <!-- Narrative Details -->
      <xsl:call-template name="lc-narrative-details-new"/>
   
      <!-- Narrative Period -->
      <xsl:call-template name="lc-narrative-period-new"/>
      
      <!-- Narrative Charges -->
      <xsl:call-template name="si-narrative-charges-new"/>
      
      <xsl:call-template name="bank-instructions-header">
       <xsl:with-param name="send-mode-required">N</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
      <!-- <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
 -->
     </xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">downloadgteetext</xsl:with-param>
			<xsl:with-param name="parseFormOnLoad">Y</xsl:with-param>
			<xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
			<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/StandByLCTextPopup</xsl:with-param>
			<xsl:with-param name="override-displaymode">edit</xsl:with-param>
			<xsl:with-param name="content">
				<div class="widgetContainer">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">transactiondata</xsl:with-param>
					<xsl:with-param name="id">transactiondata_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">featureid</xsl:with-param>
					<xsl:with-param name="id">featureid_download_project</xsl:with-param>
					<xsl:with-param name="value">PROJET</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">gteeName</xsl:with-param>
					<xsl:with-param name="id">gteeName_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">company</xsl:with-param>
					<xsl:with-param name="id">company_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">bank</xsl:with-param>
					<xsl:with-param name="id">bank_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">entity</xsl:with-param>
					<xsl:with-param name="id">entity_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">parentEntity</xsl:with-param>
					<xsl:with-param name="id">parentEntity_download_project</xsl:with-param>
				</xsl:call-template>
				</div>
			</xsl:with-param>
			
	</xsl:call-template>
    
    <!-- Form #11 : Attach Files -->  
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>

    <xsl:call-template name="realform"/>
    </div>
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->
  
  <!-- 
   Additional JS imports for this form can be 
   added here. 
  -->
   <xd:doc>
  	<xd:short>Import Javascript libraries.</xd:short>
  	<xd:detail>
	 Additional JS imports for this form can be 
  	 added here. 
  	</xd:detail>
  </xd:doc>
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.create_si</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
    <xsl:with-param name="override-help-access-key">SI_01</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- 
   Additional hidden fields for this form can be 
   added here. 
  -->
  <xsl:template name="hidden-fields">
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="override-product-code">lc</xsl:with-param>
   </xsl:call-template>
   <div class="widgetContainer">
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
       <xsl:with-param name="value">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </div>
  </xsl:template> 

 <!--
  General Details Fieldset
  -->
  <xd:doc>
  	<xd:short>General details.</xd:short>
  	<xd:detail>
		This template displays the general details fieldset of the transaction
  	</xd:detail>
  </xd:doc>
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
   <xsl:call-template name="disclaimer-new"/>
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
       			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="common-general-details-new">
			     <xsl:with-param name="path" select="/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>

			     <!-- LC Details. -->
			     <xsl:call-template name="lc-general-details-new">
			     <xsl:with-param name="path" select="/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    
    <!-- second Column -->
  
     <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="common-general-details-new">
			      <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"></xsl:with-param> 
			    
			     </xsl:call-template>
			      <!-- LC Details. -->
			     <xsl:call-template name="lc-general-details-new">
			     <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"></xsl:with-param>
			     </xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xd:doc>
  	<xd:short>Beneficiary details.</xd:short>
  	<xd:detail>
		This template displays the beneficiary details fieldset of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="beneficiary-details">
    <xsl:call-template name="fieldset-wrapper">
		      <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
		      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		      <xsl:with-param name="button-type"></xsl:with-param>
		      <xsl:with-param name="content">
		        <xsl:call-template name="column-container">
			       <xsl:with-param name="content">			 
			         <xsl:call-template name="column-wrapper">
			             <xsl:with-param name="content">
					       <xsl:call-template name="beneficiaryaddress">
		      					 <xsl:with-param name="path" select="/si_tnx_record"/> 		        	        
		      			 </xsl:call-template>
		                </xsl:with-param>
		            </xsl:call-template>
		       <xsl:call-template name="column-wrapper">
			        <xsl:with-param name="content">
					  <xsl:call-template name="beneficiaryaddress">
					       <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"/> 		        	        
					  </xsl:call-template>     
		            </xsl:with-param>
		       </xsl:call-template>
		       </xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template> 
   </xsl:template>
 
  <xd:doc>
  	<xd:short>Amount Details .</xd:short>
  	<xd:detail>
		This template displays the LC amount details fieldset of the transaction
  	</xd:detail>
  </xd:doc> 
  <xsl:template name="lc-amt-details-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
       			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="lc-amt-details-new">
			     	 <xsl:with-param name="show-revolving">N</xsl:with-param>
				     <xsl:with-param name="show-standby">N</xsl:with-param> 
				     <xsl:with-param name="path" select="/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
       </xsl:with-param>
    </xsl:call-template>
    
 
     <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="lc-amt-details-new">
			     	 <xsl:with-param name="show-revolving">N</xsl:with-param>
				     <xsl:with-param name="show-standby">N</xsl:with-param> 
				     <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xd:doc>
  	<xd:short>Renewal Details.</xd:short>
  	<xd:detail>
		This template displays the Renewal details fieldset of the transaction
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-renewal-details-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_RENEWAL_DETAILS_LABEL</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
       			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="lc-renewal-details-new">
			     <xsl:with-param name="path" select="/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
       </xsl:with-param>
    </xsl:call-template>
    
    <!-- second Column -->
     <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="lc-renewal-details-new">
			      <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"></xsl:with-param> 
			    
			     </xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
  <xd:doc>
  	<xd:short>Shipment Details.</xd:short>
  	<xd:detail>
		This template displays the shipment details fieldset of the transaction
  	</xd:detail>
  </xd:doc>
 <xsl:template name="lc-shipment-details-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
       			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="lc-shipment-details-new">
			     <xsl:with-param name="path" select="/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
       </xsl:with-param>
    </xsl:call-template>
    
    <!-- second Column -->
  
     <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="lc-shipment-details-new">
			      <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"></xsl:with-param> 
			    
			     </xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>

  <xsl:template name="standby-lc-details-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
       			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="standby-lc-details-new">
			     <xsl:with-param name="path" select="/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
       </xsl:with-param>
    </xsl:call-template>
    
    <!-- second Column -->
     <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="standby-lc-details-new">
			      <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"></xsl:with-param> 
			    
			     </xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xd:doc>
  	<xd:short>Bank instruction Details.</xd:short>
  	<xd:detail>
		This template displays the bank instruction details fieldset of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="bank-instructions-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
       			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="bank-instructions-new">
			     <xsl:with-param name="path" select="/si_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
       </xsl:with-param>
    </xsl:call-template>
    
    <!-- second Column -->
     <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="bank-instructions-new">
			      <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"></xsl:with-param> 
			    
			     </xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
<xsl:template name="common-general-details-new">
   <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
   <xsl:param name="cross-ref-summary-option"></xsl:param>
    <xsl:param name="path"></xsl:param>
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <!-- Don't display this in unsigned mode. -->
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">appl_date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>

   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="common:node-set($path)/ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <!-- Bank Reference -->
   <!-- Shown in consolidated view -->
   <xsl:if test="$displaymode='view' and common:node-set($path)/bo_ref_id!='' and (not(common:node-set($path)/tnx_id) or common:node-set($path)/tnx_type_code[.!='01'] or common:node-set($path)/preallocated_flag[.='Y'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/bo_ref_id" />
    </xsl:call-template>
   </xsl:if>
   
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="common:node-set($path)/cross_references">
     <xsl:apply-templates select="common:node-set($path)/cross_references" mode="display_table_tnx">
     	<xsl:with-param name="cross-ref-summary-option"><xsl:value-of select="$cross-ref-summary-option"/></xsl:with-param>
    </xsl:apply-templates>
   </xsl:if>
    
   <!-- Template ID. -->
   <xsl:if test="$show-template-id='Y'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="name">template_id</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/template_id"></xsl:with-param>
     <xsl:with-param name="size">15</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
	     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	     <xsl:with-param name="value" select ="common:node-set($path)/cust_ref_id"></xsl:with-param>
	     <xsl:with-param name="size">20</xsl:with-param>
	     <xsl:with-param name="maxsize">34</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/appl_date" />
	 <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="lc-general-details-new">
  <xsl:param name="path"></xsl:param>
   <xsl:if test="$displaymode='edit'">
    <div>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">iss_date</xsl:with-param>
     </xsl:call-template>
    </div>
   </xsl:if>
   <!-- Issue Date -->
   <!-- Displayed in consolidated view -->
   <xsl:if test="$displaymode='view' and (not(common:node-set($path)/tnx_id) or common:node-set($path)/tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/iss_date" />
    </xsl:call-template>
   </xsl:if>
   
   <!--  Expiry Date. --> 
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
    <xsl:with-param name="name">exp_date</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/exp_date" />
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="swift-validate">N</xsl:with-param>
    <xsl:with-param name="required">
     <xsl:choose>
      <xsl:when test="$product-code='LC' or $product-code='EL' or $product-code='SI'">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
      
   <!-- Expiry place. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
    <xsl:with-param name="name">expiry_place</xsl:with-param>
    <xsl:with-param name="value" select="common:node-set($path)/expiry_place" />
    <xsl:with-param name="required">
     <xsl:choose>
      <xsl:when test="$product-code='LC'">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="maxsize">29</xsl:with-param>
   </xsl:call-template>
      
   <!-- 
    Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
    Pass in a show-presentation parameter set to Y to display the presentation fields.
    
    If set to N, the template will instead insert a hidden field with the value 1.0
   -->
   <xsl:call-template name="eucp-details">
    <xsl:with-param name="show-eucp" select="$show-eucp"/>
   </xsl:call-template>
</xsl:template> 
  <xsl:template name="lc-amt-details-new">
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="show-form-lc">Y</xsl:param>
   <xsl:param name="show-variation-drawing">Y</xsl:param>
   <xsl:param name="show-bank-confirmation">N</xsl:param>
   <xsl:param name="show-outstanding-amt">Y</xsl:param>
   <xsl:param name="show-standby">Y</xsl:param>
   <xsl:param name="show-amt">Y</xsl:param>
   <xsl:param name="show-form-lc-irv">N</xsl:param>
   <xsl:param name="transferable">N</xsl:param>
    <xsl:param name="path"/>
   <xsl:if test="$show-form-lc-irv='Y'">
         	<xsl:call-template name="multioption-group">
     			<xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
        		<xsl:with-param name="content"> 
        		<xsl:if test="common:node-set($path)/irv_flag[.='Y']">
          		<xsl:call-template name="input-field">          		 	
           		 	<xsl:with-param name="name">irv_flag</xsl:with-param>
           		 	<xsl:with-param name="value">
           		 	<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')" />
           		 	</xsl:with-param>
           			<xsl:with-param name="readonly">Y</xsl:with-param>
            	</xsl:call-template>
            	</xsl:if>
		   		</xsl:with-param>
		   </xsl:call-template>
     	</xsl:if>
     <!-- Form of LC Checkboxes. -->
     <div id="lc-amt-details">

     <xsl:if test="$show-form-lc='Y'">
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
        <xsl:with-param name="content"> 
          <xsl:if test="common:node-set($path)/irv_flag[.='Y']">
           <xsl:call-template name="input-field">          		 	
           	  <xsl:with-param name="name">irv_flag</xsl:with-param>
           	  <xsl:with-param name="value">
           	  <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')" />
           	 </xsl:with-param>
           	<xsl:with-param name="readonly">Y</xsl:with-param>
       	   </xsl:call-template>
       	   </xsl:if>
          <xsl:choose>
           <xsl:when test="$transferable='Y'">
				<xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">ntrf_flag</xsl:with-param>  
    				<xsl:with-param name="value">
     					<xsl:choose>
      						<xsl:when test="common:node-set($path)/ntrf_flag[.='']">Y</xsl:when>
      						<xsl:otherwise>
      							<xsl:value-of select="common:node-set($path)/ntrf_flag"></xsl:value-of>
      						</xsl:otherwise>
     					</xsl:choose>
    				</xsl:with-param> 				
   		  		</xsl:call-template>
   		  		
   		  		 <xsl:if test="common:node-set($path)/ntrf_flag[.='Y']">
		           <xsl:call-template name="input-field">          		 	
		           	  <xsl:with-param name="name">irv_flag</xsl:with-param>
		           	  <xsl:with-param name="value">
		           	  <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')" />
		           	 </xsl:with-param>
		           	<xsl:with-param name="readonly">Y</xsl:with-param>
		       	   </xsl:call-template>
       	  		 </xsl:if>
           </xsl:when>
           <xsl:otherwise>
           	<xsl:choose>
           		<xsl:when test="$displaymode='view'">
					 <xsl:if test="common:node-set($path)/ntrf_flag[.='Y']">
		           <xsl:call-template name="input-field">          		 	
		           	  <xsl:with-param name="name">irv_flag</xsl:with-param>
		           	  <xsl:with-param name="value">
		           	  <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')" />
		           	 </xsl:with-param>
		           	<xsl:with-param name="readonly">Y</xsl:with-param>
		       	   </xsl:call-template>
       	  		 </xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="checkbox-field">
           				<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE</xsl:with-param>
           				<xsl:with-param name="name">ntrf_flag</xsl:with-param>
           				<xsl:with-param name="value" select="common:node-set($path)/ntrf_flag" />
           				<!-- <xsl:with-param name="checked">Y</xsl:with-param>-->
          			</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
           </xsl:otherwise>
           <!-- <xsl:otherwise>
          	<xsl:call-template name="checkbox-field">
           		<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE</xsl:with-param>
           		<xsl:with-param name="name">ntrf_flag</xsl:with-param>
           		<xsl:with-param name="checked">Y</xsl:with-param>
          	</xsl:call-template>
           </xsl:otherwise> -->
          </xsl:choose>

          <!-- Display the standby checkbox if this is an LC -->
        
        </xsl:with-param>
       </xsl:call-template>
   
       <!-- Confirmation Instructions Radio Buttons -->
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_INST_LABEL</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:apply-templates select="common:node-set($path)/cfm_inst_code"/>
        </xsl:with-param>
       </xsl:call-template>
      
      </xsl:if>

    <!--  
      <xsl:if test="$show-bank-confirmation='Y'">
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_FLAG_LABEL</xsl:with-param>
        <xsl:with-param name="content">
        <xsl:if test="common:node-set($path)/cfm_inst_code"
        <xsl:call-template name="input-field">
        
        </xsl:call-template>
         <xsl:call-template name="radio-field">
          <xsl:with-param name="label">XSL_YES</xsl:with-param>
          <xsl:with-param name="name">cfm_flag</xsl:with-param>
          <xsl:with-param name="id">cfm_flag_1</xsl:with-param>
          <xsl:with-param name="value">Y</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="radio-field">
          <xsl:with-param name="label">XSL_NO</xsl:with-param>
          <xsl:with-param name="name">cfm_flag</xsl:with-param>
          <xsl:with-param name="id">cfm_flag_2</xsl:with-param>
          <xsl:with-param name="value">N</xsl:with-param>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if> --> 
      
      <!-- LC Currency and Amount -->
      <xsl:if test="$show-amt='Y' or $displaymode='view'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/lc_cur_code"/>  <xsl:value-of select="common:node-set($path)/lc_amt"/></xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
      <!-- Can show outstanding amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-outstanding-amt='Y' or $displaymode='view'">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="value">
	      <xsl:if test="common:node-set($path)/lc_liab_amt[.!='']">	       
	         <xsl:value-of select="common:node-set($path)/lc_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="common:node-set($path)/lc_liab_amt"></xsl:value-of>
	      </xsl:if>
	    </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <!-- Variation in drawing. -->
      <xsl:if test="$show-variation-drawing='Y' and (common:node-set($path)/lc_type[.!='04'] or common:node-set($path)/tnx_type_code[.!='01'])">
       <xsl:call-template name="label-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="content">
         <!-- <div class="group-fields">  -->
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_PSTV</xsl:with-param>
           <xsl:with-param name="name">pstv_tol_pct</xsl:with-param>
           <xsl:with-param name="type">integer</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>        
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
           <xsl:with-param name="value">
             <xsl:value-of select="common:node-set($path)/pstv_tol_pct"></xsl:value-of>
           </xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_NEG</xsl:with-param>
           <xsl:with-param name="name">neg_tol_pct</xsl:with-param>
           <xsl:with-param name="type">integer</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
            <xsl:with-param name="value">
             <xsl:value-of select="common:node-set($path)/neg_tol_pct"></xsl:value-of>
           </xsl:with-param>
          </xsl:call-template>
         <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL</xsl:with-param>
           <xsl:with-param name="name">max_cr_desc_code</xsl:with-param>
           <xsl:with-param name="options">
            <xsl:choose>
             <xsl:when test="$displaymode='edit'">
                <option/>
	            <option value="3">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
	            </option>
             </xsl:when>
             <xsl:otherwise>
              <xsl:if test="common:node-set($path)/max_cr_desc_code[. = '3']"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/></xsl:if>
             </xsl:otherwise>
            </xsl:choose>
           </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
       
       	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_BG_ISS_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_BG_CORR_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/cfm_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/cfm_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
      
      <!--  
       <xsl:apply-templates select="common:node-set($path)/open_chrg_brn_by_code">
        <xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
        <xsl:with-param name="label">XSL_CHRGDETAILS_ISS_LABEL</xsl:with-param>
       </xsl:apply-templates>
       <xsl:apply-templates select="common:node-set($path)/corr_chrg_brn_by_code">
        <xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
        <xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
       </xsl:apply-templates>
       <xsl:apply-templates select="common:node-set($path)/cfm_chrg_brn_by_code">
        <xsl:with-param name="node-name">cfm_chrg_brn_by_code</xsl:with-param>
        <xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
       </xsl:apply-templates> -->
      </xsl:if>
     </div>
     
  </xsl:template>
 
  <xsl:template name="lc-renewal-details-new">
     <xsl:param name="path"></xsl:param>
     <!-- Don't show checkbox value in summary -->
     <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="checkbox-field">
       <xsl:with-param name="name">renew_flag</xsl:with-param>
       <xsl:with-param name="label">XSL_RENEWAL_ALLOWED</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">renew_on_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
        <xsl:with-param name="options">
      <xsl:if test="common:node-set($path)/renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_on_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/></xsl:if>
       </xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="name">renewal_calendar_date</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/renewal_calendar_date" />
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_RENEWAL_RENEW_FOR</xsl:with-param>
       <xsl:with-param name="name">renew_for_nb</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/renew_for_nb" />
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">renew_for_period</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
        <xsl:with-param name="options">
        <xsl:if test="common:node-set($path)/renew_for_period[. = 'D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'W']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'M']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:if>
      </xsl:with-param>
     </xsl:call-template>
    
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_RENEWAL_DAYS_NOTICE</xsl:with-param>
      <xsl:with-param name="name">advise_renewal_days_nb</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/advise_renewal_days_nb" />
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
    
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_renewal_nb</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_NUMBER_RENEWALS</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/rolling_renewal_nb" />
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_cancellation_days</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_CANCELLATION_NOTICE</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/rolling_cancellation_days" />
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>  
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">final_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_FINAL_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/final_expiry_date" />
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>   
     <xsl:call-template name="multioption-group">
      <xsl:with-param name="group-label">XSL_RENEWAL_AMOUNT</xsl:with-param>
      <xsl:with-param name="content">
       <!-- <div class="group-fields">  -->
        <xsl:call-template name="radio-field">
         <xsl:with-param name="label">XSL_RENEWAL_ORIGINAL_AMOUNT</xsl:with-param>
         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
         <xsl:with-param name="id">renew_amt_code_1</xsl:with-param>
         <xsl:with-param name="value">01</xsl:with-param>
         <xsl:with-param name="readonly">Y</xsl:with-param>
         <xsl:with-param name="checked"><xsl:if test="common:node-set($path)/renew_amt_code[. = '01']">Y</xsl:if></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="radio-field">
         <xsl:with-param name="label">XSL_RENEWAL_CURRENT_AMOUNT</xsl:with-param>
         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
         <xsl:with-param name="id">renew_amt_code_2</xsl:with-param>
         <xsl:with-param name="value">02</xsl:with-param>
         <xsl:with-param name="readonly">Y</xsl:with-param>
         <xsl:with-param name="checked"><xsl:if test="common:node-set($path)/renew_amt_code[. = '02'] or common:node-set($path)/renew_amt_code[. = '']">Y</xsl:if></xsl:with-param>
        </xsl:call-template>
       <!-- </div>  -->
      </xsl:with-param>
     </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="lc-payment-details-header">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Credit Available With -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
      <xsl:call-template name="column-container">
       <xsl:with-param name="content">
       			 
         <xsl:call-template name="column-wrapper">
	       <xsl:with-param name="content">
	       <xsl:apply-templates select="credit_available_with_bank" mode="select"/>
	       <xsl:call-template name="credit-available-by-new">
	       <xsl:with-param name="path">si_tnx_record</xsl:with-param> 
	       </xsl:call-template>
	       </xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
       <xsl:apply-templates select="original_xml/si_tnx_record/credit_available_with_bank" mode="select"/>
       <xsl:call-template name="credit-available-by-new">
       <xsl:with-param name="path">/si_tnx_record/original_xml/si_tnx_record</xsl:with-param> 
       </xsl:call-template>
       </xsl:with-param>
       </xsl:call-template>
       </xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="credit-available-by-new">
   <xsl:param name="show-drawee">Y</xsl:param>
  <xsl:param name="path"></xsl:param>
   <!-- Credit Available By radio buttons. -->
   <xsl:apply-templates select="common:node-set($path)/cr_avl_by_code">
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL</xsl:with-param>
   </xsl:apply-templates>

   <!--
    Payment/Draft At fields.
    
    Hidden fields, that depend on the radio button selected in Credit Available By.
   -->
   <div id="payment-draft">
   
     <div class="field">
     	<xsl:if test="$displaymode='view' and common:node-set($path)/cr_avl_by_code[.='05']">
	    	<xsl:attribute name="style">display:none</xsl:attribute>
	   	</xsl:if>
      <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')"/></span>
      <div class="content">
       <xsl:value-of select="common:node-set($path)/draft_term"/>
      </div>
     </div>
  
   <xsl:if test="$show-drawee='Y'">    
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
       <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="common:node-set($path)/drawee_details_bank">
         <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="show-button">N</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>     
   </xsl:if>
   </div>

  <!-- 
    Hidden by default in edit mode, or in view mode when
    cr_avl_by_code is not a mixed payment. 
  -->
  <div id="draft-term">
   <xsl:if test="$displaymode='edit' or ($displaymode='view' and common:node-set($path)/cr_avl_by_code[.!='05'])">
    <xsl:attribute name="style">display:none</xsl:attribute>
   </xsl:if>
   <xsl:call-template name="row-wrapper">
    <xsl:with-param name="id">draft_term</xsl:with-param>
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED_DETAILS</xsl:with-param>
    <xsl:with-param name="type">textarea</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">draft_term</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </div>
  </xsl:template>
<!--   <xsl:template name="lc-payment-draft-fields-new">
   <xsl:param name="show-drawee"/>
   <xsl:param name="path"/>
   
   <div id="payment-draft">
   
     <div class="field">
     	<xsl:if test="$displaymode='view' and common:node-set($path)/cr_avl_by_code[.='05']">
	    	<xsl:attribute name="style">display:none</xsl:attribute>
	   	</xsl:if>
      <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')"/></span>
      <div class="content">
       <xsl:value-of select="common:node-set($path)/draft_term"/>
      </div>
     </div>
  
   <xsl:if test="$show-drawee='Y'">    
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
       <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="common:node-set($path)/drawee_details_bank">
         <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="show-button">N</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>     
   </xsl:if>
   </div>
  </xsl:template> -->
  
  <xsl:template name="standby-lc-details-new">
  	<xsl:param name="featureId"/>
  	<xsl:param name="isBank"/>
  	<xsl:param name="isAmend">N</xsl:param>
  	<xsl:param name="path"></xsl:param>
	    		<xsl:if test="common:node-set($path)/product_type_code[.!='']">
				<xsl:variable name="sblc_type_code"><xsl:value-of select="common:node-set($path)/product_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="common:node-set($path)/product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="common:node-set($path)/sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C010</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
					 	<xsl:with-param name="name">product_type_code</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $sblc_type_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$isBank!='Y'">
				    <div id="pro-check-box">
						 <xsl:call-template name="checkbox-field">
							 <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
							 <xsl:with-param name="name">provisional_status</xsl:with-param>
							 <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/provisional_status"></xsl:value-of></xsl:with-param>
							 <xsl:with-param name="override-displaymode">view</xsl:with-param>
						 </xsl:call-template>
					 </div>
				 </xsl:if>
				<xsl:if test="common:node-set($path)/product_type_details[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label"></xsl:with-param>
					 	<xsl:with-param name="name">product_type_details</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/product_type_details"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="common:node-set($path)/stand_by_lc_code[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_SBLC_NAME</xsl:with-param>
					 	<xsl:with-param name="name">stand_by_lc_code</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/stand_by_lc_code"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="common:node-set($path)/standby_rule_code[.!='']">
					<xsl:variable name="sblc_rule_code"><xsl:value-of select="common:node-set($path)/standby_rule_code"/></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="common:node-set($path)/product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="common:node-set($path)/sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C012</xsl:variable>
					<xsl:call-template name="input-field">
			    		<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">standby_rule_code</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $sblc_rule_code)"/></xsl:with-param>
			    		<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
  </xsl:template>
  
  <xd:doc>
  	<xd:short>Narrative Details.</xd:short>
  	<xd:detail>
		This template displays the narrative details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-narrative-details-new">
   <xsl:param name="documents-required-required">N</xsl:param>
   <xsl:param name="in-fieldset">Y</xsl:param>
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-label">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
    
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
        <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
		      <xsl:with-param name="value" select="narrative_description_goods/text"></xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		      <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
		      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_description_goods/text"></xsl:with-param>
		      
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
	   </xsl:call-template>
     
    </xsl:with-param>
     
    <!-- Tab 1 - Documents Required  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
    <xsl:with-param name="tab1-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_documents_required</xsl:with-param>
		      <xsl:with-param name="value" select="narrative_documents_required/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		      <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
		      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_documents_required/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
      
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab2-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
		       <xsl:with-param name="value" select="narrative_additional_instructions/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		      <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
		      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_additional_instructions/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    
     <xsl:with-param name="additional-content">
     <xsl:if test="$displaymode='view'">
      <xsl:if test="narrative_charges[.!= ''] or original_xml/si_tnx_record/narrative_charges[.!= '']">
       <div class="indented-header">
        <h3 class="toc-item">
         <span class="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_CHARGES')"/></span>
        </h3>
         <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_charges</xsl:with-param>
		      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_charges/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		      <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
		      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_charges/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
       </div>
      </xsl:if>
      <xsl:if test="narrative_sender_to_receiver[.!= ''] or original_xml/si_tnx_record/narrative_sender_to_receiver[.!= '']">
       <div class="indented-header">
        <h3 class="toc-item">
         <span class="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER')"/></span>
        </h3>
        <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
		       <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_sender_to_receiver/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		      <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
		      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_sender_to_receiver/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
       </div>
      </xsl:if>
      <xsl:if test="narrative_payment_instructions[.!= ''] or original_xml/si_tnx_record/narrative_payment_instructions[.!= '']">
       <div class="indented-header">
        <h3 class="toc-item">
         <span class="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/></span>
        </h3>
       <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
		       <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_payment_instructions/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		      <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
    		 <xsl:call-template name="input-field">
		      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
		      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_payment_instructions/text"></xsl:with-param>
		      <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
       </div>
      </xsl:if>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xd:doc>
  	<xd:short>Bank Details.</xd:short>
  	<xd:detail>
		This template displays the bank details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-bank-details-new">
   <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">250px</xsl:with-param>

    <!-- Tab 0_0 - Issuing Bank  -->
    <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
    <xsl:with-param name="tab0-content">
       <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
	      <xsl:call-template name="main-bank-selectbox-new">
	      <xsl:with-param name="path" select="/si_tnx_record"/> 
	    <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="customer-reference-selectbox-new">
	    <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   </xsl:with-param>
	   </xsl:call-template>
	   
	   <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
	      <xsl:call-template name="main-bank-selectbox-new">
	      <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"/>
	   <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="customer-reference-selectbox-new">
	    <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   </xsl:with-param>
	   </xsl:call-template>
	   </xsl:with-param>
	   </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 0_1 - Advising Bank -->
    <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
    <xsl:with-param name="tab1-content">
        <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
		       <xsl:apply-templates select="advising_bank">
		        <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
		       </xsl:apply-templates>
		       </xsl:with-param>
		       </xsl:call-template>
		       
       <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
       <xsl:apply-templates select="original_xml/si_tnx_record/advising_bank">
        <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
       </xsl:apply-templates>
       </xsl:with-param>
       </xsl:call-template>
       
       </xsl:with-param>
       </xsl:call-template>
       
    </xsl:with-param>
     
    <!-- Tab 0_2 - Advise Thru Bank -->
    <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
    <xsl:with-param name="tab2-content">
       <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
       <xsl:apply-templates select="advise_thru_bank">
        <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
       </xsl:apply-templates>
       </xsl:with-param>
       </xsl:call-template>
       
        <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
       <xsl:apply-templates select="original_xml/si_tnx_record/advise_thru_bank">
        <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
       </xsl:apply-templates>
       </xsl:with-param>
       </xsl:call-template>
       </xsl:with-param>
       </xsl:call-template>
       
    </xsl:with-param>
   </xsl:call-template>
   
  </xsl:template>
  
  
    <xsl:template name="main-bank-selectbox-new">
   <xsl:param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:param>
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>   
    <xsl:param name="path"></xsl:param>
 
   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="common:node-set($path)/recipient_bank/abbv_name"/>
   </xsl:variable>
    
   <xsl:variable name="main-bank-name-value">
    <xsl:if test="common:node-set($path)/recipient_bank/name">
     <xsl:value-of select="common:node-set($path)/recipient_bank/name"/>
    </xsl:if>
   </xsl:variable>
  
   <xsl:variable name="sender-reference-value" select="common:node-set($path)/applicant_reference"/>
  
   <!-- Hidden Fields -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_name</xsl:with-param>
    <xsl:with-param name="value">
     <xsl:choose>
      <xsl:when test="$main-bank-name-value != ''">
       <xsl:value-of select="$main-bank-name-value"/>
      </xsl:when>
      <!-- never used because if only one available main bank, server set it to current main bank -->
      <xsl:when test="count(common:node-set($path)/avail_main_banks/bank)=1"><xsl:value-of select="common:node-set($path)/avail_main_banks/bank/name"/></xsl:when>
      <xsl:otherwise/>
      </xsl:choose>
     </xsl:with-param>
   </xsl:call-template>

  
   <xsl:call-template name="select-field">
    <xsl:with-param name="label" select="$label"/>
    <xsl:with-param name="name"><xsl:value-of select="common:node-set($path)/recipient_bank_abbv_name"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="$main_bank_abbv_name_value"/></xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="disabled"><xsl:if test="bg_code[.!='']">Y</xsl:if></xsl:with-param>
    <xsl:with-param name="options">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'"><xsl:apply-templates select="avail_main_banks/bank" mode="main"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="common:node-set($path)/recipient_bank/name"/></xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
   <xsl:if test="$displaymode='view'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">remitting_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/remitting_bank/abbv_name"/></xsl:with-param>
     </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  
   <!--
   Customer Reference Select Box.
   -->
  <xsl:template name="customer-reference-selectbox-new">
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>
   <xsl:param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:param>
   <xsl:param name="path"></xsl:param>
   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="common:node-set($path)/recipient_bank/abbv_name"/>
   </xsl:variable>
 
   <xsl:variable name="sender-reference-value">
    <xsl:choose>
     <!-- current customer reference not null (draft) -->
     <xsl:when test="common:node-set($path)/applicant_reference != ''">
       <xsl:value-of select="common:node-set($path)/applicant_reference"/>
     </xsl:when>
     <!-- not entity defined and only one bank and only one customer reference available -->
     <xsl:when test="entities[.= '0']">
       <xsl:if test="count(common:node-set($path)/avail_main_banks/bank/customer_reference)=1">
         <xsl:value-of select="common:node-set($path)/avail_main_banks/bank/customer_reference/reference"/>
       </xsl:if>
     </xsl:when>
     <!-- only one entity, only one bank and only one customer reference available -->
     <xsl:otherwise>
       <xsl:if test="count(common:node-set($path)/avail_main_banks/bank/entity/customer_reference)=1">
         <xsl:value-of select="common:node-set($path)/avail_main_banks/bank/entity/customer_reference/reference"/>
       </xsl:if>          
     </xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   
   <!-- Check if customer references are defined for entities or not -->
   <xsl:if test="common:node-set($path)/avail_main_banks/bank/entity/customer_reference or common:node-set($path)/avail_main_banks/bank/customer_reference">
    <!-- Hidden Fields -->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$sender-reference-name"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
    </xsl:call-template>
  
    <xsl:choose>
    <xsl:when test="$displaymode='edit'">
        <xsl:call-template name="select-field">
     <xsl:with-param name="label" select="$label"/>
     <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_customer_reference</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
	      <xsl:choose>
	      <!-- if not entity defined -->         
	      <xsl:when test="entities[.= '0']">
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:when>
	      <!-- else -->  
	      <xsl:otherwise>
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:otherwise>
	     </xsl:choose>
       </xsl:when>
       <xsl:otherwise>
	     <xsl:choose>
		     <xsl:when test="count(common:node-set($path)/avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]) >= 1">
		      	<xsl:value-of select="common:node-set($path)/avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]/description"/>
		     </xsl:when>
		     <xsl:otherwise>
		     	<xsl:value-of select="common:node-set($path)/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference/description"/>
		     </xsl:otherwise>
	     </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
   	  <xsl:call-template name="input-field">
   	   	 <xsl:with-param name="label" select="$label"/>
    	 <xsl:with-param name="name"><xsl:value-of select="common:node-set($path)/recipient_bank_customer_reference"/></xsl:with-param>
    	 <xsl:with-param name="value"> <xsl:value-of select="utils:decryptApplicantReference($sender-reference-value)"/></xsl:with-param>
   </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
  </xsl:if>
 </xsl:template>
 
 
 <xsl:template name="disclaimer-new">
   <xsl:if test="$displaymode='view'">
    <div class="disclaimer">
     <!-- <h2><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTING_DISCLAIMER_LABEL')"/></h2> -->
     <h2><xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATED_DISCLAIMER')"/></h2>
    </div>
   </xsl:if>
  </xsl:template>
  
   <xsl:template name="lc-narrative-period-new">
	<xsl:param name="in-fieldset">Y</xsl:param>
   <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-period-tabcontainer</xsl:with-param>
    
    <!-- Tab 0 - Period Presentation  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
       <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
						 <xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_period_presentation/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_period_presentation/text"></xsl:with-param>
						<xsl:with-param name="rows">4</xsl:with-param>
		      <xsl:with-param name="cols">35</xsl:with-param>
		      <xsl:with-param name="maxlines">4</xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
		</xsl:call-template>
    </xsl:with-param>
    
    <!-- Tab 1 - Shipment Period  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD</xsl:with-param>
    <xsl:with-param name="tab1-content">
     	<xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
					     <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_shipment_period/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
				     <xsl:with-param name="content"> 
					     <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_shipment_period/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     	</xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Amount  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT</xsl:with-param>
    <xsl:with-param name="tab2-content">
	      <xsl:call-template name="column-container">
		      <xsl:with-param name="content">			 
			      <xsl:call-template name="column-wrapper">
				      <xsl:with-param name="content"> 
					      <xsl:call-template name="textarea-field">
						      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
						      <xsl:with-param name="value" select="narrative_additional_amount/text"></xsl:with-param>
						      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
					      </xsl:call-template>
				      </xsl:with-param>
			      </xsl:call-template>
			      <xsl:call-template name="column-wrapper">
				      <xsl:with-param name="content"> 
					      <xsl:call-template name="input-field">
						      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
						      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_additional_amount/text"></xsl:with-param>
					      </xsl:call-template>
					      <xsl:call-template name="input-field">
      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
      <xsl:with-param name="value" select="original_xml/bg_tnx_record/narrative_additional_amount"></xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
     </xsl:call-template>
				      </xsl:with-param>
			      </xsl:call-template>
	      	  </xsl:with-param>
	      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="bank-instructions-new">
  <xsl:param name="send-mode-required">Y</xsl:param>
  <xsl:param name="send-mode-displayed">Y</xsl:param>
  <xsl:param name="send-mode-label">XSL_INSTRUCTIONS_LC_ADV_SEND_MODE_LABEL</xsl:param>
  <xsl:param name="forward-contract-shown">N</xsl:param>
  <xsl:param name="principal-acc-displayed">Y</xsl:param>
  <xsl:param name="fee-acc-displayed">Y</xsl:param>
  <xsl:param name="delivery-to-shown">N</xsl:param>
  <xsl:param name="delivery-channel-displayed">N</xsl:param>
  <xsl:param name="free-format-text-displayed">Y</xsl:param>
  <xsl:param name="path"/>
  
  <xsl:choose>
    <xsl:when test="$mode = 'DRAFT' and $displaymode='view'">
     <!-- Don't show the file details for the draft view mode, but do in all other cases -->
     
    </xsl:when>

    <xsl:otherwise>
     <xsl:if test="$send-mode-displayed='Y'">
      <xsl:call-template name="select-field">
       <xsl:with-param name="label" select="$send-mode-label"/>
       <xsl:with-param name="name">adv_send_mode</xsl:with-param>
       <xsl:with-param name="required"><xsl:value-of select="$send-mode-required"/></xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="options">
       <xsl:if test="common:node-set($path)/adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:if>
      <xsl:if test="common:node-set($path)/adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:if>
      <xsl:if test="common:node-set($path)/adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:if>
      <xsl:if test="common:node-set($path)/adv_send_mode[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/></xsl:if>
      </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    <xsl:if test="$delivery-channel-displayed='Y'">
	<xsl:call-template name="select-field">
		<xsl:with-param name="label">XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL</xsl:with-param>
		<xsl:with-param name="name">delivery_channel</xsl:with-param>
		<xsl:with-param name="fieldsize">small</xsl:with-param>
	 	<xsl:with-param name="value">
	 	<xsl:value-of select="localization:getDecode($language, 'N802', common:node-set($path)/delivery_channel)"/>
	 	</xsl:with-param> 			
	</xsl:call-template>
	</xsl:if>           
     <xsl:if test="$principal-acc-displayed='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="button-type">account</xsl:with-param>
       <xsl:with-param name="type">account</xsl:with-param>
       <xsl:with-param name="name">principal_act_no</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/principal_act_no"/></xsl:with-param> 
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$fee-acc-displayed='Y'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
      <xsl:with-param name="button-type">account</xsl:with-param>
      <xsl:with-param name="type">account</xsl:with-param>
      <xsl:with-param name="name">fee_act_no</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/fee_act_no"/></xsl:with-param> 
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="size">34</xsl:with-param>
      <xsl:with-param name="maxsize">34</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$forward-contract-shown='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/fwd_contract_no"/></xsl:with-param>
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$delivery-to-shown='Y'">
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_DELIVERY_TO_LABEL</xsl:with-param>
	      <xsl:with-param name="name">delivery_to</xsl:with-param>
	       <xsl:with-param name="options">
	      <xsl:if test="common:node-set($path)/delivery_to[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OURSELVES')"/></xsl:if>
      <xsl:if test="common:node-set($path)/delivery_to[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_PARTY')"/></xsl:if>
      <xsl:if test="common:node-set($path)/delivery_to[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_BENEFICIARY')"/></xsl:if>
      <xsl:if test="common:node-set($path)/delivery_to[. = '04']">
      	<xsl:call-template name="row-wrapper">
      	<xsl:with-param name="id">delivery_to_other</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:call-template name="input-field">
	        <xsl:with-param name="name">delivery_to_other</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/delivery_to_other"/></xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
	  </xsl:with-param> 
	     </xsl:call-template>
	  </xsl:if>
     
     <xsl:if test="$free-format-text-displayed='Y'">
     <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
      <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">free_format_text</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/free_format_text"/></xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="rows">13</xsl:with-param>
        <xsl:with-param name="cols">60</xsl:with-param>
        <xsl:with-param name="maxlines">100</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:template>
  
  
    <!-- Applicant Details -->
    <xsl:template name="applicant-details">
			     <xsl:call-template name="fieldset-wrapper">
			      <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
			      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
			      <xsl:with-param name="content">
			       <xsl:call-template name="column-container">
                     <xsl:with-param name="content">
                     <!-- First column -->			 
                     <xsl:call-template name="column-wrapper">
                          <xsl:with-param name="content">
						        <xsl:call-template name="applicantaddress">
						          <xsl:with-param name="path" select="/si_tnx_record"/> 
						        </xsl:call-template>
				       </xsl:with-param>
				      </xsl:call-template>
				       <!-- second column -->
				       <xsl:call-template name="column-wrapper">
                          <xsl:with-param name="content">                         
						       <xsl:call-template name="applicantaddress">
						       <xsl:with-param name="path" select="/si_tnx_record/original_xml/si_tnx_record"/> 
					    </xsl:call-template>			      
				       </xsl:with-param>
				     </xsl:call-template>
				   </xsl:with-param>
				</xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template>
   </xsl:template>
   
   <!-- This template displays the charges/payment instruction/other details section of the transaction -->
   <xd:doc>
  	<xd:short>Charges/Payment details.</xd:short>
  	<xd:detail>
		This template displays the charges/payment instruction/other details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="si-narrative-charges-new">
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_CHARGES</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
        <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
             <xsl:call-template name="column-wrapper">
	             <xsl:with-param name="content"> 
		    		 <xsl:call-template name="input-field">
				      <xsl:with-param name="name">narrative_charges</xsl:with-param>
				      <xsl:with-param name="value" select="narrative_charges/text"></xsl:with-param>
				     </xsl:call-template>
			     </xsl:with-param>
		     </xsl:call-template>
		     <xsl:call-template name="column-wrapper">
	             <xsl:with-param name="content"> 
		    		 <xsl:call-template name="input-field">
				      <xsl:with-param name="name">narrative_charges</xsl:with-param>
				      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_charges/text"></xsl:with-param>
				     </xsl:call-template>
			     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
	   </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 1 - Documents Required  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER</xsl:with-param>
    <xsl:with-param name="tab1-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_sender_to_receiver/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_sender_to_receiver/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab2-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_payment_instructions/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/si_tnx_record/narrative_payment_instructions/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>
   </xsl:template>
   
 <!--
  SI Realform.
  -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
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
      <xsl:with-param name="value">01</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">attIds</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">TransactionData</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="reauth_params"/>   
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
<!--  -->  
<!-- END LOCAL TEMPLATES FOR THIS FORM -->
<!--  -->

</xsl:stylesheet>