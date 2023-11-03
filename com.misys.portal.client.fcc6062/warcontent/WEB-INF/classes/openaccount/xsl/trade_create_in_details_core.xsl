<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization securityCheck security defaultresource">

	<xsl:template match="in_tnx_record">
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
		<xsl:call-template name="payments-declaration" />
		<!-- Taxes declaration -->
		<xsl:call-template name="taxes-declaration" />
		<!-- Freight Charges declaration -->
		<xsl:call-template name="freight-charges-declaration" />
		<!-- Incoterms declaration -->
		<xsl:call-template name="incoterms-declaration" />
		<!-- User defined informations declaration buyer -->
		<xsl:call-template name="user-defined-informations-declaration">
			<xsl:with-param name="user_info_type">01</xsl:with-param>
		</xsl:call-template>
		<!-- User defined informations declaration seller -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">02</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="contact-details-declaration" />
		<xsl:call-template name="routing-summary-declaration" />
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!--  Display common menu.  -->
					<xsl:call-template name="menu">
						<xsl:with-param name="show-template" select="$show-template"/>	
						<xsl:with-param name="show-return">Y</xsl:with-param>
					</xsl:call-template>

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />
					
					<!-- Reauthentication -->	
				 	<xsl:call-template name="server-message">
				 		<xsl:with-param name="name">server_message</xsl:with-param>
				 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
				 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="reauthentication" />

					<xsl:apply-templates select="cross_references"
						mode="hidden_form" />
					<xsl:call-template name="hidden-fields" />
					<xsl:call-template name="fscm-general-details" />

					<!-- Goods details -->
					<xsl:call-template name="goods-details" />
 
					<!-- Amount details -->
					<xsl:if test="$section_po_amount_details!='N'">
						<xsl:call-template name="amount-details" />
					</xsl:if>
					
					<!-- Payment details -->
					<xsl:if test="$section_po_payment_terms!='N'">
						<xsl:call-template name="payment-terms" />
					</xsl:if>
					
					<!--Settlement Terms Details-->
					<xsl:if test="$section_po_settlement_terms!='N'">
						<xsl:call-template name="settlement-terms" />
					</xsl:if>
					
					<!-- Bank details -->
					<xsl:call-template name="bank-details" />
					
					<!--Documents required Details-->
					<xsl:if test="$section_po_documents_required!='N'">
						<xsl:call-template name="documents-required" />
					</xsl:if>
					
					<!--Shipment Details-->
					<xsl:if test="$section_po_shipment_details!='N'">
						<xsl:call-template name="shipment-details" />
					</xsl:if>
					
					<!--Inco Terms-->
					<xsl:if test="$section_po_inco_terms!='N'">
						<xsl:call-template name="inco-terms" />
					</xsl:if>
					
					<!--Routing summary Details-->
					<xsl:if test="$section_po_routing_summary!='N'">
						<xsl:call-template name="routing-summary" />
					</xsl:if>
					
					<!--User Details-->
					<xsl:if test="$section_po_user_info!='N'">
						<xsl:call-template name="user-details" />
					</xsl:if>
					
					<!--Contact Details-->
					<xsl:if test="$section_po_contact!='N' and tnx_type_code[.!='03']">
						<xsl:call-template name="contact-details" />
					</xsl:if>
					
					<!-- Credit Note Details -->
					<xsl:if test="$displaymode = 'view'">
					<xsl:call-template name="credit-Note-details"/>
					</xsl:if>
					
					<!-- comments for return -->
  					<xsl:call-template name="comments-for-return">
						<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
						<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
  					</xsl:call-template>
					
					
				</xsl:with-param>
			</xsl:call-template>
		</div>
		<!-- Form #1 : Attach Files -->
		<xsl:choose>
		<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
			<xsl:call-template name="attachments-file-dojo">
				<xsl:with-param name="attachment-group">invoice</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="$option ='DETAILS'">
			<xsl:call-template name="attachments-file-dojo">
	          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
	          	<xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
	          	<xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
          	</xsl:call-template>
          	<xsl:call-template name="attachments-file-dojo">
	          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
	          	<xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
	          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
          	</xsl:call-template>
          	</xsl:if>
		</xsl:otherwise>
		</xsl:choose>

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
			<xsl:with-param name="show-template" select="$show-template"/>
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

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
		<xsl:if test="$displaymode='view'">
			<!-- This field is sent in the unsigned view -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="issuing_bank/abbv_name" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>				
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code</xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>			
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">program_id</xsl:with-param>				
		</xsl:call-template>
		
		 <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fscm_programme_code</xsl:with-param>				
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">tnxTypeCode</xsl:with-param>	
				<xsl:with-param name="value">01</xsl:with-param>			
		</xsl:call-template>
		
		<xsl:if test="security:isCounterparty($rundata)">
	 	  <xsl:call-template name="hidden-field">
	     	 <xsl:with-param name="name">company_type</xsl:with-param>
	     	 <xsl:with-param name="value"><xsl:value-of select="company_type"/></xsl:with-param>
	   	 </xsl:call-template>
	   	 </xsl:if>
		</div>
	</xsl:template>

	<!--
		Goods Details Fieldset. 
		-->
	<xsl:template name="goods-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:if test="sub_product_code ='ISO'">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
					<xsl:with-param name="name">goods_desc</xsl:with-param>
					<xsl:with-param name="size">70</xsl:with-param>
	     			<xsl:with-param name="maxsize">70</xsl:with-param>
	     			 <xsl:with-param name="fieldsize">x-large</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="sub_product_code='SMP'">
					 <xsl:call-template name="textarea-field">
				      <xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
				        <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
				        <xsl:with-param name="rows">5</xsl:with-param>
				        <xsl:with-param name="cols">35</xsl:with-param>
				        <xsl:with-param name="required">N</xsl:with-param>
				       </xsl:call-template>
				</xsl:if>       
				<xsl:choose>
					<xsl:when test="$option = 'FULL' or $option = 'DETAILS'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label"><xsl:value-of select="$product-currency-label"/></xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/></xsl:with-param>
							<xsl:with-param name="name">total_cur_code</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$mode ='UNSIGNED'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CURRENCY_CODE</xsl:with-param>
						<xsl:with-param name="product-code">total</xsl:with-param>
						<xsl:with-param name="name">total_cur_code</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/></xsl:with-param>
						<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-amt">N</xsl:with-param>
					</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label"><xsl:value-of select="$product-currency-label"/></xsl:with-param>
						<xsl:with-param name="product-code">total</xsl:with-param>
						<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-amt">N</xsl:with-param>
					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			<xsl:if test="$section_po_line_items!='N'">
				<!-- Buyer Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<!-- Line items grid -->
						<xsl:call-template name="build-line-items-dojo-items">
							<xsl:with-param name="items" select="line_items/lt_tnx_record" />
						</xsl:call-template>
						<!-- Total Goods Amount -->
						<xsl:choose>
							<xsl:when test="$option = 'FULL' or $option = 'DETAILS'">
								<br/>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
									<xsl:with-param name="name">fake_total_amt</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
							<xsl:if test="$displaymode = 'edit'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
									 <xsl:with-param name="product-code">total</xsl:with-param>
									<xsl:with-param name="override-currency-name">fake_total_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">fake_total_amt</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
								<xsl:if test="$displaymode = 'view'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
									<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">total_amt</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						<!-- This div is required to force the content to appear -->
						<div style="height:1px">&nbsp;</div>						
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!--  Payment Details Fieldset. -->
<xsl:template name="payment-terms">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="multioption-group">
		        <xsl:with-param name="group-label">XSL_DETAILS_PO_PAYMENT_TYPE</xsl:with-param>
		        <xsl:with-param name="content">
					<!-- events : onclick -->
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_HEADER_PO_PAYMENT_AMOUNT</xsl:with-param>
						<xsl:with-param name="name">payment_terms_type</xsl:with-param>
						<xsl:with-param name="id">payment_terms_type_1</xsl:with-param>
						<xsl:with-param name="value">AMNT</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_HEADER_PO_PAYMENT_PCT</xsl:with-param>
						<xsl:with-param name="name">payment_terms_type</xsl:with-param>
						<xsl:with-param name="id">payment_terms_type_2</xsl:with-param>
						<xsl:with-param name="value">PRCT</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="payments-new">
				<xsl:with-param name="items" select="payments/payment" />
				<xsl:with-param name="id">po-payments</xsl:with-param>
			</xsl:call-template>
					
		</xsl:with-param>
	</xsl:call-template>							
</xsl:template>
	
<!--  Settlment Details Fieldset. -->
<xsl:template name="settlement-terms">
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
						<xsl:with-param name="size">34</xsl:with-param>
						<xsl:with-param name="maxsize">34</xsl:with-param>
					</xsl:call-template>
					
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_PURCHASE_ORDER_FINANCIAL_INSTITUTION</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="button-type">fin_inst</xsl:with-param>
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
						<xsl:with-param name="size">40</xsl:with-param>
						<xsl:with-param name="maxsize">40</xsl:with-param>
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
					 <xsl:call-template name="country-field">
						    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
						    <xsl:with-param name="name">fin_inst_country</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="fin_inst_country" /></xsl:with-param>
						    <xsl:with-param name="prefix" >fin_inst</xsl:with-param>
					   </xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>

		</xsl:with-param>
	</xsl:call-template>							
</xsl:template>

<!--  Bank Details Fieldset. -->
<xsl:template name="bank-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="issuing-bank-tabcontent">
				<xsl:with-param name="sender-name">seller</xsl:with-param>
				<xsl:with-param name="sender-reference-name">seller_reference</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	
<!--  Documents required Fieldset. -->
<xsl:template name="documents-required">
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
</xsl:template>
	
<!--  Shipment details Fieldset. -->
<xsl:template name="shipment-details">
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
						<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED</xsl:with-param>
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
</xsl:template>

<!--  Inco terms Fieldset. -->
<xsl:template name="inco-terms">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
		<xsl:with-param name="content">&nbsp; 
			<xsl:call-template name="build-incoterms-dojo-items">
				<xsl:with-param name="items" select="incoterms/incoterm"/>
				<xsl:with-param name="id">po-incoterms</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	
	<!-- Routing summary Fieldset. -->
	<xsl:template name="routing-summary">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ROUTING_SUMMARY_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
			<xsl:call-template name="select-field">
				<!-- events : onfocus and onchange -->
				<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
				<xsl:with-param name="name">transport_type</xsl:with-param>
				<xsl:with-param name="options">
				<xsl:choose>
				 <xsl:when test="$displaymode='edit'">
					<option value="0">&nbsp;
					</option>
					<option value="01">
						<xsl:if
							test="count(/in_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">
							<xsl:attribute name="selected" />
						</xsl:if>
						<xsl:value-of
							select="localization:getDecode($language, 'N213', '01')" />
					</option>
					<option value="02">
						<xsl:if
							test="count(/in_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">
							<xsl:attribute name="selected" />
						</xsl:if>
						<xsl:value-of
							select="localization:getDecode($language, 'N213', '02')" />
					</option>
					</xsl:when>
			        <xsl:otherwise>
			         <xsl:choose>
			          <xsl:when test="transport_type[. = '0' or . = '' ]"></xsl:when>
			          <xsl:when test="transport_type[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N213', '01')" /></xsl:when>
			          <xsl:when test="transport_type[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N213', '02')" /></xsl:when>
			         </xsl:choose>
			         </xsl:otherwise>
			      </xsl:choose>   
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">transport_type_old</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="/in_tnx_record/routing_summaries/routing_summary/transport_type"/></xsl:with-param>
			</xsl:call-template>
				<xsl:call-template name="routing-summary-individuals-div">
				<xsl:with-param name="hidden">
					<xsl:choose>
						<xsl:when test="count(/in_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="routing-summary-multimodal-div">
				<xsl:with-param name="hidden">
					<xsl:choose>
						<xsl:when test="count(/in_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	

<!-- User Details Fieldset. -->
<xsl:template name="user-details">
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
</xsl:template>

<!-- Contact Person Details Fieldset. -->
<xsl:template name="contact-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_CONTACT_PERSON_DETAILS</xsl:with-param>
		<xsl:with-param name="content">&nbsp;
			<xsl:call-template name="build-contact-details-dojo-items">
				<xsl:with-param name="items" select="contacts/contact" />
				<xsl:with-param name="id">po-contacts</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>		

	<!-- Amount Details Fieldset. -->
	<xsl:template name="amount-details">
		<div>
		<xsl:if test="$section_amount_details = 'N'">
			<xsl:attribute name="class">hide</xsl:attribute>
		</xsl:if>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<!-- Adjustments -->
				<xsl:if test="$section_po_adjustements_details!='N'">
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
				</xsl:if>

				<!-- Taxes -->
				<xsl:if test="$section_po_taxes_details!='N'">
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
				</xsl:if>

				<!-- Freight charges -->
				<xsl:if test="$section_po_freight_charges_details!='N'">
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
        						<option value="">&nbsp;</option>
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
				</xsl:if>
				<!-- Line Item Net Amount -->
				<div>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="override-currency-name">total_net_cur_code</xsl:with-param>
						<xsl:with-param name="override-amt-name">total_net_amt</xsl:with-param>
						<xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
					</xsl:call-template>	
				</div>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
	<!--
   PO Realform.
   -->
	<xsl:template name="realform">
		<!-- Do not display this section when the counterparty mode is 'counterparty' -->
		<xsl:if test="$collaborationmode != 'counterparty'">
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
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:if test="tnx_type_code = '01' and $option = 'EXISTING'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">isCopyFrom</xsl:with-param>
								<xsl:with-param name="value">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="e2ee_transaction"/>
						<xsl:call-template name="reauth_params"/>						
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
