<?xml version="1.0" encoding="UTF-8"?>
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
	exclude-result-prefixes="xmlRender localization securitycheck utils defaultresource security">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <!-- Columns definition import -->
	<xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:param name="rundata"/>
  <xsl:param name="formLoad">false</xsl:param>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">LC</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LetterOfCreditScreen</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

  

  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="lc_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC TNX FORM TEMPLATE.
   
  -->
  <xsl:template match="lc_tnx_record">
   <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
   
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
  
       <xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
	      	<xsl:if test="not($swift2019Enabled)">
	      	<xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'true'">
		      		<xsl:call-template name="lc-amt-details-swift2018">
		      			<xsl:with-param name="show-standby">N</xsl:with-param>
		      			<xsl:with-param name="show-amt">
		      			<xsl:choose>
		      				<xsl:when test="lc_amt[.!='']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
	      			</xsl:with-param>
	      			  	<xsl:with-param name="show-revolving">
		      			<xsl:choose>
		      				<xsl:when test="sub_tnx_type_code[.!='06']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
	      			</xsl:with-param>
	      		</xsl:call-template>
		      	</xsl:if>
		      	<xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'false'">
		      		<xsl:call-template name="lc-amt-details-swift2018">
		      		<xsl:with-param name="show-amt">
		      			<xsl:choose>
		      				<xsl:when test="lc_amt[.!='']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
	      			</xsl:with-param>
	      			  	<xsl:with-param name="show-revolving">
		      			<xsl:choose>
		      				<xsl:when test="sub_tnx_type_code[.!='06']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
	      			</xsl:with-param>
	      			</xsl:call-template>
		      	</xsl:if>
	      	</xsl:if>
		      	<xsl:if test="$swift2019Enabled">
		      	<xsl:call-template name="lc-amt-details-swift2018">
		      			<xsl:with-param name="show-standby">N</xsl:with-param>
	      			  	<xsl:with-param name="show-revolving">
		      			<xsl:choose>
		      				<xsl:when test="sub_tnx_type_code[.!='06']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
	      			</xsl:with-param>
	      			<xsl:with-param name="show-amt">
		      			<xsl:choose>
		      				<xsl:when test="lc_amt[.!='']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
	      			</xsl:with-param>
	      		</xsl:call-template>
		      	</xsl:if>
	      	</xsl:when>
	      	<xsl:otherwise>
		      	<xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'true'">
		      		<xsl:call-template name="lc-amt-details">
				      		<xsl:with-param name="show-standby">N</xsl:with-param>
			      			  	<xsl:with-param name="show-revolving">
				      			<xsl:choose>
				      				<xsl:when test="sub_tnx_type_code[.!='06']">Y</xsl:when>
				      				<xsl:otherwise>N</xsl:otherwise>
				      			</xsl:choose>
			      			</xsl:with-param>
	      		    </xsl:call-template>
	      		</xsl:if>
      		  <xsl:if test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'false'">
      		  	<xsl:call-template name="lc-amt-details">
      			  	<xsl:with-param name="show-revolving">
		      			<xsl:choose>
		      				<xsl:when test="sub_tnx_type_code[.!='06']">Y</xsl:when>
		      				<xsl:otherwise>N</xsl:otherwise>
		      			</xsl:choose>
      			    </xsl:with-param>
	      		</xsl:call-template>
      		  </xsl:if>
      		 </xsl:otherwise>
	   </xsl:choose> 
	   
      <xsl:choose>
	      <xsl:when test="sub_tnx_type_code">
		  	<xsl:choose>
		    	<xsl:when test="$displaymode = 'view' and revolving_flag = 'Y' and sub_tnx_type_code[.!='06']">
	      			<xsl:call-template name="lc-revolving-details" />
		      	</xsl:when>
		      	<xsl:when test="$displaymode = 'edit' and sub_tnx_type_code[.!='06']">
					<div id="revolving-details" style="display:none;">
				      	<xsl:call-template name="lc-revolving-details" />
				    </div>
				</xsl:when>
		   	</xsl:choose>
	      </xsl:when>
	      <xsl:when test="$displaymode = 'view' and revolving_flag = 'Y'">
		  	<xsl:call-template name="lc-revolving-details" />
	      </xsl:when>
      </xsl:choose>
      
        <!-- Bank details -->
      <xsl:choose>
	      <xsl:when test="$swift2018Enabled and tnx_type_code[.='03']">
	      		<xsl:call-template name="lc-bank-details-amend"/> <!-- view after SWIFT2018 LC amendment -->
	   	  </xsl:when>
	   	 <xsl:otherwise>
	      		<xsl:choose>
	      			<xsl:when test="$swift2018Enabled"><xsl:call-template name="lc-bank-details-swift2018"/></xsl:when>
	      			<xsl:otherwise><xsl:call-template name="lc-bank-details"/></xsl:otherwise>
	      		</xsl:choose>    
	      </xsl:otherwise>
   	  </xsl:choose>
      <!-- 
       This template is used by Upload LC in view mode; we hide the following sections
       in this case. 
      --> 
      <xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
       <xsl:call-template name="lc-payment-details"/>
       <xsl:choose>
	       <xsl:when test="$swift2018Enabled and tnx_type_code[.='03']"> <!-- SWIFT2018 LC amendment -->
	       		<xsl:if test="ship_from[.!=''] and ship_loading[.!=''] and ship_discharge[.!=''] and ship_to[.!=''] and part_ship_detl[.!=''] and tran_ship_detl[.!=''] and last_ship_date[.!=''] and inco_term[.!=''] and inco_place[.!='']">
	       			<xsl:call-template name="lc-shipment-details-swift2018"/>
	       		</xsl:if>
	       </xsl:when>
	       <xsl:otherwise>
	      		<xsl:choose>
	      			<xsl:when test="$swift2018Enabled"><xsl:call-template name="lc-shipment-details-swift2018"/></xsl:when>
	      			<xsl:otherwise><xsl:call-template name="lc-shipment-details"/></xsl:otherwise>
	      		</xsl:choose>    
	       </xsl:otherwise>
       </xsl:choose>	
      </xsl:if>
      
    
      
      <xsl:choose>
	      <xsl:when test="$displaymode = 'view'">
	      	<xsl:choose>
	      	<xsl:when test="$mode = 'UNSIGNED' and //limit_details/limit_reference[.!='']  ">
			   	  	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	</xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 <xsl:if test="//limit_details/limit_reference[.!=''] and (prod_stat_code = '03' or prod_stat_code = '08') and //limit_details/booking_amt[.!=0] ">
		  	 	 	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	<xsl:with-param name="displayAmount">N</xsl:with-param>
			   	  	</xsl:call-template>
			   		 </xsl:if>
		  	 </xsl:otherwise>
		  	 </xsl:choose>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:if test="(defaultresource:getResource('SHOW_FACILITY_SECTION_FOR_TRADE_PRODUCTS') = 'true') and (utils:isFaciltyRequired($rundata,$product-code) = 'true')">     
		       <xsl:call-template name="build-facility-data"/> 
			     <div id = "facilityLimitDetail">
			   	  	<xsl:call-template name="facility-limit-section"/>
		   		 </div>
		  	  </xsl:if>
<script>
             dojo.ready(function(){
                     misys._config = misys._config || {};
                             misys._config.validate_tnxamt_with_limit_outstanding = <xsl:value-of select="defaultresource:getResource('VALIDATE_TNXAMT_WITH_LIMIT_OUTSTANDING') = 'true'"/>;
                     });
</script>		  	  
	   	 </xsl:otherwise>
	   	 
   	 </xsl:choose>
   	
   	 
  
   	 
   	 
   <xsl:if test="(securitycheck:hasPermission($rundata,'ls_access') and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true')">
   	  <xsl:call-template name="linked-ls-declaration"/>
	  <xsl:call-template name="linked-licenses"/>
   </xsl:if>
	   <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	    
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
			<xsl:with-param name="in-fieldset">N</xsl:with-param>
		</xsl:call-template>
	      </xsl:if>
	      
	  <xsl:if test= "$swift2018Enabled  and $displaymode = 'edit')">
      	<xsl:call-template name="lc-narrative-special-payments-beneficiary"/>
      </xsl:if>
	
      <xsl:if test="$displaymode = 'view'">
        <xsl:if test="narrative_charges[.!= '']">
                <div class="indented-header">
                   <h3 class="toc-item">
                      <span class="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_CHARGES')"/></span>
                   </h3>
                   <xsl:call-template name="textarea-field">
                      <xsl:with-param name="name">narrative_charges</xsl:with-param>
                   </xsl:call-template>
                </div>
        </xsl:if>
        
        
		<!-- 20170816_01 starts added lc narrative in view mode and moved free format text -->  
		<xsl:choose>
	        <xsl:when test = "$swift2018Enabled" >
	        	<xsl:call-template name = "previewModeExtendedNarrative"/>
		      	<xsl:call-template name="lc-narrative-period-swift2018">
	      		 	<xsl:with-param name="in-fieldset">N</xsl:with-param>
	     		 </xsl:call-template>		 	
	        </xsl:when>
	        <xsl:otherwise>
	        <xsl:call-template name="lc-narrative-period">
	                 <xsl:with-param name="in-fieldset">N</xsl:with-param>
	             </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
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
	    
	   
	      <!-- Narrative Period -->
	      <!-- above we have view mode, adding the condition for edit mode -->
	      <xsl:if test= "$displaymode = 'edit'">
	      <xsl:choose>
	      	<xsl:when test = "$swift2018Enabled" >
	      		 <xsl:call-template name="lc-narrative-period-swift2018">
	      		 	<xsl:with-param name="in-fieldset">N</xsl:with-param>
	     		 </xsl:call-template>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		 <xsl:call-template name="lc-narrative-period">
	      		 	<xsl:with-param name="in-fieldset">N</xsl:with-param>
	     		 </xsl:call-template>
	      	</xsl:otherwise>
	      </xsl:choose>
	      </xsl:if>
	      <!-- 20170816_01 ends -->
	         
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
      
      <!-- Bank Instructions -->
      <xsl:call-template name="bank-instructions">
      	<xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="$displaymode = 'view' and narrative_full_details != ''">
      	<xsl:call-template name="lc-narrative-full">
      		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      
	  <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
      
      <!-- comments for return -->
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
		
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>
    
    <!-- The form that's submitted -->
    <xsl:call-template name="realform"/>

    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
    <!-- Line Items declaration -->
  
   <xsl:call-template name="line-items-declaration" />
  
	<!-- Template to initialize the product and category map data for dynamic phrase. -->
	<xsl:call-template name="populate-phrase-data"/>
	   <xsl:call-template name="build-inco-terms-data"/>
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
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>

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
    <xsl:with-param name="binding">misys.binding.trade.create_lc</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
    <xsl:with-param name="override-help-access-key">LC_01</xsl:with-param>
   </xsl:call-template>
   <script type="text/javascript">
		dojo.ready(function(){
			misys._config.swiftExtendedNarrativeEnabled = <xsl:value-of select="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE')" />
			misys._config.isBank = <xsl:value-of select="security:isBank($rundata)"/>
		});
	</script>
  </xsl:template>
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="additional-fields">
     <xsl:if test="$displaymode='view'">
      <!-- This field is sent in the unsigned view -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">CREATE_OPTION</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
	</xsl:call-template>
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
	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">sub_product_code</xsl:with-param>				
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">tol_booking_amt</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">version</xsl:with-param>				
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
      <xsl:call-template name="common-general-details"/>
      <xsl:call-template name="lc-general-details"/>
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
       <xsl:with-param name="name">formLoad</xsl:with-param>
       <xsl:with-param name="value" select="$formLoad"/>
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
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>