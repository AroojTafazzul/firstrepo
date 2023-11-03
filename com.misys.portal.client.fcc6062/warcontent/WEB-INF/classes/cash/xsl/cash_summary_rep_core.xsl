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
 xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
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
  <xsl:template match="fx_tnx_record | fb_tnx_record | td_tnx_record | la_tnx_record | xo_tnx_record | ft_tnx_record | to_tnx_record | sp_tnx_record">
   <div id="event-summary">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="parse-widgets">N</xsl:with-param>
     <xsl:with-param name="legend">XSL_HEADER_EVENT_DETAILS</xsl:with-param>
     <xsl:with-param name="content">
     <xsl:choose>
     	<xsl:when test="product_code[.!='FB']">
     		<xsl:if test="release_dttm[.!='']">
		   		<xsl:call-template name="row-wrapper">
			    <xsl:with-param name="id">event_summary_release_dttm_view</xsl:with-param>
			    <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RELEASE_DTTM</xsl:with-param>
			    <xsl:with-param name="content"><div class="content">
			    <xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata)"/>
			    </div></xsl:with-param>
		   		</xsl:call-template>
		  </xsl:if>	
     	</xsl:when>
     	<xsl:otherwise>
     		<xsl:if test="release_dttm[.!='']">
			    <xsl:call-template name="row-wrapper">
			    <xsl:with-param name="id">event_summary_release_dttm_view</xsl:with-param>
			    <xsl:with-param name="label">XSL_EVENT_DATE</xsl:with-param>
			    <xsl:with-param name="content"><div class="content">
			    <xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata)"/>
			    </div></xsl:with-param>
		   		</xsl:call-template>
		  </xsl:if>	
     	</xsl:otherwise>
     </xsl:choose>
     <xsl:variable name="ref_id_for_company_name"><xsl:value-of select="ref_id"/></xsl:variable>
     <xsl:variable name="product_code"><xsl:value-of select="product_code"/></xsl:variable>

	  <xsl:if test="(product_code[.='FX'] or sub_product_code[.='TRTD'] or product_code[.='FT'] or sub_product_code[.='BILLP'] or sub_product_code[.='MT103'] or sub_product_code[.='TPT'] or sub_product_code[.='INT'] or sub_product_code[.='DOM'] or sub_product_code[.='MUPS'] or sub_product_code[.='HVPS'] or sub_product_code[.='HVXB'] or sub_product_code[.='PICO'] or sub_product_code[.='FI103'] or sub_product_code[.='MT101'] or sub_product_code[.='PIDD'] or product_code[.='TD']) and company_name[.!='']">
	<xsl:call-template name="row-wrapper">
	   <xsl:with-param name="id">company_name</xsl:with-param>
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_COMPANY_NAME</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="utils:getCompanyName($ref_id_for_company_name,$product_code)"/>
       </div></xsl:with-param>
	   </xsl:call-template>
	  </xsl:if>
	  <xsl:if test="product_code[.!='']">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">event_summary_product_code_view</xsl:with-param>
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
       <xsl:if test="sub_product_code[.!=''] and product_code[.!='FB']">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">event_summary_sub_product_code_view</xsl:with-param>
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_SUBPRODUCT_CODE</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code[.])"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:if test="tnx_type_code[.!='']">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_TYPE</xsl:with-param>
       <xsl:with-param name="id">event_summary_tnx_type_view</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
         <xsl:if test="sub_tnx_type_code[.!='']">&nbsp;<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/></xsl:if>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:if test="(product_code[.='FX'] or sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'] or sub_product_code[.='TRTD']) and tnx_stat_code[.!='']">
	      <xsl:call-template name="row-wrapper">
	      	<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_STAT_CODE_LABEL</xsl:with-param>
	      	<xsl:with-param name="id">tnx_stat_code</xsl:with-param>
	      	<xsl:with-param name="content">
	      		<div class="content">
	      			<xsl:value-of select="localization:getDecode($language, 'N004', tnx_stat_code)"/>
	      		</div>
	      	</xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="id">event_summary_ref_id_view</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="not(product_code[. = 'FT'])">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="id">iss_date</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="iss_date"/>
       </div></xsl:with-param>
       </xsl:call-template>
       </xsl:if>
		<xsl:if test="(product_code[. != 'FX'] and sub_product_code[.!='TRTD'])">
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
				<xsl:with-param name="id">event_summary_cust_ref_id_view</xsl:with-param>
				<xsl:with-param name="content">
					<div class="content">
						<xsl:value-of select="cust_ref_id"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="(sub_product_code[.='INT'] or sub_product_code[.='TPT'] or sub_product_code[.='MUPS']) and counterparties/counterparty[counterparty_type='02']/counterparty_reference[.!='']">
				<xsl:if test="issuing_bank/name[.!='']">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>
						<xsl:with-param name="content">
							<div class="content">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_reference"/>
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
			<xsl:if test="sub_product_code[.!='TRTD'] and product_code[.!='FB'] and bo_ref_id[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="id">event_summary_bo_ref_id_view</xsl:with-param>
					<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="bo_ref_id"/>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	   <xsl:if test="issuing_bank/name[.!='']">
	    <xsl:call-template name="row-wrapper">
	     <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
	      <xsl:value-of select="issuing_bank/name"/>
	     </div></xsl:with-param>
	    </xsl:call-template>
	   </xsl:if>
  	   
    <!--application Date -->

	<xsl:if test="appl_date[.!='']">
	    <xsl:call-template name="row-wrapper">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
	      <xsl:value-of select="appl_date"/>
	     </div></xsl:with-param>
	    </xsl:call-template>
   </xsl:if>
   
   <xsl:if test="product_code[.='TD'] and td_amt[.!='']">
	    <xsl:call-template name="row-wrapper">
	     <xsl:with-param name="label">XSL_TD_PLACEMENT_AMOUNT</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
	      <xsl:value-of select="td_cur_code"/> <xsl:value-of select="td_amt"/>
	     </div></xsl:with-param>
	    </xsl:call-template>
   </xsl:if>
  
   <xsl:if test="ft_amt[.!='']">
	    <xsl:call-template name="row-wrapper">
	     <xsl:with-param name="label">XSL_AMOUNTDETAILS_FT_AMT_LABEL</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
	      <xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>
	     </div></xsl:with-param>
	    </xsl:call-template>
   </xsl:if>
     
      <xsl:if test="(product_code[.='FX'] or (product_code[.='TD'] and sub_product_code[.='TRTD'] )) and trade_id[.!='']">  
	      <xsl:call-template name="row-wrapper">
	       <xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
	       <xsl:with-param name="id">trade_id</xsl:with-param>
	       <xsl:with-param name="content"><div class="content">
	         <xsl:value-of select="trade_id"/>
	       </div></xsl:with-param>
	      </xsl:call-template>
	      
	       <xsl:call-template name="row-wrapper">
	       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_TNX_ID</xsl:with-param>
	       <xsl:with-param name="id">bo_tnx_id</xsl:with-param>
	       <xsl:with-param name="content"><div class="content">
	         <xsl:value-of select="bo_tnx_id"/>
	       </div></xsl:with-param>
	      </xsl:call-template>
	    
	      <xsl:if test="fx_cur_code or fx_amt or tnx_cur_code or tnx_amt" >
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="id">event_summary_fx_amt_view</xsl:with-param>
						<xsl:with-param name="content">
							<div class="content">
								<xsl:choose>
									<xsl:when test="(product_code[.='FX'] and tnx_cur_code[.!=''] and tnx_amt[.!=''] ) or (product_code[.='TD'] and sub_product_code[.='TRTD'] )">
										<xsl:value-of select="concat(tnx_cur_code, ' ', tnx_amt)" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat(fx_cur_code, ' ', fx_amt)" />
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</xsl:with-param>
					</xsl:call-template>
		   </xsl:if>
		   <xsl:if test="rate">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
						<xsl:with-param name="id">event_summary_rate_view</xsl:with-param>
						<xsl:with-param name="content">
							<div class="content">
								<xsl:value-of select="rate" />
							</div>
						</xsl:with-param>          
					</xsl:call-template>
			</xsl:if>
			<xsl:if test="counter_cur_code">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_CONTRACT_FX_COUNTER_TRANSACTION_COUNTER_AMT</xsl:with-param>
						<xsl:with-param name="id">event_summary_counter_cur_code_view</xsl:with-param>
						<xsl:with-param name="content">
							<div class="content">
								<xsl:choose>
									<xsl:when test="product_code[.='FX']">
										<xsl:value-of select="concat(counter_cur_code, ' ', tnx_counter_amt)" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat(counter_cur_code, ' ', counter_amt)" />
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</xsl:with-param>          
					</xsl:call-template>
			</xsl:if>	
			<xsl:if test="appl_date[. != ''] and product_code[.!='FX']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">APPL_DATE</xsl:with-param>
					<xsl:with-param name="name">appl_date</xsl:with-param>
					<xsl:with-param name="value" select="appl_date" />
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="option_date[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_FX_OPTION_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="id">event_summary_option_date_view</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="option_date" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="value_date[. != '']">
				<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">
		           <xsl:choose>
		            <xsl:when test="product_code[.='TD']">XSL_TD_START_DATE</xsl:when>
		            <xsl:otherwise>XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:otherwise> 
		           </xsl:choose>
		          </xsl:with-param>
					<xsl:with-param name="id">event_summary_value_date_view</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:choose>
								<xsl:when test="product_code[.='FX'] and takedown_value_date[.!='']">
									<xsl:value-of select="takedown_value_date" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="value_date" />
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- action required -->
			<xsl:if test="action_req_code[. != '']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
					<xsl:with-param name="name">action_req_code</xsl:with-param>
					<xsl:with-param name="value" select="localization:getDecode($language, 'N042', action_req_code)" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<xsl:if test="product_code[.='TD'] and sub_product_code[.='TRTD']">
		<xsl:if test="maturity_date[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="id">event_summary_maturity_date_view</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="maturity_date" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
		   	<xsl:call-template name="row-wrapper">
	         <xsl:with-param name="label">XSL_TD_AMOUNT_LABEL</xsl:with-param>
	         <xsl:with-param name="id">event_summary_td_amt_view</xsl:with-param>
	         <xsl:with-param name="content">
		         <div class="content">
		           <xsl:value-of select="td_cur_code"/>&nbsp;<xsl:value-of select="td_amt"/>
		         </div>
	         </xsl:with-param>
	      </xsl:call-template>
	      <xsl:if test="interest[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_TD_INTEREST_LABEL</xsl:with-param>
					<xsl:with-param name="id">event_summary_interest_view</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="interest" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="total_with_interest[. != '']">
			<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_TD_TOTAL_WITH_INTEREST_LABEL</xsl:with-param>
					<xsl:with-param name="id">event_summary_total_interest_view</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="total_with_interest" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
		</xsl:if>
		
       <!-- TD Amend Details -->
         <!-- System ID --><!--
      <xsl:if test="product_code[.='TD']">
      <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_ORIGINAL_BENEFICIARY_GENERAL_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="ref_id"/>
          </div></xsl:with-param>
         </xsl:call-template>
         Entity 
          <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="entity"/>
          </div></xsl:with-param>
         </xsl:call-template>
         Issuing Bank Name 
      <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="issuing_bank/name"/>
          </div></xsl:with-param>
       </xsl:call-template>
        Issuing Bank Reference 
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="applicant_reference"/>
          </div></xsl:with-param>
       </xsl:call-template>
        
     </xsl:with-param>
     </xsl:call-template>
        
      </xsl:if>
      
      
      
      --><xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_FOLDER_REF_ID</xsl:with-param>
       <xsl:with-param name="id">event_summary_link_ref_id_view</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="link_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
        
      <xsl:if test="product_code[.= 'FB']">
        <xsl:call-template name="row-wrapper">
       	<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
      	<xsl:with-param name="id">event_summary_cust_ref_id_view</xsl:with-param>
       	<xsl:with-param name="content"><div class="content">
        <xsl:value-of select="issuing_bank/name"/>
       </div></xsl:with-param>
      </xsl:call-template>
        </xsl:if>
       
        <xsl:if test="product_code[.='LC' or .='BG' or .='SR' or .='SI' or .='BR']">
	          <xsl:call-template name="row-wrapper">
		           <xsl:with-param name="label">XSL_DOC_REF_NO</xsl:with-param>
		           <xsl:with-param name="id">event_summary_doc_ref_no_view</xsl:with-param>
		           <xsl:with-param name="content"><div class="content">
		              <xsl:value-of select="doc_ref_no"/>
		            </div></xsl:with-param>
	          </xsl:call-template>
          </xsl:if>
      <xsl:if test="sub_tnx_type_code[.='25']">
	      <xsl:call-template name="row-wrapper">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL</xsl:with-param>
	         <xsl:with-param name="id">event_summary_tnx_amt_view</xsl:with-param>
	         <xsl:with-param name="content">
		         <div class="content">
		           <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
		         </div>
	         </xsl:with-param>
	      </xsl:call-template>
	  </xsl:if>  
      <!-- Show cross references -->
      <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
      <xsl:if test="product_code[.='EL' or .='SR']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="id">event_summary_lc_ref_id_view</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="lc_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <!-- Initiation From -->
	  <xsl:if test="cross_references/cross_reference/type_code[.='02']">
	   <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
	   <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">
           <xsl:choose>
            <xsl:when test="product_code[.!='TD']">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:when>
            <xsl:otherwise>BANK_REFERENCE_LABEL</xsl:otherwise> 
           </xsl:choose>
          </xsl:with-param>
        
        <xsl:with-param name="id">event_summary_parent_file_bo_ref_id_view</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="$parent_file/bo_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
	  </xsl:if>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUER_REF_ID</xsl:with-param>
       <xsl:with-param name="id">event_summary_issuer_ref_id_view</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="issuer_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="product_code[.='FX']">
    	<xsl:if test="liquidation_amt[.!=''] and liquidation_cur_code[.!='']">
    		<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">XSL_TREASURY_LIQUIDATION_AMT_LABEL</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="liquidation_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="liquidation_amt"/>
	             </div></xsl:with-param>
	        </xsl:call-template>
	    </xsl:if>
	    <xsl:if test="liquidation_date[.!='']">
    		<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">XSL_LIQUIDATION_DATE</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="liquidation_date"/>
	             </div></xsl:with-param>
	        </xsl:call-template>
	    </xsl:if>
	    <xsl:if test="liquidation_rate[.!='']">
    		<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">XSL_LIQUIDATION_RATE</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="liquidation_rate"/>
	             </div></xsl:with-param>
	        </xsl:call-template>
	    </xsl:if>
	    <xsl:if test="liquidation_profit_loss[.!='']">
    		<xsl:call-template name="row-wrapper">
	             <xsl:with-param name="label">XSL_LIQUIDATION_AMT_GAIN_LOSS</xsl:with-param>
	             <xsl:with-param name="content"><div class="content">
	               <xsl:value-of select="localization:getDecode($language, 'N429', liquidation_profit_loss[.])" />
	             </div></xsl:with-param>
	        </xsl:call-template>
	    </xsl:if>    
	    <xsl:if test="original_amt[.!=''] and original_cur_code[.!='']">
	     	<xsl:call-template name="row-wrapper">
	           <xsl:with-param name="label">XSL_CONTRACT_FX_ORG_CUR_AMT_LABEL</xsl:with-param>
	           <xsl:with-param name="content"><div class="content">
	             <xsl:value-of select="concat(original_cur_code, ' ', original_amt)"/>
	           </div></xsl:with-param>
	       </xsl:call-template>
	    </xsl:if>
	    <xsl:if test="original_counter_amt[.!=''] and original_counter_cur_code[.!='']">  
	       <xsl:call-template name="row-wrapper">
	           <xsl:with-param name="label">XSL_CONTRACT_FX_COUNTER_ORG_CUR_AMT_LABEL</xsl:with-param>
	           <xsl:with-param name="content"><div class="content">
	             <xsl:value-of select="concat(original_counter_cur_code, ' ', original_counter_amt)"/>
	           </div></xsl:with-param>
	       </xsl:call-template>
	     </xsl:if>
	  </xsl:if>   
       
      <!--
       Select amongst the different tnx types 
       -->
      <xsl:choose>
       <!-- NEW -->
       <xsl:when test="tnx_type_code[. = '01'] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TRTD']"> 
        <xsl:if test="tnx_stat_code[.='04'] and sub_product_code[.!='MEPS' and .!='MUPS' and .!='RTGS' and .!='HVPS' and .!='HVXB' and .!='INT' and .!='TPT' and .!='MT103' ]">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">
           <xsl:choose>
            <xsl:when test="product_code[.='FT']">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:when>
            <xsl:otherwise>XSL_GENERALDETAILS_ISSUE_DATE</xsl:otherwise> 
           </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="id">event_summary_iss_date_view</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="iss_date"/>
          </div></xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:choose>
          <xsl:otherwise>
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
            <xsl:with-param name="id">event_summary_exp_date_view</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="exp_date"/>
            </div></xsl:with-param>
           </xsl:call-template>
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
            <xsl:with-param name="id">event_summary_expiry_place_view</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="expiry_place"/>
            </div></xsl:with-param>
           </xsl:call-template>
         </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
       <xsl:when test="tnx_type_code[. = '01'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'])"> 
	       <xsl:if test="tnx_stat_code[.='04'] or tnx_stat_code[.='02']">
	       		<xsl:call-template name="row-wrapper">
	       			<xsl:with-param name="label">
	       				<xsl:choose>
	       					<xsl:when test="product_code[.='FT']">XSL_FT_DEAL_SUMMARY_LABEL_APPLICATION_DATE</xsl:when>
	       					<xsl:otherwise>XSL_GENERALDETAILS_ISSUE_DATE</xsl:otherwise> 
	       				</xsl:choose>
	       			</xsl:with-param>
	       			<xsl:with-param name="id">event_summary_appl_date_view</xsl:with-param>
	       			<xsl:with-param name="content">
	       				<div class="content"><xsl:value-of select="appl_date"/></div>
	       			</xsl:with-param>
	       		</xsl:call-template>
	       </xsl:if>
      
	       <xsl:if test="tnx_stat_code[.='04']">
	       		<xsl:call-template name="row-wrapper">
	          		<xsl:with-param name="label">
	           			<xsl:choose>
	            			<xsl:when test="product_code[.='FT']">XSL_REQUEST_DATE</xsl:when>
	            			<xsl:otherwise>XSL_GENERALDETAILS_ISSUE_DATE</xsl:otherwise> 
	           			</xsl:choose>
	          		</xsl:with-param>
	          		<xsl:with-param name="id">event_summary_iss_date_view</xsl:with-param>
	          		<xsl:with-param name="content"><div class="content"><xsl:value-of select="iss_date"/></div>
	          		</xsl:with-param>
	         	</xsl:call-template>
	       </xsl:if>
       </xsl:when>
      
            
       <!-- AMEND -->
       <xsl:when test="tnx_type_code[.='03'] or tnx_type_code[.='13']"> 
       <xsl:if test="product_code[.!='TD'] and tnx_type_code[.='03']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
          <xsl:with-param name="id">event_summary_amd_no_view</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="amd_no"/>
          </div></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
          <xsl:with-param name="id">event_summary_amd_date_view</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="amd_date"/>
          </div></xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      
     <!--   <xsl:if test="product_code[.='TD']">
      <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
        common fields for TD update and withdrawal
        <xsl:call-template name="td-common-general-fields"></xsl:call-template>
        <xsl:if test="tnx_type_code[.='03']">        
        <xsl:call-template name="td-common-fields"></xsl:call-template>
        </xsl:if>
	   Current Maturity Instruction Given
	   <xsl:if test="tnx_type_code[.='03'] and org_previous_file/td_tnx_record/maturity_instruction_code[.!='']">
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_TD_CURRENT_MATURITY_INSTRUCTIONS</xsl:with-param>
	     <xsl:with-param name="id">event_summary_org_previous_maturity_instruction_name_view</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="org_previous_file/td_tnx_record/maturity_instruction_name"/>
          </div></xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
     </xsl:with-param>
     </xsl:call-template>
     
     <xsl:if test="tnx_type_code[.='13']">
       <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_FIXED_DEPOSIT_DETAILS</xsl:with-param>
	     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	     <xsl:with-param name="content">
	      <xsl:call-template name="td-common-fields"></xsl:call-template>
	      <xsl:call-template name="td-withdrwal-fields"></xsl:call-template>
	     </xsl:with-param>
	   </xsl:call-template>  
     </xsl:if>
      
     Maturity Instructions Details
     <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">
     			 <xsl:choose>
					<xsl:when test="tnx_type_code[.='03']">XSL_TD_MATURITY_MODIFY_INSTRUCTIONS_DETAILS</xsl:when>
					<xsl:when test="tnx_type_code[.='13']">XSL_SETTLEMENT_INSTRUCTIONS</xsl:when>
				</xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
     new Maturity Instruction
     <xsl:if test="tnx_type_code[.='03'] and maturity_instruction[.!='']">
      <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_TD_MODIFY_MATURITY_INSTRUCTIONS</xsl:with-param>
	     <xsl:with-param name="id">event_summary_maturity_instruction_name_view</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="maturity_instruction_name"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	  </xsl:if>
	   Credit Interest to account
       <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">
				<xsl:choose>
				   <xsl:when test="tnx_type_code[.='03']">XSL_TD_CREDIT_INTEREST_TO_ACCOUNT</xsl:when>
				   <xsl:when test="tnx_type_code[.='13']">XSL_NET_SETTLEMENT_AMT_CREDIT_TO</xsl:when>
			    </xsl:choose>
		</xsl:with-param>
	    <xsl:with-param name="id">event_credit_act_name_view</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="credit_act_name"/>
          </div></xsl:with-param>
	   </xsl:call-template>
     </xsl:with-param>
     </xsl:call-template>
     Transaction Remarks
     <xsl:if test="tnx_type_code[.='03']">
     <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_TD_TRANSACTION_REMARKS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">event_remarks_view</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="remarks"/>
         </div></xsl:with-param>
	   </xsl:call-template>
     </xsl:with-param>
     </xsl:call-template>
     </xsl:if>
    </xsl:if> -->   
        </xsl:when>
        <!-- MESSAGE -->
        <xsl:when test="tnx_type_code[.='13']">
         <!-- Discrepant Ack Message -->
         <xsl:if test="sub_tnx_type_code[.='08']">
          <!-- Document Amount or Maturity date may be modified by bank -->
          <xsl:if test="tnx_amt[.!='']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">
             <xsl:choose>
              <xsl:when test="product_code[.='PO']">XSL_GENERALDETAILS_UTILIZATION_PAID_AMOUNT</xsl:when>
              <xsl:otherwise>XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:otherwise>
             </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="id">event_discrepant_tnx_amt_view</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="tnx_cur_code"/> <xsl:value-of select="tnx_amt"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
           <xsl:with-param name="id">event_discrepant_maturity_date_view</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="maturity_date"/>
            </div></xsl:with-param>
           </xsl:call-template>
         </xsl:if>
         <!-- Transfer Message -->
         <xsl:if test="sub_tnx_type_code[.='12' or .='19']">
          <xsl:choose>
		   <xsl:when test="sub_tnx_type_code[.='12']">
           <!-- Second Beneficiary -->
           <xsl:call-template name="fieldset-wrapper">
            <xsl:with-param name="legend">XSL_HEADER_SECOND_BENEFICIARY_DETAILS</xsl:with-param>
            <xsl:with-param name="legend-type">indented-header</xsl:with-param>
            <xsl:with-param name="content">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
              <xsl:with-param name="id">event_summary_sec_beneficiary_name_view</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_name"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
              <xsl:with-param name="id">event_summary_sec_beneficiary_address_line_1_view</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_address_line_1"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="id">event_summary_sec_beneficiary_address_line_2_view</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_address_line_2"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
               <xsl:with-param name="id">event_summary_sec_beneficiary_dom_view</xsl:with-param>
               <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="sec_beneficiary_dom"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="id">event_summary_sec_beneficiary_reference_view</xsl:with-param>
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="sec_beneficiary_reference"/>
               </div></xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
           </xsl:call-template>
          </xsl:when>
          <xsl:when test="sub_tnx_type_code[.='19']">
           <!-- Assignee -->
           <xsl:call-template name="fieldset-wrapper">
            <xsl:with-param name="legend">XSL_HEADER_ASSIGNEE_DETAILS</xsl:with-param>
            <xsl:with-param name="legend-type">indented-header</xsl:with-param>
            <xsl:with-param name="content">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
              <xsl:with-param name="id">event_summary_assignee_name_view</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="assignee_name"/>
              </div></xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
              <xsl:with-param name="id">event_summary_assignee_address_line_1_view</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="assignee_address_line_1"/>
              </div></xsl:with-param>
             </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="id">event_summary_assignee_address_line_2_view</xsl:with-param>
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="assignee_address_line_2"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="id">event_summary_assignee_dom_view</xsl:with-param>
               <xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="assignee_dom"/>
               </div></xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="row-wrapper">
               <xsl:with-param name="id">event_summary_assignee_reference_view</xsl:with-param>
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
              <xsl:with-param name="id">event_lc_amt_view</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="lc_cur_code"/> <xsl:value-of select="lc_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="tnx_amt[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ASG_AMT_LABEL</xsl:with-param>
              <xsl:with-param name="id">event_tnx_amt_view</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="lc_cur_code"/> <xsl:value-of select="tnx_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           </xsl:with-param>
          </xsl:call-template>
          
          <xsl:call-template name="fieldset-wrapper">
           <xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_PARTIESDETAILS_NOTIFY_AMENDMENT</xsl:with-param>
             <xsl:with-param name="id">event_summary_notify_amendment_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:choose>
                <xsl:when test="notify_amendment_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'N034_N')"/></xsl:otherwise>
               </xsl:choose>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_PARTIESDETAILS_SUBSTITUTE_INVOICE</xsl:with-param>
             <xsl:with-param name="id">event_summary_substitute_invoice_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:choose>
                <xsl:when test="substitute_invoice_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'N034_N')"/></xsl:otherwise>
               </xsl:choose>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_PARTIESDETAILS_ADVISE_MODE</xsl:with-param>
             <xsl:with-param name="id">event_summary_advise_mode_view</xsl:with-param>
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
        </xsl:when>
        
        <!-- Invoice Presentation -->
        <xsl:when test="tnx_type_code[.='18']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_PRESENTATION_REF_ID</xsl:with-param>
          <xsl:with-param name="id">event_summary_data_set_id_view</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="data_set_id"/>
          </div></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_DOCUMENT_PRESENTATION_AMOUNT</xsl:with-param>
          <xsl:with-param name="id">event_document_tnx_amt_view</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="tnx_cur_code"/><xsl:value-of select="tnx_amt"/>
          </div></xsl:with-param>
         </xsl:call-template>
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_DOCUMENT_PRESENTATION_FINAL</xsl:with-param>
           <xsl:with-param name="id">event_summary_final_presentation_view</xsl:with-param>
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
        <xsl:with-param name="id">event_summary_po_presentation_view</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:apply-templates select="payments" mode="po_presentation"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <!-- Additional details are provided for an amendment -->
      <xsl:if test="tnx_type_code[.='03']">
         
        <!--Shipment Details-->
        <xsl:if test="ship_from!='' or ship_loading!='' or ship_discharge!='' or ship_to!='' or narrative_shipment_period!='' or last_ship_date!=''">
         <xsl:call-template name="fieldset-wrapper">
          <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
          <xsl:with-param name="legend-type">indented-header</xsl:with-param>
          <xsl:with-param name="content">
          
           <!-- Shipment From, Shipment To, Last Shipment Date -->
           <xsl:if test="ship_from!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_FROM</xsl:with-param>
             <xsl:with-param name="id">event_summary_org_previous_ship_from_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_from"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_FROM</xsl:with-param>
             <xsl:with-param name="id">event_summary_ship_from_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_from"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="ship_loading!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_LOADING</xsl:with-param>
             <xsl:with-param name="id">event_summary_org_previous_ship_loading_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_loading"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING</xsl:with-param>
             <xsl:with-param name="id">event_summary_ship_loading_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_loading"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="ship_discharge!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_DISCHARGE</xsl:with-param>
             <xsl:with-param name="id">event_summary_org_previous_ship_discharge_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_discharge"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE</xsl:with-param>
             <xsl:with-param name="id">event_summary_ship_discharge_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_discharge"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="ship_to!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_SHIP_TO</xsl:with-param>
             <xsl:with-param name="id">event_summary_org_previous_ship_to_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/ship_to"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_SHIP_TO</xsl:with-param>
             <xsl:with-param name="id">event_summary_ship_to_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ship_to"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
           
           <xsl:if test="narrative_shipment_period!='' or last_ship_date!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE</xsl:with-param>
             <xsl:with-param name="id">event_summary_org_previous_last_ship_date_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/last_ship_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_SHIPMENT_PERIOD</xsl:with-param>
             <xsl:with-param name="id">event_summary_org_previous_narrative_shipment_period_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/narrative_shipment_period"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:with-param>
             <xsl:with-param name="id">event_summary_last_ship_date_view</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="last_ship_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_SHIPMENT_PERIOD</xsl:with-param>
             <xsl:with-param name="id">event_summary_narrative_shipment_period_view</xsl:with-param>
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
       <xsl:if test="amd_details[. !='']">
	       <xsl:call-template name="big-textarea-wrapper">
	        <xsl:with-param name="label">XSL_HEADER_AMENDMENT_NARRATIVE</xsl:with-param>
	        <xsl:with-param name="id">event_summary_amd_details_view</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:value-of select="amd_details"/>
	        </div></xsl:with-param>
	       </xsl:call-template>
       </xsl:if>
       
       <!-- Additional Information Provided by the Client for trade Funds transfer-->
      <xsl:if test="sub_product_code[.='TTPT' or .='TINT']">
        <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
       
       <xsl:with-param name="content">     
        <xsl:if test="adv_send_mode[. != ''] and tnx_type_code[.='01' or .='03']">
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
	    
        <xsl:if test="principal_act_no[. != ''] or fee_act_no[. != ''] or (fwd_contract_no[.!=''] and product_code[.='EC'])">
	        <xsl:call-template name="row-wrapper">
	         <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
	         <xsl:with-param name="content"><div class="content">
	           <xsl:value-of select="principal_act_no"/>
	         </div></xsl:with-param>
	        </xsl:call-template>
	        <xsl:if test="fee_act_no[. != '']">
		        <xsl:call-template name="row-wrapper">
		         <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
		         <xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="fee_act_no"/>
		         </div></xsl:with-param>
		        </xsl:call-template>
	        </xsl:if>
	    </xsl:if>
        <xsl:if test="free_format_text[.!='']">
          <xsl:call-template name="big-textarea-wrapper">
           <xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="free_format_text"/>
           </div></xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="attachments-file-dojo">
         <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
         <xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
         <xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
      <!-- Bank Message -->
      <xsl:if test="(tnx_stat_code[.='04'] or security:isBank($rundata)) and (product_code[.!='FB'] and sub_product_code[.!='MEPS' and .!='MUPS' and .!='RTGS' and .!='HVPS' and .!='HVXB' and .!='INT' and .!='TPT' and .!='MT103' and .!='FI103' and .!='FI202' and .!= 'MT101'])">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_BANK_MESSAGE</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_DTTM</xsl:with-param>
           <xsl:with-param name="id">bank_message_bo_release_dttm_view</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="converttools:formatReportDate(bo_release_dttm,$rundata)"/>
           </div></xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
           <xsl:with-param name="id">bank_message_prod_stat_view</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/>
           </div></xsl:with-param>
          </xsl:call-template>

          <!-- Back-Office comment -->
          <xsl:if test="bo_comment[.!='']">
          <xsl:call-template name="big-textarea-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
           <xsl:with-param name="id">bank_message_bo_comment_view</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="bo_comment"/>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
          
          <xsl:if test="sub_product_code[.!='TRTD'] and bo_ref_id[.!='']">
	       <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="id">event_summary_bo_ref_id_view</xsl:with-param>
	        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:value-of select="bo_ref_id"/>
	        </div></xsl:with-param>
	       </xsl:call-template>
      	 </xsl:if>

          <xsl:if test="action_req_code[.!=''] and product_code[.!='FX']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
            <xsl:with-param name="id">bank_message_action_req_view</xsl:with-param>
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
				<xsl:with-param name="id">event_summary_contract_type_view</xsl:with-param>
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
					<xsl:with-param name="id">event_expiration_code_view</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="expiration_code" />
						</div>
					</xsl:with-param>
				</xsl:call-template>
			<xsl:if test="expiration_code[. != '']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_CONTRACT_XO_EXPIRATION_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="id">event_summary_expiration_date_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_expiration_date_term_number_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_counter_cur_code_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_fx_amt_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_value_date_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_value_date_term_number_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_market_order_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_trigger_pos_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_trigger_stop_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_amd_date_view</xsl:with-param>
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
					<xsl:with-param name="id">event_summary_cancel_reason_view</xsl:with-param>
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
		      <xsl:with-param name="label">XSL_TD_START_DATE</xsl:with-param>
		      <xsl:with-param name="id">td_section_value_date_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="value_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		       <!-- maturity date -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TRTD_MATURITY_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_maturity_date_value_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
				<xsl:choose>
							<xsl:when test="value_date_term_number[.!='']"><xsl:value-of select="value_date_term_number"/></xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="maturity_date"/>
							</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="value_date_term_code[.!='']"><xsl:value-of select="concat(' ', localization:getDecode($language, 'N413', value_date_term_code[.]) )"/></xsl:if>
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		          <!-- new amount -->
			 <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_AMOUNTDETAILS_ROLLOVER_AMT_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_td_amt_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="td_amt" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		        <!-- Interest Capitalisation -->
			   <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_INTEREST_CAPITALISATION_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_interest_capitalisation_view</xsl:with-param>
		      <xsl:with-param name="content">
				<div class="content">
		      <xsl:value-of select="interest_capitalisation" />
		      </div>
		      </xsl:with-param>
		      </xsl:call-template>
		      
		           <!-- Remarks -->
			 <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_REMARKS</xsl:with-param>
		      <xsl:with-param name="id">td_section_remarks_view</xsl:with-param>
		      <xsl:with-param name="content">
				<div class="content">
		      		<xsl:value-of select="remarks" />
		      	</div>
		      </xsl:with-param>
		     </xsl:call-template>
		    
		     </xsl:with-param>
		</xsl:call-template>

 		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
		  
		  <!-- Transaction number -->
		  <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_TRADE_ID_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_trade_id_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="trade_id" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		      <!-- maturity date -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_maturity_date_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="maturity_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		     <!-- rate -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_RATE_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_rate_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="rate" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		      <!-- interest -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_INTEREST_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_interest_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="interest" />
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
		    
		    <!-- reversal reason -->
			 <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_CANCEL_REASON_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_reversal_reason_view</xsl:with-param>
		      <xsl:with-param name="content">
				<div class="content">
		      		<xsl:value-of select="reversal_reason" />
		      	</div>
		      </xsl:with-param>
		     </xsl:call-template>
		    <!-- amount -->
			    <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="label">XSL_TD_AMOUNT_LABEL</xsl:with-param>
			      <xsl:with-param name="id">td_section_rebook_td_amt_view</xsl:with-param>
			      <xsl:with-param name="content">
					<div class="content">
			      <xsl:value-of select="normalize-space(concat(td_cur_code, ' ', td_amt))" />
			      </div>
			      </xsl:with-param>
		      	</xsl:call-template>
			     <!-- value date -->
				<xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_VALUE_DATE_LABEL</xsl:with-param>
		       <xsl:with-param name="id">td_section_rebook_value_date_view</xsl:with-param>
		       <xsl:with-param name="content">
						<div class="content">
				<xsl:choose>
							<xsl:when test="value_date_term_number[.!='']"><xsl:value-of select="value_date_term_number"/></xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="value_date"/>
							</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="value_date_term_code[.!='']"><xsl:value-of select="concat(' ', localization:getDecode($language, 'N413', value_date_term_code[.]) )"/></xsl:if>
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     <!-- maturity date -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_rebook_maturity_date_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
				<xsl:choose>
							<xsl:when test="value_date_term_number[.!='']"><xsl:value-of select="value_date_term_number"/></xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="maturity_date"/>
							</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="value_date_term_code[.!='']"><xsl:value-of select="concat(' ', localization:getDecode($language, 'N413', value_date_term_code[.]) )"/></xsl:if>
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>	
		     
		      <!-- Remarks -->
			 <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_REMARKS</xsl:with-param>
		      <xsl:with-param name="id">td_section_rebook_remarks_view</xsl:with-param>
		      <xsl:with-param name="content">
				<div class="content">
		      		<xsl:value-of select="remarks" />
		      	</div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		     	
		    </xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
		  
		  <!-- Transaction number -->
		  <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_TRADE_ID_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_rebook_trade_id_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="trade_id" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		      <!-- maturity date -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_rebook_maturity_date_view_2</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="maturity_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		       <!-- Value date -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_VALUE_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_rebook_value_date_view_2</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="value_date" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     <!-- rate -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_RATE_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_rebook_rate_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="rate" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		     
		      <!-- interest -->
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="label">XSL_TD_INTEREST_LABEL</xsl:with-param>
		      <xsl:with-param name="id">td_section_rebook_interest_view</xsl:with-param>
		      <xsl:with-param name="content">
						<div class="content">
		      <xsl:value-of select="interest" />
		      </div>
		      </xsl:with-param>
		     </xsl:call-template>
		   </xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="td_type[.='REVERSE']">
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_ACTION_REVERSE_DETAILS</xsl:with-param>
		    <xsl:with-param name="id">td_section_reversal_reason_view</xsl:with-param>
		    <xsl:with-param name="content">
			    <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="label">XSL_TD_CANCEL_REASON_LABEL</xsl:with-param>
			      <xsl:with-param name="content">
					<div class="content">
			      <xsl:value-of select="reversal_reason" />
			      </div>
			      </xsl:with-param>
		      	</xsl:call-template>
		       </xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	</xsl:choose>				
    </xsl:if> 
 </div>
 <div id="transaction-amount-details">
 	<xsl:if test="sub_product_code[.= 'DDA']">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="parse-widgets">N</xsl:with-param>
     <xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
     <xsl:with-param name="content">
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_ORIGINAL_LIMIT_AMOUNT</xsl:with-param>
	    <xsl:with-param name="id">dda_section_org_previous_ft_cur_code_view</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="org_previous_file/ft_tnx_record/ft_cur_code"/>&nbsp;<xsl:value-of select="org_previous_file/ft_tnx_record/ft_amt"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	    <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">dda_section_ft_amt_view</xsl:with-param>
        <xsl:with-param name="label">XSL_NEW_LIMIT_AMOUNT</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/>
        </div></xsl:with-param>
       </xsl:call-template>
	</xsl:with-param>
	</xsl:call-template>
	</xsl:if>
	</div> 
	<!-- <div id="transaction-details-remarks">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="parse-widgets">N</xsl:with-param>
     <xsl:with-param name="legend">XSL_HEADER_TRANSACTION_REMARKS</xsl:with-param>
     <xsl:with-param name="content">
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_HEADER_TRANSACTION_REMARKS_DETAILS</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="free_format_text"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	</xsl:with-param>
	</xsl:call-template>
	</div>  -->
	<!-- Return Comments -->
         <xsl:if test="return_comments[.!=''] and $option = 'SUMMARY'">
	         <xsl:if test="product_code[.='TD']">
						<xsl:call-template name="comments-for-return">
							<xsl:with-param name="value">
								<xsl:value-of select="return_comments" />
							</xsl:with-param>
							<xsl:with-param name="mode">
								<xsl:value-of select="$mode" />
							</xsl:with-param>
						</xsl:call-template>
			</xsl:if>
		</xsl:if>
 
 </xsl:template>
 
 <!-- TD Common Fields -->
  <xsl:template name="td-common-general-fields">
  <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
          <xsl:with-param name="id">td_common_gen_ref_id_view</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="ref_id"/>
          </div></xsl:with-param>
         </xsl:call-template>
         <!--Entity -->
          <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
          <xsl:with-param name="id">td_common_gen_entity_view</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="entity"/>
          </div></xsl:with-param>
         </xsl:call-template>
        <!-- Issuing Bank Name -->
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
        <xsl:with-param name="id">td_common_gen_issuing_bank_name_view</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="issuing_bank/name"/>
          </div></xsl:with-param>
       </xsl:call-template>
       <!-- Issuing Bank Reference -->
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
        <xsl:with-param name="id">td_common_gen_applicant_reference_view</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="applicant_reference"/>
          </div></xsl:with-param>
       </xsl:call-template>
   </xsl:template>
   <xsl:template name="td-common-fields">
    <!-- FD Account Number -->
       <xsl:call-template name="row-wrapper">
	     <xsl:with-param name="label">XSL_TD_TERM_DEPOSIT_ACCOUNT</xsl:with-param>
	     <xsl:with-param name="id">td_common_placement_act_name_view</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="placement_act_name"/>
          </div></xsl:with-param>
	   </xsl:call-template>
	   <!-- Tenor -->
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
	    <xsl:with-param name="id">td_common_value_date_term_number_view</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	        <xsl:value-of select="value_date_term_number"/>
	    	<!--<xsl:choose>
	    	<xsl:when test="value_date_term_code[.='01']">1 Month</xsl:when>
	    	<xsl:when test="value_date_term_code[.='02']">2 Month</xsl:when>
	    	</xsl:choose>
          --></div></xsl:with-param>
	  </xsl:call-template>
	  <!-- interest P.A -->
	  <xsl:if test="interest and interest[.!='']">
		  <xsl:call-template name="row-wrapper">
		     <xsl:with-param name="label">XSL_TD_INTEREST_RATE_PA</xsl:with-param>
		     <xsl:with-param name="id">td_common_interest_view</xsl:with-param>
		     <xsl:with-param name="content"><div class="content">
	           <xsl:value-of select="interest"/> %
	          </div></xsl:with-param>
		   </xsl:call-template>  
	   </xsl:if> 
	   <!-- Maturity Date -->
	    <xsl:call-template name="row-wrapper">
			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
			<xsl:with-param name="id">td_common_maturity_date_view</xsl:with-param>
			<xsl:with-param name="content"><div class="content">
           <xsl:value-of select="maturity_date"/>
          </div></xsl:with-param>
		</xsl:call-template>
		<!-- Outstanding Amount -->
	   <xsl:if test="td_liab_amt and td_liab_amt[.!='']">	
		   <xsl:call-template name="row-wrapper">
		    <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
		    <xsl:with-param name="id">td_common_td_liab_amt_view</xsl:with-param>
		    <xsl:with-param name="content"><div class="content">
	           <xsl:value-of select="td_cur_code"/>  <xsl:value-of select="td_liab_amt"/>
	          </div></xsl:with-param>
		   </xsl:call-template>
	   </xsl:if>
   </xsl:template>
   <xsl:template name="td-withdrwal-fields">
     <!-- interest P.A -->
    <xsl:if test="interest and interest[.!='']">
	  <xsl:call-template name="row-wrapper">
	     <xsl:with-param name="label">XSL_TD_INTEREST_RATE_PA</xsl:with-param>
	     <xsl:with-param name="id">td_withdrawal_interest_view</xsl:with-param>
	     <xsl:with-param name="content"><div class="content">
	          <xsl:value-of select="interest"/> %
	         </div></xsl:with-param>
	   </xsl:call-template>
	</xsl:if>      
	<xsl:if test="tnx_type_code[.='13']">
			 <xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_ACCURED_INTEREST</xsl:with-param>
				<xsl:with-param name="id">td_withdrawal_accured_interest_view</xsl:with-param>
				<xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="accured_interest"/>
		           </div></xsl:with-param>
			 </xsl:call-template>
			 <xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_PREMATURE_WITHDRAWAL_PENALTY</xsl:with-param>
				<xsl:with-param name="id">td_withdrawal_premature_withdrawal_penalty_view</xsl:with-param>
				<xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="premature_withdrawal_penalty"/>
		           </div></xsl:with-param>
			 </xsl:call-template>
			 <xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_WITHHOLDING_TAX</xsl:with-param>
				<xsl:with-param name="id">td_withdrawal_withholding_tax_view</xsl:with-param>
				<xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="withholding_tax"/>
		           </div></xsl:with-param>
			 </xsl:call-template>
			 <xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_HOLD_MAIL_CHARGES</xsl:with-param>
				<xsl:with-param name="id">td_withdrawal_interest_view</xsl:with-param>
				<xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="hold_mail_charges"/>
		           </div></xsl:with-param>
			 </xsl:call-template>
			 <xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_ANNUAL_POSTAGE_FEE</xsl:with-param>
				<xsl:with-param name="id">td_withdrawal_annual_postage_fee_view</xsl:with-param>
				<xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="annual_postage_fee"/>
		           </div></xsl:with-param>
			 </xsl:call-template>
			 <xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_WITHDRAWABLE_INTEREST</xsl:with-param>
				<xsl:with-param name="id">td_withdrawable_interest_view</xsl:with-param>
				<xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="withdrawable_interest"/>
		           </div></xsl:with-param>
			 </xsl:call-template>
			 <xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_NET_SETTLEMENT_AMOUNT</xsl:with-param>
				<xsl:with-param name="id">td_withdrawal_net_settlement_amount_view</xsl:with-param>
				<xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="net_settlement_amount"/>
		           </div></xsl:with-param>
			 </xsl:call-template>
	   </xsl:if>
   </xsl:template>    
</xsl:stylesheet>