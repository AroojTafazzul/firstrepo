<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for displaying transaction summaries.

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
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
 xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
 xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
 xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
 exclude-result-prefixes="localization converttools xmlRender security">
 
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

  <xsl:include href="../../core/xsl/common/trade_common.xsl"/>
  <xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
   
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
	
  <!--TEMPLATE Main-->
  <xsl:template match="ip_tnx_record">
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
      <xsl:if test="tnx_type_code[.='85']"> 
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_COMPANY_NAME</xsl:with-param>
				<xsl:with-param name="value" select="company_name"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="fscm_programme_code[.!='']">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
				<xsl:with-param name="name"><xsl:value-of select="localization:getDecode($language, 'N084', fscm_programme_code[.])" /></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
           	<xsl:with-param name="value" select="localization:getDecode($language, 'N001', product_code[.])"/>
		</xsl:call-template>      
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_TYPE</xsl:with-param>
           	<xsl:with-param name="value">
		         <xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
		         <xsl:if test="sub_tnx_type_code[.!='']">&nbsp;<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/></xsl:if>
           	</xsl:with-param>
		</xsl:call-template> 
		<!-- <xsl:if test="tnx_type_code[.!='85']">     -->  
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
           	<xsl:with-param name="value" select="ref_id"/>
		</xsl:call-template>
		<!-- </xsl:if> -->	   
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_FOLDER_REF_ID</xsl:with-param>
           	<xsl:with-param name="value" select="link_ref_id"/>
		</xsl:call-template>  
		<!-- <xsl:if test="tnx_type_code[.!='85']"> --> 
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
           	<xsl:with-param name="value" select="cust_ref_id"/>
		</xsl:call-template>   
		<!-- </xsl:if>  -->   

      <xsl:if test="((tnx_type_code[.='01'] and tnx_stat_code[.='04']) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
           	<xsl:with-param name="value" select="bo_ref_id"/>
		</xsl:call-template> 
      </xsl:if>
      <xsl:if test="((tnx_type_code[.='01'] and tnx_stat_code[.='04']) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_FIN_BO_REF_ID</xsl:with-param>
           	<xsl:with-param name="value" select="fin_bo_ref_id"/>
		</xsl:call-template> 
      </xsl:if>
      
      <!-- Show cross references -->
      <!-- <xsl:apply-templates select="cross_references" mode="display_table_tnx"/> -->
      <!-- Initiation From -->
	  <xsl:if test="cross_references/cross_reference/type_code[.='02'] and (child_product_code != product_code)">
	   <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
           	<xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
		</xsl:call-template> 
	  </xsl:if>
      
      <!--
       Select among the different transaction types 
       -->
      <xsl:choose>
       <!-- NEW -->
       <xsl:when test="tnx_type_code[. = '01'] or tnx_type_code[. = '13'] or (tnx_type_code[. = '15'] and tnx_stat_code[.='04']) or tnx_type_code[. = '63'] or tnx_type_code[. = '85']"> 
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
				<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
	           	<xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
			</xsl:call-template>
			<xsl:if test="sub_tnx_type_code[.!='A4'] and tnx_type_code[.!='85']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_DATE</xsl:with-param>
					<xsl:with-param name="name">iss_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_DUE_DATE</xsl:with-param>
					<xsl:with-param name="name">due_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="repay_date[.!='']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REPAYMENT_FINANCE_DATE</xsl:with-param>
					<xsl:with-param name="name">repay_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
       </xsl:when>
		</xsl:choose>
	
        <!--Documents Send Mode-->
        <xsl:if test="free_format_text[.!='']">
	      	<xsl:choose>
		        <xsl:when test="$displaymode='edit'">
					<xsl:call-template name="row-wrapper">
		         		<xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
			         	<xsl:with-param name="type">textarea</xsl:with-param>
		         		<xsl:with-param name="content">
								<div class="content">
		           			<xsl:value-of select="$displaymode"/>
			         		</div>
			         	</xsl:with-param>
		         	</xsl:call-template>
				</xsl:when>
	         	<xsl:when test="$displaymode='view'">
					<xsl:call-template name="big-textarea-wrapper">
						<xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
						<xsl:with-param name="type">textarea</xsl:with-param>
						<xsl:with-param name="content">
							<div class="content">
								<xsl:value-of select="free_format_text"/>
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
	        </xsl:choose>
        </xsl:if>
        
         <xsl:call-template name="attachments-file-dojo">
          <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
          <xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
          <xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
          <!--<xsl:with-param name="parse-widgets">N</xsl:with-param>
          <xsl:with-param name="with-wrapper">N</xsl:with-param>
         --></xsl:call-template> 
        <!--<xsl:if test="attachments/attachment[auto_gen_doc_code != '']">
         <xsl:call-template name="attachments-file-dojo">
          <xsl:with-param name="existing-attachments" select="attachments/attachment[auto_gen_doc_code != '']"/>
          <xsl:with-param name="legend">XSL_HEADER_OTHER_FILE_UPLOAD</xsl:with-param>
         </xsl:call-template> 
        </xsl:if>-->
        
      <!-- Bank Message -->
      <xsl:if test="tnx_stat_code[.='04'] or security:isBank($rundata) or prod_stat_code = '46' or (finance_requested_flag[.='Y' or .='P'] and tnx_type_code[.='63']) or (prod_stat_code ='E2' and tnx_type_code ='85')">
       	<xsl:call-template name="fieldset-wrapper">
        	<xsl:with-param name="legend">XSL_HEADER_MESSAGE</xsl:with-param>
        	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
        	<xsl:with-param name="parse-widgets">N</xsl:with-param>
        	<xsl:with-param name="content">
          	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_DTTM</xsl:with-param>
           		<xsl:with-param name="value" select="converttools:formatReportDate(bo_release_dttm,$rundata)"/>
		  	</xsl:call-template>
          	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="prod_stat_code[.='70']">
								<xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])" />
								(<xsl:value-of select="localization:getDecode($language, 'N084', fscm_programme_code[.])" />)
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code)" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
		  	</xsl:call-template>
		  
           <xsl:if test="eligibility_flag[.!='']">
           	   <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REPORTINGDETAILS_ELIGIBILITY_STATUS_LABEL</xsl:with-param>
           			<xsl:with-param name="id">eligibility_flag_view</xsl:with-param>
           			<xsl:with-param name="value">
           				<xsl:value-of select="localization:getDecode($language, 'N085', eligibility_flag)" />
           			</xsl:with-param>
           	   </xsl:call-template>
          </xsl:if>
          <xsl:if test="full_finance_accepted_flag[.!='']">
	           <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FULL_FINANCING_FLAG_LABEL</xsl:with-param>
		           	<xsl:with-param name="id">full_finance_accepted_flag_view</xsl:with-param>
		           	<xsl:with-param name="value">
		           		<xsl:value-of select="localization:getDecode($language, 'N034', full_finance_accepted_flag)" />
		           	</xsl:with-param>
	           </xsl:call-template>
         </xsl:if>
         
		<!-- Added so that transaction appear in Inquiry screen of IP -->
		<xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_AMOUNT</xsl:with-param>
			<xsl:with-param name="override-currency-name">total_net_cur_code</xsl:with-param>
			<xsl:with-param name="override-amt-name">total_net_amt</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="inv_eligible_amt[.!=''] and sub_tnx_type_code[.!='A4'] and tnx_type_code[.!='85']">
           <xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMOUNT</xsl:with-param>
	           	<xsl:with-param name="id">inv_eligible_amt_view</xsl:with-param>
	           	<xsl:with-param name="product-code">inv_eligible</xsl:with-param>
           </xsl:call-template>
        </xsl:if>
        <xsl:if test="finance_requested_flag[.='Y' or .='P'] and tnx_type_code[.='63']">
           <xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_CURRENCY</xsl:with-param>
	           	<xsl:with-param name="value">
					<xsl:choose>
		    			<xsl:when test="finance_requested_cur_code[.='']"><xsl:value-of select="inv_eligible_cur_code"/></xsl:when>
		    			<xsl:otherwise><xsl:value-of select="finance_requested_cur_code"/></xsl:otherwise>
		    		</xsl:choose>
				</xsl:with-param>
           </xsl:call-template>
           <xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_REQUESTED_AMT</xsl:with-param>
	           	<xsl:with-param name="id">finance_requested_amt_view</xsl:with-param>
	           	<xsl:with-param name="override-currency-name">finance_requested_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">finance_requested_amt</xsl:with-param>
				<xsl:with-param name="override-currency-value">
	     			<xsl:choose>
		    			<xsl:when test="finance_requested_cur_code[.='']"><xsl:value-of select="total_cur_code"/></xsl:when>
		    			<xsl:otherwise><xsl:value-of select="finance_requested_cur_code"/></xsl:otherwise>
		    		</xsl:choose>
	     			</xsl:with-param>
				<xsl:with-param name="override-amt-value" select="finance_requested_amt"></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
	           	<xsl:with-param name="product-code">finance_requested</xsl:with-param>
           </xsl:call-template>
         </xsl:if> 
         <xsl:if test="finance_amt[.!='']">
	     	<xsl:call-template name="currency-field">
				<xsl:with-param name="label">
					<xsl:choose>
						<xsl:when test="sub_tnx_type_code[.!='A4'] and tnx_type_code[.!='63']">XSL_GENERALDETAILS_IN_PAYMENT_AMOUNT</xsl:when>
						<xsl:otherwise>XSL_GENERALDETAILS_IN_FINANCE_AMOUNT</xsl:otherwise>
					</xsl:choose>					
				</xsl:with-param>
				<xsl:with-param name="id">finance_amt_view</xsl:with-param>
	           	<xsl:with-param name="product-code">finance</xsl:with-param>
	     	</xsl:call-template>
         </xsl:if> 
         <xsl:if test="finance_repayment_amt[.!=''] and sub_tnx_type_code[.='A4']">				
		 	<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
			 	<xsl:with-param name="product-code">finance_repayment</xsl:with-param>	
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
			</xsl:call-template>
		 </xsl:if>
		 <xsl:if test="total_repaid_amt[.!=''] and tnx_stat_code[.='04']">			
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_TOTAL_REPAID_AMT</xsl:with-param>
				 	<xsl:with-param name="product-code">total_repaid</xsl:with-param>
					<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>											
				</xsl:call-template>
		 </xsl:if>
		 <xsl:if test="outstanding_repayment_amt[.!=''] and sub_tnx_type_code[.='A4']">				
		 	<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_OUTSTANDING_REPAYMENT</xsl:with-param>
			 	<xsl:with-param name="product-code">outstanding_repayment</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
		  	</xsl:call-template>
		  </xsl:if>
		  <!-- IP Collection Settlement Amount Details -->
		  <xsl:if test="settlement_amt[.!=''] and tnx_type_code[.='85']">				
		  	<xsl:call-template name="currency-field">
			   <xsl:with-param name="label">XSL_SETTLEMENT_AMOUNT</xsl:with-param>
			   <xsl:with-param name="product-code">settlement</xsl:with-param>	
			   <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			   <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
		  	</xsl:call-template>
		  </xsl:if>
       	  <xsl:if test="liab_total_net_amt[.!=''] and sub_tnx_type_code[.!='A4']">
		  	<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
				<xsl:with-param name="override-currency-name">liab_total_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">liab_total_amt</xsl:with-param>
				<xsl:with-param name="override-currency-value" select="liab_total_net_cur_code"></xsl:with-param>
				<xsl:with-param name="override-amt-value" select="liab_total_net_amt"></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		  </xsl:if>

		  <xsl:call-template name="input-field">
		  		<xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
          		<xsl:with-param name="value" select="bo_comment"/>
		  </xsl:call-template>
		  
          <xsl:if test="action_req_code[.!='']">
           <xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
           	<xsl:with-param name="value" select="localization:getDecode($language, 'N042', action_req_code)"/>
           </xsl:call-template>
          </xsl:if>
           
           <xsl:call-template name="attachments-file-dojo">
            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
            <xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
            <xsl:with-param name="attachment-group">summarybank</xsl:with-param><!--
            <xsl:with-param name="parse-widgets">N</xsl:with-param>
            <xsl:with-param name="with-wrapper">N</xsl:with-param>
           --></xsl:call-template> 
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
 
      <!-- Charges -->
      <xsl:if test="count(charges/charge[created_in_session = 'Y']) != 0 and $option != 'FULL'">
       <xsl:call-template name="attachments-charges">
        <xsl:with-param name="existing-attachments" select="charges/charge"/>
       </xsl:call-template>
      </xsl:if>
      <!-- Reporting Message Section  -->
      <xsl:if test="tnx_type_code[.= '15'] and ($option != 'FULL')" >
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_REPORTING_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="parse-widgets">N</xsl:with-param>
				<xsl:with-param name="content">
				 <xsl:call-template name="input-field">
					<xsl:with-param name="label">TOPIC_LABEL</xsl:with-param>
		           	<xsl:with-param name="value" select="subject"/>
           		 </xsl:call-template>
           		 <xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">total_amt</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="override-currency-name">tnx_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
					<xsl:with-param name="override-currency-value" select="tnx_cur_code"></xsl:with-param>
					<xsl:with-param name="override-amt-value" select="tnx_amt"></xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="override-currency-name">liab_total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">liab_total_amt</xsl:with-param>
					<xsl:with-param name="override-currency-value" select="liab_total_net_cur_code"></xsl:with-param>
					<xsl:with-param name="override-amt-value" select="liab_total_net_amt"></xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
	           			<xsl:with-param name="value" select="bo_comment"/>
			  		</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template> 
		</xsl:if>
      
      <!-- FSCM Program conditions -->
	 <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_OPTIONAL_PROGRAMME_CONDITIONS</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
        <xsl:with-param name="content">
           	 <xsl:call-template name="string_replace">
	        	<xsl:with-param name="input_text" select="conditions"/>
	        </xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    
   </div>
 </xsl:template>
</xsl:stylesheet>