<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all Letter of Credit forms for displaying
updated data (i.e. LC, SI).

Letter of Credit forms should import this template after importing
trade_common.xsl (on the customer side) or bank_common.xsl (on the bank
side).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      01/08/15
author:    Shailly Palod
email:     shailly.palod@misys.com
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
	xmlns:common="http://exslt.org/common"
	exclude-result-prefixes="localization utils common">
  
  
 <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
 <xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param> 
 
  <!-- This template displays the common general details fieldset of the transaction like ref_id, bo_ref_id, template_id etc.-->
   <xd:doc>
  	<xd:short>LC common general details.</xd:short>
  	<xd:detail>
		Common general detail fieldset.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="common-general-details-new">
   <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
   <xsl:param name="cross-ref-summary-option"></xsl:param>
    <xsl:param name="path"></xsl:param>
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <!-- Don't display this in unsigned mode. -->
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">appl_date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>

   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="common:node-set($path)/ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <!-- Bank Reference -->
   <!-- Shown in consolidated view -->
   <xsl:if test="common:node-set($path)/bo_ref_id!='' and (not(common:node-set($path)/tnx_id) or common:node-set($path)/tnx_type_code[.!='01'] or common:node-set($path)/preallocated_flag[.='Y'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/bo_ref_id" />
    </xsl:call-template>
   </xsl:if>
   
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="common:node-set($path)/cross_references">
     <xsl:apply-templates select="common:node-set($path)/cross_references" mode="display_table_tnx">
     	<xsl:with-param name="cross-ref-summary-option"><xsl:value-of select="$cross-ref-summary-option"/></xsl:with-param>
    </xsl:apply-templates>
   </xsl:if>
    
   <!-- Template ID. -->
   <xsl:if test="$show-template-id='Y'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="name">template_id</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/template_id"></xsl:with-param>
     <xsl:with-param name="size">15</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
	     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	     <xsl:with-param name="value" select ="common:node-set($path)/cust_ref_id"></xsl:with-param>
	     <xsl:with-param name="size">20</xsl:with-param>
	     <xsl:with-param name="maxsize">34</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/appl_date" />
	 <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- This template displays the LC general details fieldset of the transaction -->
  <xsl:template name="lc-general-details-new">
  <xsl:param name="path"></xsl:param>
   <xsl:if test="$displaymode='edit'">
    <div>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">iss_date</xsl:with-param>
     </xsl:call-template>
    </div>
   </xsl:if>
   <!-- Issue Date -->
   <!-- Displayed in consolidated view -->
   <xsl:if test="(not(common:node-set($path)/tnx_id) or common:node-set($path)/tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/iss_date" />
    </xsl:call-template>
   </xsl:if>
   
   <!--  Expiry Date. --> 
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
    <xsl:with-param name="name">exp_date</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/exp_date" />
   </xsl:call-template>
      
   <!-- Expiry place. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
    <xsl:with-param name="name">expiry_place</xsl:with-param>
    <xsl:with-param name="value" select="common:node-set($path)/expiry_place" />
   </xsl:call-template>
      
   <!-- 
    Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
    Pass in a show-presentation parameter set to Y to display the presentation fields.
    
    If set to N, the template will instead insert a hidden field with the value 1.0
   -->
   <xsl:call-template name="eucp-details">
    <xsl:with-param name="show-eucp" select="$show-eucp"/>
   </xsl:call-template>
</xsl:template> 

<!-- This template displays the applicant address -->
   <xsl:template name="applicantaddress"> 
     <xsl:param name="path"></xsl:param>
	    <xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
	    	<xsl:with-param name="name">entity</xsl:with-param>
	    	<xsl:with-param name="value" select="common:node-set($path)/entity"/>
   		</xsl:call-template>
     
       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
		     <xsl:with-param name="name">applicant_name</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select ="common:node-set($path)/applicant_name"/></xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_address_line_1"/>		   
	   </xsl:call-template>
	   
	   <xsl:call-template name="input-field">
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_address_line_2"/>
	   </xsl:call-template>
	   
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
	    	<xsl:with-param name="name">country</xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',common:node-set($path)/applicant_country)"/>
   		</xsl:call-template>
   		
	   <xsl:call-template name="input-field">		   
		    <xsl:with-param name="name"><xsl:value-of select="applicant_dom"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_dom"/>
	   </xsl:call-template>
  </xsl:template>
    
    <!-- This template displays the beneficiary address -->
  <xsl:template name="beneficiaryaddress">
      <xsl:param name="path"></xsl:param>   
       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
		     <xsl:with-param name="name">applicant_name</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select ="common:node-set($path)/beneficiary_name"/></xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/beneficiary_address_line_1"/>		   
	   </xsl:call-template>
	   
	   <xsl:call-template name="input-field">
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/beneficiary_address_line_2"/>
	   </xsl:call-template>
	   
	   <xsl:call-template name="input-field">		   
		    <xsl:with-param name="name"><xsl:value-of select="applicant_dom"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/beneficiary_dom"/>
	   </xsl:call-template>
	   
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
	    	<xsl:with-param name="name">country</xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',common:node-set($path)/beneficiary_country)"/>
   		</xsl:call-template>
	   
	   <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
		     <xsl:with-param name="name">beneficiary_reference</xsl:with-param>
		     <xsl:with-param name="value" select="common:node-set($path)/beneficiary_reference"/>
	    </xsl:call-template>
   
  </xsl:template>
  
  <!-- This template displays the amount details section of the transaction -->
  <xsl:template name="lc-amt-details-new">
   <xsl:param name="show-form-lc">Y</xsl:param>
   <xsl:param name="show-variation-drawing">Y</xsl:param>
   <xsl:param name="show-bank-confirmation">N</xsl:param>
   <xsl:param name="show-outstanding-amt">Y</xsl:param>
   <xsl:param name="show-standby">Y</xsl:param>
   <xsl:param name="show-amt">Y</xsl:param>
   <xsl:param name="show-revolving">N</xsl:param>
   <xsl:param name="path"/>
   
     <div id="lc-amt-details">
     <xsl:if test="$show-form-lc='Y'">
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
        <xsl:with-param name="content"> 
          <xsl:if test="common:node-set($path)/irv_flag[.='Y']">
           <xsl:call-template name="input-field">          		 	
           	  <xsl:with-param name="name">irv_flag</xsl:with-param>
           	  <xsl:with-param name="value">
           	  <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')" />
           	 </xsl:with-param>
       	   </xsl:call-template>
       	   </xsl:if>
		   <xsl:if test="common:node-set($path)/ntrf_flag[.='Y']">
	          <xsl:call-template name="input-field">          		 	
	          	  <xsl:with-param name="name">irv_flag</xsl:with-param>
	          	  <xsl:with-param name="value">
	          	  <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')" />
	          	  </xsl:with-param>
	          </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-standby='Y'">
		       <xsl:if test="common:node-set($path)/stnd_by_lc_flag[.='Y']">
		          <xsl:call-template name="input-field">          		 	
		          	  <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
		          	  <xsl:with-param name="value">
		          	  <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_STAND_BY')" />
		          	  </xsl:with-param>
		          </xsl:call-template>
		       </xsl:if>
	       </xsl:if>
	       <xsl:if test="$show-revolving='Y'">
		       <xsl:if test="common:node-set($path)/revolving_flag[.='Y']">
		          <xsl:call-template name="input-field">          		 	
		          	  <xsl:with-param name="name">revolving_flag</xsl:with-param>
		          	  <xsl:with-param name="value">
		          	  <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOLVING')" />
		          	  </xsl:with-param>
		          </xsl:call-template>
		       </xsl:if>
	       </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
   
       <!-- Confirmation Instructions Radio Buttons -->
       <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_AMOUNTDETAILS_CFM_INST_LABEL</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:apply-templates select="common:node-set($path)/cfm_inst_code"/>
        </xsl:with-param>
       </xsl:call-template>
      
      </xsl:if>

      <!-- LC Currency and Amount -->
      <xsl:if test="$show-amt='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($path)/lc_amt"/></xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
      <!-- Can show outstanding amt field in the form. -->
      <!-- Also shown in consolidated view -->
      <xsl:if test="$show-outstanding-amt='Y'">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="value">
	      <xsl:if test="common:node-set($path)/lc_liab_amt[.!='']">	       
	         <xsl:value-of select="common:node-set($path)/lc_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="common:node-set($path)/lc_liab_amt"></xsl:value-of>
	      </xsl:if>
	    </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <!-- Variation in drawing. -->
      <xsl:if test="$show-variation-drawing='Y' and (common:node-set($path)/lc_type[.!='04'] or common:node-set($path)/tnx_type_code[.!='01'])">
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
           <xsl:with-param name="value">
             <xsl:value-of select="common:node-set($path)/pstv_tol_pct"></xsl:value-of>
           </xsl:with-param>
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
            <xsl:with-param name="value">
             <xsl:value-of select="common:node-set($path)/neg_tol_pct"></xsl:value-of>
           </xsl:with-param>
          </xsl:call-template>
         <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL</xsl:with-param>
           <xsl:with-param name="name">max_cr_desc_code</xsl:with-param>
           <xsl:with-param name="options">
            <xsl:choose>
             <xsl:when test="$displaymode='edit'">
                <option/>
	            <option value="3">
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
	            </option>
             </xsl:when>
             <xsl:otherwise>
              <xsl:if test="common:node-set($path)/max_cr_desc_code[. = '3']"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/></xsl:if>
             </xsl:otherwise>
            </xsl:choose>
           </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
       
       	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_BG_ISS_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_BG_CORR_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/cfm_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/cfm_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
      
      </xsl:if>
     </div>
  </xsl:template>
  
  <!-- This template displays the Credit Available with section of the transaction -->
  <xsl:template name="credit-available-by-new">
   <xsl:param name="show-drawee">Y</xsl:param>
  <xsl:param name="path"></xsl:param>
   <!-- Credit Available By radio buttons. -->
   <xsl:apply-templates select="common:node-set($path)/cr_avl_by_code">
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL</xsl:with-param>
   </xsl:apply-templates>

   <!--
    Payment/Draft At fields.
    
    Hidden fields, that depend on the radio button selected in Credit Available By.
   -->
   <div id="payment-draft">
   
     <div class="field">
     	<xsl:if test="common:node-set($path)/cr_avl_by_code[.='05']">
	    	<xsl:attribute name="style">display:none</xsl:attribute>
	   	</xsl:if>
      <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL')"/></span>
      <div class="content">
       <xsl:value-of select="common:node-set($path)/draft_term"/>
      </div>
     </div>
  
   <xsl:if test="$show-drawee='Y'">    
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
       <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="common:node-set($path)/drawee_details_bank">
         <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="show-button">N</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>     
   </xsl:if>
   </div>

  <!-- 
    Hidden by default in edit mode, or in view mode when
    cr_avl_by_code is not a mixed payment. 
  -->
  <div id="draft-term">
   <xsl:if test="common:node-set($path)/cr_avl_by_code[.!='05']">
    <xsl:attribute name="style">display:none</xsl:attribute>
   </xsl:if>
   <xsl:call-template name="row-wrapper">
    <xsl:with-param name="id">draft_term</xsl:with-param>
    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED_DETAILS</xsl:with-param>
    <xsl:with-param name="type">textarea</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">draft_term</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </div>
  </xsl:template>
  
  <!-- This template displays the shipment details section of the transaction -->
  <xsl:template name="lc-shipment-details-new">
  <xsl:param name="path"/>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:with-param>
      <xsl:with-param name="name">ship_from</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/ship_from" />
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_LOADING</xsl:with-param>
      <xsl:with-param name="name">ship_loading</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/ship_loading" />
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_DISCHARGE</xsl:with-param>
      <xsl:with-param name="name">ship_discharge</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/ship_discharge" />
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_TO</xsl:with-param>
      <xsl:with-param name="name">ship_to</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/ship_to" />
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="id">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="options">
      	<xsl:if test="common:node-set($path)/part_ship_detl[. = '' or . = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:if>
        <xsl:if test="common:node-set($path)/part_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:if>
        <xsl:if test="common:node-set($path)/part_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/></xsl:if>
        <xsl:if test="common:node-set($path)/part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/></xsl:if>
        </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or common:node-set($path)/part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">part_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="common:node-set($path)/part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="common:node-set($path)/part_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="id">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:if test="common:node-set($path)/tran_ship_detl[. = '' or . = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:if>
          <xsl:if test="common:node-set($path)/tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:if>
         <xsl:if test="common:node-set($path)/tran_ship_detl[. = 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/></xsl:if>
          <xsl:if test="common:node-set($path)/ran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/></xsl:if>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or common:node-set($path)/tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="id">tran_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="common:node-set($path)/tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> 
         <xsl:value-of select="common:node-set($path)/tran_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/last_ship_date" />
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="swift-validate">N</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="options">
	     <xsl:if test="common:node-set($path)/inco_term[. = 'EXW']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_EXW')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'FCA']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FCA')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'FAS']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FAS')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'FOB']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FOB')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'CFR']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CFR')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'CIF']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIF')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'DAT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAT')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'DAP']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAP')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'CPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CPT')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'CIP']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIP')"/></xsl:if>
	      <xsl:if test="common:node-set($path)/inco_term[. = 'DDP']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DDP')"/></xsl:if>
       </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
      <xsl:with-param name="name">inco_place</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/inco_place" />
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
     </xsl:call-template>            
  </xsl:template>
  
  <!-- This template displays the customer reference details section of the transaction -->
  <xsl:template name="customer-reference-selectbox-new">
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>
   <xsl:param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:param>
   <xsl:param name="path"></xsl:param>
   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="common:node-set($path)/recipient_bank/abbv_name"/>
   </xsl:variable>
 
   <xsl:variable name="sender-reference-value">
    <xsl:choose>
     <!-- current customer reference not null (draft) -->
     <xsl:when test="common:node-set($path)/applicant_reference != ''">
       <xsl:value-of select="common:node-set($path)/applicant_reference"/>
     </xsl:when>
     <!-- not entity defined and only one bank and only one customer reference available -->
     <xsl:when test="entities[.= '0']">
       <xsl:if test="count(common:node-set($path)/avail_main_banks/bank/customer_reference)=1">
         <xsl:value-of select="common:node-set($path)/avail_main_banks/bank/customer_reference/reference"/>
       </xsl:if>
     </xsl:when>
     <!-- only one entity, only one bank and only one customer reference available -->
     <xsl:otherwise>
       <xsl:if test="count(common:node-set($path)/avail_main_banks/bank/entity/customer_reference)=1">
         <xsl:value-of select="common:node-set($path)/avail_main_banks/bank/entity/customer_reference/reference"/>
       </xsl:if>          
     </xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   
   <!-- Check if customer references are defined for entities or not -->
   <xsl:if test="common:node-set($path)/avail_main_banks/bank/entity/customer_reference or common:node-set($path)/avail_main_banks/bank/customer_reference">
    <!-- Hidden Fields -->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$sender-reference-name"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
    </xsl:call-template>
  
    <xsl:choose>
    <xsl:when test="$displaymode='edit'">
        <xsl:call-template name="select-field">
     <xsl:with-param name="label" select="$label"/>
     <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_customer_reference</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
	      <xsl:choose>
	      <!-- if not entity defined -->         
	      <xsl:when test="entities[.= '0']">
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:when>
	      <!-- else -->  
	      <xsl:otherwise>
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:otherwise>
	     </xsl:choose>
       </xsl:when>
       <xsl:otherwise>
	     <xsl:choose>
		     <xsl:when test="count(common:node-set($path)/avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]) >= 1">
		      	<xsl:value-of select="common:node-set($path)/avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]/description"/>
		     </xsl:when>
		     <xsl:otherwise>
		     	<xsl:value-of select="common:node-set($path)/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference/description"/>
		     </xsl:otherwise>
	     </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
   	  <xsl:call-template name="input-field">
   	   	 <xsl:with-param name="label" select="$label"/>
    	 <xsl:with-param name="name"><xsl:value-of select="common:node-set($path)/recipient_bank_customer_reference"/></xsl:with-param>
    	 <xsl:with-param name="value"> <xsl:value-of select="utils:decryptApplicantReference($sender-reference-value)"/></xsl:with-param>
   </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
  </xsl:if>
 </xsl:template>
 
  <!-- This template displays the main bank details section of the transaction -->
  <xsl:template name="main-bank-selectbox-new">
   <xsl:param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:param>
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>   
   <xsl:param name="path"></xsl:param>
 
   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="common:node-set($path)/recipient_bank/abbv_name"/>
   </xsl:variable>
   <xsl:variable name="main-bank-name-value">
    <xsl:if test="common:node-set($path)/recipient_bank/name">
     <xsl:value-of select="common:node-set($path)/recipient_bank/name"/>
    </xsl:if>
   </xsl:variable>
   <xsl:variable name="sender-reference-value" select="common:node-set($path)/applicant_reference"/>
  
   <!-- Hidden Fields -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_name</xsl:with-param>
    <xsl:with-param name="value">
     <xsl:choose>
      <xsl:when test="$main-bank-name-value != ''">
       <xsl:value-of select="$main-bank-name-value"/>
      </xsl:when>
      <!-- never used because if only one available main bank, server set it to current main bank -->
      <xsl:when test="count(common:node-set($path)/avail_main_banks/bank)=1"><xsl:value-of select="common:node-set($path)/avail_main_banks/bank/name"/></xsl:when>
      <xsl:otherwise/>
      </xsl:choose>
     </xsl:with-param>
   </xsl:call-template>
  
   <xsl:call-template name="select-field">
    <xsl:with-param name="label" select="$label"/>
    <xsl:with-param name="name"><xsl:value-of select="common:node-set($path)/recipient_bank_abbv_name"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="$main_bank_abbv_name_value"/></xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="disabled"><xsl:if test="bg_code[.!='']">Y</xsl:if></xsl:with-param>
    <xsl:with-param name="options">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'"><xsl:apply-templates select="avail_main_banks/bank" mode="main"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="common:node-set($path)/recipient_bank/name"/></xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">remitting_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/remitting_bank/abbv_name"/></xsl:with-param>
     </xsl:call-template>
  </xsl:template>
  
  <!-- This template displays the disclamer for the updated details -->
 <xsl:template name="disclaimer-new">
    <div class="disclaimer">
     <!-- <h2><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTING_DISCLAIMER_LABEL')"/></h2> -->
     <h2><xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATED_DISCLAIMER')"/></h2>
    </div>
  </xsl:template>
  
    <!-- This template displays the bank instruction details section of the transaction -->
  <xsl:template name="bank-instructions-new">
  <xsl:param name="send-mode-required">Y</xsl:param>
  <xsl:param name="send-mode-displayed">Y</xsl:param>
  <xsl:param name="send-mode-label">XSL_INSTRUCTIONS_LC_ADV_SEND_MODE_LABEL</xsl:param>
  <xsl:param name="forward-contract-shown">N</xsl:param>
  <xsl:param name="principal-acc-displayed">Y</xsl:param>
  <xsl:param name="fee-acc-displayed">Y</xsl:param>
  <xsl:param name="delivery-to-shown">N</xsl:param>
  <xsl:param name="delivery-channel-displayed">N</xsl:param>
  <xsl:param name="free-format-text-displayed">Y</xsl:param>
  <xsl:param name="path"/>
  
  <xsl:choose>
    <xsl:when test="$mode = 'DRAFT' and $displaymode='view'">
     <!-- Don't show the file details for the draft view mode, but do in all other cases -->
     
    </xsl:when>

    <xsl:otherwise>
     <xsl:if test="$send-mode-displayed='Y'">
      <xsl:call-template name="select-field">
       <xsl:with-param name="label" select="$send-mode-label"/>
       <xsl:with-param name="name">adv_send_mode</xsl:with-param>
       <xsl:with-param name="required"><xsl:value-of select="$send-mode-required"/></xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="options">
       <xsl:if test="common:node-set($path)/adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:if>
      <xsl:if test="common:node-set($path)/adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:if>
      <xsl:if test="common:node-set($path)/adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:if>
      <xsl:if test="common:node-set($path)/adv_send_mode[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/></xsl:if>
      </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    <xsl:if test="$delivery-channel-displayed='Y'">
	<xsl:call-template name="select-field">
		<xsl:with-param name="label">XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL</xsl:with-param>
		<xsl:with-param name="name">delivery_channel</xsl:with-param>
		<xsl:with-param name="fieldsize">small</xsl:with-param>
	 	<xsl:with-param name="value">
	 	<xsl:value-of select="localization:getDecode($language, 'N802', common:node-set($path)/delivery_channel)"/>
	 	</xsl:with-param> 			
	</xsl:call-template>
	</xsl:if>           
     <xsl:if test="$principal-acc-displayed='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="button-type">account</xsl:with-param>
       <xsl:with-param name="type">account</xsl:with-param>
       <xsl:with-param name="name">principal_act_no</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/principal_act_no"/></xsl:with-param> 
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$fee-acc-displayed='Y'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
      <xsl:with-param name="button-type">account</xsl:with-param>
      <xsl:with-param name="type">account</xsl:with-param>
      <xsl:with-param name="name">fee_act_no</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/fee_act_no"/></xsl:with-param> 
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="size">34</xsl:with-param>
      <xsl:with-param name="maxsize">34</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$forward-contract-shown='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/fwd_contract_no"/></xsl:with-param>
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$delivery-to-shown='Y'">
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_DELIVERY_TO_LABEL</xsl:with-param>
	      <xsl:with-param name="name">delivery_to</xsl:with-param>
	       <xsl:with-param name="options">
	      <xsl:if test="common:node-set($path)/delivery_to[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OURSELVES')"/></xsl:if>
      <xsl:if test="common:node-set($path)/delivery_to[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_PARTY')"/></xsl:if>
      <xsl:if test="common:node-set($path)/delivery_to[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_BENEFICIARY')"/></xsl:if>
      <xsl:if test="common:node-set($path)/delivery_to[. = '04']">
      	<xsl:call-template name="row-wrapper">
      	<xsl:with-param name="id">delivery_to_other</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:call-template name="input-field">
	        <xsl:with-param name="name">delivery_to_other</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/delivery_to_other"/></xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
	  </xsl:with-param> 
	     </xsl:call-template>
	  </xsl:if>
     
     <xsl:if test="$free-format-text-displayed='Y'">
     <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
      <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">free_format_text</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/free_format_text"/></xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="rows">13</xsl:with-param>
        <xsl:with-param name="cols">60</xsl:with-param>
        <xsl:with-param name="maxlines">100</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:template>
    
  <!-- This template instantiates the linked licenses -->
  <xsl:template name="linked-licenses-new">
  <xsl:param name="path"/>
		<script type="text/javascript">
			var linkedLsItems =[];
			<xsl:for-each select="common:node-set($path)/linked_licenses/license">
				var refLs = "<xsl:value-of select="ls_ref_id"/>";
				linkedLsItems.push({ "REFERENCEID" :"<xsl:value-of select="ls_ref_id"/>", "BO_REF_ID" :"<xsl:value-of select="bo_ref_id"/>", "LS_NUMBER":"<xsl:value-of select="ls_number"/>", "LS_ALLOCATED_AMT" :"<xsl:value-of select="ls_allocated_amt"/>", "LS_AMT" :"<xsl:value-of select="ls_amt"/>", "LS_OS_AMT" :"<xsl:value-of select="ls_os_amt"/>", "CONVERTED_OS_AMT" :"<xsl:value-of select="converted_os_amt"/>", "ALLOW_OVERDRAW" :"<xsl:value-of select="allow_overdraw"/>", "ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteLsRecord(refLs)\"/>]]>"});
			</xsl:for-each>	
		</script>
	</xsl:template>
	
	<!-- This template declares the linked licenses of the transaction -->
  <xsl:template name="linkedlsdeclaration">
  <xsl:param name="path"/>
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
						<table border="0" cellpadding="0" cellspacing="0" class="attachments">
					     <xsl:attribute name="id">ls_table</xsl:attribute>
					      <xsl:choose>
					      	<xsl:when test="common:node-set($path)/linked_licenses/license">
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
						         <xsl:for-each select="common:node-set($path)/linked_licenses/license">
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
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- This template displays the revolving details fieldset of the transaction -->
  <xsl:template name="lc-revolving-details-new">
     <xsl:param name="path"></xsl:param>
     <xsl:if test="common:node-set($path)/revolving_flag = 'Y'">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_REVOLVE_PERIOD</xsl:with-param>
	       <xsl:with-param name="name">revolve_period</xsl:with-param>
	       <xsl:with-param name="value" select="common:node-set($path)/revolve_period" />
	      </xsl:call-template>
	      
	      <xsl:if test="common:node-set($path)/revolve_frequency">
		      <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_REVOLVE_FREQUENCY</xsl:with-param>
			     <xsl:with-param name="name">revolve_frequency</xsl:with-param>
			     <xsl:with-param name="value">
			     	<xsl:value-of select="localization:getDecode($language, 'C049', common:node-set($path)/revolve_frequency)"/>
			     </xsl:with-param>
			  </xsl:call-template>
		  </xsl:if>
	      
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_REVOLVE_TIME_NUMBER</xsl:with-param>
	       <xsl:with-param name="name">revolve_time_no</xsl:with-param>
	       <xsl:with-param name="value" select="common:node-set($path)/revolve_time_no" />
	     </xsl:call-template>
	    
	     <xsl:choose>
	     	 <xsl:when test="common:node-set($path)/cumulative_flag[.='Y']">
	     	 	  <xsl:call-template name="input-field">
				     <xsl:with-param name="name">cumulative_flag</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getGTPString($language, 'XSL_CUMULATIVE')"></xsl:value-of>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="common:node-set($path)/cumulative_flag[.='N']">
	     	 	 <xsl:call-template name="input-field">
				     <xsl:with-param name="name">cumulative_flag</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getGTPString($language, 'XSL_NON_CUMULATIVE')"></xsl:value-of>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
	     </xsl:choose>
	    	 
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="name">next_revolve_date</xsl:with-param>
	       <xsl:with-param name="label">XSL_NEXT_REVOLVE_DATE</xsl:with-param>
	       <xsl:with-param name="value" select="common:node-set($path)/revolve_time_no" />
	     </xsl:call-template>
	     
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_NOTICE_DAYS</xsl:with-param>
	       <xsl:with-param name="name">notice_days</xsl:with-param>
	       <xsl:with-param name="value" select="common:node-set($path)/revolve_time_no" />
	     </xsl:call-template>
	     
	   	 <xsl:if test="common:node-set($path)/charge_upto[.!='']">
	    	 <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_CHARGE_UPTO</xsl:with-param>
		     <xsl:with-param name="name">charge_upto</xsl:with-param>
		     <xsl:with-param name="value">
		     	<xsl:value-of select="localization:getDecode($language, 'C050', common:node-set($path)/charge_upto)"/>
		     </xsl:with-param>
	    	 </xsl:call-template>
	   	 </xsl:if>
   	 </xsl:if>
  </xsl:template>
  
  <!-- This template displays the renewal details fieldset of the transaction -->
    <xsl:template name="lc-renewal-details-new">
     <xsl:param name="path"></xsl:param>
     <!-- Don't show checkbox value in summary -->
     <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="checkbox-field">
       <xsl:with-param name="name">renew_flag</xsl:with-param>
       <xsl:with-param name="label">XSL_RENEWAL_ALLOWED</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">renew_on_code</xsl:with-param>
        <xsl:with-param name="options">
      <xsl:if test="common:node-set($path)/renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_on_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/></xsl:if>
       </xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="name">renewal_calendar_date</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/renewal_calendar_date" />
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_RENEWAL_RENEW_FOR</xsl:with-param>
       <xsl:with-param name="name">renew_for_nb</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/renew_for_nb" />
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">renew_for_period</xsl:with-param>
        <xsl:with-param name="options">
        <xsl:if test="common:node-set($path)/renew_for_period[. = 'D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'W']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'M']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:if>
      </xsl:with-param>
     </xsl:call-template>
    
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_RENEWAL_DAYS_NOTICE</xsl:with-param>
      <xsl:with-param name="name">advise_renewal_days_nb</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/advise_renewal_days_nb" />
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
    
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_renewal_nb</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_NUMBER_RENEWALS</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/rolling_renewal_nb" />
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_cancellation_days</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_CANCELLATION_NOTICE</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/rolling_cancellation_days" />
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>  
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">final_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_FINAL_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/final_expiry_date" />
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>   
     <xsl:call-template name="multioption-group">
      <xsl:with-param name="group-label">XSL_RENEWAL_AMOUNT</xsl:with-param>
      <xsl:with-param name="content">
       <!-- <div class="group-fields">  -->
        <xsl:call-template name="radio-field">
         <xsl:with-param name="label">XSL_RENEWAL_ORIGINAL_AMOUNT</xsl:with-param>
         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
         <xsl:with-param name="id">renew_amt_code_1</xsl:with-param>
         <xsl:with-param name="value">01</xsl:with-param>
         <xsl:with-param name="readonly">Y</xsl:with-param>
         <xsl:with-param name="checked"><xsl:if test="common:node-set($path)/renew_amt_code[. = '01']">Y</xsl:if></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="radio-field">
         <xsl:with-param name="label">XSL_RENEWAL_CURRENT_AMOUNT</xsl:with-param>
         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
         <xsl:with-param name="id">renew_amt_code_2</xsl:with-param>
         <xsl:with-param name="value">02</xsl:with-param>
         <xsl:with-param name="readonly">Y</xsl:with-param>
         <xsl:with-param name="checked"><xsl:if test="common:node-set($path)/renew_amt_code[. = '02'] or common:node-set($path)/renew_amt_code[. = '']">Y</xsl:if></xsl:with-param>
        </xsl:call-template>
       <!-- </div>  -->
      </xsl:with-param>
     </xsl:call-template>
  </xsl:template>
  
 </xsl:stylesheet>