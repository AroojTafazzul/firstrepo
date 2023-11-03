<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all SWIFT 2018 format Letter of Credit forms (i.e. LC, SI, EL, SR) are defined in this xsl

Copyright (c) 2017-2018 Finastra ,
All Rights Reserved. 

version:   1.0
date:      11/09/2017
author:    Avilash Ghosh
email:     avilash.ghosh@misys.com
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
  xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization utils security defaultresource">

<!-- 
  	*******************************************************FRONT OFFICE TEMPLATES ARE PLACED BELOW*******************************************************
  	*****************************************************************************************************************************************************
 -->
	<xsl:variable name="isSiStructuredFormatAccess">
		<xsl:if test="securitycheck:hasPermission($rundata,'si_create_structured_format') = 'true'">Y</xsl:if>
	</xsl:variable>
  <!--
   Shipment Details section for LC,SI FO
   -->
 <xsl:template name="lc-shipment-details-swift2018">
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
        	<xsl:when test="part_ship_detl[. = '' or . = 'NONE']"></xsl:when>
       		<xsl:otherwise>CONDITIONAL</xsl:otherwise>
       	</xsl:choose>	  
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">    	 
       	 <option/>
         <option value="ALLOWED">
         	 <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          	<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
         <option value="CONDITIONAL">
	       	 <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/>       	 	
	     </option>
        </xsl:when>
        <xsl:otherwise>
        <xsl:if test="part_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="part_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = '' or . = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
          <!--Todoswift2018 : 'None' to be replaced with blank in the condition and value too must be blank post migration-->
          <xsl:when test="part_ship_detl[. = '']"></xsl:when>
          <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' ]"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/></xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="infoMessagePartialShipment"></xsl:call-template>       
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="product_code = 'SI'">
	     <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">purpose</xsl:with-param>
	       <xsl:with-param name="value">ISSU</xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
    
     <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL_LC</xsl:with-param>
      <xsl:with-param name="id">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
      <xsl:choose>
      		 <xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       		 <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        	 <xsl:when test="tran_ship_detl[. = '' or . = 'NONE']"></xsl:when>
       		<xsl:otherwise>CONDITIONAL</xsl:otherwise>
      </xsl:choose>   
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">      	 
       	  <option/>
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	      <option value="CONDITIONAL">
	       	 <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/>       	 	
	      </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:if test="tran_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = '']"></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/></xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>

    <xsl:call-template name="infoMessageTranshipment"></xsl:call-template>  
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="swift-validate">N</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
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
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$product-code='LC'  and ($displaymode='edit' or ($displaymode='view' and transport_mode[.!='']))">
    	 <xsl:call-template name="transport-mode-fields"/>
     </xsl:if>           
    </xsl:with-param>    
   </xsl:call-template>       
  </xsl:template>
  
  
  
   <!--
   Narrative Period Tabgroup for LC,SI FO
   
   Tab0 - Period for Presentation in SWIFT 2018 format
   Tab1 - Shipment Period
   Tab2 - Additional Amount
   -->
  <xsl:template name="lc-narrative-period-swift2018">
   <!-- Tabgroup #2 : Narrative Period (3 Tabs) -->
	<xsl:param name="in-fieldset">Y</xsl:param>

   <xsl:call-template name="tabgroup-wrapper">
   	<xsl:with-param name="tabgroup-height">180px;</xsl:with-param>
   	<xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-period-tabcontainer</xsl:with-param>
    
    <!-- Tab 0 - Period Presentation  -->
    <xsl:with-param name="tab0-label">XSL_TAB_PERIOD_PRESENTATION_IN_DAYS</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
    <span> 
    <xsl:if test="$rundata!='' ">
    	<xsl:call-template name="localization-dblclick">
			<xsl:with-param name="xslName">XSL_PERIOD_NO_OF_DAYS</xsl:with-param>
			<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_PERIOD_NO_OF_DAYS')" />
		</xsl:call-template>
	</xsl:if>	
    <xsl:if test="$displaymode='edit'"> 
	<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>
	<div class="x-small" maxLength="3" dojoType="dijit.form.NumberTextBox"
		trim="true">
		<xsl:attribute name="id">period_presentation_days</xsl:attribute>
		<xsl:attribute name="name">period_presentation_days</xsl:attribute>
		<xsl:attribute name="value"><xsl:value-of select="period_presentation_days"/></xsl:attribute>
		<xsl:attribute name="constraints">{places:'0',min:0, max:999}</xsl:attribute>
	</div>
	</xsl:if>
	<xsl:if test="period_presentation_days[.!=''] and $displaymode='view'">
	<div>
	<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>&nbsp; 
	 <b><xsl:value-of select="period_presentation_days"/></b>	
	 </div>	
	</xsl:if>
	</span>
	<span>
	 <xsl:if test="$rundata!='' ">
		<xsl:call-template name="localization-dblclick">
			<xsl:with-param name="xslName">XSL_TAB_PERIOD_DESCRIPTION</xsl:with-param>
			<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_TAB_PERIOD_DESCRIPTION')" />
		</xsl:call-template>
	</xsl:if>	
	 <xsl:if test="$displaymode='edit'">
	  <div>
	 <xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/> 
       </div>   
     <div>
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="maxlines">1</xsl:with-param>
     </xsl:call-template>
     </div>
     </xsl:if>
      <xsl:if test="narrative_period_presentation[.!=''] and $displaymode='view'">
      <div>
	<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/>&nbsp; 
	 <b><xsl:value-of select="narrative_period_presentation"/></b>	
	 </div>	
	</xsl:if>
	</span>
    </xsl:with-param>
    
    <!-- Tab 1 - Shipment Period  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
      <xsl:with-param name="messageValue"><xsl:value-of select="narrative_shipment_period/text"/></xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Amount  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="maxlines">4</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
  <!--
   Bank Details Tabgroup section for LC,SI FO
   
   Tab0 - Issuing Bank
   Tab1 - Advising Bank
   Tab2 - Advise Thru Bank
   Tab3 -Requested Confirmation Party
   -->
  <xsl:template name="lc-bank-details-swift2018">
   <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS_LC</xsl:with-param>
    <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">215px</xsl:with-param>

    <!-- Tab 0_0 - Issuing Bank  -->
    <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:call-template name="issuing-bank-tabcontent"/>
    </xsl:with-param>
     
    <!-- Tab 0_1 - Advising Bank -->
    <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
    <xsl:with-param name="tab1-content">
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and (advising_bank/name !=''  or advising_bank/iso_code !=''))">
	    <div id="advising-bank-details">
	       <xsl:apply-templates select="advising_bank">
	        <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
	        <xsl:with-param name="swift-required">Y</xsl:with-param>
	       </xsl:apply-templates>
		</div>
	 </xsl:if>
    </xsl:with-param>
     
    <!-- Tab 0_2 - Advise Thru Bank -->
    <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
    <xsl:with-param name="tab2-content">
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and (advise_thru_bank/name !=''  or advise_thru_bank/iso_code !=''))">
	    <div id="advise-thru-bank-details">
	       <xsl:apply-templates select="advise_thru_bank">
	        <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
	        <xsl:with-param name="swift-required">Y</xsl:with-param>
	       </xsl:apply-templates>
		 </div>
	 </xsl:if>
    </xsl:with-param>
    <!-- Tab 0_3 - Requested Confirmation Party ILC--> 
    <xsl:with-param name="tab3-label">XSL_BANKDETAILS_TAB_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>  
	    <xsl:with-param name="tab3-content">
    	<xsl:call-template name="requestedConfirmationPartyTabSection"></xsl:call-template>  
    </xsl:with-param>
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
  </xsl:template>
  
  
  
  <!--
   Bank Details Tabgroup section for LC Amendment SWIFT2018
   Only requested confirmation part is required
   Tab0 - Requested Confirmation Party
   -->
  <xsl:template name="lc-bank-details-amend">
   <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-label"> 
    <xsl:choose>
		<xsl:when test="$product-code = 'LC'">XSL_HEADER_BANK_DETAILS_LC</xsl:when>    
		<xsl:otherwise>XSL_HEADER_BANK_DETAILS</xsl:otherwise>
    </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">215px</xsl:with-param>

    <!-- Tab 0_3 - Requested Confirmation Party ILC--> 
    <xsl:with-param name="tab3-label">XSL_BANKDETAILS_TAB_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>  
	    <xsl:with-param name="tab3-content">
    	<xsl:call-template name="requestedConfirmationPartyTabSection"></xsl:call-template>  
    </xsl:with-param>
   </xsl:call-template>   
  </xsl:template>
  
   <!--
   Receipt of Bank Messages from Backoffice/TI for view in Front office view page
   Added as part of SWIFT 2018 changes
   1.Special payment conditions for Beneficiary
   2.Special payment conditions for Receiving Bank.
   3.Payment instructions
   -->
  <xsl:template name="lc-bank-receipt">
   <xsl:call-template name="tabgroup-wrapper">
     <xsl:with-param name="tabgroup-height">180px</xsl:with-param> 
     <!-- Tab 1 - Special payment conditions for Beneficiary -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
      <xsl:with-param name="maxlines">100</xsl:with-param>
      <xsl:with-param name="messageValue"><xsl:value-of select="narrative_special_beneficiary"/></xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    <!-- Tab 2 - Special payment conditions for Receiving Bank -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_special_recvbank</xsl:with-param>
      <xsl:with-param name="maxlines">100</xsl:with-param>
      <xsl:with-param name="messageValue"><xsl:value-of select="narrative_special_recvbank"/></xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     <!-- Tab _3 - Payment Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab2-content"> 
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
      <xsl:with-param name="cols">65</xsl:with-param>
      <xsl:with-param name="rows">12</xsl:with-param>
      <xsl:with-param name="maxlines">12</xsl:with-param>
     </xsl:call-template> 
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
   <xsl:template name="lc-narrative-swift-details">
   <xsl:param name="documents-required-required">N</xsl:param>
   <xsl:param name="description-goods-required">Y</xsl:param>
   <xsl:param name="in-fieldset">Y</xsl:param>
   
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-label">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">450px;</xsl:with-param>
    
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="tab0-content">
    <div style="display:none">&nbsp;</div>
    <div id="tabNarrativeDescriptionGoods" style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block" attribute="status: true">
   		<div id="narrativeDescriptionGoods" style="width:675px;">
   		<xsl:if test="narrative_description_goods/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_description_goods/issuance/data/datum/text, 6)" />
				</p>
			</div>
			</div>
		</xsl:if>
   		<xsl:if test="narrative_description_goods/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="narrative_description_goods/amendments/amendment">
			<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
		</div>
   		<xsl:if test="narrative_master_description_goods/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_description_goods/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_description_goods/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
			<xsl:for-each select="//*/narrative_master_description_goods/amendments/amendment">
				<div class="indented-header" style="width:675px;" align="left">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
		</xsl:if>
		
	</div>
	<div style=" display: inline-block;vertical-align:top">  
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_goods</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_goods"/>
	      <xsl:with-param name="widget-name">narrative_amend_goods</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_goods_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_goods"/>
	      <xsl:with-param name="widget-name">narrative_amend_goods</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
    		<xsl:with-param name="id">narrative_description_goods</xsl:with-param>
   			<xsl:with-param name="name">narrative_description_goods</xsl:with-param>
   			<xsl:with-param name="value" select="org_narratives/narrative_description_goods"/>
  	   </xsl:call-template> 
	</div>
  	</xsl:with-param>
    <!-- Tab 1 - Documents Required  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
    <xsl:with-param name="tab1-content">
    <div style="display:none">&nbsp;</div>
    <div id="tabNarrativeDocumentsRequired" style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block" attribute="status: true">
   		<div id="narrativeDocumentsRequired" style="width:675px;">
   		<xsl:if test="narrative_documents_required/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_documents_required/issuance/data/datum/text, 6)" />
				</p>
			</div>
			</div>
		</xsl:if>
   		<xsl:if test="narrative_documents_required/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="narrative_documents_required/amendments/amendment">
			<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
		</div>
   		<xsl:if test="narrative_master_documents_required/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_documents_required/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_documents_required/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
			<xsl:for-each select="//*/narrative_master_documents_required/amendments/amendment">
				<div class="indented-header" style="width:675px;" align="left">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top">  
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_docs</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_docs"/>
	      <xsl:with-param name="widget-name">narrative_amend_docs</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_docs_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_docs"/>
	      <xsl:with-param name="widget-name">narrative_amend_docs</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
    		<xsl:with-param name="id">narrative_documents_required</xsl:with-param>
   			<xsl:with-param name="name">narrative_documents_required</xsl:with-param>
   			<xsl:with-param name="value" select="org_narratives/narrative_documents_required"/>
  	 
  	   </xsl:call-template> 
	</div>
    </xsl:with-param>
    
     
    <!-- Tab 2 - Additional Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
	<xsl:with-param name="tab2-content">
	<div style="display:none">&nbsp;</div>
    <div id="tabNarrativeAdditionalInstructions" style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block" attribute="status: true">
   		<div id="narrativeAdditionalInstructions" style="width:675px;">
   		<xsl:if test="narrative_additional_instructions/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_additional_instructions/issuance/data/datum/text, 6)" />
				</p>
			</div>
			</div>
		</xsl:if>
   		<xsl:if test="narrative_additional_instructions/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="narrative_additional_instructions/amendments/amendment">
			<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
		</div>
   		<xsl:if test="narrative_master_additional_instructions/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_additional_instructions/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_additional_instructions/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
			<xsl:for-each select="//*/narrative_master_additional_instructions/amendments/amendment">
				<div class="indented-header" style="width:675px;" align="left">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top">  
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_instructions</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_instructions"/>
	      <xsl:with-param name="widget-name">narrative_amend_instructions</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_instructions_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_instructions"/>
	      <xsl:with-param name="widget-name">narrative_amend_instructions</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
    		<xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
   			<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
   			<xsl:with-param name="value" select="org_narratives/narrative_additional_instructions"/>
  	   </xsl:call-template> 
	</div>
	</xsl:with-param>     
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="previewModeExtendedNarrative">
  		<xsl:variable name="goodsDescription">
			<xsl:if test = "//narrative_description_goods/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_description_goods/amendments/amendment">
				<xsl:for-each select="narrative_description_goods/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>
			<xsl:if test = "//narrative_master_description_goods/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_master_description_goods/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_master_description_goods/amendments/amendment">
				<xsl:for-each select="narrative_master_description_goods/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>	
		</xsl:variable>
		<xsl:variable name="documentsRequired">
			<xsl:if test = "//narrative_documents_required/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_documents_required/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_documents_required/amendments/amendment">
				<xsl:for-each select="narrative_documents_required/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>
			<xsl:if test = "//narrative_master_documents_required/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_master_documents_required/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_master_documents_required/amendments/amendment">
				<xsl:for-each select="narrative_master_documents_required/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>		
		</xsl:variable>
		<xsl:variable name="additionalInstructions">
			<xsl:if test = "//narrative_additional_instructions/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_additional_instructions/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_additional_instructions/amendments/amendment">
				<xsl:for-each select="narrative_additional_instructions/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>
			<xsl:if test = "//narrative_master_additional_instructions/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_master_additional_instructions/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_master_additional_instructions/amendments/amendment">
				<xsl:for-each select="narrative_master_additional_instructions/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>			
		</xsl:variable>
		<xsl:variable name="beneficiaryConf">
			<xsl:if test = "//narrative_special_beneficiary/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_special_beneficiary/amendments/amendment">
				<xsl:for-each select="narrative_special_beneficiary/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>
			<xsl:if test = "//narrative_master_special_beneficiary/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_master_special_beneficiary/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_master_special_beneficiary/amendments/amendment">
				<xsl:for-each select="narrative_master_special_beneficiary/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>		
		</xsl:variable>
		<xsl:variable name="receivingBank">
			<xsl:if test = "//narrative_special_recvbank/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_special_recvbank/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_special_recvbank/amendments/amendment">
				<xsl:for-each select="narrative_special_recvbank/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>
			<xsl:if test = "//narrative_master_special_recvbank/issuance/data/datum/text != ''">
	  			&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;
	  			<xsl:value-of select="//narrative_master_special_recvbank/issuance/data/datum/text"/>
	  		</xsl:if>
			<xsl:if test="narrative_master_special_recvbank/amendments/amendment">
				<xsl:for-each select="narrative_master_special_recvbank/amendments/amendment">
					&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>	
		</xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS</xsl:with-param>
	    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	    <xsl:with-param name="id">narrative_description_goods</xsl:with-param>
	    <xsl:with-param name="button-type">extended-narrative</xsl:with-param>
	    <xsl:with-param name="messageValue">
	    	<xsl:value-of select="$goodsDescription"/>
	    </xsl:with-param>
	    <xsl:with-param name="content">
    	<xsl:if test="//narrative_description_goods/issuance and //narrative_description_goods/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
				<p style="white-space: pre-wrap;width:100%;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_description_goods/issuance/data/datum/text, 6)" />
				</p>
		</xsl:if>
   		<xsl:if test="narrative_description_goods/amendments/amendment">
		<xsl:for-each select="/*/narrative_description_goods/amendments/amendment">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<p style="width:100%;">
					<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
					<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
					<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b><xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)"/><xsl:if test="response[.='Rejected']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REJECTED')"/></xsl:if>
				</p>
			</xsl:for-each>
		</xsl:for-each>
		</xsl:if>
		<xsl:if test="narrative_master_description_goods/issuance and narrative_master_description_goods/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
				<p style="white-space: pre-wrap;width:100%;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_description_goods/issuance/data/datum/text, 6)" />
				</p>
		</xsl:if>
   		<xsl:if test="narrative_master_description_goods/amendments/amendment">
		<xsl:for-each select="//*/narrative_master_description_goods/amendments/amendment">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<p style="white-space: pre-wrap;width:100%;">
					<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
					<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
					<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
				</p>
			</xsl:for-each>
		</xsl:for-each>
		</xsl:if>
	    </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="not(security:isBank($rundata)) and (product_code [.= 'LC'] or product_code [.= 'SI']) and $displaymode='view'  and defaultresource:getResource('PURCHASE_ORDER_ASSISTANT') = 'true'">
   			 <xsl:call-template name="purchase-order-view-mode"/>
   			 </xsl:if>
    <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
	    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	    <xsl:with-param name="id">narrative_documents_required</xsl:with-param>
	    <xsl:with-param name="button-type">extended-narrative</xsl:with-param>
	    <xsl:with-param name="messageValue">
	    	<xsl:value-of select="$documentsRequired"/>
	    </xsl:with-param>
	    <xsl:with-param name="content">
	    	<xsl:if test="//narrative_documents_required/issuance and //narrative_documents_required/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
				<p style="white-space: pre-wrap;width:100%;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_documents_required/issuance/data/datum/text, 6)" />
				</p>
		</xsl:if>
   		<xsl:if test="narrative_documents_required/amendments/amendment">
		<xsl:for-each select="/*/narrative_documents_required/amendments/amendment">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<p style="width:100%;">
					<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
					<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
					<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)"/><xsl:if test="response[.='Rejected']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REJECTED')"/></xsl:if>
				</p>
			</xsl:for-each>
		</xsl:for-each>
		</xsl:if>
		<xsl:if test="narrative_master_documents_required/issuance and narrative_master_documents_required/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
				<p style="white-space: pre-wrap;width:100%;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_documents_required/issuance/data/datum/text, 6)" />
				</p>
		</xsl:if>
   		<xsl:if test="narrative_master_documents_required/amendments/amendment">
		<xsl:for-each select="//*/narrative_master_documents_required/amendments/amendment">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<p style="white-space: pre-wrap;width:100%;">
					<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
					<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
					<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
				</p>
			</xsl:for-each>
		</xsl:for-each>
		</xsl:if>
	    </xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
	    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	    <xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
	    <xsl:with-param name="button-type">extended-narrative</xsl:with-param>
	    <xsl:with-param name="messageValue">
	    	<xsl:value-of select="$additionalInstructions"/>
	    </xsl:with-param>
	    <xsl:with-param name="content">
    		<xsl:if test="//narrative_additional_instructions/issuance and //narrative_additional_instructions/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<p style="white-space: pre-wrap;width:100%;">
				<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_additional_instructions/issuance/data/datum/text, 6)" />
			</p>
		</xsl:if>
   		<xsl:if test="narrative_additional_instructions/amendments/amendment">
		<xsl:for-each select="/*/narrative_additional_instructions/amendments/amendment">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
			<p style="width:100%;">
				<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
				<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
				<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)"/><xsl:if test="response[.='Rejected']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REJECTED')"/></xsl:if>
			</p>
			</xsl:for-each>
		</xsl:for-each>
		</xsl:if>
		<xsl:if test="narrative_master_additional_instructions/issuance and narrative_master_additional_instructions/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<p style="white-space: pre-wrap;width:100%;">
				<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_additional_instructions/issuance/data/datum/text, 6)" />
			</p>
		</xsl:if>
   		<xsl:if test="narrative_master_additional_instructions/amendments/amendment">
		<xsl:for-each select="//*/narrative_master_additional_instructions/amendments/amendment">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
			<p style="white-space: pre-wrap;width:100%;">
				<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
				<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
				<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
			</p>
			</xsl:for-each>
		</xsl:for-each>
		</xsl:if>
	    </xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
	    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	    <xsl:with-param name="id">narrative_special_beneficiary</xsl:with-param>
	    <xsl:with-param name="button-type">extended-narrative</xsl:with-param>
	    <xsl:with-param name="messageValue">
	    	<xsl:value-of select="$beneficiaryConf"/>
	    </xsl:with-param>
	    <xsl:with-param name="content">
    		<xsl:if test="//narrative_special_beneficiary/issuance and //narrative_special_beneficiary/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<p style="white-space: pre-wrap;width:100%;">
				<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_special_beneficiary/issuance/data/datum/text, 6)" />
			</p>
			</xsl:if>
	   		<xsl:if test="narrative_special_beneficiary/amendments/amendment">
			<xsl:for-each select="/*/narrative_special_beneficiary/amendments/amendment">
				<div class="indented-header">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
				<p style="width:100%;">
					<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
					<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
					<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)"/><xsl:if test="response[.='Rejected']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REJECTED')"/></xsl:if>
				</p>
				</xsl:for-each>
			</xsl:for-each>
			</xsl:if>
			<xsl:if test="narrative_master_special_beneficiary/issuance and narrative_master_special_beneficiary/issuance/data/datum/text[.!='']">
			<div class="indented-header">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<p style="white-space: pre-wrap;width:100%;">
				<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_special_beneficiary/issuance/data/datum/text, 6)" />
			</p>
			</xsl:if>
	   		<xsl:if test="narrative_master_special_beneficiary/amendments/amendment">
			<xsl:for-each select="//*/narrative_master_special_beneficiary/amendments/amendment">
				<div class="indented-header">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
				<p style="white-space: pre-wrap;width:100%;">
					<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
					<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
					<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
				</p>
				</xsl:for-each>
			</xsl:for-each>
			</xsl:if>
	    </xsl:with-param>
	</xsl:call-template>
	<xsl:if test="security:isBank($rundata)">
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV</xsl:with-param>
		    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		    <xsl:with-param name="id">narrative_special_recvbank</xsl:with-param>
		    <xsl:with-param name="button-type">extended-narrative</xsl:with-param>
		    <xsl:with-param name="messageValue">
		    	<xsl:value-of select="$receivingBank"/>
		    </xsl:with-param>
		    <xsl:with-param name="content">
	    		<xsl:if test="//narrative_special_recvbank/issuance and //narrative_special_recvbank/issuance/data/datum/text[.!='']">
					<div class="indented-header">
						<h3 class="toc-item">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
						</h3>
					</div>
					<p style="white-space: pre-wrap;width:100%;">
						<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_special_recvbank/issuance/data/datum/text, 6)" />
					</p>
				</xsl:if>
		   		<xsl:if test="narrative_special_recvbank/amendments/amendment">
					<xsl:for-each select="/*/narrative_special_recvbank/amendments/amendment">
						<div class="indented-header">
							<h3 class="toc-item">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
							</h3>
						</div>
						<xsl:for-each select="data/datum">
						<p style="width:100%;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)"/><xsl:if test="response[.='Rejected']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REJECTED')"/></xsl:if>
						</p>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="narrative_master_special_recvbank/issuance and narrative_master_special_recvbank/issuance/data/datum/text[.!='']">
					<div class="indented-header">
						<h3 class="toc-item">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
						</h3>
					</div>
					<p style="white-space: pre-wrap;width:100%;">
						<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_special_recvbank/issuance/data/datum/text, 6)" />
					</p>
				</xsl:if>
		   		<xsl:if test="narrative_master_special_recvbank/amendments/amendment">
					<xsl:for-each select="//*/narrative_master_special_recvbank/amendments/amendment">
						<div class="indented-header">
							<h3 class="toc-item">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
							</h3>
						</div>
						<xsl:for-each select="data/datum">
						<p style="white-space: pre-wrap;width:100%;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
		    </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
  </xsl:template> 
  
  <!-- SWIFT2018 View mode Extended narrative -->
  <xsl:template name="viewModeExtendedNarrative">
	 <xsl:if test="//narrative_description_goods/issuance/data/datum/text[.!= '']">
		<xsl:variable name="messageValue">
			<xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/>
		</xsl:variable>
		<div class="indented-header">
			<h3 class="toc-item">
				<span class="legend">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
					<xsl:call-template name="get-button">
						<xsl:with-param name="button-type">extended-narrative</xsl:with-param>
						<xsl:with-param name="id">narrative_description_goods</xsl:with-param>
						<xsl:with-param name="messageValue">
							<xsl:value-of select="$messageValue"/>
						</xsl:with-param>
						<xsl:with-param name="non-dijit-button">Y</xsl:with-param>
					</xsl:call-template>
				</span>
			</h3>

			<xsl:call-template name="textarea-field">
				<xsl:with-param name="name">narrative_description_goods</xsl:with-param>
				<xsl:with-param name="messageValue">
					<xsl:value-of select="convertTools:displaySwiftNarrative($messageValue, 12)"/>
				</xsl:with-param>
			</xsl:call-template>

		</div>
	</xsl:if>

	<xsl:if test="//narrative_documents_required/issuance/data/datum/text[.!= '']">
		<xsl:variable name="messageValue">
			<xsl:value-of select="//narrative_documents_required/issuance/data/datum/text"/>
		</xsl:variable>

		<div class="indented-header">
			<h3 class="toc-item">
				<span class="legend">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
					<xsl:call-template name="get-button">
						<xsl:with-param name="button-type">extended-narrative</xsl:with-param>
						<xsl:with-param name="id">narrative_documents_required</xsl:with-param>
						<xsl:with-param name="messageValue">
							<xsl:value-of select="$messageValue"/>
						</xsl:with-param>
						<xsl:with-param name="non-dijit-button">Y</xsl:with-param>
					</xsl:call-template>
				</span>
			</h3>
			<xsl:call-template name="textarea-field">
				<xsl:with-param name="name">narrative_documents_required</xsl:with-param>
				<xsl:with-param name="messageValue">
					<xsl:value-of select="convertTools:displaySwiftNarrative($messageValue, 12)"/>
				</xsl:with-param>

			</xsl:call-template>
		</div>
	</xsl:if>

	<xsl:if test="//narrative_additional_instructions/issuance/data/datum/text[.!= '']">
		<xsl:variable name="messageValue">
			<xsl:value-of select="//narrative_additional_instructions/issuance/data/datum/text"/>
		</xsl:variable>
		<div class="indented-header">
			<h3 class="toc-item">
				<span class="legend">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
					<xsl:call-template name="get-button">
						<xsl:with-param name="button-type">extended-narrative</xsl:with-param>
						<xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
						<xsl:with-param name="messageValue">
							<xsl:value-of select="$messageValue"/>
						</xsl:with-param>
						<xsl:with-param name="non-dijit-button">Y</xsl:with-param>
					</xsl:call-template>
				</span>
			</h3>

			<xsl:call-template name="textarea-field">
				<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
				<xsl:with-param name="messageValue">
					<xsl:value-of select="convertTools:displaySwiftNarrative($messageValue, 12)"/>
				</xsl:with-param>
			</xsl:call-template>

		</div>
	</xsl:if>
	<xsl:if test="//narrative_special_beneficiary/issuance/data/datum/text[.!= '']">
				<xsl:variable name="messageValue">
					<xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/>
				</xsl:variable>
				<div class="indented-header">
					<h3 class="toc-item">
						<span class="legend">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
							<xsl:call-template name="get-button">
								<xsl:with-param name="button-type">extended-narrative</xsl:with-param>
								<xsl:with-param name="id">narrative_special_beneficiary</xsl:with-param>
								<xsl:with-param name="messageValue">
									<xsl:value-of select="$messageValue"/>
								</xsl:with-param>
								<xsl:with-param name="non-dijit-button">Y</xsl:with-param>
							</xsl:call-template>
						</span>
					</h3>

					<xsl:call-template name="textarea-field">
						<xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
						<xsl:with-param name="messageValue">
							<xsl:value-of select="convertTools:displaySwiftNarrative($messageValue, 12)"/>
						</xsl:with-param>
					</xsl:call-template>

				</div>
			</xsl:if>
			<xsl:if test="//narrative_special_recvbank/issuance/data/datum/text[.!= ''] and (security:isBank($rundata))">
				<xsl:variable name="messageValue">
					<xsl:value-of select="//narrative_special_recvbank/issuance/data/datum/text"/>
				</xsl:variable>
				<div class="indented-header">
					<h3 class="toc-item">
						<span class="legend">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
							<xsl:call-template name="get-button">
								<xsl:with-param name="button-type">extended-narrative</xsl:with-param>
								<xsl:with-param name="id">narrative_special_recvbank</xsl:with-param>
								<xsl:with-param name="messageValue">
									<xsl:value-of select="$messageValue"/>
								</xsl:with-param>
								<xsl:with-param name="non-dijit-button">Y</xsl:with-param>
							</xsl:call-template>
						</span>
					</h3>

					<xsl:call-template name="textarea-field">
						<xsl:with-param name="name">narrative_special_recvbank</xsl:with-param>
						<xsl:with-param name="messageValue">
							<xsl:value-of select="convertTools:displaySwiftNarrative($messageValue, 12)"/>
						</xsl:with-param>
					</xsl:call-template>

				</div>
			</xsl:if>
  </xsl:template>
  
  <xsl:template name="bank-details-swift2018">
 
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS_LC</xsl:with-param>
   <xsl:with-param name="tabgroup-height">215px</xsl:with-param>
   
   
   		<!-- Tab 1_0 - issuing Bank  -->
	   <xsl:with-param name="tab0-label"><xsl:if test="$displaymode != 'edit'">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:if></xsl:with-param>
	   <xsl:with-param name="tab0-content"><xsl:if test="$displaymode != 'edit'">
	    <xsl:apply-templates select="issuing_bank">
	      <xsl:with-param name="prefix" select="'issuing_bank'"/>
	     <xsl:with-param name="disabled">
	     	<xsl:choose>
	     		<xsl:when test="tnx_type_code[.='03'] or (tnx_type_code[.='15'] and prod_stat_code[.='08']) ">Y</xsl:when>
	     		<xsl:otherwise>N</xsl:otherwise>
	   		</xsl:choose>
	   	</xsl:with-param>
	   	<xsl:with-param name="swift-required">Y</xsl:with-param>
	    </xsl:apply-templates>
	    </xsl:if>
	   </xsl:with-param>

	   <!-- Tab 1_1 - Advising Bank  -->
	   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
	   <xsl:with-param name="tab1-content">
	    <xsl:apply-templates select="advising_bank">
	     <xsl:with-param name="prefix">advising_bank</xsl:with-param>
	     <xsl:with-param name="disabled">
	     	<xsl:choose>
	     		<xsl:when test="tnx_type_code[.='03'] or (tnx_type_code[.='15'] and prod_stat_code[.='08']) ">Y</xsl:when>
	     		<xsl:otherwise>N</xsl:otherwise>
	   		</xsl:choose>
	   	</xsl:with-param>
	   	<xsl:with-param name="swift-required">Y</xsl:with-param>
	    </xsl:apply-templates>
	   </xsl:with-param>
	    
	   <!-- Tab 1_2 - Advise Thru Bank  -->
	   <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
	   <xsl:with-param name="tab2-content">
	    <xsl:apply-templates select="advise_thru_bank">
	     <xsl:with-param name="prefix">advise_thru_bank</xsl:with-param>
	     <xsl:with-param name="disabled">
	     	<xsl:choose>
	     		<xsl:when test="tnx_type_code[.='03'] or (tnx_type_code[.='15'] and prod_stat_code[.='08'])">Y</xsl:when>
	     		<xsl:otherwise>N</xsl:otherwise>
	   		</xsl:choose>
	     </xsl:with-param>
	     <xsl:with-param name="swift-required">Y</xsl:with-param>
	    </xsl:apply-templates>
	   </xsl:with-param>
	
   
   <!-- Tab 1_3 - Requested Confirmation Party ILC  -->
   <xsl:with-param name="tab3-label">XSL_BANKDETAILS_TAB_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
   <xsl:with-param name="tab3-content">
   <xsl:choose>
    	 <xsl:when test="$displaymode='edit'">
    	   <div id="req_conf_party_flag_div">
           <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
           <xsl:with-param name="name">req_conf_party_flag</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="options">     
		            <option value="Advising Bank">
		             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
		            </option>
	              <option value="Advise Thru Bank">
		             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
		            </option>	            
	            <option value="Other">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
	            </option>
           </xsl:with-param>
          </xsl:call-template>
          </div>
            <xsl:variable name="banksInMaster" select="utils:checkMasterRecordForBanks(ref_id)"/>
           <div id="req_conf_party_flag_filtered_div" style="display:none;">
          <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
           <xsl:with-param name="name">req_conf_party_flag_filtered</xsl:with-param>
           <xsl:with-param name="value">req_conf_party_flag</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="options">           		
           			<option/> 
           		<xsl:if test="((tnx_type_code[.='01'] and (advising_bank/name !=''  or advising_bank/iso_code !='')) or  $banksInMaster = '10' or $banksInMaster = '11')">
		            <option value="Advising Bank">
		             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
		            </option>
	            </xsl:if>
	            <xsl:if test="((tnx_type_code[.='01'] and (advise_thru_bank/name !='' or advise_thru_bank/iso_code !='')) or $banksInMaster = '01' or $banksInMaster = '11')">
		            <option value="Advise Thru Bank">
		             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
		            </option>
	            </xsl:if>	
	            <option value="Other">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
	            </option>
           </xsl:with-param>
          </xsl:call-template>
          </div>
	     <xsl:call-template name="requestedConfirmationPartyBankDetails"></xsl:call-template>
        </xsl:when>
        <xsl:when test="$displaymode='view'">
          <xsl:call-template name="select-field">
          <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
       
           <xsl:with-param name="options">
         	<xsl:choose>
        		<xsl:when test="req_conf_party_flag[. = 'Advising Bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/></xsl:when>
        		<xsl:when test="req_conf_party_flag[. = 'Advise Thru Bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/></xsl:when>
         		<xsl:when test="req_conf_party_flag[. = 'Other']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/></xsl:when>			
         	</xsl:choose>
         	</xsl:with-param>       
         </xsl:call-template>
        	<xsl:apply-templates select="requested_confirmation_party">
     			 <xsl:with-param name="theNodeName">requested_confirmation_party</xsl:with-param>    		 
     			 <xsl:with-param name="swift-required">Y</xsl:with-param>
       	 	</xsl:apply-templates> 
        </xsl:when>
        </xsl:choose>
   </xsl:with-param>
  </xsl:call-template>  
	<script>
		dojo.ready(function()
		{
		if(misys._config.swiftRelatedSections !== undefined)
			{
				misys._config.swiftRelatedSections.push('advise_thru_bank');
			}
		});
	</script>
 </xsl:template>
  
  
  <!-- 
  	*******************************************************BANK SECTION TEMPLATES ARE PLACED BELOW*******************************************************
  	*****************************************************************************************************************************************************
  -->
  
  <!--
   Shipment Details section for LC,SI,EL,SR Middle office
   -->
  <xsl:template name="lc-bank-shipment-details-swift2018">
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
    <xsl:if test="$product-code='EL' or $product-code='SR' or $product-code='SI'">
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">part_ship_detl</xsl:with-param>
	     </xsl:call-template>
	</xsl:if>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="id">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
      	<xsl:choose>
       		<xsl:when test="part_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       		<xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        	<xsl:when test="part_ship_detl[. = '' or . = 'NONE']"></xsl:when>
       		<xsl:otherwise>CONDITIONAL</xsl:otherwise>
       	</xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
       	 <option/>
         <option value="ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
 		<option value="CONDITIONAL">
	       	 		<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/>       	 	
	     </option>
        </xsl:when>
        <xsl:otherwise>
           <xsl:if test="part_ship_detl[.!='']">
         	<xsl:choose>
         		 <xsl:when test="part_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          		<xsl:when test="part_ship_detl[. = '' or . = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
         		 <!--Todoswift2018 : 'None' to be replaced with blank in the condition and value too must be blank post migration-->
          		<xsl:when test="part_ship_detl[. = '']"></xsl:when>
          		<xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' ]"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')"/></xsl:when>
         	</xsl:choose>
         	</xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
   	 <xsl:call-template name ="infoMessagePartialShipment"/>	
     <xsl:if test="$product-code='EL' or $product-code='SR' or $product-code='SI'" >
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
	     </xsl:call-template>
	</xsl:if>
     <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL_LC</xsl:with-param>
     <xsl:with-param name="id">tran_ship_detl_nosend</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       		<xsl:when test="tran_ship_detl[. = 'ALLOWED']">ALLOWED</xsl:when>
       		<xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        	<xsl:when test="tran_ship_detl[. = '' or . = 'NONE']"></xsl:when>
       		<xsl:otherwise>CONDITIONAL</xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">      	 
       	  <option/>
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	      <option value="CONDITIONAL">
	       	 	<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/>       	 	
	       </option>
        </xsl:when>
        <xsl:otherwise>
       <xsl:if test="tran_ship_detl[.!='']">
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = '']"></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/></xsl:when>
         </xsl:choose>
         </xsl:if>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
   
   	  <xsl:call-template name ="infoMessageTranshipment"/>
     <xsl:call-template name="input-field">
 	  <xsl:with-param name="label">
     	<xsl:choose>
     		<xsl:when test="tnx_type_code[.='03']">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:when>
     		<xsl:otherwise>XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:otherwise>
      	</xsl:choose>
      </xsl:with-param>      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="button-type">date</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
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
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

<!--
   Delivery Instructions 
   -->
  <xsl:template name="delivery-instructions">
  
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_DELIVERY_INSTRUCTIONS</xsl:with-param>
   <xsl:with-param name="content">
    <!--  Swift 2019  fields-->
	<xsl:if test="$swift2019Enabled and product_code[.='SR'] and $displaymode='edit'">
	     	<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
			      <xsl:with-param name="name">delv_org</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="options">
  			     <xsl:call-template name="delivery-mode"/>
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
	    		  <xsl:with-param name="value"><xsl:value-of select="delivery_to"/></xsl:with-param>			      
			      <xsl:with-param name="fieldsize">small</xsl:with-param>
			      <xsl:with-param name="options">
			      	<xsl:if test="security:isBank($rundata) = false">
			       			<xsl:call-template name="delivery-to"/>
   					</xsl:if>
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
				      		<xsl:with-param name="cols">35</xsl:with-param>
      						<xsl:with-param name="rows">6</xsl:with-param>
			  				<xsl:with-param name="maxlines">6</xsl:with-param>
					       <xsl:with-param name="swift-validate">Y</xsl:with-param>
					     </xsl:call-template>
					    </xsl:with-param>
					</xsl:call-template>	
		
   		</xsl:if>
	
	<xsl:if test="$swift2019Enabled and product_code[.='SR'] and $displaymode='view'">
	<xsl:if test="delv_org[.!='']">
					<xsl:variable name="delv_org_code"><xsl:value-of select="delv_org"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C086</xsl:variable>
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
					<xsl:variable name="delv_to_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
					 	<xsl:with-param name="name">delv_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/></xsl:with-param>
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
	
	</xsl:with-param>
	</xsl:call-template>
	</xsl:template>
    <!-- 
   Narrative charges.
   
   Tab0 - Charges Details
   Tab1 - Period for Presentation
   Tab2 - Shipment Period
  -->
  <xsl:template name="lc-narrative-charges-swift2018">
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
	  <xsl:with-param name="tabgroup-height">180px;</xsl:with-param>
    <!-- Tab 0 - Charges Details  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_CHARGES</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <!-- Form #4 : Narrative Charges Details -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_charges</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 1 - Period Presentation  -->
    <xsl:with-param name="tab1-label">XSL_TAB_PERIOD_PRESENTATION_IN_DAYS</xsl:with-param>
    <xsl:with-param name="tab1-content">   
      <!-- Form #5 : Narrative Period Presentation -->
      <xsl:if test="$displaymode='edit'"> 
		<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>
			<div class="x-small" maxLength="3" dojoType="dijit.form.NumberTextBox"
				trim="true">
				<xsl:attribute name="id">period_presentation_days</xsl:attribute>
				<xsl:attribute name="name">period_presentation_days</xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="period_presentation_days"/></xsl:attribute>
				<xsl:attribute name="constraints">{places:'0',min:0, max:999}</xsl:attribute>			
			</div>
	  </xsl:if>
		<xsl:if test="period_presentation_days[.!=''] and $displaymode='view'">
			<div>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>&nbsp; 
				 <b><xsl:value-of select="period_presentation_days"/></b>	
				 </div>	
		</xsl:if>
		 <xsl:if test="$displaymode='edit'">
		  <div>
			 <xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/> 
     	  </div>   
     	  <div>
    	 	<xsl:call-template name="textarea-field">
      			<xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
      			<xsl:with-param name="rows">4</xsl:with-param>
      			<xsl:with-param name="cols">35</xsl:with-param>
      			<xsl:with-param name="maxlines">1</xsl:with-param>
     		</xsl:call-template>
     	 </div>
     	</xsl:if>
      	<xsl:if test="narrative_period_presentation[.!=''] and $displaymode='view'">
     	 <div>
			<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/>&nbsp; 
	 		<b><xsl:value-of select="narrative_period_presentation"/></b>
		 </div>	
		</xsl:if>
    </xsl:with-param>
     
    <!-- Tab 2 - Shipment Period  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <!-- Form #6 : Shipment Period Details -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  
  <!-- 
   Narrative details.
   
   Tab0 - Special payment conditions for Beneficiary
   Tab1 - Special payment conditions for Receiving Bank
  -->
  <xsl:template name="lc-narrative-special-payments">
  <xsl:param name="in-fieldset">Y</xsl:param>
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
    <!-- Tab 0 - Special payment conditions for Beneficiary -->
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
        	 <xsl:when test="$swift2018Enabled and product_code = 'EL' and ((tnx_type_code = '13' and sub_tnx_type_code[.='12' or .='19']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)"></xsl:when>		 	
    	     <xsl:when test="$swift2018Enabled and product_code = 'EL' and ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2']))">
      		 	<xsl:value-of select="narrative_special_beneficiary"/>
      		 </xsl:when>
			<xsl:when test="$swift2018Enabled">
	   				<xsl:variable name="desc"><xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/></xsl:variable>
	   				<xsl:choose>
 		 					<xsl:when test="$desc != ''">
 		 						<xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/>
 		 					</xsl:when>
 		 					<xsl:otherwise><xsl:value-of select="//narrative_special_beneficiary/text"/></xsl:otherwise>
	   		 		</xsl:choose>
	   		</xsl:when>
		   	<xsl:otherwise><xsl:value-of select="narrative_special_beneficiary"/></xsl:otherwise>
		</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    <!-- Tab 1 - Special payment conditions for Receiving Bank -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_special_recvbank</xsl:with-param>
      <xsl:with-param name="messageValue">
      	<xsl:choose>
      		 <xsl:when test="$swift2018Enabled and product_code = 'EL' and ((tnx_type_code = '13' and sub_tnx_type_code[.='12' or .='19']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])) and security:isBank($rundata)"></xsl:when>
      		 <xsl:when test="$swift2018Enabled and product_code = 'EL' and ((tnx_type_code[.='09' or .='13'] and sub_tnx_type_code[.='12']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2']))">
      		 	<xsl:value-of select="narrative_special_recvbank"/>
      		 </xsl:when>
			 <xsl:when test="$swift2018Enabled">
	   				<xsl:variable name="desc"><xsl:value-of select="//narrative_special_recvbank/issuance/data/datum/text"/></xsl:variable>
	   				<xsl:choose>
 		 					<xsl:when test="$desc != ''">
 		 						<xsl:value-of select="//narrative_special_recvbank/issuance/data/datum/text"/>
 		 					</xsl:when>
 		 					<xsl:otherwise><xsl:value-of select="//narrative_special_recvbank/text"/></xsl:otherwise>
	   		 		</xsl:choose>
	   		</xsl:when>
		   	 <xsl:otherwise><xsl:value-of select="narrative_special_recvbank"/></xsl:otherwise>
		</xsl:choose>
      </xsl:with-param>
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
     </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
    

    
    <xsl:template name="lc-narrative-swift-special-payments">
  <xsl:param name="in-fieldset">Y</xsl:param>
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-height">450px</xsl:with-param>
    <!-- Tab 0 - Special payment conditions for Beneficiary -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
   <xsl:with-param name="tab0-content">
  	<div style="display:none">&nbsp;</div>
    <div id="tabNarrativeSpecialBeneficiary" style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block">
 		<div id="narrativeSpecialBeneficiary" style="width:675px;">
	   		<xsl:if test="narrative_special_beneficiary/issuance/data/datum/text[.!='']">
	   			<div style="width:675px;">
					<div class="indented-header" style="width:675px;" align="left">
						<h3 class="toc-item">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
						</h3>
					</div>
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_special_beneficiary/issuance/data/datum/text, 6)" />
						</p>
					</div>
				</div>
			</xsl:if>
	   		<xsl:if test="narrative_special_beneficiary/amendments/amendment/data/datum/text[.!='']">
	   			<div style="width:675px;">
				<xsl:for-each select="narrative_special_beneficiary/amendments/amendment">
					<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</div>
					<xsl:for-each select="data/datum">
						<div style="width:675px;">
							<p style="white-space: pre-wrap;">
								<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
								<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
								<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
							</p>
						</div>
					</xsl:for-each>
				</xsl:for-each>
				</div>
			</xsl:if>
		</div>
   		<xsl:if test="narrative_master_special_beneficiary/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_special_beneficiary/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_special_beneficiary/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="//*/narrative_master_special_beneficiary/amendments/amendment">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top"> 
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_sp_beneficiary</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_beneficiary"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_beneficiary</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_sp_beneficiary_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_beneficiary"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_beneficiary</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
   	   <xsl:call-template name="hidden-field">
    		<xsl:with-param name="id">narrative_special_beneficiary</xsl:with-param>
    		<xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
    		<xsl:with-param name="value" select="org_narratives/narrative_special_beneficiary"/>
  		</xsl:call-template> 
   	</div>
    </xsl:with-param>
    <!-- Tab 1 - Special payment conditions for Receiving Bank -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV</xsl:with-param>
    <xsl:with-param name="tab1-content">
   	<div style="display:none">&nbsp;</div>
    <div id="tabNarrativeSpecialReceivingBank" style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block">
 		<div id="narrativeSpecialReceivingBank" style="width:675px;">
	   		<xsl:if test="narrative_special_recvbank/issuance/data/datum/text[.!='']">
	   			<div style="width:675px;">
					<div class="indented-header" style="width:675px;" align="left">
						<h3 class="toc-item">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
						</h3>
					</div>
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_special_recvbank/issuance/data/datum/text, 6)" />
						</p>
					</div>
				</div>
			</xsl:if>
	   		<xsl:if test="narrative_special_recvbank/amendments/amendment/data/datum/text[.!='']">
	   			<div style="width:675px;">
				<xsl:for-each select="narrative_special_recvbank/amendments/amendment">
					<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</div>
					<xsl:for-each select="data/datum">
						<div style="width:675px;">
							<p style="white-space: pre-wrap;">
								<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
								<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
								<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
							</p>
						</div>
					</xsl:for-each>
				</xsl:for-each>
				</div>
			</xsl:if>
		</div>
   		<xsl:if test="narrative_master_special_recvbank/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_special_recvbank/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_special_recvbank/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="//*/narrative_master_special_recvbank/amendments/amendment">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top"> 
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_sp_recvbank</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_recvbank"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_recvbank</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_sp_recvbank_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_recvbank"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_recvbank</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
   	   <xsl:call-template name="hidden-field">
    		<xsl:with-param name="id">narrative_special_recvbank</xsl:with-param>
    		<xsl:with-param name="name">narrative_special_recvbank</xsl:with-param>
    		<xsl:with-param name="value" select="org_narratives/narrative_special_recvbank"/>
  		</xsl:call-template> 
   	</div>
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
    

    <xsl:template name="lc-narrative-special-payments-beneficiary">
  <xsl:param name="in-fieldset">N</xsl:param>
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
   <xsl:with-param name="in-fieldset">N</xsl:with-param>
    <!-- Tab 0 - Special payment conditions for Beneficiary -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
      	<xsl:with-param name="messageValue">
   			<xsl:choose>
	   			<xsl:when test="$swift2018Enabled"><xsl:value-of select="//narrative_special_beneficiary/issuance/data/datum/text"/></xsl:when>
   				<xsl:otherwise><xsl:value-of select="narrative_special_beneficiary"/></xsl:otherwise>
   			</xsl:choose>
   		</xsl:with-param>
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
     </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="lc-swift-narrative-special-payments-beneficiary">
    <xsl:param name="in-fieldset">N</xsl:param>
    <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-id">narrative-special-payments-beneficiary-tabcontainer</xsl:with-param>
    <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-height">450px</xsl:with-param>
    
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
    <xsl:with-param name="tab0-content">
    <div id="tabNarrativeSpecialBeneficiary" style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block" attribute="status: true">
 			<div id="narrativeSpecialBeneficiary" style="width:675px;">
   		<xsl:if test="narrative_special_beneficiary/issuance/data/datum/text[.!='']">
   			<div style="width:675px;">
				<div class="indented-header" style="width:675px;" align="left">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
					</h3>
				</div>
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_special_beneficiary/issuance/data/datum/text, 6)" />
					</p>
				</div>
			</div>
		</xsl:if>
   		<xsl:if test="narrative_special_beneficiary/amendments/amendment/data/datum/text[.!='']">
   			<div style="width:675px;">
			<xsl:for-each select="narrative_special_beneficiary/amendments/amendment">
				<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</div>
				<xsl:for-each select="data/datum">
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
					</div>
				</xsl:for-each>
			</xsl:for-each>
			</div>
		</xsl:if>
		</div>
   		<xsl:if test="narrative_master_special_beneficiary/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_special_beneficiary/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_special_beneficiary/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="//*/narrative_master_special_beneficiary/amendments/amendment">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top"> 
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_sp_beneficiary</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_beneficiary"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_beneficiary</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="get-button">
	      <xsl:with-param name="button-type">narrative_amend_sp_beneficiary_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_beneficiary"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_beneficiary</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
   	   <xsl:call-template name="hidden-field">
    		<xsl:with-param name="id">narrative_special_beneficiary</xsl:with-param>
    		<xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
  		</xsl:call-template> 
   	</div>
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
  
   <!--
   			Narrative Other Details 
   -->
  <xsl:template name="lc-bank-narrative-other-swift2018">
   <!-- Tabgroup #2 : Narrative Other (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    
     <xsl:with-param name="tabgroup-height">220px</xsl:with-param>
    <!-- Tab 2_0 - Charges Details  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
       <xsl:with-param name="messageValue">
      	<xsl:choose>
	      	<xsl:when test="security:isBank($rundata)">
      			<xsl:value-of select="narrative_sender_to_receiver"/>
    	 	</xsl:when>
	    	 <xsl:otherwise>
	    	 		<xsl:value-of select="free_format_text"/>
	    	 </xsl:otherwise>
    	</xsl:choose>
    	</xsl:with-param>
     </xsl:call-template> 
    </xsl:with-param>
    
    <!-- Tab 2_1 - Payment Instructions  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="cols">65</xsl:with-param>
      <xsl:with-param name="maxlines">12</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2_2 - Shipment Amount  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="maxlines">4</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- 
  	*******************************************************COMMON TEMPLATES USED BY FO/MO PLACED BELOWS*******************************************************
  	********************************************************************************************************************************************************
 -->
 
 <xsl:template name="lc-amt-details-swift2018">
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="show-form-lc">Y</xsl:param>
   <xsl:param name="show-variation-drawing">Y</xsl:param>
   <xsl:param name="show-bank-confirmation">N</xsl:param>
   <xsl:param name="show-outstanding-amt">N</xsl:param>
   <xsl:param name="show-liability-amt">N</xsl:param>
   <xsl:param name="show-available-amt">N</xsl:param>
   <xsl:param name="show-standby">Y</xsl:param>
   <xsl:param name="show-revolving">N</xsl:param>
   <xsl:param name="show-amt">Y</xsl:param>
   <xsl:param name="show-form-lc-irv">N</xsl:param>
   <xsl:param name="transferable">N</xsl:param>
   <xsl:param name="disable-standby-flag">N</xsl:param>
   

   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_CONFIRMATION_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
         <xsl:if test="$show-form-lc-irv='Y'">
         	<xsl:call-template name="multioption-group">
     			<xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
        		<xsl:with-param name="content"> 
          		<xsl:call-template name="checkbox-field">
          		 	<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_IRREVOCABLE</xsl:with-param>
           		 	<xsl:with-param name="name">irv_flag</xsl:with-param>
           			 <xsl:with-param name="readonly">Y</xsl:with-param>
            	</xsl:call-template>
		   		</xsl:with-param>
		   </xsl:call-template>
     	</xsl:if>
     <!-- Form of LC Checkboxes. -->
     <div id="lc-amt-details">

     <xsl:if test="$show-form-lc='Y'">
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:choose>
          	<xsl:when test="$displaymode='view'">
	          	<xsl:choose>
	          		<xsl:when test="irv_flag = 'N'">
	          			<xsl:call-template name="input-field">
	          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOCABLE')"/>
	          			</xsl:call-template>
	           		</xsl:when>
	           		<xsl:otherwise>
	          			<xsl:call-template name="input-field">
	          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')"/>
	          			</xsl:call-template>
	          			&nbsp;
	           		</xsl:otherwise>
	         	</xsl:choose>
          	</xsl:when>
          	<xsl:otherwise>
          		<xsl:call-template name="checkbox-field">
		           <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_IRREVOCABLE</xsl:with-param>
		           <xsl:with-param name="name">irv_flag</xsl:with-param>
		           <xsl:with-param name="readonly">Y</xsl:with-param>
          		</xsl:call-template>
          	</xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
           <xsl:when test="$transferable='Y'">
				<xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">ntrf_flag</xsl:with-param>  
    				<xsl:with-param name="value">
     					<xsl:choose>
      						<xsl:when test="ntrf_flag[.='']">Y</xsl:when>
      						<xsl:otherwise>
      							<xsl:value-of select="ntrf_flag"></xsl:value-of>
      						</xsl:otherwise>
     					</xsl:choose>
    				</xsl:with-param> 				
   		  		</xsl:call-template>
   		  		
           		<xsl:call-template name="checkbox-field">
            		<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_TRANSFERABLE</xsl:with-param>
            		<xsl:with-param name="name">trf_flag</xsl:with-param>
					<xsl:with-param name="value">
     					<xsl:choose>
      						<xsl:when test="ntrf_flag='N'">Y</xsl:when>
      						<xsl:otherwise>N</xsl:otherwise>
     					</xsl:choose>
    				</xsl:with-param>
           		</xsl:call-template>          		
           </xsl:when>
           <xsl:otherwise>
           	<xsl:choose>
           		<xsl:when test="$displaymode='view'">
					<xsl:choose>
           				<xsl:when test="ntrf_flag[. = 'N']">
          					<xsl:call-template name="input-field">
	          					<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')"/>
          					</xsl:call-template>
          					&nbsp;
           				</xsl:when>
           				<xsl:otherwise>
           					<xsl:call-template name="input-field">
	          					<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE')"/>
          					</xsl:call-template>
          					&nbsp;
           				</xsl:otherwise>
           			</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="checkbox-field">
           				<xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE</xsl:with-param>
           				<xsl:with-param name="name">ntrf_flag</xsl:with-param>
           				<xsl:with-param name="value">
	     					<xsl:choose>
	      						<xsl:when test="ntrf_flag[.='']">Y</xsl:when>
	      						<xsl:otherwise>
	      							<xsl:value-of select="ntrf_flag"></xsl:value-of>
	      						</xsl:otherwise>
	     					</xsl:choose>
    					</xsl:with-param> 
          			</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
	  <xsl:if test="$swift2019Enabled and ($product-code = 'SI' or $product-code = 'SR' or ($product-code = 'LC' and sub_tnx_stat_code[.=''] and security:isBank($rundata))) and $displaymode='edit'">        
	   <xsl:call-template name="row-wrapper">
			<xsl:with-param name="id">transfer_condition</xsl:with-param>
			<xsl:with-param name="label">TRANSFER_CONDITION</xsl:with-param>
			<xsl:with-param name="type">textarea</xsl:with-param>
			<xsl:with-param name="content">
			 <xsl:call-template name="textarea-field">
			  <xsl:with-param name="name">narrative_transfer_conditions</xsl:with-param>
			  <xsl:with-param name="messageValue"><xsl:value-of select="narrative_transfer_conditions/text"/></xsl:with-param>
			  <xsl:with-param name="rows">12</xsl:with-param>
			  <xsl:with-param name="cols">65</xsl:with-param>
			  <xsl:with-param name="maxlines">12</xsl:with-param>
			  <xsl:with-param name="swift-validate">Y</xsl:with-param>
			  	<xsl:with-param name="disabled">
					<xsl:choose>
						<xsl:when test="ntrf_flag[.='N'] or ntrf_flag[.='']">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	  </xsl:if>          
         <xsl:if test="stnd_by_lc_flag='Y' and $displaymode='view' and $product-code != 'SI'">
         	<xsl:call-template name="input-field">
     		<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_STAND_BY')"/>
        </xsl:call-template> 
        &nbsp;
         </xsl:if>
	
		<div id = "standByLcFlagDetails">
			<!-- Display the standby checkbox if this is an LC -->
          <xsl:if test="$show-standby='Y' and $displaymode='edit' and $product-code != 'SI'">
           <xsl:call-template name="checkbox-field">
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_STAND_BY</xsl:with-param>
            <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
            <xsl:with-param name="disabled"><xsl:value-of select="$disable-standby-flag"/></xsl:with-param>
             <xsl:with-param name="value">
 					<xsl:choose>
  						<xsl:when test="stnd_by_lc_flag[.='Y']">Y</xsl:when>
  						<xsl:when test="stnd_by_lc_flag[.=''] or stnd_by_lc_flag[.='N']">N</xsl:when>
 					</xsl:choose>
    		</xsl:with-param>
           </xsl:call-template>
          </xsl:if>
		</div>
          
          
          <xsl:if test="revolving_flag='Y' and $displaymode='view'">
          <xsl:call-template name="input-field">
            <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOLVING')"/>
          </xsl:call-template>
          </xsl:if>
          
          <xsl:if test="$show-revolving='Y' and $displaymode='edit'">
           <xsl:call-template name="checkbox-field">
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORM_REVOLVING</xsl:with-param>
            <xsl:with-param name="name">revolving_flag</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="revolving_flag"/></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
       
       <xsl:if test="$swift2019Enabled and ($product-code = 'SI' or $product-code = 'SR' or $product-code = 'LC') and $displaymode='view'"> 
			<xsl:if test="$displaymode='view' and ntrf_flag[.!=''] and ntrf_flag[.='N'] and narrative_transfer_conditions/text[.!='']">
				<xsl:call-template name="big-textarea-wrapper-narrative">
					<xsl:with-param name="label">TRANSFER_CONDITION</xsl:with-param>
					<xsl:with-param name="content">			
						<xsl:value-of select="narrative_transfer_conditions/text" />
					</xsl:with-param>
				</xsl:call-template>	
			</xsl:if>
		</xsl:if>
       <!-- Confirmation Instructions Radio Buttons -->
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_INST_LABEL</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:apply-templates select="cfm_inst_code"/>
        </xsl:with-param>
       </xsl:call-template>
      <!-- Requested Confirmation Party details -->
      <xsl:choose>
    	<xsl:when test="($product-code = 'EL' or $product-code = 'SR') and $displaymode ='edit'">
    	<div id="requested-conf-party" style="display:none;">
        <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
           <xsl:with-param name="name">req_conf_party_flag</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="options">         
	            <option value="Advising Bank">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
	            </option>
	            <option value="Advise Thru Bank">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
	            </option>
	            <option value="Other">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
	            </option>
           </xsl:with-param>
          </xsl:call-template>
         </div>
         <xsl:call-template name="requestedConfirmationPartyBankDetails"></xsl:call-template>   
         </xsl:when>
         <xsl:when test="($product-code = 'EL' or $product-code = 'SR') and $displaymode ='view'">
         <xsl:call-template name="select-field">
          <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
       
           <xsl:with-param name="options">
         	<xsl:choose>
        		<xsl:when test="req_conf_party_flag[. = 'Advising Bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/></xsl:when>
        		<xsl:when test="req_conf_party_flag[. = 'Advise Thru Bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/></xsl:when>
         		<xsl:when test="req_conf_party_flag[. = 'Other']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/></xsl:when>			
         	</xsl:choose>
         	</xsl:with-param>       
         </xsl:call-template>
         <xsl:if test="req_conf_party_flag[. != 'Advising Bank']"> 
         <xsl:apply-templates select="requested_confirmation_party">
     			 <xsl:with-param name="theNodeName">requested_confirmation_party</xsl:with-param>    		 
       	 </xsl:apply-templates> 
        <xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_BIC_CODE</xsl:with-param>
			<xsl:with-param name="name">requested_confirmation_party_iso_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="requested_confirmation_party/iso_code"/> </xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
       </xsl:when>
      </xsl:choose>
      </xsl:if>

      <!-- Bank's Confirmation -->
      <xsl:if test="$show-bank-confirmation='Y'">
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_FLAG_LABEL</xsl:with-param>
        <xsl:with-param name="content">
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
      </xsl:if>
      
      <!-- LC Currency and Amount -->
     <xsl:choose>
      <xsl:when test="tnx_type_code[.='03'] and tnx_stat_code[.!='04'] and $displaymode='view'">
      <xsl:choose>
      <xsl:when test="product_code[.='LC']">
       <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">
           		<xsl:choose>
		     		<xsl:when test="tnx_type_code[.='03']">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:when>
		     		<xsl:otherwise>XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:otherwise>
		      	</xsl:choose>
		   </xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
           </div></xsl:with-param>
          </xsl:call-template>
      </xsl:when>
      <xsl:when test="product_code[.='SI']">
       <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">
           		<xsl:choose>
		     		<xsl:when test="tnx_type_code[.='03']">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:when>
		     		<xsl:otherwise>XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:otherwise>
		      	</xsl:choose>
		   </xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
           </div></xsl:with-param>
          </xsl:call-template>
      </xsl:when>
      </xsl:choose>
      </xsl:when>
       <xsl:otherwise>
       <xsl:choose>
			<xsl:when test="$product-code = 'LC' and tnx_type_code[.='03'] and sub_tnx_type_code [.='']">
		       	<xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
			      <xsl:with-param name="required">N</xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="override-amt-name">org_lc_amt_value</xsl:with-param>
			      <xsl:with-param name="override-amt-value">
			        <xsl:choose>
			        <xsl:when test="$product-code='SI'"><xsl:value-of select="org_previous_file/si_tnx_record/lc_amt"/> </xsl:when>
			        <xsl:when test="$product-code='LC'"><xsl:value-of select="org_previous_file/lc_tnx_record/lc_amt"/> </xsl:when>
		     	 	</xsl:choose>
			      </xsl:with-param>
			      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
			      <xsl:with-param name="disabled">Y</xsl:with-param>
			    </xsl:call-template>
       
       			<!-- Increase / Decrease Amt -->
			     <xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
      			  <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="override-amt-name">inc_amt_value</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
      			  <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="override-amt-name">dec_amt_value</xsl:with-param>
			     </xsl:call-template>
		 	</xsl:when>
		 </xsl:choose>       
         <xsl:if test="$show-amt='Y' or $displaymode='edit'">
       		<xsl:call-template name="currency-field">
       		<xsl:with-param name="label">
           		<xsl:choose>
		     		<xsl:when test="($product-code = 'LC' or $product-code = 'SI') and tnx_type_code[.='03']">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:when>
		     		<xsl:otherwise>XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:otherwise>
		      	</xsl:choose>
		    </xsl:with-param>
       		<xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
       		<xsl:with-param name="required">Y</xsl:with-param>
       	 </xsl:call-template>
      	</xsl:if>
      </xsl:otherwise>      
     </xsl:choose> 
     
     <!-- Can show available amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-available-amt='Y' or $displaymode='view'">
      
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_available_amt</xsl:variable>
       <xsl:variable name="field-cur-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>

       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="type">amount</xsl:with-param>
        <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()=$field-cur-name]"/></xsl:with-param>
        <xsl:with-param name="name"><xsl:value-of select="$field-name"/></xsl:with-param>
        <xsl:with-param name="size">20</xsl:with-param>
        <xsl:with-param name="appendClass">available</xsl:with-param>
        <xsl:with-param name="maxsize">15</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	      <xsl:if test="$field-value !=''">
	       <xsl:choose>
	        <xsl:when test="$displaymode='view'">
	         <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	        </xsl:when>
	        <xsl:otherwise><xsl:value-of select="$field-value"/></xsl:otherwise>
	       </xsl:choose>
	      </xsl:if>
	    </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      
      <!-- Can show Liability amt field in the form. -->
      <!-- Also shown in consolidated view -->      
       <xsl:if test="$show-liability-amt='Y' or $displaymode='view' and security:isBank($rundata)">
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
       <xsl:variable name="field-cur-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
       
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="type">amount</xsl:with-param>
        <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()=$field-cur-name]"/></xsl:with-param>
        <xsl:with-param name="name"><xsl:value-of select="$field-name"/></xsl:with-param>
        <xsl:with-param name="size">20</xsl:with-param>
        <xsl:with-param name="appendClass">outstanding</xsl:with-param>
        <xsl:with-param name="maxsize">15</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	      <xsl:if test="$field-value !=''">
	       <xsl:choose>
	        <xsl:when test="$displaymode='view'">
	         <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	        </xsl:when>
	        <xsl:otherwise><xsl:value-of select="$field-value"/></xsl:otherwise>
	       </xsl:choose>
	      </xsl:if>
	    </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <!-- Can show outstanding amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-outstanding-amt='Y' or $displaymode='view'">
      
      
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_outstanding_amt</xsl:variable>
       <xsl:variable name="field-cur-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
       

       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="type">amount</xsl:with-param>
        <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()=$field-cur-name]"/></xsl:with-param>
        <xsl:with-param name="name"><xsl:value-of select="$field-name"/></xsl:with-param>
        <xsl:with-param name="size">20</xsl:with-param>
        <xsl:with-param name="appendClass">outstanding</xsl:with-param>
        <xsl:with-param name="maxsize">15</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	      <xsl:if test="$field-value !=''">
	       <xsl:choose>
	        <xsl:when test="$displaymode='view'">
	         <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	        </xsl:when>
	        <xsl:otherwise><xsl:value-of select="$field-value"/></xsl:otherwise>
	       </xsl:choose>
	      </xsl:if>
	    </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
       <xsl:if test="security:isCustomer($rundata) and ($product-code='LC' or $product-code='SI') and defaultresource:getResource('PURCHASE_ORDER_ASSISTANT') = 'true'">
      <xsl:choose>
     <xsl:when test="$displaymode='edit'">
	      <xsl:call-template name="checkbox-field">
	       		<xsl:with-param name="label">XSL_PURCHASE_ORDER_ASSISTANT</xsl:with-param>
	       		<xsl:with-param name="name">po_activated</xsl:with-param>
		         <xsl:with-param name="value">
							<xsl:value-of select="po_activated"/>
				 </xsl:with-param>
	     </xsl:call-template>
	     </xsl:when>
	      <xsl:otherwise>
	       <xsl:if test="po_activated[. = 'Y'] and $displaymode='view'">
	        <xsl:call-template name="row-wrapper">
                     <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                      <xsl:with-param name="content">
                           <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ASSISTANT')"/>
                            </div>
                   </xsl:with-param>
         </xsl:call-template>
	       </xsl:if>
	      </xsl:otherwise>
	     </xsl:choose>
     </xsl:if>
       <xsl:if test="security:isBank($rundata) and ($product-code='LC' or $product-code='SI')">
	       <xsl:if test="po_activated[. = 'Y'] and $displaymode='view'">
	        <xsl:call-template name="row-wrapper">
                     <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                      <xsl:with-param name="content">
                           <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ASSISTANT')"/>
                            </div>
                   </xsl:with-param>
         </xsl:call-template>
	       </xsl:if>
     </xsl:if>
      <!-- Variation in drawing. -->
      <xsl:if test="$show-variation-drawing='Y' and (lc_type[.!='04'] or tnx_type_code[.!='01'])">
       <xsl:call-template name="label-wrapper">
        <xsl:with-param name="label">
        	 <xsl:choose>
	     		<xsl:when test="($product-code = 'LC' or $product-code = 'SI') and tnx_type_code[.='03']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:when>
	     		<xsl:otherwise>XSL_AMOUNTDETAILS_TOL_LABEL</xsl:otherwise>
	      	</xsl:choose>        
        </xsl:with-param>        
        <xsl:with-param name="content">
        <xsl:call-template name="hidden-field">
           	<xsl:with-param name="name">DrawingTolerence_spl</xsl:with-param>
           	<xsl:with-param name="value" select="defaultresource:getResource('TOLERANCE_WITH_NOTEXCEEDING')"/>
         </xsl:call-template>
         <!-- <div class="group-fields">  -->
         <xsl:if test="$displaymode='edit'">
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
          </xsl:call-template>
        </xsl:if>           
        <xsl:if test="$displaymode='view' and pstv_tol_pct[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_PSTV</xsl:with-param>
           <xsl:with-param name="name">pstv_tol_pct</xsl:with-param>
           <xsl:with-param name="type">number</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>        
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
          </xsl:call-template>
       	</xsl:if>
        <xsl:if test="$displaymode='view' and neg_tol_pct[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_NEG</xsl:with-param>
           <xsl:with-param name="name">neg_tol_pct</xsl:with-param>
           <xsl:with-param name="type">number</xsl:with-param>
           <xsl:with-param name="fieldsize">x-small</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
           <xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>
           <xsl:with-param name="size">2</xsl:with-param>
           <xsl:with-param name="maxsize">2</xsl:with-param>
           <xsl:with-param name="content-after">%</xsl:with-param>
           <xsl:with-param name="appendClass">block</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        <!--  <xsl:call-template name="select-field">
           <xsl:with-param name="label">
	            <xsl:choose>
		     		<xsl:when test="($product-code = 'LC' or $product-code = 'SI') and tnx_type_code[.='03']">XSL_AMOUNTDETAILS_NEW_TOL_MAX_CREDIT_LABEL</xsl:when>
		     		<xsl:otherwise>XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL</xsl:otherwise>
		      	</xsl:choose> 
           </xsl:with-param>
           <xsl:with-param name="name">max_cr_desc_code</xsl:with-param>
           <xsl:with-param name="options">
            <xsl:choose>
             <xsl:when test="$displaymode='edit'">
                <option/>
	            <option value="3">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
	            </option>
             </xsl:when>
            </xsl:choose>
           </xsl:with-param>
          </xsl:call-template> -->
        </xsl:with-param>
       </xsl:call-template>
       
       <!--  <xsl:if test="$displaymode='view' and max_cr_desc_code[.!='']">
          <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/>
			<xsl:choose>
			<xsl:when test="max_cr_desc_code[. = '3']">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
			</xsl:when>
			</xsl:choose></div>
          </xsl:with-param>
          </xsl:call-template>
          </xsl:if> -->
       
      
       <!-- Charges borne by flags  -->
       <xsl:variable name="isMT798Enabled"><xsl:value-of select="is_MT798"/></xsl:variable>
       <xsl:if test="open_chrg_brn_by_code !=''">
       	 <xsl:apply-templates select="open_chrg_brn_by_code">
	        <xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
	        <xsl:with-param name="label">XSL_CHRGDETAILS_ISS_LABEL</xsl:with-param>
	        <xsl:with-param name="show-option">
     			<xsl:choose>
					<xsl:when test="$isMT798Enabled = 'Y'">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
		 	</xsl:with-param>
       	 </xsl:apply-templates>
       	  <xsl:call-template name="split_charges">
			<xsl:with-param name="name">open_chrg</xsl:with-param>
		   </xsl:call-template>
       </xsl:if>
       <xsl:if test="corr_chrg_brn_by_code !=''"> 
	       <xsl:apply-templates select="corr_chrg_brn_by_code">
	        <xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
	        <xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
	        <xsl:with-param name="show-option">
     			<xsl:choose>
					<xsl:when test="$isMT798Enabled = 'Y'">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
		 	</xsl:with-param>
	       </xsl:apply-templates>
	         <xsl:call-template name="split_charges">
			<xsl:with-param name="name">corr_chrg</xsl:with-param>
		   </xsl:call-template>
	       
       </xsl:if>
       <xsl:if test="((cfm_chrg_brn_by_code !='' or tnx_type_code[.='01']) or (($product-code = 'LC' or $product-code = 'SI' or $product-code = 'SR' or $product-code = 'EL') and tnx_type_code[.='03' or .='15'])) and $confirmationChargesEnabled and is_MT798[.='N']"> 
        <div id="cfm_chrg_brn_by_code_div" style="display:block;">
	       <xsl:apply-templates select="cfm_chrg_brn_by_code">
	        <xsl:with-param name="node-name">cfm_chrg_brn_by_code</xsl:with-param>
	        <xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
	       </xsl:apply-templates>
	     </div>
       </xsl:if>
        <xsl:choose>
			<xsl:when test="( $displaymode='edit' and ($product-code = 'LC' or $product-code = 'SI' or $product-code = 'SR')  and tnx_type_code[.='03' or .='15'])">
				<xsl:call-template name="amendmentCharges"></xsl:call-template> 
			</xsl:when>      
			<xsl:when test="$displaymode='view' and ($product-code = 'LC' or $product-code = 'SI' or $product-code = 'SR')">
				<xsl:call-template name="amendmentCharges"></xsl:call-template> 
			</xsl:when>  
       </xsl:choose>

      </xsl:if>
     </div>
     <xsl:if test="(product_code[.='LC'] or product_code[.='EL']) or (product_code[.='SR'] and lc_type[.!=02]) 
     or ((product_code[.='SI'] and lc_type[.=02]) and ($isSiStructuredFormatAccess != 'Y'))">
     	<xsl:call-template name = "applicable-rules"/>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
    <!--
  	Template for displaying the Info message text box below Transhipments
   	-->
    <xsl:template name="infoMessageTranshipment">
 	 <span id="infoMessageTranshipment" style="display: none" >
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_INFO_TEXT')"/>
    </span> 
 	</xsl:template>
 	<!-- 	
 	Template for displaying the Info message text box below Partial shipments
 	-->
 	<xsl:template name="infoMessagePartialShipment">
 	 <span id="infoMessagePartialShipment" style="display: none" >
      		<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_INFO_TEXT')"/>
    </span> 
 	</xsl:template>
 	<!-- 	
 		Template for displaying the Amendment charges radio box
 	-->
 	<xsl:template name="amendmentCharges">
 	    <div id="amd_chrg_brn_by_code_div" style="display:block;">
		       <xsl:apply-templates select="amd_chrg_brn_by_code">
			      <xsl:with-param name="node-name">amd_chrg_brn_by_code</xsl:with-param>
			      <xsl:with-param name="label">XSL_CHRGDETAILS_AMD_LABEL</xsl:with-param>
			      <xsl:with-param name="show-option">Y</xsl:with-param>
			      <xsl:with-param name="show-required-prefix">
				      <xsl:choose>
				      	<xsl:when test="security:isBank($rundata) and $displaymode='edit'">Y</xsl:when>
				      	<xsl:otherwise>N</xsl:otherwise>
				      </xsl:choose>
			      </xsl:with-param>
			   </xsl:apply-templates>
	       </div>
	 </xsl:template>
 	 <!--
  		 Requested confirmation Party Tab section LC/SI FO MO
   	-->
 	<xsl:template name="requestedConfirmationPartyTabSection">
    	<xsl:choose>
    	 <xsl:when test="$displaymode='edit'">
         <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
           <xsl:with-param name="name">req_conf_party_flag</xsl:with-param>
           <xsl:with-param name="options">    
           <xsl:choose>
           <xsl:when test="tnx_type_code[.!='03']">
           		<option/>  
	            <option value="Advising Bank">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
	            </option>
	            <option value="Advise Thru Bank">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
	            </option>
	            <option value="Other">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
	            </option>
           </xsl:when>
           <xsl:otherwise>
            <!-- For amendment,Advising Bank and Advise thru must be displayed in RCF dropdown,only if they were selected during the initiation -->
           	<option/>   
           	<xsl:if test="advising_bank/name !='' or advising_bank/iso_code!='' ">
           			<option value="Advising Bank">
	             		<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
	           		 </option>     		 
           	</xsl:if>   	
           	<xsl:if test="advise_thru_bank/name !='' or advise_thru_bank/iso_code!='' ">
        			<option value="Advise Thru Bank">
	             		 <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
	           		 </option>
        	</xsl:if>
         	<option value="Other">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
	         </option>       	
           </xsl:otherwise>
           </xsl:choose>   
           		
           </xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="requestedConfirmationPartyBankDetails"></xsl:call-template>
        </xsl:when>
        <xsl:when test="$displaymode='view'">
        <xsl:if test="req_conf_party_flag[. !='']">
          <xsl:call-template name="select-field">
          <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
       
           <xsl:with-param name="options">
         	<xsl:choose>
        		<xsl:when test="req_conf_party_flag[. = 'Advising Bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/></xsl:when>
        		<xsl:when test="req_conf_party_flag[. = 'Advise Thru Bank']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/></xsl:when>
         		<xsl:when test="req_conf_party_flag[. = 'Other']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/></xsl:when>			
         	</xsl:choose>
         	</xsl:with-param>       
         </xsl:call-template>
        	<xsl:apply-templates select="requested_confirmation_party">
     			 <xsl:with-param name="theNodeName">requested_confirmation_party</xsl:with-param>    		 
       	 	</xsl:apply-templates> 
         	<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_BIC_CODE</xsl:with-param>
			<xsl:with-param name="name">requested_confirmation_party_iso_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="requested_confirmation_party/iso_code"/> </xsl:with-param>
	     	</xsl:call-template> 
	     </xsl:if>
        </xsl:when>
       </xsl:choose>
    </xsl:template>
    
    <!-- Legacy data template -->
    <xsl:template name="legacy-template">
   
      <xsl:if test="narrative_legacy_partial_shipment[ .!= '']">
      	<xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_LEGACY_DETAILS_PARTIAL_SHIPMENT</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="narrative_legacy_partial_shipment"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
      <xsl:if test="narrative_legacy_tran_shipment[ .!= '']">
      	<xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_LEGACY_DETAILS_TRAN_SHIPMENT</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="narrative_legacy_tran_shipment"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
      <xsl:if test="narrative_legacy_max_credit_amount[ .!= '']">
      	<xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_LEGACY_DETAILS_MAX_CREDIT_AMOUNT</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="narrative_legacy_max_credit_amount"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
     <!--  <xsl:value-of select="string-length(narrative_legacy_period_of_presentation)" /> -->
      <xsl:if test="narrative_legacy_period_of_presentation[ .!= '']">
      	<xsl:call-template name="row-wrapper">
			<xsl:with-param name="label">XSL_LEGACY_DETAILS_PERIOD_OF_PRESENTATION</xsl:with-param>
			<xsl:with-param name="content">
				<div style="font-weight: bold;font-family: Tahoma, Arial, Helvetica, sans-serif;padding-left:245px;">
					<xsl:call-template name="string_replace">
			        	<xsl:with-param name="input_text" select="narrative_legacy_period_of_presentation"/>
			        </xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	 </xsl:if>
      

  </xsl:template>
    
    <!--
  		 Bank Details section for 'Other' type in Requested confirmation party dropdown
   	-->
    <xsl:template name="requestedConfirmationPartyBankDetails">
 		<div id="requested-conf-party-bank-details" style="display:none;">
         	<xsl:apply-templates select="requested_confirmation_party">
     			 <xsl:with-param name="theNodeName">requested_confirmation_party</xsl:with-param>    		 
       	 		 <xsl:with-param name="swift-required">Y</xsl:with-param>    		 
       	 	</xsl:apply-templates> 
    </div>
    </xsl:template>
  <xsl:template name="view-narrative-swift-details">
   <xsl:param name="documents-required-required">N</xsl:param>
   <xsl:param name="description-goods-required">Y</xsl:param>
   <xsl:param name="in-fieldset">Y</xsl:param>
   
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-label">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">view-narrative-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">450px;</xsl:with-param>
    
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="tab0-content">
    <div style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block">
   	<div style="width:675px;">
   		<xsl:if test="narrative_description_goods/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_description_goods/issuance/data/datum/text, 6)" />
				</p>
			</div>
			</div>
		</xsl:if>
   		<xsl:if test="narrative_description_goods/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="narrative_description_goods/amendments/amendment">
			<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
		</div>
   		
   	<xsl:if test="narrative_master_description_goods/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_description_goods/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_description_goods/amendments/amendment">
  			<div style="width:675px;">
			<xsl:for-each select="//*/narrative_master_description_goods/amendments/amendment">
				<div class="indented-header" style="width:675px;" align="left">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top">  
	   <xsl:call-template name="get-button">
	   	  <xsl:with-param name="id">narrative_amend_goods_mo</xsl:with-param>
	      <xsl:with-param name="button-type">narrative_amend_goods_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_goods"/>
	      <xsl:with-param name="widget-name">narrative_amend_goods</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template> 
	</div>
  	</xsl:with-param>
    <!-- Tab 1 - Documents Required  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
    <xsl:with-param name="tab1-content">
    <div style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block">
   		<div style="width:675px;">
   		<xsl:if test="narrative_documents_required/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_documents_required/issuance/data/datum/text, 6)" />
				</p>
			</div>
			</div>
		</xsl:if>
   		<xsl:if test="narrative_documents_required/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="narrative_documents_required/amendments/amendment">
			<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
		</div>
   		
   		
   		<xsl:if test="narrative_master_documents_required/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_documents_required/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_documents_required/amendments/amendment">
  			<div style="width:675px;">
			<xsl:for-each select="//*/narrative_master_documents_required/amendments/amendment">
				<div class="indented-header" style="width:675px;" align="left">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top">  
	   <xsl:call-template name="get-button">
	   	  <xsl:with-param name="id">narrative_amend_docs_mo</xsl:with-param>
	      <xsl:with-param name="button-type">narrative_amend_docs_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_docs"/>
	      <xsl:with-param name="widget-name">narrative_amend_docs</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
	</div>
    </xsl:with-param>
    
     
    <!-- Tab 2 - Additional Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
	<xsl:with-param name="tab2-content">
    <div style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block">
   		<div style="width:675px;">
   		<xsl:if test="narrative_additional_instructions/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_additional_instructions/issuance/data/datum/text, 6)" />
				</p>
			</div>
			</div>
		</xsl:if>
   		<xsl:if test="narrative_additional_instructions/amendments/amendment/data/datum/text[.!='']">
  			<div style="width:675px;">
		<xsl:for-each select="narrative_additional_instructions/amendments/amendment">
			<div class="indented-header" style="background-color:#ffffff;font-weight:bold;color: blue;width:675px;" align="left">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_CURRENT_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
		</div>
   		
   		<xsl:if test="narrative_master_additional_instructions/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_additional_instructions/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_additional_instructions/amendments/amendment">
  			<div style="width:675px;">
			<xsl:for-each select="//*/narrative_master_additional_instructions/amendments/amendment">
				<div class="indented-header" style="width:675px;" align="left">
					<h3 class="toc-item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
					</h3>
				</div>
				<xsl:for-each select="data/datum">
					<div style="width:675px;">
						<p style="white-space: pre-wrap;">
							<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
						</p>
					</div>
				</xsl:for-each>
			</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top">  
	   <xsl:call-template name="get-button">
	   	  <xsl:with-param name="id">narrative_amend_instructions_mo</xsl:with-param>
	      <xsl:with-param name="button-type">narrative_amend_instructions_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_instructions"/>
	      <xsl:with-param name="widget-name">narrative_amend_instructions</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
	</div>
	</xsl:with-param>     
   </xsl:call-template>
  </xsl:template>
  <xsl:template name="view-narrative-swift-special-payments">
  <xsl:param name="in-fieldset">Y</xsl:param>
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-id">view-narrative-special-payments-tabcontainer</xsl:with-param>
   <xsl:with-param name="tabgroup-height">450px</xsl:with-param>
    <!-- Tab 0 - Special payment conditions for Beneficiary -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
   <xsl:with-param name="tab0-content">
   <div style="display:none">&nbsp;</div>
    <div style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block">
    <div style="width:675px;">
   <xsl:if test="narrative_special_beneficiary/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_special_beneficiary/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_special_beneficiary/amendments/amendment">
  			<div style="width:675px;">
		<xsl:for-each select="//*/narrative_special_beneficiary/amendments/amendment">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
       </div>
    	<xsl:if test="narrative_master_special_beneficiary/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_special_beneficiary/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_special_beneficiary/amendments/amendment">
  			<div style="width:675px;">
		<xsl:for-each select="//*/narrative_master_special_beneficiary/amendments/amendment">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top"> 
	   <xsl:call-template name="get-button">
	   	  <xsl:with-param name="id">narrative_amend_sp_beneficiary_mo</xsl:with-param>
	      <xsl:with-param name="button-type">narrative_amend_sp_beneficiary_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_beneficiary"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_beneficiary</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template> 
   	</div>	
    </xsl:with-param>
    <!-- Tab 1 - Special payment conditions for Receiving Bank -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV</xsl:with-param>
    <xsl:with-param name="tab1-content">
    <div style="display:none">&nbsp;</div>
    <div style="border: solid 1px #B8B8B8;width:695px;height:350px;overflow-y:auto; display: inline-block">
   <div style="width:675px;">
    
       		<xsl:if test="narrative_special_recvbank/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_special_recvbank/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_special_recvbank/amendments/amendment">
  			<div style="width:675px;">
		<xsl:for-each select="//*/narrative_special_recvbank/amendments/amendment">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
    	</div>
    
   		<xsl:if test="narrative_master_special_recvbank/issuance/data/datum/text[.!='']">
  			<div style="width:675px;">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:675px;">
				<p style="white-space: pre-wrap;">
					<xsl:value-of select="convertTools:displaySwiftNarrative(//narrative_master_special_recvbank/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="narrative_master_special_recvbank/amendments/amendment">
  			<div style="width:675px;">
		<xsl:for-each select="//*/narrative_master_special_recvbank/amendments/amendment">
			<div class="indented-header" style="width:675px;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
				</h3>
			</div>
			<xsl:for-each select="data/datum">
				<div style="width:675px;">
					<p style="white-space: pre-wrap;">
						<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="convertTools:displaySwiftNarrative(text, 2)" />
					</p>
				</div>
			</xsl:for-each>
		</xsl:for-each>
		</div>
		</xsl:if>
	</div>
	<div style=" display: inline-block;vertical-align:top"> 
	   <xsl:call-template name="get-button">
	   	  <xsl:with-param name="id">narrative_amend_sp_recvbank_mo</xsl:with-param>
	      <xsl:with-param name="button-type">narrative_amend_sp_recvbank_view</xsl:with-param>
	      <xsl:with-param name="messageValue" select="narrative_amend_sp_recvbank"/>
	      <xsl:with-param name="widget-name">narrative_amend_sp_recvbank</xsl:with-param>
	      <xsl:with-param name="amendment-no"><xsl:value-of select="//amd_no"/></xsl:with-param>
	      <xsl:with-param name="overrideDimensions">width: 550px;height: 450px;</xsl:with-param>
	   </xsl:call-template>
   	</div>
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>