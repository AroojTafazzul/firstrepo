<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to License form (i.e. LS).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      24/09/14
author:    shrgupta
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization utils security defaultresource">

 <!--
  ########################################################################
  #1 - CUSTOMER SIDE TEMPLATES
 
  Below, all templates for LS form on the customer side
  ########################################################################
  -->

  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
  
  
    <xsl:param name="ls_bank"/>
  <xsl:template name="ls-general-details">
  <xsl:param name="show-iss-date">Y</xsl:param>
  <xsl:variable name="legal_id_readonly">
  <xsl:choose>
  <xsl:when test="defaultresource:getResource('LS_LEGAL_ID_EDITABLE') = 'true'">N</xsl:when>
  <xsl:otherwise>Y</xsl:otherwise>
  </xsl:choose>
  </xsl:variable>
  <xsl:variable name="ls_type_code"><xsl:value-of select="license/license_definition/ls_type"></xsl:value-of></xsl:variable>
  <xsl:variable name="productCode">*</xsl:variable>
  <xsl:variable name="subProductCode">*</xsl:variable>
  <xsl:variable name="parameterId">C026</xsl:variable>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_LABEL_LICENSE_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_LICENSE_TYPE</xsl:with-param>
    <xsl:with-param name="id">ls_type_value</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'$subProductCode',$productCode,$parameterId, $ls_type_code)"/></xsl:with-param>
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ls_type</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="$ls_type_code"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_LICENSE_NAME</xsl:with-param>
    <xsl:with-param name="name">ls_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="license/license_definition/ls_name"/></xsl:with-param>
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">ls_bank</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="$ls_bank"/></xsl:with-param>
		   </xsl:call-template>
   <xsl:choose>
	   <xsl:when test="$displaymode='edit'">
		   <xsl:if test="$displaymode='edit'">
			    <xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">XSL_LICENSE_ALLOW_OVERDRAW</xsl:with-param>
					<xsl:with-param name="id">allow_overdraw</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="license/license_definition/allow_overdraw"/></xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
				</xsl:call-template>
		   </xsl:if>
	   </xsl:when>
	   <xsl:when test="$displaymode='view' and license/license_definition/allow_overdraw ='Y'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_ALLOW_OVERDRAW')"/></xsl:with-param>
				<xsl:with-param name="id">allow_overdraw</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
   <xsl:choose>
	   <xsl:when test="$displaymode='edit'">
		   <xsl:call-template name="checkbox-field">
				<xsl:with-param name="label">XSL_LICENSE_ALLOW_MULTI_LS</xsl:with-param>
				<xsl:with-param name="id">allow_multi_ls</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="license/license_definition/allow_multi_ls"/></xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$displaymode='view' and license/license_definition/allow_multi_ls ='Y'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_ALLOW_MULTI_LS')"/></xsl:with-param>
				<xsl:with-param name="id">allow_multi_ls</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
	   <xsl:when test="$displaymode='edit'">
		   <xsl:call-template name="checkbox-field">
				<xsl:with-param name="label">XSL_LICENSE_MULTI_CURRENCY</xsl:with-param>
				<xsl:with-param name="name">allow_multi_cur</xsl:with-param>
				<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="allow_multi_cur[.='']"><xsl:value-of select="license/license_definition/multi_cur"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="allow_multi_cur"/></xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="disabled">
				<xsl:choose>
				   	<xsl:when test="license/license_definition/multi_cur_override ='N'">Y</xsl:when>
				   	<xsl:otherwise>N</xsl:otherwise>
			   	</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$displaymode='view' and allow_multi_cur[.='Y']">
			<xsl:call-template name="input-field">
				<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_MULTI_CURRENCY')"/></xsl:with-param>
				<xsl:with-param name="id">allow_multi_cur</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_LICENSE_NUMBER</xsl:with-param>
    <xsl:with-param name="name">ls_number</xsl:with-param>
    <xsl:with-param name="value" select="ls_number" />
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_AUTH_REFERENCE</xsl:with-param>
    <xsl:with-param name="name">auth_reference</xsl:with-param>
    <xsl:with-param name="value" select="auth_reference" />
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   
   <!--  Registration Date. --> 
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REG_DATE</xsl:with-param>
    <xsl:with-param name="name">reg_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
   </xsl:call-template>
   
   <!-- Issue Date -->
   <xsl:if test="$show-iss-date = 'Y'">
	    <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	    <xsl:with-param name="name">iss_date</xsl:with-param>
	    <xsl:with-param name="size">10</xsl:with-param>
	    <xsl:with-param name="maxsize">10</xsl:with-param>
	    <xsl:with-param name="fieldsize">small</xsl:with-param>
	    <xsl:with-param name="type">date</xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   </xsl:with-param>
   </xsl:call-template>
   
   <!-- Applicant Details -->
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend"><xsl:value-of select="license/license_definition/principal_label"/></xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="localized">N</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="address">
      <xsl:with-param name="show-entity">Y</xsl:with-param>
      <xsl:with-param name="prefix">applicant</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
     	<xsl:when test="$displaymode='edit'">
			 <xsl:call-template name="input-field">
			  <xsl:with-param name="label">XSL_FURTHER_IDENTIFICATION</xsl:with-param>
			  <xsl:with-param name="name">further_identification</xsl:with-param>
			  <xsl:with-param name="id">further_identification</xsl:with-param>
			  <xsl:with-param name="type">text</xsl:with-param>
			  <xsl:with-param name="maxsize">35</xsl:with-param>
			  <xsl:with-param name="required">N</xsl:with-param>
			 </xsl:call-template>
     	</xsl:when>
     	<xsl:otherwise>
     		<xsl:if test="further_identification[.!='']">
	     		<xsl:call-template name="input-field">
	     		  <xsl:with-param name="label">XSL_FURTHER_IDENTIFICATION</xsl:with-param>
				  <xsl:with-param name="value"><xsl:value-of select="further_identification"/></xsl:with-param>
				 </xsl:call-template>
			 </xsl:if>
			<!-- Applicant reference is removed under Applicant details as it is available under bank details (in accordance with MPS-39538- removed for LC)-->
			 <!-- <xsl:if test="applicant_reference[.!=''] and //*/avail_main_banks">
			  <xsl:variable name="appl_ref">
              <xsl:value-of select="applicant_reference"/>
              </xsl:variable>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
				  		<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) &gt;= 1">
									    <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
								</xsl:when>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0">
									     	<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$appl_ref]/description"/>
								</xsl:when>
							</xsl:choose>		
							</xsl:with-param>
						</xsl:call-template>
			 </xsl:if> -->
			 
     	</xsl:otherwise>
     </xsl:choose>
     
    </xsl:with-param>
   </xsl:call-template>
  
   <!-- Beneficiary Details -->
   <xsl:if  test="defaultresource:getResource('LICENSE_BENEFICIARY_MANDATORY_FOR_TRADE_PRODUCTS') = 'true'">
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend"><xsl:value-of select="license/license_definition/non_principal_label"/></xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="localized">N</xsl:with-param>
     <xsl:with-param name="button-type"></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
       <xsl:with-param name="show-reference">
	       <xsl:choose>
		       <xsl:when test="license/license_definition/non_principal_default[.='01' or .='']">Y</xsl:when>
		       <xsl:otherwise>N</xsl:otherwise>
	       </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="show-country">
	       <xsl:choose>
		       <xsl:when test="license/license_definition/non_principal_default[.='01' or .='02' or .='']">Y</xsl:when>
		       <xsl:otherwise>N</xsl:otherwise>
	       </xsl:choose>       
       </xsl:with-param>
       <xsl:with-param name="show-address">
	       <xsl:choose>
		       <xsl:when test="license/license_definition/non_principal_default[.='01' or .='']">Y</xsl:when>
		       <xsl:otherwise>N</xsl:otherwise>
	       </xsl:choose>   
       </xsl:with-param>
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
    </xsl:if>
  </xsl:template> 
  
  <!--
   Shipment Details Fieldset.
   -->
  <xsl:template name="ls-shipment-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:choose>
     <xsl:when test="$displaymode='edit'">
   		<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_SHIPMENTDETAILS_CTY_OF_ORIGIN</xsl:with-param>
	    	<xsl:with-param name="name">origin_country</xsl:with-param>
	    	<xsl:with-param name="size">2</xsl:with-param>
	    	<xsl:with-param name="maxsize">2</xsl:with-param>
    		<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
    		<xsl:with-param name="uppercase">Y</xsl:with-param>
    		<xsl:with-param name="prefix">origin</xsl:with-param>
    		<xsl:with-param name="button-type">codevalue</xsl:with-param>
   		</xsl:call-template>
   	  </xsl:when>
   	  <xsl:otherwise>
   	  	<xsl:variable name="name">origin_country</xsl:variable>
   	  	<xsl:variable name="codeValue" select="//*[name()=$name]"/>
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_SHIPMENTDETAILS_CTY_OF_ORIGIN</xsl:with-param>
	    	<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',$codeValue)"/>
   		</xsl:call-template>
   	  </xsl:otherwise>
   	 </xsl:choose>
   	 <xsl:choose>
     <xsl:when test="$displaymode='edit'">
   		<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_SHIPMENTDETAILS_CTY_OF_SUPPLY</xsl:with-param>
	    	<xsl:with-param name="name">supply_country</xsl:with-param>
	    	<xsl:with-param name="size">2</xsl:with-param>
	    	<xsl:with-param name="maxsize">2</xsl:with-param>
    		<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
    		<xsl:with-param name="uppercase">Y</xsl:with-param>
    		<xsl:with-param name="prefix">supply</xsl:with-param>
    		<xsl:with-param name="button-type">codevalue</xsl:with-param>
   		</xsl:call-template>
   	  </xsl:when>
   	  <xsl:otherwise>
   	  	<xsl:variable name="name">supply_country</xsl:variable>
   	  	<xsl:variable name="codeValue" select="//*[name()=$name]"/>
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_SHIPMENTDETAILS_CTY_OF_SUPPLY</xsl:with-param>
	    	<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',$codeValue)"/>
   		</xsl:call-template>
   	  </xsl:otherwise>
   	 </xsl:choose>
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
  
  <!-- Bank Details. -->
  <xsl:template name="ls-bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent">
   				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
  </xsl:template>
    
  <!-- 
   Narrative details.
   
   Tab0 - Description of Goods
   Tab1 - Additional Instructions
  -->
  <xsl:template name="ls-narrative-details">
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
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
      <xsl:with-param name="messageValue"><xsl:value-of select="narrative_description_goods"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="word-wrap">Y</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 1 - Additional Instructions  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
      <xsl:with-param name="messageValue"><xsl:value-of select="narrative_additional_instructions"/></xsl:with-param>
      <xsl:with-param name="maxlines">100</xsl:with-param>
      <xsl:with-param name="word-wrap">Y</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--Amount Details Fieldset.-->
  <xsl:template name="ls-amt-details">
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="show-outstanding-amt">N</xsl:param>
   
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <div id="ls-amt-details">   
      <!-- LS Currency and Amount -->
      <xsl:if test="($displaymode='view' and ls_amt[.!='']) or $displaymode='edit'">
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_LS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
      <xsl:if test="($displaymode='view' and additional_amt[.!='']) or $displaymode='edit'">
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_ADDITIONAL_AMT</xsl:with-param>
       <xsl:with-param name="override-currency-name">additional_cur_code</xsl:with-param>
       <xsl:with-param name="override-amt-name">additional_amt</xsl:with-param>
       <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
       <xsl:with-param name="currency-readonly">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
     <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">narrative_additional_amount</xsl:with-param>
      <xsl:with-param name="label">XSL_ADDITIONAL_AMT_DETAILS</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
	     <xsl:call-template name="textarea-field">
	      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
	      <xsl:with-param name="cols">35</xsl:with-param>
	      <xsl:with-param name="rows">4</xsl:with-param>
	      <xsl:with-param name="maxlines">4</xsl:with-param>
	     </xsl:call-template>
	    </xsl:with-param>
	    </xsl:call-template>
     </xsl:if>
     <xsl:if test="$displaymode='view' and narrative_additional_amount[.!='']">
	      <xsl:call-template name="big-textarea-wrapper">
	      <xsl:with-param name="label">XSL_ADDITIONAL_AMT_DETAILS</xsl:with-param>
	      <xsl:with-param name="content"><div class="content">
	        <xsl:value-of select="narrative_additional_amount"/>
	      </div></xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     
      <xsl:if test="($displaymode='view' and total_amt[.!='']) or $displaymode='edit'">
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_LICENSE_TOTAL_AMT</xsl:with-param>
       <xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
       <xsl:with-param name="override-amt-name">total_amt</xsl:with-param>
       <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
       <xsl:with-param name="currency-readonly">Y</xsl:with-param>
       <xsl:with-param name="amt-readonly">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
      <!-- Can show outstanding amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-outstanding-amt='Y' or $displaymode='view'">
      
      
       <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
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
      <!-- Variation in drawing. -->
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
       </xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
  <!--Validity Details-->
  <xsl:template name="ls-validity-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_VALIDITY_DETAILS_LABEL</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_VALID_FROM</xsl:with-param>
       <xsl:with-param name="name">valid_from_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      <xsl:choose>
      	<xsl:when test="$displaymode='edit'">
	      	<xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_VALIDITY_PERIOD</xsl:with-param>
		       <xsl:with-param name="name">valid_for_nb</xsl:with-param>
		       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
		       <xsl:with-param name="size">3</xsl:with-param>
		       <xsl:with-param name="maxsize">3</xsl:with-param>
		       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
		       <xsl:with-param name="type">integer</xsl:with-param>
		       <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
		    </xsl:call-template>
	      	<xsl:call-template name="select-field">
		       <xsl:with-param name="label"></xsl:with-param>
		       <xsl:with-param name="name">valid_for_period</xsl:with-param>
		       <xsl:with-param name="fieldsize">small</xsl:with-param>
		       <xsl:with-param name="appendClass">inlineBlock legalType</xsl:with-param>
		       <xsl:with-param name="options">
		       <xsl:call-template name="valid-for-period-options"/>
		      </xsl:with-param>
		    </xsl:call-template>
      	</xsl:when>
      	<xsl:otherwise>
      		<xsl:if test="valid_for_period[.!=''] and valid_for_nb[.!='']">
	      		<xsl:call-template name="input-field">
	      			<xsl:with-param name="label">XSL_VALIDITY_PERIOD</xsl:with-param>
	      			<xsl:with-param name="value"><xsl:value-of select="valid_for_nb"/>&nbsp;<xsl:value-of select="localization:getCodeData($language,'*','*','C029', valid_for_period)"/></xsl:with-param>
	      		</xsl:call-template>
      		</xsl:if>
      	</xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_VALID_TO</xsl:with-param>
       <xsl:with-param name="name">valid_to_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_LATEST_PAYMENT_DATE</xsl:with-param>
       <xsl:with-param name="name">latest_payment_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
    Valid For Period Dropdown C029(i.e  01- Days, 02- Weeks, 03- Months, 04- Years)
   -->
  <xsl:template name="valid-for-period-options">
  	<xsl:for-each select="periods/period_details">
   <option>
	<xsl:attribute name="value">
	            <xsl:value-of select="period_code"></xsl:value-of>
	</xsl:attribute>
	            <xsl:value-of select="period_desc"/>
   </option>
    </xsl:for-each>
  </xsl:template> 
  
   <xsl:template name="legal-id-types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <option>
            <xsl:attribute name="value"></xsl:attribute>
    </option>
     <xsl:for-each select="legal_ids/legal_types/legal_id_type">
     	<option>
     		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
     	    <xsl:value-of select="."></xsl:value-of>
     	</option>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:value-of select="legal_id_type"></xsl:value-of>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 
  
    <!--
   Amend amount details.
   
   By default, it looks for the ls_tnx_record node, but a different node can
   be passed in.
   -->
  <xsl:template name="ls-amend-amt-details">
   <xsl:param name="tnx-record" select="org_previous_file/ls_tnx_record"/>
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   
   <xsl:variable name="cur-code-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:variable name="org-amt-name">org_<xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
     <xsl:variable name="product-amt-name"><xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
     <xsl:variable name="org-amt-val" select="$tnx-record//*[name()=$product-amt-name]"/>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LS_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name"><xsl:value-of select="$org-amt-name"/></xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="$org-amt-val"/></xsl:with-param>
	      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	     </xsl:call-template>
	     <xsl:if test="$displaymode='edit'">
	      <xsl:call-template name="hidden-field"> 
	       <xsl:with-param name="name"><xsl:value-of select="$cur-code-name"/></xsl:with-param>
	      </xsl:call-template>
	     </xsl:if>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">inc_amt</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">dec_amt</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LS_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	     </xsl:call-template>
     &nbsp;
     <!-- Additional Amount -->
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_ADDITIONAL_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_additional_amt</xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/ls_tnx_record/additional_amt"/></xsl:with-param>
	      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ADDITIONAL_INC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">additional_inc_amt</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ADDITIONAL_DEC_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">additional_dec_amt</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_ADDITIONAL_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	      <xsl:with-param name="override-amt-name">additional_amt</xsl:with-param>
	     </xsl:call-template>
	     <xsl:choose>
		     <xsl:when test="$displaymode='edit'">
		     	 <xsl:call-template name="textarea-field">
				      <xsl:with-param name="label">XSL_ORG_ADDITIONAL_AMT_DETAILS</xsl:with-param>
				      <xsl:with-param name="name">org_narrative_additional_amount</xsl:with-param>
				      <xsl:with-param name="cols">35</xsl:with-param>
				      <xsl:with-param name="rows">4</xsl:with-param>
				      <xsl:with-param name="maxlines">4</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
				      <xsl:with-param name="messageValue"><xsl:value-of select="org_previous_file/ls_tnx_record/narrative_additional_amount"/></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="textarea-field">
				      <xsl:with-param name="label">XSL_NEW_ADDITIONAL_AMT_DETAILS</xsl:with-param>
				      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
				      <xsl:with-param name="cols">35</xsl:with-param>
				      <xsl:with-param name="rows">4</xsl:with-param>
				      <xsl:with-param name="maxlines">4</xsl:with-param>
			     </xsl:call-template>
		     </xsl:when>
		     <xsl:otherwise>
		     	  <xsl:call-template name="big-textarea-wrapper">
				      <xsl:with-param name="label">XSL_ORG_ADDITIONAL_AMT_DETAILS</xsl:with-param>
				      <xsl:with-param name="content"><div class="content">
				        <xsl:value-of select="org_previous_file/ls_tnx_record/narrative_additional_amount"/>
				      </div></xsl:with-param>
				  </xsl:call-template>
			      <xsl:call-template name="big-textarea-wrapper">
				      <xsl:with-param name="label">XSL_NEW_ADDITIONAL_AMT_DETAILS</xsl:with-param>
				      <xsl:with-param name="content"><div class="content">
				        <xsl:value-of select="narrative_additional_amount"/>
				      </div></xsl:with-param>
				  </xsl:call-template>
	     	 </xsl:otherwise>
     	 </xsl:choose>
     &nbsp;
     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOTAL_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_total_amt</xsl:with-param>
	      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/ls_tnx_record/total_amt"/></xsl:with-param>
	 </xsl:call-template>
	     
	 <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOTAL_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	      <xsl:with-param name="override-amt-name">total_amt</xsl:with-param>
	 </xsl:call-template>
     
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- 
   Amend Shipment Details.
   
   By default, it looks for the ls_tnx_record node, but a different node can
   be passed in.
  -->
  <xsl:template name="ls-amend-shipment-details">
   <xsl:param name="tnx-record" select="org_previous_file/ls_tnx_record"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">toplevel-header</xsl:when>
      <xsl:otherwise>indented-header</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_CTY_OF_ORIGIN</xsl:with-param>
       <xsl:with-param name="id">origin_country_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/origin_country!=''"><xsl:value-of select="localization:getCodeData($language,'*','*','C006',$tnx-record/origin_country)"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:choose>
	      <xsl:when test="$displaymode='edit'">
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_CTY_OF_ORIGIN</xsl:with-param>
		       <xsl:with-param name="name">origin_country</xsl:with-param>
		       <xsl:with-param name="size">2</xsl:with-param>
			   <xsl:with-param name="maxsize">2</xsl:with-param>
			   <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			   <xsl:with-param name="uppercase">Y</xsl:with-param>
			   <xsl:with-param name="prefix">origin</xsl:with-param>
			   <xsl:with-param name="button-type">codevalue</xsl:with-param>
		      </xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_CTY_OF_ORIGIN</xsl:with-param>
		       <xsl:with-param name="name">origin_country</xsl:with-param>
			   <xsl:with-param name="value">
		        <xsl:choose>
		         <xsl:when test="origin_country[.!='']"><xsl:value-of select="localization:getCodeData($language,'*','*','C006',origin_country)"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
		        </xsl:choose>
		       </xsl:with-param>
		      </xsl:call-template>
	      </xsl:otherwise>
      </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_CTY_OF_SUPPLY</xsl:with-param>
      <xsl:with-param name="id">supply_country_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/supply_country!=''"><xsl:value-of select="localization:getCodeData($language,'*','*','C006',$tnx-record/supply_country)"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
	      <xsl:when test="$displaymode='edit'">
		     <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_CTY_OF_SUPPLY</xsl:with-param>
		      <xsl:with-param name="name">supply_country</xsl:with-param>
		      <xsl:with-param name="size">2</xsl:with-param>
			  <xsl:with-param name="maxsize">2</xsl:with-param>
			  <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			  <xsl:with-param name="uppercase">Y</xsl:with-param>
			  <xsl:with-param name="prefix">supply</xsl:with-param>
			  <xsl:with-param name="button-type">codevalue</xsl:with-param>
		     </xsl:call-template>
		   </xsl:when>
		   <xsl:otherwise>
			   <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_CTY_OF_SUPPLY</xsl:with-param>
		       <xsl:with-param name="name">supply_country</xsl:with-param>
			   <xsl:with-param name="value">
		       <xsl:choose>
		        <xsl:when test="supply_country[.!='']"><xsl:value-of select="localization:getCodeData($language,'*','*','C006',supply_country)"/></xsl:when>
		        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
		       </xsl:choose>
		      </xsl:with-param>
		      </xsl:call-template>
		   </xsl:otherwise>
	 </xsl:choose>
	  <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_INCO_TERM_YEAR</xsl:with-param>
      <xsl:with-param name="id">inco_term_year_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/inco_term_year!=''"><xsl:value-of select="$tnx-record/inco_term_year"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
         <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
         <xsl:call-template name="select-field">
	 	<xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_INCO_TERM_YEAR</xsl:with-param>
		<xsl:with-param name="name">inco_term_year</xsl:with-param>	 
		 <xsl:with-param name="fieldsize">small</xsl:with-param>
		  <xsl:with-param name="required">N</xsl:with-param>	 
	</xsl:call-template>
	   </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="inco_year"><xsl:value-of select="inco_term_year"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_INCO_TERM_YEAR</xsl:with-param>
					<xsl:with-param name="name">inco_term_year_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$inco_year"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_INCO_TERM</xsl:with-param>
      <xsl:with-param name="id">inco_term_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/inco_term!=''"><xsl:value-of select="$tnx-record/inco_term"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
    	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
	  <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
       </xsl:when>
		<xsl:otherwise>
		<xsl:variable name="incoTerm"><xsl:value-of select="inco_term"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_INCO_TERM</xsl:with-param>
					<xsl:with-param name="name">inco_term_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','N212',$incoTerm)"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_INCO_PLACE</xsl:with-param>
      <xsl:with-param name="id">inco_place_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/inco_place!=''"><xsl:value-of select="$tnx-record/inco_place"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_INCO_PLACE</xsl:with-param>
      <xsl:with-param name="name">inco_place</xsl:with-param>
      <xsl:with-param name="maxsize">35</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--Amend Validity Details-->
  <xsl:template name="ls-amend-validity-details">
  <xsl:param name="tnx-record" select="org_previous_file/ls_tnx_record"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_VALIDITY_DETAILS_LABEL</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORG_VALID_FROM</xsl:with-param>
       <xsl:with-param name="name">valid_from_date_view</xsl:with-param>
       <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/valid_from_date!=''"><xsl:value-of select="$tnx-record/valid_from_date"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_NEW_VALID_FROM</xsl:with-param>
       <xsl:with-param name="name">valid_from_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      
	  <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_ORG_VALIDITY_PERIOD</xsl:with-param>
	     <xsl:with-param name="name">valid_for_nb_view</xsl:with-param>
	     <xsl:with-param name="value">
	     <xsl:choose>
	       <xsl:when test="$tnx-record/valid_for_nb!='' and $tnx-record/valid_for_period!=''"><xsl:value-of select="$tnx-record/valid_for_nb"/>&nbsp;<xsl:value-of select="localization:getCodeData($language,'*','*','C029', $tnx-record/valid_for_period)"/></xsl:when>
	       <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
	     </xsl:choose>
	     </xsl:with-param>
	     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
	    
	  <xsl:choose>
		  <xsl:when test="$displaymode='edit'">
			  <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_NEW_VALIDITY_PERIOD</xsl:with-param>
			     <xsl:with-param name="name">valid_for_nb</xsl:with-param>
			     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			     <xsl:with-param name="size">3</xsl:with-param>
			     <xsl:with-param name="maxsize">3</xsl:with-param>
			     <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
			     <xsl:with-param name="type">integer</xsl:with-param>
			     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			  </xsl:call-template>
			  <xsl:call-template name="select-field">
			     <xsl:with-param name="label"></xsl:with-param>
			     <xsl:with-param name="name">valid_for_period</xsl:with-param>
			     <xsl:with-param name="fieldsize">small</xsl:with-param>
			     <xsl:with-param name="appendClass">inlineBlock legalType</xsl:with-param>
			     <xsl:with-param name="options">
			     <xsl:call-template name="valid-for-period-options"/>
			     </xsl:with-param>
			  </xsl:call-template>
		  </xsl:when>
		  <xsl:otherwise>
			  <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_NEW_VALIDITY_PERIOD</xsl:with-param>
			     <xsl:with-param name="id">valid_for_period</xsl:with-param>
			     <xsl:with-param name="value">
				     <xsl:choose>
				       <xsl:when test="valid_for_nb[.!=''] and valid_for_period[.!='']"><xsl:value-of select="valid_for_nb"/>&nbsp;<xsl:value-of select="localization:getCodeData($language,'*','*','C029', valid_for_period)"/></xsl:when>
				       <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
				     </xsl:choose>
			     </xsl:with-param>
			  </xsl:call-template>
		  </xsl:otherwise>
	  </xsl:choose>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORG_VALID_TO</xsl:with-param>
       <xsl:with-param name="name">valid_to_date_view</xsl:with-param>
       <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/valid_to_date!=''"><xsl:value-of select="$tnx-record/valid_to_date"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_NEW_VALID_TO</xsl:with-param>
       <xsl:with-param name="name">valid_to_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORG_LATEST_PAYMENT_DATE</xsl:with-param>
       <xsl:with-param name="name">latest_payment_date_view</xsl:with-param>
       <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/latest_payment_date!=''"><xsl:value-of select="$tnx-record/latest_payment_date"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:choose>
		  <xsl:when test="$displaymode='edit'">
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_NEW_LATEST_PAYMENT_DATE</xsl:with-param>
		       <xsl:with-param name="name">latest_payment_date</xsl:with-param>
		       <xsl:with-param name="fieldsize">small</xsl:with-param>
		       <xsl:with-param name="size">10</xsl:with-param>
		       <xsl:with-param name="maxsize">10</xsl:with-param>
		       <xsl:with-param name="type">date</xsl:with-param>
		      </xsl:call-template>
		  </xsl:when>
		  <xsl:otherwise>
		  		<xsl:call-template name="input-field">
			       <xsl:with-param name="label">XSL_NEW_LATEST_PAYMENT_DATE</xsl:with-param>
			       <xsl:with-param name="name">latest_payment_date</xsl:with-param>
			       <xsl:with-param name="value">
				       <xsl:choose>
				        <xsl:when test="latest_payment_date[.!='']"><xsl:value-of select="latest_payment_date"/></xsl:when>
				        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
				       </xsl:choose>
			      </xsl:with-param>
		      </xsl:call-template>
		  </xsl:otherwise>
	  </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="linked-ls-declaration">
  		 <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">ls_delete_icon</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:with-param>
		   </xsl:call-template>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_LICENSES</xsl:with-param>
			<xsl:with-param name="content">
				<div id="ls-items-template">
					<div class="clear multigrid">
						<script type="text/javascript">
							var gridLayoutLicense, pluginsData;
							dojo.ready(function(){
						    	gridLayoutLicense = {"cells" : [
						                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "REFERENCEID", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_BACK_OFFICE_REFERENCE')"/>", "field": "BO_REF_ID", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LICENSE_NUMBER')"/>", "field": "LS_NUMBER", "width": "20%%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LS_AMT')"/>", "field": "LS_AMT", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LS_OS_AMT')"/>", "field": "LS_OS_AMT", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CONVERTED_OS_AMT')"/>", "field": "CONVERTED_OS_AMT", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"},
						                   {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_AMT')"/>", "field":"LS_ALLOCATED_AMT", "width": "10em", "type": dojox.grid.cells._Widget},
						                   <!-- {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_ADD_AMT')"/>", "field":"LS_ALLOCATED_ADD_AMT", "width": "10em", "type": dojox.grid.cells._Widget}, -->
						                   {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_ALLOW_OVERDRAW')"/>", "field":"ALLOW_OVERDRAW", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"}
						                   <xsl:if test="$displaymode='edit'">
						                   		,{ "noresize":"true", "name": "&nbsp;", "field": "ACTION", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "formatter": misys.grid.formatHTML}
						                    ]
						                   </xsl:if>
						        ]};
								pluginsData = {indirectSelection: {headerSelector: "false",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
							});
						</script>
						<div style="width:100%;height:100%;" class="widgetContainer clear">
						<xsl:choose>
	
						 <xsl:when test="$mode='DRAFT' and  $displaymode = 'edit'">
							<table class="grid" plugins="pluginsData" structure="gridLayoutLicense"
								autoHeight="true" id="gridLicense" dojoType="dojox.grid.EnhancedGrid" selectionMode="none" selectable="false" singleClickEdit="true"
								noDataMessage="{localization:getGTPString($language, 'XSL_NO_LINKED_LS_ITEMS')}" 
								escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
								<thead>
									<tr></tr>
								</thead>
								<tfoot>
									<tr><td></td></tr>
								</tfoot>
								<tbody>
									<tr><td></td></tr>
								</tbody>
							</table>
						</xsl:when>
						<xsl:otherwise>
						<div  id="gridLicense" style="display:none;border-width:0" dojoType="dojox.grid.EnhancedGrid" ></div>
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
						     <xsl:attribute name="id">ls_table</xsl:attribute>
						      <xsl:choose>
						      	<xsl:when test="linked_licenses/license">
							      <thead>
							       <tr>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_BACK_OFFICE_REFERENCE')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'LICENSE_NUMBER')"/></th>
							       	<th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_AMT')"/></th>
							       	<!-- <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_ADD_AMT')"/></th> -->
							       </tr>
							      </thead>
							      <tbody>
									<xsl:attribute name="id">license_table_details</xsl:attribute>      
							         <xsl:for-each select="linked_licenses/license">
							          <tr>
							         	<td><xsl:value-of select="ls_ref_id"/></td>
							         	<td><xsl:value-of select="bo_ref_id"/></td>
							           	<td><xsl:value-of select="ls_number"/></td>
							           	<td><xsl:value-of select="ls_allocated_amt"/></td>
							           	<!-- <td><xsl:value-of select="ls_allocated_add_amt"/></td> -->
							          </tr>
							         </xsl:for-each>
							      </tbody>
							    </xsl:when>
							    <xsl:otherwise>
							      	<div><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_LINKED_LS_ITEMS')"/></div>
							      	<tbody></tbody>
							    </xsl:otherwise>
						      </xsl:choose>
						     </table>
						</xsl:otherwise>
						</xsl:choose>
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
						<xsl:if test="$displaymode='edit'">
						<div id="license-items-add" class="widgetContainer">
							<div id="license_lookup" type="button" dojoType="dijit.form.Button">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LINK_LS_ITEMS')" />
							</div>
						</div>
						</xsl:if>	
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
  
  <xsl:template name="linked-licenses">
		<script type="text/javascript">
			var linkedLsItems =[];
			<xsl:for-each select="linked_licenses/license">
				var refLs = "<xsl:value-of select="ls_ref_id"/>";
				linkedLsItems.push({ "REFERENCEID" :"<xsl:value-of select="ls_ref_id"/>", "BO_REF_ID" :"<xsl:value-of select="bo_ref_id"/>", "LS_NUMBER":"<xsl:value-of select="ls_number"/>", "LS_ALLOCATED_AMT" :"<xsl:value-of select="ls_allocated_amt"/>", "LS_AMT" :"<xsl:value-of select="ls_amt"/>", "LS_OS_AMT" :"<xsl:value-of select="ls_os_amt"/>", "CONVERTED_OS_AMT" :"<xsl:value-of select="converted_os_amt"/>", "ALLOW_OVERDRAW" :"<xsl:value-of select="allow_overdraw"/>", "ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteLsRecord(refLs)\"/>]]>"});
			</xsl:for-each>	
		</script>
	</xsl:template>
</xsl:stylesheet>