<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!--
##########################################################
Templates for

Open Account - Simplified Invoice (IN) Form, Customer Side.
 
Copyright (c) 2000-2016 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      16/08/16
author:    Mitchell Angelo
email:     MitchellAngelo.Yniguez@misys.com
##########################################################
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization securityCheck security defaultresource">
		
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">IN</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="nextscreen" />
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/InvoiceScreen</xsl:param>

	
	<!-- All marks used to shown/hidden form's sections-->
	
	<xsl:param name="show-template">N</xsl:param>
	<xsl:param name="product-currency-label">XSL_INVOICE_PAYABLE_CURRENCY_CODE</xsl:param>
	<xsl:param name="show_buyer_button">Y</xsl:param>
	
	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../core/xsl/common/fscm_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 
    <xsl:variable name="fscm_cash_customization_enable">
  		<xsl:value-of select="defaultresource:getResource('FSCM_CASH_CUSTOMIZATION_ENABLE')"/>
  	</xsl:variable>
  	
	<xsl:template match="/">
		<xsl:apply-templates select="in_tnx_record"/>
	</xsl:template>

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_simplified_in</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="override-lowercase-product-code">in</xsl:with-param>
			<xsl:with-param name="override-help-access-key">IN_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="in_tnx_record">
	<!-- Preloader  -->
	<xsl:call-template name="loading-message" />

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

			<xsl:apply-templates select="cross_references" mode="hidden_form" />
			<xsl:call-template name="hidden-fields" />
			<!-- FSCM General Details -->
			<xsl:call-template name="fscm-general-details" />
			<!-- Goods details -->
			<xsl:call-template name="goods-details" />
			<!-- Bank details -->
			<xsl:call-template name="bank-details" />
		
			<xsl:if test="$displaymode = 'view'">
				<xsl:call-template name="credit-Note-details" />
			</xsl:if>
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
			<!-- comments for return -->
			<xsl:call-template name="comments-for-return">
				<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
				<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
			</xsl:call-template>
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

	<!-- Goods Details Fieldset.-->
	<xsl:template name="goods-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:choose>
				<xsl:when test="$displaymode='edit'">
				     <xsl:call-template name="row-wrapper">
				      	  <xsl:with-param name="id">narrative_description_goods</xsl:with-param>
				          <xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
					      <xsl:with-param name="required">N</xsl:with-param>
					      <xsl:with-param name="type">textarea</xsl:with-param>
					      <xsl:with-param name="content">
						       <xsl:call-template name="textarea-field">
						        <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
						        <xsl:with-param name="rows">5</xsl:with-param>
						        <xsl:with-param name="cols">35</xsl:with-param>
						        <xsl:with-param name="required">N</xsl:with-param>
						       </xsl:call-template>
				      	  </xsl:with-param>
				    </xsl:call-template>
				</xsl:when>
			    <xsl:when test="$displaymode='view' and narrative_description_goods[.!='']">
			     	<xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="narrative_description_goods"/>
					      </div></xsl:with-param>
				     </xsl:call-template>
			    </xsl:when>
			    </xsl:choose>
				<xsl:choose>
					<xsl:when test="$option = 'FULL' or $option = 'DETAILS'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CURRENCY_CODE</xsl:with-param>
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
						<xsl:with-param name="label">XSL_CURRENCY_CODE</xsl:with-param>
						<xsl:with-param name="product-code">total</xsl:with-param>
						<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-amt">N</xsl:with-param>
					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
						<!-- Total Goods Amount -->
						<xsl:choose>
							<xsl:when test="$option = 'FULL' or $option = 'DETAILS'">
								<br/>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_FACE_VALUE</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
									<xsl:with-param name="name">total_amt</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
							<xsl:if test="$displaymode = 'edit'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_FACE_VALUE</xsl:with-param>
									 <xsl:with-param name="product-code">total</xsl:with-param>
									<xsl:with-param name="override-currency-name">face_total_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">total_amt</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="amt-readonly">N</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
								<xsl:if test="$displaymode = 'view'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_FACE_VALUE</xsl:with-param>
									<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">total_amt</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>				
							
						<xsl:choose>
							<xsl:when test="$option = 'FULL' or $option = 'DETAILS'">
								<br/>
								<xsl:if test="total_adjustments[.!='']">	
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_INVOICE_ADJUSTMENT_VALUE</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="adjustment_cur_code"/>&nbsp;<xsl:value-of select="total_adjustments"/></xsl:with-param>
										<xsl:with-param name="name">total_adjustments</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
							<xsl:if test="$displaymode = 'edit'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_INVOICE_ADJUSTMENT_VALUE</xsl:with-param>
									 <xsl:with-param name="product-code">adjustment</xsl:with-param>
									<xsl:with-param name="override-currency-name">adjustment_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">total_adjustments</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="amt-readonly">N</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
								<xsl:if test="$displaymode = 'view' and total_adjustments[.!='']">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_INVOICE_ADJUSTMENT_VALUE</xsl:with-param>
									<xsl:with-param name="override-currency-name">adjustment_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">total_adjustments</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Adjustment direction Radio buttons-->
				       	<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="multioption-group">
									<xsl:with-param name="group-label">XSL_DETAILS_PO_ADJUSTMENT_DIRECTION</xsl:with-param>
									<xsl:with-param name="content">
										<xsl:call-template name="radio-field">
											<xsl:with-param name="label">N216_ADDD</xsl:with-param>
											<xsl:with-param name="name">adjustment_direction</xsl:with-param>
											<xsl:with-param name="id">adjustment_direction_1</xsl:with-param>
											<xsl:with-param name="value">ADDD</xsl:with-param>
											<xsl:with-param name="checked"><xsl:if test="adjustment_direction[. = 'ADDD']">Y</xsl:if></xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="radio-field">
											<xsl:with-param name="label">N216_SUBS</xsl:with-param>
											<xsl:with-param name="name">adjustment_direction</xsl:with-param>
											<xsl:with-param name="id">adjustment_direction_2</xsl:with-param>
											<xsl:with-param name="value">SUBS</xsl:with-param>
											<xsl:with-param name="checked"><xsl:if test="adjustment_direction[. = 'SUBS']">Y</xsl:if></xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="total_adjustments[.!='']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_ADJUSTMENT_DIRECTION</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N216', adjustment_direction)"/></xsl:with-param>
										<xsl:with-param name="name">adjustment_direction</xsl:with-param>
										<xsl:with-param name="swift-validate">N</xsl:with-param>
										<xsl:with-param name="size">35</xsl:with-param>
										<xsl:with-param name="maxsize">35</xsl:with-param>
										<xsl:with-param name="readonly">Y</xsl:with-param>
										<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Expiry date -->
					 <xsl:if test="($fscm_cash_customization_enable = 'true')">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
							<xsl:with-param name="name">discount_exp_date</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template> 
					</xsl:if>

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
	<!--
   PO Realform.
   -->
	<xsl:template name="realform">
		<!--
			Do not display this section when the counterparty mode is
			'counterparty'
		-->
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
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">cashCustomizationEnable</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$fscm_cash_customization_enable"/></xsl:with-param>							
						</xsl:call-template>
						<xsl:call-template name="e2ee_transaction"/>
						<xsl:call-template name="reauth_params"/>						
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
