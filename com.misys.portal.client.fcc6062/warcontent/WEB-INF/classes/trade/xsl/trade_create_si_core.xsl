<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Issued Standby LC (SI) Form, Customer Side.
 
 Note: Templates beginning with lc_ are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->

 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS.
   For the trade summary, some of these are empty.
  -->
 
	<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>	
<xsl:stylesheet 
  version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
   	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender converttools localization securitycheck utils defaultresource security">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SI</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/StandbyIssuedScreen</xsl:param>
  <xsl:param name="featureid"></xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" /> 
  <xsl:include href="../../core/xsl/common/lc_common.xsl" /> 
   <xsl:include href="../../core/xsl/common/static_document_upload_templates.xsl" />
   <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />  
   
   
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
       <xsl:call-template name="build-inco-terms-data"/>
     <!-- Bank Message -->
       <!--  <xsl:if test="tnx_stat_code[.='04'] or security:isBank($rundata)"> -->
      <xsl:if test="prod_stat_code[.!='03'] and tnxtype[.!='01']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">
       		<xsl:choose>
				<xsl:when test="product_code[.='PO' or .='SO' or .='IN']">XSL_HEADER_SELLER_BANK_MESSAGE</xsl:when>
				<xsl:otherwise>XSL_HEADER_BANK_MESSAGE</xsl:otherwise>
			</xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_DTTM</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata)"/>
           </div></xsl:with-param> 
          </xsl:call-template>

          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
           <xsl:choose>
				<xsl:when test="(product_code[.='LN'] or product_code[.='BK'] and sub_product_code[.='LNRPN']) and  prod_stat_code='01' and tnx_stat_code='04' and (sub_tnx_stat_code='05' or sub_tnx_stat_code='' or sub_tnx_stat_code='17'   ) ">
				    <xsl:value-of select="localization:getGTPString($language, 'STATUS_CODE_LOAN_CANCELLED')" />
                </xsl:when>
				<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/></xsl:otherwise>
			</xsl:choose>           </div></xsl:with-param>
          </xsl:call-template>
          
          <xsl:if test="product_code[.='SE'] and sub_product_code[.='COCQS']">
          	<xsl:call-template name="big-textarea-wrapper">
	         <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
	         <xsl:with-param name="content"><div class="content">
	           <xsl:value-of select="free_format_text"/>
	         </div></xsl:with-param>
	        </xsl:call-template>
	      </xsl:if>  
          
          <xsl:if test="product_code[.='BG' or .='SI'] and request_date != '' and prod_stat_code = '86'">
          <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">EXTEND_PAY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="request_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
		  </xsl:if>
		  
		  <!-- Back-Office Reference -->
		   <xsl:if test="bo_ref_id!=''">
	          <xsl:call-template name="row-wrapper">
	           <xsl:with-param name="label">
				<xsl:choose>
					<xsl:when test="product_code[.='LN']">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:when>
					<xsl:otherwise>XSL_GENERALDETAILS_BO_REF_ID</xsl:otherwise>
				</xsl:choose>
	           </xsl:with-param>
	           <xsl:with-param name="content"><div class="content" style="white-space:pre;">
	          	<xsl:value-of select="bo_ref_id"/>
	           </div>
	           </xsl:with-param>
	          </xsl:call-template>
	        </xsl:if>
		  		
          <!-- Back-Office comment -->
          <xsl:if test="bo_comment!=''">
	         <xsl:choose>
          		<xsl:when test = "(prod_stat_code[.='01'] and sub_tnx_stat_code[.='20']) and (product_code[.='LN'] or (product_code[.='BK'] and sub_product_code[.='LNRPN']))">
          			<xsl:call-template name="input-field">
			           <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
			           <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'LN_BUSINESS_VALIDATION_ERROR')"/>
			           </xsl:with-param>
	          		</xsl:call-template>
          		</xsl:when>
          		<xsl:otherwise>
          			<xsl:call-template name="big-textarea-wrapper">
			           <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
			           <xsl:with-param name="content">
			           <xsl:choose>
			           	<xsl:when test="$displaymode='view'">
			           		<div class="content">
             					<xsl:value-of select="bo_comment"/>
             				</div>
			           	</xsl:when>
			           	<xsl:otherwise>
			           		<div class="content">
					            <xsl:call-template name="textarea-field">
							         <xsl:with-param name="name">bo_comment</xsl:with-param>
							         <xsl:with-param name="rows">13</xsl:with-param>
							         <xsl:with-param name="cols">75</xsl:with-param>
							         <xsl:with-param name="maxlines">500</xsl:with-param>
							         <xsl:with-param name="swift-validate">N</xsl:with-param>
						        </xsl:call-template>
				           </div>
			           	</xsl:otherwise>
			           </xsl:choose>
			           </xsl:with-param>
		          	</xsl:call-template>
          		</xsl:otherwise>
          	</xsl:choose>
	      </xsl:if>
	      
	      <xsl:if test="tnx_type_code[.!='24']">
	      <xsl:if test="product_code[.='BG' or .='SI' or .='LC']">
	      <xsl:if test="claim_reference!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_reference"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="linked_event_reference!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_LINKED_EVENT_REFERENCE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="linked_event_reference"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="claim_present_date!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_present_date"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="claim_amt!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_AMOUNT_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_cur_code"/>&nbsp;<xsl:value-of select="claim_amt"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      </xsl:if>
  		 
          <xsl:if test="action_req_code[.!='']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="localization:getDecode($language, 'N042', action_req_code)"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
         </xsl:if>
           
           <xsl:if test="attachments/attachment[type = '02']">
	           <xsl:call-template name="attachments-file-dojo">
	            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
	            <xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
	            <xsl:with-param name="attachment-group">summarybank</xsl:with-param>
	           </xsl:call-template>
           </xsl:if>
            <xsl:if test="attachments/attachment[type = '07']"> 
	           <xsl:call-template name="attachments-file-dojo">
	            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '07']"/>
	            <xsl:with-param name="legend">XSL_HEADER_AUTO_GENERATED_FILES</xsl:with-param>
	            <xsl:with-param name="attachment-group">optional</xsl:with-param>
	           </xsl:call-template>
	         </xsl:if>
	          <xsl:if test="defaultresource:getResource('SHOW_UPLOADED_SWIFT_FILES') = 'true'">
	         <xsl:if test="attachments/attachment[type = '08']"> 
	           <xsl:call-template name="attachments-file-dojo">
	            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '08']"/>
	            <xsl:with-param name="legend">XSL_HEADER_UPLOADED_SWIFT_FILES</xsl:with-param>
	            <xsl:with-param name="attachment-group">other</xsl:with-param>
	           </xsl:call-template>
	         </xsl:if>
	         </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     
      <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/> 

      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details" />
      
      <xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      		<xsl:call-template name="lc-amt-details-swift2018">
	      			<xsl:with-param name="show-standby">N</xsl:with-param>
	      			<xsl:with-param name="show-amt">
		      			<xsl:choose>
		      				<xsl:when test="lc_amt[.!='']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
	      			</xsl:with-param>
       				<xsl:with-param name="override-product-code">lc</xsl:with-param>
	      		</xsl:call-template>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:call-template name="lc-amt-details">
       				<xsl:with-param name="show-standby">N</xsl:with-param>
       				<xsl:with-param name="override-product-code">lc</xsl:with-param>
     			 </xsl:call-template>
	      	</xsl:otherwise>
	   </xsl:choose>  
      
      <xsl:call-template name="lc-renewal-details"/>
          <!-- Bank details -->
   		<xsl:choose>
	      	<xsl:when test="$swift2018Enabled"><xsl:call-template name="lc-bank-details-swift2018"/></xsl:when>
	      	<xsl:otherwise><xsl:call-template name="lc-bank-details"/></xsl:otherwise>
	    </xsl:choose>    
	    
      <xsl:call-template name="lc-payment-details"/>
      <xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      		<xsl:call-template name="lc-shipment-details-swift2018"/>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:call-template name="lc-shipment-details"/>
	      	</xsl:otherwise>
	   </xsl:choose>    		
      
  
      <xsl:if test="$displaymode='edit'">
         <script>
         	dojo.ready(function(){
         		misys._config = misys._config || {};
				misys._config.provisionalProductTypes = {};
				<xsl:apply-templates select="provisional_flag/provisional"/>
			});
		</script>
      </xsl:if>
      <!-- Standby LC details -->
      <xsl:call-template name="standby-lc-details">
       	<xsl:with-param name="featureId"><xsl:value-of select="featureid"></xsl:value-of></xsl:with-param>
      </xsl:call-template>
      <!-- Narrative Details -->
       <xsl:if test="($displaymode = 'view' and (not($swift2018Enabled))) or ($displaymode = 'edit')">
      <xsl:call-template name="lc-narrative-details">
			<xsl:with-param name="documents-required-required">
				<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'true'">
					<xsl:value-of select="'Y'"/>
				</xsl:if>
				<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'false'">
					<xsl:value-of select="'N'"/>
				</xsl:if>	
			</xsl:with-param>
			<xsl:with-param name="description-goods-required">
				<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'true'">
					<xsl:value-of select="'Y'"/>
				</xsl:if>
				<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'false'">
					<xsl:value-of select="'N'"/>
				</xsl:if>	
			</xsl:with-param>
		</xsl:call-template>
   	  </xsl:if>
   	  

   	   <xsl:if test= "$swift2018Enabled  and $displaymode = 'edit'">
      		 <xsl:call-template name="tabgroup-wrapper">
			   <xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
			    <xsl:with-param name="in-fieldset">Y</xsl:with-param>
			    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
			    <xsl:with-param name="tab0-content">
			     <xsl:call-template name="textarea-field">
			      <xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
			      <xsl:with-param name="maxlines">
					<xsl:choose>
			   			<xsl:when test="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
			   			<xsl:otherwise>100</xsl:otherwise>
					</xsl:choose>
				  </xsl:with-param>
			      <xsl:with-param name="button-type-ext-view">
				  	<xsl:choose>
						<xsl:when test="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
				  		<xsl:otherwise/>
				  	</xsl:choose>
				  </xsl:with-param>
			      <xsl:with-param name="messageValue">
		   			<xsl:choose>
			   			<xsl:when test="$swift2018Enabled"><xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/></xsl:when>
		   				<xsl:otherwise><xsl:value-of select="narrative_special_beneficiary"/></xsl:otherwise>
		   			</xsl:choose>
		   		 </xsl:with-param>
			     </xsl:call-template>
			    </xsl:with-param>
			   </xsl:call-template>
         </xsl:if>
        
   	   <xsl:if test="$displaymode = 'view' and $swift2018Enabled">
   	   <xsl:call-template name="fieldset-wrapper">
   	    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
   	   <xsl:call-template name = "previewModeExtendedNarrative"/>
   	   </xsl:with-param>
   	   </xsl:call-template>
   	   </xsl:if>
      <!-- Narrative Period -->
       <xsl:choose>
	      	<xsl:when test = "$swift2018Enabled">
	      		 <xsl:call-template name="lc-narrative-period-swift2018"></xsl:call-template>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		 <xsl:call-template name="lc-narrative-period"></xsl:call-template>
	      	</xsl:otherwise>
	      </xsl:choose>	

	        <xsl:call-template name="fieldset-wrapper">
	      <xsl:with-param name="legend">XSL_LEGACY_DETAILS_LABEL</xsl:with-param>
	      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	      <xsl:with-param name="content">
	       <!-- <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE'] or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> -->
	       		<xsl:call-template name="legacy-template"/>
	       <!-- </xsl:if> -->
	      </xsl:with-param>
	     </xsl:call-template>


      <xsl:if test="$displaymode = 'view'">
     	<xsl:if test="narrative_payment_instructions[.!= '']">
 			       <div class="indented-header">
 				        <h3 class="toc-item">
 				         <span class="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/></span>
 				        </h3>
 				        <xsl:call-template name="textarea-field">
 				         <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
 				        </xsl:call-template>
 			       		</div>
 				</xsl:if>
      </xsl:if>
      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-required">N</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="$displaymode = 'view' and narrative_full_details != ''">
      	<xsl:call-template name="lc-narrative-full">
      		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>

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
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>

    <xsl:call-template name="realform"/>
    
    	 <!-- Reauthentication -->
	<xsl:call-template name="reauthentication"/> 

	 
    
    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
  <!-- Line Items declaration -->
  
   <xsl:call-template name="line-items-declaration" />
	<!-- Template to initialize the product and category map data for dynamic phrase. -->
	<xsl:call-template name="populate-phrase-data"/>
	<script>
		<!-- Instantiate columns arrays -->
		<xsl:call-template name="product-arraylist-initialisation"/>
		
		<!-- Add columns definitions -->
		<xsl:call-template name="Columns_Definitions"/>
		
		<!-- Include some eventual additional columns -->
		<xsl:call-template name="report_addons"/>
	</script>
	<!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
	<xsl:call-template name="Products_Columns_Candidates"/>
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">
     <xsl:choose>
      <xsl:when test="tnx_stat_code = '01' or tnx_stat_code = '02'">false</xsl:when>
      <xsl:otherwise>true</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
  
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
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.create_si</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
    <xsl:with-param name="override-help-access-key">SI_01</xsl:with-param>
   </xsl:call-template>
    <script type="text/javascript">
		dojo.ready(function(){
			misys._config.makeDescOfGoodsMandatory = {};
			misys._config.makeDescOfGoodsMandatory = <xsl:value-of select="defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY')" />
			misys._config.swiftExtendedNarrativeEnabled = <xsl:value-of select="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE')" />
			misys._config.isBank = <xsl:value-of select="security:isBank($rundata)"/>
		});
	</script>
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
    <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">swiftregexValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">swiftregexzcharValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX_ZCHAR')"/></xsl:with-param>
  	 </xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">product_code</xsl:with-param>				
	</xsl:call-template>	
   </div>
  </xsl:template> 

 <!--
  General Details Fieldset
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="common-general-details"/>
    <xsl:call-template name="lc-general-details"/>
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
		<xsl:with-param name="name">CREATE_OPTION</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
	  </xsl:call-template>
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
     	<xsl:with-param name="name">fileActIds</xsl:with-param>
     	<xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">TransactionData</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">narrative_period_presentation_nosend</xsl:with-param>
       <xsl:with-param name="value" select="narrative_period_presentation"/>
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