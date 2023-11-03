<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

ISSUED STAND BY (ISB) Amendment Form, Customer Side.
 
 Note: Templates beginning with amend- are in amend_common.xsl

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
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization utils security defaultresource">
  
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
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
  
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_si_common_new.xsl" />
  <xsl:include href="../../core/xsl/common/amend_lc_common_new.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="si_tnx_record"/>
  </xsl:template>
  
  <!-- 
   SI AMEND TNX FORM TEMPLATE.
  -->
  <xsl:template match="si_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
      <xsl:with-param name="show-return">Y</xsl:with-param>
      <xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="build-inco-terms-data"/>
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details-new"/>
      <xsl:call-template name="amend-amt-details">
       <xsl:with-param name="show-release-flag">Y</xsl:with-param>
       <xsl:with-param name="show-os-amt">Y</xsl:with-param>
       <xsl:with-param name="show-standby">N</xsl:with-param>
       <xsl:with-param name="override-product-code">lc</xsl:with-param>
       <xsl:with-param name="tnx-record" select="org_previous_file/si_tnx_record"/>
      </xsl:call-template>
      <xsl:choose>
   	 <xsl:when test="$displaymode = 'edit'">
   	 <xsl:call-template name="amend-renewal-details"/>
   	 </xsl:when> 
   	 <xsl:when test="$displaymode = 'view' and $mode = 'UNSIGNED'">
   	 <xsl:if test="renew_flag[.='Y']">
      <xsl:call-template name="amend-renewal-details"/>
      </xsl:if>
   	 </xsl:when>
   	 <xsl:when test="$displaymode = 'view' and $mode != 'UNSIGNED'">
      <xsl:call-template name="amend-renewal-details"/>
   	 </xsl:when>
   	 </xsl:choose>
     <xsl:call-template name="lc-payment-details">									
       		<xsl:with-param name="required">Y</xsl:with-param>
	   </xsl:call-template>
      <xsl:call-template name="amend-shipment-details">
        <xsl:with-param name="tnx-record" select="org_previous_file/si_tnx_record"/>
      </xsl:call-template>
      <!-- Bank details -->
      <xsl:call-template name="amend-lc-bank-details"/>	
      <xsl:call-template name="standby-lc-details">
      	<xsl:with-param name="isAmend">Y</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	    
	      <!-- Narrative Details -->
	      <xsl:choose>
		      <xsl:when test="$swift2018Enabled">
		      	<xsl:call-template name="lc-narrative-swift-details">
				<xsl:with-param name="in-fieldset">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="lc-swift-narrative-special-payments-beneficiary"/>
		      </xsl:when>
		      <xsl:otherwise>
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
		      </xsl:otherwise>
	      </xsl:choose>

	     <!-- Narrative Period -->
	       <xsl:choose>
	      	<xsl:when test = "$swift2018Enabled" >
	      		 <xsl:call-template name="lc-narrative-period-swift2018">			<!-- from lc_common_swift_core -->
	      		 	<xsl:with-param name="in-fieldset">N</xsl:with-param>
	     		 </xsl:call-template>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		 <xsl:call-template name="lc-narrative-period">						<!-- from lc_common_core -->
	      		 	<xsl:with-param name="in-fieldset">N</xsl:with-param>
	     		 </xsl:call-template>
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
      </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="amend-narrative"/>
      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-required">N</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
       <xsl:with-param name="override-form-name">fakeform1</xsl:with-param>
      </xsl:call-template>
      
      
      <!-- Charges (hidden section) -->
      <!-- <xsl:for-each select="charges/charge">
       <xsl:call-template name="charge-details-hidden"/>
      </xsl:for-each> -->
       <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>

    <!-- Form #1 : Attach Files -->
   <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo">
   			<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
   			<xsl:with-param name="title-size">35</xsl:with-param>
   		</xsl:call-template>
    </xsl:if>

    <xsl:call-template name="realform"/>
	  <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
     <xsl:with-param name="show-template">N</xsl:with-param>
    </xsl:call-template>
   </div>
    
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
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
   
  <!-- Add the communication channel in the page (MT798 or standard)
	   Fields are switched depending on it -->
	   <xsl:if test="$displaymode='edit'">
	    <script>
	    	dojo.ready(function(){
	    		misys._config = misys._config || {};
				misys._config.customerBanksMT798Channel = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="customer_banks_communication_channel"/>
			});
		</script>
	   </xsl:if> 

	<xsl:call-template name="amendedNarrativesStore"/>
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
   <xsl:with-param name="binding">misys.binding.trade.amend_si_swift2018</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SI_03</xsl:with-param>
   <xsl:with-param name="show-period-js">Y</xsl:with-param>
  </xsl:call-template>
    <script type="text/javascript">
		dojo.ready(function(){
			misys._config.swiftExtendedNarrativeEnabled = <xsl:value-of select="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE')" />
		});
	</script>
 </xsl:template>

 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="override-product-code">lc</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
    <xsl:with-param name="value" select="issuing_bank/name"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
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
       <xsl:with-param name="name">narrative_period_presentation_nosend</xsl:with-param>
       <xsl:with-param name="value" select="narrative_period_presentation"/>
      </xsl:call-template>
  <xsl:if test="entity[. != '']">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">entity</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
   <xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_description_goods</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_description_goods"/>
   	</xsl:call-template> 
   	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_documents_required</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_documents_required"/>
   	</xsl:call-template> 
   	<xsl:call-template name="hidden-field">
      	<xsl:with-param name="name">org_narrative_additional_instructions</xsl:with-param>
      	<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_additional_instructions"/>
   	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
   		<xsl:with-param name="name">org_narrative_special_beneficiary</xsl:with-param>
   		<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_special_beneficiary"/>
    </xsl:call-template>
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
    </xsl:call-template>

    <!-- Original Shipment Fields -->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_from</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_from"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_loading</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_loading"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_discharge</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_discharge"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_to</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_to"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_last_ship_date</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/last_ship_date"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_narrative_additional_amount</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_additional_amount"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">product_code</xsl:with-param>				
	</xsl:call-template>
	<!-- Master Revolve fields -->
	<xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_revolve_time_no</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/revolve_time_no"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_revolve_frequency</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/revolve_frequency"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_revolve_period</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/revolve_period"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_next_revolve_date</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/next_revolve_date"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_notice_days</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/notice_days"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_charge_upto</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/charge_upto"/>
   </xsl:call-template>
  
   <!-- Master Shipment Fields -->
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_part_ship_detl</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/part_ship_detl"/>
    </xsl:call-template> 
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_tran_ship_detl</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/tran_ship_detl"/>
    </xsl:call-template> 
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_amd_date</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/amd_date"/>
   </xsl:call-template>
   <!--  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_inco_term</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/inco_term"/>
    </xsl:call-template> --> 
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_inco_place</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/inco_place"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_applicant_name</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/applicant_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_applicant_dom</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/applicant_dom"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_applicant_address_line_1</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/applicant_address_line_1"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_applicant_address_line_2</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/applicant_address_line_2"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_applicant_address_line_4</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/applicant_address_line_4"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_renew_on_code</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/renew_on_code"/>
    </xsl:call-template>
	<!-- Advise send mode master value-->
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_adv_send_mode</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/adv_send_mode"/>
     </xsl:call-template>
      <!-- Tolerance%  master value-->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_pstv_tol_pct</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/pstv_tol_pct"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_neg_tol_pct</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/neg_tol_pct"/>
     </xsl:call-template>
     <!-- Master Credit available by values -->
  	 <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_5</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
      <!-- Master Payment /Draft by values -->
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_tenor_type_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/tenor_type" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_tenor_type_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/tenor_type" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_tenor_type_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/tenor_type" />
     </xsl:call-template>
     <!-- Master Drawee details values -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_drawee_details_bank_name</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/drawee_details_bank/name"/>
     </xsl:call-template>
     <!-- Master Narrative field values -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_narrative_shipment_period</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_shipment_period"/>
   </xsl:call-template>
   	<xsl:call-template name="hidden-field">
      	<xsl:with-param name="name">org_narrative_period_presentation</xsl:with-param>
      	<xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_period_presentation"/>
   	</xsl:call-template> 
   	<xsl:call-template name="hidden-field">
      	<xsl:with-param name="name">org_amd_details</xsl:with-param>
      	<xsl:with-param name="value" select="org_previous_file/si_tnx_record/amd_details"/>
   	</xsl:call-template>
   	<!-- Master Credit available with Bank values -->
   	 <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_name</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/credit_available_with_bank/name"/>
     </xsl:call-template>
       <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_role_code</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/credit_available_with_bank/role_code" />
     </xsl:call-template>
     
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_address_line_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/credit_available_with_bank/address_line_1" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_address_line_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/credit_available_with_bank/address_line_2" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_address_line_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/credit_available_with_bank/address_line_4" />
     </xsl:call-template>
     <!-- Master Requested confirmation party values -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_req_conf_party_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/req_conf_party_flag" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_requested_confirmation_party_name</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/requested_confirmation_party/name" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_requested_confirmation_party_address_line_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/requested_confirmation_party/address_line_1" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_requested_confirmation_party_address_line_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/requested_confirmation_party/address_line_2" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_requested_confirmation_party_address_line_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/requested_confirmation_party/address_line_4" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_requested_confirmation_party_iso_code</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/requested_confirmation_party/iso_code" />
     </xsl:call-template>
      <!-- Master Form of LC values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_irv_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/irv_flag" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_renew_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/renew_flag" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_ntrf_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ntrf_flag" />
     </xsl:call-template>
       <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_trf_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/trf_flag" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_stnd_by_lc_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/stnd_by_lc_flag" />
     </xsl:call-template>
      <!-- Master Confirmation Instructions values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_inst_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cfm_inst_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_inst_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cfm_inst_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_inst_code_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cfm_inst_code" />
     </xsl:call-template>
      <!-- Master Issuing Bank charges values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_open_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/open_chrg_brn_by_code" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_open_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/open_chrg_brn_by_code" />
     </xsl:call-template>
      <!-- Master Outside country charges values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_corr_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/corr_chrg_brn_by_code" />
     </xsl:call-template>
        <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_corr_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/corr_chrg_brn_by_code" />
     </xsl:call-template>
      <!-- Master Confirmation charges values -->
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cfm_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/cfm_chrg_brn_by_code" />
     </xsl:call-template>
      <!-- Master Amend charges by values -->
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_standby_rule_code</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/standby_rule_code"/>
     </xsl:call-template>
     <!-- Type of stand by lc -->
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_product_type_code</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/si_tnx_record/product_type_code" />
     </xsl:call-template>
	
   </xsl:if>
  </div>
 </xsl:template>


 
 <!--
   SI General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details-new">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="button-type">summary-details</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">
      <!-- Hidden fields. -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">ref_id</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$displaymode='edit'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">appl_date</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">cust_ref_id</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">org_iss_date</xsl:with-param>
        <xsl:with-param name="value" select="org_previous_file/si_tnx_record/iss_date"/>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">org_exp_date</xsl:with-param>
        <xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
       </xsl:call-template>
        <!-- <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
	    </xsl:call-template> -->
	    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_name</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_address_line_1</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_address_line_1"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_address_line_2</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_address_line_2"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_address_line_4</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_address_line_4"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_dom</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_dom"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_country</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_country"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_beneficiary_reference</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/beneficiary_reference"/>
      </xsl:call-template>
      </xsl:if>
      <!--  System ID. -->
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="cust_ref_id[.!='']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
        <xsl:with-param name="id">general_cust_ref_id_view</xsl:with-param>
        <xsl:with-param name="value" select="cust_ref_id" />
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="id">org_previous_iss_date_view</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/iss_date"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
	  <!-- <xsl:if test="org_previous_file/si_tnx_record/exp_date[.!='']">
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
	       <xsl:with-param name="id">org_previous_exp_date_view</xsl:with-param>
	       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
	  </xsl:if> -->
	  <xsl:if test="$displaymode = 'edit' and $swift2019Enabled"> 
			<xsl:call-template name="select-field">
			<xsl:with-param name="label">GENERALDETAILS_NEW_EXPIRY_TYPE</xsl:with-param>
			<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			 <xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="options">
			<xsl:call-template name="exp-date-type-code-options"/>
		     </xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
		 <!-- Expiry Type Code -->
		<xsl:choose>
		    <xsl:when test="product_code[.='SI'] and $swift2019Enabled and $displaymode = 'view'">
		     <xsl:if test="lc_exp_date_type_code[.!='']">
				<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C085</xsl:variable>
					<xsl:choose>
			    		<xsl:when test="org_previous_file/si_tnx_record/lc_exp_date_type_code!=lc_exp_date_type_code"> 
						 <xsl:call-template name="input-field">
						 	<xsl:with-param name="label">GENERALDETAILS_NEW_EXPIRY_TYPE</xsl:with-param>
						 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
						 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
						 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
						 </xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
						  <xsl:call-template name="input-field">
						 	<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
						 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
						 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
						 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
						 </xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
		  
      <!--  Expiry Date. --> 
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
       <xsl:with-param name="name">exp_date</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="required">
	       <xsl:choose>
			<xsl:when test="$product-code='LC' or $product-code='EL'">Y</xsl:when>
			<xsl:when test="$product-code='SI' and ($swift2019Enabled and lc_exp_date_type_code='01')">Y</xsl:when>
			<xsl:when test="$product-code='SI' and $swift2019Enabled and (lc_exp_date_type_code='02' or lc_exp_date_type_code='03')">N</xsl:when>
			<xsl:when test="$product-code='SI' and $swift2018Enabled">Y</xsl:when>
			<xsl:otherwise>N</xsl:otherwise>
		   </xsl:choose>
   	  </xsl:with-param>
	    <xsl:with-param name="disabled">
	    	<xsl:choose>
	      		<xsl:when test="$product-code='SI' and $swift2019Enabled and lc_exp_date_type_code='03'">Y</xsl:when>
	      		<xsl:otherwise>N</xsl:otherwise>
	     	</xsl:choose>
	    </xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$swift2019Enabled and product_code[.='SI'] and $displaymode = 'edit' and security:isCustomer($rundata)">
	   <div id="exp-event" style="display:none;">
	 	<xsl:call-template name="row-wrapper">
	     <xsl:with-param name="id">exp_event</xsl:with-param>
	     <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_EVENT</xsl:with-param>
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
      
      <!-- Expiry place. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_PLACE</xsl:with-param>
    <xsl:with-param name="name">expiry_place</xsl:with-param>
    <xsl:with-param name="maxsize">29</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   <!-- Place of Jurisdiction and Governing Law -->
   <xsl:if test="product_code[.='SI'] and $swift2019Enabled and security:isCustomer($rundata)">
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
			<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_DEMAND_INDICATOR</xsl:with-param>
			      <xsl:with-param name="name">demand_indicator</xsl:with-param>
			      <xsl:with-param name="required">N</xsl:with-param>
			      <xsl:with-param name="fieldsize">large</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:call-template name="demand-indicator"/>
			      </xsl:with-param>
			</xsl:call-template>
			<xsl:if test="$displaymode = 'view'">
				<xsl:if test="demand_indicator[.!='']">
					<xsl:variable name="demand_indicator_code"><xsl:value-of select="demand_indicator"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C089</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_DEMAND_INDICATOR</xsl:with-param>
					 	<xsl:with-param name="name">demand_indicator</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $demand_indicator_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="ntrf_flag[.!=''] and ntrf_flag[.='N'] and narrative_transfer_conditions/text[.!='']">
				 <xsl:call-template name="input-field">
				 		<xsl:with-param name="label">TRANSFER_CONDITION</xsl:with-param>
					 	<xsl:with-param name="name">narrative_transfer_conditions</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="narrative_transfer_conditions/text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delv_org[.!='']">
					<xsl:variable name="delv_org_code"><xsl:value-of select="delv_org"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C083</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
					 	<xsl:with-param name="name">delv_org</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
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
					<xsl:variable name="delv_org_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C084</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
					 	<xsl:with-param name="name">delv_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
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
      
      <!--  Amendment Date. --> 
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
       <xsl:with-param name="name">amd_date</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">amd_no</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="amd_no"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$displaymode='view'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">amd_date</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </div>   
     		<!-- Applicant Details Field 50 Feb 2018 changes -->
     	 <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
    		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
    		<xsl:with-param name="content">
   				<xsl:call-template name="lc-changed-applicant-details" />
 			</xsl:with-param>
   		</xsl:call-template>
	    <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
	     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	     <xsl:with-param name="button-type"></xsl:with-param>
	     <xsl:with-param name="content">
	      <xsl:call-template name="address">
	       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
	       <xsl:with-param name="show-reference">Y</xsl:with-param>
	       <xsl:with-param name="required">Y</xsl:with-param>
	       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
	        <xsl:with-param name="show-country">Y</xsl:with-param>
	       <xsl:with-param name="button-content">
	          <xsl:call-template name="get-button">
		        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
		        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
		        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
		      </xsl:call-template>
	       </xsl:with-param>
	      </xsl:call-template>
	     </xsl:with-param>
	    </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>  
  </xsl:template> 
  
  <!--
   Hidden fields for Letter of Credit 
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
       <xsl:with-param name="value">03</xsl:with-param>
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
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   <script>
	   dojo.ready(function(){
		        	misys._config = misys._config || {};
					misys._config.release_flag = <xsl:value-of select="defaultresource:getResource('AMEND_RELEASE_FLAG')"/>;	
				});
	</script>
  </xsl:template>
</xsl:stylesheet>