<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Secure Email (SE) Form, Customer Side.
 
Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      03/12/10
author:    Saïd SAI
email:     said.sai0@misys.com
##########################################################
-->

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
  <xsl:param name="option"/>
  <xsl:param name="tnxType"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SE</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/SecureEmailScreen</xsl:param>
  <xsl:param name="thecase">
  	<xsl:choose>
  		<xsl:when test="//se_type!=''">
  			<xsl:choose>
  				<xsl:when test="//se_type='02'">SE_DEPOSIT</xsl:when>
  				<xsl:when test="//se_type='06'">SE_CHEQUE</xsl:when>
  				<xsl:when test="(//se_type='09' or  //se_type='10') and //sub_product_code='ADVNO'">SE_ADVICES_NOTIFICATIONS</xsl:when>
  				<xsl:when test="(//se_type='09' or  //se_type='10') and //sub_product_code='OTHER'">SE_OTHER</xsl:when>
  				<xsl:otherwise>SE_CORRESPONDENCE</xsl:otherwise>
  			</xsl:choose>
  		</xsl:when>
  		<xsl:when test="$option!=''"><xsl:value-of select="$option"/></xsl:when>
  		<xsl:otherwise>SE_CORRESPONDENCE</xsl:otherwise>
  	</xsl:choose>
  </xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
    
    <xsl:variable name="setype">
        <xsl:choose>
            <xsl:when test="$thecase='SE_CHEQUE'">06</xsl:when>
            <xsl:when test="$thecase='SE_DEPOSIT'">02</xsl:when>
            <xsl:otherwise><xsl:value-of select="se_type"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

  <!-- Global Imports. -->
  
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="se_tnx_record"/>
  </xsl:template>

  <!-- 
   SE TNX FORM TEMPLATE.
  -->
  <xsl:template match="se_tnx_record"> 
   <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
   
   <div>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="menu" />
      
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      
      <xsl:choose>
      	<xsl:when test="$thecase='SE_CHEQUE'">
      		<xsl:call-template name="general-details" />
      		<xsl:call-template name="order-book" />
      	</xsl:when>
      	<xsl:when test="$thecase='SE_DEPOSIT'">
      		<xsl:call-template name="general-details" />
      		<xsl:call-template name="fixed-term-deposit" />
      		<xsl:call-template name="free-format-message" />
      	</xsl:when>
      	<xsl:otherwise>
			<xsl:call-template name="general-details" />
			<xsl:call-template name="free-format-message" />
      	</xsl:otherwise>
      </xsl:choose>
      
     </xsl:with-param>
    </xsl:call-template>
      
    <xsl:choose>
 		<xsl:when test="$thecase='SE_CORRESPONDENCE'">
 			<!-- Attach Files -->
    		<xsl:call-template name="attachments-file-dojo"/>
      	</xsl:when>
      	<xsl:when test="$thecase='SE_CHEQUE'">
      	
      	</xsl:when>
      	<xsl:when test="$thecase='SE_DEPOSIT'">
 			<!-- Attach Files -->
    		<xsl:call-template name="attachments-file-dojo"/>
      	</xsl:when>
	</xsl:choose>

    <!-- The form that is submitted -->
    <xsl:call-template name="realform"/>

    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
 
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">
	    <xsl:choose>
	 		<xsl:when test="$thecase='SE_CORRESPONDENCE'">misys.binding.trade.correspondence_se</xsl:when>
	      	<xsl:when test="$thecase='SE_CHEQUE'">misys.binding.trade.correspondence_se</xsl:when>
	      	<xsl:when test="$thecase='SE_DEPOSIT'">misys.binding.trade.correspondence_se</xsl:when>
		</xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="override-help-access-key">SE_01</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">brch_code</xsl:with-param>
     <xsl:with-param name="value" select="brch_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_id</xsl:with-param>
     <xsl:with-param name="value" select="company_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_name</xsl:with-param>
     <xsl:with-param name="value" select="company_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_id</xsl:with-param>
     <xsl:with-param name="value" select="tnx_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
     <xsl:with-param name="value" select="//ctl_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
     <xsl:with-param name="value" select="inp_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">prod_stat_code</xsl:with-param>
     <xsl:with-param name="value" select="prod_stat_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">date_time</xsl:with-param>
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
      <xsl:call-template name="se-general-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="se-general-details">
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <!-- Don't display this in unsigned mode. -->
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </div>
   <!-- Entity -->
    <xsl:if test="$displaymode='view' and entity[.!='']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
     <xsl:with-param name="name">entity</xsl:with-param>
     <xsl:with-param name="value" select="entity"/>
   </xsl:call-template>		
   </xsl:if>			
					
   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
    <xsl:if test="$displaymode='view' and cust_ref_id[.!=' ']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
     <xsl:with-param name="value" select="cust_ref_id"/>
   </xsl:call-template>
   </xsl:if>   
   
   <!--  Application date. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
    <xsl:with-param name="id">appl_date_view</xsl:with-param>
    <xsl:with-param name="value" select="appl_date" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>

   <!-- Instruction -->
   <xsl:if test="sub_product_code[.!='CTCHP']">
 	<xsl:choose>
 		<xsl:when test="$thecase='SE_CHEQUE' or $thecase='SE_DEPOSIT'">
 		   <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PAYMENTDETAILS_SE_INSTRUCTION</xsl:with-param>
		    <xsl:with-param name="id">se_type_view</xsl:with-param>
		    <xsl:with-param name="value" select="localization:getDecode($language, 'N430', $setype)" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name">se_type</xsl:with-param>
	        <xsl:with-param name="value" select="$setype"/>
	       </xsl:call-template>
	       <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">topic</xsl:with-param>
		     <xsl:with-param name="value" select="localization:getDecode($language, 'N430', $setype)"/>
		   </xsl:call-template>
 		</xsl:when>
 		<xsl:when test="$thecase='SE_ADVICES_NOTIFICATIONS' or sub_product_code='ADVNO'">
 		  <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_SECURE_EMAIL_TYPE</xsl:with-param>
		    <xsl:with-param name="id">se_type_view</xsl:with-param>
		    <xsl:with-param name="value" select="localization:getDecode($language, 'N047', 'ADVNO')"/>
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		   </xsl:call-template>
 		</xsl:when>
 		<xsl:when test="$thecase='SE_OTHER' or sub_product_code='OTHER'">
 		  <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_SECURE_EMAIL_TYPE</xsl:with-param>
		    <xsl:with-param name="id">se_type_view</xsl:with-param>
		    <xsl:with-param name="value" select="localization:getDecode($language, 'N047', 'OTHER')"/>
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		   </xsl:call-template>
 		</xsl:when>
 		<xsl:otherwise>
 		   <xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_PAYMENTDETAILS_SE_INSTRUCTION</xsl:with-param>
			<xsl:with-param name="name">se_type</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="options">
			  <xsl:call-template name="instruction-types"/>
			</xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">topic</xsl:with-param>
		     <xsl:with-param name="value"/>
		   </xsl:call-template>
		   <div></div>
 		</xsl:otherwise>
 	</xsl:choose>
 	</xsl:if>
	   
   <!-- Ordering Account -->
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_ACT_NO_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">account</xsl:with-param>
     <xsl:with-param name="type">account</xsl:with-param>
     <xsl:with-param name="name">act_no</xsl:with-param>
     <xsl:with-param name="id">act_no</xsl:with-param>
     <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="size">34</xsl:with-param>
     <xsl:with-param name="maxsize">34</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="applicant_act_no"/></xsl:with-param>
   </xsl:call-template>

   <xsl:if test="$displaymode='view' and bo_ref_id[.!=' ']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_BANK_REF</xsl:with-param>
     <xsl:with-param name="name">bo_ref_id</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id"/>
   </xsl:call-template>
   </xsl:if>
   
   <xsl:if test="$displaymode='view' and se_priority[.!=' ']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_PRIORITY</xsl:with-param>
     <xsl:with-param name="name">priority</xsl:with-param>
     <xsl:with-param name="value" select="se_priority"/>
   </xsl:call-template>
   </xsl:if>
   
 <xsl:if test="$displaymode='view' and priority[.!=' ']">
   <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SE_PRIORITY</xsl:with-param>
      <xsl:with-param name="name">priority</xsl:with-param>
       <xsl:with-param name="value">
           <xsl:choose>
             <xsl:when test="priority[.='1']">
                    <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_HIGH')"/>
             </xsl:when>
             <xsl:when test="priority[.='2']">
                     <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_MEDIUM')"/>
             </xsl:when>
             <xsl:when test="priority[.='3']">
                    <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_LOW')"/>
             </xsl:when>
           </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:if>  
   
  <xsl:choose>
  <xsl:when test="$displaymode='view' and topic[.!=' '] and sub_product_code[.! = 'CTCHP']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_TOPIC</xsl:with-param>
     <xsl:with-param name="name">topic</xsl:with-param>
     <xsl:with-param name="value" select="topic"/>
   </xsl:call-template>
    </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_TOPIC</xsl:with-param>
     <xsl:with-param name="name">topic</xsl:with-param>
     <xsl:with-param name="value" select="topic_description"/>
   </xsl:call-template>
   </xsl:otherwise>
   </xsl:choose>
   
   <xsl:if test="se_type[.!='']">
   <xsl:choose>
   <xsl:when test="$displaymode='view' and se_type[. = '09']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_ADVICES_TYPE</xsl:with-param>
	 <xsl:with-param name="value" select="localization:getDecode($language, 'N430', '09')"/>
   </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_ADVICES_TYPE</xsl:with-param>
	 <xsl:with-param name="value" select="localization:getDecode($language, 'N430', '10')"/>
   </xsl:call-template>
   </xsl:otherwise>
   </xsl:choose>
   </xsl:if>
   
   <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:if test="$displaymode='edit'">
        <script>
        	dojo.ready(function(){
        		misys._config = misys._config || {};
				misys._config.customerReferences = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
			});
		</script>
       </xsl:if>
       <xsl:call-template name="main-bank-selectbox">
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="customer-reference-selectbox">
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
   
  </xsl:template>
  
  <!-- Template for Order Book -->
  <xsl:template name="order-book">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_ORDER_CHEQUE_BOOK</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="se-order-book"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="se-order-book">
    
    <!-- No of books required -->
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_CHEQUEBOOK_NO</xsl:with-param>
     <xsl:with-param name="name">checkbook_no</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="applicant_act_no"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="options">
     	<xsl:choose>
     		<xsl:when test="$displaymode='edit'">
		      <option value="1">
	              <xsl:if test="checkbook_no='1'">
	                <xsl:attribute name="selected">selected</xsl:attribute>
	              </xsl:if>1</option>
              <option value="2">
                  <xsl:if test="checkbook_no='2'">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                  </xsl:if>2</option>
              <option value="3">
                  <xsl:if test="checkbook_no='3'">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                  </xsl:if>3</option>
		    </xsl:when>
		    <xsl:otherwise>
		      <option><xsl:attribute name="value"><xsl:value-of select="//checkbook_no"/></xsl:attribute><xsl:value-of select="//checkbook_no"/></option>
		    </xsl:otherwise>
	    </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- format -->
    <xsl:call-template name="multioption-group">
     <xsl:with-param name="group-label">XSL_GENERALDETAILS_CHEQUEBOOK_FORMAT</xsl:with-param>
     <xsl:with-param name="content">
       <xsl:call-template name="radio-field">
	    <xsl:with-param name="label">XSL_CHEQUEBOOK_STANDARD</xsl:with-param>
	    <xsl:with-param name="name">chequebook_format</xsl:with-param>
	    <xsl:with-param name="id">chequebook_format_1</xsl:with-param>
	    <xsl:with-param name="value">STANDARD</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="radio-field">
	    <xsl:with-param name="label">XSL_CHEQUEBOOK_LARGE</xsl:with-param>
	    <xsl:with-param name="name">chequebook_format</xsl:with-param>
	    <xsl:with-param name="id">chequebook_format_2</xsl:with-param>
	    <xsl:with-param name="value">LARGE</xsl:with-param>
	   </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    
  </xsl:template>
  
  <xsl:template name="instruction-types">
  	  <xsl:choose>
	  	<xsl:when test="$displaymode='edit'">
	  		<option value="01">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '01')"/>
		    </option>
		    <option value="03">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '03')"/>
		     </option>
		     <option value="04">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '04')"/>
		     </option>
		     <option value="05">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '05')"/>
		     </option>
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<option>
	  		  <xsl:attribute name="value"><xsl:value-of select="//se_type"/> </xsl:attribute>
		      <xsl:value-of select="localization:getDecode($language, 'N430', //se_type)"/>
		    </option>
	  	</xsl:otherwise>
	  </xsl:choose>

  </xsl:template>
  
  <!-- Free format message -->
  
  <xsl:template name="free-format-message">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CORRESPONDENCE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text_row</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">free_format_text</xsl:with-param>
        <xsl:with-param name="rows">16</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="button-type"></xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- Fixed term deposit details -->
  
  <xsl:template name="fixed-term-deposit">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_FIX_DEPOSIT_HEADER_INSTRUCTION</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="fixed-term-deposit-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <xsl:template name="fixed-term-deposit-details">
  	<!-- Start Date --> 
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_SCHEDULED_START_DATE</xsl:with-param>
    <xsl:with-param name="name">exec_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="swift-validate">N</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   
   <!-- Amount -->
   
   <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_SE_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="product-code">se</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   
   <!-- 	Select Term or Maturity -->
    <xsl:call-template name="multioption-group">
     <xsl:with-param name="group-label">XSL_GENERALDETAILS_FIX_DEPOSIT_TERM_MATURITY</xsl:with-param>
     <xsl:with-param name="content">
       <xsl:call-template name="radio-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_FIX_DEPOSIT_TERM</xsl:with-param>
	    <xsl:with-param name="name">term_type_radio</xsl:with-param>
	    <xsl:with-param name="id">term_type_radio_1</xsl:with-param>
	    <xsl:with-param name="value">01</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="radio-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_FIX_DEPOSIT_MATUTITY_DATE</xsl:with-param>
	    <xsl:with-param name="name">term_type_radio</xsl:with-param>
	    <xsl:with-param name="id">term_type_radio_2</xsl:with-param>
	    <xsl:with-param name="value">02</xsl:with-param>
	   </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   
  </xsl:template>
  
  <!--
   SE Realform.
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
       <xsl:with-param name="name">mode</xsl:with-param>
       <xsl:with-param name="value" select="$mode"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value" select="$tnxType" ></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>