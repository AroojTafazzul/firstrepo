<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for displaying transaction summaries.Client Specific

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
base version : 1.25 
date:      02/03/11	
author:    Pavan kumar
email:     pavankumar.c@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
 xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
 xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
 xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
 xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
 exclude-result-prefixes="localization converttools xmlRender security utils">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS.
   For the trade summary, some of these are empty.
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode"/>
  <xsl:param name="displaymode">view</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code"/>
  <xsl:param name="main-form-name"/>
  <xsl:param name="realform-action"/>
   
  <xsl:include href="../../../core/xsl/common/bk_upl_trade_common.xsl"/>
  <xsl:include href="../../../core/xsl/common/com_cross_references.xsl"/>
  <xsl:include href="../../../openaccount/xsl/po_common.xsl"/>
  
    <!-- Open account specific parameters -->
  <!-- All marks used to shown/hidden form's sections-->
 <!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_po_line_items" />
	<xsl:param name="section_po_amount_details" />
	<xsl:param name="section_po_payment_terms" />
	<xsl:param name="section_po_settlement_terms" />
	<xsl:param name="section_po_documents_required" />
	<xsl:param name="section_po_shipment_details" />
	<xsl:param name="section_po_inco_terms" />
	<xsl:param name="section_po_routing_summary" />
	<xsl:param name="section_po_user_info" />
	<xsl:param name="section_po_contact" />

	<xsl:param name="section_line_item_po_reference" />
	<xsl:param name="section_line_item_adjustments_details" />
	<xsl:param name="section_line_item_taxes_details" />
	<xsl:param name="section_line_item_freight_charges_details" />
	<xsl:param name="section_line_item_shipment_details" />
	<xsl:param name="section_line_item_inco_terms_details" />
	<xsl:param name="section_line_item_total_net_amount_details"/>

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
   
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
	
  <!--TEMPLATE Main-->
  <xsl:template match="lc_tnx_record | ri_tnx_record | li_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | bk_tnx_record | ft_tnx_record | br_tnx_record | ln_tnx_record | sw_tnx_record | td_tnx_record | fx_tnx_record | xo_tnx_record | eo_tnx_record | sw_tnx_record | ts_tnx_record | cs_tnx_record | cx_tnx_record | ct_tnx_record | st_tnx_record | se_tnx_record | la_tnx_record | bk_tnx_record | po_tnx_record | so_tnx_record">
   <div id="event-summary">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="parse-widgets">N</xsl:with-param>
     <xsl:with-param name="legend">XSL_HEADER_EVENT_DETAILS</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:if test="release_dttm[.!='']">
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RELEASE_DTTM</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata)"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	  </xsl:if>
	  <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_COMPANY_NAME</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="company_name"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="product_code[.!='']">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
       <xsl:if test="sub_product_code[.!=''] ">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">
      		<xsl:choose>
      			<xsl:when test="product_code[.='TF']">XSL_FINANCINGTYPE_LABEL</xsl:when>
       			<xsl:otherwise>XSL_TRANSACTIONDETAILS_SUBPRODUCT_CODE</xsl:otherwise>
       		</xsl:choose>
       	</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code[.])"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_TYPE</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
        <xsl:if test="sub_tnx_type_code[.!='']">&nbsp;<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/></xsl:if> 
        <xsl:if test="product_code[.='LC'] and tnx_type_code[.='13'] and lc_message_type_clean and lc_message_type_clean[.='BillArrivalClean']">
         	&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_ADVISE_OF_BILL_ARRV_CLEAN')"/>
         </xsl:if>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_TNX_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="tnx_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_RELATED_REFERENCE</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="link_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="cust_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="((tnx_type_code[.='01'] and tnx_stat_code[.='04']) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="bo_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
       <xsl:if test="(product_code[.='LC'] and ibReference[.!=''])">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_IB_REFERENCE_LABEL</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="ibReference"/>
        </div></xsl:with-param>
       </xsl:call-template>
       </xsl:if>
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BILL_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="imp_bill_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="maturity_date"/>
        </div></xsl:with-param>
       </xsl:call-template>
       <xsl:if test="value_date[.!='']">
        	<xsl:call-template name="row-wrapper">
      		 <xsl:with-param name="label">XSL_FACTOR_PRO_VALUE_DATE</xsl:with-param>
      	 		<xsl:with-param name="content"><xsl:value-of select="value_date"/>
     	  	</xsl:with-param>
     		 </xsl:call-template>
     	 </xsl:if>
       <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
			<xsl:choose>
				<xsl:when test="sub_tnx_type_code[. = '24']">
					<xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
				</xsl:when>
				<xsl:when test="sub_tnx_type_code[. = '38']">
					<xsl:value-of select="localization:getDecode($language, 'N003', '38')"/>
				</xsl:when>
				<xsl:when test="sub_tnx_type_code[. = '39']">
					<xsl:value-of select="localization:getDecode($language, 'N003', '39')"/>
				</xsl:when>
				<xsl:when test="sub_tnx_type_code[. = '40']">
					<xsl:value-of select="localization:getDecode($language, 'N003', '40')"/>
				</xsl:when>
				<xsl:when test="sub_tnx_type_code[. = '22']">
					<xsl:value-of select="localization:getDecode($language, 'N003', '22')"/>
				</xsl:when>
				
			</xsl:choose>
           </div></xsl:with-param>
          </xsl:call-template>
          
          <xsl:if test="fin_outstanding_amt[.!='']">
        	<xsl:call-template name="row-wrapper">
      		 <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
      	 		<xsl:with-param name="content"><div class="content">
      	 	  <xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_outstanding_amt"/>
     	  	</div></xsl:with-param>
     		 </xsl:call-template>
     	 </xsl:if>
          
          <xsl:if test="fin_liab_amt[.!=''] and security:isBank($rundata)">
        	<xsl:call-template name="row-wrapper">
      		 <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
      	 		<xsl:with-param name="content"><div class="content">
      	 	  <xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_liab_amt"/>
     	  	</div></xsl:with-param>
     		 </xsl:call-template>
     	 </xsl:if>
     	 
      <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPAYMENT_MODE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
		   <xsl:choose>
		   <xsl:when test="repayment_mode[. = '01']">
		   <xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL')"/>
		   </xsl:when>
		   <xsl:when test="repayment_mode[. = '02']">
		   <xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL_INTEREST')"/>
		   </xsl:when>
		   </xsl:choose>
           </div></xsl:with-param>
          </xsl:call-template>
           <xsl:if test="repayment_amt[.!='']">
      		 <xsl:call-template name="row-wrapper">
       		<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
      		 <xsl:with-param name="content">
      		 <div class="content">
        	 <xsl:value-of select="repayment_cur_code"/>&nbsp;<xsl:value-of select="repayment_amt"/>
       		</div></xsl:with-param>
      		</xsl:call-template>
      		</xsl:if>
      		<xsl:call-template name="row-wrapper">
	       <xsl:with-param name="label">XSL_INTEREST_AMOUNT</xsl:with-param>
	       <xsl:with-param name="content"><div class="content">
	         <xsl:value-of select="interest_amt"/>
	       </div></xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
      
      <!-- Show cross references -->
      <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
      <xsl:if test="product_code[.='EL' or .='SR']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="lc_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <!-- Initiation From -->
	  <xsl:if test="cross_references/cross_reference/type_code[.='02']">
	   <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
	   <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="$parent_file/bo_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
	  </xsl:if>
      <xsl:if test="product_code[.='LI']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="alt_lc_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="product_code[.='PO']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_IN_ISSUER_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="invoice_cust_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="product_code[.='LI']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_DEAL_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="deal_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUER_REF_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="issuer_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      
      <!--
       Select amongst the different tnx types 
       -->
    <xsl:choose>
     <!-- NEW -->
     <xsl:when test="tnx_type_code[. = '01']"> 
        <xsl:choose>
         <xsl:when test="product_code[.='LC' or .='SG' or .='LI' or .='TF' or .='SI' or .='FT' or .='PO' or .='IN' or .='LN' or .='SW' or .='BK']">
           <xsl:if test="issuing_bank/name[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="issuing_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:when>
         <xsl:when test="product_code[.='EL' or .='SR' or .='SO' or .='BR']">
         <xsl:if test="advising_bank/name[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ADVISING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="advising_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:when>
         <xsl:when test="product_code[.='EC' or .='IR']">
           <xsl:if test="remitting_bank/name[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_REMITTING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="remitting_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:when>
         <xsl:when test="product_code[.='IC']">
          <xsl:if test="presenting_bank/name[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRESENTING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="presenting_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:when>
         <xsl:when test="product_code[.='BG']">
           <xsl:if test="recipient_bank/name[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RECIPIENT_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="recipient_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:when>
        </xsl:choose>
        <xsl:if test="tnx_stat_code[.='04']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">
           <xsl:choose>
            <xsl:when test="product_code[.='FT']">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:when>
            <xsl:when test="product_code[.='BK']">XSL_GENERALDETAILS_VALUE_DATE</xsl:when>
            <xsl:otherwise>XSL_GENERALDETAILS_ISSUE_DATE</xsl:otherwise> 
           </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="content">
          	<div class="content">
				<xsl:choose>
            		<xsl:when test="product_code[.='BK']"><xsl:value-of select="value_date"/></xsl:when>
            		<xsl:otherwise><xsl:value-of select="iss_date"/></xsl:otherwise> 
           		</xsl:choose>
			</div>
			</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:choose>
         <xsl:when test="product_code[.='TF']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_DAYS</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="tenor"/>
           </div></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="maturity_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="product_code[.='EC' or .='IC']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
			<xsl:choose>
				<xsl:when test="term_code[. = '01']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/>
				</xsl:when>
				<xsl:when test="term_code[. = '02']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/>
				</xsl:when>
				<xsl:when test="term_code[. = '03']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/>
				</xsl:when>
				<xsl:when test="term_code[. = '04']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/>
				</xsl:when>
				<xsl:when test="tenor_desc[.!='']">
					<xsl:value-of select="tenor_desc"/>
				</xsl:when>
			</xsl:choose>
           </div></xsl:with-param>
          </xsl:call-template>
          <xsl:if test="tenor_desc[.!='']">
	          <xsl:call-template name="row-wrapper">	        
	           <xsl:with-param name="label">XSL_GENERALDETAILS_BILL_TENOR</xsl:with-param>	
	              <xsl:with-param name="content"><div class="content">           	
				<xsl:value-of select="tenor_desc"/>
	           </div></xsl:with-param>
	          </xsl:call-template>
          </xsl:if>
         </xsl:when>
         <xsl:otherwise>
          <xsl:if test="exp_date[.!='']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="exp_date"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="expiry_place"/>
            </div></xsl:with-param>
           </xsl:call-template>
           
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_CLIENT_SUBTYPE</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:choose>
             <xsl:when test="lc_subtype[. = '01']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_LC_SUBTYPE_COMMERCIAL')"/>
		     </xsl:when>
			 <xsl:when test="lc_subtype[. = '02']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_LC_SUBTYPE_RED_CLAUSE')"/>
			 </xsl:when>
			 <xsl:when test="lc_subtype[. = '03']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_LC_SUBTYPE_LOCAL')"/>
			 </xsl:when>
		    </xsl:choose>
            </div></xsl:with-param>
           </xsl:call-template>
         </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="tnx_cur_code[.!=''] and tnx_amt[.!='']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">
           <xsl:choose>
            <xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR']">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='EC' or .='IC' or .='IR']">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='SG' or .='BG' or .='BR']">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='TF']">XSL_AMOUNTDETAILS_FIN_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='FT']">XSL_AMOUNTDETAILS_FT_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='BK']">XSL_AMOUNTDETAILS_BK_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='LI']">XSL_AMOUNTDETAILS_LI_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='PO' or .='SO']">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='IN']">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='LN']">XSL_LOAN_AMOUNT</xsl:when>
            <xsl:when test="product_code[.='SW']">XSL_AMOUNTDETAILS_SW_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='EO']">XSL_EQUITYOPTIONDETAILS_AMT_LABEL</xsl:when>
           </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
          </div></xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:if test="product_code[.='FA']">
        <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="entity"/>
        </div></xsl:with-param>
       </xsl:call-template>
       </xsl:if>  
       <xsl:if test="product_code[.='FA']">    
        <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_FACTOR_PRO_CLIENT_CODE</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="client_code"/>
        </div></xsl:with-param>
       </xsl:call-template>  
       </xsl:if>
       <xsl:if test="product_code[.='FA']">
        <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_FACTOR_PRO_ACCOUNT_TYPE</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="account_type"/>
        </div></xsl:with-param>
       </xsl:call-template>
       </xsl:if>
       <xsl:if test="product_code[.='FA']">
        <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_FACTOR_PRO_ADVANCE_CURRENCY</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="adv_currency"/>
        </div></xsl:with-param>
       </xsl:call-template>
       </xsl:if>
       <xsl:if test="product_code[.='FA']">
        <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_FACTOR_PRO_DRAWDOWN_AMOUNT</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="amt_avail_for_adv_payment"/>
        </div></xsl:with-param>
       </xsl:call-template>
       </xsl:if>      
    </xsl:when>
      
    <!-- AMEND -->
    <xsl:when test="tnx_type_code[.='03']"> 
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="utils:formatAmdNo(amd_no)"/>
          </div></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="amd_date"/>
          </div></xsl:with-param>
         </xsl:call-template>
        <xsl:choose>
         <xsl:when test="product_code[.='BG'] and not(org_previous_file/bg_tnx_record/exp_date=exp_date and org_previous_file/bg_tnx_record/exp_date_type_code=exp_date_type_code)">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:choose>
			  <xsl:when test="exp_date_type_code[.='01']">
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_01_NO_DATE')"/>
			  </xsl:when>
			  <xsl:when test="exp_date_type_code[.='02']">
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_02_FIXED')"/>
			  </xsl:when>
			  <xsl:when test="exp_date_type_code[.='03']">
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_03_ESTIMATED')"/>
			  </xsl:when>
			 </xsl:choose>
             <xsl:if test="exp_date[.!='']">
	          (<xsl:value-of select="exp_date"/>)
		     </xsl:if>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="(product_code[.='LC'] and org_previous_file/lc_tnx_record/exp_date!=exp_date) or (product_code[.='SI'] and org_previous_file/si_tnx_record/exp_date!=exp_date)">
          <xsl:if test="exp_date[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="exp_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:when>
        </xsl:choose>
        <xsl:if test="product_code[.='BG'] and org_previous_file/bg_tnx_record/bg_effective_date!=bg_effective_date">
          <xsl:if test="bg_effective_date[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EFFECTIVE_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="bg_effective_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:if>
         <xsl:if test="product_code[.='BG'] and org_previous_file/bg_tnx_record/bg_claim_period!=bg_claim_period">
          <xsl:if test="bg_claim_period[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_CLAIM_PERIOD</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="bg_claim_period"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:if>
         <xsl:if test="product_code[.='BG'] and org_previous_file/bg_tnx_record/bg_claim_date!=bg_claim_date">
          <xsl:if test="bg_claim_date[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_CLAIM_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="bg_claim_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
         </xsl:if>
        <xsl:if test="sub_tnx_type_code[.!='03'] and tnx_amt[.!='']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="tnx_cur_code"/> <xsl:value-of select="tnx_amt"/>
          </div></xsl:with-param>
         </xsl:call-template>
          <xsl:choose>
           <xsl:when test="product_code[.='BG' or .='BR']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_GTEE_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="bg_cur_code"/> <xsl:value-of select="bg_amt"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:when>
           <xsl:when test="product_code[.='EL' or .='LC' or .='BG' or .='SI' or .='SR']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="lc_cur_code"/> <xsl:value-of select="lc_amt"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:when>
          </xsl:choose>
         </xsl:if>
         <xsl:if test="product_code[.='LC']">
          <xsl:choose>
           <xsl:when test="org_previous_file/lc_tnx_record/pstv_tol_pct!='' or org_previous_file/lc_tnx_record/neg_tol_pct!='' or org_previous_file/lc_tnx_record/max_cr_desc_code!=''">
            <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[.!=''] and (pstv_tol_pct != org_previous_file/lc_tnx_record/pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/> <xsl:value-of select="org_previous_file/lc_tnx_record/pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/lc_tnx_record/neg_tol_pct[.!=''] and (neg_tol_pct != org_previous_file/lc_tnx_record/neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
               <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[.='']">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:if>
              </xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/> <xsl:value-of select="org_previous_file/lc_tnx_record/neg_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/lc_tnx_record/max_cr_desc_code[.!=''] and (max_cr_desc_code != org_previous_file/lc_tnx_record/max_cr_desc_code)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
               <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[. = ''] and org_previous_file/lc_tnx_record/neg_tol_pct[. = ''] and org_previous_file/lc_tnx_record/max_cr_desc_code[.!='']">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:if>
              </xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/>
                <xsl:if test="org_previous_file/lc_tnx_record/max_cr_desc_code[. = '3']">
                 <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
                </xsl:if>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           </xsl:when>
           <xsl:otherwise>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_ORG_TOL')"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:otherwise>
          </xsl:choose>
          <!--New Variation in Drawing-->
          <xsl:choose>
           <xsl:when test="pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']">
            <xsl:if test="pstv_tol_pct[.!=''] and (pstv_tol_pct != org_previous_file/lc_tnx_record/pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/> <xsl:value-of select="pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="neg_tol_pct[.!=''] and (neg_tol_pct != org_previous_file/lc_tnx_record/neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="pstv_tol_pct[. = '']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/> <xsl:value-of select="neg_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="max_cr_desc_code[.!=''] and (max_cr_desc_code != org_previous_file/lc_tnx_record/max_cr_desc_code)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="pstv_tol_pct[. = ''] and neg_tol_pct[. = ''] and max_cr_desc_code[.!='']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/>
                <xsl:choose>
				 <xsl:when test="max_cr_desc_code[. = '3']">NOT EXCEEDING</xsl:when>
				 <xsl:otherwise>-<xsl:value-of select="max_cr_desc_code"/>-</xsl:otherwise>
				</xsl:choose>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           </xsl:when>
           <xsl:otherwise>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_NEW_TOL')"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="narrative_additional_amount[.!=''] and (narrative_additional_amount != org_previous_file/lc_tnx_record/narrative_additional_amount)">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_ADDITIONAL_AMT</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="org_previous_file/lc_tnx_record/narrative_additional_amount"/>
            </div></xsl:with-param>
           </xsl:call-template>
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="narrative_additional_amount"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
         </xsl:if>
         <!-- SI -->
         <xsl:if test="product_code[.='SI']">
          <xsl:choose>
           <xsl:when test="org_previous_file/si_tnx_record/pstv_tol_pct!='' or org_previous_file/si_tnx_record/neg_tol_pct!='' or org_previous_file/si_tnx_record/max_cr_desc_code!=''">
            <xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[.!=''] and (pstv_tol_pct != org_previous_file/si_tnx_record/pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="org_previous_file/si_tnx_record/pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/si_tnx_record/neg_tol_pct[.!=''] and (neg_tol_pct != org_previous_file/si_tnx_record/neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[.='']">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="org_previous_file/si_tnx_record/neg_tol_pct"/> 
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/si_tnx_record/max_cr_desc_code[.!=''] and (max_cr_desc_code != org_previous_file/si_tnx_record/max_cr_desc_code)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[. = ''] and org_previous_file/si_tnx_record/neg_tol_pct[. = ''] and org_previous_file/si_tnx_record/max_cr_desc_code[.!='']">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/>
                <xsl:if test="org_previous_file/si_tnx_record/max_cr_desc_code[. = '3']">
                 <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
                </xsl:if>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           </xsl:when>
           <xsl:otherwise>
            <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_ORG_TOL')"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
           <xsl:when test="pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']">
            <xsl:if test="pstv_tol_pct[.!=''] and (pstv_tol_pct != org_previous_file/si_tnx_record/pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
                <xsl:value-of select="pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="neg_tol_pct[.!=''] and (neg_tol_pct != org_previous_file/si_tnx_record/neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="pstv_tol_pct[. = '']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="neg_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="max_cr_desc_code[.!=''] and (max_cr_desc_code != org_previous_file/si_tnx_record/max_cr_desc_code)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="pstv_tol_pct[. = ''] and neg_tol_pct[. = ''] and max_cr_desc_code[.!='']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/>
                <xsl:choose>
				 <xsl:when test="max_cr_desc_code[. = '3']">NOT EXCEEDING</xsl:when>
				 <xsl:otherwise>-<xsl:value-of select="max_cr_desc_code"/>-</xsl:otherwise>
				</xsl:choose>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           </xsl:when>
           <xsl:otherwise>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_NEW_TOL')"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="narrative_additional_amount[.!=''] and (narrative_additional_amount != org_previous_file/si_tnx_record/narrative_additional_amount)">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_ADDITIONAL_AMT</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="org_previous_file/si_tnx_record/narrative_additional_amount"/>
            </div></xsl:with-param>
           </xsl:call-template>
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="narrative_additional_amount"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
         </xsl:if>
         <xsl:if test="product_code[.='BG'] and bg_release_flag[.='Y']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="content"><div class="content">
           	<xsl:choose>
              <xsl:when test="sub_tnx_type_code[.!='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_YES')"/></xsl:when>
              <xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL')"/></xsl:otherwise>
             </xsl:choose>
            
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:if>
   	</xsl:when>
    <!-- MESSAGE -->
    <xsl:when test="tnx_type_code[.='13']">
         <!-- Discrepant Ack Message -->
         <xsl:if test="sub_tnx_type_code[.='08' or .='09'] or (lc_message_type_clean and lc_message_type_clean[.='BillArrivalClean'])">
          <!-- Document Amount or Maturity date may be modified by bank -->
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">
             <xsl:choose>
              <xsl:when test="product_code[.='PO']">XSL_GENERALDETAILS_UTILIZATION_PAID_AMOUNT</xsl:when>
              <xsl:otherwise>XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:otherwise>
             </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:choose>
				<xsl:when test="product_code[.='LC'] and document_amt[.!='']">
					<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="document_amt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
				</xsl:otherwise>
			</xsl:choose>
            </div></xsl:with-param>
           </xsl:call-template>
         <xsl:if test="product_code[.='LC' or .='BG' or .='SR' or .='SI' or .='BR']">
          	<xsl:call-template name="row-wrapper">
          		 <xsl:with-param name="label">XSL_DOC_REF_NO</xsl:with-param>
           		<xsl:with-param name="id">event_summary_doc_ref_no_view</xsl:with-param>
           		<xsl:with-param name="content"><div class="content">
              	<xsl:value-of select="doc_ref_no"/>
            	</div></xsl:with-param>
         	 </xsl:call-template>
          </xsl:if>
           <!-- Bill Arrival Discrepancy Yes or No -->
            <xsl:if test="sub_tnx_type_code[.='08' or .='09']">
	            <xsl:call-template name="row-wrapper">
	           			<xsl:with-param name="label">XSL_GENERALDETAILS_DISCREPANCY_RESPONSE</xsl:with-param>
	           			<xsl:with-param name="content"><div class="content">
	              			<xsl:choose>
	              				<xsl:when test="sub_tnx_type_code[.='08']">
	              					<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
	              				</xsl:when>
	              				<xsl:otherwise>
	              					<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
	              				</xsl:otherwise>
	              			</xsl:choose>
	            		</div></xsl:with-param>
	            </xsl:call-template>
            </xsl:if>

         </xsl:if>
         <!-- Transfer Message -->
         <xsl:if test="sub_tnx_type_code[.='12' or .='19']">
          <xsl:choose>
		   <xsl:when test="sub_tnx_type_code[.='12']">
		   	<xsl:if test="exp_date[.!='']">
				<xsl:call-template name="row-wrapper">
           			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
           			<xsl:with-param name="content"><div class="content">
              			<xsl:value-of select="exp_date"/>
            		</div></xsl:with-param>
           </xsl:call-template>
           </xsl:if>
           <xsl:if test="last_ship_date[.!= '']">
           		<xsl:call-template name="row-wrapper">
           			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
           			<xsl:with-param name="content"><div class="content">
              		<xsl:value-of select="last_ship_date"/>
            	</div></xsl:with-param>
           		</xsl:call-template>
           	</xsl:if>

           <!-- Second Beneficiary -->
           <xsl:call-template name="fieldset-wrapper">
            <xsl:with-param name="legend">XSL_HEADER_SECOND_BENEFICIARY_DETAILS</xsl:with-param>
            <xsl:with-param name="legend-type">indented-header</xsl:with-param>
            <xsl:with-param name="content">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_name"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_address_line_1"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_address_line_2"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_dom"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_address_line_4"/>
              </div></xsl:with-param>
             </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="sec_beneficiary_reference"/>
               </div></xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
           </xsl:call-template>
           
           <!-- Transferee's Bank details -->
           <xsl:if test="transferee_bank_name[.!='']">
           <xsl:call-template name="fieldset-wrapper">
            <xsl:with-param name="legend">XSL_HEADER_TRANSFEREE_DETAILS</xsl:with-param>
            <xsl:with-param name="legend-type">indented-header</xsl:with-param>
            <xsl:with-param name="content">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="transferee_bank_name"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="transferee_bank_address_line_1"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="transferee_bank_address_line_2"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="transferee_bank_dom"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="transferee_bank_address_line_4"/>
              </div></xsl:with-param>
             </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="transferee_bank_country"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="transferee_bank_reference"/>
               </div></xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
           </xsl:call-template>
           </xsl:if>
           
          </xsl:when>
          <xsl:when test="sub_tnx_type_code[.='19']">
           <!-- Assignee -->
           <xsl:call-template name="fieldset-wrapper">
            <xsl:with-param name="legend">XSL_HEADER_ASSIGNEE_DETAILS</xsl:with-param>
            <xsl:with-param name="legend-type">indented-header</xsl:with-param>
            <xsl:with-param name="content">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="assignee_name"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="assignee_address_line_1"/>
              </div></xsl:with-param>
             </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="assignee_address_line_2"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="assignee_dom"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="assignee_address_line_4"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="assignee_reference"/>
               </div></xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
           </xsl:call-template>
          </xsl:when>
         </xsl:choose>
          <xsl:call-template name="fieldset-wrapper">
           <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:if test="lc_amt[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="lc_cur_code"/> <xsl:value-of select="lc_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
              <xsl:choose>
               <xsl:when test="sub_tnx_type_code[.='19']">XSL_AMOUNTDETAILS_FULL_ASG_AMT_LABEL</xsl:when>
               <xsl:otherwise>XSL_AMOUNTDETAILS_FULL_TRF_AMT_LABEL</xsl:otherwise>
              </xsl:choose></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:choose>
                	<xsl:when test="full_trf_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/></xsl:when>
                	<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'N034_N')"/></xsl:otherwise>
               </xsl:choose>
              </div></xsl:with-param>
             </xsl:call-template>
           
            <xsl:if test="tnx_amt[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
              <xsl:choose>
               <xsl:when test="sub_tnx_type_code[.='19']">XSL_AMOUNTDETAILS_ASG_AMT_LABEL</xsl:when>
               <xsl:otherwise>XSL_AMOUNTDETAILS_TRF_AMT_LABEL</xsl:otherwise>
              </xsl:choose>
              </xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="lc_cur_code"/> <xsl:value-of select="tnx_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            
         <xsl:if test="full_trf_flag[.!='Y']">
           <xsl:if test="transfer_expiry_date[.!= '']">
           		<xsl:call-template name="row-wrapper">
           			<xsl:with-param name="label">XSL_TRANSFER_EXPIRY_DATE</xsl:with-param>
           			<xsl:with-param name="content"><div class="content">
              		<xsl:value-of select="transfer_expiry_date"/>
            	</div></xsl:with-param>
           		</xsl:call-template>
           </xsl:if>
            
           <xsl:if test="transfer_last_ship_date[.!= '']">
           		<xsl:call-template name="row-wrapper">
           			<xsl:with-param name="label">XSL_TRANSFER_LAST_SHIPMENT_DATE</xsl:with-param>
           			<xsl:with-param name="content"><div class="content">
              		<xsl:value-of select="transfer_last_ship_date"/>
            	</div></xsl:with-param>
           		</xsl:call-template>
           </xsl:if>
           <xsl:if test="transfer_presentation_period[.!= '']">
           		<xsl:call-template name="row-wrapper">
           			<xsl:with-param name="label">XSL_TRANSFER_PRESENTATION_PERIOD</xsl:with-param>
           			<xsl:with-param name="content"><div class="content">
              		<xsl:value-of select="transfer_presentation_period"/>
            		</div></xsl:with-param>
            	</xsl:call-template>
            </xsl:if>
            <xsl:if test="unit_price[.!= '']">
            	<xsl:call-template name="row-wrapper">
           			<xsl:with-param name="label">XSL_TRANSFER_UNIT_PRICE</xsl:with-param>
           			<xsl:with-param name="content"><div class="content">
              		<xsl:value-of select="unit_price" />
            		</div></xsl:with-param>
           </xsl:call-template>
           </xsl:if>
           <xsl:if test="insurance_coverage_percentage[.!= '']">
           		<xsl:call-template name="row-wrapper">
           			<xsl:with-param name="label">XSL_TRANSFER_INSURANCE_COVERAGE_PERCENTAGE</xsl:with-param>
          			<xsl:with-param name="content"><div class="content">
              		<xsl:value-of select="insurance_coverage_percentage"/>
            	</div></xsl:with-param>
           		</xsl:call-template>
           </xsl:if>
          </xsl:if> 
            
           </xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="fieldset-wrapper">
           <xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_PARTIESDETAILS_NOTIFY_AMENDMENT</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:choose>
                <xsl:when test="notify_amendment_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'N034_N')"/></xsl:otherwise>
               </xsl:choose>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_PARTIESDETAILS_SUBSTITUTE_INVOICE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:choose>
                <xsl:when test="substitute_invoice_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'N034_N')"/></xsl:otherwise>
               </xsl:choose>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_PARTIESDETAILS_ADVISE_MODE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:choose>
                <xsl:when test="advise_mode_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADVISE_MODE_DIRECT')"/></xsl:when>
                <xsl:when test="advise_mode_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADVISE_MODE_THRU_BANK')"/></xsl:when>
               </xsl:choose>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:if test="advise_mode_code[.='02']">
             <xsl:call-template name="fieldset-wrapper">
              <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
              <xsl:with-param name="legend-type">indented-header</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
               <xsl:apply-templates select="advise_thru_bank">
                <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
               </xsl:apply-templates>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:if>

          <xsl:if test="presentation_amt[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_GENERALDETAILS_PRESENTATION_AMOUNT</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="presentation_cur_code"/>&nbsp;<xsl:value-of select="presentation_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if>        
          <xsl:if test="sub_tnx_type_code[.='25']"> 
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_REMITTING_CHRG_WAIVE_FLAG</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
               		 <xsl:choose>
						<xsl:when test="waive_remitting_chrg_flag[. = 'Y']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REMITTING_CHRG_WAIVE_YES')" />
						</xsl:when>
						<xsl:when test="waive_remitting_chrg_flag[. = 'N']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REMITTING_CHRG_WAIVE_NO')" />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
              </div></xsl:with-param>             
             </xsl:call-template>
          </xsl:if>              
           
          <xsl:if test="settlement_code[.!= '']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_GENERALDETAILS_SETTLEMENT_METHOD</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:choose>
                <xsl:when test="settlement_code[.='01']"><xsl:value-of select="localization:getDecode($language, 'N045', '01')"/></xsl:when>
                <xsl:when test="settlement_code[.='02']"><xsl:value-of select="localization:getDecode($language, 'N045', '02')"/></xsl:when>
                <xsl:when test="settlement_code[.='03']"><xsl:value-of select="localization:getDecode($language, 'N045', '03')"/></xsl:when>
                <xsl:when test="settlement_code[.='04']"><xsl:value-of select="localization:getDecode($language, 'N045', '04')"/></xsl:when>
               </xsl:choose>
             </div></xsl:with-param>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="product_code[.='IC'] and ic_amt[.!='']">
	      	<xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:with-param>
              <xsl:with-param name="content">
              	<div class="content">
	                <xsl:value-of select="ic_cur_code"/>&nbsp;<xsl:value-of select="ic_amt"/>
	            </div>
              </xsl:with-param>
            </xsl:call-template>
	      </xsl:if>
          <xsl:if test="debit_amt[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_GENERALDETAILS_DEBIT_AMT_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="debit_cur_code"/>&nbsp;<xsl:value-of select="debit_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if>
            <xsl:call-template name="row-wrapper">
            
               <xsl:with-param name="content"><div class="content">
              	 <xsl:choose>
              	 	<xsl:when test="(product_code[.='LC'] and (sub_tnx_type_code[.='08' or .='09'] or (lc_message_type_clean and lc_message_type_clean[.='BillArrivalClean'])))">
	             		<xsl:variable name="bank-specific-label">XSL_MSG_BANK_SETTLEMENT_LABEL.<xsl:value-of select="issuing_bank/abbv_name"></xsl:value-of></xsl:variable>
	             		<xsl:value-of select="localization:getGTPString($language, 'XSL_MSG_BANK_FINANCING_MESSAGE')" disable-output-escaping="yes" />&nbsp;<a target="_blank"><xsl:attribute name="href"><xsl:value-of select="localization:getGTPString($language, $bank-specific-label)" disable-output-escaping="yes" /></xsl:attribute><xsl:value-of select="localization:getGTPString($language, $bank-specific-label)" disable-output-escaping="yes" /></a>
	             	</xsl:when>
	             	<xsl:when test="product_code[.='IC'] and sub_tnx_type_code[.='25']">
	             		<xsl:variable name="bank-specific-label">XSL_MSG_BANK_SETTLEMENT_LABEL.<xsl:value-of select="presenting_bank/abbv_name"></xsl:value-of></xsl:variable>
	             		<xsl:value-of select="localization:getGTPString($language, 'XSL_MSG_BANK_FINANCING_MESSAGE')" disable-output-escaping="yes" />&nbsp;<a target="_blank"><xsl:attribute name="href"><xsl:value-of select="localization:getGTPString($language, $bank-specific-label)" disable-output-escaping="yes" /></xsl:attribute><xsl:value-of select="localization:getGTPString($language, $bank-specific-label)" disable-output-escaping="yes" /></a>
	             	</xsl:when>
	             	<xsl:otherwise>
	             		<xsl:value-of select="localization:getGTPString($language, 'XSL_LC_DEBIT_AMT_MESSAGE')"/>
	             	</xsl:otherwise>
	             </xsl:choose>
              </div></xsl:with-param>
             </xsl:call-template>
          <xsl:if test="finance_amt[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_GENERALDETAILS_FINANCE_AMT_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="finance_cur_code"/>&nbsp;<xsl:value-of select="finance_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if>
           <xsl:if test="finance_tenor[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_GENERALDETAILS_FINANCE_TENOR</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="finance_tenor"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if> 
            <xsl:if test="settlement_date[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_GENERALDETAILS_SETTLEMENT_DATE</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="settlement_date"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if> 
            <xsl:if test="fx_details[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_GENERALDETAILS_FX_DETAILS</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="fx_details"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if> 
    <!-- END:Specific -->
    </xsl:when>
    <!-- REPORTING -->
    <xsl:when test="tnx_type_code[.='15']">
         
         <xsl:choose>
          <!-- Show the amendment date and number for all products that can effectively be amended -->
          <xsl:when test="prod_stat_code[.='08'] and product_code[.='EL' or .='LC' or .='BG' or .='SI' or .='SR']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="utils:formatAmdNo(amd_no)"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="amd_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <!-- For a reporting of Acceptance, Discrepancy, Payment at Sight, Parital Payment at Sight,
                 Settlement, or Partial Settlement on LC or SI, show the documents amount and 
                 maturity date -->
          <!-- Also added for EL and SR -->
          <xsl:when test="prod_stat_code[.='04' or .='05' or .='12' or .='13' or .='14' or .='15' or .='16' or .='17' or .='26'] and product_code[.='LC' or .='SI' or .='EL' or .='SR' or .='IC' or .='EC']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">
             <xsl:choose>
              <xsl:when test="product_code[.='PO'] and prod_stat_code[.='16' or .='17']">XSL_GENERALDETAILS_UTILIZATION_PAID_AMOUNT</xsl:when>
              <xsl:otherwise>XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:otherwise>
             </xsl:choose>   
            </xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="tnx_cur_code"/> <xsl:value-of select="tnx_amt"/>
            </div></xsl:with-param>
           </xsl:call-template>
           <xsl:if test="product_code[.='LC']">
          	<xsl:call-template name="row-wrapper">
          		 <xsl:with-param name="label">XSL_DOC_REF_NO</xsl:with-param>
           		<xsl:with-param name="id">event_summary_doc_ref_no_view</xsl:with-param>
           		<xsl:with-param name="content"><div class="content">
              	<xsl:value-of select="doc_ref_no"/>
            	</div></xsl:with-param>
         	 </xsl:call-template>
          </xsl:if>
           <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_REPORTINGDETAILS_LATEST_ANSWER_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="latest_answer_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
          </xsl:when>
         </xsl:choose>
   </xsl:when>
   <!-- Invoice Presentation -->
   <xsl:when test="tnx_type_code[.='18']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_PRESENTATION_REF_ID</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="data_set_id"/>
          </div></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_DOCUMENT_PRESENTATION_AMOUNT</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
          </div></xsl:with-param>
         </xsl:call-template>
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_DOCUMENT_PRESENTATION_FINAL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="localization:getDecode($language, 'N034', final_presentation)"/>
           </div></xsl:with-param>
          </xsl:call-template>
    </xsl:when>
  </xsl:choose>
       
      <!-- Purchase Order Apply - Invoice Presentation -->
      <xsl:if test="prod_stat_code='45' and product_code='PO'">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:apply-templates select="payments" mode="po_presentation"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <!-- Additional details are provided for an amendment -->
      <xsl:if test="tnx_type_code[.='03']">
       <xsl:if test="product_code[.='LC']">
         
     <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_HEADER_ORIGINAL_BENEFICIARY_GENERAL_DETAILS</xsl:with-param>
	     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	     <xsl:with-param name="content">
	     
	      <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="label">DISPLAYUSER_NAMEMSG</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:choose>
		         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_name!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_name"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
	          </xsl:choose>
	        </div></xsl:with-param>
	     </xsl:call-template>
	     
	      <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	           <xsl:choose>
		         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_address_line_1!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_address_line_1"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
		        </xsl:choose>
	        </div></xsl:with-param>
	      </xsl:call-template>
	      
	       <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="content"><div class="content">
	          <xsl:choose>
			         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_address_line_2!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_address_line_2"/></xsl:when>
			         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
		        </xsl:choose>
	        </div></xsl:with-param>
	       </xsl:call-template>
	     
	    <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="content"><div class="content">
	          <xsl:choose>
		         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_dom!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_dom"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
		      </xsl:choose>
	        </div></xsl:with-param>
	    </xsl:call-template>
	    
	     <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="label">XSL_JURISDICTION_CONTACT_NAME</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:choose>
		         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_contact_name!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_contact_name"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
	          </xsl:choose>
	        </div></xsl:with-param>
	     </xsl:call-template>
	     
	     <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="label">XSL_BENEFICIARY_CONTACT_NUMBER</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:choose>
		         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_contact_number!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_contact_number"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
	          </xsl:choose>
	        </div></xsl:with-param>
	     </xsl:call-template>
	     
	      <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_FAX_NUMBER</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:choose>
		         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_fax_num!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_fax_num"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
	          </xsl:choose>
	        </div></xsl:with-param>
	     </xsl:call-template>
	      <!-- Client Specific FDS 1.6 Changes -->
	     <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	         <xsl:choose>
		         <xsl:when test="org_previous_file/lc_tnx_record/beneficiary_fax_num!=''"><xsl:value-of select="org_previous_file/lc_tnx_record/beneficiary_email"/></xsl:when>
		         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
	         </xsl:choose>
	        </div></xsl:with-param>
	     </xsl:call-template>
	   
	     </xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_NEW_BENEFICIARY_GENERAL_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="show-contact-name">Y</xsl:with-param>
       <xsl:with-param name="show-contact-number">Y</xsl:with-param>
       <xsl:with-param name="show-fax-number">Y</xsl:with-param>
       <xsl:with-param name="show-email">Y</xsl:with-param>
      </xsl:call-template>
      
     
     </xsl:with-param>
    </xsl:call-template>
           
        <!--Shipment Details-->
        <xsl:if test="ship_from!='' or ship_loading!='' or ship_discharge!='' or ship_to!='' or part_ship_detl!='' or tran_ship_detl!='' or narrative_shipment_period!='' or last_ship_date!=''">
         <xsl:call-template name="fieldset-wrapper">
          <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
          <xsl:with-param name="legend-type">indented-header</xsl:with-param>
          <xsl:with-param name="content">
          
           <!-- Shipment From, Shipment To, Last Shipment Date -->
           <xsl:if test="ship_from!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_FROM</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_from"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_FROM</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_from"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="ship_loading!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_LOADING</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_loading"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_loading"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="ship_discharge!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_DISCHARGE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_discharge"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_discharge"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="ship_to!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_TO</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_to"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_TO</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_to"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="part_ship_detl!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_PARTIAL_SHIP_TO</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/part_ship_detl"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_PARTIAL_SHIP_TO</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="part_ship_detl"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="org_previous_file/lc_tnx_record/tran_ship_detl != ''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_TRANS_SHIP</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/tran_ship_detl"/>
             </div></xsl:with-param>
            </xsl:call-template>
            </xsl:if>
            <xsl:if test="tran_ship_detl[. = 'NOT ALLOWED']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_TRANS_SHIP</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="tran_ship_detl"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="torg_previous_file/lc_tnx_record/tran_ship_detl[. != 'NOT ALLOWED']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_TRANS_SHIP_TO_PLACE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/tran_ship_detl"/>
             </div></xsl:with-param>
            </xsl:call-template>
            </xsl:if>
            <xsl:if test="tran_ship_detl[. != 'NOT ALLOWED']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_TRANS_SHIP_TO_PLACE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="tran_ship_detl"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="narrative_shipment_period!='' or last_ship_date!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/last_ship_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_SHIPMENT_PERIOD</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/narrative_shipment_period"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="last_ship_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_SHIPMENT_PERIOD</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="narrative_shipment_period"/>
             </div></xsl:with-param>
            </xsl:call-template>
          </xsl:if>
         </xsl:with-param>
        </xsl:call-template>
       </xsl:if>
      </xsl:if>
       
       <!-- SI -->
       <xsl:if test="product_code[.='SI']">
        <!--Shipment Details-->
        <xsl:if test="ship_from!='' or ship_to!='' or narrative_shipment_period!='' or last_ship_date!=''">
         <xsl:call-template name="fieldset-wrapper">
          <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
          <xsl:with-param name="legend-type">indented-header</xsl:with-param>
          <xsl:with-param name="content">
          
           <!-- Shipment From, Shipment To, Last Shipment Date -->
           <xsl:if test="ship_from[.!=''] and ship_from!=org_previous_file/si_tnx_record/ship_from">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_FROM</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/si_tnx_record/ship_from"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_FROM</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_from"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="ship_loading[.!=''] and ship_loading!=org_previous_file/si_tnx_record/ship_loading">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_LOADING</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/si_tnx_record/ship_loading"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_loading"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="ship_discharge[.!=''] and ship_discharge!=org_previous_file/si_tnx_record/ship_discharge">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_DISCHARGE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/si_tnx_record/ship_discharge"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_discharge"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="ship_to[.!=''] and ship_to!=org_previous_file/si_tnx_record/ship_to">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_TO</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/si_tnx_record/ship_to"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_TO</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_to"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="last_ship_date[.!=''] and last_ship_date!=org_previous_file/si_tnx_record/last_ship_date">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="org_previous_file/si_tnx_record/last_ship_date"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="last_ship_date"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="narrative_shipment_period[.!=''] and narrative_shipment_period!=org_previous_file/si_tnx_record/narrative_shipment_period">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_SHIPMENT_PERIOD</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="org_previous_file/si_tnx_record/narrative_shipment_period"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_SHIPMENT_PERIOD</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="narrative_shipment_period"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if>
          </xsl:with-param>
         </xsl:call-template>
        </xsl:if>
       </xsl:if>
       
       <!-- Additional Information Provided by the Client for amendment -->
       <xsl:call-template name="big-textarea-wrapper">
        <xsl:with-param name="label">XSL_HEADER_AMENDMENT_NARRATIVE</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="amd_details"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <!-- Additional Information Provided by the Client -->
      <xsl:if test="product_code[.='BG']">
      <xsl:call-template name="fieldset-wrapper">
      	 <xsl:with-param name="legend">XSL_HEADER_NEW_ORDERING_PARTY_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
       		<xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_HEADER_ORDERING_PARTY_NAME</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="ordering_party_name"/>
          </div></xsl:with-param>
         </xsl:call-template>
       		<xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_HEADER_ORDERING_ADDRESS_LINE_1</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="ordering_party_address_line_1"/>
          </div></xsl:with-param>
         </xsl:call-template>
       	<xsl:call-template name="row-wrapper">
          <xsl:with-param name="label"></xsl:with-param>
          <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="ordering_party_address_line_2"/>
          </div></xsl:with-param>
         </xsl:call-template>
       		<xsl:call-template name="row-wrapper">
          <xsl:with-param name="label"></xsl:with-param>
          <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="ordering_party_address_dom"/>
          </div></xsl:with-param>
         </xsl:call-template>
       		<xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_HEADER_ORDERING_PARTY_CONTACT_NAME</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="ordering_party_contact_name"/>
          </div></xsl:with-param>
         </xsl:call-template>
       		<xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_HEADER_ORDERING_PARTY_PHONE</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="ordering_party_phone"/>
          </div></xsl:with-param>
         </xsl:call-template>
       </xsl:with-param>       
      </xsl:call-template>
      </xsl:if>      
      <xsl:if test="product_code[.!='EC']">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">
		<xsl:choose>
			<xsl:when test="product_code[.='PO' or .='SO' or .='IN']">XSL_HEADER_OPEN_ACCOUNT_INSTRUCTIONS</xsl:when>
			<xsl:otherwise>XSL_HEADER_INSTRUCTIONS</xsl:otherwise>
		</xsl:choose>							
       </xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="adv_send_mode[. != ''] and tnx_type_code[.='01' or .='03' or .='13']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:choose>
             <xsl:when test="adv_send_mode[. = '01']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
		     </xsl:when>
			 <xsl:when test="adv_send_mode[. = '02']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
			 </xsl:when>
			 <xsl:when test="adv_send_mode[. = '03']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
			 </xsl:when>
			 <xsl:when test="adv_send_mode[. = '04']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
			 </xsl:when>
		    </xsl:choose>
          </div></xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        
        <!--Documents Send Mode-->
        <xsl:if test="tnx_type_code[.='01']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_INSTRUCTIONS_DOCS_SEND_MODE_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
           <xsl:choose>
			<xsl:when test="docs_send_mode[. = '03']">
			 <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
			</xsl:when>
			<xsl:when test="docs_send_mode[. = '04']">
			 <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
			</xsl:when>
			<xsl:otherwise/>
		   </xsl:choose>
          </div></xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="row-wrapper">
         <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
         <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="principal_act_name"/>
         </div></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="row-wrapper">
         <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
         <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="fee_act_name"/>
         </div></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
	    <xsl:with-param name="content">
	     <div class="content">
	      <xsl:value-of select="fwd_contract_no"/>
	     </div></xsl:with-param>
	    </xsl:call-template>
        <xsl:call-template name="row-wrapper">
         <xsl:with-param name="label">XSL_BANKDETAILS_LCHOLD_ORIGINAL</xsl:with-param>
         <xsl:with-param name="content"><div class="content">
           <xsl:if test="lc_hold_flag[.!='']">
	           <xsl:value-of select="localization:getDecode($language, 'N034', lc_hold_flag)"/>
           </xsl:if>
         </div></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="row-wrapper">
         <xsl:with-param name="label">XSL_INSTRUCTIONS_MARGIN_LABEL</xsl:with-param>
         <xsl:with-param name="content"><div class="content">
           <xsl:if test="margin_indicator[.!='']">
	           <xsl:value-of select="localization:getDecode($language, 'N034', margin_indicator)"/>
           </xsl:if>
         </div></xsl:with-param>
        </xsl:call-template>
       <xsl:if test="margin_act_name[.!='']">
	    <xsl:call-template name="row-wrapper">
         <xsl:with-param name="label">XSL_INSTRUCTIONS_MARGIN_ACCOUNT_LABEL</xsl:with-param>
         <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="margin_act_name"/>
         </div></xsl:with-param>
        </xsl:call-template>
        <!-- Client Specific FDS1.6 changes -->
        <xsl:if test="product_code[.='LC'] and margin_indicator[.!='']">
         <xsl:call-template name="row-wrapper">
         <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_MARGIN_ACCOUNT_MESSAGE')"/>
         </div></xsl:with-param>
        </xsl:call-template>
        </xsl:if>
      </xsl:if>
        <xsl:call-template name="row-wrapper">
         <xsl:with-param name="label">XSL_GTEEDETAILS_COLLECTOR_NAME</xsl:with-param>
         <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="collector_name"/>
         </div></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="row-wrapper">
         <xsl:with-param name="label">XSL_GTEEDETAILS_COLLECTOR_ID</xsl:with-param>
         <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="collector_id"/>
         </div></xsl:with-param>
        </xsl:call-template>
		<xsl:if test="product_code[.='TF'] and source_fund[.!='']">
		<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_SOURCE_FUND_LABEL</xsl:with-param>
				<xsl:with-param name="content">
					<div class="content">
						<xsl:choose>
							<xsl:when test="source_fund[. = '01']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_EXPORT_PROCEEDS')" />
							</xsl:when>
							<xsl:when test="source_fund[. = '02']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_POST_SHIPMENT_PROCEEDS')" />
							</xsl:when>
							<xsl:when test="source_fund[. = '03']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_OWN_FUNDS')" />
							</xsl:when>
							<xsl:when test="source_fund[. = '04']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_COMBINATION')" />
							</xsl:when>
						</xsl:choose>
	        		</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
        <xsl:if test="free_format_text[.!='']">
	        <xsl:call-template name="big-textarea-wrapper">
		      <xsl:with-param name="id">free_format_text</xsl:with-param>
		      <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>     
		      <xsl:with-param name="content">
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">free_format_text</xsl:with-param>        
		        <xsl:with-param name="rows">3</xsl:with-param>
				<xsl:with-param name="cols">65</xsl:with-param>
				<xsl:with-param name="maxlines">100</xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
	        </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="tnx_type_code[.='13'] and fx_rates_type and fx_rates_type[.!= ''] or product_code[.='EC']">
         <xsl:call-template name="fx-details-for-view"/>
        </xsl:if>
      
        <xsl:if test="attachments/attachment[type = '01'  or type = '06' or type = '07'] and attachments/attachment[file_name !='']">
         <xsl:choose>
	        <xsl:when test="product_code[.='PO' or .='SO' or .='IN']">
         <xsl:call-template name="attachments-file-dojo">
          <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '06' or type = '07']"/>
          <xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
          <xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
        </xsl:call-template> 
         </xsl:when>
	     <xsl:otherwise>
	     <xsl:call-template name="attachments-file-dojo">
          <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
          <xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
          <xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
        </xsl:call-template> 
	     </xsl:otherwise>
	      </xsl:choose>  
       </xsl:if>
       </xsl:with-param>
      </xsl:call-template>
      </xsl:if> 
      
       <xsl:if test="product_code[.='EC']"> 
		   <xsl:if test="attachments/attachment[type = '01'] and attachments/attachment[file_name !='']">
	         <xsl:call-template name="attachments-file-dojo">
	          <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
	          <xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
	          <xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
	          </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="free_format_text[.!=''] and tnx_type_code[.='13']">
		        <xsl:call-template name="big-textarea-wrapper">
			      <xsl:with-param name="id">free_format_text</xsl:with-param>
			      <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>     
			      <xsl:with-param name="content">
			       <xsl:call-template name="textarea-field">
			        <xsl:with-param name="name">free_format_text</xsl:with-param>        
			        <xsl:with-param name="rows">3</xsl:with-param>
					<xsl:with-param name="cols">65</xsl:with-param>
					<xsl:with-param name="maxlines">100</xsl:with-param>
			       </xsl:call-template>
			      </xsl:with-param>
		        </xsl:call-template>
	        </xsl:if>
       </xsl:if>

       
      <!-- Bank Message -->
      <xsl:if test="tnx_stat_code[.='04'] or security:isBank($rundata)">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">
       		<xsl:choose>
				<xsl:when test="product_code[.='PO' or .='SO' or .='IN']">XSL_HEADER_SELLER_BANK_MESSAGE</xsl:when>
				<xsl:otherwise>XSL_HEADER_BANK_MESSAGE</xsl:otherwise>
			</xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_DTTM</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="converttools:formatReportDate(bo_release_dttm,$rundata)"/>
           </div></xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/>
           </div></xsl:with-param>
          </xsl:call-template>

          <!-- Back-Office comment -->
          <xsl:if test="bo_comment!=''">
          <xsl:call-template name="big-textarea-wrapper">
           <xsl:with-param name="label">
             <xsl:choose>
              <xsl:when test="product_code[.='PO' or .='SO' or .='IN']">XSL_REPORTINGDETAILS_COMMENT_BANK_OA</xsl:when>
              <xsl:otherwise>XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:otherwise>
             </xsl:choose>          
           </xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:call-template name="textarea-field">
			         <xsl:with-param name="name">bo_comment</xsl:with-param>
			         <xsl:with-param name="rows">13</xsl:with-param>
			         <xsl:with-param name="cols">75</xsl:with-param>
			         <xsl:with-param name="maxlines">500</xsl:with-param>
			         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>

		  <xsl:if test="action_req_code[.!='']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="localization:getDecode($language, 'N042', action_req_code)"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
           
           <xsl:call-template name="attachments-file-dojo">
            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
            <xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
            <xsl:with-param name="attachment-group">summarybank</xsl:with-param>
           </xsl:call-template> 
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
 
      <!-- Charges -->
      <xsl:if test="count(charges/charge[created_in_session = 'Y']) != 0">
       <xsl:call-template name="attachments-charges">
        <xsl:with-param name="existing-attachments" select="charges/charge"/>
       </xsl:call-template>
      </xsl:if>

     </xsl:with-param>
    
    </xsl:call-template>
    
    <!-- XO Inquiry -->
    <xsl:if test="tnx_type_code[.='13'] and  product_code[.='XO']">
    	<xsl:choose>	
     	<!-- Update -->
        <xsl:when test="sub_tnx_type_code[.='18']">
        	<xsl:call-template name="fieldset-wrapper">
	    	<xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
	    	<xsl:with-param name="content">
	    	<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_HEADER_AMENDMENT_NARRATIVE</xsl:with-param>
				<xsl:with-param name="content">
					<div class="content">
						<xsl:choose>
							<xsl:when test="contract_type[. = '01']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')" />
							</xsl:when>
							<xsl:when test="contract_type[. = '02']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')" />
							</xsl:when>
							<xsl:when test="contract_type[. = '03']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_CONTACT_LABEL')" />
							</xsl:when>
						</xsl:choose>
	        		</div>
				</xsl:with-param>
			</xsl:call-template>
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_EXPIRATION_CODE_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="expiration_code" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			<xsl:if test="expiration_code[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_EXPIRATION_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="expiration_date" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="expiration_date_term_number[. != ''] or expiration_date_term_code[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="concat(expiration_date_term_number, ' ', localization:getDecode($language, 'N413', expiration_date_term_code[.]))" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="counter_cur_code">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CURRENCY_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="counter_cur_code" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="fx_cur_code or fx_amt" >
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="concat(fx_cur_code, ' ', fx_amt)" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="value_date[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="value_date" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="value_date_term_number[. != ''] or value_date_term_code[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="concat(value_date_term_number, ' ', localization:getDecode($language, 'N413', value_date_term_code[.]))" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="market_order">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_MARKET_ORDER_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:choose>
								<xsl:when test="market_order[. = 'Y']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_YES')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_NO')" />
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="trigger_pos">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_TRIGGER_POS_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="trigger_pos" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="trigger_stop">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_TRIGGER_STOP_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="trigger_stop" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="trigger_limit">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_TRIGGER_LIMIT_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="trigger_limit" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
	      	</xsl:if>
	   		</xsl:with-param>
			</xsl:call-template>
   		</xsl:when>
		<!-- Cancel -->
		<xsl:when test="sub_tnx_type_code[.='22']">
			<xsl:call-template name="fieldset-wrapper">
		    	<xsl:with-param name="legend">XSL_HEADER_ACTION_CANCEL_DETAILS</xsl:with-param>
		    	<xsl:with-param name="content">
	    			<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_CANCEL_REASON_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="cancel_reason" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
	    		</xsl:with-param>
	    	</xsl:call-template>
		</xsl:when>
		<!-- Confirm -->
		<xsl:when test="sub_tnx_type_code[.='23']">
			
		</xsl:when>
		</xsl:choose>
    </xsl:if>
    
    
        <!-- TD Inquiry -->
    <xsl:if test="tnx_type_code[.='13'] and  product_code[.='TD']">
    	<xsl:choose>	
     	<!-- Update -->
        <xsl:when test="td_type[.='ROLLOVER']">
        	<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_ROLLOVER_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
			
			<!-- start date -->
			 <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_VALUE_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="value_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		    <!-- maturity date -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="maturity_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		    
		      		      	
			     <!-- new amount -->
			 <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_AMOUNTDETAILS_ROLLOVER_AMT_LABEL</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="td_amt" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
			  
			     
			     <!-- Interest Capitalisation -->
			   <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_INTEREST_CAPITALISATION_LABEL</xsl:with-param>
		      <xsl:with-param name="content">
				<div class="content">
		      <xsl:value-of select="interest_capitalisation" />
		      </div>
		      </xsl:with-param>
		      </xsl:call-template>
			     
		</xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="td_type[.='REBOOK']">
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_REBOOK_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
			    <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="label">XSL_TD_AMOUNT_LABEL</xsl:with-param>
			      <xsl:with-param name="content">
					<div class="content">
			      <xsl:value-of select="td_amt" />
			      </div>
			      </xsl:with-param>
		      	</xsl:call-template>
			     <!-- value date -->
				<xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_VALUE_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="value_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		     <!-- maturity date -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="maturity_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>		
			
		    </xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	</xsl:choose>				
    </xsl:if>
      
 </div>
 <!-- Purchase Order Apply - Invoice Presentation / Payment terms -->
	<xsl:if test="((prod_stat_code='45' or prod_stat_code='04' or prod_stat_code='48') and product_code='PO') or product_code='IN'">
		<!-- Payments declaration -->
		<xsl:call-template name="payments-declaration" />
	</xsl:if>
 </xsl:template>
</xsl:stylesheet>