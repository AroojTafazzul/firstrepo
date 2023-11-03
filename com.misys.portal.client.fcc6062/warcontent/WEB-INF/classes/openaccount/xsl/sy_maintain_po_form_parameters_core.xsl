<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"		
		exclude-result-prefixes="localization">
		
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">PO</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/PurchaseOrderScreen</xsl:param>

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


	<xsl:include href="po_common.xsl"/>
	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>


	<xsl:output method="html" indent="no" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="section_records"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="section_records">
		
		<!-- Preloader -->
		<xsl:call-template name="loading-message"/>
		
		<div>
    		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

			<!-- Form #0 : Main Form -->
	    	<xsl:call-template name="form-wrapper">
	     		<xsl:with-param name="name" select="$main-form-name"/>
	    		<xsl:with-param name="validating">Y</xsl:with-param>
	     		<xsl:with-param name="content">
	     			<!-- Hidden fields -->
					<xsl:call-template name="hidden-fields"/>

                    <!-- Display common menu. -->
	     			<xsl:call-template name="system-menu"/>
	     			
	     			<!-- Show the company details -->
					<xsl:apply-templates select="static_company"/>
					
					<!-- Show sections -->
	     			<xsl:call-template name="maintain-form"/>	
	     			<xsl:call-template name="disclaimer"/>
	    	 	</xsl:with-param>
	    	</xsl:call-template>	    	
	   	</div>
		
		<!-- Display common menu, this time outside the form -->
		<xsl:call-template name="system-menu">
			<xsl:with-param name="second-menu">Y</xsl:with-param>
		</xsl:call-template>
		
		<!-- The form that's submitted -->
		<xsl:call-template name="realform" />
		
		<xsl:call-template name="js-imports"/> 
		
	</xsl:template>
	
	<xsl:template name="js-imports">
	  	<xsl:call-template name="common-js-imports">
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="xml-tag-name">section_records</xsl:with-param>			
		</xsl:call-template>
	</xsl:template>
	
	<!--  Maintain form -->
	<xsl:template name="maintain-form">
		<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_PO_MAINTAIN_FORM_HEADER</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_amount_details</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
					</xsl:call-template>			
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_payment_terms</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
					</xsl:call-template>			
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_settlement_terms</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_SETTLEMENT_TERMS_DETAILS</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_documents_required</xsl:with-param>
						<xsl:with-param name="label">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_shipment_details</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_inco_terms</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_routing_summary</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_ROUTING_SUMMARY_DETAILS</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_user_info</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_USER_INFORMATION_DETAILS</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="name">section_po_contact</xsl:with-param>
						<xsl:with-param name="label">XSL_HEADER_CONTACT_PERSON_DETAILS</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_HEADER_LINE_ITEMS</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="name">section_line_item_po_reference</xsl:with-param>
								<xsl:with-param name="label">XSL_HEADER_LINE_ITEMS_PRODUCT</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="name">section_line_item_adjustments_details</xsl:with-param>
								<xsl:with-param name="label">XSL_HEADER_ADJUSTMENTS_DETAILS</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="name">section_line_item_taxes_details</xsl:with-param>
								<xsl:with-param name="label">XSL_HEADER_TAXES_DETAILS</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="name">section_line_item_freight_charges_details</xsl:with-param>
								<xsl:with-param name="label">XSL_HEADER_FREIGHT_CHARGES_DETAILS</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="name">section_line_item_shipment_details</xsl:with-param>
								<xsl:with-param name="label">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="name">section_line_item_inco_terms_details</xsl:with-param>
								<xsl:with-param name="label">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="name">section_line_item_total_net_amount_details</xsl:with-param>
								<xsl:with-param name="label">XSL_HEADER_TOTAL_NET_AMT_LABEL</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>

				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="hidden-fields">
	
		<div class="widgetContainer">

			<!-- Security token -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">token</xsl:with-param>
			</xsl:call-template>
	
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>
				<xsl:with-param name="value" select="$product-code"/>
			</xsl:call-template>
		
		</div>
	
	</xsl:template>
	
	<!--******************************-->
	<!-- Template for Company Details -->
	<!--******************************-->
	<xsl:template match="static_company">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_COMPANY_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">abbv_name</xsl:with-param>
  				 </xsl:call-template>
  				 <xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">name</xsl:with-param>
  				 </xsl:call-template>
  				 <xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">street_name</xsl:with-param>
  				 </xsl:call-template>
  				 <xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">post_code</xsl:with-param>
  				 </xsl:call-template>
  				 <xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">town_name</xsl:with-param>
  				 </xsl:call-template>
  				 <xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">country_sub_div</xsl:with-param>
  				 </xsl:call-template>
  				 <xsl:call-template name="hidden-field">
    				<xsl:with-param name="name">country</xsl:with-param>
  				 </xsl:call-template>
  				<!-- Jurisdiction Abbreviated Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
    				<xsl:with-param name="id">jurisdiction_abbv_name_view</xsl:with-param>
    				<xsl:with-param name="value" select="abbv_name" />
    				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Jurisdiction Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
    				<xsl:with-param name="id">jurisdiction_name_view</xsl:with-param>
    				<xsl:with-param name="value" select="name" />
    				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Jurisdiction Address Street Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_STREET_NAME</xsl:with-param>
    				<xsl:with-param name="id">jurisdiction_street_name_view</xsl:with-param>
    				<xsl:with-param name="value" select="street_name" />
    				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Jurisdiction Address Post Code -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_POST_CODE</xsl:with-param>
    				<xsl:with-param name="id">jurisdiction_post_code_view</xsl:with-param>
    				<xsl:with-param name="value" select="post_code" />
    				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Jurisdiction Address Town Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_TOWN_NAME</xsl:with-param>
    				<xsl:with-param name="id">jurisdiction_town_name_view</xsl:with-param>
    				<xsl:with-param name="value" select="town_name" />
    				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Jurisdiction Address Country Sub Division -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_COUNTRY_SUB_DIVISION</xsl:with-param>
    				<xsl:with-param name="id">jurisdiction_country_sub_div_view</xsl:with-param>
    				<xsl:with-param name="value" select="country_sub_div" />
    				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Jurisdiction Country -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_COUNTRY</xsl:with-param>
    				<xsl:with-param name="id">jurisdiction_country_view</xsl:with-param>
    				<xsl:with-param name="value" select="country" />
    				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- PO REAL FORM -->
	
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
						 <xsl:with-param name="name">operation</xsl:with-param>
						 <xsl:with-param name="id">realform_operation</xsl:with-param>
						 <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">referenceid</xsl:with-param>
					       <xsl:with-param name="value" select="ref_id"/>
					      </xsl:call-template>
					      <xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">tnxid</xsl:with-param>
					       <xsl:with-param name="value" select="tnx_id"/>
					      </xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">mode</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">tnxtype</xsl:with-param>
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
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>