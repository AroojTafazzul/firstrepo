<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization defaultresource securitycheck ">
    
	
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">LC</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="lc_tnx_record"/>
  </xsl:template>
  
 
 <!-- 
   LC TNX FORM TEMPLATE.
  -->
  <xsl:template match="lc_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
     <xsl:call-template name="build-inco-terms-data"/>
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
		<xsl:choose>
			<xsl:when test ="sub_tnx_stat_code[.='17']">
				     <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
				       <xsl:with-param name="title-size">35</xsl:with-param>
				      </xsl:call-template> 
			</xsl:when>
			<xsl:otherwise>
				     <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
				       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02' or type = '01']"/>
				       <xsl:with-param name="title-size">35</xsl:with-param>
				      </xsl:call-template> 
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>

    <!--
    <xsl:choose>
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- The details of the LC are only shown if the beneficiary is not defined (it means that the transaction
           has been initiated through the Upload option and some mandatory fields are still missing  -->
    <!--xsl:when test="tnx_type_code[.='01'] and attachments/attachment[type = '01']">
      <hr/>
      <p><b><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></b></p>
    </xsl:when>
    <xsl:when test="tnx_type_code[.='15' or .='13' or .='01' or .='03']"> -->
    
     <!-- Link to display transaction contents -->
     <xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and $displaymode='edit' or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
					<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="show-hyperlink">
			<xsl:choose>
				<xsl:when test="(tnx_type_code[.='01'] or tnx_type_code[.='03']) and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='13'] and defaultresource:getResource('ENABLE_EDITING_MSG_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='15']">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	 </xsl:call-template>
	 
	 <xsl:call-template name="amendedNarrativesStore"/>
     
     <div id="transactionDetails">
      <xsl:if test="$displaymode='view'">
       <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="tnx_type_code[.!='01']">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
        </xsl:if>
        
        <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/>
        
        <xsl:call-template name="hidden-fields"/>
        <xsl:call-template name="general-details" />
       
       	<xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      	<xsl:if test="not($swift2019Enabled)">
	      		<xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'true'">
		      		<xsl:call-template name="lc-amt-details-swift2018">
			         <xsl:with-param name="override-product-code">lc</xsl:with-param>
			         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
			         <xsl:with-param name="show-available-amt">Y</xsl:with-param>
	        		 <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
			         <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
			         <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
			         <xsl:with-param name="show-revolving">Y</xsl:with-param>
			         <xsl:with-param name="show-standby">N</xsl:with-param>
			        </xsl:call-template>
	      		</xsl:if>
	      		<xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'false'">
	      			<xsl:call-template name="lc-amt-details-swift2018">
			         <xsl:with-param name="override-product-code">lc</xsl:with-param>
			         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
			         <xsl:with-param name="show-available-amt">Y</xsl:with-param>
	        		 <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
			         <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
			         <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
			         <xsl:with-param name="show-revolving">Y</xsl:with-param>
			        </xsl:call-template>
	      		</xsl:if>
	      	</xsl:if>
	      	<xsl:if test="$swift2019Enabled">
	      	<xsl:call-template name="lc-amt-details-swift2018">
		         <xsl:with-param name="override-product-code">lc</xsl:with-param>
		         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
		         <xsl:with-param name="show-available-amt">Y</xsl:with-param>
        		 <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		         <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		         <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		         <xsl:with-param name="show-revolving">Y</xsl:with-param>
		         <xsl:with-param name="show-standby"><xsl:if test="security:isBank($rundata)">Y</xsl:if></xsl:with-param> 
		        </xsl:call-template>
	      	</xsl:if>
	      	</xsl:when>
	      	<xsl:otherwise>
	      	<xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'true'">
	      		<xsl:call-template name="lc-amt-details">
		         <xsl:with-param name="override-product-code">lc</xsl:with-param>
		         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
		         <xsl:with-param name="show-available-amt">Y</xsl:with-param>
        		 <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		         <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		         <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		         <xsl:with-param name="show-revolving">Y</xsl:with-param>
		         <xsl:with-param name="show-standby">N</xsl:with-param>
		        </xsl:call-template>
	      	</xsl:if>
	      	<xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'false'">
	      		<xsl:call-template name="lc-amt-details">
		         <xsl:with-param name="override-product-code">lc</xsl:with-param>
		         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
		         <xsl:with-param name="show-available-amt">Y</xsl:with-param>
	       		 <xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		         <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		         <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		         <xsl:with-param name="show-revolving">Y</xsl:with-param>
		        </xsl:call-template>
	      	</xsl:if>
	      		
	      	</xsl:otherwise>
	     </xsl:choose>
          <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and revolving_flag = 'Y'">
	      	<xsl:call-template name="lc-revolving-details" />
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit'">
		      <div id="revolving-details" style="display:none;">
		      	<xsl:call-template name="lc-revolving-details" />
		      </div>
	      </xsl:when>
      </xsl:choose>
      <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and stnd_by_lc_flag = 'Y' and $swift2019Enabled and security:isBank($rundata)">
	      	<xsl:call-template name="lc-renewal-details" />
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit' and $swift2019Enabled and security:isBank($rundata)">
		      <div id="renewalDetails" style="display:none;">
		      	<xsl:call-template name="lc-renewal-details" />
		      </div>
	      </xsl:when>
      </xsl:choose>
        <xsl:call-template name="payment-details"/>
        <xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      		<xsl:call-template name="shipment-details-swift2018"/>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:call-template name="shipment-details"/>
	      	</xsl:otherwise>
	     </xsl:choose>
         <xsl:choose>
	      <xsl:when test="$displaymode = 'view'">
	      	<xsl:choose>
	      	<xsl:when test="$mode = 'UNSIGNED' and //limit_details/limit_reference[.!=''] ">
			   	  	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	</xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 	<xsl:if test="//limit_details/limit_reference[.!='']">
		  	 	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	<xsl:with-param name="displayAmount">N</xsl:with-param>
			   	  	</xsl:call-template>
			   	 </xsl:if>
		  	 </xsl:otherwise>
		  	 </xsl:choose>
	      </xsl:when>
	      <xsl:otherwise>
		      <xsl:if test="//limit_details/limit_reference[.!='']">
		       <xsl:call-template name="build-facility-data"/> 
			   	  	<xsl:call-template name="facility-limit-section">
				  	  	<xsl:with-param name="isBank">Y</xsl:with-param>
				  	</xsl:call-template>
		  	 </xsl:if>
	   	 </xsl:otherwise>
   	 </xsl:choose>
         
        
        <xsl:if test="securitycheck:hasPermission($rundata,'tradeadmin_ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	   </xsl:if>
        
        <xsl:choose>
         <xsl:when test="lc_type[.='04']">
          <xsl:call-template name="fieldset-wrapper">
           <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:call-template name="textarea-field">
             <xsl:with-param name="name">narrative_full_details</xsl:with-param>
             <xsl:with-param name="rows">16</xsl:with-param>
            </xsl:call-template>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
          
           <xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      		<xsl:call-template name="bank-details-swift2018"/>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:call-template name="bank-details"/>
	      	</xsl:otherwise>
	      </xsl:choose>
	      <xsl:choose>
				 <xsl:when test="($displaymode = 'view' and (not($swift2018Enabled))) or ($displaymode = 'edit' and (not($swift2018Enabled)) or ($displaymode = 'edit' and tnx_type_code[.='01'] and $swift2018Enabled) )">
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
		          <xsl:choose>
			      	<xsl:when test = "$swift2018Enabled" >
			      		<xsl:call-template name="lc-narrative-special-payments"/>
			      	</xsl:when>
			      	<xsl:otherwise>
			      	</xsl:otherwise>
			      </xsl:choose>
		       </xsl:when>
		      <xsl:otherwise>
		         <div id="view-narrative-swift">
		      		<xsl:if test="$displaymode = 'edit' and $swift2018Enabled">
		      		<xsl:call-template name="view-narrative-swift-details"/>
		      		<xsl:call-template name="view-narrative-swift-special-payments"/>
	      		</xsl:if>
	      		</div>
	      		<div id="amend_narratives_display">
		        <xsl:if test="$displaymode = 'edit' and $swift2018Enabled ">
		      	  <xsl:call-template name="lc-narrative-swift-details">
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
		         <xsl:call-template name="lc-narrative-swift-special-payments"/>
		        </xsl:if>
		        </div>
		        <xsl:if test="(not($swift2018Enabled)) or ($displaymode = 'view' and $swift2018Enabled) ">
			     <xsl:call-template name="fieldset-wrapper">
				    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
				    <xsl:with-param name="in-fieldset">Y</xsl:with-param>
				    <xsl:with-param name="content">
					<xsl:call-template name="previewModeExtendedNarrative"/>
					</xsl:with-param>
				</xsl:call-template> 
				</xsl:if>
		      </xsl:otherwise>
	      </xsl:choose>
	      
	      <xsl:choose>
	      	<xsl:when test = "$swift2018Enabled" >
	      		<xsl:call-template name="lc-narrative-charges-swift2018"/>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		 <xsl:call-template name="lc-narrative-charges"/>
	      	</xsl:otherwise>
	      </xsl:choose>
          <xsl:call-template name="lc-bank-narrative-other"/>
          <xsl:choose>
          <xsl:when test="lc_type ='02' and $displaymode='edit'">
        	<xsl:call-template name="lc-narrative-full">
        		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
        		<xsl:with-param name="readonly">Y</xsl:with-param>
        		<xsl:with-param name="button-required">N</xsl:with-param>
            </xsl:call-template>  
          </xsl:when>
          <xsl:when test="$displaymode='view' and (narrative_full_details != '')">
          	<xsl:call-template name="lc-narrative-full">
          		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
          	</xsl:call-template>
          </xsl:when>
          </xsl:choose>
         </xsl:otherwise>
        </xsl:choose>
     	<xsl:if test="tnx_type_code[.='01'] and release_dttm[.='']">
         <xsl:call-template name="instructions-send-mode"/>
        </xsl:if>
        <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and stnd_by_lc_flag = 'Y'">
	      	<xsl:call-template name="lc-delivery-instructions" />
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit'">
		      <div id="deliveryInstructions" style="display:none;">
		      	<xsl:call-template name="lc-delivery-instructions" />
		      </div>
	      </xsl:when>
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
        
       </xsl:with-param>
      </xsl:call-template>
     </div>
   <!-- </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
      <div>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">exp_date</xsl:with-param>
       </xsl:call-template>
       <xsl:if test="tnx_type_code[.='03']">
        <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">iss_date</xsl:with-param>
        </xsl:call-template>
       </xsl:if>
      </div>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>  --> 
  
  <xsl:call-template name="menu">
	<xsl:with-param name="show-template">
	<xsl:choose>
		<xsl:when test="product_code[.='LC'] and tnx_type_code[.='01'])">Y</xsl:when>
	 	<xsl:otherwise>N</xsl:otherwise>
	</xsl:choose>
	</xsl:with-param>
   	<xsl:with-param name="second-menu">Y</xsl:with-param>
  </xsl:call-template>
 </div>
  
 <!-- Table of Contents -->
 <xsl:call-template name="toc"/>
	
 <!-- Javascript imports  -->
 <xsl:call-template name="js-imports"/>
</xsl:template>
 
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.bank.report_lc</xsl:with-param>
   <xsl:with-param name="show-period-js">Y</xsl:with-param>   
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING' and tnx_type_code[.='01']">IMP_NOT</xsl:when>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>IMP_NOT</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
    <script type="text/javascript">
		dojo.ready(function(){
			misys._config.swiftExtendedNarrativeEnabled = <xsl:value-of select="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE')" />
			misys._config.isBank = <xsl:value-of select="security:isBank($rundata)"/>
		});
	</script>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="additional-fields">
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">narrative_period_presentation_nosend</xsl:with-param>
       <xsl:with-param name="value" select="narrative_period_presentation"/>
     </xsl:call-template>
   <xsl:if test="$displaymode='edit' and release_dttm[.!='']">
	   <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
	   </xsl:call-template>
  </xsl:if>
   <!-- For new messages from customer, don't empty the principal and fee accounts-->
   <xsl:if test="tnx_type_code[.!='01'] or release_dttm[.='']" >
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_no</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_no</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
   </xsl:if>
   <xsl:if test="tnx_type_code[.='03']">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_exp_date</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/exp_date"/>
   </xsl:call-template>
   	<xsl:call-template name="hidden-field">
   		<xsl:with-param name="name">inc_amt</xsl:with-param>
   	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">dec_amt</xsl:with-param>
   	</xsl:call-template>
   </xsl:if>
   <xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_description_goods</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_description_goods"/>
   	</xsl:call-template> 
   	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_documents_required</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_documents_required"/>
   	</xsl:call-template> 
   	<xsl:call-template name="hidden-field">
      	<xsl:with-param name="name">org_narrative_additional_instructions</xsl:with-param>
      	<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_additional_instructions"/>
   	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_special_beneficiary</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_special_beneficiary"/>
   	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_special_recvbank</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_special_recvbank"/>
   	</xsl:call-template>
    <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_description_goods</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_description_goods"/>
	</xsl:call-template> 
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_documents_required</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_documents_required"/>
	</xsl:call-template> 
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_additional_instructions</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_additional_instructions"/>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_special_beneficiary</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_special_beneficiary"/>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">original_narrative_special_recvbank</xsl:with-param>
	      <xsl:with-param name="value" select="org_narratives/narrative_special_recvbank"/>
	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">is798</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="is_MT798"/></xsl:with-param>
 	</xsl:call-template>
   <!-- <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">tnx_amt</xsl:with-param>
   	</xsl:call-template> -->
   <xsl:call-template name="hidden-field">
	   	<xsl:with-param name="name">org_lc_amt</xsl:with-param>
	   	<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/lc_amt"/>
   </xsl:call-template> 
   <xsl:if test="tnx_stat_code[.='03' or .='07']">
	   <xsl:call-template name="hidden-field">
	   	<xsl:with-param name="name">tnx_stat_code</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   </xsl:with-param>
  
  </xsl:call-template>
 </xsl:template>
 
 <!--
  General Details 
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
   	<!-- System ID -->
   	 <xsl:if test="product_code[.='LC'] and $displaymode='view'">
   	  <xsl:call-template name="row-wrapper">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
 
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ref_id"/>
             </div></xsl:with-param>
   </xsl:call-template>
	 <xsl:if test="cust_ref_id[.!='']">
	  <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="cust_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:if test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
        <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="bo_ref_id"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
      </xsl:if>
       <xsl:if test="appl_date[.!='']">
       <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="appl_date"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
	   	<xsl:if test="iss_date[.!=''] and tnx_type_code[.!='15' or .!='13']">
	   	 <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="iss_date"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	   	</xsl:if>
      </xsl:if>
   	<!-- Template ID. -->
    <xsl:if test="product_code[.='LC']">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="name">template_id</xsl:with-param>
     <xsl:with-param name="size">15</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
 
     <!-- The Issue Date needs to be shown only for a reporting, 
           it is in the reporting section for the New Upload -->
     <xsl:if test="tnx_type_code[.='15' or .='13'] and $displaymode='edit'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="name">iss_date</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
     <div id="expiryType" style="display:none;">
     <xsl:if test="$swift2019Enabled and product_code[.='LC'] and security:isBank($rundata) ">
		<xsl:if test="$displaymode = 'edit'"> 
			<xsl:call-template name="select-field">
			<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
			<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			 <xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="options">
			<xsl:call-template name="exp-date-type-code-options"/>
		     </xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
	</xsl:if>
	</div>
	<xsl:if test="$swift2019Enabled and product_code[.='LC'] and security:isBank($rundata)">
		<xsl:if test="$displaymode = 'view'">
			<xsl:if test="lc_exp_date_type_code[.!='']">
				<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C085</xsl:variable>
				<xsl:call-template name="input-field">
				 	<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
				 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
				 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
				 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
				 </xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:if>
	
     <!--  Expiry Date. --> 
<xsl:call-template name="input-field">
   <xsl:with-param name="label">
  	 <xsl:if test="$displaymode = 'view' and exp_date !=''"> 
  	    <xsl:choose>
     		<xsl:when test="$swift2018Enabled and tnx_type_code[.='03']">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:when>
     		<xsl:otherwise>XSL_GENERALDETAILS_EXPIRY_DATE</xsl:otherwise>
      	</xsl:choose>
      </xsl:if>
     <xsl:if test="$displaymode = 'edit'"> 
  	   	<xsl:choose>
     		<xsl:when test="$swift2018Enabled and tnx_type_code[.='03']">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:when>
     		<xsl:otherwise>XSL_GENERALDETAILS_EXPIRY_DATE</xsl:otherwise>
      	</xsl:choose>
     </xsl:if>
    </xsl:with-param>
  <xsl:with-param name="name">exp_date</xsl:with-param>
  <xsl:with-param name="size">10</xsl:with-param>
  <xsl:with-param name="maxsize">10</xsl:with-param>
  <xsl:with-param name="type">date</xsl:with-param>
  <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="required">
     <xsl:choose>
      <xsl:when test="$swift2019Enabled and lc_exp_date_type_code='01'">Y</xsl:when>
      <xsl:when test="$swift2019Enabled and (lc_exp_date_type_code='02' or lc_exp_date_type_code='03')">N</xsl:when>
      <xsl:otherwise>Y</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="disabled">
     <xsl:choose>
      <xsl:when test="$swift2019Enabled and lc_exp_date_type_code='03'">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
 </xsl:call-template>
     <xsl:if test="$swift2019Enabled and product_code[.='LC'] and security:isBank($rundata)">
	<xsl:if test="$displaymode = 'edit'">
 	 <div id="exp-event" style="display:none;">
	 	<xsl:call-template name="row-wrapper">
	     <xsl:with-param name="id">exp_event</xsl:with-param>
	     <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
	     <xsl:with-param name="type">textarea</xsl:with-param>
	     <xsl:with-param name="content">
	      <xsl:call-template name="textarea-field">
	       <xsl:with-param name="name">exp_event</xsl:with-param>
	       <xsl:with-param name="button-type"></xsl:with-param>
	       <xsl:with-param name="rows">4</xsl:with-param>
	       <xsl:with-param name="cols">35</xsl:with-param>
	       <xsl:with-param name="maxlines">4</xsl:with-param>
	       <xsl:with-param name="messageValue"><xsl:value-of select="exp_event"/></xsl:with-param>
	      </xsl:call-template>
	     </xsl:with-param>
		</xsl:call-template>
	 </div>
	</xsl:if>
	<xsl:if test="$displaymode = 'view'">
		<xsl:if test="exp_event[.!='']">
	        <xsl:call-template name="big-textarea-wrapper">
			  <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
			  <xsl:with-param name="content">
			  	<div class="content">
			    	<xsl:value-of select="exp_event"/>
				</div>
			  </xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>
</xsl:if>
     <!-- Expiry place. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">
      <xsl:choose>
     		<xsl:when test="$swift2018Enabled and tnx_type_code[.='03']">XSL_GENERALDETAILS_NEW_EXPIRY_PLACE</xsl:when>
     		<xsl:otherwise>XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:otherwise>
      	</xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="name">expiry_place</xsl:with-param>
      <xsl:with-param name="maxsize">29</xsl:with-param>
     </xsl:call-template>
     
      <!-- PO Reference -->
   <xsl:if test="product_code[.='LC'] and purchase_order[.!=''] and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_PUO_REF_ID</xsl:with-param>
    <xsl:with-param name="name">purchase_order</xsl:with-param>
   <xsl:with-param name="readonly">Y</xsl:with-param>
   
   </xsl:call-template>
   </xsl:if>
 
     
   <!-- <xsl:if test="amd_date[.!=''] and $option='EXISTING'">
      <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
     <xsl:with-param name="name">amd_no</xsl:with-param>
     <xsl:with-param name="size">2</xsl:with-param>
     <xsl:with-param name="maxsize">3</xsl:with-param>
     <xsl:with-param name="type">number</xsl:with-param>
     <xsl:with-param name="override-value">Y</xsl:with-param>
     <xsl:with-param name="custom-value"><xsl:value-of select="utils:formatAmdNo(amd_no)"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
     <xsl:with-param name="name">amd_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    </xsl:if>  -->
     <!-- LC changes Starts -->
     <xsl:if test="$displaymode='view' and amd_no[.!='']">
       <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_COUNT</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="amd_no"/>
             </div></xsl:with-param>
            </xsl:call-template>
      </xsl:if>
       <xsl:if test="$displaymode='view' and amd_date[.!='']">
       <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="amd_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
      </xsl:if>
       
      <div id="governingLawDetails" style="display:none;">
      <xsl:if test="$swift2019Enabled and product_code[.='LC'] and security:isBank($rundata) and $displaymode='edit'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_LC_PLACE_OF_JURISDICTION</xsl:with-param>
				<xsl:with-param name="name">lc_govern_country</xsl:with-param>
				<xsl:with-param name="prefix">lc_govern</xsl:with-param>
				<xsl:with-param name="button-type">codevalue</xsl:with-param>
				<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				<xsl:with-param name="uppercase">Y</xsl:with-param>
				<xsl:with-param name="size">2</xsl:with-param>
				<xsl:with-param name="maxsize">2</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">  
				<xsl:with-param name="label">GOVERNING_LABEL</xsl:with-param>
				<xsl:with-param name="name">lc_govern_text</xsl:with-param>
				<xsl:with-param name="maxsize">65</xsl:with-param>
				<xsl:with-param name="swift-validate">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		</div>
      <xsl:if test="$displaymode='view' and $swift2019Enabled and product_code[.='LC']">
			<xsl:if test="lc_govern_country[.!='']">
					<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">XSL_LC_PLACE_OF_JURISDICTION</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="lc_govern_country"/>
	             </div></xsl:with-param>
	            </xsl:call-template>
	            </xsl:if>
	            <xsl:if test="lc_govern_text[.!='']">
				<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">GOVERNING_LABEL</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="lc_govern_text"/>
	             </div></xsl:with-param>
	            </xsl:call-template>
	            </xsl:if>
      </xsl:if>
		
      <!-- LC changes ends -->
     <!-- 
      Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
      Pass in a show-presentation parameter set to Y to display the presentation fields.
      
      If set to N, the template will instead insert a hidden field with the value 1.0
     -->
     <xsl:call-template name="eucp-details">
      <xsl:with-param name="show-eucp" select="$show-eucp"/>
     </xsl:call-template>
     <xsl:variable name="appl_ref">
	      <xsl:value-of select="applicant_reference"/>
	 </xsl:variable>
     <xsl:if test="lc_type[.!='04']">
      <!-- Applicant Details -->
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="show-entity">
          <xsl:choose>
           <xsl:when test="entity[.=''] and release_dttm[.!='']">N</xsl:when>
           <xsl:otherwise>Y</xsl:otherwise>
          </xsl:choose> 
          </xsl:with-param>
         <xsl:with-param name="entity-required">N</xsl:with-param>
         <xsl:with-param name="show-entity-button"><xsl:if test="tnx_type_code[.='01']">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="entity-type">bank-entity</xsl:with-param>
         <xsl:with-param name="show-abbv"><xsl:if test="tnx_type_code[.='01']">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='01']">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="address-readonly"><xsl:if test="tnx_type_code[.='01']">N</xsl:if></xsl:with-param>
         <xsl:with-param name="prefix">applicant</xsl:with-param>
        </xsl:call-template>
        
        <!-- Case of LC initiations on bank side : applicant must be selected and not keyed --> 
        <xsl:choose>
         <xsl:when test="tnx_type_code[.='01'] and release_dttm[.=''] and customer_references/customer_reference">
          <xsl:choose>
	         <xsl:when test="$displaymode ='edit'">
	          		<xsl:call-template name="select-field">
			            <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
			           	<xsl:with-param name="name">applicant_reference</xsl:with-param>
						<xsl:with-param name="options"><xsl:apply-templates select="customer_references/customer_reference"/></xsl:with-param>
	          		</xsl:call-template>
	          </xsl:when>
	          <xsl:otherwise>
	          <xsl:if test="$displaymode ='view'">
		    		<xsl:call-template name="input-field">
				           <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
				           <xsl:with-param name="name">applicant_reference</xsl:with-param>
				           <xsl:with-param name="value"><xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/></xsl:with-param>
		           </xsl:call-template>
	          </xsl:if>
	          </xsl:otherwise>
          </xsl:choose>
         </xsl:when>
         <!-- Case of LC initiated on customer side : applicant already selected and not keyed --> 
         <xsl:otherwise>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
           <xsl:with-param name="name">applicant_reference</xsl:with-param>
           <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/></xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
          </xsl:call-template>
         </xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_ALTERNATE_PARTY_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
  <xsl:if test="$displaymode = 'edit'">
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_FOR_THE_ACCOUNT_OF</xsl:with-param>
     <xsl:with-param name="name">for_account_flag</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">alt_applicant_cust_ref</xsl:with-param>
		</xsl:call-template>
    </xsl:if>    
    <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and for_account_flag = 'Y'">
	      	<xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_NAME</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_name</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_name[.!='']"><xsl:value-of select="alt_applicant_name"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_address_line_1</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_address_line_1[.!='']"><xsl:value-of select="alt_applicant_address_line_1"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="name">alt_applicant_address_line_2</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_address_line_2[.!='']"><xsl:value-of select="alt_applicant_address_line_2"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="name">alt_applicant_dom</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_dom[.!='']"><xsl:value-of select="alt_applicant_dom"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="name">alt_applicant_address_line_4</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_address_line_4[.!='']"><xsl:value-of select="alt_applicant_address_line_4"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_COUNTRY</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_country</xsl:with-param>
	       <xsl:with-param name="value"><xsl:if test="alt_applicant_country[.!='']"><xsl:value-of select="localization:getCodeData($language,'*','*','C006',alt_applicant_country)"/></xsl:if>
	       </xsl:with-param>
	       </xsl:call-template>
	       <xsl:if test="alt_applicant_cust_ref[.!='']">
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_ALTERNATE_APPLICANT_REF</xsl:with-param>
	       <xsl:with-param name="name">alt_applicant_cust_ref</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="alt_applicant_cust_ref"/></xsl:with-param>
	       </xsl:call-template>
	       </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit'">
		      <div id="alternate-party-details" style="display:none;">
		      	<xsl:call-template name="lc-alternative-applicant-details" />
		      </div>
	      </xsl:when>
      </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
  
      <!-- Beneficiary Details -->
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="show-reference">Y</xsl:with-param>
         <xsl:with-param name="show-button">Y</xsl:with-param>
         <xsl:with-param name="search-button-type">beneficiary</xsl:with-param>
         <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
         <xsl:with-param name="prefix">beneficiary</xsl:with-param>
         <xsl:with-param name="show-country">Y</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  LC Payment Details
  -->
 <xsl:template name="payment-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="lc-reporting-credit-available-with-bank">
       <xsl:with-param name="theNodeName">credit_available_with_bank</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="credit-available-by">
       <xsl:with-param name="show-drawee">N</xsl:with-param>
      </xsl:call-template>
      
      
    </xsl:with-param>
   </xsl:call-template>
   <xsl:choose>
    <xsl:when test="drawee_details_bank/name[.!=''] and $displaymode='view'">
   	<xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:apply-templates select="drawee_details_bank">
       <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>
      </xsl:apply-templates>
     </xsl:with-param>
    </xsl:call-template>
    </xsl:when>
    <xsl:when test="$displaymode='edit'">
   	<xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:apply-templates select="drawee_details_bank">
       <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">Y</xsl:with-param>
      </xsl:apply-templates>
     </xsl:with-param>
    </xsl:call-template>
    </xsl:when>
    </xsl:choose>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
   <!--
   LC/SI Shipment Details Fieldset.
  -->
  <xsl:template name="shipment-details">
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:with-param>
     <xsl:with-param name="name">ship_from</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_LOADING</xsl:with-param>
     <xsl:with-param name="name">ship_loading</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_DISCHARGE</xsl:with-param>
     <xsl:with-param name="name">ship_discharge</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_TO</xsl:with-param>
     <xsl:with-param name="name">ship_to</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="id">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="part_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:when test="part_ship_detl[. = 'NONE']">NONE</xsl:when>
        <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">OTHER</xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
         <option value="ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
         <option value="NONE">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/>
         </option>
         <option value="OTHER">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/>
         </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="part_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/></xsl:when>
          <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">part_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="part_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">credit_available_with_bank_type</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="id">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:when test="tran_ship_detl[. = 'NONE']">NONE</xsl:when>
        <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">OTHER</xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	      <option value="NONE">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/>
	      </option>
	      <option value="OTHER">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/>
	      </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">tran_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="tran_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
     <xsl:with-param name="name">last_ship_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
   <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
         <xsl:call-template name="select-field">
	 	<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
		<xsl:with-param name="name">inco_term_year</xsl:with-param>	 
		 <xsl:with-param name="fieldsize">small</xsl:with-param>
		  <xsl:with-param name="required">N</xsl:with-param>	 
	</xsl:call-template>
	   </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="inco_year"><xsl:value-of select="inco_term_year"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
					<xsl:with-param name="name">inco_term_year_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$inco_year"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
	  <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
       </xsl:when>
		<xsl:otherwise>
		<xsl:variable name="incoTerm"><xsl:value-of select="inco_term"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
					<xsl:with-param name="name">inco_term_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','N212',$incoTerm)"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
     <xsl:with-param name="name">inco_place</xsl:with-param>
     <xsl:with-param name="required">N</xsl:with-param>
     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
    </xsl:call-template>
    <xsl:if test="transport_mode[. != '']">
	<xsl:call-template name="transport-mode-fields"/>
	</xsl:if>   
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template> 
 
 <!-- 
  LC Bank Details
  -->
 <xsl:template name="bank-details">
 	<xsl:choose>
 	 <xsl:when test="$displaymode='edit'">
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   <xsl:with-param name="tabgroup-height">250px</xsl:with-param>

   <!-- Tab 1_0 - Advising Bank  -->
   <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
   <xsl:with-param name="tab0-content">
    <xsl:apply-templates select="advising_bank">
     <xsl:with-param name="prefix">advising_bank</xsl:with-param>
    </xsl:apply-templates>
   </xsl:with-param>
   
   <!-- Tab 1_2 - Advise Thru Bank  -->
   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
   <xsl:with-param name="tab1-content">
    <xsl:apply-templates select="advise_thru_bank">
     <xsl:with-param name="prefix">advise_thru_bank</xsl:with-param>
    </xsl:apply-templates>
   </xsl:with-param>
  </xsl:call-template> 
  </xsl:when>
  <xsl:otherwise>
  
   <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   <xsl:with-param name="tabgroup-height">250px</xsl:with-param>
		
		 <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:call-template name="issuing_bank">
       <xsl:with-param name="prefix" select="'issuing_bank'"/>
     </xsl:call-template>
    </xsl:with-param>  

   <!-- Tab 1_1 - Advising Bank  -->
   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
   <xsl:with-param name="tab1-content">
    <xsl:apply-templates select="advising_bank">
     <xsl:with-param name="prefix">advising_bank</xsl:with-param>
    </xsl:apply-templates>
   </xsl:with-param>
   
   <!-- Tab 1_2 - Advise Thru Bank  -->
   <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
   <xsl:with-param name="tab2-content">
    <xsl:apply-templates select="advise_thru_bank">
     <xsl:with-param name="prefix">advise_thru_bank</xsl:with-param>
    </xsl:apply-templates>
   </xsl:with-param>
  </xsl:call-template> 
  </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
<xsl:template name="issuing_bank">
   <xsl:param name="prefix"/>
   <xsl:variable name="issuing-bank-name-value">
     <xsl:value-of select="//*[name()=$prefix]/name"/>
   </xsl:variable>
   
   <xsl:variable name="appl_ref">
	  <xsl:value-of select="applicant_reference"/>
   </xsl:variable>
   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="value" select="$issuing-bank-name-value"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   
   <xsl:call-template name="input-field">
  	   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
  	   <xsl:with-param name="value">
  	   	<xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
  	   </xsl:with-param>
  	   <xsl:with-param name="readonly">Y</xsl:with-param>
  </xsl:call-template>
  
 </xsl:template>

 <!--
  Advising / Advise Thru Bank
 -->
 <xsl:template match="advising_bank | advise_thru_bank">
  <xsl:param name="prefix"/>
  <xsl:param name="disabled">N</xsl:param>

	<xsl:choose>
	  <xsl:when test="$prefix='advising_bank'">
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">
	    	<xsl:choose>
	     		<xsl:when test="$swift2018Enabled">XSL_PARTIESDETAILS_SWIFT_CODE</xsl:when>
	     		<xsl:otherwise>XSL_JURISDICTION_BIC_CODE</xsl:otherwise>
	      	</xsl:choose>
	    </xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
	    <xsl:with-param name="value" select="iso_code"/>
	    <xsl:with-param name="size">11</xsl:with-param>
	    <xsl:with-param name="maxsize">11</xsl:with-param>
	    <xsl:with-param name="disabled" select="$disabled"/>
	   <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
	    <xsl:with-param name="value" select="reference"/>
	    <xsl:with-param name="size">16</xsl:with-param>
	    <xsl:with-param name="maxsize">16</xsl:with-param>
	    <xsl:with-param name="disabled" select="$disabled"/>
	   </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="$prefix='advise_thru_bank'">
	  <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PARTIESDETAILS_SWIFT_CODE</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
	    <xsl:with-param name="value" select="iso_code"/>
	    <xsl:with-param name="size">11</xsl:with-param>
	    <xsl:with-param name="maxsize">11</xsl:with-param>
	    <xsl:with-param name="disabled" select="$disabled"/>
	    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
	   </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	   <div>
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">advise_thru_bank_iso_code</xsl:with-param>
	     <xsl:with-param name="value" select="iso_code"/>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">advise_thru_bank_reference</xsl:with-param>
	     <xsl:with-param name="value" select="reference"/>
	    </xsl:call-template>
	   </div>
	  </xsl:otherwise>
	</xsl:choose>
  <!-- Name. -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
   <xsl:with-param name="value" select="name"/>
   <xsl:with-param name="override-product-code"><xsl:value-of select="product-code"/></xsl:with-param>
   <!--xsl:with-param name="required">Y</xsl:with-param-->
   <xsl:with-param name="button-type"><xsl:if test="not($swift2018Enabled)"><xsl:value-of select="$prefix"/></xsl:if></xsl:with-param>
   <xsl:with-param name="disabled" select="$disabled"/>
  </xsl:call-template>
   
  <!-- Address Lines -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
   <xsl:with-param name="value" select="address_line_1"/>
   <xsl:with-param name="disabled" select="$disabled"/>
   <!--xsl:with-param name="required">Y</xsl:with-param-->
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
   <xsl:with-param name="value" select="address_line_2"/>
   <xsl:with-param name="disabled" select="$disabled"/>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
   <xsl:with-param name="value" select="dom"/>
   <xsl:with-param name="disabled" select="$disabled"/>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
   <xsl:with-param name="value" select="address_line_4"/>
  </xsl:call-template>
  
 </xsl:template>
 

 <!--LC Instructions / Send Mode  -->
 <xsl:template name="instructions-send-mode">  
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL</xsl:with-param>
   <xsl:with-param name="content">
   
 
	
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL</xsl:with-param>
     <xsl:with-param name="name">adv_send_mode</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
        <xsl:when test="$displaymode='edit'">
        <xsl:choose>
       	<xsl:when test="is_MT798[. = 'Y']">
      	  <option value="01">
    	     <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
	       </option>
      	</xsl:when>
      	<xsl:otherwise>
      	   <option value="01">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
	      </option>
	      <option value="02">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
	      </option>
	      <option value="03">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
	      </option>
	      <option value="99">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_OTHER')"/>
	      </option>
	      </xsl:otherwise>
	      
        </xsl:choose>
	   
	   </xsl:when>
	   <xsl:otherwise>
	    <xsl:choose>
          <xsl:when test="adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
          <xsl:when test="adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
          <xsl:when test="adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
          <xsl:when test="adv_send_mode[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_OTHER')"/></xsl:when>
         </xsl:choose>
	   </xsl:otherwise>
	  </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
		   <xsl:with-param name="name">adv_send_mode_text</xsl:with-param>
		    <xsl:with-param name="readonly">Y</xsl:with-param>
		   <xsl:with-param name="required">N</xsl:with-param>
		   <xsl:with-param name="maxsize">35</xsl:with-param>
	   </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>  
 </xsl:template>
 
 <xsl:template name="shipment-details-swift2018">
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">
     	<xsl:choose>
     		<xsl:when test="tnx_type_code[.='03']">XSL_SHIPMENTDETAILS_NEW_SHIP_FROM</xsl:when>
     		<xsl:otherwise>XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:otherwise>
      	</xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="name">ship_from</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">
     	<xsl:choose>
     		<xsl:when test="tnx_type_code[.='03']">XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING</xsl:when>
     		<xsl:otherwise>XSL_SHIPMENTDETAILS_SHIP_LOADING</xsl:otherwise>
      	</xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="name">ship_loading</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">
     	<xsl:choose>
     		<xsl:when test="tnx_type_code[.='03']">XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE</xsl:when>
     		<xsl:otherwise>XSL_SHIPMENTDETAILS_SHIP_DISCHARGE</xsl:otherwise>
      	</xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="name">ship_discharge</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">
     	<xsl:choose>
     		<xsl:when test="tnx_type_code[.='03']">XSL_SHIPMENTDETAILS_NEW_SHIP_TO</xsl:when>
     		<xsl:otherwise>XSL_SHIPMENTDETAILS_SHIP_TO</xsl:otherwise>
      	</xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="name">ship_to</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="id">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
      <!-- SWIFT 2018 changes -->
      <xsl:choose>
      		 <xsl:when test="$product-code='LC'">
      		 	<xsl:choose>
       				 <xsl:when test="part_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       				 <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        			 <xsl:when test="part_ship_detl[. = 'NONE']"></xsl:when>
        			 <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">CONDITIONAL</xsl:when>
       			</xsl:choose>
      		 </xsl:when>
      		 <xsl:otherwise>
      		 	<xsl:choose>
       				 <xsl:when test="part_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       				 <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        			 <xsl:when test="part_ship_detl[. = 'NONE']">NONE</xsl:when>
        			 <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">OTHER</xsl:when>
       			</xsl:choose>
      		</xsl:otherwise>
      </xsl:choose>   
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
         <!-- SWIFT 2018 changes -->
       	  <xsl:if test="$product-code='LC'">
       	  		<option/>
       	  </xsl:if>
         <option value="ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
         <!-- SWIFT 2018 changes -->
	      <xsl:choose>
	       	 <xsl:when test="$product-code='LC'">
	       	 	<option value="CONDITIONAL">
	       	 		<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/>       	 	
	       	 	</option>
	       	 </xsl:when>
	       	 <xsl:otherwise>
	       	  	<option value="NONE">
	      			 <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/>
	     		 </option>
	       	 	<option value="OTHER">
	       	 		<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/>       	 	
	       	 	</option>   	 	
	       	 </xsl:otherwise>
	       </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
        <!-- SWIFT 2018 changes -->
         <xsl:if test="part_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="part_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/></xsl:when>
          <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']">
           <!-- SWIFT 2018 changes -->
	       <xsl:choose>
     		 <xsl:when test="$product-code='LC'"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/></xsl:when>
      		 <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/></xsl:otherwise>
     	   </xsl:choose>       
          </xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <!-- SWIFT 2018 changes --> 
     <xsl:call-template name="infoMessagePartialShipment"></xsl:call-template> 
     <xsl:if test="not($product-code='LC') and ($displaymode='edit' or part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE'])">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">part_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="part_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">credit_available_with_bank_type</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
    <!-- SWIFT 2018 changes 
    If the product code is 'LC' display the new label as per SWIFT standards.
    -->
    <xsl:with-param name="label">
     <xsl:choose>
      <xsl:when test="$product-code='LC'">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL_LC</xsl:when>
      <xsl:otherwise>XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
      <xsl:with-param name="id">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
         <!-- SWIFT 2018 changes -->
      <xsl:choose>
      		 <xsl:when test="$product-code='LC'">
      		 	<xsl:choose>
       				 <xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       				 <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        			 <xsl:when test="tran_ship_detl[. = 'NONE']"></xsl:when>
       				 <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">CONDITIONAL</xsl:when>
       			</xsl:choose>
      		 </xsl:when>
      		 <xsl:otherwise>
      		 	<xsl:choose>
       				 <xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       				 <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        			 <xsl:when test="tran_ship_detl[. = 'NONE']">NONE</xsl:when>
       				 <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">CONDITIONAL</xsl:when>
       			</xsl:choose>
      		</xsl:otherwise>
      </xsl:choose>   
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
          <!-- SWIFT 2018 changes -->
       	  <xsl:if test="$product-code='LC'">
       	  		<option/>	  		
       	  </xsl:if>
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	       <!-- SWIFT 2018 changes -->
	      <xsl:choose>
	       	 <xsl:when test="$product-code='LC'">
	       	 	<option value="CONDITIONAL">
	       	 		<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/>       	 	
	       	 	</option>
	       	 </xsl:when>
	       	 <xsl:otherwise>
	       	  	<option value="NONE">
	      			 <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/>
	     		 </option>
	       	 	<option value="OTHER">
	       	 		<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/>       	 	
	       	 	</option>   	 	
	       	 </xsl:otherwise>
	       </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
        <!-- SWIFT 2018 changes -->
         <xsl:if test="tran_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']">
          <!-- SWIFT 2018 changes -->
	       <xsl:choose>
     		 <xsl:when test="$product-code='LC'"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/></xsl:when>
      		 <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/></xsl:otherwise>
     	   </xsl:choose>       
          </xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
      <!-- SWIFT 2018 changes -->
    <xsl:call-template name="infoMessageTranshipment"></xsl:call-template>
      <xsl:if test="not($product-code='LC') and ($displaymode='edit' or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE'])">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">tran_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="tran_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">
     	<xsl:choose>
     		<xsl:when test="tnx_type_code[.='03']">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:when>
     		<xsl:otherwise>XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:otherwise>
      	</xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="name">last_ship_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
         <xsl:call-template name="select-field">
	 	<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
		<xsl:with-param name="name">inco_term_year</xsl:with-param>	 
		 <xsl:with-param name="fieldsize">small</xsl:with-param>
		  <xsl:with-param name="required">N</xsl:with-param>	 
	</xsl:call-template>
	   </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="inco_year"><xsl:value-of select="inco_term_year"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
					<xsl:with-param name="name">inco_term_year_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$inco_year"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
	  <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
       </xsl:when>
		<xsl:otherwise>
		<xsl:variable name="incoTerm"><xsl:value-of select="inco_term"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
					<xsl:with-param name="name">inco_term_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','N212',$incoTerm)"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
     <xsl:with-param name="name">inco_place</xsl:with-param>
     <xsl:with-param name="required">N</xsl:with-param>
     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
    </xsl:call-template>
    <xsl:if test="transport_mode[. != '']">
	<xsl:call-template name="transport-mode-fields"/>
	</xsl:if>   
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
  <!--TEMPLATE Customer Reference-->
	<xsl:template match="customer_references/customer_reference">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="reference"/></xsl:attribute>
			<xsl:if test="//applicant_reference=reference">
				<xsl:attribute name="selected"/>
			</xsl:if>
			<xsl:value-of select="description"/> (<xsl:value-of select="utils:decryptApplicantReference(reference)"/>)
		</option>
	</xsl:template>
	
	<xsl:template name="lc-delivery-instructions">
	<xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_DELIVERY_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="content">
   <xsl:if test="$swift2019Enabled and product_code[.='LC']">
	     	<xsl:if test="$displaymode = 'edit'"> 
				<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
			      <xsl:with-param name="name">delv_org</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:call-template name="delivery-mode-options"/>
			      </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="input-field">
			       <xsl:with-param name="name">delv_org_text</xsl:with-param>
			       <xsl:with-param name="size">35</xsl:with-param>
			       <xsl:with-param name="maxsize">35</xsl:with-param>
			       	<xsl:with-param name="disabled">
				       <xsl:choose>
			     		<xsl:when test="delv_org[.='99']">N</xsl:when>
			     		<xsl:otherwise>Y</xsl:otherwise>
			   		   </xsl:choose>
			   		</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
			      <xsl:with-param name="name">delivery_to</xsl:with-param>
			      <xsl:with-param name="fieldsize">small</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:call-template name="delivery-to-options"/>
			      </xsl:with-param>
			     </xsl:call-template>
					<xsl:call-template name="row-wrapper">
					    <xsl:with-param name="id">narrative_delivery_to</xsl:with-param>
					    <xsl:with-param name="label">N002_BLANK</xsl:with-param>
					    <xsl:with-param name="type">textarea</xsl:with-param>
					    <xsl:with-param name="content">
					     <xsl:call-template name="textarea-field">
					      	<xsl:with-param name="name">narrative_delivery_to</xsl:with-param>
					      	<xsl:with-param name="messageValue"><xsl:value-of select="narrative_delivery_to/text"/></xsl:with-param>
      						<xsl:with-param name="phrase-params">{'category':'62'}</xsl:with-param>
				      		<xsl:with-param name="cols">35</xsl:with-param>
      						<xsl:with-param name="rows">6</xsl:with-param>
			  				<xsl:with-param name="maxlines">6</xsl:with-param>
					       <xsl:with-param name="swift-validate">Y</xsl:with-param>
					     </xsl:call-template>
					    </xsl:with-param>
					</xsl:call-template>	
			</xsl:if>
			<xsl:if test="$displaymode = 'view'">
				<xsl:if test="delv_org[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
					 	<xsl:with-param name="name">delv_org</xsl:with-param>
					 	<xsl:with-param name="value">
					 	<xsl:choose>
										<xsl:when test="delv_org[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COLLECTION')"/></xsl:when>
										<xsl:when test="delv_org[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COURIER')"/></xsl:when>
										<xsl:when test="delv_org[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MAIL')"/></xsl:when>
										<xsl:when test="delv_org[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MESSENGER')"/></xsl:when>
										<xsl:when test="delv_org[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_REGISTERED_MAIL')"/></xsl:when>
										<xsl:when test="delv_org[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_OTHER')"/></xsl:when>
						</xsl:choose>
						</xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delv_org_text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">delv_org_text</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="delv_org_text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delivery_to[.!=''] or narrative_delivery_to/text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
					 	<xsl:with-param name="name">delv_to</xsl:with-param>
					 	<xsl:with-param name="value">
									<xsl:variable name="delv_to_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>								
									<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
						</xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="narrative_delivery_to/text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">narrative_delivery_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="narrative_delivery_to/text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
   		</xsl:if>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:template>
 
</xsl:stylesheet>