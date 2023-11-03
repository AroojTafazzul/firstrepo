<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to FSCM forms on the customer side. This
stylesheet should be the first thing imported by customer-side
XSLTs.

This should be the first include for forms on the customer side.

Copyright (c) 2000-2016 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      28/09/16
author:    Devika Saraswat
email:     devika.saraswat@misys.com
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
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:fscmTools="xalan://com.misys.portal.openaccount.util.FSCMUtils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization utils security fscmTools defaultresource">

 <xsl:strip-space elements="*"/>
  
 <xsl:param name="up">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
 <xsl:param name="lo">abcdefghijklmnopqrstuvwxyz</xsl:param>

 <!--  Character encoding to use. -->
 <xsl:param name="encoding">
  <xsl:value-of select="localization:getGTPString($language, 'CHARSET')"/>
 </xsl:param>
  
 <!-- Lower-case product code -->
 <xsl:param name="lowercase-product-code">
  <xsl:value-of select="translate($product-code,$up,$lo)"/>
 </xsl:param>
 
 <xsl:variable name="fscm_cash_customization_enable">
  		<xsl:value-of select="defaultresource:getResource('FSCM_CASH_CUSTOMIZATION_ENABLE')"/>
 </xsl:variable>
 
 <xsl:variable name ="totalDiscount" select="fscmTools:getTotalDiscountSingleFinance(//ref_id,//product_code)"/>
  
 <xsl:variable name="collections_amount_configuration">
  		<xsl:value-of select="defaultresource:getResource('FSCM_COLLECTIONS_SETTLEMENTAMOUNT_EXCEEDS_OUTSTANDINGAMOUNT_ENABLE')"/>
 </xsl:variable>
  	
 <xsl:variable name ="thresholdAmount" select="fscmTools:calculateCollectionThresholdAmount(//ref_id,//product_code)"/>
  	
<!-- Common Includes	 -->	
<xsl:include href="form_templates.xsl" />
<xsl:include href="fx_common.xsl"/>
<xsl:include href="com_cross_references.xsl"/>

<!-- General Details fields, common to FSCM forms on the customer side.System ID, Customer Reference, Invoice Reference, Application Date, Invoice Date and Due Date -->
<xsl:template name="fscm-general-details">
	<xsl:param name="override-displaymode" select="$displaymode"/>
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		<xsl:variable name="show-cust-ref-id">Y</xsl:variable>
	 	<xsl:variable name="show-bo-ref-id">Y</xsl:variable>
	 	<xsl:variable name="show-template">
	 		<xsl:choose>
	 			<xsl:when test="product_code = 'CN' or product_code = 'CR'">Y</xsl:when>
	 			<xsl:otherwise>N</xsl:otherwise>
	 		</xsl:choose>
	 	</xsl:variable>
	   	<!-- Hidden fields. -->
	 	<xsl:variable name="override-cust-ref-id-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:variable>
	    <xsl:call-template name="hidden-field">
	   		 <xsl:with-param name="name">ref_id</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="localization-dialog"/>
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
		    <xsl:with-param name="value" select="ref_id" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:if test="prod_stat_code[.='D7' or .='D8' or .='D9'] and bulk_ref_id != ''">
		    <xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>
				<xsl:with-param name="id">bulk_ref_id</xsl:with-param>
				<xsl:with-param name="value" select="bulk_ref_id" />
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	    
	    <!-- Template ID. -->
	   <xsl:if test="$show-template='Y'">
		    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
			     <xsl:with-param name="name">template_id</xsl:with-param>
			     <xsl:with-param name="size">15</xsl:with-param>
			     <xsl:with-param name="maxsize">20</xsl:with-param>
			     <xsl:with-param name="fieldsize">small</xsl:with-param>
		    </xsl:call-template>
	   </xsl:if>
	    <!-- Customer reference -->
	    <xsl:if test="$show-cust-ref-id='Y'">
		    <xsl:call-template name="input-field">
			     <xsl:with-param name="label"><xsl:value-of select="$override-cust-ref-id-label"/></xsl:with-param>
			     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
			     <xsl:with-param name="size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_LENGTH')"/></xsl:with-param>
			     <xsl:with-param name="maxsize">64</xsl:with-param>
			     <xsl:with-param name="regular-expression">
			     	<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_FSCM_VALIDATION_REGEX')"/>
			     </xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
			     <xsl:with-param name="fieldsize">small</xsl:with-param>
			     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		    </xsl:call-template>
	    </xsl:if>
	    <!-- Bank Reference -->
  		<!-- Shown in consolidated view -->
	    <xsl:if test="$show-bo-ref-id='Y' and $displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
		    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
		     <xsl:with-param name="value" select="bo_ref_id" />
		    </xsl:call-template>
	    </xsl:if>
	    <xsl:choose>
	    	<xsl:when test="product_code = 'IN' or product_code = 'IP'">
	    		<!-- Invoice reference -->
				<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_REFERENCE</xsl:with-param>
				     <xsl:with-param name="name">issuer_ref_id</xsl:with-param>
				     <xsl:with-param name="size">35</xsl:with-param>
				     <xsl:with-param name="maxsize">35</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
				</xsl:call-template>
	    	</xsl:when>
	    	<xsl:when test="product_code = 'CN' or product_code = 'CR'">
	    		<!-- Credit Note Reference -->
	 			<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_CN_REFERENCE</xsl:with-param>
				     <xsl:with-param name="name">cn_reference</xsl:with-param>
				     <xsl:with-param name="size">20</xsl:with-param>
				     <xsl:with-param name="maxsize">16</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
	    	</xsl:when>
	    </xsl:choose>
	    
	    	 <!-- Cross Refs -->
  			 <!-- Shown in consolidated view  -->
		   <xsl:if test="cross_references">
		   	 <xsl:choose>
		      <xsl:when test="product_code[.='IP']">
		       <xsl:apply-templates select="cross_references" mode="display_table_master"/>
		      </xsl:when>
		      <xsl:otherwise>
		     <xsl:apply-templates select="cross_references" mode="display_table_tnx">
		    </xsl:apply-templates>
		    </xsl:otherwise>
		    </xsl:choose>
		   </xsl:if>
		
		<!-- Bulk reference -->
		<xsl:if test="$displaymode!='edit'">
			<xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>
			     <xsl:with-param name="name">bulk_ref_id</xsl:with-param>
			     <xsl:with-param name="size">35</xsl:with-param>
			     <xsl:with-param name="maxsize">35</xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
	    <!--  Application date. -->
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		     <xsl:with-param name="id">appl_date_view</xsl:with-param>
		     <xsl:with-param name="value" select="appl_date" />
		     <xsl:with-param name="type">date</xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:if test="product_code = 'IN' or product_code = 'IP'">
	    	<!--  Invoice Date -->
		    <xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_DATE</xsl:with-param>
				<xsl:with-param name="name">iss_date</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
			</xsl:call-template>
			<!-- Hidden Invoice Date -->
			<xsl:call-template name="hidden-field">
		   		 <xsl:with-param name="name">inv_date</xsl:with-param>
		   		 <xsl:with-param name="value" select="iss_date" />
		   		 <xsl:with-param name="type">date</xsl:with-param>
		    </xsl:call-template>
			<!-- Due Date -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_DUE_DATE</xsl:with-param>
				<xsl:with-param name="name">due_date</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
			</xsl:call-template>
	    </xsl:if>
	    
	    <xsl:if test="tnx_type_code = '85'">
	    <!-- Invoice Settlement Date (here)  -->
		 	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_SETTLEMENT_DATE</xsl:with-param>
				<xsl:with-param name="name">settlement_date</xsl:with-param>
				<xsl:with-param name="id">settlement_date</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template> 
  
			<!-- Invoice Amount (here)-->
			<xsl:call-template name="currency-field"> 
					<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_AMOUNT</xsl:with-param>
	      			<xsl:with-param name="product-code">collections</xsl:with-param>
	      			<xsl:with-param name="show-amt">Y</xsl:with-param>
	      			<xsl:with-param name="override-currency-value"><xsl:value-of select="total_net_cur_code"/></xsl:with-param>
	      			<xsl:with-param name="override-amt-value"><xsl:value-of select="total_net_amt"/></xsl:with-param>
	      			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	      			<xsl:with-param name="swift-validate">N</xsl:with-param>
	      			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
	      			<xsl:with-param name="show-button">N</xsl:with-param>
	      			<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	      			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	    	</xsl:call-template>
	    	<xsl:call-template name="hidden-field">
		   		 <xsl:with-param name="name">collections_amt</xsl:with-param>
		   		 <xsl:with-param name="value" select="total_net_amt" />
		   		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    </xsl:call-template>
	   	</xsl:if>
		<xsl:call-template name="seller-programme-buyer-details">
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
	</xsl:with-param>
 </xsl:call-template>		
</xsl:template>

<!-- seller-programme-buyer Details --> 
<xsl:template name="seller-programme-buyer-details">
	<!-- Seller Details -->
	<xsl:if test="product_code = 'IN' or product_code = 'CN'">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="tnx_type_code = '85'">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="product_code = 'IP' or product_code = 'CR'">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="tnx_type_code = '85'">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
						</xsl:call-template>	
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>		
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<!-- Programme Details -->

	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_PROGRAMME_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
		<xsl:choose>
			<xsl:when test="$displaymode='edit' and tnx_type_code != '85'">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
					<xsl:with-param name="name">program_name</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="//program_name"/></xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="button-type">fscm_programme</xsl:with-param>
					<xsl:with-param name="prefix">fscm_programme</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
					<xsl:with-param name="name">program_name</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="//program_name"/></xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
	<!-- Buyer Details -->
	<xsl:if test="product_code = 'IN' or product_code = 'CN'">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="tnx_type_code = '85'">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">Y</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">Y</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="product_code = 'IP' or product_code = 'CR'">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="tnx_type_code = '85'">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">Y</xsl:with-param>					
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">Y</xsl:with-param>					
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
	<!-- Display other parties -->
	<xsl:if test="$displaymode='edit' and (product_code[.= 'IN' or .= 'IP'] and sub_product_code != 'SMP' and tnx_type_code != '85')">
		<xsl:call-template name="multichoice-field">
	    	<xsl:with-param name="label">XSL_INVOICE_PAYABLE_DISPLAY_OTHER_PARTIES</xsl:with-param>
	    	<xsl:with-param name="type">checkbox</xsl:with-param>
	    	<xsl:with-param name="name">display_other_parties</xsl:with-param>
	    	<xsl:with-param name="checked"><xsl:if test="bill_to_name[. != ''] or ship_to_name[. != ''] or consgn_to_name[. != '']">Y</xsl:if></xsl:with-param>
		</xsl:call-template>
	<!-- Other parties Tabgroup. Tab0 - Bill To Tab1 - Ship To Tab2 - Consignee -->
	<xsl:call-template name="tabgroup-wrapper">
		<xsl:with-param name="tabgroup-id">other_parties_section</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<!--  Tab 0_0 - Bill To  -->
		<xsl:with-param name="tab0-label">XSL_HEADER_BILL_TO_DETAILS</xsl:with-param>
		<xsl:with-param name="tab0-content">
			<xsl:call-template name="party-details">
				<xsl:with-param name="prefix">bill_to</xsl:with-param>
				<xsl:with-param name="show-button">Y</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
		<!--  Tab 0_1 - Ship To -->
		<xsl:with-param name="tab1-label">XSL_HEADER_SHIP_TO_DETAILS</xsl:with-param>
		<xsl:with-param name="tab1-content">
			<xsl:call-template name="party-details">
				<xsl:with-param name="prefix">ship_to</xsl:with-param>
				<xsl:with-param name="show-button">Y</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
		<!--  Tab 0_2 - Consignee -->
		<xsl:with-param name="tab2-label">XSL_HEADER_CONSIGNEE_DETAILS</xsl:with-param>
		<xsl:with-param name="tab2-content">
			<xsl:call-template name="party-details">
				<xsl:with-param name="prefix">consgn</xsl:with-param>
				<xsl:with-param name="show-button">Y</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:if>	
</xsl:template>

<!-- ****************************************************************** -->
				<!-- CREDIT NOTE Templates :: START -->
<!-- ****************************************************************** -->

 	<!--  Bank Details Fieldset. -->
	<xsl:template name="fscm-bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test = "product_code = 'CN'" >
						<xsl:call-template name="issuing-bank-tabcontent">
							<xsl:with-param name="sender-name">seller</xsl:with-param>
							<xsl:with-param name="sender-reference-name">seller_reference</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test = "product_code = 'CR'" >
						<xsl:call-template name="issuing-bank-tabcontent">
							<xsl:with-param name="sender-name">buyer</xsl:with-param>
							<xsl:with-param name="sender-reference-name">buyer_reference</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="credit-note-amount-details">
	<xsl:param name="amount-product-code"/>
		<div>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<div>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_CN_AMOUNT</xsl:with-param>
						<xsl:with-param name="product-code"><xsl:value-of select="$amount-product-code"/></xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-button">Y</xsl:with-param>
					</xsl:call-template>	
				</div>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
	<xsl:template name="credit_note_invoices">
		<script type="text/javascript">
			var invoiceItems =[];
			<xsl:for-each select="invoice-items/invoice">
				var refInv = "<xsl:value-of select="invoice_ref_id"/>";
				invoiceItems.push({ "REFERENCEID" :"<xsl:value-of select="invoice_ref_id"/>","INVOICE_REFERENCE":"<xsl:value-of select="invoice_reference"/>","CURCODE" :"<xsl:value-of select="invoice_currency"/>","INVOICE_AMOUNT" :"<xsl:value-of select="invoice_amount"/>","INVOICE_SETTLEMENT_AMT" :"<xsl:value-of select="invoice_settlement_amt"/>", "ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteInvoiceRecord(refInv)\"/>]]>"});
			</xsl:for-each>	
		</script>
	</xsl:template>
<!-- Invoice addition to Credit Note -->
	<xsl:template name="invoice-items-declaration">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INVOICE_ITEMS</xsl:with-param>
			<xsl:with-param name="content">
				<div id="invoice-items-template">
					<div class="clear multigrid">
						<script type="text/javascript">
							var gridLayoutInvoice, pluginsData;
							dojo.ready(function(){
						    	gridLayoutInvoice = {"cells" : [
						                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "REFERENCEID", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "INVOICE_REFERENCE", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "CURCODE", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')"/>", "field": "INVOICE_AMOUNT", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'CREDIT_NOTE_AMOUNT')"/>", "field":"INVOICE_SETTLEMENT_AMT", "type": dojox.grid.cells._Widget, "width": "15%", "styles":"white-space:nowrap;text-align: center;"}
						                   <xsl:if test="$displaymode='edit'">
						                   		,{ "noresize":"true", "name": "&nbsp;", "field": "ACTION", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "formatter": misys.grid.formatHTML}
						                    ]
						                   </xsl:if>
						        ]};
								pluginsData = {indirectSelection: {headerSelector: "false",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
							});
						</script>
						<div style="width:100%;height:100%;" class="widgetContainer clear">
						<xsl:if test="$mode='DRAFT' and  $displaymode = 'edit'">
							<table class="grid" plugins="pluginsData" structure="gridLayoutInvoice"
								autoHeight="true" id="gridInvoice" dojoType="dojox.grid.EnhancedGrid" selectionMode="none" selectable="false" singleClickEdit="true"
								noDataMessage="{localization:getGTPString($language, 'XSL_CN_NO_INVOICE_ITEM')}" 
								escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
								<thead>
									<tr></tr>
								</thead>
								<tfoot>
									<tr><td></td></tr>
								</tfoot>
								<tbody>
									<tr><td></td></tr>
								</tbody>
							</table>
						</xsl:if> 
						 <xsl:choose>
	
						 <xsl:when test="$mode='DRAFT' and  $displaymode = 'edit'">
							<table class="grid" plugins="pluginsData" structure="gridLayoutInvoice"
								autoHeight="true" id="gridInvoice" dojoType="dojox.grid.EnhancedGrid" selectionMode="none" selectable="false" singleClickEdit="true"
								noDataMessage="{localization:getGTPString($language, 'XSL_CN_NO_INVOICE_ITEM')}" 
								escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
								<thead>
									<tr></tr>
								</thead>
								<tfoot>
									<tr><td></td></tr>
								</tfoot>
								<tbody>
									<tr><td></td></tr>
								</tbody>
							</table>
						</xsl:when>
						<xsl:otherwise>
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
						     <xsl:attribute name="id">invoice_table</xsl:attribute>
						      <xsl:choose>
						      	<xsl:when test="invoice-items/invoice">
							      <thead>
							       <tr>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')"/></th>
							       	<th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CREDIT_NOTE_AMOUNT')"/></th>
							       </tr>
							      </thead>
							      <tbody>
									<xsl:attribute name="id">invoice_table_details</xsl:attribute>      
							         <xsl:for-each select="invoice-items/invoice">
							          <tr>
							         	<td><xsl:value-of select="invoice_ref_id"/></td>
							           	<td><xsl:value-of select="invoice_reference"/></td>
							           	<td><xsl:value-of select="invoice_currency"/></td>
							           	<td><xsl:value-of select="invoice_amount"/></td>
							    		<td><xsl:value-of select="invoice_settlement_amt"/></td>							           	
							          </tr>
							         </xsl:for-each>
							      </tbody>
							    </xsl:when>
							    <xsl:otherwise>
							      	<div><xsl:value-of select="localization:getGTPString($language, 'XSL_CN_NO_INVOICE_ITEM')"/></div>
							      	<tbody></tbody>
							    </xsl:otherwise>
						      </xsl:choose>
						     </table>
						</xsl:otherwise>
						</xsl:choose> 
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
						<xsl:if test="$displaymode='edit'">
						<div id="invoice-items-add" class="widgetContainer">
							<div id="invoice_lookup" type="button" dojoType="dijit.form.Button">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_ADD_INVOICE_ITEM')" />
							</div>
						</div>
						</xsl:if>	
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="message-freeFormat">
  	<xsl:param name="required">N</xsl:param>
  	<xsl:param name="value"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_FREE_FORMAT</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">free_format_text</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="rows">12</xsl:with-param>
        <xsl:with-param name="maxlines">35</xsl:with-param>
        <xsl:with-param name="cols">50</xsl:with-param>
        <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="$value"/></xsl:with-param>
        <xsl:with-param name="override-displaymode">
        	<xsl:choose>
        		<xsl:when test="$mode ='ACCEPT' or $displaymode = 'edit'">edit</xsl:when>
        		<xsl:otherwise>view</xsl:otherwise>
        	</xsl:choose>
        	</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template> 
  </xsl:template>
  
  <xsl:template name="bo-comments">
  	<xsl:param name="bo_comment"/>
  	<xsl:if test="bo_comment[.!='']">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_MESSAGE</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				    <xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT</xsl:with-param>
					    <xsl:with-param name="id">bo_comment_view</xsl:with-param>
					    <xsl:with-param name="value" select="bo_comment" />
					    <xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">bo_comment</xsl:with-param>
			<xsl:with-param name="value" select="bo_comment" />
		</xsl:call-template>
	</xsl:if>
  </xsl:template>

<!-- ****************************************************************** -->
				<!-- CREDIT NOTE Templates :: END -->
<!-- ****************************************************************** -->

<!-- ****************************************************************** -->
				<!-- Collections Templates :: START -->
<!-- ****************************************************************** -->

<!-- Settlement Amount Details (here) -->
	<xsl:template name="settlement-amount-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_SETTLEMENT_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			 <xsl:if test=" ($fscm_cash_customization_enable = 'true') and collection_discount_flag and collection_discount_flag !='Y' ">
				 <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_DISCOUNT_AMOUNT</xsl:with-param>
				     <xsl:with-param name="name">total_discount</xsl:with-param>
				      <xsl:with-param name="id">total_discount</xsl:with-param>
				     <xsl:with-param name="value" select = "$totalDiscount"/>
				     <xsl:with-param name="size">3</xsl:with-param>
				     <xsl:with-param name="maxsize">5</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="readonly">Y</xsl:with-param>
				     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
				<xsl:if test="liab_total_net_amt[.!='']">				
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_OUTSTANDING_AMOUNT</xsl:with-param>
					 	<xsl:with-param name="product-code">liab_total_net</xsl:with-param>
					 	<xsl:with-param name="override-currency-value"><xsl:value-of select="total_net_cur_code"/></xsl:with-param>
					 	<xsl:with-param name="override-amt-value">
	
						<xsl:value-of select="liab_total_net_amt"/>
							
						</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="amt-readonly">N</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
					</xsl:call-template>
					
				</xsl:if>		
				<xsl:choose>
					<xsl:when test="$option = 'FULL' or $option = 'DETAILS'">					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SETTLEMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="settlement_cur_code"/>&nbsp;<xsl:value-of select="settlement_amt"/></xsl:with-param>
							<xsl:with-param name="name">settlement_amt_input_field</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
					<xsl:if test="$displaymode = 'edit'">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_SETTLEMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="product-code">settlement</xsl:with-param>
				 			<xsl:with-param name="override-amt-value">
							
							<xsl:value-of select="settlement_amt"/>
								
						</xsl:with-param>  
							<xsl:with-param name="currency-readonly">N</xsl:with-param>
							<xsl:with-param name="amt-readonly">N</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>	
							<xsl:with-param name="required">Y</xsl:with-param>						
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="$displaymode = 'view'">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_SETTLEMENT_AMOUNT</xsl:with-param>
						 	<xsl:with-param name="product-code">settlement</xsl:with-param>
							<xsl:with-param name="currency-readonly">Y</xsl:with-param>
							<xsl:with-param name="amt-readonly">Y</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<!-- Added as part of MPS-51375 for settlement amount calculations in collections, value fetched from dic from portlets -->
						<xsl:if test="tnx_type_code and tnx_type_code = '85'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">invoice_outstanding_amt</xsl:with-param>
						 </xsl:call-template>
						 </xsl:if>
					</xsl:otherwise>
				</xsl:choose>		
				<div>
			     	  <xsl:call-template name="input-field">
				          <xsl:with-param name="label">XSL_SETTLEMENT_PERCENTAGE</xsl:with-param>
				          <xsl:with-param name="name">settlement_percentage</xsl:with-param>
				     	  <xsl:with-param name="type">decimal</xsl:with-param> 
				          <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				          <xsl:with-param name="swift-validate">N</xsl:with-param>
				          <xsl:with-param name="size">2</xsl:with-param>
				          <xsl:with-param name="maxsize">6</xsl:with-param>
				           <xsl:with-param name="override-constraints">{places:'0,2',max:999.99}</xsl:with-param>  
				  		  <xsl:with-param name="content-after">%</xsl:with-param>
				          <xsl:with-param name="appendClass">block</xsl:with-param>
			         </xsl:call-template>
				</div>
				        <xsl:if test="$collections_amount_configuration">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">threshold_amount</xsl:with-param>
						        <xsl:with-param name="value" ><xsl:value-of select="$thresholdAmount"/></xsl:with-param>							
						   </xsl:call-template>
						</xsl:if>
						
						  <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">collectionAmountConfig</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$collections_amount_configuration"/></xsl:with-param>							
						 </xsl:call-template>
						
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- FX Snippets Start -->
	<xsl:template name="exchange-rate-details">
		<xsl:if test="$displaymode='edit'and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']"> 
			<xsl:call-template name="fx-template"/>
		</xsl:if>
		<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
			<xsl:call-template name="fx-details-for-view" /> 
		</xsl:if>
	</xsl:template>
	<!-- FX Snippets End -->
	
	<xsl:template name="instructions-for-bank">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_INSTRUCTIONS_FOR_THE_BANK</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:choose>
				<xsl:when test="$displaymode='edit'">
				     <xsl:call-template name="row-wrapper">
				      	  <xsl:with-param name="id">instructions_for_the_bank</xsl:with-param>				         
					      <xsl:with-param name="required">N</xsl:with-param>
					      <xsl:with-param name="type">textarea</xsl:with-param>
					      <xsl:with-param name="content">
						       <xsl:call-template name="textarea-field">
						        <xsl:with-param name="name">free_format_text</xsl:with-param>
						        <xsl:with-param name="rows">5</xsl:with-param>
						        <xsl:with-param name="cols">35</xsl:with-param>
						        <xsl:with-param name="required">N</xsl:with-param>
						       </xsl:call-template>
				      	  </xsl:with-param>
				    </xsl:call-template>
				</xsl:when>
			    <xsl:when test="$displaymode='view' and free_format_text[.!='']">
			     	<xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="free_format_text"/>
					      </div></xsl:with-param>
				     </xsl:call-template>
			    </xsl:when>
			    </xsl:choose>
		   </xsl:with-param>
	  </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="instructions-from-bank">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_INSTRUCTIONS_FROM_THE_BANK</xsl:with-param>
			<xsl:with-param name="content">				
			    <xsl:if test="$displaymode='view' and bo_comment[.!='']">
			     	<xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="bo_comment"/>
					      </div></xsl:with-param>
				     </xsl:call-template>
			    </xsl:if>
		   </xsl:with-param>
	  </xsl:call-template>
	</xsl:template>

	<!-- Credit Note addition to Invoice-->
	<xsl:template name="credit-Note-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CREDIT_NOTE_DETALS</xsl:with-param>
			<xsl:with-param name="content">
				<div id="credit-note-details-template">
					<div class="clear multigrid">

						<xsl:if test="$displaymode = 'view'">
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
						     <xsl:attribute name="id">invoice_table</xsl:attribute>
						      <xsl:choose>
						      	<xsl:when test="credit-note-items/credit-note">
							      <thead>
							       <tr>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CREDIT_NOTE_REFERENCE_LABEL')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CREDIT_NOTE_SETTLED_AMOUNT')"/></th>
							       </tr>
							      </thead>
							      <tbody>
									<xsl:attribute name="id">credit_note_table_details</xsl:attribute>      
							         <xsl:for-each select="credit-note-items/credit-note">
							          <tr>
							         	<td><xsl:value-of select="ref_id"/></td>
							           	<td><xsl:value-of select="credit_note_reference"/></td>
							           	<td><xsl:value-of select="invoice_currency"/></td>
							           	<td><xsl:value-of select="invoice_settlement_amt"/></td>							           	
							          </tr>
							         </xsl:for-each>
							      </tbody>
							    </xsl:when>
							    <xsl:otherwise>
							      	<div><xsl:value-of select="localization:getGTPString($language, 'XSL_IN_NO_CN_ITEM')"/></div>
							      	<tbody></tbody>
							    </xsl:otherwise>
						      </xsl:choose>
						     </table>
							</xsl:if>
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
					</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- ****************************************************************** -->
				<!-- Collections Templates :: END -->
<!-- ****************************************************************** -->
</xsl:stylesheet>
