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
 xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
 exclude-result-prefixes="localization converttools xmlRender defaultresource security utils">
 
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
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
   
  <xsl:include href="trade_common.xsl"/>
  <xsl:include href="amend_common.xsl"/>
  <xsl:include href="com_cross_references.xsl"/>
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
	<xsl:param name="section_line_item_routing_summary"/>
	<xsl:param name="section_shipment_sub_schedule"/>
	<xsl:param name="isMultiBank">N</xsl:param>
	<xsl:param name="optionCode">OTHERS</xsl:param>
		
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
   
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
	
  <!--TEMPLATE Main-->
  <xsl:template match="lc_tnx_record | ri_tnx_record | li_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | ft_tnx_record | br_tnx_record | ln_tnx_record | sw_tnx_record | td_tnx_record | fx_tnx_record | xo_tnx_record | eo_tnx_record | sw_tnx_record | ts_tnx_record | cs_tnx_record | cx_tnx_record | ct_tnx_record | st_tnx_record | se_tnx_record | la_tnx_record | to_tnx_record | sp_tnx_record | fa_tnx_record | bk_tnx_record | po_tnx_record | so_tnx_record | io_tnx_record | tu_tnx_record | ls_tnx_record | ea_tnx_record">
   <div id="event-summary" class="widgetContainer">
   
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="parse-widgets">N</xsl:with-param>
     <xsl:with-param name="legend"><xsl:choose>
      <xsl:when test="product_code[.='SE'] and sub_product_code[.='SEEML']">XSL_HEADER_GENERAL_DETAILS</xsl:when>
      <xsl:otherwise>XSL_HEADER_EVENT_DETAILS</xsl:otherwise>
     </xsl:choose></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:if test="release_dttm[.!='']">
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RELEASE_DTTM</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata)"/>
	    </div></xsl:with-param>
	   </xsl:call-template>
	  </xsl:if>
	  
	  <xsl:variable name="ref_id_for_company_name"><xsl:value-of select="ref_id"/></xsl:variable>
	  <xsl:variable name="product_code"><xsl:value-of select="product_code"/></xsl:variable>
	  <xsl:if test="company_name[.!='']">
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_COMPANY_NAME</xsl:with-param>
	     <xsl:with-param name="content">
             <xsl:choose>
      			<xsl:when test="product_code[.='BK'] and sub_product_code[.='MPRTG']">
			      	<div class="content">
			      		<xsl:value-of select="utils:getCompanyName($ref_id_for_company_name,$product_code)"/>
			      	</div>
			    </xsl:when>
				<xsl:otherwise>
					<div class="content">
						<xsl:value-of select="utils:getCompanyName($ref_id_for_company_name,$product_code)"/>
					</div>
				</xsl:otherwise>
       		</xsl:choose>
	     </xsl:with-param>
	   </xsl:call-template>
	  </xsl:if>
	  
      <xsl:if test="product_code[.!='']">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
       
             <xsl:choose>
      			<xsl:when test="product_code[.='BK'] and sub_product_code[.!=''] and sub_product_code[.='LNRPN']">
      			<xsl:value-of select="localization:getDecode($language, 'N001', 'LN')"/></xsl:when>
       			<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/></xsl:otherwise>
       		</xsl:choose>
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
       <xsl:with-param name="label">
      		<xsl:choose>
      			<xsl:when test="product_code[.='SO']">XSL_PURCHASE_ORDER_STATUS</xsl:when>
       			<xsl:otherwise>XSL_TRANSACTIONDETAILS_PRODUCT_TYPE</xsl:otherwise>
       		</xsl:choose>
       	</xsl:with-param>
       <xsl:with-param name="content">
		<div class="content">
			<xsl:choose>
			<xsl:when test="product_code[.='LN']">
				<!-- Perform product specific exercises -->
				 <xsl:choose>
				 	<xsl:when test="tnx_type_code[.='03']">
				 		<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE_INCREASE')"/>
				 	</xsl:when>
				 	<xsl:when test="tnx_type_code[.='13']">
				 		<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE_PAYMENT')"/>
				 	</xsl:when>
				 	<xsl:otherwise>
				 		<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])" />
				 		<xsl:if test="tnx_type_code[.='86'] or tnx_type_code[.='87']">
					 		<xsl:value-of select="concat(' [',localization:getGTPString($language, 'XSL_OLD_NAME'),old_name,',',localization:getGTPString($language, 'XSL_NEW_NAME'),new_name,']')" />
				 		</xsl:if>
				 	</xsl:otherwise>
				 </xsl:choose>
				<xsl:if test="sub_tnx_type_code and sub_tnx_type_code[.!='']">
					<xsl:value-of select="concat(' (',localization:getDecode($language, 'N003', sub_tnx_type_code[.]),')')" />
				</xsl:if>
			</xsl:when>
			<xsl:when test="product_code[.='LC']">
				<!-- Perform product specific exercises -->
				<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])" />
				<xsl:if test="sub_tnx_type_code and sub_tnx_type_code[.!='']">
					<xsl:value-of select="concat(' ',localization:getDecode($language, 'N003', sub_tnx_type_code[.]))" />
				</xsl:if>
				<xsl:if test="tnx_type_code[.='13'] and lc_message_type_clean and lc_message_type_clean[.='BillArrivalClean']">
			 		&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_ADVISE_OF_BILL_ARRV_CLEAN')" />
			 	</xsl:if>
			</xsl:when>
			<xsl:when test="product_code[.='SO']">
				<!-- Perform product specific exercises -->
				<xsl:if test="prod_stat_code and prod_stat_code[.='55']">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/>		
				</xsl:if>
				<xsl:if test="prod_stat_code and prod_stat_code[.='01']">
					        <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_PURCHASE_ORDER_REJECTED')"/>
				</xsl:if>
			</xsl:when>		
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])" />
				<xsl:if test="sub_tnx_type_code and sub_tnx_type_code[.!='']">
					<xsl:value-of select="concat(' ',localization:getDecode($language, 'N003', sub_tnx_type_code[.]))" />
				</xsl:if>
			</xsl:otherwise>
			</xsl:choose>
		</div>
       </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRESENTING_BANK</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="presenting_bank/name"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="product_code[.='EC']">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_REMITTING_BANK</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="remitting_bank/name"/>
       </div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_GENERALDETAILS_RELATED_REFERENCE</xsl:with-param>
       <xsl:with-param name="content"><div class="content">
         <xsl:value-of select="link_ref_id"/>
       </div></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="product_code[.='BK']">XSL_GENERALDETAILS_BULK_REF_ID</xsl:when>
				<xsl:otherwise>XSL_GENERALDETAILS_CUST_REF_ID</xsl:otherwise>
			</xsl:choose>
        </xsl:with-param>
       	<xsl:with-param name="content">
	       <div class="content" style="white-space:pre;">
	       	 <xsl:value-of select="cust_ref_id"/>
	       </div>
	       </xsl:with-param>
      </xsl:call-template>
     <xsl:if test="(((bo_ref_id[.!=''] and tnx_type_code[.='01'] and tnx_stat_code[.='04'] and (product_code[.!='FT'] and (sub_product_code[.!='TRINT'] or sub_product_code[.!='TRTPT']))) or (bo_ref_id[.!=''] and tnx_type_code[.!='01']) or preallocated_flag[.='Y']) and product_code[.!='FX'] and (product_code[.!='TD'] and sub_product_code[.!='TRTD'] and product_code[.='FT'] and sub_product_code[.!='TRINT'] and sub_product_code[.='TRTPT']) )">
 		 <xsl:call-template name="row-wrapper">
        	<xsl:with-param name="label">
				<xsl:choose>
					<xsl:when test="product_code[.='LN']">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:when>
				<xsl:otherwise>XSL_GENERALDETAILS_BO_REF_ID</xsl:otherwise>
			</xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="content"><div class="content" style="white-space:pre;">
          <xsl:value-of select="bo_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="iss_date[.!=''] and product_code[.='EL'] and sub_tnx_type_code[.='19' or .='12']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	          <xsl:with-param name="content"><div class="content">
	            <xsl:value-of select="iss_date"/>
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
       <xsl:if test="bo_tnx_id[.!='']">
 	      <xsl:call-template name="row-wrapper">
 	 	  <xsl:with-param name="label">XSL_GENERALDETAILS_BO_EVENT_REFERENCE</xsl:with-param>
 	 	  <xsl:with-param name="content"><div class="content">
 	       <xsl:value-of select="bo_tnx_id"/>
 	     </div></xsl:with-param>
 	    </xsl:call-template>
 	  </xsl:if>
 	  
 	  <xsl:if test="prod_stat_code[.='31' or .='08' or .='32' or .='82' or .='81' or .='06'] and related_ref_id[.!= '']">
 	  	<xsl:choose>
 	  		<xsl:when test="product_code[.='LC']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">related_ref_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="related_ref_id" />
 	  			</xsl:call-template>
 		  </xsl:when>
 		  
 		  <xsl:when test="product_code[.='SI']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">related_ref_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="related_ref_id" />
 	  			</xsl:call-template>
 		  </xsl:when>
 	  	</xsl:choose>
 	  </xsl:if>
 	  
 	   <!-- MPS-41196 - Related Event reference for Amendment and Cancel Event  -->
 	   <xsl:if test="prod_stat_code[.='08' or .='06' or .='32'] and tnx_type_code[.='03' or .='15'] and cross_references">
 	   <xsl:choose>
		  <xsl:when test="product_code[.='LC'] and related_ref_id[.= '']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">bo_tnx_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/bo_tnx_id" />
 	  			</xsl:call-template>
 		  </xsl:when>
 	  
		  <xsl:when test="product_code[.='EL']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">bo_tnx_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="org_previous_file/el_tnx_record/bo_tnx_id" />
 	  			</xsl:call-template>
 		  </xsl:when>

		  <xsl:when test="product_code[.='BG']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">bo_tnx_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="org_previous_file/bg_tnx_record/bo_tnx_id" />
 	  			</xsl:call-template>
 	  	 </xsl:when>
 	  	 
		  <xsl:when test="product_code[.='BR']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">bo_tnx_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="org_previous_file/br_tnx_record/bo_tnx_id" />
 	  			</xsl:call-template>
 	  	 </xsl:when>

		  <xsl:when test="product_code[.='SI'] and related_ref_id[.= '']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">bo_tnx_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="org_previous_file/si_tnx_record/bo_tnx_id" />
 	  			</xsl:call-template>
 	  	 </xsl:when>
 
		  <xsl:when test="product_code[.='SR']">
 	  			<xsl:call-template name="input-field">
	      		   <xsl:with-param name="label">RELATED_EVENT_REFERENCE</xsl:with-param>
	     		   <xsl:with-param name="id">bo_tnx_id</xsl:with-param>
	      		   <xsl:with-param name="value" select="org_previous_file/sr_tnx_record/bo_tnx_id" />
 	  			</xsl:call-template>
 	  	 </xsl:when>
 	  </xsl:choose>
 	  </xsl:if>
	<xsl:if test="product_code[.='BG'] and prod_stat_code[.='86']">
	        <xsl:if test="extend_pay_date!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_EXTEND_PAY_DATE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="extend_pay_date"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	       <xsl:if test="latest_date_reply!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_LATEST_DATE_REPLY_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="latest_date_reply"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      </xsl:if> 	  
 	  
 	  
      <xsl:if test="sub_tnx_type_code[.='25' or .='62' or .='63'] or prod_stat_code[.='84' or .='87' or .='88']"> 
     	  <xsl:if test="product_code[.='BG' or .='SI' or .='LC'] and tnx_type_code[.='13']">
		      <xsl:if test="claim_reference!=''">
		          <xsl:call-template name="input-field">
		           <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
		           <xsl:with-param name="value"><xsl:value-of select="claim_reference"/>
		           </xsl:with-param>
		          </xsl:call-template>
		      </xsl:if>
		      <xsl:if test="claim_present_date!=''">
		          <xsl:call-template name="input-field">
		           <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
		           <xsl:with-param name="value"><xsl:value-of select="claim_present_date"/>
		           </xsl:with-param>
		          </xsl:call-template>
		      </xsl:if>
		      <xsl:if test="claim_amt!=''">
		          <xsl:call-template name="input-field">
		           <xsl:with-param name="label">XSL_CLAIM_AMOUNT_LABEL</xsl:with-param>
		           <xsl:with-param name="value"><xsl:value-of select="claim_cur_code"/>&nbsp;<xsl:value-of select="claim_amt"/>
		           </xsl:with-param>
		          </xsl:call-template>
		      </xsl:if>
	      </xsl:if>
	      <xsl:choose>
		      <xsl:when test="product_code[.='LS']">
		      	  <xsl:if test="ls_settlement_amt[.!='']">
			      	  <xsl:call-template name="row-wrapper">
				         <xsl:with-param name="label">XSL_AMOUNTDETAILS_LS_SETTLEMENT_AMT_LABEL</xsl:with-param>
				         <xsl:with-param name="content">
					         <div class="content">
					           <xsl:value-of select="ls_cur_code"/>&nbsp;<xsl:value-of select="ls_settlement_amt"/>
					         </div>
				         </xsl:with-param>
				      </xsl:call-template>
			      </xsl:if>
			      <xsl:if test="add_settlement_amt[.!='']">
				      <xsl:call-template name="row-wrapper">
				         <xsl:with-param name="label">XSL_AMOUNTDETAILS_ADD_SETTLEMENT_AMT_LABEL</xsl:with-param>
				         <xsl:with-param name="content">
					         <div class="content">
					           <xsl:value-of select="ls_cur_code"/>&nbsp;<xsl:value-of select="add_settlement_amt"/>
					         </div>
				         </xsl:with-param>
				      </xsl:call-template>
			      </xsl:if>
			      <xsl:if test="tnx_amt[.!='']">
				      <xsl:call-template name="row-wrapper">
				         <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOTAL_SETTLEMENT_AMT_LABEL</xsl:with-param>
				         <xsl:with-param name="content">
					         <div class="content">
					           <xsl:value-of select="ls_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
					         </div>
				         </xsl:with-param>
				      </xsl:call-template>
			      </xsl:if>
		      </xsl:when>
		      <xsl:otherwise>
		       <xsl:if test="tnx_amt[.!='']">
			      <xsl:call-template name="row-wrapper">
			         <xsl:with-param name="label">XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL</xsl:with-param>
			         <xsl:with-param name="content">
				         <div class="content">
				           <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
				         </div>
			         </xsl:with-param>
			      </xsl:call-template>
			      </xsl:if>
		      </xsl:otherwise>
	      </xsl:choose>
	  </xsl:if> 
	  <xsl:if test="tnx_type_code[.='24']">
      <xsl:if test="exp_date[.!='']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="exp_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
      </xsl:if>
	 <xsl:if test="tnx_cur_code[.!=''] and tnx_amt[.!='']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">
           <xsl:choose>
            <xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR']">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='EC' or .='IC' or .='IR']">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='SG' or .='BG' or .='BR']">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='LI']">XSL_AMOUNTDETAILS_LI_AMT_LABEL</xsl:when>
           </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="content">
          <div class="content">
           <xsl:choose>
	          <xsl:when test="product_code[.='LC'] or product_code[.='SI'] or product_code[.='EL'] or product_code[.='SR']">
	          		<xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="lc_amt"/>
	          </xsl:when>
	           <xsl:when test="product_code[.='BG'] or product_code[.='BR']">
	          		 <xsl:value-of select="bg_cur_code"/>&nbsp;<xsl:value-of select="bg_amt"/>
	           </xsl:when>
	           <xsl:otherwise>
		          <xsl:variable name="cur_code_name"> <xsl:value-of select="product_code"/>_cur_code  </xsl:variable>
		          <xsl:variable name="amt_name"> <xsl:value-of select="product_code"/>_amt  </xsl:variable>
		          <xsl:value-of select="$cur_code_name"/>&nbsp;<xsl:value-of select="$amt_name"/>
	           </xsl:otherwise>
           </xsl:choose>
         </div>
         </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </xsl:if> 
<xsl:if test="product_code[.='SE']">
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
   
   <!--  System ID. -->
   <xsl:if test="$displaymode='edit'">
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
	    <xsl:with-param name="value" select="ref_id" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   
   
   <xsl:if test="$displaymode='view'">
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_SECURE_EMIAIL_REQUEST_TYPE</xsl:with-param>
	    <xsl:with-param name="value" select="topic_description" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>

   <!-- Entity -->
 <!--   <xsl:if test="entities[number(.) &gt; 0]"> -->
	<xsl:call-template name="entity-field">
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="button-type">entity</xsl:with-param>
     <xsl:with-param name="prefix">applicant</xsl:with-param>
    </xsl:call-template>	
   <!-- </xsl:if>	 -->   
	<xsl:call-template name="select-field">
      	<xsl:with-param name="label">XSL_SE_TOPIC</xsl:with-param>
      	<xsl:with-param name="name">topic</xsl:with-param>
      	<xsl:with-param name="required">Y</xsl:with-param>
      	<xsl:with-param name="fieldsize">x-medium</xsl:with-param>
      	<xsl:with-param name="options">			       		
			<xsl:choose>
				<xsl:when test="$displaymode='edit'">
				<xsl:for-each select="contact_helpdesk/contact_helpdesk">
				    <option>
				    <xsl:attribute name="value"><xsl:value-of select="topic_id"></xsl:value-of></xsl:attribute>
				    <xsl:value-of select="topic_description"/></option>
				</xsl:for-each>
			   </xsl:when>
			</xsl:choose>
     	</xsl:with-param>
   	</xsl:call-template>
</xsl:if>

	  <!-- Provisional flow for finance request event details : START -->
	  <xsl:if test="product_code[.='TF'] and tnx_type_code[.='13'] and sub_tnx_type_code[.='66' or .='67']">
		    <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_DAYS</xsl:with-param>
			    <xsl:with-param name="name">tenor_view</xsl:with-param>
			    <xsl:with-param name="value" select="tenor" />
		        <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    </xsl:call-template>
	        <xsl:call-template name="input-field">
		        <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
		        <xsl:with-param name="id">general_details_maturity_date_view</xsl:with-param>
		        <xsl:with-param name="value" select="maturity_date" />
		        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	        </xsl:call-template>
		    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_AMOUNTDETAILS_FIN_AMT_LABEL</xsl:with-param>
			     <xsl:with-param name="name">fin_amt_view</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_amt"/></xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_PCT</xsl:with-param>
			     <xsl:with-param name="name">req_pct</xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			     <xsl:with-param name="type">percentnumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
		      	<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMT</xsl:with-param>
		      	<xsl:with-param name="product-code">req</xsl:with-param>
		      	<xsl:with-param name="override-currency-value">
		   			<xsl:value-of select="fin_cur_code"/>
				</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
		    </xsl:call-template>
	    </xsl:if>
	    <!-- Provisional flow for finance request event details : END -->
      <!-- Show cross references -->
      <!-- When product code is bulk,pass cross reference summary option used 
           to display popup which includes bulk file upload details,only in case of 
           bulk intiated from upload-->
      <xsl:choose>
        <xsl:when test="product_code[.='BK'] and bulk_intiation_type[.='U'] and tnx_id[.!='']">
        	<xsl:apply-templates select="cross_references" mode="display_table_tnx">
        	 	<xsl:with-param name="cross-ref-summary-option">FILE_DETAILS</xsl:with-param>
        	</xsl:apply-templates>
        </xsl:when>
        <xsl:when test="product_code[.='LI' or .='LC' or .='SI' or .='SG' or .='TF']">
        	<xsl:apply-templates select="cross_references" mode="display_table_master"/>
        </xsl:when>
        <xsl:when test="product_code[.='IO'] and cross_references and (cross_references/cross_reference/product_code != cross_references/cross_reference/child_product_code)">
        	<xsl:apply-templates select="cross_references" mode="display_table_master"/>
        </xsl:when>
        <xsl:otherwise>
        	<xsl:if test="cross_references/cross_reference/type_code[.!='09']">
        		<xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
        	</xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="product_code[.='SR'] and issuing_bank/name[.!='']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="issuing_bank/name"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="product_code[.='EL' or .='SR']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="lc_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <!-- Remittance Letter Details -->
      <xsl:if test="product_code[.='EL'] and sub_tnx_type_code[.='87']">
      <xsl:if test="tnx_amt[.!='']">
	      <xsl:call-template name="row-wrapper">
	         <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_AMOUNT</xsl:with-param>
	         <xsl:with-param name="content">
		         <div class="content">
		           <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
		         </div>
	         </xsl:with-param>
	      </xsl:call-template>
      </xsl:if><br/>
      
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="prefix">applicant</xsl:with-param>
         <xsl:with-param name="override-displaymode">view</xsl:with-param>
         <xsl:with-param name="show-entity-button">N</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
			      
       <xsl:call-template name="attachments-documents">
      	<xsl:with-param name="product_code">EL</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
	    <xsl:with-param name="content">
		      <xsl:call-template name="big-textarea-wrapper">
		      <xsl:with-param name="content"><div class="content">
		        <xsl:value-of select="narrative_additional_instructions"/>
		      </div></xsl:with-param>
		     </xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
     
     <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
	    <xsl:with-param name="content">
		     <xsl:call-template name="big-textarea-wrapper">
		      <xsl:with-param name="content"><div class="content">
		        <xsl:value-of select="narrative_payment_instructions"/>
		      </div></xsl:with-param>
		     </xsl:call-template>
		</xsl:with-param>
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
       <xsl:if test="product_code[.='PO' or .='IO']">
       <xsl:call-template name="row-wrapper">
       	<xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
      	<xsl:with-param name="content"><div class="content">
        <xsl:value-of select="issuer_ref_id"/>
      	</div></xsl:with-param>
       </xsl:call-template>
       </xsl:if>
       <xsl:if test="product_code[.='IO'] and tnx_type_code[.='03']">
        <xsl:call-template name="row-wrapper">
       	<xsl:with-param name="label">XSL_LABEL_TMA_REF</xsl:with-param>
      	<xsl:with-param name="content"><div class="content">
        <xsl:value-of select="tid"/>
      	</div></xsl:with-param>
      </xsl:call-template>
      </xsl:if>
     
      <xsl:if test="product_code[.='LI']">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="label">XSL_GENERALDETAILS_RELATED_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="deal_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
           
      <xsl:if test="product_code[.='BK'] and not(tnx_type_code[. = '01'])">
      <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="issuing_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
       </xsl:if>
      <!--
       Select amongst the different tnx types 
       -->
      <xsl:choose>
       <!-- NEW -->
       <xsl:when test="tnx_type_code[. = '01']"> 
        <xsl:choose>
         <xsl:when test="product_code[.='LC' or .='SG' or .='LI' or .='TF' or .='SI' or .='FT' or .='PO' or .='IN' or .='LN' or .='SW' or .='IR' or .='LS']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">
	           <xsl:choose>
	            <xsl:when test="$isMultiBank='Y'">CUSTOMER_BANK_LABEL</xsl:when>
	            <xsl:otherwise>XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:otherwise> 
	           </xsl:choose>
           </xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="issuing_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="product_code[.='EL' or .='SR' or .='SO' or .='BR']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ADVISING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="advising_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="product_code[.='LC' or .='SG' or .='LI' or .='TF' or .='SI' or .='FT' or .='PO' or .='IN' or .='LN' or .='SW' or .='IR' or 'LS' or .='BK']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="issuing_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="product_code[.='EC' or .='IR']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_REMITTING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="remitting_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="product_code[.='IC']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRESENTING_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="presenting_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="product_code[.='BG']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RECIPIENT_BANK</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="recipient_bank/name"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
        </xsl:choose>
        <xsl:if test="tnx_stat_code[.='04']">
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">
           <xsl:choose>
            <xsl:when test="product_code[.='FT']">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:when>
            <xsl:otherwise>XSL_GENERALDETAILS_ISSUE_DATE</xsl:otherwise> 
           </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="iss_date"/>
          </div></xsl:with-param>
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
          <xsl:if test="appl_date[.!='']">
         	<xsl:call-template name="row-wrapper">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		     <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="appl_date"/>
            </div></xsl:with-param>
		    </xsl:call-template>  
		    </xsl:if> 
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
          <!-- Removed application from event details as application date is available under transaction details as part of MPS-41778  -->
          <xsl:if test="appl_date[.!=''] and (product_code !='IC' or (security:isCustomer($rundata)))">
         	<xsl:call-template name="row-wrapper">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		     <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="appl_date"/>
            </div></xsl:with-param>
		    </xsl:call-template>  
		    </xsl:if>  
         </xsl:when>
         <xsl:when test="product_code ='LS'">
         	<xsl:if test="appl_date[.!='']">
         	<xsl:call-template name="row-wrapper">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		     <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="appl_date"/>
            </div></xsl:with-param>
		    </xsl:call-template>  
		    </xsl:if>  
         	<xsl:if test="ls_number[.!='']">
            <xsl:call-template name="input-field">
      	     <xsl:with-param name="label">XSL_LICENSE_NUMBER</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="ls_number"/></xsl:with-param>
            </xsl:call-template>
           </xsl:if>
         </xsl:when>
         <xsl:otherwise>
			<xsl:call-template name="row-wrapper">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		     <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="appl_date"/>
            </div></xsl:with-param>
		   </xsl:call-template>
		   <xsl:if test="product_code[.='SI'] or product_code[.='SR']">
			<xsl:if test="$displaymode = 'view'">
				<xsl:if test="lc_exp_date_type_code[.!='']">
					<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">
						<xsl:choose>
				        	<xsl:when test="product_code[.='SI']">C085</xsl:when>
				        	<xsl:when test="product_code[.='SR']">C088</xsl:when>
				        </xsl:choose>
					</xsl:variable>
					<xsl:call-template name="input-field">	
					 	<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
					 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
					 </xsl:call-template>
				</xsl:if>
			</xsl:if>
		  </xsl:if>         	
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="exp_date"/>
            </div></xsl:with-param>
           </xsl:call-template>
          <xsl:if test="(product_code[.='SI'] or product_code[.='SR']) and $displaymode = 'view'">
           <xsl:if test="exp_event[.!='']">
			<xsl:call-template name="big-textarea-wrapper-narrative">
	        	<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
        		<xsl:with-param name="content">		
						<xsl:value-of select="exp_event" />
				</xsl:with-param>
	    	</xsl:call-template>
	      </xsl:if>
	    </xsl:if>
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="expiry_place"/>
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
            <xsl:when test="product_code[.='LI']">XSL_AMOUNTDETAILS_LI_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='PO' or .='SO' or .='IO' or .='EA']">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='IN']">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='LN']">XSL_LOAN_AMOUNT</xsl:when>
            <xsl:when test="product_code[.='SW']">XSL_AMOUNTDETAILS_SW_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='EO']">XSL_EQUITYOPTIONDETAILS_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='FA']">XSL_AMOUNTDETAILS_FA_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='BK'] and sub_product_code[.='IPBR']">XSL_BK_TOTAL_REPAYMENT_AMT</xsl:when>
            <xsl:when test="product_code[.='BK']">XSL_AMOUNTDETAILS_BK_AMT_LABEL</xsl:when>
            <xsl:when test="product_code[.='LS']">XSL_LICENSE_TOTAL_AMT</xsl:when>
           </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
          </div></xsl:with-param>
         </xsl:call-template>
        </xsl:if>
       </xsl:when>
       <xsl:when test="product_code[.='BG']  and sub_tnx_type_code[.='24']" >
         <xsl:call-template name="row-wrapper">
         	<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
            <xsl:with-param name="content">
            <div class="content" style="white-space:pre;">
            	<xsl:value-of select="iss_date"/>
            </div>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
       <!-- AMEND -->
       <xsl:when test="tnx_type_code[.='03']">
       <xsl:if test="((security:isCustomer($rundata) and tnx_stat_code[.='04']) or security:isBank($rundata))">    	
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="utils:formatAmdNo(amd_no)"/>
          </div></xsl:with-param>
         </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="product_code[.='LN']">XSL_GENERALDETAILS_LOAN_AMD_DATE</xsl:when>
				<xsl:when test="$swift2018Enabled and product_code[.='LC']">XSL_GENERALDETAILS_AMD_CAN_DATE</xsl:when>
				<xsl:otherwise>XSL_GENERALDETAILS_AMD_DATE</xsl:otherwise>
			</xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="amd_date"/>
          </div></xsl:with-param>
         </xsl:call-template>
         <!-- Additional Information Provided by the Client for amendment -->
       <xsl:if test="product_code[.!='LN'] and amd_details[.!='']">
	      <xsl:call-template name="big-textarea-wrapper">
	        <xsl:with-param name="label">XSL_AMENDMENT_NARRATIVE_LABEL</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:value-of select="amd_details"/>
	        </div></xsl:with-param>
	      </xsl:call-template>
       </xsl:if>
       
       <!-- Expiry Type Code -->
       <xsl:choose>
         <xsl:when test="product_code[.='SI'] and org_previous_file/si_tnx_record/lc_exp_date_type_code!=lc_exp_date_type_code">
       		<xsl:if test="lc_exp_date_type_code[.!='']">
				<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C085</xsl:variable>
				<xsl:call-template name="input-field">
				 	<xsl:with-param name="label">GENERALDETAILS_NEW_EXPIRY_TYPE</xsl:with-param>
				 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
				 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
				 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
				 </xsl:call-template>
			</xsl:if>
		  </xsl:when>
        </xsl:choose>       
        <xsl:choose>
         <xsl:when test="product_code[.='BG']">
         <xsl:choose>
         <xsl:when test ="not(org_previous_file/bg_tnx_record/exp_date=exp_date and org_previous_file/bg_tnx_record/exp_date_type_code=exp_date_type_code)">
          <xsl:call-template name="row-wrapper">
		        <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
		           <xsl:with-param name="content"><div class="content">
				       <xsl:choose>
				        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '02']">
				          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/>
				        </xsl:when>
				        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '03']">
				          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/>
				        </xsl:when>
				         <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '01']">
				          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/>
				        </xsl:when>
				       </xsl:choose>
				       (<xsl:value-of select="org_previous_file/bg_tnx_record/exp_date"/>)
			     </div> </xsl:with-param>
	        </xsl:call-template>
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
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_03_PROJECTED')"/>
			  </xsl:when>
			 </xsl:choose>
             <xsl:if test="exp_date[.!=''] and exp_date_type_code[.!= '01'] ">
	          (<xsl:value-of select="exp_date"/>)
		     </xsl:if>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:when>
          <xsl:when test ="org_previous_file/bg_tnx_record/exp_date=exp_date and org_previous_file/bg_tnx_record/exp_date_type_code=exp_date_type_code">
          	<xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:choose>
			  <xsl:when test="exp_date_type_code[.='01']">
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_01_NO_DATE')"/>
			  </xsl:when>
			  <xsl:when test="exp_date_type_code[.='02']">
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_02_FIXED')"/>
			  </xsl:when>
			  <xsl:when test="exp_date_type_code[.='03']">
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_03_PROJECTED')"/>
			  </xsl:when>
			 </xsl:choose>
             <xsl:if test="exp_date[.!=''] and exp_date_type_code[.!= '01'] ">
	          (<xsl:value-of select="exp_date"/>)
		     </xsl:if>
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:when>
          </xsl:choose>
         </xsl:when>
         <xsl:when test="(product_code[.='LC'] and org_previous_file/lc_tnx_record/exp_date!=exp_date) or (product_code[.='SI'] and org_previous_file/si_tnx_record/exp_date!=exp_date)">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="exp_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
        </xsl:choose>
          <xsl:if test="product_code[.='BG']">
          	 <xsl:call-template name="row-wrapper">
	          <xsl:with-param name="label">XSL_GENERALDETAILS_START_DATE_TYPE</xsl:with-param>
		          <xsl:with-param name="content"><div class="content">
			             <xsl:choose>
						  <xsl:when test="iss_date_type_code[. = '01']">
						   	<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/>
						  </xsl:when>
						  <xsl:when test="iss_date_type_code[. = '02']">
						   	<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/>
						  </xsl:when>
						  <xsl:when test="iss_date_type_code[. = '03']">
						   	<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/>
						  </xsl:when>
						   <xsl:when test="iss_date_type_code[. = '99']">
					        <xsl:value-of select="iss_date_type_details"/>
					       </xsl:when>
						 </xsl:choose>
						</div>
					</xsl:with-param> 
	         </xsl:call-template>
	         <xsl:if test="iss_date[.!='']">
		          <xsl:call-template name="row-wrapper">
			          <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
				          <xsl:with-param name="content"><div class="content">
				            <xsl:value-of select="iss_date"/>
				      </div></xsl:with-param>
		         </xsl:call-template>
	         </xsl:if>
          </xsl:if>
        <xsl:if test="sub_tnx_type_code[.!='03'] and tnx_amt[.!='']">
			 <xsl:if test="product_code[.='LC' or .='SI'] and (org_previous_accepted_file/lc_tnx_record/lc_amt[.!=''] or org_previous_accepted_file/si_tnx_record/lc_amt[.!=''])">
			   <xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text>
							<xsl:choose>
								<xsl:when test="product_code[.='LC']">
									<xsl:value-of select="org_previous_accepted_file/lc_tnx_record/lc_amt"/>
								</xsl:when>
								<xsl:when test="product_code[.='SI']">
									<xsl:value-of select="org_previous_accepted_file/si_tnx_record/lc_amt"/>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
            <xsl:value-of select="tnx_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="tnx_amt"/>
          </div></xsl:with-param>
         </xsl:call-template>
          <xsl:choose>
           <xsl:when test="product_code[.='BG' or .='BR']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_GTEE_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="bg_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="bg_amt"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:when>
           <xsl:when test="product_code[.='EL' or .='LC' or .='BG' or .='SR']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:when>
           <xsl:when test="product_code[.='EC']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_EC_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="ec_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="ec_amt"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:when>
           <xsl:when test="product_code[.='SI']  and sub_tnx_type_code[.!='05']" >
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:when>
          </xsl:choose>
         </xsl:if>
         <xsl:if test="product_code[.='LC']">
          <xsl:if test="tnx_type_code[.!='03'] and not($swift2018Enabled)"> <!-- not for SWIFT2018 LC amendment -->
          <xsl:choose>
           <xsl:when test="(pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']) and (org_previous_file/lc_tnx_record/pstv_tol_pct!='' or org_previous_file/lc_tnx_record/neg_tol_pct!='' or org_previous_file/lc_tnx_record/max_cr_desc_code[.!=''])">
           <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[.!=''] and (org_previous_file/lc_tnx_record/pstv_tol_pct != pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/> <xsl:value-of select="org_previous_file/lc_tnx_record/pstv_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/lc_tnx_record/neg_tol_pct[.!=''] and (org_previous_file/lc_tnx_record/neg_tol_pct != neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
               <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[.='']">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:if>
              </xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/> <xsl:value-of select="org_previous_file/lc_tnx_record/neg_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/lc_tnx_record/max_cr_desc_code[.!=''] and (org_previous_file/lc_tnx_record/max_cr_desc_code != max_cr_desc_code)">
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
            <xsl:if test="pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_ORG_TOL')"/>
             </div></xsl:with-param>
            </xsl:call-template>
            </xsl:if>
           </xsl:otherwise>
          </xsl:choose>
          </xsl:if>
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
              <xsl:with-param name="label">
	      	<xsl:if test="pstv_tol_pct[. = ''] or (pstv_tol_pct = org_previous_file/lc_tnx_record/pstv_tol_pct)">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if>
	      </xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/> <xsl:value-of select="neg_tol_pct"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="max_cr_desc_code[.!=''] and (max_cr_desc_code != org_previous_file/lc_tnx_record/max_cr_desc_code)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
		<xsl:if test="pstv_tol_pct[. = ''] and neg_tol_pct[. = ''] and max_cr_desc_code[.!='']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if>
	      </xsl:with-param>
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
   		<!-- 	<xsl:otherwise>
   			 <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct!='' or org_previous_file/lc_tnx_record/neg_tol_pct!='' or org_previous_file/lc_tnx_record/max_cr_desc_code!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_NEW_TOL')"/>
             </div></xsl:with-param>
            </xsl:call-template>
            </xsl:if>
           </xsl:otherwise> -->
          </xsl:choose>
          <xsl:if test="narrative_additional_amount[.!=''] and (narrative_additional_amount != org_previous_file/lc_tnx_record/narrative_additional_amount)">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_ADDITIONAL_AMT</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="org_previous_file/lc_tnx_record/narrative_additional_amount"/>
            </div></xsl:with-param>
           </xsl:call-template>
           <xsl:call-template name="big-textarea-wrapper">
            <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="narrative_additional_amount"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
         </xsl:if>

         <!-- SI -->
         <xsl:if test="product_code[.='SI']  and sub_tnx_type_code[.!='05'] and not($swift2018Enabled) and (org_previous_file/si_tnx_record/pstv_tol_pct!=pstv_tol_pct or org_previous_file/si_tnx_record/neg_tol_pct!=neg_tol_pct or org_previous_file/si_tnx_record/max_cr_desc_code!=max_cr_desc_code)">          
          <xsl:choose>
           <xsl:when test="(pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']) and (org_previous_file/si_tnx_record/pstv_tol_pct!='' or org_previous_file/si_tnx_record/neg_tol_pct!='' or org_previous_file/si_tnx_record/max_cr_desc_code[.!=''])">
  		    <xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[.!=''] and (org_previous_file/si_tnx_record/pstv_tol_pct != pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
      			<xsl:value-of select="org_previous_file/si_tnx_record/pstv_tol_pct"/>%
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/si_tnx_record/neg_tol_pct[.!=''] and (org_previous_file/si_tnx_record/neg_tol_pct != neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label"><xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[.='']">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:if></xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="org_previous_file/si_tnx_record/neg_tol_pct"/>% 
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="org_previous_file/si_tnx_record/max_cr_desc_code[.!=''] and (org_previous_file/si_tnx_record/max_cr_desc_code != max_cr_desc_code)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
              	<xsl:if test="org_previous_file/si_tnx_record/pstv_tol_pct[. = ''] and org_previous_file/si_tnx_record/neg_tol_pct[. = ''] and org_previous_file/si_tnx_record/max_cr_desc_code[.!='']">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:if>
              </xsl:with-param>
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
           <xsl:if test="pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']">
            <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_ORG_TOL')"/>
              </div></xsl:with-param>
             </xsl:call-template>
             </xsl:if>
           </xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
           <xsl:when test="pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']">
            <xsl:if test="pstv_tol_pct[.!=''] and (pstv_tol_pct != org_previous_file/si_tnx_record/pstv_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
                <xsl:value-of select="pstv_tol_pct"/>%
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="neg_tol_pct[.!=''] and (neg_tol_pct != org_previous_file/si_tnx_record/neg_tol_pct)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
              	<xsl:if test="pstv_tol_pct[. = ''] or (pstv_tol_pct = org_previous_file/si_tnx_record/pstv_tol_pct)">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if>
              </xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
                <xsl:value-of select="neg_tol_pct"/>%
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            <xsl:if test="max_cr_desc_code[.!=''] and (max_cr_desc_code != org_previous_file/si_tnx_record/max_cr_desc_code)">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
              	<xsl:if test="pstv_tol_pct[. = ''] and neg_tol_pct[. = ''] and max_cr_desc_code[.!='']">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:if>
              </xsl:with-param>
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
          <!--  <xsl:otherwise>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOL_LABEL</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_NEW_TOL')"/>
             </div></xsl:with-param>
            </xsl:call-template>
           </xsl:otherwise> -->
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

          <xsl:choose>
          <xsl:when test="product_code[.='SI' ]">
	          <xsl:if test="beneficiary_name[.!=''] and (beneficiary_name != org_previous_file/si_tnx_record/beneficiary_name)">
	          	<xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
				    <xsl:call-template name="fieldset-wrapper">
				     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
				     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
				     <xsl:with-param name="button-type"></xsl:with-param>
				     <xsl:with-param name="content">
				      <xsl:call-template name="address">
				       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
				       <xsl:with-param name="show-reference">Y</xsl:with-param>
				       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
				       <xsl:with-param name="show-country">Y</xsl:with-param>
				       <xsl:with-param name="button-content">
				          <xsl:call-template name="get-button">
					        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
					        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
					        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
					      </xsl:call-template>
				       </xsl:with-param>
				      </xsl:call-template>
				     </xsl:with-param>
				    </xsl:call-template>
				  </xsl:if>
	           </xsl:if>
		       	<xsl:if test="renew_flag[.='Y'] and $option != 'FULL'">
		       		<xsl:call-template name="amend-renewal-details"></xsl:call-template>
		       	</xsl:if>
	         </xsl:when>
	         <xsl:when test="product_code[.='BG']">
	         <xsl:call-template name="row-wrapper">
       			<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
       			<xsl:with-param name="content">
	       		<div class="content" style="white-space:pre;">
	       	 		<xsl:value-of select="issuing_bank/name"/>
	       		</div>
	       		</xsl:with-param>
       		 </xsl:call-template>
	         <xsl:if test="beneficiary_name[.!=''] and (beneficiary_name != org_previous_file/bg_tnx_record/beneficiary_name)">
	           	<xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
				    <xsl:call-template name="fieldset-wrapper">
				     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
				     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
				     <xsl:with-param name="button-type"></xsl:with-param>
				     <xsl:with-param name="content">
				      <xsl:call-template name="address">
				       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
				       <xsl:with-param name="show-reference">Y</xsl:with-param>
				       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
				       <xsl:with-param name="show-country">Y</xsl:with-param>
				       <xsl:with-param name="button-content">
				          <xsl:call-template name="get-button">
					        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
					        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
					        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
					      </xsl:call-template>
				       </xsl:with-param>
				      </xsl:call-template>
				     </xsl:with-param>
				    </xsl:call-template>
				  </xsl:if>
				 </xsl:if>
		       	<xsl:if test="renew_flag[.='Y'] and $option != 'FULL'">
		       		<xsl:call-template name="amend-renewal-details"></xsl:call-template>
		       	</xsl:if>
	         </xsl:when>
         </xsl:choose>
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
         <xsl:if test="product_code[.='SI'] and sub_tnx_type_code[.='05']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="content"><div class="content">
              <xsl:if test="lc_release_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL')"/></xsl:if>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         
         <xsl:if test="product_code[.='LS']">
         <xsl:if test="ls_number[.!='']">
	           <xsl:call-template name="input-field">
	            <xsl:with-param name="label">XSL_LICENSE_NUMBER</xsl:with-param>
	            <xsl:with-param name="value"><xsl:value-of select="ls_number"/></xsl:with-param>
	           </xsl:call-template>
         </xsl:if>
         <xsl:if test="auth_reference[.!='']">
	           <xsl:call-template name="input-field">
	            <xsl:with-param name="label">XSL_AUTH_REFERENCE</xsl:with-param>
	            <xsl:with-param name="value"><xsl:value-of select="auth_reference"/></xsl:with-param>
	           </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LS_AMT_LABEL</xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select="ls_cur_code"/>&nbsp;<xsl:value-of select="ls_amt"/> </xsl:with-param>
		 </xsl:call-template>
		 <xsl:if test="additional_amt[.!='']">
			 <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_ADDITIONAL_AMT_LABEL</xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="ls_cur_code"/>&nbsp;<xsl:value-of select="additional_amt"/> </xsl:with-param>
			 </xsl:call-template>
		 </xsl:if>
         <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_TOTAL_AMT_LABEL</xsl:with-param>
		      <xsl:with-param name="override-displaymode">view</xsl:with-param>
		      <xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/> </xsl:with-param>
		 </xsl:call-template>
         </xsl:if>
         
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
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="tnx_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="tnx_amt"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="maturity_date"/>
            </div></xsl:with-param>
           </xsl:call-template>
         </xsl:if>
         <!-- Transfer Message -->
         <xsl:if test="sub_tnx_type_code[.='12' or .='19']">
          <xsl:choose>
		   <xsl:when test="sub_tnx_type_code[.='12']">
           <!-- Expiry Date and Expiry Place -->
           <xsl:if test="org_previous_file/el_tnx_record/exp_date[.!='']">
	           <xsl:call-template name="row-wrapper">
	            <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
	            <xsl:with-param name="content"><div class="content">
	              <xsl:value-of select="org_previous_file/el_tnx_record/exp_date"/>
	            </div></xsl:with-param>
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="exp_date[.!='']">
	           <xsl:call-template name="row-wrapper">
	            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE_TRANSFER</xsl:with-param>
	            <xsl:with-param name="content"><div class="content">
	              <xsl:value-of select="exp_date"/>
	            </div></xsl:with-param>
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="expiry_place[.!='']">
	           <xsl:call-template name="row-wrapper">
	            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE_TRANSFER</xsl:with-param>
	            <xsl:with-param name="content"><div class="content">
	              <xsl:value-of select="expiry_place"/>
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
                <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
           
            <xsl:if test="tnx_amt[.!='']">
      	     <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">
	             <xsl:choose>
	              <xsl:when test="sub_tnx_type_code[.='19']">XSL_AMOUNTDETAILS_ASG_AMT_LABEL</xsl:when>
	              <xsl:otherwise>XSL_AMOUNTDETAILS_TRF_AMT_LABEL</xsl:otherwise>
	             </xsl:choose>   
	          </xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="tnx_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
            </xsl:if>
             <xsl:if test="applicable_rules[.!='']">
             	<xsl:call-template name = "applicable-rules"/>
             </xsl:if>
           </xsl:with-param>
          </xsl:call-template>
           <xsl:if test="(notify_amendment_flag!='') or (substitute_invoice_flag!='') or (advise_mode_code!='')">
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
              <xsl:with-param name="content">
               <xsl:apply-templates select="advise_thru_bank">
                <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
               </xsl:apply-templates>
              </xsl:with-param>
             </xsl:call-template>
            </xsl:if>
            </xsl:with-param>
            </xsl:call-template>
            </xsl:if>
            
            <xsl:if test="$displaymode = 'view' and $swift2019Enabled">
			  <xsl:call-template name="fieldset-wrapper">
           <xsl:with-param name="legend">XSL_DELIVERY_INSTRUCTIONS</xsl:with-param>
           <xsl:with-param name="content">	
				<xsl:if test="delv_org[.!='']">
					<xsl:variable name="delv_org_code"><xsl:value-of select="delv_org"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C086</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
					 	<xsl:with-param name="name">delv_org</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delv_org_text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">delv_org_text</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="delv_org_text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delivery_to[.!=''] or narrative_delivery_to/text[.!='']">
					<xsl:variable name="delv_org_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C087</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
					 	<xsl:with-param name="name">delv_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="narrative_delivery_to/text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">narrative_delivery_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="narrative_delivery_to/text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				</xsl:with-param>
				</xsl:call-template>
           </xsl:if>
      <xsl:if test="sub_tnx_type_code[.='12']">
          
          	<!--Shipment Details-->
	        <xsl:if test="(narrative_shipment_period[.!=''] or last_ship_date[.!=''] or inco_term[.!=''] or inco_place[.!=''] or narrative_description_goods[.!=''] or narrative_period_presentation[.!=''] or narrative_special_beneficiary[.!=''] or narrative_special_recvbank[.!=''] or period_presentation_days[.!='']) and product_code[.!='SR']">
	         <xsl:call-template name="fieldset-wrapper">
	          <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_NARRATIVE_DETAILS</xsl:with-param>
	          <xsl:with-param name="content">
			            <xsl:call-template name="row-wrapper">
			             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE</xsl:with-param>
			             <xsl:with-param name="content"><div class="content">
			               <xsl:value-of select="org_previous_file/el_tnx_record/last_ship_date"/>
			             </div></xsl:with-param>
			            </xsl:call-template>
			            <xsl:call-template name="row-wrapper">
			             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE_TRANSFER</xsl:with-param>
			             <xsl:with-param name="content"><div class="content">
			               <xsl:value-of select="last_ship_date"/>
			             </div></xsl:with-param>
			            </xsl:call-template>
			            <xsl:call-template name="row-wrapper">
			             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM_TRANSFER</xsl:with-param>
			             <xsl:with-param name="content"><div class="content">
			               <xsl:value-of select="inco_term"/>
			             </div></xsl:with-param>
			            </xsl:call-template>
			            <xsl:call-template name="row-wrapper">
			             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE_TRANSFER</xsl:with-param>
			             <xsl:with-param name="content"><div class="content">
			               <xsl:value-of select="inco_place"/>
			             </div></xsl:with-param>
			            </xsl:call-template>
			            <xsl:if test = "narrative_description_goods[.!=''] and not($swift2018Enabled)">
				            <xsl:call-template name="row-wrapper">
				             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_DESCRIPTION_GOODS</xsl:with-param>
				             <xsl:with-param name="content"><div class="content">
				               <xsl:value-of select="narrative_description_goods"/>
				             </div></xsl:with-param>
				            </xsl:call-template>
			            </xsl:if>
			              <xsl:if test = "narrative_documents_required[.!=''] and not($swift2018Enabled)">
				            <xsl:call-template name="row-wrapper">
				             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_DOCUMENTS_REQUIRED</xsl:with-param>
				             <xsl:with-param name="content"><div class="content">
				               <xsl:value-of select="narrative_documents_required"/>
				             </div></xsl:with-param>
				            </xsl:call-template>
			            </xsl:if>
			            <xsl:if test = "narrative_additional_instructions[.!=''] and not($swift2018Enabled)">
				            <xsl:call-template name="row-wrapper">
				             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
				             <xsl:with-param name="content"><div class="content">
				               <xsl:value-of select="narrative_additional_instructions"/>
				             </div></xsl:with-param>
				            </xsl:call-template>
			            </xsl:if>
			            <!-- not required for Swift 2018 -->	
			            <xsl:if test="not($swift2018Enabled)">		            
			         	 <xsl:call-template name="row-wrapper">
			             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_PERIOD_PRESENTATION</xsl:with-param>
			             <xsl:with-param name="content"><div class="content">
			               <xsl:value-of select="narrative_period_presentation"/>
			             </div></xsl:with-param>
			            </xsl:call-template>
			            </xsl:if>
			            <xsl:call-template name="row-wrapper">
			             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_SHIPMENT_PERIOD</xsl:with-param>
			             <xsl:with-param name="content"><div class="content">
			               <xsl:value-of select="org_previous_file/el_tnx_record/narrative_shipment_period"/>
			             </div></xsl:with-param>
			            </xsl:call-template>
			            <xsl:call-template name="row-wrapper">
			             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_SHIPMENT_PERIOD</xsl:with-param>
			             <xsl:with-param name="content"><div class="content">
			               <xsl:value-of select="narrative_shipment_period"/>
			             </div></xsl:with-param>
			            </xsl:call-template>
			            <!-- Swift 2018 -->
			            <xsl:if test="$swift2018Enabled">
				            <xsl:choose>
				            	<xsl:when test = "defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">
				            		<xsl:if test = "narrative_description_goods[.!='']">
								    <xsl:call-template name="view-mode-extedned-narrative">
										<xsl:with-param name="messageValue"><xsl:value-of select="narrative_description_goods"/></xsl:with-param>
										<xsl:with-param name="name">narrative_description_goods</xsl:with-param>
									</xsl:call-template>
									</xsl:if>
								    <xsl:if test = "narrative_special_beneficiary[.!='']">
								    <xsl:call-template name="view-mode-extedned-narrative">
										<xsl:with-param name="messageValue"><xsl:value-of select="narrative_special_beneficiary"/></xsl:with-param>
										<xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
									</xsl:call-template>
									</xsl:if>
									<xsl:if test = "security:isBank($rundata) and narrative_special_recvbank[.!='']">
									<xsl:call-template name="view-mode-extedned-narrative">
										<xsl:with-param name="messageValue"><xsl:value-of select="narrative_special_recvbank"/></xsl:with-param>
										<xsl:with-param name="name">narrative_special_recvbank</xsl:with-param>
									</xsl:call-template>
									</xsl:if>
				            	</xsl:when>
				            	<xsl:when test = "defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false'">
									<xsl:if test = "narrative_description_goods[.!='']">
							            <xsl:call-template name="row-wrapper">
							             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_DESCRIPTION_GOODS</xsl:with-param>
							             <xsl:with-param name="content"><div class="content">
							               <xsl:value-of select="narrative_description_goods"/>
							             </div></xsl:with-param>
							            </xsl:call-template>
						            </xsl:if>
						             <xsl:if test = "narrative_documents_required[.!='']">
				           				 <xsl:call-template name="row-wrapper">
				            			 <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_DOCUMENTS_REQUIRED</xsl:with-param>
				            			 <xsl:with-param name="content"><div class="content">
				              			 <xsl:value-of select="narrative_documents_required"/>
				            			 </div></xsl:with-param>
				           			 </xsl:call-template>
			          				 </xsl:if>
			         			   <xsl:if test = "narrative_additional_instructions[.!='']">
				          				<xsl:call-template name="row-wrapper">
				             			<xsl:with-param name="label">XSL_NARRATIVEDETAILS_TRANSFER_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
				             			<xsl:with-param name="content"><div class="content">
				               			<xsl:value-of select="narrative_additional_instructions"/>
				             			</div></xsl:with-param>
				            	   </xsl:call-template>
			           			   </xsl:if>
						        	<xsl:if test = "narrative_special_beneficiary[.!='']">
						            	 <xsl:call-template name="row-wrapper">
							             <xsl:with-param name="label">XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_BENEF_TNF</xsl:with-param>
							             <xsl:with-param name="content"><div class="content">
							               <xsl:value-of select="narrative_special_beneficiary"/>
							             </div></xsl:with-param>
							            </xsl:call-template>
							        </xsl:if>
						            <xsl:if test = "security:isBank($rundata) and narrative_special_recvbank[.!='']">
							             <xsl:call-template name="row-wrapper">
							             <xsl:with-param name="label">XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_RECEIV_TNF</xsl:with-param>
							             <xsl:with-param name="content"><div class="content">
							               <xsl:value-of select="narrative_special_recvbank"/>
							             </div></xsl:with-param>
							            </xsl:call-template>
						            </xsl:if>
				            	</xsl:when>
				            	<xsl:otherwise/>
				            </xsl:choose>
			            </xsl:if>
			         
			   		<xsl:if test="$swift2018Enabled">
				   		 <!-- Swift 2018 -->
				          <xsl:call-template name="fieldset-wrapper">
				            <xsl:with-param name="legend">XSL_TAB_PERIOD_PRESENTATION_IN_DAYS</xsl:with-param>
				          <xsl:with-param name="legend-type">indented-header</xsl:with-param>
				            <xsl:with-param name="content">
				            <xsl:if test="narrative_period_presentation[.!=''] or period_presentation_days[.!='']">			         
				          <xsl:call-template name="row-wrapper">
				             <xsl:with-param name="label">XSL_PERIOD_NO_OF_DAYS</xsl:with-param>
				             <xsl:with-param name="content"><div class="content">
				               <xsl:value-of select="period_presentation_days"/>
				             </div></xsl:with-param>
				            </xsl:call-template>
				            <xsl:call-template name="row-wrapper">
				             <xsl:with-param name="label">XSL_TAB_PERIOD_DESCRIPTION</xsl:with-param>
				             <xsl:with-param name="content"><div class="content">
				               <xsl:value-of select="narrative_period_presentation"/>
				             </div></xsl:with-param>
				            </xsl:call-template>
				              </xsl:if>
				             </xsl:with-param>
				         </xsl:call-template>
			         </xsl:if>		         
			       </xsl:with-param>
			     </xsl:call-template>
			   </xsl:if>
          </xsl:if>
        </xsl:if>  
         <xsl:if test="sub_tnx_type_code[.='20' or .='21']">
         	<xsl:call-template name="row-wrapper">
	           <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	           <xsl:with-param name="content">
	           	<div class="content">
	             <xsl:value-of select="iss_date"/>
	           	</div>
	           </xsl:with-param>
	        </xsl:call-template>
	        <xsl:if test="org_previous_file/bg_tnx_record/exp_date_type_code[.!='']">
		        <xsl:call-template name="row-wrapper">
		           <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
		           <xsl:with-param name="value">
				       <xsl:choose>
				        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '02']">
				          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/>
				        </xsl:when>
				        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '03']">
				          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/>
				        </xsl:when>
				        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '01']">
				          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/>
				        </xsl:when>
				       </xsl:choose>
				       (<xsl:value-of select="org_previous_file/bg_tnx_record/exp_date"/>)
			      </xsl:with-param>
	        </xsl:call-template>
	        </xsl:if>
         	<xsl:choose>
              <!-- Extend -->
	          <xsl:when test="sub_tnx_type_code[.='20']">
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
			   <xsl:value-of select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_03_PROJECTED')"/>
			  </xsl:when>
			 </xsl:choose>
             <xsl:if test="exp_date[.!='']">
	          (<xsl:value-of select="exp_date"/>)
		     </xsl:if>
           </div></xsl:with-param>
		        </xsl:call-template>
	          </xsl:when>
	          <!-- Pay -->
	          <xsl:when test="sub_tnx_type_code[.='21']">
	          	 <xsl:call-template name="row-wrapper">
		          <xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
		          <xsl:with-param name="content"><div class="content">
		            <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
		          </div></xsl:with-param>
		         </xsl:call-template>
	          </xsl:when>
	        </xsl:choose>
	        <xsl:call-template name="big-textarea-wrapper">
	         <xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
	         <xsl:with-param name="content"><div class="content">
	           <xsl:value-of select="free_format_text"/>
	         </div></xsl:with-param>
	        </xsl:call-template>
	     </xsl:if>
	     <!-- CLEAN LC MESSAGE -->
	     <xsl:if test="prod_stat_code[.='26']">
	     	<!-- Issue Date -->
	     	<xsl:call-template name="row-wrapper">
	          <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	          <xsl:with-param name="content"><div class="content"><xsl:value-of select="iss_date"/></div></xsl:with-param>
	         </xsl:call-template>
	     	<!-- Expiry Date -->
	     	<xsl:call-template name="row-wrapper">
	           <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
	           <xsl:with-param name="content"><div class="content"><xsl:value-of select="exp_date"/></div></xsl:with-param>
	          </xsl:call-template>
	     	<!-- Document Amount -->
	     	<xsl:call-template name="row-wrapper">
	            <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
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
	     	<!-- Debit Amount -->
	     	<xsl:if test="product_code[.='LC'] and debit_amt[.!='']">
             <xsl:call-template name="row-wrapper">
              <xsl:with-param name="label">XSL_GENERALDETAILS_DEBIT_AMT_LABEL</xsl:with-param>
              <xsl:with-param name="content"><div class="content">
                <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="debit_amt"/>
              </div></xsl:with-param>
             </xsl:call-template>
           </xsl:if>
	     </xsl:if>
        </xsl:when>
        <!-- REPORTING -->
        <xsl:when test="tnx_type_code[.='15']">
         
         <xsl:choose>
          <!-- Show the amendment date and number for all products that can effectively be amended -->
          <xsl:when test="prod_stat_code[.='08'] and product_code[.='EL' or .='LC' or .='BG' or .='SI' or .='SR']">
             <!-- For reporting  show tnx amt label additionally for SI ,LC and SR 
          		This is already present for tnx_type_code=03 event summary so it should also be available for MO transactions where tnx_type_code=15   
          	 -->
            <xsl:if test="product_code[.='LC' or .='EL' or .='SI' or .='SR'] and tnx_amt[.!=''] and tnx_cur_code[.!='']">
		      <xsl:call-template name="row-wrapper">
		         <xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
		         <xsl:with-param name="content">
			         <div class="content">
			           <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
			         </div>
		         </xsl:with-param>
		      </xsl:call-template>
		     </xsl:if> 
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
                 Settlement, or Partial Settlement ,Bill clean on LC or SI, show the documents amount and 
                 maturity date -->
          <!-- Also added for EL and SR -->
          <xsl:when test="prod_stat_code[.='04' or .='05' or .='12' or .='13' or .='14' or .='15' or .='16' or .='17' or .='26' or .='A9'] and product_code[.='LC' or .='SI' or .='EL' or .='SR' or .='IC' or .='EC']">
           <xsl:if test="tnx_amt[.!='']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">
             <xsl:choose>
              <xsl:when test="product_code[.='PO'] and prod_stat_code[.='16' or .='17']">XSL_GENERALDETAILS_UTILIZATION_PAID_AMOUNT</xsl:when>
              <xsl:otherwise>XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:otherwise>
             </xsl:choose>   
            </xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="tnx_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="tnx_amt"/>
            </div></xsl:with-param>
           </xsl:call-template>
           </xsl:if>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="maturity_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_REPORTINGDETAILS_LATEST_ANSWER_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="latest_answer_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          
          <!-- To show tnx_amt in Event details for acceptance event (MT753) -->
          <xsl:when test="(product_code[.='EL'] or product_code[.='LC']) and prod_stat_code[.='07'] and tnx_amt[.!='']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="tnx_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="tnx_amt"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:when>
          
          <!-- Show the free format text of the mismatches for IO -->
           <xsl:when test="prod_stat_code[.='75'] and product_code[.='IO']">
          		<xsl:if test="nb_mismatch[.!='']">
		          <xsl:call-template name="row-wrapper">
		           <xsl:with-param name="label">XSL_LABEL_NO_OF_MISMATCHES</xsl:with-param>
		           <xsl:with-param name="content"><div class="content">
		             <xsl:value-of select="nb_mismatch"/>
		           </div></xsl:with-param>
		          </xsl:call-template>
		        </xsl:if>
            	<xsl:if test="free_format_text[.!='']">
		          <xsl:call-template name="big-textarea-wrapper">
		           <xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
		           <xsl:with-param name="content"><div class="content">
		             <xsl:value-of select="free_format_text"/>
		           </div></xsl:with-param>
		          </xsl:call-template>
		        </xsl:if>
          </xsl:when>
          <!-- Show the free format text of the mismatches for EA-->
           <xsl:when test="prod_stat_code[.='75'] and product_code[.='EA']">
          		<xsl:if test="nb_mismatch[.!='']">
		          <xsl:call-template name="row-wrapper">
		           <xsl:with-param name="label">XSL_LABEL_NO_OF_MISMATCHES</xsl:with-param>
		           <xsl:with-param name="content"><div class="content">
		             <xsl:value-of select="nb_mismatch"/>
		           </div></xsl:with-param>
		          </xsl:call-template>
		        </xsl:if>
            	<xsl:if test="mismatches[.!='']">
		          <xsl:call-template name="big-textarea-wrapper">
		           <xsl:with-param name="label">XSL_HEADER_MISMATCHES</xsl:with-param>
		           <xsl:with-param name="content"><div class="content">
		             <xsl:value-of select="mismatches"/>
		           </div></xsl:with-param>
		          </xsl:call-template>
		        </xsl:if>
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
        <!-- For Re-submit/Close -->
        <xsl:when test="tnx_type_code[.='31' or .='38']">
        	<xsl:call-template name="row-wrapper">
	            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
	            <xsl:with-param name="content"><div class="content">
	              <xsl:value-of select="exp_date"/>
	            	</div>
	            </xsl:with-param>
           	</xsl:call-template>
           	<xsl:call-template name="row-wrapper">
	            <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
	            <xsl:with-param name="content"><div class="content">
	              <xsl:value-of select="expiry_place"/>
	            	</div>
	            </xsl:with-param>
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
       <xsl:if test="product_code[.='LC'] and not($swift2018Enabled)"> <!-- not for SWIFT2018 LC amendment -->
         
        <!--Shipment Details org_last_ship_date-->
        <xsl:if test="ship_from!='' or ship_loading!='' or ship_discharge!='' or ship_to!='' or narrative_shipment_period!='' or last_ship_date!='' or org_last_ship_date!=''">
         <xsl:call-template name="fieldset-wrapper">
          <xsl:with-param name="legend">XSL_HEADER_AMENDED_SHIPMENT_DETAILS</xsl:with-param>
          <xsl:with-param name="legend-type">indented-header</xsl:with-param>
          <xsl:with-param name="content">
          <xsl:variable name="orginalShipmentFrom"><xsl:value-of select="org_previous_file/lc_tnx_record/ship_from"/></xsl:variable>
	          <xsl:variable name="newShipmentFrom"><xsl:value-of select="ship_from"/></xsl:variable>
	          <xsl:variable name="orginalShipmentLoading"><xsl:value-of select="org_previous_file/lc_tnx_record/ship_loading"/></xsl:variable>
	          <xsl:variable name="newShipmentLoading"><xsl:value-of select="ship_loading"/></xsl:variable>
	          <xsl:variable name="orginalShipmentDicharge"><xsl:value-of select="org_previous_file/lc_tnx_record/ship_discharge"/></xsl:variable>
         	  <xsl:variable name="newShipmentDischarge"><xsl:value-of select="ship_discharge"/></xsl:variable>
	          <xsl:variable name="orginalShipmentTo"><xsl:value-of select="org_previous_file/lc_tnx_record/ship_to"/></xsl:variable>
	          <xsl:variable name="newShipmentTo"><xsl:value-of select="ship_to"/></xsl:variable>
	          <xsl:variable name="originalLastShipDate"><xsl:value-of select="org_previous_file/lc_tnx_record/last_ship_date"/></xsl:variable>
	          <xsl:variable name="newLastShipDate"><xsl:value-of select="last_ship_date"/></xsl:variable>
	          <xsl:variable name="originalNarrativeShipmentPeriod"><xsl:value-of select="org_previous_file/lc_tnx_record/narrative_shipment_period"/></xsl:variable>
	          <xsl:variable name="newNarrativeShipmentPeriod"><xsl:value-of select="narrative_shipment_period"/></xsl:variable>
          
           <!-- Shipment From, Shipment To, Last Shipment Date -->
            <xsl:if test="$orginalShipmentFrom != $newShipmentFrom">
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
            </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="$orginalShipmentLoading != $newShipmentLoading">
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
            </xsl:if>
            
            <xsl:if test="$orginalShipmentDicharge != $newShipmentDischarge">
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
           </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="$orginalShipmentTo != $newShipmentTo">
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
            </xsl:if>
           
          <xsl:if test="$originalLastShipDate!= $newLastShipDate">
           <xsl:if test="last_ship_date!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="org_previous_file/lc_tnx_record/last_ship_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
               <xsl:value-of select="last_ship_date"/>
             </div></xsl:with-param>
            </xsl:call-template>
            </xsl:if>
	          </xsl:if>
	         
	          
	          <xsl:if test="$originalNarrativeShipmentPeriod != $newNarrativeShipmentPeriod">
	              <xsl:if test="narrative_shipment_period!=''">
            <xsl:call-template name="row-wrapper">
             <xsl:with-param name="label">XSL_NARRATIVEDETAILS_ORG_SHIPMENT_PERIOD</xsl:with-param>
             <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="org_previous_file/lc_tnx_record/narrative_shipment_period"/>
             </div></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="big-textarea-wrapper">
            <xsl:with-param name="label">XSL_NARRATIVEDETAILS_NEW_SHIPMENT_PERIOD</xsl:with-param>
             <xsl:with-param name="content">
	             <div class="content">
	               <xsl:value-of select="narrative_shipment_period"/>
	             </div></xsl:with-param>
            </xsl:call-template>
          </xsl:if>
          </xsl:if>
         </xsl:with-param>
        </xsl:call-template>
       </xsl:if>
      </xsl:if>
       
       <!-- SI -->
       <xsl:if test="product_code[.='SI'] and not($swift2018Enabled)">
        <!--Shipment Details-->
        <xsl:if test="ship_from!='' or ship_loading!='' or ship_discharge!='' or ship_to!='' or narrative_shipment_period!='' or last_ship_date!=''">
         <xsl:call-template name="fieldset-wrapper">
          <xsl:with-param name="legend">XSL_HEADER_AMENDED_SHIPMENT_DETAILS</xsl:with-param>
          <xsl:with-param name="legend-type">indented-header</xsl:with-param>
          <xsl:with-param name="content">
          <xsl:variable name="orginalShipmentFrom"><xsl:value-of select="org_previous_file/si_tnx_record/ship_from"/></xsl:variable>
         <xsl:variable name="newShipmentFrom"><xsl:value-of select="ship_from"/></xsl:variable>
	          <xsl:variable name="orginalShipmentLoading"><xsl:value-of select="org_previous_file/si_tnx_record/ship_loading"/></xsl:variable>
	         <xsl:variable name="newShipmentLoading"><xsl:value-of select="ship_loading"/></xsl:variable>
	          <xsl:variable name="orginalShipmentDicharge"><xsl:value-of select="org_previous_file/si_tnx_record/ship_discharge"/></xsl:variable>
	         <xsl:variable name="newShipmentDischarge"><xsl:value-of select="ship_discharge"/></xsl:variable>
	          <xsl:variable name="orginalShipmentTo"><xsl:value-of select="org_previous_file/si_tnx_record/ship_to"/></xsl:variable>
	         <xsl:variable name="newShipmentTo"><xsl:value-of select="ship_to"/></xsl:variable>
          
           <!-- Shipment From, Shipment To, Last Shipment Date -->
            <xsl:if test="$orginalShipmentFrom != $newShipmentFrom">
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
            </xsl:if>
           
           <!-- SWIFT 2006 -->
            <xsl:if test="$orginalShipmentLoading != $newShipmentLoading">
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
                </xsl:if>
           
            <xsl:if test="$orginalShipmentDicharge != $newShipmentDischarge">
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
            </xsl:if>
           
           <!-- SWIFT 2006 -->
           <xsl:if test="$orginalShipmentTo != $newShipmentTo">
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
             <xsl:call-template name="big-textarea-wrapper">
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
       </xsl:if>
       
       <!-- Additional details are provided for an amendment release amount details -->
	<xsl:if test="product_code[.='BG'] and tnx_type_code[.='03'] and sub_tnx_type_code[.='05'] and $displaymode = 'view'">
        <xsl:variable name="legend_value">XSL_HEADER_RELEASE_AMOUNT_DETAILS</xsl:variable>
        <xsl:call-template name="fieldset-wrapper">
         <xsl:with-param name="legend">
         <xsl:value-of select="$legend_value"/>
		</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
       <xsl:with-param name="content">     
         <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_RELEASE_AMT_LABEL</xsl:with-param>
          <xsl:with-param name="content"><div class="content">
		  <xsl:value-of select="bg_cur_code" />&nbsp;<xsl:value-of select="release_amt" />  
          </div></xsl:with-param>          
         </xsl:call-template>
        <xsl:if test="bg_release_flag[.='Y']">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="content"><div class="content">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL')"/>
           </div></xsl:with-param>
          </xsl:call-template>
         </xsl:if>       
       </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
      <!-- Additional Information Provided by the Client -->
   <xsl:if test="sub_product_code[.!='COCQS' and .!='CQBKR' and .!='CTCHP'] and ((adv_send_mode[. != ''] and tnx_type_code[.='01' or .='03']) or
       				 (docs_send_mode[. != ''] and tnx_type_code[.='01']) or 
       				 (principal_act_no[. != '']) or (fee_act_no[. != '']) or (fwd_contract_no[.!=''] and product_code[.='EC']) 
       				 or ((security:isBank($rundata) and narrative_sender_to_receiver[.!='']) or (free_format_text[.!=''])) or (attachments/attachment[type='01'])) ">
        <xsl:variable name="legend_value">XSL_HEADER_INSTRUCTIONS</xsl:variable>
        <xsl:call-template name="fieldset-wrapper">
        
        <xsl:with-param name="legend">
         <xsl:if test="((tnx_type_code[.!='15'] and (free_format_text[.!=''] or adv_send_mode[. != ''] or docs_send_mode[. != '']) and sub_product_code[.!='ULOAD']) or
         		(product_code[.='TF'] and (fee_act_no[.!=''] or principal_act_no[. != ''])))">
		  <xsl:value-of select="$legend_value"/>
		 </xsl:if>
		</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
       
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
			 <xsl:when test="adv_send_mode[. = '99']">
			  <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_OTHER')"/>
			 </xsl:when>
		    </xsl:choose> 		    
          </div></xsl:with-param>          
         </xsl:call-template>
         <xsl:if test="adv_send_mode_text[. != '']">
           <xsl:call-template name="input-field">
		   <xsl:with-param name="name">adv_send_mode_text</xsl:with-param>
		   <xsl:with-param name="maxsize">35</xsl:with-param>
		   <xsl:with-param name="readonly">Y</xsl:with-param>
		   <xsl:with-param name="required">Y</xsl:with-param>
		 </xsl:call-template>
		 </xsl:if>
        </xsl:if>        
	    
       <!-- File delivery channel (Tag 23X of SWIFT MT798) -->
        <xsl:if test="delivery_channel[. != '']">	
        	<div>
			  	<script>
			  		var deliveryChannelFileAct;
			  		<xsl:choose>
				  	<xsl:when test="delivery_channel[.='FACT']"> 
				  		deliveryChannelFileAct = true;
					</xsl:when>
					<xsl:otherwise>
						deliveryChannelFileAct = false;
					</xsl:otherwise>
					</xsl:choose>
			  	</script>
		  </div>       
			<xsl:call-template name="select-field">
				<xsl:with-param name="label" select="'XSL_INSTRUCTIONS_REQ_DELIVERY_CHANNEL_LABEL'" />
				<xsl:with-param name="name">delivery_channel</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
			 	<xsl:with-param name="value"><xsl:value-of select="delivery_channel"/></xsl:with-param> 			
				<xsl:with-param name="options">
					<xsl:call-template name="delivery-channel-options"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>         
        
        <!--Documents Send Mode-->
        <xsl:if test="docs_send_mode[. != ''] and tnx_type_code[.='01']">
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
        <xsl:if test="principal_act_no[. != ''] or fee_act_no[. != ''] or (fwd_contract_no[.!=''] and product_code[.='EC' or .='LC' or .='IC' or .='SI'])">
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
	        <xsl:if test="fwd_contract_no[.!=''] and product_code[.='SI' or .='LC' or .='IC']">
		        <xsl:call-template name="row-wrapper">
		         <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
		         <xsl:with-param name="content"><div class="content">
		           <xsl:value-of select="fwd_contract_no"/>
		         </div></xsl:with-param>
		        </xsl:call-template>
	        </xsl:if>
	        <xsl:if test="$displaymode = 'view' and product_code[.='SI']">
				<xsl:if test="delv_org[.!='']">
					<xsl:variable name="delv_org_code"><xsl:value-of select="delv_org"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C083</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
					 	<xsl:with-param name="name">delv_org</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delv_org_text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">delv_org_text</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="delv_org_text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delivery_to[.!=''] or narrative_delivery_to/text[.!='']">
					<xsl:variable name="delv_org_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C084</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
					 	<xsl:with-param name="name">delv_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $delv_org_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="narrative_delivery_to/text[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="name">narrative_delivery_to</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="narrative_delivery_to/text"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
	      <xsl:if test="product_code[.='TF']">
	      <xsl:if test="sub_tnx_type_code[.='38']">
		 		<xsl:call-template name="input-field">
					<xsl:with-param name ="label">XSL_REPAYMENT_MODE</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="id">repayment_mode</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:if test="repayment_mode[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL')"/></xsl:if>
						<xsl:if test="repayment_mode[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL_INTEREST')"/></xsl:if>
					</xsl:with-param>
		 	    </xsl:call-template>
		 </xsl:if>
		 <xsl:if test="tnx_amt[.!=''] and (tnx_type_code[.!='03'] and tnx_type_code[.!='01'])">
			 <xsl:call-template name="currency-field">
	      	 	<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
	      	 	<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
		        <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">repayment_cur_code</xsl:with-param>
	      	 </xsl:call-template>
      	 </xsl:if>
      	 
      	 <xsl:if test="interest_amt[.!='']">
      	 	<xsl:call-template name="currency-field">
      	 		<xsl:with-param name="label">XSL_INTEREST_AMOUNT</xsl:with-param>
      	 		<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	        	<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-name">interest_amt</xsl:with-param>
				<xsl:with-param name="override-currency-name">repayment_cur_code</xsl:with-param>
      	 	</xsl:call-template>
      	 </xsl:if>
      	 
      	 <xsl:call-template name="input-field">
      	 	<xsl:with-param name="label">XSL_GENERALDETAILS_SETTLEMENT_METHOD</xsl:with-param>
      	 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
      	 	<xsl:with-param name="id">settlement_code</xsl:with-param>
      	 	<xsl:with-param name="value">
      	 		<xsl:if test="settlement_code[.='01']"><xsl:value-of select="localization:getDecode($language, 'N045', '01')"/></xsl:if>
      	 		<xsl:if test="settlement_code[.='03']"><xsl:value-of select="localization:getDecode($language, 'N045', '03')"/></xsl:if>
      	 	</xsl:with-param>
      	 </xsl:call-template>
      	 </xsl:if>
	        <xsl:if test="fwd_contract_no[.!=''] and product_code[.='EC']">
		        <xsl:call-template name="row-wrapper">
			    <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
			    <xsl:with-param name="content">
			     <div class="content">
			      <xsl:value-of select="fwd_contract_no"/>
			     </div></xsl:with-param>
			    </xsl:call-template>
		    </xsl:if>
	    </xsl:if>
	    <xsl:if test="$displaymode='view' and product_code[.='BG'] and delivery_to[.!=''] "  >
     	<xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_DELIVERY_TO_LABEL</xsl:with-param>
	      <xsl:with-param name="name">delivery_to</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="bg-delivery-to"/>
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:if test="delivery_to[. = '04'] and delivery_to_other[.!='']">
	     		<xsl:call-template name="big-textarea-wrapper">
					<xsl:with-param name="content"><div class="content">
						<xsl:value-of select="delivery_to_other"/>
					</div></xsl:with-param>
				</xsl:call-template>
     		</xsl:if>
    	</xsl:if>
        <xsl:if test="free_format_text[.!=''] and tnx_type_code[.!='15'] and sub_product_code[.!='ULOAD' and .!='CTCHP']">
        <xsl:choose>
        	<xsl:when test="product_code[.='LS'] and sub_tnx_type_code[.='96']">
        	  <xsl:call-template name="big-textarea-wrapper">
	           <xsl:with-param name="label">XSL_REASON_FOR_CANCELLATION_TITLE</xsl:with-param>
	           <xsl:with-param name="content"><div class="content">
	             <xsl:value-of select="free_format_text"/>
	           </div></xsl:with-param>
	          </xsl:call-template>
        	</xsl:when>
        	<xsl:when test="product_code[.='LC'] and security:isBank($rundata)">
        	  <xsl:call-template name="big-textarea-wrapper">
	           <xsl:with-param name="label">XSL_FREE_FORMAT_CUSTOMER_INSTRUCTIONS</xsl:with-param>
	           <xsl:with-param name="content"><div class="content">
	             <xsl:value-of select="free_format_text"/>
	           </div></xsl:with-param>
	          </xsl:call-template>
        	</xsl:when>
        	<xsl:when test="product_code[.='EL' or .='SR' or .='TF']">
        	  <xsl:call-template name="big-textarea-wrapper">
	           <xsl:with-param name="label">XSL_FREE_FORMAT_CUSTOMER_INSTRUCTIONS</xsl:with-param>
	           <xsl:with-param name="content"><div class="content">
	             <xsl:value-of select="free_format_text"/>
	           </div></xsl:with-param>
	          </xsl:call-template>
        	</xsl:when>
        	<xsl:otherwise>
	        	<!-- <xsl:if test="(free_format_text[.!=''] and security:isCustomer($rundata)) or (narrative_sender_to_receiver[.!=''] and security:isBank($rundata))"> -->
	        	<xsl:if test="(free_format_text[.!=''])"> 
		        	<xsl:call-template name="big-textarea-wrapper">
			           <xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
			           <xsl:with-param name="content"><div class="content">
					    	 		<xsl:value-of select="free_format_text"/>
			           </div></xsl:with-param>
			          </xsl:call-template>
			    </xsl:if>
	        </xsl:otherwise>
        </xsl:choose>
        </xsl:if>
        <xsl:if test="free_format_text[.!=''] and tnx_type_code[.='15'] and is_MT798[.='Y'] and product_code = 'LC'">
	        <xsl:call-template name="big-textarea-wrapper">
				           <xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
				           <xsl:with-param name="content"><div class="content">
						    	 		<xsl:value-of select="free_format_text"/>
				           </div></xsl:with-param>
		    </xsl:call-template>
        </xsl:if>
        <xsl:if test="security:isBank($rundata) and tnx_amt[.!=''] and product_code[.='SG']">
         <xsl:call-template name="currency-field">
      	 	<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
      	 	<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	        <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
			<xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
			<xsl:with-param name="override-currency-name">repayment_cur_code</xsl:with-param>
      	 </xsl:call-template>
      	 </xsl:if>
         <xsl:call-template name="attachments-file-dojo">
          <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
          <xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
          <xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
          <xsl:with-param name="show-status-column">
          <xsl:choose>
          	<!-- Displays the status for files sent to SWIFT (MT798 and FileAct) -->
         	 <xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR' or .='BG' or .='BR'] and attachments/attachment[status ='04' or status='05' or status='06' or status='07']">Y</xsl:when>
         	 <xsl:otherwise>N</xsl:otherwise>
          </xsl:choose>	
          </xsl:with-param><!--
          <xsl:with-param name="parse-widgets">N</xsl:with-param>
          <xsl:with-param name="with-wrapper">N</xsl:with-param>
         --></xsl:call-template> 
         <xsl:if test="return_comments[.!=''] and tnx_stat_code[.!='03' and .!='04'] and $displaymode = 'view' and security:isCustomer($rundata)">
				<xsl:if test="product_code[.='LC' or .='SI' or 'BG']">
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
        <!--<xsl:if test="attachments/attachment[auto_gen_doc_code != '']">
         <xsl:call-template name="attachments-file-dojo">
          <xsl:with-param name="existing-attachments" select="attachments/attachment[auto_gen_doc_code != '']"/>
          <xsl:with-param name="legend">XSL_HEADER_OTHER_FILE_UPLOAD</xsl:with-param>
         </xsl:call-template> 
        </xsl:if>-->
       </xsl:with-param>
      </xsl:call-template>
    </xsl:if> 
            
   
   <xsl:if test="tnx_stat_code[.='03'] and product_code[.='BR'] and sub_tnx_stat_code[.='05'] and sub_tnx_type_code[.='46' or .='47']">
 	  <!-- Link to display Amend Details contents -->
 	   <xsl:call-template name="amend-details-link">
 	    <xsl:with-param name="show-amddetails">N</xsl:with-param>
 	   </xsl:call-template>
 	     
 	  <!-- Amend Details -->
 	    <div id="amdDetails">  
 	     <xsl:variable name="amendflag" select="defaultresource:getResource('AMEND_DETAILS_ENABLE')"></xsl:variable>
 	      <xsl:if test="$amendflag='true'">
      <xsl:if test="tnx_stat_code[.='03'] and product_code[.='EL' or .='BR'] and sub_tnx_stat_code[.='05'] and sub_tnx_type_code[.='46' or .='47']">
 	       <xsl:call-template name="fieldset-wrapper">
 	 	       
 	         
 	       <xsl:with-param name="legend">XSL_HEADER_AMENDMENT_DETAILS</xsl:with-param>
 	        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
 	        <xsl:with-param name="parse-widgets">N</xsl:with-param>
 	        <xsl:with-param name="content">
 	           
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
 	 	 	 <xsl:if test="tnx_cur_code[.!=''] and tnx_amt[.!='']">
 	 	 	 <xsl:call-template name="row-wrapper">
 	 	 	 <xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
 	 	 	 <xsl:with-param name="content"><div class="content">
 	 	 	   <xsl:value-of select="tnx_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="tnx_amt"/>
 	 	 	 </div></xsl:with-param>
 	 	 	 </xsl:call-template>
 	 	 	 </xsl:if>
 	 	 	 <xsl:call-template name="row-wrapper">
 	 	 	 <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL</xsl:with-param>
 	 	 	 <xsl:with-param name="content"><div class="content">
 	 	 	   <xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
 	 	 	 </div></xsl:with-param>
 	 	 	 </xsl:call-template>
 	 	 	
 	 	 	 <!-- Exp Date -->
 	 	 	 <xsl:call-template name="row-wrapper">
 	 	 	 <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
 	 	 	 <xsl:with-param name="content"><div class="content">
 	 	 	   <xsl:value-of select="exp_date"/>
 	 	 	 </div>
 	 	 	 </xsl:with-param>
 	 	 	 </xsl:call-template>
 	 	 	 
 	 	 	 <!-- Last Shipment aneesh Date -->
 	 	 	 <xsl:call-template name="row-wrapper">
 	 	 	 <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
 	 	 	 <xsl:with-param name="content"><div class="content">
 	 	 	   <xsl:value-of select="last_ship_date"/>
 	 	 	 </div>
 	 	 	 </xsl:with-param>
 	 	 	 </xsl:call-template>          
 	 	 	</xsl:with-param>
 	 		</xsl:call-template>
 	 	      <xsl:call-template name="amend-amt-details"/>
 	 	 	  <xsl:call-template name="amend-shipment-details"/>
 	 	 	  <xsl:call-template name="amend-renewal-details"/>
 	 	 	  <xsl:if test="amd_details[.!='']">
 	 	 	  	 <xsl:call-template name="amend-narrative" />
 	 	 	  </xsl:if>
 	 	 	  <xsl:call-template name="renew-time-period-options"/>
 	 	 	</xsl:if>
 	 	  </xsl:if>
 	 	 </div>
   </xsl:if>   
      <!-- Bank Message -->
      <xsl:if test="tnx_stat_code[.='04'] or security:isBank($rundata)">
      <xsl:if test="bo_ref_id!='' or prod_stat_code[.='01' or .='03' or .='25'] or bo_comment!=''">
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
             <xsl:choose>	
			<xsl:when test="release_dttm[.!='']">
			<xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata)" />
			</xsl:when>
			<xsl:otherwise>
		    <xsl:value-of select="converttools:formatReportDate(bo_release_dttm,$rundata)" />	
			</xsl:otherwise>
			</xsl:choose>
           </div></xsl:with-param>
          </xsl:call-template>

		<xsl:if test="$optionCode != 'SNAPSHOT'">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
           <xsl:choose>
				<xsl:when test="(product_code[.='LN'] or product_code[.='BK'] and sub_product_code[.='LNRPN']) and  prod_stat_code='01' and tnx_stat_code='04' and (sub_tnx_stat_code='05' or sub_tnx_stat_code='' or sub_tnx_stat_code='17'   ) ">
				    <xsl:value-of select="localization:getGTPString($language, 'STATUS_CODE_LOAN_CANCELLED')" />
                </xsl:when>
				<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/></xsl:otherwise>
			</xsl:choose>           </div></xsl:with-param>
          </xsl:call-template>
		</xsl:if>
          
          <xsl:if test="product_code[.='SE'] and sub_product_code[.='COCQS']">
          	<xsl:call-template name="big-textarea-wrapper">
	         <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
	         <xsl:with-param name="content"><div class="content">
	           <xsl:value-of select="free_format_text"/>
	         </div></xsl:with-param>
	        </xsl:call-template>
	      </xsl:if>  
          
          <xsl:if test="product_code[.='BG' or .='SI'] and request_date != '' and prod_stat_code = '86'">
          <xsl:call-template name="row-wrapper">
          <xsl:with-param name="label">EXTEND_PAY_DATE</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="request_date"/>
           </div></xsl:with-param>
          </xsl:call-template>
		  </xsl:if>
		  
		  <!-- Back-Office Reference -->
		   <xsl:if test="bo_ref_id!=''">
	          <xsl:call-template name="row-wrapper">
	           <xsl:with-param name="label">
				<xsl:choose>
					<xsl:when test="product_code[.='LN']">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:when>
					<xsl:otherwise>XSL_GENERALDETAILS_BO_REF_ID</xsl:otherwise>
				</xsl:choose>
	           </xsl:with-param>
	           <xsl:with-param name="content"><div class="content" style="white-space:pre;">
	          	<xsl:value-of select="bo_ref_id"/>
	           </div>
	           </xsl:with-param>
	          </xsl:call-template>
	        </xsl:if>
		  		
          <!-- Back-Office comment -->
          <xsl:if test="bo_comment!=''">
	         <xsl:choose>
          		<xsl:when test = "(prod_stat_code[.='01'] and sub_tnx_stat_code[.='20']) and (product_code[.='LN'] or (product_code[.='BK'] and sub_product_code[.='LNRPN']))">
          			<xsl:call-template name="input-field">
			           <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
			           <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'LN_BUSINESS_VALIDATION_ERROR')"/>
			           </xsl:with-param>
	          		</xsl:call-template>
          		</xsl:when>
          		<xsl:otherwise>
          			<xsl:call-template name="big-textarea-wrapper">
			           <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
			           <xsl:with-param name="content">
			           <xsl:choose>
			           	<xsl:when test="$displaymode='view'">
			           		<div class="content">
             					<xsl:value-of select="bo_comment"/>
             				</div>
			           	</xsl:when>
			           	<xsl:otherwise>
			           		<div class="content">
					            <xsl:call-template name="textarea-field">
							         <xsl:with-param name="name">bo_comment</xsl:with-param>
							         <xsl:with-param name="rows">13</xsl:with-param>
							         <xsl:with-param name="cols">75</xsl:with-param>
							         <xsl:with-param name="maxlines">500</xsl:with-param>
							         <xsl:with-param name="swift-validate">N</xsl:with-param>
						        </xsl:call-template>
				           </div>
			           	</xsl:otherwise>
			           </xsl:choose>
			           </xsl:with-param>
		          	</xsl:call-template>
          		</xsl:otherwise>
          	</xsl:choose>
	      </xsl:if>
	      
	      
	      
	      <xsl:if test="defaultresource:getResource('VIEW_BANKS_PREVIOUS_COMMENTS') = 'true'">
			      <xsl:if test="bo_comment = '' and tnx_stat_code[.!='04'] and org_parent_file/lc_tnx_record/bo_comment != '' and 
		(product_code[.='LC'] and (org_parent_file/lc_tnx_record/prod_stat_code = '12' or org_parent_file/lc_tnx_record/action_req_code = '12'))">
			      	<xsl:call-template name="big-textarea-wrapper">
								<xsl:with-param name="label">XSL_BO_COMMENT</xsl:with-param>
								<xsl:with-param name="id">previous_bo_comment</xsl:with-param>
								<xsl:with-param name="content">
									<div class="big-textarea-wrapper-content">
										<xsl:value-of select="org_parent_file/lc_tnx_record/bo_comment"/>
									</div>
								</xsl:with-param>
							</xsl:call-template>
			      </xsl:if>
			      
			      
			      <xsl:if test="bo_comment = '' and tnx_stat_code[.!='04'] and org_parent_file/si_tnx_record/bo_comment != '' and 
		(product_code[.='SI'] and (org_parent_file/si_tnx_record/prod_stat_code = '12' or org_parent_file/si_tnx_record/action_req_code = '12'))">
			      	<xsl:call-template name="big-textarea-wrapper">
								<xsl:with-param name="label">XSL_BO_COMMENT</xsl:with-param>
								<xsl:with-param name="id">previous_bo_comment</xsl:with-param>
								<xsl:with-param name="content">
									<div class="big-textarea-wrapper-content">
										<xsl:value-of select="org_parent_file/si_tnx_record/bo_comment"/>
									</div>
								</xsl:with-param>
							</xsl:call-template>
			      </xsl:if>
	      </xsl:if>
	      
	      
	      <xsl:if test="tnx_type_code[.!='24']">
	      <xsl:if test="product_code[.='BG' or .='SI' or .='LC']">
	      <xsl:if test="linked_event_reference!='' and product_code[.!='SI']">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_LINKED_EVENT_REFERENCE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="linked_event_reference"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="sub_tnx_type_code[.='25' or .='62' or .='63'] or prod_stat_code[.='84' or .='87' or .='88']">
	      <xsl:if test="claim_reference!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_reference"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      
	      <xsl:if test="claim_present_date!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_present_date"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="claim_amt!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_AMOUNT_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_cur_code"/>&nbsp;<xsl:value-of select="claim_amt"/>
	           </xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      </xsl:if>
	      </xsl:if>
  		 
          <xsl:if test="action_req_code[.!='']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="localization:getDecode($language, 'N042', action_req_code)"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
         </xsl:if>
           
           <xsl:if test="attachments/attachment[type = '02']">
	           <xsl:call-template name="attachments-file-dojo">
	            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
	            <xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
	            <xsl:with-param name="attachment-group">summarybank</xsl:with-param>
	           </xsl:call-template>
           </xsl:if>
            <xsl:if test="attachments/attachment[type = '07']"> 
	           <xsl:call-template name="attachments-file-dojo">
	            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '07']"/>
	            <xsl:with-param name="legend">XSL_HEADER_AUTO_GENERATED_FILES</xsl:with-param>
	            <xsl:with-param name="attachment-group">optional</xsl:with-param>
	           </xsl:call-template>
	         </xsl:if>
	          <xsl:if test="defaultresource:getResource('SHOW_UPLOADED_SWIFT_FILES') = 'true'">
	         <xsl:if test="attachments/attachment[type = '08']"> 
	           <xsl:call-template name="attachments-file-dojo">
	            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '08']"/>
	            <xsl:with-param name="legend">XSL_HEADER_UPLOADED_SWIFT_FILES</xsl:with-param>
	            <xsl:with-param name="attachment-group">other</xsl:with-param>
	           </xsl:call-template>
	         </xsl:if>
	         </xsl:if>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      </xsl:if>
 
		
		      <!-- Charges -->
      <xsl:choose>
       <xsl:when test="count(charges/charge[created_in_session = 'Y']) != 0 and product_code[.!='LI' and .!='BG' and .!='LC' and .!='BR' and .!='IC' and .!='EL' and .!='EC' and .!='SI' and .!='SR' and .!='IR' and .!='TF' and .!='SG']">
       	<xsl:call-template name="attachments-charges">
       	  <xsl:with-param name="existing-attachments" select="charges/charge"/>
        </xsl:call-template>
       </xsl:when>
       <xsl:when test="count(charges/charge[created_in_session = 'Y']) != 0 and (product_code[.='LI'] or product_code[.='BG'] or product_code[.='LC'] or product_code[.='IC'] or product_code[.='EL'] or product_code[.='EC'] or product_code[.='SI'] or product_code[.='BR'] or product_code[.='SR'] or product_code[.='IR'] or product_code[.='TF']) and security:isCustomer($rundata)">
      	<xsl:call-template name="attachments-charges">
       	 <xsl:with-param name="existing-attachments" select="charges/charge"/>
        </xsl:call-template> 
       </xsl:when>
      </xsl:choose>
		 
      <!-- Return Comments -->
		<xsl:if test="return_comments[.!='']">
				<xsl:if test="product_code[.='EL' or .='IC' or .='BR' or .='IR' or .='SR']">
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
 </xsl:template>
     <xsl:template name="view-mode-extedned-narrative">
    	<xsl:param name="messageValue"/>
    	<xsl:param name="name"/>
   		<xsl:if test="$messageValue!=''">
   		<div class="indented-header">
			<h3 class="toc-item">
				<span class="legend">
				<xsl:choose>
					<xsl:when test = "$name = 'narrative_description_goods'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS_TRANSFER')" /></xsl:when>
					<xsl:when test = "$name = 'narrative_special_beneficiary'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_BENEF_TNF_HEAD')" /></xsl:when>
					<xsl:when test = "$name = 'narrative_special_recvbank'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_RECEIV_TNF_HEAD')" /></xsl:when>
				</xsl:choose>
					<xsl:call-template name="get-button">
						<xsl:with-param name="button-type">extended-narrative</xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select="$name" /></xsl:with-param>
						<xsl:with-param name="messageValue"><xsl:value-of select="$messageValue" /></xsl:with-param>
						<xsl:with-param name="non-dijit-button">Y</xsl:with-param>
					</xsl:call-template>
				</span>
			</h3>				
			<xsl:call-template name="textarea-field">
				<xsl:with-param name="id"><xsl:value-of select="$name" /></xsl:with-param>
				<xsl:with-param name="messageValue"><xsl:value-of select="converttools:displaySwiftNarrative($messageValue, 12)" /></xsl:with-param>
			</xsl:call-template>
		</div>  
		</xsl:if>  
    </xsl:template>
</xsl:stylesheet>