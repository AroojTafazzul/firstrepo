<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to amendment forms (lc_amend, si_amend etc)
on the customer and bank sides.

Amendentment forms should import this template after importing
trade_common.xsl (on the customer side) or bank_common.xsl (on the bank
side).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
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
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  exclude-result-prefixes="localization security defaultresource">


<xsl:param name="Amendment_Narrative"/>
  <!--
   Amend amount details.
   
   By default, it looks for the lc_tnx_record node, but a different node can
   be passed in.
   -->
  <xsl:template name="amend-amt-details">
   <xsl:param name="tnx-record" select="org_previous_file/lc_tnx_record"/>
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="show-os-amt">N</xsl:param>
   <xsl:param name="show-release-flag">N</xsl:param>
   
   <xsl:variable name="cur-code-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
    <xsl:variable name="cur-code-name-value">org_<xsl:value-of select="$cur-code-name"/>_liab_amt</xsl:variable>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:variable name="org-amt-name">org_<xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
     <xsl:variable name="product-amt-name"><xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
     <xsl:variable name="org-amt-val" select="$tnx-record//*[name()=$product-amt-name]"/>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL</xsl:with-param>
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
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$show-release-flag='Y'">
	     <xsl:call-template name="checkbox-field">
	      <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_release_flag</xsl:with-param>
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_RELEASE</xsl:with-param>
	     </xsl:call-template> 
     </xsl:if>      

     
     <xsl:if test="$show-os-amt='Y'">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
   
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_<xsl:value-of select="$cur-code-name-value"/>_liab_amt</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:with-param>  
      </xsl:call-template>
       
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name"><xsl:value-of select="$cur-code-name-value"/></xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:with-param>
     </xsl:call-template>
   
     </xsl:if>
     
     <!-- Original Variation in Drawing -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">DrawingTolerence_spl</xsl:with-param>
      <xsl:with-param name="value" select="defaultresource:getResource('TOLERANCE_WITH_NOTEXCEEDING')"/>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$tnx-record/pstv_tol_pct[.!=''] or $tnx-record/neg_tol_pct[.!='']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="id">org_tol_view</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="$tnx-record/pstv_tol_pct[.!='']">
          <div class="content">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/> <xsl:value-of select="$tnx-record/pstv_tol_pct"/>%
          </div>
         </xsl:if>
          <xsl:if test="$tnx-record/neg_tol_pct[.!='']">
         <div class="content">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/> <xsl:value-of select="$tnx-record/neg_tol_pct"/>%
         </div>
         </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test="$tnx-record/max_cr_desc_code[.!='']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="id">org_tol_view</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
        <xsl:with-param name="content">
         <div class="content">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/> 
          <xsl:if test="$tnx-record/max_cr_desc_code[. = '3']">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
          </xsl:if>
         </div>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
        <xsl:with-param name="id">org_tol_view</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
        <xsl:with-param name="content">
         <div class="content">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_ORG_TOL')"/>
         </div>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:otherwise>
     </xsl:choose>
     
    <!--New Variation in Drawing-->
	<xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">org_pstv_tol_pct</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="$tnx-record/pstv_tol_pct"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">org_neg_tol_pct</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="$tnx-record/neg_tol_pct"/></xsl:with-param>
	</xsl:call-template>
     <xsl:choose>
     	<xsl:when test="$displaymode='edit'">
	     <xsl:call-template name="label-wrapper">
	      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
	      <xsl:with-param name="content">
	       <!-- Note: IE6 requires a width on floated elements. -->
	        <xsl:choose>
	   		<xsl:when test="$tnx-record/pstv_tol_pct[.!=''] = pstv_tol_pct">
	        <xsl:call-template name="input-field">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_PSTV</xsl:with-param>
	         <xsl:with-param name="name">pstv_tol_pct</xsl:with-param>
	         <xsl:with-param name="type">number</xsl:with-param>
	         <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	         <xsl:with-param name="size">2</xsl:with-param>
	         <xsl:with-param name="maxsize">2</xsl:with-param>
             <xsl:with-param name="value"></xsl:with-param>
	        </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	        <xsl:call-template name="input-field">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_PSTV</xsl:with-param>
	         <xsl:with-param name="name">pstv_tol_pct</xsl:with-param>
	         <xsl:with-param name="type">number</xsl:with-param>
	         <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	         <xsl:with-param name="size">2</xsl:with-param>
	         <xsl:with-param name="maxsize">2</xsl:with-param>
	    
	        </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	   	<xsl:when test="$tnx-record/neg_tol_pct[.!=''] = neg_tol_pct">
	        <xsl:call-template name="input-field">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_NEG</xsl:with-param>
	         <xsl:with-param name="name">neg_tol_pct</xsl:with-param>
	         <xsl:with-param name="type">number</xsl:with-param>
	         <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	         <xsl:with-param name="size">2</xsl:with-param>
	         <xsl:with-param name="maxsize">2</xsl:with-param>
	         <xsl:with-param name="value"></xsl:with-param>
	        </xsl:call-template>
		</xsl:when>
		 <xsl:otherwise>
	        <xsl:call-template name="input-field">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_NEG</xsl:with-param>
	         <xsl:with-param name="name">neg_tol_pct</xsl:with-param>
	         <xsl:with-param name="type">number</xsl:with-param>
	         <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	         <xsl:with-param name="size">2</xsl:with-param>
	         <xsl:with-param name="maxsize">2</xsl:with-param>
	        </xsl:call-template>
		 </xsl:otherwise>
		</xsl:choose>
	       <xsl:call-template name="select-field">
	        <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL</xsl:with-param>
	        <xsl:with-param name="name">max_cr_desc_code</xsl:with-param>
	        <xsl:with-param name="options">
	         <xsl:choose>
	          <xsl:when test="$displaymode='edit'">
	           <option value=""/>
		       <option value="3">
		        <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
		       </option>
	          </xsl:when>
	          <xsl:otherwise>
		       <xsl:if test="max_cr_desc_code[. = '3']"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/></xsl:if>
	         </xsl:otherwise>
	         </xsl:choose>
	        </xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	     </xsl:call-template>
		</xsl:when>
     	<xsl:otherwise>
            <xsl:if test="pstv_tol_pct[.!=''] and (pstv_tol_pct != $tnx-record/pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content">
              	<div class="content">
              		<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/> <xsl:value-of select="pstv_tol_pct"/>
              	</div>
              </xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="neg_tol_pct[.!=''] and (neg_tol_pct != $tnx-record/neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="pstv_tol_pct[. = '']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content">
              	<div class="content">
                	<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/> <xsl:value-of select="neg_tol_pct"/>
              	</div>
              </xsl:with-param>
             </xsl:call-template>
            </xsl:if>
     	</xsl:otherwise>
     </xsl:choose>
     <!-- New additional amount -->
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_ADDITIONAL_AMT</xsl:with-param>
      <xsl:with-param name="id">narrative_additional_amount_view</xsl:with-param>
      <xsl:with-param name="content"> <div class="content"><div class="big-textarea-wrapper-content">
      
         <xsl:value-of select="$tnx-record/narrative_additional_amount"/>
     </div></div>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
     	<xsl:when test="$displaymode='edit'">
	     <xsl:call-template name="row-wrapper">
	      <xsl:with-param name="id">narrative_additional_amount</xsl:with-param>
	      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	      	<xsl:choose>
	      	<xsl:when test="product_code[.='LC' or .='SI']"> 
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
		        <xsl:with-param name="phrase-params">{'category':'05'}</xsl:with-param>
		        <xsl:with-param name="rows">4</xsl:with-param>
		        <xsl:with-param name="cols">35</xsl:with-param>
		        <xsl:with-param name="maxlines">4</xsl:with-param>
		        <xsl:with-param name="messageValue" select="narrative_additional_amount"/>
		       </xsl:call-template>
		     </xsl:when>
		     <xsl:otherwise>
		     	<xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
		        <xsl:with-param name="rows">4</xsl:with-param>
		        <xsl:with-param name="cols">35</xsl:with-param>
		        <xsl:with-param name="messageValue" select="narrative_additional_amount"/>
		       </xsl:call-template>
		     </xsl:otherwise>
		     </xsl:choose>
	     </xsl:with-param>
	    </xsl:call-template>
     	</xsl:when>
     	<xsl:otherwise>
	     <xsl:if test="$displaymode='view' and narrative_additional_amount[.!='']">
	      <xsl:call-template name="big-textarea-wrapper">
	      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT</xsl:with-param>
	      <xsl:with-param name="content">
			<div class="content">
				<xsl:value-of select="narrative_additional_amount"/>
			</div>
	      </xsl:with-param>
	     </xsl:call-template>
	     </xsl:if>
     	</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  
  <!--
   This template is used to build the lc revolving details on the Amendment UI
   
   By default, it looks for the lc_tnx_record node, but a different node can
   be passed in.
   -->
  <xd:doc>
	<xd:short>Revolving details for transction.</xd:short>
	<xd:detail>
		This template build revolving details for the amendment. 
	</xd:detail>
	<xd:param name="tnx-record">hold original file</xd:param>
  </xd:doc>
  <xsl:template name="amend-revolving-details">
  <xsl:param name="tnx-record" select="org_previous_file/lc_tnx_record"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_REVOLVING_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">toplevel-header</xsl:when>
      <xsl:otherwise>indented-header</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORIGINAL_REVOLVE_PERIOD</xsl:with-param>
       <xsl:with-param name="id">revolve_period_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/revolve_period!=''"><xsl:value-of select="$tnx-record/revolve_period"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_NEW_REVOLVE_PERIOD</xsl:with-param>
       <xsl:with-param name="name">revolve_period</xsl:with-param>
	       <xsl:with-param name="size">5</xsl:with-param>
	       <xsl:with-param name="maxsize">5</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="override-constraints">{min:0,max:99999}</xsl:with-param>
	       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORIGINAL_REVOLVE_FREQUENCY</xsl:with-param>
       <xsl:with-param name="id">revolve_frequency_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/revolve_frequency!=''"><xsl:value-of select="localization:getDecode($language, 'C049', $tnx-record/revolve_frequency)"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="select-field">
			       <xsl:with-param name="label">XSL_NEW_REVOLVE_FREQUENCY</xsl:with-param>
			       <xsl:with-param name="name">revolve_frequency</xsl:with-param>
			       <xsl:with-param name="fieldsize">small</xsl:with-param>
			       <xsl:with-param name="options">
			       <xsl:call-template name="revolving-frequency-options"/>
			       </xsl:with-param>
	     	   </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="revolve_frequency[.!=''] and $displaymode='view'">
		     	 <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_NEW_REVOLVE_FREQUENCY</xsl:with-param>
				     <xsl:with-param name="name">revolve_frequency</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getDecode($language, 'C049', revolve_frequency)"/>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
     	 </xsl:choose>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORIGINAL_REVOLVE_TIME_NUMBER</xsl:with-param>
       <xsl:with-param name="id">revolve_time_no_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/revolve_time_no!=''"><xsl:value-of select="$tnx-record/revolve_time_no"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_NEW_REVOLVE_TIME_NUMBER</xsl:with-param>
       <xsl:with-param name="name">revolve_time_no</xsl:with-param>
       <xsl:with-param name="size">9</xsl:with-param>
       <xsl:with-param name="maxsize">9</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999999999}</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
       <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="checkbox-field">
		           <xsl:with-param name="label">XSL_CUMULATIVE</xsl:with-param>
		           <xsl:with-param name="name">cumulative_flag</xsl:with-param>
		           <xsl:with-param name="checked">
		           <xsl:choose>
		           	 <xsl:when test="/lc_tnx_record/cumulative_flag!=''">
			           <xsl:choose>
				           <xsl:when test="cumulative_flag[.='Y']">Y</xsl:when>
				           <xsl:otherwise>N</xsl:otherwise>
			           </xsl:choose>
			         </xsl:when>
			         <xsl:otherwise>
			         	<xsl:value-of select="tnx-record/cumulative_flag"/>
			         </xsl:otherwise> 
			       </xsl:choose>
			       </xsl:with-param>
		           <xsl:with-param name="value">N</xsl:with-param>
		       </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="cumulative_flag[.='Y'] and $displaymode='view'">
	     	 	  <xsl:call-template name="input-field">
				     <xsl:with-param name="name">cumulative_flag</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getGTPString($language, 'XSL_CUMULATIVE')"></xsl:value-of>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="cumulative_flag[.='N'] and $displaymode='view'">
	     	 	 <xsl:call-template name="input-field">
				     <xsl:with-param name="name">cumulative_flag</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getGTPString($language, 'XSL_NON_CUMULATIVE')"></xsl:value-of>
				     </xsl:with-param>
		     	  </xsl:call-template>  
	     	 </xsl:when>
     	 </xsl:choose>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORIGINAL_NEXT_REVOLVE_DATE</xsl:with-param>
       <xsl:with-param name="id">next_revolve_date_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/next_revolve_date!=''"><xsl:value-of select="$tnx-record/next_revolve_date"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
	       <xsl:with-param name="name">next_revolve_date</xsl:with-param>
	       <xsl:with-param name="label">XSL_NEW_NEXT_REVOLVE_DATE</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="size">10</xsl:with-param>
	       <xsl:with-param name="maxsize">10</xsl:with-param>
	       <xsl:with-param name="readonly">N</xsl:with-param>
	       <xsl:with-param name="type">date</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORIGINAL_NOTICE_DAYS</xsl:with-param>
       <xsl:with-param name="id">notice_days_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/notice_days!=''"><xsl:value-of select="$tnx-record/notice_days"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_NEW_NOTICE_DAYS</xsl:with-param>
       <xsl:with-param name="name">notice_days</xsl:with-param>
       <xsl:with-param name="size">9</xsl:with-param>
       <xsl:with-param name="maxsize">9</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999999999}</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORIGINAL_CHARGE_UPTO</xsl:with-param>
       <xsl:with-param name="id">charge_upto_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/charge_upto!=''"><xsl:value-of select="localization:getDecode($language, 'C050', $tnx-record/charge_upto)"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
       <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="select-field">
			       <xsl:with-param name="label">XSL_NEW_CHARGE_UPTO</xsl:with-param>
			       <xsl:with-param name="name">charge_upto</xsl:with-param>
			       <xsl:with-param name="fieldsize">small</xsl:with-param>
			       <xsl:with-param name="options">
			       	<xsl:call-template name="charge-upto-options"/>
			       </xsl:with-param>
		       </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="charge_upto[.!=''] and $displaymode='view'">
		     	 <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_NEW_CHARGE_UPTO</xsl:with-param>
				     <xsl:with-param name="name">charge_upto</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getDecode($language, 'C050', charge_upto)"/>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
     	 </xsl:choose>
     </xsl:with-param>
     </xsl:call-template>
  </xsl:template>
  
  <!--
    Valid For Revolving Frequency Dropdown C049(i.e  D- Days, M- Months)
   -->
   <xsl:template name="revolving-frequency-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="D">
      <xsl:value-of select="localization:getDecode($language, 'C049', 'D')"/>
     </option>
     <option value="M">
      <xsl:value-of select="localization:getDecode($language, 'C049', 'M')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="revolve_frequency[. = 'D']"><xsl:value-of select="localization:getDecode($language, 'C049', 'D')"/></xsl:when>
      <xsl:when test="revolve_frequency[. = 'M']"><xsl:value-of select="localization:getDecode($language, 'C049', 'M')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 
  
  <!--
    Valid For Charge Upto Dropdown C050(i.e  p- First periods, e- Final expiry)
   -->
  <xsl:template name="charge-upto-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="e">
      <xsl:value-of select="localization:getDecode($language, 'C050', 'e')"/>
     </option>
     <option value="p">
      <xsl:value-of select="localization:getDecode($language, 'C050', 'p')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="charge_upto[. = 'e']"><xsl:value-of select="localization:getDecode($language, 'C050', 'e')"/></xsl:when>
      <xsl:when test="charge_upto[. = 'p']"><xsl:value-of select="localization:getDecode($language, 'C050', 'p')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  <!-- 
   Amend Shipment Details.
   
   By default, it looks for the lc_tnx_record node, but a different node can
   be passed in.
  -->
  <xsl:template name="amend-shipment-details">
   <xsl:param name="tnx-record" select="org_previous_file/lc_tnx_record"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">toplevel-header</xsl:when>
      <xsl:otherwise>indented-header</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="content">
     <xsl:if test="$displaymode='edit' or ($displaymode='view' and (ship_from!=org_previous_file/si_tnx_record/ship_from ) or (ship_from!=org_previous_file/lc_tnx_record/ship_from))">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_FROM</xsl:with-param>
       <xsl:with-param name="id">ship_from_view</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/ship_from!=''"><xsl:value-of select="$tnx-record/ship_from"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:choose>
      <xsl:when test="$tnx-record/ship_from[.!=''] = ship_from">
       <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_FROM</xsl:with-param>
       <xsl:with-param name="name">ship_from</xsl:with-param>
       <xsl:with-param name="maxsize">65</xsl:with-param>
       <xsl:with-param name="value"></xsl:with-param>
      </xsl:call-template>
      </xsl:when>
       <xsl:otherwise>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_FROM</xsl:with-param>
       <xsl:with-param name="name">ship_from</xsl:with-param>
       <xsl:with-param name="maxsize">65</xsl:with-param>
      </xsl:call-template>
      </xsl:otherwise>
       </xsl:choose>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_LOADING</xsl:with-param>
      <xsl:with-param name="id">ship_loading_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/ship_loading!=''"><xsl:value-of select="$tnx-record/ship_loading"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
   	<xsl:choose>
      <xsl:when test="$tnx-record/ship_loading[.!=''] = ship_loading">
      <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING</xsl:with-param>
      <xsl:with-param name="name">ship_loading</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
       <xsl:with-param name="value"></xsl:with-param>
      </xsl:call-template>
       </xsl:when>
      <xsl:otherwise>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING</xsl:with-param>
      <xsl:with-param name="name">ship_loading</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_DISCHARGE</xsl:with-param>
      <xsl:with-param name="id">ship_discharge_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/ship_discharge!=''"><xsl:value-of select="$tnx-record/ship_discharge"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$tnx-record/ship_discharge[.!=''] = ship_discharge">
      <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE</xsl:with-param>
      <xsl:with-param name="name">ship_discharge</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
       <xsl:with-param name="value"></xsl:with-param>
      </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE</xsl:with-param>
      <xsl:with-param name="name">ship_discharge</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_TO</xsl:with-param>
      <xsl:with-param name="id">ship_to_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="$tnx-record/ship_to!=''"><xsl:value-of select="$tnx-record/ship_to"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
      <xsl:choose>
      <xsl:when test="$tnx-record/ship_to[.!=''] = ship_to">
      <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_TO</xsl:with-param>
      <xsl:with-param name="name">ship_to</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
      <xsl:with-param name="value"></xsl:with-param>
      </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_TO</xsl:with-param>
      <xsl:with-param name="name">ship_to</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     </xsl:otherwise>
     </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="id">last_ship_date_view</xsl:with-param>
      <xsl:with-param name="value" select="$tnx-record/last_ship_date"></xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
      <xsl:choose>
      <xsl:when test="$tnx-record/last_ship_date[.!=''] = last_ship_date">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="button-type">date</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="value"></xsl:with-param>
     </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:with-param>
      <xsl:with-param name="name">last_ship_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="button-type">date</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     </xsl:otherwise>
     </xsl:choose>
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_SHIPMENT_PERIOD</xsl:with-param>
      <xsl:with-param name="id">narrative_shipment_period_view</xsl:with-param>
	    <xsl:with-param name="content"> <div class="content"><div class="big-textarea-wrapper-content">
      	 <xsl:choose>
        <xsl:when test="$tnx-record/narrative_shipment_period!=''">
         <xsl:value-of select="$tnx-record/narrative_shipment_period"/>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
       </xsl:choose>
       </div></div>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <!-- New Shipment Period -->
     <xsl:choose>
     	<xsl:when test="$displaymode='edit'">
	     <xsl:call-template name="row-wrapper">
	      <xsl:with-param name="id">narrative_shipment_period</xsl:with-param>
	      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_SHIPMENT_PERIOD</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	      	<xsl:choose>
	      	<xsl:when test="product_code[.='LC' or .='SI']">
	      	<xsl:choose>
	      <xsl:when test="$tnx-record/narrative_shipment_period[.!=''] = narrative_shipment_period">
	      	  <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
		        <xsl:with-param name="phrase-params">{'category':'08'}</xsl:with-param>
		        <xsl:with-param name="rows">6</xsl:with-param>
		        <xsl:with-param name="cols">65</xsl:with-param>
		        <xsl:with-param name="maxlines">6</xsl:with-param>
		        <xsl:with-param name="messageValue"></xsl:with-param>
		       </xsl:call-template>
	      	</xsl:when>
	      	<xsl:otherwise>
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
		        <xsl:with-param name="phrase-params">{'category':'08'}</xsl:with-param>
		        <xsl:with-param name="rows">6</xsl:with-param>
		        <xsl:with-param name="cols">65</xsl:with-param>
		        <xsl:with-param name="maxlines">6</xsl:with-param>
		        <xsl:with-param name="messageValue" select="narrative_shipment_period"/>
		       </xsl:call-template>
		    </xsl:otherwise>
		     </xsl:choose>
		    </xsl:when>
		    <xsl:otherwise>
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
		        <xsl:with-param name="rows">6</xsl:with-param>
		        <xsl:with-param name="cols">65</xsl:with-param>
		        <xsl:with-param name="maxlines">6</xsl:with-param>
		         <xsl:with-param name="messageValue" select="narrative_shipment_period"/>
		       </xsl:call-template>
		    </xsl:otherwise>
		    </xsl:choose>
	      </xsl:with-param>
	     </xsl:call-template>
     	</xsl:when>
     	<xsl:otherwise>
	     <xsl:if test="$displaymode='view' and narrative_shipment_period[.!='']">
	      <xsl:call-template name="big-textarea-wrapper">
	      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_SHIPMENT_PERIOD</xsl:with-param>
	      <xsl:with-param name="content">
			<div class="content">
				<xsl:value-of select="narrative_shipment_period"/>
			</div>
	      </xsl:with-param>
	     </xsl:call-template>
	     </xsl:if>
     	</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  
  <!-- Renewal details -->
   <xd:doc>
		<xd:short>Creates renewal details section.</xd:short>
		<xd:detail>
			This tempalte will create the renewal section.
		</xd:detail>
  </xd:doc>
   <xsl:template name="amend-renewal-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_RENEWAL_DETAILS_LABEL</xsl:with-param>
    <xsl:with-param name="content">
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
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="01">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
	       </option>
	       <option value="02">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/>
	       </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:when>
          <xsl:when test="renew_on_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="name">renewal_calendar_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_RENEWAL_RENEW_FOR</xsl:with-param>
       <xsl:with-param name="name">renew_for_nb</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">renew_for_period</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="options">
       <xsl:call-template name="renew-time-period-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <xsl:call-template name="checkbox-field">
        <xsl:with-param name="name">advise_renewal_flag</xsl:with-param>
        <xsl:with-param name="label">XSL_RENEWAL_ADVISE</xsl:with-param>
        <xsl:with-param name="disabled">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      <xsl:if test="advise_renewal_flag[.!='N']  or advise_renewal_flag[. = '']">
       <div class="indented-header">
        <h3><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE')"/></h3>
       </div>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_RENEWAL_DAYS_NOTICE</xsl:with-param>
      <xsl:with-param name="name">advise_renewal_days_nb</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <xsl:call-template name="checkbox-field">
        <xsl:with-param name="name">rolling_renewal_flag</xsl:with-param>
        <xsl:with-param name="label">XSL_RENEWAL_ROLLING_RENEWAL</xsl:with-param>
        <xsl:with-param name="disabled">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <div class="indented-header">
        <h3><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL')"/></h3>
       </div>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:if test="product_code[.='SI'] or product_code[.='BG']">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">rolling_renew_on_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="01">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
	       </option>
	       <option value="03">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
	       </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="rolling_renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:when>
          <xsl:when test="rolling_renew_on_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or ($displaymode='view' and rolling_renew_on_code[.='03'])">
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">FREQUENCY_LABEL</xsl:with-param>
       <xsl:with-param name="name">rolling_renew_for_nb</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">rolling_renew_for_period</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="options">
       <xsl:call-template name="renew-time-period-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ROLLING_DAY_IN_MONTH</xsl:with-param>
       <xsl:with-param name="name">rolling_day_in_month</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">2</xsl:with-param>
       <xsl:with-param name="maxsize">2</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:1,max:31}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_renewal_nb</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_NUMBER_RENEWALS</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
      <xsl:with-param name="value">
      	<xsl:choose>
      		<xsl:when test="rolling_renewal_nb[.!='']"><xsl:value-of select="rolling_renewal_nb"/></xsl:when>
      		<xsl:when test="rolling_renewal_flag[.!='Y'] and renew_flag[.='Y']">1</xsl:when>
      	</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_cancellation_days</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_CANCELLATION_NOTICE</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">renew_amount_code</xsl:with-param>
       <xsl:with-param name="id">renew_amount_code</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="renew_amt_code"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="multioption-group">
      <xsl:with-param name="group-label">XSL_RENEWAL_AMOUNT</xsl:with-param>
      <xsl:with-param name="content">
 		<xsl:choose>
    		<xsl:when test="$displaymode='edit'">
			    <xsl:call-template name="radio-field">
			         <xsl:with-param name="label">XSL_RENEWAL_ORIGINAL_AMOUNT</xsl:with-param>
			         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
			         <xsl:with-param name="id">renew_amt_code_1</xsl:with-param>
			         <xsl:with-param name="readonly">Y</xsl:with-param>
			         <xsl:with-param name="value">01</xsl:with-param>
			        </xsl:call-template>
			        <xsl:call-template name="radio-field">
			         <xsl:with-param name="label">XSL_RENEWAL_CURRENT_AMOUNT</xsl:with-param>
			         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
			         <xsl:with-param name="id">renew_amt_code_2</xsl:with-param>
			         <xsl:with-param name="readonly">Y</xsl:with-param>
			         <xsl:with-param name="value">02</xsl:with-param>
			        </xsl:call-template>
    		</xsl:when>
    		<xsl:otherwise>
     			<xsl:choose>
      				<xsl:when test="renew_amt_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ORIGINAL_AMOUNT')"/></xsl:when>
      				<xsl:when test="renew_amt_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CURRENT_AMOUNT')"/></xsl:when>
    	 		</xsl:choose>
    		</xsl:otherwise>
   		</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="(product_code[.='SI'] or product_code[.='BG']) and projected_expiry_date[.!='']">
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">projected_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_PROJECTED_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="readonly">
      	<xsl:choose>
	    	<xsl:when test="security:isBank($rundata)">N</xsl:when>
	    	<xsl:otherwise>Y</xsl:otherwise>
	    </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">final_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_FINAL_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="readonly">N</xsl:with-param>
      <xsl:with-param name="required">N</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field"> 
	    <xsl:with-param name="name">is_bank</xsl:with-param>
	    <xsl:with-param name="value">
	      	<xsl:choose>
		    	<xsl:when test="security:isBank($rundata)">Y</xsl:when>
		    	<xsl:otherwise>N</xsl:otherwise>
		    </xsl:choose>
	    </xsl:with-param>
	  </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  <!-- 
   Amend Narrative.
   -->
  <xsl:template name="amend-narrative">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMENDMENT_NARRATIVE</xsl:with-param>
    <xsl:with-param name="content">
     <!-- This empty tag is needed for this to appear, I'm not sure why. -->
     <div style="display:none">&nbsp;</div>
      <xsl:call-template name="row-wrapper">
      <xsl:with-param name="label">XSL_AMENDMENT_NARRATIVE_LABEL</xsl:with-param>
       <xsl:with-param name="id">amd_details</xsl:with-param>
       <xsl:with-param name="type">textarea</xsl:with-param>
       <xsl:with-param name="content">
		<xsl:choose>
	   		<xsl:when test="$Amendment_Narrative != ''">
	   			<xsl:call-template name="textarea-field">
			      <xsl:with-param name="name">amd_details</xsl:with-param>
			      <xsl:with-param name="maxlines"><xsl:value-of select="$Amendment_Narrative"/></xsl:with-param>
			      <xsl:with-param name="rows">10</xsl:with-param>
		         <xsl:with-param name="cols">50</xsl:with-param>
			    </xsl:call-template>
	    	</xsl:when>
	  		<xsl:otherwise>
	       		<xsl:call-template name="textarea-field">
			      <xsl:with-param name="name">amd_details</xsl:with-param>
		         <xsl:with-param name="rows">10</xsl:with-param>
		         <xsl:with-param name="cols">50</xsl:with-param>
		         <!-- Increasing as per TI confirm`ation that filed can accormodate 15860 including CR  -->
		         <xsl:with-param name="maxlines">305</xsl:with-param>
			    </xsl:call-template>
	       	</xsl:otherwise>
	   	</xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Renewal Time Period <select> options 
   -->
  <xsl:template name="renew-time-period-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="D">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/>
     </option>
     <option value="W">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/>
     </option>
     <option value="M">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/>
     </option>
     <option value="Y">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="renew_for_period[. = 'D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:when>
      <xsl:when test="renew_for_period[. = 'W']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:when>
      <xsl:when test="renew_for_period[. = 'M']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:when>
      <xsl:when test="renew_for_period[. = 'Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>