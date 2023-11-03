<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Term Deposit (TD) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Satyanarayana R	
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    exclude-result-prefixes="localization xmlRender">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">TD</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/bank_fx_common.xsl" />
  <xsl:include href="../../collaboration/xsl/collaboration.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="td_tnx_record"/>
  </xsl:template>
 
 <!-- 
   FX TNX FORM TEMPLATE.
  -->
  <xsl:template match="td_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   <xsl:apply-templates select="deposit_details"/>
   <script>
		dojo.ready(function(){
		misys._config = misys._config || {};
		dojo.mixin(misys._config, {
			maturityCodes :  new Array(),
			maturityCodesDescription : new Array()
			
		});
		<xsl:for-each select="maturity_instructions/deposit_type">
			<xsl:variable name="depositName"><xsl:value-of select="deposit_name"/></xsl:variable>
			misys._config.maturityCodes["<xsl:value-of select="$depositName"/>"] = new Array(<xsl:value-of select="count(maturity_instruction)"/>);
			misys._config.maturityCodesDescription["<xsl:value-of select="$depositName"/>"] = new Array(<xsl:value-of select="count(maturity_instruction)"/>);
			<xsl:for-each select="maturity_instruction">
				<xsl:variable name="position" select="position() - 1" />
				misys._config.maturityCodes["<xsl:value-of select="$depositName"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="maturity_code"/>";
      			misys._config.maturityCodesDescription["<xsl:value-of select="$depositName"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="maturity_name"/>";
			</xsl:for-each>
		</xsl:for-each>
		});
	</script>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
    
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    
    <!--<xsl:choose>
     <xsl:when test="tnx_type_code[.='15']">
      --><!-- Link to display transaction contents -->
      <xsl:call-template name="transaction-details-link"/>
      
      <div id="transactionDetails">
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         
         <!-- Disclaimer Notice -->
         <xsl:call-template name="disclaimer"/>
         
         <xsl:call-template name="hidden-fields"/>
         <xsl:call-template name="general-details"/>
         <xsl:if test="fx_rates_type and fx_rates_type[.!='']">
        	<xsl:call-template name="bank-fx-template">
        	<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	</xsl:call-template>
         </xsl:if>
         <xsl:call-template name="maturity-instructions-details"/>
         <xsl:call-template name="transactional-remarks-details"></xsl:call-template>
         </xsl:with-param>
       </xsl:call-template>
      </div>
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
    <!--  Collaboration Window -->   
   <xsl:if test="$collaborationmode != 'none'">
   	<xsl:call-template name="collaboration">
	    <xsl:with-param name="editable">true</xsl:with-param>
	    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
	    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
	    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
		<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
	</xsl:call-template>
   </xsl:if>

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
   <xsl:with-param name="binding">misys.binding.bank.report_td</xsl:with-param>
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="override-product-code">fx</xsl:with-param>
  </xsl:call-template>
  <xsl:if test="fx_rates_type and fx_rates_type[.!='']">
	   <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
	     <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">fx_master_currency</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">fx_nbr_contracts</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="fx_nbr_contracts"/></xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
 </xsl:template>
 
 <!-- 
  TD General Details
  -->
  <xsl:template name="general-details">
  	<!-- General details for fx order -->
  	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<!-- Value Date -->
			<xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_FACTOR_PRO_VALUE_DATE</xsl:with-param>
		     <xsl:with-param name="name">value_date</xsl:with-param>
		     <xsl:with-param name="value" select="value_date" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    </xsl:call-template>
			<!-- Applicant Details -->
			<!-- Hidden fields since show-name and show-address disabled after -->
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_name</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_name"/>
		     </xsl:call-template>
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_address_line_1"/>
		     </xsl:call-template>
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_address_line_2"/>
		     </xsl:call-template>
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">applicant_dom</xsl:with-param>
		      <xsl:with-param name="value" select="applicant_dom"/>
		     </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">value_date</xsl:with-param>
		      <xsl:with-param name="value" select="value_date"/>
		    </xsl:call-template> 
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">selected_td_type</xsl:with-param>
		      <xsl:with-param name="value" select="td_type"/>
		    </xsl:call-template> 
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">selected_tenor_type</xsl:with-param>
		      <xsl:with-param name="value"><xsl:value-of select="value_date_term_number"/>_<xsl:value-of select="value_date_term_code"/></xsl:with-param>
		    </xsl:call-template> 
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">selected_maturity_type</xsl:with-param>
		      <xsl:with-param name="value" select="maturity_instruction"/>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">selected_td_cur</xsl:with-param>
		      <xsl:with-param name="value" select="td_cur_code"/>
		    </xsl:call-template> 
		   <!-- Entity Field -->
	       <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
	       <xsl:with-param name="id">entity_view</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
           <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">entity</xsl:with-param>
	       <xsl:with-param name="value" select="entity"/>
	       </xsl:call-template> 
	       
	       <!-- placement account and td service implemented -->
	       
	       <xsl:call-template name="hidden-field">
			  <xsl:with-param name="name">placement_account_enabled</xsl:with-param>
		      <xsl:with-param name="value"><xsl:value-of select="Placement_account_enabled"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">service_enabled</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="interest_inquiry_impl"/></xsl:with-param>
			</xsl:call-template>				
	   		
	   		<!-- Deposit Type -->
	   		<xsl:if test="td_type and td_type[.!='' and .!='*']">
		      <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_TD_DEPOSIT_TYPE</xsl:with-param>
			    <xsl:with-param name="name">td_type</xsl:with-param>
			    <xsl:with-param name="value" select="localization:getDecode($language, 'N414', td_type)"/>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			  </xsl:call-template>
			  </xsl:if>
			 <!-- Tenor days -->
			 <xsl:if test="value_date_term_number and value_date_term_number[.!='']">
			 <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
			    <xsl:with-param name="id">tenor_term_code</xsl:with-param>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="value_date_term_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', value_date_term_code)"/></xsl:with-param>
			 </xsl:call-template>
			 </xsl:if>
			 <!-- Placement Account -->
			 <div id="placement-div">
			        <xsl:call-template name="user-account-field">
			  	        <xsl:with-param name="label">XSL_TD_TERM_DEPOSIT_ACCOUNT</xsl:with-param>
			  	        <xsl:with-param name="name">placement</xsl:with-param>
					    <xsl:with-param name="entity-field">entity</xsl:with-param>
					    <xsl:with-param name="dr-cr">credit</xsl:with-param>
					    <xsl:with-param name="product_types">TD</xsl:with-param>
					    <xsl:with-param name="required">
					    	<xsl:choose>
								<xsl:when test="Placement_account_enabled[.='Y']">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>			    	
					    	</xsl:choose>
					    </xsl:with-param>
					    <xsl:with-param name="show-product-types">N</xsl:with-param>
					    <xsl:with-param name="value"><xsl:value-of select="placement_act_name"/></xsl:with-param>
					    <xsl:with-param name="show-clear-button">N</xsl:with-param>
					    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			        </xsl:call-template>
			   </div>    	
			 <!-- Placement Amount -->
			 <xsl:call-template name="td-placement-amt-details">
		       <xsl:with-param name="override-product-code">td</xsl:with-param>
		     </xsl:call-template>
		     <!-- Interest Rate -->
		     <xsl:if test="interest and interest[.!='']">
			     <div id="interest-rate">
			     <xsl:choose>
			     <xsl:when test="service_enabled[.='Y']">
			     <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_TD_INTEREST_RATE_PA</xsl:with-param>
			     <xsl:with-param name="name">interest</xsl:with-param>
			     <xsl:with-param name="size">5</xsl:with-param>
			     <xsl:with-param name="maxsize">5</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="interest"/></xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
			     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			     <xsl:with-param name="content-after">%</xsl:with-param>
			     </xsl:call-template>
			     </xsl:when>
			     <xsl:otherwise>
			       <xsl:call-template name="input-field">
			       <xsl:with-param name="label">XSL_TD_INTEREST_RATE_PA</xsl:with-param>
			       <xsl:with-param name="name">interest</xsl:with-param>
			       <xsl:with-param name="size">5</xsl:with-param>
			       <xsl:with-param name="maxsize">5</xsl:with-param>
			       <xsl:with-param name="value"><xsl:value-of select="interest"/></xsl:with-param>
			       <xsl:with-param name="required">N</xsl:with-param>
			       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			       <xsl:with-param name="content-after">%</xsl:with-param>
			     </xsl:call-template>  
			     
			     </xsl:otherwise>
			     </xsl:choose>
			     </div>
		     </xsl:if>
		    <!-- Debit Account --> 
		    <xsl:if test="applicant_act_name and applicant_act_name[.!='']">
		     <xsl:call-template name="user-account-field">
			  	<xsl:with-param name="label">XSL_TD_DEBIT_ACCOUNT</xsl:with-param>
			  	<xsl:with-param name="name">applicant</xsl:with-param>
			    <xsl:with-param name="entity-field">entity</xsl:with-param>
			    <xsl:with-param name="dr-cr">debit</xsl:with-param>
			    <xsl:with-param name="product_types">TD</xsl:with-param>
			    <xsl:with-param name="required">Y</xsl:with-param>
			    <xsl:with-param name="show-product-types">N</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="applicant_act_name"/></xsl:with-param>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			  </xsl:call-template>
			 </xsl:if>	
	 </xsl:with-param>    
	</xsl:call-template>
  </xsl:template>
   <!-- Placement Amount Fields -->
    <!-- Placement Amount Fields -->
  <xsl:template name="td-placement-amt-details">
  	<xsl:param name="override-product-code" select="$lowercase-product-code"/>
  	<div>
		<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">td_amt</xsl:with-param>
	      <xsl:with-param name="value" select="td_amt"/>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">td_cur_code</xsl:with-param>
	      <xsl:with-param name="value" select="td_cur_code"/>
	    </xsl:call-template>  
	   <xsl:call-template name="input-field">
     	 <xsl:with-param name="label">XSL_TD_PLACEMENT_AMOUNT</xsl:with-param>
	     <xsl:with-param name="value"><xsl:value-of select="td_cur_code"/>&nbsp;<xsl:value-of select="td_amt"/></xsl:with-param>
	     <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>   
  	</div>
  </xsl:template>
 <!--Maturity Instructions Details-->
   <xsl:template name="maturity-instructions-details">
  	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_TD_MATURITY_INSTRUCTIONS_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		<!-- maturity instructions -->
		<xsl:if test="maturity_instruction_name and maturity_instruction_name[.!='']">
			<xsl:choose>
				<xsl:when test="(td_type and td_type[.!='' or .!='*'])">
					<xsl:call-template name="input-field">
					       <xsl:with-param name="label">XSL_TD_MATURITY_INSTRUCTIONS</xsl:with-param>
					       <xsl:with-param name="id">maturity_instruction</xsl:with-param>
					       <xsl:with-param name="value"><xsl:value-of select="maturity_instruction_name"/></xsl:with-param>
					       <xsl:with-param name="readonly">Y</xsl:with-param>
					       <xsl:with-param name="override-displaymode">view</xsl:with-param>
					  </xsl:call-template> 
					  <xsl:call-template name="hidden-field">
					     <xsl:with-param name="name">maturity_instruction</xsl:with-param>
					  </xsl:call-template>    
					  <xsl:call-template name="hidden-field">
					     <xsl:with-param name="name">maturity_instruction_name</xsl:with-param>
					  </xsl:call-template> 
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="select-field">
					    <xsl:with-param name="label">XSL_TD_MATURITY_INSTRUCTIONS</xsl:with-param>
					    <xsl:with-param name="id">maturity_instruction</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="value">
					    <xsl:choose>
					    <xsl:when test="maturity_instruction[.!='']"><xsl:value-of select="maturity_instruction_name"/></xsl:when>
					    <xsl:otherwise></xsl:otherwise>
					    </xsl:choose>
					    </xsl:with-param>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
			<!-- Credit Account --> 
		    <xsl:call-template name="user-account-field">
			  	<xsl:with-param name="label">XSL_TD_CREDIT_ACCOUNT</xsl:with-param>
			  	<xsl:with-param name="name">credit</xsl:with-param>
			    <xsl:with-param name="entity-field">entity</xsl:with-param>
			    <xsl:with-param name="dr-cr">credit</xsl:with-param>
			    <xsl:with-param name="product_types">TD</xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			    <xsl:with-param name="show-product-types">N</xsl:with-param>
			    <xsl:with-param name="show-clear-button">N</xsl:with-param>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="credit_act_name"/></xsl:with-param>	
			 </xsl:call-template>	
		</xsl:with-param>
	</xsl:call-template>
   </xsl:template>
   
  	<!-- Transactional Remarks -->
   <xsl:template name="transactional-remarks-details">
  	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_TD_TRANSACTION_REMARKS</xsl:with-param>
		<xsl:with-param name="content">
		<xsl:call-template name="row-wrapper">
		      <xsl:with-param name="type">textarea</xsl:with-param>
		      <xsl:with-param name="content">
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">remarks</xsl:with-param>
		        <xsl:with-param name="rows">2</xsl:with-param>
				<xsl:with-param name="cols">114</xsl:with-param>
				<xsl:with-param name="maxlines">2</xsl:with-param>
				<xsl:with-param name="button-type"></xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
     		</xsl:call-template> 
		</xsl:with-param>
	</xsl:call-template>
   </xsl:template>
   
   <xsl:template match="deposit_details">
     <xsl:apply-templates select="deposit_type"/>
   </xsl:template>

	<xsl:template match="deposit_type">
	<script>
	dojo.ready(function(){
	misys._config = misys._config || {};
	misys._config.depositTypes = misys._config.depositTypes || [];
	misys._config.depositTypes.push("<xsl:value-of select="deposit_name"/>,<xsl:value-of select="localization:getDecode($language, 'N414', deposit_name)"/>");
	misys._config.depositTypes['<xsl:value-of select="deposit_name"/>'] = misys._config.depositTypes['<xsl:value-of select="deposit_name"/>'] || [];
	<xsl:apply-templates select="tenor_type" />
	});
	</script>
	</xsl:template>

	<xsl:template match="tenor_type">
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor = misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor || [];
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor.push("<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>");
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'] = misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'] || [];
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'].key = "<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>";
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'].value = "<xsl:value-of select="tenor_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', tenor_code)"/>"
	<xsl:apply-templates select="currency_code" />
	</xsl:template>
	
	<xsl:template match="currency_code">
	misys._config.depositTypes['<xsl:value-of select="../../deposit_name"/>'].tenor['<xsl:value-of select="../tenor_number"/>_<xsl:value-of select="../tenor_code"/>'].currency = misys._config.depositTypes['<xsl:value-of select="../../deposit_name"/>'].tenor['<xsl:value-of select="../tenor_number"/>_<xsl:value-of select="../tenor_code"/>'].currency || [];
	misys._config.depositTypes['<xsl:value-of select="../../deposit_name"/>'].tenor['<xsl:value-of select="../tenor_number"/>_<xsl:value-of select="../tenor_code"/>'].currency.push("<xsl:value-of select="."/>");
	</xsl:template>
   
</xsl:stylesheet>