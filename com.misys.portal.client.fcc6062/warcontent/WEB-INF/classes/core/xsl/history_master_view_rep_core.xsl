<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"	
	exclude-result-prefixes="localization xmlRender utils security loanIQ defaultresource">
	
	<!--
   Copyright (c) 2000-2007 Misys (http://www.misys.com),
   All Rights Reserved. 
	-->
	
	<xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">view</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code"></xsl:param> 
  <xsl:param name="main-form-name"></xsl:param>
  <xsl:param name="realform-action"></xsl:param>
  <xsl:param name="cross-ref-summary-option"></xsl:param>
  
	<!-- Global Imports. -->
	<xsl:include href="common/trade_common.xsl" />
  	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!--TEMPLATE Main-->
	<xsl:template match="lc_tnx_record | li_tnx_record | fb_tnx_record | ri_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | ft_tnx_record | po_tnx_record | so_tnx_record | in_tnx_record | ip_tnx_record | br_tnx_record | fx_tnx_record | td_tnx_record | la_tnx_record | xo_tnx_record | ln_tnx_record | se_tnx_record | to_tnx_record  | sp_tnx_record | fa_tnx_record | bk_tnx_record | cn_tnx_record | cr_tnx_record | io_tnx_record | tu_tnx_record | ls_tnx_record |ea_tnx_record">
	 <div id="history-master">
		<div class="indented-header">
		<h3>
		<xsl:choose>
			<xsl:when test="product_code[.='TD'] and sub_product_code[.='TRTD']">
		 	 	<span class="legend"><xsl:value-of select="localization:getString($language, 'TOPMENU_TRTD_TREASURY_DEPOSITS')"/></span>
			 </xsl:when>
			 <xsl:otherwise>
			 <span class="legend"><xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/></span>
			 </xsl:otherwise>
		 </xsl:choose>
		 </h3>
		 <xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
         </xsl:call-template>
		 <xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_GENERALDETAILS_RELATED_REFERENCE</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="link_ref_id"/></xsl:with-param>
         </xsl:call-template>
         <div style="white-space:pre;">
			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">
	   		 	 <xsl:choose>
	                    <xsl:when test="product_code[.='BK']">BULK_CUSTOMER_REFERENCE</xsl:when>
						<xsl:otherwise>XSL_GENERALDETAILS_CUST_REF_ID</xsl:otherwise>
	             </xsl:choose>      	  
	      	  </xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param>
	         </xsl:call-template>
         </div>
         <xsl:if test="product_code[.='PO' or .='IO' or .='EA']">
          <xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="issuer_ref_id"/></xsl:with-param>
         </xsl:call-template>
         </xsl:if>
         <xsl:if test="product_code[.='EA']">
          <xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="po_ref_id"/></xsl:with-param>
         </xsl:call-template>
         </xsl:if>
         <!-- Cross Refs -->
		 <!-- Shown in consolidated view  and hiding for the loan repricing -->
<!-- 		  <xsl:if test="product_code[.!='LN']"> -->
			 <xsl:if test="cross_references">
			     <xsl:apply-templates select="cross_references" mode="display_table_tnx">
			     	<xsl:with-param name="cross-ref-summary-option"><xsl:value-of select="$cross-ref-summary-option"/></xsl:with-param>
			    </xsl:apply-templates>
			 </xsl:if>
		 <xsl:choose>
		 	<xsl:when test="product_code[.='FB']">
		 		<xsl:call-template name="input-field">
	      	  	<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_REFERENCE</xsl:with-param>
	          	<xsl:with-param name="value"><xsl:value-of select="bo_ref_id"/></xsl:with-param>
	         	</xsl:call-template>
		 	</xsl:when>
		 	<xsl:otherwise>
		 	<div style="white-space:pre;">
		 		<xsl:call-template name="input-field">
	      	  	<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	          	<xsl:with-param name="value"><xsl:value-of select="bo_ref_id"/></xsl:with-param>
	         	</xsl:call-template>
	         </div>
		 	</xsl:otherwise> 
		 </xsl:choose>  
		 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_GENERALDETAILS_FIN_BO_REF_ID</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="fin_bo_ref_id"/></xsl:with-param>
	     </xsl:call-template>       
         <xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
         </xsl:call-template>
         <xsl:choose> 
          <xsl:when test="product_code[.='LC' or .='SI' or .='EL' or .='SR']">
           <xsl:if test="lc_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="lc_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <!-- MPS-41651 LC Available Amount -->
           <xsl:if test="lc_available_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="lc_available_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="lc_liab_amt[.!=''] and security:isBank($rundata)">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="lc_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          
          <xsl:when test="product_code[.='FB']">
           <xsl:if test="fb_cur_code[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_CURRENCY</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="fb_cur_code"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="inv_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_AMOUNT</xsl:with-param>
             <xsl:with-param name="value" select="inv_amt" />
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="due_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_BANKINVOICEDETAILS_DUE_AMT</xsl:with-param>
             <xsl:with-param name="value" select="due_amt" />
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="inv_due_date[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_DUE_DATE</xsl:with-param>
             <xsl:with-param name="value" select="inv_due_date" />
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="payment_status[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_PAYMENT_STATUS</xsl:with-param>
             <xsl:with-param name="value" select="payment_status" />
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="status[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_INVOICE_STATUS</xsl:with-param>
             <xsl:with-param name="value" select="localization:getDecode($language, 'N426', status)" />
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
         
          <xsl:when test="product_code[.='SE']">
           <xsl:if test="se_type[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_PAYMENTDETAILS_SE_INSTRUCTION</xsl:with-param>
             <xsl:with-param name="value" select="localization:getDecode($language, 'N430', se_type)" />
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="act_no[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_PAYMENTDETAILS_SE_ORDERING_ACCOUNT</xsl:with-param>
             <xsl:with-param name="value" select="act_no" />
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='IC']">
           <xsl:if test="ic_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ic_cur_code"/>&nbsp;<xsl:value-of select="ic_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="ic_outstanding_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ic_cur_code"/>&nbsp;<xsl:value-of select="ic_outstanding_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>    
           <!-- MPS-55947(In case of of collections liability amount won't be updated as per banks perspective so making the field as hidden) -->       
           <xsl:if test="ic_liab_amt[.!=''] and security:isBank($rundata)">
            <xsl:call-template name="hidden-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ic_cur_code"/>&nbsp;<xsl:value-of select="ic_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='IR']">
           <xsl:if test="ir_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_IR_AMT_LABEL2</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ir_cur_code"/>&nbsp;<xsl:value-of select="ir_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="ir_liab_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ir_cur_code"/>&nbsp;<xsl:value-of select="ir_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='TF']">
           <xsl:if test="fin_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="fin_outstanding_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_outstanding_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="fin_liab_amt[.!=''] and security:isBank($rundata)">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='SG']">
           <xsl:if test="sg_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="sg_cur_code"/>&nbsp;<xsl:value-of select="sg_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="sg_liab_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="sg_cur_code"/>&nbsp;<xsl:value-of select="sg_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='EC']">
           <xsl:if test="ec_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ec_cur_code"/>&nbsp;<xsl:value-of select="ec_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="ec_outstanding_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ec_cur_code"/>&nbsp;<xsl:value-of select="ec_outstanding_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>              
            <!-- MPS-55947(In case of of collections liability amount won't be updated as per banks perspective so making the field as hidden) -->       
           <xsl:if test="ec_liab_amt[.!=''] and security:isBank($rundata)">
            <xsl:call-template name="hidden-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ec_cur_code"/>&nbsp;<xsl:value-of select="ec_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='BG' or .='BR']">
           <xsl:if test="bg_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="bg_cur_code"/>&nbsp;<xsl:value-of select="bg_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <!-- MPS-41651 BG Available Amount -->
           <xsl:if test="bg_available_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="bg_cur_code"/>&nbsp;<xsl:value-of select="bg_available_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="bg_liab_amt[.!=''] and security:isBank($rundata)">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="bg_cur_code"/>&nbsp;<xsl:value-of select="bg_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='LI']">
           <xsl:if test="li_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LI_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="li_cur_code"/>&nbsp;<xsl:value-of select="li_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="li_liab_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="li_cur_code"/>&nbsp;<xsl:value-of select="li_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
           <xsl:when test="product_code[.='LN']">
           <xsl:if test="ln_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_LOAN_AMOUNT</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ln_cur_code"/>&nbsp;<xsl:value-of select="ln_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="ln_liab_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ln_cur_code"/>&nbsp;<xsl:value-of select="ln_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           <!-- Repricing frequency -->
			<xsl:variable name="scalarOfRepricingFrequency">
				<xsl:value-of select="translate(repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','')"/>
			</xsl:variable>
			<xsl:variable name="unitOfRepricingFrequency">
				<xsl:value-of select="translate(repricing_frequency,'0123456789 ','')"/>
			</xsl:variable>
			<xsl:if test="repricing_frequency[.!='']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="concat($scalarOfRepricingFrequency, ' ', localization:getDecode($language, 'C031', $unitOfRepricingFrequency))"/>
					</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="label">XSL_GENERALDETAILS_REPRICING_DATE</xsl:with-param>
     			<xsl:with-param name="name">repricing_date</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
           </xsl:if>
           <xsl:if test="fx_conversion_rate[.!=''] and fac_cur_code[.!=''] and (string(ln_cur_code)!=string(fac_cur_code))">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XLS_FX_RATE</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="fx_conversion_rate"/></xsl:with-param>
			</xsl:call-template>
		   </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='LS']">
          <xsl:if test="ls_number[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_LICENSE_NUMBER</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ls_number"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="total_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_LICENSE_AMOUNT</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ls_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="ls_liab_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ls_cur_code"/>&nbsp;<xsl:value-of select="ls_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code[.='PO' or .='SO']">
           <xsl:if test="total_net_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="total_net_cur_code"/>&nbsp;<xsl:value-of select="total_net_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="po_liab_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="po_cur_code"/>&nbsp;<xsl:value-of select="po_liab_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
           <xsl:when test="product_code[.='IN' or .='IP']">
           <xsl:if test="total_net_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_IP_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_net_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="liab_total_net_amt[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="liab_total_cur_code"/>&nbsp;<xsl:value-of select="liab_total_net_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code = 'IO'">
           <xsl:if test="total_net_amt !=''">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_IMPORT_OPEN_ACCOUNT_AMOUNT</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_net_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           <xsl:if test="liab_total_amt !=''">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="liab_total_cur_code"/>&nbsp;<xsl:value-of select="liab_total_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
          <xsl:when test="product_code = 'FT'">
           <xsl:if test="ft_amt !=''">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_FT_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
          </xsl:when>
         </xsl:choose>
         
          <xsl:if test="product_code[.='CN']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="appl_date"/></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N084',fscm_program_code)" /></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
         
		</div>
		<xsl:choose>
		  <xsl:when test="product_code[.='LC' or .='SG' or .='TF' or .='SI' or .='FT' or .='BG' or .='LI' or .= 'FX' or .= 'XO' or .= 'TD' or .='FB']">
			<xsl:choose>
		  <xsl:when test="product_code[.='FB']">    
			    <xsl:call-template name="fieldset-wrapper">
	   			<xsl:with-param name="legend">XSL_HEADER_CUSTOMER_DETAILS</xsl:with-param>
	   			<xsl:with-param name="legend-type">indented</xsl:with-param>
	   			<xsl:with-param name="content">
		         <xsl:if test="issuing_bank/name[.!='']">
		         <xsl:call-template name="input-field">
		     		 <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
		    		 <xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
		    		 <xsl:with-param name="value" select="issuing_bank/name" />
		    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    	     </xsl:call-template>
	    	     </xsl:if>
	    	     <xsl:if test="applicant_reference[.!='']">
	    	     <xsl:variable name="applicant_ref"><xsl:value-of select="applicant_reference" /></xsl:variable>
	    	     <xsl:call-template name="input-field">
		     		 <xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_CUST_ID</xsl:with-param>
		    		 <xsl:with-param name="id">applicant_reference_view</xsl:with-param>
		    		 <xsl:with-param name="value" select = "utils:decryptApplicantReference(applicant_reference)"/>
		    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    	     </xsl:call-template> 
	    	     </xsl:if>
	   			</xsl:with-param>
	   		   </xsl:call-template>
   		   </xsl:when>
   		   <xsl:otherwise>
			   <xsl:call-template name="fieldset-wrapper">
	   			<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
	   			<xsl:with-param name="legend-type">indented</xsl:with-param>
	   			<xsl:with-param name="content">
	   			 <xsl:call-template name="input-field">
		      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
		          <xsl:with-param name="value"><xsl:value-of select="applicant_name"/></xsl:with-param>
		         </xsl:call-template>
		         <xsl:call-template name="input-field">
		      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
		          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
		         </xsl:call-template>
		         <xsl:call-template name="input-field">
		          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
		         </xsl:call-template>
		         <xsl:call-template name="input-field">
		          <xsl:with-param name="value"><xsl:value-of select="applicant_dom"/></xsl:with-param>
		         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
		         <xsl:if test="issuing_bank/name[.!='']">
		         <xsl:call-template name="input-field">
	     		 <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	    		 <xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
	    		 <xsl:with-param name="value" select="issuing_bank/name" />
	    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    	     </xsl:call-template>
	    	     </xsl:if>
	    	     <xsl:if test="applicant_reference[.!='']">
	    	     <xsl:variable name="applicant_ref"><xsl:value-of select="applicant_reference" /></xsl:variable>
	    	     <xsl:call-template name="input-field">
	     		 <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
	    		 <xsl:with-param name="id">applicant_reference_view</xsl:with-param>
	    		 <xsl:with-param name="value">
	    		 		<xsl:choose>
	                     <xsl:when test="(count(//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]) >= 1) and (//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]/description[.!=''])">
	                          <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]/description"/>
	                     </xsl:when>
	                     <xsl:when test="(count(//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]) = 0) and (//*/avail_main_banks/bank/customer_reference[reference=$applicant_ref]/description[.!=''])">
	                          <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$applicant_ref]/description"/>
	                     </xsl:when>
	                     <xsl:otherwise>
	                     	<xsl:if test="product_code[.='FX']">
								<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)" />	
							</xsl:if>											
						</xsl:otherwise>
	             	</xsl:choose>
	    		 </xsl:with-param>
	    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    	     </xsl:call-template> 
	    	     </xsl:if>
	   			</xsl:with-param>
	   		   </xsl:call-template>
   		   </xsl:otherwise>
   		   </xsl:choose>
   		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value">
	          	<xsl:choose>
                	<xsl:when test="product_code[.='FT']">
                    	<xsl:value-of select="counterparties/counterparty/counterparty_name"/>
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:value-of select="beneficiary_name"/>
                    </xsl:otherwise>
              	</xsl:choose>
              </xsl:with-param>
	         </xsl:call-template>
	          <xsl:if test="product_code[.='FT'] and defaultresource:getResource('BENEFICIARY_NICKNAME_ENABLED')='true' and counterparties/counterparty/beneficiary_nickname!=''">
	         	<xsl:call-template name="beneficiary-nickname-field-template"/>
	         </xsl:if>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	      	  <xsl:with-param name="value">
	          	<xsl:choose>
                	<xsl:when test="product_code[.='FT']">
                    	<xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/>
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:value-of select="beneficiary_address_line_1"/>
                    </xsl:otherwise>
              	</xsl:choose>
	          </xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	           <xsl:with-param name="value">
	          	<xsl:choose>
                	<xsl:when test="product_code[.='FT']">
                    	<xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/>
                    </xsl:when>
                    <xsl:otherwise>
	          			<xsl:value-of select="beneficiary_address_line_2"/>
	          		</xsl:otherwise>
	          	</xsl:choose>
	          </xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value">
	          	<xsl:choose>
                	<xsl:when test="product_code[.='FT']">
                    	<xsl:value-of select="counterparties/counterparty/counterparty_dom"/>
                    </xsl:when>
                    <xsl:otherwise>
	          	    	<xsl:value-of select="beneficiary_dom"/>
	          	    </xsl:otherwise>
	          	</xsl:choose>
	          </xsl:with-param>
	         </xsl:call-template>
	         <xsl:if test="product_code[.!='FT']">
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
	         </xsl:if>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		   <xsl:when test="product_code[.='IO' or .='EA']">
		  	 <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   					 <xsl:call-template name="input-field">
	      				  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	         			 <xsl:with-param name="value"><xsl:value-of select="buyer_name"/></xsl:with-param>
	       			  </xsl:call-template>
	       			  <xsl:call-template name="input-field">
		      	  	 	<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
		       		    <xsl:with-param name="value"><xsl:value-of select="buyer_street_name"/></xsl:with-param>
		        	 </xsl:call-template>
		        	 <xsl:call-template name="input-field">
		       		    <xsl:with-param name="value"><xsl:value-of select="buyer_town_name"/></xsl:with-param>
		        	 </xsl:call-template>
		        	 <xsl:call-template name="input-field">
		       		    <xsl:with-param name="value"><xsl:value-of select="buyer_country_sub_div"/></xsl:with-param>
		        	 </xsl:call-template>
   				</xsl:with-param>
	   		 </xsl:call-template>
			 <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   				<xsl:call-template name="input-field">
	      	  	 	<xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	       		    <xsl:with-param name="value"><xsl:value-of select="seller_name"/></xsl:with-param>
	        	 </xsl:call-template>
	        	 <xsl:call-template name="input-field">
	      	  	 	<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	       		    <xsl:with-param name="value"><xsl:value-of select="seller_street_name"/></xsl:with-param>
	        	 </xsl:call-template>
	        	 <xsl:call-template name="input-field">
	       		    <xsl:with-param name="value"><xsl:value-of select="seller_town_name"/></xsl:with-param>
	        	 </xsl:call-template>
	        	 <xsl:call-template name="input-field">
	       		    <xsl:with-param name="value"><xsl:value-of select="seller_country_sub_div"/></xsl:with-param>
	        	 </xsl:call-template>
	        	 
	        	 <xsl:if test="seller_reference[.!='']">
		    	     <xsl:variable name="seller_ref"><xsl:value-of select="seller_reference" /></xsl:variable>
		    	     <xsl:call-template name="input-field">
		     		 <xsl:with-param name="label">XSL_PARTY_BANK_REFERENCE</xsl:with-param>
		    		 <xsl:with-param name="id">seller_reference_view</xsl:with-param>
		    		 <xsl:with-param name="value">
		    		 	<xsl:choose>
		                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$seller_ref]) >= 1">
		                          <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$seller_ref]/description"/>
		                     </xsl:when>
		                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$seller_ref]) = 0">
		                          <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$seller_ref]/description"/>
		                     </xsl:when>
		             	</xsl:choose>
		    		 </xsl:with-param>
		    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    	     </xsl:call-template> 
		    	 </xsl:if>
	        	 
	        	 
   			</xsl:with-param>
   		   </xsl:call-template>
   		  
   		    <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   				 <xsl:call-template name="input-field">
	      			  <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
	       			  <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
	       		  </xsl:call-template>
   				</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		  <xsl:when test="product_code[.='TM']">
		  	 <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   					 <xsl:call-template name="input-field">
	      				  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	         			 <xsl:with-param name="value"><xsl:value-of select="buyer_name"/></xsl:with-param>
	       			  </xsl:call-template>
   				</xsl:with-param>
	   		 </xsl:call-template>
			 <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   				<xsl:call-template name="input-field">
	      	  	 	<xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	       		    <xsl:with-param name="value"><xsl:value-of select="seller_name"/></xsl:with-param>
	        	 </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
   		    <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
	   				<xsl:if test="link_ref_id[.!='']">
		      			<xsl:variable name="linkRefId"><xsl:value-of select="link_ref_id"/></xsl:variable>
	   				     <xsl:call-template name="input-field">
		      			 	<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_CUSTOMER_BANK_BIC</xsl:with-param>
		       			  	<xsl:with-param name="value">
		    	       	     	<xsl:choose>
			       			  		<xsl:when test="contains($linkRefId,IO)"><xsl:value-of select="buyer_bank_bic"/></xsl:when>
			       			  		<xsl:when test="contains($linkRefId,EA)"><xsl:value-of select="seller_bank_bic"/></xsl:when>
		       			     	</xsl:choose> 
		       			  </xsl:with-param>
		       		  </xsl:call-template>
		       		</xsl:if>
   				</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		   		    
		  <xsl:when test="product_code[.='LS']">
		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend"><xsl:value-of select="license/license_definition/principal_label"/></xsl:with-param>
   			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
   			<xsl:with-param name="localized">N</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="applicant_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="applicant_dom"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:if test="issuing_bank/name[.!='']">
	         <xsl:call-template name="input-field">
     		 <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    		 <xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
    		 <xsl:with-param name="value" select="issuing_bank/name" />
    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	     </xsl:call-template>
    	     </xsl:if>
    	     <xsl:if test="applicant_reference[.!='']">
    	     <xsl:variable name="applicant_ref"><xsl:value-of select="applicant_reference" /></xsl:variable>
    	     <xsl:call-template name="input-field">
     		 <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
    		 <xsl:with-param name="id">applicant_reference_view</xsl:with-param>
    		 <xsl:with-param name="value">
    		 	<xsl:choose>
                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]) >= 1">
                          <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]/description"/>
                     </xsl:when>
                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]) = 0">
                          <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$applicant_ref]/description"/>
                     </xsl:when>
             	</xsl:choose>
    		 </xsl:with-param>
    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	     </xsl:call-template> 
    	     </xsl:if>
   			</xsl:with-param>
   		   </xsl:call-template>
   		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend"><xsl:value-of select="license/license_definition/non_principal_label"/></xsl:with-param>
   			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
   			<xsl:with-param name="localized">N</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_dom"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		  <xsl:when test="product_code[.='EL' or .='SR' or .='BR']">
		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_dom"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
 	         <xsl:choose>
 	           <xsl:when test="product_code[.='BR']">
 	              <xsl:if test="beneficiary_name[.!='']">
			        <xsl:call-template name="input-field">
		     		  <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
		    		   <xsl:with-param name="id">advising_bank_name_view</xsl:with-param>
		    		  <xsl:with-param name="value" select="advising_bank/name" />
		    		  <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    	    </xsl:call-template>
	    	     </xsl:if>
 	           </xsl:when>
 	           <xsl:otherwise>
 	              <xsl:if test="advising_bank/name[.!='']">
			        <xsl:call-template name="input-field">
		     		  <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
		    		  <xsl:with-param name="id">advising_bank_name_view</xsl:with-param>
		    		  <xsl:with-param name="value" select="advising_bank/name" />
		    		  <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    	    </xsl:call-template>
	    	     </xsl:if>
 	           </xsl:otherwise>
 	         </xsl:choose>
 	        
    	     <xsl:if test="beneficiary_reference[.!='']">
    	     <xsl:variable name="beneficiary_ref"><xsl:value-of select="beneficiary_reference" /></xsl:variable>
    	      <xsl:call-template name="input-field">
     		   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
    		   <xsl:with-param name="id">beneficiary_reference_view</xsl:with-param>
    		   <xsl:with-param name="value">
    		 	<xsl:choose>
                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$beneficiary_ref]) >= 1">
                          <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$beneficiary_ref]/description"/>
                     </xsl:when>
                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$beneficiary_ref]) = 0">
                          <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$beneficiary_ref]/description"/>
                     </xsl:when>
             	</xsl:choose>
    		 </xsl:with-param>
    		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	      </xsl:call-template> 
    	     </xsl:if>
   			</xsl:with-param>
   		   </xsl:call-template>
   		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="applicant_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="applicant_dom"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="applicant_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		  <xsl:when test="product_code[.='IR']">
		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="beneficiary_dom"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
   		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_REMITTER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="remitter_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="remitter_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="remitter_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="remitter_dom"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		  <xsl:when test="product_code[.='EC']">
   		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_DRAWER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawer_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawer_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawer_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawer_dom"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawer_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
    	     <xsl:if test="remitting_bank/name[.!='']">
 	          <xsl:call-template name="input-field">
      		   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    		   <xsl:with-param name="id">remitting_bank_name_view</xsl:with-param>
    		   <xsl:with-param name="value" select="remitting_bank/name" />
    		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	      </xsl:call-template>
    	     </xsl:if>
    	     <xsl:if test="drawer_reference[.!='']">
    	       <xsl:variable name="drawer_ref"><xsl:value-of select="drawer_reference" /></xsl:variable>
    	       <xsl:call-template name="input-field">
     		    <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
    		    <xsl:with-param name="id">drawer_reference_view</xsl:with-param>
    		    <xsl:with-param name="value">
	    		 	 <xsl:choose>
	                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) >= 1">
	                          <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]/description"/>
	                     </xsl:when>
	                     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) = 0">
	                          <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$drawer_ref]/description"/>
	                     </xsl:when>
		             </xsl:choose>
		    	  </xsl:with-param>
    		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	       </xsl:call-template> 
    	     </xsl:if>
   			</xsl:with-param>
   		   </xsl:call-template>
		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawee_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawee_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawee_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawee_dom"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawee_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		  <xsl:when test="product_code[.='IC']">
		   	<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawee_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawee_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawee_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawee_dom"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawee_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
   		     <xsl:if test="presenting_bank/name[.!='']">
	          <xsl:call-template name="input-field">
     		   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    		   <xsl:with-param name="id">presenting_bank_name_view</xsl:with-param>
    		   <xsl:with-param name="value" select="presenting_bank/name" />
    		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	      </xsl:call-template>
    	     </xsl:if>
    	     <xsl:if test="drawee_reference[.!='']">
    	     <xsl:variable name="drawee_ref"><xsl:value-of select="drawee_reference" /></xsl:variable>
    	      <xsl:call-template name="input-field">
     		   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
    		   <xsl:with-param name="id">drawee_reference_view</xsl:with-param>
    		   <xsl:with-param name="value">
    		 	<xsl:choose>
					<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawee_ref]) >= 1">
						<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$drawee_ref]/description"/>
					</xsl:when>
					<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawee_ref]) = 0">
						<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$drawee_ref]/description"/>
					</xsl:when>
				</xsl:choose>
    		 </xsl:with-param>
    		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	      </xsl:call-template> 
    	     </xsl:if>
   			</xsl:with-param>
   		   </xsl:call-template>
		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_DRAWER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawer_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="drawer_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawer_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawer_dom"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="drawer_address_line_4"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		  <xsl:when test="product_code[.='LN']">
		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_BORROWER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="borrower_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="borrower_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="borrower_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="borrower_dom"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		    
		  <xsl:when test="product_code='CN' or 'CR'">
		   <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   				<xsl:call-template name="input-field">
	      	  	 	<xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	       		    <xsl:with-param name="value"><xsl:value-of select="seller_name"/></xsl:with-param>
	        	 </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
   		   <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   					 <xsl:call-template name="input-field">
	      				  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	         			 <xsl:with-param name="value"><xsl:value-of select="buyer_name"/></xsl:with-param>
	       			  </xsl:call-template>
   				</xsl:with-param>
   		   </xsl:call-template>
   		    <xsl:call-template name="fieldset-wrapper">
   				<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   				<xsl:with-param name="legend-type">indented</xsl:with-param>
   				<xsl:with-param name="content">
   				 <xsl:call-template name="input-field">
	      			  <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
	       			  <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
	       		  </xsl:call-template>
	       		  <xsl:choose>
	       		  	<xsl:when test="product_code='CN'">
	       		  		<xsl:call-template name="input-field">
	      					<xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
	       			 		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(seller_reference)"/></xsl:with-param>
	      		   		</xsl:call-template>
	      		 	</xsl:when>
	       		  	<xsl:when test="product_code='CR'">
	       		 	 	<xsl:call-template name="input-field">
	      					<xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
	       					<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(buyer_reference)"/></xsl:with-param>
	      		   		</xsl:call-template>
	      			</xsl:when>
	      		  </xsl:choose>
   				</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		  
		  
		  
		  <xsl:when test="product_code[.='IP' or .='PO']">
		  <div class="indented-header">
			<h3>
		 	<span class="legend"><xsl:value-of select="localization:getString($language, 'XSL_HEADER_BUYER_DETAILS')"/></span>
			</h3>
			<!--  <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content"> -->
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="buyer_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="buyer_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="buyer_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="buyer_dom"/></xsl:with-param>
	         </xsl:call-template>
   			<!-- </xsl:with-param>
   		   </xsl:call-template> -->
   		
			<h3>
		 	<span class="legend"><xsl:value-of select="localization:getString($language, 'XSL_HEADER_SELLER_DETAILS')"/></span>
			</h3>
   	 		<!--<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">  -->
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="seller_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="seller_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="seller_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="seller_dom"/></xsl:with-param>
	         </xsl:call-template>
   			<!--  </xsl:with-param>
   		   </xsl:call-template>  -->
   		   </div>   		  
   		    <xsl:if test="issuing_bank/name[.!='']">
	         <xsl:call-template name="input-field">
     		 <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    		 <xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
    		 <xsl:with-param name="value" select="issuing_bank/name" />
    		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	     </xsl:call-template>
    	     </xsl:if>
		  </xsl:when>
		  <xsl:when test="product_code[.='IN' or 'SO']">
		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="seller_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="seller_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="seller_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="seller_dom"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
   		   <xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
   			<xsl:with-param name="legend-type">indented</xsl:with-param>
   			<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="buyer_name"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	      	  <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	          <xsl:with-param name="value"><xsl:value-of select="buyer_address_line_1"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="buyer_address_line_2"/></xsl:with-param>
	         </xsl:call-template>
	         <xsl:call-template name="input-field">
	          <xsl:with-param name="value"><xsl:value-of select="seller_dom"/></xsl:with-param>
	         </xsl:call-template>
   			</xsl:with-param>
   		   </xsl:call-template>
		  </xsl:when>
		 </xsl:choose>
	  </div>
	</xsl:template>
</xsl:stylesheet>