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
  <xsl:param name="product-code">TD</xsl:param>
  <xsl:param name="sub-product-code">TRTD</xsl:param>
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TreasuryTermDepositScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="./request_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
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
		
		<!-- Reauthentication -->
	  <xsl:call-template name="reauthentication" />
	  <xsl:call-template name="reauth_params"/>	
					
      <xsl:call-template name="rollover-details"/>
	  <xsl:call-template name="reverse-details"/>
	  <xsl:call-template name="rebook-details"/>
	  
	  <xsl:call-template name="request-button">
	  	<xsl:with-param name="display">N</xsl:with-param>
      </xsl:call-template>
	  <xsl:call-template name="submit-button"/>


	<!-- response Details. -->
	<xsl:call-template name="TD-Response-details"/>

	<!-- WAITING POPUPS -->
	<xsl:call-template name="waiting-Dialog"/>
	<xsl:call-template name="loading-Dialog"/>

     </xsl:with-param>
    </xsl:call-template>

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
   <xsl:with-param name="binding">misys.binding.cash.TradeMessageTdBinding</xsl:with-param>
   <xsl:with-param name="override-help-access-key">TRTD_03</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
    <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
    </xsl:call-template>
  </xsl:if>
   
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
     <xsl:with-param name="name">remarks</xsl:with-param>
    </xsl:call-template>
    
    	<xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
		 </xsl:call-template>
		 <xsl:call-template name="hidden-field">
	    		<xsl:with-param name="name">sub_product_code</xsl:with-param>
	    		<xsl:with-param name="value">TRTD</xsl:with-param>
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
       <xsl:with-param name="value" select="bo_ref_id" />
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">applicant_reference</xsl:with-param>
	  <xsl:with-param name="value" select="applicant_reference"/>
	 </xsl:call-template>
     
     <!--  System ID. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
      <xsl:with-param name="value" select="ref_id" />
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	   <xsl:with-param name="value" select="bo_ref_id" />
	   <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
     
     <xsl:if test="cust_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
       <xsl:with-param name="value" select="cust_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
      	<!-- old amount -->
	   	<xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code">td</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-name">org_td_amt</xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/td_tnx_record/td_amt"/></xsl:with-param>
	     </xsl:call-template>
	     
	     <div>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">td_cur_code</xsl:with-param>
	      </xsl:call-template>
	      
	      <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">td_amt</xsl:with-param>
		  </xsl:call-template>
	     </div>
     
     	<!-- original start date -->
		 <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_TD_ORG_START_DATE</xsl:with-param>
	      <xsl:with-param name="name">org_value_date</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/td_tnx_record/value_date" />
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	     
	     <!--original maturity date -->
		 <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_TD_ORG_MATURITY_DATE</xsl:with-param>
	      <xsl:with-param name="name">org_maturity_date</xsl:with-param>
	      <xsl:with-param name="value" select="org_previous_file/td_tnx_record/maturity_date" />
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
     
    	 <!-- interest label -->
	  	  <xsl:call-template name="currency-field">
		      <xsl:with-param name="label">XSL_TD_ORG_INTEREST_LABEL</xsl:with-param>
		      <xsl:with-param name="product-code">td</xsl:with-param>
		      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/td_tnx_record/interest"/></xsl:with-param>
		      <xsl:with-param name="override-amt-name">interest_td</xsl:with-param>
	 	  </xsl:call-template>
	 	  
	   <!-- new total amount with interest -->
	   	 <xsl:call-template name="currency-field">
	      <xsl:with-param name="label">XSL_TD_ORG_TOTAL_WITH_INTEREST_LABEL</xsl:with-param>
	      <xsl:with-param name="product-code">td</xsl:with-param>
	      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/td_tnx_record/total_with_interest"/></xsl:with-param>
	      <xsl:with-param name="override-amt-name">total_with_interest</xsl:with-param>
	  	 </xsl:call-template>
	  	 
	  	 <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">total_with_interest</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="org_previous_file/td_tnx_record/total_with_interest"/></xsl:with-param>
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
			      <xsl:with-param name="name">td_type</xsl:with-param>
			      <xsl:with-param name="readonly">N</xsl:with-param>
			      <xsl:with-param name="options">
			       <option value=""></option>
			      <xsl:call-template name="code-data-options">
					 <xsl:with-param name="paramId">C046</xsl:with-param>
					 <xsl:with-param name="productCode">TD</xsl:with-param>
					 <xsl:with-param name="specificOrder">Y</xsl:with-param>
					</xsl:call-template>
			      </xsl:with-param>
			    </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
 	</div>
 </xsl:template>

<!-- Div rollover -->
 <xsl:template name="rollover-details">
 	<div id="rollover-details">
 		<xsl:attribute name="style">display:none</xsl:attribute>
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_ROLLOVER_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
			
			<!-- start date -->
			 <xsl:call-template name="input-field">
			  <xsl:with-param name="id">rollover_start_date</xsl:with-param>
		      <xsl:with-param name="label">XSL_TD_START_DATE</xsl:with-param>
		      <xsl:with-param name="value" select="org_previous_file/td_tnx_record/maturity_date" />
		      <xsl:with-param name="override-displaymode">view</xsl:with-param>
		     </xsl:call-template>
		     
		    <xsl:call-template name="hidden-field">
			  <xsl:with-param name="name">input_value_date</xsl:with-param>
		      <xsl:with-param name="value" select="org_previous_file/td_tnx_record/maturity_date" />
			</xsl:call-template>	
			
			
				<!-- maturity date -->
		  				<xsl:call-template name="input-date-or-term-field">
					       <xsl:with-param name="label">XSL_TRTD_MATURITY_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="name">input_maturity</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="term-options">							
								<xsl:call-template name="code-data-options">
									<xsl:with-param name="paramId">C045</xsl:with-param>
									<xsl:with-param name="productCode">TD</xsl:with-param>
									<xsl:with-param name="specificOrder">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						    <xsl:with-param name="date">
								<xsl:choose>
									<xsl:when test="request_value_term_number[.!='']"><xsl:value-of select="request_value_term_number"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="request"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="code">
								<xsl:choose>
									<xsl:when test="request_value_term_code[.!='']"><xsl:value-of select="request_value_term_code"/></xsl:when>
								</xsl:choose>
							</xsl:with-param>
			   			</xsl:call-template>
			      
			      
		      <!-- old amount -->
		    	<xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_AMT_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code">td</xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
			      <xsl:with-param name="override-amt-name">org_reminder_td_amt</xsl:with-param>
			      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/td_tnx_record/td_amt"/></xsl:with-param>
			     </xsl:call-template>
			   
			     <!-- Increase / Decrease Amt -->
			     <xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code">td</xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="override-amt-name">inc_amt</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code">td</xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="override-amt-name">dec_amt</xsl:with-param>
			     </xsl:call-template>
			     <!-- new amount -->
			     <xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_TD_AMOUNTDETAILS_ROLLOVER_AMT_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code">td</xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
			      <xsl:with-param name="override-amt-name">rollover_td_amt</xsl:with-param>
			     </xsl:call-template>
			     <!-- Interest Capitalisation -->
			     <xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label">XSL_TD_INTEREST_CAPITALISATION_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_YES</xsl:with-param>
							<xsl:with-param name="name">interest_capitalisation</xsl:with-param>
							<xsl:with-param name="id">interest_capitalisation_Y</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_NO</xsl:with-param>
							<xsl:with-param name="name">interest_capitalisation</xsl:with-param>
							<xsl:with-param name="id">interest_capitalisation_N</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="checked">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				 <!--remarks-->
			      <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_TD_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">input_rollover_remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">70</xsl:with-param>
				</xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	</div>
 </xsl:template>

<xsl:template name="TD-Response-details">
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
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">trade_id</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rec_id</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">maturity_report</xsl:with-param>
			<xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
					<xsl:otherwise><xsl:value-of select="maturity_date"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">rate_report</xsl:with-param>
			<xsl:with-param name="label">XSL_TD_RATE_LABEL</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
					<xsl:otherwise><xsl:value-of select="rate"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">interest_report</xsl:with-param>
			<xsl:with-param name="label">XSL_TD_INTEREST_LABEL</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
					<xsl:otherwise><xsl:value-of select="rate"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rate</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">value_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">maturity_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">interest</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="$displaymode='view'">
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">total_with_interest</xsl:with-param>
				<xsl:with-param name="label">XSL_TD_TOTAL_WITH_INTEREST_LABEL</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">remarks</xsl:with-param>
				<xsl:with-param name="label">XSL_TD_REMARKS_LABEL</xsl:with-param>
			</xsl:call-template>
					
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">reversal_reason</xsl:with-param>
				<xsl:with-param name="label">XSL_TD_CANCEL_REASON_LABEL</xsl:with-param>
			</xsl:call-template> 
		</xsl:if>
		
	</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="reverse-details">
 	<div id="reverse-details">
 		<xsl:attribute name="style">display:none</xsl:attribute>
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_REVERSE_DETAILS</xsl:with-param>
		    <xsl:with-param name="toc-item">N</xsl:with-param>
		    <xsl:with-param name="content">
		    	<xsl:call-template name="input-field">
			    	<xsl:with-param name="label">XSL_TD_CANCEL_REASON_LABEL</xsl:with-param>
			     	<xsl:with-param name="name">reversal_reason</xsl:with-param>			     
			     	<xsl:with-param name="required">Y</xsl:with-param>
			  	</xsl:call-template>		    
		    </xsl:with-param>
		</xsl:call-template>
	</div>
 </xsl:template>

 <xsl:template name="rebook-details">
 	<div id="rebook-details">
 		<xsl:attribute name="style">display:none</xsl:attribute>
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_REBOOK_DETAILS</xsl:with-param>
		    <xsl:with-param name="toc-item">N</xsl:with-param>
		    <xsl:with-param name="content">
			    <xsl:call-template name="input-field">
				    	<xsl:with-param name="label">XSL_TD_CANCEL_REASON_LABEL</xsl:with-param>
				     	<xsl:with-param name="name">rebook_reason</xsl:with-param>			     
				     	<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_TD_AMOUNT_LABEL</xsl:with-param>
				    <xsl:with-param name="product-code">rebook_input_td</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
			   	</xsl:call-template>
				<xsl:call-template name="input-date-term-field">
			        <xsl:with-param name="label">XSL_TD_VALUE_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="name">rebook_input_value</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="term-options">
				     	<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
				     	<option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
				     	<option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
				     	<option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
				     </xsl:with-param>
				     <xsl:with-param name="static-options">
				     	<option value="SPOT"><xsl:value-of select="localization:getDecode($language, 'N413', 'SPOT')"/></option>
				    </xsl:with-param>
				    <xsl:with-param name="date">
						<xsl:choose>
							<xsl:when test="value_date_term_number[.!='']"><xsl:value-of select="value_date_term_number"/></xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="value_date"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="code">
						<xsl:choose>
							<xsl:when test="value_date_term_code[.!='']"><xsl:value-of select="value_date_term_code"/></xsl:when>
						</xsl:choose>
					</xsl:with-param>
			      </xsl:call-template> 				
					<!-- maturity date -->
			    <xsl:call-template name="input-date-term-field">
			        <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="name">rebook_input_maturity</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>	      				
					<xsl:with-param name="term-options">
				     	<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
				     	<option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
				     	<option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
				     	<option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
				     </xsl:with-param>
				    <xsl:with-param name="date">
						<xsl:choose>
							<xsl:when test="maturity_date_term_number[.!='']"><xsl:value-of select="maturity_date_term_number"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="maturity_date"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="code">
						<xsl:choose>
							<xsl:when test="maturity_date_term_code[.!='']"><xsl:value-of select="maturity_date_term_code"/></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
			      </xsl:call-template>
			       <!-- remarks -->
			      <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_TD_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">input_rebook_remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">70</xsl:with-param>
				</xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	</div>
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
     <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">productcode</xsl:with-param>
	  <xsl:with-param name="value" select="$product-code" />
	 </xsl:call-template>
	 <xsl:call-template name="hidden-field">
 	  <xsl:with-param name="name">subproductcode</xsl:with-param>
	  <xsl:with-param name="value" select="$sub-product-code" />
	 </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>