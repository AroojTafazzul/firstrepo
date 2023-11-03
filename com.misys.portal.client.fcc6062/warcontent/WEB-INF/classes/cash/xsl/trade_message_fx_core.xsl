<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Request for Foreign Exchange (XO) Form, Customer Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        exclude-result-prefixes="localization">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">FX</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/ForeignExchangeScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="./request_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="fx_tnx_record"/>
  </xsl:template>
  
  <!-- 
   FX TNX FORM TEMPLATE.
  -->
  <xsl:template match="fx_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div >
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
       <xsl:call-template name="menu">
       <xsl:with-param name="show-save">N</xsl:with-param>
       <xsl:with-param name="show-submit">N</xsl:with-param>
       <xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>

      <xsl:call-template name="action-details"/>

     <!--  <xsl:call-template name="split-details"/> -->
	  <xsl:call-template name="takedown-details"/>
	  <!-- <xsl:call-template name="extend-details"/> -->
	  <!-- <xsl:call-template name="uptake-details"/> -->
	  
	  <xsl:call-template name="request-button">
	   	<xsl:with-param name="display">N</xsl:with-param>
      </xsl:call-template>

	
	<!-- response Details. -->
	<xsl:call-template name="FX-Response-details"/>

	<!-- WAITING POPUPS -->
	<xsl:call-template name="waiting-Dialog"/>
	<xsl:call-template name="loading-Dialog"/>
	
	<xsl:call-template name="reauthentication" />
	<xsl:call-template name="e2ee_transaction"/>

	<xsl:call-template name="reauth_params"/>

     </xsl:with-param>
    </xsl:call-template>
    
     <xsl:call-template name="submit-button"/>

    <!-- Form #1 : Attach Files -->
    <!--  
    <xsl:call-template name="attachments-file-dojo"/>
	-->
	
    <xsl:call-template name="realform"/>

     <xsl:call-template name="menu">
		<xsl:with-param name="show-save">N</xsl:with-param>
	    <xsl:with-param name="show-submit">N</xsl:with-param>
	    <xsl:with-param name="show-template">N</xsl:with-param>
	    <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->
   <!--       
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id"></xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id"></xsl:with-param>
   </xsl:call-template>
 	-->
 
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
   <xsl:with-param name="binding">misys.binding.cash.message_fx</xsl:with-param>
   <xsl:with-param name="override-help-access-key">FX_03</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
<xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
     <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">applicant_abbv_name</xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">applicant_name</xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">applicant_dom</xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">appl_date</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">cust_ref_id</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">bo_ref_id</xsl:with-param>
      <xsl:with-param name="value" select="bo_ref_id" />
    </xsl:call-template>
 
     <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">applicant_reference</xsl:with-param>
	  <xsl:with-param name="value" select="applicant_reference"/>
	 </xsl:call-template>
	 
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">value_date</xsl:with-param>
	</xsl:call-template>
		
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">original_value_date</xsl:with-param>
		<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/value_date"/>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">option_date</xsl:with-param>
	</xsl:call-template>
	
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">maturity_date</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rate</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">fx_amt</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">fx_cur_code</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">counter_amt</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">counter_cur_code</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">contract_type</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">trade_id</xsl:with-param>
	</xsl:call-template>
		
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">rec_id</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">remarks</xsl:with-param>
	</xsl:call-template>
	
	<!-- Original Deal's values -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">org_fx_amt</xsl:with-param>
		<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/fx_amt"/>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">org_fx_cur_code</xsl:with-param>
		<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/fx_cur_code"/>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">org_counter_amt</xsl:with-param>
		<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counter_amt"/>
	</xsl:call-template>

	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">org_counter_cur_code</xsl:with-param>
		<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counter_cur_code"/>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">org_rate</xsl:with-param>
		<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/rate"/>
	</xsl:call-template>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">org_maturity_date</xsl:with-param>
		<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/maturity_date"/>
	</xsl:call-template>
	
    </xsl:with-param>
  </xsl:call-template>

 </xsl:template>

  <!--
    TD General Details Fieldset.
  -->
  <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <!-- <xsl:with-param name="button-type">summary-details</xsl:with-param> -->
   <xsl:with-param name="content">
    <div id="generaldetails">
     <!-- Hidden fields. -->
     
     <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	   <xsl:with-param name="value" select="bo_ref_id" />
	   <xsl:with-param name="override-displaymode">view</xsl:with-param>
	 </xsl:call-template>
     <!--  System ID. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
      <xsl:with-param name="value" select="ref_id" />
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <xsl:if test="cust_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
       <xsl:with-param name="value" select="cust_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
      <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_CONTRACT_FX_ORG_TYPE_LABEL</xsl:with-param>
	   <xsl:with-param name="value" select="localization:getGTPString($language, concat('FX_CONTRACT_TYPE_', org_previous_file/fx_tnx_record/sub_product_code))"/>
	   <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
	  
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL</xsl:with-param>
	   <xsl:with-param name="value" >
	    <xsl:choose>
		    <xsl:when test="org_previous_file/fx_tnx_record/contract_type=01">
		        <xsl:value-of select="localization:getGTPString($language,'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')"/>
		    </xsl:when>
		    <xsl:otherwise>
		 		<xsl:value-of select="localization:getGTPString($language,'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')"/>   
		    </xsl:otherwise>
	    </xsl:choose>
	   </xsl:with-param>
	   <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
	    
	    <!-- original amount --> 
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_CONTRACT_FX_ORG_CUR_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code">fx</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_fx_amt</xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/fx_tnx_record/original_amount"/></xsl:with-param>
	     </xsl:call-template>
	      
	    <!-- Available Amount -->	     
      	<xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_AMOUNT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code">fx</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">fx_amt</xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/fx_tnx_record/fx_amt"/></xsl:with-param>
	     </xsl:call-template>
	     
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_FX_COUNTER_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code">counter</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_counter_amt</xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/fx_tnx_record/counter_amt"/></xsl:with-param>
	     </xsl:call-template>
	     
	    <!-- original start date -->
		 <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_FX_ORG_VALUE_DATE</xsl:with-param>
	      <xsl:with-param name="name">org_value_date</xsl:with-param>
	 	  <xsl:with-param name="value" select="org_previous_file/fx_tnx_record/value_date" />
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	     
	     	<!-- original start date -->
		<xsl:if test="org_previous_file/fx_tnx_record/option_date[.!='']">
		 <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_FX_ORG_OPTION_DATE</xsl:with-param>
	      <xsl:with-param name="name">org_option_date</xsl:with-param>
	 	  <xsl:with-param name="value" select="org_previous_file/fx_tnx_record/option_date" />
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	    </xsl:if>
	     
	     	<!-- original start date -->
	    <xsl:if test="org_previous_file/fx_tnx_record/near_date[.!='']">
		 <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_FX_ORG_NEAR_DATE</xsl:with-param>
	      <xsl:with-param name="name">org_near_date</xsl:with-param>
	 	  <xsl:with-param name="value" select="org_previous_file/fx_tnx_record/near_date" />
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	    </xsl:if>
	     
	     <!--original maturity date -->
	     <xsl:if test="org_previous_file/fx_tnx_record/maturity_date[.!=''] and product_code='TD'">
		 <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_FX_ORG_MATURITY_DATE</xsl:with-param>
	      <xsl:with-param name="name">org_maturity_date</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/fx_tnx_record/maturity_date" />
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
     	</xsl:if>
     	
    	 <!-- rate label -->
	  	  <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_FX_ORG_RATE_LABEL</xsl:with-param>
		      <xsl:with-param name="product-code">fx</xsl:with-param>
		      <xsl:with-param name="override-displaymode">view</xsl:with-param>
		      <xsl:with-param name="value"><xsl:value-of select="org_previous_file/fx_tnx_record/rate"/></xsl:with-param>
		      <xsl:with-param name="name">org_rate_fx</xsl:with-param>
	 	  </xsl:call-template>

     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template> 
 
 <xsl:template name="action-details">
 	<div id="action-details">
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_DETAILS</xsl:with-param>
		    <xsl:with-param name="content"> 
			 	 <xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_TD_UPDATE_ACTION_LABEL</xsl:with-param>
			      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
			      <xsl:with-param name="readonly">N</xsl:with-param>
			      <xsl:with-param name="options">
			      <option value=""></option>
			      <xsl:choose>
			      		<xsl:when test="sub_product_code[.='SPOT'] or sub_product_code[.='FWD']">
						 <!--option value = 93  -->
						    <xsl:call-template name="code-data-options">
							 <xsl:with-param name="paramId">C039</xsl:with-param>
							 <xsl:with-param name="productCode">FX</xsl:with-param>
							 <xsl:with-param name="specificOrder">Y</xsl:with-param>
							</xsl:call-template>
						    
						</xsl:when>
						<xsl:when test="sub_product_code[.='WFWD'] or sub_product_code[.='DELIVERY_OPTION']">
							<!--option value = 31  -->
							<xsl:call-template name="code-data-options">
							 <xsl:with-param name="paramId">C040</xsl:with-param>
							 <xsl:with-param name="productCode">FX</xsl:with-param>
							 <xsl:with-param name="specificOrder">Y</xsl:with-param>
							</xsl:call-template>							
						</xsl:when>						
						<xsl:otherwise>
							<!--option value = -1  -->
							<option value="-1">
						     <xsl:value-of select="localization:getGTPString($language, 'XSL_FX_UPDATE_ACTION_NOACTION')"/>
							</option>	
						</xsl:otherwise>
					</xsl:choose>			      
			      </xsl:with-param>
			     </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
 	</div>
 </xsl:template>
 
<!-- <xsl:template name="split-details">
 	<div id="split-details">
 		<xsl:attribute name="style">display:none</xsl:attribute>
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_SPLIT_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
			 <xsl:call-template name="input-date-term-field">
		        <xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">input_split_value</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>	      				
				<xsl:with-param name="term-options">
					<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
				    <option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
				    <option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
				    <option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
				     </xsl:with-param>
				    <xsl:with-param name="date">
						<xsl:choose>
							<xsl:when test="input_split_value_date"><xsl:value-of select="input_split_value_date"/></xsl:when>
							<xsl:when test="input_split_value_DateTermNumber"><xsl:value-of select="input_split_value_DateTermNumber"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="code">
						<xsl:choose>
							<xsl:when test="input_split_value_DateTermCode"><xsl:value-of select="input_split_value_DateTermCode"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
			   </xsl:call-template>
			      <xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label">XSL_CONTRACT_FX_CURRENCY_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_SPLIT_CCY_LABEL</xsl:with-param>
							<xsl:with-param name="name">select_split_cur_code</xsl:with-param>
							<xsl:with-param name="id">select_split_cur_code_CCY</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
							<xsl:with-param name="checked">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_SPLIT_CTR_CCY_LABEL</xsl:with-param>
							<xsl:with-param name="name">select_split_cur_code</xsl:with-param>
							<xsl:with-param name="id">select_split_cur_code_CTR_CCY</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counter_cur_code"/></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
		      <xsl:call-template name="currency-field">
		       	  <xsl:with-param name="label">XSL_CONTRACT_FX_AMOUNT_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code">counter</xsl:with-param>
			      <xsl:with-param name="currency-readonly">Y</xsl:with-param>
			      <xsl:with-param name="override-currency-value"><xsl:value-of select="org_previous_file/fx_tnx_record/fx_cur_code"/></xsl:with-param>
			      <xsl:with-param name="override-amt-name">input_split_amt</xsl:with-param>
			      <xsl:with-param name="override-currency-name">input_split_cur_code</xsl:with-param>
		          <xsl:with-param name="required">Y</xsl:with-param>
		     </xsl:call-template>
		      	<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">input_split_remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">250</xsl:with-param>
				</xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	</div>
 </xsl:template>

 <xsl:template name="uptake-details">
 	<div id="uptake-details">
 		<xsl:attribute name="style">display:none</xsl:attribute>
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_UPTAKE_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
				<xsl:call-template name="input-date-term-field">
		        <xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">input_uptake_value</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>	      				
				<xsl:with-param name="term-options">
					<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
				    <option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
				    <option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
				    <option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
				     </xsl:with-param>
				    <xsl:with-param name="date">
						<xsl:choose>
							<xsl:when test="input_uptake_value_date"><xsl:value-of select="input_uptake_value_date"/></xsl:when>
							<xsl:when test="input_uptake_value_DateTermNumber"><xsl:value-of select="input_uptake_value_DateTermNumber"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="code">
						<xsl:choose>
							<xsl:when test="input_uptake_value_DateTermCode"><xsl:value-of select="input_uptake_value_DateTermCode"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
			      </xsl:call-template>
			    <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">input_uptake_remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">250</xsl:with-param>
				</xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	</div>
 </xsl:template>

 <xsl:template name="extend-details">
 	<div id="extend-details">
 		<xsl:attribute name="style">display:none</xsl:attribute>
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_EXTEND_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
				<xsl:call-template name="input-date-term-field">
		        <xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">input_extend_value</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>	      				
				<xsl:with-param name="term-options">
					<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
				    <option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
				    <option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
				    <option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
				     </xsl:with-param>
				    <xsl:with-param name="date">
						<xsl:choose>
							<xsl:when test="input_extend_value_date"><xsl:value-of select="input_extend_value_date"/></xsl:when>
							<xsl:when test="input_extend_value_DateTermNumber"><xsl:value-of select="input_extend_value_DateTermNumber"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="code">
						<xsl:choose>
							<xsl:when test="input_extend_value_DateTermCode"><xsl:value-of select="input_extend_value_DateTermCode"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
			      </xsl:call-template>
			      <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">input_extends_remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">250</xsl:with-param>
				  </xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	</div>
 </xsl:template> -->
 
<!-- Div takedown -->
 <xsl:template name="takedown-details">
 	<div id="takedown-details">
 		<xsl:attribute name="style">display:none</xsl:attribute>
		<xsl:call-template name="fieldset-wrapper">
		    <!-- <xsl:with-param name="legend">XSL_HEADER_ACTION_TAKEDOWN_DETAILS</xsl:with-param> -->
		    <xsl:with-param name="legend">
		    	<xsl:choose>
		    		<xsl:when test="sub_product_code[.='SPOT'] or sub_product_code[.='FWD']">XSL_HEADER_ACTION_PAYMENT_SPLIT_DETAILS</xsl:when>
		    		<xsl:otherwise>XSL_HEADER_ACTION_TAKEDOWN_DETAILS</xsl:otherwise>
		    	</xsl:choose>
		    </xsl:with-param>
		    <xsl:with-param name="content">
			<!-- start date -->
			 <xsl:call-template name="input-date-or-term-field">
		        <xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">input_takedown_value</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>	      				
				<xsl:with-param name="term-options">
					<option value="dt"><xsl:value-of select="localization:getDecode($language, 'N413', 'dt')"/></option>
					<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
				    <option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
				    <option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
				    <option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
				     </xsl:with-param>
				    <xsl:with-param name="date">
						<xsl:choose>
							<xsl:when test="input_takedown_value_date"><xsl:value-of select="input_takedown_value_date"/></xsl:when>
							<xsl:when test="input_takedown_value_number"><xsl:value-of select="input_takedown_value_number"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="code">
						<xsl:choose>
							<xsl:when test="input_takedown_value_code"><xsl:value-of select="input_takedown_value_code"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
			      </xsl:call-template>
				<xsl:call-template name="currency-field">
		       	  <xsl:with-param name="label">XSL_CONTRACT_FX_AMOUNT_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code">fx</xsl:with-param>
			      <xsl:with-param name="currency-readonly">Y</xsl:with-param>
			      <xsl:with-param name="override-currency-value"><xsl:value-of select="org_previous_file/fx_tnx_record/fx_cur_code"/></xsl:with-param>
			      <xsl:with-param name="override-amt-name">input_takedown_amt</xsl:with-param>
			      <xsl:with-param name="override-currency-name">input_takedown_cur_code</xsl:with-param>
		          <xsl:with-param name="required">Y</xsl:with-param>
		          <xsl:with-param name="show-button">N</xsl:with-param>
		     </xsl:call-template>
		      <!--remarks-->
			  <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">input_takedown_remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">70</xsl:with-param>
			  </xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	</div>
 </xsl:template>
 
<xsl:template name="FX-Response-details">
<xsl:call-template name="trade-details">
	<xsl:with-param name="content">
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">trade_id_report</xsl:with-param>
			<xsl:with-param name="label">XSL_TD_TRADE_ID_LABEL</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
					<xsl:otherwise><xsl:value-of select="trade_id"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<div id="split-trade-details">
		<xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_CONTRACT_FX_SPLIT_ORG_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code">fx</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_amount_report</xsl:with-param>
	      <xsl:with-param name="override-currency-value"><xsl:value-of select="org_previous_file/fx_tnx_record/fx_cur_code"/></xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_CONTRACT_FX_SPLIT_ORG_CTR_AMT_LABEL</xsl:with-param>
	       <xsl:with-param name="product-code">fx</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_ctr_amount_report</xsl:with-param>
	      <xsl:with-param name="override-currency-value"><xsl:value-of select="org_previous_file/fx_tnx_record/counter_cur_code"/></xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="input-field">
			<xsl:with-param name="name">org_rate_report</xsl:with-param>
			<xsl:with-param name="label">XSL_CONTRACT_FX_SPLIT_RATE_LABEL</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="org_previous_file/fx_tnx_record/rate"/></xsl:with-param>
		</xsl:call-template>
		</div>
		<xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_CONTRACT_FX_UPDATE_AMT_LABEL</xsl:with-param>
	       <xsl:with-param name="product-code">fx</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">amount_report</xsl:with-param>
	      <xsl:with-param name="override-currency-value"><xsl:value-of select="org_previous_file/fx_tnx_record/fx_cur_code"/></xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_CONTRACT_FX_UPDATE_CTR_AMT_LABEL</xsl:with-param>
	       <xsl:with-param name="product-code">fx</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">ctr_amount_report</xsl:with-param>
	      <xsl:with-param name="override-currency-value"><xsl:value-of select="org_previous_file/fx_tnx_record/counter_cur_code"/></xsl:with-param>
	    </xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">rate_report</xsl:with-param>
			<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
					<xsl:otherwise><xsl:value-of select="rate"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">value_date_report</xsl:with-param>
			<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
					<xsl:otherwise><xsl:value-of select="value_date"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="$displaymode='view'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">input_takedown_remarks</xsl:with-param>
				<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
	</xsl:with-param>
	</xsl:call-template>
</xsl:template>

  <!--
   Hidden fields for Request for Financing
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
      <xsl:with-param name="value">13</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">attIds</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">TransactionData</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">option</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>