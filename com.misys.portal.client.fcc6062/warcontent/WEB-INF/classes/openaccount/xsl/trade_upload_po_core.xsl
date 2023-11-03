<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
<!--
   Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../../core/xsl/common/file_upload_widgets.xsl"/>
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">PO</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/PurchaseOrderScreen</xsl:param>


	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="po_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="po_tnx_record">

		<!-- Preloader -->
		<xsl:call-template name="loading-message"/>
		
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			
			<!-- Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Display common menu -->
					<xsl:call-template name="system-menu"/>
					<xsl:call-template name="common-hidden-fields"/>
					<xsl:call-template name="general-details"/>
					<xsl:call-template name="buyer-details" />	
					<xsl:call-template name="file-upload"/>
	     			<xsl:call-template name="disclaimer"/>
	     			
	     			<!-- Reauthentication -->
	     			<xsl:call-template name="server-message">
			 			<xsl:with-param name="name">server_message</xsl:with-param>
			 			<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
			 			<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
	  				<xsl:call-template name="reauthentication" />	  				
	  				<xsl:call-template name="bank-details" />	     			
	     			<xsl:call-template name="attachments-file-dojo">
						<xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
						<xsl:with-param name="max-files">1</xsl:with-param>
						<xsl:with-param name="attachment-group">purchaseorderupload</xsl:with-param>
					</xsl:call-template>
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
		

		<!-- Include some eventual additional elements -->
		<xsl:call-template name="client_addons"/>
	
	</xsl:template>
	
	<xsl:template name="js-imports">
	  	<xsl:call-template name="common-js-imports">
	  		<xsl:with-param name="binding">misys.binding.openaccount.upload_po</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="xml-tag-name">po_tnx_record</xsl:with-param>
			<xsl:with-param name="override-help-access-key">PO_03</xsl:with-param>			
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
 
   
    
    
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>

<!-- 				<xsl:call-template name="po-general-details" /> -->
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
  
  
   <xsl:template name="buyer-details">
   	<xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <!-- Common general details. -->
    <xsl:call-template name="party-details">
		<xsl:with-param name="show-entity">Y</xsl:with-param>
		<xsl:with-param name="show-BEI">Y</xsl:with-param>
		<xsl:with-param name="prefix">buyer</xsl:with-param>
		<xsl:with-param name="readonly">Y</xsl:with-param>
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
	
     <xsl:if test="$displaymode='edit'">
      <script>
      	dojo.ready(function(){
      		misys._config = misys._config || {};
			misys._config.customerReferences = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
	  </script>
     </xsl:if>
	
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
	
	   <!--  Bank Details Fieldset. -->
	<xsl:template name="bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent">
					<xsl:with-param name="sender-name">buyer</xsl:with-param>
					<xsl:with-param name="sender-reference-name">buyer_reference</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="file-upload">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label">XSL_BASELINE_UPLOAD_IMPORT</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_BASELINE_UPLOAD_IMPORT_CONCATENATE</xsl:with-param>
							<xsl:with-param name="name">import</xsl:with-param>
							<xsl:with-param name="id">import_1</xsl:with-param>
							<xsl:with-param name="value">concat</xsl:with-param>
							<xsl:with-param name="checked">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_BASELINE_UPLOAD_IMPORT_OVERWRITE</xsl:with-param>
							<xsl:with-param name="name">import</xsl:with-param>
							<xsl:with-param name="id">import_2</xsl:with-param>
							<xsl:with-param name="value">overwrite</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="import[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_BASELINE_UPLOAD_TEMPLATE</xsl:with-param>
					<xsl:with-param name="name">upload_template_id</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="options">
						<xsl:apply-templates select="upload_templates/upload_template[./product_code='PO']"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">ACTION_USER_SUBMIT</xsl:with-param>
					<xsl:with-param name="name">submit</xsl:with-param>
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
						 <xsl:with-param name="value">SUBMIT</xsl:with-param>
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
						 	<xsl:with-param name="value">DRAFT</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option</xsl:with-param>
						 	<xsl:with-param name="value">UPLOAD</xsl:with-param>
						</xsl:call-template>
					      <xsl:call-template name="hidden-field">
						    <xsl:with-param name="name">productcode</xsl:with-param>
						     <xsl:with-param name="value">PO</xsl:with-param>
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
						<xsl:call-template name="reauth_params"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- PO Upload Template -->
	<xsl:template match="upload_template">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="upload_template_id"/></xsl:attribute>
			<xsl:value-of select="name"/>
		</option>
	</xsl:template>
	
	<!-- PO Template -->
	<xsl:template match="po_tnx_record" mode="template">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="template_id"/></xsl:attribute>
			<xsl:value-of select="template_id"/>
		</option>
	</xsl:template>	
</xsl:stylesheet>
