<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		exclude-result-prefixes="localization securityCheck">
		
<!--
   Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->


	<xsl:include href="po_common.xsl"/>
		
	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	

	<!--
		Global Parameters. These are used in the imported XSL, and to set
		global params in the JS
	-->
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<!--
		set to none, counterparty or bank, depending on whether we are in a
		collab summary screen
	-->
	<xsl:param name="product-code">SO</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/SellOrderScreen</xsl:param>

	<!-- if value = 'TEMPLATE', open all dynamic input forms -->
	<xsl:param name="option" />

	
	<!-- All marks used to shown/hidden form's sections-->
	
	<xsl:param name="section_po_line_items"/>
	<xsl:param name="section_po_amount_details"/>
	<xsl:param name="section_po_payment_terms"/>
	<xsl:param name="section_po_settlement_terms"/>
	<xsl:param name="section_po_documents_required"/>
	<xsl:param name="section_po_shipment_details"/>
	<xsl:param name="section_po_inco_terms"/>
	<xsl:param name="section_po_routing_summary"/>
	<xsl:param name="section_po_user_info"/>
	<xsl:param name="section_po_contact"/>
	
	<xsl:param name="section_line_item_po_reference" />
	<xsl:param name="section_line_item_adjustments_details" />
	<xsl:param name="section_line_item_taxes_details" />
	<xsl:param name="section_line_item_freight_charges_details" />
	<xsl:param name="section_line_item_shipment_details" />
	<xsl:param name="section_line_item_inco_terms_details" />
	<xsl:param name="section_line_item_total_net_amount_details" />
	<xsl:param name="section_line_item_routing_summary">N</xsl:param>
	<xsl:param name="section_shipment_sub_schedule"/>	
	<!-- <xsl:param name="section_li_product"/>
	<xsl:param name="section_li_amount_details"/>
	<xsl:param name="section_li_shipment_details"/>
	<xsl:param name="section_li_inco_terms"/>
	<xsl:param name="section_li_routing_summary"/>-->
	
	<xsl:output method="html" version="4.01" indent="no"
		encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="so_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="so_tnx_record">
		
		<!-- Preloader  -->
		<xsl:call-template name="loading-message" />

		<!-- ***************************** -->
		<!-- Widgets' template declaration -->
		<!-- ***************************** -->
		<!-- Line Items declaration -->
		<xsl:call-template name="line-items-declaration" />
		<!-- Product Identifiers declaration -->
		<xsl:call-template name="product-identifiers-declaration" />
		<!-- Product Categories declaration -->
		<xsl:call-template name="product-categories-declaration" />
		<!-- Product Characteristics declaration -->
		<xsl:call-template name="product-characteristics-declaration" />
		<!-- Adjustments declaration -->
		<xsl:call-template name="adjustments-declaration" />
		<!-- Payments declaration -->
		<xsl:call-template name="payment-terms-declaration" />
		<!-- Taxes declaration -->
		<xsl:call-template name="taxes-declaration" />
		<!-- Freight Charges declaration -->
		<xsl:call-template name="freight-charges-declaration" />
		<!-- Incoterms declaration -->
		<xsl:call-template name="incoterms-declaration" />
		<!-- User defined informations declaration buyer -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">01</xsl:with-param>
		</xsl:call-template>
		<!-- User defined informations declaration seller -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">02</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="contact-details-declaration" />
		
		<xsl:call-template name="routing-summary-declaration" />
 					
		<!-- ************************** -->
		<!-- Purchase Order Advice form -->
		<!-- ************************** -->
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!--  Display common menu.  -->
					<xsl:call-template name="menu" >
						<xsl:with-param name="show-template">N</xsl:with-param>
						<xsl:with-param name="show-return">Y</xsl:with-param>
					</xsl:call-template>
					
					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references"
						mode="hidden_form" />
						
					<xsl:call-template name="hidden-fields" />
					<xsl:call-template name="general-details" />

					<!-- Early payment condition -->
					<xsl:call-template name="early-payment" />

					<!-- Free Format Message -->
					<xsl:call-template name="message-freeformat" />
  
					<xsl:call-template name="view-details" />
 					
				</xsl:with-param>
			</xsl:call-template>
	
		</div>

		<!-- Table of Contents -->
		<xsl:call-template name="toc" />

		<!--  Collaboration Window  -->
		<xsl:call-template name="collaboration">
			<xsl:with-param name="editable">true</xsl:with-param>
			<xsl:with-param name="productCode">
				<xsl:value-of select="$product-code" />
			</xsl:with-param>
			<xsl:with-param name="contextPath">
				<xsl:value-of select="$contextPath" />
			</xsl:with-param>
			<xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>

		<!-- Display common menu, this time outside the form -->
		<xsl:call-template name="menu">
			<xsl:with-param name="second-menu">Y</xsl:with-param>
			<xsl:with-param name="show-template">N</xsl:with-param>
			<xsl:with-param name="show-return">Y</xsl:with-param>
		</xsl:call-template>
		<!-- The form that's submitted -->
		<xsl:call-template name="realform" />

		<!-- Javascript and Dojo imports  -->
		<xsl:call-template name="js-imports" />

	</xsl:template>
		
		
	<!--                                     -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_so</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<xsl:if test="$displaymode='view'">
			<!-- This field is sent in the unsigned view -->
			<div class="widgetContainer">
<!-- 	tid		 -->
<!-- 				<xsl:call-template name="hidden-field"> -->
<!-- 					<xsl:with-param name="name">tid</xsl:with-param> -->
<!-- 				</xsl:call-template> -->
			</div>
		</xsl:if>
	</xsl:template>
	
	
	<!--
		General Details Fieldset. 
		-->
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="button-type">summary-full</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="common-general-details" >
					<xsl:with-param name="show-template-id">N</xsl:with-param>
					<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
					<xsl:with-param name="name">iss_date</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				
				<!--Seller ref id -->
			      <xsl:call-template name="input-field">
			       <xsl:with-param name="label">XSL_GENERALDETAILS_SELLER_REF_ID</xsl:with-param>
			       <xsl:with-param name="name">cust_ref_id</xsl:with-param>
			       <xsl:with-param name="fieldsize">small</xsl:with-param>
			      </xsl:call-template>
			     
			     
				 <!--Buyer ref id -->
			     <xsl:if test="issuer_ref_id[.!='']">
			      <xsl:call-template name="input-field">
			       <xsl:with-param name="label">XSL_GENERALDETAILS_BUYER_REF_ID</xsl:with-param>
			       <xsl:with-param name="id">issuer_ref_id_view</xsl:with-param>
			       <xsl:with-param name="value" select="issuer_ref_id"/>
			       <xsl:with-param name="override-displaymode">view</xsl:with-param>
			      </xsl:call-template>
			      <xsl:if test="$displaymode='edit'">
			       <xsl:call-template name="hidden-field">
			        <xsl:with-param name="name">iss_date</xsl:with-param>
			       </xsl:call-template>
			      </xsl:if>
			     </xsl:if>
			     
			      <!--Order Status -->
			     <xsl:call-template name="select-field">
			       <xsl:with-param name="label">XSL_PURCHASE_ORDER_STATUS</xsl:with-param>
			       <xsl:with-param name="name">prod_stat_code</xsl:with-param>
				      <xsl:with-param name="required">Y</xsl:with-param>
				      <xsl:with-param name="options">
				       <xsl:choose>
					    <xsl:when test="$displaymode='edit'">
					       <option value ="">
					       </option>
						   <option value="55">
						    <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/>
						   </option>
					       <option value="01">
					        <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_PURCHASE_ORDER_REJECTED')"/>
					       </option>
					    </xsl:when>
					    <xsl:otherwise>
					     <xsl:choose>
				          <xsl:when test="sub_tnx_type_code[.='55']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
				          <xsl:when test="sub_tnx_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_PURCHASE_ORDER_REJECTED')"/></xsl:when>
				         </xsl:choose>
					    </xsl:otherwise>
					   </xsl:choose>
				      </xsl:with-param>
				     </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template name="early-payment" >
		<xsl:if test="counterparty_early_payment_conds[.!='']">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_BUYER_ADVANCE_PAYMENT_CONDITIONS</xsl:with-param>
				<xsl:with-param name="content">	
				
					<div>
						<p><xsl:value-of select="localization:getGTPString($language, 'XSL_SO_EARLY_PAYMENT_DESCRIPTION')"/></p>
					</div>
									
					<xsl:call-template name="textarea-field">
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="name">counterparty_early_payment_conds</xsl:with-param>
					</xsl:call-template>		
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>	



	<xsl:template name="view-details" >
	<div id="hidden-view" >
		<xsl:if test="$displaymode='edit'">
			<xsl:attribute name="style">display:none</xsl:attribute>
		</xsl:if>
		<!-- Seller Details -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">
				indented-header
			</xsl:with-param>
			<xsl:with-param name="button-type">
				seller
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="show-BEI">Y</xsl:with-param>
					<xsl:with-param name="prefix">seller</xsl:with-param>
					<xsl:with-param name="show-reference">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	
		<!-- Buyer Details -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="show-entity">Y</xsl:with-param>
					<xsl:with-param name="show-BEI">Y</xsl:with-param>
					<xsl:with-param name="prefix">buyer</xsl:with-param>
				</xsl:call-template>
				<!--
					If we have to, we show the reference field for applicants. This is
					specific to this form.
				-->
				<xsl:if
					test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
						<xsl:with-param name="name">buyer_reference</xsl:with-param>
						<xsl:with-param name="maxsize">64</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>


		<!-- Display other parties -->
		<xsl:if test="$displaymode='edit'">
		<xsl:call-template name="checkbox-field">
			<xsl:with-param name="name">display_other_parties</xsl:with-param>
			<xsl:with-param name="label">XSL_PURCHASE_ORDER_DISPLAY_OTHER_PARTIES</xsl:with-param>
			<xsl:with-param name="checked"><xsl:if test="bill_to_name[. != ''] or ship_to_name[. != ''] or consgn_to_name[. != '']">Y</xsl:if></xsl:with-param>
		</xsl:call-template>
		</xsl:if>
	
	
	
		<!--
			Other parties Tabgroup. Tab0 - Bill To Tab1 - Ship To Tab2 -
			Consignee
		-->
		<xsl:call-template name="tabgroup-wrapper">
			<xsl:with-param name="tabgroup-id">other_parties_section</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<!--  Tab 0_0 - Bill To  -->
			<xsl:with-param name="tab0-label">XSL_HEADER_BILL_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab0-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">bill_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<!--  Tab 0_1 - Ship To -->
			<xsl:with-param name="tab1-label">XSL_HEADER_SHIP_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab1-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">ship_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<!--  Tab 0_2 - Consignee -->
			<xsl:with-param name="tab2-label">XSL_HEADER_CONSIGNEE_DETAILS</xsl:with-param>
			<xsl:with-param name="tab2-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">consgn</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
				
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="textarea-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
					<xsl:with-param name="name">goods_desc</xsl:with-param>
				</xsl:call-template>
	
				<!-- line Item Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
							&nbsp;
						<!-- Line items grid -->
						<xsl:call-template name="build-line-items-dojo-items">
							<xsl:with-param name="items" select="line_items/lt_tnx_record" />
						</xsl:call-template>
							&nbsp;
						<!-- Total Goods Amount -->
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
							<xsl:with-param name="product-code">total</xsl:with-param>
							<xsl:with-param name="override-currency-name">fake_total_cur_code</xsl:with-param>
							<xsl:with-param name="override-amt-name">fake_total_amt</xsl:with-param>
						</xsl:call-template>
						
					</xsl:with-param>
				</xsl:call-template>
	
	
			</xsl:with-param>
		</xsl:call-template>

		<!-- Amount details -->		
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
					&nbsp;
				<!-- Adjustments -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_ADJUSTMENTS_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<xsl:call-template name="build-adjustments-dojo-items">
							<xsl:with-param name="items" select="adjustments/adjustment" />
							<xsl:with-param name="id">po-adjustments</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>

				<!-- Taxes -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_TAXES_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
							&nbsp;
						<xsl:call-template name="build-taxes-dojo-items">
							<xsl:with-param name="items" select="taxes/tax" />
							<xsl:with-param name="id">po-taxes</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>

				<!-- Freight charges -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_FREIGHT_CHARGES_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<!-- Price unit measure code -->
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
							<xsl:with-param name="name">freight_charges_type</xsl:with-param>
							<xsl:with-param name="options">
							 <xsl:choose>
        						<xsl:when test="$displaymode='edit'">
								<option value="CLCT">
									<xsl:value-of
										select="localization:getDecode($language, 'N211', 'CLCT')" />
									<xsl:if test="freight_charges_type[. = 'CLCT']">
										<xsl:attribute name="selected" />
									</xsl:if>
								</option>
								<option value="PRPD">
									<xsl:value-of
										select="localization:getDecode($language, 'N211', 'PRPD')" />
									<xsl:if test="freight_charges_type[. = 'PRPD']">
										<xsl:attribute name="selected" />
									</xsl:if>
								</option>
								 </xsl:when>
						        <xsl:otherwise>
						         <xsl:choose>
						          <xsl:when test="freight_charges_type[. = 'CLCT']"><xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')" /></xsl:when>
						          <xsl:when test="freight_charges_type[. = 'PRPD']"><xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')" /></xsl:when>
						         </xsl:choose>
						        </xsl:otherwise>
						       </xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
							&nbsp;
						<xsl:call-template name="build-freight-charges-dojo-items">
							<xsl:with-param name="items"
								select="freightCharges/freightCharge" />
							<xsl:with-param name="id">po-freight-charges</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>

				<!-- Line Item Net Amount -->
					&nbsp;
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="override-currency-name">total_net_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">total_net_amt</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
		
		<!--  Payment terms -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">	
				&nbsp;				
				<xsl:call-template name="build-payment-terms-dojo-items">
					<xsl:with-param name="items" select="payments/payment" />
					<xsl:with-param name="id">po-payments</xsl:with-param>
				</xsl:call-template>
						
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Settlement -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_SELLER_ACCOUNT</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE</xsl:with-param>
							<xsl:with-param name="name">seller_account_type</xsl:with-param>
							<xsl:with-param name="value">
							 <xsl:choose>
						          <xsl:when test="seller_account_iban[.!='']">IBAN</xsl:when>
						          <xsl:when test="seller_account_bban[.!='']">BBAN</xsl:when>
						          <xsl:when test="seller_account_upic[.!='']">UPIC</xsl:when>
						          <xsl:when test="seller_account_id[.!='']">OTHER</xsl:when>
						          <xsl:otherwise></xsl:otherwise>
						     </xsl:choose>
						     </xsl:with-param>
							<!-- events : onChange -->
							<xsl:with-param name="options">
							<xsl:choose>
        						<xsl:when test="$displaymode='edit'">
								<option value=""></option>
								<option value="IBAN">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" />
								</option>
								<option value="BBAN">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" />
								</option>
								<option value="UPIC">
									
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" />
								</option>
								<option value="OTHER">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" />
								</option>
								 </xsl:when>
						        <xsl:otherwise>
						         <xsl:choose>
						          <xsl:when test="seller_account_type[. = '']"></xsl:when>
						          <xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" /></xsl:when>
						          <xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" /></xsl:when>
						          <xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" /></xsl:when>
						          <xsl:when test="seller_account_id[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" /></xsl:when>
						         </xsl:choose>
						        </xsl:otherwise>
						       </xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
							<xsl:with-param name="name">seller_account_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="seller_account_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_SELLER_ACCOUNT_NUMBER</xsl:with-param>
							<xsl:with-param name="name">seller_account_value</xsl:with-param>
							<!-- events : onfocus, onblur -->
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="seller_account_iban" /></xsl:when>
									<xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="seller_account_bban" /></xsl:when>
									<xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="seller_account_upic" /></xsl:when>
									<xsl:when test="seller_account_id[.!='']"><xsl:value-of select="seller_account_id" /></xsl:when>
									<xsl:otherwise />
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_FINANCIAL_INSTITUTION</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
							<xsl:with-param name="name">fin_inst_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PARTIESDETAILS_BIC_CODE</xsl:with-param>
							<xsl:with-param name="name">fin_inst_bic</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_bic" />
							</xsl:with-param>
							<xsl:with-param name="size">11</xsl:with-param>
							<xsl:with-param name="maxsize">11</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
							<xsl:with-param name="name">fin_inst_street_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_street_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
							<xsl:with-param name="name">fin_inst_post_code</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_post_code" />
							</xsl:with-param>
							<xsl:with-param name="size">16</xsl:with-param>
							<xsl:with-param name="maxsize">16</xsl:with-param>
							<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
							<xsl:with-param name="name">fin_inst_town_name</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_town_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
							<xsl:with-param name="name">fin_inst_country_sub_div</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_country_sub_div" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">34</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
							<xsl:with-param name="name">fin_inst_country</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_country" />
							</xsl:with-param>
							<xsl:with-param name="button-type">country</xsl:with-param>
	    					<xsl:with-param name="disabled" >Y</xsl:with-param>
							<xsl:with-param name="size">2</xsl:with-param>
							<xsl:with-param name="maxsize">2</xsl:with-param>
							<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						</xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>			
		
		<!-- Document required -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
			<xsl:with-param name="content">
			
		       <xsl:call-template name="multioption-group">
		        <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET</xsl:with-param>
		        <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'Y' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'N']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
	       	  <xsl:call-template name="multioption-group">
	       	  	 <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET</xsl:with-param>
	       		 <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'Y']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'N' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_LAST_MATCH_DATE</xsl:with-param>
					<xsl:with-param name="name">last_match_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<!-- events : onblur -->
					<xsl:with-param name="value">
						<xsl:value-of select="last_match_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
		<!-- Shipment details -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
			   <!-- Lastest Shipment Date, Partial and Trans Shipments-->
			   <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
				        <xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
			        	<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			   </xsl:call-template>
				
			  <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
					<!-- events : onblur, onfocus -->
					<xsl:with-param name="name">last_ship_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="last_ship_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
			  </xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp; 
				<xsl:call-template name="build-incoterms-dojo-items">
					<xsl:with-param name="items" select="incoterms/incoterm"/>
					<xsl:with-param name="id" select="po-incoterms" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
<!-- 		<xsl:call-template name="fieldset-wrapper"> -->
<!-- 			<xsl:with-param name="legend">XSL_HEADER_ROUTING_SUMMARY_DETAILS</xsl:with-param> -->
<!-- 			<xsl:with-param name="content"> -->
			
<!-- 			<xsl:call-template name="select-field"> -->
<!-- 				events : onfocus and onchange -->
<!-- 				<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param> -->
<!-- 				<xsl:with-param name="name">transport_type</xsl:with-param> -->
<!-- 				<xsl:with-param name="options"> -->
<!-- 				<xsl:choose> -->
<!-- 				 <xsl:when test="$displaymode='edit'"> -->
<!-- 					<option value="0">&nbsp; -->
<!-- 					</option> -->
<!-- 					<option value="01"> -->
<!-- 						<xsl:if -->
<!-- 							test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0"> -->
<!-- 							<xsl:attribute name="selected" /> -->
<!-- 						</xsl:if> -->
<!-- 						<xsl:value-of -->
<!-- 							select="localization:getDecode($language, 'N213', '01')" /> -->
<!-- 					</option> -->
<!-- 					<option value="02"> -->
<!-- 						<xsl:if -->
<!-- 							test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0"> -->
<!-- 							<xsl:attribute name="selected" /> -->
<!-- 						</xsl:if> -->
<!-- 						<xsl:value-of -->
<!-- 							select="localization:getDecode($language, 'N213', '02')" /> -->
<!-- 					</option> -->
<!-- 					</xsl:when> -->
<!-- 			        <xsl:otherwise> -->
<!-- 			         <xsl:choose> -->
<!-- 			          <xsl:when test="transport_type[. = '0' or . = '' ]"></xsl:when> -->
<!-- 			          <xsl:when test="transport_type[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N213', '01')" /></xsl:when> -->
<!-- 			          <xsl:when test="transport_type[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N213', '02')" /></xsl:when> -->
<!-- 			         </xsl:choose> -->
<!-- 			         </xsl:otherwise> -->
<!-- 			      </xsl:choose>    -->
<!-- 				</xsl:with-param> -->
<!-- 			</xsl:call-template> -->
<!-- 			<xsl:call-template name="hidden-field"> -->
<!-- 				<xsl:with-param name="name">transport_type_old</xsl:with-param> -->
<!-- 				<xsl:with-param name="value"><xsl:value-of select="/po_tnx_record/routing_summaries/routing_summary/transport_type"/></xsl:with-param> -->
<!-- 			</xsl:call-template> -->
<!-- 				<xsl:call-template name="routing-summary-individuals-div"> -->
<!-- 				<xsl:with-param name="hidden"> -->
<!-- 					<xsl:choose> -->
<!-- 						<xsl:when test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">N</xsl:when> -->
<!-- 						<xsl:otherwise>Y</xsl:otherwise> -->
<!-- 					</xsl:choose> -->
<!-- 				</xsl:with-param> -->
<!-- 			</xsl:call-template> -->
<!-- 			<xsl:call-template name="routing-summary-multimodal-div"> -->
<!-- 				<xsl:with-param name="hidden"> -->
<!-- 					<xsl:choose> -->
<!-- 						<xsl:when test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">N</xsl:when> -->
<!-- 						<xsl:otherwise>Y</xsl:otherwise> -->
<!-- 					</xsl:choose> -->
<!-- 				</xsl:with-param> -->
<!-- 			</xsl:call-template> -->
<!-- 		</xsl:with-param> -->
<!-- 	</xsl:call-template> -->
	
	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_USER_INFORMATION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_BUYER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_buyer">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=01]" />
							<xsl:with-param name="id" select="po-buyer-user-informations" />
						</xsl:call-template>
					
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_SELLER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_seller">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=02]" />
							<xsl:with-param name="id" select="po-seller-user-informations" />
						</xsl:call-template>
					
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CONTACT_PERSON_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-contact-details-dojo-items">
					<xsl:with-param name="items" select="contacts/contact" />
					<xsl:with-param name="id" select="po-contacts" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	
	</div>
	</xsl:template>

	<!--
   SO Realform.
   -->
	<xsl:template name="realform">
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">realform</xsl:with-param>
				<xsl:with-param name="action" select="$realform-action" />
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
							<xsl:with-param name="value" select="$mode" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">tnxtype</xsl:with-param>
							<xsl:with-param name="value">21</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
					</div>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
